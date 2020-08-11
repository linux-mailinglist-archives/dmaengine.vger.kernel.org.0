Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39EA24175F
	for <lists+dmaengine@lfdr.de>; Tue, 11 Aug 2020 09:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgHKHki (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Aug 2020 03:40:38 -0400
Received: from mail-eopbgr130054.outbound.protection.outlook.com ([40.107.13.54]:60589
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728275AbgHKHkh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 11 Aug 2020 03:40:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBa1JnavbaI5/nn0c4Vw/HeyFy/4hdl5n+/D9m9g+A86uAW6KF/pPBox3JKL0TfdywmVlFV2g0H4L6f3RA8LEbvwNswO5o01fKW4G1PejnAcWSsjMsS7i5LxgUZEbDEGVPTz1FBdHIfFPougRyqXQ6IIZHpI4vxtr6ttt9DLKV+U839z7ThfvhdKqJ/ayU8Fs17i0vB48N/3Zu4OVSHlUGxRcfyRZC2luXltocvZusDB13Rq0+owMe3DGeh+8Bko9DoUQfOxW1SPE8WE0GBY/MCEjQRn5XhQrJX4iJjgND6E+6trNLsYOyJg/I69yU/w7cVkPY8nr1A01HXcfQnVzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7wglQdCBx4vybuSP0CcjtoW8ZOV8IUohKb+Ye4yy8I=;
 b=j4DL33NtyRdYmal9HBr5ysC0EQ4iUTk5kyiWCNyn1kIZlzf+L969vcn3xsjExy0UCNahS88tzEd3IngWs2blCpGHp2zv7D/HPANwzDI4BlCwNWw2bIiHW7ORp7MHyv39RcQOmtn4K9PdY2jUOiEAiEhxQc6RIeJDNb3UOrnJgVRt3WH4/zygfbUlb5L7Le8SWVlzCxtf06k/2eQc1NTRZdwTLaxbECRK3l5xHG2Me5jcSjUu4h81o3SI4VZy2CSTCLrzbW0i3rTwQebVFogFWepFhB7NgjgSLvS1C8MmrWoIAbwlb29UlfhkNV1V4tnewTLNuWpb7AQnHPJ9463DZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7wglQdCBx4vybuSP0CcjtoW8ZOV8IUohKb+Ye4yy8I=;
 b=WhrAXHIazubA4L8mGITvGEqP6p14x3iDkKxjMniQN5ZQysESMXLJwqw8CBgUTonSC0gUWRig9oyXSRZ4TmYgI+HrW2y1zLLyRa0oVH4IEdUaHSt8WI/WfZnmEKSvRB2A2yJdV1WktHd8rXm1vrpoof+mkIRAq5j1EGGGULKpeqk=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33)
 by AM6PR0402MB3464.eurprd04.prod.outlook.com (2603:10a6:209:12::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Tue, 11 Aug
 2020 07:40:31 +0000
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::c9b8:4020:7705:e3dd]) by AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::c9b8:4020:7705:e3dd%7]) with mapi id 15.20.3261.025; Tue, 11 Aug 2020
 07:40:31 +0000
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
Subject: [PATCH v12 07/12] spi: imx: fix ERR009165
Date:   Tue, 11 Aug 2020 23:53:46 +0800
Message-Id: <1597161231-32303-8-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597161231-32303-1-git-send-email-yibin.gong@nxp.com>
References: <1597161231-32303-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) To
 AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3305.2 via Frontend Transport; Tue, 11 Aug 2020 07:40:25 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 245fdb99-6b3a-42dd-8ef5-08d83dc9d2db
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3464:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR0402MB346445046D589353EFDD0DC789450@AM6PR0402MB3464.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vkixeMoeylYQMRkWfsPDd9BL4/coImsXcTTNJprU6EAXGHStQfElVCZ8u6OwX4+/gkv5ZNCpe1N1zIvoC3xGA7MquRfGFlgbvUFhG+SupAvP3Px2Z5EACYo+7pVw0CZK8rvKKLSUch2D1SWR8BA3+A0heUdBxLEWcYgmxDeN+yNtVt3O5msbcQwOQEZyxYZb5F/DKZlI7fphDygUaWidU06SsGI13Zit4KZAcAuKweGcKhr5495bpG+mwnpZHYAQGJX8jHve27EAlQUUU+rdScsdQ6BVpZ3o9B/U6hYCiO4wM4ylU6vIYXDiHdDhQ0h+FIQInsiLpW3KStXQSEzbbrfRi0SDQj9F25ab+MXsi1gNpMJRD0GkuRIAREpPbIfxoV53t5d+W13erlXtjC0ij2vyVIf5N8lHXXeDtiap2Y4le7f6OZKDgbiXl57T5NQowNQ8sDf+4mj0+FsqPOhYTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(4326008)(5660300002)(52116002)(66476007)(66556008)(86362001)(956004)(66946007)(6486002)(2616005)(7416002)(316002)(966005)(36756003)(186003)(2906002)(8676002)(6506007)(6666004)(6512007)(8936002)(26005)(478600001)(83380400001)(16526019)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: zKcm9oS00WtLeC/9JCw+hSG1q8HsMynsNSCZ5rXcV8fVoXStGUamJ8r+KNVUg3OpIOLIwjTe076dCb3RD3YhfrrRlAru996spo18RU3srLxJvcS6MJeZTMHUaY5Ep5XF9SiQAjKoRUCbKx2DgXkCxvrJwsWevYg4RrOqFgiZEYTo0sqEK5b+snPfmFjWLFge8CL7TMJrwf85KvrBY1rzLloW/UmZ37enDYRgru/GBbirW6IPHfJsP9IYPYGxeFniB+aLpw6WW77TkZwx4EJSwwpLqioMVr3obEduf/OycfAdJSyJkKv9U5dRCCstVu4Dtef1hQ748wEaw7v1RICyiEbfgZnNnuoqBmIhyf4r+BkW6MuV1Nyd8g42TvXEC7pQ6J18D9gs6Df/ZU6NzAytCUlCfULNLXr7tDiX+KgIMwR9jiCtYPXpk6/6vYq6OlZ6S3PzJlI0rl+OHnS1P5go1Hv83sFwW3k/QY/gwcs0aoVSO6lVQPZI240i/xyxoZRTPUrk81onnigiyjDIuPsOAuGETSHMEUq6ObXBchroQ//n+RTWGVZEFH933jJ0p5ZgJrx4gaQzTAHhmdGswy/PS3tUM3jcZi2M1LfWfUiOrvNvrHuyqWnf3inQoHC6NaZAeclY1y9sTiN8gZdTxA+3nQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 245fdb99-6b3a-42dd-8ef5-08d83dc9d2db
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 07:40:31.0419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eVO+BGZLivzoyXrqq9Dg2pcosA/pCzguESwE76DmTtFxjWesno2ZRWCVkVz6heltcWeTVRGVtaaG91XxnWRb8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3464
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

