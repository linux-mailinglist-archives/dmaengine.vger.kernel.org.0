Return-Path: <dmaengine+bounces-2655-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3D292A4FF
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jul 2024 16:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7C81F22013
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jul 2024 14:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED6C13E883;
	Mon,  8 Jul 2024 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="agffXYYJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DB513C674
	for <dmaengine@vger.kernel.org>; Mon,  8 Jul 2024 14:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720449938; cv=fail; b=m8CwGd4Q7oQA+dkc/xOkzNYLczG/ctErtjClCq2xZJuIHYPeFy3rUbnm5xr8IAN0wja3jg8QieY/xgZPMTc5SUMwomDKRo9B9JZqKqOOwSjAVjMsOKAB2dYJr8wdXzb9x4LWWUoE5l8I1TKQUD35DkS1Lo1p71JTDwtizbItCKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720449938; c=relaxed/simple;
	bh=W0ULvef8FSiC/F3nCYmtiuEhEg3mK/ThQvmb2pZXmJA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FfHWOfSAEQL8wLHy2fULYlTXKF7ETyGj2662QA1wqAWaFUBCUQOw/c05c1AfwHyatjr0TL3KghtJJJUcgyTROm0BstDQYtDLExwkRhQtRenHNjFYwRbTAzqXNXv/r16fc8LnMVtmKW9nbRA48L7VIgQ81EVHVGZadywZ701L6m4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=agffXYYJ; arc=fail smtp.client-ip=40.107.102.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLCpVrD9cLkNmY3/n/dP3xu+qkvf+yjV55QMiJRyg0VvZpl57U6DBsIV4UywoVSpzUyumW2HYb+ydJ9+XJ0qwKg+NlLJdq5por0t+F40qbKhBh24EKIeqh4+0WR775A1UaVyzjsNbnjY1hbJljUyyKImSR9w0YQkfCwyoJqJ44gsSm84EJrfIEeB2aCyWE0N6ILlAcRAJcTZkNhYrqJJ5B2u1X809eCZ+vZ7qNS8H2sNe59Qrh8OCD9mB7xCsSdDQ0jOfT7VWUwvoxZBC+2H7xaESnL16mJ7oZ2nwyJ27WvTgSG5SE6ls+hia/6ODLetbmaNN4ErIRMmamgdFKO92A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7q/qZRkOmijskuNe30az9i7ajyG2j288qezL+VTGu8=;
 b=L3DThXYl/2Bp3FlAsmsYSg+U32KLQLQ05v0Lc1DFWz1lgNLlEgg/5lOfHb2OLsYxTRuhuYiVrn7EuMuoEeh64BvM1kgDosfgHY5GC5TdSMcMeb7Te6wANSS9uLxEn4IPKthZlLLBBeDjDWNY7NePjg5P+GrcR/FaB1vRf90CVAFAA2fUa+9hNmviDOKOEo251Ny4ikfymAuckBwGHOnbuh+x1x/0Iy/KEjN7XHhCHESfA6ca7hPWQqfNW9ViQQZcw36+LDNPltwb7/tyK1/i9k4CV+HUELRJyxS6vDdd1n6GD7g682RTrrRQ296+vjSH74fMNithWCL8VOp8So03Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7q/qZRkOmijskuNe30az9i7ajyG2j288qezL+VTGu8=;
 b=agffXYYJNKZRsV3BMWyMSrviyAClmP+MZ4vBMdpO6TT4dnPhzOtqkz2k8l1E+3i9jF/cI+ctkHv5/6+q6pDewlj9BFXe5VT3HC67X6g++K3STIlSGSs/Xwdi2oy0MKBy5rQmFvKsXM9IpwsF+z7LSchT2g7CheSdUrBOf5CkD6w=
Received: from BLAPR03CA0135.namprd03.prod.outlook.com (2603:10b6:208:32e::20)
 by SA1PR12MB7152.namprd12.prod.outlook.com (2603:10b6:806:2b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 14:45:33 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::a4) by BLAPR03CA0135.outlook.office365.com
 (2603:10b6:208:32e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35 via Frontend
 Transport; Mon, 8 Jul 2024 14:45:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 14:45:32 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Jul
 2024 09:45:28 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v5 5/7] dmaengine: ae4dma: Register AE4DMA using pt_dmaengine_register
