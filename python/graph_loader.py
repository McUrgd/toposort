import os


class Edge:

    def __init__(self, frm, to):
        self.From = frm
        self.To = to

    def __repr__(self):
        return '{} > {}'.format(self.From, self.To)

    def __str__(self):
        return '{} > {}'.format(self.From, self.To)


class Graph:
    Edges = []

    def add_edge(self, edge: Edge):
        self.Edges.append(edge)

    def __repr__(self):
        return str(self.Edges)

    def __str__(self):
        return str(self.Edges)


def parse(line):
    if not line:
        raise ValueError('line is empty')

    source, destination = line.split('->', 1)

    if not source:
        raise ValueError('source is not specified')
    if not destination:
        raise ValueError('destination is not specified')

    source = source.strip()
    destination = destination.strip()
    return Edge(source, destination)


class GraphLoader:
    DataDirectory = 'test_data/'

    @classmethod
    def load(cls, filename):
        result = Graph()

        path = os.path.join(cls.DataDirectory, filename)
        for line in open(path).readlines():
            result.add_edge(parse(line))

        return result
