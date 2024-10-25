Return-Path: <dmaengine+bounces-3572-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FD29AFF5C
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 12:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE21E1F216C3
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 10:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3A31D5ADD;
	Fri, 25 Oct 2024 10:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3ZqgtU8k"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2086.outbound.protection.outlook.com [40.107.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA151D8DF8
	for <dmaengine@vger.kernel.org>; Fri, 25 Oct 2024 10:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850451; cv=fail; b=gRZLOCosGJjPIIMEEoiKnE+9rE4kS8thXCYbECmwkMPpF2/oTrNwnIRxEfw722MlGdnUj7k85ZinohOCX+gCse6FOVlHlgr1grUaoCe9dPCMe5nNqrpGSZTTyOOA3jK++Rra20EQHm+NEhRUedjqRyBAIu12gyT3Okc8PL786aU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850451; c=relaxed/simple;
	bh=s7l0vnUJ2kbH9RlYmQU9+5RbbmzH5BzHiYW5U40YD5M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BqO7cHGgr+CDqO5E7KBJCzhcs+BrxCZJVKp7S28Kneg8FfYp9998BiYT7mkqtJn0QTFozgwjsjNbGCUXtDw0Q6Y60LY37AEw3CK5Vhnjkv6Xx1m53sMb/KSC92LDKxIZyw/3jcylRUFCjb+TAXq5NHUUcDHKxMYjVIikddyYAPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3ZqgtU8k; arc=fail smtp.client-ip=40.107.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGfXOJY6OlvRyMgQ9u/JLePNQfxB/Y0gx9OOIGD82Tl7NcbSNoxxO9QhP4DxGLVEKZ2V5qpSDEPegLf66GZDdbYqkca/nd2K3nkJN2aG7ZLr2KhFAAAdEaUW2iXmiiV2U6Y7rmUbO+kwAAcLCXQb5fnMIKASuldIZAjPtBS3Br9JLBtNVC1rc95INB5L0EQqVrBD9UumZVz72Zkb39p5ivsdJASwalgySGu/86u9eQtD42E659H0j+QpdxIiWYEvN8BFSO8Zfk1N0//1EipBHZTqTJkawWmf26Au/K91XxKebfhVuNwotvgIA6g1fWQZP/kvgYoZmdHjEpROQeJ5gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tRb+F4jQF8eAXLs69TYO07dkn3sVqOZQScQ6lOFS8w=;
 b=c6Fbg9qCzv39hoM4IJeL+3b/jzyDNN+4vCpMGAjUSsubcgDwNV90lr0byN6G+lK6oJYNO8fuawuhIvrhC4iAkUU9HYMhyncl8D5O3cemdV+J4/Haln+mRG1zNZeHagOQfjzgkxMB2n8KkNOmQUpCSg//c8/diSOtfNTbwOAChpYtqogZzqFAQSwNvhMZVI71y3aS0OOAe7uXSLh9IlDCYgsFybRUzBfvj6jmmRfpi4tmmcAMh1e60T9kROGfuvUVmtnWyWDidqFTmwMK10jZBRMSSfYrCOi0ntyRC8xvn87PCd7Rqr6UMY9nRtnCyrIb2sw0bCu8Qr+7ScQ486KGog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tRb+F4jQF8eAXLs69TYO07dkn3sVqOZQScQ6lOFS8w=;
 b=3ZqgtU8knzGq78GarAnvNpoXzvRBC+d4HR1y0OXGEj/3yh23VQ8BLApj/mgS2g2515X5Ga3Idjz/MQoy/Ob4OpWal7dQBbOKN02poAldS3MFpsCO3eLnGq/rAbMcqR9sq/y84DYftY0an6U9luVNfqjGZIgQEBCifpzzEqlQDNs=
Received: from BLAPR03CA0075.namprd03.prod.outlook.com (2603:10b6:208:329::20)
 by SA0PR12MB4365.namprd12.prod.outlook.com (2603:10b6:806:96::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 10:00:44 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:208:329:cafe::20) by BLAPR03CA0075.outlook.office365.com
 (2603:10b6:208:329::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21 via Frontend
 Transport; Fri, 25 Oct 2024 10:00:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 10:00:44 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Oct
 2024 05:00:42 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v8 4/6] dmaengine: ae4dma: Register AE4DMA using pt_dmaengine_register
