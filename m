Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A1872EE02
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jun 2023 23:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240330AbjFMVc4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jun 2023 17:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240317AbjFMVce (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Jun 2023 17:32:34 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2924B1FDE;
        Tue, 13 Jun 2023 14:32:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqauyT6LSN5kF+q2ZoCe/G0Ah2jshBACw7KyIT4Qeq7iNEzzXBp6mLQzqWVC831Hkw+D1t9AdBddmcurPFjqqAYJBemziEH4YWZ8MFepjaBdiRyeDBAXwbgkncK0RQV71K2TIpxmo7p7Axb/LHqkAkaM8+IbUOJDaXDQRIFy8TCX0OytIrZRT7t1mt9SN5hX6D0MDHVbM1zROPhlQXOs2mrU6v4cDpz5PrPnaG6ZVriODAuKyjkMYOBaTgDfMZN9Jt9WYqLmKFB422+HgVGjkt29ZqRfDHGkkiu4iFjcR+Osh56dHxnRfO9BySBKXg7Vc5rLeXeT9d5I1hS6b/bxRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWGw4Zf+HBff2ktpvDNTKgNM3Qy6tvNMDZ1fjELGovU=;
 b=U168XDoUYzawZWftloSz9k/A4BlvpK5H9gxb+CJvyM0xVDbs3V24kTrYHVcqpQ3dnUpcJSPU4Dm46s2R0qY+sIGZm1QYKFZLFmYAlPr0BbAE+tm8gpVxkjceL1tkdBkqFLF/yhQyYPB5uGZEW850XttXVIN2Lj+Q+NbMPvKALEKYadDT+KMyL6VYXG/yf+u2vnywpEyrsWU8T6VTRPgVBr7QfThV4QV93fXP5Bp7+8nSP8aHAo+1wYE5tvhRxHae1n9v05n6XkzsxiO2prmF2xP4E9Kn4uCl3H8RGQZDHkCR3JJWiJbeB2toJ148GbtMbEd/ezP1HtpMcpyC172DRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWGw4Zf+HBff2ktpvDNTKgNM3Qy6tvNMDZ1fjELGovU=;
 b=hjj3U4Of+ab5NgqhKfPA4WM1Wc+G30N/9n51F6G5Adh2m9RrmnHybV44J2NmYpR1CnS+u+V9MLR5dC/+utE0uRFJAARGQqghQKnL+NQ+y36J7O6nKeQUl88lLuvbfjalS7FxMQlDwAEzuA5kW8YVVa0vmXWrnHuiWCH/f5Ek2Ws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS1PR04MB9479.eurprd04.prod.outlook.com (2603:10a6:20b:4d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 13 Jun
 2023 21:32:26 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.035; Tue, 13 Jun 2023
 21:32:26 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v5 07/12] dmaengine: fsl-edma: refactor using devm_clk_get_enabled
Date:   Tue, 13 Jun 2023 17:31:44 -0400
Message-Id: <20230613213149.2076358-8-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613213149.2076358-1-Frank.Li@nxp.com>
References: <20230613213149.2076358-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:a03:217::8) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS1PR04MB9479:EE_
X-MS-Office365-Filtering-Correlation-Id: c806f238-28b1-4fef-fb99-08db6c55aed5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m99xJRSlhFqv3dczHVP2mQC6hj5ZHlKv0JRgmvPpkqoNgWH3M+Sn4cKSz86bjZ6cXVhY3pzESH1GhgO7w9vDs0/iEhKdrWzuRb7qWLwvJKTsLX0dVrfLy66mJj0EbdaKZYiURddmRNb1FkeGi2fRiiAYIJEjbUqjoRxfJiPK6AFo+KlJSQCYTqFTdKA6FvF3IIBh/QXuM8pWiZHJZn7+H5K5d/kJe1jvGMC/7h8OkUiHvZWpOu3efbvcJFWHXRgAo1xnL8lvs0saDD8ho0qXGxKBPRZUqa2YC9ssyvdhmIoz9jKiZn/J3w6rUozafNFjWfGwgoxjpAY6qyqIv/db/mUM9Hk/fjBWrqE7bhWqpgHU+WU7EPFXYWCSxZUEAucfj9tXxF6IZHmEKSuS3q5MVGmAnVBqCZaxgTI/7W9778/bkCmkObMmRRzO5IeOo0TiDq8TTmiaIgvJN+MNGYLwxlmXgZXOpznpqobk7tsRL7iqMFxF95an/b7UuNgVVlGctoHTvbr/vTF2mnBhjaQ2x8K9ff8IFjjQAEZdH7HRxnOEE+o26yMMFojXO/LgtdRof0BDn61c76zkxCEjiFdxpYiJ/dKxVH4JJB/GXjhZyQx41VUod3etadu/rok4awKGExTdUDUkifgMFvUYPVRRiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199021)(2616005)(36756003)(86362001)(66556008)(478600001)(66946007)(6666004)(66476007)(316002)(6486002)(52116002)(8676002)(41300700001)(2906002)(8936002)(5660300002)(921005)(38100700002)(38350700002)(186003)(83380400001)(26005)(1076003)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mjPz243is2msovlf9dXfgvI3WZOvkBnDTRNUZJYFHSlcWUkq1ACL+GN738jR?=
 =?us-ascii?Q?9RsrxIdPAsJ7LYBvUUAUPB3NFTSOtSdqtziJasoOfWFqx8Dn8u4IE79wcbjf?=
 =?us-ascii?Q?QWcziIsCPQar8ZUAuq6JRzz0VsjocxXfvCNBATWhXk8FiBSJqPMoJLSi0cpG?=
 =?us-ascii?Q?+5LCrZP6Y7LQf9tDRqYtv+uMHRs2R8G3D9ett5MzSygfoh+tL0fKdpUkjux4?=
 =?us-ascii?Q?23xbQqC0e6NgcCzrl4kGszPBM+k4Az60rosUK+7pGBkiAnrOk9MQVgHZS5NA?=
 =?us-ascii?Q?Wcqdouw62jbiNMaFTA7VRJUrISkD8z6+vOIq00OYErpRT35zgKoXIxrYFxxi?=
 =?us-ascii?Q?n6aD2DJXaCiwSCG0H2zA5Dw2nuzn6s+QfN53rvfjIHDSyMQpIrYK4lERqLyZ?=
 =?us-ascii?Q?k9LZ+8Etg8ktLk9KG2a0/a0a1+VbZDZd6+z09lbKKpIRjqtSYyo0dfR/Ldhq?=
 =?us-ascii?Q?/P1mm8SARyStqwKe4IkWrt8LGgdH91sQL57jpf3DM9ugJHx6GRAJUhNpZYO/?=
 =?us-ascii?Q?yNzra9EbaSLcl895jK/vKYs3xZdLJFlZNycOn68YA1Spr59WY1CnvYcqL8K6?=
 =?us-ascii?Q?iezEzv86+x1Qsptl4576PRp19FGuH5ODwHTYOTdRjPEl0y9tj4c3KPHqlGqN?=
 =?us-ascii?Q?CDYxh8PUg06sejes8/qAaNB0kRFbKPrg7SG9vuKK/TdXhRgRJJlca56nKlg9?=
 =?us-ascii?Q?9lpyAp95+ytavdGimsayV3AF6zQIBXvLZahRww/e4YNcL1brJ9Il2t5Qujxj?=
 =?us-ascii?Q?Bvl1ChFUgBvmwoYJN9cXtEtZQOwAmFa/s/0i4fHjb+7WTbiC4N0/n8PmFvgd?=
 =?us-ascii?Q?tpNjkeM6AzK2GPr44wOFnuV59h5jDgVVx2K8FWs/CxAyBw1/xSDXztAImc/9?=
 =?us-ascii?Q?hCgRsKMQ0wJcIWOvyMSw4eTkeLAiH9RwJVRFRtLI7tUnrL5JvuZbJW34VzuZ?=
 =?us-ascii?Q?HN90i5ZIJi3hHCddDirUN9tCr+1iBOeW/k2IbjfrXLtlWhEjzRqVe9K4vtj4?=
 =?us-ascii?Q?+NXOtVJgrVb34PORIVTZ1YB2zasyYuHPeTjf7BaYSpAfmsDidzQ4wc0YbqF5?=
 =?us-ascii?Q?+3NhV/CFXIBP3WDnFcikKmMqURdKLdID4sgR5ZM0neJm9FBCTHW3BMCAjsao?=
 =?us-ascii?Q?fF9c7jru6iLMHNUQHrYnUYvJ3XQbH0frhHorvenouSEuZpbVhjLYG/s7meqt?=
 =?us-ascii?Q?cOwfqZJiERGUCM0IDmNj4Bqp3J1MYxpMG4giv7XvDMO/Cdl1fDiw58fECM7b?=
 =?us-ascii?Q?XOw1aICxoVNui62Xv+LH6NWMl0lrE3W+mUXpvQPkCWgXX2c84R7BPpCJEcXY?=
 =?us-ascii?Q?cGunMGbt63G27a1g41IlFGerYh07FQywLh0VT47OJVZzqBQYl+oy40QafVca?=
 =?us-ascii?Q?t5vYxekypvSWZ7prKwGhq8lVw1xxGRaPTGyc+1ehS0yqmzOnWlLWJkck89oi?=
 =?us-ascii?Q?wxRFa9c7+RuiSfnMx+ojTAMC8RhUFh9gAfJFN+nVk8/BImWcEH5WBMCvs6+O?=
 =?us-ascii?Q?YOHyK1rM/c+7+kb81xOXChpguDhRh0ILtNdthbuWovwxWg3k5Io6nGyFJpcK?=
 =?us-ascii?Q?OqBlQ88YL7myjf92izHqZU5PYrTb6UYY6LtdyuqJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c806f238-28b1-4fef-fb99-08db6c55aed5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 21:32:26.6112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyKLa2CotB46F42P/gk/KMKUt3PI+cIgnQvrgNcR4QLfU/0tZciusuLNMphyd+bLyaA4KiW5ky0sME3Bl+l4oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9479
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use devm_clk_get_enabled in probe code to reduce error checks,
thereby enhancing readability

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-main.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index a0e54ca4893c..503e5ad5a8dd 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -266,17 +266,11 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	regs = &fsl_edma->regs;
 
 	if (drvdata->flags & FSL_EDMA_DRV_HAS_DMACLK) {
-		fsl_edma->dmaclk = devm_clk_get(&pdev->dev, "dma");
+		fsl_edma->dmaclk = devm_clk_get_enabled(&pdev->dev, "dma");
 		if (IS_ERR(fsl_edma->dmaclk)) {
 			dev_err(&pdev->dev, "Missing DMA block clock.\n");
 			return PTR_ERR(fsl_edma->dmaclk);
 		}
-
-		ret = clk_prepare_enable(fsl_edma->dmaclk);
-		if (ret) {
-			dev_err(&pdev->dev, "DMA clk block failed.\n");
-			return ret;
-		}
 	}
 
 	for (i = 0; i < fsl_edma->drvdata->dmamuxs; i++) {
@@ -291,19 +285,12 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		}
 
 		sprintf(clkname, "dmamux%d", i);
