Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B719257496
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 09:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbgHaHvr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 03:51:47 -0400
Received: from mail-eopbgr140050.outbound.protection.outlook.com ([40.107.14.50]:27033
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728183AbgHaHvl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 31 Aug 2020 03:51:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgypJKlHTr8JLJ7Ls2kp8i7Xf3Ba2Eptgcg7rOpMNOiZyXtb8trAIVD5SnIU4rTadf2pndrLdXeQpYUu2qf+lf81a4gvw80ePtBbYZ0diz62biSGFm0plCTVELAXnTiHVWJifyyU5FoO0QNO/8bjSMxR5BXTVdVNwIHhITUQMmaSAjAigqzzXTK656fe7tHqMBpOZFNePRch2RhtGD+tod2OOTDxRLdqLyatXYLfE0vib6Zewl6zHwI99fcZuezJaKclkUWhkHaIt3Dxp4M3CoWtCVUS4g7RkSyM7WvxG2J81YEm++ULfd/TFZZCGX6auUac7adxL20fD+MUb37Ilg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5E4RXpWtEXH5ZD6hhoNZYGbbhp9YaKb9LOKdxX2N9UA=;
 b=l44NMjVDG9kAjtHFPTWj8nJoPhhXQZA9dtrm2ZNauz6RiNBcw5zZY3IVK6kJoHklOJLHXsehiCcatFpT9qjX/p+d67qhlcWf3iDykkU1sWpOK/cp8ouX78jUGxtN4OVDz5G65WWNBm7yMqTVlYFD9ijw+78WzPjE8c3HWBBWR/EbujZ5u+jGPOZNNHoGCHDQaZ8iFK2viFwjiwgVuU6ht1Rby2NIAXkdUFX81Ul9qDtgaPK39/57IooZxpZ1ld3/tWS48xBZQpXK2uH2YK4KHFCZwfL/N/DLI2ejIWPo6X2a/bRRImD4xr5Pi3Xb7BeWsbMe9YyvkSrJ1wx2I+O8aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5E4RXpWtEXH5ZD6hhoNZYGbbhp9YaKb9LOKdxX2N9UA=;
 b=svUEepJV7TT7PTBPLU7+Zcme3BAEVDSVegQ6Fog5fD7PY8RnTmMxs48h/9YvgvOjhcTYTO6HL3DfFJwqAe5mlat/QdbWO4fnuL4BX+B6kHiMriVxxFZ/eHk81ZozGTznMOGLSpmjk6zk3QlWC07rklKBaMQ5j9uvG7giP8orXnI=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB5694.eurprd04.prod.outlook.com (2603:10a6:803:e0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Mon, 31 Aug
 2020 07:51:16 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950%3]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 07:51:16 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, r.schwebel@pengutronix.de,
        Benjamin.Bara@skidata.com, Richard.Leitner@skidata.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v13 07/12] spi: imx: fix ERR009165
