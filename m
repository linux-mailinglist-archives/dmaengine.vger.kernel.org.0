Return-Path: <dmaengine+bounces-5260-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8D0AC33CD
	for <lists+dmaengine@lfdr.de>; Sun, 25 May 2025 12:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F03DF188AD84
	for <lists+dmaengine@lfdr.de>; Sun, 25 May 2025 10:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D151F03D8;
	Sun, 25 May 2025 10:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Nf7OwBBK"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5C8BA42;
	Sun, 25 May 2025 10:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748168198; cv=fail; b=TPp/SwZWh5fquNKGaPNkXYOp3m7nNSZeNiACXu+VpCdkDjRUW/6/EQ8d7yh+SvY85drY6oPrQ2qbrJx7UaN4qfrGonIertZhY2wmHsDj6wx4HC7NMXj1hbyJo5ALTsZ5wgRBaAawIFjzMzyHC0V3yYcfVxoDjcH8qUh4NVz99fQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748168198; c=relaxed/simple;
	bh=ti++qP2SxbCr94b+06dVpNQ9tNLbZ2ONqCbu72CQOmE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FhQrODlm8iT12PoG0WAPT9zYuRRV6N5dZbPPpDj4zseKX5gWsuBkgw3cCHddncwZwW6IGJVRxiZFbaY42VJPK2Rm8gnG6DbuxiWb/MEDI1YwQxaZBESZUBTynIeh4zt4tJNKE0+sO3sRi/80P1gsjEP6EGHqLXYmslUwVPKHBQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Nf7OwBBK; arc=fail smtp.client-ip=40.107.237.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFSxjE0aVdCf5qOf4bYAqqXrkOV/DLEqef6P9uFVguRVm94YthYzXa/pYFVZLS56M7oDZJBdoBnq+U6yfiV+2U8PhdpZPscYpdK+RZzVxgNT+RCBDNm2ZMpLjnadDkRzs3NTncRou5EJ5B2/H5qV6buBBUW0TW6AgzL+jzg/I/qQYovNu9unvpi19oGChDdMffmfpw+sxc1XXJcoReponbo4/v6v6gHPEHmBfYfMvTi4tFdcGGzd/9yfPJoaEXjOTY4fXf75Yrh6VO3gLmAs8GdSWxY3rBXnUMrW9dTjqKeVwGLXkGHUOOzAhlbyj7YkTSCQQYYn2Rfou907fr25mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izlEIQwUeKrajRtPKUwber5TbtMd+1HlD92TZXy7rh8=;
 b=FKIy2laTVzrYdnFMWYYDJisWxO9IlsYZiIoGJ5bspS9Hc39lE8dtR1D4jcASOpfAGspdKzJWO6V8WUbLj7NcXhdyQeHRlWooPpAn2Y1DHTMLxt+RyUXSA0fpOqv/QUkd8j75WzMr2CEc42Ym+nG2n3TzDa9sHFNMB4q1L00z3fd05JHBQDeFXWmiv4HQPvCH/6rQpl8xq4JqlEeqhRMqIAYpRFWxj036HyRXv5F2tEwPCLH+DlwgOEn+aY/2zYR253EqQVbSfPVTxucgqC2lVnkfVrvEU8EI96a7yIXT2ElbGNrFTfYsA+FbSQOg8PO860OkJFNFWvcb7rGgC9MaLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izlEIQwUeKrajRtPKUwber5TbtMd+1HlD92TZXy7rh8=;
 b=Nf7OwBBKpznfj4JQdzlCrO+5LZIPuHHPsE3Bip5RlnBaHWywDt4+6uozLC6Z3jO+6WaCtF6XoELcH7QuhtgJisvoS8InH/a0ksaaIP3+R3YwfZftWchIysGbhjONWMuZoNFVswhbB4JCn0BOwMHWZmfNPB6VOm9kW6mzW5TTmN8=
