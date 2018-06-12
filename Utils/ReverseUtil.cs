namespace Utils
{
    using System;

    public static class ReverseUtil
    {
        public static string ReverseString(string input)
        {
            var chars = input.ToCharArray();
            Array.Reverse(chars);
            var reversedString = new string(chars);
            return reversedString;
        }
    }
}