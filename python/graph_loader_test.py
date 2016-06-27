import pytest

from python.graph_loader import GraphLoader


def test_no_lt_sign():
    with pytest.raises(ValueError):
        GraphLoader.load('no_lt_sign')


def test_no_from():
    with pytest.raises(ValueError):
        GraphLoader.load('no_from')


def test_no_to():
    with pytest.raises(ValueError):
        GraphLoader.load('no_to')
