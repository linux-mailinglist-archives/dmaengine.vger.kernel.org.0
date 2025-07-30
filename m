Return-Path: <dmaengine+bounces-5890-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 844C7B157A4
	for <lists+dmaengine@lfdr.de>; Wed, 30 Jul 2025 04:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E491547070
	for <lists+dmaengine@lfdr.de>; Wed, 30 Jul 2025 02:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43A01ADC83;
	Wed, 30 Jul 2025 02:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="uYNruk95"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8631A0BF3
	for <dmaengine@vger.kernel.org>; Wed, 30 Jul 2025 02:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753844192; cv=fail; b=mJWVQiLFyeYWIsKRzw+iPqyP7o5cIMwmN1GkjC72w8zXZV3aKUFewK0ybPbq7qfg0SuUP6Z+xY15Mr+T0M8hZZBDmJQNsi+BRXgqc5c+G+S2pYZERXlQQ2UAm4h/tKS0YrbHXpV8wvWuke78Zax25A+0WmoWOiw9XmSPAxYsISY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753844192; c=relaxed/simple;
	bh=vUYriwig/iy47rcRcz3gOq0ke51RwQgsuh2fpGJgwCA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nbRCL3+kqI9BunuwDqNiB0C69t4/6aTDTnmu1raMOHYA41h4+mq71gMMEX4RvVdTL3gT/QMU+K3sYPeDu2m1iVXu+Z/c6AyAxTW2TWE77FBrqCDy5b6cgm1vNZWTMDhZwyJT0HWLIvnwWDw21N+6ptCQ68t94aZNx5wOmrklavI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=uYNruk95; arc=fail smtp.client-ip=40.107.92.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4PCHUI8drCLuwJXzg8FyzLKvS61EkvsRqdSCdEhvKYfehJ50aZOyceSGHWQvD+3R0cCXIa59hswghu40qO0yxP1u2PoIPFtBR1bsk6FTkpY118dN+sEiS3/e4XeWuO3c4TKxr3abH7SVL1KS1H2wYbcJonCUKLnmVXguxDiTNl5g43ZWd0uBJnCT/cIvZyyO/FLYrd9ktIxt4Zl+B2Ux7Mp9nqnp2CLUFuMd57JMepkPjH6UoaEPBJLfqCqyh5p6kA2Q8hpSRaoCbAXdyTTELx6DkEPeEmy2ZVtD5hcY8VuiwdyIBZdGb2iwQHspKuhqm23AnVOZya1M01+aVk3+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZa/grP8CrxLLQuhKEhQD8fM4lviwEfMG2wXB+Jwo6k=;
 b=uHOSVi9Bn2WaBUpVbuBEYfynpL9gksYIEWbmt7X7qPm/BD1j/lYhVhiS+A5WPKB4eY/Zqt2FIiJliSvmhsAfWkDOkJvZ3/Jzp+q0AKZTrBZ3YpkVxLHEBxHGjtNbypgGr5WiA5owcQmoYb/ivMxNXxacf9eDus6nKOlashbJA7eATX5UiTFVTx20u5TwjD55RIGB9sKWwYfVRaBHHBUayHUj05PVGUOaM5QXJ8skeQcBSms8u1woI1wz85j9/5SZe9R4Bha4CwP9mHtygRtj+yexaoiLPpmB4idqyEphXYFGmdw/h4ry2/Fm3JGGFg9nZjLM80t18UvXnlxRxywC/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 174.47.1.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=maxlinear.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=maxlinear.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZa/grP8CrxLLQuhKEhQD8fM4lviwEfMG2wXB+Jwo6k=;
 b=uYNruk95K421qY7Yif2UIQ6anre/3nJu0BJoou/tqZdokvZl/gtt52zyOo0z3TC+QYDTx29T/bsNf6Ca+n2+9F2sFbh7fLSkMAfSLwEdtbmFhoWqEDqpDssqa1b7jo8R2kcMwwVuvVxeCGEBJkEteBNk5jRX3zYki1Uvlzg7oaet2iUwNE4tuzkPrXGT+yufLZYgL1iZss2o2ZK9HSm5jDifwMr4y7c3Zf7u53xnT+9DH75La4JXS75MPy0R+9ygI2Tuc9dwPQcIKJhcqZxwqFLaKR0Ivszd6L6hetODEx45uyUzrRc56iFRsVmc205vo5KBtvItancZJ4wM5r/HwA==
Received: from CY5P221CA0107.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::34) by
 SA0PR19MB4617.namprd19.prod.outlook.com (2603:10b6:806:bb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.11; Wed, 30 Jul 2025 02:56:21 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:930:9:cafe::8) by CY5P221CA0107.outlook.office365.com
 (2603:10b6:930:9::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Wed,
 30 Jul 2025 02:56:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 174.47.1.83)
 smtp.mailfrom=maxlinear.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=maxlinear.com;
