%In class problem from Lecture 4
%Characterize viscocity properties of unknown fluid sample
clear all
clc


film_thickness = 0.1; %mm
velocity = [0.01 0.05 0.1 0.5 1 2]; %mm/s
wall_shear_stress = [40.0 81.6 120.0 328.5 521.2 834.2]; %dynes/cm^2

%initial plot
plot(velocity, wall_shear_stress,'o-','linewidth',2,'markersize',5,'markerfacecolor','b')
xlabel('Velocity (mm/s)')
ylabel('wall shear stress (dynes/cm^2)')


%%%
w = waitforbuttonpress(); %Tip for debugging

%Convert velocity to shear rate
%Divide plate velocity by thickness of fluid (recall shear rate = V/h)
shear_rate = velocity./film_thickness;
plot(shear_rate, wall_shear_stress,'o-','linewidth',2,'markersize',5,'markerfacecolor','b')
xlabel('shear rate (s^-1)')
ylabel('wall shear stress (dynes/cm^2)')

w = waitforbuttonpress();
%Thoughts on model? not linear, non 0 intercept


%Try Casson:
plot(sqrt(shear_rate), sqrt(wall_shear_stress),'o-','linewidth',2,'markersize',5,'markerfacecolor','b')
hold on
coeffs = polyfit(sqrt(shear_rate),sqrt(wall_shear_stress), 1);
% Get fitted values
fittedX = linspace(min(sqrt(shear_rate)), max(sqrt(shear_rate)), 200);
fittedY = polyval(coeffs, fittedX);
% Plot the fitted line

plot(fittedX, fittedY)
xlabel('SQRT(shear rate (s^-1))')
ylabel('SQRT(wall shear stress (dynes/cm^2))')
ylabel('${\it} \sqrt{wall\:shear\:stress} $','Interpreter','Latex')
xlabel('${\it} \sqrt{shear\:rate (s^{-1})} $','Interpreter','Latex')
hold off
%Not really linear

w=waitforbuttonpress();

%Try Herschel-Bulkey (H-B model)
%make dimmensionless
yield_shear_stress = 20;
gamma_0 = 1
%Reminder log is natural log in matlab
y_values = log(wall_shear_stress - yield_shear_stress);
x_values = log(shear_rate);
plot(x_values, y_values,'o-','linewidth',2,'markersize',5,'markerfacecolor','b')
ylabelfont = ylabel('${\it} ln(\tau_w - \tau_y)  $','Interpreter','Latex');
set(ylabelfont, 'fontsize',19)
xlabelfont = xlabel('${\it} ln(\dot{\gamma})  $','Interpreter','Latex');
set(xlabelfont, 'fontsize',19);
%looks much more linear
coeffs = polyfit(x_values,y_values, 1);
fittedX = linspace(min(x_values), max(x_values), 200);
fittedY = polyval(coeffs, fittedX);
hold on
plot(fittedX, fittedY)
n = coeffs(1)
intercept = coeffs(2)
K = exp(intercept)
X = ['Model fits well with n=', num2str(n),', tau_y= ',num2str(yield_shear_stress),', and K=' num2str(K)];
disp(X)

%What if the yield stress wasn't given? Could you solve for it with this
%data as well?



%{
%Version from the textbook. Make paramaterless and choose a reasonable
%value for gamma_0
%Try Herschel-Bulkey (H-B model)
%make dimmensionless
yield_shear_stress = 20;
gamma_0 = 1
%Reminder log is natural log in matlab
y_values = log((wall_shear_stress - yield_shear_stress)/yield_shear_stress);
x_values = log(shear_rate/gamma_0);
plot(x_values, y_values,'o-','linewidth',2,'markersize',5,'markerfacecolor','b')
ylabelfont = ylabel('${\it} ln(\frac{\tau_w - \tau_y}{\tau_y}).  $','Interpreter','Latex');
set(ylabelfont, 'fontsize',19)
xlabelfont = xlabel('${\it} ln(\frac{\dot{\gamma}}{\dot{\gamma_0}})  $','Interpreter','Latex');
set(xlabelfont, 'fontsize',19);
%looks much more linear
coeffs = polyfit(x_values,y_values, 1);
fittedX = linspace(min(x_values), max(x_values), 200);
fittedY = polyval(coeffs, fittedX);
hold on
plot(fittedX, fittedY)
n = coeffs(1)
intercept = coeffs(2)
K = (yield_shear_stress/(gamma_0^n))*exp(intercept)
hold off
w = waitforbuttonpress();
%}
