function wavlet = ExtractIdentity(ori, img)
%% 进行n层小波分解，取第n层的低频分量作为特征
ori = rgb2gray(ori);
img = rgb2gray(img);
ori_size = size(ori);
img_size = size(img);
n = img_size(1) / ori_size(1);
m = 2;
ori = imresize(ori, 2);
[c1, s1] = wavedec2(img, log2(n), 'haar');
[c2, s2] = wavedec2(ori, log2(m), 'haar');

[H1, ~, ~] = detcoef2('all', c1, s1, log2(n));
[H2, ~, ~] = detcoef2('all', c2, s2, log2(m));

% 使用标准化方式进行映射
H1 = H1(:)';%% 小波
H1_std = (H1 - mean(H1)) / std(H1);
H2 = H2(:)';
H2_std = (H2 - mean(H2)) / std(H2);

wavlet = pdist2(H1_std, H2_std);
end