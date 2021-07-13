Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E156F3C6E87
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jul 2021 12:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbhGMK3S (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jul 2021 06:29:18 -0400
Received: from mail-eopbgr20053.outbound.protection.outlook.com ([40.107.2.53]:28903
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235730AbhGMK3K (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 13 Jul 2021 06:29:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEO7YItxXInSgDbfOHlQRdpl9O7IYG2xeWDZNstNipUCv3FTNHdTz48elLDKBm6OjRLwlkvb81tORTTGDSgx7JmrUGNiYRr/gYZ4xkx+80RD+XJDkc6vsUJdZcgRcSKUJV1Olw36aZkd4P0uy8CuToZN8kXMdzncEPW17nJsxOzROfQGVXJy6BUb+RsZtf4F22ELBWdZPolHHWDFZwe6PZsuFeH/AbOGrQH9wWQeTaCwCrmY+ndtgkraCY8kKk1Faxheufq7TwnjUUAX5XhYfQZzVcBm4MGd49v3tqn1i1CS8h8FRC6PZgG/MxB4IcZ6Lmvwe93yId7cj9H1SKBZjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idwxBfwcWMgbvSDKmIijITAOmdmaYljkCXfE7OYchws=;
 b=DWLGTG29EgXsB25CFnvUhzTIkeKvC0Gtfw35PqVJ+uy8dt63yiRvdublx9H0neGZXrnPQJzF2wdjTdUd08+gPmCHlCWjsJhmccno4arTdf0uwPIwQLGXBhDhtfMxgwiKKa5WK/Ei1B6jDJKZePS6+Al18zMV/7bOHvnDAPBxTSGq2uLoSNF+U9dJAxdFyVdfwmLVnJMGRrdaqF0W1Efe0bC2krJ4dEPnvWH3C5gCZLU2tWpwhs9ovAyKlP5ElyvUwM8S1+byNB0YkKK+P9WfvuJpfg44Pxmw+BgGp4uX+kBdY9RRMvsCDGP9SPv7qe84zch/kmzBam6RVNRvMWng6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idwxBfwcWMgbvSDKmIijITAOmdmaYljkCXfE7OYchws=;
 b=lnIevpDoGT9eFWgodTXsYISSoTYhgyWjTizYUfffgck2MGayBcD9FfQBl2CRGJ6CiSbuD6mMU3fodjigrX5pVrKfQnHrhIY3sdpPKUmtmPhelQKQtFxRQ8RLkhJ6vTM8/T6KLFvU+LUrZxnDQpqf2JGTMchzwAkSl9dTlWXVPU0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR0401MB2288.eurprd04.prod.outlook.com (2603:10a6:800:28::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.25; Tue, 13 Jul
 2021 10:26:18 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076%5]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 10:26:18 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        robh+dt@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, m.felsch@pengutronix.de,
        l.stach@pengutronix.de, xiaoning.wang@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v15 08/12] spi: imx: remove ERR009165 workaround on i.mx6ul
Date:   Wed, 14 Jul 2021 02:41:45 +0800
Message-Id: <1626201709-19643-9-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626201709-19643-1-git-send-email-yibin.gong@nxp.com>
References: <1626201709-19643-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30)
 To VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 10:26:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 073d1d5f-1e87-4e89-7e93-08d945e8a69d
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2288:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2288CD3F174394847EB283E889149@VI1PR0401MB2288.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kUEKxUYjJg73ENXslLwhm1+R5pKBXcUciOGuahaEMUt/CDOty/srCwhC4jBmtZgkfzCnCi8VwXoOdm//xoffhHHvZjfrj+RoPN36JqjWpu2NKuAo2UI4ES95I7YRTSBm7dPHhwBlGgw3KZlRO2ditzRpUq7GnZzMNQzvUWlA5jkf8RP1WKp1sBsV+M7r8qgInug/nGBYUN4GtgGECsAS5dIwn6rxvosjBZE3Xi+dzGtB9cR/IRz/amCJu5pk3mjOUNTELhShKEGB3iuXl7xcYzO2FZS1qix+wiflG2hSYz4sPgt+Sp68627gBat/hyKz89GrFF14MJlDUlTaigvrml26PHT2g7iIrx4cZ9WWkZUpsZQ0vzRYgGLjJAcxsyUbTOEoe9PZAOp7CZfrfIFYwuOnBMuCupNPYIIv/waCfQ94J4OZucTLaAAwcPgEhuPVLba4AZA6zQTt3tfa4TL6iPrvnuRjS0JdMcSnCYTFvU8Dm38T5zwWrwW+YNT9LhMIcaVm8cKxxvyOzlrWxyH5Luy/uJsQshruZolcJTwb+GKUoXZElRKF4Ggfakq68kvd/LFIqJ1mENHdgg0LNTXuHxdUfEbKy82w5sLPzPgNPXMabyHlHMvLo6V9TEUyAwa2xBa8eHVAVqdMrHl1wuwenus0cZy3anDJbhEh6+cgp/AabsJOK+QkHgOJtxccC8kpIHqLtCoh/DUwhY7ifHhvzlE8cliMlOZ7eR4S6oCWQ+KX4ic5/byKTPSa6N1Hxqvp4Vh+kLSgo02Mn+zmsygHEnTbnp18TwEnHDbSzc816vEteNUM6DNzXEWgMhvjA0xV49zKaHlMb7F1FYNE9arCodH8Fgl9pxP0fZqNJqTje+Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(396003)(39840400004)(376002)(6666004)(6512007)(316002)(83380400001)(66476007)(966005)(38350700002)(52116002)(86362001)(6506007)(8936002)(5660300002)(921005)(8676002)(36756003)(66556008)(186003)(26005)(66946007)(38100700002)(2616005)(2906002)(6636002)(4326008)(478600001)(6486002)(7416002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AOj3l9qaouTEr77MJWlZbxXLnD6qqXrQMD3jDzG89WSCgezn4ym0h1rhYwG6?=
 =?us-ascii?Q?4KAzCAj9aYZ6TLPQE3oCN1gmSUoYiK4J/AdAXOmKhTUohFhA+7S3m55NU81G?=
 =?us-ascii?Q?TbYMBZlHlAPCQ8O2LwMZ0YeAsdz9JBRHryJhAwfjN/FGtHaCTUJ0LLm2qsTv?=
 =?us-ascii?Q?iKH5KORoC9tXr8xUk+EmXUBTsNrf+kqdavlLyzY+0SoeLfpt+YaKSowH1Qat?=
 =?us-ascii?Q?iV5eLuYfQRAlyu7XR4Vda579YKRrtfO90jqIK7QbxMb/io0qdE94D0+klEAe?=
 =?us-ascii?Q?J64z5CJwe3bcoDAz5VGa9Sb8bYI7dniLCrdRwf718BI5wUjaa0TpYCaCFlnr?=
 =?us-ascii?Q?zIBThDGMLmPcY9Bs2S21zhA9BWHJB+9pePseXNyycvS430lxeK0KSY2hpJFN?=
 =?us-ascii?Q?th1GNiuN0Xhxk6n56IM1fTjfG5R8af2l5F7gslOTyk0naW1GspG0FgzYZm2k?=
 =?us-ascii?Q?Rzz48ybqQUMY2Klab78n54vruzuRQMZOW3FuGCnn0CzHXqrsNH4aBGvQMdaq?=
 =?us-ascii?Q?NhNUyNRMzMEC8u+CXELXnXYyBKpKzeJNaRmYARwRN19eYqfJNQyCCseLvm7b?=
 =?us-ascii?Q?jY6xh+CqlluTv1norJsZEjmRiHKKi3L4BMFH4lHVGSTZtN1+f6nPhjkT0iAl?=
 =?us-ascii?Q?dwUALnyWj2VUetznNK4ZdTyuvXMnPuuQ25e3xyHKfNQwChx5I7NMILf9C1m4?=
 =?us-ascii?Q?7YRa13x6Uw1V/r5JL/u4NEVi1rBsWKr1DDctAbotV9cwtc71ao/Tp/jnaBsO?=
 =?us-ascii?Q?2eERXoCVgtUfXBuAB68233rVWRQNGq6aOW+lGLBuYXp7UmkrOzuvyzVpKBpJ?=
 =?us-ascii?Q?oh6pdajf80wfeVqzxTA8sABxTT7HITpqEJByVaZMZFPL6kz8HQnUVoKPKMTc?=
 =?us-ascii?Q?4SjxqA7tK20mCyFjICjj+pzqp6Fd8AEdpteYvTZYebM3L2/J0AyN+1wKM6qh?=
 =?us-ascii?Q?EOx4pW3LMiSlQ7LkVNeqhjDNRFQ4xI9YZW/aXj9AR2W39QdRVq16uxkeVEq5?=
 =?us-ascii?Q?W+J4dD3kCEV17tecnxJ0njb9e1AKOIcUwCYZKpIpugeVrTSUPsQ3vqLALRQN?=
 =?us-ascii?Q?EiQHd4lU2DTeask8NSt7uCma1JgdmZKH5Nk+OymRIlMDXbLRlZpCQfYBS5UT?=
 =?us-ascii?Q?22ZHzabZabLl9SI3c1T9Ai5nmH0c+H2TWIDMOwlU3YfOQSgAG62swErFopgE?=
 =?us-ascii?Q?usH1+Wh6v6f73dqpsCy7oGUOklqEn9aIV5TnDbAGBPNHJBVKtotMPOEDv8iy?=
 =?us-ascii?Q?Ac8ERhrvsIdhVwT/PT6feNbU29HEgGiicu0vgvV92c0UHS29lu4X0Rny6Jxw?=
 =?us-ascii?Q?Wa+1BmihoFRd52KiFxtJPsM9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 073d1d5f-1e87-4e89-7e93-08d945e8a69d
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 10:26:18.2143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YvFy0sHplrNiy8QI3N9MAi5/8lZT+ZNMb30pKFYIpSTQ10IkYs7f3ygZsoEoQCRjiSg7cCKfDDoJUbE5kScSrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2288
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
 drivers/spi/spi-imx.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 61e4fa0..63a8d7b 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -77,6 +77,11 @@ struct spi_imx_devtype_data {
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
 
@@ -608,8 +613,14 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 	ctrl |= mx51_ecspi_clkdiv(spi_imx, spi_imx->spi_bus_clk, &clk);
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
 
@@ -618,12 +629,16 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 
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
@@ -1014,6 +1029,23 @@ static struct spi_imx_devtype_data imx53_ecspi_devtype_data = {
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
+	.devtype = IMX51_ECSPI,
+};
+
 static const struct of_device_id spi_imx_dt_ids[] = {
 	{ .compatible = "fsl,imx1-cspi", .data = &imx1_cspi_devtype_data, },
 	{ .compatible = "fsl,imx21-cspi", .data = &imx21_cspi_devtype_data, },
@@ -1022,6 +1054,7 @@ static const struct of_device_id spi_imx_dt_ids[] = {
 	{ .compatible = "fsl,imx35-cspi", .data = &imx35_cspi_devtype_data, },
 	{ .compatible = "fsl,imx51-ecspi", .data = &imx51_ecspi_devtype_data, },
 	{ .compatible = "fsl,imx53-ecspi", .data = &imx53_ecspi_devtype_data, },
+	{ .compatible = "fsl,imx6ul-ecspi", .data = &imx6ul_ecspi_devtype_data, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, spi_imx_dt_ids);
-- 
2.7.4

