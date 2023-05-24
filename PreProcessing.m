%%%%%%%%%%%%%%%%%%%data preparation

        %import data and ground truth label
        %this data is composed of 17 surface material mostly trees and vegetation
        %source: http://www.ehu.eus/ccwintco/index.php/Hyperspectral_Remote_Sensing_Scenes#Pavia_Centre_scene
        
load('C:\Users\Safari\Desktop\Sahand\RS\data\Indian_pines_corrected.mat')
load('C:\Users\Safari\Desktop\Sahand\RS\data\Indian_pines_gt.mat')

im=reshape(indian_pines_corrected,145*145,200);
gt=reshape(indian_pines_gt, 145*145,1);
        %find min of data and subtract 
a=min(im(:));
a1=im-a;
        % scale to [1 1]
a2=normalize(a1,'range');
        %choosing t random sample from each of the classes for training 
        %N(k): number of elements in each class
gt1=gt+1;
for k1=1:17
    N(k1)=sum(gt1==k1);
end
t=min(N(:));
idx=[];
for kk=1:17    
    f = find(gt1==kk);
    p = datasample(f,t);
    idx=vertcat(idx,p);
end
      
        %training data
X1=a2(idx,:)';
D1=gt1(idx)';
        %shuffle
v=randperm(340);
X=X1(:,v);
D2=D1(v);
D=full(ind2vec((D2)));
        %turn ground truth to vector
T = full(ind2vec((gt1)'));
P=a2';
        %map the training data and the ground truth
h=zeros(145*145,1);
h(idx)=1;
h2=reshape(h,145,145);

figure
hold on
h4=imagesc(h2)
h3=imagesc(indian_pines_gt)
title('Ground Truth')
alpha(h3,.3)

        %plotting the mean of each 17 classes
        %NOTE: obviously classes are very similar and hard to differentiate
I=[];
for i=1:17
    q=mean(X1(:,[20*(i-1)+1:20*i]),2);
    I=horzcat(I,q);
end
figure;

plot([1:200],I(:,[1:17]))
        %use a portion of feautures where classes are more seperated
X=X([111:140],:);
P=P([111:140],:);