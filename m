Return-Path: <dmaengine+bounces-3573-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6279AFF5D
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 12:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 499A5283286
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 10:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DA31D4352;
	Fri, 25 Oct 2024 10:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eEohMNbz"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657C01A0BEE
	for <dmaengine@vger.kernel.org>; Fri, 25 Oct 2024 10:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850452; cv=fail; b=P9cn5x8GSBRlXQ45ER6tYp++5H0veTyk9vaG5DLzIfcxBTj63iaPPbSLI/cdeqyj7Dwwixiy5gEgYcgci8naRrOVLW5o+d56AI4Yt2a7FKT1CmNmjHxYbZoKi2UMffKr3nDjQTiUY/vWo8sHiWhmqaVF0TkaO7GF0jHE8qCLAEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850452; c=relaxed/simple;
	bh=0DtXHPJuQy2PHRpNHMdFZk/EUe1L09W/CRdxPK6priw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KMyqKV6zw+GrCFvMXJaPjcIAKJhoNRN5uCpOA9SbKRF2F97oGVt8achPYAB4z+w2Yx/1vIf0Pe7TffkuSx//to4EAC4hNSEWV/HSILeO3nYfw3/nPDZKDzN9Or9+jA0LqqR1nXpwOthVKO4zCxB+PozDJHDvVmd+jzpZtXvyjRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eEohMNbz; arc=fail smtp.client-ip=40.107.93.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ttOhuRjjr/a5G7ju8bE5u6acJZCBiwaP8aAPsxJ+fr5838IU3DTG08fxtSOk5XU0+5E7qUgcUk7G2+4GTuZ5Rs2u2UXAzMwmk15PBUOO+TXPaAxcs+aYjkJixKW4iL+fWc12U4dakw5CEucrM1QcdjJUMm1LD/pvEeSAVfF3StlZCekiOjD9FfbAprhnN+KEHDhKj+iJnfh3dttTV6GZjCIZ6uwJcJbcf6J4ykaSztFp1RHGMy4sNcRZIS/QmYcWlu/DjHrlMiGXhYpO6NA8rMUSOnmls/VbhELunEiRxeJVXxSGoB9v2QeZAcSafX0RCHEQ8W4y41PNTFh34Fabzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1BX+ylMJuA51jMPVMzBd1noOfpfcERitMlIGXkPfrA=;
 b=YKneggTh8tH3/DWMfp7aJj86ppOr5Jo/e/C1+dQ/07A6pZ0Js0eIGbFLUW2PBc+5MOJjZXiKy05iPTe9PNTWJii1FP9WEnUGSqa2bv5nusg2UAVpzqdq/lg1q3n8X+bD0yrkpqxaqncu9WmbtAhklm1hbWaSO5PtqmMbm0pb9bkc/HYbJGIokoAnrS/Ok3K5soG6l4te4UffYtC7iWPXX0v+bjkvMEOkoiUPPLs5ncNUeOmBDd6Q9PNFvMDJw06EJJ3dgauR07xS0zYW6TNrSFLsymc/NlqL4XFSwkunGLcz6vEvyMwHoTaEWmghJD45gBqc4MIHFYeOCKIRnFrxIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1BX+ylMJuA51jMPVMzBd1noOfpfcERitMlIGXkPfrA=;
 b=eEohMNbzZV2vBHeoBMZ6ShqBR2V8PC9YGrKI5y+I5I3ZD41a9oNCEsrJTNR7EVe0bJaV/BS7ZS0L0dchWk131lAqKp9ArIbJJ9Uj2zkKmrN11UGhOUsH30wDo6iHsZKQue5BjQJalaHMlYvTbuqqMvAOvL2MI0aw9jTXKGGElAM=
