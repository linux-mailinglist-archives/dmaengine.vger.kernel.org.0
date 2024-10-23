Return-Path: <dmaengine+bounces-3438-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE989ACA1C
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 14:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5AC21F22795
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 12:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109A61AB6C7;
	Wed, 23 Oct 2024 12:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5UL1XaRw"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FA81AB51D
	for <dmaengine@vger.kernel.org>; Wed, 23 Oct 2024 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729687017; cv=fail; b=E5jDTol9OA1fPgzHEf1/65s+XeEcG25qjT9CUsBVxaWio9gYUHnMngnbxNi17HAcSZAHvUfYP/Yp6l/Aq4FpzI+CgmQorEdYOz2A19WPXQgsVIKtYmKxpO2JsFivlybCO/UHg+V3QVCcGgdxVRsiecQnLAvNrSijeuHBcztqsLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729687017; c=relaxed/simple;
	bh=Ej4AsB5TkDb842txp4gD5B0FOnLlwpx6ITd11CNr9dQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FU7RJD9ZqbBrK6hVB8Y7ap/M0pKqPsXXQOQ/CnWlsrj9HiP12LA8iVn/DswqDHwN4GV5oK+BhjQxbaUZ/3Q3K8ApYXqxMQG9HzJy6kUrJuK7a7Puhaj1jFSWyeTtJDirgtGWV+nmEuCsXO6Jrt+luYgLWLQ1AmptiJ6jZy9RNtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5UL1XaRw; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJy73YZPpeHE5KlrNfyZ7Lzx/HfJlbSGzXw8BkC1rafGtiLQfAB5vXdfSDXM4iU7d+lhc/QnQtaZm8k0l+PGXB2B3hbP5otcwMt63h+DKdqCumP1Ps9FDFvgSq+x4zmSbzq2V4Nx16seyZ/uaP240sf1pZr1T5U3XTVmMD7ud5XBsxItmGr6WsgHKGTYoM3jr9kAuHDQbZ95UWXuJvQQ3OBnswqmtIxFE7Jco1rle3ydf2Z+llZu4XM7fDhOxMULJHE8xHYgMvUqah3Jib8kABK7/3N78p7qtqI3O/f19yuiIj+02yntvycFmjvoDxUxsZ5aSEqIeHfcxz1wmd4LkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRYlp2yYdCI1pxL496q9WvvLWnIJHKkTUXpu9XD4vpQ=;
 b=QVB2Nx2dIqKjPTq6RUobNk7WDSFkGRDlLWd6YiN2kRJJO+DdsQK/8yYuzzfacvIga+6mqvYoz/shWGPIfBRzrtNDb9CtbvTPRLShjagAwB9tnCE7735oRP0ahUOJS8PQw7JrJzRnSBnu1rMguI505/L3buMnGdyUsGm3nXS3ZrjcvxqhrGZZrVUlYppMOQM2w9U0YctSfm1haTTJvbTzQLjc9NxxDSvzb8li1cueZE7T8hVDbNTSCI/7B7bt75/YGmWnzk9mR1AKTo1O9bwfsJp9RMkyFq61M2w0JU69COaP5Ly5sq98H+kejsCDIcop8lKgrMRuL9YGV4Bi62OTKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRYlp2yYdCI1pxL496q9WvvLWnIJHKkTUXpu9XD4vpQ=;
 b=5UL1XaRwy0qU6p2Z53+zNLn/z2FJR/nLLVBHQMjaZ0rFwPG2+RZf5938r1uVAh5DJ0J8XgCN5qVSAv0jm95qbJahMiNiMvLwhfAsqxz8cRZTKqu0FJCGzuGFvLFD7PFV60dLXn2AAYaHqEwR5RuzyQigHAqTr6MPRVOaHxmemxE=
Received: from MW4PR03CA0080.namprd03.prod.outlook.com (2603:10b6:303:b6::25)
 by DM4PR12MB7672.namprd12.prod.outlook.com (2603:10b6:8:103::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Wed, 23 Oct
 2024 12:36:49 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:303:b6:cafe::1b) by MW4PR03CA0080.outlook.office365.com
 (2603:10b6:303:b6::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Wed, 23 Oct 2024 12:36:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 12:36:49 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 07:36:46 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v7 4/6] dmaengine: ae4dma: Register AE4DMA using pt_dmaengine_register
