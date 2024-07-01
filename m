Return-Path: <dmaengine+bounces-2610-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2A691E59C
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jul 2024 18:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB80285730
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jul 2024 16:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B829816DC24;
	Mon,  1 Jul 2024 16:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t9UTjz9w"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F033D16D9DF
	for <dmaengine@vger.kernel.org>; Mon,  1 Jul 2024 16:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852191; cv=fail; b=Ab90m/MbZb8LtjiodgN0xz68iQp5FGydBYsLxE+96hPSpjMTePhIGjoTAgKL/wZXHYklVtwuYdg8wNVPUx4FIxc+LVM4HCsPg2k22SwxWlVCWDNxspbaB01zuMIKi6pWSn89En2SZNZZC6l0+lX+9KJS7ZJJ8KsFCvZ2uhSyCqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852191; c=relaxed/simple;
	bh=JQAu7eqhXnjzxhQzyOhqOfX5IHAFHsv5X1prBhtKzEo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W2YF5rUZHkjVg2SVjrJe/St6xw/yh6AbILI1kp+6HZjavLytPykojjKmJ+cAlJNAWq9jzEa7rP6ZENTUV7CTDsDGeXjaZFB0xo9S6gL3Qd27EOh0zo5eeubf/ZAXZi6RGqnMeuMiVr4nyz781gZVU8hWK/7FWc/T6rJDVOrI5W4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t9UTjz9w; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMzZ08FlR65eaeY4IbyC17wM0KVDZ6vyvFzgPU8vl307wtcON5kfZMIiazcXruH/ygg56YbNe0F4eHnKVlUAGzksyAf+vAVfm7lNOn9TYj8UiPtskMjAkrFGQ1nI+YB1iRVnaMUU7bWToUnOF00WrtwEm7kYboinUQO655dkBPQ7KNxnJbiJ2+VztFcjs/AyFXDRJERWfZZoCA6nIjyr+uAOReOPicdVxpk5AEv7dRz+Bl50lfSZvoHFmdCRYmOU/ZlrhgK8sQ6GJyKPcoorR7SJd3cFg3Rr8Qx9M8KhcXF2+MDyN7h0jtkuZyRcUAuw+B16IDqsATQsi/jtCdwMvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bq0eNhIEhQPuhzlsB6Y/lodnDkn8A63gKTNJ86G5msA=;
 b=U8zqK9+yBTvr5pf4f11CQXhxC2X3J5XYNe8DhYIk0CLrk9Tb5e+DcGS5S5IA3NyQWMtT1Tch7g8D7x63yPWQaA5V6s8We5DzjSFBvbtGObPe248teSNglEv5uFkxmVKAH2gHd2ulWmYpnOp4lC/Mwj2ZHAWswBE0sTnYcjEvevX4A5AyJfAK/W5hSagQhyLUvkeVzYN6Fa13VdTJOJoSioljitQo7oYHDR2bTzO2LAmPYOF89MlCg/AvhRhvx64WFrDJTsr0ArAYLz+VdzjLa+d7KNUvgXljSU8ZSnQovNiGzRVVoV8+E9KmXSAM1vEHejtje+4BnvjQgW5BKAlVJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bq0eNhIEhQPuhzlsB6Y/lodnDkn8A63gKTNJ86G5msA=;
 b=t9UTjz9wQKUo7KhfPT2cwRLUrJax8nS6zCM+qOk/QyYm8hqz8bPdXuz7QjoN3APRlu6V+yOJIt1lEuIecp4HcPoDh0+fcOOeLn2yz7DOK99w6NgZTxpKszZ7YMGAfNKTJ0z4TdBpjtYBgFR3IE0XH9IQquhVwjNk15/M6iVaHyA=
Received: from SJ0PR03CA0060.namprd03.prod.outlook.com (2603:10b6:a03:33e::35)
 by DM6PR12MB4466.namprd12.prod.outlook.com (2603:10b6:5:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 16:43:07 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::d9) by SJ0PR03CA0060.outlook.office365.com
 (2603:10b6:a03:33e::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33 via Frontend
 Transport; Mon, 1 Jul 2024 16:43:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Mon, 1 Jul 2024 16:43:07 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Jul
 2024 11:43:02 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v4 4/7] dmaengine: ptdma: Extend ptdma to support multi-channel and version