Date:   Tue,  1 Sep 2020 00:03:20 +0800
Message-Id: <1598889805-30399-8-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598889805-30399-1-git-send-email-yibin.gong@nxp.com>
References: <1598889805-30399-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0104.apcprd02.prod.outlook.com
 (2603:1096:4:92::20) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR02CA0104.apcprd02.prod.outlook.com (2603:1096:4:92::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3326.20 via Frontend Transport; Mon, 31 Aug 2020 07:51:10 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3dedc73e-688e-4395-a50a-08d84d82a3d3
X-MS-TrafficTypeDiagnostic: VI1PR04MB5694:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB5694944061A608865612A0BB89510@VI1PR04MB5694.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cTmsN6gzQWv5yRvJPMlxOLHz6NTSMnrR30OcG6zfU/QrWJAr/RQ9e2c+br+n0SjJHFn5Y7Iv6N4TOXD0BMqZ7UNvztiv0EdzbTcMbMx4IGthhMk+i0xiQbPuACz7i2T8VikUBP4oNo6hSYMNFN3HwW941Jq7a9yWf17FbLLFbkPNOOtjq6Gvg2akL10Sf1OcAkp1vqUGyoeIvf/XUGnXFdXmXilBVgVSqRh8KorI+xkZ130VsoW1iV4XRx8c6Mjc70xnTkcxcgL97VJGoSGMu1QDeOKXP4AuoWDTICu51pR/L35ibT4/cjtfm2E9uKktsAmV5uuT12Ugq0rzFTmis7vFbxGlZTljDLGBAGETzbnALbTm8A1OyG/EmsN9128FZGv6IIP9Gbal4J/eBUTgtrzfPUbRiCuj0zJlQe7/G63le4AKHIxd6tnf+Vo1sNeDSh36Q505bT36h5sb6wy2Yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(8676002)(2616005)(2906002)(36756003)(8936002)(86362001)(5660300002)(956004)(316002)(26005)(6506007)(478600001)(6666004)(83380400001)(6486002)(7416002)(66476007)(66946007)(66556008)(4326008)(186003)(16526019)(966005)(6512007)(52116002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 9ukXfdh+AIq0mDlu5z4jQNOqUSq/nmZL86+GMXJ9VVJ4pB/QewOybav3JxIfOSL/RzvHilEBNOFPu5cj60g5vOpBRu+7hKa4u6NU0kORiaX4T4PLjODFcMOZqVz/XhX8w0tmbYCmP32ryPjJDQJA4DISYMr4LZ1qUznAmkceXPzZIq+JIQPRwOM6fdfnmDi3Wznm9I51X+42UGN+JSyMcneBvUFBJfNuamfNmfexkSV9T65GbUAzz65zKvD3OrZYFKR1uv0vQgpbeCi+K5cRsDDSNYUxPhvRJGYFQ5dfagO1XAyeHtGE5A9ageU/rwUr8HYYZNlGMAlsCW7syM1dsBgerDHNITYnR/ZM3SyMfwLWFa2O/QoEMRGsPI8stFTqNF4OmG3AFN+iWnEqCJSQ3NEIuG0LEHBRif00JlrpJFEnVTcvt9YaSaE69SolKYfsx3Uw0+6gV/EiLEFmytnHjX5xmmYNSuZkFglRRTb+x/uUqQTqY/XHD3AtQ59aeEvjmlprG8azlGzTQAvtkb1MrxFdzvYS5vLj8KTQpDJg7cbTJD+1fpn2kohUR0A2MhfpkKURnEHXx/GCLVr29qSMmS6qFbOW5U5dLUcGF4cOsO6+rP1vqLLReUYchFECTdVnNoO++Sgp5oV/1rbzlkGjEw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dedc73e-688e-4395-a50a-08d84d82a3d3
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 07:51:16.5467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RI+g+teCgV/4r873udkr04RMTDU2NtyJho28SohNmGujB3iDH7rwkNkh6WZcwyOa3Pu7wSOyIjwSqWF5Y9rchQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5694
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
index 197f606..9edb259 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -593,8 +593,8 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 	ctrl |= mx51_ecspi_clkdiv(spi_imx, t->speed_hz, &clk);
 	spi_imx->spi_bus_clk = clk;
 
-	if (spi_imx->usedma)
-		ctrl |= MX51_ECSPI_CTRL_SMC;
+	/* ERR009165: work in XHC mode as PIO */
+	ctrl &= ~MX51_ECSPI_CTRL_SMC;
 
 	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
 
@@ -625,7 +625,7 @@ static void mx51_setup_wml(struct spi_imx_data *spi_imx)
 	 * and enable DMA request.
 	 */
 	writel(MX51_ECSPI_DMA_RX_WML(spi_imx->wml - 1) |
-		MX51_ECSPI_DMA_TX_WML(spi_imx->wml) |
+		MX51_ECSPI_DMA_TX_WML(0) |
 		MX51_ECSPI_DMA_RXT_WML(spi_imx->wml) |
 		MX51_ECSPI_DMA_TEDEN | MX51_ECSPI_DMA_RXDEN |
 		MX51_ECSPI_DMA_RXTDEN, spi_imx->base + MX51_ECSPI_DMA);
@@ -1261,10 +1261,6 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
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

