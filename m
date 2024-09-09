Return-Path: <dmaengine+bounces-3119-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C2D9719A8
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 14:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99A5A1F23224
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 12:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FBF1B78F3;
	Mon,  9 Sep 2024 12:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BUXjW5ab"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2067.outbound.protection.outlook.com [40.107.212.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB5A1B5804
	for <dmaengine@vger.kernel.org>; Mon,  9 Sep 2024 12:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725885619; cv=fail; b=aR5KqxkbTK+dXaFmwNNFM1JD7HjOutID7n61oIhkCQ17OhpT8/REKy0pmdrxfnVvoF08b+N5w+wlyQGASwwD3E1CVm1EreU6ScTPa5eA+YHrH1Xt/EsA8xy3UcUHOzJl7VA8TeRtkf5wrmCAdNPnZEx6RfbA7G1mNo2VtWHXNQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725885619; c=relaxed/simple;
	bh=Upi61HZJcxlSSCV4HoFjq+bWFXe2mLtAIPPwnjobKqY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N9YIVazDBGrZ3bJQO9dlIpa7Yy8FhHEtjLJ6U5eUUccf/d8ETy0miI5l8qRFX5ocuDxESJuUEVrMcm8tx8hdo+Z+7miEmaaJVeZ87G3t9QZZojAVnQrsxFxb0dXZ4SsONrdqL6G6f/njV4WXoC7GnLwwe6JDMVISWhlLyLOAb1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BUXjW5ab; arc=fail smtp.client-ip=40.107.212.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/TIsOpIY/ErBbeP5SOjJum5WZhRvVYReS+xpz0j9rOyf1EfSafqsIaSfKJ1ZEnBL2PDweDgO0kCyYraGh4VPrbDHrf+nA+Ir1QQNrNxfF+5fy9RBTkzkUYXN8lk9MT6CO+q87mPs6Cxjtd5x+GxMy+0yc4CkwvPRMqrtXPXeU6sIGTZpxXEtSdmZ2WYBZB1Y/GxYDyCMCgJMeuqI4qAr7eV2qVYdLBjV/Lg5S33QYTnRuyIIE3AfQY/RfVWM1xbqQmsUCBBfu4j7b19OXJjqwZMnew5X4y+QFRBVTbtqGxxm8+OW/rinRGNUDje7JCaGQ7/KSeGI7HwnKMMoFoEbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8i/6XISlMa2nVCpCDHZlFS30R9esYuBmLRvgOmbzPd4=;
 b=hbLjd9FryivjzMlw3APE1rktVDDAcbt9zRb2/5xtb79ttyLjL78Je3O75GnV5K6O8/aDXbflRXi9Ft3O8O4U7EjjU3ABtT1lt19Go3j4CjEQvQG1mArG/W1lfuVnKZg1Ys3UwGvspmWMvWUG0vJUR3NYkuclNTlLSQ/8Jn5n4CLA7l4+3MvVaaohg8NPIv1HwWCEvABRzY+s81ZvapkaBAOl0oKTDFTSBJ1HlqY2CLdZaGRgO3FHqWKx2fjMNquUXa0OjqcSpkTVhJGS4QGGy2mkiZf7rePeyiSrCLMUnaVk+cwJEjBVzQejIuwuil4E169yXZqNQRHPRsG40BvZWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8i/6XISlMa2nVCpCDHZlFS30R9esYuBmLRvgOmbzPd4=;
 b=BUXjW5abFwVG6vlSHpYyu80QE1qQiV9GKdpU4uFt0D4D2Xj3j7/Bog6/NcAD0rTZ/45eH0zxUIipqFMi9EZHhO8YIt/q/av7PFy6l3MJHwDd2SdBBK8JwkFrvIJUZiGMHz7XCec7o+R59FxE/99xM1zFNC7eaCVCfsjxhivmWR8=
Received: from MW4PR03CA0071.namprd03.prod.outlook.com (2603:10b6:303:b6::16)
 by MN0PR12MB6079.namprd12.prod.outlook.com (2603:10b6:208:3c9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 9 Sep
 2024 12:40:10 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:303:b6:cafe::1a) by MW4PR03CA0071.outlook.office365.com
 (2603:10b6:303:b6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Mon, 9 Sep 2024 12:40:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 12:40:10 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 07:40:06 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v6 3/6] dmaengine: ptdma: Extend ptdma to support multi-channel and version
