Return-Path: <dmaengine+bounces-5970-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 049C1B1E0ED
	for <lists+dmaengine@lfdr.de>; Fri,  8 Aug 2025 05:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E03C18A564B
	for <lists+dmaengine@lfdr.de>; Fri,  8 Aug 2025 03:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0051ADC83;
	Fri,  8 Aug 2025 03:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="r9x6P/r7"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2063.outbound.protection.outlook.com [40.107.101.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A50A3FE4;
	Fri,  8 Aug 2025 03:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754623410; cv=fail; b=kxoK1JcHsZqA/d55j4WYi6D94cWLr4euu5l/tKPVX2gpObuFfHi19xQ0krkCal5powa8j616cc8+n3fOM95lrhGXgsFDJ1odrkHq1+pu7lbjTFS+ELvZTBIFxJCD2mHUNuTYBbgttsb0jtt2EQznumu1/x/XJHyNfM7ubGJEBHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754623410; c=relaxed/simple;
	bh=LQ4XGJ08z+devQNhDqM1vFrUHf9COlC6vo2PCtcC02U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lMGI4fjG5Y4dB56U10e3ZRukYoutJcyXFejPkXZkQpCrX34f4NxVm70mHmzwJo2ekHPq8iQHdqa+51iqH8gSMWmXNuCjSCPvUPjY4zZMpzsNOgfIFPeLJzoEy2W/6knPkHqyK3a8z7rmelqSgy+BUbn4W4KtOP8q2fN1ifH9lE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=r9x6P/r7; arc=fail smtp.client-ip=40.107.101.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyN0NPQ78XhpQs85Bc7MLuqsCT+mUV1IoiJuBuk8YLW+0WbxFoF5QFwiogk0plB0U61tTekpTfEeor5UZC4kav3TFabpanj8Uk/SGZQA3RKnIRz38Rmbnn8PHx7O2VtPq9BPo1tkJ9kpM41bnuwGouDHnQ1h+WIpFgilihJB+i7Z+E9sJpAw82OptSuF9CvQcH4zycLz8kU2DTuraHC5+SER5XGOF9fXyekQpqThSnyl1RWS8OgadZeha0yZzfxRT2IwQD4KbL2BlCUkLAg+pXShAN8xOeioI5lVxeH4SOgZmwnpUbeosg3JOLmau35Cwdtulm3T8vZ1feXxOd45EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KYWZ3BITKvKBpz3E6HgIIqj8+DQqVCO9FY4IZSej7+o=;
 b=dana8Gqx5st9XVL8p0Lhu+kWTitKzxbbRm2yFuPFKJ5sFaJLYPP3cQfMN7pxqGdGanXCva4CGSH0pfBMP2nXf8MQNIfJRx3czR3PlKvzyTqbJh6Fqce/S6M429X1EASxoDpzv/zrDPK/Qc0Cwnyd+ma/NZo6mHs77Uv4cYhyUNouCpvhH6+8zC178ZvhmHmCN5XM/pAz+oSvTwDYvIgY2iThLwh6rp4AyDfhK1GHNT3puGChuoHMaU1IY023RFQiHU3EPLiCcehzhoi40KqPjMLqWax8CBnMYMxREy/yg/6rtxIx7y+PJxs7CfKoDyPFvjEWsAnBVc29D2TFIYI33A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 174.47.1.84) smtp.rcpttodomain=kernel.org smtp.mailfrom=maxlinear.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=maxlinear.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYWZ3BITKvKBpz3E6HgIIqj8+DQqVCO9FY4IZSej7+o=;
 b=r9x6P/r7CG5r8mntTtH8kbFMVxs1oiMMH7hF/0J8fhLxIrKYAyFoemJ+GQblIBWJ+d4KK0IKdqbLqB3mCbR6/foNEwLrIvJP6fyUS74ww3vT0zfRVXs7BJ4u5dfi0qqFEIbNo8HCC1BNliUbuwO3Ns/I29RGvCaSgzVLAKqqkyMO0xCOgDJmYINw41DBkedhIsmCY2FlYhpr6pSLh83ZsDSm/cectMlb1ovmA0/ttpU6rTPvQ0RPKrhWusGsjSB+dfE6FY/67tuw4eAsyLtJcAK/F4AQ4efoMT41huTN9d5mKAUqEX1SY1UuSvtOVddtHey9wQAlisdcvVn0dHIOgg==
Received: from DM6PR21CA0023.namprd21.prod.outlook.com (2603:10b6:5:174::33)
 by CH2PR19MB4071.namprd19.prod.outlook.com (2603:10b6:610:a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.9; Fri, 8 Aug
 2025 03:23:19 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:5:174:cafe::32) by DM6PR21CA0023.outlook.office365.com
 (2603:10b6:5:174::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.8 via Frontend Transport; Fri, 8
 Aug 2025 03:23:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 174.47.1.84)
 smtp.mailfrom=maxlinear.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=maxlinear.com;
Received-SPF: Pass (protection.outlook.com: domain of maxlinear.com designates
 174.47.1.84 as permitted sender) receiver=protection.outlook.com;
 client-ip=174.47.1.84; helo=usmxlcas.maxlinear.com; pr=C
Received: from usmxlcas.maxlinear.com (174.47.1.84) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 03:23:19 +0000
Received: from sgb015.sgsw.maxlinear.com (10.23.238.15) by mail.maxlinear.com
 (10.23.38.119) with Microsoft SMTP Server id 15.1.2507.39; Thu, 7 Aug 2025
 20:23:15 -0700
From: Zhu Yixin <yzhu@maxlinear.com>
To: <vkoul@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <p.zabel@pengutronix.de>, <kees@kernel.org>,
	<dave.jiang@intel.com>, <av2082000@gmail.com>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Zhu Yixin <yzhu@maxlinear.com>
