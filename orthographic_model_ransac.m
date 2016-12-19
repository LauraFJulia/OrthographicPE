function [model,vec_err]=orthographic_model_ransac(Data,sample)
% Auxiliary function for AC_RANSAC to compute a valid orthographic
% orientation from a minimal set of tracks on 3 cameras.
% The scaled Orthographic model is used to compute the orientations and
% then the reprojection error is computed by pairs 

% recover tracks and internal calibration param. from Data
p1=Data{1}; p2=Data{2}; p3=Data{3};
K1=Data{4}; K2=Data{5}; K3=Data{6}; 

Corresp=[p1(1:2,:);p2(1:2,:);p3(1:2,:)];
N=size(p1,2);
err_min=inf;
try
    [Sol1,Sol2]=OrthographicPoseEstimation(Corresp(:,sample),[K1;K2;K3]);
catch
    model={};
    vec_err=[];
    return;
end

R=Sol1{4}; T=Sol1{5};
for j=1:2
    %%% (orthographic) 3d reconstruction from views 1&2
    p3D_12=pinv(R(1:4,:))*(Corresp(1:4,:)-repmat(T(1:4),1,N));
    %%% reprojection to view 3 and error
    error_3=sqrt(sum((R(5:6,:)*p3D_12+repmat(T(5:6),1,N) - Corresp(5:6,:)).^2,1));

    %%% (orthographic) 3d reconstruction from views 1&3
    p3D_13=pinv(R([1 2 5 6],:))*(Corresp([1 2 5 6],:)-repmat(T([1 2 5 6]),1,N));
    %%% reprojection to view 2 and error
    error_2=sqrt(sum((R(3:4,:)*p3D_13+repmat(T(3:4),1,N) - Corresp(3:4,:)).^2,1));
    
    %%% (orthographic) 3d reconstruction from views 2&3
    p3D_23=pinv(R(3:6,:))*(Corresp(3:6,:)-repmat(T(3:6),1,N));
    %%% reprojection to view 3 and error
    error_1=sqrt(sum((R(1:2,:)*p3D_23+repmat(T(1:2),1,N) - Corresp(1:2,:)).^2,1));

    err=max([error_1; error_2; error_3]);

    if sum(err)<err_min
        vec_err=err;
        err_min=sum(err);
        model={R,T};
    end
    R=Sol2{4}; T=Sol2{5};
end

end

