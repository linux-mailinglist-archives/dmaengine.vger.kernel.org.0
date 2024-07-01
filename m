Return-Path: <dmaengine+bounces-2611-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CC091E59E
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jul 2024 18:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2DC51F2212A
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jul 2024 16:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3745416DC16;
	Mon,  1 Jul 2024 16:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E8KA3iHU"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC8716D9DF
	for <dmaengine@vger.kernel.org>; Mon,  1 Jul 2024 16:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852194; cv=fail; b=a05a4TpbhZyQ3ToWk+pNBNoIAArqEBG6HXBVHkUkGe+gc62Cfp2d3WIIjtBdtl3KcidgIafW+5CRgrjqsiiGVHSryMFp3j+ZeLJwcJJWUFkEagNa/rRGUdrbTZEN2P2QMv6V7Bg4qFcqfbBxilTkTmGP9GCj0uBhdIlIk3JCaGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852194; c=relaxed/simple;
	bh=BaHjlUXLULEhv2gSIRawq6RzeDlfcsC3UDuLcE/Mb/I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VzT4mDkYDOOZYH9QlA+fV9QMXXAfxTuSx221uah2fqIgihjv6jfKtazfMJEJrPJE4Nw8MeNw4sy2kwSI/fIGLPcjfTNUAwziOpL6SoZ+dbSk0qy5yPe8LR+pFf8fIzmAbp+WO/7lW1SjpPLCaLEMUNoRLiT5XamupU/sQXTla8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E8KA3iHU; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwWV+YaBwkKQf5O/2c5BhpcgkkWi41mwndsbyJbL0rIQLyBBnxuAMKZLufRYsx97J4ckLJPpINlIzAhzr8Iqp9jAABKbQcThUu2H85rLhyYWAc4ihy4Sr87Xk3pJ5IgBi/qVmt8gBmitJ/Z3q4ykTDAI8bYLs3wHno3GFTKgzjjbXiTsjOmiwb5XX3y5Y265AUYvg2OqlJpHg6ymeOdJkI4KEHVyAyT1UOZz4DndhOVAvXz7DBYgNY94R5zmoJp/1kFZRiWGMh1lcsmsQiMg9ybHgisazMapGxlw3dS3Dx0AZvMWqbzY++hXIKqmTFbHUqtNX5n8SwlDiuQm3Hj8fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWSygaxOuSirtVIZozU1GmuR2V30/9zmuFQGXlN5JMc=;
 b=VFkmCqXPkCt//zAOyTYKhTwbuKUjPxNDsouMdd5UOiG+oDGP6lRkUAGrN0TJDr4WJcCLZqe5X5RIxWPFekui8hkFSrBt2cdibxNSte8ZNEifdJAaxn5tPI7rCaJ8cw/VYtwbszAZVwj3fxGCGjExfQ9YP+X8l6QvtY9goB5sYBu37G+NiUf+nsFayH5ClUlf6jWWvTaerQilmGrrkei3rZXzLuTEVBTPwE2eMvTD16sd91pSYMIuOrttLqpWlnefLmab/oAmlRhu+i1AMNBgRxSJAybCGKc1IsKAEcaJndYoK22+55A12ZxZm93NziomkwSCs5CNs3YhPHmbREqa1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWSygaxOuSirtVIZozU1GmuR2V30/9zmuFQGXlN5JMc=;
 b=E8KA3iHUQCbRTpZf3e0R3f4rcArI7WhjVMgKKlblwOS2KygadcUxibK0Y1SGG/91zBIWNnYMsKzMLDfo3CyA1Zx4bGlaf8lMnhtqWTQ6YvnDxjObPPojZZRQ4g+O343JDkFu+pBAIDvjw7SM1uc6Utc92NtRsia0RKmtc050Mv8=
Received: from SJ0PR03CA0052.namprd03.prod.outlook.com (2603:10b6:a03:33e::27)
 by MW4PR12MB6876.namprd12.prod.outlook.com (2603:10b6:303:208::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 16:43:08 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::68) by SJ0PR03CA0052.outlook.office365.com
 (2603:10b6:a03:33e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33 via Frontend
 Transport; Mon, 1 Jul 2024 16:43:08 +0000
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
 2024 11:43:04 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v4 5/7] dmaengine: ae4dma: Register AE4DMA using pt_dmaengine_register
