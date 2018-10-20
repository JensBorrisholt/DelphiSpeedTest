using System;
using System.Diagnostics;
using System.Threading.Tasks;

namespace BinomialTest
{
    class Program
    {
        public static int Binomial(int n, int k)
        {
            if (k > n)
                return 0;

            if (k == 0)
                return 1;

            if (k > n - k)
                k = n - k;

            var result = 1;
            var denominator = 0;

            while (denominator < k)
            {
                result = result * (n - denominator);
                denominator++;
                result = result / denominator;
            }

            return result;
        }
        
        static void Main(string[] args)
        {
            const int count = 2000;
            
            var stopwatch = Stopwatch.StartNew();
            for (var i = 1; i <= count; i++)
            for (var j = 1; j <= count; j++)
                Binomial(i, j);
            
            stopwatch.Stop();
            
            
            Console.WriteLine($"Binomial single thread: Elapsed time: {stopwatch.Elapsed.TotalSeconds:0.00} seconds");

            stopwatch = Stopwatch.StartNew();
            Parallel.For(1, count, i =>
            {
                for (var j = 1; j <= count; j++)
                    Binomial(i, j);
            });

            stopwatch.Stop();
            
            Console.WriteLine($"Binomial single thread: Elapsed time: {stopwatch.Elapsed.TotalSeconds:0.00} seconds");
            Console.ReadLine();
        }
    }
}
