Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF8E1F0766
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2020 17:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgFFPV6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 6 Jun 2020 11:21:58 -0400
Received: from mail-eopbgr70055.outbound.protection.outlook.com ([40.107.7.55]:57088
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728904AbgFFPVw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 6 Jun 2020 11:21:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRsnN4rnXm2Uf79wbpERPdnuf4at2XGWX0tYTXq1oTaZ1vkQHvHpzYSyHJ7t7OK0EHxE5nRuZQV+UF1NiBbC+es+P9r43y0y+t+Tie+C3chJKwC4iTm6jSgposMKwYpzYznaV3BrbA5sLLR1EUoJWOeUlnFiyNC0bCXOluGz22YMD+nY1leTz2SVo/lS3Ne8v/JgL5f7JS1v1DmPJPL38qJm/br/fl4bo+O5EO3CgK+zB49LdeX461OLJPHYZA+SHRPbm/doNbKZzy0Bgt0mPqfSwbSAOZ5UpMea9BdxdnpIeIGpBEdb8cynWM7Ck9R4JFdu6T5yPQXnBpd7JBRshQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwfoeN46wII4AzCv4Aep+lEnXdhpI+0nA9yQ0aIHe7M=;
 b=A7oJTc/g6VAOAJozfqMzkdUjKMSgZteUKgIoV2f+63baUfYVEcigsnv01jUNv2ZGxrZZoIwX8W1hX62nADrFI/ZZziLCyA6Wlah7hGRrOHNmpsAksTzFiibwalxYeevSUmc1tcKsWno/r3s+IgHEsg/5T9e3Tj3rUlU+DWdhyEmLDHhR53Cgc14NnafuGZiL71RiyOwK63cLZTVfDkZgHB+pAA5onHqu/zUGuLSnvtEf8pHjwupKvdsw5Ll5WK3CrnNOLKtfPKpIfinVKxTqjHdrHN5Dm8UKSej6dN2shy3l4n61BVa+akWQhINwtDsS1WEnFImsDWWg1kmh+0uNJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwfoeN46wII4AzCv4Aep+lEnXdhpI+0nA9yQ0aIHe7M=;
 b=se7r61Es7E81ZqygqHlsGEQKdtip+457S2PCZsoGtItTLkBAAfjOtMnF0vv8x52M1j58W4KG4cOCfXi/wbDRuFjcMbV4RtUjcROTDJdHNuWRCci4FCSeE+NGBpU8m2OW6Gj51hBe4JNOmVdgLJWTqs05g8DT98cGgYgRgf9fKrk=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6511.eurprd04.prod.outlook.com (2603:10a6:803:11f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Sat, 6 Jun
 2020 15:21:45 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3066.019; Sat, 6 Jun 2020
 15:21:45 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-imx@nxp.com, dmaengine@vger.kernel.org
Subject: [PATCH v9 RESEND 07/13] spi: imx: fix ERR009165
Date:   Sun,  7 Jun 2020 07:21:11 +0800
Message-Id: <1591485677-20533-8-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591485677-20533-1-git-send-email-yibin.gong@nxp.com>
References: <1591485677-20533-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR04CA0184.apcprd04.prod.outlook.com (2603:1096:4:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.18 via Frontend Transport; Sat, 6 Jun 2020 15:21:40 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 911ec55c-7be9-478a-6998-08d80a2d52f0
X-MS-TrafficTypeDiagnostic: VE1PR04MB6511:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB65114F07FA075720080D02D689870@VE1PR04MB6511.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 04267075BD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qITVc7SVY52UqTXq/Pkk1ON4uhE0wePxcu6ayyuvJeUnKu/NO72M70M1VuUY7RwHFerISKQwi250BE8+gvSQI9/4vTqpR5E2bATs3j8s8tKMQStD+bqwHkqw16k1AwGTMhmvG4go1t/bABwmAWxm4mzF5ZoF7tkfSQZ1ei5bnUkvx8Pm1epsKq1p/39zMGbZvSXw/4Mjb5CHGGj9TS/QuS4MUjPpyDt9gK0/Vwei5xvgkQO90/dr7yS5QY9MftjvJsxAaC95tXu8P6lmVEk8++tNSch4XvkXA2ZvhQ8gvsAwnNK8MzI2zOLpI2hnTwqEVjHWMHb8XAYWO1LR/3lnHJxZ/miCt0TuXLct/MQk4RIuxxOa4gcF9QrfXfWDC8sFHb4tLdoPwwAu+9Wkw2f1hDOfDx5ZSVMLh3v+4VkRYlCm+c5Zy78zFyQe+jWlhT5RSByzvhW9N8knrubNT7LkMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(86362001)(5660300002)(66476007)(16526019)(6506007)(66946007)(956004)(6666004)(2616005)(186003)(36756003)(2906002)(7416002)(316002)(66556008)(4326008)(478600001)(52116002)(26005)(6486002)(966005)(6512007)(8676002)(83380400001)(8936002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: yYmSisGS1blfkZaHxXmlVp6HDWkDAMrP8bR2OW4cvMIfoaiSiWnPRn5kJr5e+kBi3hjHH/R//2+2AS4RmTbhfKptL+PPSl3TwwDa3Td++N2iIPPrII3YiwZEm6MM6xLf9JniOb9pAAKktKqyeH0spzavHWXz14WHOk9VJ/I21ojcvqZxXz+CpJMZzR6TOAvtQBONvBpGuZ5eUWCgKJcoBjR0LcKVYZOceyk6nt710QSUXODizW+ExWfE9CDtSyj7yCRcJTO6ivEqwFpdAq9QFe2g5CNhVMQszf0i0rlZcQr/dUwd4kkK6bylw56Zk7LO/rNpK1Na0fOBIcwUtihMxQsLgZrd6G5Qk6DyBWLqoH1vtg/Bdnaqfl1ZxAMmHbXUvnEPat9OSVs7SeMZpwbtLQTqWUcYxev94lMArb17okytE4O/UxRaSuJ/3YPrX6mtHcLzx2JcnuJNSywOQdbZB3Qp7Mr+xjFkcc7WPKV0ZDk=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 911ec55c-7be9-478a-6998-08d80a2d52f0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2020 15:21:45.6347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KZ54JDec7PAKZkQVtKVcaw3TRO5RsQ6NnUlvA9WYRU0t2Kttec1Sv68EXCCLuygtQYwFmj9sHwI6KyHwbpDkzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6511
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
index 84aebee..d4fe5dd 100644
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

