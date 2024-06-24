Return-Path: <dmaengine+bounces-2520-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6479143FF
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2024 09:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1A801C21546
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2024 07:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025FD47F5F;
	Mon, 24 Jun 2024 07:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rMMq2e8N"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D47482DB
	for <dmaengine@vger.kernel.org>; Mon, 24 Jun 2024 07:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719215808; cv=fail; b=WBijPnBWIVs2Mn7gZF5ip5H4FlWVq2WEm4PFym+JcEQZ58CqEco7sTrsCkgXDBHYFF7ac0djjjwNQsaeiVnMlzT4zJE1R/VQmIaYCSnraQI3k5IHQdi8AH8k2UdSAcpYDQna2vw3FDUCAS8WmMxucMm5i39WQtzoBhNtSC+6y9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719215808; c=relaxed/simple;
	bh=VJJpdHEl6y41byAgiYESrmHq+ZdiNLIx1dq3gvaB4nw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tzXdp+jbjCBhlz8G9tyZynwEcMC72D+bORUvxOX9gw9S8ORXgNnSV/D+bGqNH14XnwKiy1m+oEbwoCKIMyNcyHrLO1BUXuEf/EHrC6tUmAYnU9eMHvoVm9qJxQrYS5d1O6IBk7bOqTy88a2xY9HXtOBdGB+28aF+7Eo8PAyjhJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rMMq2e8N; arc=fail smtp.client-ip=40.107.236.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+lwfMtA1Htbdf3K1vD2RHqCIiikew6wVCBfgzmMWALV+m12hJk+zCfy7olI6pmtT7NmQRWMwcawyZ2Xu6fdn+83kjcIB3hvrW56uZRn8h/Dcgext2dcntX7LfsplfbkBKPfwod57odUMknQlqo+GBJByY4AxElQeVb0aY5MqW1lw8cU+rIuzKrt27xKpYQBe6/e9ulCvgfF62mPKNPBXVHqNhjXOlAoRKcK05OHyEJtKhbP+TGJlOaaVgQm2rf06SLKyTQE6ZOR8aoXN1R0/CLWkbr6sWE2B5PUAPOzgcmmus7karx26XfvnpGKjkPx4oi7H0AbnFUV4WDM1YfrMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EASjL/NEmup4Ob9H2mzNBoJHKxGs80oH2hrlH4mi2z4=;
 b=Z/183dHvQIDFqYcA7QAEo3MhaIPytFGw/fYcqXQPy6WNgUmOvYYyaNAeCpP713+nEOXggoHWNdCPJZ5ozukJgBxwXLYvzPOJMWslQKTiRUZ5ean5L2qm1crde9Jh1ud9tELeN/JiJmTJsNBGptQEHLj4U8OW9iFlJtwIKtdN4BUJ+HO3FrgZDgFRFfzoVtRzfqSwgM0TSHVmS4yvvo8mLXkXnIPkhIXx8pErZvig/wsA6B/KGK2h58ORGGcQX8YBQvJoUHDds+I0NdtM+V15ddPDJx6XEuZ8z7CktNwLfUuIX4uFMyeY7cx6JZzSo890owxbPRJo3ry4ds3rkM8nTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EASjL/NEmup4Ob9H2mzNBoJHKxGs80oH2hrlH4mi2z4=;
 b=rMMq2e8N4rqm/tfGKyj9i0j/BRYX+DzHFft0Mq0Gft5lWhYxpcCtrNgXhwuFj1WrKdhB41r6OGkvf/Yza5GjhY36fICFPBqnAyGJb6sq3DIjDTHQxVEEUDqabA6mw2psTdnFgroWOok9mAg+AqTzjzXGIxcdzccZuY777EvvVYA=
Received: from CH0PR04CA0074.namprd04.prod.outlook.com (2603:10b6:610:74::19)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 07:56:40 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::9) by CH0PR04CA0074.outlook.office365.com
 (2603:10b6:610:74::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 07:56:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 07:56:40 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 02:56:37 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v3 4/7] dmaengine: ptdma: Extend ptdma to support multi-channel and version
