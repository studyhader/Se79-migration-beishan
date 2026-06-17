clc; clear; close all;

%% 距离
x = 0:10:2000;

%% 参数（控制曲线形状）
sigma1 = 700;   % 孔隙度 0.01
sigma2 = 500;   % 孔隙度 0.02
sigma3 = 300;   % 孔隙度 0.03

%% 浓度曲线
C1 = exp(-(x/sigma1).^2);
C2 = exp(-(x/sigma2).^2);
C3 = exp(-(x/sigma3).^2);

%% 颜色设置（关键）
color_blue   = [0 0.4470 0.7410];     % 蓝
color_orange = [0.8500 0.3250 0.0980]; % 橙（MATLAB默认橙）
color_yellow = [0.9290 0.6940 0.1250]; % 黄

%% 绘图
figure;
plot(x, C1, 'Color', color_blue,   'LineWidth', 2); hold on;
plot(x, C2, 'Color', color_orange, 'LineWidth', 2);
plot(x, C3, 'Color', color_yellow, 'LineWidth', 2);

%% 坐标轴
xlim([0 2000]);
ylim([0 1]);

xlabel('迁移距离 / m');
ylabel('Se-79 相对浓度');

legend('岩石孔隙度 0.01','岩石孔隙度 0.02','岩石孔隙度 0.03');

% title('岩石孔隙度对Se-79迁移的影响');

grid on;
box on;
