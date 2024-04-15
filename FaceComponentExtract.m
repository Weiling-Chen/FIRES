function [roi_n, roi_m] = FaceComponentExtract(img)

% 人脸检测与关键点定位
[~, landmarks] = face_landmarks(img);
mouth = 49:68;
% right_eye = 37:42;
% left_eye = 43:48;
nose = 28:36;
% width = 512;
th = 0.25;

% 人脸landmark检测
if isempty(landmarks)
    disp('Face is not detected!');
    return;
else
    landmark1 = landmarks;
end

landmarks_n = landmark1(nose, :);
[x1, y1, w1, h1] = boundingRect(landmarks_n);  % 矩形的左上坐标、宽、高
roi_n = imcrop(img, [x1 - round(th * w1), y1 - round(th * h1), ...
    w1 + round(th * w1) * 2, h1 + round(th * h1) * 2]);

landmarks_m = landmark1(mouth, :);
[x2, y2, w2, h2] = boundingRect(landmarks_m);  % 矩形的左上坐标、宽、高
roi_m = imcrop(img, [x2 - round(th * w2), y2 - round(th * h2), ...
    w2 + round(th * w2) * 2, h2 + round(th * h2) * 2]);

function [x, y, w, h] = boundingRect(pts)
% 计算最小外接矩形的左上角坐标，宽度和高度
x = min(pts(:, 1));
y = min(pts(:, 2));
w = max(pts(:, 1)) - x + 1;
h = max(pts(:, 2)) - y + 1;
end
end
