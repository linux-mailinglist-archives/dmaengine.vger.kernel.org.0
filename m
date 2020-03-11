Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7B618132F
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2020 09:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgCKIgF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Mar 2020 04:36:05 -0400
Received: from mail-eopbgr130050.outbound.protection.outlook.com ([40.107.13.50]:32750
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728585AbgCKIgF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 11 Mar 2020 04:36:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crxOXVT4kuBKfqLJCLqwQcVB+O/ZWMnVAdKyCj44tnhHYkA6Djn39yzVluS6rVxUD6X16TSeRmuImEoB/L4CNbgZx+sDnruxkRBN9Zcbep5NKTPX35jCq75Qyfi83vqe3EQJjiiyaYFoWkGIVFJSPVPkdaHc6/11iQjnqe3z/TukdCSXQrX127akoABXhxYfJGeWuXSmyh6U4xbDyr5Gz1vq0NXWGUfjQvDFRP2U95BWcYVnz2VShVM4owSKJTu7HPF3ot0pr+iSwxwhb/PL0V0VD7+Qrf/ttl1Pnd5M0XCrhYQ/rshYX1Dcqdhylk2eQMywB40NaBFK8x93S86Sqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqmLvhcU+jWUPBsc+Lha7GCOZUjE8UdZPd2ceh3CHTM=;
 b=a7rapiWMDNs0+7NB1gC3p9WWU97uPy58tf02trwdOiyBbsLvUCBq3qavsD6kdOUaByiKA3M5d5eKRaV7Yj78R31R3VZP4kqUPo2NamOel6IqCe3BP27cYCA0vgDQ8tVe00odilG2JmWgbUt3EHscij3RgQDsxm7WLMi4hfQhRmW+5w8YfLHyitLc4zNqhCSOLauRbhMHFeD6gzSfSfOItNC82KwPmoflvsVqLKCS2PRUKDOY7bgKbYUPBrZMCv9Sc10bcHTPAD0nDxDIaVKwbXamIeI3dow/ZfOqqOfYqztvIt21TNNrzAyuftBs62mUS4isKxr/K63cxh+HrJzv9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqmLvhcU+jWUPBsc+Lha7GCOZUjE8UdZPd2ceh3CHTM=;
 b=DL6WNuId9vtnlwCaO8cxtSARgXVEObpzgytJ3zaK9UAlfzy/RzDEdk8dD1So2MSkbs0cJLIU8Dk/JaE3pKPwknrucPU82UKOjX2SJoSEbvyk7vzuYdNaRbTZinGYCQYH5waYc22kq7GnaqPiEpOTUi8FOybioCWJ826tabVA9tg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.232.15) by
 VE1PR04MB6495.eurprd04.prod.outlook.com (20.179.233.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Wed, 11 Mar 2020 08:36:01 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::490:6caa:24b:4a31]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::490:6caa:24b:4a31%6]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 08:36:01 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     s.hauer@pengutronix.de, vkoul@kernel.org, shawnguo@kernel.org,
        u.kleine-koenig@pengutronix.de, broonie@kernel.org,
        robh+dt@kernel.org, festevam@gmail.com, dan.j.williams@intel.com,
        mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        l.stach@pengutronix.de, martin.fuzzey@flowbird.group
Cc:     kernel@pengutronix.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v7 08/13] spi: imx: remove ERR009165 workaround on i.mx6ul
Date:   Thu, 12 Mar 2020 00:36:31 +0800
Message-Id: <1583944596-23410-9-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583944596-23410-1-git-send-email-yibin.gong@nxp.com>
References: <1583944596-23410-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20)
 To VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2793.15 via Frontend Transport; Wed, 11 Mar 2020 08:35:55 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 82e88627-9808-4e69-dbdf-08d7c5973a79
