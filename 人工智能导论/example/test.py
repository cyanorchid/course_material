
from __future__ import division, print_function, absolute_import

import matplotlib.pyplot as plt
import numpy as np
import tensorflow as tf

# 输入Mnist数据集，采用one hot 编码
from tensorflow.examples.tutorials.mnist import input_data
mnist = input_data.read_data_sets("/tmp/data/", one_hot=True)

# 设置训练所用的基本参数
num_steps = 12000
batch_size = 128
lr_generator = 0.002
lr_discriminator = 0.002

# 设置网络的参数
image_dim = 784 # 28*28 像素 * 1 通道
noise_dim = 100 # 噪声的数据点


# 开始建立网络
# 设定网络的输入参数
noise_input = tf.placeholder(tf.float32, shape=[None, noise_dim])
real_image_input = tf.placeholder(tf.float32, shape=[None, 28, 28, 1])
# 设定Boolean值
is_training = tf.placeholder(tf.bool)

# 设定LeakyReLU作为激活函数
def leakyrelu(x, alpha=0.2):
    return 0.5 * (1 + alpha) * x + 0.5 * (1 - alpha) * abs(x)

# 生成器网络
# 以噪音为输入值，输出手写数字的图像
def generator(x, reuse=False):
    with tf.variable_scope('Generator', reuse=reuse):
        # tensorflow会自动创建变量，并且计算相关数据
        x = tf.layers.dense(x, units=7 * 7 * 128)
        x = tf.layers.batch_normalization(x, training=is_training)
        x = tf.nn.relu(x)
        #重新设定图片的 4-D数组，包含（ batch, height, width, channels ），根据输入及设定，变更为(batch, 7, 7, 128)
        x = tf.reshape(x, shape=[-1, 7, 7, 128])
        #对图像进行反卷积 ，经处理后变为(batch, 14, 14, 64)
        x = tf.layers.conv2d_transpose(x, 64, 5, strides=2, padding='same')
        x = tf.layers.batch_normalization(x, training=is_training)
        x = tf.nn.relu(x)
        # 再次对图像进行反卷积，处理后变为: (batch, 28, 28, 1)
        x = tf.layers.conv2d_transpose(x, 1, 5, strides=2, padding='same')
        # 应用tach函数，使其更加稳定
        x = tf.nn.tanh(x)
        return x

# 设计辨别器
# 对输入的图像进行判断，给出真或假的判断
def discriminator(x, reuse=False):
    with tf.variable_scope('Discriminator', reuse=reuse):
        # 应用卷积神经网络对图像进行分类
        x = tf.layers.conv2d(x, 64, 5, strides=2, padding='same')
        x = tf.layers.batch_normalization(x, training=is_training)
        x = leakyrelu(x)
        x = tf.layers.conv2d(x, 128, 5, strides=2, padding='same')
        x = tf.layers.batch_normalization(x, training=is_training)
        x = leakyrelu(x)
        # 将多维输入一维化
        x = tf.reshape(x, shape=[-1, 7 * 7 * 128])
        x = tf.layers.dense(x, 1024)
        x = tf.layers.batch_normalization(x, training=is_training)
        x = leakyrelu(x)
        # 输出真或假
        x = tf.layers.dense(x, 2)
    return x


# 构建生成器
gen_sample = generator(noise_input)

# 建立两个辨别器，分别判断来自生成器的图像和来自数据集的图像
disc_real = discriminator(real_image_input)
disc_fake = discriminator(gen_sample, reuse=True)

# 建立堆叠生成器/判别器
stacked_gan = discriminator(gen_sample, reuse=True)

# 建立损失，输入真假图片，计算判别器的损失
disc_loss_real = tf.reduce_mean(tf.nn.sparse_softmax_cross_entropy_with_logits(
    logits=disc_real, labels=tf.ones([batch_size], dtype=tf.int32)))#真
disc_loss_fake = tf.reduce_mean(tf.nn.sparse_softmax_cross_entropy_with_logits(
    logits=disc_fake, labels=tf.zeros([batch_size], dtype=tf.int32)))#假
disc_loss = disc_loss_real + disc_loss_fake# 将损失加起来
gen_loss = tf.reduce_mean(tf.nn.sparse_softmax_cross_entropy_with_logits(
    logits=stacked_gan, labels=tf.ones([batch_size], dtype=tf.int32)))# 计算生成器的损失（根据是否成功欺骗判别器计算）

# 建立优化
optimizer_gen = tf.train.AdamOptimizer(learning_rate=lr_generator, beta1=0.5, beta2=0.999)
optimizer_disc = tf.train.AdamOptimizer(learning_rate=lr_discriminator, beta1=0.5, beta2=0.999)


gen_vars = tf.get_collection(tf.GraphKeys.TRAINABLE_VARIABLES, scope='Generator')# 指定优化器更新的训练变量
disc_vars = tf.get_collection(tf.GraphKeys.TRAINABLE_VARIABLES, scope='Discriminator')# 判别器的变量

# 建立训练的操作
gen_update_ops = tf.get_collection(tf.GraphKeys.UPDATE_OPS, scope='Generator')
with tf.control_dependencies(gen_update_ops):
    train_gen = optimizer_gen.minimize(gen_loss, var_list=gen_vars)
disc_update_ops = tf.get_collection(tf.GraphKeys.UPDATE_OPS, scope='Discriminator')
with tf.control_dependencies(disc_update_ops):
    train_disc = optimizer_disc.minimize(disc_loss, var_list=disc_vars)

# 初始化各个变量
init = tf.global_variables_initializer()

# 开始训练
sess = tf.Session()# 启动一个tf.Session
sess.run(init)# 初始化

# 训练部分
for i in range(1, num_steps + 1):

    # 准备输入数据，从Mnist加载
    batch_x, _ = mnist.train.next_batch(batch_size)
    batch_x = np.reshape(batch_x, newshape=[-1, 28, 28, 1])
    # 缩放为判别器的输入范围
    batch_x = batch_x * 2. - 1.

    # 判别器的训练
    # 生成噪声并用于生成器
    z = np.random.uniform(-1., 1., size=[batch_size, noise_dim])
    _, dl = sess.run([train_disc, disc_loss], feed_dict={real_image_input: batch_x, noise_input: z, is_training: True})

    # 生成器的训练
    # 生成噪声用于生成器
    z = np.random.uniform(-1., 1., size=[batch_size, noise_dim])
    _, gl = sess.run([train_gen, gen_loss], feed_dict={noise_input: z, is_training: True})
    n = 6
    canvas = np.empty((28 * n, 28 * n))
    if i % 250 == 0 or i == 1:
        print('Step %i: Generator Loss: %f, Discriminator Loss: %f' % (i, gl, dl))

    #测试
    # 运用神经网络，通过噪声输出图像
        if i % 500== 0 or i == 1:
            for t in range(n):
                    # 输入噪声
                    z = np.random.uniform(-1., 1., size=[n, noise_dim])
                    # 生成图像
                    g = sess.run(gen_sample, feed_dict={noise_input: z, is_training: False})
                    # 缩放
                    g = (g + 1.) / 2.
                    #反转颜色，便于展示
                    g = -1 * (g - 1)
                    for j in range(n):
                        # 绘图
                        canvas[t * 28:(t + 1) * 28, j * 28:(j + 1) * 28] = g[j].reshape([28, 28])
            plt.figure(figsize=(n, n))
            plt.imshow(canvas, origin="upper", cmap="gray")
            plt.savefig("%d.png"% i)

