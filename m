Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435717128A5
	for <lists+dmaengine@lfdr.de>; Fri, 26 May 2023 16:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243949AbjEZOjT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 May 2023 10:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237223AbjEZOjH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 May 2023 10:39:07 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2053.outbound.protection.outlook.com [40.107.104.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20835E71;
        Fri, 26 May 2023 07:38:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9pUO3IzRlVqd/Y07PZkPnqoLH6hxmMH+SZEf0sdXp19b9dOnzQjHUD/WzsBLu3zSPQqfslW2iOSkvrzkz8x+36gjAvwuuo5fz/nxHAnDimV1j7zWAOzyJrXtr2poUugmLoEVhfYV5fx6RYrGAjNHD6+qYx61Nkd9v+cGgx2HhihlBx7Pdu36QAdRLdi/SVXmpYFzB7Z9GXKUunEUDdCOjXFMTdIq+PNRrpBQXyrv4CtPAHYVlQPR4EEyV5lGpD02Noo42TOxHoTOj7cUSoh/IRXTEXfyoym/Cn9TWDtExHly6Tq21hP1ymJKBirbZRR+i6Bt1fJSHQsoUpKAiA5/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3P8AoOS+eHwcaqc5bUfUnf+Uxj1PFHD3YCKbldbyag=;
 b=nXtVWVFlHxROVB47FLRdImgsnI2E4LmP2W7wSv1K8izDeFZVKSNPCibjlluhxmt/X3VgOZB9DNTLNh8ge1CzdwzN8yxy3/bl1Jr0dhBlrMa2PsxU+VfVhZXLgDRvXAc5N0up5ZMSufBZT8oG+i2PVApHwb0HLAh8h32CwU5F/4uXBlSyeBUaBzc6U3VHVGZbU5R/rqujtClxl8VosP2PGbvR8tdGduxyWQlBF6f7Rbm0xFN6kB/u/49Akeg1mbJUf3MstDHbsDnembbJsN/amlfgXJ4d0u6ZzWf6qlL9FFg4CvpYmmtEkH7JDrSPulbv1fMpzWuFlqL8oIoqUPeskA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3P8AoOS+eHwcaqc5bUfUnf+Uxj1PFHD3YCKbldbyag=;
 b=KPqa0LN6cN59ZE7OSFnTjDHNU2yH9vxL88ovbS94LMSO1O+52iekMi2OvN7m//Ok3hYT0LNFABWJzN7d1YLIkN9u40aFuj1F8PvPMD3Q/pS565xVXhIouWGQE4nXqxa+f0T5jr0d25rKCwBPTcrRSRHvVhXg4a1ys9WDpy/qBX4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8070.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Fri, 26 May
 2023 14:37:17 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6411.028; Fri, 26 May 2023
 14:37:17 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v1 07/12] dmaengine: fsl-edma: refactor using devm_clk_get_enabled
