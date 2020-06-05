Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4F61EF92F
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2020 15:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgFENdD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 5 Jun 2020 09:33:03 -0400
Received: from mail-db8eur05on2051.outbound.protection.outlook.com ([40.107.20.51]:9557
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727116AbgFENdA (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 5 Jun 2020 09:33:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKaQ2sClz7OW801SDgJ8S3C8Kpno+KPy/2rBVdWzojSJVLnJ4bX7B9QTeJUuj0QAbSLp35b0SNilNQJTgzUMDcCn76YYtHNg0uya4mnX8HjdBdW0kITMonbUjpxkd2iwz8sXeu7Q9rgAVgJC2BsLQ0paVPbwgLyIUK3wesTidZZzaV45bBc/8U/vSUw7Q3Km8i9+egKcW6KUlFJ/uDmcT6i4+WgzA+3kNhJQRTsCmKrYPV34sDPLuHN0Azx4XVwpKWmGbxv5gMPFpzi1s33uEwu10u2rdmRCN61RoOymwh2zgQ6+8Z9f6iSRP7MvmMQ3k/rpXurI1v+oISraAnVhIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiPkcC3B+QkXtXP3K0ZodSEVT1VTh7f/2ZXBFmj8Rpc=;
 b=lK/hr3GRANSuEGrB5lbJd5ZcNJrjUTVCmDu95hHGxF+K7AnLHCoCDMCcU0r2znbYV+4FClH2fi4TvXyKI2TmshEWvpdcKmkEThwLPw8Ql6ox3WO87xUPyhyiXPhB7dIfK1mh+hsepgRSXeLQ1DljWJ1adMdW+t3/ZYXCkqZvmaJ4UOwoYMcomKclE9RKKBkHuQLx0ossjtDICoyhlFQY2Xxzeklv6qRuQINIgnoMC1wlVyuxDHeJtO6MAEUrklZcNXEov2NLbcwv2LmjU48AchBhfWjWBtaIWW9YvBdqnG4XJa6Ozc6KBNn88vo5BCog36PgQaj3Uif3ITN4tCFBag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiPkcC3B+QkXtXP3K0ZodSEVT1VTh7f/2ZXBFmj8Rpc=;
 b=jKTgdvhJmmJaCnMdG6QBvCXGZx1FNRMpj/EYRAXlN0g8IkOdQ5ZL2mdZG033MF/reyIMPmd2YPl4v49wYYfR7sqA0RqSVJHjuikjhw4A+s57sT3zZnKS9ul9iYPDAuGgeqxFXANOWO+7EwDAiXrvEuR5mE7dz+Bm8ZCNcIclR1c=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6702.eurprd04.prod.outlook.com (2603:10a6:803:123::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Fri, 5 Jun
 2020 13:32:54 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3066.019; Fri, 5 Jun 2020
 13:32:54 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-imx@nxp.com, dmaengine@vger.kernel.org
Subject: [PATCH v9 05/14] spi: imx: fallback to PIO if dma setup failure
Date:   Sat,  6 Jun 2020 05:32:26 +0800
Message-Id: <1591392755-19136-6-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591392755-19136-1-git-send-email-yibin.gong@nxp.com>
References: <1591392755-19136-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:3:18::36) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR02CA0048.apcprd02.prod.outlook.com (2603:1096:3:18::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.20 via Frontend Transport; Fri, 5 Jun 2020 13:32:48 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9c13fa9e-b9ee-4196-ec12-08d80954f39e
X-MS-TrafficTypeDiagnostic: VE1PR04MB6702:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6702808873A575B61CF9A1BD89860@VE1PR04MB6702.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1RX7E8PMQTLOkbIDIA8401CAsT1/XPa4w1G/CYtJ9KG3tYtbVb8d6aUh3indOe3Po9BQg83bFknM0eXDfSmStNszrgXanGJhaYyvxIfl/boKsbsMssTZn2C8Ip9eq9dOONRw5IFpCDfrMV6IBYEYnstAdkHHqP2ruQ9TdG+9hO5gze8uDw4oiMpH481Jci8HHigstokbx6TaCe/TvdoMp6OsU7ey0zJId/CRtExEnbytRMR18/3Vrg++GEOvFymnA7/4gwzjWf94OyAMjHe7Kd961yo70zoDjogF2kFMr2IdBil4/PsENMAiWBeylSCxN9nGB5wBuEvyMRAEBs8kBE4MlNJ6k/MQUTChTdZMq+LcLGaOBQRbTRuxYS44wf/K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(6486002)(52116002)(2906002)(316002)(4326008)(6506007)(5660300002)(26005)(66946007)(2616005)(956004)(478600001)(66556008)(186003)(8676002)(16526019)(7416002)(6512007)(6666004)(36756003)(8936002)(83380400001)(86362001)(66476007)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: vRHsGZwqU5Tzi2JLdLnOX6SBAPY40Dm4E3I6j9rTjd4WdG0a/3uo4dmbYtixfxI0cVaSeh1p16hHN+bNNwnbBPETpQg3j3fg4A+50+2JSnNFB9ZYaycuXxIQXP2wlV/24xZLvkC1GIEp+RHlz86kbBV9hROtvJcNE9vTT9HC5ER3Qx2U+Df6uwVOOpWkzubmqX7znzSBuddtkWQi8DivcB7sjfi3OcKGXFhIIPG3Qq3IJqAe/7Y9+KesOcdRLixqIxrXQQytcfmRAaIAPbpVmeHCrjzDYDZ8VCjAlnaH8jkHlGNgXOwwIhwlcAkO4ue0cjY7avq+u3AL+mxQwmPnslA8GRv19GFRqWPzlo9itU2H14VuDKB/+dPLLg8HT+/52t2ROBQveEAMQMskMHKzfIE/5MtQfN7l58rvZmj1dmZ0lteYfV//ssBBB9l8vPr7XaxGKW4ha0/K0y/5q2d/Jn7nOQKBOXoVmrI+OY9LZvw=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c13fa9e-b9ee-4196-ec12-08d80954f39e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 13:32:54.4465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qSgdExW8Uw3Kw3JqTNXgVx61OtD7Jh2u/pnJSFopXunrjuPZNEJt94C07//FJ0fbNs9fSYlZ3BgdTz+5MQ9/wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6702
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fallback to PIO in case dma setup failed. For example, sdma firmware not
updated but ERR009165 workaroud added in kernel.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/spi/spi-imx.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index f4f28a4..b7a85e3 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -71,6 +71,7 @@ struct spi_imx_devtype_data {
 	void (*reset)(struct spi_imx_data *);
 	void (*setup_wml)(struct spi_imx_data *);
 	void (*disable)(struct spi_imx_data *);
+	void (*disable_dma)(struct spi_imx_data *);
 	bool has_dmamode;
 	bool has_slavemode;
 	unsigned int fifo_size;
@@ -485,6 +486,11 @@ static void mx51_ecspi_trigger(struct spi_imx_data *spi_imx)
 	writel(reg, spi_imx->base + MX51_ECSPI_CTRL);
 }
 
+static void mx51_disable_dma(struct spi_imx_data *spi_imx)
+{
+	writel(0, spi_imx->base + MX51_ECSPI_DMA);
+}
+
 static void mx51_ecspi_disable(struct spi_imx_data *spi_imx)
 {
 	u32 ctrl;
@@ -987,6 +993,7 @@ static struct spi_imx_devtype_data imx51_ecspi_devtype_data = {
 	.rx_available = mx51_ecspi_rx_available,
 	.reset = mx51_ecspi_reset,
 	.setup_wml = mx51_setup_wml,
+	.disable_dma = mx51_disable_dma,
 	.fifo_size = 64,
 	.has_dmamode = true,
 	.dynamic_burst = true,
@@ -1001,6 +1008,7 @@ static struct spi_imx_devtype_data imx53_ecspi_devtype_data = {
 	.prepare_transfer = mx51_ecspi_prepare_transfer,
 	.trigger = mx51_ecspi_trigger,
 	.rx_available = mx51_ecspi_rx_available,
+	.disable_dma = mx51_disable_dma,
 	.reset = mx51_ecspi_reset,
 	.fifo_size = 64,
 	.has_dmamode = true,
@@ -1385,6 +1393,7 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc_tx) {
 		dmaengine_terminate_all(master->dma_tx);
+		dmaengine_terminate_all(master->dma_rx);
 		return -EINVAL;
 	}
 
@@ -1498,6 +1507,7 @@ static int spi_imx_transfer(struct spi_device *spi,
 				struct spi_transfer *transfer)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
+	int ret;
 
 	/* flush rxfifo before transfer */
 	while (spi_imx->devtype_data->rx_available(spi_imx))
@@ -1506,10 +1516,23 @@ static int spi_imx_transfer(struct spi_device *spi,
 	if (spi_imx->slave_mode)
 		return spi_imx_pio_transfer_slave(spi, transfer);
 
-	if (spi_imx->usedma)
-		return spi_imx_dma_transfer(spi_imx, transfer);
-	else
-		return spi_imx_pio_transfer(spi, transfer);
+	/*
+	 * fallback PIO mode if dma setup error happen, for example sdma
+	 * firmware may not be updated as ERR009165 required.
+	 */
+	if (spi_imx->usedma) {
+		ret = spi_imx_dma_transfer(spi_imx, transfer);
+		if (ret != -EINVAL)
+			return ret;
+
+		spi_imx->devtype_data->disable_dma(spi_imx);
+
+		spi_imx->usedma = false;
+		spi_imx->dynamic_burst = spi_imx->devtype_data->dynamic_burst;
+		dev_dbg(&spi->dev, "Fallback to PIO mode\n");
+	}
+
+	return spi_imx_pio_transfer(spi, transfer);
 }
 
 static int spi_imx_setup(struct spi_device *spi)
-- 
2.7.4

