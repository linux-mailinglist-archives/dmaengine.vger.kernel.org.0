Return-Path: <dmaengine+bounces-1055-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D13A85B914
	for <lists+dmaengine@lfdr.de>; Tue, 20 Feb 2024 11:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDD6F282693
	for <lists+dmaengine@lfdr.de>; Tue, 20 Feb 2024 10:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574C3612C9;
	Tue, 20 Feb 2024 10:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pUKuacQ0"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2091.outbound.protection.outlook.com [40.92.18.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600D25F470;
	Tue, 20 Feb 2024 10:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708424974; cv=fail; b=mGT7dUM3yMFsEJGJcdNAaqCVnJXzwKor2YjD0I4OdudLZmAOnsgdo6X7GOyEy88HT+bfjWpaEbP3yJngWWj8M+vplP4rBXIycbFu9mcWORQv+zbiLgdrob9do9Jn3uZovTN04yllra8KFEUdwDZX3v0KULLgrVGKhn9mh5lBCyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708424974; c=relaxed/simple;
	bh=XXV6nMc8o7eCFYU7MSxbIzJnKa2S0VdxWQTsb2i7PhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uNJVVjC5SEjEDX1XgR/i0tC4w5TIltXcKbKlf9n7u7yJVVD8YtkoNuKYZI4STEQ9EIRxZ9cLi4BRnTNMaVs9y2gJCSl71k46+M5GvnZGUxxlkeBkAgeq+80xyUF0JZCwlB+A8P63rYt2i8nMGha4wgSPRun5LhYx+ONuieCoOT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pUKuacQ0; arc=fail smtp.client-ip=40.92.18.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtsayK6sxhF47/qZM8u3g9EJ19npQEglkyMJAHrHDRpx7LquQnUDQ92yMC760lJ5WDoT0qwHFhPZfC8Nc7sJJF53wtNbseuD/ylASaeAlfUMnVPHW4noyWTbr7IdCCqj/CMDOiYSvJWNckyUuDMTyOx7nsAkXrPWb14D06vp/XU5jbZumxxfJ60HzvXQ3+YXpteQV45yYrPJLzqqoUcoUrrC4GImLvW+csHQyQ8TWvAFYxiDbV+ERPLO/DqnuCecExE4PeGNubW8O45dEN0cyI7wpy75+LoGgpOhZ7bA9AJyE4PABQhgcH3ftevMG9JZvZ3KlqUV9zJLShIn2ORU0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zn82jgskJdQbI2YTFjPDsz/iYp5K+2/rTbV3KNO0tHs=;
 b=fzCGen8u9zpd+6UlBmBVialhoWKCCeUGDFUPuBpYXOwZr7w48UoifWX8rmz+XPPGj+i00ZTzRbG3GHCeZ0lt/wcE9sPyoDVU8EY9p7Dk5Kk8ieKoyEiVaYkdNBlZotrDuCZ2fYLEnABDa4JV7anIpuEi7yIZf6Qzpfbrp/z1tcJ6iIFHpnZ9KexbOvEbQ66+1gP+HC75lZB+XKOBJL52k4XLfwr7p5sGNLW80Gk90XrFfZTkbl85RU+AUe2HydxS8ns0YFgzbEXTQEH4Dv6mKgCGqFl7F7Qtffi2egSusP5zUmCT1HcIZHsNMFv1ws3BaGUWvfzqOxURjyVUmsxcrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zn82jgskJdQbI2YTFjPDsz/iYp5K+2/rTbV3KNO0tHs=;
 b=pUKuacQ00Be6x1tkUPanJNFZMXDqC+McJZWQYttgTi2xtqchQgOwQyJjwKWBb7NplTAi13Er0GJSx5KC8ZZVLC1VbVEpWNuMoAxn+8EN5O8D2Ubrlt69UNFvbnxdBBwJsOVAzWkZACPsNHYIU9AZ62Vl577sno3MJsyGxsgS+ytEwUAqHWP1e1cQPaXimSafCOGkDJK4qVpiocuqS0O5ClToULMNdl+PfojpBcOhq1Slc/+tJGeJ3/nOlwy6skP+TvRQ0yeutRQdq1sFyRYoE1KswRWv0m94DXuaHhrrqUlNXAsdvaOiPN76cbGygAcqnSVuV+u0USMwhKKp00VuOw==
Received: from PH7PR20MB4962.namprd20.prod.outlook.com (2603:10b6:510:1fa::6)
 by IA0PR20MB6813.namprd20.prod.outlook.com (2603:10b6:208:405::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 10:29:30 +0000
Received: from PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::4719:8c68:6f:34ff]) by PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::4719:8c68:6f:34ff%6]) with mapi id 15.20.7292.033; Tue, 20 Feb 2024
 10:29:30 +0000
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
Subject: [PATCH v2 4/4] dmaengine: add driver for Sophgo CV18XX/SG200X dmamux
Date: Tue, 20 Feb 2024 18:29:01 +0800
Message-ID:
 <IA1PR20MB4953C0514E8F5B9A4F6DA608BB502@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <PH7PR20MB49624AFE44E26F26490DC827BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
References: <PH7PR20MB49624AFE44E26F26490DC827BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [6TBxqLxCPsW85B8tYi4fwxmgBUMa8fdCNcudmz+EGEk=]
X-ClientProxiedBy: KU1PR03CA0011.apcprd03.prod.outlook.com
 (2603:1096:802:18::23) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240220102901.874602-4-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR20MB4962:EE_|IA0PR20MB6813:EE_
