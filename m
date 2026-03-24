Return-Path: <dmaengine+bounces-9622-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLO8JsSAwmlneQQAu9opvQ
	(envelope-from <dmaengine+bounces-9622-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 13:17:08 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFE6308071
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 13:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 41F403047286
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 12:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29BE3F23BB;
	Tue, 24 Mar 2026 12:01:29 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022124.outbound.protection.outlook.com [40.107.75.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39D63EFD37;
	Tue, 24 Mar 2026 12:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774353689; cv=fail; b=OblfE9FGeQExdcw0IDw1Yp+yDB5WJ4OKAyrMDmLlWE520baTbFTHdDG04/1nwFV4DKic6oQqTp+biubCytBajer6NpPUUQuMmjSnriAuqHpfPzW7cSrZk84CtAi1YnjZ8y+nDyXbDXXX+sNEnQfgiBwVVaokO2VhjHvER67uJkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774353689; c=relaxed/simple;
	bh=tFgZ+BAt0weVwsNwZ7ToG1JuH+X8WR7ztQnDqmNHD/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dTquZn5Arjp+WEtrZBJmjZk5G+vA5Y8BXHXFCDnJ2Xs56X7UWvLfm/calutAUUo/EDGXRa4tAkB+I0/2kCDo1K2VCYk1lffqMjONulfIsIx9X8d/dwfUqOQzCLaVaU05iF87/DiA6/q3HGWJGH8frgUUcJzMwXE8r90ciKvIdjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GRIldbP40Xjr33s+BTirDFlN9pCiG686LI+937AM3qmymbCm8QImc2wQf0pby3mKJCYnBDmP205epNwavcYRptbfpJbf5nUChr3F0OSaNYDFfJzwkbX1Ag0Yb0sOi+3qP5Rb5kckbP6hO568/t7zJ1gHaAGo0gOKSS2fJzLBjLEaBoKe3haQOdONazYg6hPNS9l6tnjuzLs7F39Y+4jo/juzWraJbSLzZ8RIrPPp7NiQ4b6+uLTRT5t8uR9xUc0Dddnm5es5JQWZqgmm3K3CcpF3ipOkhqZXE9ey0m9ChdAiRZx9hWnLF+n57cmwoON9ud+a8pH/Apj7idBOCLgYjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V97lSHmYmZQNj/WK3qXhzLHfnMTjHvxr382F+owUrGM=;
 b=SR4ENBNrmrerA633OMniUxzdH7KmAtcV0mgY6a37V8sm2zQkGPhnolJp6JXvdNw2Z0V1t4kt26aFBPSrevxrNus2C+XnPjUNfQ3sOQlPWAKVpFLiKkmjbjfVnQPQab8Lc/PSOktJs9XsaWGm871WAxaywkfWKAbIfXeUs/MEXttlgKuINHw1+poWrnQsIj9RYerJnJk/+ZlEatiFJyMxjha/dagL1u6LmZbYZ0JHxvRRY+UaiKSyxis6Z6jaUK7KzXlGfpriWsp+wndfW7rEmWTcR8I6XFL6RzkMND2ybt48MUxdSZthGCSrz2FMzOm/Nb3hrdhO/pULyyoh6jVCdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI1PR02CA0057.apcprd02.prod.outlook.com (2603:1096:4:1f5::10)
 by KL1PR06MB7009.apcprd06.prod.outlook.com (2603:1096:820:11a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 12:01:19 +0000
Received: from SG2PEPF000B66D0.apcprd03.prod.outlook.com
 (2603:1096:4:1f5:cafe::2d) by SI1PR02CA0057.outlook.office365.com
 (2603:1096:4:1f5::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 12:01:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66D0.mail.protection.outlook.com (10.167.240.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 12:01:18 +0000
Received: from guoo-System-Product-Name.. (unknown [172.20.64.188])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 831A34126F9A;
	Tue, 24 Mar 2026 20:01:14 +0800 (CST)
From: Jun Guo <jun.guo@cixtech.com>
To: peter.chen@cixtech.com,
	fugang.duan@cixtech.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	ychuang3@nuvoton.com,
	schung@nuvoton.com,
	robin.murphy@arm.com,
	Frank.Li@kernel.org
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com,
	linux-arm-kernel@lists.infradead.org,
	Jun Guo <jun.guo@cixtech.com>
Subject: [PATCH v5 2/3] dma: arm-dma350: support combined IRQ mode with runtime IRQ topology detection
Date: Tue, 24 Mar 2026 20:01:12 +0800
Message-Id: <20260324120113.3681830-3-jun.guo@cixtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324120113.3681830-1-jun.guo@cixtech.com>
References: <20260324120113.3681830-1-jun.guo@cixtech.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66D0:EE_|KL1PR06MB7009:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d9a5bdde-6d62-412a-b056-08de899d0ebb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|7416014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	DmUDJp5yr9ShZV0B5f52zqeqfKIa5Zkbw7p3sNFICoelY+Yd8sjbO1mnxHHYFCAEKpnaylAn58yO0NV+PB/82lrCmFbxuS0rfoKpmLgor59IXsfOOlpp/1+m0vG41P/RVnOlz3Nx09z63fzv2+Oquor6eZj9rLC32RhMiqSFGYLQV0XwHL8YNRYuSsrs0aCXk5vH2G/4d1SJoPsGUzpa7IkCWvAYHFElUJNDH3oN0ZYabcxEgdB06WRdqby2y3rtgX5XRopyTr4o6QX+jmZdmPiP9yQqj0pqChRxKhPdENq7GKQiBkcIB40QG1dCxFgfZgznhJkd+Sw5BEpxi5kInML/sgdC/24n5pUNfb1JB0d4R7VLnPyYODGdEnKzFCVHFxHxnNP+mZy0wSXTGI+LubVBUjamugOiqorejDNUaP+vF2Appncz76YEqW525WKcje3L0vVFjabn8NRznSr5/ecDAMl1uO+k5KThXRb5J/vxb4o3I06uVe0Zxwox2OowVXiMARFciwy9LTK8suBZjG9+po+mzqyu6Jl7QVcdC1IROpMQPRw2/a3tEcd8Il1E+daLJj6EOIjqpv725Z3B335UuQXez3lXqOCcxL2PQWq3gIaWtRVyjDzef9h7WtiqTIwQpLTJYuSxOOZl2h3wkybu0cn6x6mCrzF57UtbdhS5yEliNHpaPUo5BYTM1YtL1BtCeT2QCaCUcFOwYjR1yJgImcMVnd/6SRBQ9yqnQ0qumRcIitb2wNohPRo0PVGZ6gBE2yYbul9XXYA5T3AdhmcpRNC2kQMB/spsBPePWtlZAeix7xM7TUkPJUr0//E5
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(7416014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NgcRLn43K5XSm+dAawyQDT0suBZ1XgD/Qej+d9vC7PdVGetRqA8qjzbhqOV+3F+qkq4VcLNUaeEQnowsCVX/h+4pjNm0dEDpfmmPb1pfG834YPBQnk7mrr17kVAkNr1sFs72GJMaL8WWWJXDjtlUE/sAq2dkowTADZRkBisWYMpK4rF09eftFckp52nvP534P0bplPgioORo5ALyL/dtQpUmPcvMmfDbzhf6MvYDjdWtyEqofmzpQcZi4NzMBOWJWFGXmLHFGuS3tIeYxUWN7/E4zGVKrjq/Fp0eqFAG4gvQ4T9pu0CENVNhfHjHobwFcnV0Ufm0hkMO51bk2ytsAij/wUyx6ODXRoAxEpgdLPQRMNMjSOi0gMoMBbCz6QaPHwY3B9pw/Y7ZVawMVnja3R6bK5Chc7Ev8k/xRwikNjC7Bcl/8lMhPU1GBH6OI/UL
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 12:01:18.1579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a5bdde-6d62-412a-b056-08de899d0ebb
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66D0.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7009
X-Spamd-Result: default: False [3.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9622-lists,dmaengine=lfdr.de];
	DMARC_NA(0.00)[cixtech.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jun.guo@cixtech.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9EFE6308071
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DMA-350 can be integrated with either per-channel IRQ lines or a single
combined IRQ line. Add support for both layouts in a unified way.

Detect IRQ topology at probe time via platform_irq_count(), then:
- request one global IRQ and enable DMANSECCTRL.INTREN_ANYCHINTR for
  combined mode, or
- request per-channel IRQs for channel mode.

Refactor IRQ completion/error handling into a shared channel handler
used by both global and per-channel IRQ paths, and guard against IRQs
arriving without an active descriptor.

Assisted-by: Cursor:GPT-5.3-Codex
Signed-off-by: Jun Guo <jun.guo@cixtech.com>
---
 drivers/dma/arm-dma350.c | 164 ++++++++++++++++++++++++++++++++-------
 1 file changed, 138 insertions(+), 26 deletions(-)

diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
index 84220fa83029..9e42c34b74bb 100644
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
@@ -461,18 +466,40 @@ static void d350_issue_pending(struct dma_chan *chan)
 	spin_unlock_irqrestore(&dch->vc.lock, flags);
 }
 
-static irqreturn_t d350_irq(int irq, void *data)
+static void d350_handle_chan_irq(struct d350_chan *dch, struct device *dev,
+				 int chan_id, u32 ch_status)
 {
-	struct d350_chan *dch = data;
-	struct device *dev = dch->vc.chan.device->dev;
-	struct virt_dma_desc *vd = &dch->desc->vd;
-	u32 ch_status;
+	struct virt_dma_desc *vd;
+	bool intr_done = ch_status & CH_STAT_INTR_DONE;
+	bool intr_err = ch_status & CH_STAT_INTR_ERR;
 
-	ch_status = readl(dch->base + CH_STATUS);
-	if (!ch_status)
-		return IRQ_NONE;
+	if (!intr_done && !intr_err) {
+		if (chan_id >= 0)
+			dev_warn(dev, "Channel %d unexpected IRQ: 0x%08x\n",
+				 chan_id, ch_status);
+		else
+			dev_warn(dev, "Unexpected IRQ source? 0x%08x\n", ch_status);
+		writel_relaxed(ch_status, dch->base + CH_STATUS);
+		return;
+	}
+
+	writel_relaxed(ch_status, dch->base + CH_STATUS);
+
+	spin_lock(&dch->vc.lock);
+	if (!dch->desc) {
+		if (chan_id >= 0)
+			dev_warn(dev,
+				 "Channel %d IRQ without active descriptor: 0x%08x\n",
+				 chan_id, ch_status);
+		else
+			dev_warn(dev, "IRQ without active descriptor: 0x%08x\n",
+				 ch_status);
+		spin_unlock(&dch->vc.lock);
+		return;
+	}
 
-	if (ch_status & CH_STAT_INTR_ERR) {
+	vd = &dch->desc->vd;
+	if (intr_err) {
 		u32 errinfo = readl_relaxed(dch->base + CH_ERRINFO);
 
 		if (errinfo & (CH_ERRINFO_AXIRDPOISERR | CH_ERRINFO_AXIRDRESPERR))
@@ -483,14 +510,10 @@ static irqreturn_t d350_irq(int irq, void *data)
 			vd->tx_result.result = DMA_TRANS_ABORTED;
 
 		vd->tx_result.residue = d350_get_residue(dch);
-	} else if (!(ch_status & CH_STAT_INTR_DONE)) {
-		dev_warn(dev, "Unexpected IRQ source? 0x%08x\n", ch_status);
 	}
-	writel_relaxed(ch_status, dch->base + CH_STATUS);
 
-	spin_lock(&dch->vc.lock);
 	vchan_cookie_complete(vd);
-	if (ch_status & CH_STAT_INTR_DONE) {
+	if (intr_done) {
 		dch->status = DMA_COMPLETE;
 		dch->residue = 0;
 		d350_start_next(dch);
@@ -499,6 +522,44 @@ static irqreturn_t d350_irq(int irq, void *data)
 		dch->residue = vd->tx_result.residue;
 	}
 	spin_unlock(&dch->vc.lock);
+}
+
+static irqreturn_t d350_global_irq(int irq, void *data)
+{
+	struct d350 *dmac = (struct d350 *)data;
+	irqreturn_t ret = IRQ_NONE;
+	int i;
+
+	(void)irq;
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
+		d350_handle_chan_irq(dch, dmac->dma.dev, i, ch_status);
+	}
+
+	return ret;
+}
+
+static irqreturn_t d350_channel_irq(int irq, void *data)
+{
+	struct d350_chan *dch = data;
+	struct device *dev = dch->vc.chan.device->dev;
+	u32 ch_status;
+
+	(void)irq;
+
+	ch_status = readl(dch->base + CH_STATUS);
+	if (!ch_status)
+		return IRQ_NONE;
+
+	d350_handle_chan_irq(dch, dev, -1, ch_status);
 
 	return IRQ_HANDLED;
 }
@@ -506,10 +567,18 @@ static irqreturn_t d350_irq(int irq, void *data)
 static int d350_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct d350_chan *dch = to_d350_chan(chan);
-	int ret = request_irq(dch->irq, d350_irq, IRQF_SHARED,
-			      dev_name(&dch->vc.chan.dev->device), dch);
-	if (!ret)
-		writel_relaxed(CH_INTREN_DONE | CH_INTREN_ERR, dch->base + CH_INTREN);
+	int ret = 0;
+
+	if (dch->irq >= 0) {
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
@@ -519,18 +588,21 @@ static void d350_free_chan_resources(struct dma_chan *chan)
 	struct d350_chan *dch = to_d350_chan(chan);
 
 	writel_relaxed(0, dch->base + CH_INTREN);
-	free_irq(dch->irq, dch);
+	if (dch->irq >= 0) {
+		free_irq(dch->irq, dch);
+		dch->irq = -EINVAL;
+	}
 	vchan_free_chan_resources(&dch->vc);
 }
 
 static int d350_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct d350 *dmac;
+	struct d350 *dmac = NULL;
 	void __iomem *base;
 	u32 reg;
-	int ret, nchan, dw, aw, r, p;
-	bool coherent, memset;
+	int ret, nchan, dw, aw, r, p, irq_count;
+	bool coherent, memset, combined_irq;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
@@ -556,6 +628,7 @@ static int d350_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	dmac->nchan = nchan;
+	dmac->base = base;
 
 	reg = readl_relaxed(base + DMAINFO + DMA_BUILDCFG1);
 	dmac->nreq = FIELD_GET(DMA_CFG_NUM_TRIGGER_IN, reg);
@@ -582,12 +655,46 @@ static int d350_probe(struct platform_device *pdev)
 	dmac->dma.device_issue_pending = d350_issue_pending;
 	INIT_LIST_HEAD(&dmac->dma.channels);
 
+	irq_count = platform_irq_count(pdev);
+	if (irq_count < 0)
+		return dev_err_probe(dev, irq_count,
+				     "Failed to count interrupts\n");
+
+	if (irq_count == 1) {
+		combined_irq = true;
+	} else if (irq_count >= nchan) {
+		combined_irq = false;
+	} else {
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid IRQ count %d for %d channels\n",
+				     irq_count, nchan);
+	}
+
+	if (combined_irq) {
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
+		/* Combined Non-Secure Channel Interrupt Enable */
+		writel_relaxed(INTREN_ANYCHINTR_EN, dmac->base + DMANSECCTRL);
+	}
+
 	/* Would be nice to have per-channel caps for this... */
 	memset = true;
 	for (int i = 0; i < nchan; i++) {
 		struct d350_chan *dch = &dmac->channels[i];
 
 		dch->base = base + DMACH(i);
+		dch->irq = -EINVAL;
 		writel_relaxed(CH_CMD_CLEAR, dch->base + CH_CMD);
 
 		reg = readl_relaxed(dch->base + CH_BUILDCFG1);
@@ -595,10 +702,15 @@ static int d350_probe(struct platform_device *pdev)
 			dev_warn(dev, "No command link support on channel %d\n", i);
 			continue;
 		}
-		dch->irq = platform_get_irq(pdev, i);
-		if (dch->irq < 0)
-			return dev_err_probe(dev, dch->irq,
-					     "Failed to get IRQ for channel %d\n", i);
+
+		if (!combined_irq) {
+			dch->irq = platform_get_irq(pdev, i);
+			if (dch->irq < 0)
+				return dev_err_probe(
+					dev, dch->irq,
+					"Failed to get IRQ for channel %d\n",
+					i);
+		}
 
 		dch->has_wrap = FIELD_GET(CH_CFG_HAS_WRAP, reg);
 		dch->has_trig = FIELD_GET(CH_CFG_HAS_TRIGIN, reg) &
-- 
2.34.1