Received: from SJ0PR13CA0014.namprd13.prod.outlook.com (2603:10b6:a03:2c0::19)
 by MW4PR12MB5601.namprd12.prod.outlook.com (2603:10b6:303:168::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Sun, 25 May
 2025 10:16:31 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::84) by SJ0PR13CA0014.outlook.office365.com
 (2603:10b6:a03:2c0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Sun,
 25 May 2025 10:16:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Sun, 25 May 2025 10:16:31 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 25 May
 2025 05:16:30 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 25 May 2025 05:16:28 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <vkoul@kernel.org>, <michal.simek@amd.com>, <radhey.shyam.pandey@amd.com>,
	<thomas.gessler@brueckmann-gmbh.de>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <harini.katakam@amd.com>
Subject: [PATCH 2/2] dmaengine: xilinx_dma: Add support to configure/report coalesce parameters from/to client using AXI DMA
Date: Sun, 25 May 2025 15:46:17 +0530
Message-ID: <20250525101617.1168991-3-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250525101617.1168991-1-suraj.gupta2@amd.com>
References: <20250525101617.1168991-1-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: suraj.gupta2@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|MW4PR12MB5601:EE_
X-MS-Office365-Filtering-Correlation-Id: b3f0fa65-ed8a-42dd-6a83-08dd9b75385f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WA8g2uxEXoi3gYYQt75FOx8xOtgQxPyx1652anJp7dowfZXEvsPKwLFIry2/?=
 =?us-ascii?Q?ybSaRkuHHg5No6KDbcXmjaWds9OyFd0F98T+YlUxOp4sioBufcHcKCS1s/CR?=
 =?us-ascii?Q?8jv5T7hdWwGeUf4ZDVCU4yRLKRwSI+AqzpvzwcDZGke/rPVahQeex3lA+NFM?=
 =?us-ascii?Q?Ol0SdBpVff6p+983Q5vpFAYMa3d190Nvo0X8UZvjnbLPTLkARv0chfZ6zjKL?=
 =?us-ascii?Q?7QE4zcJBdU4VFTDES3wQJr0ly7PoxwpCcaS6qcZDT5WX+bPZSCMKXO2rpYp0?=
 =?us-ascii?Q?k/d2hVqiMrEU+vioRvtHjSFSs5qSzpuq10koE20+ToD6VxbpeyTgeWcd6ndp?=
 =?us-ascii?Q?+ff6woDa36Qmnp1Yzor5oZJnKvOREMbZj/sniWofz6eEFt7ktJ8NWISwN0BN?=
 =?us-ascii?Q?mVPwJ791j1D5rfj9BreA2/tXEqnWI8U1yvQ0ORTzVlAAQQ3l6SkQ43deI260?=
 =?us-ascii?Q?d4NSgh3zzQVeXx2bizBlMCPMaLmez29ijXQzcnOsO1Y0ZP4hqcnT/6UkLm6s?=
 =?us-ascii?Q?4kpei9kZE81XyjGTwiB7BdsYrMYXNbo0DV0YJdTLukIitcumi1N9rMnrODtZ?=
 =?us-ascii?Q?NCh7p3qsf774nGmJ9ZP40+cQcrnzrPTyP2uEGADVwWtbAVVdBdC/yBJ5Ut/4?=
 =?us-ascii?Q?K+lkdSmuT6U6aGXYLiVb5OBxCnMg4oC2fu/lx038u3raaS/GDSAVcSSKh8XV?=
 =?us-ascii?Q?1lNzfjzhuRmqC0I6VNke1LhkMg318gvA0MFiW9P/0oB94bs+HLVEaF/DyCwh?=
 =?us-ascii?Q?k4/yJgQq6CXekkGgOZQqMDDDrKT1ldbpsdbJcrRhFe1HRDynz55zfU4vYzkF?=
 =?us-ascii?Q?f1OLTJiw9F7RcfEUw4XxXk7b5pxcYe9AYPrQzQOItAuUOyunFTbaJ7biPlYG?=
 =?us-ascii?Q?XbGiyoumVRlt5wBCmVYdYksWJypecQPIm8dvkuUHO9yFxMAKrl2/BE7SAqc1?=
 =?us-ascii?Q?sMAwJinlSDLcnFQ9zCXveyiKY0JmTQS48RwmGmEr0tHiOd97f8X5hJ87LwKY?=
 =?us-ascii?Q?N7RSRNpKu7Pk5P5cOTACmHzyioWR3kKoohtS4t7CC8yUr8dv20afKQhFYn/H?=
 =?us-ascii?Q?BNtwnEGu+I1XMG9eeiEJRwlgqcq6BNKccVkcZzLGFsrl00vfBYuwbO2JOY+3?=
 =?us-ascii?Q?SXgNC3jilF+LnYN1N1lYYyJVM7xnGuAl718UK6ut6Bg8TgyAKVoKXSDG3g7G?=
 =?us-ascii?Q?uEo5XBtQzLXcZROLGe0llrTeJt4EYMDFpOYSn9PiI2zWDoy42MT5LqKbIkcc?=
 =?us-ascii?Q?je/lIzZh/YF4XAG+3xWi6iFQKRUB1eqUFvZ4rr5yeXLiOrhda83QZw62av6e?=
 =?us-ascii?Q?i+A+T9R69MPKNgm5GMsTpmmT2AK8a1+XlY6PcU297MMX1gCIvIGytIK6wdX+?=
 =?us-ascii?Q?ZcF+/CgezLCiQU7PW3h+ng01egHVZKi6UeE+ysZmcEINz+zFAOwpImwUjDBV?=
 =?us-ascii?Q?8jQJDL1aXX10SjtfzUD1ic4U7RtQwu9t39/Wlu9oDSaVVBE20jQSBLgMqJ9a?=
 =?us-ascii?Q?7THluC4SMO3sd+CNjh2PiRyHVOEtf/D4p6xQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 10:16:31.4478
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f0fa65-ed8a-42dd-6a83-08dd9b75385f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5601

AXI DMA supports interrupt coalescing. Client can fine-tune coalesce
parameters based on transaction load. Add support to configure/
report coalesce parameters.
Change delay setting to scale with SG clock rate rather than being a
fixed number of clock cycles (Referred from AXI ethernet driver).

Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 62 ++++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index a34d8f0ceed8..b03975b6f00f 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -159,6 +159,9 @@
 		 XILINX_DMA_DMASR_SOF_EARLY_ERR | \
 		 XILINX_DMA_DMASR_DMA_INT_ERR)
 
