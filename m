Return-Path: <dmaengine+bounces-9520-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iG/8C6fNu2mXogIAu9opvQ
	(envelope-from <dmaengine+bounces-9520-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 11:19:19 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A42822C95CE
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 11:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0C723035267
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 10:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDBE36165A;
	Thu, 19 Mar 2026 10:17:38 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023091.outbound.protection.outlook.com [40.107.44.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6593B2FE6;
	Thu, 19 Mar 2026 10:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773915458; cv=fail; b=ZDhQ4UJJrfA8RQITyCOU3Hich8G5z/5NHPKPjEas7GjFT9g8bJoU7UhMe8f7HnO+y7CNDjm3P+UhglVR3N/RHmWAO/ETNRiDp2a2r/QXPYbGHkrdTwDMVYhRMWJjQPJjB1lxBF/OVBv79irH5crQR9jlcl4fdFgCVVWqXgmx+8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773915458; c=relaxed/simple;
	bh=1HCpv8/5We81/uq8IF6JYVVWzxt8vioLviFWQglH51g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aDqI2Wtb2xjCTE05vdjkB5BLvOPlkeOFoRZXtCaGWZRmJSJYgge2u483q4zWb186P+ELF2vgESeQ0q7GYieolB4RPj9YRxvDNHms0LVnXPZgjMW1p+SURLdd8CZq9Ubu0jJQ5SNcPlLid778lrxNw6wLMeT7hqsHoqWpAtjm6UM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ewOtnRXje37KCIqkAgmXXQj6Z1n4pme2koKVHKncxUa7vkzfwU9xpY6Az9bY65VM1ZJtUx9UtV+JJLHhB2ZUWseIQS9PfcP/AQqmT6rqrr8erhRxNvnGwph0D6bH6OIGLKh79aIgdJPCk7cPjk+XuuCyLrSRcWUHY1mC520Qxm2WIByAefat4FXQcr9muKvYziXLGNNm06JIeS2NysJGbaAOZclxSXUYyk7UeZBu0Ln43DgsqIFr/5KmoxN57U3bQOMSOfR6aCmdD9/g32wL08XIMB7JyajD0qJMHBKo6z3HyKvGLWP2iNbFZJR39I5AwKfqWfqoFjeHZHvaLoBtpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5oRnYiRTj/6KHXH7ANIzqUqzPWFC7ChD1Il5HOvADc=;
 b=SCsffzIhkzdvuFjzgzLJJf1nQ6wBcYvDVmAjnkfDD9bmZRXYdlLENhd9f1bYEBnotT+2uYDfSbxi95wpETJR/YljfRarKSe0nzeoN5FpcUYWsUE1Aioynk+7VWwBLiFnLeQz+PcFQlqfYHWIUo4r+3QPYSobEJtjVEjWth+Ou0DY6M0WS+6us+LuoWZ+cIide7BzHTfOFgSwgeHvlro18YSCGuJ7sb/buAp/gAb1oyfpFIQpCUGBB2EaGC/9UODwCjDzuKW+8fYk8OliUSDF8Behki3qF/hf+l35+s1/PI/K7gqHh0teMdaure2VD+jkmzh98DbmTU8q/TnC6M0I1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR02CA0049.apcprd02.prod.outlook.com (2603:1096:4:196::7) by
 TYPPR06MB8242.apcprd06.prod.outlook.com (2603:1096:405:383::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 10:17:28 +0000
Received: from OSA0EPF000000CB.apcprd02.prod.outlook.com
 (2603:1096:4:196:cafe::85) by SI2PR02CA0049.outlook.office365.com
 (2603:1096:4:196::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Thu,
 19 Mar 2026 10:17:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000CB.mail.protection.outlook.com (10.167.240.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 10:17:27 +0000
Received: from guoo-System-Product-Name.. (unknown [172.20.64.188])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id D55BA4126F90;
	Thu, 19 Mar 2026 18:17:25 +0800 (CST)
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
Subject: [PATCH v3 2/3] dma: arm-dma350: support combined IRQ mode with runtime IRQ topology detection
Date: Thu, 19 Mar 2026 18:17:22 +0800
Message-Id: <20260319101723.246539-3-jun.guo@cixtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319101723.246539-1-jun.guo@cixtech.com>
References: <20260319101723.246539-1-jun.guo@cixtech.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CB:EE_|TYPPR06MB8242:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 83a5272c-f57b-4a46-e01d-08de85a0b8bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|7416014|82310400026|22082099003|56012099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	l7J4t25awIjdC53/K2ehs9OK2gFXLGxxpaLwCNdZDef/BufoWSOpp4GYMeG6hEv+YDGQV85OOp/v+mo1lWSF3Miaa/wsn0pJIhoRaVzaKY3SA/+t0njupzKVCAAFK5WzQZJUobLFliTsCJIbClcXCh82z/Fp7wP5JEePV5M/4zpIsJOd43whsJWxelELG0+jTtvtbD50qJJEUSu9kdIYILqtjFhx8SczY1a4dKh18BcAcFaEWB+LD5m9gIZmcMRsuwoNPWsWpKwGnWccugSbBAonjaU8Qe2Hp62/bq2PtxDb0W31b2CMvXaTTpHc1L9CS2rjWTAcZS7hj9u2rsccGmknuN5BNSbAdbJHxEfjwn529ppC3WgizuvhsenZM7UQkGuN52CGHKnV+YkHAigXATSZ1NMQMDLBHBkWxVj5RLX8Xmz7HCLBIZoWMmjZdvh2OGuV16vVvLNHgbgNEE9mxb7K7+tLfIGzttSvcXQOn8d+BxlB/PmGcV0EeIB8A+LsgMtXcRmM8MphMM+sRNewT5OjJPlgIXZtVKeSfd7YlkabsxaQq7p7ijRSTBldKt7D2X56XQUmez3bO+RV6TxZvYF9JesXT5eR2lGP7HecUT+m7SgQpGrW3wZA+9dHWY3f90yowtpPtkrhzX5HuVc9Hhx3CshIxXioBee45plcEm4MMlUGQLNOk+Pdkk/rZNgfeafj1z0Ztpr53hdkpJdPc/3gHSgPBUhCamlkyyXoT7rbCydlHTBiFje2q4mbs3synOE7iPxeH2V8VvkwC1SHQkp+nzlRI0M41JlvHijUw+k4FdLlReP5oXgox1KoFtOo
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(82310400026)(22082099003)(56012099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vv5Kt8ebs3wVfads/AybMJJph5BK9pTN+72A8N7jYJGR1maIRJqWJu2GgDGh5D2Ku1BFSvVZEPVRQN4pYwyEKMZwc/Cn94Xc3z75JeFzTIEmUXOlGNeo+zvi45hXDa+Mqd3jt+VqNqtAgNJMgPy8grwflqu554FNYyDo5yK3r8OOJKaxFjerTeP6P1WUKdfFRF+F3H3SE/K2GkEB+KfGL6kYXXKC6GnEGcZKm6Ffufs8EcusSFlPs8T5eLsFm6LRqkUwCaeb7TjqjfiqjxyLPCZg0Tc9K38Rn9rHegL20wtel2CvpQdFNtPlGnqAI1mlhpBjcXIBW1DU2yVLQG72g1QcutDUpvYCkuUy/8tFOOCjOYLuHRvrmFqM/SAPdoaxBPkV1xZI2YQgvdJigosRUcx9HHSUs6CkfzTwwVtKL5aulFUQwAZJRm3KY1ZHgZo+
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 10:17:27.1173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a5272c-f57b-4a46-e01d-08de85a0b8bb
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000CB.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR06MB8242
X-Spamd-Result: default: False [3.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9520-lists,dmaengine=lfdr.de];
	DMARC_NA(0.00)[cixtech.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jun.guo@cixtech.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.314];
	RCVD_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cixtech.com:email,cixtech.com:mid]
X-Rspamd-Queue-Id: A42822C95CE
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

This patch is Assisted-by: Cursor: GPT-5.3 Codex.

Signed-off-by: Jun Guo <jun.guo@cixtech.com>
Link: https://lore.kernel.org/r/20251216123026.3519923-3-jun.guo@cixtech.com
---
 drivers/dma/arm-dma350.c | 165 +++++++++++++++++++++++++++++++++------
 1 file changed, 139 insertions(+), 26 deletions(-)

diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
index 84220fa83029..2cf6f783b44f 100644
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
@@ -640,6 +752,7 @@ static void d350_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id d350_of_match[] __maybe_unused = {
+	{ .compatible = "cix,sky1-dma-350" },
 	{ .compatible = "arm,dma-350" },
 	{}
 };
-- 
2.34.1


