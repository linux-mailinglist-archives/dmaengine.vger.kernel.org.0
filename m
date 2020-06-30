Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7EF20ED73
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2020 07:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbgF3FZU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Jun 2020 01:25:20 -0400
Received: from mail-am6eur05on2040.outbound.protection.outlook.com ([40.107.22.40]:63552
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729753AbgF3FZQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 30 Jun 2020 01:25:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzhZHlmQ9+iAR6hD+MqII3ro+5iSahKlE7socZM6V9OWa+raVxhhXbxcSEA/eT7Y7CNpCvxkLvGFQZ9FGw1L6aPoA5lKrQcG4eS28IRZxWJB7fmX2/oqvnQGv6fVAt5wIoWUQZwsSiQ802QzpuvQwzerh0689ljqNC3/Shzp35F/xZ5Osb9HTuV2F5ZaMMhJZz1lTAtVHsNY4IyO+qgdFr9jlK7C2HoC+TWaETO/meqGcyNX6n2CRtg6oEwmFZazP9fuTBdeZzLK+ulbF2/9yp0AfERAsqyVTdkGMZQ//1qxqg1aF0shLB+ziTuop/3UaHtGtXyF+Jqucv9OfFTqtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIdg0TAYR1sjIrLOlt2s+rn1Vm6gjVIRKwp3FX6c2sQ=;
 b=gaa7hyo9CibFRsdIYrgo9CdzGj9DVA7jA3lOz7ugCT22NkBo5fL1ATwTyx0MRUoGl8MTk7rDHGu5VFOIUfVkGpY3rIeUQyxChchjKk/RSWftuj4kuCXWmBkqbjJg3kTJZirPKqBCbA8AJR6urPPSZAaafb6cC27iEfW+e9kNWwYNQSfPDDU2H/OlB44R7EfssSNIQ0EOTghE5KlkW+gZ3qV2V6ZVCihzbN3yKVriO9Wl/GckI9dSCQXQE+LxcM4+YJcwjzJ+bZWOPjgnV4pZorULvMxSgSEHq+3kdX7Qbbdj1+h935PST4CUI4PbmOuxwDuYnONZO1KHt4/7eL+ISg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIdg0TAYR1sjIrLOlt2s+rn1Vm6gjVIRKwp3FX6c2sQ=;
 b=BLwOXQEruW3+Co5qm13DSSb6cm4WPHISm3S7+IezUj2CBc30R2ZJ6Jta210NiK3T1Tx5M0IbQToYmVtX9ciefQuxbvvfDVQ88PkSxrRPLYwR9lt4bjZRtfDDJZ1x/0YCRGHSEDt7vDNEj8u3HETC6ZGXhxZc+GtV1XDkyYSDMAw=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6640.eurprd04.prod.outlook.com (2603:10a6:803:122::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Tue, 30 Jun
 2020 05:25:12 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3131.028; Tue, 30 Jun 2020
 05:25:12 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v10 08/12] spi: imx: remove ERR009165 workaround on i.mx6ul
Date:   Tue, 30 Jun 2020 21:31:12 +0800
Message-Id: <1593523876-22387-9-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593523876-22387-1-git-send-email-yibin.gong@nxp.com>
References: <1593523876-22387-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0132.apcprd06.prod.outlook.com
 (2603:1096:1:1d::34) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR06CA0132.apcprd06.prod.outlook.com (2603:1096:1:1d::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3131.21 via Frontend Transport; Tue, 30 Jun 2020 05:25:06 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 256c0629-9deb-41e1-bd57-08d81cb5f621
X-MS-TrafficTypeDiagnostic: VE1PR04MB6640:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB664090CC5E5A84D802F7F3F8896F0@VE1PR04MB6640.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0450A714CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lNfJfl0utKGZiHqXiybLHBAA4phJdDpdcJbVNTdX6jtNjjXyV9E42IP7X+V1hz7LtW84jdhFgAV0mYJ4Jz8zSXjoIhO5iCtgjyQwIoZQhbAqShbHXkDUuJTn00MWE01q036jhkmdR7vHUccUYSQMxnS1Ot0V5s6IsLrUmxtZ8jpHE8ir0xjY2XW4Ujw8QYuf96J4Eg7F6KfRzNWStTZJtmAY0XrpL/ACzwoDjy/POzo+BtNpQUcsv7yyWAl3uPT60C7vx4t4EfiDGBEkGSFiV1L5ZewMB0fnw2kEyFksPq1OsAArUOnebGRt1soekVmtZB5JC+hdFu+HlF5E+wVB/nFTaxjTkjw4S9YmJXktWxVG/K5JN4ftD4vYQVHN1AerawzZ+PDA3UrcVWWFfomhrBmqrKuE3kFBv6kW1GE/mCpgFE4qGBgFvfZ3ndebfxPrvpSzA7Mkir2u0QmY4N3DWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(86362001)(956004)(6666004)(2616005)(52116002)(7416002)(4326008)(6506007)(6486002)(2906002)(5660300002)(186003)(26005)(36756003)(16526019)(8676002)(966005)(478600001)(316002)(83380400001)(66946007)(66476007)(6512007)(8936002)(66556008)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: NrhAGK5YQE0/ccKb/6cNrQKFNk6DUTHG4ZWMGVZ4z4adnXXixAd+vM5qSm8NT1+JKwiVsjzA69wNXlSM364/lm0qVZnbdIM1jQOoU6ZQOVdfwfDT1jpYoillkto3oaRR8jf7tR3N8Ii2JhAFLVX1p3vvlMXePRUrkHQnMqXcdthxQr/90MTc6OV5Y9Tvm8eJnklTzbJ1KEXPneymj/NzsgDsTcU6/rmmD433mJatilk42+qTJOcIooynjxyBXe/OJZMmkk1icwilBVTq2es7pjfnBKNCJDCYE/JLJn5oBXEiQlcOLx/G3ZAAYYJ+PSs6s/KA3zFysuVyXfgAuHnezKLddo50q402nEWoDqbiM5GTdJtcqBdn3QmasvNclulfgl2LeiKstyyEg3ifsSvIZuMaWRuR3rTyPu3i7iQLMSbWnzqiXprt+1Rnzova/KV9Lut+T1pjN8/uMMfLSk/PWNPKvt4a1DPOKTU5kKpqoHg=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 256c0629-9deb-41e1-bd57-08d81cb5f621
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2020 05:25:11.9258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CbZ84XrAPnZOgwzdj85jwBorzSYf5VY0JFyzRZu9+Qvz1aOsVqeM7B358et2FinA6iBWOic2Y6kn9ItcHIvq5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6640
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

ERR009165 fixed on i.mx6ul/6ull/6sll. All other i.mx6/7 and
i.mx8m/8mm still need this errata. Please refer to nxp official
errata document from https://www.nxp.com/ .

For removing workaround on those chips. Add new i.mx6ul type.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-imx.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 873be5e..f3049c7 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -57,6 +57,7 @@ enum spi_imx_devtype {
 	IMX35_CSPI,	/* CSPI on all i.mx except above */
 	IMX51_ECSPI,	/* ECSPI on i.mx51 */
 	IMX53_ECSPI,	/* ECSPI on i.mx53 and later */
+	IMX6UL_ECSPI,	/* ERR009165 fix from i.mx6ul */
 };
 
 struct spi_imx_data;
@@ -76,6 +77,11 @@ struct spi_imx_devtype_data {
 	bool has_slavemode;
 	unsigned int fifo_size;
 	bool dynamic_burst;
+	/*
+	 * ERR009165 fixed or not:
+	 * https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf
+	 */
+	bool tx_glitch_fixed;
 	enum spi_imx_devtype devtype;
 };
 
@@ -132,6 +138,11 @@ static inline int is_imx51_ecspi(struct spi_imx_data *d)
 	return d->devtype_data->devtype == IMX51_ECSPI;
 }
 
+static inline int is_imx6ul_ecspi(struct spi_imx_data *d)
+{
+	return d->devtype_data->devtype == IMX6UL_ECSPI;
+}
+
 static inline int is_imx53_ecspi(struct spi_imx_data *d)
 {
 	return d->devtype_data->devtype == IMX53_ECSPI;
@@ -591,8 +602,14 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 	ctrl |= mx51_ecspi_clkdiv(spi_imx, t->speed_hz, &clk);
 	spi_imx->spi_bus_clk = clk;
 
-	/* ERR009165: work in XHC mode as PIO */
-	ctrl &= ~MX51_ECSPI_CTRL_SMC;
+	/*
+	 * ERR009165: work in XHC mode instead of SMC as PIO on the chips
+	 * before i.mx6ul.
+	 */
+	if (spi_imx->usedma && spi_imx->devtype_data->tx_glitch_fixed)
+		ctrl |= MX51_ECSPI_CTRL_SMC;
+	else
+		ctrl &= ~MX51_ECSPI_CTRL_SMC;
 
 	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
 
@@ -618,12 +635,16 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 
 static void mx51_setup_wml(struct spi_imx_data *spi_imx)
 {
+	u32 tx_wml = 0;
+
+	if (spi_imx->devtype_data->tx_glitch_fixed)
+		tx_wml = spi_imx->wml;
 	/*
 	 * Configure the DMA register: setup the watermark
 	 * and enable DMA request.
 	 */
 	writel(MX51_ECSPI_DMA_RX_WML(spi_imx->wml - 1) |
-		MX51_ECSPI_DMA_TX_WML(0) |
+		MX51_ECSPI_DMA_TX_WML(tx_wml) |
 		MX51_ECSPI_DMA_RXT_WML(spi_imx->wml) |
 		MX51_ECSPI_DMA_TEDEN | MX51_ECSPI_DMA_RXDEN |
 		MX51_ECSPI_DMA_RXTDEN, spi_imx->base + MX51_ECSPI_DMA);
@@ -1017,6 +1038,23 @@ static struct spi_imx_devtype_data imx53_ecspi_devtype_data = {
 	.devtype = IMX53_ECSPI,
 };
 
+static struct spi_imx_devtype_data imx6ul_ecspi_devtype_data = {
+	.intctrl = mx51_ecspi_intctrl,
+	.prepare_message = mx51_ecspi_prepare_message,
+	.prepare_transfer = mx51_ecspi_prepare_transfer,
+	.trigger = mx51_ecspi_trigger,
+	.rx_available = mx51_ecspi_rx_available,
+	.reset = mx51_ecspi_reset,
+	.setup_wml = mx51_setup_wml,
+	.fifo_size = 64,
+	.has_dmamode = true,
+	.dynamic_burst = true,
+	.has_slavemode = true,
+	.tx_glitch_fixed = true,
+	.disable = mx51_ecspi_disable,
+	.devtype = IMX6UL_ECSPI,
+};
+
 static const struct platform_device_id spi_imx_devtype[] = {
 	{
 		.name = "imx1-cspi",
@@ -1040,6 +1078,9 @@ static const struct platform_device_id spi_imx_devtype[] = {
 		.name = "imx53-ecspi",
 		.driver_data = (kernel_ulong_t) &imx53_ecspi_devtype_data,
 	}, {
+		.name = "imx6ul-ecspi",
+		.driver_data = (kernel_ulong_t) &imx6ul_ecspi_devtype_data,
+	}, {
 		/* sentinel */
 	}
 };
@@ -1052,6 +1093,7 @@ static const struct of_device_id spi_imx_dt_ids[] = {
 	{ .compatible = "fsl,imx35-cspi", .data = &imx35_cspi_devtype_data, },
 	{ .compatible = "fsl,imx51-ecspi", .data = &imx51_ecspi_devtype_data, },
 	{ .compatible = "fsl,imx53-ecspi", .data = &imx53_ecspi_devtype_data, },
+	{ .compatible = "fsl,imx6ul-ecspi", .data = &imx6ul_ecspi_devtype_data, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, spi_imx_dt_ids);
@@ -1671,7 +1713,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 	spi_imx->bitbang.master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH \
 					     | SPI_NO_CS;
 	if (is_imx35_cspi(spi_imx) || is_imx51_ecspi(spi_imx) ||
-	    is_imx53_ecspi(spi_imx))
+	    is_imx53_ecspi(spi_imx) || is_imx6ul_ecspi(spi_imx))
 		spi_imx->bitbang.master->mode_bits |= SPI_LOOP | SPI_READY;
 
 	spi_imx->spi_drctl = spi_drctl;
-- 
2.7.4

