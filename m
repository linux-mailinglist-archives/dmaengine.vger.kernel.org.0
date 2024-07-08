Return-Path: <dmaengine+bounces-2654-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 549DE92A4FE
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jul 2024 16:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DCBAB2301D
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jul 2024 14:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DC6137937;
	Mon,  8 Jul 2024 14:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gimn0Vvz"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154FD13C674
	for <dmaengine@vger.kernel.org>; Mon,  8 Jul 2024 14:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720449936; cv=fail; b=R88Xv6zz2K6RS5Tfk1xpHH7j0TIkWmORK829fJhp8vg1CFnRAKRJDUe5CxOLUbi73DuUpLD9kSxleGevoFmqc99TiwRFxqcwEkCLS9JSWNfHA9D41tIIIPn0f1JXaV2wf9BRJlTMeFYSY7qNyoJ30nCHbj4pjEZqbwOoA5Pv07g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720449936; c=relaxed/simple;
	bh=3Yiys6c6UTRKJ6Qn0UYlOh1GK25pBSEoMkz6CYfNXCQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dd2xXZtPPWnh2vd074GjB0fKW6TZ0kIg0n6hEw59xPSyehQcjFhFSu8qB6+d8Jr2Z6alI93DMF+9CHw1q3CTtRCRu6YveGWmk9hIxBxAFGJ1K+rCdk0G/m2rAjVL5TOnja6yezekMFDr0j3glZpJ3/9YQhFsagZRGqf2j2Aqits=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gimn0Vvz; arc=fail smtp.client-ip=40.107.100.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYKbuJXWxTIVhMbkkR6IWVoSnKW6QrCoESe97quEfLS9ngNm9yLjc3wunTIknnUkdAyUhTbNlMDh3PWoPZttJMkhUwdX6vQQy29tLHhKKHStCAetEOTrm3HXal3ynEVHsfPTw9CgjphGR28ThfWhEi9W/o64Rv/lMMbE9OlU4pmdj9JvnZ/ojs8V4xUGJwn3tKdWs8iapLXjPPU5qdbGY0crE2tJz8oq+F8zchcvcg4kz6ZeZ8C0TlBqMlGTKIuyUFHmd6yqf/jVk/aOR1xAWPMs9peRMl1aJepiI55DTP84328MG0wzbUpPTwlGj98QGk2Ezmgx/I3o+ijhcat69A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fQcifImxxKNsH2AznDmTVwomeKfKNo3yo9Pev1GlQo=;
 b=jygCBQnXwpuHoOj93LX7RyxNp1HW8LXXSgGnb0ZpcgstopwdCyuxOKHuK74KMMO1wJ9BLMwNODEqj6gDSIzCihDUq1W4DYwPVq9TDG/vliKzXlpIHVzItSXE3eG5zWF2rfCJuJp98JgZ6pGukAeR/KhwgA6Wmlqg/J+eGW/tF+r1GzMr8VqJVdEJHGkLAnF4bD/BSKUme4wLXJ9FPPcl/aaj7SB/CFplpQjypv6SrzxIufH0x1i41czPdlr+DayPHHzKQTn0KSP5il2qEhOqDKqkm41kJrPNhtqjhzsibLENUpPMfjChzxpgljqQh8XXfsmXWxZI5FcH+UrBkqPRtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fQcifImxxKNsH2AznDmTVwomeKfKNo3yo9Pev1GlQo=;
 b=gimn0VvzzM6CFS6W63X1sKSlZsapNIMLwNbiKo0aNHvstQUYAGiq4qzNwgotjBCFhTN6XEuSRUlHJXB1ermQT20/yNHSGs2Z7K4VS99NSeMUvdgmLfpfQ2k5lJ7uWSlz0944PHpiKuvBbSi1dgv8i7iAi39/EODnCVQzvf9yxvU=
Received: from BLAPR03CA0147.namprd03.prod.outlook.com (2603:10b6:208:32e::32)
 by SA1PR12MB6945.namprd12.prod.outlook.com (2603:10b6:806:24c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 14:45:29 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::36) by BLAPR03CA0147.outlook.office365.com
 (2603:10b6:208:32e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Mon, 8 Jul 2024 14:45:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 14:45:29 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Jul
 2024 09:45:26 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v5 4/7] dmaengine: ptdma: Extend ptdma to support multi-channel and version
