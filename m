Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CEF782E26
	for <lists+dmaengine@lfdr.de>; Mon, 21 Aug 2023 18:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbjHUQSI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Aug 2023 12:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236523AbjHUQSH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Aug 2023 12:18:07 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2052.outbound.protection.outlook.com [40.107.7.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264DC132;
        Mon, 21 Aug 2023 09:17:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/b9MOne2HyZyzmb7Q01JZAriUULp3BBeGjf3hzBiXloGJeIGvJIMjzy2GDsIwhwWNZb/VRrJ2EP1N0irDtuujSEDZ4Bl7jcPEGCygdBAQwAnSsUv1DcfKryvBE35ZnN9Dp/hFhobebm/YQTc/+JxMVKrbBLqf1B7DaXg+9LPwmtq1GV91kBPZ6NioO+VVgxXQEgf6F7jg2uM98aw1RjkBgJvyJNjsUPaS7CGjkdIxMUgVm7WCpBSyOj0ZKkV/LaqzsMJtosjFa4qiIkXpkXHTROayYjzXmftFC1PgT3ntyWAgaEsXU+Ye6QfQ8bKZOePZUlq6ON/rpSmJMYXfuPyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1QZvP1Qd2YtDLfQYwlU1EH3Jm+4a1h3jZaVBdFog2M=;
 b=CLXxxdXswryDBCqGpjQu535trPRyOGopQUJOkwafX1yVKUHRE5PU/VUi5CaKNgBwI1THeHDafREad/z8top/sku766qXtZc+P8gSJjd0cQKW4iA/DKFIxSM7mz4CYC7//EVe5DR2z+gKYinrYWNzMl8ibe0B5RlTKpJSHpVk1vznZQZfWOZtyGNLqUoIR/jpYWbA83GZT9SKLN/YAtMdKuDtxDEfaWYJL+pwnJ0e5kgif4AEGwHe1WJBYXVm9Bpf1hTbFWApwQ8zdBLr/W65dg8mYqP3ERuwxTJ1AqSRgMBsNhjAVkgV6lUkipK096EAiIDrP5ZJ1jo3H9y4bilbdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1QZvP1Qd2YtDLfQYwlU1EH3Jm+4a1h3jZaVBdFog2M=;
 b=sI7VqZn6sjWBw2CWhMK9lI/k0aeWnf4aNrSbHMGMZhBxONVX86+LebviegU50yCUmc4pwDsSb2WzJJQKfIcTo1yUZdoFwYO84v781DVRw7ynJVfQ4quajybMv6ilL0kWuwz9oPRHqiZ3YuG86+9Y36Wfo69PNPeg6lUGqRzak34=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB10042.eurprd04.prod.outlook.com (2603:10a6:20b:67e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 16:16:57 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 16:16:57 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: [PATCH v11 07/12] dmaengine: fsl-edma: refactor using devm_clk_get_enabled
Date:   Mon, 21 Aug 2023 12:16:12 -0400
Message-Id: <20230821161617.2142561-8-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821161617.2142561-1-Frank.Li@nxp.com>
References: <20230821161617.2142561-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:a03:74::30) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS5PR04MB10042:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e77aab6-eedf-4514-5759-08dba2620a76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +dAvC4FtvYEdqftDcHYT31XP7UB+iEUt2QMfc363J3hA3jsVJguP6wr9R50qS2v1psFlIH/lvj62COfPulO295GPERRdOgxU6NkQFAg5lxWv3khmTvkK+D+9rdtLiUTDlvaAkjWcse/G4UuP2geG3JY5cX8gIaQfu+9RqMK35JNfT9yGZYwZ7WHdCuuSBk2Ow8IPCib1fB6K5jFxJ1eRlZhxlWso1Ul7gzaUWABEq6VUKbpnctCXDg695IC8+FvgE/O9k6CWoGMFgQ1uyQogFbYwjM00DfDebWE6+4WoxDZUU1XKZLu0sXUXTKLvilYCBz7Lvf3yo1mJIYaPz8JQO7FH+vtHaVnkM76eK303EiSaHmahS1M31HSgQ7M4Z2PmXq2xhs4HBhwL0Z+40RRR5w0xe4QqNsoPrhSc2/x1s+Kz08ZFnI3QLVzTCL8bFonO5gfIx2HCLb+8HlTCH1rOaAzCRYBrlQa/LiN7AXabGCkMGqOiYcIbsvteOTJqScejdcoBy2r3tcjnEkGGkVkB9ohfqTCrE7A8qnKZMqM1l6OM/SF+xBzlYoMYNF0sZp3TGJXSp+YjRa9hn814k3EyBls0lIOdKiMt2L5gU2A++Ie7Gvv3X7cxMO4yL+4z8Otu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199024)(1800799009)(186009)(2906002)(52116002)(38350700002)(38100700002)(6486002)(6506007)(83380400001)(5660300002)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(316002)(6512007)(66946007)(66556008)(66476007)(478600001)(6666004)(36756003)(41300700001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lLp7qFSpXy/ew/ADzeJuIqmdtrWwXqNzYNP6ihQRzv+OfxUKJrlJD6LLw9D6?=
 =?us-ascii?Q?JN0o62bRueegHYG36BYqhFXI6hiKFqnXvS+EpIkvTp3hhaw5zJ+8CROogzF9?=
 =?us-ascii?Q?Mevc6ynUlMWqXcCqUOS4709XG1lt4DvAbzYhn9jmWFVnATEFG27raDqv8vEu?=
 =?us-ascii?Q?c8r4eyG3Yfg95Ex9cgvOuwVbTP/oeIixpSnX/KyXpOM1jaDp9MdVMigc+iN5?=
 =?us-ascii?Q?Cl8zu82nhE/iZXxqK+w/sIxzM1310fRQv6QkPISLo4SDxAUdxApufZTWW2Cm?=
 =?us-ascii?Q?msdaq9lkwBJcjmiKEHKy9/bvqLnhlUpFTCBWQlVuy0akfqjdI37ZKiGJFNvC?=
 =?us-ascii?Q?uazlJNQGtJ/Ds69mcOdEhqq5cKX/aTXLi1iZMNskirw5CMM91DySxwO6RtqM?=
 =?us-ascii?Q?mHcE6reID0dUu2g8tNAxhVvP5T4J7d5t2JXCFcGy1MtgeowrqbU6q6sWL7kz?=
 =?us-ascii?Q?1v/2Y7pZ0wD5dRwYsEg0oIjct8BhOUL0HaxSUr/y6QeZgxF1tUyO3sZFU7Gf?=
 =?us-ascii?Q?UauGOXfibrwz7oigxg24kQTE5VhLJZ0wJYwuFll3qFXRfyaqYwTsweuuHR2W?=
 =?us-ascii?Q?n6xKGpN+qQ26PM+PugipXA4i8SobkkjapW6v+ke17othNS1fs9uMqAZVlqKf?=
 =?us-ascii?Q?Tya8ILuhR6N+DS1sXzCSpBl0RLLOKwfuaf88S1c/y+/imo14A7bCjgIy9N0C?=
 =?us-ascii?Q?ZKRsHlydKT8V4tJ89yQtY76cpd8g9GWQl67MDR9sa+qMjKHM2ikmGJ7oLs2p?=
 =?us-ascii?Q?QmhmzAPS8ScrE1qtAsP3JXWFYfFemKq5FG6UcI11ozTcPQ7zunuCG0sVLs4O?=
 =?us-ascii?Q?aUMy93dqWvEGhJBAWM2RqN5JWSQhoJIEYe44M8qS5I9NUrfeqtSIhQJx++HO?=
 =?us-ascii?Q?inCos1TwVXvk6BPxHQ+k5Td4KtSHqcfwlMQLuzwDZQY1tjjysppS0hNpr5FQ?=
 =?us-ascii?Q?gVd8vuypTTx4rSkq6pJFlT4tYWV8SOpftQ/+1yviwqN1ADUGEhLi2AAwjDk4?=
 =?us-ascii?Q?SC8r5vLuD1bKH27lTjgOswN24TQ0fnZ7oDFKikqVIiUdr6E49tCu8/UzEUtN?=
 =?us-ascii?Q?TYLyPFJPsZtoOEdEKYPsmgkp2xZNBFb1uEPZf8fLsn7Ovd6KYO9dX8BlI1Ge?=
 =?us-ascii?Q?UKHzJR21OlcDjJC0jh1fCuQV5GId2wm9d0kk5BV+t4KWR/sZFev22bqCSDr1?=
 =?us-ascii?Q?Hip8cGEclxsDKxKrmkLCLHwN5SlF2+BC2a1tibluLJLlUbVZAsX/qfsXvNvX?=
 =?us-ascii?Q?RvJ4OHzFl3kmE+jlINVFE5RIJyR7IPI9fYBoItRnom2ZO6H4nZ9HbK60Logf?=
 =?us-ascii?Q?gnL7gv9bn81vM43ZFiE8K0wAkLy6gRKAQoEgWkJ/9oVNR58z1H/tbcoW8wsD?=
 =?us-ascii?Q?RW9JVK4XX8lFY6Nyuh8sdthBIGrRM0VFbo9LrRm7feDDP26a9xWFcDy6JU3+?=
 =?us-ascii?Q?L64P9puYGhkYAiBXwbZ+yXcz4aw+OjaV6NLCyiuaYn6Rh/+aCYhk3QLU/IJq?=
 =?us-ascii?Q?K06eBcJXEm+iHDXK4428IG55g7BtqhAUVoOOM3XG4T/9i3xIPzNOIl8u8y9Q?=
 =?us-ascii?Q?WQpnWWtbg3f+EN6+DDqaSF1jhubPr9Laz4tU4vdK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e77aab6-eedf-4514-5759-08dba2620a76
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 16:16:57.1215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FtaS3Xn2uD/f/iFpYtAuxh7r8qMGUnOVWMnob9d86dOhL9Iqj2eW2cn9KlL0bc5A3Yi4iAOn16VAzajBCSnkEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10042
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index c8b9f2eff111..7dfbdc89051a 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -276,17 +276,11 @@ static int fsl_edma_probe(struct platform_device *pdev)
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
@@ -301,19 +295,12 @@ static int fsl_edma_probe(struct platform_device *pdev)
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
@@ -374,7 +361,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev,
 			"Can't register Freescale eDMA engine. (%d)\n", ret);
-		fsl_disable_clocks(fsl_edma, fsl_edma->drvdata->dmamuxs);
 		return ret;
 	}
 
@@ -383,7 +369,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev,
 			"Can't register Freescale eDMA of_dma. (%d)\n", ret);
 		dma_async_device_unregister(&fsl_edma->dma_dev);
-		fsl_disable_clocks(fsl_edma, fsl_edma->drvdata->dmamuxs);
 		return ret;
 	}
 
-- 
2.34.1