Date: Mon, 24 Jun 2024 13:26:07 +0530
Message-ID: <20240624075610.1659502-5-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240624075610.1659502-1-Basavaraj.Natikar@amd.com>
References: <20240624075610.1659502-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|SA0PR12MB4415:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ba76b4a-c38a-4435-f4ee-08dc94232e81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|1800799021|82310400023|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rla5SG0fKs3TP6UogPpSIctMLg6OHNaaVeprnmjFuTlxb4+hczI9hm/StsFY?=
 =?us-ascii?Q?Fgm6CFG7imTQ7H16kwSoz2DicMh+0c13xJi8rZOV8rmKOLFZxlJVSA7e8Jf9?=
 =?us-ascii?Q?cs7hIzHhqIG+jWTycQT58Po9BUFEiavIAsVaKYttLV1nnf1kKhUx2J7GQ441?=
 =?us-ascii?Q?iQ6juyK2MdUoOAMCfXkI6LpviRyf0vFThn6+ahp0+tQ56EP8gwkB3efEGGD8?=
 =?us-ascii?Q?zZhtHtPDFmJ7J4sMz/8akUSU8Vurvh0Z82/KSxaSjXS/YjGpr+CBEBkew2Mv?=
 =?us-ascii?Q?1BlwTLbK3QEJ95CXLBFB7qA/JM2Q68n/o3Kv24JGO1Bov7i4+a4ljNsf6HOL?=
 =?us-ascii?Q?y8t+g+cv5KXgck9QGF4TJ9yDT+gGpb/ou6D92CWzAupEKRApGqCeww0m837V?=
 =?us-ascii?Q?Kx/Nc1em8ooFvO9n/qjMDa4ON15z/+cv5vsP/DHlM6wayVyBK9/Kvf+IuWkH?=
 =?us-ascii?Q?AGQvXj20cqvvWQvlWbuj+u3BFl6qk9OgmLE9Ca7BbVBFE/zd8Snm3bpbB1mV?=
 =?us-ascii?Q?3tNZBZiVBxgs+Z/VltvMcjckIrRlOdhfqRdhhI5ceHuZL1liIeN9IgcnZhSG?=
 =?us-ascii?Q?9+pXK/s93pXl4xNYbSdto/zd7yDCigweGc3mEkHNQ+8WyQoo7d1wq2wm0uB+?=
 =?us-ascii?Q?TTVF81ZuAhqnvZu8PATdcOAo57tY+gewm/4xeJnkqj/ZvvfMIwG80elRb6Wp?=
 =?us-ascii?Q?+3yoWSgP0HpVWxVbDfIh5XwvHXesp6YCRey8UrbJAJFkUk816qNqg4JasNEq?=
 =?us-ascii?Q?9aWkkx63t3ayob+0UuqcP6uDf/lMPjpJK93mUfSH7WKJA2JYE7c2ZywDiFA9?=
 =?us-ascii?Q?cVQa2FfRcTWckg3E/k9N166sALncHAmjlVMwpqE/DUK8zidjyput5ZHjlFsc?=
 =?us-ascii?Q?1pLAPERlDm1dXmczoHGZCxrwGuP/6oZM2QN6X9325XFU7GC/tvWqsG6aZQUt?=
 =?us-ascii?Q?oXU+wHA/d/1aS+vjAmq4ODjJpNFFpPjejE2M+P6dD4K6gMpMd6qSHX1EElcf?=
 =?us-ascii?Q?KBsFdvAMD4E+cxyj6vMJRnkyUsJEUQtPPaodgldV6LyoIBKBcOdqqKx7hakk?=
 =?us-ascii?Q?Wk+juUDuoWa4Yo7RZ9IkhIPECNhypIQphxvjhTNrjl/OEYYiFH2OfYlVc0gr?=
 =?us-ascii?Q?mC5I74Z3ou1aDFO7bdRfx+6r6+7Sv+c7coH+GxoRYdJOCyVTY0OrmiKrpadE?=
 =?us-ascii?Q?DGX/4wMRFb5rXZiNdkp8y6MhgmTpqLk1CjYs0xwB4AiVi+qY95kA6RAkLIYQ?=
 =?us-ascii?Q?cD+Ykn7A6McsXMZu0W2gjTpXsEYxNs0hTEuCXzKNszsXQWJFtBKD9MESC+hb?=
 =?us-ascii?Q?U+Azy1XaIKK++DEQihEfW1hUHIwLKZFOR5I2Qc4oRe187aQgZiQgSqzKvWku?=
 =?us-ascii?Q?7J785I0wIA5V+wwew3qSgREA6O9CtClYXyesRQIySnR5i29lEA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(1800799021)(82310400023)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 07:56:40.3865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba76b4a-c38a-4435-f4ee-08dc94232e81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415

