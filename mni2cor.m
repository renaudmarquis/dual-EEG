function coordinate = mni2cor(mni, T)
% mni2cor(mni, T): convert mni coordinate to matrix coordinate
%
% mni: a Nx3 matrix of mni coordinate
% T: (optional) transform matrix
% coordinate is the returned coordinate in matrix
%
% xu cui
% 2004-8-18
%
% RM @ LREN
%

if isempty(mni)
    coordinate = [];
    return;
end

if nargin == 1
    V = spm_vol(spm_select);
    T = V.mat;
% 	T = ...
%         [-4     0     0    84;...
%          0     4     0  -116;...
%          0     0     4   -56;...
%          0     0     0     1];
end

coordinate = [mni(:,1) mni(:,2) mni(:,3) ones(size(mni,1),1)]*(inv(T))';
coordinate(:,4) = [];
coordinate = round(coordinate);
return;