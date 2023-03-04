using Miningcore.Contracts;
using Miningcore.Native;

namespace Miningcore.Crypto.Hashing.Algorithms;

[Identifier("lyra2z")]
public unsafe class Lyra2Z : IHashAlgorithm
{
    public void Digest(ReadOnlySpan<byte> data, Span<byte> result, params object[] extra)
    {
        Contract.Requires<ArgumentException>(result.Length >= 32);

        fixed (byte* input = data)
        {
            fixed (byte* output = result)
            {
                Multihash.lyra2z(input, output, (uint) data.Length);
            }
        }
    }
}
