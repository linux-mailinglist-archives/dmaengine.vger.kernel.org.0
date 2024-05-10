Return-Path: <dmaengine+bounces-2020-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EE48C1FA0
	for <lists+dmaengine@lfdr.de>; Fri, 10 May 2024 10:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692D81C216AA
	for <lists+dmaengine@lfdr.de>; Fri, 10 May 2024 08:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D37715ECFA;
	Fri, 10 May 2024 08:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vDtP8ppW"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD41B1FA4
	for <dmaengine@vger.kernel.org>; Fri, 10 May 2024 08:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715329307; cv=fail; b=EBUfZE52TkeJOJjXlDDIrXL8fK4x0Qsi16Q9uV6pobJFrC1/RVu8Foh6sNSaIjUSCYjQXw0PipgWFbBASnH+CWhC0XXS4DRoZXWKod7rVtzmYMKLkSE9IUmUzL7Dkati/aH3e7zKseFHbLDYYsA8TEPDfICZxuphuFfHYUtRf20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715329307; c=relaxed/simple;
	bh=+3D6efU6rtFgWf2q1XJjKtYbHIsLUjjsPWJ+TmNY73o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ncrQw6BS7QD4dX6iwXWaIJXinrNv8jR3+HtvsfG/Mgf5pOFj41f7jW4RMXBNF7Vf0VrZpFGBKZOBDaDijhUJ/nm9JQZjOgmkZlF6Yv4utpAcW5am5z9/nVoQMbhwzoSqL7kc5oYV0Uj7Ct0c5wxUglS+k4QYDTsMmvzrCY1SrJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vDtP8ppW; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWAZG/1SdBk9sK/Io93Nt/hYkWLrmFx3XKsti4JRS6XTq5Q8CXtIXdpCk5UfgpHJbCp6hntLcKHzH0BElrx0YO+Ob0ZcIokhpFqxwh9QsXYz8X7g2c0IFSj0eoMglQimoBP8iTgPUSAREkeNxXAAr/tEO1UdCCFa2t1yBD7x2RQg3fduH2CHCQx7UPCk40a7BQyXGpLTgcHj+5eDJsyftPmWzW3pv3S216fuVnx10wiDEfd09Xa9SkLrrQDNB8HSCzmk6LIBPAnxxHq8OfCmxXwECOmnqW9BYa2qm+KCpfWjdPTRjjblfz856vtJbzwecyt1sTgz+d08mQflS4GKHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYD7YNjUj0eA/AOhxdwk43EYTnZChhewtr3SKwSuPh8=;
 b=bAao0L/mLecUzQJqAJZZrgcZNJdPbNfiSIw1TbRJho8dJc4KeqYRHO+Dav7UCj8mXETmo7n7y18lzXrXKHedOZzNQhBQzE7r4HQbnGYGauBU1H1A6kgjYoAi5WJRLIQndnu6c6qWYXcZXRDHK7ei5F+9m1H7DMX09DeRXhwPfeIpT6yMd+uqQLcFcRXemwYIZOl4DCvblD3siM9jIqPmHw69uCiFAV/NhrjI/VMgNNMpMbl16US5TFFgR0GAiMncqpGw3o8q57NJogyllN3mZoFezZW6TeAHOiiwrQr28NptNweCNlN1d674DgL4yp7w5asicPvBAw2OqTpO71FK/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYD7YNjUj0eA/AOhxdwk43EYTnZChhewtr3SKwSuPh8=;
 b=vDtP8ppWiQsorx2VrWXVSnv823tgUYDwhS02ytCDzz3qiwH+eYUViU/Qe7//Uzton71zLQgP/VVUcKK6rmf/sFLEJZJe5EYdYB5SK6gYgLXo3Qgw8+1Ukalf2hxHVfdBv6QtUNFO4vRBNGFQIRkBAROcVaCEyockdM4NMXqsBqs=
Received: from DM6PR11CA0001.namprd11.prod.outlook.com (2603:10b6:5:190::14)
 by PH7PR12MB5782.namprd12.prod.outlook.com (2603:10b6:510:1d1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.51; Fri, 10 May
 2024 08:21:40 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:190:cafe::fb) by DM6PR11CA0001.outlook.office365.com
 (2603:10b6:5:190::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49 via Frontend
 Transport; Fri, 10 May 2024 08:21:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 10 May 2024 08:21:39 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 10 May
 2024 03:21:33 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH 4/7] dmaengine: ptdma: Extend ptdma to support multi-channel and version