Received: from BLAPR03CA0074.namprd03.prod.outlook.com (2603:10b6:208:329::19)
 by SA1PR12MB7269.namprd12.prod.outlook.com (2603:10b6:806:2be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Fri, 25 Oct
 2024 10:00:44 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:208:329:cafe::86) by BLAPR03CA0074.outlook.office365.com
 (2603:10b6:208:329::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19 via Frontend
 Transport; Fri, 25 Oct 2024 10:00:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 10:00:43 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Oct
 2024 05:00:39 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v8 3/6] dmaengine: ptdma: Extend ptdma to support multi-channel and version
Date: Fri, 25 Oct 2024 15:29:28 +0530
Message-ID: <20241025095931.726018-4-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241025095931.726018-1-Basavaraj.Natikar@amd.com>
References: <20241025095931.726018-1-Basavaraj.Natikar@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|SA1PR12MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: 992a6744-0974-4d8e-1bb9-08dcf4dbe417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q2rNo+/02QmH+gsa5lNI2s1OH1IwiQMOeTDdfAke+mT1mp4tv+GDpMuiIAKg?=
 =?us-ascii?Q?73yldgB8lTdbyZfq2m7QGIpv7sQDpbJVx1UKhePlEZmFRZ4uzuAUec9BbXib?=
 =?us-ascii?Q?a0fXPpHe3mOegvlcDU9gLseQlvbflYux8Bro9u4klI/QPPAyGYsMMEO4EqbF?=
 =?us-ascii?Q?7ZfKvjmmZRFAXXD8AfcxLuz2eEIuHAVURtILk2v205TxjaSJP/F8fH1UCONF?=
 =?us-ascii?Q?2zb2DM59QtGt7x5bnBLjDWII8szw7BiNSisQtFEz5BQrFHW5nch4VawSMbJe?=
 =?us-ascii?Q?eiBdG1E305f4yVdjT3rZlrn3I8K/YyxBCmT8m2BH0BrO9kKPXyx02/PcJQwR?=
 =?us-ascii?Q?+0D5+49KBViVLytxCy31LSwrEaA2dXOPn+DbGrAfjlTLbRZnMIl2zj0nYIE/?=
 =?us-ascii?Q?wNwU/k5qLQekHVI/g9gUXlVS0EUcJwHGCPmSViokBsFKT1cn1CFzMNixIKnu?=
 =?us-ascii?Q?eSeCfsO24rcZDDW3QRLKB55CycLJW4V2SwVObeao4UoCMQIKiSwliqn3K+Kg?=
 =?us-ascii?Q?xakLGz6JqqcEnrTKKT2O9ZUz1zg6lQivDfcSXnQglO7ZiJYTTYygte84KcNK?=
 =?us-ascii?Q?8ajYTHL6LJlz+6bWktZPNp8C5ip26u2zBAhHlA1iFnwrINkA5qsWpSVqluzO?=
 =?us-ascii?Q?RU8mZ2a7YZTSiS0XlzwSBS1rMW5TtCDbwZSQKlxwnqiCJ9cZHI56FosQO6/D?=
 =?us-ascii?Q?NoUl15Hu0Khe4LWem1ThYJpsJYVQg9/Kc/8ewdn0yUEc47T9dzhKhHJyk06S?=
 =?us-ascii?Q?903MApZEkRu6kdZLS3fA774i2tGWA3rX1Q0kcW6dekFnKTtlhJlVwwUbW3NZ?=
 =?us-ascii?Q?4thzwSgC0Lur91mFspBPAtySRryB69niG7s7iRk8LVPdypZLu4jrSEzvYAGM?=
 =?us-ascii?Q?TzE2m0Xx99lIyYuR3TgFSP6l2spgjbHABofwcGIPvQjSCeRJ3LQ0fZ5sQdzo?=
 =?us-ascii?Q?AQnH98QYgIasTKTrJSHhzfhzKGM56DPfzKWEp3spNVARwqnxA2bcc71cw5Q+?=
 =?us-ascii?Q?j6wqy9JKMlCi8TXLxbBhFfA2K6Mad7FGgSrPDSbhpl9H91QEQAEk+Q9CY/km?=
 =?us-ascii?Q?beMM66GpSiv3livQc/O9dMvdjUtYHtdZARTimPTGCXkDfHdJzPZbHfnfHYy0?=
 =?us-ascii?Q?uRpTdo1+LgP1axgGvNVJi/yyrtqdvcWe/y/untozXg1Gt890VB6mlM8LeLma?=
 =?us-ascii?Q?zTcyxwn1bKlo6eZdrMGN98SVCKN/rPt97BVWeH6RgGEB5DpiGu37MiJGebBb?=
 =?us-ascii?Q?/yt23m9OUlKJfuOo3Bv7Z6NZnpi//uX2UtW3U7LmgCvC+f9UpwsYNkRuZO7E?=
 =?us-ascii?Q?J08CxVKhMQG2FPoaqZu72CmA+MwhLhLO/BZkfiNSzOCRpF7O529Cqua281cv?=
 =?us-ascii?Q?k9Hru1x7Mliw6qB2uYO5J9UtZVt1TMiSJXthav+PrzMxdSxUlA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 10:00:43.9783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 992a6744-0974-4d8e-1bb9-08dcf4dbe417
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7269

