Return-Path: <dmaengine+bounces-5891-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE95B157A5
	for <lists+dmaengine@lfdr.de>; Wed, 30 Jul 2025 04:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EA2118A6068
	for <lists+dmaengine@lfdr.de>; Wed, 30 Jul 2025 02:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D6D1A0BF3;
	Wed, 30 Jul 2025 02:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="f3Sh4P6q"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9782260C
	for <dmaengine@vger.kernel.org>; Wed, 30 Jul 2025 02:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753844194; cv=fail; b=CUm3M3wesRfHDHd3ifdcHRZYK5/4DxZ/tDwP4JXz9ZGEMTtaYVqkki0QymCtKxdBe8DFgrwQPiLcbl8zXIm93zN/4AdtqwJSM4iHRMXb5TNFZCJQ9EbpGuD0jjTQcLwTRlNiECY2B2yj5vyi5GMPcniYTKXGSTDAM/29FTj49pA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753844194; c=relaxed/simple;
	bh=y84+LO+8Mexcv4jrExDyertr8XuVZSJJV8eMGuFSlnM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mUlqIx/7U/68VCd6y0IvBBJUgUe7bgSN4x0Rmc6cpfDPFz5vhbGBe9MlURVHO8dMYWoGRof9LZzMO93qicN6B5srTDz1tDneRv08UnwEg3mQKEapn4lw8Z7/w8e4t1fTumkMCsHBT+59gUN3Rqnjo4BW6QzvqZsQq4/BkwiBJbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=f3Sh4P6q; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eUP1pXDQpDvunfpcmuyAwkdVCXfw/59Uj/hNgZ8RgKxqbxt8fMhJW/VlcFPMZrGl/hh5gWEKL0+N3M/fA+V6247oGvW7pf4JjDEFK2adjmdJkZTLx1bOE7Q3HqJJlUJUgqPkmXqz7ERjIjBbti2znoeYp3kwcucYjEx+PwPFW2swdRlkL4QE6a3ikS5fJHzO/erPmPncLdAOrFYi54Mdyj13i82V6ak+EThrkQ+2JinRsnqDEGil8XnalN4JHyFdKfeEIb6MA88U3yRjN+8hGk+O81EufnyFusJd0Z/iP6IWN/ZcIKAigdQ61ffNTk10tQigZDNE++FazFoo5Ci3rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDlF09UjuKHmsn2BXVPRR4uOW2AbDcPe548zHXyRNek=;
 b=XYxqM5fm+Wsbr+P/qdBz7bZCqRGPjaUojY49JuNCfqe1h/jyEBywPRV2L8lej3THyblgORdwTTx2P9hX9m1+VbQY8ZXmhmjQx5wVqs/17YmsSWaRwCMNC6X64WcgE5rdPRzcHDRDMHxrrXcPM2e+ydsi9stGuUqUbcMa2YjKfun9r2xmb29Tiim0CM30CCirG9SX+oV+pWen3MGC9C6lP3N/eWeqnxKCwJexUNm8PMgXkK4HsFFkq1W6KEzlDCpLWN1rwCc9A0lxkdi+VqtksMM+T3QbZ69R2EHXfTpeEzgwkeFba9abavPhWZBmDCVWCftqoNY9bYaifKABaNMk5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 174.47.1.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=maxlinear.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=maxlinear.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDlF09UjuKHmsn2BXVPRR4uOW2AbDcPe548zHXyRNek=;
 b=f3Sh4P6qOXys8r4Ikbk9aWyfaF8Q+12YZtmFBJqsHo2v/bv7ToH4WFcnrhmGY2b+GOwX2VdPswK7oQ2v708cf0u1KeSVZ+wIczTvWcpIX1p4GWfV+E+MYOdu5O2fUZlDB3PzGRnQ1c19g4mT2Buf1juvLsIAXherWJyS6qAFU/yTdquw9kCtCRxCvYGIJz0ylaPXdmVV5XxHg8nrtYed4Zx4pmEXaK/YFzURm+QV9I98wkNnuSIdj7hq39pi07iY6K/VH1J5G/2MDZEaDgvBk+6WAmuZKV20Jqh4VxqX+2gPkHChzfnYj14MaayXlZNezdBxn60Ie9rlP9GohQrrRg==
Received: from DM6PR11CA0055.namprd11.prod.outlook.com (2603:10b6:5:14c::32)
 by DS7PR19MB6278.namprd19.prod.outlook.com (2603:10b6:8:99::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 02:56:24 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:5:14c:cafe::c0) by DM6PR11CA0055.outlook.office365.com
 (2603:10b6:5:14c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Wed,
 30 Jul 2025 02:56:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 174.47.1.83)
 smtp.mailfrom=maxlinear.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=maxlinear.com;
