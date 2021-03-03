b=[0.999,0.993,0.88,0.708,0.459,0.195,0.096];
c=[0.01,0.099,0.443,0.707,0.894,0.979,0.999];
values=spcrv([[a(1) a a(end)];[b(1) b b(end)]],3);
plot(values(1,:),values(2,:),'r')
hold on;
values1=spcrv([[a(1) a a(end)];[c(1) c c(end)]],3);
plot(values1(1,:),values1(2,:),'b')