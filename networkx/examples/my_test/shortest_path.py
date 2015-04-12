import networkx as nx
G = nx.Graph()
G.add_edge('A', 'B', weight=5)
G.add_edge('B', 'C', weight=3)
G.add_edge('A', 'D', weight=1)
sp_mat = nx.all_pairs_dijkstra_path_length(G, cutoff=None, weight='weight')
print sp_mat