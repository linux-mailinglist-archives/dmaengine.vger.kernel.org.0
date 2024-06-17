Return-Path: <dmaengine+bounces-2388-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD2B90AABA
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2024 12:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FA431C210FF
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2024 10:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDFF18C326;
	Mon, 17 Jun 2024 10:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IFGumnjA"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA32190687
	for <dmaengine@vger.kernel.org>; Mon, 17 Jun 2024 10:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718618690; cv=fail; b=SNiBVaF4DHlUJrK5rMYCc+RjYlY966g08GXc/Sdl5X634P1welI58uboQMewaBorIQhtPKsq3pMRl7M4DM53An7L5xahmqKXF+JBo6sfv3sVlt8Ceo7CVplh5aDzBTLZmzcht5/jBQJeNdUdBo8wDFIySTLiICJpDI8xax9CAZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718618690; c=relaxed/simple;
	bh=ztpJmfqVbUOGa7W3TtDXm5JLCyZsKW71QvXxVyCBLBk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nza5y9d8A+zdGs84ftrOJ0vjwlDG9mvtwpe40m5Li1HBEpsqODwbJ23F52dhqDMLDJs8iWJCOM4C7weZnS5Uk70aaI2TjeEe1NZGHuzGP3OqGoda5x08fgrj0nMPG7EHRTLye2ApVqpXdrxhObXq3ZaSEuytNQrizIhl3qKArNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IFGumnjA; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/05LNvFgE++khURAQ4zCGvE3ezXS3r2meCDS/YsKlXG8t9cyXLoCJv7Ouu/GRD4inL3vzex9tvLe5iwo9Fg0ybXngNSnhxzAKzS5CAOUaBovkYSPMIBnYHE49qrHn1S+plTzqUdUkVGnRIvU5DZGNklsYDw+G0EVXvnS1Vkfreo8fvrEk8w9gXRq6Zi7USzGmO4bZIFvn2Hmr7kGr7yp/tLPkVUDqG5R/OEJDOtQOBlsfaiavFLqCk1mQ4LO3qg2LPxkDj0q82rzE0gq4F94vUWj9Ga0U+/WDIEewEhOaERPPrLxlVUXsplyLSyhj/eZGcxkCBhfC7s3qzczPFzXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYdWJctlb3s4wIMAPgocMmjQYrnbSaxKlcOZA4IhhCU=;
 b=ACVPKYUwkQpZjLD6rZ082x3N8Kg0+LgonN0u9PJ1GhX3W+CIvGVhr2XZwwWzOztf6nLTTDQsglQiSjqpBeBoY4qF0LW9Blk4pdTQvmUqDZftNPSHenbBHQPGz7HG5yz0qhjYi24v8v8dqHiOu5SPCboKLBg1Z85CpXYNwbxirEARD43GtOr70wniwFhaPz/fTgu17dT8xPO+ZZeFY/i+U6bLcvblp4YU94Hco6rscSDTfeBWoK6KU+L+jHPwvdjOGeakMYOBmoC5tyF/2Mh06/+mLjwW0qNOM2TJG/Eh0W7GZ88HRMrT0FZpKas6SNIifZdLEbG4fUDzKNpnNrMTNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYdWJctlb3s4wIMAPgocMmjQYrnbSaxKlcOZA4IhhCU=;
 b=IFGumnjAQqRdy5HB/ZMuBPQVVf3zaVdFMy67sG3BH4UeLnXGZla0TmRbSCJTznHkQontMEix79LBwxxfgb7jPDUG2ILHBuoGA6Il6rUJdnqEj3+PbQEMfych384PGCsEdBV2EkvUc+Pv912+5j60ZYc4xPb+8NARMjpJ5fsw3X4=
