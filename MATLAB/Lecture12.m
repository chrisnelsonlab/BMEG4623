%Author nelsonc
%Simple FDM demonstration
%1D flow through infinite parallel plates
clear all
clc

%note this makes 10 interior nodes. The boundaries are not plotted
fdm_matrix = zeros(10);

%populate matrix
for i=2:9
    fdm_matrix(i-1,i) = 1;
    fdm_matrix(i,i) = -2;
    fdm_matrix(i+1,i) = 1;
end

%Handle boundary condtion nodes separatly
fdm_matrix(1,1) = -2;
fdm_matrix(2,1) = 1; %NOTE ADDED LINE
fdm_matrix(10,10) = -2;
fdm_matrix(10-1,10) = 1; %NOTE ADDED LINE


%Make coeff matrix - right now they are all the same. The value here is for
%illustration
coef = zeros(10,1);
for j=1:10
    coef(j) = -1.00/(100);
end

%Invert matrix
fdm_invert = inv(fdm_matrix);

%Solve for velocity
velocity_matrix = fdm_invert*coef;

%Plot distribution
plot(velocity_matrix)

 
w=waitforbuttonpress();

%make the problem more general for Ndivisions

N=50; %Change this value for increased or decreased spacing
for i=2:N-1
    fdm_matrix(i-1,i) = 1;
    fdm_matrix(i,i) = -2;
    fdm_matrix(i+1,i) = 1;
end
fdm_matrix(1,1) = -2;
fdm_matrix(2,1) = 1; %NOTE ADDED LINE
fdm_matrix(N,N) = -2;
fdm_matrix(N-1,N) = 1; %NOTE ADDED LINE

coef = zeros(N,1)

for j = 1:N
    coef(j) = -1.00/(N*N);
end

fdm_invert = inv(fdm_matrix)
velocity_matrix = fdm_invert*coef;
plot(velocity_matrix)

w=waitforbuttonpress();

N=50;
v_matrix1 = zeros(N,1);
v_matrix2 = zeros(N,1);
P_term = 1/(N*N)
er = 10;
counter = 0;
while abs(er)>.001
    counter = counter +1;
    for i=2:N-1
        v_matrix2(i) = v_matrix1(i-1)/2+v_matrix1(i+1)/2+P_term;
    end
    er=sum(minus(v_matrix1,v_matrix2));
    v_matrix1 = v_matrix2;
    plot(v_matrix1)
    pause(0.1)
end
plot(v_matrix1)
counter
        
        



    
