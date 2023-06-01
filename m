Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6132471A096
	for <lists+dmaengine@lfdr.de>; Thu,  1 Jun 2023 16:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbjFAOmR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 1 Jun 2023 10:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbjFAOmJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 1 Jun 2023 10:42:09 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2086.outbound.protection.outlook.com [40.107.21.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4278AE71;
        Thu,  1 Jun 2023 07:41:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qf37H4tFRoOrZ/yefhdabbcktJmbRUiKJdi0RyNaDV3UpotB47+/Nm7vM7S39HSXGGXTNHAEjf4vLs/KoxePfxmhnXzS0GWdjgHqNjLSbswTwsq/j2s+hi3m8nYqwBFhstdkQwIKnzTuXjiYXhUWyw+IzwT/GCcN4upoQuore3UDBsvWdm0KQlydh0Bc+baxB1Bg4ahBiIIZi7UAiShVOsMIHhEMuwPy3drrtUwl/Vixr0vBCdIEwB5hD3BlirQ08B1tTtlgRyB3B5ZS2qlZYuE/Wa3gZkmhneFf2THUXgUAicelHWYR6nYwlIuEYgQVnUVdRv1y92IqIohT8XzTUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTnuy2oiZIXFuP4CJwEXIDJopDToYbLMOYN1F/PnZAI=;
 b=dO8Zk8wZJ0wGDWLbpxOn1wTAhmcaTHRk6eGyNWw5MJFFoLtyGo6wydKY6eXuYAh5lXMyFHor/hmptFHGymJYuZ1L0LHKnyYagiEP3f7Zl0bw/dP+83n3NNSAxIMKD7/Aj7GbAL93B0AQ7DZ/s+Q+NcVwlbdLFKred4GzlS3z3cOEIRRzHLYqwLBe+AZgWCk1UAW9GsZ6T3oBDvlV/DAdkd8XbF5HjCWrqttxGpLojdYwFZtIUq12ib1zIniXtG1sZYNvSNosTQhNRK2B6kIK7aCML88LJK3g9VNc8Kevx9Pt7IIP5COIRZvA0FcYJ6rr1IXiw591s49nHkKe8ylUEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTnuy2oiZIXFuP4CJwEXIDJopDToYbLMOYN1F/PnZAI=;
 b=cxifqw25GwBadMMYZQz6DuzGfGUfM1mryakGx3pMlkN793l4jbYbK/o/Bq04gj5gkmAF3oxhPw5C7gZBiQyf/cBWRjmAbNpQc1TX9SHhF0JKMMh6L32zccZAVjJ1gB39BSrpwkAc4oPWXDEbbfAqGmdw1SNWxbS3tDp28xvbGIQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB7603.eurprd04.prod.outlook.com (2603:10a6:20b:2d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 14:41:46 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 14:41:46 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v3 07/12] dmaengine: fsl-edma: refactor using devm_clk_get_enabled
Date:   Thu,  1 Jun 2023 10:41:02 -0400
Message-Id: <20230601144107.1636833-8-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230601144107.1636833-1-Frank.Li@nxp.com>
References: <20230601144107.1636833-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::15) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e7c8465-8d4d-4b7c-68b3-08db62ae531e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uYQo+hfUfgQ18+5M8dxey5uWHjIEgr0bBqdOOJgZFWUN+V5TY2POt7Gq5MYNDm2QuMJ9dayEPc4EpSqlZDeNRMXhxR3iVlzJVv0SCm9WEwhK0q+VcckpwiRqBLX0fDBi3QfeokHj5Xc3OcgjNh9Z1PnIbYoX4S4Op4G08Ddst5fWP32urov/aX3/NipjiAP1CWKM80Ctw5ze9zvoiJnalDNX7ZbrisyFakEk/n2RDvuX1tyyybJ0iIoQp3+Stnkta7fyTEtcbQxvrgH7B+LTiQuQkm6sWMhLTaWTK/jwre7WrLLuPZ8u3MBRgmpES7lknKhpkSOSlrBN2q3eh8MCVS2ujkFoAZpKTCdhUQZ2ld7PAHirYLlpVdXPqCY1IXjh5IfTXo1o1YZU++itGNYpxAgVzF0wPxbSWDP5HB6nNvz0p+iNEImqfQi+0vIdgQhmnrEg/CELHvuFtXQJcXqirP3iKbgvWmLC5MFfrfKFRJTrhOKQYE+yoD34td36f/YwbxPXkBo5fYjAJXgdA5JU/Df4j4SExpRPTu8WVCVEHjhhj+mkSFUkmZRWH0M2N80E3S1GKuDSyZLMqceDQaOkHQxWjiVLJ0mXE/YUwODpINfDSUFNwBCZw8IKvqGSPEEFsVNLu1MPkWbSvaK8qxa11A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199021)(26005)(36756003)(6506007)(1076003)(6512007)(2616005)(86362001)(186003)(2906002)(478600001)(66946007)(66476007)(66556008)(5660300002)(52116002)(83380400001)(8936002)(6486002)(41300700001)(921005)(38100700002)(8676002)(316002)(38350700002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7JT98iJNEEkMHKSAGQmEG6HWDJZKrbzlob66/fR1HcZfqTfi0SBhs0r1Qi86?=
 =?us-ascii?Q?BzObt4bCcoK5la0nRlvCqr9UzOoCUKm61a0xfMUPcnzq7da2+Yv2aXzK3rYD?=
 =?us-ascii?Q?9CwBsRnmWggwk40eGCL/B7MD0vfbTWUcxceytmAkGQBnowTsP50I0VJxaECH?=
 =?us-ascii?Q?A1Y9h9ClvKjE5Pv1kZxrX788cV4VozX0VB9PorNO7g+Hgn6qZzqxOBbZ+rTT?=
 =?us-ascii?Q?AaFANUz1giHrzb+LhVp1IGUN2mO/M0PSbW99FaWXPb2eTjXjiSl7Hlprjd3J?=
 =?us-ascii?Q?4JeUOVRjwc8mQn/Uv7J2efKNDJj1bSsNQ4859EwOM/v7b0SrQu+oL8tIFWWu?=
 =?us-ascii?Q?grkA/LVcM2pdObKvlKLMnFRjSE9ktc7EPpZBodmqKX5dOLYKwTnqhpWCQ24G?=
 =?us-ascii?Q?5To+N/MHTrXKe2LRJXwTS4MyJkWFEMhjHSAbMPJcPqnXe7/JpbsYUqG9iNBV?=
 =?us-ascii?Q?1AsZLQ2eryRYDprdM7hU3O25Gah5Xql6RP5bGEtN8aHMCenKg6B2dDO8kCcZ?=
 =?us-ascii?Q?GvP7WTxY+ictU9pUDU0kqJlj7uVy2CAEcCfBOc8JBvbO9BJT1cJciWtW7MAo?=
 =?us-ascii?Q?fU8Lwrwzi+4Kzeo9riHbsayydOgrQA8rSPV8j0txQmV5uZqGg0wlHH9HBsWM?=
 =?us-ascii?Q?LctKWqHUy1i4hcwqGSCNfuQp86zMacX3YHBoIxFyNNU0HzprxjNhQFX2Ni3k?=
 =?us-ascii?Q?2EhixLCwiV4uwn7pCJYStf9AE4HQk/I85hP4ovTqhncfByypeudnqeqGtlDU?=
 =?us-ascii?Q?vzmBBS4KVoF3zVamM5UM5UPdigYjHGLdDT//ukpVa8JRtrrah8sKeAhOmCN2?=
 =?us-ascii?Q?2JVQ8gG0DeaJeBoELG6JnyHA3w5n/6HZCHovee3/8Jz5Tv/dXIEeXLOSTMVx?=
 =?us-ascii?Q?D0mZBgum7n4njHR8vhZEqZsX/ZMqOkVUmyZfhuaXylGFxp/Dr2FAghjN8gko?=
 =?us-ascii?Q?55hBhwUA8kdkoZaIW4XMeTlnwyToOyoPKx/F7qaBMElMw+v56KMlSZJqZEuh?=
 =?us-ascii?Q?DmO1IxLqAzwK8AuerSlNyI3LvYJeULUccxhfCjx3W1Fz0gC8ZzRo1M2zc6qd?=
 =?us-ascii?Q?3+SHV4XOeIEgI0zpm3YNBh3Tu2yy73g9hAaLc58RK8BqPlIqn3Eo3zTWDpho?=
 =?us-ascii?Q?8RYnZAmsgyhWMAZ7iQtuUFXyoZRAwaOIMvnsv88OVe2gzbCQEKXn+GVtsoxw?=
 =?us-ascii?Q?jYGtp8Kcj/fBm5Mtz1cXy25mgMXXNIrdKpuh21QlBvp6N7R/qlwDrTIbN6UN?=
 =?us-ascii?Q?3HboDbxqxLNRoWq/hlUU8Tu7ks21Z2QZWOI0ik4fqwLkzTieaHviKoytpSjW?=
 =?us-ascii?Q?Cjtbn+4nd2T6E55u1iKh7db2ITtmY9yZaWLtcU3ChqV8tscgRjhfkFvF3zh8?=
 =?us-ascii?Q?VyW7kU/pRWoDSCu7GicUjI+hrEQt1UnPrZWG7DMNZdsoWk91AZ0DROH9ql3L?=
 =?us-ascii?Q?WsXA4ENQyoOWL8EWGSbcr73HC07yIc8dnWVny+DCwnU7oFIb9kNXz0GdDtyo?=
 =?us-ascii?Q?HiikP8se9x4AnBCVzgEZ29ZHmx8P5pWfE1oaBnNbH/aceNWAmWoQYJa3UbQ3?=
 =?us-ascii?Q?J3WL79vH14Fxc/gGshy01HGlNWVaaKOOYz/3qpIe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7c8465-8d4d-4b7c-68b3-08db62ae531e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 14:41:46.3572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U5tD9ZvD11vKTNLKVjEswxsmVWhbkkpbE+QbpqeEFKfy+4sihQH59AVYoiDA/DLSxuN0x23ALtPrGU5vXUqmeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7603
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
index 73178f250d0a..70e1a0605025 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -265,17 +265,11 @@ static int fsl_edma_probe(struct platform_device *pdev)
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
@@ -290,19 +284,12 @@ static int fsl_edma_probe(struct platform_device *pdev)
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
@@ -363,7 +350,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev,
 			"Can't register Freescale eDMA engine. (%d)\n", ret);
-		fsl_disable_clocks(fsl_edma, fsl_edma->drvdata->dmamuxs);
 		return ret;
 	}
 
@@ -372,7 +358,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev,
 			"Can't register Freescale eDMA of_dma. (%d)\n", ret);
 		dma_async_device_unregister(&fsl_edma->dma_dev);
-		fsl_disable_clocks(fsl_edma, fsl_edma->drvdata->dmamuxs);
 		return ret;
 	}
 
-- 
2.34.1

