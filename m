Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AFC72D097
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 22:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237521AbjFLUfM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 16:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237752AbjFLUfB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 16:35:01 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2075.outbound.protection.outlook.com [40.107.8.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A40E56;
        Mon, 12 Jun 2023 13:35:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEn5NzTS1YbhYgXXw4KfLHzogXRB/Fg2rLbJFFgx3G6aNfOoo3RXaf8EqrRLC2yZh/zE2Hm2v8HHxrbtffO2PML/4ohQyQry/6byUM36LTVKYBz4OR2PBSrWQe52x1F+BLVPw9ZFaH0O0t4BrtR+PNxSJIU2HHO+nNCzqID6zDwX+YsMB/IInk1xDDRROe1J6lNP4NN5kNXGfU2tY7SjKPOs6RyZwDrcMxyNCGbqavjTIj/rVm0v9Cz78f2pnNWadl7IoBe7VS2dJjylKdat1ElEIX7vKWLndajXjy7DcIIiScdxtyrWDPG4fL3L7zuh/VP6alQrBFGLs5ic1iJMYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWGw4Zf+HBff2ktpvDNTKgNM3Qy6tvNMDZ1fjELGovU=;
 b=MzRPRo/wYWMPs6adYK+8xn6sNcvuwD7iGMce30jWblPskT0nv1y9cLPXpnO1d3h6gXwP2gKPp1xnT/SVzbI4h2N/Gkn/oHvPjI2nJBSn+aKSF3+UvYKB9icaowz5yp5IQgyPewabjT6/Tz0ybnZ674JRdpFcKqV3M1F5W32hXtgPHYFJRsZHTiOIjNfszCH2WpUNiZq2H7YgGtHbq5XN+Vc8iOKcttCmWnAdIvFhivKRl5K92Zac5vqcA8qoUHLgD5c04WHy1JhzkXMxUJGuB1YtC4pxZqIBnLccOnPQKu2bRPmiKYt/FoMW5cjIy3x1WCSa3M0JFCTL4R6XlIDdIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWGw4Zf+HBff2ktpvDNTKgNM3Qy6tvNMDZ1fjELGovU=;
 b=Ppl7KbBp+e8TGj19XKqOhi0DppdtNtxhX1orlaU4qL78GOsMD4dddqlLo43ZymAVrmzOf/qQe1cTSIohG92Lb8jCosAlNaeVZLU7fFM8HK6qV/porcEI2iXlnugYSuUH51oDDBgJJTVLCjULxvTsl2OLq79RW9ZqRbaDITyIWR8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (2603:10a6:803:51::30)
 by AS8PR04MB7975.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Mon, 12 Jun
 2023 20:34:58 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::602f:42ad:882a:5ca7]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::602f:42ad:882a:5ca7%3]) with mapi id 15.20.6455.045; Mon, 12 Jun 2023
 20:34:58 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v4 07/12] dmaengine: fsl-edma: refactor using devm_clk_get_enabled
