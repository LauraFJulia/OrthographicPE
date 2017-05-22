function writeOrientations(file_name,R_t)

M=size(R_t,1)/3;
file = fopen(file_name, 'wt');
fprintf(file,'Orientation file. Total of %d cameras.\n',M);
fprintf(file,'Format: 3 lines per camera, 3 first columns for rotation, last column for translation.\n\n');
for i=1:size(R_t,1)
    fprintf(file,'%f %f %f %f\n', R_t(i,1),R_t(i,2),R_t(i,3),R_t(i,4));
end
fclose(file);

