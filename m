Return-Path: <dmaengine+bounces-2518-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EB69143FE
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2024 09:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EA5F2838A2
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2024 07:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3DA482EB;
	Mon, 24 Jun 2024 07:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="byzFc2p2"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A1647F5F
	for <dmaengine@vger.kernel.org>; Mon, 24 Jun 2024 07:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719215807; cv=fail; b=obRtkZzzTXGI9+Yxd8+Hjwve3f0QXKWFhb3MUSUNxC7pQa/qZLk/97KV0tmq/dcoahOa2HcU92oErfCl6E+ZGCIPfFKIZbAmDim4T4cYXEnGDP/zC5hRLWiF46Tv67mTV+8wgofqPhvzg0hVTa/N+nRfN+oELyxXVkdoHQbSkY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719215807; c=relaxed/simple;
	bh=Z+ofXQLQ2DGHIXi/pYp1eNTMEx0E3RbLKEhjgK0e3Ts=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qjOPBdSzQdc/+j+CL2YWbkFTct7aQXo/g6J/A1eRx0KMmBfr4RSgCzSWmv2Z40yKK+Y2V4mCHta9BSITtZG/hOFE49jrRXNQ//VI+N+NMLWcQahviDt8EmEjIOK8zMtWTB/2Yc7Ck4Clo1AilaU3btHdt/X2LHOykbgymN6ZSyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=byzFc2p2; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1G7rMiqMX43CMWpUM5UH3lTCV2sYn2SwrffJX386aRERadvrdCkyIN+QQa3lxeKjKCVjdx9vzzu/GOzmVn7ltNO14GAn1cxQiHCSK865WskDKucPZUU7YNj8YD8dns9jpUfzJY19i7rueOFKSzV1Vjw5WB5K3Wui/H5tPp9UxxC88fz4dhAXo58maDvh4f2zuqmVyV1hxLMb26nhEQdwGcrSBUgNhktXV4fRtuHDEMGOJMCRvwSlErNbcj2eSnjhIV9cV10BA48qjQmlUlbDJ1wCsY9xZzQhzjcd6nIloiSPt1Bhe5aQcDjkrxRFiPTsdreUPNQ2rC45Z+uCrHuZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iP44LH3NfVMgBdisr6/PTi9GPUcm6Z9TjBSwgtxOxE=;
 b=f061gVWikbaPWmpiGh0mn3Gn9DLSh/IrfZhAXEscZLyeitG5K4TrIa7HDP9Fw8ckGk6MTxVy3ZzEAxzrMwgR/xg4Xz8sNvPx1/myudk0PomsPdFOz0ij+1KsEhCiIXr5mjJGjPIO6gr4G3+OJu05zyV8ZTO756IbrHSHmJYrg/4H26HMd6l2vLGLBAM9vvj+zwgQmtkGgxcq071ohZkdA0KpWAIjeqObWzXe7/RHQ1aIhAaS1mmveaS67T+TNbev6tuSOonJbOgK6BiK6QrvrFcc2cXeCdKta1eF298lbWIf5KRIRrBLI4tmo9YoOMolU3QvabVZeFh0V2FBjafiJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iP44LH3NfVMgBdisr6/PTi9GPUcm6Z9TjBSwgtxOxE=;
 b=byzFc2p2srNM//BJg0IRGfsjGkptzKl6i7CUcqqpuKy3dY3FkhNjqRNjhBpN4+n+gukJG81bYqTsSASndK2eSZF3GPxHaNc6k/F8nfRYZ8iMclSF/LKj5ueI1c6dL3aXU86Tf5O7JjmlmtoJsun6yPEJTz5wF2hRbO2S97KFwqI=
Received: from CH5PR03CA0022.namprd03.prod.outlook.com (2603:10b6:610:1f1::8)
 by BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Mon, 24 Jun
 2024 07:56:42 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::bb) by CH5PR03CA0022.outlook.office365.com
 (2603:10b6:610:1f1::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 07:56:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 07:56:42 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 02:56:40 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v3 5/7] dmaengine: ae4dma: Register AE4DMA using pt_dmaengine_register