Date: Fri, 10 May 2024 13:50:50 +0530
Message-ID: <20240510082053.875923-5-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240510082053.875923-1-Basavaraj.Natikar@amd.com>
References: <20240510082053.875923-1-Basavaraj.Natikar@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|PH7PR12MB5782:EE_
X-MS-Office365-Filtering-Correlation-Id: a90bf5fa-80d2-4e22-d156-08dc70ca3778
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xgl+tVidmAgHR+hTDWMIr9SH09xfvigplK48TuQrrfgZYoxo8jzOicbxf19t?=
 =?us-ascii?Q?MyjTceuW4pdaEBuj80jnUDDrj1WQwG52YvCdHkcLvi7EmntD9aT7ZqqAaIzm?=
 =?us-ascii?Q?k+M+DsZpU3Li+UqysubCZm6kjUaLR/QHo+zhgSnsy8w+8AxPpo5FDvwXeBp4?=
 =?us-ascii?Q?H0GFE5OwtMzXwfK2fwsyvrNHVGBhjUqthzPkPVFrOb0oUK5mk1g/sIBbxT0h?=
 =?us-ascii?Q?/qSx64o6OWijpawYE32fm2oL8rFZAvS6ksbgvZmFCmYfMrszrUkj3CBI6Zgi?=
 =?us-ascii?Q?ElEwXoX6MhpYP+tPPY3x3uInIOY73+//kO+jTETDxl28EaZmZDsTDszT3ur0?=
 =?us-ascii?Q?m3TUied86789VbB8r28a+CwwbJTRzgDyjPjP4DgbOk9HvljlY/Pz+700hMWL?=
 =?us-ascii?Q?iG1/eH7NbfdxEDohdixZaPZZccTjMagPzJguzPOWO5KeUn6ZzMSm3OW618Rp?=
 =?us-ascii?Q?ovRjq5oiNJY+ihs2F1Ye04KelX/ygte8MghvujH1LRN2Xo+gSNyff7qjtnIn?=
 =?us-ascii?Q?o4EHwurJonTEmGknq2vhN4SoZunoY/p3BR5nmAtqfS5Yv+zsIzFaAXXDbeUQ?=
 =?us-ascii?Q?xO1irD5n/ZVoPm1qfKWtWkqA5xVNk7xPBA79j3JrlNNJh4dqPrYvhxoIbzS2?=
 =?us-ascii?Q?rAMQnhY48eqO1fcZGTHOrCe8+692zkt1K+bdmt27PRonOwBrNJ+sii2JC6bf?=
 =?us-ascii?Q?a26ASX5tyG0AzlwdILERlQXnEd/54wb9ZoFVDsai/KhaV6ludqW2LScNP61C?=
 =?us-ascii?Q?6dYI/sQLchhUJQSMvjk+Z/8B+Uc0uwvuEM+bKIkJVVDy3XaSsfE0g9wbtmpd?=
 =?us-ascii?Q?misphypXPnkoGWXNmfD3ouOy/qNjUKRxH0cZVz31ouQMweIAp9ySfbMgk62J?=
 =?us-ascii?Q?INqgWvvdfmlAxdjbxuYAnPSaE9BZ9AIYeWcqxuUWIHT7xBrFwFGietQrzpKb?=
 =?us-ascii?Q?5oQML3kYiPRLLjnu7Kh8zXnpEz337dyBQXaHJ8AvIV7Iw8oCrg4wyTxQ2mYm?=
 =?us-ascii?Q?2gS5grzPckEe61sqILYouZVl/H1jDqS96KMf0Q8LX1TUrNou9MHjk4uqsbu2?=
 =?us-ascii?Q?mvbvyjBRahsPEalBNp5ARKAhKwnhwgkWoduZBi1NjZ2OlpX8SfTBNP3TPIVN?=
 =?us-ascii?Q?QRbV4IgIzH3X7qDY7jR+m0sUo4rPym5aVBULZMn5NoH+7cmTZSxvx+s+VVld?=
 =?us-ascii?Q?Asuc69pOw57qFVgX3R0uKl3G465wisg8AEbmbJ2Uv4jb6r+pCOotqekIgM9W?=
 =?us-ascii?Q?XCYDprpcu9Vt81LPFtD8MUBzgHZXjZW1U3G5LinUch2fFk3es+OM5o8I1u2h?=
 =?us-ascii?Q?revHOihVBKX2MLVBbZMPKrp0+ZJVLFSVwUCrB9FzhfOrjcEV8QONM6PR9KBZ?=
 =?us-ascii?Q?q49eQh8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 08:21:39.5356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a90bf5fa-80d2-4e22-d156-08dc70ca3778
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5782

To support multi-channel functionality with AE4DMA engine, extend the
PTDMA code with reusable components.

Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/dma/amd/ae4dma/ae4dma.h         |   1 +
 drivers/dma/amd/common/amd_dma.h        |   1 +
 drivers/dma/amd/ptdma/ptdma-dmaengine.c | 107 +++++++++++++++++++-----
 drivers/dma/amd/ptdma/ptdma.h           |   2 +
 4 files changed, 91 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/amd/ae4dma/ae4dma.h b/drivers/dma/amd/ae4dma/ae4dma.h
index 24b1253ad570..4e4584e152a1 100644
--- a/drivers/dma/amd/ae4dma/ae4dma.h
+++ b/drivers/dma/amd/ae4dma/ae4dma.h
@@ -15,6 +15,7 @@
 #define MAX_AE4_HW_QUEUES		16
 
 #define AE4_DESC_COMPLETED		0x3