To support multi-channel functionality with AE4DMA engine, extend the
PTDMA code with reusable components.

Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/dma/amd/ae4dma/ae4dma.h         |   1 +
 drivers/dma/amd/common/amd_dma.h        |   1 +
 drivers/dma/amd/ptdma/ptdma-dmaengine.c | 105 +++++++++++++++++++-----
 drivers/dma/amd/ptdma/ptdma.h           |   2 +
 4 files changed, 89 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/amd/ae4dma/ae4dma.h b/drivers/dma/amd/ae4dma/ae4dma.h
index 59a0ea3293cb..850ad1e49b51 100644
--- a/drivers/dma/amd/ae4dma/ae4dma.h
+++ b/drivers/dma/amd/ae4dma/ae4dma.h
@@ -15,6 +15,7 @@
 #define MAX_AE4_HW_QUEUES		16
 
 #define AE4_DESC_COMPLETED		0x3
+#define AE4_DMA_VERSION			4
 
 struct ae4_msix {
 	int msix_count;
diff --git a/drivers/dma/amd/common/amd_dma.h b/drivers/dma/amd/common/amd_dma.h
index 44251918f157..40f18fc912ae 100644
--- a/drivers/dma/amd/common/amd_dma.h
+++ b/drivers/dma/amd/common/amd_dma.h
@@ -21,6 +21,7 @@
 #include <linux/wait.h>
 
 #include "../ptdma/ptdma.h"
+#include "../ae4dma/ae4dma.h"
 #include "../../virt-dma.h"
 
 void pt_start_queue(struct pt_cmd_queue *cmd_q);
diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
index 66ea10499643..90ca02fd5f8f 100644
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
 
@@ -184,7 +203,10 @@ static struct pt_dma_desc *pt_create_desc(struct dma_chan *dma_chan,
 {
 	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
 	struct pt_passthru_engine *pt_engine;
+	struct pt_device *pt = chan->pt;
+	struct ae4_cmd_queue *ae4cmd_q;
 	struct pt_dma_desc *desc;
+	struct ae4_device *ae4;
 	struct pt_cmd *pt_cmd;
 
 	desc = pt_alloc_dma_desc(chan, flags);
@@ -192,7 +214,7 @@ static struct pt_dma_desc *pt_create_desc(struct dma_chan *dma_chan,
 		return NULL;
 
 	pt_cmd = &desc->pt_cmd;
-	pt_cmd->pt = chan->pt;
+	pt_cmd->pt = pt;
 	pt_engine = &pt_cmd->passthru;
 	pt_cmd->engine = PT_ENGINE_PASSTHRU;
 	pt_engine->src_dma = src;
@@ -203,6 +225,14 @@ static struct pt_dma_desc *pt_create_desc(struct dma_chan *dma_chan,
 
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
 
@@ -260,8 +290,11 @@ static enum dma_status
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
@@ -270,10 +303,13 @@ pt_tx_status(struct dma_chan *c, dma_cookie_t cookie,
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
@@ -283,10 +319,13 @@ static int pt_resume(struct dma_chan *dma_chan)
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
 
@@ -300,11 +339,17 @@ static int pt_resume(struct dma_chan *dma_chan)
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
@@ -317,14 +362,24 @@ static int pt_terminate_all(struct dma_chan *dma_chan)
 
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
 
@@ -366,9 +421,6 @@ int pt_dmaengine_register(struct pt_device *pt)
 
 	INIT_LIST_HEAD(&dma_dev->channels);
 
-	chan = pt->pt_dma_chan;
-	chan->pt = pt;
-
 	/* Set base and prep routines */
 	dma_dev->device_free_chan_resources = pt_free_chan_resources;
 	dma_dev->device_prep_dma_memcpy = pt_prep_dma_memcpy;
@@ -380,8 +432,21 @@ int pt_dmaengine_register(struct pt_device *pt)
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
index b4f9ee83b074..d9e4ff942901 100644
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