Date: Fri, 25 Oct 2024 15:29:29 +0530
Message-ID: <20241025095931.726018-5-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241025095931.726018-1-Basavaraj.Natikar@amd.com>
References: <20241025095931.726018-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|SA0PR12MB4365:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fcc2c38-7ba0-4398-65c3-08dcf4dbe482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mFix3BhPwMYzDT9f+nTlblofnSsWq4B2vlBq8TxjLhoAsR5/Nr1Gm0B9peRJ?=
 =?us-ascii?Q?eZlbp68cCBabVWkBay+64krj1+RgAnSJJhtn5wIJj/iTvzvpE6jluU2XeAaR?=
 =?us-ascii?Q?6sm2gitIEKtSAAnnTPxwCWS67oq15KWY1EIz+E38uNunULBrj8mlbHuFvTHS?=
 =?us-ascii?Q?B6ow51CluQF/gCXCaBu5yCnZyCzIsirgpGYE8qDFlnpXQs+H8I1T1I4DY7LG?=
 =?us-ascii?Q?rk1Vnl4DAYPvnHW7uXmINbCcEz+BeltYzoagkcBvVCicKfhXKPfhe1f7Pljd?=
 =?us-ascii?Q?XJ+fQ3cjJAPyY8TcUnvK9RJW2XGCXJdWolc9lLV2gnWKXfnOeeCKKpSkC5gU?=
 =?us-ascii?Q?8UQQV2novRjbd9IZnY4HQvcUPtFJXZ4Kf8GYmoM0cT0sEAiiq09DE7uckfOZ?=
 =?us-ascii?Q?37pK8w2U/N5JQuCa+cZxASf49cn4EkRSWMmWEb68MdzwfVRFjx3HiGYaRPPt?=
 =?us-ascii?Q?3g/wg6jFnRNQEQNWq5Hy4QaWPbcI4LOJKThsDeKw3zxWS7Fo37xq8Nr58cz5?=
 =?us-ascii?Q?uKcTTMXdQc3F0McSVmS/1CswkQ53bXit/96l3z43+SaSbzlE/xzv0SIH+wRj?=
 =?us-ascii?Q?SjuSrOIuSIPEzEBgyqJi8gyevkOjXm+hAhAZTx+d9pDUYszKZSjC/NXWZN+d?=
 =?us-ascii?Q?qgSi9reDdRe5Q+XsTfy+ZeOBOBjW9E13c3ZwJ9ZLpqmxsvKHPKNrU6+tKvGD?=
 =?us-ascii?Q?v0vk2oZSdAiY/MVr00c7n+92ILJ94JjIqfvIbq+SMtPMy8Lo124G/4bDRLp9?=
 =?us-ascii?Q?t190L+1PjB8Wuw9jCRubWlYSdYcALjStfkXkFyomtqU5f3lm3WoRLSJyR6Sg?=
 =?us-ascii?Q?KgfaMVQWe04F7E2FoCv+wxbYoD70Nwb1Dgc2BMfUFrv+RVtxgvD/e274PTpJ?=
 =?us-ascii?Q?NXbvkq2dTZeDRczPFlWrkcd/NHttl8G0Ban2L2PN3YSJoNrI272g9p349VOn?=
 =?us-ascii?Q?OtxVtvJFUBL8NY6IvTqlJTzcw1AulCQi/z+EwRns2VU+hwNJ1khpKB735noc?=
 =?us-ascii?Q?sQk2i5eCcCNW/U7Ht/Q8pJe5kCeBRP/XDJlZsT9ejSt9P9M0rehizPyvetOC?=
 =?us-ascii?Q?D323f0h/HbiDFNeKGspadWuAKt3EtWZOfeV8OSffD07tKHJWfFjknpP8wX53?=
 =?us-ascii?Q?9xx46IXyjMCwoJdy0zbYi9T2ybN9wr1mwQuhlNr4txAZXGtRvj/9SMeDEkt9?=
 =?us-ascii?Q?6mVoBkYBItMN1LISRtz/+e8QOVtmjgXuPsyGclxwTeILog3/Ew6OKqRsrAXK?=
 =?us-ascii?Q?KwTuC8KDFdw1rnaw8x4Q36I5juCfBXgBqsBNu/js5akSZL/803Y1sB/eTUmt?=
 =?us-ascii?Q?Sohqcw0cvWGr7rhClPFQNxyzvQILZOFuO4qhpl34atAdhzeDerM5PQ6pBXaR?=
 =?us-ascii?Q?hRhf7gqPBnLfHplEyQa1xgO4ONkAeTbjBPNCA3ENpENWkmUVEQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 10:00:44.7127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fcc2c38-7ba0-4398-65c3-08dcf4dbe482
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4365

