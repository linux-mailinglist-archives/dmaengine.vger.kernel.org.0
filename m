Return-Path: <dmaengine+bounces-7186-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A88B3C620B4
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 03:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EB4D4E54FE
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 02:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECF2241695;
	Mon, 17 Nov 2025 01:59:53 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022140.outbound.protection.outlook.com [40.107.75.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D9C1F583D;
	Mon, 17 Nov 2025 01:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763344793; cv=fail; b=T1qdCaKPrxCUBkKW97It7zPUQI3v4GnvgoHyFxe4cr8Cg0+6foiKEA9fllNCv/SBvE76HrUkVjlEQY3+w4jGVwLFHHn+4DevOtm76Zfc6f3Vawhc6u7Tb2c+iUwOr295hOkDUVVuErhStDbajSvcrVVdcT+nMPc71nVhmCCEq4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763344793; c=relaxed/simple;
	bh=Zp6sBjZ63q8wI7S7IuNMB8hfPIL27MdtGShck0VBKN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s70FjoR9j0tRo2ii72k7/Vn6OkHd1V/FX5bVEz3GNxDuyGPbv+WX09b2YoqMJrzYJVFVVAfxxPj8hq7HWSiZ5ViMHtb/WYParVRgwBzRHP+jhwSEteDjCNE35CU/PhiMTq8Nx0sC477uXM1zQBH/VvLeuigOLK00AT/MZklRvVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eu6m/sMkQ+IbS7MLOejPvIztfdkc6E/2GegGYVyWaatuvwqPLFelJiYlth8TPHerqZSKiBU0lMRwmhx49M36sEQIOy/ioJeE7ymhxtD7HqremzV2i0aC6bC7xUzHiG5fjSny+BVB44DT8DNLXGbVbF7Z8CDUZ70DgFAo5M4F3I+MF0dT9VjqXfjW8wT+VvH3yjnbUm9hkNniSBO1NgPyzTbmF8Jj5MzoK/4ojKXUeaUvJtwMeLgWkj57wdSxrjOKe5kNFQAm3YVtbQfd+RgSs5VKCSu9JSorWAJM+58Vr8Jq1diYlffY64KF1jSElw1zu0N3QID3ku4arP03ntd1vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFK+DcudUfIlD74gluAR/dSirnX7eqNdyP1gpUuGVXA=;
 b=oUxibwTsI2T9KkEuTqQMgxrUrPD7dlWIXOI2+k6T3jJQzheXFSKPWSN+/7qJ8WTnBNsOonAhepzE8udLNCKAe3HIGB+ny6OuiE4fuiiC7mhH5TiZlHWEQJ6fhYVI1kmUyNuTHoE4uv49vfUzNtx2iO2ETqpWzKp8qteTCi3nlQ6OSB99514aQjczmWo8khBTTveK1ex60PkZE0+JaTovQJfPk10NWpbNH2v54Lsx10uKvrJPlC8xz2Aw0MKvziOcWqPkYJZ9Jm+APv2y4QROgvagvghk1L+nukWAF/1DUmbi/d5/1aOKyer1u9XeFvpQXfi9mW71V1Q+gZkFH8cp1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI1PR02CA0046.apcprd02.prod.outlook.com (2603:1096:4:1f5::14)
 by SG2PR06MB5336.apcprd06.prod.outlook.com (2603:1096:4:1db::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Mon, 17 Nov
 2025 01:59:46 +0000
Received: from SG2PEPF000B66CD.apcprd03.prod.outlook.com
 (2603:1096:4:1f5:cafe::5e) by SI1PR02CA0046.outlook.office365.com
 (2603:1096:4:1f5::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.21 via Frontend Transport; Mon,
 17 Nov 2025 01:59:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CD.mail.protection.outlook.com (10.167.240.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 01:59:45 +0000
Received: from guoo-System-Product-Name.. (unknown [172.20.64.188])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id CA62C41C017B;
	Mon, 17 Nov 2025 09:59:44 +0800 (CST)
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
	Jun Guo <jun.guo@cixtech.com>
Subject: [PATCH 2/3] dma: arm-dma350: add support for shared interrupt mode
Date: Mon, 17 Nov 2025 09:59:42 +0800
Message-Id: <20251117015943.2858-3-jun.guo@cixtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251117015943.2858-1-jun.guo@cixtech.com>
References: <20251117015943.2858-1-jun.guo@cixtech.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CD:EE_|SG2PR06MB5336:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3d916844-b3fa-4193-764e-08de257cfb88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AanZ1OEgoZjSVDBpBky33+HtgEgyMpBbkBvtTI2cXtEL3Z3mhI6Vf7+FHeLp?=
 =?us-ascii?Q?mQVCo8DnZaZCKAPGRl1OnlG0Xpo1UmEcQmXtaQGZvS3ehE2UI4rhp2iiX6Z2?=
 =?us-ascii?Q?oSscFq0J5B16Tdteicd+CahuzlOK+MkhjQWWdE1yc+Rwh0miRgnG+paCv+Rm?=
 =?us-ascii?Q?65uN1zPHf/vC03rtOSQWGVofo5cgt8h9r4we/JPE+dc+qX8Wc4IgKDJeeHAV?=
 =?us-ascii?Q?CemFfeinv2VkZUGuyMHfWyJDhRZVhxJVtgi3Sfd3m3buhhJCNKk+iVxv+oNl?=
 =?us-ascii?Q?M9I0IUwckBOQoL9TJZXoqv9y8DlJbhhQP3ldrmAgrgirCj/l4EPHX2PriSFj?=
 =?us-ascii?Q?fYo7r4NE4848pq5FKN2WbQTkeq2sdtfEbU1z3LH4RRlwXKYJlKuBRBdFGqDW?=
 =?us-ascii?Q?IyhRsf2Hl6T9JxSf0e9j2eO+G5FdO9pOEEDKKHYwx/toXwbv6KIMPwGvjvy5?=
 =?us-ascii?Q?ojy26y0io2yD/TTsu0LvvPjhdVshDzNxr3hRtq8npHmcjDXajJ2GFD08r0gn?=
 =?us-ascii?Q?Nls30TuNIzJnSJvdbGi/+spSCEkav+WXYCT6AdiHXarkkdP/DRUiLN012a7n?=
 =?us-ascii?Q?Uybdn1VN+tAhylCyblq5kg68f3lVSF2AkITKIEvAPFe9voX4Y2XD8UgYLulB?=
 =?us-ascii?Q?t/3YD2IkJlunTPrMKnstL4BD9AH4BZswUdmFUdkxWfvS4hIywI++3GDVR7cz?=
 =?us-ascii?Q?T5V0kGtuYPkTwfpwaXOja5RBLvSfLFCbX66BT8cRn9phPbCLQGK35gNypyTd?=
 =?us-ascii?Q?nbmohGhHP/BsWstjoZvZFXbMxyQILpOvhKb1jWFs2UukBM4FepTxsna5uouA?=
 =?us-ascii?Q?Sq4GCbb6pqGmF7XYSIh0ebqQPHfTCECmoZouoe3WIToO8qJ1b+qb5Nt+PJtG?=
 =?us-ascii?Q?4xjXz6EQ3GI9XX7V7pgIGJouc5f/lfGEldRzaSX6nzVszBIwpcfcZKlq142K?=
 =?us-ascii?Q?2zTRTGfsg1Z91xasDKP2OJCo0fUPnRN5fiQtyBhAdryDO6FCdxUHH1vQmO3X?=
 =?us-ascii?Q?sTLCCMLHJggc13A0S395DUWVKlcK9rBU3HRPV7nUzSWMbPBtJVS4i9AkmfWX?=
 =?us-ascii?Q?Vg5i8yJYNX7DUZw8jdx9LpfmLFgnUBevv6BWmrYGeK2HMgP3lKY31/rAki1N?=
 =?us-ascii?Q?Qlek5XvkXv5am5eh4NpIEOLd75WokxI9yTnYsa2x1UFZxD/8njhVsqXODs/h?=
 =?us-ascii?Q?qkJnd8+/SylR/L6/qioe5sEN6BvBiLTtOS1ZilA15rzJ1bjfE97Wma3QMafr?=
 =?us-ascii?Q?W7TUcQbDDZIBxNitzULUQCa0d8iaBf3GB5ZSA+BQqNC6XEl2PvteqBTr7nah?=
 =?us-ascii?Q?FdE85wBlKGn3Y1rTKTtBARvNaUaIFKKEdkpch1iSiIVDdf/SR1eLjLmGXuNe?=
 =?us-ascii?Q?54mFO7+psC0XDHGMsP+JeN0rU3q+PgfUFKfYkLJ/HrhCae7N5CY/U3SLnkGH?=
 =?us-ascii?Q?f1Rphe3C2qHJrlzF2zG19zntIvm8M1TBeDONFsV/TxSjhDryYiPQfCJnqgec?=
 =?us-ascii?Q?yUyLLgo+8MTyD84UxJSR1o44SpT9iEjmUDdT2TNsiFhXk6nePWL0Rbk9J9Kv?=
 =?us-ascii?Q?zVg4tesdqLAM8sA6DJY=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 01:59:45.7674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d916844-b3fa-4193-764e-08de257cfb88
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CD.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5336

- The arm dma350 controller's hardware implementation varies: some
 designs dedicate a separate interrupt line for each channel, while
 others have all channels sharing a single interrupt.This patch adds
 support for the hardware design where all DMA channels share a
 single interrupt.

Signed-off-by: Jun Guo <jun.guo@cixtech.com>
---
 drivers/dma/arm-dma350.c | 115 +++++++++++++++++++++++++++++++++++----
 1 file changed, 105 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
index 9efe2ca7d5ec..cb1907be18d0 100644
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
@@ -192,6 +196,7 @@ struct d350_chan {
 
 struct d350 {
 	struct dma_device dma;
+	void __iomem *base;
 	int nchan;
 	int nreq;
 	struct d350_chan channels[] __counted_by(nchan);
@@ -461,7 +466,61 @@ static void d350_issue_pending(struct dma_chan *chan)
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
@@ -506,10 +565,18 @@ static irqreturn_t d350_irq(int irq, void *data)
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
@@ -526,7 +593,7 @@ static void d350_free_chan_resources(struct dma_chan *chan)
 static int d350_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct d350 *dmac;
+	struct d350 *dmac = NULL;
 	void __iomem *base;
 	u32 reg;
 	int ret, nchan, dw, aw, r, p;
@@ -556,6 +623,7 @@ static int d350_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	dmac->nchan = nchan;
+	dmac->base = base;
 
 	reg = readl_relaxed(base + DMAINFO + DMA_BUILDCFG1);
 	dmac->nreq = FIELD_GET(DMA_CFG_NUM_TRIGGER_IN, reg);
@@ -582,6 +650,26 @@ static int d350_probe(struct platform_device *pdev)
 	dmac->dma.device_issue_pending = d350_issue_pending;
 	INIT_LIST_HEAD(&dmac->dma.channels);
 
+	/* Cix Sky1 has a common host IRQ for all its channels. */
+	if (of_device_is_compatible(pdev->dev.of_node, "cix,sky1-dma-350")) {
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
+
+		/* Combined Non-Secure Channel Interrupt Enable */
+		writel_relaxed(INTREN_ANYCHINTR_EN, dmac->base + DMANSECCTRL);
+	}
+
 	/* Would be nice to have per-channel caps for this... */
 	memset = true;
 	for (int i = 0; i < nchan; i++) {
@@ -595,10 +683,16 @@ static int d350_probe(struct platform_device *pdev)
 			dev_warn(dev, "No command link support on channel %d\n", i);
 			continue;
 		}
-		dch->irq = platform_get_irq(pdev, i);
-		if (dch->irq < 0)
-			return dev_err_probe(dev, dch->irq,
-					     "Failed to get IRQ for channel %d\n", i);
+
+		if (!of_device_is_compatible(pdev->dev.of_node,
+					     "cix,sky1-dma-350")) {
+			dch->irq = platform_get_irq(pdev, i);
+			if (dch->irq < 0)
+				return dev_err_probe(
+					dev, dch->irq,
+					"Failed to get IRQ for channel %d\n",
+					i);
+		}
 
 		dch->has_wrap = FIELD_GET(CH_CFG_HAS_WRAP, reg);
 		dch->has_trig = FIELD_GET(CH_CFG_HAS_TRIGIN, reg) &
@@ -640,6 +734,7 @@ static void d350_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id d350_of_match[] __maybe_unused = {
+	{ .compatible = "cix,sky1-dma-350" },
 	{ .compatible = "arm,dma-350" },
 	{}
 };
-- 
2.34.1


