function Color=paintReconstruction(Corresp,im_name)

I=imread(im_name);
index=round(Corresp);
Color=zeros(3,size(index,2));
for i=1:size(index,2)
    Color(:,i)=I(index(2,i),index(1,i),:);
end