To support multi-channel functionality with AE4DMA engine, extend the
PTDMA code with reusable components.

Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/dma/amd/ae4dma/ae4dma.h         |   2 +
 drivers/dma/amd/ptdma/ptdma-dmaengine.c | 105 +++++++++++++++++++-----
 drivers/dma/amd/ptdma/ptdma.h           |   2 +
 3 files changed, 89 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/amd/ae4dma/ae4dma.h b/drivers/dma/amd/ae4dma/ae4dma.h
index 4a1dfcf620c1..92cb8c379c18 100644
--- a/drivers/dma/amd/ae4dma/ae4dma.h
+++ b/drivers/dma/amd/ae4dma/ae4dma.h
@@ -34,6 +34,8 @@
 #define AE4_Q_BASE_H_OFF		0x1c
 #define AE4_Q_SZ			0x20
 
+#define AE4_DMA_VERSION			4
+
 struct ae4_msix {
 	int msix_count;
 	struct msix_entry msix_entry[MAX_AE4_HW_QUEUES];
diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
index 77fe709fb327..e2d4bc8aa1de 100644
--- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
+++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
@@ -93,7 +93,24 @@ static void pt_do_cleanup(struct virt_dma_desc *vd)
 	kmem_cache_free(pt->dma_desc_cache, desc);
 }
 
