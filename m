Return-Path: <dmaengine+bounces-5971-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A78B1E0F0
	for <lists+dmaengine@lfdr.de>; Fri,  8 Aug 2025 05:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD88618A56CA
	for <lists+dmaengine@lfdr.de>; Fri,  8 Aug 2025 03:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E377E1BD035;
	Fri,  8 Aug 2025 03:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="Gi0w/QVo"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C853A1B4138;
	Fri,  8 Aug 2025 03:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754623413; cv=fail; b=UVfM5jQZUmPWMl2cwu4Sn5lGs94qn60uBe4LLqnDfbcIFEaicPi+Yw8T/299giewdyRMnluPLHJ+F9jcmfBC8CZHLOocDrOiFA+2oCpJkVNBEa4I1q//wx164p1nid19XQhbR7SpWsc/A/0PzqFnSBAPY3s68EaGDqJPYBOFR7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754623413; c=relaxed/simple;
	bh=9BMhO0NQJXS7PJDXM6yZbd8Gd/cu9qbclqPaK9cTLAM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LIJd0Q5udzXMKcAQic77OnAqIThPwrJrgxj2y72C0gKOzDmMapCTQIbuNgd0toS+ba1IewAYpnffTdVVMoM7r5Un9Syg9VbBxwb09PGy+//PwuZsMXv7c+sIeC+J46HPOWZjPmhd6pZKw0W3WDWutb61kDLsFpWmakN0HdBX8EM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=Gi0w/QVo; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O9j8SxsnsPgOehjUhHcrrjHS+wD0h5QPeajBVQ9e6kPgdHFCUmVOOjKXCsWv3qvqXVDBgez9se0MumrfV7LXH7HFGnu0j29+mlQUxdwwPz9SaM0UUhXBVDHBdYfHs3n6FJ9+bY8es9t82/OJIa6k1CFMomMbdaD0C2ziIsz9s5mFnsOC13oC9S7a1AsQS7bUSpQ4Y1g8Fm4HZuU/IOSEgVVtfNyA9LNajvDNVDOkYw1CjZ2Ju9Mv6caPZtY9WPyRPJ0vgD4V2PrtH/ns+Wla9h2/SYas+pDAys8iB4aRYhfn7g31O+IlBIJHETHjdLw5w6k0CMzD4gy2DNqLG7gloQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmvu4vg85i7oFEgjoO4b2gm96bQ2F7+QXAbR1kOSTXQ=;
 b=JZcuWByHmwNtnB6CzQUjENH9xOzwhcFBwG7pvaTAlMR9p9GvTI1ZuPRxq6Z4UV0MFYgZpy5q1xtvc6n8t/VvE4VbFn985x0w8uLf4AO3nIU/c1uRrJ/vTxTUGdfqC9t5s4U8hlduu9kWXzp4z5DB9lUnjG88nF/0hAAYvOrGGqawmcfRp0sNcX0vbDZCl7X4rFFah0a1ly/adpJmChidmaO5F5Mu5oyozE6atZTYk8RiXPObA9yxCu/gUDMtwb9+OI0zkfrpvIjZbYtM4UdKXHkSgRO4PREXAcY1C23CBnsZrQanMgVHBKYLBPfGcZv+Oq+1gImjyrybsbRXbsZslg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 174.47.1.84) smtp.rcpttodomain=kernel.org smtp.mailfrom=maxlinear.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=maxlinear.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmvu4vg85i7oFEgjoO4b2gm96bQ2F7+QXAbR1kOSTXQ=;
 b=Gi0w/QVox6mtcxmtf2/0+xYUFDn5BhAVTABI63sn2w6j0IKTCpbkMSvtn63D6U8ONcdstO/eOc+vNW5ZE0fQvma7Z1WEPU8nBqiT20yG23d2izn2k0X2SvXYbdxKlBXZYIo2dczXx5Z+i4CUuJZVVTbO2Pd7pdcOi77QJEwXAKAU3ebBuKWVceHtNnsweSMzLoYx04W7Av+5TNNeicy3ZTeO5hH2M05rOJZl6DCEnDFWDq+MfxtLPmPjHk8Yfs4RrJ9DpXz1kGO7JoSYBCXH+v5qNlV2fXDoOw23qjIjxPgH/j4qJaN+FzWnY/w/BZLBUJ/F5inlfGoAky8VoOMfbg==
