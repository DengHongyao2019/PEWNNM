function  [keypatchArr]  =  hykeyPatchArr(im, para)
% This Function Precompute the all the patch indexes in the Searching window
% ===============================================================================

s           =   para.step;
tempR       =   size(im,1)-para.patchSize+1;
tempC       =   size(im,2)-para.patchSize+1;
M           =   tempR * tempC; % # pathes.

rGridIdx	=   [1:s:tempR];
cGridIdx	=   [1:s:tempC];
rGridH      =   length(rGridIdx);    
cGridW      =   length(cGridIdx); 
pM          =   rGridH * cGridW; % # key patches.

keypatchArr   =    int32(zeros(1, pM)); 

imIdx       =   1:M;
imIdx       =   reshape(imIdx, tempR, tempC);
keypatchArr =   imIdx(rGridIdx, cGridIdx);
keypatchArr =   keypatchArr(:)';

% % down exampling 下采样，步长为s
% for  i  =  1 : rGridH
%     for  j  =  1 : cGridW    
%         OffsetR     =   rGridIdx(i);
%         OffsetC     =   cGridIdx(j);
%         Offset1  	=  (OffsetC-1)*tempR + OffsetR; %%% 原图像中的索引
%         Offset2   	=  (j-1)*rGridH + i; %%% 采样点索引（坐标）
%                 
%         keypatchArr(Offset2) = Offset1;
%     end
% end
% if(keypatches == keypatchArr)
%     fprintf('They are same');
% end