Date: Mon, 8 Jul 2024 20:14:58 +0530
Message-ID: <20240708144500.1523651-6-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|SA1PR12MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: 576ca7a3-3df9-4c2c-a87b-08dc9f5c9ee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k689zX4SHQvqykB8BXSER72DjVZxBKOseqIHmOkwPnSOzJymJCQtwiTgKYGt?=
 =?us-ascii?Q?ONSrFvMBk0dX0VuwaZa3wdeENjzuCFaT6cfPSVVkPL0wdTjTCzKoznS4Pc99?=
 =?us-ascii?Q?AubzrIvEjkV80AmqyXS4xYL+lLrOKhwBOnB/1hurKEuzy2oC13p7COK4YvDa?=
 =?us-ascii?Q?SSOzLrL8NDTc86p6bjkStLaoS8SXq3S2fz6UyxKqQyNe9rjx7vfhB6TlJXlf?=
 =?us-ascii?Q?HdCg0FBs0XhniApc1cyytGMrf1VSN5w+kCwLUZ0prjadlK5QdgAjSDldIakT?=
 =?us-ascii?Q?4ZPTaRdijZwhooAXS0crl38w/03yb6le8QS0BTLGZA0/pcZUd02i7Zcd6Piz?=
 =?us-ascii?Q?554sEU9HHGhrvJ47NghXhlzLhmSREmranhgBHyrePbz/3IKE5ZYG7Uvgg34T?=
 =?us-ascii?Q?g46gfrkFYReSqkpw98ZJJefYqjgsLjeRpvL+lCVWM8L0qkLD7ONOdLwQEBsO?=
 =?us-ascii?Q?3KRiNSbUW8YciInMRcsMgxfD0/vPNKG1hGtwBwTf9z8XL4gSzhhwGnTrfqgA?=
 =?us-ascii?Q?+Y2zdGthEseDcW8OACAz5IUjqZrq9Jyl/CMTEpvfS7e7fmzRd01y4Xy5Rmnq?=
 =?us-ascii?Q?sZ43R4X6U5zzPBuLp4dei4IN6ApumrVcYJxY9IrIOTRxN1AqjvjY2tlRPMK4?=
 =?us-ascii?Q?KSHHUsDgnj8pMr89zwTuv/ezENZiO3hmcAbEe8tb2db3qVzIlFFdWRrNgY2t?=
 =?us-ascii?Q?QuvMYPmIpy61t1Zw5DQROK/H6zvH9I9HObjGNA233MtKeUfbEiS1ETL7G8WU?=
 =?us-ascii?Q?Vg7Kc4dXMmwljPivRQP9dzDF1HZqSPUHnt7zImUDdXuhvBeYwAUk9/oJBb5y?=
 =?us-ascii?Q?zMdx9n2i7IqXuTVhMqN2I9RnjcQ9BwLf20aE3+HP1zveazrjHRK3PmaCuq4w?=
 =?us-ascii?Q?JfQkwkqdCr+5x692aUU/kEXm9NuelQaYySpuhBGNnuZXO8HE+fhRdLwNYdSe?=
 =?us-ascii?Q?lYMmTpKRWuQqKEXVGrVNg1mZMhIr+UIaYpQ31tJ3WdSFk2nJ4kkOpvdi6HjW?=
 =?us-ascii?Q?APdSPxyCceChau+mNHVfq1Y+vPXb5WhD82/fZqNaP/nerWIZnS4XT066oPEK?=
 =?us-ascii?Q?KghDOmF4TGEUc0BMN7ZSqU9OjINDy92fz/pSIW8WqjBvGjfh16Kr6S0LUzhL?=
 =?us-ascii?Q?rLZ6GUK3Y1wC0d8BbCqyp59C//oGh3FkkjoeLdjfal5KeUJiQSNdKaCXf/tV?=
 =?us-ascii?Q?SCpjl9kHu24NQoV54C5jve5pJYMHzlbFhXryuiQsn+Vryw3pVO7qwZknPROL?=
 =?us-ascii?Q?o+TLV7/9o7Uw1/oXeR3BgVpmbGayu6UozXQ+wleEzBpM/GbDH3UL8lT5OENR?=
 =?us-ascii?Q?MZK5m/gEQP5GvpiJyLuSVPnWZrCJEJjiHfVGFH2r5IjbCrjoom90wVkox8my?=
 =?us-ascii?Q?RMce7Pp7KNvXnirwZEQE2Ut8x1r0604br+w1kQw5KU1U806SKStwccFAZXnH?=
 =?us-ascii?Q?gi7L+Lq+4qs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 14:45:32.8951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 576ca7a3-3df9-4c2c-a87b-08dc9f5c9ee3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7152

