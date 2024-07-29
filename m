Return-Path: <dmaengine+bounces-2752-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A00B93ECA0
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jul 2024 06:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88AAE1F21CEA
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jul 2024 04:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B9B82D7F;
	Mon, 29 Jul 2024 04:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="p5IUJq6P"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2012.outbound.protection.outlook.com [40.92.23.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6CD83CDA;
	Mon, 29 Jul 2024 04:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722227850; cv=fail; b=qgHTFo3Pq01Fm5OEBNBMn/xx24PA3HFROnVGIPvA53BvSJzlh4JA9eqp27dYsFGBRfGotwU3WYNT5pDZpxhmj4tRl0lDZaba0eznr1KG4uKWtKACxaPc3GCP3+fJdvAKi50BVqsq4AhBof0l7xxT2dotvuMW/RE+rF3ZUjrwZHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722227850; c=relaxed/simple;
	bh=JAyHy+YA0aYNbZyDEp8mEDtdLqamjMswz0XLY/PSjAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dB8YD+57uu4oKoP7m0O7owOHzJzVI7MW8VNUxRISa+Q3aO8iOO61RnXuNKDmlKcLo+PhJuI+RLrJCZ5tuusbqGP81AxDT/huagRsOfTxPsCQNR55UO0nTcLBk3aF0E1XYPq8nco8aby9cdMzY3e1GUJ2tcXdCsiOaSMbANVEjMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=p5IUJq6P; arc=fail smtp.client-ip=40.92.23.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KbAYerldT7lO3u9edaaXtZsvqiREeMTXEw02j2/ucYR7Qzrrz3TH9r1YRAhSq3iETRN6cvU5KoBdy4kUaHHyTZBXGHUsfTS6cq0yD1QCI5+Twr3pm8XwAv7WyEHXm09byRaQQhD0hWCJKUYmu0drxSuk3sLOIeyTWBZkafXwyt/Z0uEcvBTOP62CiOA0OvP/swD+XPVthCbOFHOIXSY1u5F2TYWddOKMqWaq8pMTX9qisdSbwmYfaMJQVkz2QKLRaCvbIVP4K3ayJZ/kk2Txe53d02gC86zmzrrmFlv/ov9Ts+y6HFieD1vCF2hkzxZFOFfaVeMpgDTIGWMjfQ8NEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVvw0KcRO3YlrxiYZpzerGioQkzY8USL+mN5SJYl50c=;
 b=gscCQqkWSn6Y+jTqoohwldMn8pJaaYAHmoQkjYooKpNuatGVQnD06a4JvVt39CfyulCiFMmRtoeXOixJ8SaTmBzpKSeHgt3FbtlGq0R3aOZdgWbnNf60o+uJWO0TP5ITHUFzzwW7WbPpLpLa6Atn0CJCyILsyv3I/0KI9DRskvCPixCW5gTDcz/LPvJiROPiy5x+jHrK5DYgXtZH9iFVMeBMVF+1O/NnM+cP2SQNZSGdbWja55zIovW6Jc21s5unXB7I4XHHSaBy4p2LdFPHgVCbGkg5RTZ40XhAiohFnb6O5M2b9vfXFFm/zqXpJzVYvAus5rfZVMA0rtDxh90tYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVvw0KcRO3YlrxiYZpzerGioQkzY8USL+mN5SJYl50c=;
 b=p5IUJq6PT5Wc/C/ytTBdAwWritH+O+o4F6mhciGR+HrWj3AsN3UhaCcEvyM9obHZEbpmKk4wHgCQeBxT3HsVzj6TZ3alYdT0qa4UdtY3uXEEMYkGYJP75uxJsWKRVubiwJA1ElEms5oLnu91WAz4YYxW9PB7eaSvyyAz+yqKBAKb73BZeatJbYcQGYp06hDipcC6pRKaPsQh8+KTNUv5V2t8lTaeK4YWyOY3dYlJANTzIRB/OmwnXfCHUx6KjhgEl9zUytfRAiUjVn0Ed8cMb0/QOOzEI+Gf6Usi3FHtX+N6wicNFsKxgQ3QcG9BvM0UqF+yXFssAV8IM3gXSRkQ+g==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB4516.namprd20.prod.outlook.com (2603:10b6:806:23d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Mon, 29 Jul
 2024 04:37:25 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 04:37:25 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Liu Gui <kenneth.liu@sophgo.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v8 RESEND 3/3] dmaengine: add driver for Sophgo CV18XX/SG200X dmamux
Date: Mon, 29 Jul 2024 12:36:53 +0800
Message-ID:
 <IA1PR20MB49533F3CC6E7FE99EB290E9DBBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <IA1PR20MB49535EC188F8EE3F8FD0B68DBBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49535EC188F8EE3F8FD0B68DBBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [2wGaVa5uJy+MaoEB50U5drkt5On76xTEXS5HnJtP3yA=]
X-ClientProxiedBy: TYCP301CA0064.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::16) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240729043653.899480-3-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB4516:EE_
X-MS-Office365-Filtering-Correlation-Id: d2454099-eef8-4f58-56a7-08dcaf882518
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|5072599006|19110799003|461199028|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	D77KAMEvGSjFDpWFEOCYWvuvR1PoCrC1J03Ov8waxw2dhupZrX7Us3Ga1fht6rYWrh3zRyVTPMRhOSwk5SAz2VW0Mb+f4SZs9sdJ+cS2Ec8ZPDGXRuK6L4PL09gfkEwizKzI9+Lwtm8b7jEr5iv3RvxFC6vhGOCsFqbtdM3PJDm4f6OrFA9gKCIpQaSqdSqFDuFI5XZ5Aza79i+o9aNdamB7GJOyRDiv+S3twvAHoZa02Br+HmL+gw11XSvZdj/FXsso6lEqQ5KxF2G9zgvYlnoF0B7coZGppwXx0TjpV1FzEbpy606bd/18iKRCemvLbJ6lVMhnDV8hx1l+N/8h/zlS9xv2RMO84M5OORRWrztCaKv3ruw5/J5B7NzsO98ixM5LwWFk8STDKffewgh3oUEh5TfKNqmZIWaN/Le4x6plu4u93XNv+OJPDzht6FL4WHyVFWXtJzf6mOlnY2VzyIeEipfKJQ7LAOu/YKUH06MGWoRrYy12U0uwNhNtlZkS4cnqoGYVM8ftvm1ZourXsp6pTTft52E34R23Gn2Tiy85ke7msIvl3dsbh8JV2MljJYA78ZprUsDQl13cDEgmrbsWHtJ0HRu406b1wqJessd9xlOWYZtsgPUDysimQiYlEsVgkzh0QDfSgmKTAwwr69zQmIKUkv7f3bI1RMoqP94XNKrrP8J+A9UKoYz7I1IUd9uTLE8eDtPewABJwoiijg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LRWYAeAOHY7x+sSeztoRp18eIMitVlGVHt0m474K+0HVV9coDd1iCHVcKJ97?=
 =?us-ascii?Q?YRUv+RvNTFD/9ejmD91BPMtGPgeTJewXzrMhq3h9BMjQyvovgsgrRQKO6spa?=
 =?us-ascii?Q?BZZipx+mMSGjl1TVWBAKBH3Y/SAODFXsoScjiiV1uxZj/2cEpHrkG1np08nR?=
 =?us-ascii?Q?Wus2PCy/sqyZMV1bI5FZaHDNWQAH5HAtIM1/Z0ZMMMBNCRslspY6qZnD6DDo?=
 =?us-ascii?Q?Mmwfw5V3k2tw6kpPSvtsnqjTXCIWAk38ySaCgt/uq6AGZBkiixaFBrmVMOKr?=
 =?us-ascii?Q?9jFzL86qsqNQjg6HB9lzJ4H8MaXDx9zKprqrFEoGRbLVH8B4T9TuU5ec4ygG?=
 =?us-ascii?Q?7qKz00r0TZPJ8++5oU1GuL9EJz6JbI2YNufgQ87ioP4sUTMDzArEYRs3ZfhS?=
 =?us-ascii?Q?CbWWK6onO5UIP6aNQqQ7ZNPZzu/I8bRxsjW9vKhKc80bXGib4QRDnFN74HRB?=
 =?us-ascii?Q?zSiQ5A4EpurNe2hU2Zza5fNgb4HVUS4VtXAx9K6j6+PHa2rXJK0avnZ2XmFC?=
 =?us-ascii?Q?6SKrxmoKvBp7n66psBCdya+FpFpMZnbhVUKTDcy5meeEsMhdEpSrK4oozgXL?=
 =?us-ascii?Q?Kj5LZzT2YEE9os08i5C/La6La46N0FngUtPeKf5bSZ+Vje9Bkt15G9X/wGja?=
 =?us-ascii?Q?RVNwqINvZvwV4oVDCTmlwUbF6QFaojIFYuCWP1DKMqKIEWdKfzlNjTmsdabN?=
 =?us-ascii?Q?UJhSY49p+SobB24LT1MJ+pGKtDYyU1A7lr8Oi+qUbRN70p9IUEuS0HmODtd3?=
 =?us-ascii?Q?Ok6Ju0G07XJmmd2ePVv3OlXHc1nZT2HHRhcCeq/KXKdoQ5WPlILGWJuob1yx?=
 =?us-ascii?Q?Fj8S3seu6bsN3J6eUoK6uwqMRpA/I/U4mD92rS1vADBaOjXU49j+i6KaDZmn?=
 =?us-ascii?Q?GhRWXCT15MPHNfa3CBsayFQhLlznu2ts5kOn4SexM0inW0/3UNQmhuQavhkM?=
 =?us-ascii?Q?y1nXzPBEgsixgI0kwJUd+V8iKXQcnmJAnpngaKMKQg1Glbgk2+59zEqKsd1F?=
 =?us-ascii?Q?BwBYv1uKQKTOeWwkCSkikUYxNy89YoEOK2d4hbw/LoCe+5Pf8ssaBCmqjyXS?=
 =?us-ascii?Q?94y1zI1VJ/4KPs9Pr2+CkNXWyiKxWo9JE/s8xz2CpSn+qduyRb6Wx6F+sDGT?=
 =?us-ascii?Q?LTCSIv8pMT0j808bMLsjYW1VvqHTA96TREzQHSvjb7eWOoMp16TBJYoIFM/t?=
 =?us-ascii?Q?YcVvXCqbbpAayr3wAWiAlZ7v/l8rsuxkUBxgmIKSG9gsleXNmG1qaFu5ztcy?=
 =?us-ascii?Q?NKKpjdjKwitmOVb0oSx2?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2454099-eef8-4f58-56a7-08dcaf882518
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 04:37:25.5519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB4516