Received: from BN0PR02CA0010.namprd02.prod.outlook.com (2603:10b6:408:e4::15)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 17 Jun
 2024 10:04:45 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:408:e4:cafe::ab) by BN0PR02CA0010.outlook.office365.com
 (2603:10b6:408:e4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 10:04:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7719.0 via Frontend Transport; Mon, 17 Jun 2024 10:04:44 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 05:04:42 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, Basavaraj Natikar
	<Basavaraj.Natikar@amd.com>
Subject: [PATCH v2 5/7] dmaengine: ae4dma: Register AE4DMA using pt_dmaengine_register
Date: Mon, 17 Jun 2024 15:33:57 +0530
Message-ID: <20240617100359.2550541-6-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240617100359.2550541-1-Basavaraj.Natikar@amd.com>
References: <20240617100359.2550541-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: 16fedb41-7766-4180-7dab-08dc8eb4e9fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1W+6uh17qEIu9sgzRCO4U+RlEIMQxOzZ1F7uhqFaRJ/RqztN1wybQBotOmgb?=
 =?us-ascii?Q?oxcWyB/oCPkfeOwqe7FwZaV4YH9tYPBxGNlDP1krQzejaWX1IvImcROcnBSR?=
 =?us-ascii?Q?FSCAQR67SHyztEfoVjo14CgSt/91S7+JUox6ohvqY+Ioa/F2UOEw5+9N4pJH?=
 =?us-ascii?Q?KeLd0QTcHb2WdFbZrmL7Kt0LYJajxgUq0QuD8jTav/h0wU2/BevjEyJvmeRl?=
 =?us-ascii?Q?mzIkWt80kViDAuHGrdskjXYQXDzZyWCD3A1opV7kEQS9yY4s631MqK7PowZF?=
 =?us-ascii?Q?40WHDRXoXBmK3i0W6pudKjb9TVDFTOtNnLmW77hGh4HRGNcv6aBR2g7lIYRH?=
 =?us-ascii?Q?RED4/S5eHhuEuZRK73HTo6f4l9QmQUbLwVq/InqyDyTEqW2VXK9c3RF18arb?=
 =?us-ascii?Q?NG7yjdriN8+i3UO4tgdnqSBt/lyczeeDxcThZF6QB9ifyLx4vLJN5KmmXF6Y?=
 =?us-ascii?Q?u1RyaSRIWkqeBR1ZT4AhVXjjOpW7y0z038aAjniWuVF50FBPEAsOxibFtdOv?=
 =?us-ascii?Q?ngtMtvy511KYjExUJqTle8VyZ0+FyRTk+WV1vft0ceWepymGNdQSWWCBk78C?=
 =?us-ascii?Q?aXm7PdkNELHxCGdT+eKWSl2SbUnyXfjSry6TFeNEvzIwmPmM3+vmwSS40dVD?=
 =?us-ascii?Q?BZ0cV2L59VeeMU25zUdQb4Z20VmflqVznbARAhD5vY64qbvLGah+itJeTaE8?=
 =?us-ascii?Q?GDYt+AJnArvylUBGBXDcdmDArHhsqCoRLJ2m1RWYUfo3R7qAZVhmbaF04/7Y?=
 =?us-ascii?Q?vMjPXHV9ObV3GK9g7rs6BZO0PPKWZFei0EHwI1XNeiq9Xmr4gI0ZhwAJNRzV?=
 =?us-ascii?Q?2Dv4m2RTHzn6VcpeLf0RJvBfDPAJ6yeShJ8rKVUORrgTI+rNFy0e5YmSln3c?=
 =?us-ascii?Q?pQURNWksz4LWNYhfJpZx/+4c0T+YGqNYqB0X5zW5ngvcs7OByePBNz1IApMH?=
 =?us-ascii?Q?TJuzrOzvV+30962UZ76rL2MPoKIXm41VTXnELJ95tZVfxhnGwQdbbTT1Y9uz?=
 =?us-ascii?Q?Dn+rQj8vY7m2CR2KY3oX0UvFpMHqOMLDdf3IZeLoDXWrX0wj+93+Z61hUxvn?=
 =?us-ascii?Q?Tzwz2Qvr25nfmqd/4tSwtgood3bTs2/D0CVlm3Ds++CZf3XPg8XC5MRmvPBi?=
 =?us-ascii?Q?VLS8dThHM7In4gIlDD/e9f+lHNxmcITFWOx4F5B1Fvn024B7H2vL8GIHCGkd?=
 =?us-ascii?Q?eYtf7VcIrs7ECCXlj+fQ1wPd0tuv45Sh+vTv9n3Dzqqh9C3mrxEarxGGMWJV?=
 =?us-ascii?Q?TBOdE8Nm4tld/6dfvilYJxFZUDndNgt69QeGlqmL75L4ks1MPNPT+XqSoMfv?=
 =?us-ascii?Q?4/nymgo/iDr2Qhsa1UHW5/c15WPWMOPU0VyZDbMHiODg87a3x28jWOyZAlgt?=
 =?us-ascii?Q?dqZtBhqAcQhJLbH1YJGMjZay9vRRPxSuNPMoqb6V8Gdq/CdIMg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 10:04:44.9882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16fedb41-7766-4180-7dab-08dc8eb4e9fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293

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
index 958bdab8db59..77c37649d8d1 100644
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
index ddebf0609c4d..5450fa551eea 100644
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


