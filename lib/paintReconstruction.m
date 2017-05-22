function Color=paintReconstruction(Corresp,im_name)
%PAINTRECONSTRUCTION extracts the color of each correspondance point from
% a reference image.
%  
%  Input arguments:
%  Corresp  - 2xN matrix with the coordinates of the correspondences in the
%             image.
%  im_name  - string containing the path to the image.

% Copyright (c) 2017 Laura F. Julia <laura.fernandez-julia@enpc.fr>
% All rights reserved.
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.


I=imread(im_name);
index=round(Corresp);
Color=zeros(3,size(index,2));
for i=1:size(index,2)
    Color(:,i)=I(index(2,i),index(1,i),:);
end