Use the pt_dmaengine_register function to register a AE4DMA DMA engine.

Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
Reviewed-by: Philipp Stanner <pstanner@redhat.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/dma/amd/ae4dma/ae4dma-dev.c     | 61 +++++++++++++++++++++++++
 drivers/dma/amd/ae4dma/ae4dma-pci.c     |  1 +
 drivers/dma/amd/ae4dma/ae4dma.h         |  2 +
 drivers/dma/amd/common/amd_dma.h        |  3 ++
 drivers/dma/amd/ptdma/ptdma-dmaengine.c | 11 ++++-
 5 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/amd/ae4dma/ae4dma-dev.c b/drivers/dma/amd/ae4dma/ae4dma-dev.c
index c38464b96fc6..248abf794aff 100644
--- a/drivers/dma/amd/ae4dma/ae4dma-dev.c
+++ b/drivers/dma/amd/ae4dma/ae4dma-dev.c
@@ -61,6 +61,16 @@ static void ae4_check_status_error(struct ae4_cmd_queue *ae4cmd_q, int idx)
 	}
 }
 
+void pt_check_status_trans_ae4(struct pt_device *pt, struct pt_cmd_queue *cmd_q)
+{
+	struct ae4_cmd_queue *ae4cmd_q = container_of(cmd_q, struct ae4_cmd_queue, cmd_q);
+	int i;
+
+	for (i = 0; i < CMD_Q_LEN; i++)
+		ae4_check_status_error(ae4cmd_q, i);
+}
+EXPORT_SYMBOL_GPL(pt_check_status_trans_ae4);
+
 static void ae4_pending_work(struct work_struct *work)
 {
 	struct ae4_cmd_queue *ae4cmd_q = container_of(work, struct ae4_cmd_queue, p_work.work);
@@ -117,6 +127,53 @@ static irqreturn_t ae4_core_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static int ae4_core_execute_cmd(struct ae4dma_desc *desc, struct ae4_cmd_queue *ae4cmd_q)
+{
+	bool soc = FIELD_GET(DWORD0_SOC, desc->dwouv.dw0);
+	struct pt_cmd_queue *cmd_q = &ae4cmd_q->cmd_q;
+
+	if (soc) {
+		desc->dwouv.dw0 |= FIELD_PREP(DWORD0_IOC, desc->dwouv.dw0);
+		desc->dwouv.dw0 &= ~DWORD0_SOC;
+	}
+
+	mutex_lock(&ae4cmd_q->cmd_lock);
+	memcpy(&cmd_q->qbase[ae4cmd_q->tail_wi], desc, sizeof(struct ae4dma_desc));
+	ae4cmd_q->q_cmd_count++;
+	ae4cmd_q->tail_wi = (ae4cmd_q->tail_wi + 1) % CMD_Q_LEN;
+	writel(ae4cmd_q->tail_wi, cmd_q->reg_control + AE4_WR_IDX_OFF);
+	mutex_unlock(&ae4cmd_q->cmd_lock);
+
+	wake_up(&ae4cmd_q->q_w);
+
+	return 0;
+}
+
+int pt_core_perform_passthru_ae4(struct pt_cmd_queue *cmd_q, struct pt_passthru_engine *pt_engine)
+{
+	struct ae4_cmd_queue *ae4cmd_q = container_of(cmd_q, struct ae4_cmd_queue, cmd_q);
+	struct ae4dma_desc desc;
+
+	cmd_q->cmd_error = 0;
+	cmd_q->total_pt_ops++;
+	memset(&desc, 0, sizeof(desc));
+	desc.dwouv.dws.byte0 = CMD_AE4_DESC_DW0_VAL;
+
+	desc.dw1.status = 0;
+	desc.dw1.err_code = 0;
+	desc.dw1.desc_id = 0;
+
+	desc.length = pt_engine->src_len;
+
+	desc.src_lo = upper_32_bits(pt_engine->src_dma);
+	desc.src_hi = lower_32_bits(pt_engine->src_dma);
+	desc.dst_lo = upper_32_bits(pt_engine->dst_dma);
+	desc.dst_hi = lower_32_bits(pt_engine->dst_dma);
+
+	return ae4_core_execute_cmd(&desc, ae4cmd_q);
+}
+EXPORT_SYMBOL_GPL(pt_core_perform_passthru_ae4);
+
 void ae4_destroy_work(struct ae4_device *ae4)
 {
 	struct ae4_cmd_queue *ae4cmd_q;
@@ -194,5 +251,9 @@ int ae4_core_init(struct ae4_device *ae4)
 		init_completion(&ae4cmd_q->cmp);
 	}
 
+	ret = pt_dmaengine_register(pt);
+	if (ret)
+		ae4_destroy_work(ae4);
+
 	return ret;
 }
