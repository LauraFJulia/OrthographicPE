function writePLYreconstruction(file_name,CalM,R_t,Reconst,Color)

N=size(Reconst,2);
M=size(R_t,1)/3;

col=nargin>4;

file = fopen(file_name, 'wt');
fprintf(file,'ply\nformat ascii 1.0\nelement vertex %d\n', N+5*M);
fprintf(file,'property float x\nproperty float y\nproperty float z\n');
fprintf(file,'property uchar red\nproperty uchar green\nproperty uchar blue\n');
fprintf(file,'element edge %d\nproperty int vertex1\nproperty int vertex2\n',8*M);
fprintf(file,'property uchar red\nproperty uchar green\nproperty uchar blue\n');
fprintf(file,'end_header\n');

% Reconstruction Points
for n=1:N
    fprintf(file,'%f %f %f ',Reconst(1,n),Reconst(2,n),Reconst(3,n));
    if col
        fprintf(file,'%d %d %d\n',Color(1,n),Color(2,n),Color(3,n));
    else
        fprintf(file,'255 255 255\n');
    end
end

scale=1/100000;
% Camera Points and vertices
for m=1:M
    O=-R_t((m-1)*3+(1:3),1:3)'*R_t((m-1)*3+(1:3),4);
    fprintf(file,'%f %f %f 0 255 0\n',O(1),O(2),O(3));
    frame=[CalM((m-1)*3+(1:2),3);CalM((m-1)*3+1,1)]*scale;
    for i=1:4
        P=R_t((m-1)*3+(1:3),1:3)'*frame+O;
        fprintf(file,'%f %f %f 0 255 0\n',P(1),P(2),P(3));
        frame(1)=-frame(1);
        if i==2
            frame(2)=-frame(2);
        end
    end
end
for m=1:M
    ind=N+(m-1)*5;
    for i=1:4
        fprintf(file,'%d %d 0 255 0\n',ind, ind+i);
    end
    fprintf(file,'%d %d 0 255 0\n',ind+1, ind+2);
    fprintf(file,'%d %d 0 255 0\n',ind+2, ind+4);
    fprintf(file,'%d %d 0 255 0\n',ind+4, ind+3);
    fprintf(file,'%d %d 0 255 0\n',ind+3, ind+1);
end

fclose(file);