Date: Mon, 24 Jun 2024 13:26:08 +0530
Message-ID: <20240624075610.1659502-6-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|BL3PR12MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: 861a3c19-26a3-4422-2271-08dc94232fe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|82310400023|376011|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YY4kbVwv24U+l+ZOabJlpzQvC9bmx77ZRB0zMNCklRAxCKM2QKU1Wt4rbvwi?=
 =?us-ascii?Q?+Wre5M4UbbyaLKoDMoGFg07Gm7AItvDuy3fKvPnHH2jc4dxcuT+mJg7J8hb5?=
 =?us-ascii?Q?3dAhPEyS+8Ilv5C6EqEgqAI74HZP2x1EhhDPE2hPZGbiNznUUzvkcLXRfvLD?=
 =?us-ascii?Q?FV978siQRoMdvAiwwBkEAKzIW5yDvzH3r1T8JD2cBYaxYLvclZonVNetRycL?=
 =?us-ascii?Q?nLruaTh1zVJtYt11hYEFkvJfMBmpHlzFU9hPW6g0DzREIXOzu8liTqt0HHv5?=
 =?us-ascii?Q?dfPFsrbGBhUE+j9rzOScGD5xr1w/kpQe/CiOIG8RNCiuD1IJGgp0A8P9AQBO?=
 =?us-ascii?Q?CNjyJnO7afVt7myniXCSH4aWN9ZjQg8m+sp3aH0PGdDwdhZivZBCE1t6oE1C?=
 =?us-ascii?Q?R/YEsGI4ex66fsQRPP6q83HA8qa44UpspwzGWHoIwpLPLSomOs1czsWVY18J?=
 =?us-ascii?Q?ThwtPRRK3X6a1m3/nynR5bYP8rFQXlnmeAchBT1ES0i2B6I8q1UW9FRviuS+?=
 =?us-ascii?Q?NfSsxtMMJ869UNnbtxuSAj/PLf+sxKvPIpDJ+LodlgKWI44OsOud06ATCYKy?=
 =?us-ascii?Q?qOAuNjdE1kKizkLgU8MLtxZlHsXwELFZLio5IjEvDMZaN2kLIypIH8cHnvv4?=
 =?us-ascii?Q?fIwxbwc1nxfdVaxH8Yg5tIWkigOBrljtgHSTivkzqWAVPfkC+boZQWIHsGfK?=
 =?us-ascii?Q?z4fFMbaTi+kRL68UFOgQwuPdyjB0HEzf0fKSzasYIl7FjGee9iPlxfwoFp+T?=
 =?us-ascii?Q?V1gDyJAYB6l/BS0XX6D0pJ5V1t4l+6CoEtDaZZhiXy33WPdlWwPbj8AmuVpM?=
 =?us-ascii?Q?3sRdBP7JTXymPJJN2f72cgROLiytMJj+VcssEjtQu6z24JAHDJii77OvUvik?=
 =?us-ascii?Q?H1+kxxtiqn1cZjSucwcbdytMbwhnbmPOgIh70q/azlzzYiwsS3mmjxrNohHh?=
 =?us-ascii?Q?Idxf3toGvzb8Roo4phF3bdBsepzrRX5aH3rOxZVJ32pyyS4nRtl1n9JOab9I?=
 =?us-ascii?Q?56Iz60xNl5wgDEJxhH6IBAMTWmRhTuxE19B+1oo4IXIVvspe22C7cZEfuvmk?=
 =?us-ascii?Q?5CNREYE5vM//thwm5qIPkzVadQG872ZYDE0tJ0sNvGZFTnNOvu7P9HvHP8WH?=
 =?us-ascii?Q?BkKnqzzfGfgncd4TIt0BwPgtlJtrydAABLloANrxas4rzdG5HSUKwxAzYnIg?=
 =?us-ascii?Q?dzw+n4PVPazNHuLz6FbD/+a0oXqPTbqbN3A+J5vDIkzxyOM1vn92ynH66AcG?=
 =?us-ascii?Q?Vca32f84oFCUkO82ixIcwdpeacLqKDFFExiQuqCpnb//CvKGM4PRYh+zWksl?=
 =?us-ascii?Q?TbgDvylvuWqbmGNZWckPYbLeiWfKM7CTVA52z++JhiUXdxWUPKvAbrQHU6vN?=
 =?us-ascii?Q?fYsbuiKA5PV5+Jkri2IjmdESld6z?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(376011)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 07:56:42.7560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 861a3c19-26a3-4422-2271-08dc94232fe9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6450

Use the pt_dmaengine_register function to register a AE4DMA DMA engine.

Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/dma/amd/ae4dma/ae4dma-dev.c     | 65 +++++++++++++++++++++++++
 drivers/dma/amd/ae4dma/ae4dma-pci.c     |  1 +
 drivers/dma/amd/ae4dma/ae4dma.h         |  2 +
 drivers/dma/amd/ptdma/ptdma-dmaengine.c |  1 +
 4 files changed, 69 insertions(+)

diff --git a/drivers/dma/amd/ae4dma/ae4dma-dev.c b/drivers/dma/amd/ae4dma/ae4dma-dev.c
index cb05fcb47987..9ab74fc227cb 100644
--- a/drivers/dma/amd/ae4dma/ae4dma-dev.c
+++ b/drivers/dma/amd/ae4dma/ae4dma-dev.c
@@ -58,6 +58,15 @@ static void ae4_check_status_error(struct ae4_cmd_queue *ae4cmd_q, int idx)
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
@@ -117,6 +126,58 @@ static irqreturn_t ae4_core_irq_handler(int irq, void *data)
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
+
+	memcpy(&cmd_q->qbase[ae4cmd_q->tail_wi], desc, sizeof(struct ae4dma_desc));
+
+	ae4cmd_q->q_cmd_count++;
+
+	ae4cmd_q->tail_wi = (ae4cmd_q->tail_wi + 1) % CMD_Q_LEN;
+
+	writel(ae4cmd_q->tail_wi, cmd_q->reg_control + 0x10);
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
@@ -196,5 +257,9 @@ int ae4_core_init(struct ae4_device *ae4)
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
index 850ad1e49b51..668fad780314 100644
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


