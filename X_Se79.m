
clc; clear; close all;

%% 距离
x = linspace(0,2000,1000);   % m

%% 裂隙隙宽 (m)
b_list = [0.05e-3, 0.5e-3, 2.0e-3];
label_list = {'0.05 mm','0.5 mm','2.0 mm'};

%% 参考隙宽
b0 = 0.5e-3;

%% 参数（数值已做尺度控制）
L_ref = 350;      % 裂隙内前锋控制尺度 (m)
n = 2.0;          % 非线性指数
Lm0 = 1200;       % 基质交换特征长度 (m)

figure; hold on; box on;

for i = 1:length(b_list)
    b = b_list(i);

    % 裂隙内迁移前锋尺度
    Lc = L_ref * (b / b_list(1)).^0.6;

    % 基质交换等效长度（随隙宽变化）
    Lm = Lm0 * (b / b0);

    % 前锋项
    front = exp( - (x ./ Lc).^n );

    % 双域基质损失项（稳定）
    loss_matrix = exp( - x ./ Lm );

    % 裂隙域相对浓度
    C = front .* loss_matrix;

    plot(x, C, 'LineWidth', 2, ...
        'DisplayName', ['隙宽 ', label_list{i}]);
end

xlabel('迁移距离 / m');
ylabel('Se-79 裂隙域相对浓度');
% title('双域模型下隙宽对 Se-79 裂隙迁移的影响（10^5 年）');
legend('Location','northeast');
grid on;
set(gca,'FontSize',12);

