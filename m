Return-Path: <dmaengine+bounces-1050-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9EC85B8E7
	for <lists+dmaengine@lfdr.de>; Tue, 20 Feb 2024 11:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 652C41F21C35
	for <lists+dmaengine@lfdr.de>; Tue, 20 Feb 2024 10:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5FE61695;
	Tue, 20 Feb 2024 10:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="WA7+WW0N"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02olkn2085.outbound.protection.outlook.com [40.92.44.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0916612C6;
	Tue, 20 Feb 2024 10:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.44.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708424467; cv=fail; b=j+xqW2lmgIP0zYbcg3jKRw4JoVwZEcThXtfhqgP68HLskcuwbKVDCjBkcJCJQ8uCua7Xal8K7NvcCatrFRHSgP2yoNCh5AZmimDCbph37XUxIKtbyrlRWcfUTnkXhpBE2Ie5TkDlH+PQRl3XiZNDBUUSKVK+XDUtLGzpQKSNxMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708424467; c=relaxed/simple;
	bh=XXV6nMc8o7eCFYU7MSxbIzJnKa2S0VdxWQTsb2i7PhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SwJHEDVZt+XXm4f0MHSHWRkdVEg01mk1s7/4FEy7GhWGnSw4IsinzUGbxzKWt4Ew52EQNhd7Oa1wgWDbHs8jBXHOEvQOOMvG6bWQO/y5UIwwLHxPv6Je86f+J3fZehnQdkDFHT0wTfOO4PrPwIJ9WPkEQzZMryrZE/kU49ORKd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=WA7+WW0N; arc=fail smtp.client-ip=40.92.44.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QB+8+d+kT7xWxPIjF0D2OFwEa+oJkyrQU9kwLqP5G6Mf1rNElg5kCtY/2KV0dYfIWwU4/8Kdmz6TewPlLLVhL2ra2FrX/L1NLuXPWKoaZ2SeyWxKp1Fgs3EXM9jLlh2LqPuWzl0C+8HqFbPZk0ji2dqsMeVohvLz/o0gJSBOKDjCRF+apX6UeUets52xmwrMD085p4wmR0CJARP9rg3ERhMyLKPnvzvopY/Dq5QE/zDjcvcXbB+e9ay7Zwg0iHyD4p8pZWVl9eBqkt2mM80+sUnMSwaZawrvpSxbLuOB9Kbb5oCHAZx13AXX2tlzeRQDPga9VXIRAeh4a4Ucwmyd0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zn82jgskJdQbI2YTFjPDsz/iYp5K+2/rTbV3KNO0tHs=;
 b=mKaOyXkwNuB8Y78Oo3yoO1oeQKB2shyRXyHsA4WRCKx5p87RFUBR0Ye5IR6j1VPzWbqjhT8gZ+PQOgjRxbadkyNDFJsOnbQZBwa98ChhwmOAB3UGa1ykHtCZRCoPjn7NaRiKRBglpULAiRqbgj3rbKgqkPMDSpQG4CccOAJidwHRXR0vn7AHU5QVIt5f11ac89G43XE0m75jOqe8DbBAD1h43cIzk8wPO7mRw5zipYAifAVSV4AJnmlHHv2vwJyzMgdyJDQu1peXe3NnLI8Ax1SerB8eKfu8QTuPzP5O+C8ASinb0l1MaQIyZTmASE9EuGZ0CuPTCaFI/NqTRtJaiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zn82jgskJdQbI2YTFjPDsz/iYp5K+2/rTbV3KNO0tHs=;
 b=WA7+WW0NtYSeDj8lJ5SbesEPVkSgde25XMRjzMVTSwhEWICD9ctdYQwV3GyfmIwpmJBkwzCaOR7Lf4UfhMN0GWPiEpaAYtrV3hSFkx/VkXKOGriObiC3tuF+aBPvEPNjctbLrtfr7cx5jyN1lq1BTocxfHRae02pMRx9lnLid1Fp2jfg+Opn6ESsrSL3i63isg2MDPyZzGuE59pX8XmDYhjqjtwwQ+9Hf6sLjvLpnrgJrNpEdZ0qPKzkmQ9roiLauPaiQShmCaFghzlN+PAhmeHzJYhjnI8EKd9R/+gV0xyzcRGrXrytfpzwZ1qSts84SDYw14g9Zz/6f4ybQ/C0ww==
Received: from PH7PR20MB4962.namprd20.prod.outlook.com (2603:10b6:510:1fa::6)
 by MW4PR20MB5156.namprd20.prod.outlook.com (2603:10b6:303:1ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Tue, 20 Feb
 2024 10:21:03 +0000
Received: from PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::4719:8c68:6f:34ff]) by PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::4719:8c68:6f:34ff%6]) with mapi id 15.20.7292.033; Tue, 20 Feb 2024
 10:21:03 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: Chen Wang <unicorn_wang@outlook.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] dmaengine: add driver for Sophgo CV18XX/SG200X dmamux
