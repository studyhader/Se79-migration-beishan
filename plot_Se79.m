clc; clear; close all;

%% 距离向量
x = 0:10:2000;

%% 高斯曲线参数
sigma_1k = 200; sigma_10k = 500; sigma_100k = 900;
C_1k = exp(-(x/sigma_1k).^2);
C_10k = exp(-(x/sigma_10k).^2);
C_100k = exp(-(x/sigma_100k).^2);

%% 衰变修正
half_life = 3.27e5;
lambda = log(2)/half_life;

C_1k = C_1k * exp(-lambda * 1e3);
C_10k = C_10k * exp(-lambda * 1e4);
C_100k = C_100k * exp(-lambda * 1e5);

%% 归一化
C_1k = C_1k / C_1k(1);
C_10k = C_10k / C_10k(1);
C_100k = C_100k / C_100k(1);

%% ====== 设置颜色 ======
blue  = [0,    0.45, 0.74]; % t = 10^5 a (蓝色)
red   = [0.85, 0.33, 0.10]; % t = 10^4 a (红色) 
yellow = [0.9, 0.7, 0.2];    % t = 10^3 a (金黄色，接近图片里的黄色)

%% 绘制曲线
plot(x, C_100k, 'Color', blue,   'LineWidth', 2, 'DisplayName', 't=10^5 a'); hold on;
plot(x, C_10k,  'Color', red,    'LineWidth', 2, 'DisplayName', 't=10^4 a');
plot(x, C_1k,   'Color', yellow, 'LineWidth', 2, 'DisplayName', 't=10^3 a');

%% ---------- 计算典型迁移距离 ----------
v = 54.5; R = 1321;
v_eff = v / R; % m/年
times = [1e3, 1e4, 1e5];
L_eff = v_eff * times;

%% 图形属性
xlabel('裂隙中的迁移距离 / m','FontSize',12,'FontWeight','bold');
ylabel('Se-79相对浓度','FontSize',12,'FontWeight','bold');
xlim([0 2000]); ylim([0 1]);
grid on; box on;
legend('Location','northeast','FontSize',10);
set(gca,'FontSize',11,'LineWidth',1.5,'TickDir','in');
ax = gca; ax.Color = [0.98 0.98 0.98];

fprintf('典型迁移距离（m）：1e3年=%.1f, 1e4年=%.1f, 1e5年=%.1f\n', L_eff);