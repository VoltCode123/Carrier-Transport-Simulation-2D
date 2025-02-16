% Advanced 2D Carrier Transport Simulation with Voltage Bias & Recombination
clear; clc; close all;

% Use Gnuplot renderer for better handling of large values
graphics_toolkit("gnuplot");

% Constants
q = 1.6e-19;  % Electron charge (C)
k = 1.38e-23; % Boltzmann constant (J/K)
eps_0 = 8.85e-12; % Vacuum permittivity (F/m)

% User Inputs
T = input('Enter temperature (K): ');
Lx = input('Enter semiconductor length in x (microns): ') * 1e-6;
Ly = input('Enter semiconductor length in y (microns): ') * 1e-6;
Nx = input('Enter number of x points: ');
Ny = input('Enter number of y points: ');
Nt = input('Enter number of time steps: ');
dt = input('Enter time step (ps): ') * 1e-12;
V_bias = input('Enter applied voltage (V): ');

% Define space grid
x = linspace(0, Lx, Nx);
y = linspace(0, Ly, Ny);
[X, Y] = meshgrid(x, y);
dx = x(2) - x(1);
dy = y(2) - y(1);

% Material properties (Silicon example)
mu_n = 1350e-4; % Electron mobility (m^2/Vs)
mu_p = 480e-4;  % Hole mobility (m^2/Vs)
D_n = mu_n * (k*T/q);
D_p = mu_p * (k*T/q);

% Initial carrier distribution
n = exp(-((X - Lx/2).^2 + (Y - Ly/2).^2) / (0.1e-6)^2) * 1e21;
p = exp(-((X - Lx/2).^2 + (Y - Ly/2).^2) / (0.1e-6)^2) * 1e21;

% Voltage distribution
V = linspace(0, V_bias, Nx);
[E_x, E_y] = gradient(-V, dx, dy);

% Simulation loop
figure;
for t = 1:Nt
    % Compute drift currents
    J_drift_n_x = q * n .* mu_n .* E_x;
    J_drift_n_y = q * n .* mu_n .* E_y;
    J_drift_p_x = q * p .* mu_p .* E_x;
    J_drift_p_y = q * p .* mu_p .* E_y;

    % Compute diffusion currents using 2D gradient
    [dn_dx, dn_dy] = gradient(n, dx, dy);
    [dp_dx, dp_dy] = gradient(p, dx, dy);

    J_diff_n_x = q * D_n * dn_dx;
    J_diff_n_y = q * D_n * dn_dy;
    J_diff_p_x = q * D_p * dp_dx;
    J_diff_p_y = q * D_p * dp_dy;

    % Recombination (SRH model)
    tau = 1e-9;
    R = (n .* p - 1e20) ./ tau;

    % Update carrier concentration (ensuring positivity)
    n = n - dt * (gradient(J_drift_n_x + J_diff_n_x, dx, dy) + gradient(J_drift_n_y + J_diff_n_y, dx, dy)) - dt * R;
    p = p - dt * (gradient(J_drift_p_x + J_diff_p_x, dx, dy) + gradient(J_drift_p_y + J_diff_p_y, dx, dy)) - dt * R;

    % Ensure positive values to prevent log10 errors
    n(n < 1) = 1;
    p(p < 1) = 1;

    % Visualization
    subplot(1,2,1);
    surf(X*1e6, Y*1e6, log10(n * 1e-21)); shading interp; view(2);
    title(['Electron Density (log scale) at t = ' num2str(t)]);
    xlabel('x (um)'); ylabel('y (um)'); colorbar;

    subplot(1,2,2);
    surf(X*1e6, Y*1e6, log10(p * 1e-21)); shading interp; view(2);
    title(['Hole Density (log scale) at t = ' num2str(t)]);
    xlabel('x (um)'); ylabel('y (um)'); colorbar;

    pause(0.1);
end

