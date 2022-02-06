function [ img ] = SART( params, sgram, Iterations )

%------------
% Generate System Matrix Row and Col sums
%------------
rotations = params.rotations;
Scol = zeros(1, params.pxNum^2);
Srow = zeros(1, params.detNum*params.viewNum);
for idx = 1:params.viewNum
    params.rotations = rotations(idx);
    A = ProjectDDM_matrix(params);
    Scol = Scol + sum(A,1);
    Srow(:, 1+(idx-1)*params.detNum:idx*params.detNum) = sum(A,2);
end
Srow = (1./(Srow + 1e-6))';
Scol = 1./(Scol + 1e-6)';
params.rotations = rotations;
sgram = sgram(:);
img = zeros(params.pxNum);
relaxParam = 1.0;

for x=1:Iterations
    tic
    img_err = ProjectDDM(params, img);
    img_err = img_err(:) - sgram;
    img_err = Srow.*img_err;
    img_err = reshape(img_err,params.detNum,params.viewNum);
    img_err = BackProjectDDM(params, img_err);
    img_err = relaxParam.*Scol.*img_err(:);
    img = img - reshape(img_err,params.pxNum,params.pxNum);
%     imshow(img,[]);
%     title("SART Iteration: " + string(x));
%     savefig("data/ph512-sart-" + string(x));
    toc
end
end
