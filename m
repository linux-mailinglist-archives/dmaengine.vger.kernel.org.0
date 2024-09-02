Return-Path: <dmaengine+bounces-3056-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FAE967D06
	for <lists+dmaengine@lfdr.de>; Mon,  2 Sep 2024 02:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3F52281A59
	for <lists+dmaengine@lfdr.de>; Mon,  2 Sep 2024 00:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A7A257D;
	Mon,  2 Sep 2024 00:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Z6cotogc"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02olkn2065.outbound.protection.outlook.com [40.92.43.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C6EB65C;
	Mon,  2 Sep 2024 00:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.43.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725237547; cv=fail; b=RKPjHRoQjjjA5GZ2lrFgWUvuaQCM+Z6BoeVGdfZStDXw53hSeuUA24w0LJnMvhfcESsL+39xmIKD7K6+6auPHUzbiBAlArSSx71cSStR74HkeTYT75KUOp6HqBxu9MaQTwyzot3BNQPJtb0VmUmGTzbQeqc8bnqfgZKiq1cJt9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725237547; c=relaxed/simple;
	bh=oECP76BK132HcgNXru9CMZj102Rv9NsH35sqxylg6+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sA9lYcKgJMfQBND0jfPGcNNxOQvdOU3N12UDDwEcQ9CUq543rOmAL4RDTdUD7sQMxKCtarKK6u/tFyYYgJdrq3Bv9qTBmz1li8Q7cpy8S/1df5nnlZn/KWSrE/Iko3G/aY12yNeJT+7J0f70X1LKNnJtipf+L1SThSej8Db3iPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Z6cotogc; arc=fail smtp.client-ip=40.92.43.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RxMwbaiA6d2qBEzKBYoF52RaSXTyIZxKSXh7LWQLRbYT+2IUuK7JWirDLQctdbYO+aGRitxwLKzeIoUmPRDeVhGjFeYlXJJcGesEyR4wf+jTdPwy2byp1QllXPTDzEEdf3W7IOpD+rnlSr8/OvE2QvjsiLJMERRXO4i7CB9uk+kT/F5lz+PAHthyn45ErpYWd7b3Duf8+XDCN7UxEB5QAya/ISvqtyKi7ywDx8rZEhBvDUffl52+NmvYquyyUgffk96A+joG6yBOzy8ALiruBC2cQHrvGBcntY5ZisH/fEARmKYdVo2S6MoDWhpNn9OPBd9nlT0jEtRxmN9Vh41CZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVHMsX7MfU7pe13sqL9LwukDPCDepSplw/bfrqZvmaE=;
 b=Wa7A6k94cK3e2tObdMfOV3bnvZk/ejmzbW5vrYUimOzf77g6JhofyVzdJ3jmPJDm1MnadDPBGjQ6dtuFVJvsYtchH9YSLjyo8GD0zvrQb8ltEXxm1W0eJijRGsje1ppL4gDACeTEzyuMPw+SN/fcfwCSqFveTl76T3/Fpy0m6j4FkDiWYLPb+yBnQ2CCISvzshMlskiAHdVZJRBwXLjvkBVMznYuNLx7SKdBccmuwSN4ulIx0XaL2kcoYIuJECilXz3mQJsDmtieEuwckCLnh918J9fmqXi5kewi+k74E5tbDRtTi0M+XoWI9HUspl0xpdtXw8a4vRVJYjiMbFKq8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVHMsX7MfU7pe13sqL9LwukDPCDepSplw/bfrqZvmaE=;
 b=Z6cotogc9AnmfWEZfm/FXUuGKj3voNV9eNzcu4E9X/4Zlb8UMBl1AL0pW9e/CDNEorWWyiQLyMWDDsJajp2qpmWKOJqVIzE8Pv/BNc62rfMpIRZ1nt+l8OylC9+J/b96EcaOtMsIEChnxPeBcqkivO/qMXUJZM7uK7V1EI4LB2ZVOvHYPPPjDzCsOFqbgR3aJbd5mw767MHhYbw0WiTMqggGCRvbkZp3qVFlgyKBvukj7zxtP7njsZsUog3tCqXY1rFMmLpNqfWGjamBP9gE8vZNgBKDWbJ10MQZcYlZUulsSm5ubf6x8OtPmUuG9Nm6ZvyAbAe0DGMMiIxL6OgtHw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DM4PR20MB6766.namprd20.prod.outlook.com (2603:10b6:8:be::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.23; Mon, 2 Sep 2024 00:39:04 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 00:39:04 +0000
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
Subject: [PATCH v13 2/2] dmaengine: add driver for Sophgo CV18XX/SG200X dmamux
Date: Mon,  2 Sep 2024 08:37:55 +0800
Message-ID:
 <IA1PR20MB49539913AE08C1146A351733BB922@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <IA1PR20MB49539E5AB43E44E9DE5473F1BB922@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49539E5AB43E44E9DE5473F1BB922@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [mWBqxmrbG6GTHOUQ5dDeoc/ABCLqVBkjzDaiZcKcXOk=]
X-ClientProxiedBy: TY2PR0101CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::32) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240902003756.217629-2-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DM4PR20MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: 171b0115-a06c-4d20-5661-08dccae7a52d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|5072599009|8060799006|15080799006|461199028|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	XiE9FBYfG0bvNRnOok2Lduu4sSoweYFlcH64BPAF/7rLs9Cy5vwZXDhIIDnRfTZMlbBRtM/qdgd2/8MbVWKDV/UqYUhE8YO31gncl2C2EVC4E3uGdWh6SPZtvAmM8QwF3tDRW45cq3GzJ0dV/VrGRI8jqC1Igy/030ueDbC0Aimc58wOlUXFatNvFWVzTvPhZsNCrhhMlN3PiZbW3i7tzAsRq8xtm/ATewTbZb1uhl5PU9pqR+OS5Uvv1BNY6da0eBMUU6r5uY9R1m8tvH2jQ2Dxnw7t2bFTXXNB003VTMAHudoGOfOIgSB+08hMW1SCFAaK0oh3dxIZweEPZwzjBMkNhLKk1QCAOH1q0R+GGy7AS1+3hMsJB50yKOmQuHGMOIc54BL1htc9qqkx9ymOn8N67cEmCr2IlHPfewiczQGvWpE/v1Yt24sivSn9l01JyEmir+F3F5/ZBSKOqB8VL00Pc8/4YGBRhFDz8PLHmTtPCcGC+D+f0xXYGS5Udmr2hyv8XEqw6W3Uivaih1IY8Mn3Yb5WaxoT7s5agaxcrsLaVJyNs6mL4SewvOotDBji5pz8B5gNn7k3sJNwJNy9zIoXu0nU+usVYv+yI+/wvbFYXV2ODs0H3HSFmmpG40IjhBIzxL54u7mBJEVXqFq5Rs7PqSxyZdt4zjJ1hgbzpyJyefipn8K3/PUgLvYc4P7IP/v8DXDgBewWnklFbe+w9g+PrlhUcyRvEnKQ7DLJjdI=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j7u8TuX1TJ1nnF43TgFND2ojlHolPDfx9+SMjglyf64Ugx9xVQw/I9UZEeKN?=
 =?us-ascii?Q?Kku0ogQuYITAVcZd9wl4Uix9qjC0cE2KiYxD3ofmlaNINwg5trDixB5eZMT/?=
 =?us-ascii?Q?wOKGIIvV3rdBYSQ90i/W4T98cctWbM5Q1DOAQSzWXMKwFobILUvnTbDiNl/J?=
 =?us-ascii?Q?bYAWfwNuw33Q5AuZOQ5Q+fWBmz2sqREuRcd5+Q3FScImlzTUj1nzmTShWSSe?=
 =?us-ascii?Q?8pDliaopoNcY0o/6tfR082Mi/SYRMX3VCVkpmRoRBo/3vSSZxmVqjgu5pQQJ?=
 =?us-ascii?Q?o+nLbE/AOkUquKXTz1tIM145vtOCtKVLyT/jEBNm8QZcmjSlfGamKSsJpgfi?=
 =?us-ascii?Q?+sWOSS1gxwhwk/vPKIbxhsSEPw2Ik38hYvK1oqqd/CGFWp822rlZeedG1IdW?=
 =?us-ascii?Q?TFXZiM+M+E/NWCogpvXZ6eDexmH3/SPYu36Wj8HNbQXxns3uU8Pwbv3FU4B3?=
 =?us-ascii?Q?OJ9bJg/XuFzda6c9obZkp/v3qYLGOeB/NLOwp+3pkR8Q2sbJRhv3mn+63HHf?=
 =?us-ascii?Q?i4NPd2USNLdpjVbEs+DA77Udqp2gHDp6ALAGMU/NKUNApbIDNV+BSMB7ejry?=
 =?us-ascii?Q?/drbSV3PZGAQnjkbTGc6byjUZqG2I2veic6pGOerJzS4hOaSPOztxM8VVnZP?=
 =?us-ascii?Q?GSq4rtn+0C92Ytgt+jV4G/LDhmIRQv7RUBBpzQHqSQVNObOFPaeqXW03CDfd?=
 =?us-ascii?Q?/JFeoQ+MSiHAEEhBSFCB6p2tOW/b+oPuRL5lsuJtFysNAxnK21Te/Mv27VBU?=
 =?us-ascii?Q?XZMf6GcoCeV+MNvUECOiUbaWrrGnhGJewaYokO5DqI64ZqwUMYBD811Ta4Oe?=
 =?us-ascii?Q?nEddyo+UN1oO9JRGDrBaPZTw4MRteyZRWqAbQT2YhJ4pBJuH8R6h4ugWRdte?=
 =?us-ascii?Q?q8kU79Ht+gCvbSyLwDBxweZaH+HyZykZXT4RLIiOvNYAGvbZjogupL5eCcmA?=
 =?us-ascii?Q?vzJOPQN6l8JdSeLdYIWvIBzNupEqCou8/7oxF6OkIOJtyRQIO9H6oe1CrO8A?=
 =?us-ascii?Q?pn+aMcpli/6oCOlm+iwrONCLON8BiR4jQMKBfjbCLWz54NZWwyQPUM06LEwV?=
 =?us-ascii?Q?nFoD4yDrWcmcMy1cGaGl+cQZjRheu7T8Xc5Q251nKm3iJfJPvvSt9KbROS9k?=
 =?us-ascii?Q?aihTkDa7eFMZSJ6Q2B+IHShhrthxldk7fHQwbTjY12/JLhk8t/c+WFXy7Svv?=
 =?us-ascii?Q?L+OopZzs+iPh3TkjeS/4QcLvAc+iNL+50SDkw9jOIRXpekzD0Wl4Y7XwQMLl?=
 =?us-ascii?Q?I8k1RY57lnQm+dtnghYw?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 171b0115-a06c-4d20-5661-08dccae7a52d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 00:39:03.9950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR20MB6766

