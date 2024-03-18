Return-Path: <dmaengine+bounces-1406-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C15087E3C5
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 07:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5239281D61
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 06:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A863523754;
	Mon, 18 Mar 2024 06:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dxzaaOYs"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2071.outbound.protection.outlook.com [40.92.40.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24F723763;
	Mon, 18 Mar 2024 06:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710743967; cv=fail; b=oE8PoPzQT2yBQuOUJH+A7QgHvS8W0dr2d+Eepg0WrEp7w2ZIUWov/i/ktlAjxz2+XJKkH5xkpKl0+xiLR0CXPVRqcXu12dyyz0tt/uQdobREkbU5tlwaAOOKjj56yZ3HOynzbUVWVtI3J9DHu5TB4cXiTupFBel6hZczAO5yzHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710743967; c=relaxed/simple;
	bh=9xHhgfB/CufDd99/ZjTDROfnM/5S3ZH3dQLxSNNm7JE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qdpUi0SMrMXkO2jgrWn1YsFs7w0vJXngFQGhFvgZloOS/C44cm/HvYPUzKBOleoyHH7BwbILrES5RBvPMQjuFBb+hZ3WfDcoGHdVWFHAYDWiU28ZxPIORgrrXoxeTOB1KR0m6KZbSizbgOm8y8Hy+/xymIRerHdNIkT8oBe11j4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dxzaaOYs; arc=fail smtp.client-ip=40.92.40.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WedTzBz980Jjprz+lTuM1g5E4uXT+ZTPNyf391fkveaOnKVyKZaGZg3glO9ENL9tAhfCBz3piL69R/ZYj+a1M970ZX5A6i4eSW0ggI/xkYRhSfttHxzjQLhhghmIdwPA5qlJumnjM4dJrQGjvT+k3w1ZbneBKpoJCLt6XV0c9KFjJMPhVBbvy7ad3hAhF34tx771XDbgQg5sDTqZ4emjnvIe/n2fzV7oYmGv2lRsqjGY/soCcR6ePU++/fKunVizzMjyCbuedkhnIgjfbLHLV28xXqGS7wMP66sNgukj8lhCpetl0lsI5DWkVOCbXnN7rXcgGl18jdzusBGArKnmZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6pYCSaKfLXkzXMfkQJfkJFlTBHLZWxHB/e4t7eei6s=;
 b=iixErwYdVSVcDg2DjFREKx9i+6xS6wmgbboUuabpE1acFP3kp/8ami0Bz1P4ip9PznKBdE0D+WzIX9af+9Z4GKSb81eqhG+7B0p0i7Em/kFRakR+m60hCBfaRzfkJ4yW2CZoC6HzJ9FzhuBRckvlFwzraorEdzgIM1/7cwU8qYQbV379F2CVdwfn1focZyR2Mf9ub4bMxiNUs9X5g0Rp/eV5+lFzii+tz4Jio3PNPL3eFCWYyfUzy5sUgvcYTV16h5SUuAKqTrH7fpn+KD6mXPAU2wsjtiTvvQqqefR9N/nSxNzsYNinbzQ5Hp9HIDhybLUTh+yBhbjnJnbUZy0/Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6pYCSaKfLXkzXMfkQJfkJFlTBHLZWxHB/e4t7eei6s=;
 b=dxzaaOYsHaWYAvtXyNqDRvKt5sZgijnbTXGPC7Xta8XLBGwAWzZfVjWjJrUJ8SxfTnZwmf6YhNZPZl6RUIQ0UmGWnJy4yFk+7ydp3eMp41uQS1umM2H773/YWzhTp9pknh57LbC028gXsp/UIUPAS7XR36zAWLCD7EY/XPAXfYNqcsjrco/5N2JrYGkDlll2vC1ihK9bM1vf8GHhzg26tfBJYFDF2qfPVHdVRCn06PdgDjWcTOusWJwGhGuBGea9+4FJdPAks0qU8ToDH+ACYhvbvy+s+xgRMtJ2ewgyI1giCPrFgW04+yxRKe9NxgTwpNcY8EGZHvoQIk8Znbg3Xg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SN7PR20MB5460.namprd20.prod.outlook.com (2603:10b6:806:2ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Mon, 18 Mar
 2024 06:39:23 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041%3]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 06:39:22 +0000
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
Subject: [PATCH v4 4/4] dmaengine: add driver for Sophgo CV18XX/SG200X dmamux
Date: Mon, 18 Mar 2024 14:38:51 +0800
Message-ID:
 <IA1PR20MB49533E6C8C18337E5F6519D0BB2D2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <IA1PR20MB49536DED242092A49A69CEB6BB2D2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49536DED242092A49A69CEB6BB2D2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [7qm0FjB5asIBI6vetYBPR8kdaSYNsdCZLJ2EnNQRv48=]