Received-SPF: Pass (protection.outlook.com: domain of maxlinear.com designates
 174.47.1.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=174.47.1.83; helo=usmxlcas.maxlinear.com; pr=C
Received: from usmxlcas.maxlinear.com (174.47.1.83) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 02:56:24 +0000
Received: from sgb015.sgsw.maxlinear.com (10.23.238.15) by mail.maxlinear.com
 (10.23.38.120) with Microsoft SMTP Server id 15.1.2507.39; Tue, 29 Jul 2025
 19:56:21 -0700
From: Zhu Yixin <yzhu@maxlinear.com>
To: <dmaengine@vger.kernel.org>, <vkoul@kernel.org>
CC: <jchng@maxlinear.com>, <sureshnagaraj@maxlinear.com>, Zhu Yixin
	<yzhu@maxlinear.com>
Subject: [PATCH 4/5] dmaengine: lgm-dma: Added HDMA software mode TX function.
Date: Wed, 30 Jul 2025 10:45:46 +0800
Message-ID: <20250730024547.3160871-4-yzhu@maxlinear.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|DS7PR19MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: d5879bb5-11fb-4817-d383-08ddcf14aba9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qsnP0WsNB4maRhxDP5en/t9KDgo4wzphq9c74UvQi6siwQDLQeYInwGoJiFu?=
 =?us-ascii?Q?27unoGiCS81h5SqJ04UHs+aaOKG0xKzvn5pN3A1hTcTOotTo75saim3q+xpa?=
 =?us-ascii?Q?uAVT0T2eCDW03WOSyu6BoGRwepbXdIGYtet7rZgVVSiodCOBtTql8t+FRxPe?=
 =?us-ascii?Q?MqhApv9jBLABQ6MDMrZn692QJzmZe3pIlaV3OU2bbkL8N8n1eYFNYKEzTWCf?=
 =?us-ascii?Q?IvVKmfVpUN1/8SlipHMJ/NtlK022JDBDVrVuYt+KTsTrSTT+3jlI8aLSG9It?=
 =?us-ascii?Q?6yaP2oF06u8pRrdZzZtQ1ZyxrnelTSqxnFM0rhVn/C427/+q5CZ4WbyKuy1S?=
 =?us-ascii?Q?1u2FElYKQCQe5Zu0ao18g6Xq3syDXZ8Q793O0DWY8UiXRcDWAeKkCShsNqKd?=
 =?us-ascii?Q?c23X8/hOw0PPObYRhVZ5LynjsnapGfu9kMvTm+yvGYqQAy+cHV7Zb4jZR5G/?=
 =?us-ascii?Q?seI0NNO75WeIWpqZOzY2thMGMVetDqMrfZes39hJ506gFs0r+sn344IadrJe?=
 =?us-ascii?Q?KvjuxS8tsy9EepT7DI07K48OVspTTv9pEje83V/7DeMOsOY6YzF5nlZz/vaU?=
 =?us-ascii?Q?Roi3YUzgYtFvtGC2BvhGtF0V0gEGLHdnK8l/fY3lcY07XYTQwKCA/6sMWjPz?=
 =?us-ascii?Q?UskP4qhddl6oeAht7T40czFmfWQi51rlO3bWLtp0cdkfOY59vyHLRdogvxY7?=
 =?us-ascii?Q?E3DYMQ0PTYdHHFUM/A3Kxo4In7uVdL89u0G6CAkqhtoZIYt+CoB9IJc70LvU?=
 =?us-ascii?Q?og20s4etAjWInZsoVCyBsENfcQQy9UeCnSS4pESkUT2OxzbnIxhJMC9Femlc?=
 =?us-ascii?Q?eb7zEALAKYrBYw3w5ZPNk/01enwZz4s1cbRMozYYZHvLm6oU2sc52tJGnBWG?=
 =?us-ascii?Q?bx1SA/xlEyYChGuXNNIVq/RieIzVk2KCrESDqbU7pHHl8kiTLiX/T1jv6QeJ?=
 =?us-ascii?Q?/VtQ6oHelbrze/wIAZfQdmA4PTVyPRvEbZ4qfCcoz8MSNl+qdbPAwo5TKfFM?=
 =?us-ascii?Q?1gjRhWukxxG0O7oe5sluBNFaMIBijiathYjVUMu5QTl0q4GcViu7fyF4Va0Q?=
 =?us-ascii?Q?GHFIxqUhYOuc5O1Ynb/pxiFAUbQh/UJnwdpFGQIkFIjjq6V4wILVBoqNez1/?=
 =?us-ascii?Q?XeNfA9ER+NtOujC35L4y4K9OcGuv5EKcyNQT2BVIg2svH/84YdCl32wFqxJK?=
 =?us-ascii?Q?/s7QYSNew5pMG/Ij5xX0SPQ5rnMT9waxYPst2msD0pseIgvHHZbZ6DDaCjd2?=
 =?us-ascii?Q?bOb0nySvDJ+3ocWd1mq3PvRKhKqjSA/BRKbMAkAlL+B342lWzKbNHJSfmBsE?=
 =?us-ascii?Q?MIyRg55xPVigjMBI5Br+PS86vMCdv5no8P5T1TqVBj2a8MSNPRLsfOzbDj22?=
 =?us-ascii?Q?85yv52cVxkEFgIc6qfzZCsg4CTDRpf7RINn8neLb7HLZ06dSVYk2R65cYPfB?=
 =?us-ascii?Q?HdDz9OLkNOyj32KnoXrPEEzkPjbdAvCwPrglXfPOxKz/8LEpGAWQnQCyWXCG?=
 =?us-ascii?Q?lJeOPWKPJD4OPdgGafHETsFu6953enDPSRut?=
X-Forefront-Antispam-Report:
	CIP:174.47.1.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:usmxlcas.maxlinear.com;PTR:174-47-1-83.static.ctl.one;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 02:56:24.2015
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5879bb5-11fb-4817-d383-08ddcf14aba9
X-MS-Exchange-CrossTenant-Id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=dac28005-13e0-41b8-8280-7663835f2b1d;Ip=[174.47.1.83];Helo=[usmxlcas.maxlinear.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB6278

Added HDMA software mode to handle DMA TX functions.

Signed-off-by: Zhu Yixin <yzhu@maxlinear.com>
---
 .../devicetree/bindings/dma/intel,ldma.yaml   |   6 +
 drivers/dma/lgm/lgm-cdma.c                    |  42 +-
 drivers/dma/lgm/lgm-dma.c                     | 189 +++++---
 drivers/dma/lgm/lgm-dma.h                     |  31 +-
 drivers/dma/lgm/lgm-hdma.c                    | 453 +++++++++++++++++-
 5 files changed, 608 insertions(+), 113 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/intel,ldma.yaml b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
index f91d849edc4c..e58f1d13aee3 100644
--- a/Documentation/devicetree/bindings/dma/intel,ldma.yaml
+++ b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
@@ -118,6 +118,11 @@ properties:
     description:
       Name of the DMA.
 
+  intel,dma-hw-desc:
+    type: boolean
+    description:
+      DMA descriptor manupulated by Hardware.
+
 required:
   - compatible
   - reg
@@ -157,4 +162,5 @@ examples:
       intel,dma-desc-in-sram;
       intel,dma-name = "dma3";
       intel,dma-orrc = <16>;
+      intel,dma-hw-desc;
     };
diff --git a/drivers/dma/lgm/lgm-cdma.c b/drivers/dma/lgm/lgm-cdma.c
index 0acb30706c42..07dff684167d 100644
--- a/drivers/dma/lgm/lgm-cdma.c
+++ b/drivers/dma/lgm/lgm-cdma.c
@@ -22,6 +22,8 @@
 #include "../virt-dma.h"
 #include "lgm-dma.h"
 
+#define DESC_DATA_LEN		GENMASK(15, 0)
+
 struct dw2_desc {
 	u32 field;
 	u32 addr;
@@ -44,19 +46,14 @@ struct cdma_chan {
 	struct dma_slave_config config;
 };
 
-struct cdma_dev {
-	struct ldma_dev		*ldev;
-	struct workqueue_struct	*wq;
-};
-
 static int cdma_ctrl_init(struct ldma_dev *d);
 static int cdma_port_init(struct ldma_dev *d, struct ldma_port *p);
 static int cdma_chan_init(struct ldma_dev *d, struct ldma_chan *c);
 static int cdma_irq_init(struct ldma_dev *d, struct platform_device *pdev);
-static void cdma_func_init(struct dma_device *dma_dev);
+static void cdma_func_init(struct ldma_dev *d, struct dma_device *dma_dev);
 static irqreturn_t cdma_interrupt(int irq, void *dev_id);
 
-static struct cdma_dev *g_cdma_dev;
+static struct workqueue_struct	*wq_work;
 
 struct ldma_ops cdma_ops = {
 	.dma_ctrl_init = cdma_ctrl_init,
@@ -119,20 +116,10 @@ static void cdma_work(struct work_struct *work)
 
 static int cdma_ctrl_init(struct ldma_dev *d)
 {
-	struct cdma_dev *cdma;
-
-	cdma = devm_kzalloc(d->dev, sizeof(*cdma), GFP_KERNEL);
-	if (!cdma)
+	wq_work = alloc_ordered_workqueue("dma_wq", WQ_MEM_RECLAIM | WQ_HIGHPRI);
+	if (!wq_work)
 		return -ENOMEM;
 
-	cdma->ldev = d;
-	cdma->wq = alloc_ordered_workqueue("dma_wq",
-					   WQ_MEM_RECLAIM | WQ_HIGHPRI);
-	if (!cdma->wq)
-		return -ENOMEM;
-
-	g_cdma_dev = cdma;
-
 	return 0;
 }
 
@@ -174,7 +161,7 @@ static int cdma_irq_init(struct ldma_dev *d, struct platform_device *pdev)
 static void cdma_chan_irq(int irq, void *data)
 {
 	struct ldma_chan *c = data;
-	struct ldma_dev *d = g_cdma_dev->ldev;
+	struct ldma_dev *d = chan_to_ldma_dev(c);
 	struct cdma_chan *chan;
 	u32 stat;
 
@@ -187,7 +174,7 @@ static void cdma_chan_irq(int irq, void *data)
 	writel(readl(d->base + DMA_CIE) & ~DMA_CI_ALL, d->base + DMA_CIE);
 	writel(stat, d->base + DMA_CIS);
 	chan = (struct cdma_chan *)c->priv;
-	queue_work(g_cdma_dev->wq, &chan->work);
+	queue_work(wq_work, &chan->work);
 }
 
 static irqreturn_t cdma_interrupt(int irq, void *dev_id)
@@ -219,7 +206,7 @@ static irqreturn_t cdma_interrupt(int irq, void *dev_id)
 static int cdma_alloc_chan_resources(struct dma_chan *dma_chan)
 {
 	struct ldma_chan *c = to_ldma_chan(dma_chan);
-	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	struct ldma_dev *d = chan_to_ldma_dev(c);
 	struct cdma_chan *chan = (struct cdma_chan *)c->priv;
 	struct device *dev = d->dev;
 	size_t desc_sz;
@@ -279,7 +266,7 @@ cdma_slave_config(struct dma_chan *dma_chan, struct dma_slave_config *cfg)
 
 static void cdma_chan_irq_en(struct ldma_chan *c)
 {
-	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	struct ldma_dev *d = chan_to_ldma_dev(c);
 	unsigned long flags;
 
 	spin_lock_irqsave(&d->dev_lock, flags);
@@ -293,7 +280,6 @@ static void cdma_issue_pending(struct dma_chan *dma_chan)
 {
 	struct ldma_chan *c = to_ldma_chan(dma_chan);
 	struct cdma_chan *chan = (struct cdma_chan *)c->priv;
-	//struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
 	unsigned long flags;
 
 	spin_lock_irqsave(&c->vchan.lock, flags);
@@ -332,12 +318,12 @@ cdma_tx_status(struct dma_chan *dma_chan, dma_cookie_t cookie,
 static struct dw2_desc_sw *
 cdma_alloc_desc_resource(int num, struct ldma_chan *c)
 {
-	struct device *dev = g_cdma_dev->ldev->dev;
+	struct ldma_dev *d = chan_to_ldma_dev(c);
 	struct cdma_chan *chan = (struct cdma_chan *)c->priv;
 	struct dw2_desc_sw *ds;
 
 	if (num > c->desc_cnt) {
-		dev_err(dev, "sg num %d exceed max %d\n", num, c->desc_cnt);
+		dev_err(d->dev, "sg num %d exceed max %d\n", num, c->desc_cnt);
 		return NULL;
 	}
 
@@ -349,7 +335,7 @@ cdma_alloc_desc_resource(int num, struct ldma_chan *c)
 	ds->desc_hw = dma_pool_zalloc(chan->desc_pool, GFP_ATOMIC,
 				      &ds->desc_phys);
 	if (!ds->desc_hw) {
-		dev_dbg(dev, "out of memory for link descriptor\n");
+		dev_dbg(d->dev, "out of memory for link descriptor\n");
 		kfree(ds);
 		return NULL;
 	}
@@ -472,7 +458,7 @@ cdma_prep_slave_sg(struct dma_chan *dma_chan, struct scatterlist *sgl,
 	return vchan_tx_prep(&c->vchan, &ds->vdesc, DMA_CTRL_ACK);
 }
 
-static void cdma_func_init(struct dma_device *dma_dev)
+static void cdma_func_init(struct ldma_dev *d, struct dma_device *dma_dev)
 {
 	dma_dev->device_alloc_chan_resources = cdma_alloc_chan_resources;
 	dma_dev->device_free_chan_resources = cdma_free_chan_resources;
diff --git a/drivers/dma/lgm/lgm-dma.c b/drivers/dma/lgm/lgm-dma.c
index 6fade7b4f820..edf26ecc29b0 100644
--- a/drivers/dma/lgm/lgm-dma.c
+++ b/drivers/dma/lgm/lgm-dma.c
@@ -24,28 +24,18 @@
 #include "../virt-dma.h"
 #include "lgm-dma.h"
 
-static inline void
-ldma_update_bits(struct ldma_dev *d, u32 mask, u32 val, u32 ofs)
-{
-	u32 old_val, new_val;
-
-	old_val = readl(d->base +  ofs);
-	new_val = (old_val & ~mask) | (val & mask);
-
-	if (new_val != old_val)
-		writel(new_val, d->base + ofs);
-}
+enum {
+	DMA_ARG_CHAN_ID,
+	DMA_ARG_DESC_CNT,
+	DMA_ARG_PORT_ID,
+	DMA_ARG_BURST_SZ,
+};
 
 static inline bool ldma_chan_tx(struct ldma_chan *c)
 {
 	return !!(c->flags & DMA_TX_CH);
 }
 
-static inline bool ldma_chan_is_hw_desc(struct ldma_chan *c)
-{
-	return !!(c->flags & DMA_HW_DESC);
-}
-
 static void ldma_dev_reset(struct ldma_dev *d)
 
 {
@@ -251,7 +241,7 @@ static int ldma_dev_cfg(struct ldma_dev *d)
 
 static int ldma_chan_cctrl_cfg(struct ldma_chan *c, u32 val)
 {
-	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	struct ldma_dev *d = chan_to_ldma_dev(c);
 	u32 class_low, class_high;
 	unsigned long flags;
 	u32 reg;
@@ -280,7 +270,7 @@ static int ldma_chan_cctrl_cfg(struct ldma_chan *c, u32 val)
 
 static void ldma_chan_irq_init(struct ldma_chan *c)
 {
-	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	struct ldma_dev *d = chan_to_ldma_dev(c);
 	unsigned long flags;
 	u32 enofs, crofs;
 	u32 cn_bit;
@@ -306,9 +296,36 @@ static void ldma_chan_irq_init(struct ldma_chan *c)
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
 
 	if (d->type == DMA_TYPE_MCPY || val > DMA_MAX_CLASS)
@@ -326,9 +343,12 @@ static void ldma_chan_set_class(struct ldma_chan *c, u32 val)
 
 int ldma_chan_on(struct ldma_chan *c)
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
@@ -336,6 +356,7 @@ int ldma_chan_on(struct ldma_chan *c)
 	spin_lock_irqsave(&d->dev_lock, flags);
 	ldma_update_bits(d, DMA_CS_MASK, c->nr, DMA_CS);
 	ldma_update_bits(d, DMA_CCTRL_ON, DMA_CCTRL_ON, DMA_CCTRL);
+	ldma_chan_irq_en(c, true);
 	spin_unlock_irqrestore(&d->dev_lock, flags);
 
 	c->onoff = DMA_CH_ON;
@@ -345,7 +366,7 @@ int ldma_chan_on(struct ldma_chan *c)
 
 static int ldma_chan_off(struct ldma_chan *c)
 {
-	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	struct ldma_dev *d = chan_to_ldma_dev(c);
 	unsigned long flags;
 	u32 val;
 	int ret;
@@ -353,6 +374,7 @@ static int ldma_chan_off(struct ldma_chan *c)
 	spin_lock_irqsave(&d->dev_lock, flags);
 	ldma_update_bits(d, DMA_CS_MASK, c->nr, DMA_CS);
 	ldma_update_bits(d, DMA_CCTRL_ON, 0, DMA_CCTRL);
+	ldma_chan_irq_en(c, false);
 	spin_unlock_irqrestore(&d->dev_lock, flags);
 
 	ret = readl_poll_timeout_atomic(d->base + DMA_CCTRL, val,
@@ -368,7 +390,7 @@ static int ldma_chan_off(struct ldma_chan *c)
 void ldma_chan_desc_hw_cfg(struct ldma_chan *c, dma_addr_t desc_base,
 			   int desc_num)
 {
-	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	struct ldma_dev *d = chan_to_ldma_dev(c);
 	unsigned long flags;
 
 	spin_lock_irqsave(&d->dev_lock, flags);
@@ -390,7 +412,7 @@ void ldma_chan_desc_hw_cfg(struct ldma_chan *c, dma_addr_t desc_base,
 
 int ldma_chan_reset(struct ldma_chan *c)
 {
-	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	struct ldma_dev *d = chan_to_ldma_dev(c);
 	unsigned long flags;
 	u32 val;
 	int ret;
@@ -417,7 +439,7 @@ int ldma_chan_reset(struct ldma_chan *c)
 
 static void ldma_chan_byte_offset_cfg(struct ldma_chan *c, u32 boff_len)
 {
-	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	struct ldma_dev *d = chan_to_ldma_dev(c);
 	u32 mask = DMA_C_BOFF_EN | DMA_C_BOFF_BOF_LEN;
 	u32 val;
 
@@ -433,7 +455,7 @@ static void ldma_chan_byte_offset_cfg(struct ldma_chan *c, u32 boff_len)
 static void ldma_chan_data_endian_cfg(struct ldma_chan *c, bool enable,
 				      u32 endian_type)
 {
-	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	struct ldma_dev *d = chan_to_ldma_dev(c);
 	u32 mask = DMA_C_END_DE_EN | DMA_C_END_DATAENDI;
 	u32 val;
 
@@ -449,7 +471,7 @@ static void ldma_chan_data_endian_cfg(struct ldma_chan *c, bool enable,
 static void ldma_chan_desc_endian_cfg(struct ldma_chan *c, bool enable,
 				      u32 endian_type)
 {
-	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	struct ldma_dev *d = chan_to_ldma_dev(c);
 	u32 mask = DMA_C_END_DES_EN | DMA_C_END_DESENDI;
 	u32 val;
 
@@ -464,7 +486,7 @@ static void ldma_chan_desc_endian_cfg(struct ldma_chan *c, bool enable,
 
 static void ldma_chan_hdr_mode_cfg(struct ldma_chan *c, u32 hdr_len, bool csum)
 {
-	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	struct ldma_dev *d = chan_to_ldma_dev(c);
 	u32 mask, val;
 
 	/* NB, csum disabled, hdr length must be provided */
@@ -483,7 +505,7 @@ static void ldma_chan_hdr_mode_cfg(struct ldma_chan *c, u32 hdr_len, bool csum)
 
 static void ldma_chan_rxwr_np_cfg(struct ldma_chan *c, bool enable)
 {
-	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	struct ldma_dev *d = chan_to_ldma_dev(c);
 	u32 mask, val;
 
 	/* Only valid for RX channel */
@@ -499,7 +521,7 @@ static void ldma_chan_rxwr_np_cfg(struct ldma_chan *c, bool enable)
 
 static void ldma_chan_abc_cfg(struct ldma_chan *c, bool enable)
 {
-	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	struct ldma_dev *d = chan_to_ldma_dev(c);
 	u32 mask, val;
 
 	if (d->ver < DMA_VER32 || ldma_chan_tx(c))
@@ -556,7 +578,7 @@ static int ldma_port_cfg(struct ldma_port *p)
 
 static int ldma_chan_cfg(struct ldma_chan *c)
 {
-	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
+	struct ldma_dev *d = chan_to_ldma_dev(c);
 	unsigned long flags;
 	u32 reg;
 
@@ -636,6 +658,9 @@ static int ldma_parse_dt(struct ldma_dev *d)
 	if (fwnode_property_read_bool(fwnode, "intel,dma-desc-fack"))
 		d->flags |= DMA_VALID_DESC_FETCH_ACK;
 
+	if (fwnode_property_read_bool(fwnode, "intel,dma-hw-desc"))
+		d->flags |= DMA_CHAN_HW_DESC;
+
 	if (fwnode_property_read_u32(fwnode, "intel,dma-poll-cnt",
 				     &d->pollcnt))
 		d->pollcnt = DMA_DFT_POLL_CNT;
@@ -664,34 +689,23 @@ static int ldma_parse_dt(struct ldma_dev *d)
 	return 0;
 }
 
-int ldma_terminate_all(struct dma_chan *chan)
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
 
-int ldma_resume_chan(struct dma_chan *chan)
+int ldma_resume_chan(struct dma_chan *dma_chan)
 {
-	struct ldma_chan *c = to_ldma_chan(chan);
-
-	ldma_chan_on(c);
-
-	return 0;
+	return ldma_chan_on(to_ldma_chan(dma_chan));
 }
 
-int ldma_pause_chan(struct dma_chan *chan)
+int ldma_pause_chan(struct dma_chan *dma_chan)
 {
-	struct ldma_chan *c = to_ldma_chan(chan);
-
-	return ldma_chan_off(c);
+	return ldma_chan_off(to_ldma_chan(dma_chan));
 }
 
 static u32
@@ -718,43 +732,82 @@ static int
 update_client_configs(struct of_dma *ofdma, struct of_phandle_args *spec)
 {
 	struct ldma_dev *d = ofdma->of_dma_data;
-	u32 chan_id =  spec->args[0];
-	u32 port_id =  spec->args[1];
-	u32 burst = spec->args[2];
-	struct ldma_port *p;
+	int i, chan_id, port_id, desc_cnt, burst;
 	struct ldma_chan *c;
+	struct ldma_port *p;
 
-	if (chan_id >= d->chan_nrs || port_id >= d->port_nrs)
-		return 0;
+	port_id  = -1;
+	desc_cnt = -1;
+	burst    = -1;
+
+	for (i = spec->args_count - 1; i >= 0; i--) {
+		switch (i) {
+		case DMA_ARG_BURST_SZ:
+			burst = spec->args[i];
+			break;
+
+		case DMA_ARG_PORT_ID:
+			port_id = spec->args[i];
+			break;
+
+		case DMA_ARG_DESC_CNT:
+			desc_cnt = spec->args[i];
+			break;
+
+		case DMA_ARG_CHAN_ID:
+			chan_id = spec->args[i];
+			break;
+		}
+	}
+
+	if (chan_id >= d->chan_nrs || chan_id < 0)
+		return -1;
 
-	p = &d->ports[port_id];
 	c = &d->chans[chan_id];
+	if (!ldma_chan_is_hw_desc(c) && desc_cnt > 0)
+		c->desc_cnt = desc_cnt;
+
+	if (port_id < 0 || burst < 0 || port_id > d->port_nrs)
+		return chan_id;
+
+	p = &d->ports[port_id];
 	c->port = p;
 
 	update_burst_len(c, p, burst);
 
 	ldma_port_cfg(p);
 
-	return 1;
+	return chan_id;
 }
 
+/**
+ * args 0: channel ID
+ * args 1: channel length
+ * args 2: port ID
+ * args 3: burst size setting
+ */
 static struct dma_chan *ldma_xlate(struct of_phandle_args *spec,
 				   struct of_dma *ofdma)
 {
 	struct ldma_dev *d = ofdma->of_dma_data;
-	u32 chan_id =  spec->args[0];
-	int ret;
+	int chan_id;
+
+	dev_dbg(d->dev, "DMA channel args count: %d\n", spec->args_count);
+	dev_dbg(d->dev, "DMA chan no: %u, desc num: %u\n",
+		spec->args[0], spec->args[1]);
 
 	if (!spec->args_count)
 		return NULL;
 
-	/* if args_count is 1 driver use default settings */
-	if (spec->args_count > 1) {
-		ret = update_client_configs(ofdma, spec);
-		if (!ret)
-			return NULL;
+	if (!(d->flags & DMA_CHAN_HW_DESC) && spec->args_count < 2) {
+		dev_err(d->dev, "DMA channel parameter format error!\n");
+		return NULL;
 	}
 
+	chan_id = update_client_configs(ofdma, spec);
+	if (chan_id < 0)
+		return NULL;
+
 	return dma_get_slave_channel(&d->chans[chan_id].vchan.chan);
 }
 
@@ -885,10 +938,6 @@ static int intel_ldma_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = ldma_init(d);
-	if (ret)
-		return ret;
-
 	ret = ldma_irq_init(d, pdev);
 	if (ret)
 		return ret;
@@ -903,7 +952,11 @@ static int intel_ldma_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&dma_dev->channels);
 
 	/* init dma callback functions */
-	d->ops->dma_func_init(dma_dev);
+	d->ops->dma_func_init(d, dma_dev);
+
+	ret = ldma_init(d);
+	if (ret)
+		return ret;
 
 	platform_set_drvdata(pdev, d);
 
diff --git a/drivers/dma/lgm/lgm-dma.h b/drivers/dma/lgm/lgm-dma.h
index ff5aa5142019..d6692b80e329 100644
--- a/drivers/dma/lgm/lgm-dma.h
+++ b/drivers/dma/lgm/lgm-dma.h
@@ -39,7 +39,7 @@ struct ldma_ops {
 	/* DMA interrupt init */
 	int (*dma_irq_init)(struct ldma_dev *d, struct platform_device *pdev);
 	/* DMA callback API init */
-	void (*dma_func_init)(struct dma_device *dma_dev);
+	void (*dma_func_init)(struct ldma_dev *d, struct dma_device *dma_dev);
 };
 
 struct ldma_chan {
@@ -218,6 +218,7 @@ extern struct ldma_ops hdma_ops;
 #define DMA_DBURST_WR			BIT(6)
 #define DMA_VALID_DESC_FETCH_ACK	BIT(7)
 #define DMA_DFT_DRB			BIT(8)
+#define DMA_CHAN_HW_DESC		BIT(9)
 
 #define DMA_ORRC_MAX_CNT		16
 #define DMA_DFT_POLL_CNT		SZ_4
@@ -236,12 +237,10 @@ extern struct ldma_ops hdma_ops;
 /* DMA flags */
 #define DMA_TX_CH			BIT(0)
 #define DMA_RX_CH			BIT(1)
-#define DEVICE_ALLOC_DESC		BIT(2)
-#define CHAN_IN_USE			BIT(3)
-#define DMA_HW_DESC			BIT(4)
+#define CHAN_IN_USE			BIT(2)
+#define DMA_HW_DESC			BIT(3)
 
 /* Descriptor fields */
-#define DESC_DATA_LEN			GENMASK(15, 0)
 #define DESC_BYTE_OFF			GENMASK(25, 23)
 #define DESC_EOP			BIT(28)
 #define DESC_SOP			BIT(29)
@@ -267,6 +266,28 @@ static inline struct ldma_dev *to_ldma_dev(struct dma_device *dma_dev)
 	return container_of(dma_dev, struct ldma_dev, dma_dev);
 }
 
+static inline bool ldma_chan_is_hw_desc(struct ldma_chan *c)
+{
+	return !!(c->flags & DMA_HW_DESC);
+}
+
+static inline struct ldma_dev *chan_to_ldma_dev(struct ldma_chan *c)
+{
+	return to_ldma_dev(c->vchan.chan.device);
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
 void ldma_chan_desc_hw_cfg(struct ldma_chan *c, dma_addr_t desc_base,
 			   int desc_num);
 int ldma_terminate_all(struct dma_chan *chan);
diff --git a/drivers/dma/lgm/lgm-hdma.c b/drivers/dma/lgm/lgm-hdma.c
index 9133aa31c47b..198005b48d59 100644
--- a/drivers/dma/lgm/lgm-hdma.c
+++ b/drivers/dma/lgm/lgm-hdma.c
@@ -4,6 +4,7 @@
  *
  * Copyright (c) 2025 Maxlinear Inc.
  */
+
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
@@ -22,12 +23,68 @@
 #include "../virt-dma.h"
 #include "lgm-dma.h"
 
+/* Descriptor fields */
+#define DESC_DATA_LEN		GENMASK(13, 0)
+#define DESC_BP_EXT		GENMASK(26, 23)
+#define DESC_EOP		BIT(28)
+#define DESC_SOP		BIT(29)
+#define DESC_C			BIT(30)
+#define DESC_OWN		BIT(31)
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
-static void hdma_func_init(struct dma_device *dma_dev);
+static void hdma_func_init(struct ldma_dev *d, struct dma_device *dma_dev);
 static void hdma_free_chan_resources(struct dma_chan *dma_chan);
+static void dma_tx_chan_complete(struct tasklet_struct *t);
+
+static inline
+struct dw4_desc_sw *to_lgm_dma_dw4_desc(struct virt_dma_desc *vd)
+{
+	return container_of(vd, struct dw4_desc_sw, vd);
+}
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
 
 struct ldma_ops hdma_ops = {
 	.dma_ctrl_init = hdma_ctrl_init,
@@ -54,18 +111,21 @@ static int hdma_port_init(struct ldma_dev *d, struct ldma_port *p)
 	return 0;
 }
 
-static inline void hdma_free_desc_resource(struct virt_dma_desc *vdesc)
+static inline void hdma_free_desc_resource(struct virt_dma_desc *vd)
 {
 }
 
 static int hdma_chan_init(struct ldma_dev *d, struct ldma_chan *c)
 {
+	struct hdma_chan *chan;
+
 	c->data_endian = DMA_DFT_ENDIAN;
 	c->desc_endian = DMA_DFT_ENDIAN;
 	c->data_endian_en = false;
 	c->desc_endian_en = false;
 	c->desc_rx_np = false;
-	c->flags |= DEVICE_ALLOC_DESC;
+	if (d->flags & DMA_CHAN_HW_DESC)
+		c->flags |= DMA_HW_DESC;
 	c->onoff = DMA_CH_OFF;
 	c->rst = DMA_CHAN_RST;
 	c->abc_en = true;
@@ -74,51 +134,404 @@ static int hdma_chan_init(struct ldma_dev *d, struct ldma_chan *c)
 	c->vchan.desc_free = hdma_free_desc_resource;
 	vchan_init(&c->vchan, &d->dma_dev);
 
+	chan = devm_kzalloc(d->dev, sizeof(*chan), GFP_KERNEL);
+	if (!chan)
+		return -ENOMEM;
+
+	c->priv = chan;
+	chan->c = c;
+	if (is_dma_chan_tx(d))
+		tasklet_setup(&chan->task, dma_tx_chan_complete);
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
+static void dma_tx_chan_complete(struct tasklet_struct *t)
+{
+	struct hdma_chan *chan = from_tasklet(chan, t, task);
+	struct ldma_chan *c = chan->c;
+	struct ldma_dev *d = chan_to_ldma_dev(c);
+
+	/* check how many valid descriptor from DMA */
+	while (chan->prep_desc_cnt > 0) {
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
+		dma_cookie_complete(tx);
+		chan->comp_idx = (chan->comp_idx + 1) % c->desc_cnt;
+		chan->prep_desc_cnt -= 1;
+		dmaengine_desc_callback_invoke(&cb, NULL);
+	}
+
+	hdma_chan_int_enable(d, c);
+}
+
+static unsigned long hdma_irq_stat(struct ldma_dev *d, int high)
+{
+	u32 irnen, irncr, en_off, cr_off, cid;
+	unsigned long flags;
+	unsigned long ret;
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
+	ret = irncr;
+
+	return high ? ret << 32 : ret;
+}
+
+static irqreturn_t hdma_interrupt(int irq, void *dev_id)
+{
+	struct ldma_dev *d = dev_id;
+	struct hdma_chan *chan;
+	u32 cid;
+	unsigned long stat;
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
 
+/**
+ * Allocate DMA descriptor list
+ */
 static int hdma_alloc_chan_resources(struct dma_chan *dma_chan)
 {
 	struct ldma_chan *c = to_ldma_chan(dma_chan);
+	struct hdma_chan *chan = (struct hdma_chan *)c->priv;
 	struct device *dev = c->vchan.chan.device->dev;
+	struct dw4_desc_sw *desc_sw;
+	struct dw4_desc_hw *desc_hw;
+	size_t desc_sz;
+	int i;
 
-	dev_dbg(dev, "allocate channel resource!\n");
-
-	if (c->flags & DMA_HW_DESC) {
+	/* HW allocate DMA descriptors */
+	if (ldma_chan_is_hw_desc(c)) {
 		c->flags |= CHAN_IN_USE;
 		dev_dbg(dev, "desc in hw\n");
+		return 0;
 	}
 
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
+	dev_dbg(dev, "DMA CH: %u, phy addr: 0x%llx, desc cnt: %u\n",
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
+	struct device *dev = c->vchan.chan.device->dev;
+
+	ldma_chan_reset(c);
+
+	/* HW allocate DMA descriptors */
+	if (ldma_chan_is_hw_desc(c)) {
+		c->flags &= ~CHAN_IN_USE;
+		dev_dbg(dev, "%s: desc in hw\n", __func__);
+		return;
+	}
+
+	vchan_free_chan_resources(&c->vchan);
+	kfree(chan->ds);
+	kfree(c->desc_base);
+
+	dev_dbg(dev, "Free DMA channel %u\n", c->nr);
+}
+
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
 
-	c->flags &= ~CHAN_IN_USE;
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
 }
 
 static void hdma_issue_pending(struct dma_chan *dma_chan)
 {
 	struct ldma_chan *c = to_ldma_chan(dma_chan);
+	unsigned long flags;
 
-	ldma_chan_on(c);
+	if (ldma_chan_is_hw_desc(c))
+		return;
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
+ * dma sideband info passed in sideband info
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
+}
+
+/**
+ * HW Manipulate DMA descriptors.
+ * Only need configure descriptor address and length to DMA.
+ */
+static struct dma_async_tx_descriptor *
+hdma_chan_hw_desc_cfg(struct dma_chan *chan, dma_addr_t desc_base, int desc_num)
+{
+	struct ldma_chan *c = to_ldma_chan(chan);
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
+	struct hdma_chan *chan = (struct hdma_chan *)c->priv;
+	struct device *dev = c->vchan.chan.device->dev;
+	struct dw4_desc_hw *desc_hw;
+	struct dw4_desc_sw *desc_sw;
+
+	if (!sgl || sglen < 1) {
+		dev_err(dev, "%s param error!\n", __func__);
+		return NULL;
+	}
+
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
 
-static void hdma_func_init(struct dma_device *dma_dev)
+static void hdma_func_init(struct ldma_dev *d, struct dma_device *dma_dev)
 {
 	dma_dev->device_alloc_chan_resources = hdma_alloc_chan_resources;
 	dma_dev->device_free_chan_resources = hdma_free_chan_resources;
@@ -127,4 +540,20 @@ static void hdma_func_init(struct dma_device *dma_dev)
 	dma_dev->device_tx_status = hdma_tx_status;
 	dma_dev->device_resume = ldma_resume_chan;
 	dma_dev->device_pause = ldma_pause_chan;
+	dma_dev->device_prep_slave_sg = hdma_prep_slave_sg;
+	dma_dev->device_config = hdma_slave_config;
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
 }
-- 
2.43.5