diff --git a/drivers/dma/amd/ae4dma/ae4dma-pci.c b/drivers/dma/amd/ae4dma/ae4dma-pci.c
index 43d36e9d1efb..aad0dc4294a3 100644
--- a/drivers/dma/amd/ae4dma/ae4dma-pci.c
+++ b/drivers/dma/amd/ae4dma/ae4dma-pci.c
@@ -98,6 +98,7 @@ static int ae4_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	pt = &ae4->pt;
 	pt->dev = dev;
+	pt->ver = AE4_DMA_VERSION;
 
 	pt->io_regs = pcim_iomap_table(pdev)[0];
 	if (!pt->io_regs) {
diff --git a/drivers/dma/amd/ae4dma/ae4dma.h b/drivers/dma/amd/ae4dma/ae4dma.h
index 5f9dab5f05f4..1bc8abcd1d44 100644
--- a/drivers/dma/amd/ae4dma/ae4dma.h
+++ b/drivers/dma/amd/ae4dma/ae4dma.h
@@ -25,6 +25,7 @@
 #define AE4_Q_SZ			0x20
 
 #define AE4_DMA_VERSION			4
+#define CMD_AE4_DESC_DW0_VAL		2
 
 struct ae4_msix {
 	int msix_count;
@@ -45,6 +46,7 @@ struct ae4_cmd_queue {
 	atomic64_t done_cnt;
 	u64 q_cmd_count;
 	u32 dridx;
+	u32 tail_wi;
 	u32 id;
 };
 
diff --git a/drivers/dma/amd/common/amd_dma.h b/drivers/dma/amd/common/amd_dma.h
index 396667e81e1a..896318ed2495 100644
--- a/drivers/dma/amd/common/amd_dma.h
+++ b/drivers/dma/amd/common/amd_dma.h
@@ -24,4 +24,7 @@
 #include "../ae4dma/ae4dma.h"
 #include "../../virt-dma.h"
 
+void pt_check_status_trans_ae4(struct pt_device *pt, struct pt_cmd_queue *cmd_q);
+int pt_core_perform_passthru_ae4(struct pt_cmd_queue *cmd_q, struct pt_passthru_engine *pt_engine);
+
 #endif
diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
index 90ca02fd5f8f..412b40903e57 100644
--- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
+++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
@@ -79,7 +79,10 @@ static int pt_dma_start_desc(struct pt_dma_desc *desc, struct pt_dma_chan *chan)
 	pt->tdata.cmd = pt_cmd;
 
 	/* Execute the command */
-	pt_cmd->ret = pt_core_perform_passthru(cmd_q, pt_engine);
+	if (pt->ver == AE4_DMA_VERSION)
+		pt_cmd->ret = pt_core_perform_passthru_ae4(cmd_q, pt_engine);
+	else
+		pt_cmd->ret = pt_core_perform_passthru(cmd_q, pt_engine);
 
 	return 0;
 }
@@ -296,7 +299,10 @@ pt_tx_status(struct dma_chan *c, dma_cookie_t cookie,
 
 	cmd_q = pt_get_cmd_queue(pt, chan);
 
-	pt_check_status_trans(pt, cmd_q);
+	if (pt->ver == AE4_DMA_VERSION)
+		pt_check_status_trans_ae4(pt, cmd_q);
+	else
+		pt_check_status_trans(pt, cmd_q);
 	return dma_cookie_status(c, cookie, txstate);
 }
 
@@ -462,6 +468,7 @@ int pt_dmaengine_register(struct pt_device *pt)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(pt_dmaengine_register);
 
 void pt_dmaengine_unregister(struct pt_device *pt)
 {
-- 
2.25.1