Date:   Fri, 26 May 2023 10:36:34 -0400
Message-Id: <20230526143639.1037099-8-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230526143639.1037099-1-Frank.Li@nxp.com>
References: <20230526143639.1037099-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0212.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::7) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a2ba342-7aaf-4b99-6a06-08db5df6b429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FiADvj2oFRg7twHp1NKay5OKCXKteQOBlqAZtwMA2/XnI05raERxG1ci7VdL8xgfvt9yfDg9wDb+deYTCPsZWMzho/CmdgrUvvqiM/8mAeNKp8qxQG/ZhhcOP7bnjndhXUS+fkX9wuz88U0Vn6LS5luh8+HHbmT0OOgrZTvwgI1m+gc9gEL+JdtxogRjiv4Vw9LKNpqroJL01lujdn+k9+UlquCWVxgshf5JkJuVY8p1SunWyP0EIKxreFAFJJoFy3Qh+yBh5DGMGCdnWe1Pl4PX1ybK9VJ9/nEONpU0Kucy/jT5Ofo0rYFiLEE0NVXMf1KvfjycQATHIaP5B87MALvgj9GGfUjPNUNJcWbh3FMrThN8sYgHQkClgGzBbLDJfBA/DoE2DM5Q68ZCfP2lJ5SQocw75jocXAlSk0MsUwGZyAy2Bbw/r8FGZ0gp2quJxGzNiKSPk8C+JxNlBZmrL+OMkHLjuvyp+w0CjQg5hZOppE6C/nIJiwgbCCr1lYULo2Z+n1KQduzhtxBWd0m2pctU/8+lfilALMjcNash5Aki2IwtDec4DgxoEwR2W5tLU7yGzq5yIrvw9bQXTcnUYZVSVRB0uA71THrLY5AVgZoWM/J0ToGt1aQsvdSLKcENXU8t7BMwhp8n3GqlHNo7+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199021)(38350700002)(38100700002)(8936002)(8676002)(5660300002)(478600001)(6486002)(316002)(6666004)(52116002)(41300700001)(921005)(66946007)(66556008)(66476007)(36756003)(2616005)(86362001)(186003)(2906002)(83380400001)(6506007)(6512007)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZMmRwxSjuX5IiTZiKgbWtLRXC8dy2Z2uvBjq2yrGjhT3zdrXyl51S4zT120t?=
 =?us-ascii?Q?0gsdY6fxctclyxRsCfc91RX3ZIgjA2CQH31x+W2S8ekfHvuq5fnxSir4macV?=
 =?us-ascii?Q?HCE1lnZeVUd5I0gwY53R9uR5aR6j6AvHExHoJlkcBBX4L/87xWYPXWvliMuf?=
 =?us-ascii?Q?6N+if2gYfy3FNpaaO7adtiJOSe8I5sNuikHkzvYLg/sN7RPKfnEdjw3BG+le?=
 =?us-ascii?Q?hYB5/pg+7U4iM5VRWqIEBrE5j3/W9H6DOyzqkAm6g/GCkEWeKL+8BWIGX/Mh?=
 =?us-ascii?Q?QvSqqewHmIaNeCBitOYL2sv7UcDjtAgo7nGun+jMnxWX6ToQNM6WWh3yP26N?=
 =?us-ascii?Q?gRDmM0KvgkrzFrs6uo8orW/lIgnbB+ZVYAS31GewoxOdnlzcb0X0ScQ+AGM/?=
 =?us-ascii?Q?Md++06Apxkke8Up0AG2snQrAGg5AhmZNNWjibKbPllVtKsU3bwMbPKirra//?=
 =?us-ascii?Q?FmI+F55fQod7GTFs+hi+30idgqzEzlyzpHP/1GgfANNgdodO4CZjQzkJuSzZ?=
 =?us-ascii?Q?NN1NgYHeaaaDDb2SWBTAFUz2l7uqsZk6UyevmxsMYaIg/JkTDmdgFbSLK7T8?=
 =?us-ascii?Q?vpw1epQ9PF4ODyBRLNBvYTOjcxCjnqBC1e7FPpptpmVR1PakftpPCEOfwYRs?=
 =?us-ascii?Q?7xfCK7iiQaBvwKFC4hWyTcuiMH08fWFWmsGuXJFJNNF9oP9DRbMLjLJsPHXd?=
 =?us-ascii?Q?tubiGpmDXML0PrHKQ6G2etj80+i6plVOiUQMK5keg/mpN8KIJ1euGn1Fdq9J?=
 =?us-ascii?Q?xIjtS2ZGRilUmikHu1JlmWrlF+9GTY3HFytFmZEkvpZkHnanvjdDF3mE7fye?=
 =?us-ascii?Q?lPPxjWQoCVmBpvBi8LxAGZ+Js0Je8Xrcp1uw/IuDFeQ/EPOyyon9do8CjUli?=
 =?us-ascii?Q?aP2QqhwIpymquwFOd1ljfjWNtEIshJN+JHgqnbxYy0qtzDugEcIGtnxiBExl?=
 =?us-ascii?Q?gZQdfmF1oaNne3AygLkbl0JzeFAjfZUKSXgtGKAOlHjC3eLaoYvpue3kGirh?=
 =?us-ascii?Q?k4LjU9wRUq7sdAvaXaNVWFLkt1YUG8M4KMV7njPIbV3L05OS/nrNYvngA9AW?=
 =?us-ascii?Q?f9BqLlU8McER9biAIwxTYIRuGtfb+eaPxShFQqXqUiv23vllgFF2YdVW9NFw?=
 =?us-ascii?Q?0/EHN6lFfz6Yb/GJjW89Ga6dfWkrg4sWQlTY8+2WcOIo6T+Lz05IjAuHK1oL?=
 =?us-ascii?Q?d4tNGfTrYdhE94C6hyeYD0je+q9qWZfIzeRYUvbgFUPb6iZhQNFfNYRMlx2+?=
 =?us-ascii?Q?S+yU/TQQNdw8JxK62BqD4YPpsjCZawZ9l7u/23Tjfzbj9NywNQtTEQ8MvGF+?=
 =?us-ascii?Q?DPGe8XRDPPKvq1olpbgnhAlw4sZwcjwD8cQLFchOlBtLwdpageo9UaVcdCPO?=
 =?us-ascii?Q?O3oXDz7g+YgFuYtN3WShqmWTO6OWIPvwru8Dfg+hIqZSio6G+s5QKvLdriyY?=
 =?us-ascii?Q?SXM2Piz8SYlMnx/6uU2QEN4MkjpbEDVsh7V/fqaLJbZ/cu4yXgC/YQG9gD7r?=
 =?us-ascii?Q?EXJDeq6ZswHY1FpVnZAPUGAIOJmZNXUcsNOEKnVlU5NsRYJ6nBsknniAah81?=
 =?us-ascii?Q?BK/v/MWflHpV5ZcTrt1yic8mofvoEgG7YEUemPE1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2ba342-7aaf-4b99-6a06-08db5df6b429
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 14:37:17.0848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 32fUe0AS/YOdYs99JpZhU/Xn23SxiudxTSn+C3XZz19+D4f9igkK21wYe+UHZzJ9oAUjI6DZDOhcjP+CHnOY1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
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
index 9c0b6fb4cb8f..6126717fc87e 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -268,17 +268,11 @@ static int fsl_edma_probe(struct platform_device *pdev)
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
@@ -293,19 +287,12 @@ static int fsl_edma_probe(struct platform_device *pdev)
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
@@ -366,7 +353,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev,
 			"Can't register Freescale eDMA engine. (%d)\n", ret);
-		fsl_disable_clocks(fsl_edma, fsl_edma->drvdata->dmamuxs);
 		return ret;
 	}
 
@@ -375,7 +361,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev,
 			"Can't register Freescale eDMA of_dma. (%d)\n", ret);
 		dma_async_device_unregister(&fsl_edma->dma_dev);
-		fsl_disable_clocks(fsl_edma, fsl_edma->drvdata->dmamuxs);
 		return ret;
 	}
 
-- 
2.34.1

