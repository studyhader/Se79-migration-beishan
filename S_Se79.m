clc; clear; close all;

%% 距离
x = linspace(0,2000,1000);   % m

%% 水力坡度
i_list = [0.001, 0.005, 0.01];
label_list = {'i = 0.001','i = 0.005','i = 0.01'};

%% 参考坡度
i0 = 0.005;

%% 参数（与前一节保持一致）
L_ref = 350;      % 裂隙内前锋特征尺度 (m)
n = 2.0;          % 非线性指数
Lm0 = 1200;       % 基质交换特征长度 (m)

figure; hold on; box on;

for i = 1:length(i_list)
    ih = i_list(i);

    % 水力坡度控制的裂隙迁移尺度
    Lc = L_ref * (ih / i0);

    % 基质交换尺度（弱相关，可视为常数）
    Lm = Lm0;

    % 裂隙内前锋项
    front = exp( - (x ./ Lc).^n );

    % 基质交换损失项
    loss_matrix = exp( - x ./ Lm );

    % 裂隙域相对浓度
    C = front .* loss_matrix;

    plot(x, C, 'LineWidth', 2, ...
        'DisplayName', label_list{i});
end

xlabel('迁移距离 / m');
ylabel('Se-79 相对浓度');
% title('不同水力坡度条件下 Se-79 裂隙迁移特征（10^5 年）');
legend('Location','northeast');
grid on;
set(gca,'FontSize',12); 