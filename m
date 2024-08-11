Return-Path: <dmaengine+bounces-2844-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 544B794E014
	for <lists+dmaengine@lfdr.de>; Sun, 11 Aug 2024 07:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2BD2814BC
	for <lists+dmaengine@lfdr.de>; Sun, 11 Aug 2024 05:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CD717BD5;
	Sun, 11 Aug 2024 05:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="eUuFl1IC"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2037.outbound.protection.outlook.com [40.92.20.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6589022339;
	Sun, 11 Aug 2024 05:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723353464; cv=fail; b=FchWq37barTsugsh7ljLxm4ovfq0pQ84CKv7wLrmT7M6HqvY/dWqXZi86wQbPGALzcGkLvch5uRymMmy+mhGgF8rEvBWNExqF3BSU1wAwMcvS8LLBzvsoLG/D4LHf3My9bhB7rS+g65NBv3KJd6P7BYDu+vSjSWuHjnIQtETC2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723353464; c=relaxed/simple;
	bh=pxAO91XUNNbvZQAdUlbHtEX2Uh5KvVKfJp97fMSWDTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=osb+je+co6/E80HuMq+N/bwQu1ocuZtqK3gwXumTu7JlSGi/Bda5Ev956GZ15znz/+ytSmMv3DBAfFmMyC9PxrYfpBkEchGerFvsUc6Yk/3QzxI7hsI6Xv5EyPvIgGGSt9MWpLHSwpqRtIgIdqzteanO6j8Pfzeh4JTo21Kf9ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=eUuFl1IC; arc=fail smtp.client-ip=40.92.20.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wl6uj3hNNfRagaUrqfj0QNe4OemLy82k6tMc3Jn5dY2RO7trQkGXC4j5hxIP2NdUe0mz0uqHggQ2CP6NSQJCOrFAJ2O/Hi49AOpMKWs+RbZocbFYPxaZXALv+20QZgfgRP+vcqQRjQEK/62gp4erAVNbScalJHd+d8uPVyb/oxknrYMvfv2z6ZdQQk9RcSIxeSQhxoU/E4TvND7mEg0583OB4P/HHmQzxuv/bsfTleNNdz8v7J4wgXV2EMOomMc/REeoCefBFV5k9dIBHrCjKZZjCss+JQMX5PUXXaaVF5aE6bAL4KXiYMNz5Mr53cLtmfmw0GTZHLk3IwQ4hOwayQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xs2ROf6X1JN3z9bP2TAgfx/DOx2m5ZoymWkgTW82OW8=;
 b=DHwgNo64gtBKRUwN+0KwM9pGBQmuy/Pg0XTiDJoYUqcOxiizDkPuLV/Rsu8oPUSWYKvRLJIB6aJLEzcIMBEMHEp8OTVCuY/BAhDaI148FGvDv/0XxZaduEHvNovf085VsWosyp2eaTrvWEdJG7mEybOXWwyQRH12HfLMl9VP4a30I39Tgn3JievQ4I/PpgHH7+8Wz/6P+v1+/+wi/05ByrdcWJxKE9X448bqkZjO2AE/2i/xDinuTHataFQ0LbZZnjWUIxWpaZaXemnF0kifkwLqCDLeQgjFSFnULkhWEXOhmxLLb5M3ZdzFzUEZMP4PQlJ6VJjuYz62GWmlHZJfSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xs2ROf6X1JN3z9bP2TAgfx/DOx2m5ZoymWkgTW82OW8=;
 b=eUuFl1IC+PNMUW9Q1EYrMsdq5Ul3DvCPQ7LfQ778enSAuRekIGD0ezVdZ24l8uK1HdfscuBT+ITs9o8rstw6xrYUKsslor9ggU6+vrZ2Mk6QsbGyxlAe3eRlv0pJ4502NGR+k+8qKKbx1jgDriyrAcTg2lhVKGZj+A3SLiJKMMdv1H26phSKbXzOK+eax973kHfWoyGhkbbrmdn3amZgdTlkHsRuEDqoXyBzIBanDYyd9/g4ANpfkVoXmYL3HLqhmNTelXUiWI553mwOeKVP/6rb++ucrYH9p2BjeZyiPp/XM2xhG8yPJhVqPxJ1qMy0WC7YbMxEBkdQ6BWlSRWMqA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SJ0PR20MB5255.namprd20.prod.outlook.com (2603:10b6:a03:47d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.17; Sun, 11 Aug
 2024 05:17:38 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7849.018; Sun, 11 Aug 2024
 05:17:38 +0000
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
Subject: [PATCH v11 3/3] dmaengine: add driver for Sophgo CV18XX/SG200X dmamux
Date: Sun, 11 Aug 2024 13:16:39 +0800
Message-ID:
 <IA1PR20MB49533EAD95963C2E99D27B88BB842@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <IA1PR20MB495324F3EF7517562CB4CACFBB842@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB495324F3EF7517562CB4CACFBB842@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [rcDXifOLZpoTiURF69txmo0/aI75f+bQeTaHeglVG68=]
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240811051644.990577-3-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SJ0PR20MB5255:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f1f68c4-257a-458f-064b-08dcb9c4eab0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|15080799003|8060799006|19110799003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	2A82b8D2ZRiQJu8VrLuPUGstA/Tk/cdOEOHX9++yBZTW5ZxdB2hMa4iCpvN5woDudCus8zvrFKGUhs4D97N8AuRFZz5LaLOQoy3vkD0cPU+4NxWDryZDayWv42HYaQIDE/D7yhkJV401OzPL22VQcp06B59GcfPrOSVXIuVdE2XbxTDLeVIrFMfVBZIqfdQHjni1pe/HxKIym/EE2T69uFxKqSZOF8F9VojMH52qIBQWYZaWaPBNmggsll6K9BNtT4WR97uLXKBU3l8RGdGx0v81USsLMM3wG/HCxa0hZnT1Kr5DC6EojpSpY7Bc1zjOJpbaqxl2HRwEr0KwyxGqRFcMg0d5VTSzU1NyFXjyLfA/mxnNPDjlQW0vkY39r5WyMLFBDRVbBdjH4d9s0XYTLcTFUGv6rDz4PVTlJsRRp/Iog0wPd28R7l0iMJkn+9qbGaOhvxwp5JZirajwL1KSez8yci3LzFJ73hOXlGS+k0P86/0lHw1A0qsBuB4HGh2Q2eQS+5JRqYsaJw4Is3hZ/rTY03MNNylsO0zSNjgzHQuuy40pbiC1Xt2gJ4spczDXJ86o9cfkqpHphOYCr/hUXEiHCzav2YWbnQ7KFhhnLVTG7cToXYHrSQ+I8CRj6vK1SK7QL5fpkEr3BFy2R7uZGR4FF42AVyhWA2Ibbb6h3sVB+DrO60qs78GQ5B57qOsz8WBsPthJ9xNeYF3CV2AIv09V1v4wLdLupeteQ5KyNds=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4zjVegeKcBsGKwxMc6iVRW6Y+2LfpUL5YjV9EBwbxeyb3wqJIkh6mYmrxqdd?=
 =?us-ascii?Q?DD/pigUW9q/DKm0mGAzmNZnTer+B61x22ECml8U2oH/LlJyleM5mR/vTLKX5?=
 =?us-ascii?Q?kCEFWKPFk2i9gOB39CK/ZNit6vJr9hAsEwsOYlCBxKoaDN7RnvAzQDF9pwoi?=
 =?us-ascii?Q?hwjnaxwzdCHDNzTH8Rdv1lXaadw8Ovet8UF6OdzhfkPxlRvyaJJqwYSURIYw?=
 =?us-ascii?Q?DyUJ317R0KKVn9JGbvnlMFJb/CdEA65blUYkxvXZQxl9hMmaZvkilcmrG27k?=
 =?us-ascii?Q?xVssq8S8ATCyqa/USvJ0S0q37/kT7xA+qBJTL8762+6kSor+CvO2ZlcIzM8U?=
 =?us-ascii?Q?4Q63+3DJIfSJgBQh7iGmWUQpTQa6LdNIcyPyxTgHm9hNSUDrwhocdg93lRvu?=
 =?us-ascii?Q?PGHRbBgDwpIYI7xvdhVlseL+5Qn3zqlmr/Q45Yhu/zcFe93pPrRQbk3HOotE?=
 =?us-ascii?Q?mWAlwvApMx8DgK1ITWSGf7GN21ucr2doeLh5LCVTg5SwoERX0b3UwCxwudUu?=
 =?us-ascii?Q?KgM53lMRvRFgs0vRdPLaB/JnUN8FHPnIJ9GU4qDAusdvByd4bgySOisEF+oo?=
 =?us-ascii?Q?QxEqVhlQLdzPxXFg8+W1XY0Z0N+gjjCgWcslef2Tt/VXEYXDsSQ3eD4ntRnV?=
 =?us-ascii?Q?5jbE5vdeijZCd2iq5yL4UeAuweI12u3fpQwjm1cyVVNbL8DzUG3zJIaI1r5f?=
 =?us-ascii?Q?yt3DG9+IqG8EGLwYt6KOPjMAgZVEdcRxsxI2uFWCEFLv3ysfshJ7FBmWPKH9?=
 =?us-ascii?Q?H50le/3AyVPlVwVz36iSdjDL73HcyKBEnps28k1dzZD/2+S2dT37sDhVqZgI?=
 =?us-ascii?Q?LObykbNHaZ4DO/c8H/VmBMMCoeoe+aHGH4Vk0PzCQksBQK7Der7vdt8tDjT+?=
 =?us-ascii?Q?jSlkJ2BNkBO044wICgbDAkQx8MAQY2V7XxO3pFEA6Y+ewQQh1HRoCBJMxmGq?=
 =?us-ascii?Q?W8K1zLyFuGQak28Khu5vG0uw2f9F+a+avi3EkwdDTIBzyK+1yooNU+sgH+cY?=
 =?us-ascii?Q?XS2iHs4TBzt1tRrf9yxUDv/GHfPj4MrvHx0hDv+mhYnzLDn9M8PQ09CxRz28?=
 =?us-ascii?Q?IBg/jLReoamkyUo3FC0cK2UurTqC0Va6htUpOYRfHs9vcbfTIOoQtS/Wdc4n?=
 =?us-ascii?Q?HB3MiTmRqtgtBcepe8B8/FWVWRSfjc4RVEheDO88okLYv8wUwRwKnTqlnmQz?=
 =?us-ascii?Q?LJ7di9NyJi9lwcbdxhtw0wqSa73gpQSa5YD/kaNTq7fB6+ImGK92wioSuRbm?=
 =?us-ascii?Q?QVCaLS6y2IoaQSbkBMna?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f1f68c4-257a-458f-064b-08dcb9c4eab0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2024 05:17:38.5431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR20MB5255

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