X-ClientProxiedBy: TYCP301CA0074.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::14) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240318063852.1554712-4-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SN7PR20MB5460:EE_
X-MS-Office365-Filtering-Correlation-Id: 82558cd3-549a-4900-3413-08dc471625ab
X-MS-Exchange-SLBlob-MailProps:
	7J/vb0KDx3g6a7F03Qev6MOuCGwUNmfERvbL1B87uliY8ZRwG+wrIeHDOAedME1pjkGmrqmMix19l4z8NMY1kudSPJ7pYxqgCOYE7K42q0R8uhar0Xx7UstHHfBk+IHw44HwLe10w35cM19YJA94itnn+udRNbi9E6bqCbB0dvVc7xojYoYMTQvRvhnbtuiae6+kcOhi6IQDDKEHhbDzfCm6cftV3sIPU+dQYLVPR+MVAR1sAJHVc6FEFwASCA8Gn6EQDCgO0dPT1+O9bol8QwWy7BMuEeKX3f5bknzWPKMJie66WwjeYSIEUjMiZGUMPYF8rjVAPQFaHGJBCD9oh8/sSMxV/CnKaRhKpxPdGD0dCUNEKHbtkNJwWz0+nKLms0SDS/LB43rRHKEPZgY6LjBS2E3kAsHcFRJccbVNdPIPhGBEdYW10KNaODyZKMegwStMCQ+mUoMX2Y7WH1hHCmOnXHAiwjdwqGWtVVHYuApvQW++jRrpTbM85OcO6sBR01xIbo2jTm17Muce/eDOujZUVxKfmO2TSFlcYAtgon7sIqnvJIB7sZYkrvNLa7cFg8rw/FVNcdZVqLMfHBDvQSPz3vbrpe9vPELAwABGIaHX5JpvfAGrOuNxtVF0mdHoidHCgnQW0rcgQkcjZcWOtbL/cBCH6rD4yloH0WCFhvllBYlM7knBJM8VX6yBQhLiOqrhQKkrTF2Sb6i0qJvZYUYINRdHuyrLKps9zNl4m0hTSDHrrmLuZYCgSX72tn9thyJ5PSfJMo/Z5QGObmWiQx39lcwxEk7v/Q7qGEYAnR8=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0PTTo1c24djxOBbeEMIs3hJph9zqsk5+on9DYwH7rtf6ajIcXfkudy0F0RFmOoVGuQ4SEsUcnLnUTiIRT47DdvruLVZcM/0ebtrQjg5XA2FkQFuFHmoPOuw22DVfm1lgedar2PRs/U+WWRqubakTCTWrCZCKQg6fBSZA541McA/kNka52+x3l/82vHfnWbrkkHiC3IPpUPBtmqCt/vwXRPS/pvV4HP8xncpcDzpkhggNZxAXUthmD/pmzCqdNsnPKk1bixvjWNM2+gMOjqL+7PJ7xUVLwYPfYSxPBtKjnEpOxLIHAHP239KyMNRx73nnPyXGMttCOJDrumLjQuUIlIxMPvwOdrV23XqrtJu38JlsH2tOpR9OdFL15rXk9wKLQD/WM7h276kq0SI51EIkJ3gyfV452Z4EHUED19jdOMhhSMaYbKvTbbYfo0IRcpegCINohSohPjSdQV+fObW7jrN8FUQV0SlEAmCII2gt7jVjz6V97Ivt7IsrlZsS9mHVs3VqZ9AIMkbEhvkPpiFxtNNAgT/h+PDoCpIKrkXaEhXYLI3cu2cwr8nDMtkI6+fuCaR8PUVpgBzn8ZZscMTXu4g2IURav7dAP3KQPxJofrU9CErXzuCFjewNUBNv/COF
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cetwP+yGu8/jJVaEyaWs8XHWY04lIrZr5zEoHyGwcAfBofSXtBxMK7zeyMBL?=
 =?us-ascii?Q?d5yMrvO6d94lp7dPcNXidtVNwJiUwLFhtYboFIHWGt2p18Ep+HBv2m5tfCbc?=
 =?us-ascii?Q?QnPbm7N4Omixsu5SHQii+DFlw8zwsxXOxgbzfL8EeLVd0KcKZ+sNkB1I0Hh2?=
 =?us-ascii?Q?d22iiEQ3ffdyM3sd0TuA/b/4+XStWyjIxyA9kJ2z/VWwed5td84ux9qm08mH?=
 =?us-ascii?Q?DONjBSq0T2BxAgIS7CK4jBpVz7kS80BUGJ+MGE41DQ9K9QGWxC4xm5MBdXN9?=
 =?us-ascii?Q?Yob3IyQ3DWkyQ6RSWLEfsOwWu6ShQlFkae+NIHuU+EmOMKLVnVHjGyL0xgs1?=
 =?us-ascii?Q?8DRfftLQzxyKewmnBX5LN69uAFs0rgZ+we74f9wc7OJwjzaMIDZYAPoOFHtL?=
 =?us-ascii?Q?JcoEKawKjHT5rVXLi9p1BgdfGz/FXg8R5xiqG4zNepzYOlvAnGvIJ+pBkzCr?=
 =?us-ascii?Q?i4LQngGnwWfGQAmvH2ZMWbjycKkDeWsI5Xq6d+qR3S57pPKBkzjXMKGHOhgG?=
 =?us-ascii?Q?n/c1uyPVNYLfA6GKGOUMDvZG5oHjT4UOBGRG7X74UKeUtt3nEHSXEFvSSea8?=
 =?us-ascii?Q?ChiYuQyfVvc9H+q3ix8xrcNL7OMtjei4TZHhYU1iE2uLdFdZw/aY1fkg7qvV?=
 =?us-ascii?Q?qjPx/E64bUPgHToua2ulUK0XxqG2smZg4xwgOw1DGUxTt1afAFqNYtSlHSwt?=
 =?us-ascii?Q?vKmaoDSYxdNJlTIJpFwDox7nS9TGUhRIHzn9rgJuIVHTgt6Jc0QwiMA5rdki?=
 =?us-ascii?Q?56cNngW/x9KU3Knu46xcjOerDA5W9ce3O3zLrIM7Q7fns08je5PRiAdx2IyN?=
 =?us-ascii?Q?EwB+IKjTlDCDzliR+XiOVIuanW3fiLiQ7g2yaKGVp+dO3hLAlBEWjE5M2EmB?=
 =?us-ascii?Q?Nl6xfpm4XhQ+T7vhWeIQKdEXPkqwcxtHGgW0WwxKJooQsn2MXfLMxaI4PTv/?=
 =?us-ascii?Q?CChItuH+F4Gw5j9Z3XfXAWv8mZUveJ9mc+y3+J7ECs4HbGk017Yn9QZht3H6?=
 =?us-ascii?Q?85yYhRES50PubRdr/O9kc3GvyMGH8YUK6nnmm4B6VMxUfwyU8PKZaClsmSwx?=
 =?us-ascii?Q?hOuxtwNgWvlmm3VVA3kxIXN4L43Vdre1IHur1LfRcyWcKCoey8kMpTjKNWih?=
 =?us-ascii?Q?R6FiVE+NdK5FY+/FGHNchd2GeDf4gjaOkPoWvVicHbcmzZMUDoNTmgZGONkA?=
 =?us-ascii?Q?20Rnsgr/82D+6EfzGhGC5I8m6eUBJZvw+ixp54PU5Z7FSHVhZVp2dcel0zRz?=
 =?us-ascii?Q?L5oa3qnYSn3N55F26GJx?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82558cd3-549a-4900-3413-08dc471625ab
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 06:39:22.9447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR20MB5460

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
2.44.0