Sophgo CV18XX/SG200X use DW AXI CORE with a multiplexer for remapping
its request lines. The multiplexer supports at most 8 request lines.

Add driver for Sophgo CV18XX/SG200X DMA multiplexer.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 drivers/dma/Kconfig          |  11 +-
 drivers/dma/Makefile         |   1 +
 drivers/dma/cv1800b-dmamux.c | 260 +++++++++++++++++++++++++++++++++++
 3 files changed, 271 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dma/cv1800b-dmamux.c

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index cc0a62c34861..824f87d283ad 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -446,7 +446,7 @@ config MOXART_DMA
 	select DMA_VIRTUAL_CHANNELS
 	help
 	  Enable support for the MOXA ART SoC DMA controller.
- 
+
 	  Say Y here if you enabled MMP ADMA, otherwise say N.
 
 config MPC512X_DMA
@@ -546,6 +546,15 @@ config PLX_DMA
 	  These are exposed via extra functions on the switch's
 	  upstream port. Each function exposes one DMA channel.
 
+config SOPHGO_CV1800B_DMAMUX
+	tristate "Sophgo CV1800/SG2000 series SoC DMA multiplexer support"
+	depends on MFD_SYSCON
+	depends on ARCH_SOPHGO || COMPILE_TEST
+	help
+	  Support for the DMA multiplexer on Sophgo CV1800/SG2000
+	  series SoCs.
+	  Say Y here if your board have this soc.
+
 config STE_DMA40
 	bool "ST-Ericsson DMA40 support"
 	depends on ARCH_U8500
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 374ea98faf43..04d5a3a0a6a8 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_PPC_BESTCOMM) += bestcomm/
 obj-$(CONFIG_PXA_DMA) += pxa_dma.o
 obj-$(CONFIG_RENESAS_DMA) += sh/
 obj-$(CONFIG_SF_PDMA) += sf-pdma/
+obj-$(CONFIG_SOPHGO_CV1800B_DMAMUX) += cv1800b-dmamux.o
 obj-$(CONFIG_STE_DMA40) += ste_dma40.o ste_dma40_ll.o
 obj-$(CONFIG_SPRD_DMA) += sprd-dma.o
 obj-$(CONFIG_TXX9_DMAC) += txx9dmac.o
diff --git a/drivers/dma/cv1800b-dmamux.c b/drivers/dma/cv1800b-dmamux.c
new file mode 100644
index 000000000000..e3137500bb11
--- /dev/null
+++ b/drivers/dma/cv1800b-dmamux.c
@@ -0,0 +1,260 @@
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
+/* Offset of the syscon device */
+#define SYSCON_DMA_CHANNEL_REMAP0	0x154
+#define SYSCON_DMA_CHANNEL_REMAP1	0x158
+#define SYSCON_DMA_INT_MUX		0x298
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
+	 SYSCON_DMA_CHANNEL_REMAP0)
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
+	regmap_update_bits(dmamux->regmap, SYSCON_DMA_INT_MUX,
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
+	regmap_update_bits(dmamux->regmap, SYSCON_DMA_INT_MUX,
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