X-MS-Office365-Filtering-Correlation-Id: d09be249-9f8d-498e-7e53-08dc31fec830
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LufN23+q/h7bkojuWVFhbAsf15D+yxn5u/taUFqElaQi+YnzuLYCH9e5oY7Eck1ydKNlihJKTCHJhqio+ZjRovRV9IG6nFS392FHTQlbVS/ikpeQO7G2RHi5jlDUk5xYw8in7IB/B9XdkKnI2kTWCublSajNoxD4CabOO92Kvy7rZhI/E7bq7DnnSR/kMrvonl+r+RfCpqWGb76+tMd+k7vdrZJDYtHGPD/ZhwHeC3xy46ap/iw06KH4nDgMSrqt3EVeOPSJXWwA+EmV9T3DgX7pc8P/MPrNYwP5a/ri/o6qx25P/euJDsmtbmwnd4Gsuej4xGb+VmSYQgU6TsbTA1SFKGVxJy0MNfWYcVc61WlKgDLpIzwswLsVeGOYsUG2coPt18lMG/fs6SoGGe1tTYkZxfgTPKruaxvwplZy08rm3xcP55ay4O5Mq0pg4T//DE0gn3SX1HvkvoZDpba6HwTj0XW1ri74we6IZY4wmbGjKukpNJW2OQMnswy+Pnyn9S3aaZHz1l06rleMCX9TVMMAQyU/GyfB5CzhvouBEr9glFbmaKbAZfkZXzintdLsuWIS7ZZ/FUDitK5N2PfnH1o2bTabMUhbz2hR038nbYmphG8sZmEgbZVvDfRnYuNo
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hbsD2Gp+DdgbFarZun42uzlHJ0zKNW97p0luFGBjW+cBzoXfPrpjK21V+MhQ?=
 =?us-ascii?Q?4YMfOz1hA0SySgWbFhfGnz9WRsa1c/wPI++08H9J5wTYEWg6w8PBzNRKudVf?=
 =?us-ascii?Q?fvZWl9IcbAaYqlJL1PrvB7ZbgtI+r2cUtH4fmKLEmncCrBEH2WmEv+1VWlZx?=
 =?us-ascii?Q?uNfsT3lfiGrel7I2APFoZ/hwGPStAvN+czB5vhEoCwu6riJ8PihN1m7rLK5i?=
 =?us-ascii?Q?hNJ1RPDTGk3fJuCJ0yXUJUJARq/bW18aRxMq3I8akK5Y0Lvr31NNng5pXtkD?=
 =?us-ascii?Q?rqz02AW3rOLYEkFu6OMdMpjhPwBJUDxQflMSe6iRoy617CEq6ltqBK0RxQTi?=
 =?us-ascii?Q?nFCAbZ4a+MKr5UG20k4YE7R4MpxMLOXIqoqd6Wwzvz80gzo4+bXojOiFzIPO?=
 =?us-ascii?Q?m6q2oCfr902g4JSh2ZmoaWZXvMvVu8QxsBIlaAEfB16mijX8xQWFTj5/xv6c?=
 =?us-ascii?Q?zSuuzd+h0nVaL4liTqqJFIL/etCpMv88uzggpJu696Jn0q+NJXkAKjfz+FVM?=
 =?us-ascii?Q?yB+TkkGWnA8xIsCIqhHaXYzm14C//y9Y/x/bkBp0U/CBI90WrwpLFEiDR61J?=
 =?us-ascii?Q?b0ZEzla0k0iKbu09CcOwpeYyAYD4CRoUWNsXwWfg6F5YnC03dMa3/6fPbk00?=
 =?us-ascii?Q?a/nvQW4IysmKG46hSn0tr2qlLcfCFENI34SdHZR2QTG8KrNfrvB721GJ1XS8?=
 =?us-ascii?Q?BveVDKbkbJp1W2QDqNEm2DcOaHg0DSX7udB8HpAiRb4IjTRrAq47zZdXv02m?=
 =?us-ascii?Q?Fnr6HvdpIzqabCAcZ38N11Et0E8Fesk7ovkPWSvdDjp0LubUqfHTbuorFTIb?=
 =?us-ascii?Q?L6r60sXo75JNKV4RcPWFXfdTxftfqJejTBFNcr2p96fmlu+kKbKTvYXv0GyU?=
 =?us-ascii?Q?XZVd/9JnMqvDvBFOZ3814ZqRUek3elXRrAGBsIyyJke+kVwZb7PvpeXkWk6Q?=
 =?us-ascii?Q?wyauNUQwCTVqoj9uOnsMgvkK2uNcUQb9aC1gDJ3GdLE+1LZblvnU+7uvSf0I?=
 =?us-ascii?Q?41ckbS+gOgtsJdqP1zKHir/MtWPQhGbzyNvJV6/uOIFKto9T3k0ToLPrvT0a?=
 =?us-ascii?Q?miJJGvJFzRjZArmIUurAE8+YhjV9aTmS5YEcOv3qS6Sbct3WgBBtz6P93Hew?=
 =?us-ascii?Q?QSHhlRgSBNJ5SufZz4HwWh3/y5YwEMeDlZdfzhUDvVYuNpbZP9hW6+1hRJ8N?=
 =?us-ascii?Q?z5f4+47cawOO9tqW5lyNgAhK82YiIdmUUIBW2V9SM6EG3FHoiMCWMDvK8ik3?=
 =?us-ascii?Q?Cket9EI7OrZa+yJcj7pu?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d09be249-9f8d-498e-7e53-08dc31fec830
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 10:29:30.0585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR20MB6813

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