Date: Mon, 8 Jul 2024 20:14:57 +0530
Message-ID: <20240708144500.1523651-5-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240708144500.1523651-1-Basavaraj.Natikar@amd.com>
References: <20240708144500.1523651-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|SA1PR12MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: cd532798-5896-4c98-974a-08dc9f5c9cec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xqarb4E+tC1YyiBS8f82mOAIAYgmnGLJEeu0um2YpKuxuHivRTKgkr7R4quy?=
 =?us-ascii?Q?uApBuZo9zusQ5LVQSvWj9XRlCNtQT1fOfKePS4hXZzRC9spqohJm7jAVI4ST?=
 =?us-ascii?Q?TwHtVL7hTtpJNIvh2/wE2KTDhSG4YjHrQpfbnidPGuwidct14K20tySp0zgw?=
 =?us-ascii?Q?4HWDC4czZAFumVpBNhZ8x8qohdNwa13fvXBCFe5dLZAd0gDSTl1+AmIi7LSp?=
 =?us-ascii?Q?W0lgVGkYSupBFY5CSRueJKeCkhKQELkA82zmNB5NmmhDY2DE0Xth6DaS/oPb?=
 =?us-ascii?Q?geL4760Ed9dv9ccwX3myumutR5opqz+tofrRAbqhAGui7QE7SP5u2KkUUYs9?=
 =?us-ascii?Q?IAFy+6hNKgYF9S2t9ZMrgGvJm23sl7sOFlr7iQ5fecApR2eNluo2S2lxwnR8?=
 =?us-ascii?Q?bmOg9W1HFUqhyZJylbeDAFi9q3/8MdS0adMp5kywaDEsxL0UAsgy0XZVq8Ih?=
 =?us-ascii?Q?Samtghb8Sgcj0HYyDolLlvwVrBsc1Z/K9PPbxpNptvX7fQ7EYCOLmF+SUApL?=
 =?us-ascii?Q?Za0NLPJV+g0NaN2OwbNUQ/B8N4Lk6DZ9zRJZ0aWA/GrZX31gOMMbXMkwBfRT?=
 =?us-ascii?Q?Ne4F0bO8Fngp8Fg1mu6iOBg7GfDTWnxx2zC9ljrpIv5nDCOaQpgsX4jsLA7B?=
 =?us-ascii?Q?xPkJLnpuFRW6Uy5seZ/bwH5OkpHGdqw5cQwS0A2yxWQgaLqiThVIlROOQzg0?=
 =?us-ascii?Q?NIlJVTxZgGK89h5ZVBGFDRCrUOXRGkjCaW6ZdTeimND1urdn8Sv3XpdQCrsM?=
 =?us-ascii?Q?m7Ih97HfXgzsg53cjRFfY3gbyPxHcTepvZQRKTXB0y5r31NLdR3oA6dCZUTB?=
 =?us-ascii?Q?vmW5gyuEEnOZDZF8P1Sud8KH3UA8rE1p+f5emKnO/2eMD/cbcr6QZD1Lr1ju?=
 =?us-ascii?Q?ORMiw5sMejno+6lg2n3JkHZ819L70R8UGRDbhBXF3oZmbbWvAlufBj/r8OxI?=
 =?us-ascii?Q?NPtlsorrIgSEXPz4xh/xoFJxCBqtAaw7UZtq4QLG31iNGz+SZDPWM49EUmdF?=
 =?us-ascii?Q?Go8Cz5m0CD7qs7vR36NwL+1cBNUe41d1Xi2rUQnSwvn4FBcZyqj6zd5diXAb?=
 =?us-ascii?Q?7pzJfetVBE3LYJpxl9hBc9hbcjQFFyyWY1i1JkJlDXbn6zhFyA0jxyriI9xy?=
 =?us-ascii?Q?74GlKlX7bqER220EqklBiPWvmuHyJLG14G5cqt+ATxiE0wEkAIt/3bbdZAfH?=
 =?us-ascii?Q?rEtzGSHX8Ppl1iuzz719bItM7/AJFUL9m/AdSPSsW3OIeOQN8EkL4YIY3ZpZ?=
 =?us-ascii?Q?7Xi0uRfzmNlAY5QczvNETyzTlusliwUEntZ8SOPU8j4M76P7Vcnc7xTgYaEA?=
 =?us-ascii?Q?wBw9+aaikiAEn3iv543qguDPi2m7cWOPvKoKoG6kFIyKRC3F7mb25J7DCgA3?=
 =?us-ascii?Q?ws5nK1ZA0dmvP+G9VHqgcGkP/Wot7GzYpDVFLLL1OFcmCYC8nExOjnxABJTy?=
 =?us-ascii?Q?NsMq3QeYQac=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 14:45:29.6451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd532798-5896-4c98-974a-08dc9f5c9cec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6945

To support multi-channel functionality with AE4DMA engine, extend the
PTDMA code with reusable components.

Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/dma/amd/ae4dma/ae4dma.h         |   2 +
 drivers/dma/amd/common/amd_dma.h        |   1 +
 drivers/dma/amd/ptdma/ptdma-dmaengine.c | 105 +++++++++++++++++++-----
 drivers/dma/amd/ptdma/ptdma.h           |   2 +
 4 files changed, 90 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/amd/ae4dma/ae4dma.h b/drivers/dma/amd/ae4dma/ae4dma.h
index a63525792080..5f9dab5f05f4 100644
--- a/drivers/dma/amd/ae4dma/ae4dma.h
+++ b/drivers/dma/amd/ae4dma/ae4dma.h
@@ -24,6 +24,8 @@
 #define AE4_Q_BASE_H_OFF		0x1C
 #define AE4_Q_SZ			0x20
 
+#define AE4_DMA_VERSION			4
+
 struct ae4_msix {
 	int msix_count;
 	struct msix_entry msix_entry[MAX_AE4_HW_QUEUES];
diff --git a/drivers/dma/amd/common/amd_dma.h b/drivers/dma/amd/common/amd_dma.h
index f9f396cd4371..396667e81e1a 100644
--- a/drivers/dma/amd/common/amd_dma.h
+++ b/drivers/dma/amd/common/amd_dma.h
@@ -21,6 +21,7 @@
 #include <linux/wait.h>
 
 #include "../ptdma/ptdma.h"
+#include "../ae4dma/ae4dma.h"
 #include "../../virt-dma.h"
 
 #endif
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


