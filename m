Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545F620ED71
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2020 07:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbgF3FZM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Jun 2020 01:25:12 -0400
Received: from mail-am6eur05on2049.outbound.protection.outlook.com ([40.107.22.49]:9761
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729677AbgF3FZK (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 30 Jun 2020 01:25:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Of5Sq+40LBh2/4BUbG22IcGXC8NKgk++u84z7YQGU64TEIEYWXCNytKQnE1wX1zCOXTg3H/aBdYA/Qn1d3Ju3i5/0BBnA4Q/eEXX4YQq+NGXB4W/3UcV2DUjDgDonyCifqy0Inz7/0v20hvQAP59ndtalocajPD1fmUtrtwhKmNwOYpKO2haa2WHlwC3s5p2qD5ZIEb7EdG+0jvVfytV9i4zNP4eMzY1v61fCItioDaLMQpSZLsa+misprwfMPg+L8cYxn1EXPEGeqwvQuIYhCAKLZKERzkbpZDT298Ss7mjbcteObcwm6FOSsgqDhYgJBpROyD8diqlo47LVyahgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7wglQdCBx4vybuSP0CcjtoW8ZOV8IUohKb+Ye4yy8I=;
 b=WWNStUA2RAKyjDFWykLikBzNqXz8x4qFoyPlGga9NNLlypl5qs5BFx1kjHfM+TGDzBgHjL/SDlsBL/hZ1mzxQYUjsamFMyDOZpl2VSxKmMVrft5vHhkZMBcoGaufjAQnYF1RFHi0g5ARF0h+iRh4uwWzQLwDIxi8H/s4tnWesGrlmG8U++opjBZ2uoGAMXj6m+bnQaL0JmoPIM4Ncg2QIVu+bweenFTc53jNqdDOBIhR1y6RvjeGOkNwWv3I1ivQpoNnNIWb9lyQtvc6I0sYWdTbovBDwIl21EuYGYEWHqXKCTJg6f3DQyRBwnXDtz81BfFb+lK8jyvebMohkXBV1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7wglQdCBx4vybuSP0CcjtoW8ZOV8IUohKb+Ye4yy8I=;
 b=QytV1BsEI29GBoP0vEu0zUsLMRGa5D3oR3kvmywHaBdbS/BIAqfEnV3iGKK+8ktusw14ukgm+J8GIhP7SOmlWdvgfXMiczn+pR6KyvGyoJY4YRMb5pMfhWCpiW3qsjeKtYpWVS/BhJQaW95eeQQy7MEUCdhbSAi2UUbAUP5UpKc=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6640.eurprd04.prod.outlook.com (2603:10a6:803:122::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Tue, 30 Jun
 2020 05:25:06 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3131.028; Tue, 30 Jun 2020
 05:25:06 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v10 07/12] spi: imx: fix ERR009165
Date:   Tue, 30 Jun 2020 21:31:11 +0800
Message-Id: <1593523876-22387-8-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593523876-22387-1-git-send-email-yibin.gong@nxp.com>
References: <1593523876-22387-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0132.apcprd06.prod.outlook.com
 (2603:1096:1:1d::34) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR06CA0132.apcprd06.prod.outlook.com (2603:1096:1:1d::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3131.21 via Frontend Transport; Tue, 30 Jun 2020 05:25:01 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 840cd8b7-c5b0-48c9-7339-08d81cb5f2cf
X-MS-TrafficTypeDiagnostic: VE1PR04MB6640:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6640CD35C7D8EA8F4F143A7B896F0@VE1PR04MB6640.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0450A714CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zyTe2g5ijPrA6OQo11BngqhKwidXqdiBq0Ry9C0PxouEbxW8qAFUAMP5/nlr8bggW9x2cqgkRf+if5TnfnmsdNjmMBOsve6fkMO0uo6mynNGxq2Xn7M6fbOR1IuTxyRqfn4Su5tK2AU9/3ksqVDPfsS885TTpNrpK/QBpyu4f//AUZjUlw3RZDvUY/LvjY2XW4BtS2vxuflcJgiG/iCiDq+yillgiHiqGkPMMxC49LjB8kI/J9BBZNNUFmXAP2nAjFtri7uWyvVPq7IOfynMx6ZBEos/4wvU3D3sM+lS5OfCv+cJGhMukLx3CldyujjRTwgJ0Sx8oaZsOskJpwljiGkS3wmiFtoocF2wRJNrUGeTrjGPA9AhQYCnQfQW6gOUvEgOP7bG1wrOPSJLKE199VpcxC0iTNc1EB6Mr8AKXWgBqAk/cMSRrawYvKVTTk/KWBJoZh3w5k/HGnyWYv9FiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(86362001)(956004)(6666004)(2616005)(52116002)(7416002)(4326008)(6506007)(6486002)(2906002)(5660300002)(186003)(26005)(36756003)(16526019)(8676002)(966005)(478600001)(316002)(83380400001)(66946007)(66476007)(6512007)(8936002)(66556008)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: jETdR/b5t+lrSn3urVeDLMtPN5yrJhM6TkCkzyAu3pZYOx5lMttqYnqPZ3ljuoNq6L4+tiRR0dCq2NV6JTCWLh34Zs9O+sfaPXsdr9IEYd/aaTZG7nmKbx7UcTRb+fyFkKRBNQUVHdlDU58KJKLt+t9DLzuVclzR6oSQYCEwBV8TjjIMBy6lkI54WghWaqQt86OHSxeUqevPM68C8p1QCBktZtMo4GIxkBpSdcRK7a7+vTmEES5ASr38BpLtCIufVQJaqX8WAtWqjT52dNhUDr4Bivnwx+a0Z/7y309q2M4GyCk6ZIOxMkHkyTs3yQqJL7v3jUuc7GN/YzQAAWs+PJKEVUMV73ttJflyzP+2bctrutcYi1h15Ip6AsCNEbTkmu4FkF+9Mz1Zfi7aw6eO0E3Nq+sDsl7QP4z61mVPQArWFhuKQGBlto1RbrRgUEZl9vSHgbERfIq+ypuSeVyglFHKRb9D30ysQY8f47kgr08=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 840cd8b7-c5b0-48c9-7339-08d81cb5f2cf
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2020 05:25:06.3723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uVG/Q4oBP9u8RegbihvlB4/KcTdIi9D5Vr5N09V8Pc//8NkA/2luUwtuUg+TlNA6DRxEoNFZCgDhNCRZzvnPHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6640
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

