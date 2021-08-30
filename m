Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540FE3FB334
	for <lists+dmaengine@lfdr.de>; Mon, 30 Aug 2021 11:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235971AbhH3JiZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 30 Aug 2021 05:38:25 -0400
Received: from mail-co1nam11on2081.outbound.protection.outlook.com ([40.107.220.81]:13729
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235621AbhH3JiY (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 30 Aug 2021 05:38:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoyX4ElivVWroDtkUO0QaDkT6PAw2ekNubPaTbiSFMKCL1suqU4z3/GHI8gSK8EzXrZXBXTVSzrszkW56Hk1r0G1Dc7+s8djFniCeypGFczhuJAlIyOuNCpzmiibGMObfLlNZf+2ZUj/A82RVL3beB0CFw6SSizo0G5QeVU0Qfm0Q1Z1NIeZHN9jXhBc5aQ3fY9Zye44LuHeP7u1GQKvJ5SOKywUHFx/3uu6cU6r4Qlqc9QT4qrjorqZB3TB9LGR2NbwsHnbTf4HdiqjGCwFwlBKzlDzqMpAd7u7ctaSOD1a7oAxq1LH1wGP1gWENj5aHfuncpHCgKIRSjmx3Ylz0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50tggsmfWGL+IBJSXElURIP/D3nTrIn2lLbT8PgEeuk=;
 b=GGJbLNEuCRo5gsDNADcboMeJ1c5kAes88cH84VjxRMJDXF1NIQcvPSvQl38Aohk53CaiIDpER9yIkBXSWtmps5VDEASkMl3RqomrgzPnDdcJl9TvoAE3SY7S9L1BuA6tZNLqiC3KxPgaO0+Wfyprso3PNKs67/60VrSPV6WAIDeXNMpM0WVJOkyspT3Lwr4Cc9doYoy+rUHOKMIWNRilIG/FybJgfxwhF+5x22FPpmuk7WUMLsFJc6LW5SD1IqbmY880I/rcRmJgA0++dbMrnqi6GAGrNrDvUFaz3+55cwB2Qlk94J14J5deaRVv3DX5INNquIFAsY4iimjrk3Z5zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50tggsmfWGL+IBJSXElURIP/D3nTrIn2lLbT8PgEeuk=;
 b=NtymUOx8kkSFjdjk+mTwT3FkG/PsgR8034xh0QtuXBx6l49uO4wksdGYo+MhCuNJcC4+vmygKXd3ebnwnpd/NY8xEolbmWxWNdBwL+HVThzjG3cJo1X6y11x3Kxq9NuoZqSnf4Ues+TMIcgcHyPhdu9K4S/0qz3vIXkFfRTW9n9Kd8SqJiQJUqmfVW77ZGi6Fq8cLM2U4znsTnCKxMo7YH1ZtCnNb1JMsqUJMnsdJNMnaL863sdOmuDcDaiyQyo5WI8XbWZP8luvLl2aBTO/HjJ0T7MlnvNGJmIrpTYo2DiLIGFb1X+yLB/HnL6Ud/zfVhUi2Hxh8Bj5PSlEkQ1YQw==
Received: from CO2PR04CA0129.namprd04.prod.outlook.com (2603:10b6:104:7::31)
 by MN2PR12MB3968.namprd12.prod.outlook.com (2603:10b6:208:16f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Mon, 30 Aug
 2021 09:37:29 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:7:cafe::2) by CO2PR04CA0129.outlook.office365.com
 (2603:10b6:104:7::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.21 via Frontend
 Transport; Mon, 30 Aug 2021 09:37:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4457.17 via Frontend Transport; Mon, 30 Aug 2021 09:37:29 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 30 Aug
 2021 09:37:28 +0000
Received: from audio.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 30 Aug 2021 09:37:26 +0000
From:   Sameer Pujar <spujar@nvidia.com>
To:     <vkoul@kernel.org>, <jonathanh@nvidia.com>, <ldewangan@nvidia.com>,
        <thierry.reding@gmail.com>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 3/3] dmaengine: tegra210-adma: Override ADMA FIFO size
Date:   Mon, 30 Aug 2021 15:07:01 +0530
Message-ID: <1630316221-9728-4-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1630316221-9728-1-git-send-email-spujar@nvidia.com>
References: <1630316221-9728-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7854255-eb05-4b38-69cb-08d96b99c8bf
X-MS-TrafficTypeDiagnostic: MN2PR12MB3968:
X-Microsoft-Antispam-PRVS: <MN2PR12MB39681F5D65FE5013B4D89C5AA7CB9@MN2PR12MB3968.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wWLMo3F35iylvFYMaVgKz9chi4Qt1YMvFi2D0//T4Mzxh2dD/9jVEopCo0Wtka/WcVvU/donjeN1s/myfVFVyj6rs36tpoMNZX4lpvJ3lkofFMOB82K0MFn6y7Fixqs7BhkZEFh/ySFlo2BJc1H3sQhFJz4mSuty9nlyzFOihippqLJQtCHMSuXpb6JWh8Kw2DTjLJjIND8+kHStLACv2xPZmBb1lruPdkqzL/K+nxSIaPrQUWzT3z6kq0apejPFwei0I1xTQrlrrSV6ocJ2CeMEpyRiIF8Rppdl7HXYy5ka79mUql8bl8znan8AR1BEfbIYFReuMWRAzbIjuL4uZp1Q+X86VXlYAXYg0r9NWpuIIZ4r2uGCyzHrEMpOG1eCr2qBV9cZJ12mqDoBjQDDONI9PW09HhrQnJ2Kqq0XtKSXWB5Es0ygHdbp2PC7CC+VQTOnMLPzu8P+x1X/iQK/hR0PGVVKRQ0SCyZTt0IJBDGFhmcVAFWJfEek1nDtGF3tfCCkxHhL9mMCowetf7riqAyNzCtAeX6S9uuoNON4jgNnoUJycQMexfXL+9j0MHDwvYhgFDj0+Z2s8n58zyAtAjyuzYVaj0KtpBOZue6NSC3VfMj2vQ+k3aac6B7MXuWtT5LBJs/0D4pRfc1c4s6e42s2oD2cOfxAc/yBS69VK/Mrg2IikyxHBitaSeZLjLD6aY7uEAsn/uA9lFtrr6d7bQ==
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(46966006)(36840700001)(8936002)(83380400001)(107886003)(82740400003)(70206006)(36860700001)(70586007)(110136005)(7696005)(5660300002)(36906005)(7636003)(86362001)(36756003)(478600001)(8676002)(2616005)(426003)(6666004)(2906002)(336012)(54906003)(4326008)(82310400003)(186003)(316002)(26005)(47076005)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 09:37:29.0692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7854255-eb05-4b38-69cb-08d96b99c8bf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3968
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

ADMAIF FIFO uses a ring buffer and it is divided amongst the available
channels. The default FIFO size (in multiples of 16 words) of ADMAIF TX/RX
channels is as below:
 * On Tegra210,
     channel 1 to 2 : fifo_size = 3
     channel 3 to 10: fifo_size = 2
 * On Tegra186 and later,
     channel 1 to 4 : fifo_size = 3
     channel 5 to 20: fifo_size = 2

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