Date: Mon, 1 Jul 2024 22:12:30 +0530
Message-ID: <20240701164233.2563221-5-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240701164233.2563221-1-Basavaraj.Natikar@amd.com>
References: <20240701164233.2563221-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|DM6PR12MB4466:EE_
X-MS-Office365-Filtering-Correlation-Id: 273951fa-ca8e-45f6-3b1d-08dc99ece288
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UxFkQwxQACFtDgy+uOoBiiUnbz/TQtsrKsEt5PGb9sNSwVg+a+jiGI1pIvrE?=
 =?us-ascii?Q?kaOysDbL0JPl+Gb0mSvAWABD79w1+KRlGoqXJ1XdUM3b6xY25J8BmZIqJcfY?=
 =?us-ascii?Q?FoIsYMFtA/2BgImUj3o84omyDGizgYuoeqGaBWQlDJEuAN44NFTWWfRMIT9m?=
 =?us-ascii?Q?Nq5Z0vwwxg8aK05WgGbVThfoSSn4meO2qpbd27cSJylNwrCorHPurXMYVPFM?=
 =?us-ascii?Q?QxtN/yzmKd9pKMuTJd0raYEi8CRMX8oIzgfhxsM9bkzdCwPiDyUr3nJgdHxi?=
 =?us-ascii?Q?WDkYRusC8oMG9P/3Lm6ALrYZjZu/lSOG4d/rmFR9kmxbEFCXcpUMEAqSxrAy?=
 =?us-ascii?Q?9+vBvCVafdoTi2dnGuBfCDELtV9yXkx9W7nFMjsHaINcAgg0C7agVawB+qBO?=
 =?us-ascii?Q?iCrnW7w/x58OCinKkVXsj58yw+DC+NxeJteVneorrywMHzPc1BsIbj6n0h0w?=
 =?us-ascii?Q?5zzabbHt00A90PxwkQVsWLQJ568fPnAZccjGun20+ME7SIuBcCeh9YWQWZzD?=
 =?us-ascii?Q?i9Wzfk1bXFxBd4DkJl2WUpA2naALKQzL+FEG324S+ejvHnZYbzHN0RkjKDF+?=
 =?us-ascii?Q?5ZxY+K2ls+Ga7Ku6UatZORzUoPssgvGvLDCMlidFOHE+NRcCoO3P/hhQS7UT?=
 =?us-ascii?Q?PARz6QTYxDzs2ghBl1X3UAITdR0diMlfSN8+3pJ5/3l0YQMiNCVanBg8yL2p?=
 =?us-ascii?Q?pG2b3UTtmG0+JbipujMowzAs/yIEKCXkdzb02/wosSCPo66aYNs4K0cgvatN?=
 =?us-ascii?Q?G2KGkz4jceFFKC22t5IFuenW8i5+HCHF8JwXEEytHYfkhM+Hhb0ZhD2yLYf4?=
 =?us-ascii?Q?2iGMz5u3rH6qcymGhZhG5SqkBEIAduoDBPoMgc0JIIW2jAIBvk5+ozfBSInU?=
 =?us-ascii?Q?sVPE5cKNXNOC39bVigVOYkNXBo7qoE9PZtDb32SvvIZGSsFE3NEGwBVB3XJ3?=
 =?us-ascii?Q?szvhaaKweOn/E2nfth9ws9BqwxMMEl7Hm5R4LNNvfwY2OiNMw5YTZEpjyCZz?=
 =?us-ascii?Q?gTnd0nC5IsO0RfrF7QLi+GH2qgJg23e6//atF3toUozJUUV/2W1jY4CtRuSU?=
 =?us-ascii?Q?Mg03UviS+LkjrlqtLEM3EJZf+TQfVcEbpG0Lo0kXSmBMSAIfYd8UQTNlHUj7?=
 =?us-ascii?Q?HchwvlKOXwYmxr6nSmtmkbt/xtzXTP5MKao6dDanQGscetq0/tsf1J1y3asJ?=
 =?us-ascii?Q?YRNSGcOocgwIVaLeJ5QZIAAOlSPm5/KeiA5YjHGfJ5ohj6Ws89Jtl+49I1Nx?=
 =?us-ascii?Q?XRHNmHDGf31CDUwDe7sM1swsh1s7MQBwbPm8JqfqXvrowQTWjXD3MpNNDKVl?=
 =?us-ascii?Q?tMTzQlensHYHItJJXeku6y5danjMWoasyCuDCoTDq1rP72zV6NaVvZXIDFF+?=
 =?us-ascii?Q?PABfzEvxCZIsNYkhKnUIGRtW9gIgZnL9JC0G8DUJTRK+GcOaOUFgawHZArBb?=
 =?us-ascii?Q?WT4N32tt/j4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 16:43:07.0272
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 273951fa-ca8e-45f6-3b1d-08dc99ece288
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4466

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


