function Corresp=matches2triplets(corresp12,corresp23,corresp13)
%MATCHES2TRIPLETS Computes the matching triplets of points for 3 views from
% the matching points between pairs of images.
%
%  Input arguments:
%  corresp12   - 4xN matrix containing in each column, the coordinates of a 
%                point in image 1 followed by the coordinates of the
%                matching point in image 2.
%  corresp23   - 4xN matrix containing in each column, the coordinates of a
%                point in image 2 followed by the coordinates of the
%                matching point in image 3.
%  corresp13   - 4xN matrix containing in each column, the coordinates of a
%                point in image 1 followed by the coordinates of the
%                matching point in image 3. Optional, for consistency check.
%
%  Output arguments:
%  Corresp     - 6xN matrix containing in each column, the 3 projections of
%                the same space point onto each image.

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


% intersection of matches
[~,i1,i2]=intersect(corresp12(3:4,:).',corresp23(1:2,:).','rows');
if ~isempty(i1)
   Corresp=[corresp12(:,i1); corresp23(3:4,i2)];
else
    error('No common matching points between the 3 images.\n');
end

% If a third file is provided for consistency check
if nargin==3
    % intersection of matches
    [~,i1,~]=intersect(Corresp([1 2 5 6],:).',corresp13.','rows');
    if ~isempty(i1)
       Corresp=Corresp(:,i1);
    else
        error('No common matching points between the 3 images.\n');
    end
end

end