Date: Tue, 20 Feb 2024 18:20:31 +0800
Message-ID:
 <PH7PR20MB4962E0305A1F4442012C721BBB502@PH7PR20MB4962.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <PH7PR20MB49624130A5D0B71599D76358BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
References: <PH7PR20MB49624130A5D0B71599D76358BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [xhYwH5W1ZUv8tffS6PV8774XUKoe9YY/wEnaoy6V9cw=]
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To PH7PR20MB4962.namprd20.prod.outlook.com
 (2603:10b6:510:1fa::6)
X-Microsoft-Original-Message-ID:
 <20240220102032.870200-4-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR20MB4962:EE_|MW4PR20MB5156:EE_
X-MS-Office365-Filtering-Correlation-Id: add84bab-e65a-4496-31a3-08dc31fda414
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fU/RaIwDfJ8FLtVmdK+b2a088Lkya5BX2LGajqcZz+QyIomnofXEunCRFBye0dlQeas1LA1TQhbwLRTKINm4OHj0gF/DQo8UamAMVe7yKl93/p/LQ3eX5Tnm4v8+reRK7TMb5uv235qCAbGpRijIxpNDo+Eess3bNc+6YAY1VIkC/Df3jYd6wKerQeoISAhBOhDcwClt4gWOFKVmph3RxZ5ZmKqi1uhJXRcmhD82MKxQv6mWVMmWKA+v6oClXc3Hg81nx7fxJ/jYo71F44H+0ZAZu5Zg0MwOpVk3oHtFo45vQFo+z5ZbPlR5M3nXu+MO/KMedXllnMFCiPdCYAMG90y4hWbzoq/+Gk79VuqUJs7C05sWCkmk8JI7LdtU0kBGPdY8l2fDcJrCDYLopwaP42Zpno+sbKQYprJIUrDaeNX0UV8QqhMu8MpSat1zNeBppzbSqNcfkcRrjNlay0j+XZN4hImY4z/BAFdct6AU7oWxWSImSaM/yiiGQUnKihe4SLIfydr1Ae5KA6ewc0rrtMVYTQA5nFfNizDss3mE9prowHZxD1wjgde8GRSU7eNQkt5HGt1nhhr0DrLiKBGu/Ms4qPYc+cBgWqsWi3q77RsD8/xY++b9wLfZVZ7rB1wH
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EnCOtqR8gM3cF6xLXjTku5zZAfJa4qVO3zP3waaexAYHjS7+5PvY0GJuwC+q?=
 =?us-ascii?Q?VkZhsKbQhGfTIMLqaRj5CdGW1whhMWAIUNwGk6F4fBl59103VsBab6IL3dzM?=
 =?us-ascii?Q?9LyCnGKhWxWBL8HAe4dwO0VAQRWYU1l+Zb0efWgYLRDCiX7s/cLphsFz7Usu?=
 =?us-ascii?Q?cIcZxyR8DdUi48ZhAEdXFD0Ers6/J5lYvSF0JL3sil0X+Q9bhDdj1ifzLDDw?=
 =?us-ascii?Q?3xoMY+USBu217pPO6E39OrbDNil+mnFvwSGlMDT+8Gng415jb9ZVkqbDiquR?=
 =?us-ascii?Q?LItZpM83vPhq1FJo3I8VFtZ6A/PHm/Cxs9paRIbz6dAfxhrgxyujIB9pCQ4E?=
 =?us-ascii?Q?f82UqWAOSEqqKVJM1ezh3+hmRpFOKpfQGDKN8WmQtOR5VtM4Ke3HkuV7niqH?=
 =?us-ascii?Q?IR952o1GxzhRSy/oz2ntJ/OJWYyB1qvtMa4AQ4LadVLXTI6GuNK+l/zV7M3F?=
 =?us-ascii?Q?GCjh3DUks43qlqfNxzY09cFrorE6oN5f37g9zJwHcbDZmOKg8utH1Duq0q6A?=
 =?us-ascii?Q?BFFDjoNKBUshYAUV29TcCOH/ZW7bYlLiyExHogUyHCXnekrqYn8JUfVBiwVD?=
 =?us-ascii?Q?vxxRrBXm1RT/ZGduzYaFyjVQZ2etl3Iw1GXcT5aZSQgIZbennHXtg77v2eBp?=
 =?us-ascii?Q?7XN/XHlKyX9CBqyVjCBUHTEKPK0fmAujX8H7PafYlpzqdEyrYf/exN47972t?=
 =?us-ascii?Q?IATTjWMZxJLZwvBYZq768re3iusbdEmWho3sD0vbQwMf/eftHgg6rerc9M+/?=
 =?us-ascii?Q?+yhArRlMrnGzEDoXwmIutce8y3eBxSdhepv9VjnlZmuPR81FkoqBGIH+0j9p?=
 =?us-ascii?Q?ygCuP8KqAiU4ABpJ/9ObiS/TXcRwekX/iSC7aY28GZb5JBhPKooqOGtsVzjQ?=
 =?us-ascii?Q?VHQyRrj0Q5aWliR3uUfn+X3O0pc9OsKj2CSdB2XL/WNAjh1yHJbnnCkS+Jkj?=
 =?us-ascii?Q?t/WptdBYtsPNO6zRVGQGtmBDPisMxemq5Em3uH2whsusMDqzSXq2Uv3Y9L/6?=
 =?us-ascii?Q?WWI5sp9nSa8/Hc3dQbvsiUXLQx6tO6GgFgzgDJapCiaiJOiPh0yBfqXnZ73y?=
 =?us-ascii?Q?bQXeqlXq6zkNgExsZrqW4rXCrAUj8X8LzWO1xGmrFLagwHNTfROJiKLec1+i?=
 =?us-ascii?Q?SgeuErPKQ9B1WixvXWfJcRnbQRIQAKWbvMr07TEHxpEveH3oqA2WhVah8MSf?=
 =?us-ascii?Q?EeGmjgvjpppK4Fwt5G83YYasvXKTeSG7cgxmigkOKdjJ+3IOCHJkGau1f8Ne?=
 =?us-ascii?Q?cRSC6aMH0I3rldQlyNAO?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: add84bab-e65a-4496-31a3-08dc31fda414