-		fsl_edma->muxclk[i] = devm_clk_get(&pdev->dev, clkname);
+		fsl_edma->muxclk[i] = devm_clk_get_enabled(&pdev->dev, clkname);
 		if (IS_ERR(fsl_edma->muxclk[i])) {
 			dev_err(&pdev->dev, "Missing DMAMUX block clock.\n");
 			/* on error: disable all previously enabled clks */
-			fsl_disable_clocks(fsl_edma, i);
 			return PTR_ERR(fsl_edma->muxclk[i]);
 		}
-
-		ret = clk_prepare_enable(fsl_edma->muxclk[i]);
-		if (ret)
-			/* on error: disable all previously enabled clks */
-			fsl_disable_clocks(fsl_edma, i);
-
 	}
 
 	fsl_edma->big_endian = of_property_read_bool(np, "big-endian");
@@ -364,7 +351,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev,
 			"Can't register Freescale eDMA engine. (%d)\n", ret);
-		fsl_disable_clocks(fsl_edma, fsl_edma->drvdata->dmamuxs);
 		return ret;
 	}
 
@@ -373,7 +359,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev,
 			"Can't register Freescale eDMA of_dma. (%d)\n", ret);
 		dma_async_device_unregister(&fsl_edma->dma_dev);
-		fsl_disable_clocks(fsl_edma, fsl_edma->drvdata->dmamuxs);
 		return ret;
 	}
 
-- 
2.34.1

