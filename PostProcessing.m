for kkk=1:21025
    [r c]=max(Z(:,kkk));
    C(kkk)=c;
end


h5=reshape(C,[145,145]);
tiledlayout(1,2)
nexttile
h4=imagesc(h5)
title('Classification Result')
nexttile
h3=imagesc(indian_pines_gt)
title('Ground Truth')
