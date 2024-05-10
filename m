Return-Path: <dmaengine+bounces-2017-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4738C1F9D
	for <lists+dmaengine@lfdr.de>; Fri, 10 May 2024 10:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DA3B1C2145C
	for <lists+dmaengine@lfdr.de>; Fri, 10 May 2024 08:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF4C15FA79;
	Fri, 10 May 2024 08:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GjsusimR"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C25C136
	for <dmaengine@vger.kernel.org>; Fri, 10 May 2024 08:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715329304; cv=fail; b=XuK1JgWFAcaie/MuIoajhd67T73MDHElQ03BCdzN8xvzwMLSQF2ltEVa976rJemwpvducpopFf+vzipSYtbS4vjOykkvLpaK76k2nv6tbXHMMrPuZs8FGiEEdK4C+eOvYz9KpPKiPkgy0J0lBaIWoMCORo0JPXqjIpWjgaixcJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715329304; c=relaxed/simple;
	bh=eMeC6La3Dv8Mt9SGDujElUO/HEpWWUUy+eTgdMp1uQY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e7mp7GX6Hk1A2Kc9Gkp6UzrCqa4iNIkoEbufMRmq2jJBjsrBnuKjoAvW2Ao635W64QctXaocXHJFrkXU0UYU3OVs30hV9uac8izeuU3qea0lx0uBzPfhDPUPnL2CVEE2o3gOcH/aFbtMwHnVTgFNUC/X/3tAiDp/IZWCAWHCTQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GjsusimR; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbwfyFcIabTvsv2k47SlskV9J5ogcrDiFj7GHgQCqS1KrqaNQGBk6/dKyo753YOL9zBQTv2mojVgUcRU6fjCi5XKm+Wvkmxt3rpFhxL8cCvmbFj35BdtgnQr+SCVelC+3F0KCMIxltHHewDbzr78CdPAjVIK5cRjPvLCVexNFOqo6YMSd7gvMwFQ5OjkW2kddzbPjlILR24DN3GxjHAW/VrWq6xbG9uLeXtpqCM8+FWwTCGODC2D0pn94qyzm0ZSBDG0G1ZmYqSCVftIVYEA/8GQuw3e1Hl2JozylRwU4mfz/mRvYJMV0vZuG2ySAsfDBOkMBjZdz5WG3/so/wzdJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4GTd7Cio82h9vthREKd/dwXuQ899svKYlwuZOy1Iy4=;
 b=ZTcqdtRoDNyK/+MNdQQUYFJmx9yND50ya4Bat2gndCZodTT9GhzzlbreAMPWRjphQpn1X01lpdwHxH0CDCp5jeeCfU5iDwv3b93UbVHcUaKE519OZX8GJW5ral6hJsB21vAP2JRnGtW98sqfAHzEfSjI8aT2KtGQzcdI70PoowgTjRqgk9XRtRPYYMjulzl6jGYl6Jhz6ABlQ1qWhDQ3lzSyVT7MSqjm/2ohZTzouTCqyPXeU1TeW0p+rivdlqvP0cGAEx8uOgJmkAxNBQjSr/CqWw/Xz4zE4/R/MugY8/9eKOW6HWDxbPiHvHHC8uY3D0hR3dNFFkMzg2oA6IPG3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4GTd7Cio82h9vthREKd/dwXuQ899svKYlwuZOy1Iy4=;
 b=GjsusimR4RVJRhWYxlHlAJ7UlnBHqUQ1N3M5Z9liwzRyccwOKQBYuOkhNXbLx1vQIGegPLQHDeLmTqMAwKKRkXV/HuaF76eEygRSZq0NpO2YIfgA7rqF3l7JbH36e7UlrDAt9Udq+213H1WLXC/xQne9b6s0ffgFXul5qLb8EGA=
Received: from DM6PR11CA0029.namprd11.prod.outlook.com (2603:10b6:5:190::42)
 by SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Fri, 10 May
 2024 08:21:40 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:190:cafe::c3) by DM6PR11CA0029.outlook.office365.com
 (2603:10b6:5:190::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49 via Frontend
 Transport; Fri, 10 May 2024 08:21:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 10 May 2024 08:21:40 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 10 May
 2024 03:21:35 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH 5/7] dmaengine: ae4dma: Register AE4DMA using pt_dmaengine_register