Use the pt_dmaengine_register function to register a AE4DMA DMA engine.

Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
Reviewed-by: Philipp Stanner <pstanner@redhat.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/dma/amd/ae4dma/ae4dma-dev.c     |  4 ++
 drivers/dma/amd/ae4dma/ae4dma-pci.c     |  1 +
 drivers/dma/amd/ae4dma/ae4dma.h         |  2 +
 drivers/dma/amd/ptdma/ptdma-dmaengine.c | 69 ++++++++++++++++++++++++-
 4 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/amd/ae4dma/ae4dma-dev.c b/drivers/dma/amd/ae4dma/ae4dma-dev.c
index 7cbef9e79f38..cd84b502265e 100644
--- a/drivers/dma/amd/ae4dma/ae4dma-dev.c
+++ b/drivers/dma/amd/ae4dma/ae4dma-dev.c
@@ -147,5 +147,9 @@ int ae4_core_init(struct ae4_device *ae4)
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
index 92cb8c379c18..265c5d436008 100644
--- a/drivers/dma/amd/ae4dma/ae4dma.h
+++ b/drivers/dma/amd/ae4dma/ae4dma.h
@@ -35,6 +35,7 @@
 #define AE4_Q_SZ			0x20
 
 #define AE4_DMA_VERSION			4
+#define CMD_AE4_DESC_DW0_VAL		2
 
 struct ae4_msix {
 	int msix_count;
@@ -55,6 +56,7 @@ struct ae4_cmd_queue {
 	atomic64_t done_cnt;
 	u64 q_cmd_count;
 	u32 dridx;
+	u32 tail_wi;
 	u32 id;
 };
 
diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
index e2d4bc8aa1de..35c84ec9608b 100644
--- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
+++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
@@ -9,6 +9,7 @@
  * Author: Gary R Hook <gary.hook@amd.com>
  */
 
+#include <linux/bitfield.h>
 #include "ptdma.h"
 #include "../ae4dma/ae4dma.h"
 #include "../../dmaengine.h"
@@ -110,6 +111,53 @@ static struct pt_cmd_queue *pt_get_cmd_queue(struct pt_device *pt, struct pt_dma
 	return cmd_q;
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
+static int pt_core_perform_passthru_ae4(struct pt_cmd_queue *cmd_q,
+					struct pt_passthru_engine *pt_engine)
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
 static int pt_dma_start_desc(struct pt_dma_desc *desc, struct pt_dma_chan *chan)
 {
 	struct pt_passthru_engine *pt_engine;
@@ -129,7 +177,10 @@ static int pt_dma_start_desc(struct pt_dma_desc *desc, struct pt_dma_chan *chan)
 	pt->tdata.cmd = pt_cmd;
 
 	/* Execute the command */
-	pt_cmd->ret = pt_core_perform_passthru(cmd_q, pt_engine);
+	if (pt->ver == AE4_DMA_VERSION)
+		pt_cmd->ret = pt_core_perform_passthru_ae4(cmd_q, pt_engine);
+	else
+		pt_cmd->ret = pt_core_perform_passthru(cmd_q, pt_engine);
 
 	return 0;
 }
@@ -336,6 +387,15 @@ static void pt_issue_pending(struct dma_chan *dma_chan)
 		pt_cmd_callback(desc, 0);
 }
 
+static void pt_check_status_trans_ae4(struct pt_device *pt, struct pt_cmd_queue *cmd_q)
+{
+	struct ae4_cmd_queue *ae4cmd_q = container_of(cmd_q, struct ae4_cmd_queue, cmd_q);
+	int i;
+
+	for (i = 0; i < CMD_Q_LEN; i++)
+		ae4_check_status_error(ae4cmd_q, i);
+}
+
 static enum dma_status
 pt_tx_status(struct dma_chan *c, dma_cookie_t cookie,
 		struct dma_tx_state *txstate)
@@ -346,7 +406,11 @@ pt_tx_status(struct dma_chan *c, dma_cookie_t cookie,
 
 	cmd_q = pt_get_cmd_queue(pt, chan);
 
-	pt_check_status_trans(pt, cmd_q);
+	if (pt->ver == AE4_DMA_VERSION)
+		pt_check_status_trans_ae4(pt, cmd_q);
+	else
+		pt_check_status_trans(pt, cmd_q);
+
 	return dma_cookie_status(c, cookie, txstate);
 }
 
@@ -512,6 +576,7 @@ int pt_dmaengine_register(struct pt_device *pt)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(pt_dmaengine_register);
 
 void pt_dmaengine_unregister(struct pt_device *pt)
 {
-- 
2.25.1


