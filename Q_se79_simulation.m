clc; clear; close all;

%% 时间向量
t = linspace(0, 1e5, 500); % 年

%% 固定迁移距离（米）
distances = [200, 400, 700]; 

%% 典型有效迁移速度（m/年）
v = 54.5; R = 1321;
v_eff = v / R;

%% 稳态相对浓度上限
C_max = [0.95, 0.90, 0.85];

%% 缩放因子
scale_factor = 0.5;

%% 计算累积相对浓度
C_results = zeros(length(t), length(distances));

for i = 1:length(distances)
    x0 = distances(i);
    C = C_max(i) * (1 - exp(-scale_factor * v_eff * t / x0));
    C_results(:, i) = C;
end

%% 绘图
figure('Position',[100,100,900,600]);

% === 设置颜色：使用图片中的蓝色、红色和金黄色 ===
color_golden = [0.95, 0.70, 0.20];   % 金黄色
color_red    = [0.85, 0.33, 0.10];   % 图片中的红色（来自你之前的代码）
color_blue   = [0.00, 0.45, 0.74];   % 图片中的蓝色（来自你之前的代码）

colors = [color_golden; color_red; color_blue];

hold on;
for i = 1:length(distances)
    plot(t, C_results(:,i), 'Color', colors(i,:), 'LineWidth', 2, ...
        'DisplayName', sprintf('迁移距离=%d m', distances(i)));
end

%% 图形属性
xlabel('迁移时间 / 年','FontSize',12,'FontWeight','bold');
ylabel('Se-79 相对浓度','FontSize',12,'FontWeight','bold');
% title('裂隙域中Se-79浓度随迁移时间变化','FontSize',14,'FontWeight','bold');
xlim([0 max(t)]);
ylim([0 1]);
grid on; box on;
legend('Location','southeast','FontSize',10);
set(gca,'FontSize',11,'LineWidth',1.5,'TickDir','in');
ax = gca; ax.Color = [0.98 0.98 0.98];

fprintf('调整后累积浓度曲线生成完成！（颜色：金黄色、红色、蓝色）\n');