source("tsDist.R")

climate_networks <- function(distance_matrix, normalize = TRUE, percentileNum = 0.1) {
    if (normalize) 
        dist = dist.normalize(dist)
    
    percentileThreshold = dist_percentile(dist, percentileNum)
    net = net.epsilon.create(dist, percentileThreshold)
    if (!is.null(outputfilePath)) { 
        distName = str_match(path, "tsdiss_(\\w*).RDS")[2]
        fileName = paste0(outputfilePath, "/net_", distName,"_p", (percentileNum*100), ".RDS")
        saveRDS(net, fileName) 
    }
    net
}