Return-Path: <dmaengine+bounces-2783-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0B99459FB
	for <lists+dmaengine@lfdr.de>; Fri,  2 Aug 2024 10:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D1ED1C231DB
	for <lists+dmaengine@lfdr.de>; Fri,  2 Aug 2024 08:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22881C37AE;
	Fri,  2 Aug 2024 08:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="tx/SYS59"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2026.outbound.protection.outlook.com [40.92.20.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59E71C37A3;
	Fri,  2 Aug 2024 08:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722587613; cv=fail; b=VHehqxWx74YYtlyqBPK8EWGizdTsilrnOU4JykWV49eAnh66ctKNKvphqYN/3eQA9S3QLbX9Mo1MBxAasAcLhiibSlfqyhPlKEgvd9MMjfPL3BReVA2Vkk20Z8cLuWcBhmtT34ZiO/Y5XDBNFzJImAz/7dw9GqwABCVNjbuTx8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722587613; c=relaxed/simple;
	bh=eawxatCAz7yWZqopDXpF1n6qpAOqPMLzTAivS3cWJZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fjur+a96blaQYPhCKe9hI0G9lvsKrfXeMh4Ki11Loy/4Fz36RZCQorCyDVDzl17jL8zcMgzrotrnlYSTCutFK6wycrkX4+gn/+domP4qbZLoJs2xX+gS3ACfuAyDKKT6rJ2v5Zi/q/F0jwOKYIRf42jfHPHOOiTh+44u96Nj70o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=tx/SYS59; arc=fail smtp.client-ip=40.92.20.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JS0pqvcusWiZ77bXZLU+3RaXrxDrhsMlMgR1fXuOhzfqVJ/P6DzPUjNj+PHXrLRCrRoJBJ+7u2Jcp/Glz2wa3zkHQFwjVDy1W4nkgg8+RuStzuoc9KwpgI9dE/K9gICYXiadQXjKI/0GB/kMAc6vEDp150bDh2NtGcBpMiV3IEttiZ20jkt62qiwYTI0IIdHO2bMqdc9srx/auLPYYS0Osp/mZPn5c4wIrKP4kfNpf68IYjioqvbbejbn/s+kmGlSzgNBKKragpk/ou8wa8/ss6MHWaZmF6kPpW9R7VscCRO+GxccRUDaHIlpwVEXLAlc6dFaje6OUqHODGCjXlN4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xs2ROf6X1JN3z9bP2TAgfx/DOx2m5ZoymWkgTW82OW8=;
 b=O0QxZCHCtzQePMVifYa8eEw6NHmQFx7B0OreQJR+0AHZIGrAg7bQzlhhbN6sUcZglJOAJQOvxS1mh9KufEzfdjLR4tzvW6C8RN1TABpNa4KUtw0mcQAXiRu4UHrBHYOgIQapuQZx9IjdwxSjTvwitwBPGcoGYPeLGVg+0s96IfZEE0MCgWlCIHva/GnXmxVMdbwDr4qqVZZ/YUMbfz6AKKBzsBg5Mcq8ukvWftNwvXX/T24qXyZ2gNuXczTFdK87iksArDu5LQzgK1wolpQeby8K9mG6q6LYt9QpOWtx/L82UsVljtzw7esndpo+VNZbCVnqMyv3a3UJCX1GneBKGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xs2ROf6X1JN3z9bP2TAgfx/DOx2m5ZoymWkgTW82OW8=;
 b=tx/SYS59x4hTG5XOO42oEi7mhlPyi90Iv6nuomzTcqZ7IR8s6EEeDVvNT/SoKTf1aYFpWg5EX4UeL33DHdOx4greWQ3j6sQVKSg+h3zH6jJIJMbz3B7myJNgoKQ+N7H6YMcGZndxrX+1gCvs+k3v65hCzEmGiSf3dOoHFgdaoRKQtrmRnI5bOOkbxW5MpKUVLlQHf1hfxAWeowHOSPLn35VKThQez3Bm0QiAVFg99AyaRXG3Kx4qjtqexIHdtRiMfoJb6i8x76CwGr1NKRveC5lfuhGBQ70HWr3sR63j2UobFq4PfJSudqZflGIrC9FofeFEUwE2lPDUjD+xoU96zg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CH3PR20MB7441.namprd20.prod.outlook.com (2603:10b6:610:1e5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 08:33:29 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7828.023; Fri, 2 Aug 2024
 08:33:29 +0000
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
Subject: [PATCH v9 3/3] dmaengine: add driver for Sophgo CV18XX/SG200X dmamux
Date: Fri,  2 Aug 2024 16:32:49 +0800
Message-ID:
 <IA1PR20MB49535541CFD1D66BBC8DF916BBB32@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <IA1PR20MB495332ACF71E3E8D631508B2BBB32@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB495332ACF71E3E8D631508B2BBB32@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [sI7IvK3fXGt0IgZVs4BBZ/6oPX9bTUGFed4u6o0mIX0=]
X-ClientProxiedBy: TYCP286CA0109.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::6) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240802083252.1286244-3-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CH3PR20MB7441:EE_
X-MS-Office365-Filtering-Correlation-Id: 145ff4db-1c74-4a60-7c37-08dcb2cdc90d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|8060799006|19110799003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	Y2AmDTQzUMjDzaAbQP/+2DwdjON2D5RnvEcc2bP/GToNfoa0bvzgBe+McAcK2Doq4pis253ToacVdkNyFf7NyiAgylQz25GLnOtqe3RGbXvnSWWyqmRLr31hlyEGqNqkViAhlQHEJMRSF10kNL4HDp3ACos4lwFaUM1JO+3B+UrfPSFo49zAVZXTIkJ4RE2q/9ttED+apAbYTuJbEecm/lGViEWFtesjMMPS3LUGTl8sGwbMyuWNIVf7QjJQZSdwV28HvjYpnaltL4S+zL10Q5zsPSI4WJRc8hWEc4t6u+jTMPCF/zrZ7wJCkGBM3TV6O0ya6ogr/OxlZPPeJVAQRDkvwKpBRQ1CDSS5ryJkJEJi66tnqLIwUZYQDm+tzMJhaomWnbR+3jCAP1OMeP5cmGM1BhnGS1uzeNgNU73hw4lleK6NTWGtbEGg9oqCCv3pB64fTbonSkRVuBbvVqr0d15l9XV3dapVROyNct2aOq28DLn0gMGLsyv6t/6VTeb0VF/G7SBStUH9Av3FGxWsVdgZMpIOrMuzGKP+0jjxIfVsd1W89NW6qLXBH0bSQa7pn6z+oTdzofwCewMt3e5ea+jG4Q2U7ehqMmVatn+CluI3JbRzX5xoYnlgHedral2IIP987JOb0l/R/v3P1Ep1wPZRPSlEY/V5alJ3m6BP+uXefZHj0wvSPNKRd4k0cuj4lPjsWCG4Y5j+NItExK4Vdw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2hLcwoLhBSkQNnRQol1gAAOkuaBpM60FbdsNl5EmWkBnESJ335By7YCGolfM?=
 =?us-ascii?Q?wiPHaHu6QGir9pWEOFzc70CJmxOpDF/xZs1YCcArvIl3zwtPKxfbTSIx4R8Y?=
 =?us-ascii?Q?Ed8MJnCpvDZZUQxEphwOCSJIPRGn3CRfcirbPIv97neAx4jbIB66BX42d4PY?=
 =?us-ascii?Q?Dh2XiLvk4l9phkm9acDSzurIvVI1hqXGC0SHWlEo1pSb9a2RAH2DI7w9LgbN?=
 =?us-ascii?Q?gUhDPUotedZkWCoLx86NEriR4k5aacNunor4qYevLJPfceqdR55NG7ULAvNS?=
 =?us-ascii?Q?vCh1KAzU5VZYeC3LWpFDnOfXqyMyE1SyaeCoRIxgjynACgUz+QJwSM4yU4Dy?=
 =?us-ascii?Q?yXXaWf+4iu/nm61BIKoN8ow2NtuOpM5eillQ9NwJpsjhYoMtKyQMb6R8T9I4?=
 =?us-ascii?Q?EucGK+LWRh57CYX/v4Zy6C3uxkGfXELAitL1pDVrweFvkp714nUvo40XVouQ?=
 =?us-ascii?Q?b6jrtJh0LRu+VJ0Lf6llmLEnjCDlJ4bggED4UBC0FlHvw0FatY/RBT3ljtgF?=
 =?us-ascii?Q?Knz4k0d86m8mQRVwWhKykv9NcyUkz0dJbqkiNEdgPZwWYOaCAP1VQqa5wQiG?=
 =?us-ascii?Q?4dEkGTy5vpvsZWEdva1OQfeBBjpQ30erY/c8QGbv9FSP5TBfHfWrDFRJsgk5?=
 =?us-ascii?Q?zLTL84oJUgs2N3gerUXxDXjUz62m2/k7lKAGgpZfWqvNfIylbD7JW8/TN7e9?=
 =?us-ascii?Q?cV/SDNhQpWVNnRJK/0FNOl7iLMUVk91QZXz9vKBNDW+ExCGt8ohKjE9nMG/I?=
 =?us-ascii?Q?gZe1lIQCS4xiIZa7CMg32bM0X4d4Tq6MXqCKvOEup2GGIPDKJ7aRHa1wEnLO?=
 =?us-ascii?Q?1gvZkPOxWg4JfNQJX7WKdyFzqHqz73BXP+ok6DENoA6nTtFKCkbHqe0lDqKD?=
 =?us-ascii?Q?hni81nlPnAOR9ntO6k3DDvtupEDkt/gsr2kgmhqXjQBHNYU2upre5xAPdRM/?=
 =?us-ascii?Q?uRKtLnFX/UShG2gg2Y3QHJNEod/ULkQr3ma7rv2IpIoEzL2Vc+1+JGkS6VlH?=
 =?us-ascii?Q?BA7r/Zx9slQFplv1KtNIG/0oiM7ps0PJghCdVA90GYkMymng/6wMXnfH7Itb?=
 =?us-ascii?Q?kjHXGTNJfi48TqtPT5LvW3UETew5Kb3p4RsVWFsEF9MGQYmfr8krm339ReUT?=
 =?us-ascii?Q?c/uHuaGZQP+76ij+Gh6qXf49kVKdoJu9C4X/YDzA4WxXVzHFex4E5Ieus5eV?=
 =?us-ascii?Q?6K/z+9lj4X3wTwclLz7j1FgI30nnEqhfJrAWV/Lh1kLg6SqgMotB7Ph8/mnk?=
 =?us-ascii?Q?VGVn//TYNL9u4LMcOxvn?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 145ff4db-1c74-4a60-7c37-08dcb2cdc90d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 08:33:29.3770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR20MB7441

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
index 000000000000..483cf3ff5feb
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
+
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
+	data = devm_kmalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	spin_lock_init(&data->lock);
+	init_llist_head(&data->free_maps);
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
+MODULE_DESCRIPTION("Sophgo CV1800/SG2000 Series Soc DMAMUX driver");
+MODULE_LICENSE("GPL");
--
2.46.0