+#define AE4_DMA_VERSION			4
 
 struct ae4_msix {
 	int msix_count;
diff --git a/drivers/dma/amd/common/amd_dma.h b/drivers/dma/amd/common/amd_dma.h
index c216a03b5161..316af6ba0692 100644
--- a/drivers/dma/amd/common/amd_dma.h
+++ b/drivers/dma/amd/common/amd_dma.h
@@ -21,6 +21,7 @@
 #include <linux/dmapool.h>
 
 #include "../ptdma/ptdma.h"
+#include "../ae4dma/ae4dma.h"
 #include "../../virt-dma.h"
 
 void pt_start_queue(struct pt_cmd_queue *cmd_q);
diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
index 66ea10499643..eab372cfcd17 100644
--- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
+++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
@@ -43,7 +43,24 @@ static void pt_do_cleanup(struct virt_dma_desc *vd)
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
@@ -54,7 +71,9 @@ static int pt_dma_start_desc(struct pt_dma_desc *desc)
 
 	pt_cmd = &desc->pt_cmd;
 	pt = pt_cmd->pt;
-	cmd_q = &pt->cmd_q;
+
+	cmd_q = pt_get_cmd_queue(pt, chan);
+
 	pt_engine = &pt_cmd->passthru;
 
 	pt->tdata.cmd = pt_cmd;
@@ -149,7 +168,7 @@ static void pt_cmd_callback(void *data, int err)
 		if (!desc)
 			break;
 
-		ret = pt_dma_start_desc(desc);
+		ret = pt_dma_start_desc(desc, chan);
 		if (!ret)
 			break;
 
@@ -184,7 +203,11 @@ static struct pt_dma_desc *pt_create_desc(struct dma_chan *dma_chan,
 {
 	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
 	struct pt_passthru_engine *pt_engine;
+	struct pt_device *pt = chan->pt;
+	struct ae4_cmd_queue *ae4cmd_q;
+	struct pt_cmd_queue *cmd_q;
 	struct pt_dma_desc *desc;
+	struct ae4_device *ae4;
 	struct pt_cmd *pt_cmd;
 
 	desc = pt_alloc_dma_desc(chan, flags);
@@ -192,7 +215,7 @@ static struct pt_dma_desc *pt_create_desc(struct dma_chan *dma_chan,
 		return NULL;
 
 	pt_cmd = &desc->pt_cmd;
-	pt_cmd->pt = chan->pt;
+	pt_cmd->pt = pt;
 	pt_engine = &pt_cmd->passthru;
 	pt_cmd->engine = PT_ENGINE_PASSTHRU;
 	pt_engine->src_dma = src;
@@ -203,6 +226,15 @@ static struct pt_dma_desc *pt_create_desc(struct dma_chan *dma_chan,
 
 	desc->len = len;
 
+	if (pt->ver == AE4_DMA_VERSION) {
+		ae4 = container_of(pt, struct ae4_device, pt);
+		ae4cmd_q = &ae4->ae4cmd_q[chan->id];
+		cmd_q = &ae4cmd_q->cmd_q;
+		mutex_lock(&ae4cmd_q->cmd_lock);
+		list_add_tail(&pt_cmd->entry, &ae4cmd_q->cmd);
+		mutex_unlock(&ae4cmd_q->cmd_lock);
+	}
+
 	return desc;
 }
 
@@ -260,8 +292,11 @@ static enum dma_status
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
@@ -270,10 +305,13 @@ pt_tx_status(struct dma_chan *c, dma_cookie_t cookie,
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
@@ -283,10 +321,13 @@ static int pt_resume(struct dma_chan *dma_chan)
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
 
@@ -300,11 +341,17 @@ static int pt_resume(struct dma_chan *dma_chan)
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
@@ -317,14 +364,24 @@ static int pt_terminate_all(struct dma_chan *dma_chan)
 
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
 
@@ -366,9 +423,6 @@ int pt_dmaengine_register(struct pt_device *pt)
 
 	INIT_LIST_HEAD(&dma_dev->channels);
 
-	chan = pt->pt_dma_chan;
-	chan->pt = pt;
-
 	/* Set base and prep routines */
 	dma_dev->device_free_chan_resources = pt_free_chan_resources;
 	dma_dev->device_prep_dma_memcpy = pt_prep_dma_memcpy;
@@ -380,8 +434,21 @@ int pt_dmaengine_register(struct pt_device *pt)
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
index b4f9ee83b074..3ef290b78448 100644
--- a/drivers/dma/amd/ptdma/ptdma.h
+++ b/drivers/dma/amd/ptdma/ptdma.h
@@ -184,6 +184,7 @@ struct pt_dma_desc {
 struct pt_dma_chan {
 	struct virt_dma_chan vc;
 	struct pt_device *pt;
+	unsigned int id;
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


