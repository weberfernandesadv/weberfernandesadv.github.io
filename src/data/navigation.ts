export interface NavItem {
  label: string;
  href: string;
}

export const headerMenu: NavItem[] = [
  { label: "Início", href: "/" },
  { label: "O Escritório", href: "/o-escritorio" },
  { label: "Nossa Equipe", href: "/nossa-equipe" },
  { label: "Áreas de Atuação", href: "/areas-de-atuacao" },
  { label: "Plataformas", href: "/plataformas" },
  { label: "Estudos & Artigos", href: "/forum-juridico" },
  { label: "Perguntas Frequentes", href: "/perguntas-frequentes" },
  { label: "Contato", href: "/contato" }
];

export const footerLinks: NavItem[] = [
  { label: "O Escritório", href: "/o-escritorio" },
  { label: "Nossa Equipe", href: "/nossa-equipe" },
  { label: "Áreas de Atuação", href: "/areas-de-atuacao" },
  { label: "Plataformas", href: "/plataformas" },
  { label: "Estudos & Artigos", href: "/forum-juridico" },
  { label: "Perguntas Frequentes", href: "/perguntas-frequentes" },
  { label: "Contato", href: "/contato" },
  { label: "Política de Privacidade", href: "/politica-de-privacidade" },
  { label: "Termos de Uso", href: "/termos-de-uso" }
];