Date: Mon, 9 Sep 2024 18:09:38 +0530
Message-ID: <20240909123941.794563-4-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240909123941.794563-1-Basavaraj.Natikar@amd.com>
References: <20240909123941.794563-1-Basavaraj.Natikar@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|MN0PR12MB6079:EE_
X-MS-Office365-Filtering-Correlation-Id: bb9f160b-915b-400d-2001-08dcd0cc8b0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G9S9iRBpXS8uVBNgn8XOSw6hUF2AaADB0TWBolwsctlMgN2HhVtstDmLr4fw?=
 =?us-ascii?Q?fLhsB2OTg0a8bYg24FmR7g/rCJa2Z3jg8EpAaHrmg7XjDnq0BlKAcGQL6ACX?=
 =?us-ascii?Q?QZ9TQjxO9Uo30rsDn14Tz/EoaaEOk0w8t8+JCPuzclJA7bRBEuINHdzrZgiC?=
 =?us-ascii?Q?VN4QKywATDpgdB+MaPanDbIYbdwKxUVMR4gmp1lO8LWYBHMHk/ebo71t76JZ?=
 =?us-ascii?Q?gBRSIkds1EgxGozBRVKLI26EL4DfKCGiaABjxHYrXN4BRAb5mVsU+QiMzr0j?=
 =?us-ascii?Q?XPWc63F3PU2Ex4+/wDatHnmcigcknmRUuExyL7GCoBCphw2kQif6KBWVQMfa?=
 =?us-ascii?Q?al6izRC51ayIQKT5y2nmN7BWHZDvP64lcHc7Lcsk4EFcNlmoLqwDtaTpf8NL?=
 =?us-ascii?Q?OrhDAcoByrINm6qiD0BVdgclIO4BePeHBw/WEpBRQzQpD/ITUaOR7grLc9KX?=
 =?us-ascii?Q?fverzGKtF+vnDAJ7DtrQx99fKgQiFkNvVHxz5FrAwJrgORS3dRSBhd2HgLoF?=
 =?us-ascii?Q?Arljp3voNB7h+pfmlVvXDou7m/DxJmcgdfxNlhGiDhEoFm8N8qpTbFjckg9G?=
 =?us-ascii?Q?DxaxPE13bXVA4hX8ZrOaQ2lVdSct36s4/ElOcXQ7BdYhf9IK5PdB3WuO337C?=
 =?us-ascii?Q?ETIy05fJQYD1p94J8FAdomoObL0WuyJZhkDHAALVhNY3kE5mS6uNB7Uok1xU?=
 =?us-ascii?Q?2OxV3Mb6oDx1JUY7oDUz0CvLL2EnIt7dsmKw+3XuPoUhsGut9f3TIAxsiyJt?=
 =?us-ascii?Q?XvWxo8tYYHFYUHHSrhdtDE8zTMhEzLa15mfvKk+DtkkqiLVTBAUQhTdd00rl?=
 =?us-ascii?Q?T4Qdgl3ydNPNsvW6UHxn4gg42W7HLMpLzP/OQW0al7qEy3CgZ5IVFr51BnVe?=
 =?us-ascii?Q?DDs0QEagdJDd7SvUENN3y5mwebzOUiWDaRgd7ia10Ry9qMRnaGjIyoPnXoCa?=
 =?us-ascii?Q?rphhcxkYu6H3cYwgzu0+X9lUBrnqeB9utTCKtpKVeMdgX+fFqkCdHJk9YKIT?=
 =?us-ascii?Q?Joy/qRDqYnEiRCYVGVuQFYGzkZM3h1kvvyHNxxuannh824I7vVNBTwPSSN1E?=
 =?us-ascii?Q?JE4BzCn67chs6fo1SzxP5pfM9f0WgD4jTJ12pzZiSq9buRcQHIPjcCdnGBSg?=
 =?us-ascii?Q?r5qXt+Vw2w6qzPJ63s57Uo+tAmG4GsJnKE9HZ98rIkwD5eQhfqmlFB78FmUn?=
 =?us-ascii?Q?yL/EWXtFffaF4NV8ne2CUY6Cq8MH8YVoUGGj/PWCnhtYjbTRF+frGPtx0ySE?=
 =?us-ascii?Q?iXhwXFRObLI9MFrqE1OxGm1nCoG7su1viQz3NoXFWveUfKiKFDsUP0CVnMOV?=
 =?us-ascii?Q?NMHLELZe3D5rBoTM5/da0l4KbjKzVsq0AHWagJQw0Faht5/LwZhYoMhyXdHx?=
 =?us-ascii?Q?TClpRH5EGE4of7N+bxVGBIAsU6YrwJErfQGgY3/5ixA9q3eG56xodoM4YdKi?=
 =?us-ascii?Q?M5p8eJvfikQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 12:40:10.3498
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb9f160b-915b-400d-2001-08dcd0cc8b0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6079

