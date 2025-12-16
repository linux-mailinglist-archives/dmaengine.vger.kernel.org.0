Return-Path: <dmaengine+bounces-7734-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC6CCC5764
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 00:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 65AD7300D3FA
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 23:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DE133D4E1;
	Tue, 16 Dec 2025 23:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="d/lEPSPA"
X-Original-To: dmaengine@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010061.outbound.protection.outlook.com [52.101.56.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FF423BCFD;
	Tue, 16 Dec 2025 23:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765927588; cv=fail; b=iDipcoMnxxvrAqEp1aszrSp8RdtIGpRE0K8b4HDp/MWp5a9BMkYw+tnBUNf6z/X9njG25KoLsiN4ofyLnxQx4EoK2rUrM3tX/JSXNh2xmcFPqqSCD+8Ibo17TFc1cskATfc/JadL2HZE8zbNJhpQ/IY40lsajOwqtjLdDREb8t8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765927588; c=relaxed/simple;
	bh=8a6MbTGQs8awvw1hkHBP7rWmi2kiafyv9Ijnyn3WU30=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Xc3WifBjnX7m25/E433xCOjMB83ybxOyvkI6zzKE0530b1ee3wpyDDhr7YvqEUCTUNOIKnaoGAbEhQS/7YOwq2Gh2wyAcwKcyxP8Ok01cHQag+xkrNP9IxjQoIWdgoBM1YhYRDKyO0j7UGdpXuI01PvcKlyz9o1+60zhZrnkzuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=d/lEPSPA; arc=fail smtp.client-ip=52.101.56.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kG4kmELej+rWXmKoC5ZgMTGACJB8dOUGcbctDc1yPLeq5hGnwJ1VnP+HozxQTYdab4X/ClAy1lTufqpfocTTXrnY0a0M0HiBETnZrrVjA+kyolefbcOMqHlchdpZTNdKUAPl82QQiHmgXJU/ZzEzoHTvpOErk/pThRi/OlFlXi1RM6vnftimMtZQgxPvgFTMiPFGtyEQAc9PXb413RNAe7Vg5FgW77y+tgUPkaI6YWZ/KPeJsQlG9ZPVw8sachdkeR6gfaZnv0gXiSOmzW4kZO4F7ix6w3+qU6dBeh/bof02d/pqnpbqYUCzh/dm+TTlNBbyZNJeG6OLowCYOVoi1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbEZt/Kbt8IRVzkO6dSflpSJ1GpeKgzdlRgFLw+VDs8=;
 b=i56T3l8A2hrq/ZHxYmZQbRuiy7QWDhfSIWNQ8SlP3gjZcTFCWEY0tkkX8g6WlezgbsQ5qGRzQ2gzQXqWS0MlQXHhTn68vShKubkT2L79tqxka24zZgBjUlXJtLMsej6CqjeI7oFxQeBaVILCRaQyTefQqAcKAwV5X6mSCc5OG4XoYVH7WbQe3K5UZuMPO+HE564xlzGHump1jpOJbMA9a/2napzSKtuiX+2S8WgeqGws3Qsz1gI9Z/She6+Jy6AvIh9B3OjKXKVj/sfqGQy4o37y3/CWGr8oKJ4K76BN5ou+dmYC56ZDrWO4p81WXXi1WSKRvz5QtOcIC9tCpwVSdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbEZt/Kbt8IRVzkO6dSflpSJ1GpeKgzdlRgFLw+VDs8=;
 b=d/lEPSPA1UhAUifbKtonOqi4pHef+Cu6L2RlKO2Rffl62Y2gV/8zFqUx+nKZ8cKazshDGvXNMxAoskgW6+AZB+XYy7BiROee5TmruQXCqxmBcftVKqxhUTSsxfIdN+ASf737/4GujPNliVzR+SXWNUcYi19xWhcTVKkEUdqdYDUkHn3eLPL0Zrv2Sjggwb8/5qOSJtGpoahpgGcq6hujEJUG4kFpCxzeg1S5HJp1P7j8KyrMXhDeqXexJ7UQ+q63KEHuLfLSBQdDH6oLkMBwH3SVeljhhVhh0pj7xuFKXAEJ3Dg+C3fU0iQoihgwQ22a6AIY0uK+klHZy8rxIpsT4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS4PR03MB8447.namprd03.prod.outlook.com (2603:10b6:8:322::12)
 by DS7PR03MB5637.namprd03.prod.outlook.com (2603:10b6:5:2ca::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 23:26:24 +0000
Received: from DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a]) by DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a%2]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 23:26:24 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v4 0/3] Add Agilex5 AXI DMA support
Date: Wed, 17 Dec 2025 07:26:15 +0800
Message-ID: <cover.1765845252.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0021.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::34) To DS4PR03MB8447.namprd03.prod.outlook.com
 (2603:10b6:8:322::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR03MB8447:EE_|DS7PR03MB5637:EE_
X-MS-Office365-Filtering-Correlation-Id: 61bf0a70-b011-4a54-b157-08de3cfa8756
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y4nalytMrMuMeoByH2mU+sgkY09VNsJRhRX7AFCW28TfmBWi3wp/AcPKt2uq?=
 =?us-ascii?Q?YM8H48i4qCoB7z14sjlTquVnsZfzYC5sZYet9zYELGs9YB6pLr6MP9i95Mx4?=
 =?us-ascii?Q?iJzYIjN9STjT1Gj6sfpvCZiYnISf0ivcH6sESJP7RzNe025U60Y1+L4e7x6f?=
 =?us-ascii?Q?DPa3oIADJpFPQhe53HK9kH1sO6aot94iwQjYWOuwwGSwjJsnuqHazaLfkEzs?=
 =?us-ascii?Q?OosUAXMntTuwcL79MP3+4pGPBpW1VLjRUTuk83TpUsGlaAuHWYS7aE8/3qg6?=
 =?us-ascii?Q?ib1EFZYG1+wTBFzDCy7j/aHDhwWP+zQ9FhKAmg2K7KDS7pODU26RLL68OOU6?=
 =?us-ascii?Q?VekiyoeHbcaA7qukjfvs0xIg/gPG8+RyKgMT1056Xf0YIF2OmYa/13nh9lS9?=
 =?us-ascii?Q?jh/WzM75FIFI46E9eUMAIX0XtsaIZPJhL6F0wRtYUC0JQxMGNBPySj51E3OI?=
 =?us-ascii?Q?2XSLHe/MTgiOD/eqkK98EZXWknsiegfJYk067cDT3xo9dIh7sryxnU7/e07I?=
 =?us-ascii?Q?sxb2jpWOAaLWw/zPtOJTc/bZa6zxh3sutH+fFcM16tp3nsRmnzIovXj3Qcwa?=
 =?us-ascii?Q?4zfGZW8vxk2LyePskGa0y89aDbnRN7Yci+ewQ9gcMhC7nkq/r6DAWns7t7kV?=
 =?us-ascii?Q?kvo/LFQBcKdkkJA+1VLoZR/QLXjh1x2A1/R59/0a7vDA8sNIQ8tIYfbnRZbF?=
 =?us-ascii?Q?LT+lOm4iakdtHuPAz/VbLN3I2LFkFqDOBuBBvXpywt2QfLx3SrXeTMGO4vsr?=
 =?us-ascii?Q?HZZ7AwZjLkJ8kMTQ7unzbMwALb81NpBUVxItKn77OuBVdQzGI2KJ3N8Bl2ww?=
 =?us-ascii?Q?7RGa00WGjCyupljqT01JuBwYizqSRc13ZkK+WaLrxWO7joUVE4FxKFoYBAyP?=
 =?us-ascii?Q?zPQMn+C0cokxTgBgW7NecZN7TJM8lkZePvEBhkOvO3JSeYpCcj8/2G3D25iX?=
 =?us-ascii?Q?n//9P+ix9xd0Jc+4AwzYeTiVctMBwrAA00cVis2hl/9Q5BbpSgXCPzLlqSSx?=
 =?us-ascii?Q?r5SvKLmAQT4TUHwLsgbblAn/FHxPG12aOSlUwKxv1XxPes4XnKVHI3i6dLjH?=
 =?us-ascii?Q?YWvtpgMgTxiXotoj1kHewo1+iBc7PQgSjBnBemFhuLFkmBngi4+1hLzCdiS1?=
 =?us-ascii?Q?syd3TqTpRFUpCy3ZGJeSu+zRBWR/eGnXme3L1zB8bmpk1gMh1WxjmEJ2bA1o?=
 =?us-ascii?Q?dUvwkrF4WE6Rmx4m+GeCEN0a8zOpALBeCz0aD+5IOLRjG3wf1sYmPAQLRheN?=
 =?us-ascii?Q?ELTcYsRmTUpwsJu9xuVzJkmSntkdjUDPww3bpHhZJp3w4PANd3d1pEVde225?=
 =?us-ascii?Q?FNMBJu2hRkGEsOyKVeIi4v6ZKOIo0cuOsoHRNRe/8wr2i1hLtYv0tsXVKdPd?=
 =?us-ascii?Q?0voiVv+JWWi22kSshqmph3YTxJN7Sabc6BDPSOguNNsSjqrMOdR6BsxnK8XK?=
 =?us-ascii?Q?K8yLevbjmP8aa59zOdNaYXE3XwjDJTLDHI7PTspPuuuz71T1ovKPd12Eudvc?=
 =?us-ascii?Q?W+5dL+dQA+VqSln1Tc2A3Kl7DJJeOinBbnH2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR03MB8447.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aIR7E8fSuN6xjL2j+dE9TrMuNPd73cYHBHuhvgTlcZxrb6QdlUyf0wckNK3T?=
 =?us-ascii?Q?1KNd2a2KIJ0rqoSbfNW7ucOL7zq+FxKHacE2THyYnii5b6XbdzzzLQlY6lOT?=
 =?us-ascii?Q?HcUh5SntYnKjNnqC3MrVafbECUACXk3AEZ8x509ojW8mH3RdJCOi+N71tvSx?=
 =?us-ascii?Q?X8SZmmolDytpezuDPfuHl/PW5xmMCSmrlpERSVekLirDo6Xb9EB6UdgjZzYe?=
 =?us-ascii?Q?oNy7nXEzRWfguwTJLdWsb8xqk/EvfOXr/gxeTZz39GqzTQJ84zqC32r2LXWT?=
 =?us-ascii?Q?hYQ5h56CirFxKKeKOqzB1/me+svORHv2iJ5ExV1Uwqt8ioUJwZXU9GxTlVx9?=
 =?us-ascii?Q?8YlNF1cVH0BPU34ltDslk08eMatb0WPrtbL2O3QOpWFa+hd28W7+L9gEuFzJ?=
 =?us-ascii?Q?b2Owsw51ABBc9SIwSTNieB5l09DVUQNKhw7+ljJtj386YIwmigWM+BDXl1n5?=
 =?us-ascii?Q?n529e36XB+A8ARsBarPUkIfNVWKTsRZosq4s+s2DIJykkI3t6D/etqfhP2Zq?=
 =?us-ascii?Q?Co+7fiHku1sgt6gdW/4IW6oCjp+Eep9sEVGQmV432ZRRToDQC6bjZSzgqsLO?=
 =?us-ascii?Q?glIZ63duezQletDp5+mlxZbXyVRH3KwOp+NoK9Uq8ktgapjHBNWQwcPsm7Pk?=
 =?us-ascii?Q?kkpbOy3+FlpU7guqheQ4Bp6quIdbp804Vo+8AuGWEJtxhySDtdQEqI27iCm/?=
 =?us-ascii?Q?3mBgJ0KT3IPhLesDk5zX0yH8TRoUoroRupU9mHFuHIhTPB3/HPIyeMvzBm3b?=
 =?us-ascii?Q?zXtzQ/WN0rudSEMsIfovs1qkPti1LMrR59qCLDJ29UKjWxCN26GTR4p7bIjk?=
 =?us-ascii?Q?3XBxVOpMvYBP4UWmhlu59oJz3b2UBV9bF3NhhMofaXgTIxqpyUmUKu8czH0P?=
 =?us-ascii?Q?ipu7mo51yGGXYNRnGMbhCCBM9leXjl6al9GepOFXCONMT8r2VkG2HrP892a6?=
 =?us-ascii?Q?KAftu3pfuOTJ8tR/+/SO4cPSY6ELd8dB1Nt8aQC6RdW5Uw2xL/HUoLWg1MBP?=
 =?us-ascii?Q?JOAAMhFiBkl65qKRBuK/Dt3gylnnNCscfac9iJitgYsjUHjGtsJhHVB72Nj9?=
 =?us-ascii?Q?zm9cpQtKasNjhwOvz4zJfgEqDNCCNs/w6WYkP4dxB7A20cQrMDqWYAihdWZH?=
 =?us-ascii?Q?8S6huaO+M+JIJl+Fhd/92IwFiBLLWC4k9kn5WN9tXBSkMder5+dycqqn6JOH?=
 =?us-ascii?Q?Gw/alFloDH+MmoYwT2YQ0jlpBm/2Al84nSeBhBpC6fE48uiY/XMA20gPZ9PO?=
 =?us-ascii?Q?ebpfDxSPQ32hxjPsW19GOu+Cf/oJaH7FZjsDNAvOgudx5XO/h4CP7R+LFMly?=
 =?us-ascii?Q?lFvHmxm+U4reAoTAJsk/uGMFoB/kh9G6Y6S6pb6bJq31cZVT924q6nAvSkWz?=
 =?us-ascii?Q?5vTLdAq6fba2+LdcenyvQLQzE1bj4E5Kl9LvrtDliABwx5CAm+ao6Ki60JMu?=
 =?us-ascii?Q?TS89/Lx6HtgzJOdFFpK+lpUNyeTCycBnsObC1RBfKVEdkgVriJijjPV76VDW?=
 =?us-ascii?Q?YF7oVPck7XO8pogs5kYzwJiqxdBcGMUQMmfT2IoHvUua03S3nnWmLP5FdA6J?=
 =?us-ascii?Q?C2njsjplUuUKKQsX+iJl5DqAzv5BT9ig8YDf9PmsapvghsWmSxmgSdZx9RHT?=
 =?us-ascii?Q?IkzfRuJUdfjkEEOQIuWlg36TPT7a92PlzkTwN+3Ni3WxWr4gPk5Sa6gel6lA?=
 =?us-ascii?Q?ir8vH+1rLJgx2mvLLaYxcEEFA4mYeydXFa+RLUJEJRqUb8ldfI7vRWdOq9gs?=
 =?us-ascii?Q?jxrfFECzLyxo0q7oiitq4d0g4WjHYXI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61bf0a70-b011-4a54-b157-08de3cfa8756
X-MS-Exchange-CrossTenant-AuthSource: DS4PR03MB8447.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 23:26:24.6185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K6FHbOTOmVc8nx3/IoCLDr32ddDD1+MQDZpABLU3J6MhJJNu2VlKW1Jax9abQRbuzDkdhiw+4dsw1Mb5yiSc/VILYl1qvEjc0AfrAZSsobk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5637

This series introduces support for Agilex5 SoC in the Synopsys DesignWare
AXI DMA binding and updates the device tree to use the platform-specific
compatible string.

The Agilex5 only has 40-bit DMA addressable bit instead of 64-bit. Hence,
this specific addition will enable driver to handle this limitation.

---
Notes:
This patch series is applied on socfpga maintainer's tree
https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git/log/?h=socfpga_dts_for_v6.20

Changes in v4:
	- Use common code to get dma ranges.
	- Simplify the code to only in hw_init that will set the bit mask.

Changes in v3:
	- simplify dma-ranges addition without description as per input
	  from Rob.
	- Add simple-bus to with address-cells, size-cells, dma-ranges
	  added under this bus-node.
	- Move dma controller device node under simple-bus node.
	- Rename "arm64: dts: intel: agilex5: Add dma-ranges, address and size
	  cells to dma node" to #2
	- Drop "dt-bindings: dma: snps,dw-axi-dmac: Add #address-cells and
	  #size-cells"
	- Refactor "dma: dw-axi-dmac: Add support for Agilex5 and dynamic bus
	  width" to align with dma controller node now under simple-bus node.

Changes in v2:
	- Add dma-ranges property.
	- Add address-cells and size-cells due to warning when dma-ranges
	  is define without address-cells and size-cells present. Also
	  prevent kernel panic if address-cells and size-cells are not
	  defined.
	- Add driver support to handle defined properties and set the DMA
	  BIT MASK according to value from DT.
	- Rename "arm64: dts: agilex5: Use platform-specific compatible for
          AXI DMA" to "arm64: dts: intel: agilex5: Add dma-ranges and
          address cells to dma node"

This changes is validated on:
	- intel/socfpga_agilex5_socdk.dtb
	- snps,dw-axi-dmac.yaml
	- snps,dw-axi-dmac.yaml intel/socfpga_agilex5_socdk.dtb
	- Agilex5 devkit
---
Khairul Anuar Romli (3):
  dt-bindings: dma: snps,dw-axi-dmac: Add compatible string for Agilex5
  arm64: dts: intel: agilex5: Add simple-bus node on top of dma
    controller node
  dma: dw-axi-dmac: Add support for Agilex5 and dynamic bus width

 .../bindings/dma/snps,dw-axi-dmac.yaml        | 14 ++--
 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 78 ++++++++++---------
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 16 +++-
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
 4 files changed, 68 insertions(+), 41 deletions(-)

-- 
2.43.7