Date: Fri, 10 May 2024 13:50:51 +0530
Message-ID: <20240510082053.875923-6-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|SJ2PR12MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c12ba6d-9148-4975-9025-08dc70ca37f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|36860700004|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0de4KATiqt7+oxOVBbK+1+rDmPRkWFJuSJFbmykPNGsxvNGI0yhEAsyqk12g?=
 =?us-ascii?Q?lJEYTG9PcsAuHb4uKxW4D9BYNvcTzCEbHrIbUHN+FaDxzxHgPH/Pfxe89evS?=
 =?us-ascii?Q?Hbxq6iqxU7dvacHFdNYClBFD5r+qbXCPA1ksnx4VLaanwF6PPafpzf3Aph67?=
 =?us-ascii?Q?6k1kwWBoNawygFMr0xrMIeXzkZO3UK9xxhpUGIfJ6wVVyc6hUmbLWYsuroTb?=
 =?us-ascii?Q?lqX6DQgz+pTUrEIcvo/wyKKP+gwHHF69qSOZ7yZDOWQDGltJfOhB6r/PMG8A?=
 =?us-ascii?Q?HdRBpQM5bE1XN9Op3o15oK7QU7KWZRMx5FWhW7vZdgWMMLokcVQnG3BR1LzU?=
 =?us-ascii?Q?C0ZZX9XeZqTHayQmNyBIi9FYl7P4EYZX7hq6YcPQEocQXuLUgxYjuJqk24h5?=
 =?us-ascii?Q?Id7Zr288hz8G0gxMYZhTHAl0KE+0CO14JeeP32OWWkW/ZQQyxnTaRaQPVxkJ?=
 =?us-ascii?Q?278swZYry3ij/1doE5fDbnoRl8GXL1J3xdRaGREwoGA1xUWBNRXJ3KNHGlNr?=
 =?us-ascii?Q?aPno4hQt7q+HXqM8YRNqYMon+aMv/XlMl4roEflKukHfSTD4rroP3gcS6RIt?=
 =?us-ascii?Q?0MWNYHunbfZq6w55uWIJt7ynNCrPjoP4eox0m+jxGYgqO+/6TeE2BRtZUlGq?=
 =?us-ascii?Q?4OrAjHVYTyrFoEx870mkIGzooCptsdTiIP3K12OaC6nDZDCHxXi9Fb1UthAY?=
 =?us-ascii?Q?cxXG/97Mktzi1zs/IIe4ADLZ+5EoH9D9RqMXXf0nvKzVQG3pQa+Pa5JGxHCF?=
 =?us-ascii?Q?u3OSaNTlqJiWG6RjY7ZthgNYqkP6ccVlSvDsaod+4KJ2LSLaJv08Yk+Xd5wy?=
 =?us-ascii?Q?gCpIOuQXKnucFFf6VNS5lfiA9Do0LKQ7N0Tx8s4lyTDywrfTBfmo8Xupe1kx?=
 =?us-ascii?Q?5bE1KLXiEK1ADX2qUPMG9qDo4Wwc2fi5UaeezOOnc36WBzalEv9wa2sRDN5w?=
 =?us-ascii?Q?iUSssZfr6zy777pAaVKlj5cjHnaL1momFq8rvsxuer77ALh2aJ5VkiThH70w?=
 =?us-ascii?Q?IvW8ZOLyIFxNcKBJoZ0RHd020YmrFnbjuVo6I2McrCPSA1ROcgWCJUXJPOz0?=
 =?us-ascii?Q?WsOf5azCZgTZb2TLVteftpC1PKqsy2hnLl4JpHE71mChy6FIFXSdTeS7zkNf?=
 =?us-ascii?Q?Xy7Zwfp69QKuXJO5rQF1wpt23U/ZvcvoVomo/QJcFNeLM4ePFwTndT185ylX?=
 =?us-ascii?Q?SoWmdBrv86btg+G559vB1w1diUnQ1Nspmv7vrvQs6HsQpgsM0g+hEMrpetDS?=
 =?us-ascii?Q?96RgLKZd8L0NCsm9H1u1jk6DEld2tNXzqh5of3OmYWcqmxjICkpaTYpo8Fbz?=
 =?us-ascii?Q?qs2xg6wY1YWxKAncmo7QtUqJeYj3DRWjQIAwxCAlN8QUT/aUt7omMSWc9Vwf?=
 =?us-ascii?Q?dsuBo+XMhWDRAYLhMDzwwQSPA2fQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 08:21:40.3793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c12ba6d-9148-4975-9025-08dc70ca37f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991

Use the pt_dmaengine_register function to register a AE4DMA DMA engine.

Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/dma/amd/ae4dma/Makefile     |  2 +-
 drivers/dma/amd/ae4dma/ae4dma-dev.c | 73 +++++++++++++++++++++++++++++
 drivers/dma/amd/ae4dma/ae4dma-pci.c |  1 +
 drivers/dma/amd/ae4dma/ae4dma.h     |  2 +
 4 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/amd/ae4dma/Makefile b/drivers/dma/amd/ae4dma/Makefile
