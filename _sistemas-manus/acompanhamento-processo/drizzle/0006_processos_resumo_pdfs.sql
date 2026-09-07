ALTER TABLE `processos`
  ADD `resumoProcessual` text,
  ADD `processoIntegralKey` text,
  ADD `processoIntegralUrl` text,
  ADD `processoIntegralNome` varchar(255),
  ADD `ultimaMovimentacaoKey` text,
  ADD `ultimaMovimentacaoUrl` text,
  ADD `ultimaMovimentacaoNome` varchar(255);