Date: Mon, 1 Jul 2024 22:12:31 +0530
Message-ID: <20240701164233.2563221-6-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|MW4PR12MB6876:EE_
X-MS-Office365-Filtering-Correlation-Id: 7421865e-12fe-4505-837f-08dc99ece312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PopweHdQvFOeZa/N16RSYgaTta3naDWoTM76wlzWmU89Lm9Lr5dvzmf0ov5W?=
 =?us-ascii?Q?ZEcBAqyVJLX4+ETVLNDS0DZWvs7TZPrluwU0UJ+Z95BQmOPMbEeVyb8CXiW3?=
 =?us-ascii?Q?dpW3HwypZA2PSPGrOZzANwzXz8uE2p0iKm8QkWlHd2BBYAaarCOJ3btp2sWh?=
 =?us-ascii?Q?TUqG/k8WW/OnP0aXbl6wAAXWRrSia0jEK54gpg3rPSDdbEMccDfNeIO6B2IF?=
 =?us-ascii?Q?l2HEj3++2kkvWVRE9xEB4jgV8+zAGlgtpQ91xPBTk3kwa23yG2jMu6r1E+CK?=
 =?us-ascii?Q?GJni35abPkEgg4uoKh1H/pm2okdOArePm+pWQGchWA5QCeYbiTlpDB7NMo9p?=
 =?us-ascii?Q?ImSMfAN8nPCwEzV2Hk7zmrxe4YmiFfy2Id6DCJtDJZ1RknQ/zjmkAj7BSCTx?=
 =?us-ascii?Q?nXhxjdrbWAO1xVJU+yyMK3Q/9VK+Q0yn26YIkBO1q1I8YjE1PAjK93QUm2Un?=
 =?us-ascii?Q?wIe6XAZIfzdEpbOJdlpLrm66sPjzKtShU8PzSpnsK/cbTTcRGU9vB8LeNqWx?=
 =?us-ascii?Q?6T0Zq4+rjzWMir8niHlKQ5M0+pO83NfHudsVf6WlpnOmhF7grz85nPWuSWF8?=
 =?us-ascii?Q?5NOGsSi7dLoV2+bAP3XHEvwsqTVx2JhbFznPM4SOICxA+5vhOLaklS/hl1kj?=
 =?us-ascii?Q?zz97tln2zUwvGdT7+rgaJRRf2LNeX7DDlioVvJ7sSn2wt34lAjGZr9ilAMEG?=
 =?us-ascii?Q?mFWnn4PirXUt2EN1Kgj8r65GQDoav1K/JtvR1AV3R9+UXTs0qJOOpFzd0wVU?=
 =?us-ascii?Q?b7YG5fAbcRWM8EV3jy4y0FNa0PUD+ucNYc08bEDsKB/PxLklvafw4BkNYlUX?=
 =?us-ascii?Q?Hb4xsiaIqgf79S1UV8QASP9KqKWdAfAEkgTFR4sVKWPnU4YxHBqsgedAYeay?=
 =?us-ascii?Q?fH0TiimEcYwoTrQJ7RCRlAkA2ZBCqorn4dq+cmWTa0mht86MdAmlzKGtHsS7?=
 =?us-ascii?Q?CIZlRXDRW5D2NnLtkhvK0EF2X9c1l9zfIBjqQ9T7SMGmEQNpdkYx62Ju2NRi?=
 =?us-ascii?Q?AYtX85oVJwviCkefUCYSCpZzsvpM3S/dG6/25iLXG9HfakW8DgHSmLceA20+?=
 =?us-ascii?Q?hCsWqvbAy8+UWy1KwlSR05FBdSHbLPtv9dSWdyc8Xx6N4PoC1wWJicoAeziJ?=
 =?us-ascii?Q?oRoJiNBk/drHgJrWMpGyAqlj3YKzLtucKvoqj4txUauEezMyWlCyMptQisSR?=
 =?us-ascii?Q?HWfCkRyn3nL679p3P/ZlCLKt0pYSVGSr7Iy51xs6Hv9gaoBz3FoZ/Tt5yRn7?=
 =?us-ascii?Q?EeiGNpcWUktICuNac8WpfQMAAS3UDQVBHNEAY8Lk604fuj6ot5c/FJDIxxTR?=
 =?us-ascii?Q?yuEBsiITkevMmJHIDmPE4sxY/ePbGSzyDQW28ANFT165hamztc/XVUz9F6Um?=
 =?us-ascii?Q?t2AF6ASoSerykfJpZv1yjqszLLbTPtobbwZlE/RSlP1rUg1jh8dy/Rw93653?=
 =?us-ascii?Q?kcO8SzucA4E=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 16:43:07.9334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7421865e-12fe-4505-837f-08dc99ece312
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6876

Use the pt_dmaengine_register function to register a AE4DMA DMA engine.

Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/dma/amd/ae4dma/ae4dma-dev.c     | 60 +++++++++++++++++++++++++
 drivers/dma/amd/ae4dma/ae4dma-pci.c     |  1 +
 drivers/dma/amd/ae4dma/ae4dma.h         |  2 +
 drivers/dma/amd/ptdma/ptdma-dmaengine.c |  1 +
 4 files changed, 64 insertions(+)

diff --git a/drivers/dma/amd/ae4dma/ae4dma-dev.c b/drivers/dma/amd/ae4dma/ae4dma-dev.c
index c38464b96fc6..205bb8822f84 100644
--- a/drivers/dma/amd/ae4dma/ae4dma-dev.c
+++ b/drivers/dma/amd/ae4dma/ae4dma-dev.c
@@ -61,6 +61,15 @@ static void ae4_check_status_error(struct ae4_cmd_queue *ae4cmd_q, int idx)
 	}
 }
 
+void pt_check_status_trans(struct pt_device *pt, struct pt_cmd_queue *cmd_q)
+{
+	struct ae4_cmd_queue *ae4cmd_q = container_of(cmd_q, struct ae4_cmd_queue, cmd_q);
+	int i;
+
+	for (i = 0; i < CMD_Q_LEN; i++)
+		ae4_check_status_error(ae4cmd_q, i);
+}
+
 static void ae4_pending_work(struct work_struct *work)
 {
 	struct ae4_cmd_queue *ae4cmd_q = container_of(work, struct ae4_cmd_queue, p_work.work);
@@ -117,6 +126,53 @@ static irqreturn_t ae4_core_irq_handler(int irq, void *data)
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
+int pt_core_perform_passthru(struct pt_cmd_queue *cmd_q,
+			     struct pt_passthru_engine *pt_engine)
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
+
 void ae4_destroy_work(struct ae4_device *ae4)
 {
 	struct ae4_cmd_queue *ae4cmd_q;
@@ -194,5 +250,9 @@ int ae4_core_init(struct ae4_device *ae4)
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
 
diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
index 90ca02fd5f8f..1f020f90d886 100644
--- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
+++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
@@ -462,6 +462,7 @@ int pt_dmaengine_register(struct pt_device *pt)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(pt_dmaengine_register);
 
 void pt_dmaengine_unregister(struct pt_device *pt)
 {
-- 
2.25.1