index e918f85a80ec..165d1c74b732 100644
--- a/drivers/dma/amd/ae4dma/Makefile
+++ b/drivers/dma/amd/ae4dma/Makefile
@@ -5,6 +5,6 @@
 
 obj-$(CONFIG_AMD_AE4DMA) += ae4dma.o
 
-ae4dma-objs := ae4dma-dev.o
+ae4dma-objs := ae4dma-dev.o  ../ptdma/ptdma-dmaengine.o ../common/amd_dma.o
 
 ae4dma-$(CONFIG_PCI) += ae4dma-pci.o
diff --git a/drivers/dma/amd/ae4dma/ae4dma-dev.c b/drivers/dma/amd/ae4dma/ae4dma-dev.c
index fc33d2056af2..7c4bd14c4f12 100644
--- a/drivers/dma/amd/ae4dma/ae4dma-dev.c
+++ b/drivers/dma/amd/ae4dma/ae4dma-dev.c
@@ -60,6 +60,15 @@ static void ae4_check_status_error(struct ae4_cmd_queue *ae4cmd_q, int idx)
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
@@ -123,6 +132,66 @@ static irqreturn_t ae4_core_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static int ae4_core_execute_cmd(struct ae4dma_desc *desc, struct ae4_cmd_queue *ae4cmd_q)
+{
+	bool soc = FIELD_GET(DWORD0_SOC, desc->dwouv.dw0);
+	struct pt_cmd_queue *cmd_q = &ae4cmd_q->cmd_q;
+	u32 tail_wi;
+
+	if (soc) {
+		desc->dwouv.dw0 |= FIELD_PREP(DWORD0_IOC, desc->dwouv.dw0);
+		desc->dwouv.dw0 &= ~DWORD0_SOC;
+	}
+
+	mutex_lock(&ae4cmd_q->cmd_lock);
+
+	tail_wi = atomic_read(&ae4cmd_q->tail_wi);
+	memcpy(&cmd_q->qbase[tail_wi], desc, sizeof(struct ae4dma_desc));
+
+	atomic64_inc(&ae4cmd_q->q_cmd_count);
+
+	tail_wi = (tail_wi + 1) % CMD_Q_LEN;
+
+	atomic_set(&ae4cmd_q->tail_wi, tail_wi);
+	/* Synchronize ordering */
+	mb();
+
+	writel(tail_wi, cmd_q->reg_control + 0x10);
+	/* Synchronize ordering */
+	mb();
+
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
@@ -202,5 +271,9 @@ int ae4_core_init(struct ae4_device *ae4)
 		init_completion(&ae4cmd_q->cmp);
 	}
 
+	ret = pt_dmaengine_register(pt);
+	if (ret)
+		ae4_destroy_work(ae4);
+
 	return ret;
 }
diff --git a/drivers/dma/amd/ae4dma/ae4dma-pci.c b/drivers/dma/amd/ae4dma/ae4dma-pci.c
index 4cd537af757d..883c4c28361f 100644
--- a/drivers/dma/amd/ae4dma/ae4dma-pci.c
+++ b/drivers/dma/amd/ae4dma/ae4dma-pci.c
@@ -131,6 +131,7 @@ static int ae4_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	pt = &ae4->pt;
 	pt->dev = dev;
+	pt->ver = AE4_DMA_VERSION;
 
 	pt->io_regs = pcim_iomap_table(pdev)[0];
 	if (!pt->io_regs) {
diff --git a/drivers/dma/amd/ae4dma/ae4dma.h b/drivers/dma/amd/ae4dma/ae4dma.h
index 4e4584e152a1..f1b6dcc1d8c3 100644
--- a/drivers/dma/amd/ae4dma/ae4dma.h
+++ b/drivers/dma/amd/ae4dma/ae4dma.h
@@ -16,6 +16,7 @@
 
 #define AE4_DESC_COMPLETED		0x3
 #define AE4_DMA_VERSION			4
+#define CMD_AE4_DESC_DW0_VAL		2
 
 struct ae4_msix {
 	int msix_count;
@@ -36,6 +37,7 @@ struct ae4_cmd_queue {
 	atomic64_t done_cnt;
 	atomic64_t q_cmd_count;
 	atomic_t dridx;
+	atomic_t tail_wi;
 	unsigned int id;
 };
 
-- 
2.25.1


