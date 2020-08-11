Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53FD7241765
	for <lists+dmaengine@lfdr.de>; Tue, 11 Aug 2020 09:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgHKHkp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Aug 2020 03:40:45 -0400
Received: from mail-eopbgr130047.outbound.protection.outlook.com ([40.107.13.47]:31297
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728275AbgHKHko (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 11 Aug 2020 03:40:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSt6148a7K5M+/zQAh0hh3AXf2dzCQ+grkfrC3RqRAe0lnwzC5ut+7F0f5bCSjWQSUKDYbCOuCdqsahV1kAYSGizIsMhqYUxZhN3LyXNMiAXhKYtlao/I36U3tjTwUVjvD+W++jMaowQRiqoo8VLEqq8zwCdyf96P6VCsWv6xbZ8pRzeytn4+IU+IdknkxTV44bhATFUgiBpY1w+cXeJMO7H82rGXAlQj/z7HalfUM4tBN7o4IqY6NS7drvP2mo6lllBnO/QCZCxKbgfaGpNBNJThDlMogy06UcsZ54cfPletcGxOm/bZtKkRDmPR2fkFpPhtzAwv66ptKgLuRgykQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIdg0TAYR1sjIrLOlt2s+rn1Vm6gjVIRKwp3FX6c2sQ=;
 b=Ky/m6HxlhfOFk7GaPA0mRoMOe/ZdupJNTCxtOVXDKnQdRw+8wZxCidFCLLQqF3LEmVwZu5kMJLw3zytIcINNrQm3aaXFSSE0XK2DPSYfRBVU4zU0JnefoNSJf5szTmhMvQYmB1TPqVvMYQMmA8poxe3e8ep4j1R6d6CsaEz27MZKffh9zdcOCiRPdCnWeI8P10ZAGoflM2IXytPODltgWqKv6fAQ0G1xkUtignyFlaraSbDPIf8IS9lvwE2LHbyySXsOa+uFqRoOfZpf8ioNixkWkJ0/c3g/z06om9Jn3mnb/01WlKg9B/d4uWOs/LHcziGppWGiiKDtONGonnravw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIdg0TAYR1sjIrLOlt2s+rn1Vm6gjVIRKwp3FX6c2sQ=;
 b=N4j6q1aFq6qoh4VFdkJ2ysX6u2D6taJyLJbtzV9RF8+O/DeeQRdW9m9LghG1cPqV2SLkHcYweGcLJoOQwFKx6/tNShS/E5Jv4wDasVmMrCtxt5wAdwd33k0Qj6mT8CF5oB91BkMOqF9MMoAraE4YF1zKaxxjjQWK5RwGqSFhed4=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33)
 by AM6PR0402MB3464.eurprd04.prod.outlook.com (2603:10a6:209:12::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Tue, 11 Aug
 2020 07:40:37 +0000
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::c9b8:4020:7705:e3dd]) by AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::c9b8:4020:7705:e3dd%7]) with mapi id 15.20.3261.025; Tue, 11 Aug 2020
 07:40:37 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, r.schwebel@pengutronix.de
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v12 08/12] spi: imx: remove ERR009165 workaround on i.mx6ul
Date:   Tue, 11 Aug 2020 23:53:47 +0800
Message-Id: <1597161231-32303-9-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597161231-32303-1-git-send-email-yibin.gong@nxp.com>
References: <1597161231-32303-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) To
 AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3305.2 via Frontend Transport; Tue, 11 Aug 2020 07:40:31 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9b8ea2fd-adf0-4cf2-dd6b-08d83dc9d692
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3464:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR0402MB34649254FFCDA2BAFA252C0789450@AM6PR0402MB3464.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zU2sb50otW1ScYkq7ihsPk5+zV3ILRM3G0JNI7NGdIDgBesNsZ9EMKtbrVrnWpQop2WocQ5MkRyiN66UMkBRjafrDu+0lGe6FcwbULvT/BYuW2ibKTUMpCyfLdTVB5a5gwq3jy0GknpBxRTpd+QfzMtYv9G4bn1X0r1JAv6gzy9akn/eYMTwpyt5JNCtbCJ5YaBPQh28w1/8Epod5VPUGnSOrKGb3/3N2nD9mszzPznpE2XHA3EVu+M2VboRnOqyCA3gMY69z+sozVFIydTC8PZyShjJV4cyefgMNyY0qA8tq4lYrVCT4JB7E22qpfHo0CTrT95jhxfQx7pSO54iTkU2xFlugwHEXOADIFYBZifTsWk1C1uZKm+C2bJEcoPRNQhNdoT+x0t85piMmu2WojsrHFZ4i9O7gGEIHIcH9fnJiat3mi2tJrDvVUsY3sTT0Nvr2N6JlYSOr5XrqoiDig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(4326008)(5660300002)(52116002)(66476007)(66556008)(86362001)(956004)(66946007)(6486002)(2616005)(7416002)(316002)(966005)(36756003)(186003)(2906002)(8676002)(6506007)(6666004)(6512007)(8936002)(26005)(478600001)(83380400001)(16526019)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: hMAMdxpGunGQPRM46KttD//iSQksBZKHkLhTFN9yCp4kw4tejEFqGvhqWldu+c6Oq2QbLK7SM7kM/r5vycyI6B32ZSPtIxS4HfmfLscO3biIviKLTyyRVZW9VXFG+NkMW1HULWmBIqu4LWByn9J7UUc+auppc71lesbLDlnCgmou0gpWceckJRicD+TJ2HpiZGHs04hJMd3unigagGF28BNVPpwDWeod8Bnmr/6gJ5/W5qDri+SW/dhEyIow48mBeaUkZWZIGfxMXixjajUG4+cmVZqoHRHc97L6OQda/j7uWOri0u3Th3aaCRAT0VURrxV2B8xtds7D5H9BERuJyubK8I+/UQFUIbET7YzY7ScFv/PosxnU+IB74T7fcJbANFSTzqXzF+tnyUmyJmf+ZvBNB+cwB3uxhzQi4GJo1Sx+alCX+9dHqsnjZNVBdaA8FcHHP2UcYI3Zasktbq5rX9sgzb+HJabx9vAhJ0ySRn8UTDcYuO1+GcC2/ErPnsY+IXX6F9tVbUYuFNru5digGRdQs0+foqTvAqprfzUNprg85B2bw7VB+DLAu2PiadjaB8Xf2fQjA087f0Z2tH7zvCTOE4vSjawJY+WxwPlVDIR4Vm22rvC8uo3I6A0b87fEMzBgOgUAGCs77TPsLKLx3A==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8ea2fd-adf0-4cf2-dd6b-08d83dc9d692
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 07:40:37.2823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bBbmilcteoQrWFsqgQveNseDT6GWtkYVoaXZFHyIwf27hbzHziYOrywV+KNZfPax/A2LZuR2EmaZnYg4aX0uIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3464
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

