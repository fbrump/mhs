using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Project.MSH.Test
{
    public class PessoaFake
    {
        public PessoaFake() { this.name = new NameFake(); }
        public string gender { get; set; }
        public NameFake name { get; set; }
        public string email { get; set; }

    }

    public class NameFake
    {
        public string first { get; set; }
        public string last { get; set; }
    }
}
