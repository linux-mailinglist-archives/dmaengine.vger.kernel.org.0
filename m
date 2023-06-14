Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CA0730869
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jun 2023 21:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236918AbjFNTgc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jun 2023 15:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235944AbjFNTg3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Jun 2023 15:36:29 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2057.outbound.protection.outlook.com [40.107.7.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FD82695;
        Wed, 14 Jun 2023 12:36:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtUVp15rj8FSRkiK+aqlE2j7f3xWU/rXyrh4WVxZQi/u9QR0g27d/T+m9M6MUwa/MFMaP2ECeqjL3Yr37Cck1BPXEH1s8CVsi7c41HEiZG1PyQrZG1NR/pNuzT5Z9yMrmGxA19k6WQB1edmokLuqIX3V5UjBzjPe2xpwPvl5OmrtG472yJc9biMQXxI8RkfVWYkSek6a7aMAbFKgLncbB3yWeZ4z7tU6r3yzeZVS33O2A7LSR/vRAWK3xpxzBqkIyBVHdCoJMqhUetw455vQpoXFeR8Fu8m3HpKfj8+3MR+AqYOHWedF5yJegKSqGNtnX89od2HFWtF3bVyzGiyDPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3jlBv0SLDnSXx5LFjozJINPkoX9ob6AsqXt6WuD2a0=;
 b=i5ZtiOTvyxnOwpdNFDtQXEbRaXLOlhkUneT2/EEbRW7Kf5KYY8BKjmjdvZQEgVgK51R/rwJulnpGMsum2NUM4Pn2OrOq1f5cvhOr52FBjpU30rhqf5Ec4p/4xkcpR7xUYjuOuQvxZ8rAeo1ZMM9vQkMLDVXD6iyBbAEG64C3a/9SiI//1xPaRwlT8LqqqtT1Jj6/E6ukVtdKG5MJ/B8EbjjWQWkRJxTTO55D5aQGHjFogDeUCIvCFJ9ioW4pTfm1P0woYJir4P3QUWKLLMYorA9iTmkL0vhR9lh6ISP3yURyJc5WchJ9D1CKcKZ25XAeydX3mqz2wAVZw0SO0E53eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3jlBv0SLDnSXx5LFjozJINPkoX9ob6AsqXt6WuD2a0=;
 b=Kkgb3NYtwT67OGHKSqka0W6mHBjaA3pRntRW4a/3kCLBLa9FFxDnhVPebYh0hxGqZ5QTxcO0V2N42klOCCIcBsgufYlwvME5cKf7TtjNINZuMhG4YBwBw7qZ9456i/o3bBkAajwOvRnJiuqv5nyIF8NLY2iBiTDo4VBh3TKzIpk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by VI1PR04MB9763.eurprd04.prod.outlook.com (2603:10a6:800:1d3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 19:36:22 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.035; Wed, 14 Jun 2023
 19:36:22 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v6 08/12] dmaengine: fsl-edma: move clearing of register interrupt into setup_irq function
Date:   Wed, 14 Jun 2023 15:35:40 -0400
Message-Id: <20230614193544.2114603-9-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230614193544.2114603-1-Frank.Li@nxp.com>
References: <20230614193544.2114603-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0051.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::26) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|VI1PR04MB9763:EE_
X-MS-Office365-Filtering-Correlation-Id: 995b3aef-da91-4bb9-3511-08db6d0ea238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TcICVJp1Tcnwqpz8Bji3AOB+c8lm4RlOBh2ZoVbsBrfvv0IagN/rNG9HzHLxTFbKjBftZoTBYRsXnc7tBS2qUAc2mNb4VILRqQMx7GZ15OyiImUwVpBLdsV5cLRM7qOHhvHn0O+bXbJyjAzmDZGhQXKLy4wilDc0t/cg/Mkd7EUlimZ2Cj01IQ5LORZAIbhkDwBHClVKYXiJkpl0WhMbjfta3M8fNvw0Jx1G2Lf331I1DzRAtyv+PAmFIwZ7hoNwDxWgcbmG/BKcOhHks4kcKz0jFeNx7r85G7JJHPJzjycTunBYwmDL2LmqJkIlJpHh7fJvHkW97JjRacwQyc78UkuLO/d5+yCIq2sRPDGxM3IXuzU2acxSdtEXSZQ0gLZPglSLAQI8jqEYCv4x+Rg4dSg+Vw3JfGkMZNAvhQrG05wQplM3nabKulqEmrZiOJ8n0cgH4HRjBsIynrk+Fo1W4RULS4vTft/6E+6FUilRzCm5JxtetDH3cqYPxvugJ5cQ7K7n9ajjdMx2sanXIZFbqIqvLUAV5gktrnusZ1ajMKLB5RTYbj9Vd4II9wk47Uxr0rcgZY98lCWTru1jnZCwUAor83/9DTh+1v3PxstuxgToz5C2le91m5OD2XYA0l9ugT0HKwQDVeSMA+lQa94KAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199021)(5660300002)(6486002)(8676002)(52116002)(41300700001)(6666004)(8936002)(66556008)(66476007)(316002)(2906002)(186003)(478600001)(66946007)(83380400001)(38100700002)(38350700002)(921005)(86362001)(36756003)(26005)(6512007)(1076003)(6506007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I6fw1aAYZ4emaN2IiYxzWme+au8QxWupEnfJpZTr8uBO4P/U67QCx/PbHgB1?=
 =?us-ascii?Q?OPAP6fltrXF2R0CNPPphRME2HQqK57OTZ2gVqJs2B8PXE8T0rjfbFUJDXcav?=
 =?us-ascii?Q?0agosZcfxzNVnRm8/op4CSV091BkFeU7NqRF/ScEzKh7zAEMqK4DItOH5+8B?=
 =?us-ascii?Q?M92+MeCL9E1XfFELNp4huRcNqaOg/NELYB88vlNIBKKcsXoyZqwtUB8YdfKm?=
 =?us-ascii?Q?9Yx2eqlTHr76454cOMBnjeELQGSFSWUcN1/p36jW9ow0loPWBcxvUSS7dsQW?=
 =?us-ascii?Q?uoqHCXq6uh/CUsYMdT6QoGfEcuTqMRGSWm000TNn5296IJWAqX7WwKHlMUow?=
 =?us-ascii?Q?0X4++UCibRsnHLo5ZTHRXJGl7PjJs8/+tHCSSMXEHcR7Ri5t9GLi5gNDCUdk?=
 =?us-ascii?Q?vm6Yqd6JllUMctMAk6rrh1ASsPms+ok1QcnEchOozRQlVa3QVmQkeEwwnmiJ?=
 =?us-ascii?Q?SAo9hZLUCHcURMkpqfqkvdBXehIt0yboBKb4qr/P2yvhi30Pk9HwNbaeB5Vb?=
 =?us-ascii?Q?OILtzXf3NkDIw00qKAMykBCzjQluTmApQOv6wHDNh5BK2P6W7Dxcy9bgnYmc?=
 =?us-ascii?Q?yj54/mR7T7BndAgC4Z2cGR+ikBND0QyCliIiQ3mz5XQQOElq/mM1XEYRHtB+?=
 =?us-ascii?Q?hjxa7S47Gx6c+jkRgeF4mYZI91AKWMpqKUXwHRNLPCgp9G1wjC97q9mDTSkk?=
 =?us-ascii?Q?kLcL40zC1zHk0WMkcUyno9Vb0HNwkifezrjO9vCHNC7ClxsZeVgGPPVEJxFM?=
 =?us-ascii?Q?tBaitEjN3v6it+FPi4muCjYF6I7zw+HGcy3BhV/uGNgO2pNvwbCEI1h+NhdT?=
 =?us-ascii?Q?xogJ4Psf9HGWET4eawIZfT4kJ/q2bILI6V/ma/l30Ag5RrESGwdeSsSnqjiE?=
 =?us-ascii?Q?9ZgzDlEI0gbgy11BIRmxMkX03GVCFbSuDyNxTc8oY55xs7AFiKV9jt0CARdz?=
 =?us-ascii?Q?3H1oGGoNAuyjEK4UhAe5Kae7ii2F/NOES+14s9wZh+SuclUw+Hzma6xDcSUi?=
 =?us-ascii?Q?j9SGcfVuIom/LBrNHVJgbfGpZejq8DLg5tb8HvlTMvIJTSoWd6HjXwKhWuHB?=
 =?us-ascii?Q?cpXlVjo7CulD94IjtU8Q5fmX3gp6Ub4nOU2qr5Rqei3a987R0oJe5e2evOn7?=
 =?us-ascii?Q?sbb5Mu/O1gKzxIbeYs1EemCAUXN/vomFDVjR8WTksovD8U/GWA3F0RMxL5qx?=
 =?us-ascii?Q?ds42F3xShjcrTzdJdr0RR8GbQE/f1BjWiwxD4Xel7gM3un9ATB+Aq1J/CQyr?=
 =?us-ascii?Q?bowNi+Rbt117adryUjGWv+d9MaTclRzIXr1DMNRynje3l+flwNEAzhyrq8Iv?=
 =?us-ascii?Q?9REUhkukEaWD7/5AmtLd0ZsgT/wO3BRXe3GLuqDUC4ftwB+UbDqKbiWj1TTV?=
 =?us-ascii?Q?G7jXYFBYvCXJD+JKG9bO0jKOhVoFjUSnRcixFBY2n7EVSQIrL5RYmV9u2vlJ?=
 =?us-ascii?Q?IDzFM3EkXsTOLCPsIzYXOLRajmfus09hl64a/9olCn4ytSA9AuBCLeqObeQF?=
 =?us-ascii?Q?qwcB3jCp3fZMqK87r6KkRVdeFTWopu0A0QYFo3V/kpDHljoP210vWspCZNLp?=
 =?us-ascii?Q?HpIqEx6fnVYzjWAIdyxdSruFflr6tw3UuN8DCwWB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 995b3aef-da91-4bb9-3511-08db6d0ea238
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 19:36:22.4529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n49oHguS+80B8yCFrT8/mxNF4B4M6e71LmZ/emBkEUirZHaDViocfOcUuHITBSCCY1ghDcG4JlL8NqJ3+X9fxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9763
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This accommodates differences in the register layout of EDMA v3 by moving
the clearing of register interrupts into the platform-specific set_irq
function. This should ensure better compatibility with EDMA v3.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 503e5ad5a8dd..e67aec3f76b5 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -113,6 +113,8 @@ fsl_edma_irq_init(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma
 {
 	int ret;
 
+	edma_writel(fsl_edma, ~0, fsl_edma->regs.intl);
+
 	fsl_edma->txirq = platform_get_irq_byname(pdev, "edma-tx");
 	if (fsl_edma->txirq < 0)
 		return fsl_edma->txirq;
@@ -154,6 +156,8 @@ fsl_edma2_irq_init(struct platform_device *pdev,
 	int i, ret, irq;
 	int count;
 
+	edma_writel(fsl_edma, ~0, fsl_edma->regs.intl);
+
 	count = platform_irq_count(pdev);
 	dev_dbg(&pdev->dev, "%s Found %d interrupts\r\n", __func__, count);
 	if (count <= 2) {
@@ -311,7 +315,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		fsl_edma_chan_mux(fsl_chan, 0, false);
 	}
 
-	edma_writel(fsl_edma, ~0, regs->intl);
 	ret = fsl_edma->drvdata->setup_irq(pdev, fsl_edma);
 	if (ret)
 		return ret;
-- 
2.34.1

