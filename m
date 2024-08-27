Return-Path: <dmaengine+bounces-2972-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0034B960255
	for <lists+dmaengine@lfdr.de>; Tue, 27 Aug 2024 08:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75DC31F22C71
	for <lists+dmaengine@lfdr.de>; Tue, 27 Aug 2024 06:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D87A156257;
	Tue, 27 Aug 2024 06:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="RsgIvlvg"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2057.outbound.protection.outlook.com [40.92.22.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DDB155C8A;
	Tue, 27 Aug 2024 06:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724741459; cv=fail; b=uKOAJY8ZYKl3VAcE1wQxOCrNiJ5buyrGvB7mCqlWCqcTgfDV82WaAsl7vnBAVMxKJPwzaIFyCHtuJipBAiCOVPp2FOaYACc8OC9gKFW2zSdqMAI22UW4IcLfA6Rl4o1uApxOmM6drLh2vIw/NgFr3Kafu7zwzY49TDVFzs/K0bA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724741459; c=relaxed/simple;
	bh=+hlaiptQoJAH7K+yVUT5Ebxj5kZ6hrnsYxj0E0TEiyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BgmebKhgYhnWtd5fV8LNMeNEHhkTsQ+RzAIRRVL6vk91PLya6Cc+L7AGl1ubEuLCB55ix76XvS8e1fICwT+AC/7tglV4mDuvmc03l7HaL01kOXht0bbr3Lzomd3WqI8GkDGTSvxKMmjIcyoqH3fM18HQGCW2iJeKXrFcCZ/jORI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=RsgIvlvg; arc=fail smtp.client-ip=40.92.22.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXBxcAkv4UOf8GkCCl8gM1Klg4GPWQa/sgUNeunRRpe3jLJgNcpFzTIz50KL0kBsdq1IpyOOc3QOpw0nBWf5c+BtcCJGL3SAJSv/2YVfiJYRXkSi/SM+szlTZfGq/Sgxrb+COTsIJx6LNdRhjaiDeIFBHE2k8Ssd0IVcMR2S/qzIBcfb2HyE1JHMW/w1PKIiDH61CBO8IMoVGSjlEoHf4ZneB7fSQk0a6BSohcwqteUN40KxT7+ANCyi2yS7K5e8lbaaoGcyrJk5mppYOza4Sr5S4JXguWizhqw/K/1DeVxBi3I5sZDvnCmRQqHTEp23FaIYM4jpV7l8knRVktvSOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/IRMbb/LeGWQ8Kidyr4zLAZYYjxnnMIE+RxmkPhF8Y=;
 b=h6Mo6ge8tVTPLk/u+ICfMBi7z+ACwBeCy4qC4d2tbCs/Da7FUxePZJAUOvJZo7A/kzKiTTArA83h2I46Ij8Jqqv6jD9VTZ2KBrbQUmSkpaWUFqFdcMsPoeKsN6nikHVPt5GslDB6MAo/kG152wd1DTp+2PWTQigQMWeTx3oGab5ucyhXjPKhOlQA9VV3ZWbh8XpVA1ZO8Ym2YVd6fh94sYBtseiYpIgIwIL4e1dHiaM/fcA5X3YsjOkON3NpuFt5EHJY2BXS+2ccnv8Mwxy5i18dJEN4ND6N5V7sHCdrqAJCVhkF2vtziXt8GyUB76L6be87KGVQwDhtvc32ZHi83A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/IRMbb/LeGWQ8Kidyr4zLAZYYjxnnMIE+RxmkPhF8Y=;
 b=RsgIvlvgsr0Ast08qLW6YUnKwpcY0wKhnjCFec2MUx3CaJlBKT1V6xngvHHQUECla1nwSNmSqujQ/Zp2i0qMovf+VdMoQQJftQ15rxxUbwo55OCoqLg1OkJ+hFWUKKqYgh3ZeHkXLYCOeSmgU7kGU+M6tpDlhVf+PLqa4CEAkdyFuNSIMRu/rDU3JxbSEYok6HaXQWMKT18tOXHmNcY3cbqfOpuu2PCCz2DyXAhUN1Q/jeV+ND6lxzfjAjyB4kxyRVHdHyFN8bjOeub1uwHMLjHTE1TXN2nd4BQ6I1zu4JN5dF+OqpVjOcSyGgYJ/WQR7ieq5Htco/8fb0VxeuUJvQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DM3PR20MB6939.namprd20.prod.outlook.com (2603:10b6:0:42::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 06:50:55 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 06:50:55 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v12 3/3] dmaengine: add driver for Sophgo CV18XX/SG200X dmamux
Date: Tue, 27 Aug 2024 14:49:43 +0800
Message-ID:
 <IA1PR20MB4953D9A62A26337E7EBC73DCBB942@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <IA1PR20MB495396729244074C36E51E11BB942@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB495396729244074C36E51E11BB942@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [2Bs68YJ9M9aZ+1w7lTMK74wJ6OVbNDrVA2HA4sBRTRU=]
X-ClientProxiedBy: SG2PR02CA0123.apcprd02.prod.outlook.com
 (2603:1096:4:188::22) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240827064944.740024-3-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DM3PR20MB6939:EE_
X-MS-Office365-Filtering-Correlation-Id: 9283d008-89d1-4c12-a962-08dcc6649932
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|5072599009|19110799003|8060799006|461199028|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	uCc23bp/Bw0wOydirwlvJhGOF7EEBjcn1OnyvygZRqb6u8JWfqC+CUMvBfShNEoSXgWo3ARBtK31m7mP6c+4/coAReDYEnSu/ztBO874EATrRFSXcTI5DyZI4VyFKVfi4cne6Jljt60m4vJRfoBS2ZN+cP6fqEfON8/kw4QKoWgApU9s7iosGcUP729LrU33mVwQx6c00yhTAXf91HcQClSjDmPMDW/EqeDhErgwNMU3Mh/dgsvLBnS4UciL9ONvfGqo81Emx9ywW9hhjCzd3Tt5cWh9rmRU16r77RmiS7IgMVf1BkDXAsOXVrR5fAT43QtN08FEoQC7oy9XcvU/kqfVW95BAySxHL1hRg7f1XYujeMrlW8i/0p91cEv5a+rHbXuv5F7YYZgDDGKsNHIwBeqoY6+Locpop6KQKZeY6vjF5kvEPcBq00gEys8SMfOdnpqxaLV3vK5XeIIhmt1hvMkSOM34oRKoFXyFKlMul9Gp6PaTBcssn72AvBalGmlI6w9TfKRzE4GJdrq+EKXUCelj2/Urv+GnE4QEbvJdYHCXDnvPffXvkXq0HyCnqJl38+/K3kbWNVy/3Q8TL6b5TcMOe3Mt7OmBUxR63kXYZ2epnX9KIZKCdthGFpzFF0FG/1y4wISccDWzfiprrfoOhYF4MNyxC6oQnTSHHN0XNZVaHMVvsmjw73hQMUir/oh2qWbjOr3x/MlbV4P6pyZVTC4qhXABsnYCxQZ7mR+AQE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xklxER9MKEywwutdH9ckDzyK1Tepb/ybXeTh1yyT+Ey/kpL8xqNvT9awZeRe?=
 =?us-ascii?Q?5MQcLKmwitVf3dSpbSOrM2tqYiskpQ7oeUl0G9PU29gPkJiAGobW9Yd7SlAW?=
 =?us-ascii?Q?e54d4+mWAdTPPnpvfSSrkcIbiZniUuVGShecexlqVavFV/i0i+LmaUYd0h/V?=
 =?us-ascii?Q?t54MXFaySnePX+M2BbBUoDFzs9evnhC5jCf21uTROeDERaVm+xJF+08k5RHj?=
 =?us-ascii?Q?KIuaajOveL1QKemKhjqxxkIvy+cC2VmkOMUCtwN5XNwvJe+qrNK7C+kBNDSJ?=
 =?us-ascii?Q?cvl+AjhB31HuzXWShtdJoPxHwCXFoKn33CPAUUeJH7BYJ+UN4gybvuSmRW/s?=
 =?us-ascii?Q?GB9EOiI4BQk0YRBh7xqvyjKut8NpNmZwHnOlG/9qDutYvfrqlxEgOGsfnqcp?=
 =?us-ascii?Q?YSyjJ3saC28x6xLpzFiiPeKQHqNNLAQ10Fl4YT0yr33SpiPnOdTYs+W0wYPC?=
 =?us-ascii?Q?fMdK6/yMQy/wVpLhRI8IoOJQkIrCu5ytv9TyrTvQmm2z6do4E/U0i0DHr7AX?=
 =?us-ascii?Q?ELp9i2B1t1jKPPTchJTBJWWAyaFnOrath/SawHDKdhvFHsnoFHQTzBVoUatf?=
 =?us-ascii?Q?JBmW1+Igo3qRT52mB2NK8SqDQ0bSSA9Z7xPhNlWCAU2jXVtnQIC+nAd4Wff4?=
 =?us-ascii?Q?aNEszf/HgjaFRsRKDchp9nyfCAB2CT/qn6mjLKiD7u3kjlDw/CYkQaJZiHLt?=
 =?us-ascii?Q?xiKNhZKqwmb6wco8tXTiK4cFHt1A5oiGfne8ht/BAtgTZq8AP2FdYo4N8pki?=
 =?us-ascii?Q?NrQNmkXwj9bY/2sFr3NRd/C2ReHDCa2tWT2RByVCaFT/7s8DwkbvseTKlED3?=
 =?us-ascii?Q?F6m04SDR7fOMFBKVxtjYKLuT79qLdHOXcwVyVwCuSuaTEhP+DW/K6xAU8VPP?=
 =?us-ascii?Q?UTnkRg0s8az62NQC4WHHtNb6vkebBP9gjr66wZirEqfFhVlqnw8sezyyILGd?=
 =?us-ascii?Q?vARO6T453eEAk78SKNdFTK2s46FaslI0jT5JP2EiSqSPNrqxQVwdaSsVs+Cg?=
 =?us-ascii?Q?d5F4kSTpko7KDPiqjeTXqUPF3hOzFhKLRmsfy3xToZ/jr9bMYt61mnRtDoUg?=
 =?us-ascii?Q?gYnr8M1L1cnls9GkE50m9F/2tKpSIwRUrheb+Hm0Lj6mgf+2PmbyJyjYH0lJ?=
 =?us-ascii?Q?X/IUzeOjGBE+WjA4JwWvF0ICzeV0dQQQIU/oakIBEc+e52nltdrrr0RJ7CXg?=
 =?us-ascii?Q?4b815tsB3hcQEibq2bDd7e1GTav8NRpX2v4SwvHkRYZ5o2iU3bLQI0q9je/d?=
 =?us-ascii?Q?3ZIEWLmf0HOnMXfFcbvI?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9283d008-89d1-4c12-a962-08dcc6649932
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 06:50:55.2641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR20MB6939

Sophgo CV18XX/SG200X use DW AXI CORE with a multiplexer for remapping
its request lines. The multiplexer supports at most 8 request lines.

Add driver for Sophgo CV18XX/SG200X DMA multiplexer.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 drivers/dma/Kconfig         |   9 ++
 drivers/dma/Makefile        |   1 +
 drivers/dma/cv1800-dmamux.c | 257 ++++++++++++++++++++++++++++++++++++
 3 files changed, 267 insertions(+)
 create mode 100644 drivers/dma/cv1800-dmamux.c

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index cc0a62c34861..df010ee1de46 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -546,6 +546,15 @@ config PLX_DMA
 	  These are exposed via extra functions on the switch's
 	  upstream port. Each function exposes one DMA channel.
 
+config SOPHGO_CV1800_DMAMUX
+	tristate "Sophgo CV1800/SG2000 series SoC DMA multiplexer support"
+	depends on MFD_SYSCON
+	depends on ARCH_SOPHGO
+	help
+	  Support for the DMA multiplexer on Sophgo CV1800/SG2000
+	  series SoCs.
+	  Say Y here if your board have this soc.
+
 config STE_DMA40
 	bool "ST-Ericsson DMA40 support"
 	depends on ARCH_U8500
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 374ea98faf43..60d05b305082 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_PPC_BESTCOMM) += bestcomm/
 obj-$(CONFIG_PXA_DMA) += pxa_dma.o
 obj-$(CONFIG_RENESAS_DMA) += sh/
 obj-$(CONFIG_SF_PDMA) += sf-pdma/