Received: from DS7PR03CA0093.namprd03.prod.outlook.com (2603:10b6:5:3b7::8) by
 LV9PR19MB9040.namprd19.prod.outlook.com (2603:10b6:408:2f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Fri, 8 Aug
 2025 03:23:26 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:5:3b7:cafe::52) by DS7PR03CA0093.outlook.office365.com
 (2603:10b6:5:3b7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.13 via Frontend Transport; Fri,
 8 Aug 2025 03:23:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 174.47.1.84)
 smtp.mailfrom=maxlinear.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=maxlinear.com;
Received-SPF: Pass (protection.outlook.com: domain of maxlinear.com designates
 174.47.1.84 as permitted sender) receiver=protection.outlook.com;
 client-ip=174.47.1.84; helo=usmxlcas.maxlinear.com; pr=C
Received: from usmxlcas.maxlinear.com (174.47.1.84) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 03:23:25 +0000
Received: from sgb015.sgsw.maxlinear.com (10.23.238.15) by mail.maxlinear.com
 (10.23.38.119) with Microsoft SMTP Server id 15.1.2507.39; Thu, 7 Aug 2025
 20:23:21 -0700
From: Zhu Yixin <yzhu@maxlinear.com>
To: <vkoul@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <p.zabel@pengutronix.de>, <kees@kernel.org>,
	<dave.jiang@intel.com>, <av2082000@gmail.com>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Zhu Yixin <yzhu@maxlinear.com>
Subject: [PATCH v2 3/3] dmaengine: lgm-dma: Added Software management functions on HDMA.
Date: Fri, 8 Aug 2025 11:22:43 +0800
Message-ID: <20250808032243.3796335-3-yzhu@maxlinear.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|LV9PR19MB9040:EE_
X-MS-Office365-Filtering-Correlation-Id: 779f83eb-25bb-4628-46f9-08ddd62aefb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f+GEXBpVh2mVN9GXGCXzXwGFJArHeuuSNqa/RQUM1SMRFgaRm98cLimkxq2Z?=
 =?us-ascii?Q?GoiXtyBcyxkolNAXd/aZFGxqUHCuYgDwwGJtPp+3gX+jTJrtDjrWSp6BCuTS?=
 =?us-ascii?Q?LWB5miJ5YPT8qazEPfqqrG5Mkp5KfCH4u+GDIo9c8FxAaEAvFnOZx+i1zmc7?=
 =?us-ascii?Q?S891jGyssEnZRRcMqbMiv2qixuzZR3DEdaQVjePajysG2xIUF9mDjia2rQne?=
 =?us-ascii?Q?eeZ7qWol/lafCOgl7Az7f1+fwZH7v+YHfhB+sKElID3KmxivwxpWMhzITm44?=
 =?us-ascii?Q?Yq5BpO42jp3RdTbBHhyvkENTgsYsTdjTaBj8VPXPltl7FDiDj72gp2Wm7ZJK?=
 =?us-ascii?Q?bBpeUkLY8eAOULaaETXF0QjZYiIu9d5s6X15w4D9RSnitytzy+Ev0cNH/Ago?=
 =?us-ascii?Q?jEmWwk4Hjv2obMMRbMxVjVwRZCliWdE0Y56GJFGyHBifAbHnTAsINJzrr0a1?=
 =?us-ascii?Q?pZUjQuvK9puN3wWGim1ZKLYb9PIvK+WtSGC72sbLLUZBbcz+wKaB/gdPhbSq?=
 =?us-ascii?Q?ifopmVyo8Q7DcJwBz8ZxHGq5n4xt6LeLuM9CK08qiLPxF5zdeHuQSY/n3Y+X?=
 =?us-ascii?Q?GWnIASCLep1+lYZRMVOGbORk1+M6U9Jb1PtygOrt2fOzpOggl9FYlLyjvtP4?=
 =?us-ascii?Q?Unj7MQnnyVg/CAe8Dyfmm7VLgrQ/DCstZobHcoP6H6nAVfeO7KHJlRbw3o32?=
 =?us-ascii?Q?6t5RXdbwB4sTZCQ3a/iV5J2KVB8VH9cF5trn9Awf9NI46PrlHnYo5ZgJo7iE?=
 =?us-ascii?Q?rMNOHeWGzdMEjbGeU9DHnnk5Rvlg8M36LcPgAucnxgJyZZhSyDThsQamA3lM?=
 =?us-ascii?Q?HYzTjhyfdRIqvnk0JPbR3E1SlJo5hJA7IYPko6F3ypSKUHFAECW4id2i8L01?=
 =?us-ascii?Q?3SaCQdgnYGWwGqLlWbt4Ux7oVAGNEDQdmVyt20jj6t1Kc/G+SzmEoNp2BHKJ?=
 =?us-ascii?Q?NS7P0iQaNhga9R9IThHSRrfa9N5uGL6AI7ARkZjftbqwls6c9c+Y0OE6jFU3?=
 =?us-ascii?Q?wYfHvOXsQEolubC+5R6N7RbfNT99KUQqnELWq6QhTIa7hRDczTJkP7P4bsJo?=
 =?us-ascii?Q?lRHAFJ/bvRPjt9v/tcSG69HskEpdY+IbFTyNjd5l2fQE87drEQrvgn8Ms/o9?=
 =?us-ascii?Q?8H9kSZRHZwEFJs22QxLbyYDBVslv/son6BfdXgTroQhQVp2bM8EviSUIzidY?=
 =?us-ascii?Q?+W8swHJiiK71vLAONMcNyAF5PRogAKs+GVtsks8rTzqMYCvsnDlz5vQ5LVXB?=
 =?us-ascii?Q?u+3NtLiCaA4M0Zl7q7Pg0TYF7lSfo/KHa6BdDzlsVXQvGEH0eMi0f8MV/Age?=
 =?us-ascii?Q?LNE2Dg5XDk3EEIT22pnTjA/MduPDMyLgSKbsVbpFdZiA4seROQDHztfbPtfV?=
 =?us-ascii?Q?xBTKIPY1HZcckL1mkHZc+LlIgMFQNffJ2U5p1Z9hTmfwAkegIxxQDb1s0C9M?=
 =?us-ascii?Q?RJcSnJvygM0TXcp+NVXGbOEuozcj+rk0DaGUpbFwMnQ152QJywErhINOyeLF?=
 =?us-ascii?Q?l0GIWpJAZ+lgAeKZEHksgu0nFW5bjK+i66U/b7hIZW/QTWe28JE9+p1IIA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:174.47.1.84;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:usmxlcas.maxlinear.com;PTR:174-47-1-84.static.ctl.one;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 03:23:25.3656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 779f83eb-25bb-4628-46f9-08ddd62aefb1
