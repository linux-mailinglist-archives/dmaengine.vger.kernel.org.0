Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E532140C9C4
	for <lists+dmaengine@lfdr.de>; Wed, 15 Sep 2021 18:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbhIOQIy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Sep 2021 12:08:54 -0400
Received: from mail-mw2nam10on2061.outbound.protection.outlook.com ([40.107.94.61]:46433
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236847AbhIOQIn (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Sep 2021 12:08:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzfvPU68eqy9EkxamKdAatoUp9MWWFCBw7JDEeO8/196YRIYAzV+GoHCusS9nPAX9NJiPGoI2mUwX0gskLkQMJWjPS5FHKwD3WZWT7M87wufJQz7dVa6hkilEWSnocMnEMYHa2I09iZUaUuoxB7woP9uWD1RmIl+f7drNG5TCwJEN5gGa0lSHQB6eUo6bPts+wza1TEinwwVfsqpmk0JSZasNeQz1C0tbvE1AYbKic61opfNBz1WZvuxHHGU97zny8Io1bUscfYRpqO0v+E2T/gFP9FoJrjLqK+J8wfbV27K2HuRL1lD8UacWLQxKZghDmV4XSr+yuywJVjo4hQPdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=OpXQJ08PSTw9sMnbLT/iyjMGkg/RcxTmwYosjmSqCng=;
 b=hw9dJqTAzv36e5Q8VeQCU+ccr4DtA7G+6zdBWgeBrLIU5aSDTu2+fN7Y2lGHVTVXSiGVZTdGt06B1nZR1h1HQ6c9Mx1/aS77XWczReiaRwFTvA3Wgkg3TUvX0bm88/1wB6m5r6PFQ6ODIjz+DXtG87R3VY/b0Pfr3/z/H3ZdNS9/jPqigbABASqXtp7gHVJTHTjO5VIfMOmxJQvTM5XPtY/cuZjiNhVNQYDv3A637MUU/tFpZR/hybXiUnhKmpbH8JfttDpXE1ZWzwjidbKyrRgsS9Ez81dHIKT9THts2XTqUTX7UXFhdIzw+6OaBVQgp+JXLVcEWF9VJiJvO7wz+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpXQJ08PSTw9sMnbLT/iyjMGkg/RcxTmwYosjmSqCng=;
 b=EBoIiValaOaDpUJtVrn943l9gx/1Rdg+XsXRWn5GbJ/SbQeDGuDROJ3v0HopnXgb3RiGdoeO8yMnvXe6IJUcupIP0OIoUpCA/TRvqiwVI7YB/KHYSIQCMU6yghPIGArpadl/yEFJD5UazhKhu7/vAx+LEqAsNv8vlDKseJtrkflA75Q13vH0MhnuFOLumnQkaaa8r1nlutLKWKL61Xnqf7aS9MxLAPl0ffhGKIjYI//qtSgHgCAyFtM55BPrQrT9CW3QXiAYMFOmokzxH/oiKdp6isu+yQDBm0Jv9UcbHhGABbC0lCpRMWudj1Qs+xnn/Mtwgs0EuAE1xGEL3zd9fA==
Received: from DS7PR03CA0305.namprd03.prod.outlook.com (2603:10b6:8:2b::25) by
 DM6PR12MB3307.namprd12.prod.outlook.com (2603:10b6:5:15d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14; Wed, 15 Sep 2021 16:07:22 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::c4) by DS7PR03CA0305.outlook.office365.com
 (2603:10b6:8:2b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Wed, 15 Sep 2021 16:07:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 16:07:22 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 15 Sep
 2021 16:07:21 +0000
Received: from audio.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 15 Sep 2021 09:07:19 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <vkoul@kernel.org>, <jonathanh@nvidia.com>, <ldewangan@nvidia.com>,
        <thierry.reding@gmail.com>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [RESEND PATCH 3/3] dmaengine: tegra210-adma: Override ADMA FIFO size
Date:   Wed, 15 Sep 2021 21:37:05 +0530
Message-ID: <1631722025-19873-4-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631722025-19873-1-git-send-email-spujar@nvidia.com>
References: <1631722025-19873-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfaf17f5-d365-416b-fb4d-08d97862e6d4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3307:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3307A444CBCA778000811CACA7DB9@DM6PR12MB3307.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /+siz2i8AzT4EmLosATXOp/bN9DVQxYgY9+KCaOTDz2I3b9LeVVjg2MXs1Mlph04nQdLrAsaFoEbNS2vlvyNPxygVQnstCEUW2yIXXFQGwo6+mRdub/Y+toaTZgSBC5wKNZ2qhx8esQdx91KNf/noeOSUCynUvOB/DTwl139xutrqp/qODkLD8xJe36O8LkGH0ex2sYBGkL6N0vDrO7srLesfxyd+Ard3F4kB3MVXL7GS/0kpU6t0lPFyX+eN6Ea/cwSwbo5RZoCLhkICa01ytkygOHVostW350f0iq9YLLoQOWEWBEOerWUC6Rc1O39f2OfPqCBuRWXSwoNggabEdnOxgHJT8qy449qwCRvxp4qLRiLXvmmNZKS8pfZY/EzW4V5E0uTbmZdOVxWCbjOUdYAuqSturkX58WTWM8v3jKLnPseZdc/93ngS/NbHuOk5olA0wNQrPaL2g8h87jnZH9s4xC1PMZ5Hr/4cVeFo4dDFMUpkiI+0ICOn/Y7jKEhy53DrQfZDmHthJ79Vwva4n35oGFwlxuf1eZKtckJjrG57yvAZCf0nXgjbNQ8zK/y9hQtyboVLH81tSrIMS2VQH8eBI5HZbzVRG6/sNO4e/GGDU+3fUsWcpGEq/b2850jpWoGC01hC2I7A9eJD2E7HVK1jZZSQC/c6dPOUHyasEMz51gAmu1dlDqesFJza8F4q8bEQnq1H+ryqX9KQmbafA==
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(46966006)(36840700001)(36906005)(82740400003)(316002)(82310400003)(47076005)(54906003)(86362001)(2616005)(36860700001)(5660300002)(6666004)(7696005)(70586007)(336012)(356005)(2906002)(8676002)(7636003)(186003)(70206006)(26005)(8936002)(4326008)(36756003)(478600001)(107886003)(83380400001)(110136005)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 16:07:22.3432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfaf17f5-d365-416b-fb4d-08d97862e6d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3307
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

ADMAIF FIFO uses a ring buffer and it is divided amongst the available
channels. The default FIFO size (in multiples of 16 words) of ADMAIF TX/RX
channels is as below:
 * On Tegra210,
     channel 1 to 2 : size = 3
     channel 3 to 10: size = 2
 * On Tegra186 and later,
     channel 1 to 4 : size = 3
     channel 5 to 20: size = 2

As per recommendation from HW, FIFO size of ADMA channel should be same as
the corresponding ADMAIF channel it maps to. FIFO corruption is observed if
the sizes do not match. We are using the default FIFO sizes for ADMAIF and
there is no plan to support any custom values.

Thus at runtime, override the ADMA channel FIFO size value depending on the
corresponding ADMAIF channel.

Fixes: 9ab59bf5dd63 ("dmaengine: tegra210-adma: Fix channel FIFO configuration")
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 drivers/dma/tegra210-adma.c | 48 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index 03f9776..911533c 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -43,10 +43,8 @@
 #define TEGRA186_ADMA_CH_CONFIG_OUTSTANDING_REQS(reqs)	(reqs << 4)
 
 #define ADMA_CH_FIFO_CTRL				0x2c
-#define TEGRA210_ADMA_CH_FIFO_CTRL_TXSIZE(val)		(((val) & 0xf) << 8)
-#define TEGRA210_ADMA_CH_FIFO_CTRL_RXSIZE(val)		((val) & 0xf)
-#define TEGRA186_ADMA_CH_FIFO_CTRL_TXSIZE(val)		(((val) & 0x1f) << 8)
-#define TEGRA186_ADMA_CH_FIFO_CTRL_RXSIZE(val)		((val) & 0x1f)
+#define ADMA_CH_TX_FIFO_SIZE_SHIFT			8
+#define ADMA_CH_RX_FIFO_SIZE_SHIFT			0
 
 #define ADMA_CH_LOWER_SRC_ADDR				0x34
 #define ADMA_CH_LOWER_TRG_ADDR				0x3c
@@ -61,12 +59,6 @@
 
 #define TEGRA_ADMA_BURST_COMPLETE_TIME			20
 
-#define TEGRA210_FIFO_CTRL_DEFAULT (TEGRA210_ADMA_CH_FIFO_CTRL_TXSIZE(3) | \
-				    TEGRA210_ADMA_CH_FIFO_CTRL_RXSIZE(3))
-
-#define TEGRA186_FIFO_CTRL_DEFAULT (TEGRA186_ADMA_CH_FIFO_CTRL_TXSIZE(3) | \
-				    TEGRA186_ADMA_CH_FIFO_CTRL_RXSIZE(3))
-
 #define ADMA_CH_REG_FIELD_VAL(val, mask, shift)	(((val) & mask) << shift)
 
 struct tegra_adma;
@@ -84,6 +76,8 @@ struct tegra_adma;
  * @ch_req_max: Maximum number of Tx or Rx channels available.
  * @ch_reg_size: Size of DMA channel register space.
  * @nr_channels: Number of DMA channels available.
+ * @ch_fifo_size_mask: Mask for FIFO size field.
+ * @sreq_index_offset: Slave channel index offset.
  * @has_outstanding_reqs: If DMA channel can have outstanding requests.
  */
 struct tegra_adma_chip_data {
@@ -98,6 +92,8 @@ struct tegra_adma_chip_data {
 	unsigned int ch_req_max;
 	unsigned int ch_reg_size;
 	unsigned int nr_channels;
+	unsigned int ch_fifo_size_mask;
+	unsigned int sreq_index_offset;
 	bool has_outstanding_reqs;
 };
 
@@ -561,13 +557,14 @@ static int tegra_adma_set_xfer_params(struct tegra_adma_chan *tdc,
 {
 	struct tegra_adma_chan_regs *ch_regs = &desc->ch_regs;
 	const struct tegra_adma_chip_data *cdata = tdc->tdma->cdata;
-	unsigned int burst_size, adma_dir;
+	unsigned int burst_size, adma_dir, fifo_size_shift;
 
 	if (desc->num_periods > ADMA_CH_CONFIG_MAX_BUFS)
 		return -EINVAL;
 
 	switch (direction) {
 	case DMA_MEM_TO_DEV:
+		fifo_size_shift = ADMA_CH_TX_FIFO_SIZE_SHIFT;
 		adma_dir = ADMA_CH_CTRL_DIR_MEM2AHUB;
 		burst_size = tdc->sconfig.dst_maxburst;
 		ch_regs->config = ADMA_CH_CONFIG_SRC_BUF(desc->num_periods - 1);
@@ -578,6 +575,7 @@ static int tegra_adma_set_xfer_params(struct tegra_adma_chan *tdc,
 		break;
 
 	case DMA_DEV_TO_MEM:
+		fifo_size_shift = ADMA_CH_RX_FIFO_SIZE_SHIFT;
 		adma_dir = ADMA_CH_CTRL_DIR_AHUB2MEM;
 		burst_size = tdc->sconfig.src_maxburst;
 		ch_regs->config = ADMA_CH_CONFIG_TRG_BUF(desc->num_periods - 1);
@@ -599,7 +597,27 @@ static int tegra_adma_set_xfer_params(struct tegra_adma_chan *tdc,
 	ch_regs->config |= ADMA_CH_CONFIG_WEIGHT_FOR_WRR(1);
 	if (cdata->has_outstanding_reqs)
 		ch_regs->config |= TEGRA186_ADMA_CH_CONFIG_OUTSTANDING_REQS(8);
-	ch_regs->fifo_ctrl = cdata->ch_fifo_ctrl;
+
+	/*
+	 * 'sreq_index' represents the current ADMAIF channel number and as per
+	 * HW recommendation its FIFO size should match with the corresponding
+	 * ADMA channel.
+	 *
+	 * ADMA FIFO size is set as per below (based on default ADMAIF channel
+	 * FIFO sizes):
+	 *    fifo_size = 0x2 (sreq_index > sreq_index_offset)
+	 *    fifo_size = 0x3 (sreq_index <= sreq_index_offset)
+	 *
+	 */
+	if (tdc->sreq_index > cdata->sreq_index_offset)
+		ch_regs->fifo_ctrl =
+			ADMA_CH_REG_FIELD_VAL(2, cdata->ch_fifo_size_mask,
+					      fifo_size_shift);
+	else
+		ch_regs->fifo_ctrl =
+			ADMA_CH_REG_FIELD_VAL(3, cdata->ch_fifo_size_mask,
+					      fifo_size_shift);
+
 	ch_regs->tc = desc->period_len & ADMA_CH_TC_COUNT_MASK;
 
 	return tegra_adma_request_alloc(tdc, direction);
@@ -783,11 +801,12 @@ static const struct tegra_adma_chip_data tegra210_chip_data = {
 	.ch_req_tx_shift	= 28,
 	.ch_req_rx_shift	= 24,
 	.ch_base_offset		= 0,
-	.ch_fifo_ctrl		= TEGRA210_FIFO_CTRL_DEFAULT,
 	.ch_req_mask		= 0xf,
 	.ch_req_max		= 10,
 	.ch_reg_size		= 0x80,
 	.nr_channels		= 22,
+	.ch_fifo_size_mask	= 0xf,
+	.sreq_index_offset	= 2,
 	.has_outstanding_reqs	= false,
 };
 
@@ -798,11 +817,12 @@ static const struct tegra_adma_chip_data tegra186_chip_data = {
 	.ch_req_tx_shift	= 27,
 	.ch_req_rx_shift	= 22,
 	.ch_base_offset		= 0x10000,
-	.ch_fifo_ctrl		= TEGRA186_FIFO_CTRL_DEFAULT,
 	.ch_req_mask		= 0x1f,
 	.ch_req_max		= 20,
 	.ch_reg_size		= 0x100,
 	.nr_channels		= 32,
+	.ch_fifo_size_mask	= 0x1f,
+	.sreq_index_offset	= 4,
 	.has_outstanding_reqs	= true,
 };
 
-- 
2.7.4

