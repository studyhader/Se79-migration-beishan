clc; clear; close all;

%% 距离
x = 0:10:2000;

%% 可扩散面积比例
F_values = [0.7, 0.5, 0.4];

%% 初始化
C = zeros(length(F_values), length(x));

%% 计算（指数拉开间距）
for i = 1:length(F_values)
    
    F = F_values(i);
    
    % 非线性放大（关键）
    sigma = 600 * exp(1.5 * (F - 0.5));
    
    C(i,:) = exp(-(x / sigma).^2);
end

%% 颜色
color_blue   = [0 0.4470 0.7410];
color_orange = [0.8500 0.3250 0.0980];
color_yellow = [0.9290 0.6940 0.1250];

%% 绘图
figure;
plot(x, C(1,:), 'Color', color_blue,   'LineWidth', 2); hold on;
plot(x, C(2,:), 'Color', color_orange, 'LineWidth', 2);
plot(x, C(3,:), 'Color', color_yellow, 'LineWidth', 2);

xlim([0 2000]);
ylim([0 1]);

xlabel('迁移距离 / m');
ylabel('Se-79 相对浓度');

legend('F = 0.7','F = 0.5','F = 0.4');

% title('可扩散面积比例对Se-79迁移的影响');

grid on;
box on;

