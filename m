Return-Path: <dmaengine+bounces-1648-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 934C3891159
	for <lists+dmaengine@lfdr.de>; Fri, 29 Mar 2024 03:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A4C1C29438
	for <lists+dmaengine@lfdr.de>; Fri, 29 Mar 2024 02:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531103C472;
	Fri, 29 Mar 2024 02:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="m3d2YSVx"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2053.outbound.protection.outlook.com [40.92.41.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368633C467;
	Fri, 29 Mar 2024 02:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677889; cv=fail; b=uJDn4zFXeJ0oHF9PJcW7khDxjkEBWDDlfYUJKoaDZf4GUhi9tClIkMJFO7eOZx/oiBLnup1nUwM6ULM5qRkfNQtJp0tKzBNwsZF5Y1Qd5ROixcKZWQgYd9ZvPX9yN0TFqlAOjlpZpx+LSGQschCksNKu8jyrXipc7ywE1LTxR1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677889; c=relaxed/simple;
	bh=KJXl47hSTOc7cR5oqxO/ihC9iDNpncvnfeZEDWhqZy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gmycXL+uncoPKXkHYiFqV9jQLXxlzY4YoTLsrlSJlUfro7txufIwu/OgjnSNN1LVR/Sg1e28gW7VO3JHZMKc6kFU9Ma1JJvxYe0ce3zvhdZtKfwRcJQUUWlmALRjOcV/fdtsD+M+1oyKI+aZiTbdn6jCw2/IZDxzV5aaF5V5EYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=m3d2YSVx; arc=fail smtp.client-ip=40.92.41.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWw+tbhl6haJzszC3Yq4OgK6zqFaVSHENo96mkvtL8LzXyjF5BFIRfyh4V7YJh/DacW7EJwPAxVKAt+UUAUoUpTxJOLYFN3ayVgLxfAGSVduMSBphsF+Lg2WaTGPwUUxOdtGxTNXEnCsxuaSjpksUnchmdWhDXya09y/5b0fEtnlzStkN8wr4wjBoJ15pDbIwVUQ/+o+knltvACC3ZGW+FdHG5GuqNOi6KOZA0MdaehFYDIQcWUVP+Ag2pqukfhGZnaWB8w0gzZpxA9zMdPRKGHLORdAGM6UVFT2ohpQsGLF8wx5oSiMMYuo8bOt24SsnOtA2A+O8IzTWiB6barg8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYPL93Q2yyLjYm6Mfe5wKfxUzkPTz0G+zo6DKWPjJEY=;
 b=fvQPAH44wDuv9HvIHDIJSk7iVHTt5blSEk8hqT6R/tHDC+lwwam1pb/MT6cAzsr+VmFNP57Y9vchvrBAOs7+jq8NwKhK1oG/mINBLx9Q5P8gCs5MWH0RINIBAWwo+ArZknrKQc1Kq6ZUfzzM8IzK67HPy76Qxr4cJp5vqdLShVYS2lMw2milvcqyv9t8my5sVdVkQwvx/2RuS+9Memdq3Uzn206+HxHhpkAxh7Nef/4Z9pwZs9iK3c89JGuQNjQHAAPdH+OErjPnfBXr2QYyQyk3bEtomkAl9jl6pF/bYI1WdMyjtVbB2FMuuJp0Mf1wXO+EI6c6mOQvpYYJOJ1UVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYPL93Q2yyLjYm6Mfe5wKfxUzkPTz0G+zo6DKWPjJEY=;
 b=m3d2YSVxU95rtC6p0pttgdVcqXz/P/cT/JiXgpNrdBEqmVYu71wb+iuQasi0YEaGKy7+lHNnVbPhdmMmy4rgSwhNFZQoL468iSS9APn4f6lXyKHaL2MfqoVXjT+l3gw14VBpji9B9Gl2kVIt+ssq4ONpiKZ4AYUQrm4ms41/O7ybiQ+Ohfh8v76s06Nxo4/UEQv5peTCErcMYpd69YzX9oXBNI8eiLb6hnNug0GersBY5HzU56LpodCe2t2cyoZQDjtc4Z5rJTjOAYuj+v14ssoIa9NwMTWIF9ZlMeRUxgVLm1lSDyT3dMwVNkJ0ObDN1XjYpLwJjL2et1AtRZoZ1w==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB5151.namprd20.prod.outlook.com (2603:10b6:806:256::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.39; Fri, 29 Mar
 2024 02:04:44 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 02:04:44 +0000
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
Subject: [PATCH v6 3/3] dmaengine: add driver for Sophgo CV18XX/SG200X dmamux
Date: Fri, 29 Mar 2024 10:04:39 +0800
Message-ID:
 <IA1PR20MB4953AE1184DD09F9203C665CBB3A2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <IA1PR20MB4953F0FAED4373660C7873A2BB3A2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953F0FAED4373660C7873A2BB3A2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [vN8Ey4A2F70K2YWSVmrGUoJqrJujnmeeoOoZSwls9mw=]
X-ClientProxiedBy: TYAPR01CA0178.jpnprd01.prod.outlook.com
 (2603:1096:404:ba::22) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240329020442.373744-3-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB5151:EE_
X-MS-Office365-Filtering-Correlation-Id: 686b6348-c143-4a50-0870-08dc4f949a51
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1PyfZl9Ln7By8Ifd94KIUos+Zz7lhI4amKd+jUmoy4i8H30VIB6TCuk+nWc3d5pBemL5HXSh3PnYykn/WasenLTFhLZs75w/GaAg7aVjkToMQbBt8DCSwVGFqWaVglJ9trz5A61lpTw2i0hWcxtEXSimZgkFbbv5OVxYSSHO4zm4lXFON3KcoobMuIeSETZLVLP0AL3s+tkuyCn4DLlEa2HR2WZOKQj/tkPg/WhjsSpHvlEguukIPxcy4tM/K0Gf3qhmxZrIPw5W/n72w8iImYvOqR30rreWA+DswkwugylZ83bhRyV31qubH9uo3M+LkQ7CYjt0NFxHd59siqD+jUnZ79dfBEVhDtkT/rpeWurDiwYyid+YeI2ofJXMfAwROyS5f/TF2xxyeDl9jlR1BKZARD/aTZRr/wSa3MzzPMVFB//qUD4xcUhOC2u+qqG+K9Rul3zfeIfif8XyIXgGfEBC31rttTc45/Ded50Ja8vxYS1Ze4+e6Xk+vP3sX4/SWKRxHj5VJCn9rbc0qU7Vr46lzxGy2ZnuAC/jth8NepFnwIAez1oLsxzDoWPSz1GEJuiPJEIp2GdqLK6gjUwX2XVaP4XyPYCHvT4xTikT4CiC5N1+fn1O5CaZQHNQSe0d
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lLowN0TIMaHHi1Tk39gZ0l6uUdonl7CjJX11EsJxMEhv9rh3dm8l29lB30Pu?=
 =?us-ascii?Q?BKfMLHzk4ZA721uB1pBaq2YQPQqzsHuuyaBiBoeGnqVAGrvMx3P5RuSDaddE?=
 =?us-ascii?Q?L363niyStEpTzbQ6gF+ig0YTSHtho78N2ox1+CHGQcgoV7aDh7Xr4gYLayCj?=
 =?us-ascii?Q?KlVGzO16Pf1xhElKWcY10l6prS8Bzxzqm3KJvDAQdrOqIf8TlKIGYbEaBBgk?=
 =?us-ascii?Q?L49aQeG3DJ6t5BdTVMLTyYcJ1umlBRcJGyZJbgYYxs79PCPbQNfM9EkTRyEt?=
 =?us-ascii?Q?LZJoQD4vwNG0/5Z9DbZLo4j0nvvWMxa7GMAF8hpD8DJ++NxZpyw4RMFS8IKj?=
 =?us-ascii?Q?0R92d3SCJ2shLpb7OGo21Ih9XYgNV7XsmEoMcEOAaUgPTd/nXZd0xFSeCIV2?=
 =?us-ascii?Q?+uxnRtcD18tRgGY610GO9GP4bwFd2g2GWKL0M4qJl/7sXiDyb1ggplCcnDkQ?=
 =?us-ascii?Q?TxrXIKDNVXe3b49q4gc97hWXw2h2tGyEv6WymoXtIp73sTWevbEUgr4UyOoV?=
 =?us-ascii?Q?EfsvHe4ceT50dAWRpeMoJlUm25VIyt84oJfg+yKLTDUoV1XWRJLnW6zz5izD?=
 =?us-ascii?Q?ISnwpqu4O7xkLVnuNDkkbazyBBX6nhY+1STjDDliaCTQ2Uxk0r0tLnif3YFE?=
 =?us-ascii?Q?3farErrRqmt4d/WL9454YDkKdm3izGXdixBe0YjTu3b8cHeZ7acjev1emroH?=
 =?us-ascii?Q?LIdMNAcWC5ZNa5W8A+LcuQNfEEegoaKyyWp6OqCJtAJP4mN8iPi+bZ8cuVFR?=
 =?us-ascii?Q?yPIXTmQvwOapUCMK8CrVhpD2imWFDk/oO7S3dtzlir04/qponf/5q1fV+uHN?=
 =?us-ascii?Q?c1IczkurrIKoZexSU2oSSrWxVwbVPgp0o0lJ8X/IG4wA7jppzq49ii2bXiyg?=
 =?us-ascii?Q?VQFZ3Ej8Lkk5UyJYANLZx2y3yWWLWcBp3GgEnmzzQjejdLUdd7ckKyYhlLal?=
 =?us-ascii?Q?EEDSscyrAMid+kXjr4ncOoEUuYoVSW0jiPcwVNpuHmuOXABZdGrF+cMPwrtL?=
 =?us-ascii?Q?k4UcnycLQM7N+H2bdtsK5qDxNXScpN7R4eQZyFA3f6YqKMHqZr0ZvUV8UbMj?=
 =?us-ascii?Q?yhntpJn/ro2Z2t+AgPchugfv9aoA5mnejBV2EesY8pUPgRllJljIvnlw//hu?=
 =?us-ascii?Q?fgb8H+I/IyxrJsrZXF1QDRMxER2I/hxnLw3rBnbv75IuZu2dZBRGoAEMwqRp?=
 =?us-ascii?Q?4yc4YUsL6HsrubZpAipRbKyZ31MTtO8sfzZhb2/LsUpbC8xAAP40B35OB3GJ?=
 =?us-ascii?Q?nnlxSp0up9kiyKbm0ivE?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 686b6348-c143-4a50-0870-08dc4f949a51
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 02:04:44.5312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB5151

Sophgo CV18XX/SG200X use DW AXI CORE with a multiplexer for remapping
its request lines. The multiplexer supports at most 8 request lines.

Add driver for Sophgo CV18XX/SG200X DMA multiplexer.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 drivers/dma/Kconfig         |   9 ++
 drivers/dma/Makefile        |   1 +
 drivers/dma/cv1800-dmamux.c | 267 ++++++++++++++++++++++++++++++++++++
 3 files changed, 277 insertions(+)
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
index 000000000000..709414898b67
--- /dev/null
+++ b/drivers/dma/cv1800-dmamux.c
@@ -0,0 +1,267 @@
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
+	dev_info(dev, "free channel %u for req %u (cpu %u)\n",
+		 map->channel, map->peripheral, map->cpu);
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
+	dev_info(&pdev->dev, "register channel %u for req %u (cpu %u)\n",
+		 chid, devid, cpuid);
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


