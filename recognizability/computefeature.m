function feat = computefeature(structdis)

% Input  - MSCn coefficients
% Output - Compute the 18 dimensional feature vector 

feat          = [];



[alpha, betal, betar]      = estimateaggdparam(structdis(:));

feat                     = [feat;alpha;(betal+betar)/2];

shifts                   = [0 1;1 0 ;1 1;1 -1];

for itr_shift =1:4
 
shifted_structdis        = circshift(structdis,shifts(itr_shift,:));
pair                     = structdis(:).*shifted_structdis(:);
[alpha betal betar]      = estimateaggdparam(pair);
meanparam                = (betar-betal)*(gamma(2/alpha)/gamma(1/alpha));                       
feat                     = [feat;alpha;meanparam;betal;betar];

end

function [alpha, betal, betar] = estimateaggdparam(vec)


gam   = 0.2:0.001:10;
r_gam = ((gamma(2./gam)).^2)./(gamma(1./gam).*gamma(3./gam));


leftstd            = sqrt(mean((vec(vec<0)).^2));
rightstd           = sqrt(mean((vec(vec>0)).^2));

gammahat           = leftstd/rightstd;
rhat               = (mean(abs(vec)))^2/mean((vec).^2);
rhatnorm           = (rhat*(gammahat^3 +1)*(gammahat+1))/((gammahat^2 +1)^2);
[min_difference, array_position] = min((r_gam - rhatnorm).^2);
alpha              = gam(array_position);

betal              = leftstd *sqrt(gamma(1/alpha)/gamma(3/alpha));
betar              = rightstd*sqrt(gamma(1/alpha)/gamma(3/alpha));
