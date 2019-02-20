# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

source("tsDist.R")
source("climate_networks.R")


par(ask=TRUE)

# 01) Read your time series into a list. In this example, we will create a 
#     data set instead. This data set is composed by:
#         10 sine wave time series [ids 1:10]
#         10 cosine wave time series [ids 11:20]
#     In the paper, we used the temperature variation from each cell as input.
sin_ts_list = replicate(10, jitter(sin(seq(0, 6*pi, 0.1)), 2000), simplify = F)
cos_ts_list = replicate(10, jitter(cos(seq(0, 6*pi, 0.1)), 2000), simplify = F)
ts_list = c(sin_ts_list, cos_ts_list)
matplot(do.call(cbind, ts_list), t='l', lty=1, col=c(rep(4,10), rep(2,10)), 
        xlab="time", ylab="y", main="Time series data set")


# 02) Calculate distance matrix using DTW function. Here could any other distance
#     function. See tsDist.R for more distance functions. After the cosntruction, 
#     we normalize the distance matrix.
distance_matrix = dist.parallel(tsList = ts_list, distFunc = tsdiss.dtw, cores = 1)
distance_matrix = dist.normalize(distance_matrix)


# 03) Construct the network and plot
net = network_build(distance_matrix = distance_matrix, percentile_value = 0.5)
par(mar=c(0,0,0,0))
plot(net, edge.color="gray60", vertex.size=8, vertex.label.family="Times",
                    vertex.label.cex=1.1, vertex.label.color=c("black"),
                    mark.col="gray90", mark.border="black", edge.curved=0.5)
par(mar=c(5, 4, 4, 2) + 0.1)


par(ask=FALSE)