+obj-$(CONFIG_SOPHGO_CV1800_DMAMUX) += cv1800-dmamux.o
 obj-$(CONFIG_STE_DMA40) += ste_dma40.o ste_dma40_ll.o
 obj-$(CONFIG_SPRD_DMA) += sprd-dma.o
 obj-$(CONFIG_TXX9_DMAC) += txx9dmac.o
diff --git a/drivers/dma/cv1800-dmamux.c b/drivers/dma/cv1800-dmamux.c
new file mode 100644
index 000000000000..a907c72325c7
--- /dev/null
+++ b/drivers/dma/cv1800-dmamux.c
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Inochi Amaoto <inochiama@outlook.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/cleanup.h>
+#include <linux/module.h>
+#include <linux/of_dma.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/llist.h>
+#include <linux/regmap.h>
+#include <linux/spinlock.h>
+#include <linux/mfd/syscon.h>
+
+#include <soc/sophgo/cv1800-sysctl.h>
+
+#define DMAMUX_NCELLS			2
+#define MAX_DMA_MAPPING_ID		42
+#define MAX_DMA_CPU_ID			2
+#define MAX_DMA_CH_ID			7
+
+#define DMAMUX_INTMUX_REGISTER_LEN	4
+#define DMAMUX_NR_CH_PER_REGISTER	4
+#define DMAMUX_BIT_PER_CH		8
+#define DMAMUX_CH_MASk			GENMASK(5, 0)
+#define DMAMUX_INT_BIT_PER_CPU		10
+#define DMAMUX_CH_UPDATE_BIT		BIT(31)
+
+#define DMAMUX_CH_REGPOS(chid) \
+	((chid) / DMAMUX_NR_CH_PER_REGISTER)
+#define DMAMUX_CH_REGOFF(chid) \
+	((chid) % DMAMUX_NR_CH_PER_REGISTER)
+#define DMAMUX_CH_REG(chid) \
+	((DMAMUX_CH_REGPOS(chid) * sizeof(u32)) + \
+	 CV1800_SDMA_DMA_CHANNEL_REMAP0)
+#define DMAMUX_CH_SET(chid, val) \
+	(((val) << (DMAMUX_CH_REGOFF(chid) * DMAMUX_BIT_PER_CH)) | \
+	 DMAMUX_CH_UPDATE_BIT)
+#define DMAMUX_CH_MASK(chid) \
+	DMAMUX_CH_SET(chid, DMAMUX_CH_MASk)
+
+#define DMAMUX_INT_BIT(chid, cpuid) \
+	BIT((cpuid) * DMAMUX_INT_BIT_PER_CPU + (chid))
+#define DMAMUX_INTEN_BIT(cpuid) \
+	DMAMUX_INT_BIT(8, cpuid)
+#define DMAMUX_INT_CH_BIT(chid, cpuid) \
+	(DMAMUX_INT_BIT(chid, cpuid) | DMAMUX_INTEN_BIT(cpuid))
+#define DMAMUX_INT_MASK(chid) \
+	(DMAMUX_INT_BIT(chid, 0) | \
+	 DMAMUX_INT_BIT(chid, 1) | \
+	 DMAMUX_INT_BIT(chid, 2))
+#define DMAMUX_INT_CH_MASK(chid, cpuid) \
+	(DMAMUX_INT_MASK(chid) | DMAMUX_INTEN_BIT(cpuid))
+
+struct cv1800_dmamux_data {
+	struct dma_router	dmarouter;
+	struct regmap		*regmap;
+	spinlock_t		lock;
+	struct llist_head	free_maps;
+	struct llist_head	reserve_maps;
+	DECLARE_BITMAP(mapped_peripherals, MAX_DMA_MAPPING_ID);
+};
+
+struct cv1800_dmamux_map {
+	struct llist_node node;
+	unsigned int channel;
+	unsigned int peripheral;
+	unsigned int cpu;
+};
+
+static void cv1800_dmamux_free(struct device *dev, void *route_data)
+{
+	struct cv1800_dmamux_data *dmamux = dev_get_drvdata(dev);
+	struct cv1800_dmamux_map *map = route_data;
+
+	guard(spinlock_irqsave)(&dmamux->lock);
+
+	regmap_update_bits(dmamux->regmap,
+			   DMAMUX_CH_REG(map->channel),
+			   DMAMUX_CH_MASK(map->channel),
+			   DMAMUX_CH_UPDATE_BIT);
+
+	regmap_update_bits(dmamux->regmap, CV1800_SDMA_DMA_INT_MUX,
+			   DMAMUX_INT_CH_MASK(map->channel, map->cpu),
+			   DMAMUX_INTEN_BIT(map->cpu));
+
+	dev_dbg(dev, "free channel %u for req %u (cpu %u)\n",
+		map->channel, map->peripheral, map->cpu);
+}
+
+static void *cv1800_dmamux_route_allocate(struct of_phandle_args *dma_spec,
+					  struct of_dma *ofdma)
+{
+	struct platform_device *pdev = of_find_device_by_node(ofdma->of_node);
+	struct cv1800_dmamux_data *dmamux = platform_get_drvdata(pdev);
+	struct cv1800_dmamux_map *map;
+	struct llist_node *node;
+	unsigned long flags;
+	unsigned int chid, devid, cpuid;
+	int ret;
+
+	if (dma_spec->args_count != DMAMUX_NCELLS) {
+		dev_err(&pdev->dev, "invalid number of dma mux args\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	devid = dma_spec->args[0];
+	cpuid = dma_spec->args[1];
+	dma_spec->args_count = 1;
+
+	if (devid > MAX_DMA_MAPPING_ID) {
+		dev_err(&pdev->dev, "invalid device id: %u\n", devid);
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (cpuid > MAX_DMA_CPU_ID) {
+		dev_err(&pdev->dev, "invalid cpu id: %u\n", cpuid);
+		return ERR_PTR(-EINVAL);
+	}
+
+	dma_spec->np = of_parse_phandle(ofdma->of_node, "dma-masters", 0);
+	if (!dma_spec->np) {
+		dev_err(&pdev->dev, "can't get dma master\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	spin_lock_irqsave(&dmamux->lock, flags);
+
+	if (test_bit(devid, dmamux->mapped_peripherals)) {
+		llist_for_each_entry(map, dmamux->reserve_maps.first, node) {
+			if (map->peripheral == devid && map->cpu == cpuid)
+				goto found;
+		}
+
+		ret = -EINVAL;
+		goto failed;
+	} else {
+		node = llist_del_first(&dmamux->free_maps);
+		if (!node) {
+			ret = -ENODEV;
+			goto failed;
+		}
+
+		map = llist_entry(node, struct cv1800_dmamux_map, node);
+		llist_add(&map->node, &dmamux->reserve_maps);
+		set_bit(devid, dmamux->mapped_peripherals);
+	}
+
+found:
+	chid = map->channel;
+	map->peripheral = devid;
+	map->cpu = cpuid;
+
+	regmap_set_bits(dmamux->regmap,
+			DMAMUX_CH_REG(chid),
+			DMAMUX_CH_SET(chid, devid));
+
+	regmap_update_bits(dmamux->regmap, CV1800_SDMA_DMA_INT_MUX,
+			   DMAMUX_INT_CH_MASK(chid, cpuid),
+			   DMAMUX_INT_CH_BIT(chid, cpuid));
+
+	spin_unlock_irqrestore(&dmamux->lock, flags);
+
+	dma_spec->args[0] = chid;
+
+	dev_dbg(&pdev->dev, "register channel %u for req %u (cpu %u)\n",
+		chid, devid, cpuid);
+
+	return map;
+
+failed:
+	spin_unlock_irqrestore(&dmamux->lock, flags);
+	of_node_put(dma_spec->np);
+	dev_err(&pdev->dev, "errno %d\n", ret);
+	return ERR_PTR(ret);
+}
+
+static int cv1800_dmamux_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *mux_node = dev->of_node;
+	struct cv1800_dmamux_data *data;
+	struct cv1800_dmamux_map *tmp;
+	struct device *parent = dev->parent;
+	struct regmap *regmap = NULL;
+	unsigned int i;
+
+	if (!parent)
+		return -ENODEV;
+
+	regmap = device_node_to_regmap(parent->of_node);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	spin_lock_init(&data->lock);
+	init_llist_head(&data->free_maps);
+	init_llist_head(&data->reserve_maps);
+
+	for (i = 0; i <= MAX_DMA_CH_ID; i++) {
+		tmp = devm_kmalloc(dev, sizeof(*tmp), GFP_KERNEL);
+		if (!tmp) {
+			/* It is OK for not allocating all channel */
+			dev_warn(dev, "can not allocate channel %u\n", i);
+			continue;
+		}
+
+		init_llist_node(&tmp->node);
+		tmp->channel = i;
+		llist_add(&tmp->node, &data->free_maps);
+	}
+
+	/* if no channel is allocated, the probe must fail */
+	if (llist_empty(&data->free_maps))
+		return -ENOMEM;
+
+	data->regmap = regmap;
+	data->dmarouter.dev = dev;
+	data->dmarouter.route_free = cv1800_dmamux_free;
+
+	platform_set_drvdata(pdev, data);
+
+	return of_dma_router_register(mux_node,
+				      cv1800_dmamux_route_allocate,
+				      &data->dmarouter);
+}
+
+static void cv1800_dmamux_remove(struct platform_device *pdev)
+{
+	of_dma_controller_free(pdev->dev.of_node);
+}
+
+static const struct of_device_id cv1800_dmamux_ids[] = {
+	{ .compatible = "sophgo,cv1800b-dmamux", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, cv1800_dmamux_ids);
+
+static struct platform_driver cv1800_dmamux_driver = {
+	.driver = {
+		.name = "cv1800-dmamux",
+		.of_match_table = cv1800_dmamux_ids,
+	},
+	.probe = cv1800_dmamux_probe,
+	.remove_new = cv1800_dmamux_remove,
+};
+module_platform_driver(cv1800_dmamux_driver);
+
+MODULE_AUTHOR("Inochi Amaoto <inochiama@outlook.com>");
+MODULE_DESCRIPTION("Sophgo CV1800/SG2000 Series SoC DMAMUX driver");
+MODULE_LICENSE("GPL");
-- 
2.46.0


