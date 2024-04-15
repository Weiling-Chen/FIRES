function [quality] = FIRES(img, ori, left_eye, right_eye, th, weight)
    load('modelparameters_eye.mat');
    load('modelparameters_face.mat');

    [row1, ~] = size(left_eye);
    [row2, ~] = size(right_eye);
    if row1 < 24 || row2 < 24
        niqe_l = [];
        niqe_r = [];
    else
        niqe_l = computequality(left_eye,24,24,0,0, mu_prisparam_eye,cov_prisparam_eye);
        niqe_r = computequality(right_eye,24,24,0,0, mu_prisparam_eye,cov_prisparam_eye);
    end
    niqe_f = computequality(img,96,96,0,0, mu_prisparam,cov_prisparam);
    if isempty(niqe_r) || isempty(niqe_l)
        r = niqe_f;
    else
        r = mean([niqe_f, niqe_r, niqe_l]);
    end
    identity = ExtractIdentity(ori, img);
    if identity > th
        quality = weight * (1-r/15);
%         real_score(k) = 0.05;
    else
        quality = 1-r/15;
    end
end