-static int pt_dma_start_desc(struct pt_dma_desc *desc)
+static struct pt_cmd_queue *pt_get_cmd_queue(struct pt_device *pt, struct pt_dma_chan *chan)
+{
+	struct ae4_cmd_queue *ae4cmd_q;
+	struct pt_cmd_queue *cmd_q;
+	struct ae4_device *ae4;
+
+	if (pt->ver == AE4_DMA_VERSION) {
+		ae4 = container_of(pt, struct ae4_device, pt);
+		ae4cmd_q = &ae4->ae4cmd_q[chan->id];
+		cmd_q = &ae4cmd_q->cmd_q;
+	} else {
+		cmd_q = &pt->cmd_q;
+	}
+
+	return cmd_q;
+}
+
+static int pt_dma_start_desc(struct pt_dma_desc *desc, struct pt_dma_chan *chan)
 {
 	struct pt_passthru_engine *pt_engine;
 	struct pt_device *pt;
@@ -104,7 +121,9 @@ static int pt_dma_start_desc(struct pt_dma_desc *desc)
 
 	pt_cmd = &desc->pt_cmd;
 	pt = pt_cmd->pt;
-	cmd_q = &pt->cmd_q;
+
+	cmd_q = pt_get_cmd_queue(pt, chan);
+
 	pt_engine = &pt_cmd->passthru;
 
 	pt->tdata.cmd = pt_cmd;
@@ -199,7 +218,7 @@ static void pt_cmd_callback(void *data, int err)
 		if (!desc)
 			break;
 
-		ret = pt_dma_start_desc(desc);
+		ret = pt_dma_start_desc(desc, chan);
 		if (!ret)
 			break;
 
@@ -234,7 +253,10 @@ static struct pt_dma_desc *pt_create_desc(struct dma_chan *dma_chan,
 {
 	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
 	struct pt_passthru_engine *pt_engine;
+	struct pt_device *pt = chan->pt;
+	struct ae4_cmd_queue *ae4cmd_q;
 	struct pt_dma_desc *desc;
+	struct ae4_device *ae4;
 	struct pt_cmd *pt_cmd;
 
 	desc = pt_alloc_dma_desc(chan, flags);
@@ -242,7 +264,7 @@ static struct pt_dma_desc *pt_create_desc(struct dma_chan *dma_chan,
 		return NULL;
 
 	pt_cmd = &desc->pt_cmd;
-	pt_cmd->pt = chan->pt;
+	pt_cmd->pt = pt;
 	pt_engine = &pt_cmd->passthru;
 	pt_cmd->engine = PT_ENGINE_PASSTHRU;
 	pt_engine->src_dma = src;
@@ -253,6 +275,14 @@ static struct pt_dma_desc *pt_create_desc(struct dma_chan *dma_chan,
 
 	desc->len = len;
 
+	if (pt->ver == AE4_DMA_VERSION) {
+		ae4 = container_of(pt, struct ae4_device, pt);
+		ae4cmd_q = &ae4->ae4cmd_q[chan->id];
+		mutex_lock(&ae4cmd_q->cmd_lock);
+		list_add_tail(&pt_cmd->entry, &ae4cmd_q->cmd);
+		mutex_unlock(&ae4cmd_q->cmd_lock);
+	}
+
 	return desc;
 }
 
@@ -310,8 +340,11 @@ static enum dma_status
 pt_tx_status(struct dma_chan *c, dma_cookie_t cookie,
 		struct dma_tx_state *txstate)
 {
-	struct pt_device *pt = to_pt_chan(c)->pt;
-	struct pt_cmd_queue *cmd_q = &pt->cmd_q;
+	struct pt_dma_chan *chan = to_pt_chan(c);
+	struct pt_device *pt = chan->pt;
+	struct pt_cmd_queue *cmd_q;
+
+	cmd_q = pt_get_cmd_queue(pt, chan);
 
 	pt_check_status_trans(pt, cmd_q);
 	return dma_cookie_status(c, cookie, txstate);
@@ -320,10 +353,13 @@ pt_tx_status(struct dma_chan *c, dma_cookie_t cookie,
 static int pt_pause(struct dma_chan *dma_chan)
 {
 	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
+	struct pt_device *pt = chan->pt;
+	struct pt_cmd_queue *cmd_q;
 	unsigned long flags;
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
-	pt_stop_queue(&chan->pt->cmd_q);
+	cmd_q = pt_get_cmd_queue(pt, chan);
+	pt_stop_queue(cmd_q);
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
 	return 0;
@@ -333,10 +369,13 @@ static int pt_resume(struct dma_chan *dma_chan)
 {
 	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
 	struct pt_dma_desc *desc = NULL;
+	struct pt_device *pt = chan->pt;
+	struct pt_cmd_queue *cmd_q;
 	unsigned long flags;
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
-	pt_start_queue(&chan->pt->cmd_q);
+	cmd_q = pt_get_cmd_queue(pt, chan);
+	pt_start_queue(cmd_q);
 	desc = pt_next_dma_desc(chan);
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
@@ -350,11 +389,17 @@ static int pt_resume(struct dma_chan *dma_chan)
 static int pt_terminate_all(struct dma_chan *dma_chan)
 {
 	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
+	struct pt_device *pt = chan->pt;
+	struct pt_cmd_queue *cmd_q;
 	unsigned long flags;
-	struct pt_cmd_queue *cmd_q = &chan->pt->cmd_q;
 	LIST_HEAD(head);
 
-	iowrite32(SUPPORTED_INTERRUPTS, cmd_q->reg_control + 0x0010);
+	cmd_q = pt_get_cmd_queue(pt, chan);
+	if (pt->ver == AE4_DMA_VERSION)
+		pt_stop_queue(cmd_q);
+	else
+		iowrite32(SUPPORTED_INTERRUPTS, cmd_q->reg_control + 0x0010);
+
 	spin_lock_irqsave(&chan->vc.lock, flags);
 	vchan_get_all_descriptors(&chan->vc, &head);
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
@@ -367,14 +412,24 @@ static int pt_terminate_all(struct dma_chan *dma_chan)
 
 int pt_dmaengine_register(struct pt_device *pt)
 {
-	struct pt_dma_chan *chan;
 	struct dma_device *dma_dev = &pt->dma_dev;
-	char *cmd_cache_name;
+	struct ae4_cmd_queue *ae4cmd_q = NULL;
+	struct ae4_device *ae4 = NULL;
+	struct pt_dma_chan *chan;
 	char *desc_cache_name;
-	int ret;
+	char *cmd_cache_name;
+	int ret, i;
+
+	if (pt->ver == AE4_DMA_VERSION)
+		ae4 = container_of(pt, struct ae4_device, pt);
+
+	if (ae4)
+		pt->pt_dma_chan = devm_kcalloc(pt->dev, ae4->cmd_q_count,
+					       sizeof(*pt->pt_dma_chan), GFP_KERNEL);
+	else
+		pt->pt_dma_chan = devm_kzalloc(pt->dev, sizeof(*pt->pt_dma_chan),
+					       GFP_KERNEL);
 
-	pt->pt_dma_chan = devm_kzalloc(pt->dev, sizeof(*pt->pt_dma_chan),
-				       GFP_KERNEL);
 	if (!pt->pt_dma_chan)
 		return -ENOMEM;
 
@@ -416,9 +471,6 @@ int pt_dmaengine_register(struct pt_device *pt)
 
 	INIT_LIST_HEAD(&dma_dev->channels);
 
-	chan = pt->pt_dma_chan;
-	chan->pt = pt;
-
 	/* Set base and prep routines */
 	dma_dev->device_free_chan_resources = pt_free_chan_resources;
 	dma_dev->device_prep_dma_memcpy = pt_prep_dma_memcpy;
@@ -430,8 +482,21 @@ int pt_dmaengine_register(struct pt_device *pt)
 	dma_dev->device_terminate_all = pt_terminate_all;
 	dma_dev->device_synchronize = pt_synchronize;
 
-	chan->vc.desc_free = pt_do_cleanup;
-	vchan_init(&chan->vc, dma_dev);
+	if (ae4) {
+		for (i = 0; i < ae4->cmd_q_count; i++) {
+			chan = pt->pt_dma_chan + i;
+			ae4cmd_q = &ae4->ae4cmd_q[i];
+			chan->id = ae4cmd_q->id;
+			chan->pt = pt;
+			chan->vc.desc_free = pt_do_cleanup;
+			vchan_init(&chan->vc, dma_dev);
+		}
+	} else {
+		chan = pt->pt_dma_chan;
+		chan->pt = pt;
+		chan->vc.desc_free = pt_do_cleanup;
+		vchan_init(&chan->vc, dma_dev);
+	}
 
 	ret = dma_async_device_register(dma_dev);
 	if (ret)
diff --git a/drivers/dma/amd/ptdma/ptdma.h b/drivers/dma/amd/ptdma/ptdma.h
index 7a8ca8e239e0..0a7939105e51 100644
--- a/drivers/dma/amd/ptdma/ptdma.h
+++ b/drivers/dma/amd/ptdma/ptdma.h
@@ -184,6 +184,7 @@ struct pt_dma_desc {
 struct pt_dma_chan {
 	struct virt_dma_chan vc;
 	struct pt_device *pt;
+	u32 id;
 };
 
 struct pt_cmd_queue {
@@ -262,6 +263,7 @@ struct pt_device {
 	unsigned long total_interrupts;
 
 	struct pt_tasklet_data tdata;
+	int ver;
 };
 
 /*
-- 
2.25.1


