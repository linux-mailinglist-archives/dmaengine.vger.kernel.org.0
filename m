Return-Path: <dmaengine+bounces-1833-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8805A8A27AB
	for <lists+dmaengine@lfdr.de>; Fri, 12 Apr 2024 09:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3754D28186F
	for <lists+dmaengine@lfdr.de>; Fri, 12 Apr 2024 07:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D75F5029B;
	Fri, 12 Apr 2024 07:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="iMq43M49"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2024.outbound.protection.outlook.com [40.92.19.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2E850293;
	Fri, 12 Apr 2024 07:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712905653; cv=fail; b=OUTCO5VFWfwx21TQPiJVYcPAQov+kT/53rwacgBK5n/XCp0TX8OD1+uvn7/VM+hNSSRpH4nkXKWCt/3NcUxn27lqd8gJSSBnqQcylDD1mNLZ9CP2jcSvarVHjyfsE8nAggY2sYP58ZFEMSJzsNM2Arqz3f5HkGbHJhFSbVVRoB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712905653; c=relaxed/simple;
	bh=JAyHy+YA0aYNbZyDEp8mEDtdLqamjMswz0XLY/PSjAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BxIi+cc0Gb5Ep0aT010zALPIzyjQbzGHsY9l/cHjl2QKb95RFCWWbReLFvjm1LbwO9yUXKgL1nlsH6BUZ7QMKxM7vrPgCuVnDOHzhJB9/gGYsOOVN42xN1WftUQbDz1mbMQKXr4Hg5L78IIArUZVCSsQUFuC7NqywqwWf5oslqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=iMq43M49; arc=fail smtp.client-ip=40.92.19.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzhbWY92u91RYMomc1ZMmfKjKknqnALbfF26BSnkS115LRfjYc8z5Mp+3OEN9eSMgd6xFfAvJUXA87GwwV/TOnQ0MwUY/MUTKbzU2ABb5PDaePUbG9aAiWlGQVjG+EEykVEbn0BR4L7kbl9LFMf3V7A3ezUuUZ4roFRTZ1BBAUZCheCQDLae0MxA6mQPvbOS0jHgEYe7aI62M4ik8B2PpgGqmeUGhpiWvlbWilgLvtc36sDNcQfdRMrf4J0fOrdCOhlBt3hTFTOla+xiOBlzQxIAllwlEKuPRA0GPyOoc7voKkVgJIYWZdDe/Z6DAMa6xDW0UsISyus5H7LX7YMFQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVvw0KcRO3YlrxiYZpzerGioQkzY8USL+mN5SJYl50c=;
 b=mw7gkCbJbD6T3MN6Izi4FSSw+1ZmFkXtlalsVn2GjdFwqeGTkCzE0XbQPzXX8AHmZwzqHvfQ9kEvuvKlYug8rLBCXSk8v7FvnQRXto0m9Bn2H1YPDh4P9hVqZHuw+afR5votwluFR/WaTYjrDGyUBBl4DxEJXro1vxkhhLgrgbEPVU6HqGh7GMDomcAV33fVSNkRlpA3Ox3JX+btqRJZjIM5XPxT8rsocHUoSp+J8Q1rgL6CN3xQFBkbE1S/UfprjhanT8N9uuryPhufOc8odm0zTeduGBqOSTmWfw5f7DaJKzR2IJ2YZW+n0nieQ6exKWAH/+bAVxthXSHbCEZGbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVvw0KcRO3YlrxiYZpzerGioQkzY8USL+mN5SJYl50c=;
 b=iMq43M49xwlFcVzk1sUOSOX42+d/gfP3e9lQ0DcLkjplO4QJdGYg41NGXI+scKNfxF6cw6v9mq/OBjpyR238FRhPkv0Z8/8cpJNcoxT69V7G94B2DefcJsVM1UUQ8Hj+hO7PH9qUZUzpDFQTY2EpD6CE5oJWKbz7yJkf7F9peSiG6Tv7/BGHfvZNySLgikCudTiSrvNImj+i49xxN45N+z4QSZUYSxf6E5s5NddYsJwdjAegF9q/Pt55+C5SVZCQzZqB+Fqdp8pPQxsGsjRUgmjxh3tZZ1lHrWHdMSVIuIOuJdsGkqli3uiG+qs83qDp67t4x6s1aVzk6BxK6D86TQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB7440.namprd20.prod.outlook.com (2603:10b6:806:3e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.56; Fri, 12 Apr
 2024 07:07:28 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 07:07:28 +0000
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
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v8 3/3] dmaengine: add driver for Sophgo CV18XX/SG200X dmamux
Date: Fri, 12 Apr 2024 15:07:33 +0800
Message-ID:
 <IA1PR20MB4953438ED600110E71F9D092BB042@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <IA1PR20MB495359880A3A8C4947702BB5BB042@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB495359880A3A8C4947702BB5BB042@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [Ew1k9q9zfUc1qWy0jO/R5Et2HyYaKNcA/+OC/wcmUuo=]
X-ClientProxiedBy: SG2P153CA0003.APCP153.PROD.OUTLOOK.COM (2603:1096::13) To
 IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240412070734.62133-3-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: dc28f409-7d4e-44f0-34d2-08dc5abf36a9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zAmW6MuUYhd1OR7m6ipuB1WF1CBLxIIJU3p314auIOHrfJwvcfAWDMYSm8Ms7LagGja/QLFgJZGc2j+C5RQtnWpW5E/he9KcdWTVjpAo5OxbQUg9TkWo1l5rNKw5V2I8/cnUXLLetYPVUELGvZhtzHnvLJNF0BNxNPrMiYAfRiyN436YRa8AGwWSzQgGIxndgZi9vGobA8khcZDSpUru5apb1OZAn64Jbbd4NL5VHVcU92QgXtLanRi2t1tG3EZ0KRylmBUtEkdNAx33N+FBIYFMFGdGSbnKMg3mbYr5rX/9se3SwRs+ue1hYjreFa10+xoPmXlJI3kJ1zrK4NaQ/RDuLJs79K29bSEp3ip//Yf4PIuQWZ/+jpug2rekycAB/mkLHnn0vNc4qaE2Lzd2+JJtgwZq4UwCMUhezVJU2+ho2GkzST11F5dlVgyda0n1lBJyO9kolafaP1dOFAB9ZWtPgZQvX+9KcppWIejtlj6lu5aE5WCKKBbScEfXsTlc7xaDlcFnekgcDVAuf3oFrU85winflvSJg17GFjC7gOd2GJCWSDa+aM3CCay3TTayKKeqTWcUWLdBuVEsvGgGkQk9c43ngFUcKVr6mCQgXQ/GvdckHsVoWpRNno1t5lqD
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G553UnU15YLkNtqsiBj2SdVsYWfiyrw2fWhDSUoTp3xJkU7JPf7U0Wp3oMVB?=
 =?us-ascii?Q?6xOuGnIk58afxpManL9+rvLetsRkImx6tVMwFNQRkQoPxE6F4XNhq67lvgez?=
 =?us-ascii?Q?obYCg83/9zrPFA98BV44Q0i4yYdSnnXwSGIgVu4aNIPCbNegdyKeShw7kFT+?=
 =?us-ascii?Q?yv96UhNtSd8zKDBxK9qVRIhXdagpeCajIZIyUTEJg3qCEtpzxNObVudm95hC?=
 =?us-ascii?Q?cxga/fYcxtygvWG6IG9NXcqNzFbYWXdXG37nRVFXRZc0ZZyd0BMekFYJNvKU?=
 =?us-ascii?Q?rIW+kXVH/bFrAWZAISOBEQwwJrYK48qz5ErlaKqi+y24XosFKazN51Q4MjZp?=
 =?us-ascii?Q?ULIWlrmdLRC2nPkaakEFgDB7V1IchQQnpP5kf6kuVUVGtl/MSu1lEtU2brRi?=
 =?us-ascii?Q?myK191W02d5uD5t+gZ2f1UW00+xdqz/8ITD2VJ0N1gGYKW105I+BPTd2dWRh?=
 =?us-ascii?Q?Kpty3ojWcqjckSheKWQVYJHoVInLXsnW/akSFMjMcdEjR6aLQlrC8LwpAUvj?=
 =?us-ascii?Q?PfZ1eD1o+Vks0R7bRp2e28ml2YbY1bn+Z9MVGfDfgl6tJVFKqboJPynWlBJE?=
 =?us-ascii?Q?90Gkb2FovyW4i0Vj6s+fScPlH4bPro0fl91iw08WfWQjpzTR2/9vc+Na73WD?=
 =?us-ascii?Q?ECNu6kr8UjqxrJHsuf2k7DxwXI8ZQdNgakzmexjfwkU5TO+L60Y8kltM9/7G?=
 =?us-ascii?Q?myd+Q2dh1ScUUMbbkWFzXmGmwk0143dANvOzZpJ30k4LFCd2+igY9hJ43QqF?=
 =?us-ascii?Q?/yo5jpsW3D98FPx2b+vyKgmwfyA8CLPlv48Q+OS6ucPay8J9q3kDLDGlTk/q?=
 =?us-ascii?Q?x3rkgF/sKL5Hqh0NhYObU5gjfIL52Vb+GAME2pYP6WkL3NR1enOo6tr1pxkO?=
 =?us-ascii?Q?tK+bVNsEXgTmGsfmxEX/OkmRRuzqBTeHKgmhlhDhQU323XBtFAyDEOVOzdWS?=
 =?us-ascii?Q?z4efNFbnnGTdEAnYvMkUc0rWK/hReQNXCt2xIeopHMjMmz13S8PJCKcokaBE?=
 =?us-ascii?Q?tbu9kkGEvL8gd44PkezHctOg/jGYDHTHiOtUAYpKRZ04i2l+2nC3nWYPZcT6?=
 =?us-ascii?Q?TzU3u9ldz/PXr97FQAgEY4P11G1blphvsY5VrMfH+hG9GOdmHWTJp8tZ2EBa?=
 =?us-ascii?Q?IllyGUXbgJ8Kv1V4Fpp2jtWSMI1OhFGQpKBZQIr9TLVQ7vn8A2eK2YpKd+G+?=
 =?us-ascii?Q?ApCXmX8PSbtZdqLVhbeMQHNOKdvvw+32p9lMyUTlh/TRA3/5XOQq922+Yq8K?=
 =?us-ascii?Q?MqP0oWCulI1e9vlaI9QI?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc28f409-7d4e-44f0-34d2-08dc5abf36a9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 07:07:28.5754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB7440

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


