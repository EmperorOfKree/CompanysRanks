import unittest
from app import calulate_score

class CompanyScoreCalulationTestCase(unittest.TestCase):
    def setUp(self):
        pass

    def tearDown(self):
        pass

    def test_more_then_100_perc(self):
        score = calulate_score(100, 0, 50)

        self.assertEqual(score, 100)

    def test_less_then_1_perc(self):
        score = calulate_score(0, 100, 50)

        self.assertEqual(score, 1)

    def test_mutiple_scores(self):
        score1 = calulate_score(10, 1, 50)
        score2 = calulate_score(50, 2, 50)
        score3 = calulate_score(200, 70, 50)
        score4 = calulate_score(1500, 705, 50)
        score5 = calulate_score(1, 0, 50)
        score6 = calulate_score(3, 1, 50)

        self.assertEqual(score1, 57)
        self.assertEqual(score2, 92)
        self.assertEqual(score3, 76)
        self.assertEqual(score4, 60)
        self.assertEqual(score5, 51)
        self.assertEqual(score6, 50)

if __name__ == '__main__':
    unittest.main()