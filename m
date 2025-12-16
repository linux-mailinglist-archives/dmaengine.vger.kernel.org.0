Return-Path: <dmaengine+bounces-7660-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9041FCC322E
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 14:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6C1B302B7B4
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 13:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E2F3AA183;
	Tue, 16 Dec 2025 12:30:35 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023096.outbound.protection.outlook.com [52.101.127.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB773A1D00;
	Tue, 16 Dec 2025 12:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765888235; cv=fail; b=MQMFR4FpwVD75cOf/5Db08jyMLMvf/jOQv5FEDHlDTPAch0RRq8B348XQywP0FgPXJaH39n+4Bcv/5s2rFuJ16en1qt7t4/RGKsOYOCmJNYNLxHgCjkUxcJ6FOD0SxgTddpAVUTUV/UB3lXlNERq1zeOcI1A4M351NuHNO2toYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765888235; c=relaxed/simple;
	bh=cCoBDXRp82hj43Xz4fkJt809n0nhOVe+OFFn/j0JrNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OOHs9AgoMGX4BMFLrHg1eXaoZw9iKVDzMXsyj70FDgPdTSQoTBqgxehVnamiAaaI3UG9Recv1NF92SxOV0Fb2ipYLESLvyGAayNPOqUy+nkCuR/INUYl54nWvoJF+jHuDbKfJjbfpxqF+ldxEDPB38a/W9P2vDUq+wEaFxja6QA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8b/oG4stlRqVOoOqFAYcVIRynUA2hIsfjHVf7nQ/DO2wm+2eJfttjBWH7BpwDvUpHRGSd1Uc9TVQ9l3/f7ZpkCiVMc67ks03LUmfJ/LMs89vh2caaJZOr6henso5CFBa10wnaxJdbaSH0nGq1/jGl+IbH3nrVzDC4jw/3y9iiqQUD+7SiztcCEyNaMCkAmWqtSb+8xMj6RHrsp3bziYRHa5GEi8f9fz2K7jV6OruiFZua38LRJoXCOq9w6HMZBulbHz7urw8GvcIgcnxxwTmHdvEIQXXgfpoBDjQ19pb2a+raoJowtVDpEGaoTD57L1OGk8tgOoohUgH1TtXzCAJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykXHkcXDWqPEnh4DaaVLlKegvh4gw7YwwWCABzB/Ir4=;
 b=rs2v/exUi0pmbqIJQhRWSLUJq1+RgiYE267qQOO7210SaPVHdZ6T/Q8deNW8hHA2hDBhNjmCN5J9fzHwvQAH+MbCA9drwSPrWQ+1W6ypNMypJC9bLl3sSjBgYr8H+Ijf1LY6m1yzQTy5pYddExgfkAraa6QOObb4Qb6v11uMW7E7zClkN1cxo1CaAjk9Qjul0Auhf6xoVlp1vT8ixbpGUz6xovieR4lOFenocJh4UVsGhftVyMlzcklMgkSpqlCl0JmkuarTuWkNPr8GKp2WGw74Nlj/vuq05oLKX7+v9dsb04x2pdv6mic782hYe6jIDu2woWv4i9GlZrYA8c0Xew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2P153CA0026.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::13) by
 SEYPR06MB8115.apcprd06.prod.outlook.com (2603:1096:101:2da::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.13; Tue, 16 Dec 2025 12:30:30 +0000
Received: from SG1PEPF000082E1.apcprd02.prod.outlook.com
 (2603:1096:4:c7:cafe::e3) by SG2P153CA0026.outlook.office365.com
 (2603:1096:4:c7::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.4 via Frontend Transport; Tue,
 16 Dec 2025 12:30:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E1.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 12:30:29 +0000
Received: from guoo-System-Product-Name.. (unknown [172.20.64.188])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id B3CBE4143A8D;
	Tue, 16 Dec 2025 20:30:27 +0800 (CST)
From: Jun Guo <jun.guo@cixtech.com>
To: peter.chen@cixtech.com,
	fugang.duan@cixtech.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	ychuang3@nuvoton.com,
	schung@nuvoton.com,
	robin.murphy@arm.com
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com,
	linux-arm-kernel@lists.infradead.org,
	jelly.jia@cixtech.com,
	Jun Guo <jun.guo@cixtech.com>
Subject: [PATCH v2 2/3] dma: arm-dma350: add support for shared interrupt mode
Date: Tue, 16 Dec 2025 20:30:25 +0800
Message-Id: <20251216123026.3519923-3-jun.guo@cixtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251216123026.3519923-1-jun.guo@cixtech.com>
References: <20251216123026.3519923-1-jun.guo@cixtech.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E1:EE_|SEYPR06MB8115:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 85944d03-4718-4790-34f2-08de3c9ee60f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vtD8h/wn2UvLphWYw+5QrQwyLubOrfj2NoyzqwngAomi7gZKP2VmhX6/YtPt?=
 =?us-ascii?Q?RByApDS6cLnXdluek0Ybaka56cjLrPEl296zXVT7ybB27bOgDY1vSmvwuhX8?=
 =?us-ascii?Q?e6Elkt9vRzKVHE3ztKY/d++MuLePr7+z+gzkf3Ank7AQHJUcEFlRQvSQvNyg?=
 =?us-ascii?Q?1I3jt/fm5+FAy/4IFR5hXui1TaJHQjh5elvA7BJvr5ZR/6mxYb7zlu78fUWX?=
 =?us-ascii?Q?TyED6E3XzQHNJV0O5Tso74/jS61NmZRZJ15BTVwiL8KW/PqG45N6Uoc5I2fD?=
 =?us-ascii?Q?pvEluUzh+Us4Lms6Owf4LGbc7cplqZ8a6934by++wQtK6jeeniQoaAbaCiFY?=
 =?us-ascii?Q?9dxnHcQmMq3pc15WlDCTJTQPxcbrbLQamIiSqyCR988AhEwnWNsgi3Ttaoin?=
 =?us-ascii?Q?bsG3vQHCgRXC7ON0vPIus78WAyxDgcs/s853vkkExKBrY7A2XXj+6PO5UZ0J?=
 =?us-ascii?Q?RzscKZt1DPDRoOLkdBPEHx5tYXn8t9Kp+Yx6l2ljNJM9ZZwtXXnApyB3YGHs?=
 =?us-ascii?Q?bHvQSHCNSwDShBIFocMnd/wjiuk6E5L99JTGH67cMhYgvvI2qEai5+f79hpx?=
 =?us-ascii?Q?c3+RVRCRHq5mmLNKwfedycupWLDoYdF3HqEIUdOVBxRCOaFMAVNcXt+GXUqt?=
 =?us-ascii?Q?395ecfFAbSnUqtMesWZ+NDqFl9ECAkqrgO91fMn9OOHXO6b7V3CrSmO+y2SA?=
 =?us-ascii?Q?jp1Wne2p102Xx5Q6y98eUZL0QMrgwugnKH0nlul6kVbBwcgM7KRcUjUpVnsY?=
 =?us-ascii?Q?80U4DNCRbVMothuQOYLU3nQUf2sOznKy3YTxKTwtue0Dlf8hR6djlzimxQyq?=
 =?us-ascii?Q?hNjCUyBufVbuX+mAGXAdC4hicTYNNRzk4y4m90xxe6MQ6Y2gjRFDid0GERd6?=
 =?us-ascii?Q?UDLyDQEdpRHrvg3r5H8EV0z23spNoQFJpr0elhqe37+zUrRFwZF5MIqrfYRT?=
 =?us-ascii?Q?YoYZalpeZTYgGgxSu0JZLhroX/w/9fraq0R5gyOhfcEIoVR3mifrXLtC6zx6?=
 =?us-ascii?Q?4yAKcvkIHt2CBtw0QwWXqgzDFOjO80aGYke6F0oq32tNGCO3Rfzd9Wtyci2f?=
 =?us-ascii?Q?4zB3fly2qSi90H32gRF2qr68kmSUbMowKfFNa/9DuT1nG+AL9Kj4Oih8ESha?=
 =?us-ascii?Q?eq9m4Cg+H6Wl754lLk1DChcj6YD8w7SifbluEO0anhu2x1n/nS2taHMKBMMJ?=
 =?us-ascii?Q?gS5pPtUSZbyt2fU3XGoS/Ugj39SLIoh2VZcMA2XNhyxLvw5PJwf/uoar2jMR?=
 =?us-ascii?Q?t+mxeBA9ev2lNnUvCxD2RzeqXfZ+5nVuFr+qxrKc28a8ScexjTO/pTcgWTVg?=
 =?us-ascii?Q?sIqTKkf60iHSQibC8lECKilfrvhE5sTB5dMYAuSx5WN/1BQHYQ6i6X2Sdjy6?=
 =?us-ascii?Q?6I804ybqLyvc5lABLgR8Tk97igR/KPS0PyWs3PIs2lDPGWgVgZKr5Um541JS?=
 =?us-ascii?Q?eHh68mwGH1s9c+ssDQ0GFggEBxCDFyCwKQR8BpfAsz2mPRsnrtp9hvK0mDoy?=
 =?us-ascii?Q?1QkTXk6HLvchR3LT3KjU9fPwTuKaJVX4KowUmwDUW9Gvndy76n9zFHl1QGzF?=
 =?us-ascii?Q?euZ/VXKEcaUpxNzKQFs=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 12:30:29.0423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85944d03-4718-4790-34f2-08de3c9ee60f
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E1.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8115

The arm dma350 controller's hardware implementation varies: some
designs dedicate a separate interrupt line for each channel, while
others have all channels sharing a single interrupt.This patch adds
support for the hardware design where all DMA channels share a
single interrupt.

Signed-off-by: Jun Guo <jun.guo@cixtech.com>
---
 drivers/dma/arm-dma350.c | 124 +++++++++++++++++++++++++++++++++++----
 1 file changed, 114 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
index 9efe2ca7d5ec..6bea18521edd 100644
--- a/drivers/dma/arm-dma350.c
+++ b/drivers/dma/arm-dma350.c
@@ -14,6 +14,7 @@
 #include "virt-dma.h"
 
 #define DMAINFO			0x0f00
+#define DRIVER_NAME		"arm-dma350"
 
 #define DMA_BUILDCFG0		0xb0
 #define DMA_CFG_DATA_WIDTH	GENMASK(18, 16)
@@ -142,6 +143,9 @@
 #define LINK_LINKADDR		BIT(30)
 #define LINK_LINKADDRHI		BIT(31)
 
+/* DMA NONSECURE CONTROL REGISTER */
+#define DMANSECCTRL		0x20c
+#define INTREN_ANYCHINTR_EN	BIT(0)
 
 enum ch_ctrl_donetype {
 	CH_CTRL_DONETYPE_NONE = 0,
@@ -192,11 +196,16 @@ struct d350_chan {
 
 struct d350 {
 	struct dma_device dma;
+	void __iomem *base;
 	int nchan;
 	int nreq;
 	struct d350_chan channels[] __counted_by(nchan);
 };
 
+struct d350_driver_data {
+	bool combined_irq;
+};
+
 static inline struct d350_chan *to_d350_chan(struct dma_chan *chan)
 {
 	return container_of(chan, struct d350_chan, vc.chan);
@@ -461,7 +470,61 @@ static void d350_issue_pending(struct dma_chan *chan)
 	spin_unlock_irqrestore(&dch->vc.lock, flags);
 }
 
-static irqreturn_t d350_irq(int irq, void *data)
+static irqreturn_t d350_global_irq(int irq, void *data)
+{
+	struct d350 *dmac = (struct d350 *)data;
+	struct device *dev = dmac->dma.dev;
+	irqreturn_t ret = IRQ_NONE;
+	int i;
+
+	for (i = 0; i < dmac->nchan; i++) {
+		struct d350_chan *dch = &dmac->channels[i];
+		u32 ch_status;
+
+		ch_status = readl(dch->base + CH_STATUS);
+		if (!ch_status)
+			continue;
+
+		ret = IRQ_HANDLED;
+
+		if (ch_status & CH_STAT_INTR_ERR) {
+			struct virt_dma_desc *vd = &dch->desc->vd;
+			u32 errinfo = readl_relaxed(dch->base + CH_ERRINFO);
+
+			if (errinfo &
+			    (CH_ERRINFO_AXIRDPOISERR | CH_ERRINFO_AXIRDRESPERR))
+				vd->tx_result.result = DMA_TRANS_READ_FAILED;
+			else if (errinfo & CH_ERRINFO_AXIWRRESPERR)
+				vd->tx_result.result = DMA_TRANS_WRITE_FAILED;
+			else
+				vd->tx_result.result = DMA_TRANS_ABORTED;
+
+			vd->tx_result.residue = d350_get_residue(dch);
+		} else if (!(ch_status & CH_STAT_INTR_DONE)) {
+			dev_warn(dev, "Channel %d unexpected IRQ: 0x%08x\n", i,
+				 ch_status);
+		}
+
+		writel_relaxed(ch_status, dch->base + CH_STATUS);
+
+		spin_lock(&dch->vc.lock);
+		if (ch_status & CH_STAT_INTR_DONE) {
+			vchan_cookie_complete(&dch->desc->vd);
+			dch->status = DMA_COMPLETE;
+			dch->residue = 0;
+			d350_start_next(dch);
+		} else if (ch_status & CH_STAT_INTR_ERR) {
+			vchan_cookie_complete(&dch->desc->vd);
+			dch->status = DMA_ERROR;
+			dch->residue = dch->desc->vd.tx_result.residue;
+		}
+		spin_unlock(&dch->vc.lock);
+	}
+
+	return ret;
+}
+
+static irqreturn_t d350_channel_irq(int irq, void *data)
 {
 	struct d350_chan *dch = data;
 	struct device *dev = dch->vc.chan.device->dev;
@@ -506,10 +569,18 @@ static irqreturn_t d350_irq(int irq, void *data)
 static int d350_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct d350_chan *dch = to_d350_chan(chan);
-	int ret = request_irq(dch->irq, d350_irq, IRQF_SHARED,
-			      dev_name(&dch->vc.chan.dev->device), dch);
-	if (!ret)
-		writel_relaxed(CH_INTREN_DONE | CH_INTREN_ERR, dch->base + CH_INTREN);
+	int ret = 0;
+
+	if (dch->irq) {
+		ret = request_irq(dch->irq, d350_channel_irq, IRQF_SHARED,
+				  dev_name(&dch->vc.chan.dev->device), dch);
+		if (ret) {
+			dev_err(chan->device->dev, "Failed to request IRQ %d\n", dch->irq);
+			return ret;
+		}
+	}
+
+	writel_relaxed(CH_INTREN_DONE | CH_INTREN_ERR, dch->base + CH_INTREN);
 
 	return ret;
 }
@@ -526,7 +597,8 @@ static void d350_free_chan_resources(struct dma_chan *chan)
 static int d350_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct d350 *dmac;
+	struct d350 *dmac = NULL;
+	const struct d350_driver_data *data;
 	void __iomem *base;
 	u32 reg;
 	int ret, nchan, dw, aw, r, p;
@@ -556,6 +628,7 @@ static int d350_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	dmac->nchan = nchan;
+	dmac->base = base;
 
 	reg = readl_relaxed(base + DMAINFO + DMA_BUILDCFG1);
 	dmac->nreq = FIELD_GET(DMA_CFG_NUM_TRIGGER_IN, reg);
@@ -582,6 +655,27 @@ static int d350_probe(struct platform_device *pdev)
 	dmac->dma.device_issue_pending = d350_issue_pending;
 	INIT_LIST_HEAD(&dmac->dma.channels);
 
+	data = device_get_match_data(dev);
+	/* Cix Sky1 has a common host IRQ for all its channels. */
+	if (data && data->combined_irq) {
+		int host_irq = platform_get_irq(pdev, 0);
+
+		if (host_irq < 0)
+			return dev_err_probe(dev, host_irq,
+					     "Failed to get IRQ\n");
+
+		ret = devm_request_irq(&pdev->dev, host_irq, d350_global_irq,
+				       IRQF_SHARED, DRIVER_NAME, dmac);
+		if (ret)
+			return dev_err_probe(
+				dev, ret,
+				"Failed to request the combined IRQ %d\n",
+				host_irq);
+	}
+
+	/* Combined Non-Secure Channel Interrupt Enable */
+	writel_relaxed(INTREN_ANYCHINTR_EN, dmac->base + DMANSECCTRL);
+
 	/* Would be nice to have per-channel caps for this... */
 	memset = true;
 	for (int i = 0; i < nchan; i++) {
@@ -595,10 +689,15 @@ static int d350_probe(struct platform_device *pdev)
 			dev_warn(dev, "No command link support on channel %d\n", i);
 			continue;
 		}
-		dch->irq = platform_get_irq(pdev, i);
-		if (dch->irq < 0)
-			return dev_err_probe(dev, dch->irq,
-					     "Failed to get IRQ for channel %d\n", i);
+
+		if (!data) {
+			dch->irq = platform_get_irq(pdev, i);
+			if (dch->irq < 0)
+				return dev_err_probe(
+					dev, dch->irq,
+					"Failed to get IRQ for channel %d\n",
+					i);
+		}
 
 		dch->has_wrap = FIELD_GET(CH_CFG_HAS_WRAP, reg);
 		dch->has_trig = FIELD_GET(CH_CFG_HAS_TRIGIN, reg) &
@@ -639,7 +738,12 @@ static void d350_remove(struct platform_device *pdev)
 	dma_async_device_unregister(&dmac->dma);
 }
 
+static const struct d350_driver_data sky1_dma350_data = {
+	.combined_irq = true,
+};
+
 static const struct of_device_id d350_of_match[] __maybe_unused = {
+	{ .compatible = "cix,sky1-dma-350", .data = &sky1_dma350_data },
 	{ .compatible = "arm,dma-350" },
 	{}
 };
-- 
2.34.1