X-MS-TrafficTypeDiagnostic: VE1PR04MB6495:|VE1PR04MB6495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB64956E067D269E8AC2C7E0DF89FC0@VE1PR04MB6495.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(199004)(6506007)(8676002)(16526019)(186003)(956004)(2906002)(6512007)(66556008)(81156014)(66476007)(86362001)(2616005)(52116002)(26005)(6486002)(5660300002)(66946007)(7416002)(81166006)(8936002)(316002)(966005)(36756003)(478600001)(4326008)(6666004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6495;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ubl1/0Wpe7h4zXoaoFM8cZ01yuaX3lRZeD6DKO0lRzlZmxz3Ux6KKv/w7YJUeicSsqKDywVqc+Uk+eLpCqZt/yPh/8pgmVmQ0rGVcPxPo55n1dOfN9GyzAryuG9R/NCMEW6CstsintYVO3lO09Dp7oh5zr6OyOToaGi9OIr8gC/a0HnATUedPe5MYUSC7UJUbYcZkfpA3ZTkrEWV+xsCLhmIkqrRKtd4empRxKeEqjHExRLTzeYgt3R2UXfPD2ZAfj0MvmQGLYwlDDdRocKLn6fpYdYmqeA9BmkqfGz3w9x0f3a0FhEmHPqebINgwXhWQpK71ZV4/NIDIPa7HNTHRy6ZnM2Q+ZNaLmx0lZzOnKEYb3POfOqZknJh74nNWQRC5KtrOzM8M+CayPpEFpzSd+O4reD/AyD4HWA5m2FnO9BEMEKUDcdeuH08BGdx4rhmrqo8qH3tgzWOmc6WhZO4sbQ1UMkJG5Y37yb6r3+YNCOUouyM8T+GqNkfDfIgMc8nRGhdk+478ztIiWdpJTxE8SloXDqRWaFZm98cWvg2Cw+ygmCAARF2lMD6hZWsgkDqddxrVV3F9YEH6FVQ1e/AYg==
X-MS-Exchange-AntiSpam-MessageData: Vejpy37SCxdaDhXOJp2D95W/3+ivpBQ6XCzXsNJP7FOikVeuWuqXJX4K5CbiqxDEKnuYDzorLVqR4nljWsbGPxUDQ37bZdhPvyF3hvHYIgtqAZm/N0XioRK05gOhuAkyiiE3pwIHdaZGgAcrAeqEvQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e88627-9808-4e69-dbdf-08d7c5973a79
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 08:36:00.9971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dx/t3wXJSnmVIgs7+S2PB55YP0yeCxH11S6Kb3m+N1fo5md1hs0MVitX/kIbunukyzsZHERDVV9D0JygTiiIfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6495
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
 drivers/spi/spi-imx.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 70df8e6..a57edcb 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -57,6 +57,7 @@ enum spi_imx_devtype {
 	IMX35_CSPI,	/* CSPI on all i.mx except above */
 	IMX51_ECSPI,	/* ECSPI on i.mx51 */
 	IMX53_ECSPI,	/* ECSPI on i.mx53 and later */
+	IMX6UL_ECSPI,	/* ERR009165 fix from i.mx6ul */
 };
 
 struct spi_imx_data;
@@ -75,6 +76,11 @@ struct spi_imx_devtype_data {
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
 
@@ -131,6 +137,11 @@ static inline int is_imx51_ecspi(struct spi_imx_data *d)
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
@@ -585,8 +596,14 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
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
 
@@ -612,12 +629,16 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 
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
@@ -1009,6 +1030,23 @@ static struct spi_imx_devtype_data imx53_ecspi_devtype_data = {
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
@@ -1032,6 +1070,9 @@ static const struct platform_device_id spi_imx_devtype[] = {
 		.name = "imx53-ecspi",
 		.driver_data = (kernel_ulong_t) &imx53_ecspi_devtype_data,
 	}, {
+		.name = "imx6ul-ecspi",
+		.driver_data = (kernel_ulong_t) &imx6ul_ecspi_devtype_data,
+	}, {
 		/* sentinel */
 	}
 };
@@ -1044,6 +1085,7 @@ static const struct of_device_id spi_imx_dt_ids[] = {
 	{ .compatible = "fsl,imx35-cspi", .data = &imx35_cspi_devtype_data, },
 	{ .compatible = "fsl,imx51-ecspi", .data = &imx51_ecspi_devtype_data, },
 	{ .compatible = "fsl,imx53-ecspi", .data = &imx53_ecspi_devtype_data, },
+	{ .compatible = "fsl,imx6ul-ecspi", .data = &imx6ul_ecspi_devtype_data, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, spi_imx_dt_ids);
@@ -1175,7 +1217,10 @@ static int spi_imx_dma_configure(struct spi_master *master)
 	 * For ERR009165 with tx_wml = 0 could enlarge burst size to fifo size
 	 * to speed up fifo filling as possible.
 	 */
-	tx.dst_maxburst = spi_imx->devtype_data->fifo_size;
+	if (spi_imx->devtype_data->tx_glitch_fixed)
+		tx.dst_maxburst = spi_imx->wml;
+	else
+		tx.dst_maxburst = spi_imx->devtype_data->fifo_size;
 	ret = dmaengine_slave_config(master->dma_tx, &tx);
 	if (ret) {
 		dev_err(spi_imx->dev, "TX dma configuration failed with %d\n", ret);
@@ -1659,7 +1704,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 	spi_imx->bitbang.master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH \
 					     | SPI_NO_CS;
 	if (is_imx35_cspi(spi_imx) || is_imx51_ecspi(spi_imx) ||
-	    is_imx53_ecspi(spi_imx))
+	    is_imx53_ecspi(spi_imx) || is_imx6ul_ecspi(spi_imx))
 		spi_imx->bitbang.master->mode_bits |= SPI_LOOP | SPI_READY;
 
 	spi_imx->spi_drctl = spi_drctl;
-- 
2.7.4

