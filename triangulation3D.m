function space_points=triangulation3D(Pcam,image_points)
% Triangulation of N 3d points from their image points in M>1 images.
%
% The triangulation is initially computed by the DLT algorithm and refined
% by minimizing reprojection error using Gauss-Helmert method
%
% Input arguments:
%       P      - M-cell of projection 3x4-matrices
% image_points - 2MxN-matrix with the image points in each image
%        or    - 3MxN-matrix with the image points in each image with
%                homogeneous coord
% Output arguments:
% space_points - 4xN-array containing the 3d estimated positions (in
%                 homogeneous coordinates) of the image points.

M=size(Pcam,2); % number of images
if M<2
    return
end

N=size(image_points,2); % number of points
switch size(image_points,1)
    case 2*M
        % euclidean coord
    case 3*M
        % homogeneous coord
        aux=reshape(image_points,3,N*M);
        aux=aux(1:2,:)./repmat(aux(3,:),2,1);
        image_points=reshape(aux,2*M,N);
    otherwise
        return
end


space_points=zeros(4,N);
for n=1:N
    corresp_n=image_points(:,n);
    
    % DLT solution
    valid_indexes=true(1,2*M);
    ls_matrix=zeros(2*M,4); %linear system matrix
    for i=1:M
        point=corresp_n(2*(i-1)+1:2*(i-1)+2,:);
        if sum(isfinite(point))<2
            valid_indexes(2*(i-1)+(1:2))=false;
            continue;
        end
        ls_matrix(2*(i-1)+1:2*(i-1)+2,:)=...
            [0 -1 point(2); 1 0 -point(1)]*Pcam{i};
    end
    [~,~,V]=svd(ls_matrix(valid_indexes,:));
    PointX=V(:,4);
    space_points(:,n)=PointX;
end


end