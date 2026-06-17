% -------------------------------------------------------------------------
% 直接解析解法：保证在 x_target = 0.05 m 处 erfc(...) = targetC
% -------------------------------------------------------------------------
clc; clear; close all;

% ---------- 用户参数（可改） ----------
x_target = 0.05;        % 目标深度 (m)，希望在此处浓度接近目标值
targetC = 0.01;         % 希望 C/C0 在 x_target 处约为 0.01 (1%)
t_years = 1e5;          % 模拟时间：年
t = t_years * 365 * 24 * 3600;  % 转为秒（与D单位 m^2/s 对应）

% 三个裂隙情形的界面相对浓度 C0（你可以按需修改）
C0_200 = 0.55;
C0_300 = 0.40;
C0_500 = 0.27;

% ---------- 解析反解 D（避免数值求根） ----------
% erfcinv 存在于 MATLAB，求解：
% erfc( x_target / (2*sqrt(D*t)) ) = targetC
% => x_target / (2*sqrt(D*t)) = erfcinv(targetC)
% => D = ( x_target / (2*erfcinv(targetC)) )^2 / t

arg = erfcinv(targetC);
if arg <= 0
    error('erfcinv(targetC) 非正，targetC 必须在 (0,2) 且不太接近 1。');
end

D = ( x_target / (2 * arg) )^2 / t;   % m^2/s
fprintf('解析求得扩散系数 D = %.3e m^2/s\n', D);

% ---------- 计算并绘图 ----------
x = linspace(0, 0.06, 400);   % 横坐标 0 - 0.06 m

L = 2 * sqrt(D * t);          % erfc 中的尺度量

C200 = C0_200 .* erfc( x ./ L );
C300 = C0_300 .* erfc( x ./ L );
C500 = C0_500 .* erfc( x ./ L );

% 绘图
figure('Position',[120,120,900,600]);
plot(x, C200, 'LineWidth',2); hold on;
plot(x, C300, 'LineWidth',2);
plot(x, C500, 'LineWidth',2);

xlim([0 0.06]);
ylim([0 0.6]);
xlabel('扩散深度 / m','FontSize',12);
ylabel('相对浓度 C/C_0','FontSize',12);
legend('迁移距离 200 m','迁移距离 300 m','迁移距离 500 m','Location','northeast');
% title(sprintf('基质域中 Se-79 相对浓度随扩散深度的衰减（t=%.0f a, D=%.2e m^2/s）', t_years, D));
grid on;
box on;
set(gca,'FontSize',11,'LineWidth',1.2);