X-MS-Exchange-CrossTenant-Id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=dac28005-13e0-41b8-8280-7663835f2b1d;Ip=[174.47.1.84];Helo=[usmxlcas.maxlinear.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR19MB9040

A new devicetree property 'intel,dma-sw-desc', has been introduced to
distinguish between software-managed and hardware-managed DMA modes.

In software mode, the driver is responsible for handling the DMA
interrupts, as well as preparing and updating the DMA descriptors.

Signed-off-by: Zhu Yixin <yzhu@maxlinear.com>
---
 drivers/dma/lgm/lgm-hdma.c | 377 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 369 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/lgm/lgm-hdma.c b/drivers/dma/lgm/lgm-hdma.c
index 922c2933c2e5..ef21c1842d94 100644
--- a/drivers/dma/lgm/lgm-hdma.c
+++ b/drivers/dma/lgm/lgm-hdma.c
@@ -24,14 +24,64 @@
 #include "lgm-dma.h"
 
 /* Descriptor fields */
+#define DESC_DATA_LEN		GENMASK(13, 0)
+#define DESC_BP_EXT		GENMASK(26, 23)
+#define DESC_EOP		BIT(28)
+#define DESC_SOP		BIT(29)
+#define DESC_C			BIT(30)
+#define DESC_OWN		BIT(31)
 #define DMA_DFT_DESC_NUM	1024
 
+/* RX sideband information from DMA */
+struct dma_rx_data {
+	unsigned int	data_len;
+	unsigned int	chno;
+};
+
+struct dw4_desc_hw {
+	u32 dw0;
+	u32 dw1;
+	u32 dw2;
+	u32 dw3;
+} __packed __aligned(8);
+
+struct dw4_desc_sw {
+	struct virt_dma_desc	vd;
+	struct ldma_chan	*chan;
+	struct dw4_desc_hw	*desc_hw;
+};
+
+/**
+ * hdma TX need some sideband info to switch in dw0 and dw1
+ */
+struct chan_cfg {
+	u32 desc_dw0;
+	u32 desc_dw1;
+};
+
+struct hdma_chan {
+	struct dw4_desc_sw	*ds;
+	struct chan_cfg		cfg;
+	struct ldma_chan	*c;
+	int			prep_idx; /* desc prep idx*/
+	int			comp_idx; /* desc comp idx*/
+	int			prep_desc_cnt;
+	struct tasklet_struct	task;
+};
+
 static int hdma_ctrl_init(struct ldma_dev *d);
 static int hdma_port_init(struct ldma_dev *d, struct ldma_port *p);
 static int hdma_chan_init(struct ldma_dev *d, struct ldma_chan *c);
 static int hdma_irq_init(struct ldma_dev *d, struct platform_device *pdev);
 static void hdma_func_init(struct ldma_dev *d, struct dma_device *dma_dev);
 static void hdma_free_chan_resources(struct dma_chan *dma_chan);
+static void dma_chan_complete(struct tasklet_struct *t);
+
+static inline
+struct dw4_desc_sw *to_lgm_dma_dw4_desc(struct virt_dma_desc *vd)
+{
+	return container_of(vd, struct dw4_desc_sw, vd);
+}
 
 static inline bool is_dma_chan_tx(struct ldma_dev *d)
 {
@@ -74,6 +124,8 @@ static inline void hdma_free_desc_resource(struct virt_dma_desc *vd)
 
 static int hdma_chan_init(struct ldma_dev *d, struct ldma_chan *c)
 {
+	struct hdma_chan *chan;
+
 	c->data_endian = DMA_DFT_ENDIAN;
 	c->desc_endian = DMA_DFT_ENDIAN;
 	c->data_endian_en = false;
@@ -88,12 +140,164 @@ static int hdma_chan_init(struct ldma_dev *d, struct ldma_chan *c)
 	c->vchan.desc_free = hdma_free_desc_resource;
 	vchan_init(&c->vchan, &d->dma_dev);
 
+	chan = devm_kzalloc(d->dev, sizeof(*chan), GFP_KERNEL);
+	if (!chan)
+		return -ENOMEM;
+
+	c->priv = chan;
+	chan->c = c;
+	tasklet_setup(&chan->task, dma_chan_complete);
+
 	return 0;
 }
 
+static inline void hdma_get_irq_off(int high, u32 *en_off, u32 *cr_off)
+{
+	if (!high) {
+		*cr_off = DMA_IRNCR;
+		*en_off = DMA_IRNEN;
+	} else {
+		*cr_off = DMA_IRNCR1;
+		*en_off = DMA_IRNEN1;
+	}
+}
+
+static inline
+void hdma_chan_int_enable(struct ldma_dev *d, struct ldma_chan *c)
+{
+	unsigned long flags;
+	u32 val, en_off, cr_off, cid;
+
+	spin_lock_irqsave(&d->dev_lock, flags);
+	/* select DMA channel */
+	ldma_update_bits(d, DMA_CS_MASK, c->nr, DMA_CS);
+	/* Enable EOP interrupt */
+	ldma_update_bits(d, DMA_CI_EOP, DMA_CI_EOP, DMA_CIE);
+
+	val = c->nr >= MAX_LOWER_CHANS ? 1 : 0;
+	cid = c->nr >= MAX_LOWER_CHANS ? c->nr - MAX_LOWER_CHANS : c->nr;
+	hdma_get_irq_off(val, &en_off, &cr_off);
+	ldma_update_bits(d, BIT(cid), BIT(cid), en_off);
+
+	spin_unlock_irqrestore(&d->dev_lock, flags);
+}
+
+static void dma_chan_complete(struct tasklet_struct *t)
+{
+	struct hdma_chan *chan = from_tasklet(chan, t, task);
+	struct ldma_chan *c = chan->c;
+	struct ldma_dev *d = chan_to_ldma_dev(c);
+
+	/* check how many valid descriptor from DMA */
+	while (chan->prep_desc_cnt > 0) {
+		struct dma_rx_data *data;
+		struct dmaengine_desc_callback cb;
+		struct dma_async_tx_descriptor *tx;
+		struct dw4_desc_sw *desc_sw;
+		struct dw4_desc_hw *desc_hw;
+
+		desc_sw = chan->ds + chan->comp_idx;
+		desc_hw = desc_sw->desc_hw;
+		dma_map_single(d->dev, desc_hw,
+			       sizeof(*desc_hw), DMA_FROM_DEVICE);
+
+		/* desc still in processing, stop */
+		if (!FIELD_GET(DESC_C, desc_hw->dw3))
+			break;
+
+		tx = &desc_sw->vd.tx;
+		dmaengine_desc_get_callback(tx, &cb);
+
+		if (is_dma_chan_rx(d)) {
+			data = (struct dma_rx_data *)cb.callback_param;
+			data->data_len = FIELD_GET(DESC_DATA_LEN, desc_hw->dw3);
+			data->chno = c->nr;
+		}
+
+		dma_cookie_complete(tx);
+		chan->comp_idx = (chan->comp_idx + 1) % c->desc_cnt;
+		chan->prep_desc_cnt -= 1;
+		dmaengine_desc_callback_invoke(&cb, NULL);
+	}
+
+	hdma_chan_int_enable(d, c);
+}
+
+static u64 hdma_irq_stat(struct ldma_dev *d, int high)
+{
+	u32 irnen, irncr, en_off, cr_off, cid;
+	unsigned long flags;
+	u64 ret;
+
+	spin_lock_irqsave(&d->dev_lock, flags);
+
+	hdma_get_irq_off(high, &en_off, &cr_off);
+
+	irncr = readl(d->base + cr_off);
+	irnen = readl(d->base + en_off);
+
+	if (!irncr || !irnen || !(irncr & irnen)) {
+		writel(irncr, d->base + cr_off);
+		spin_unlock_irqrestore(&d->dev_lock, flags);
+		return 0;
+	}
+
+	/* disable EOP interrupt for the channel */
+	for_each_set_bit(cid, (const unsigned long *)&irncr, d->chan_nrs) {
+		/* select DMA channel */
+		ldma_update_bits(d, DMA_CS_MASK, cid, DMA_CS);
+		/* Clear EOP interrupt status */
+		writel(readl(d->base + DMA_CIS), d->base + DMA_CIS);
+		/* Disable EOP interrupt */
+		writel(0, d->base + DMA_CIE);
+	}
+
+	/* ACK interrupt */
+	writel(irncr, d->base + cr_off);
+	irnen &= ~irncr;
+	/* Disable interrupt */
+	writel(irnen, d->base + en_off);
+
+	spin_unlock_irqrestore(&d->dev_lock, flags);
+
+	if (high)
+		ret = (u64)irncr << 32;
+	else
+		ret = (u64)irncr;
+
+	return ret;
+}
+
+static irqreturn_t hdma_interrupt(int irq, void *dev_id)
+{
+	struct ldma_dev *d = dev_id;
+	struct hdma_chan *chan;
+	u32 cid;
+	u64 stat;
+
+	stat = hdma_irq_stat(d, 0) | hdma_irq_stat(d, 1);
+	if (!stat)
+		return IRQ_HANDLED;
+
+	for_each_set_bit(cid, (const unsigned long *)&stat, d->chan_nrs) {
+		chan = (struct hdma_chan *)d->chans[cid].priv;
+		tasklet_schedule(&chan->task);
+	}
+
+	return IRQ_HANDLED;
+}
+
 static int hdma_irq_init(struct ldma_dev *d, struct platform_device *pdev)
 {
-	return 0;
+	if (d->flags & DMA_CHAN_HW_DESC)
+		return 0;
+
+	d->irq = platform_get_irq(pdev, 0);
+	if (d->irq < 0)
+		return d->irq;
+
+	return devm_request_irq(d->dev, d->irq, hdma_interrupt, 0,
+				DRIVER_NAME, d);
 }
 
 /**
@@ -102,40 +306,178 @@ static int hdma_irq_init(struct ldma_dev *d, struct platform_device *pdev)
 static int hdma_alloc_chan_resources(struct dma_chan *dma_chan)
 {
 	struct ldma_chan *c = to_ldma_chan(dma_chan);
+	struct hdma_chan *chan = (struct hdma_chan *)c->priv;
 	struct device *dev = c->vchan.chan.device->dev;
+	struct dw4_desc_sw *desc_sw;
+	struct dw4_desc_hw *desc_hw;
+	size_t desc_sz;
+	int i;
 
 	/* HW allocate DMA descriptors */
-	c->flags |= CHAN_IN_USE;
-	dev_dbg(dev, "Alloc DMA channel %u\n", c->nr);
+	if (ldma_chan_is_hw_desc(c)) {
+		c->flags |= CHAN_IN_USE;
+		dev_dbg(dev, "desc in hw\n");
+		return 0;
+	}
 
-	return 0;
+	if (!c->desc_cnt) {
+		dev_err(dev, "descriptor count is not set\n");
+		return -EINVAL;
+	}
+
+	desc_sz = c->desc_cnt * sizeof(*desc_hw);
+
+	c->desc_base = kzalloc(desc_sz, GFP_KERNEL);
+	if (!c->desc_base)
+		return -ENOMEM;
+
+	c->desc_phys = dma_map_single(dev, c->desc_base,
+				      desc_sz, DMA_TO_DEVICE);
+	if (dma_mapping_error(dev, c->desc_phys)) {
+		dev_err(dev, "dma mapping error for dma desc list\n");
+		goto desc_err;
+	}
+
+	desc_sz = c->desc_cnt * sizeof(*desc_sw);
+	chan->ds = kzalloc(desc_sz, GFP_KERNEL);
+
+	if (!chan->ds)
+		goto desc_err;
+
+	desc_hw = (struct dw4_desc_hw *)c->desc_base;
+	for (i = 0; i < c->desc_cnt; i++) {
+		desc_sw = chan->ds + i;
+		desc_sw->chan = c;
+		desc_sw->desc_hw = desc_hw + i;
+	}
+
+	dev_dbg(dev, "Alloc DMA CH: %u, phy addr: 0x%llx, desc cnt: %u\n",
+		c->nr, c->desc_phys, c->desc_cnt);
+
+	ldma_chan_desc_hw_cfg(c, c->desc_phys, c->desc_cnt);
+	ldma_chan_on(c);
+
+	return c->desc_cnt;
+
+desc_err:
+	kfree(c->desc_base);
+	return -EINVAL;
 }
 
 static void hdma_free_chan_resources(struct dma_chan *dma_chan)
 {
 	struct ldma_chan *c = to_ldma_chan(dma_chan);
+	struct hdma_chan *chan = (struct hdma_chan *)c->priv;
 	struct device *dev = c->vchan.chan.device->dev;
 
 	ldma_chan_reset(c);
 
 	/* HW allocate DMA descriptors */
-	c->flags &= ~CHAN_IN_USE;
+	if (ldma_chan_is_hw_desc(c)) {
+		c->flags &= ~CHAN_IN_USE;
+		dev_dbg(dev, "%s: desc in hw\n", __func__);
+		return;
+	}
+
+	vchan_free_chan_resources(&c->vchan);
+	kfree(chan->ds);
+	kfree(c->desc_base);
 
 	dev_dbg(dev, "Free DMA channel %u\n", c->nr);
 }
 
+static int
+hdma_slave_config(struct dma_chan *dma_chan, struct dma_slave_config *cfg)
+{
+	struct ldma_chan *c = to_ldma_chan(dma_chan);
+	struct hdma_chan *chan = (struct hdma_chan *)c->priv;
+
+	if (cfg->peripheral_config)
+		memcpy(&chan->cfg, cfg->peripheral_config, sizeof(chan->cfg));
+
+	return 0;
+}
+
+static void hdma_desc_set_own(struct dw4_desc_sw *desc_sw)
+{
+	struct ldma_chan *c = desc_sw->chan;
+	struct dw4_desc_hw *desc_hw;
+	struct device *dev = c->vchan.chan.device->dev;
+
+	desc_hw = desc_sw->desc_hw;
+	desc_hw->dw3 |= DESC_OWN;
+
+	dma_map_single(dev, desc_hw, sizeof(*desc_hw), DMA_TO_DEVICE);
+}
+
+static void hdma_execute_pending(struct ldma_chan *c)
+{
+	struct virt_dma_desc *vd = NULL;
+	struct dw4_desc_sw *desc_sw;
+
+	do {
+		vd = vchan_next_desc(&c->vchan);
+		if (!vd)
+			break;
+		list_del(&vd->node);
+		desc_sw = to_lgm_dma_dw4_desc(vd);
+		hdma_desc_set_own(desc_sw);
+	} while (vd);
+}
+
 static void hdma_issue_pending(struct dma_chan *dma_chan)
 {
 	struct ldma_chan *c = to_ldma_chan(dma_chan);
+	unsigned long flags;
 
-	ldma_chan_on(c);
+	if (ldma_chan_is_hw_desc(c)) {
+		ldma_chan_on(c);
+		return;
+	}
+
+	spin_lock_irqsave(&c->vchan.lock, flags);
+	if (vchan_issue_pending(&c->vchan))
+		hdma_execute_pending(c);
+	spin_unlock_irqrestore(&c->vchan.lock, flags);
 }
 
 static enum dma_status
 hdma_tx_status(struct dma_chan *dma_chan, dma_cookie_t cookie,
 	       struct dma_tx_state *txstate)
 {
-	return DMA_COMPLETE;
+	struct ldma_chan *c = to_ldma_chan(dma_chan);
+
+	if (ldma_chan_is_hw_desc(c))
+		return DMA_COMPLETE;
+
+	return dma_cookie_status(dma_chan, cookie, txstate);
+}
+
+/**
+ * initializa the HW DMA descriptor.
+ */
+static void
+hdma_setup_desc(struct ldma_chan *c, struct dw4_desc_hw *desc_hw,
+		dma_addr_t paddr, unsigned int len)
+{
+	struct hdma_chan *chan = (struct hdma_chan *)c->priv;
+	u32 dw3 = 0;
+
+	desc_hw->dw0 = chan->cfg.desc_dw0;
+	desc_hw->dw1 = chan->cfg.desc_dw1;
+	desc_hw->dw2 = lower_32_bits(paddr); /* physicall address */
+
+	dw3 = FIELD_PREP(DESC_DATA_LEN, len);
+	dw3 |= FIELD_PREP(DESC_BP_EXT, upper_32_bits(paddr));
+	dw3 |= FIELD_PREP(DESC_SOP, 1);
+	dw3 |= FIELD_PREP(DESC_EOP, 1);
+	desc_hw->dw3 = dw3;
+}
+
+static inline
+bool hdma_desc_empty(struct hdma_chan *chan, unsigned int desc_cnt)
+{
+	return (chan->prep_desc_cnt == desc_cnt);
 }
 
 /**
@@ -177,14 +519,32 @@ hdma_prep_slave_sg(struct dma_chan *dma_chan, struct scatterlist *sgl,
 		   unsigned long flags, void *context)
 {
 	struct ldma_chan *c = to_ldma_chan(dma_chan);
+	struct hdma_chan *chan = (struct hdma_chan *)c->priv;
 	struct device *dev = c->vchan.chan.device->dev;
+	struct dw4_desc_hw *desc_hw;
+	struct dw4_desc_sw *desc_sw;
 
 	if (!sgl || sglen < 1) {
 		dev_err(dev, "%s param error!\n", __func__);
 		return NULL;
 	}
 
-	return hdma_chan_hw_desc_cfg(dma_chan, sgl->dma_address, sglen);
+	if (ldma_chan_is_hw_desc(c))
+		return hdma_chan_hw_desc_cfg(dma_chan, sgl->dma_address, sglen);
+
+	if (hdma_desc_empty(chan, c->desc_cnt))
+		return NULL;
+
+	desc_sw = chan->ds + chan->prep_idx;
+	chan->prep_idx = (chan->prep_idx + 1) % c->desc_cnt;
+	desc_hw = desc_sw->desc_hw;
+	chan->prep_desc_cnt += 1;
+
+	hdma_setup_desc(c, desc_sw->desc_hw,
+			sg_dma_address(sgl), sg_dma_len(sgl));
+
+	return vchan_tx_prep(&c->vchan, &desc_sw->vd,
+			     DMA_CTRL_ACK);
 }
 
 static void hdma_func_init(struct ldma_dev *d, struct dma_device *dma_dev)
@@ -197,6 +557,7 @@ static void hdma_func_init(struct ldma_dev *d, struct dma_device *dma_dev)
 	dma_dev->device_resume = ldma_resume_chan;
 	dma_dev->device_pause = ldma_pause_chan;
 	dma_dev->device_prep_slave_sg = hdma_prep_slave_sg;
+	dma_dev->device_config = hdma_slave_config;
 
 	dma_dev->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
 				BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
-- 
2.43.5


