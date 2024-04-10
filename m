Return-Path: <dmaengine+bounces-1801-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C3A89E7B8
	for <lists+dmaengine@lfdr.de>; Wed, 10 Apr 2024 03:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796601F22893
	for <lists+dmaengine@lfdr.de>; Wed, 10 Apr 2024 01:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5B4A5F;
	Wed, 10 Apr 2024 01:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YTiJ1JQr"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2039.outbound.protection.outlook.com [40.92.22.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0118F4E;
	Wed, 10 Apr 2024 01:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712712085; cv=fail; b=L11Ilt5B95driVh5lMyVLKGQjkjClS55POvOnr1cg7/KlcmstE1Ep6Ta8F9cxeawmOljcr2ypMDl8oUv7FiudP7MjpZKnb0NGbhFk5wH5b1oZm1gCMqBgRm20Z68qozGT8vrCv7VOPGlQEx9Js0b1WJxNdxKOTcYX8nkxY/pIhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712712085; c=relaxed/simple;
	bh=E9awOuPbTaxmmudQbrlIB1+p1HRpuTBqGqcVAPaaqxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MxSo83UAxWXoUiWdjBLHpmbdCd8purVc33rg1HZAnGktBQjSiQ59zbIV1lLNGXIl1BuVMjugO2PInYH8j65ZynLJFtlKM2sXmg2Xyrx+l+CpPxrcz8PwtyyQvnivoiUpeLu3tuBkq/OTR3Ml4jWpk54mz3Jbz9Dy+TmvkmHELc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=YTiJ1JQr; arc=fail smtp.client-ip=40.92.22.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxS1jWgncUgIA13zUSV2ax+5EaD+mLTWW5l7VKhuxjFuYk6nbXc6Y3UuDIl1k6EBCAW8QE+vbfy4eS84UCi/IvzgGbMLfX3UMzouLI7qN+wXEImdoeitxdMRrTRntPLDNPPWRUNi0LKNFSfm3ethA1fKs4AwuVRVB6rqVdmZX71L/UGUgh33SgbGQVDa96moDIfdePNSEU9ybrftITeiQMZMHWozHGzjsdp2Kvi2XEmOqvByWoSc+goH3/ZfqdphBLn9d1l2o6uOZBKNeFwv5wTHoof6929ErI+ne1uxo0f9GwgnXDsjBW4+DkaIoUubNKo2cVU1rgBBGWZHbNnhng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inaCU+qssLdeYfL8F8P6g0twM9HglNf46taAEOj5ZZs=;
 b=gHXxxkUwHJxz7LQLG2compBp2/WQcSSucw7EQqj9Bblnue3b8jm7WupSItqqD+51knDFWW5oftw05HvZaX0kuMOIUjETXQUjzfPy+Kqtwy0UQ5OQuEho6yIrazOokc0xF7oouZ84sfESsDcG1nyNeu7nzCZjKWdhbicvQn95vHqKRDPvPEzWErOAo+pTlmVO3g9l8eQkqm4Zyq6cU3Jb9uvqnLQC27JA8b+wcTZe32jFsRczvDcVYsLCFzet5K4xO1KfuO+Lc1CpDPGA/kgm7uEzEB0o2XuwloTN3W6MINInl3uIYrXsfOgGTQzrI5/XWLtXmZpVtLmzqhWoRVr2Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inaCU+qssLdeYfL8F8P6g0twM9HglNf46taAEOj5ZZs=;
 b=YTiJ1JQrA6goBRQGEX+nSH35x3MzQCbSsIlNZ57c0L9CxkkcWlMOhJX2y4Rp8cln3BsCDAf8lx+wJz0NThnIe6Cc+g9q23KNNSeBDqX+dy0AFVpeV835UDIvWhIaQZZWmCA5nn6vIbiPQVUSeaTTgbC+O4I0NlCJDuVEfLBB4HZzKK11UzMinQ6g1KwAKDqP4cFlp/Aj8Zt4EHBkc57uVcBKzH3WhbIn6L1jv3o8htvLX0ExoMA3JMFe33vAnBfnc8LoRcwXscrvknlja8jDlyWVpMzbRghCxEFNrgyemVMY5tHXPZixZCiM0MDBES7W97b9AqNhKrfls+F5cREo3w==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CYYPR20MB6833.namprd20.prod.outlook.com (2603:10b6:930:c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 01:21:21 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 01:21:21 +0000
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
Subject: [PATCH v7 3/3] dmaengine: add driver for Sophgo CV18XX/SG200X dmamux
Date: Wed, 10 Apr 2024 09:21:22 +0800
Message-ID:
 <IA1PR20MB495310B8E4D7A6705A112004BB062@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <IA1PR20MB49538A66B7AAE7801C5A7C04BB062@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49538A66B7AAE7801C5A7C04BB062@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [9cf4eEYJMK4NP7tZlpKabb5HvPC2KW0KW/dXM8RtbTc=]
X-ClientProxiedBy: TYCP286CA0219.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::15) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240410012124.165438-3-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CYYPR20MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 30587c8c-ba09-4e34-d80d-08dc58fc8793
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	efSuwrbpbzzQjEow17q+0/p4bobojxzF7Qw3L/glat8UrhKg7IR8+TWQyb2/RxttqOweU1BRuBNIBaBNdkgQdzRM5VwqLpNLdzzv3UJQIS3JpBrIDHoSqOYWeeuHBgS3V+Yt3ZbWyn9Ck14pAROOqiMJ9mi2Jmbfz0d4pn7NcJIP9tgunPaisDKJ8JNkjMvwAN9xYfSoXdobQnPSsAUqgT12yrd5UGbF63fHsS5SXM5knbv2YCWoQJuV8OgOZV1CP74EqoHv2uWfoHCQ8AbXeDrUL+VMZ8nfb9JdvLv8quSXwAFkGuRQWFvzTIPr691DX99zyW8Jft9//UiECinPPuGYoNBhPUQ/34z8aSga598JBQVJzu/+pAwCDzMgFFaRc918ei+m+5pPpex7xY0DMzxaJ9z4AZIStl9GD5cCqJsQfeJIh9dpWhnSloswm8T5om8mAxJEnou3CT04seG/W6yO2qSxv2xucibhI9SDs3BueGe3Q5KudjUtakIWQf8oRgfUtRVuZtDWjdEPLuj8TVZ9rw5B5KpAP0WXk0jCkpqLlflVvvWOT4LBGM9gdypbrwmRNJKDd/8pwZVxEhZ6tQGGgyBZ/SRCsFB18NnyUynpdnucBjagnejOh2nKl67W
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JFyLTrL3XTWKdZLxVRU2lSnEn9bpJ3fkwXEiAtEPUbdpRCXVBxGFQiGSTwg0?=
 =?us-ascii?Q?Y/P7Wi5xTJRBdWtpwoA2HEdoh022U1Ni73y3B6dkjMkiF1DeAGV6NmfkGwaf?=
 =?us-ascii?Q?anoF3NGCNgaMC+TfWu8c5VcK1UMyz06xFEgtPjHojCwmkjYej165XWZwDbal?=
 =?us-ascii?Q?ujnU5y6qxpRpoaP7+4oN8tTggXjWZG7wzUHoRjBcAlpE+RZyax5Af4fkhmEI?=
 =?us-ascii?Q?aS2IwkoNq1n4RiCiEOyC/tBzm/aOKGjLtJKf0E7ii7TF+Ey7YsIMF9VYsi78?=
 =?us-ascii?Q?Ks/sgTT2+GNgbnhN/9buA/RsxBulZ0mxHCjXEvUkViHfi0GDjFrYD1X9mX3N?=
 =?us-ascii?Q?XoyXxXOJliszt5QZF3vGokvbP0c0qSGS3DfG2giTPLOXHMaIX5PUJU4vZgUV?=
 =?us-ascii?Q?W5huH7qKA7miSbeKL+Eq9+SocmLgI6nPnBhCVzN5viv9xJXtiAZIXP/zU1sw?=
 =?us-ascii?Q?O4LNYkG5OcVDnqWgRmHp3wpCL/4dz88ygP/Btt+MD6btIiHWcuMf0BBYRjnv?=
 =?us-ascii?Q?lDwCvixO1AZoC3Zd4AhhlwxpSsaPl009stXNCNSa0sJHNks4OlQ6ryRCgiYp?=
 =?us-ascii?Q?uQHfE9n7uAoB8UTVOnpWncgwj+ug+P4lZwILdxcQ19HY8bbaR+P2GKpytf4w?=
 =?us-ascii?Q?THQMydksQY6JXtPNr+VMqmjWlrHELmYbtsyIPFD1v6f5edZWabU1+LonmLAG?=
 =?us-ascii?Q?wmG7lhKd+EQ6tki9EZAIXvZMRylmjp6E8Zb/Q+cYk0Jc/AfHbPZLaLSgjBBg?=
 =?us-ascii?Q?bxbwHEnKE4SQ2Gq1b+iHL+BKrmgyyC7OIXm+G0LTS1AVyUyt0LvML/O2FZ7H?=
 =?us-ascii?Q?bHlfs8Y4P+Egv3ZhRYJI95PHfiZOzB8z5EYyeIXw2pLmoGRJVXU6LOlHnlJk?=
 =?us-ascii?Q?2WuDBM9FBTPL040G29GF9+7+t1lsXAe5PFUHGqFD4oQeiUDpIdySOkXOX3HX?=
 =?us-ascii?Q?RfaKsEv4LzyxUL1DnyrkY3X0cTjD3cK7TWd6POf4ApcZ4zaqOljRKjHaZxG2?=
 =?us-ascii?Q?ta4P9fXMlxXpviqgRaTKftHMCCaUXmiCvxdaM0c9c8EDZEK2Kl3CYa9Z3+/T?=
 =?us-ascii?Q?8lfpDojkI4P47rv5nAv8/ZxU5NDEAbSlDIfP0mUeahOUHK5AA4u6UVXwtFZj?=
 =?us-ascii?Q?qCArXshPDxXH9MbdgcHLQSjEm3r9hvubVr32XfQ8pov+nnsNRSgEcS4V5JBY?=
 =?us-ascii?Q?8ldNw72MYIHUj1zZIyCbmHRQE6dmFzohdQJTfoPXdiaXcgSLSWQ2WpOLQa5r?=
 =?us-ascii?Q?plPHXwEnpYorZYQTFn6p?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30587c8c-ba09-4e34-d80d-08dc58fc8793
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 01:21:21.2774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR20MB6833

Sophgo CV18XX/SG200X use DW AXI CORE with a multiplexer for remapping
its request lines. The multiplexer supports at most 8 request lines.

Add driver for Sophgo CV18XX/SG200X DMA multiplexer.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 drivers/dma/Kconfig         |   9 ++
 drivers/dma/Makefile        |   1 +
 drivers/dma/cv1800-dmamux.c | 260 ++++++++++++++++++++++++++++++++++++
 3 files changed, 270 insertions(+)
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
index 000000000000..ccee023f9d1d
--- /dev/null
+++ b/drivers/dma/cv1800-dmamux.c
@@ -0,0 +1,260 @@
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
+	struct device_node *dma_master;
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