Subject: [PATCH v2 2/3] dmaengine: lgm-dma: splitting CDMA and HDMA functions.
Date: Fri, 8 Aug 2025 11:22:42 +0800
Message-ID: <20250808032243.3796335-2-yzhu@maxlinear.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250808032243.3796335-1-yzhu@maxlinear.com>
References: <20250808032243.3796335-1-yzhu@maxlinear.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|CH2PR19MB4071:EE_
X-MS-Office365-Filtering-Correlation-Id: 10e047d0-3978-4d9d-f956-08ddd62aec05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S128tdrCm9uGBs97mU5fiCn0lQn2G3kbtIIkS5TOFv5mnFkpIrCZMq4vtowe?=
 =?us-ascii?Q?6zrilNHIXfcR9jCGW8bTJFOBXcv8KqwDEFB3tlv9TwshAVYEaCz0efoL8Vq3?=
 =?us-ascii?Q?mB7kKLIpmFnB2c5M1jfbeaaygC5UvW+uDPx1OKTk2ZTOaWKKo475E0rBA3QU?=
 =?us-ascii?Q?gkaVQIQJr7YJNtaLWwwcqJ5lSudK8a4Fi0eS1Y0oyqzmzfe57IOvyylTTUE7?=
 =?us-ascii?Q?ARF+0zwPZtbGWASbhZHtvX0b05wPV6qCOcqwCXGEi37K07syuuN9WftyficY?=
 =?us-ascii?Q?9kq+3Ld86bFZ2qebtcUPeNwDqsHwWtZB4KbqPTvkS9SvBoYZ7lAn8W1pXEAc?=
 =?us-ascii?Q?oApmYsO+oQIujSINf0RoG4NVGETMeT2NtR9D/X67QVSgFraDDyx3jIWWUYFb?=
 =?us-ascii?Q?l2XBvmfAUAq/kh17+RHGVmAxzVSfIa7KfbVqSC8pCrAn5WlzrcaRDstuRa0P?=
 =?us-ascii?Q?M6ovO0FEjAI9LUfz0ycT/NrShlXCXZyRZ3gxCvLMcfvwUjn26QNl7vP8Vj72?=
 =?us-ascii?Q?dxbeig5lxKNvIdWYfMlmoHN7TydGmOL35jdyipPxj9eeqTjWrUXzOYCys9At?=
 =?us-ascii?Q?ucJ49S3rQxDlP8QJ6fI6qwO0Rc6BeQTDBqZ5FszVIJtTNtUmvUEwKaSWJZCg?=
 =?us-ascii?Q?M+XxHWNyGvRVFXDOSkhBTJg1t30zglf/xHbUz2TlEK9Lg+4wDED0K3HtISSl?=
 =?us-ascii?Q?T/4JcSFYBrT2AQAUYRbosT89iu3+8qBt7xNWlIvfb8LfjYan2zIEH04Xctrf?=
 =?us-ascii?Q?3PbArm220jliB6rxnD4HnvU3AQH+oNqjJinDj/tZxdjw21VwpoUw5r8XWNvT?=
 =?us-ascii?Q?T0qgHzU1aC2PbuLDKofyAsRlyKh5BcAfCJwAkDNDfEKjOHOa8RTdYQG8+zdy?=
 =?us-ascii?Q?qSG+/Qj2Fi0Iy5/yRtT7ZhXlLz1BGCZAQMQ9azs313IXa0Y7CO9CGFDac006?=
 =?us-ascii?Q?OTgRt0bSmwNZfcDfHzjcjxtVZ9xoYX9TZxGRZW3Yk4dKk81Sw+vQejaqKUvr?=
 =?us-ascii?Q?mEspwX/h5RzkS3AzyrslfS/5aDZIQ5bcuUVHKZqwfrRx20bkSCMtAN6FsNkY?=
 =?us-ascii?Q?0TlgV4GCUc/T9IigdtKR+8DnvIMCcCM8wyjtB4st2idzpkpZEWGwdkj9VINm?=
 =?us-ascii?Q?eK/I4HL0iMU3rjBRTvz4s/H48wDX7OFmWEQhh9oWc2cyU0L1K9hjkWb/FeJB?=
 =?us-ascii?Q?4sZF4ZbC+rjUGwxI1Q+EC7BROk9d0gkc1pZ8YwqUTmtpWyVwd5nsPC2R6PkQ?=
 =?us-ascii?Q?S/uYkZbnvjEyM3yj1szJ2gF4aCLt2ZoLDHs5XrskZVtYujO2lip6AFWFpx7d?=
 =?us-ascii?Q?L/edsSvsSJFvcOWsK+Zt3wA1noz10C28HHKlpQWaJiVhRf2fIbIMOTLsO3Ah?=
 =?us-ascii?Q?z8PINfJBCgUbaFk8H2LtzQs5pH/+ncfNkUB+AOk0BE1sZrvD+uIJ5F/xxCMP?=
 =?us-ascii?Q?92Oje/wxm9ZpwS6qrrN/IftnktNqidey2D4IQ8fc7cVwAUgC9FrwEgPod+QL?=
 =?us-ascii?Q?J9qX4CqknOIBr+YyjQCqrHN8cwFbEz+wwPrcXA2XCG6QZl74iJE5SETOdA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:174.47.1.84;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:usmxlcas.maxlinear.com;PTR:174-47-1-84.static.ctl.one;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 03:23:19.1973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e047d0-3978-4d9d-f956-08ddd62aec05