Date:   Mon, 12 Jun 2023 16:34:13 -0400
Message-Id: <20230612203418.2017769-8-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230612203418.2017769-1-Frank.Li@nxp.com>
References: <20230612203418.2017769-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:a03:505::16) To VI1PR04MB4845.eurprd04.prod.outlook.com
 (2603:10a6:803:51::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB4845:EE_|AS8PR04MB7975:EE_
X-MS-Office365-Filtering-Correlation-Id: 09837582-3fa4-43df-834c-08db6b847d20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zrcRWFv5q8d2ue7EdxQ/jZo4ybwANvN+aRT/WUVIal7q1CsL8/K6fAVvBQgM2hJP7V9Haz3im9SN+8YLhM+qtfbhAnmUwUEW32D5zFy7HJrAQXEOgjB+n/FPflmGDVAmNGqlE/IPM8ars9RVTwLtfMtvDZAI4eY7JZzE97MvWuFsTrfU4rWA37Q12DN8iccmg3lScbmVmpcHCCKwi3vYoGePYJ8pZgDqflDvZuWILqGFJKrK4qrApNaNr0I5uhBTSlSgmdGi3l8IUAY9D/DWbeH1EabDfFDKeGU4lEqSPcsJHzj9MyGxvgbFlCO+qXz3D2C0UjT5woiSIPSlloxKrW3xmXN9/xyGLGx2oRECBNS3ocvm+Eatr/q9HcyB6JpDRL/ZAQm8Lcq1gdOFrdDpg6Tq0b6CeJ4Xner4UX2A1fgbZcUGlZMcyGFJhSOiUh+iaERVhgyHGk+l15oZPvftYmvh3L+rlX6DyD9KWh1tlodkQUVsKZBE7broDdbSCYkBd7p0T6kLD2U3oVEBThMWM5lHylyOPt8Io3vbMV9j+Gfe4Q1aWPp7nisWqLjR4lGorf0jPDjiMohoUBhd3oPOSnAVLKhQGQhx9u+pAhtFFe4GKMOppCFkx016mIaInuXko8vAf6Kmy4j9sZ3iwKjGpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4845.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(36756003)(1076003)(26005)(6512007)(186003)(5660300002)(41300700001)(6506007)(478600001)(8676002)(2616005)(66556008)(66946007)(83380400001)(66476007)(6666004)(8936002)(2906002)(6486002)(38350700002)(38100700002)(316002)(86362001)(52116002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qTVRyC8t2oDZQ15vy0O4JyUPXjvs+LrorpwI9o8zQm9yHFQ4EMbVOTomMWfz?=
 =?us-ascii?Q?YjinqwNwWJjQa5nICA4N7KWYPZCog8Rk5XXtABlYZzu1du6+zQOjStG+2r0O?=
 =?us-ascii?Q?j0pegntc4wQSXO6jl/SQa+2/i45pNAOrdQy6wl7QyB2VOnTWOlLlHJb4A1BN?=
 =?us-ascii?Q?UOUEBjTWGkrOEeHHhcnHNvscFeGrbzVQo6m4FcXuG9Dd2mGOu+RA+U6Jt8Ll?=
 =?us-ascii?Q?t5ixq0jxo/He5neex6xwrlt414/pLd4x6oMNSyRi3gh67RMYwyD5ydoIav4E?=
 =?us-ascii?Q?D3V+pRnA9R+jJnE9GUI1CcGMuzUVXYrH5ijVmavB4Rj8Tle1J7lyXixSYJ3R?=
 =?us-ascii?Q?mgTf8soeTIA+UPFImUVqUkUwGc77/GhmA955Rh0CXaEZQeX6ny1FEZZrpV1f?=
 =?us-ascii?Q?H28bGLwyWsCJlsq+sG8dXpQrBNXu72roOxdLc9Kfg2V95t/bmb7EBzkE4qSn?=
 =?us-ascii?Q?k4Fvz50VZluAqOYcI59xHp1cyckAEhY13pJjl2W8HxcfLJCrvIkiQHfDsz4n?=
 =?us-ascii?Q?gFY0YNduFdc4arlAPc3Kw08QTIRC4hXEBWT2G9DMFVIlOMESkJdlLeICG1ow?=
 =?us-ascii?Q?vFXk4Ay67kPeHpZxPlh0JQn3shf90XVhi8pp9x6aKKSSTT7PM+AiidfJ3Pz3?=
 =?us-ascii?Q?r/69+o5HsejPpIZNyexW1dC0Qhg8WSExymlQukk9H4qpB8Gb2AV4xA47J7Ft?=
 =?us-ascii?Q?1/hSp6BtqhNqTl+i2/tegisDrEhqCvJ8GG/7KxiYGJ0x9q7zs+eC3dcbZ9UU?=
 =?us-ascii?Q?jXzhTjRQeuwOURMRmn/IjRcU4yWYDJVaaMH/2GprmYcX4tjZVzwRLqjSR/OE?=
 =?us-ascii?Q?7P8brdhaaurogbSEgfmOmcfJ3qHEOD815KMA3RXH4rHjT2dKitz4DgabSUkc?=
 =?us-ascii?Q?V3IPKjL8kf87Bw+3AgLtbNxE9+bJFeM+2sPyX/VwZj9Qg25kEdwly4gEswuZ?=
 =?us-ascii?Q?2Hn1eGVTh7KDdhuwDA362ogMDSD/Pj6tYuMhCEez9jZuSlBr3vIIUCvtXDD0?=
 =?us-ascii?Q?1Cwknz8I0lMBgSpzIAJiH1hZQlEERPwUDgIV3Gb4cIyJawJuRdyd3Sf/kVlN?=
 =?us-ascii?Q?K98U5QnkVUnZoFt4yBM7Aa2t8Ra2QLewICCbrHAtE3PEII/JU36OYEjOdPhz?=
 =?us-ascii?Q?wLSqQaEi0lPvmIpD7yeDumjz2phCX7PSNBrcW9ixV+ti36ySqFeitnBJ33fi?=
 =?us-ascii?Q?EESr07WNjBqEEE5JMEo580rrSku0q/xAvbYHCDDZ+g8fb/mnYvDcUMvD/N7M?=
 =?us-ascii?Q?phd6RH+9zX28PtR5cv1Zmnt0sCLrz+UEsGHwAtIf6uJkdz1VgesfoprHW2HH?=
 =?us-ascii?Q?hZ50ktsMMTRkZUY5uoBJRL480VfJPA+vGQd4Caqo4Xi0j6CzqTf+6zGRT+SB?=
 =?us-ascii?Q?/fcUu8h0WYADo4/N0ek6t4eR8giwKf5WBuU+3N5Kr/6gtuM7svr3ygxNZv/G?=
 =?us-ascii?Q?b7B2b3dctBZorY7RNyDP0RzuZiRSzYgctBOlaxXmntaaGqw6kVnqX6+/PLnk?=
 =?us-ascii?Q?YpCMzQhLNdfYQEMJe6oFFfvx1anUfZHF1WssPuDAUyMxaD3PzM6ZgM2J/McG?=
 =?us-ascii?Q?8d2o541ppdvIm6wzZYkv+vnubleIGJaHIKoIja0t?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09837582-3fa4-43df-834c-08db6b847d20
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 20:34:58.3962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jP3wmOH51E12Jgk8FfRMPQ/1OgVqnP2MrCWAehfhZfg6AyjToyzEBe3X31pKRpGeTvUzKDfn0NqQqu4/Qx7Rfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7975
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

