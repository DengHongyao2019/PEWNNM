function hyrelative(xyBatches, iPair, k)

epsName = strcat(num2str(iPair),'Add.eps');
% epsName = strcat('espName', '.eps');
numIm = size(xyBatches,3);
h = waitbar(0, 'Computer Difference of Singular Values');
for i = 1 : 1 : numIm
    waitbar(i/numIm);
    X = xyBatches(:,:,i,1);
    Y = xyBatches(:,:,i,2);
    [~, sigmaX, Vx] = svd(X);
    [~, sigmaY, Vy] = svd(Y);
    errSigmaIm = diag(sigmaY)-diag(sigmaX);
    figure(k);
    hold on;
    plot(errSigmaIm, '--ko', 'LineWidth', 1, ...
    'MarkerEdgeColor', 'k',...
    'MarkerFaceColor', 'g', 'MarkerSize', 2);
end
close(h);
hold off;
print('-depsc2', epsName);



    