Received-SPF: Pass (protection.outlook.com: domain of maxlinear.com designates
 174.47.1.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=174.47.1.83; helo=usmxlcas.maxlinear.com; pr=C
Received: from usmxlcas.maxlinear.com (174.47.1.83) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 02:56:20 +0000
Received: from sgb015.sgsw.maxlinear.com (10.23.238.15) by mail.maxlinear.com
 (10.23.38.120) with Microsoft SMTP Server id 15.1.2507.39; Tue, 29 Jul 2025
 19:56:18 -0700
From: Zhu Yixin <yzhu@maxlinear.com>
To: <dmaengine@vger.kernel.org>, <vkoul@kernel.org>
CC: <jchng@maxlinear.com>, <sureshnagaraj@maxlinear.com>, Zhu Yixin
	<yzhu@maxlinear.com>
Subject: [PATCH 3/5] dmaengine: lgm-dma: split legacy DMA and HDMA functions
Date: Wed, 30 Jul 2025 10:45:45 +0800
Message-ID: <20250730024547.3160871-3-yzhu@maxlinear.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250730024547.3160871-1-yzhu@maxlinear.com>
References: <20250730024547.3160871-1-yzhu@maxlinear.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|SA0PR19MB4617:EE_
X-MS-Office365-Filtering-Correlation-Id: f967c00b-cf27-4d1c-a66f-08ddcf14a99e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s6ca5gPYU0SuiTFKnMKSEM0qMQZMLiQeV39EvL4sAwGuAd13l9F9mAAhFaxa?=
 =?us-ascii?Q?fZOVXdU9Q+kxF63kixPQ44OfqfM+C6J7em3gkLTSK6eKwg3wqSUJC2gw785q?=
 =?us-ascii?Q?TqslrHFLLNbLkN0GaECxVK7dbIIN7dXbu9BdY3nPSr0ETkRYP+WeRCYMGKnN?=
 =?us-ascii?Q?kAU01RfeIgEGdDW9fTLS5boGyb5PSHPEpmiJdV90vueFO+CNCschyxDDqJGq?=
 =?us-ascii?Q?z7210Ai4xZ3XWLXsb5+W1AsT+77X3bMFuI50RkaquzKVb0ycLU6ARrCCtmi1?=
 =?us-ascii?Q?z4ZBfnFZ6SbjAF6itpqQD850FWCKa1akmKbmcqWF9kzRkPBq0rvQq+nCd6UC?=
 =?us-ascii?Q?OeWeoTAo6rCYsMaNvWkp1sQ1QqLIOibkF/UXMOLMeM5n4wts2VrfrUqPiA6v?=
 =?us-ascii?Q?pKXwVKcGFCDkUw08Pnh7M5JRISK83wAL7FCKkGM4cBwNxJmZxzI21f4FJyNs?=
 =?us-ascii?Q?yXDEX/Ksg/wkcODQ3gRTRUVGH7pzXTN6q8NDU6lAwsJAI5RjVq0GJ/LNUu8p?=
 =?us-ascii?Q?F5yTd3NKzgpzw2KPYqHUYNSkNK0QuRwhVNoAZyG4ZXblGIjPF0j77+8fMF4o?=
 =?us-ascii?Q?rJKhCgT8/6HW0P5HDoIM6GxfTNq3Y4wZ4Tm8YkxOuGQQPcaxHVQMI9Fx2sXc?=
 =?us-ascii?Q?VU5DfjSSgacza0tWxQyZIxwwDP45rvG5iG6/XCv3yOahyn9We9F/7nsE9QmG?=
 =?us-ascii?Q?SteKpRQT8O6LLUsnvHcEa962aX/VlpdrOhXQgStaiEjqDcBii75upzN6m+7W?=
 =?us-ascii?Q?9luZov5pW7LZhdr7xjItNwR4twPOK7z1rdY0jYpUxjYTHPioxWXqYLiqnABy?=
 =?us-ascii?Q?3NCaLVaiiqNe3SQ72JIagi97g1Os6ypRFDQl0imNsLJpjmX4A/eDrSUGlby+?=
 =?us-ascii?Q?ZKC2m6vBbBo9jWtrfmS+j87U/H3XiWukOsXUXIsGiyu90pyObB6f+CUnFJaJ?=
 =?us-ascii?Q?QkCOrJwShpH7uk+6q4LTLFpzSzP2hVK3/1g/lJLf7sY1U8wWwnA4MVPZelwd?=
 =?us-ascii?Q?jza9Eyz3ZLy64CYzBpmumBSjx5Q0RqvLJY3e8igow8GYrull3K44/95vFb9c?=
 =?us-ascii?Q?2pbXHmsTG977a0ty3Nna7m/m+iQpctkXXZIlvbk9Uq55nZhIeSh/HXmr9cbE?=
 =?us-ascii?Q?b+WOrLlKw9cV0yq+egKlRrmP2ZaE+wtEan+btB4JsenlROzZXKez8VwGI7nz?=
 =?us-ascii?Q?GQpw0bxx9xooO0wDb45tzOfgybCkn8aJhj8p45A3YXLYUBQdVEgXi7+zKwUL?=
 =?us-ascii?Q?8ZxYsutaui8NG6DJYyVb2lx4yHRPB3vqWeDbEJHomI6BsGmqf+OMz7kjuNm/?=
 =?us-ascii?Q?KbFkf3aJbItdsSK5pHsRjyHsGpM5or++ry0AyVFzSUTfnO09gezLqdG9xKLk?=
 =?us-ascii?Q?8ALyPGkhru+aso2ZAn0uygvDi9Xw1PKgPoMwreAwKyAQ1uxYgE52rOqu95/9?=
 =?us-ascii?Q?nmV15/2FVnt+KmLoFzSlffQafZUJGFakCvYj8if7s+GTfoFwh8ixB2rqA4mQ?=
 =?us-ascii?Q?gZ4NowUas7HNRr950VqFqsoaYXAlcSWTK2UU?=
X-Forefront-Antispam-Report:
	CIP:174.47.1.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:usmxlcas.maxlinear.com;PTR:174-47-1-83.static.ctl.one;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 02:56:20.7702
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f967c00b-cf27-4d1c-a66f-08ddcf14a99e
X-MS-Exchange-CrossTenant-Id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=dac28005-13e0-41b8-8280-7663835f2b1d;Ip=[174.47.1.83];Helo=[usmxlcas.maxlinear.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR19MB4617

Move legacy DMA functions into lgm-cdma.c.
Move HDMA functions into lgm-hdma.c
Keep the driver flow and general functions in lgm-dma.c

Signed-off-by: Zhu Yixin <yzhu@maxlinear.com>
---
 .../devicetree/bindings/dma/intel,ldma.yaml   |   7 +-
 drivers/dma/lgm/Makefile                      |   2 +-
 drivers/dma/lgm/lgm-cdma.c                    | 492 ++++++++++
 drivers/dma/lgm/lgm-dma.c                     | 839 ++----------------
 drivers/dma/lgm/lgm-dma.h                     | 278 ++++++
 drivers/dma/lgm/lgm-hdma.c                    | 130 +++
 6 files changed, 961 insertions(+), 787 deletions(-)
 create mode 100644 drivers/dma/lgm/lgm-cdma.c
 create mode 100644 drivers/dma/lgm/lgm-dma.h
 create mode 100644 drivers/dma/lgm/lgm-hdma.c

diff --git a/Documentation/devicetree/bindings/dma/intel,ldma.yaml b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
index 59f928297613..f91d849edc4c 100644
--- a/Documentation/devicetree/bindings/dma/intel,ldma.yaml
+++ b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
@@ -15,7 +15,8 @@ allOf:
 properties:
   compatible:
     enum:
-      - intel,lgm-ldma
+      - intel,lgm-cdma
+      - intel,lgm-hdma
 
   reg:
     maxItems: 1
@@ -127,7 +128,7 @@ additionalProperties: false
 examples:
   - |
     dma0: dma-controller@e0e00000 {
-      compatible = "intel,lgm-ldma";
+      compatible = "intel,lgm-cdma";
       reg = <0xe0e00000 0x1000>;
       #dma-cells = <3>;
       dma-channels = <16>;
@@ -144,7 +145,7 @@ examples:
     };
   - |
     dma3: dma-controller@ec800000 {
-      compatible = "intel,lgm-ldma";
+      compatible = "intel,lgm-hdma";
       reg = <0xec800000 0x1000>;
       clocks = <&cgu0 71>;
       resets = <&rcu0 0x10 9>;
diff --git a/drivers/dma/lgm/Makefile b/drivers/dma/lgm/Makefile
index f318a8eff464..1246082253ff 100644
--- a/drivers/dma/lgm/Makefile
+++ b/drivers/dma/lgm/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_INTEL_LDMA)	+= lgm-dma.o
+obj-$(CONFIG_INTEL_LDMA)	+= lgm-dma.o lgm-cdma.o lgm-hdma.o
diff --git a/drivers/dma/lgm/lgm-cdma.c b/drivers/dma/lgm/lgm-cdma.c
new file mode 100644
index 000000000000..0acb30706c42
--- /dev/null
+++ b/drivers/dma/lgm/lgm-cdma.c
@@ -0,0 +1,492 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Lightning Mountain centralized DMA controller driver
+ *
+ * Copyright (c) 2025 Maxlinear Inc.
+ */
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmapool.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/of_dma.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+
+#include "../dmaengine.h"
+#include "../virt-dma.h"
+#include "lgm-dma.h"
+
+struct dw2_desc {
+	u32 field;
+	u32 addr;
+} __packed __aligned(8);
+
+struct dw2_desc_sw {
+	struct virt_dma_desc	vdesc;
+	struct ldma_chan	*chan;
+	dma_addr_t		desc_phys;
+	size_t			desc_cnt;
+	size_t			size;
+	struct dw2_desc		*desc_hw;
+};
+
+struct cdma_chan {
+	struct dma_pool		*desc_pool; /* Descriptors pool */
+	u32			desc_cnt; /* Descriptor length */
+	struct dw2_desc_sw	*ds;
+	struct work_struct	work;
+	struct dma_slave_config config;
+};
+
+struct cdma_dev {
+	struct ldma_dev		*ldev;
+	struct workqueue_struct	*wq;
+};
+
+static int cdma_ctrl_init(struct ldma_dev *d);
+static int cdma_port_init(struct ldma_dev *d, struct ldma_port *p);
+static int cdma_chan_init(struct ldma_dev *d, struct ldma_chan *c);
+static int cdma_irq_init(struct ldma_dev *d, struct platform_device *pdev);
+static void cdma_func_init(struct dma_device *dma_dev);
+static irqreturn_t cdma_interrupt(int irq, void *dev_id);
+
+static struct cdma_dev *g_cdma_dev;
+
+struct ldma_ops cdma_ops = {
+	.dma_ctrl_init = cdma_ctrl_init,
+	.dma_port_init = cdma_port_init,
+	.dma_chan_init = cdma_chan_init,
+	.dma_irq_init  = cdma_irq_init,
+	.dma_func_init = cdma_func_init,
+};
+
+static inline struct dw2_desc_sw *to_lgm_cdma_desc(struct virt_dma_desc *vdesc)
+{
+	return container_of(vdesc, struct dw2_desc_sw, vdesc);
+}
+
+static void cdma_free_desc_resource(struct virt_dma_desc *vdesc)
+{
+	struct dw2_desc_sw *ds = to_lgm_cdma_desc(vdesc);
+	struct ldma_chan *c = ds->chan;
+	struct cdma_chan *chan = c->priv;
+
+	dma_pool_free(chan->desc_pool, ds->desc_hw, ds->desc_phys);
+	kfree(ds);
+	chan->ds = NULL;
+}
+
+static void cdma_work(struct work_struct *work)
+{
+	struct ldma_chan *c;
+	struct cdma_chan *chan;
+	struct dma_async_tx_descriptor *tx;
+	struct virt_dma_chan *vc;
+	struct dmaengine_desc_callback cb;
+	struct virt_dma_desc *vd, *_vd;
+	unsigned long flags;
+	LIST_HEAD(head);
+
+	chan = container_of(work, struct cdma_chan, work);
+	if (!chan->ds)
+		return;
+	c = chan->ds[0].chan;
+	tx = &chan->ds->vdesc.tx;
+	vc = &c->vchan;
+
+	spin_lock_irqsave(&c->vchan.lock, flags);
+	list_splice_tail_init(&vc->desc_completed, &head);
+	spin_unlock_irqrestore(&c->vchan.lock, flags);
+	dmaengine_desc_get_callback(tx, &cb);
+	dma_cookie_complete(tx);
+	dmaengine_desc_callback_invoke(&cb, NULL);
+
+	list_for_each_entry_safe(vd, _vd, &head, node) {
+		dmaengine_desc_get_callback(tx, &cb);
+		dma_cookie_complete(tx);
+		list_del(&vd->node);
+		dmaengine_desc_callback_invoke(&cb, NULL);
+
+		vchan_vdesc_fini(vd);
+	}
+}
+
+static int cdma_ctrl_init(struct ldma_dev *d)
+{
+	struct cdma_dev *cdma;
+
+	cdma = devm_kzalloc(d->dev, sizeof(*cdma), GFP_KERNEL);
+	if (!cdma)
+		return -ENOMEM;
+
+	cdma->ldev = d;
+	cdma->wq = alloc_ordered_workqueue("dma_wq",
+					   WQ_MEM_RECLAIM | WQ_HIGHPRI);
+	if (!cdma->wq)
+		return -ENOMEM;
+
+	g_cdma_dev = cdma;
+
+	return 0;
+}
+
+static int cdma_port_init(struct ldma_dev *d, struct ldma_port *p)
+{
+	return 0;
+}
+
+static int cdma_chan_init(struct ldma_dev *d, struct ldma_chan *c)
+{
+	struct cdma_chan *chan;
+
+	c->rst = DMA_CHAN_RST;
+	c->desc_cnt = DMA_DFT_DESC_NUM;
+	snprintf(c->name, sizeof(c->name), "chan%d", c->nr);
+	c->vchan.desc_free = cdma_free_desc_resource;
+	vchan_init(&c->vchan, &d->dma_dev);
+
+	chan = devm_kzalloc(d->dev, sizeof(*chan), GFP_KERNEL);
+	if (!chan)
+		return -ENOMEM;
+
+	INIT_WORK(&chan->work, cdma_work);
+	c->priv = chan;
+
+	return 0;
+}
+
+static int cdma_irq_init(struct ldma_dev *d, struct platform_device *pdev)
+{
+	d->irq = platform_get_irq(pdev, 0);
+	if (d->irq < 0)
+		return d->irq;
+
+	return devm_request_irq(d->dev, d->irq, cdma_interrupt, 0,
+				DRIVER_NAME, d);
+}
+
+static void cdma_chan_irq(int irq, void *data)
+{
+	struct ldma_chan *c = data;
+	struct ldma_dev *d = g_cdma_dev->ldev;
+	struct cdma_chan *chan;
+	u32 stat;
+
+	/* Disable channel interrupts  */
+	writel(c->nr, d->base + DMA_CS);
+	stat = readl(d->base + DMA_CIS);
+	if (!stat)
+		return;
+
+	writel(readl(d->base + DMA_CIE) & ~DMA_CI_ALL, d->base + DMA_CIE);
+	writel(stat, d->base + DMA_CIS);
+	chan = (struct cdma_chan *)c->priv;
+	queue_work(g_cdma_dev->wq, &chan->work);
+}
+
+static irqreturn_t cdma_interrupt(int irq, void *dev_id)
+{
+	struct ldma_dev *d = dev_id;
+	struct ldma_chan *c;
+	unsigned long irncr;
+	u32 cid;
+
+	irncr = readl(d->base + DMA_IRNCR);
+	if (!irncr) {
+		dev_err(d->dev, "dummy interrupt\n");
+		return IRQ_NONE;
+	}
+
+	for_each_set_bit(cid, &irncr, d->chan_nrs) {
+		/* Mask */
+		writel(readl(d->base + DMA_IRNEN) & ~BIT(cid), d->base + DMA_IRNEN);
+		/* Ack */
+		writel(readl(d->base + DMA_IRNCR) | BIT(cid), d->base + DMA_IRNCR);
+
+		c = &d->chans[cid];
+		cdma_chan_irq(irq, c);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int cdma_alloc_chan_resources(struct dma_chan *dma_chan)
+{
+	struct ldma_chan *c = to_ldma_chan(dma_chan);
+	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	struct cdma_chan *chan = (struct cdma_chan *)c->priv;
+	struct device *dev = d->dev;
+	size_t desc_sz;
+
+	if (chan->desc_pool)
+		return c->desc_cnt;
+
+	desc_sz = c->desc_cnt * sizeof(struct dw2_desc);
+	chan->desc_pool = dma_pool_create(c->name, dev, desc_sz,
+					  __alignof__(struct dw2_desc), 0);
+
+	if (!chan->desc_pool) {
+		dev_err(dev, "unable to allocate descriptor pool\n");
+		return -ENOMEM;
+	}
+	chan->desc_cnt = c->desc_cnt;
+
+	return c->desc_cnt;
+}
+
+static void cdma_free_chan_resources(struct dma_chan *dma_chan)
+{
+	struct ldma_chan *c = to_ldma_chan(dma_chan);
+	struct cdma_chan *chan = (struct cdma_chan *)c->priv;
+
+	dma_pool_destroy(chan->desc_pool);
+	chan->desc_pool = NULL;
+	vchan_free_chan_resources(to_virt_chan(dma_chan));
+	ldma_chan_reset(c);
+}
+
+static void cdma_synchronize(struct dma_chan *dma_chan)
+{
+	struct ldma_chan *c = to_ldma_chan(dma_chan);
+	struct cdma_chan *chan = (struct cdma_chan *)c->priv;
+
+	/*
+	 * clear any pending work if any. In that
+	 * case the resource needs to be free here.
+	 */
+	cancel_work_sync(&chan->work);
+	vchan_synchronize(&c->vchan);
+	if (chan->ds)
+		cdma_free_desc_resource(&chan->ds->vdesc);
+}
+
+static int
+cdma_slave_config(struct dma_chan *dma_chan, struct dma_slave_config *cfg)
+{
+	struct ldma_chan *c = to_ldma_chan(dma_chan);
+	struct cdma_chan *chan = (struct cdma_chan *)c->priv;
+
+	memcpy(&chan->config, cfg, sizeof(chan->config));
+
+	return 0;
+}
+
+static void cdma_chan_irq_en(struct ldma_chan *c)
+{
+	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	unsigned long flags;
+
+	spin_lock_irqsave(&d->dev_lock, flags);
+	writel(c->nr, d->base + DMA_CS);
+	writel(DMA_CI_EOP, d->base + DMA_CIE);
+	writel(BIT(c->nr), d->base + DMA_IRNEN);
+	spin_unlock_irqrestore(&d->dev_lock, flags);
+}
+
+static void cdma_issue_pending(struct dma_chan *dma_chan)
+{
+	struct ldma_chan *c = to_ldma_chan(dma_chan);
+	struct cdma_chan *chan = (struct cdma_chan *)c->priv;
+	//struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	unsigned long flags;
+
+	spin_lock_irqsave(&c->vchan.lock, flags);
+	if (vchan_issue_pending(&c->vchan)) {
+		struct virt_dma_desc *vdesc;
+
+		/* Get the next descriptor */
+		vdesc = vchan_next_desc(&c->vchan);
+		if (!vdesc) {
+			chan->ds = NULL;
+			spin_unlock_irqrestore(&c->vchan.lock, flags);
+			return;
+		}
+		list_del(&vdesc->node);
+		chan->ds = to_lgm_cdma_desc(vdesc);
+		ldma_chan_desc_hw_cfg(c, chan->ds->desc_phys,
+				      chan->ds->desc_cnt);
+		cdma_chan_irq_en(c);
+	}
+	spin_unlock_irqrestore(&c->vchan.lock, flags);
+
+	ldma_chan_on(c);
+}
+
+static enum dma_status
+cdma_tx_status(struct dma_chan *dma_chan, dma_cookie_t cookie,
+	       struct dma_tx_state *txstate)
+{
+	enum dma_status status = DMA_COMPLETE;
+
+	status = dma_cookie_status(dma_chan, cookie, txstate);
+
+	return status;
+}
+
+static struct dw2_desc_sw *
+cdma_alloc_desc_resource(int num, struct ldma_chan *c)
+{
+	struct device *dev = g_cdma_dev->ldev->dev;
+	struct cdma_chan *chan = (struct cdma_chan *)c->priv;
+	struct dw2_desc_sw *ds;
+
+	if (num > c->desc_cnt) {
+		dev_err(dev, "sg num %d exceed max %d\n", num, c->desc_cnt);
+		return NULL;
+	}
+
+	ds = kzalloc(sizeof(*ds), GFP_NOWAIT);
+	if (!ds)
+		return NULL;
+
+	ds->chan = c;
+	ds->desc_hw = dma_pool_zalloc(chan->desc_pool, GFP_ATOMIC,
+				      &ds->desc_phys);
+	if (!ds->desc_hw) {
+		dev_dbg(dev, "out of memory for link descriptor\n");
+		kfree(ds);
+		return NULL;
+	}
+	ds->desc_cnt = num;
+
+	return ds;
+}
+
+static void prep_slave_burst_len(struct ldma_chan *c)
+{
+	struct ldma_port *p = c->port;
+	struct cdma_chan *chan = (struct cdma_chan *)c->priv;
+	struct dma_slave_config *cfg = &chan->config;
+
+	if (cfg->dst_maxburst)
+		cfg->src_maxburst = cfg->dst_maxburst;
+
+	/* TX and RX has the same burst length */
+	p->txbl = ilog2(cfg->src_maxburst);
+	p->rxbl = p->txbl;
+}
+
+static struct dma_async_tx_descriptor *
+cdma_prep_slave_sg(struct dma_chan *dma_chan, struct scatterlist *sgl,
+		   unsigned int sglen, enum dma_transfer_direction dir,
+		   unsigned long flags, void *context)
+{
+	struct ldma_chan *c = to_ldma_chan(dma_chan);
+	struct cdma_chan *chan = (struct cdma_chan *)c->priv;
+	size_t len, avail, total = 0;
+	struct dw2_desc *hw_ds;
+	struct dw2_desc_sw *ds;
+	struct scatterlist *sg;
+	int num = sglen, i;
+	dma_addr_t addr;
+
+	if (!sgl)
+		return NULL;
+
+	for_each_sg(sgl, sg, sglen, i) {
+		avail = sg_dma_len(sg);
+		if (avail > DMA_MAX_SIZE)
+			num += DIV_ROUND_UP(avail, DMA_MAX_SIZE) - 1;
+	}
+
+	ds = cdma_alloc_desc_resource(num, c);
+	if (!ds)
+		return NULL;
+
+	chan->ds = ds;
+
+	num = 0;
+	/* sop and eop has to be handled nicely */
+	for_each_sg(sgl, sg, sglen, i) {
+		addr = sg_dma_address(sg);
+		avail = sg_dma_len(sg);
+		total += avail;
+
+		do {
+			len = min_t(size_t, avail, DMA_MAX_SIZE);
+
+			hw_ds = &ds->desc_hw[num];
+			switch (sglen) {
+			case 1:
+				hw_ds->field &= ~DESC_SOP;
+				hw_ds->field |= FIELD_PREP(DESC_SOP, 1);
+
+				hw_ds->field &= ~DESC_EOP;
+				hw_ds->field |= FIELD_PREP(DESC_EOP, 1);
+				break;
+			default:
+				if (num == 0) {
+					hw_ds->field &= ~DESC_SOP;
+					hw_ds->field |= FIELD_PREP(DESC_SOP, 1);
+
+					hw_ds->field &= ~DESC_EOP;
+					hw_ds->field |= FIELD_PREP(DESC_EOP, 0);
+				} else if (num == (sglen - 1)) {
+					hw_ds->field &= ~DESC_SOP;
+					hw_ds->field |= FIELD_PREP(DESC_SOP, 0);
+					hw_ds->field &= ~DESC_EOP;
+					hw_ds->field |= FIELD_PREP(DESC_EOP, 1);
+				} else {
+					hw_ds->field &= ~DESC_SOP;
+					hw_ds->field |= FIELD_PREP(DESC_SOP, 0);
+
+					hw_ds->field &= ~DESC_EOP;
+					hw_ds->field |= FIELD_PREP(DESC_EOP, 0);
+				}
+				break;
+			}
+			/* Only 32 bit address supported */
+			hw_ds->addr = (u32)addr;
+
+			hw_ds->field &= ~DESC_DATA_LEN;
+			hw_ds->field |= FIELD_PREP(DESC_DATA_LEN, len);
+
+			hw_ds->field &= ~DESC_C;
+			hw_ds->field |= FIELD_PREP(DESC_C, 0);
+
+			hw_ds->field &= ~DESC_BYTE_OFF;
+			hw_ds->field |= FIELD_PREP(DESC_BYTE_OFF, addr & 0x3);
+
+			/* Ensure data ready before ownership change */
+			wmb();
+			hw_ds->field &= ~DESC_OWN;
+			hw_ds->field |= FIELD_PREP(DESC_OWN, DMA_OWN);
+
+			/* Ensure ownership changed before moving forward */
+			wmb();
+			num++;
+			addr += len;
+			avail -= len;
+		} while (avail);
+	}
+
+	ds->size = total;
+	prep_slave_burst_len(c);
+
+	return vchan_tx_prep(&c->vchan, &ds->vdesc, DMA_CTRL_ACK);
+}
+
+static void cdma_func_init(struct dma_device *dma_dev)
+{
+	dma_dev->device_alloc_chan_resources = cdma_alloc_chan_resources;
+	dma_dev->device_free_chan_resources = cdma_free_chan_resources;
+	dma_dev->device_terminate_all = ldma_terminate_all;
+	dma_dev->device_issue_pending = cdma_issue_pending;
+	dma_dev->device_tx_status = cdma_tx_status;
+	dma_dev->device_resume = ldma_resume_chan;
+	dma_dev->device_pause = ldma_pause_chan;
+	dma_dev->device_prep_slave_sg = cdma_prep_slave_sg;
+
+	dma_dev->device_config = cdma_slave_config;
+	dma_dev->device_synchronize = cdma_synchronize;
+	dma_dev->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	dma_dev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	dma_dev->directions = BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
+	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
+}
diff --git a/drivers/dma/lgm/lgm-dma.c b/drivers/dma/lgm/lgm-dma.c
index ea185c5de1b2..6fade7b4f820 100644
--- a/drivers/dma/lgm/lgm-dma.c
+++ b/drivers/dma/lgm/lgm-dma.c
@@ -22,257 +22,7 @@
 
 #include "../dmaengine.h"
 #include "../virt-dma.h"
-
-#define DRIVER_NAME			"lgm-dma"
-
-#define DMA_ID				0x0008
-#define DMA_ID_REV			GENMASK(7, 0)
-#define DMA_ID_PNR			GENMASK(19, 16)
-#define DMA_ID_CHNR			GENMASK(26, 20)
-#define DMA_ID_DW_128B			BIT(27)
-#define DMA_ID_AW_36B			BIT(28)
-#define DMA_VER32			0x32
-#define DMA_VER31			0x31
-#define DMA_VER22			0x0A
-
-#define DMA_CTRL			0x0010
-#define DMA_CTRL_RST			BIT(0)
-#define DMA_CTRL_DSRAM_PATH		BIT(1)
-#define DMA_CTRL_DBURST_WR		BIT(3)
-#define DMA_CTRL_VLD_DF_ACK		BIT(4)
-#define DMA_CTRL_CH_FL			BIT(6)
-#define DMA_CTRL_DS_FOD			BIT(7)
-#define DMA_CTRL_DRB			BIT(8)
-#define DMA_CTRL_ENBE			BIT(9)
-#define DMA_CTRL_DESC_TMOUT_CNT_V31	GENMASK(27, 16)
-#define DMA_CTRL_DESC_TMOUT_EN_V31	BIT(30)
-#define DMA_CTRL_PKTARB			BIT(31)
-
-#define DMA_CPOLL			0x0014
-#define DMA_CPOLL_CNT			GENMASK(15, 4)
-#define DMA_CPOLL_EN			BIT(31)
-
-#define DMA_CS				0x0018
-#define DMA_CS_MASK			GENMASK(5, 0)
-
-#define DMA_CCTRL			0x001C
-#define DMA_CCTRL_ON			BIT(0)
-#define DMA_CCTRL_RST			BIT(1)
-#define DMA_CCTRL_CH_POLL_EN		BIT(2)
-#define DMA_CCTRL_CH_ABC		BIT(3) /* Adaptive Burst Chop */
-#define DMA_CDBA_MSB			GENMASK(7, 4)
-#define DMA_CCTRL_DIR_TX		BIT(8)
-#define DMA_CCTRL_CLASS			GENMASK(11, 9)
-#define DMA_CCTRL_CLASSH		GENMASK(19, 18)
-#define DMA_CCTRL_WR_NP_EN		BIT(21)
-#define DMA_CCTRL_PDEN			BIT(23)
-#define DMA_MAX_CLASS			(SZ_32 - 1)
-
-#define DMA_CDBA			0x0020
-#define DMA_CDLEN			0x0024
-#define DMA_CIS				0x0028
-#define DMA_CIE				0x002C
-#define DMA_CI_EOP			BIT(1)
-#define DMA_CI_DUR			BIT(2)
-#define DMA_CI_DESCPT			BIT(3)
-#define DMA_CI_CHOFF			BIT(4)
-#define DMA_CI_RDERR			BIT(5)
-#define DMA_CI_ALL							\
-	(DMA_CI_EOP | DMA_CI_DUR | DMA_CI_DESCPT | DMA_CI_CHOFF | DMA_CI_RDERR)
-
-#define DMA_PS				0x0040
-#define DMA_PCTRL			0x0044
-#define DMA_PCTRL_RXBL16		BIT(0)
-#define DMA_PCTRL_TXBL16		BIT(1)
-#define DMA_PCTRL_RXBL			GENMASK(3, 2)
-#define DMA_PCTRL_RXBL_8		3
-#define DMA_PCTRL_TXBL			GENMASK(5, 4)
-#define DMA_PCTRL_TXBL_8		3
-#define DMA_PCTRL_PDEN			BIT(6)
-#define DMA_PCTRL_RXBL32		BIT(7)
-#define DMA_PCTRL_RXENDI		GENMASK(9, 8)
-#define DMA_PCTRL_TXENDI		GENMASK(11, 10)
-#define DMA_PCTRL_TXBL32		BIT(15)
-#define DMA_PCTRL_MEM_FLUSH		BIT(16)
-
-#define DMA_IRNEN1			0x00E8
-#define DMA_IRNCR1			0x00EC
-#define DMA_IRNEN			0x00F4
-#define DMA_IRNCR			0x00F8
-#define DMA_C_DP_TICK			0x100
-#define DMA_C_DP_TICK_TIKNARB		GENMASK(15, 0)
-#define DMA_C_DP_TICK_TIKARB		GENMASK(31, 16)
-
-#define DMA_C_HDRM			0x110
-/*
- * If header mode is set in DMA descriptor,
- *   If bit 30 is disabled, HDR_LEN must be configured according to channel
- *     requirement.
- *   If bit 30 is enabled(checksum with header mode), HDR_LEN has no need to
- *     be configured. It will enable check sum for switch
- * If header mode is not set in DMA descriptor,
- *   This register setting doesn't matter
- */
-#define DMA_C_HDRM_HDR_SUM		BIT(30)
-
-#define DMA_C_BOFF			0x120
-#define DMA_C_BOFF_BOF_LEN		GENMASK(7, 0)
-#define DMA_C_BOFF_EN			BIT(31)
-
-#define DMA_ORRC			0x190
-#define DMA_ORRC_ORRCNT			GENMASK(8, 4)
-#define DMA_ORRC_EN			BIT(31)
-
-#define DMA_C_ENDIAN			0x200
-#define DMA_C_END_DATAENDI		GENMASK(1, 0)
-#define DMA_C_END_DE_EN			BIT(7)
-#define DMA_C_END_DESENDI		GENMASK(9, 8)
-#define DMA_C_END_DES_EN		BIT(16)
-
-/* DMA controller capability */
-#define DMA_ADDR_36BIT			BIT(0)
-#define DMA_DATA_128BIT			BIT(1)
-#define DMA_CHAN_FLOW_CTL		BIT(2)
-#define DMA_DESC_FOD			BIT(3)
-#define DMA_DESC_IN_SRAM		BIT(4)
-#define DMA_EN_BYTE_EN			BIT(5)
-#define DMA_DBURST_WR			BIT(6)
-#define DMA_VALID_DESC_FETCH_ACK	BIT(7)
-#define DMA_DFT_DRB			BIT(8)
-
-#define DMA_ORRC_MAX_CNT		16
-#define DMA_DFT_POLL_CNT		SZ_4
-#define DMA_DFT_BURST_V22		SZ_2
-#define DMA_BURSTL_8DW			SZ_8
-#define DMA_BURSTL_16DW			SZ_16
-#define DMA_BURSTL_32DW			SZ_32
-#define DMA_DFT_BURST			DMA_BURSTL_16DW
-#define DMA_MAX_DESC_NUM		(SZ_8K - 1)
-#define DMA_CHAN_BOFF_MAX		(SZ_256 - 1)
-#define DMA_DFT_ENDIAN			0
-
-#define DMA_DFT_DESC_TCNT		50
-#define DMA_HDR_LEN_MAX			(SZ_16K - 1)
-
-/* DMA flags */
-#define DMA_TX_CH			BIT(0)
-#define DMA_RX_CH			BIT(1)
-#define DEVICE_ALLOC_DESC		BIT(2)
-#define CHAN_IN_USE			BIT(3)
-#define DMA_HW_DESC			BIT(4)
-
-/* Descriptor fields */
-#define DESC_DATA_LEN			GENMASK(15, 0)
-#define DESC_BYTE_OFF			GENMASK(25, 23)
-#define DESC_EOP			BIT(28)
-#define DESC_SOP			BIT(29)
-#define DESC_C				BIT(30)
-#define DESC_OWN			BIT(31)
-
-#define DMA_CHAN_RST			1
-#define DMA_MAX_SIZE			(BIT(16) - 1)
-#define MAX_LOWER_CHANS			32
-#define MASK_LOWER_CHANS		GENMASK(4, 0)
-#define DMA_OWN				1
-#define HIGH_4_BITS			GENMASK(3, 0)
-#define DMA_DFT_DESC_NUM		1
-#define DMA_PKT_DROP_DIS		0
-
-enum ldma_chan_on_off {
-	DMA_CH_OFF = 0,
-	DMA_CH_ON = 1,
-};
-
-enum {
-	DMA_TYPE_INVD = -1, /* Legacy DMA does not have type */
-	DMA_TYPE_TX = 0,
-	DMA_TYPE_RX,
-	DMA_TYPE_MCPY,
-};
-
-enum {
-	DMA_IN_HW_MODE,
-	DMA_IN_SW_MODE,
-};
-
-struct ldma_dev;
-struct ldma_port;
-
-struct ldma_chan {
-	struct virt_dma_chan	vchan;
-	struct ldma_port	*port; /* back pointer */
-	char			name[8]; /* Channel name */
-	int			nr; /* Channel id in hardware */
-	u32			flags; /* central way or channel based way */
-	enum ldma_chan_on_off	onoff;
-	dma_addr_t		desc_phys;
-	void			*desc_base; /* Virtual address */
-	u32			desc_cnt; /* Number of descriptors */
-	int			rst;
-	u32			hdrm_len;
-	bool			hdrm_csum;
-	u32			boff_len;
-	u32			data_endian;
-	u32			desc_endian;
-	bool			pden;
-	bool			desc_rx_np;
-	bool			data_endian_en;
-	bool			desc_endian_en;
-	bool			abc_en;
-	bool			desc_init;
-	struct dma_pool		*desc_pool; /* Descriptors pool */
-	u32			desc_num;
-	struct dw2_desc_sw	*ds;
-	struct work_struct	work;
-	struct dma_slave_config config;
-	int			mode;
-};
-
-struct ldma_port {
-	struct ldma_dev		*ldev; /* back pointer */
-	u32			portid;
-	u32			rxbl;
-	u32			txbl;
-	u32			rxendi;
-	u32			txendi;
-	u32			pkt_drop;
-};
-
-struct ldma_dev {
-	struct device		*dev;
-	void __iomem		*base;
-	struct reset_control	*rst;
-	struct clk		*core_clk;
-	struct dma_device	dma_dev;
-	u32			ver;
-	int			irq;
-	struct ldma_port	*ports;
-	struct ldma_chan	*chans; /* channel list on this DMA or port */
-	spinlock_t		dev_lock; /* Controller register exclusive */
-	u32			chan_nrs;
-	u32			port_nrs;
-	u32			channels_mask;
-	u32			flags;
-	u32			pollcnt;
-	u32			orrc; /* Outstanding read count */
-	int			type;
-	const char		*name;
-	struct workqueue_struct	*wq;
-};
-
-struct dw2_desc {
-	u32 field;
-	u32 addr;
-} __packed __aligned(8);
-
-struct dw2_desc_sw {
-	struct virt_dma_desc	vdesc;
-	struct ldma_chan	*chan;
-	dma_addr_t		desc_phys;
-	size_t			desc_cnt;
-	size_t			size;
-	struct dw2_desc		*desc_hw;
-};
+#include "lgm-dma.h"
 
 static inline void
 ldma_update_bits(struct ldma_dev *d, u32 mask, u32 val, u32 ofs)
@@ -286,21 +36,6 @@ ldma_update_bits(struct ldma_dev *d, u32 mask, u32 val, u32 ofs)
 		writel(new_val, d->base + ofs);
 }
 
-static inline struct ldma_chan *to_ldma_chan(struct dma_chan *chan)
-{
-	return container_of(chan, struct ldma_chan, vchan.chan);
-}
-
-static inline struct ldma_dev *to_ldma_dev(struct dma_device *dma_dev)
-{
-	return container_of(dma_dev, struct ldma_dev, dma_dev);
-}
-
-static inline struct dw2_desc_sw *to_lgm_dma_desc(struct virt_dma_desc *vdesc)
-{
-	return container_of(vdesc, struct dw2_desc_sw, vdesc);
-}
-
 static inline bool ldma_chan_tx(struct ldma_chan *c)
 {
 	return !!(c->flags & DMA_TX_CH);
@@ -589,7 +324,7 @@ static void ldma_chan_set_class(struct ldma_chan *c, u32 val)
 			 DMA_CCTRL);
 }
 
-static int ldma_chan_on(struct ldma_chan *c)
+int ldma_chan_on(struct ldma_chan *c)
 {
 	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
 	unsigned long flags;
@@ -630,8 +365,8 @@ static int ldma_chan_off(struct ldma_chan *c)
 	return 0;
 }
 
-static void ldma_chan_desc_hw_cfg(struct ldma_chan *c, dma_addr_t desc_base,
-				  int desc_num)
+void ldma_chan_desc_hw_cfg(struct ldma_chan *c, dma_addr_t desc_base,
+			   int desc_num)
 {
 	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
 	unsigned long flags;
@@ -653,43 +388,7 @@ static void ldma_chan_desc_hw_cfg(struct ldma_chan *c, dma_addr_t desc_base,
 	c->desc_init = true;
 }
 
-static struct dma_async_tx_descriptor *
-ldma_chan_desc_cfg(struct dma_chan *chan, dma_addr_t desc_base, int desc_num)
-{
-	struct ldma_chan *c = to_ldma_chan(chan);
-	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
-	struct dma_async_tx_descriptor *tx;
-	struct dw2_desc_sw *ds;
-
-	if (!desc_num) {
-		dev_err(d->dev, "Channel %d must allocate descriptor first\n",
-			c->nr);
-		return NULL;
-	}
-
-	if (desc_num > DMA_MAX_DESC_NUM) {
-		dev_err(d->dev, "Channel %d descriptor number out of range %d\n",
-			c->nr, desc_num);
-		return NULL;
-	}
-
-	ldma_chan_desc_hw_cfg(c, desc_base, desc_num);
-
-	c->flags |= DMA_HW_DESC;
-	c->desc_cnt = desc_num;
-	c->desc_phys = desc_base;
-
-	ds = kzalloc(sizeof(*ds), GFP_NOWAIT);
-	if (!ds)
-		return NULL;
-
-	tx = &ds->vdesc.tx;
-	dma_async_tx_descriptor_init(tx, chan);
-
-	return tx;
-}
-
-static int ldma_chan_reset(struct ldma_chan *c)
+int ldma_chan_reset(struct ldma_chan *c)
 {
 	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
 	unsigned long flags;
@@ -915,8 +614,6 @@ static void ldma_dev_init(struct ldma_dev *d)
 static int ldma_parse_dt(struct ldma_dev *d)
 {
 	struct fwnode_handle *fwnode = dev_fwnode(d->dev);
-	struct ldma_port *p;
-	int i;
 
 	if (fwnode_property_read_bool(fwnode, "intel,dma-byte-en"))
 		d->flags |= DMA_EN_BYTE_EN;
@@ -964,112 +661,10 @@ static int ldma_parse_dt(struct ldma_dev *d)
 		return -EINVAL;
 	}
 
-	if (d->ver > DMA_VER22) {
-		for (i = 0; i < d->port_nrs; i++) {
-			p = &d->ports[i];
-			p->rxendi = DMA_DFT_ENDIAN;
-			p->txendi = DMA_DFT_ENDIAN;
-			p->rxbl = DMA_DFT_BURST;
-			p->txbl = DMA_DFT_BURST;
-			p->pkt_drop = DMA_PKT_DROP_DIS;
-		}
-	}
-
 	return 0;
 }
 
-static void dma_free_desc_resource(struct virt_dma_desc *vdesc)
-{
-	struct dw2_desc_sw *ds = to_lgm_dma_desc(vdesc);
-	struct ldma_chan *c = ds->chan;
-
-	dma_pool_free(c->desc_pool, ds->desc_hw, ds->desc_phys);
-	kfree(ds);
-}
-
-static struct dw2_desc_sw *
-dma_alloc_desc_resource(int num, struct ldma_chan *c)
-{
-	struct device *dev = c->vchan.chan.device->dev;
-	struct dw2_desc_sw *ds;
-
-	if (num > c->desc_num) {
-		dev_err(dev, "sg num %d exceed max %d\n", num, c->desc_num);
-		return NULL;
-	}
-
-	ds = kzalloc(sizeof(*ds), GFP_NOWAIT);
-	if (!ds)
-		return NULL;
-
-	ds->chan = c;
-	ds->desc_hw = dma_pool_zalloc(c->desc_pool, GFP_ATOMIC,
-				      &ds->desc_phys);
-	if (!ds->desc_hw) {
-		dev_dbg(dev, "out of memory for link descriptor\n");
-		kfree(ds);
-		return NULL;
-	}
-	ds->desc_cnt = num;
-
-	return ds;
-}
-
-static void ldma_chan_irq_en(struct ldma_chan *c)
-{
-	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
-	unsigned long flags;
-
-	spin_lock_irqsave(&d->dev_lock, flags);
-	writel(c->nr, d->base + DMA_CS);
-	writel(DMA_CI_EOP, d->base + DMA_CIE);
-	writel(BIT(c->nr), d->base + DMA_IRNEN);
-	spin_unlock_irqrestore(&d->dev_lock, flags);
-}
-
-static void ldma_issue_pending(struct dma_chan *chan)
-{
-	struct ldma_chan *c = to_ldma_chan(chan);
-	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
-	unsigned long flags;
-
-	if (d->ver == DMA_VER22) {
-		spin_lock_irqsave(&c->vchan.lock, flags);
-		if (vchan_issue_pending(&c->vchan)) {
-			struct virt_dma_desc *vdesc;
-
-			/* Get the next descriptor */
-			vdesc = vchan_next_desc(&c->vchan);
-			if (!vdesc) {
-				c->ds = NULL;
-				spin_unlock_irqrestore(&c->vchan.lock, flags);
-				return;
-			}
-			list_del(&vdesc->node);
-			c->ds = to_lgm_dma_desc(vdesc);
-			ldma_chan_desc_hw_cfg(c, c->ds->desc_phys, c->ds->desc_cnt);
-			ldma_chan_irq_en(c);
-		}
-		spin_unlock_irqrestore(&c->vchan.lock, flags);
-	}
-	ldma_chan_on(c);
-}
-
-static void ldma_synchronize(struct dma_chan *chan)
-{
-	struct ldma_chan *c = to_ldma_chan(chan);
-
-	/*
-	 * clear any pending work if any. In that
-	 * case the resource needs to be free here.
-	 */
-	cancel_work_sync(&c->work);
-	vchan_synchronize(&c->vchan);
-	if (c->ds)
-		dma_free_desc_resource(&c->ds->vdesc);
-}
-
-static int ldma_terminate_all(struct dma_chan *chan)
+int ldma_terminate_all(struct dma_chan *chan)
 {
 	struct ldma_chan *c = to_ldma_chan(chan);
 	unsigned long flags;
@@ -1083,7 +678,7 @@ static int ldma_terminate_all(struct dma_chan *chan)
 	return ldma_chan_reset(c);
 }
 
-static int ldma_resume_chan(struct dma_chan *chan)
+int ldma_resume_chan(struct dma_chan *chan)
 {
 	struct ldma_chan *c = to_ldma_chan(chan);
 
@@ -1092,282 +687,31 @@ static int ldma_resume_chan(struct dma_chan *chan)
 	return 0;
 }
 
-static int ldma_pause_chan(struct dma_chan *chan)
+int ldma_pause_chan(struct dma_chan *chan)
 {
 	struct ldma_chan *c = to_ldma_chan(chan);
 
 	return ldma_chan_off(c);
 }
 
-static enum dma_status
-ldma_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
-	       struct dma_tx_state *txstate)
+static u32
+chan_burst_len(struct ldma_chan *c, struct ldma_port *p, u32 burst)
 {
-	struct ldma_chan *c = to_ldma_chan(chan);
-	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
-	enum dma_status status = DMA_COMPLETE;
+	struct ldma_dev *d = p->ldev;
 
 	if (d->ver == DMA_VER22)
-		status = dma_cookie_status(chan, cookie, txstate);
-
-	return status;
-}
-
-static void dma_chan_irq(int irq, void *data)
-{
-	struct ldma_chan *c = data;
-	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
-	u32 stat;
-
-	/* Disable channel interrupts  */
-	writel(c->nr, d->base + DMA_CS);
-	stat = readl(d->base + DMA_CIS);
-	if (!stat)
-		return;
-
-	writel(readl(d->base + DMA_CIE) & ~DMA_CI_ALL, d->base + DMA_CIE);
-	writel(stat, d->base + DMA_CIS);
-	queue_work(d->wq, &c->work);
-}
-
-static irqreturn_t dma_interrupt(int irq, void *dev_id)
-{
-	struct ldma_dev *d = dev_id;
-	struct ldma_chan *c;
-	unsigned long irncr;
-	u32 cid;
-
-	irncr = readl(d->base + DMA_IRNCR);
-	if (!irncr) {
-		dev_err(d->dev, "dummy interrupt\n");
-		return IRQ_NONE;
-	}
-
-	for_each_set_bit(cid, &irncr, d->chan_nrs) {
-		/* Mask */
-		writel(readl(d->base + DMA_IRNEN) & ~BIT(cid), d->base + DMA_IRNEN);
-		/* Ack */
-		writel(readl(d->base + DMA_IRNCR) | BIT(cid), d->base + DMA_IRNCR);
-
-		c = &d->chans[cid];
-		dma_chan_irq(irq, c);
-	}
-
-	return IRQ_HANDLED;
-}
-
-static void prep_slave_burst_len(struct ldma_chan *c)
-{
-	struct ldma_port *p = c->port;
-	struct dma_slave_config *cfg = &c->config;
-
-	if (cfg->dst_maxburst)
-		cfg->src_maxburst = cfg->dst_maxburst;
-
-	/* TX and RX has the same burst length */
-	p->txbl = ilog2(cfg->src_maxburst);
-	p->rxbl = p->txbl;
-}
-
-static struct dma_async_tx_descriptor *
-ldma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
-		   unsigned int sglen, enum dma_transfer_direction dir,
-		   unsigned long flags, void *context)
-{
-	struct ldma_chan *c = to_ldma_chan(chan);
-	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
-	size_t len, avail, total = 0;
-	struct dw2_desc *hw_ds;
-	struct dw2_desc_sw *ds;
-	struct scatterlist *sg;
-	int num = sglen, i;
-	dma_addr_t addr;
-
-	if (!sgl)
-		return NULL;
-
-	if (d->ver > DMA_VER22)
-		return ldma_chan_desc_cfg(chan, sgl->dma_address, sglen);
-
-	for_each_sg(sgl, sg, sglen, i) {
-		avail = sg_dma_len(sg);
-		if (avail > DMA_MAX_SIZE)
-			num += DIV_ROUND_UP(avail, DMA_MAX_SIZE) - 1;
-	}
-
-	ds = dma_alloc_desc_resource(num, c);
-	if (!ds)
-		return NULL;
-
-	c->ds = ds;
-
-	num = 0;
-	/* sop and eop has to be handled nicely */
-	for_each_sg(sgl, sg, sglen, i) {
-		addr = sg_dma_address(sg);
-		avail = sg_dma_len(sg);
-		total += avail;
-
-		do {
-			len = min_t(size_t, avail, DMA_MAX_SIZE);
-
-			hw_ds = &ds->desc_hw[num];
-			switch (sglen) {
-			case 1:
-				hw_ds->field &= ~DESC_SOP;
-				hw_ds->field |= FIELD_PREP(DESC_SOP, 1);
-
-				hw_ds->field &= ~DESC_EOP;
-				hw_ds->field |= FIELD_PREP(DESC_EOP, 1);
-				break;
-			default:
-				if (num == 0) {
-					hw_ds->field &= ~DESC_SOP;
-					hw_ds->field |= FIELD_PREP(DESC_SOP, 1);
-
-					hw_ds->field &= ~DESC_EOP;
-					hw_ds->field |= FIELD_PREP(DESC_EOP, 0);
-				} else if (num == (sglen - 1)) {
-					hw_ds->field &= ~DESC_SOP;
-					hw_ds->field |= FIELD_PREP(DESC_SOP, 0);
-					hw_ds->field &= ~DESC_EOP;
-					hw_ds->field |= FIELD_PREP(DESC_EOP, 1);
-				} else {
-					hw_ds->field &= ~DESC_SOP;
-					hw_ds->field |= FIELD_PREP(DESC_SOP, 0);
-
-					hw_ds->field &= ~DESC_EOP;
-					hw_ds->field |= FIELD_PREP(DESC_EOP, 0);
-				}
-				break;
-			}
-			/* Only 32 bit address supported */
-			hw_ds->addr = (u32)addr;
-
-			hw_ds->field &= ~DESC_DATA_LEN;
-			hw_ds->field |= FIELD_PREP(DESC_DATA_LEN, len);
-
-			hw_ds->field &= ~DESC_C;
-			hw_ds->field |= FIELD_PREP(DESC_C, 0);
-
-			hw_ds->field &= ~DESC_BYTE_OFF;
-			hw_ds->field |= FIELD_PREP(DESC_BYTE_OFF, addr & 0x3);
-
-			/* Ensure data ready before ownership change */
-			wmb();
-			hw_ds->field &= ~DESC_OWN;
-			hw_ds->field |= FIELD_PREP(DESC_OWN, DMA_OWN);
-
-			/* Ensure ownership changed before moving forward */
-			wmb();
-			num++;
-			addr += len;
-			avail -= len;
-		} while (avail);
-	}
-
-	ds->size = total;
-	prep_slave_burst_len(c);
-
-	return vchan_tx_prep(&c->vchan, &ds->vdesc, DMA_CTRL_ACK);
-}
-
-static int
-ldma_slave_config(struct dma_chan *chan, struct dma_slave_config *cfg)
-{
-	struct ldma_chan *c = to_ldma_chan(chan);
-
-	memcpy(&c->config, cfg, sizeof(c->config));
-
-	return 0;
-}
-
-static int ldma_alloc_chan_resources(struct dma_chan *chan)
-{
-	struct ldma_chan *c = to_ldma_chan(chan);
-	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
-	struct device *dev = c->vchan.chan.device->dev;
-	size_t	desc_sz;
-
-	if (d->ver > DMA_VER22) {
-		c->flags |= CHAN_IN_USE;
-		return 0;
-	}
-
-	if (c->desc_pool)
-		return c->desc_num;
-
-	desc_sz = c->desc_num * sizeof(struct dw2_desc);
-	c->desc_pool = dma_pool_create(c->name, dev, desc_sz,
-				       __alignof__(struct dw2_desc), 0);
-
-	if (!c->desc_pool) {
-		dev_err(dev, "unable to allocate descriptor pool\n");
-		return -ENOMEM;
-	}
-
-	return c->desc_num;
-}
-
-static void ldma_free_chan_resources(struct dma_chan *chan)
-{
-	struct ldma_chan *c = to_ldma_chan(chan);
-	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
-
-	if (d->ver == DMA_VER22) {
-		dma_pool_destroy(c->desc_pool);
-		c->desc_pool = NULL;
-		vchan_free_chan_resources(to_virt_chan(chan));
-		ldma_chan_reset(c);
-	} else {
-		c->flags &= ~CHAN_IN_USE;
-	}
-}
-
-static void dma_work(struct work_struct *work)
-{
-	struct ldma_chan *c = container_of(work, struct ldma_chan, work);
-	struct dma_async_tx_descriptor *tx = &c->ds->vdesc.tx;
-	struct virt_dma_chan *vc = &c->vchan;
-	struct dmaengine_desc_callback cb;
-	struct virt_dma_desc *vd, *_vd;
-	unsigned long flags;
-	LIST_HEAD(head);
-
-	spin_lock_irqsave(&c->vchan.lock, flags);
-	list_splice_tail_init(&vc->desc_completed, &head);
-	spin_unlock_irqrestore(&c->vchan.lock, flags);
-	dmaengine_desc_get_callback(tx, &cb);
-	dma_cookie_complete(tx);
-	dmaengine_desc_callback_invoke(&cb, NULL);
-
-	list_for_each_entry_safe(vd, _vd, &head, node) {
-		dmaengine_desc_get_callback(tx, &cb);
-		dma_cookie_complete(tx);
-		list_del(&vd->node);
-		dmaengine_desc_callback_invoke(&cb, NULL);
-
-		vchan_vdesc_fini(vd);
-	}
-	c->ds = NULL;
-}
-
-static void
-update_burst_len_v22(struct ldma_chan *c, struct ldma_port *p, u32 burst)
-{
-	if (ldma_chan_tx(c))
-		p->txbl = ilog2(burst);
+		return ilog2(burst);
 	else
-		p->rxbl = ilog2(burst);
+		return burst;
 }
 
 static void
-update_burst_len_v3X(struct ldma_chan *c, struct ldma_port *p, u32 burst)
+update_burst_len(struct ldma_chan *c, struct ldma_port *p, u32 burst)
 {
 	if (ldma_chan_tx(c))
-		p->txbl = burst;
+		p->txbl = chan_burst_len(c, p, burst);
 	else
-		p->rxbl = burst;
+		p->rxbl = chan_burst_len(c, p, burst);
 }
 
 static int
@@ -1387,10 +731,7 @@ update_client_configs(struct of_dma *ofdma, struct of_phandle_args *spec)
 	c = &d->chans[chan_id];
 	c->port = p;
 
-	if (d->ver == DMA_VER22)
-		update_burst_len_v22(c, p, burst);
-	else
-		update_burst_len_v3X(c, p, burst);
+	update_burst_len(c, p, burst);
 
 	ldma_port_cfg(p);
 
@@ -1417,66 +758,9 @@ static struct dma_chan *ldma_xlate(struct of_phandle_args *spec,
 	return dma_get_slave_channel(&d->chans[chan_id].vchan.chan);
 }
 
-static void ldma_dma_init_v22(int i, struct ldma_dev *d)
+static int ldma_irq_init(struct ldma_dev *d, struct platform_device *pdev)
 {
-	struct ldma_chan *c;
-
-	c = &d->chans[i];
-	c->nr = i; /* Real channel number */
-	c->rst = DMA_CHAN_RST;
-	c->desc_num = DMA_DFT_DESC_NUM;
-	snprintf(c->name, sizeof(c->name), "chan%d", c->nr);
-	INIT_WORK(&c->work, dma_work);
-	c->vchan.desc_free = dma_free_desc_resource;
-	vchan_init(&c->vchan, &d->dma_dev);
-}
-
-static void ldma_dma_init_v3X(int i, struct ldma_dev *d)
-{
-	struct ldma_chan *c;
-
-	c = &d->chans[i];
-	c->data_endian = DMA_DFT_ENDIAN;
-	c->desc_endian = DMA_DFT_ENDIAN;
-	c->data_endian_en = false;
-	c->desc_endian_en = false;
-	c->desc_rx_np = false;
-	c->flags |= DEVICE_ALLOC_DESC;
-	c->onoff = DMA_CH_OFF;
-	c->rst = DMA_CHAN_RST;
-	c->abc_en = true;
-	c->hdrm_csum = false;
-	c->boff_len = 0;
-	c->nr = i;
-	c->vchan.desc_free = dma_free_desc_resource;
-	vchan_init(&c->vchan, &d->dma_dev);
-}
-
-static int ldma_init_v22(struct ldma_dev *d, struct platform_device *pdev)
-{
-	int ret;
-
-	ret = device_property_read_u32(d->dev, "dma-channels", &d->chan_nrs);
-	if (ret < 0) {
-		dev_err(d->dev, "unable to read dma-channels property\n");
-		return ret;
-	}
-
-	d->irq = platform_get_irq(pdev, 0);
-	if (d->irq < 0)
-		return d->irq;
-
-	ret = devm_request_irq(&pdev->dev, d->irq, dma_interrupt, 0,
-			       DRIVER_NAME, d);
-	if (ret)
-		return ret;
-
-	d->wq = alloc_ordered_workqueue("dma_wq", WQ_MEM_RECLAIM |
-			WQ_HIGHPRI);
-	if (!d->wq)
-		return -ENOMEM;
-
-	return 0;
+	return d->ops->dma_irq_init(d, pdev);
 }
 
 static void ldma_clk_disable(void *data)
@@ -1487,14 +771,24 @@ static void ldma_clk_disable(void *data)
 	reset_control_assert(d->rst);
 }
 