Date: Wed, 23 Oct 2024 18:06:11 +0530
Message-ID: <20241023123613.710671-5-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241023123613.710671-1-Basavaraj.Natikar@amd.com>
References: <20241023123613.710671-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|DM4PR12MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c147010-0113-44a0-4671-08dcf35f5d46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b+h3JqOwz9cFYAR8xuIlSLjpvWt2dizDv/MSwjUf58AQFnxr3Twsfdhq7M+P?=
 =?us-ascii?Q?XSjx1KutwRIhKCMricN3ef3yUnIS+enFkOKKxskVyaUZwEUtPtCMRwGIg1rW?=
 =?us-ascii?Q?WkkNCqaoD7/OqqBaxBDgFLpSbpA+SAjm/0xLJqatntO4mJNFxpbNSM4AC4h0?=
 =?us-ascii?Q?UDU9hxJOw0duuKoOUmqVGNo1Kfe5odXDdPH5PPI3/8CGvu64iwDYV8UeQDgZ?=
 =?us-ascii?Q?O1Hbq+1OXc+g+tcBTnxSzoohpcQaaMVJxjukd/okK9joPjHz1OS8YCyDNKYp?=
 =?us-ascii?Q?rgOKJ0T6htNCXQ6VXSPf4mvd3jkipgCBbkRUj/TyWmbyXbO6MlZRoDj8+ueO?=
 =?us-ascii?Q?uPC3aIqIZD3/dJumcEYsovefh+Nve8FZRRrKy22xZLf3PQGplym5Imf5OAwV?=
 =?us-ascii?Q?py/4w9QNmQeDKwbInxH5cIaIPgJd+gPQ0/usvx49YcjVSVJDOknSp41EBpuM?=
 =?us-ascii?Q?vCd/DESQpki4kCX9jli5c5LjuTvgmVnRahjidOAED9Hm/N6nOZrg6EZO2I/5?=
 =?us-ascii?Q?TGGOzSj0FO0TzsUIVLmk3jmCt1HWAj0ux7fPrOAcM/4O7xURuG4dBiUTnwhV?=
 =?us-ascii?Q?u/Owsf9KyObh3K4YHRE3WLfRpyyq/zcHLloXYZyZ1jEPS0y9k0pf1EWPNlf8?=
 =?us-ascii?Q?HjEGKc3crUoZOOcBBHGDzwGl7LEWqXoqBD3yV4nEV22SHmKIpeJML5YUK5GI?=
 =?us-ascii?Q?gfHiYF9tFayPo4hClEnO67sTJ/qlMF4Udb8Pj0CD/qEtPDMCvUEgVpLDfXd7?=
 =?us-ascii?Q?EdkFuzkLsjf7s4/CM2KqQwFkkDu7mr7dDQbABjyabrvRTmQUMmSzI+P2kVjn?=
 =?us-ascii?Q?DXOZApkcexwZXsma/5+oxMNUHFYZCwZxF1lqydFO+z8/ka9rTKeUX6ly0B+o?=
 =?us-ascii?Q?SlA1l/Eg7aIgQ+Qm8CEc1+vQfH3qE4gODNfJ7eTBYrG+vfKavzIULFTojwIU?=
 =?us-ascii?Q?YugseecLqLYmpBeupYPtOg4CB7aalKVZod4KU/SGI9RHAZ/EAeG2uWqlPf7k?=
 =?us-ascii?Q?dwLeMLc5IJSi7dMcFYR4iNwKSUfDR4L5HrMppTv2GwnKIr+OyQeoXOI9Lqub?=
 =?us-ascii?Q?e0YhxSQXR0Z1GHmzgxul0ulzf3flkJwMbFqAms9bzHZ25XHIwby83E6RfQQ2?=
 =?us-ascii?Q?nQVVOeS465CwE1rbb+gcbH6JNHqHH1xXUP4OV8DywmnDVXpJqR1+JqODciOB?=
 =?us-ascii?Q?37PFVIk9XYkIVTaigf1AFrjJzF3uG23yBkle8/o6iuR1Zdjw0T0QImONXuTM?=
 =?us-ascii?Q?oFJQ3ndUgqnwQY9YbLOhiXsjsTJiCpfUWP/UkOWppbTGQ+vfqz+/pcT8awRO?=
 =?us-ascii?Q?PA9cGJr/tYuClUzpBBX5XoAEGWvmkylhT4XO+dFFdsZOvmta+ZbmoA8431BJ?=
 =?us-ascii?Q?7hkzeMrgdKnZfAGPW+co9503pigNk8N8vBccdg6kk/9HygTYVQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 12:36:49.1315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c147010-0113-44a0-4671-08dcf35f5d46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7672

Use the pt_dmaengine_register function to register a AE4DMA DMA engine.

Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
Reviewed-by: Philipp Stanner <pstanner@redhat.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/dma/amd/ae4dma/ae4dma-dev.c     |  4 ++
 drivers/dma/amd/ae4dma/ae4dma-pci.c     |  1 +
 drivers/dma/amd/ae4dma/ae4dma.h         |  2 +
 drivers/dma/amd/ptdma/ptdma-dmaengine.c | 68 ++++++++++++++++++++++++-
 4 files changed, 73 insertions(+), 2 deletions(-)

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
index e2d4bc8aa1de..f557b6f63632 100644
--- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
+++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
@@ -110,6 +110,53 @@ static struct pt_cmd_queue *pt_get_cmd_queue(struct pt_device *pt, struct pt_dma
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
@@ -129,7 +176,10 @@ static int pt_dma_start_desc(struct pt_dma_desc *desc, struct pt_dma_chan *chan)
 	pt->tdata.cmd = pt_cmd;
 
 	/* Execute the command */
-	pt_cmd->ret = pt_core_perform_passthru(cmd_q, pt_engine);
+	if (pt->ver == AE4_DMA_VERSION)
+		pt_cmd->ret = pt_core_perform_passthru_ae4(cmd_q, pt_engine);
+	else
+		pt_cmd->ret = pt_core_perform_passthru(cmd_q, pt_engine);
 
 	return 0;
 }
@@ -336,6 +386,15 @@ static void pt_issue_pending(struct dma_chan *dma_chan)
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
@@ -346,7 +405,11 @@ pt_tx_status(struct dma_chan *c, dma_cookie_t cookie,
 
 	cmd_q = pt_get_cmd_queue(pt, chan);
 
-	pt_check_status_trans(pt, cmd_q);
+	if (pt->ver == AE4_DMA_VERSION)
+		pt_check_status_trans_ae4(pt, cmd_q);
+	else
+		pt_check_status_trans(pt, cmd_q);
+
 	return dma_cookie_status(c, cookie, txstate);
 }
 
@@ -512,6 +575,7 @@ int pt_dmaengine_register(struct pt_device *pt)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(pt_dmaengine_register);
 
 void pt_dmaengine_unregister(struct pt_device *pt)
 {
-- 
2.25.1


