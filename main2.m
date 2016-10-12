clear;
clc;
clus = 30;
Resize = 1;

matfiles = dir(fullfile('C:', 'Users', 'Haowen', 'Desktop','project','sift-matlab-exp','siftDemoV4','data','*.jpg'));
listOfname = matfiles.name;
i = size(matfiles,1);
pics = cell(i,1);

for n = 1:i
    pics(n) = cellstr(matfiles(n).name);
end

path1 = cd;
cd data;

imageData = zeros(n,3);

for i = 1:n;
X = imread(char(pics(i)));
p(i).r = X;
X = imresize(X, Resize);
imwrite(X,strcat(num2str(i),'.pgm'));
imwrite(X,strcat(num2str(i),'.png'));
end
cd(path1);
addpath('data')
%%


dimM = zeros(1,n);
setD = zeros(1,128);
%dimM is the matrix for dimension of descriptors for each image
for i = 1:n;
                %b = descriptor vector
    [a,b,c] = sift(strcat(num2str(i),'.pgm'));
    dimM(i) = size(b,1);
    setD = [setD; b];
end

setD(1,:) = [];

[a b c] = kmeans(setD,clus);

Kmat = zeros(n,clus);
startp = 1;
for i = 1:n
    for j = 1:clus
        Kmat(i,j) = sum(a(startp:startp+dimM(i)) == j);
    end
    d = 1/norm(Kmat(i,:));
    Kmat(i,:) = Kmat(i,:) * d* log(norm(Kmat(i,:)));
end

pDist = squareform(pdist(Kmat));
[B I] = sort(pDist,2);


for i = 1:n
    
im = appendimages(p(I(i,1)).r, p(I(i,2)).r);
im = appendimages(im,p(I(i,3)).r);
im = appendimages(im,p(I(i,4)).r);
ima(i).I =  im;
end

for i = 1:30
figure;
imagesc(ima(i).I);
hold off
end
 