Sophgo CV18XX/SG200X use DW AXI CORE with a multiplexer for remapping
its request lines. The multiplexer supports at most 8 request lines.

Add driver for Sophgo CV18XX/SG200X DMA multiplexer.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 drivers/dma/Kconfig         |   9 ++
 drivers/dma/Makefile        |   1 +
 drivers/dma/cv1800-dmamux.c | 259 ++++++++++++++++++++++++++++++++++++
 3 files changed, 269 insertions(+)
 create mode 100644 drivers/dma/cv1800-dmamux.c

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 002a5ec80620..cb31520b9f86 100644
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
index dfd40d14e408..7465f249ee47 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_PPC_BESTCOMM) += bestcomm/
 obj-$(CONFIG_PXA_DMA) += pxa_dma.o
 obj-$(CONFIG_RENESAS_DMA) += sh/
 obj-$(CONFIG_SF_PDMA) += sf-pdma/
+obj-$(CONFIG_SOPHGO_CV1800_DMAMUX) += cv1800-dmamux.o
 obj-$(CONFIG_STE_DMA40) += ste_dma40.o ste_dma40_ll.o
 obj-$(CONFIG_STM32_DMA) += stm32-dma.o
 obj-$(CONFIG_STM32_DMAMUX) += stm32-dmamux.o
diff --git a/drivers/dma/cv1800-dmamux.c b/drivers/dma/cv1800-dmamux.c
new file mode 100644
index 000000000000..6ce3c292fe12
--- /dev/null
+++ b/drivers/dma/cv1800-dmamux.c
@@ -0,0 +1,259 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Inochi Amaoto <inochiama@outlook.com>
+ */
+
+#include <linux/bitops.h>
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
+	unsigned long flags;
+
+	spin_lock_irqsave(&dmamux->lock, flags);
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
+	spin_unlock_irqrestore(&dmamux->lock, flags);
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
+	{ .compatible = "sophgo,cv1800-dmamux", },
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
2.44.0