+/* Constant to convert delay counts to microseconds */
+#define XILINX_DMA_DELAY_SCALE		(125ULL * USEC_PER_SEC)
+
 /* Axi VDMA Flush on Fsync bits */
 #define XILINX_DMA_FLUSH_S2MM		3
 #define XILINX_DMA_FLUSH_MM2S		2
@@ -403,6 +406,7 @@ struct xilinx_dma_tx_descriptor {
  * @terminating: Check for channel being synchronized by user
  * @tasklet: Cleanup work after irq
  * @config: Device configuration info
+ * @slave_cfg: Device configuration info from Dmaengine
  * @flush_on_fsync: Flush on Frame sync
  * @desc_pendingcount: Descriptor pending count
  * @ext_addr: Indicates 64 bit addressing is supported by dma channel
@@ -442,6 +446,7 @@ struct xilinx_dma_chan {
 	bool terminating;
 	struct tasklet_struct tasklet;
 	struct xilinx_vdma_config config;
+	struct dma_slave_config slave_cfg;
 	bool flush_on_fsync;
 	u32 desc_pendingcount;
 	bool ext_addr;
@@ -1540,7 +1545,9 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 {
 	struct xilinx_dma_tx_descriptor *head_desc, *tail_desc;
 	struct xilinx_axidma_tx_segment *tail_segment;
-	u32 reg;
+	struct dma_slave_config *slave_cfg = &chan->slave_cfg;
+	u64 clk_rate;
+	u32 reg, usec, timer;
 
 	if (chan->err)
 		return;
@@ -1560,19 +1567,38 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 
 	reg = dma_ctrl_read(chan, XILINX_DMA_REG_DMACR);
 
-	if (chan->desc_pendingcount <= XILINX_DMA_COALESCE_MAX) {
-		reg &= ~XILINX_DMA_CR_COALESCE_MAX;
+	reg &= ~XILINX_DMA_CR_COALESCE_MAX;
+	reg  &= ~XILINX_DMA_CR_DELAY_MAX;
+
+	/* Use dma_slave_config if it has valid values */
+	if (slave_cfg->coalesce_cnt &&
+	    slave_cfg->coalesce_cnt <= XILINX_DMA_COALESCE_MAX)
+		reg |= slave_cfg->coalesce_cnt <<
+			XILINX_DMA_CR_COALESCE_SHIFT;
+	else if (chan->desc_pendingcount <= XILINX_DMA_COALESCE_MAX)
 		reg |= chan->desc_pendingcount <<
 				  XILINX_DMA_CR_COALESCE_SHIFT;
-		dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
-	}
+
+	if (slave_cfg->coalesce_usecs <= XILINX_DMA_DMACR_DELAY_MAX)
+		usec = slave_cfg->coalesce_usecs;
+	else
+		usec = chan->irq_delay;
+
+	/* Scale with SG clock rate rather than being a fixed number of
+	 * clock cycles.
+	 * 1 Timeout Interval = 125 * (clock period of SG clock)
+	 */
+	clk_rate = clk_get_rate(chan->xdev->rx_clk);
+	timer = DIV64_U64_ROUND_CLOSEST((u64)usec * clk_rate,
+					XILINX_DMA_DELAY_SCALE);
+	timer = min(timer, FIELD_MAX(XILINX_DMA_DMACR_DELAY_MASK));
+	reg |= timer << XILINX_DMA_CR_DELAY_SHIFT;
+
+	dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
 
 	if (chan->has_sg)
 		xilinx_write(chan, XILINX_DMA_REG_CURDESC,
 			     head_desc->async_tx.phys);
-	reg  &= ~XILINX_DMA_CR_DELAY_MAX;
-	reg  |= chan->irq_delay << XILINX_DMA_CR_DELAY_SHIFT;
-	dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
 
 	xilinx_dma_start(chan);
 
@@ -1703,9 +1729,28 @@ static void xilinx_dma_issue_pending(struct dma_chan *dchan)
 static int xilinx_dma_device_config(struct dma_chan *dchan,
 				    struct dma_slave_config *config)
 {
+	struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
+
+	if (!config->coalesce_cnt ||
+	    config->coalesce_cnt > XILINX_DMA_DMACR_FRAME_COUNT_MAX ||
+	    config->coalesce_usecs > XILINX_DMA_DMACR_DELAY_MAX)
+		return -EINVAL;
+
+	chan->slave_cfg.coalesce_cnt = config->coalesce_cnt;
+	chan->slave_cfg.coalesce_usecs = config->coalesce_usecs;
+
 	return 0;
 }
 
+static void xilinx_dma_device_caps(struct dma_chan *dchan,
+				   struct dma_slave_caps *caps)
+{
+	struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
+
+	caps->coalesce_cnt = chan->slave_cfg.coalesce_cnt;
+	caps->coalesce_usecs = chan->slave_cfg.coalesce_usecs;
+}
+
 /**
  * xilinx_dma_complete_descriptor - Mark the active descriptor as complete
  * @chan : xilinx DMA channel
@@ -3178,6 +3223,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	xdev->common.device_tx_status = xilinx_dma_tx_status;
 	xdev->common.device_issue_pending = xilinx_dma_issue_pending;
 	xdev->common.device_config = xilinx_dma_device_config;
+	xdev->common.device_caps = xilinx_dma_device_caps;
 	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
 		dma_cap_set(DMA_CYCLIC, xdev->common.cap_mask);
 		xdev->common.device_prep_slave_sg = xilinx_dma_prep_slave_sg;
-- 
2.25.1


