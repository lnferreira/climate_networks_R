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

library("igraph")

# ==============================================================================
# Build a network from a distance matrix and a distance percentile threshold
# ==============================================================================
network_build <- function(distance_matrix, percentile_value = 0.1, normalize = TRUE) {
    if (normalize) 
        distance_matrix = dist.normalize(distance_matrix)
    distance_threshold = dist_percentile(distance_matrix, percentile_value)
    A = matrix(0, ncol(distance_matrix), nrow(distance_matrix))
    A[distance_matrix < distance_threshold] = 1
    graph.adjacency(A, mode="undirected", diag=F)
}

# ==============================================================================
# Obtain the distance percentile threshold from a distance matrix
# ==============================================================================
dist_percentile <- function(distance_matrix, percentile_value) {
    distance_matrix[is.na(distance_matrix)] = +Inf
    quantile(distance_matrix[upper.tri(distance_matrix)], probs = c(percentile_value))
}