X-MS-Exchange-CrossTenant-AuthSource: PH7PR20MB4962.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 10:21:03.2379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR20MB5156

Sophgo CV18XX/SG200X use DW AXI CORE with a multiplexer for remapping
its request lines. The multiplexer supports at most 8 request lines.

Add driver for Sophgo CV18XX/SG200X DMA multiplexer.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 drivers/dma/Kconfig         |   9 ++
 drivers/dma/Makefile        |   1 +
 drivers/dma/cv1800-dmamux.c | 232 ++++++++++++++++++++++++++++++++++++
 3 files changed, 242 insertions(+)
 create mode 100644 drivers/dma/cv1800-dmamux.c

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index e928f2ca0f1e..5220b4eba3a4 100644
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
index 000000000000..b41c39f2e338
--- /dev/null
+++ b/drivers/dma/cv1800-dmamux.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/module.h>
+#include <linux/of_dma.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/spinlock.h>
+#include <linux/mfd/syscon.h>
+
+#include <soc/sophgo/cv1800-sysctl.h>
+#include <dt-bindings/dma/cv1800-dma.h>
+
+#define DMAMUX_NCELLS			3
+#define MAX_DMA_MAPPING_ID		DMA_SPI_NOR1
+#define MAX_DMA_CPU_ID			DMA_CPU_C906_1
+#define MAX_DMA_CH_ID			7
+
+#define DMAMUX_INTMUX_REGISTER_LEN	4
+#define DMAMUX_NR_CH_PER_REGISTER	4
+#define DMAMUX_BIT_PER_CH		8
+#define DMAMUX_CH_MASk			GENMASK(5, 0)
+#define DMAMUX_INT_BIT_PER_CPU		10
+#define DMAMUX_CH_UPDATE_BIT		BIT(31)
+
+#define DMAMUX_CH_SET(chid, val) \
+	(((val) << ((chid) * DMAMUX_BIT_PER_CH)) | DMAMUX_CH_UPDATE_BIT)
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
+	(DMAMUX_INT_BIT(chid, DMA_CPU_A53) | \
+	 DMAMUX_INT_BIT(chid, DMA_CPU_C906_0) | \
+	 DMAMUX_INT_BIT(chid, DMA_CPU_C906_1))
+#define DMAMUX_INT_CH_MASK(chid, cpuid) \
+	(DMAMUX_INT_MASK(chid) | DMAMUX_INTEN_BIT(cpuid))
+
+struct cv1800_dmamux_data {
+	struct dma_router	dmarouter;
+	struct regmap		*regmap;
+	spinlock_t		lock;
+	DECLARE_BITMAP(used_chans, MAX_DMA_CH_ID);
+	DECLARE_BITMAP(mapped_peripherals, MAX_DMA_MAPPING_ID);
+};
+
+struct cv1800_dmamux_map {
+	unsigned int channel;
+	unsigned int peripheral;
+	unsigned int cpu;
+};
+
+static void cv1800_dmamux_free(struct device *dev, void *route_data)
+{
+	struct cv1800_dmamux_data *dmamux = dev_get_drvdata(dev);
+	struct cv1800_dmamux_map *map = route_data;
+	u32 regoff = map->channel % DMAMUX_NR_CH_PER_REGISTER;
+	u32 regpos = map->channel / DMAMUX_NR_CH_PER_REGISTER;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dmamux->lock, flags);
+
+	regmap_update_bits(dmamux->regmap,
+			   regpos + CV1800_SDMA_DMA_CHANNEL_REMAP0,
+			   DMAMUX_CH_MASK(regoff),
+			   DMAMUX_CH_UPDATE_BIT);
+
+	regmap_update_bits(dmamux->regmap, CV1800_SDMA_DMA_INT_MUX,
+			   DMAMUX_INT_CH_MASK(map->channel, map->cpu),
+			   DMAMUX_INTEN_BIT(map->cpu));
+
+	clear_bit(map->channel, dmamux->used_chans);
+	clear_bit(map->peripheral, dmamux->mapped_peripherals);
+
+	spin_unlock_irqrestore(&dmamux->lock, flags);
+
+	kfree(map);
+}
+
+static void *cv1800_dmamux_route_allocate(struct of_phandle_args *dma_spec,
+					  struct of_dma *ofdma)
+{
+	struct platform_device *pdev = of_find_device_by_node(ofdma->of_node);
+	struct cv1800_dmamux_data *dmamux = platform_get_drvdata(pdev);
+	struct cv1800_dmamux_map *map;
+	unsigned long flags;
+	unsigned int chid, devid, cpuid;
+	u32 regoff, regpos;
+
+	if (dma_spec->args_count != DMAMUX_NCELLS) {
+		dev_err(&pdev->dev, "invalid number of dma mux args\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	chid = dma_spec->args[0];
+	devid = dma_spec->args[1];
+	cpuid = dma_spec->args[2];
+	dma_spec->args_count -= 2;
+
+	if (chid > MAX_DMA_CH_ID) {
+		dev_err(&pdev->dev, "invalid channel id: %u\n", chid);
+		return ERR_PTR(-EINVAL);
+	}
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
+	map = kzalloc(sizeof(*map), GFP_KERNEL);
+	if (!map)
+		return ERR_PTR(-ENOMEM);
+
+	map->channel = chid;
+	map->peripheral = devid;
+	map->cpu = cpuid;
+
+	regoff = chid % DMAMUX_NR_CH_PER_REGISTER;
+	regpos = chid / DMAMUX_NR_CH_PER_REGISTER;
+
+	spin_lock_irqsave(&dmamux->lock, flags);
+
+	if (test_and_set_bit(devid, dmamux->mapped_peripherals)) {
+		dev_err(&pdev->dev, "already used device mapping: %u\n", devid);
+		goto failed;
+	}
+
+	if (test_and_set_bit(chid, dmamux->used_chans)) {
+		clear_bit(devid, dmamux->mapped_peripherals);
+		dev_err(&pdev->dev, "already used channel id: %u\n", chid);
+		goto failed;
+	}
+
+	regmap_set_bits(dmamux->regmap,
+			regpos + CV1800_SDMA_DMA_CHANNEL_REMAP0,
+			DMAMUX_CH_SET(regoff, devid));
+
+	regmap_update_bits(dmamux->regmap, CV1800_SDMA_DMA_INT_MUX,
+			   DMAMUX_INT_CH_MASK(chid, cpuid),
+			   DMAMUX_INT_CH_BIT(chid, cpuid));
+
+	spin_unlock_irqrestore(&dmamux->lock, flags);
+
+	dev_info(&pdev->dev, "register channel %u for req %u (cpu %u)\n",
+		 chid, devid, cpuid);
+
+	return map;
+
+failed:
+	spin_unlock_irqrestore(&dmamux->lock, flags);
+	dev_err(&pdev->dev, "already used channel id: %u\n", chid);
+	return ERR_PTR(-EBUSY);
+}
+
+static int cv1800_dmamux_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *mux_node = dev->of_node;
+	struct cv1800_dmamux_data *data;
+	struct device *parent = dev->parent;
+	struct device_node *dma_master;
+	struct regmap *map = NULL;
+
+	if (!parent)
+		return -ENODEV;
+
+	map = device_node_to_regmap(parent->of_node);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+
+	dma_master = of_parse_phandle(mux_node, "dma-masters", 0);
+	if (!dma_master) {
+		dev_err(dev, "invalid dma-requests property\n");
+		return -ENODEV;
+	}
+	of_node_put(dma_master);
+
+	data = devm_kmalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	spin_lock_init(&data->lock);
+	data->regmap = map;
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
+static const struct of_device_id cv1800_dmamux_ids[] = {
+	{ .compatible = "sophgo,cv1800-dmamux", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, cv1800_dmamux_ids);
+
+static struct platform_driver cv1800_dmamux_driver = {
+	.driver = {
+		.name = "fsl-raideng",
+		.of_match_table = cv1800_dmamux_ids,
+	},
+	.probe = cv1800_dmamux_probe,
+};
+module_platform_driver(cv1800_dmamux_driver);
+
+MODULE_AUTHOR("Inochi Amaoto <inochiama@outlook.com>");
+MODULE_DESCRIPTION("Sophgo CV1800/SG2000 Series Soc DMAMUX driver");
+MODULE_LICENSE("GPL");
--
2.43.2


