export interface AreaOfPractice {
  slug: string;
  title: string;
  seoTitle: string;
  seoDescription: string;
  summary: string;
  icon: string; // Icon key
  description: string;
  topics: string[];
  caveat?: string; // H4/observacao
}

export const areasOfPractice: AreaOfPractice[] = [
  {
    slug: "direito-imobiliario",
    title: "Direito Imobiliário",
    seoTitle: "Direito Imobiliário em Goiânia | Regularização e Contratos Imobiliários",
    seoDescription: "Consultoria e assessoria em Direito Imobiliário. Regularização de imóveis, usucapião, análise de riscos em transações e contratos imobiliários em Goiânia/GO.",
    summary: "Segurança jurídica e orientação estratégica em transações, contratos e regularização de bens imóveis urbanos e rurais.",
    icon: "home",
    description: "O Direito Imobiliário envolve a regulação jurídica da propriedade de bens imóveis, bem como os direitos e obrigações a eles relacionados. Nosso trabalho atua de forma preventiva e estratégica, buscando mitigar riscos e formalizar negócios com solidez legal.",
    topics: [
      "Regularização de Imóveis Urbanos e Rurais",
      "Assessoria em Compra, Venda e Doação de Bens",
      "Processos de Usucapião (Judicial e Extrajudicial)",
      "Redação e Análise de Contratos de Locação",
      "Resolução de Conflitos Possessórios e Vizinhança"
    ],
    caveat: "Nota: A regularização de imóveis previne passivos futuros e garante a titularidade legítima perante o registro de imóveis competente."
  },
  {
    slug: "direito-administrativo-pad",
    title: "Direito Administrativo / PAD",
    seoTitle: "Direito Administrativo e PAD | Defesa de Servidores Públicos",
    seoDescription: "Assessoria em Processo Administrativo Disciplinar (PAD). Defesa de servidores públicos federais, estaduais e municipais.",
    summary: "Defesa e representação em Processos Administrativos Disciplinares (PAD), licitações, concursos públicos e sindicâncias.",
    icon: "shield",
    description: "A atuação no Direito Administrativo envolve o acompanhamento rigoroso perante órgãos e autarquias públicas. Nossa atuação foca na garantia da ampla defesa e do contraditório de servidores públicos submetidos a investigações disciplinares.",
    topics: [
      "Defesa em Processo Administrativo Disciplinar (PAD)",
      "Acompanhamento em Sindicâncias e Inquéritos Administrativos",
      "Assessoria Jurídica em Editais de Concursos Públicos",
      "Representação em Licitações e Contratos Administrativos",
      "Recursos Administrativos perante Órgãos Públicos"
    ],
    caveat: "Nota: O acompanhamento preventivo no PAD garante a observância dos princípios constitucionais da legalidade, moralidade e devido processo legal."
  },
  {
    slug: "direito-previdenciario",
    title: "Direito Previdenciário",
    seoTitle: "Direito Previdenciário | Planejamento de Aposentadoria",
    seoDescription: "Assessoria jurídica previdenciária. Planejamento previdenciário, requerimento de benefícios (aposentadorias, pensões, BPC) e recursos ao INSS.",
    summary: "Análise técnica de tempo de contribuição, planejamento e requerimento administrativo de aposentadorias e benefícios.",
    icon: "heart",
    description: "O Direito Previdenciário assegura a proteção social aos segurados e seus dependentes. O escritório presta suporte na análise e instrução documental detalhada para requerimentos perante a autarquia previdenciária.",
    topics: [
      "Planejamento Previdenciário e Cálculo de Tempo de Contribuição",
      "Requerimento de Aposentadorias (Idade, Tempo de Contribuição, Especial)",
      "Concessão e Revisão de Benefício de Prestação Continuada (BPC/LOAS)",
      "Auxílio-Doença, Auxílio-Accidente e Pensão por Morte",
      "Recursos Administrativos contra Indeferimentos do INSS"
    ],
    caveat: "Nota: O planejamento previdenciário visa indicar os melhores caminhos com base no histórico de contribuição do segurado."
  },
  {
    slug: "direito-trabalhista",
    title: "Direito Trabalhista",
    seoTitle: "Direito do Trabalho | Assessoria em Relações de Emprego",
    seoDescription: "Orientação jurídica em Direito Trabalhista. Defesas patronais, análise preventiva de contratos de trabalho e orientação técnica de direitos do trabalhador.",
    summary: "Suporte na conformidade trabalhista, prevenção de passivos e defesa técnica em dissídios e reclamações trabalhistas.",
    icon: "briefcase",
    description: "O Direito Trabalhista atua na regulação das relações laborais, visando o equilíbrio e a legalidade nas obrigações entre empregadores e empregados. Nossa atuação se baseia na prevenção e na instrução detalhada de litígios.",
    topics: [
      "Consultoria Preventiva em Legislação Trabalhista e Recursos Humanos",
      "Defesa e Representação em Reclamações Trabalhistas",
      "Análise de Contratos de Trabalho e Verbas Rescisórias",
      "Assessoria em Negociações Coletivas e Acordos",
      "Orientação sobre Saúde, Segurança e Higiene do Trabalho"
    ],
    caveat: "Nota: A conformidade com as normas trabalhistas mitiga riscos corporativos e assegura um ambiente de trabalho equilibrado."
  },
  {
    slug: "direito-civel",
    title: "Direito Cível",
    seoTitle: "Direito Civil e Contencioso Cível | Goiânia",
    seoDescription: "Atuação em Direito Civil. Cobranças, responsabilidade civil, indenizações, propriedade e relações contratuais em Goiânia/GO.",
    summary: "Resolução de conflitos de natureza civil, responsabilidade civil, posse, obrigações e assessoria jurídica em geral.",
    icon: "scale",
    description: "O Direito Civil é o ramo mais amplo do ordenamento jurídico privado, regendo as relações do cotidiano das pessoas físicas e jurídicas. Buscamos soluções que priorizem a conciliação, sem descuidar da defesa firme em juízo.",
    topics: [
      "Ações de Responsabilidade Civil e Reparação de Danos",
      "Cobranças, Execuções de Títulos e Recuperação de Crédito",
      "Proteção de Direitos da Personalidade e Privacidade",
      "Resolução de Disputas Contratuais e Obrigacionais",
      "Ações Possessórias e de Defesa da Propriedade"
    ],
    caveat: "Nota: O Direito Civil prioriza a resolução pacífica e autônoma de conflitos, recorrendo ao judiciário quando estritamente necessário."
  },
  {
    slug: "direito-de-familia",
    title: "Direito de Família",
    seoTitle: "Direito de Família | Divórcio, Pensão e Guarda",
    seoDescription: "Assessoria sensível e técnica em Direito de Família. Divórcio consensual e litigioso, pensão alimentícia, guarda e convivência em Goiânia.",
    summary: "Resolução de questões familiares com sensibilidade e respeito, incluindo divórcios, guarda, visitas e alimentos.",
    icon: "users",
    description: "As relações familiares demandam tratamento individualizado, confidencialidade e acolhimento humanizado. Nossa assessoria atua na mediação de acordos e no acompanhamento processual para preservar o bem-estar dos envolvidos.",
    topics: [
      "Divórcio Consensual e Litigioso (Judicial e Extrajudicial em Cartório)",
      "Definição, Revisão e Execução de Pensão Alimentícia",
      "Ações de Guarda Compartilhada e Regime de Convivência Familiar",
      "Reconhecimento e Dissolução de União Estável",
      "Processos de Investigação de Paternidade"
    ],
    caveat: "Nota: Os procedimentos extrajudiciais em cartório oferecem celeridade e menor desgaste emocional para as partes quando há consenso."
  },
  {
    slug: "sucessoes-inventario",
    title: "Sucessões e Inventário",
    seoTitle: "Sucessões e Inventário | Planejamento Sucessório e Partilha",
    seoDescription: "Assessoria em inventários judiciais e extrajudiciais, testamentos, doações e planejamento sucessório estratégico em Goiânia/GO.",
    summary: "Inventários extrajudiciais em cartório, inventários judiciais, partilha de bens, testamentos e planejamento patrimonial.",
    icon: "folder-open",
    description: "A transferência patrimonial decorrente do falecimento requer rigor técnico e organização de ativos. Oferecemos suporte legal para viabilizar a partilha de bens de forma ágil, priorizando o entendimento harmonioso dos herdeiros.",
    topics: [
      "Processamento de Inventário Extrajudicial (em Cartório)",
      "Acompanhamento de Inventário Judicial e Partilha de Bens",
      "Elaboração, Registro e Cumprimento de Testamentos",
      "Assessoria em Doações de Bens com Reserva de Usufruto",
      "Estruturação de Planejamento Sucessório Familiar"
    ],
    caveat: "Nota: A realização do inventário dentro do prazo legal evita multas sobre o Imposto de Transmissão Causa Mortis (ITCMD)."
  },
  {
    slug: "contratos",
    title: "Contratos",
    seoTitle: "Elaboração e Análise de Contratos Civis e Comerciais",
    seoDescription: "Assessoria contratual dedicada. Elaboração, revisão técnica e análise de riscos em contratos de prestação de serviços, parcerias e negócios.",
    summary: "Segurança na elaboração, revisão, rescisão e análise de riscos em contratos comerciais, cíveis e de prestação de serviços.",
    icon: "file-text",
    description: "Os contratos constituem o principal instrumento de prevenção de disputas nas relações jurídicas e comerciais. Nossa equipe elabora cláusulas personalizadas focadas no equilíbrio de obrigações e clareza de deveres.",
    topics: [
      "Elaboração de Contratos de Prestação de Serviços e Parcerias",
      "Revisão Técnica de Contratos de Adesão e Cláusulas Abusivas",
      "Distratos, Rescisões Contratuais e Notificações Extrajudiciais",
      "Contratos de Compra e Venda de Ativos e Bens Móveis",
      "Assessoria Jurídica na Pactuação de Instrumentos Particulares"
    ],
    caveat: "Nota: A assessoria prévia na elaboração contratual reduz significativamente a prevenção de litígios judiciais futuros."
  },
  {
    slug: "direito-do-consumidor",
    title: "Direito do Consumidor",
    seoTitle: "Direito do Consumidor | Relações de Consumo e Defesas",
    seoDescription: "Assessoria e consultoria jurídica em relações de consumo. Atuação em práticas abusivas, cobranças indevidas e vícios de produtos.",
    summary: "Defesa dos direitos previstos no CDC contra práticas comerciais abusivas, vícios em produtos e falhas na prestação de serviços.",
    icon: "shopping-bag",
    description: "O Código de Defesa do Consumidor (CDC) disciplina as relações entre consumidores e fornecedores de produtos ou serviços. Atuamos na mediação de conflitos de consumo e na defesa técnica em casos de desconformidade comercial.",
    topics: [
      "Representação em Reclamações de Práticas Comerciais Abusivas",
      "Assessoria em Vícios e Defeitos de Produtos ou Serviços",
      "Defesa de Direitos Contra Cobranças Indevidas e Negativações",
      "Ações Indenizatórias por Falhas Graves de Fornecimento",
      "Orientação Preventiva para Empresas Adequarem seus Serviços ao CDC"
    ],
    caveat: "Nota: O registro nos órgãos de proteção ao consumidor constitui etapa preliminar relevante na resolução administrativa de conflitos."
  },
  {
    slug: "direito-criminal",
    title: "Direito Criminal",
    seoTitle: "Defesa Criminal e Acompanhamento de Inquéritos",
    seoDescription: "Defesa criminal técnica e acompanhamento de inquéritos. Defesa em juízo, audiências de custódia e assessoria jurídica em Direito Penal.",
    summary: "Representação jurídica em inquéritos policiais, audiências de custódia e atos processuais na Justiça Penal.",
    icon: "gavel",
    description: "A atuação criminal exige pleno respeito às garantias individuais e ao devido processo legal estabelecidos pela Constituição. Prestamos assistência técnica em inquéritos, investigações e no âmbito processual penal.",
    topics: [
      "Acompanhamento em Delegacias e Inquéritos Policiais",
      "Defesa Técnica em Ações Penais e Processos Criminais",
      "Representação e Assistência em Audiências de Custódia",
      "Interposição de Recursos nos Tribunais de Justiça e Federais",
      "Assessoria em Compliance Penal e Crimes de Menor Potencial"
    ],
    caveat: "Nota: O acompanhamento jurídico imediato em atos de investigação policial é fundamental para a preservação das garantias constitucionais."
  },
  {
    slug: "direito-internacional",
    title: "Direito Internacional",
    seoTitle: "Direito Internacional | Assessoria Jurídica Transfronteiriça",
    seoDescription: "Assessoria em Direito Internacional. Homologação de sentenças estrangeiras, contratos internacionais e nacionalidade.",
    summary: "Suporte jurídico em contratos de exportação/importação, homologação de sentenças estrangeiras e nacionalidade.",
    icon: "globe",
    description: "O Direito Internacional disciplina as relações jurídicas com elementos estrangeiros, sejam pessoas físicas ou jurídicas. Atuamos na orientação de formalidades exigidas pelas convenções internacionais e pelo ordenamento pátrio.",
    topics: [
      "Homologação de Sentenças Estrangeiras perante o STJ",
      "Assessoria em Processos de Obtenção de Nacionalidade e Vistos",
      "Análise e Redação de Contratos de Comércio Internacional",
      "Representação em Matéria de Alimentos e Guarda Transfronteiriça",
      "Orientação sobre Tratados e Convenções Internacionais Aplicáveis"
    ],
    caveat: "Nota: A validação de atos jurídicos praticados no exterior requer o trâmite de consularização ou apostilamento, conforme o país de origem."
  },
  {
    slug: "recursos-tribunais-superiores",
    title: "Recursos aos Tribunais Superiores",
    seoTitle: "Recursos aos Tribunais Superiores | STJ e STF",
    seoDescription: "Assessoria jurídica na elaboração e interposição de recursos perante o STJ e STF. Sustentação oral e pareceres.",
    summary: "Elaboração técnica e sustentação de Recursos Especiais (STJ), Extraordinários (STF) e Habeas Corpus nos tribunais superiores.",
    icon: "award",
    description: "A atuação perante os Tribunais Superiores (STJ e STF) em Brasília exige conhecimento específico de requisitos formais estritos de admissibilidade recursal. Oferecemos assessoria qualificada para análise e elaboração de recursos constitucionais.",
    topics: [
      "Elaboração de Recurso Especial (REsp) direcionado ao STJ",
      "Elaboração de Recurso Extraordinário (RE) direcionado ao STF",
      "Apresentação de Memoriais e Realização de Sustentações Orais",
      "Impetração de Mandados de Segurança e Habeas Corpus nos Tribunais",
      "Análise de Admissibilidade de Recursos com base em Súmulas"
    ],
    caveat: "Nota: Os recursos aos tribunais superiores possuem filtros rígidos de admissibilidade e visam uniformizar a jurisprudência nacional."
  }
];