To support multi-channel functionality with AE4DMA engine, extend the
PTDMA code with reusable components.

Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/dma/amd/ae4dma/ae4dma.h         |   2 +
 drivers/dma/amd/ptdma/ptdma-dmaengine.c | 106 +++++++++++++++++++-----
 drivers/dma/amd/ptdma/ptdma.h           |   2 +
 3 files changed, 90 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/amd/ae4dma/ae4dma.h b/drivers/dma/amd/ae4dma/ae4dma.h
index 2a8eddc77f93..666bc76735cf 100644
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
index a2e7c2cec15e..3f1dc858a914 100644
--- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
+++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
@@ -10,6 +10,7 @@
  */
 
 #include "ptdma.h"
+#include "../ae4dma/ae4dma.h"
 #include "../../dmaengine.h"
 
 static inline struct pt_dma_chan *to_pt_chan(struct dma_chan *dma_chan)
@@ -44,7 +45,24 @@ static void pt_do_cleanup(struct virt_dma_desc *vd)
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
@@ -55,7 +73,9 @@ static int pt_dma_start_desc(struct pt_dma_desc *desc)
 
 	pt_cmd = &desc->pt_cmd;
 	pt = pt_cmd->pt;
-	cmd_q = &pt->cmd_q;
+
+	cmd_q = pt_get_cmd_queue(pt, chan);
+
 	pt_engine = &pt_cmd->passthru;
 
 	pt->tdata.cmd = pt_cmd;
@@ -150,7 +170,7 @@ static void pt_cmd_callback(void *data, int err)
 		if (!desc)
 			break;
 
-		ret = pt_dma_start_desc(desc);
+		ret = pt_dma_start_desc(desc, chan);
 		if (!ret)
 			break;
 
@@ -185,7 +205,10 @@ static struct pt_dma_desc *pt_create_desc(struct dma_chan *dma_chan,
 {
 	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
 	struct pt_passthru_engine *pt_engine;
+	struct pt_device *pt = chan->pt;
+	struct ae4_cmd_queue *ae4cmd_q;
 	struct pt_dma_desc *desc;
+	struct ae4_device *ae4;
 	struct pt_cmd *pt_cmd;
 
 	desc = pt_alloc_dma_desc(chan, flags);
@@ -193,7 +216,7 @@ static struct pt_dma_desc *pt_create_desc(struct dma_chan *dma_chan,
 		return NULL;
 
 	pt_cmd = &desc->pt_cmd;
-	pt_cmd->pt = chan->pt;
+	pt_cmd->pt = pt;
 	pt_engine = &pt_cmd->passthru;
 	pt_cmd->engine = PT_ENGINE_PASSTHRU;
 	pt_engine->src_dma = src;
@@ -204,6 +227,14 @@ static struct pt_dma_desc *pt_create_desc(struct dma_chan *dma_chan,
 
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
 
@@ -261,8 +292,11 @@ static enum dma_status
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
@@ -271,10 +305,13 @@ pt_tx_status(struct dma_chan *c, dma_cookie_t cookie,
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
@@ -284,10 +321,13 @@ static int pt_resume(struct dma_chan *dma_chan)
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
 
@@ -301,11 +341,17 @@ static int pt_resume(struct dma_chan *dma_chan)
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
@@ -318,14 +364,24 @@ static int pt_terminate_all(struct dma_chan *dma_chan)
 
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
 
@@ -367,9 +423,6 @@ int pt_dmaengine_register(struct pt_device *pt)
 
 	INIT_LIST_HEAD(&dma_dev->channels);
 
-	chan = pt->pt_dma_chan;
-	chan->pt = pt;
-
 	/* Set base and prep routines */
 	dma_dev->device_free_chan_resources = pt_free_chan_resources;
 	dma_dev->device_prep_dma_memcpy = pt_prep_dma_memcpy;
@@ -381,8 +434,21 @@ int pt_dmaengine_register(struct pt_device *pt)
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
index 2690a32fc7cb..a6990021fe2b 100644
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


