using System;

namespace Tests
{
    using Utils;
    using Xunit;

    public class ReverseUtilTests
    {
        [Fact]
        public void Test1()
        {
            var input = "Dotnet-bot: Welcome to using .NET Core!";
            var expected = "!eroC TEN. gnisu ot emocleW :tob-tentoD";
            var actual = ReverseUtil.ReverseString(input);
            Assert.True(actual == expected, "The input string was not reversed correctly.");
        }
    }
}