X-MS-Exchange-CrossTenant-Id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=dac28005-13e0-41b8-8280-7663835f2b1d;Ip=[174.47.1.84];Helo=[usmxlcas.maxlinear.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB4071

To reduce functional complexity, CDMA and HDMA operations are split into
separate files.

CDMA refers to the legacy DMAv22 that supports software-based management.
In contrast, HDMA refers to DMAv3x and supports hardware-managed mode.

In HDMA hardware mode, the driver is only responsible for configuring
the descriptor base address and descriptor length. The actual generation
and updating of descriptors are handled by another hardware component
without diver intervention.

Signed-off-by: Zhu Yixin <yzhu@maxlinear.com>
---
 drivers/dma/lgm/Makefile   |    2 +-
 drivers/dma/lgm/lgm-cdma.c |  485 +++++++++++++++++
 drivers/dma/lgm/lgm-dma.c  | 1014 ++++++------------------------------
 drivers/dma/lgm/lgm-dma.h  |  311 +++++++++++
 drivers/dma/lgm/lgm-hdma.c |  214 ++++++++
 5 files changed, 1176 insertions(+), 850 deletions(-)
 create mode 100644 drivers/dma/lgm/lgm-cdma.c
 create mode 100644 drivers/dma/lgm/lgm-dma.h
 create mode 100644 drivers/dma/lgm/lgm-hdma.c

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
index 000000000000..72b631504c39
--- /dev/null
+++ b/drivers/dma/lgm/lgm-cdma.c
@@ -0,0 +1,485 @@
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
+#define DESC_DATA_LEN		GENMASK(15, 0)
+#define DMA_DFT_DESC_NUM	1
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
+static int cdma_ctrl_init(struct ldma_dev *d);
+static int cdma_port_init(struct ldma_dev *d, struct ldma_port *p);
+static int cdma_chan_init(struct ldma_dev *d, struct ldma_chan *c);
+static int cdma_irq_init(struct ldma_dev *d, struct platform_device *pdev);
+static void cdma_func_init(struct ldma_dev *d, struct dma_device *dma_dev);
+static irqreturn_t cdma_interrupt(int irq, void *dev_id);
+
+static struct workqueue_struct	*wq_work;
+
+struct ldma_ops ldma_cdma_ops = {
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
+	wq_work = alloc_ordered_workqueue("dma_wq", WQ_MEM_RECLAIM | WQ_HIGHPRI);
+	if (!wq_work)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int cdma_port_init(struct ldma_dev *d, struct ldma_port *p)
+{
+	p->ldev = d;
+	p->rxendi = DMA_DFT_ENDIAN;
+	p->txendi = DMA_DFT_ENDIAN;
+	p->rxbl = DMA_DFT_BURST_V22;
+	p->txbl = DMA_DFT_BURST_V22;
+
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
+	struct ldma_dev *d = chan_to_ldma_dev(c);
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
+	queue_work(wq_work, &chan->work);
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
+	struct ldma_dev *d = chan_to_ldma_dev(c);
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
+	struct ldma_dev *d = chan_to_ldma_dev(c);
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
+	struct ldma_dev *d = chan_to_ldma_dev(c);
+	struct cdma_chan *chan = (struct cdma_chan *)c->priv;
+	struct dw2_desc_sw *ds;
+
+	if (num > c->desc_cnt) {
+		dev_err(d->dev, "sg num %d exceed max %d\n", num, c->desc_cnt);
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
+		dev_dbg(d->dev, "out of memory for link descriptor\n");
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
+static void cdma_func_init(struct ldma_dev *d, struct dma_device *dma_dev)
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
index 8173c3f1075a..4c07693226f7 100644
--- a/drivers/dma/lgm/lgm-dma.c
+++ b/drivers/dma/lgm/lgm-dma.c
@@ -3,8 +3,8 @@
  * Lightning Mountain centralized DMA controller driver
  *
  * Copyright (c) 2016 - 2020 Intel Corporation.
+ * Copyright (c) 2020 - 2025 Maxlinear Inc.
  */
-
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
@@ -21,285 +21,29 @@
 
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
-#define DMA_ORRC_MAX_CNT		(SZ_32 - 1)
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
+#include "lgm-dma.h"
 
 enum {
-	DMA_TYPE_TX = 0,
-	DMA_TYPE_RX,
-	DMA_TYPE_MCPY,
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
+	DMA_ARG_CHAN_ID,
+	DMA_ARG_DESC_CNT,
+	DMA_ARG_PORT_ID,
+	DMA_ARG_BURST_SZ,
 };
 
-/* Instance specific data */
-struct ldma_inst_data {
-	bool			desc_in_sram;
-	bool			chan_fc;
-	bool			desc_fod; /* Fetch On Demand */
-	bool			valid_desc_fetch_ack;
-	u32			orrc; /* Outstanding read count */
-	const char		*name;
-	u32			type;
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
-	const struct ldma_inst_data *inst;
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
-
-static inline void
-ldma_update_bits(struct ldma_dev *d, u32 mask, u32 val, u32 ofs)
+static inline bool ldma_dma_v22(struct ldma_dev *d)
 {
-	u32 old_val, new_val;
-
-	old_val = readl(d->base +  ofs);
-	new_val = (old_val & ~mask) | (val & mask);
-
-	if (new_val != old_val)
-		writel(new_val, d->base + ofs);
-}
-
-static inline struct ldma_chan *to_ldma_chan(struct dma_chan *chan)
-{
-	return container_of(chan, struct ldma_chan, vchan.chan);
-}
-
-static inline struct ldma_dev *to_ldma_dev(struct dma_device *dma_dev)
-{
-	return container_of(dma_dev, struct ldma_dev, dma_dev);
+	if (d->ver == DMA_VER22)
+		return true;
+	else
+		return false;
 }
 
-static inline struct dw2_desc_sw *to_lgm_dma_desc(struct virt_dma_desc *vdesc)
+struct ldma_ops *ldma_dev_get_ops(struct ldma_dev *d)
 {
-	return container_of(vdesc, struct dw2_desc_sw, vdesc);
+	if (ldma_dma_v22(d))
+		return &ldma_cdma_ops;
+	else
+		return &ldma_hdma_ops;
 }
 
 static inline bool ldma_chan_tx(struct ldma_chan *c)
@@ -307,11 +51,6 @@ static inline bool ldma_chan_tx(struct ldma_chan *c)
 	return !!(c->flags & DMA_TX_CH);
 }
 
-static inline bool ldma_chan_is_hw_desc(struct ldma_chan *c)
-{
-	return !!(c->flags & DMA_HW_DESC);
-}
-
 static void ldma_dev_reset(struct ldma_dev *d)
 
 {
@@ -349,7 +88,7 @@ static void ldma_dev_chan_flow_ctl_cfg(struct ldma_dev *d, bool enable)
 	unsigned long flags;
 	u32 mask, val;
 
-	if (d->inst->type != DMA_TYPE_TX)
+	if (d->type != DMA_TYPE_TX)
 		return;
 
 	mask = DMA_CTRL_CH_FL;
@@ -378,7 +117,7 @@ static void ldma_dev_desc_fetch_on_demand_cfg(struct ldma_dev *d, bool enable)
 	unsigned long flags;
 	u32 mask, val;
 
-	if (d->inst->type == DMA_TYPE_MCPY)
+	if (d->type == DMA_TYPE_MCPY)
 		return;
 
 	mask = DMA_CTRL_DS_FOD;
@@ -406,12 +145,11 @@ static void ldma_dev_orrc_cfg(struct ldma_dev *d)
 	u32 val = 0;
 	u32 mask;
 
-	if (d->inst->type == DMA_TYPE_RX)
+	if (d->type == DMA_TYPE_RX || !d->orrc)
 		return;
 
 	mask = DMA_ORRC_EN | DMA_ORRC_ORRCNT;
-	if (d->inst->orrc > 0 && d->inst->orrc <= DMA_ORRC_MAX_CNT)
-		val = DMA_ORRC_EN | FIELD_PREP(DMA_ORRC_ORRCNT, d->inst->orrc);
+	val = DMA_ORRC_EN | FIELD_PREP(DMA_ORRC_ORRCNT, d->orrc);
 
 	spin_lock_irqsave(&d->dev_lock, flags);
 	ldma_update_bits(d, mask, val, DMA_ORRC);
@@ -439,7 +177,7 @@ static void ldma_dev_dburst_wr_cfg(struct ldma_dev *d, bool enable)
 	unsigned long flags;
 	u32 mask, val;
 
-	if (d->inst->type != DMA_TYPE_RX && d->inst->type != DMA_TYPE_MCPY)
+	if (d->type != DMA_TYPE_RX && d->type != DMA_TYPE_MCPY)
 		return;
 
 	mask = DMA_CTRL_DBURST_WR;
@@ -455,7 +193,7 @@ static void ldma_dev_vld_fetch_ack_cfg(struct ldma_dev *d, bool enable)
 	unsigned long flags;
 	u32 mask, val;
 
-	if (d->inst->type != DMA_TYPE_TX)
+	if (d->type != DMA_TYPE_TX)
 		return;
 
 	mask = DMA_CTRL_VLD_DF_ACK;
@@ -505,20 +243,20 @@ static int ldma_dev_cfg(struct ldma_dev *d)
 	enable = !!(d->flags & DMA_VALID_DESC_FETCH_ACK);
 	ldma_dev_vld_fetch_ack_cfg(d, enable);
 
-	if (d->ver > DMA_VER22) {
+	if (ldma_dma_v22(d)) {
 		ldma_dev_orrc_cfg(d);
 		ldma_dev_df_tout_cfg(d, true, DMA_DFT_DESC_TCNT);
 	}
 
 	dev_dbg(d->dev, "%s Controller 0x%08x configuration done\n",
-		d->inst->name, readl(d->base + DMA_CTRL));
+		d->name, readl(d->base + DMA_CTRL));
 
 	return 0;
 }
 
 static int ldma_chan_cctrl_cfg(struct ldma_chan *c, u32 val)
 {
-	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	struct ldma_dev *d = chan_to_ldma_dev(c);
 	u32 class_low, class_high;
 	unsigned long flags;
 	u32 reg;
@@ -547,7 +285,7 @@ static int ldma_chan_cctrl_cfg(struct ldma_chan *c, u32 val)
 
 static void ldma_chan_irq_init(struct ldma_chan *c)
 {
-	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	struct ldma_dev *d = chan_to_ldma_dev(c);
 	unsigned long flags;
 	u32 enofs, crofs;
 	u32 cn_bit;
@@ -573,12 +311,39 @@ static void ldma_chan_irq_init(struct ldma_chan *c)
 	spin_unlock_irqrestore(&d->dev_lock, flags);
 }
 
+static void ldma_chan_irq_en(struct ldma_chan *c, bool en)
+{
+	struct ldma_dev *d = chan_to_ldma_dev(c);
+	u32 enofs, crofs;
+	u32 cn_bit, val;
+
+	if (ldma_chan_is_hw_desc(c))
+		return;
+
+	if (c->nr < MAX_LOWER_CHANS) {
+		enofs = DMA_IRNEN;
+		crofs = DMA_IRNCR;
+		cn_bit = BIT(c->nr);
+	} else {
+		enofs = DMA_IRNEN1;
+		crofs = DMA_IRNCR1;
+		cn_bit = BIT(c->nr - MAX_LOWER_CHANS);
+	}
+
+	writel(cn_bit, d->base + crofs);
+	val = en ? cn_bit : 0;
+	ldma_update_bits(d, cn_bit, val, enofs);
+	val = en ? DMA_CI_EOP : 0;
+	ldma_update_bits(d, DMA_CI_EOP, val, DMA_CIE);
+	dev_dbg(d->dev, "irq: %d, CIE: 0x%x\n", en, readl(d->base + DMA_CIE));
+}
+
 static void ldma_chan_set_class(struct ldma_chan *c, u32 val)
 {
-	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	struct ldma_dev *d = chan_to_ldma_dev(c);
 	u32 class_val;
 
-	if (d->inst->type == DMA_TYPE_MCPY || val > DMA_MAX_CLASS)
+	if (d->type == DMA_TYPE_MCPY || val > DMA_MAX_CLASS)
 		return;
 
 	/* 3 bits low */
@@ -591,11 +356,14 @@ static void ldma_chan_set_class(struct ldma_chan *c, u32 val)
 			 DMA_CCTRL);
 }
 
-static int ldma_chan_on(struct ldma_chan *c)
+int ldma_chan_on(struct ldma_chan *c)
 {
-	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	struct ldma_dev *d = chan_to_ldma_dev(c);
 	unsigned long flags;
 
+	if (c->onoff == DMA_CH_ON)
+		return 0;
+
 	/* If descriptors not configured, not allow to turn on channel */
 	if (WARN_ON(!c->desc_init))
 		return -EINVAL;
@@ -603,6 +371,7 @@ static int ldma_chan_on(struct ldma_chan *c)
 	spin_lock_irqsave(&d->dev_lock, flags);
 	ldma_update_bits(d, DMA_CS_MASK, c->nr, DMA_CS);
 	ldma_update_bits(d, DMA_CCTRL_ON, DMA_CCTRL_ON, DMA_CCTRL);
+	ldma_chan_irq_en(c, true);
 	spin_unlock_irqrestore(&d->dev_lock, flags);
 
 	c->onoff = DMA_CH_ON;
@@ -612,7 +381,7 @@ static int ldma_chan_on(struct ldma_chan *c)
 
 static int ldma_chan_off(struct ldma_chan *c)
 {
-	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	struct ldma_dev *d = chan_to_ldma_dev(c);
 	unsigned long flags;
 	u32 val;
 	int ret;
@@ -620,6 +389,7 @@ static int ldma_chan_off(struct ldma_chan *c)
 	spin_lock_irqsave(&d->dev_lock, flags);
 	ldma_update_bits(d, DMA_CS_MASK, c->nr, DMA_CS);
 	ldma_update_bits(d, DMA_CCTRL_ON, 0, DMA_CCTRL);
+	ldma_chan_irq_en(c, false);
 	spin_unlock_irqrestore(&d->dev_lock, flags);
 
 	ret = readl_poll_timeout_atomic(d->base + DMA_CCTRL, val,
@@ -632,10 +402,10 @@ static int ldma_chan_off(struct ldma_chan *c)
 	return 0;
 }
 
-static void ldma_chan_desc_hw_cfg(struct ldma_chan *c, dma_addr_t desc_base,
-				  int desc_num)
+void ldma_chan_desc_hw_cfg(struct ldma_chan *c, dma_addr_t desc_base,
+			   int desc_num)
 {
-	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	struct ldma_dev *d = chan_to_ldma_dev(c);
 	unsigned long flags;
 
 	spin_lock_irqsave(&d->dev_lock, flags);
@@ -655,45 +425,9 @@ static void ldma_chan_desc_hw_cfg(struct ldma_chan *c, dma_addr_t desc_base,
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
-	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	struct ldma_dev *d = chan_to_ldma_dev(c);
 	unsigned long flags;
 	u32 val;
 	int ret;
@@ -720,7 +454,7 @@ static int ldma_chan_reset(struct ldma_chan *c)
 
 static void ldma_chan_byte_offset_cfg(struct ldma_chan *c, u32 boff_len)
 {
-	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	struct ldma_dev *d = chan_to_ldma_dev(c);
 	u32 mask = DMA_C_BOFF_EN | DMA_C_BOFF_BOF_LEN;
 	u32 val;
 
@@ -736,7 +470,7 @@ static void ldma_chan_byte_offset_cfg(struct ldma_chan *c, u32 boff_len)
 static void ldma_chan_data_endian_cfg(struct ldma_chan *c, bool enable,
 				      u32 endian_type)
 {
-	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	struct ldma_dev *d = chan_to_ldma_dev(c);
 	u32 mask = DMA_C_END_DE_EN | DMA_C_END_DATAENDI;
 	u32 val;
 
@@ -752,7 +486,7 @@ static void ldma_chan_data_endian_cfg(struct ldma_chan *c, bool enable,
 static void ldma_chan_desc_endian_cfg(struct ldma_chan *c, bool enable,
 				      u32 endian_type)
 {
-	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	struct ldma_dev *d = chan_to_ldma_dev(c);
 	u32 mask = DMA_C_END_DES_EN | DMA_C_END_DESENDI;
 	u32 val;
 
@@ -767,7 +501,7 @@ static void ldma_chan_desc_endian_cfg(struct ldma_chan *c, bool enable,
 
 static void ldma_chan_hdr_mode_cfg(struct ldma_chan *c, u32 hdr_len, bool csum)
 {
-	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	struct ldma_dev *d = chan_to_ldma_dev(c);
 	u32 mask, val;
 
 	/* NB, csum disabled, hdr length must be provided */
@@ -786,7 +520,7 @@ static void ldma_chan_hdr_mode_cfg(struct ldma_chan *c, u32 hdr_len, bool csum)
 
 static void ldma_chan_rxwr_np_cfg(struct ldma_chan *c, bool enable)
 {
-	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	struct ldma_dev *d = chan_to_ldma_dev(c);
 	u32 mask, val;
 
 	/* Only valid for RX channel */
@@ -802,7 +536,7 @@ static void ldma_chan_rxwr_np_cfg(struct ldma_chan *c, bool enable)
 
 static void ldma_chan_abc_cfg(struct ldma_chan *c, bool enable)
 {
-	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	struct ldma_dev *d = chan_to_ldma_dev(c);
 	u32 mask, val;
 
 	if (d->ver < DMA_VER32 || ldma_chan_tx(c))
@@ -825,7 +559,7 @@ static int ldma_port_cfg(struct ldma_port *p)
 	reg = FIELD_PREP(DMA_PCTRL_TXENDI, p->txendi);
 	reg |= FIELD_PREP(DMA_PCTRL_RXENDI, p->rxendi);
 
-	if (d->ver == DMA_VER22) {
+	if (ldma_dma_v22(d)) {
 		reg |= FIELD_PREP(DMA_PCTRL_TXBL, p->txbl);
 		reg |= FIELD_PREP(DMA_PCTRL_RXBL, p->rxbl);
 	} else {
@@ -859,7 +593,7 @@ static int ldma_port_cfg(struct ldma_port *p)
 
 static int ldma_chan_cfg(struct ldma_chan *c)
 {
-	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	struct ldma_dev *d = chan_to_ldma_dev(c);
 	unsigned long flags;
 	u32 reg;
 
@@ -870,7 +604,7 @@ static int ldma_chan_cfg(struct ldma_chan *c)
 	ldma_chan_cctrl_cfg(c, reg);
 	ldma_chan_irq_init(c);
 
-	if (d->ver <= DMA_VER22)
+	if (ldma_dma_v22(d))
 		return 0;
 
 	spin_lock_irqsave(&d->dev_lock, flags);
@@ -917,8 +651,6 @@ static void ldma_dev_init(struct ldma_dev *d)
 static int ldma_parse_dt(struct ldma_dev *d)
 {
 	struct fwnode_handle *fwnode = dev_fwnode(d->dev);
-	struct ldma_port *p;
-	int i;
 
 	if (fwnode_property_read_bool(fwnode, "intel,dma-byte-en"))
 		d->flags |= DMA_EN_BYTE_EN;
@@ -929,429 +661,77 @@ static int ldma_parse_dt(struct ldma_dev *d)
 	if (fwnode_property_read_bool(fwnode, "intel,dma-drb"))
 		d->flags |= DMA_DFT_DRB;
 
+	if (!fwnode_property_read_bool(fwnode, "intel,dma-sw-desc"))
+		d->flags |= DMA_CHAN_HW_DESC;
+
 	if (fwnode_property_read_u32(fwnode, "intel,dma-poll-cnt",
 				     &d->pollcnt))
 		d->pollcnt = DMA_DFT_POLL_CNT;
 
+	if (fwnode_property_read_u32(fwnode, "dma-channel-mask",
+				     &d->channels_mask))
+		d->channels_mask = GENMASK(d->chan_nrs - 1, 0);
+
+	if (d->inst->orrc)
+		d->orrc = d->inst->orrc;
+
 	if (d->inst->chan_fc)
 		d->flags |= DMA_CHAN_FLOW_CTL;
 
-	if (d->inst->desc_fod)
-		d->flags |= DMA_DESC_FOD;
+	if (d->flags & DMA_CHAN_HW_DESC) {
+		if (d->inst->desc_fod)
+			d->flags |= DMA_DESC_FOD;
 
-	if (d->inst->desc_in_sram)
-		d->flags |= DMA_DESC_IN_SRAM;
+		if (d->inst->desc_in_sram)
+			d->flags |= DMA_DESC_IN_SRAM;
+	}
 
 	if (d->inst->valid_desc_fetch_ack)
 		d->flags |= DMA_VALID_DESC_FETCH_ACK;
 
-	if (d->ver > DMA_VER22) {
-		if (!d->port_nrs)
-			return -EINVAL;
-
-		for (i = 0; i < d->port_nrs; i++) {
-			p = &d->ports[i];
-			p->rxendi = DMA_DFT_ENDIAN;
-			p->txendi = DMA_DFT_ENDIAN;
-			p->rxbl = DMA_DFT_BURST;
-			p->txbl = DMA_DFT_BURST;
-			p->pkt_drop = DMA_PKT_DROP_DIS;
-		}
-	}
+	d->type = d->inst->type;
+	d->name = d->inst->name;
 
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
+int ldma_terminate_all(struct dma_chan *dma_chan)
 {
-	struct ldma_chan *c = to_ldma_chan(chan);
-	unsigned long flags;
-	LIST_HEAD(head);
+	struct ldma_chan *c = to_ldma_chan(dma_chan);
 
-	spin_lock_irqsave(&c->vchan.lock, flags);
-	vchan_get_all_descriptors(&c->vchan, &head);
-	spin_unlock_irqrestore(&c->vchan.lock, flags);
-	vchan_dma_desc_free_list(&c->vchan, &head);
+	vchan_free_chan_resources(&c->vchan);
 
 	return ldma_chan_reset(c);
 }
 
-static int ldma_resume_chan(struct dma_chan *chan)
-{
-	struct ldma_chan *c = to_ldma_chan(chan);
-
-	ldma_chan_on(c);
-
-	return 0;
-}
-
-static int ldma_pause_chan(struct dma_chan *chan)
-{
-	struct ldma_chan *c = to_ldma_chan(chan);
-
-	return ldma_chan_off(c);
-}
-
-static enum dma_status
-ldma_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
-	       struct dma_tx_state *txstate)
+int ldma_resume_chan(struct dma_chan *dma_chan)
 {
-	struct ldma_chan *c = to_ldma_chan(chan);
-	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
-	enum dma_status status = DMA_COMPLETE;
-
-	if (d->ver == DMA_VER22)
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
+	return ldma_chan_on(to_ldma_chan(dma_chan));
 }
 
-static irqreturn_t dma_interrupt(int irq, void *dev_id)
+int ldma_pause_chan(struct dma_chan *dma_chan)
 {
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
+	return ldma_chan_off(to_ldma_chan(dma_chan));
 }
 
-static void prep_slave_burst_len(struct ldma_chan *c)
+static u32
+chan_burst_len(struct ldma_chan *c, struct ldma_port *p, u32 burst)
 {
-	struct ldma_port *p = c->port;
-	struct dma_slave_config *cfg = &c->config;
-
-	if (cfg->dst_maxburst)
-		cfg->src_maxburst = cfg->dst_maxburst;
+	struct ldma_dev *d = p->ldev;
 
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
+	if (ldma_dma_v22(d))
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
@@ -1371,10 +751,7 @@ update_client_configs(struct of_dma *ofdma, struct of_phandle_args *spec)
 	c = &d->chans[chan_id];
 	c->port = p;
 
-	if (d->ver == DMA_VER22)
-		update_burst_len_v22(c, p, burst);
-	else
-		update_burst_len_v3X(c, p, burst);
+	update_burst_len(c, p, burst);
 
 	ldma_port_cfg(p);
 
@@ -1401,74 +778,58 @@ static struct dma_chan *ldma_xlate(struct of_phandle_args *spec,
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
+	return d->ops->dma_irq_init(d, pdev);
 }
 
-static void ldma_dma_init_v3X(int i, struct ldma_dev *d)
+static void ldma_clk_disable(void *data)
 {
-	struct ldma_chan *c;
+	struct ldma_dev *d = data;
 
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
+	clk_disable_unprepare(d->core_clk);
+	reset_control_assert(d->rst);
 }
 
-static int ldma_init_v22(struct ldma_dev *d, struct platform_device *pdev)
+/* Initialize DMA controller, port, channel structures */
+static int ldma_init(struct ldma_dev *d)
 {
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
+	struct ldma_chan *c;
+	struct ldma_port *p;
+	unsigned long ch_mask;
+	int i, ret;
 
-	ret = devm_request_irq(&pdev->dev, d->irq, dma_interrupt, 0,
-			       DRIVER_NAME, d);
+	ret = d->ops->dma_ctrl_init(d);
 	if (ret)
 		return ret;
 
-	d->wq = alloc_ordered_workqueue("dma_wq", WQ_MEM_RECLAIM |
-			WQ_HIGHPRI);
-	if (!d->wq)
+	d->ports = devm_kcalloc(d->dev, d->port_nrs, sizeof(*p), GFP_KERNEL);
+	if (!d->ports)
 		return -ENOMEM;
 
-	return 0;
-}
+	/* Channels Initializations */
+	d->chans = devm_kcalloc(d->dev, d->chan_nrs, sizeof(*c), GFP_KERNEL);
+	if (!d->chans)
+		return -ENOMEM;
 
-static void ldma_clk_disable(void *data)
-{
-	struct ldma_dev *d = data;
+	for (i = 0; i < d->port_nrs; i++) {
+		p = &d->ports[i];
+		p->portid = i;
+		ret = d->ops->dma_port_init(d, p);
+		if (ret)
+			return ret;
+	}
 
-	clk_disable_unprepare(d->core_clk);
-	reset_control_assert(d->rst);
+	ch_mask = (unsigned long)d->channels_mask;
+	for_each_set_bit(i, &ch_mask, d->chan_nrs) {
+		c = &d->chans[i];
+		c->nr = i;
+		ret = d->ops->dma_chan_init(d, c);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static const struct ldma_inst_data dma0 = {
@@ -1565,12 +926,9 @@ static int intel_ldma_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct dma_device *dma_dev;
-	unsigned long ch_mask;
-	struct ldma_chan *c;
-	struct ldma_port *p;
 	struct ldma_dev *d;
-	u32 id, bitn = 32, j;
-	int i, ret;
+	u32 id, bitn = 32;
+	int ret;
 
 	d = devm_kzalloc(dev, sizeof(*d), GFP_KERNEL);
 	if (!d)
@@ -1581,7 +939,7 @@ static int intel_ldma_probe(struct platform_device *pdev)
 
 	d->inst = device_get_match_data(dev);
 	if (!d->inst) {
-		dev_err(dev, "No device match found\n");
+		dev_err(dev, "No device match found!\n");
 		return -ENODEV;
 	}
 
@@ -1627,17 +985,18 @@ static int intel_ldma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (d->ver == DMA_VER22) {
-		ret = ldma_init_v22(d, pdev);
-		if (ret)
-			return ret;
-	}
+	d->ops = ldma_dev_get_ops(d);
 
-	ret = device_property_read_u32(dev, "dma-channel-mask", &d->channels_mask);
-	if (ret < 0)
-		d->channels_mask = GENMASK(d->chan_nrs - 1, 0);
+	ret = ldma_parse_dt(d);
+	if (ret)
+		return ret;
+
+	ret = ldma_irq_init(d, pdev);
+	if (ret)
+		return ret;
 
 	dma_dev = &d->dma_dev;
+	dma_dev->dev = &pdev->dev;
 
 	dma_cap_zero(dma_dev->cap_mask);
 	dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
@@ -1645,56 +1004,13 @@ static int intel_ldma_probe(struct platform_device *pdev)
 	/* Channel initializations */
 	INIT_LIST_HEAD(&dma_dev->channels);
 
-	/* Port Initializations */
-	d->ports = devm_kcalloc(dev, d->port_nrs, sizeof(*p), GFP_KERNEL);
-	if (!d->ports)
-		return -ENOMEM;
-
-	/* Channels Initializations */
-	d->chans = devm_kcalloc(d->dev, d->chan_nrs, sizeof(*c), GFP_KERNEL);
-	if (!d->chans)
-		return -ENOMEM;
-
-	for (i = 0; i < d->port_nrs; i++) {
-		p = &d->ports[i];
-		p->portid = i;
-		p->ldev = d;
-	}
-
-	dma_dev->dev = &pdev->dev;
-
-	ch_mask = (unsigned long)d->channels_mask;
-	for_each_set_bit(j, &ch_mask, d->chan_nrs) {
-		if (d->ver == DMA_VER22)
-			ldma_dma_init_v22(j, d);
-		else
-			ldma_dma_init_v3X(j, d);
-	}
+	/* init dma callback functions */
+	d->ops->dma_func_init(d, dma_dev);
 
-	ret = ldma_parse_dt(d);
+	ret = ldma_init(d);
 	if (ret)
 		return ret;
 
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
-
 	platform_set_drvdata(pdev, d);
 
 	ldma_dev_init(d);
@@ -1712,8 +1028,8 @@ static int intel_ldma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	dev_info(dev, "Init done - rev: %x, ports: %d channels: %d\n", d->ver,
-		 d->port_nrs, d->chan_nrs);
+	dev_info(dev, "Init done - DMA: %s: rev: %x, ports: %d channels: %d\n",
+		 d->name, d->ver, d->port_nrs, d->chan_nrs);
 
 	return 0;
 }
diff --git a/drivers/dma/lgm/lgm-dma.h b/drivers/dma/lgm/lgm-dma.h
new file mode 100644
index 000000000000..848f9945e438
--- /dev/null
+++ b/drivers/dma/lgm/lgm-dma.h
@@ -0,0 +1,311 @@
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
+	void (*dma_func_init)(struct ldma_dev *d, struct dma_device *dma_dev);
+};
+
+/* Instance specific data */
+struct ldma_inst_data {
+	bool			desc_in_sram;
+	bool			chan_fc;
+	bool			desc_fod; /* Fetch On Demand */
+	bool			valid_desc_fetch_ack;
+	u32			orrc; /* Outstanding read count */
+	const char		*name;
+	u32			type;
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
+	const struct ldma_inst_data *inst;
+	const struct ldma_ops	*ops;
+};
+
+extern struct ldma_ops ldma_cdma_ops;
+extern struct ldma_ops ldma_hdma_ops;
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
+#define DMA_CHAN_HW_DESC		BIT(9)
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
+#define CHAN_IN_USE			BIT(2)
+
+/* Descriptor fields */
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
+static inline struct ldma_dev *chan_to_ldma_dev(struct ldma_chan *c)
+{
+	return to_ldma_dev(c->vchan.chan.device);
+}
+
+static inline bool ldma_chan_is_hw_desc(struct ldma_chan *c)
+{
+	struct ldma_dev *d = chan_to_ldma_dev(c);
+
+	return !!(d->flags & DMA_CHAN_HW_DESC);
+}
+
+static inline void
+ldma_update_bits(struct ldma_dev *d, u32 mask, u32 val, u32 ofs)
+{
+	u32 old_val, new_val;
+
+	old_val = readl(d->base +  ofs);
+	new_val = (old_val & ~mask) | (val & mask);
+
+	if (new_val != old_val)
+		writel(new_val, d->base + ofs);
+}
+
+void ldma_chan_desc_hw_cfg(struct ldma_chan *c, dma_addr_t desc_base,
+			   int desc_num);
+int ldma_terminate_all(struct dma_chan *chan);
+int ldma_resume_chan(struct dma_chan *chan);
+int ldma_pause_chan(struct dma_chan *chan);
+int ldma_chan_reset(struct ldma_chan *c);
+int ldma_chan_on(struct ldma_chan *c);
+struct ldma_ops *ldma_dev_get_ops(struct ldma_dev *d);
+
+#endif
diff --git a/drivers/dma/lgm/lgm-hdma.c b/drivers/dma/lgm/lgm-hdma.c
new file mode 100644
index 000000000000..922c2933c2e5
--- /dev/null
+++ b/drivers/dma/lgm/lgm-hdma.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Lightning Mountain centralized DMA controller driver
+ *
+ * Copyright (c) 2025 Maxlinear Inc.
+ */
+
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
+/* Descriptor fields */
+#define DMA_DFT_DESC_NUM	1024
+
+static int hdma_ctrl_init(struct ldma_dev *d);
+static int hdma_port_init(struct ldma_dev *d, struct ldma_port *p);
+static int hdma_chan_init(struct ldma_dev *d, struct ldma_chan *c);
+static int hdma_irq_init(struct ldma_dev *d, struct platform_device *pdev);
+static void hdma_func_init(struct ldma_dev *d, struct dma_device *dma_dev);
+static void hdma_free_chan_resources(struct dma_chan *dma_chan);
+
+static inline bool is_dma_chan_tx(struct ldma_dev *d)
+{
+	return (d->type == DMA_TYPE_TX);
+}
+
+static inline bool is_dma_chan_rx(struct ldma_dev *d)
+{
+	return (d->type == DMA_TYPE_RX);
+}
+
+struct ldma_ops ldma_hdma_ops = {
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
+static inline void hdma_free_desc_resource(struct virt_dma_desc *vd)
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
+	c->onoff = DMA_CH_OFF;
+	c->rst = DMA_CHAN_RST;
+	c->abc_en = true;
+	c->hdrm_csum = false;
+	c->boff_len = 0;
+	c->desc_cnt = DMA_DFT_DESC_NUM;
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
+/**
+ * Allocate DMA descriptor list
+ */
+static int hdma_alloc_chan_resources(struct dma_chan *dma_chan)
+{
+	struct ldma_chan *c = to_ldma_chan(dma_chan);
+	struct device *dev = c->vchan.chan.device->dev;
+
+	/* HW allocate DMA descriptors */
+	c->flags |= CHAN_IN_USE;
+	dev_dbg(dev, "Alloc DMA channel %u\n", c->nr);
+
+	return 0;
+}
+
+static void hdma_free_chan_resources(struct dma_chan *dma_chan)
+{
+	struct ldma_chan *c = to_ldma_chan(dma_chan);
+	struct device *dev = c->vchan.chan.device->dev;
+
+	ldma_chan_reset(c);
+
+	/* HW allocate DMA descriptors */
+	c->flags &= ~CHAN_IN_USE;
+
+	dev_dbg(dev, "Free DMA channel %u\n", c->nr);
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
+/**
+ * HW Manipulate DMA descriptors.
+ * Only need configure descriptor address and length to DMA.
+ */
+static struct dma_async_tx_descriptor *
+hdma_chan_hw_desc_cfg(struct dma_chan *dma_chan, dma_addr_t desc_base, int desc_num)
+{
+	struct ldma_chan *c = to_ldma_chan(dma_chan);
+	struct ldma_dev *d = chan_to_ldma_dev(c);
+
+	if (!desc_num) {
+		dev_err(d->dev, "Channel %d must allocate descriptor first\n",
+			c->nr);
+		return NULL;
+	}
+
+	if (desc_num > DMA_MAX_DESC_NUM) {
+		dev_err(d->dev, "Channel %d descriptor number out of range %d\n",
+			c->nr, desc_num);
+		return NULL;
+	}
+
+	ldma_chan_desc_hw_cfg(c, desc_base, desc_num);
+
+	c->desc_cnt = desc_num;
+	c->desc_phys = desc_base;
+
+	return NULL;
+}
+
+/**
+ *  HDMA driver design to use 1 to 1 SW and HW descriptor mapping
+ */
+static struct dma_async_tx_descriptor *
+hdma_prep_slave_sg(struct dma_chan *dma_chan, struct scatterlist *sgl,
+		   unsigned int sglen, enum dma_transfer_direction dir,
+		   unsigned long flags, void *context)
+{
+	struct ldma_chan *c = to_ldma_chan(dma_chan);
+	struct device *dev = c->vchan.chan.device->dev;
+
+	if (!sgl || sglen < 1) {
+		dev_err(dev, "%s param error!\n", __func__);
+		return NULL;
+	}
+
+	return hdma_chan_hw_desc_cfg(dma_chan, sgl->dma_address, sglen);
+}
+
+static void hdma_func_init(struct ldma_dev *d, struct dma_device *dma_dev)
+{
+	dma_dev->device_alloc_chan_resources = hdma_alloc_chan_resources;
+	dma_dev->device_free_chan_resources = hdma_free_chan_resources;
+	dma_dev->device_terminate_all = ldma_terminate_all;
+	dma_dev->device_issue_pending = hdma_issue_pending;
+	dma_dev->device_tx_status = hdma_tx_status;
+	dma_dev->device_resume = ldma_resume_chan;
+	dma_dev->device_pause = ldma_pause_chan;
+	dma_dev->device_prep_slave_sg = hdma_prep_slave_sg;
+
+	dma_dev->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
+				BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
+				BIT(DMA_SLAVE_BUSWIDTH_8_BYTES) |
+				BIT(DMA_SLAVE_BUSWIDTH_16_BYTES);
+	dma_dev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
+				BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
+				BIT(DMA_SLAVE_BUSWIDTH_8_BYTES) |
+				BIT(DMA_SLAVE_BUSWIDTH_16_BYTES);
+	if (is_dma_chan_tx(d))
+		dma_dev->directions = BIT(DMA_MEM_TO_DEV);
+	else
+		dma_dev->directions = BIT(DMA_DEV_TO_MEM);
+	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
+}
-- 
2.43.5