-static int intel_ldma_port_channel_init(struct ldma_dev *d)
+static const struct of_device_id intel_ldma_match[] = {
+	{ .compatible = "intel,lgm-cdma", .data = &cdma_ops },
+	{ .compatible = "intel,lgm-hdma", .data = &hdma_ops },
+	{}
+};
+
+/* Initialize DMA controller, port, channel structures */
+static int ldma_init(struct ldma_dev *d)
 {
 	struct ldma_chan *c;
 	struct ldma_port *p;
 	unsigned long ch_mask;
-	int i,j;
+	int i, ret;
+
+	ret = d->ops->dma_ctrl_init(d);
+	if (ret)
+		return ret;
 
-	/* Port Initializations */
 	d->ports = devm_kcalloc(d->dev, d->port_nrs, sizeof(*p), GFP_KERNEL);
 	if (!d->ports)
 		return -ENOMEM;
@@ -1507,31 +801,23 @@ static int intel_ldma_port_channel_init(struct ldma_dev *d)
 	for (i = 0; i < d->port_nrs; i++) {
 		p = &d->ports[i];
 		p->portid = i;
-		p->ldev = d;
-
-		p->rxendi = DMA_DFT_ENDIAN;
-		p->txendi = DMA_DFT_ENDIAN;
-		p->rxbl = DMA_DFT_BURST;
-		p->txbl = DMA_DFT_BURST;
-		p->pkt_drop = DMA_PKT_DROP_DIS;
+		ret = d->ops->dma_port_init(d, p);
+		if (ret)
+			return ret;
 	}
 
 	ch_mask = (unsigned long)d->channels_mask;
-	for_each_set_bit(j, &ch_mask, d->chan_nrs) {
-		if (d->ver == DMA_VER22)
-			ldma_dma_init_v22(j, d);
-		else
-			ldma_dma_init_v3X(j, d);
+	for_each_set_bit(i, &ch_mask, d->chan_nrs) {
+		c = &d->chans[i];
+		c->nr = i;
+		ret = d->ops->dma_chan_init(d, c);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
 }
 
-static const struct of_device_id intel_ldma_match[] = {
-	{ .compatible = "intel,lgm-ldma" },
-	{}
-};
-
 static int intel_ldma_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1547,6 +833,12 @@ static int intel_ldma_probe(struct platform_device *pdev)
 	/* Link controller to platform device */
 	d->dev = &pdev->dev;
 
+	d->ops = device_get_match_data(dev);
+	if (!d->ops) {
+		dev_err(dev, "No device match found!\n");
+		return -ENODEV;
+	}
+
 	d->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(d->base))
 		return PTR_ERR(d->base);
@@ -1593,11 +885,13 @@ static int intel_ldma_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (d->ver == DMA_VER22) {
-		ret = ldma_init_v22(d, pdev);
-		if (ret)
-			return ret;
-	}
+	ret = ldma_init(d);
+	if (ret)
+		return ret;
+
+	ret = ldma_irq_init(d, pdev);
+	if (ret)
+		return ret;
 
 	dma_dev = &d->dma_dev;
 	dma_dev->dev = &pdev->dev;
@@ -1608,29 +902,8 @@ static int intel_ldma_probe(struct platform_device *pdev)
 	/* Channel initializations */
 	INIT_LIST_HEAD(&dma_dev->channels);
 
-	ret = intel_ldma_port_channel_init(d);
-	if (ret)
-		return ret;
-
-	dma_dev->device_alloc_chan_resources = ldma_alloc_chan_resources;
-	dma_dev->device_free_chan_resources = ldma_free_chan_resources;
-	dma_dev->device_terminate_all = ldma_terminate_all;
-	dma_dev->device_issue_pending = ldma_issue_pending;
-	dma_dev->device_tx_status = ldma_tx_status;
-	dma_dev->device_resume = ldma_resume_chan;
-	dma_dev->device_pause = ldma_pause_chan;
-	dma_dev->device_prep_slave_sg = ldma_prep_slave_sg;
-
-	if (d->ver == DMA_VER22) {
-		dma_dev->device_config = ldma_slave_config;
-		dma_dev->device_synchronize = ldma_synchronize;
-		dma_dev->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
-		dma_dev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
-		dma_dev->directions = BIT(DMA_MEM_TO_DEV) |
-				      BIT(DMA_DEV_TO_MEM);
-		dma_dev->residue_granularity =
-					DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
-	}
+	/* init dma callback functions */
+	d->ops->dma_func_init(dma_dev);
 
 	platform_set_drvdata(pdev, d);
 
diff --git a/drivers/dma/lgm/lgm-dma.h b/drivers/dma/lgm/lgm-dma.h
new file mode 100644
index 000000000000..ff5aa5142019
--- /dev/null
+++ b/drivers/dma/lgm/lgm-dma.h
@@ -0,0 +1,278 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Definitions related to LGM DMA.
+ *
+ * Copyright (c) 2025 Maxlinear Inc.
+ */
+
+#ifndef _LGM_DMA_H
+#define _LGM_DMA_H
+
+enum ldma_chan_on_off {
+	DMA_CH_OFF = 0,
+	DMA_CH_ON = 1,
+};
+
+enum {
+	DMA_TYPE_INVD = -1, /* Legacy DMA does not have type */
+	DMA_TYPE_TX = 0,
+	DMA_TYPE_RX,
+	DMA_TYPE_MCPY,
+};
+
+enum {
+	DMA_IN_HW_MODE,
+	DMA_IN_SW_MODE,
+};
+
+struct ldma_dev;
+struct ldma_port;
+struct ldma_chan;
+
+struct ldma_ops {
+	/* DMA control level init */
+	int (*dma_ctrl_init)(struct ldma_dev *d);
+	/* DMA port level init */
+	int (*dma_port_init)(struct ldma_dev *d, struct ldma_port *p);
+	/* DMA channel level init */
+	int (*dma_chan_init)(struct ldma_dev *d, struct ldma_chan *c);
+	/* DMA interrupt init */
+	int (*dma_irq_init)(struct ldma_dev *d, struct platform_device *pdev);
+	/* DMA callback API init */
+	void (*dma_func_init)(struct dma_device *dma_dev);
+};
+
+struct ldma_chan {
+	struct virt_dma_chan	vchan;
+	struct ldma_port	*port; /* back pointer */
+	char			name[8]; /* Channel name */
+	int			nr; /* Channel id in hardware */
+	u32			flags; /* central way or channel based way */
+	enum ldma_chan_on_off	onoff;
+	dma_addr_t		desc_phys;
+	void			*desc_base; /* Virtual address */
+	u32			desc_cnt; /* Number of descriptors */
+	int			rst;
+	u32			hdrm_len;
+	bool			hdrm_csum;
+	u32			boff_len;
+	u32			data_endian;
+	u32			desc_endian;
+	bool			pden;
+	bool			desc_rx_np;
+	bool			data_endian_en;
+	bool			desc_endian_en;
+	bool			abc_en;
+	bool			desc_init;
+	void			*priv;
+};
+
+struct ldma_port {
+	struct ldma_dev		*ldev; /* back pointer */
+	u32			portid;
+	u32			rxbl;
+	u32			txbl;
+	u32			rxendi;
+	u32			txendi;
+	u32			pkt_drop;
+};
+
+struct ldma_dev {
+	struct device		*dev;
+	void __iomem		*base;
+	struct reset_control	*rst;
+	struct clk		*core_clk;
+	struct dma_device	dma_dev;
+	u32			ver;
+	int			irq;
+	struct ldma_port	*ports;
+	struct ldma_chan	*chans; /* channel list on this DMA or port */
+	spinlock_t		dev_lock; /* Controller register exclusive */
+	u32			chan_nrs;
+	u32			port_nrs;
+	u32			channels_mask;
+	u32			flags;
+	u32			pollcnt;
+	u32			orrc; /* Outstanding read count */
+	int			type;
+	const char		*name;
+	const struct ldma_ops	*ops;
+};
+
+extern struct ldma_ops cdma_ops;
+extern struct ldma_ops hdma_ops;
+
+#define DRIVER_NAME			"lgm-dma"
+
+#define DMA_ID				0x0008
+#define DMA_ID_REV			GENMASK(7, 0)
+#define DMA_ID_PNR			GENMASK(19, 16)
+#define DMA_ID_CHNR			GENMASK(26, 20)
+#define DMA_ID_DW_128B			BIT(27)
+#define DMA_ID_AW_36B			BIT(28)
+#define DMA_VER32			0x32
+#define DMA_VER31			0x31
+#define DMA_VER22			0x0A
+
+#define DMA_CTRL			0x0010
+#define DMA_CTRL_RST			BIT(0)
+#define DMA_CTRL_DSRAM_PATH		BIT(1)
+#define DMA_CTRL_DBURST_WR		BIT(3)
+#define DMA_CTRL_VLD_DF_ACK		BIT(4)
+#define DMA_CTRL_CH_FL			BIT(6)
+#define DMA_CTRL_DS_FOD			BIT(7)
+#define DMA_CTRL_DRB			BIT(8)
+#define DMA_CTRL_ENBE			BIT(9)
+#define DMA_CTRL_DESC_TMOUT_CNT_V31	GENMASK(27, 16)
+#define DMA_CTRL_DESC_TMOUT_EN_V31	BIT(30)
+#define DMA_CTRL_PKTARB			BIT(31)
+
+#define DMA_CPOLL			0x0014
+#define DMA_CPOLL_CNT			GENMASK(15, 4)
+#define DMA_CPOLL_EN			BIT(31)
+
+#define DMA_CS				0x0018
+#define DMA_CS_MASK			GENMASK(5, 0)
+
+#define DMA_CCTRL			0x001C
+#define DMA_CCTRL_ON			BIT(0)
+#define DMA_CCTRL_RST			BIT(1)
+#define DMA_CCTRL_CH_POLL_EN		BIT(2)
+#define DMA_CCTRL_CH_ABC		BIT(3) /* Adaptive Burst Chop */
+#define DMA_CDBA_MSB			GENMASK(7, 4)
+#define DMA_CCTRL_DIR_TX		BIT(8)
+#define DMA_CCTRL_CLASS			GENMASK(11, 9)
+#define DMA_CCTRL_CLASSH		GENMASK(19, 18)
+#define DMA_CCTRL_WR_NP_EN		BIT(21)
+#define DMA_CCTRL_PDEN			BIT(23)
+#define DMA_MAX_CLASS			(SZ_32 - 1)
+
+#define DMA_CDBA			0x0020
+#define DMA_CDLEN			0x0024
+#define DMA_CIS				0x0028
+#define DMA_CIE				0x002C
+#define DMA_CI_EOP			BIT(1)
+#define DMA_CI_DUR			BIT(2)
+#define DMA_CI_DESCPT			BIT(3)
+#define DMA_CI_CHOFF			BIT(4)
+#define DMA_CI_RDERR			BIT(5)
+#define DMA_CI_ALL							\
+	(DMA_CI_EOP | DMA_CI_DUR | DMA_CI_DESCPT | DMA_CI_CHOFF | DMA_CI_RDERR)
+
+#define DMA_PS				0x0040
+#define DMA_PCTRL			0x0044
+#define DMA_PCTRL_RXBL16		BIT(0)
+#define DMA_PCTRL_TXBL16		BIT(1)
+#define DMA_PCTRL_RXBL			GENMASK(3, 2)
+#define DMA_PCTRL_RXBL_8		3
+#define DMA_PCTRL_TXBL			GENMASK(5, 4)
+#define DMA_PCTRL_TXBL_8		3
+#define DMA_PCTRL_PDEN			BIT(6)
+#define DMA_PCTRL_RXBL32		BIT(7)
+#define DMA_PCTRL_RXENDI		GENMASK(9, 8)
+#define DMA_PCTRL_TXENDI		GENMASK(11, 10)
+#define DMA_PCTRL_TXBL32		BIT(15)
+#define DMA_PCTRL_MEM_FLUSH		BIT(16)
+
+#define DMA_IRNEN1			0x00E8
+#define DMA_IRNCR1			0x00EC
+#define DMA_IRNEN			0x00F4
+#define DMA_IRNCR			0x00F8
+#define DMA_C_DP_TICK			0x100
+#define DMA_C_DP_TICK_TIKNARB		GENMASK(15, 0)
+#define DMA_C_DP_TICK_TIKARB		GENMASK(31, 16)
+
+#define DMA_C_HDRM			0x110
+/*
+ * If header mode is set in DMA descriptor,
+ *   If bit 30 is disabled, HDR_LEN must be configured according to channel
+ *     requirement.
+ *   If bit 30 is enabled(checksum with header mode), HDR_LEN has no need to
+ *     be configured. It will enable check sum for switch
+ * If header mode is not set in DMA descriptor,
+ *   This register setting doesn't matter
+ */
+#define DMA_C_HDRM_HDR_SUM		BIT(30)
+
+#define DMA_C_BOFF			0x120
+#define DMA_C_BOFF_BOF_LEN		GENMASK(7, 0)
+#define DMA_C_BOFF_EN			BIT(31)
+
+#define DMA_ORRC			0x190
+#define DMA_ORRC_ORRCNT			GENMASK(8, 4)
+#define DMA_ORRC_EN			BIT(31)
+
+#define DMA_C_ENDIAN			0x200
+#define DMA_C_END_DATAENDI		GENMASK(1, 0)
+#define DMA_C_END_DE_EN			BIT(7)
+#define DMA_C_END_DESENDI		GENMASK(9, 8)
+#define DMA_C_END_DES_EN		BIT(16)
+
+/* DMA controller capability */
+#define DMA_ADDR_36BIT			BIT(0)
+#define DMA_DATA_128BIT			BIT(1)
+#define DMA_CHAN_FLOW_CTL		BIT(2)
+#define DMA_DESC_FOD			BIT(3)
+#define DMA_DESC_IN_SRAM		BIT(4)
+#define DMA_EN_BYTE_EN			BIT(5)
+#define DMA_DBURST_WR			BIT(6)
+#define DMA_VALID_DESC_FETCH_ACK	BIT(7)
+#define DMA_DFT_DRB			BIT(8)
+
+#define DMA_ORRC_MAX_CNT		16
+#define DMA_DFT_POLL_CNT		SZ_4
+#define DMA_DFT_BURST_V22		SZ_2
+#define DMA_BURSTL_8DW			SZ_8
+#define DMA_BURSTL_16DW			SZ_16
+#define DMA_BURSTL_32DW			SZ_32
+#define DMA_DFT_BURST			DMA_BURSTL_16DW
+#define DMA_MAX_DESC_NUM		(SZ_8K - 1)
+#define DMA_CHAN_BOFF_MAX		(SZ_256 - 1)
+#define DMA_DFT_ENDIAN			0
+
+#define DMA_DFT_DESC_TCNT		50
+#define DMA_HDR_LEN_MAX			(SZ_16K - 1)
+
+/* DMA flags */
+#define DMA_TX_CH			BIT(0)
+#define DMA_RX_CH			BIT(1)
+#define DEVICE_ALLOC_DESC		BIT(2)
+#define CHAN_IN_USE			BIT(3)
+#define DMA_HW_DESC			BIT(4)
+
+/* Descriptor fields */
+#define DESC_DATA_LEN			GENMASK(15, 0)
+#define DESC_BYTE_OFF			GENMASK(25, 23)
+#define DESC_EOP			BIT(28)
+#define DESC_SOP			BIT(29)
+#define DESC_C				BIT(30)
+#define DESC_OWN			BIT(31)
+
+#define DMA_CHAN_RST			1
+#define DMA_MAX_SIZE			(BIT(16) - 1)
+#define MAX_LOWER_CHANS			32
+#define MASK_LOWER_CHANS		GENMASK(4, 0)
+#define DMA_OWN				1
+#define HIGH_4_BITS			GENMASK(3, 0)
+#define DMA_DFT_DESC_NUM		1
+#define DMA_PKT_DROP_DIS		0
+
+static inline struct ldma_chan *to_ldma_chan(struct dma_chan *chan)
+{
+	return container_of(chan, struct ldma_chan, vchan.chan);
+}
+
+static inline struct ldma_dev *to_ldma_dev(struct dma_device *dma_dev)
+{
+	return container_of(dma_dev, struct ldma_dev, dma_dev);
+}
+
+void ldma_chan_desc_hw_cfg(struct ldma_chan *c, dma_addr_t desc_base,
+			   int desc_num);
+int ldma_terminate_all(struct dma_chan *chan);
+int ldma_resume_chan(struct dma_chan *chan);
+int ldma_pause_chan(struct dma_chan *chan);
+int ldma_chan_reset(struct ldma_chan *c);
+int ldma_chan_on(struct ldma_chan *c);
+
+#endif
diff --git a/drivers/dma/lgm/lgm-hdma.c b/drivers/dma/lgm/lgm-hdma.c
new file mode 100644
index 000000000000..9133aa31c47b
--- /dev/null
+++ b/drivers/dma/lgm/lgm-hdma.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Lightning Mountain centralized DMA controller driver
+ *
+ * Copyright (c) 2025 Maxlinear Inc.
+ */
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmapool.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/of_dma.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+
+#include "../dmaengine.h"
+#include "../virt-dma.h"
+#include "lgm-dma.h"
+
+static int hdma_ctrl_init(struct ldma_dev *d);
+static int hdma_port_init(struct ldma_dev *d, struct ldma_port *p);
+static int hdma_chan_init(struct ldma_dev *d, struct ldma_chan *c);
+static int hdma_irq_init(struct ldma_dev *d, struct platform_device *pdev);
+static void hdma_func_init(struct dma_device *dma_dev);
+static void hdma_free_chan_resources(struct dma_chan *dma_chan);
+
+struct ldma_ops hdma_ops = {
+	.dma_ctrl_init = hdma_ctrl_init,
+	.dma_port_init = hdma_port_init,
+	.dma_chan_init = hdma_chan_init,
+	.dma_irq_init  = hdma_irq_init,
+	.dma_func_init = hdma_func_init,
+};
+
+static int hdma_ctrl_init(struct ldma_dev *d)
+{
+	return 0;
+}
+
+static int hdma_port_init(struct ldma_dev *d, struct ldma_port *p)
+{
+	p->ldev = d;
+	p->rxendi = DMA_DFT_ENDIAN;
+	p->txendi = DMA_DFT_ENDIAN;
+	p->rxbl = DMA_DFT_BURST;
+	p->txbl = DMA_DFT_BURST;
+	p->pkt_drop = DMA_PKT_DROP_DIS;
+
+	return 0;
+}
+
+static inline void hdma_free_desc_resource(struct virt_dma_desc *vdesc)
+{
+}
+
+static int hdma_chan_init(struct ldma_dev *d, struct ldma_chan *c)
+{
+	c->data_endian = DMA_DFT_ENDIAN;
+	c->desc_endian = DMA_DFT_ENDIAN;
+	c->data_endian_en = false;
+	c->desc_endian_en = false;
+	c->desc_rx_np = false;
+	c->flags |= DEVICE_ALLOC_DESC;
+	c->onoff = DMA_CH_OFF;
+	c->rst = DMA_CHAN_RST;
+	c->abc_en = true;
+	c->hdrm_csum = false;
+	c->boff_len = 0;
+	c->vchan.desc_free = hdma_free_desc_resource;
+	vchan_init(&c->vchan, &d->dma_dev);
+
+	return 0;
+}
+
+static int hdma_irq_init(struct ldma_dev *d, struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int hdma_alloc_chan_resources(struct dma_chan *dma_chan)
+{
+	struct ldma_chan *c = to_ldma_chan(dma_chan);
+	struct device *dev = c->vchan.chan.device->dev;
+
+	dev_dbg(dev, "allocate channel resource!\n");
+
+	if (c->flags & DMA_HW_DESC) {
+		c->flags |= CHAN_IN_USE;
+		dev_dbg(dev, "desc in hw\n");
+	}
+
+	return 0;
+}
+
+static void hdma_free_chan_resources(struct dma_chan *dma_chan)
+{
+	struct ldma_chan *c = to_ldma_chan(dma_chan);
+
+	c->flags &= ~CHAN_IN_USE;
+}
+
+static void hdma_issue_pending(struct dma_chan *dma_chan)
+{
+	struct ldma_chan *c = to_ldma_chan(dma_chan);
+
+	ldma_chan_on(c);
+}
+
+static enum dma_status
+hdma_tx_status(struct dma_chan *dma_chan, dma_cookie_t cookie,
+	       struct dma_tx_state *txstate)
+{
+	return DMA_COMPLETE;
+}
+
+static void hdma_func_init(struct dma_device *dma_dev)
+{
+	dma_dev->device_alloc_chan_resources = hdma_alloc_chan_resources;
+	dma_dev->device_free_chan_resources = hdma_free_chan_resources;
+	dma_dev->device_terminate_all = ldma_terminate_all;
+	dma_dev->device_issue_pending = hdma_issue_pending;
+	dma_dev->device_tx_status = hdma_tx_status;
+	dma_dev->device_resume = ldma_resume_chan;
+	dma_dev->device_pause = ldma_pause_chan;
+}
-- 
2.43.5


