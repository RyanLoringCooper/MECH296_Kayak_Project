function isNearBetaSingularity = nearBetaSingularity(beta)
    singularityIndicator = beta/pi;
    isNearBetaSingularity = singularityIndicator-floor(singularityIndicator) <= .01;
end