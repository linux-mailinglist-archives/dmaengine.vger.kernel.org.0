Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C3822C350
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jul 2020 12:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgGXKhz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Jul 2020 06:37:55 -0400
Received: from mail-eopbgr80048.outbound.protection.outlook.com ([40.107.8.48]:45959
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbgGXKhy (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 24 Jul 2020 06:37:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqIUTQ8zgs+iWQatEx596VHTRiKuW9Xhhh4PpEH93UgI9PNcj3NPUeEXBDCWiW42POaxqnm/C50ykIu/+TR/YY5OL5SNGpFPEszYwLGSAyefDnXMNbzSZXnOU4iNJFO72q+o3nnQuhyozJ7BWM5AlnqAEg37PvSH9TLK45eyzMzAdwfFcUM+DDt+K0gC9fzZRucgEB8W9aEHXG3Pp6/nO4t0iFSOCLSRrhfPG4pMJt600IVjEQp21+vJKf8MOsoE28ZxcpGsBNB4cFxanrlHFFCCyVhTx7itJVxKvMRJ21YYSrqgZkBB5WDFn7nMBAcCHGqjPcGIKts+0qKO73dO4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7wglQdCBx4vybuSP0CcjtoW8ZOV8IUohKb+Ye4yy8I=;
 b=Kst2wlcsSEsnPjmQ4da+xdeu9M8EsmolCKV3oxSy1ovh4JdFniWDUMEhMPfKfPUj+1Fvc/mJ0Zj/11Kyj/nb/6vJYrZOvUcdK9yKa1CWlvEzzfM7Q4uuM1OQbohsBjhjz82x+1EgO5WDapVZQmnqFwHUiOlR0++8m0gh5hf4/rf6ZrwHUZsoEftXKEB93vI1brlqCJmPwWLsgYohvP8yQR0H5bHNaSOHJY90bFkqvL7nVSgMjnDkaE4TiWVmzRgMvH0axcUV687x/cavj5MSz875FVmJHuF6iblPogExtycJIbTarzBr3lo0cvhuHKe1UrgZaCSTL1HymViz21ymKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7wglQdCBx4vybuSP0CcjtoW8ZOV8IUohKb+Ye4yy8I=;
 b=Az15bJ6E7VRO7rlmBO+RNWq2K3XXGIV/NORhCbwIp7MGQRUR/tafhu2+fXOL0tkKs6tLJ08JApnRGbSI1HrV/HwWSeb2l1E+a1WlgZHawd2psgHwSXZu7Pj36HoBYWX+OTrUADofh6TusG4/ny7qPuMc6uo1AQYjkAEpbOF5Ghc=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR0402MB3710.eurprd04.prod.outlook.com (2603:10a6:803:25::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 10:37:50 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3195.028; Fri, 24 Jul 2020
 10:37:50 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v11 07/12] spi: imx: fix ERR009165
Date:   Sat, 25 Jul 2020 02:51:20 +0800
Message-Id: <1595616685-9987-8-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595616685-9987-1-git-send-email-yibin.gong@nxp.com>
References: <1595616685-9987-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:3:18::34) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR02CA0046.apcprd02.prod.outlook.com (2603:1096:3:18::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3216.20 via Frontend Transport; Fri, 24 Jul 2020 10:37:45 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2d18e24b-59c3-4515-252a-08d82fbd9d10
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3710:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3710B85873A069DD4588C0F589770@VI1PR0402MB3710.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J80uLbY8wpukHXDlrkLDzIdTXG4rkule6UbuSq6XV4WExbrobqi0F4k0jC5O1z8E8qjKjhhc/5qD8z0i5x8ZD50+MnxNhNnFQLVGIZxvmxl0bwDqjVZhaXeiw2p37jWg7MLbcjQZRWrFX+beyX47c0tGFbfWiVbBc0wG9q+tpSo5mzIzgjin7MrVi8Nb7DCoS+Q+092jpea26aiJc5om1KDTjZ6fb116XZMEaRr7jnmmYTFN47N6UVyjZ8wpIMeH+hc9xVvJ1nA7W2OTx1MKMcQTyahStkWp8qp0WL5lr5IPa84vONk0aNzGXEFw8NdoSXpNLOtjR/ovviffWKI58hjpiVbqnFoMNinOB4G50J0CWZeOez6tVKqV72YMzN0OM31+ZCMlJtAXArcgr6HdAe0CnceMCS0QvFkZSJdZlM5TgOd3CHeWnoKu+Y2voH1s2xvUn1xter+T4xY41o0RHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(16526019)(186003)(66476007)(2906002)(8936002)(83380400001)(66556008)(478600001)(5660300002)(7416002)(52116002)(6512007)(36756003)(316002)(2616005)(6486002)(8676002)(26005)(6666004)(86362001)(4326008)(66946007)(956004)(6506007)(966005)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: NrgwD4i+eN4BtJqd/ISYMoQc/nYD6tJF0wrd78E5+Qr1vtsIL1RNJSLTXiU0qtctIY8PzbHJDdZ8alVoSSczkBSpllOlXtQ/IthI9L/WQAj7MVJVANDMiWgJEUO26KHETNgYA7dbmpaSrw77NUoTrDEqGGHJ6E1gN4nDeRDASLpG5Flm1Z755MAPoSsSz4eXJRO+UVs2qeai1ALDU1WuX/Fr1EXKtTYlE4rZmViiLAxbOfLe5hPqiuAOs0k/sFSpa30A3eOxMgO8mKmNVCGZzLSbQVZDsAWqu2fGmdqXip/MTSLn9QlJDsQbeuDOC4kwqhrENXcOjiTZs8Kf1OvIMYiKicG5Xj+NcmNcbUNCHBoQiE2r5Zj4pQT2rLEY3jPMzRp/1ZB00MU8mZCfLXUbxIIhJyo2ExZ7OYLuv43Frk4sz0Rl3o6iPG6KP9IyRfs5IXqd+9baTNGGKCKjiK83NHqTbmsWdLeESJSMcscSnfE=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d18e24b-59c3-4515-252a-08d82fbd9d10
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 10:37:50.5179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ISIjb4YRrJER3zmSgH9Q5QUlHudJwH7KFsvp0P5+vPawZHsZlKmZNkWsyzRj6NZy/KJsZlL6AP/4oRjjcI78bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3710
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Change to XCH  mode even in dma mode, please refer to the below
errata:
https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-imx.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 2b8d339..873be5e 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -591,8 +591,8 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 	ctrl |= mx51_ecspi_clkdiv(spi_imx, t->speed_hz, &clk);
 	spi_imx->spi_bus_clk = clk;
 
-	if (spi_imx->usedma)
-		ctrl |= MX51_ECSPI_CTRL_SMC;
+	/* ERR009165: work in XHC mode as PIO */
+	ctrl &= ~MX51_ECSPI_CTRL_SMC;
 
 	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
 
@@ -623,7 +623,7 @@ static void mx51_setup_wml(struct spi_imx_data *spi_imx)
 	 * and enable DMA request.
 	 */
 	writel(MX51_ECSPI_DMA_RX_WML(spi_imx->wml - 1) |
-		MX51_ECSPI_DMA_TX_WML(spi_imx->wml) |
+		MX51_ECSPI_DMA_TX_WML(0) |
 		MX51_ECSPI_DMA_RXT_WML(spi_imx->wml) |
 		MX51_ECSPI_DMA_TEDEN | MX51_ECSPI_DMA_RXDEN |
 		MX51_ECSPI_DMA_RXTDEN, spi_imx->base + MX51_ECSPI_DMA);
@@ -1273,10 +1273,6 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 {
 	int ret;
 
-	/* use pio mode for i.mx6dl chip TKT238285 */
-	if (of_machine_is_compatible("fsl,imx6dl"))
-		return 0;
-
 	spi_imx->wml = spi_imx->devtype_data->fifo_size / 2;
 
 	/* Prepare for TX DMA: */
-- 
2.7.4

