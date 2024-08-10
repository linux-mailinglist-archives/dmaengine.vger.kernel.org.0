Return-Path: <dmaengine+bounces-2833-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172FB94DB7E
	for <lists+dmaengine@lfdr.de>; Sat, 10 Aug 2024 10:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 256391C21290
	for <lists+dmaengine@lfdr.de>; Sat, 10 Aug 2024 08:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AA414C5BE;
	Sat, 10 Aug 2024 08:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fi5vR7hk"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2073.outbound.protection.outlook.com [40.92.20.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0550F14D430;
	Sat, 10 Aug 2024 08:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723279197; cv=fail; b=bDOdXsgSVgnXjvjm92OdMvdd8EsHxcfLedSP6UF9l7yNrP0cIvbgrM4LeIK9K2kxBZUdvaoqpzkGk0lSzKTXiVjW6KTcz1+TsEfSXb/jygJRCmx0LjZCmF0b0BLA5QTWAAZQKvZwafBEMKM67l+5LX0AplITmmQwe3smEeMvcr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723279197; c=relaxed/simple;
	bh=pxAO91XUNNbvZQAdUlbHtEX2Uh5KvVKfJp97fMSWDTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a6rgggFNV+i7UoxpqeOECbtjDm5pDqQ5nLX/H37dUF0e5VN8kaWS6Yoq6TW/zGh/H7AMs/lfk/X2E63DfMScGhbnOqHTyuQ2ZtRrH+8fXpAK2hEPOoKS/ongEMBbiF9aIbZ3d6SgFQ9j30aNsrTWyGQv2M+1mbpmTYqtCDyRySo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fi5vR7hk; arc=fail smtp.client-ip=40.92.20.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=utYJ94P5RGsxlI/Z027mQNqZl/00Cp0Zj+Fnj4AuQPuxv+5y7gL72RLrxgvI+jkbuDn2Dpv8bPsDQI7hxC6haq/1/imZA8rF+oOQZ/YzztB9TNnhyoI7GOTrnIlS01W7GAujP5CXEbiL0e3rLNqxWMgQBokW5DAhJpzihZxREAa47Y1i/YLjLxj/d6jKL4KhQlovO6ggTEYHXqe6dNmr7birHUFGXj5hME7XL4+tEi8l3sKIaDRkrHan/rmLSPFXDEIn33K47/D1kdMvonNlI5QxrLjKJWT7fK1nIrjC1nzBAp9OonQI/A5Bj5kMFwWNQb3V3NaZ47mg1WdHghlXhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xs2ROf6X1JN3z9bP2TAgfx/DOx2m5ZoymWkgTW82OW8=;
 b=H6NQjtNSRxma8lM58hZ8G9hCIIxRwmkXdObg/Ll1p60JtjoRM/SrBAiKR+lZLJ/WnVJEey54O2R8Mp85EwKvLOAEIYT8I99k6Wju+sQRTCLv8Age7KgBZZlxWxLED2h0O8E+Ey0rFZFV0dhowr32xvd4pUgI9aWIog67MUx5CcQGGnHOVZdf19jVxiZiNLZy6vlQQlANAfGk3GjFsboZtWddD9c8RMlKmArloJvt08BO+cr5i+Sq6qkcJaARS7igdiolafNAJSVXIEiRSyXebbjfnnLXHHc+vtAXYHuoZMcrKRe/DkAEhvtsHHsxvr6ENQ3DiR+jm9U9jGCyPjZzSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xs2ROf6X1JN3z9bP2TAgfx/DOx2m5ZoymWkgTW82OW8=;
 b=fi5vR7hkOyuVBzKiTtHB5I/q2vP8xDkjWg9oi4U0yeGjvapiENdsZipOvtO3AqEItxkp+sljx79+OdIdp9YzT25UW26M+hkLd3pw6tGDDTIu9pD0mb/qv4sGtBNc58+cNLxnEmKisCIplRuCtotoKulnY5OZtRREyVdnH/Ghwt2mwv9Lz69Dm9k7iCAHPUOXRGctQenrbbY7Oqn1RjzVzFbCoCv7SYS1jhQ/qjuepKvWaAGp+U/68HptBFL1erX/ncubZ8fero9aUb1TWRDGnX++VMKAKg5g516opo1IDoittvoJo+UNt/VvalSLnUVr3hTBujAhNhgOl0uYbDrS/w==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB6115.namprd20.prod.outlook.com (2603:10b6:510:2bb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Sat, 10 Aug
 2024 08:39:51 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7849.015; Sat, 10 Aug 2024
 08:39:51 +0000
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
Subject: [PATCH v10 3/3] dmaengine: add driver for Sophgo CV18XX/SG200X dmamux
Date: Sat, 10 Aug 2024 16:38:55 +0800
Message-ID:
 <IA1PR20MB4953C0E9B2153DF4FD4A3F23BBBB2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <IA1PR20MB49530ABC137B465548817077BBBB2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49530ABC137B465548817077BBBB2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [YKMlMLhW0UVOg5xfZ/TBYdw52enhBndqGuH9cIok6mE=]
X-ClientProxiedBy: SG2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:3:18::23) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240810083857.487764-3-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: fa47f9f7-dcc5-4871-7e75-08dcb9180032
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|19110799003|8060799006|15080799003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	5txIuTA56WFPY0PiVN95QiOq/e35093Wjt6FtS7p6199vj9zpu9KnD16NIDGfiWJO0TeVXYSc3wLxV/EpUoxCBTBYmyJH8yNVqBWqtIqO/z5n0JVX0hIrbELawCG+M1dDiXy/EMNWY61BoeDa4qTdpiBEYlLGnbHQv/gdAa1f/RNzjXzDglXusAR2MtyFbzfzwuLKmvlFAtIZIWiC04shq8BQIjvDMPJjBmj4dT6I+n2tSzLV9aMfacpSiGPgMOqJYZU2nl2HPPNs8e9bCEbBx1Pmmw55wsmUtA2oDW/qcXh2XGgPqPZdUftmKvC/KV2X9QamlMGEgP+sIIt7ViWcF11Ink5KzC+sBoH6hJNTp9RfpMwOmHzHX0vSZQoZ6fxPHGdUVE1U43JHJT0Q3k3kNTPniLLH6TUcYw5P3iKBDgL1LEvi4cu79X/kCTrxe9s4QHnZB8gqoa63fmM6CnS1cKKD6j9aMbmpSdHy9sSiuL/mhT5Ml0grnoMXcl5LdvbMKhvfoH9WaYbN+95bfQSPhjsdsWS85+BCBbBCHE4IEcOE3Oylvfi1PDt6eGyzfCU8mX9B6fVJr2oKQvTEZRLbyuQ7XHJzpWVzu/DOASYVUv94OmkcCvvXDXJMVZoRuuzy8Q9WWfqRrrujEl8bo0Qhvt8f3npx+DSjkn/MJSbCSxHZO7WrD3+FKW9JQIvSUww06P0oiqZjgk331tYiE46T+oHsEG4RF6n6+E9yZrgGJ4=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fJSKqY2x7/bYwuVNpQ98IcBF3p3fbbVQaoLogVdvM3+QFrq90YTvxW1dHJon?=
 =?us-ascii?Q?GnabL0gq6X7PwE/Vayj0rS4U0MoDsVrQoWrWEpd0JtL95zofNcelUsXrDwNR?=
 =?us-ascii?Q?5U5VePxyH+iree3aSVKonikB7SdRRg7QMwpAMtyEY65/S5S23v9AeMZNoDvS?=
 =?us-ascii?Q?9HVsKdnlzTdGXJX9FUmgTe88esixaeYxo0gkFdOvbGp+RtTenaIdUndw11kB?=
 =?us-ascii?Q?Fg46Qvm9X2hfkq1uqnxG1aqOc+5vwfVgLl3XVA3B07JK8ZnTG4SnmZQAqC3v?=
 =?us-ascii?Q?qam6JfHagljzvTb4DCwaNYUtF/vdJXxH1tohJznp2J03iAZMUe9dOo02R2Xw?=
 =?us-ascii?Q?TZMm8lvVFUtN0ObI/cmanTTmtqrO13E0i9xjSeEUfHsLPyVaulrWTSRlALkv?=
 =?us-ascii?Q?JejIQ8BUnLIVgF6DSOCn+tx7cs/TJBdiXQJA3cPK49yebIc8qFcheoh4oTD6?=
 =?us-ascii?Q?kvH5V251cF72feTOA/BzrvUNcn96Xs/GYTf5h/xjmjJtfsquiCHo3FEjMqkf?=
 =?us-ascii?Q?g+Ihve35Mj+H5ZmQYiMVRIExqA0+ah0Y5gzmSMCmUBZQbkmLLZ+muxVM6iYo?=
 =?us-ascii?Q?4JgulZQ/3PeegoqO+ABf7qqYk30DySeA80EkxNcG+zhddV0DYUioQd0Dtguo?=
 =?us-ascii?Q?JqkXQfh/3ex6ALFixakTIorCiJyjLaJVtfsN2BGA7wdi2VebXjSI2mSGIa/9?=
 =?us-ascii?Q?OeTQjlMnFHh4VB09pUAyEd/9NABL2SlVSl9CWcbo4HJGI68rZLX5pXRIGnqB?=
 =?us-ascii?Q?pj5cPCFdAozsmggmyJcAzghKp8dC+zvoFv2MBuBVzky0jSooktAFcVuoeR+o?=
 =?us-ascii?Q?e9yfb18S75a2N+7P9K2rPfvoewpZKuTBrwyy/4lQypDYbDBLCZH/I+1BR8pp?=
 =?us-ascii?Q?klJQNkMYJ7ZUrNZMs9QFvh0IahlpfTg5e66va8jB1oVAl3UlUqK43TpY3MU8?=
 =?us-ascii?Q?JRsSV4kBYCAhKsCGYksECKZVRm39JuQCc790L4/J3xHivo2H0byuAIS7iO4K?=
 =?us-ascii?Q?0KWuXcPA53+PVI0r0GpdVBSt8Vr1vyKiQV5mmRrTgnbMy0iKtFASVv6YkV8o?=
 =?us-ascii?Q?0bcd+iIbVGhATK83n9HoDvTw3Lfi4YFNUGg5+KuIRDOg9ypzGzgQxmN3m0xX?=
 =?us-ascii?Q?UZeyS146N5e5xUdMsVBj5fs2kDqK+orGHUBcgkCzEWA5coF/mlWFJism3wyK?=
 =?us-ascii?Q?ky2yrrFxs2D7A/KVtBlYmVLycCV3juy9W2fxH3l+dWZC9RxLcoYqREJGFJ/l?=
 =?us-ascii?Q?0zB8cFxWxuw+6F9Q1UmX?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa47f9f7-dcc5-4871-7e75-08dcb9180032
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2024 08:39:51.7109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB6115

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


