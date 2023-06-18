Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E813C73478A
	for <lists+dmaengine@lfdr.de>; Sun, 18 Jun 2023 20:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjFRSLY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 18 Jun 2023 14:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjFRSLX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 18 Jun 2023 14:11:23 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2085.outbound.protection.outlook.com [40.107.105.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA22AE50;
        Sun, 18 Jun 2023 11:10:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCSeLiL9RrFHO+O1Wa8gEWBVx3Lp9UXMxgl2vyfis57qKh807pe+GwVyUQai2lMO7V3rcqTE+HmbjM+mAdHE+HmK1yQ41C3VjybvfZTKgpxUFeSIKasJUqRr1Kzw6ThYLkZqV/xDG9T2K+aqxlSCIEUdKnWnSDm7+SLIaB4Hle/osSOclPKqtCDLxljcxQ6fEsoCOqn5IMWnpdseNQHgfiAheKiw/olDtiDwgSisjjKISuL7bpLO75AnQG+Hgl7NEE74VLjhiBlZmF0J805TXNijuzPo984bS5eg7tLkHjPpsfJHRr7wScirOep26uxCaEwJaZj+mCnfdLA+FqQQeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3jlBv0SLDnSXx5LFjozJINPkoX9ob6AsqXt6WuD2a0=;
 b=Sh4l84DJkuwknNjHB7wkdw9w1vR3GHWCZzwtrUxN2gGcih/ALCfQtj7BkAbzTC/OFTeWfDXCzo7Wj45w8aYuijxUjqVkUV20rrtx3D4I+DpX8KxMhuF8wjAzghanz65BisXgb2/l6upDb+SHghPC4N4IaGmL8o5VTAE0sWNc9PaE0KCYF+U+c2G+lJ1nIlBgvOX5NxBoqolOPDdDtYkP206vU8nme5cmb1BNsX2oVh0gLpOfcyDKDoZyiQplx8MmfUimJfCjerifQlyId6doUTqZ90c087CGBZ6/AaXsn0W1k42wrSM9iPXf35AlhlpXH+ZZPhtXeiBwBmEzUiHvGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3jlBv0SLDnSXx5LFjozJINPkoX9ob6AsqXt6WuD2a0=;
 b=QEc+4sBwqJYOgnrxD2UuQif4jkiHOUX8GvTea0OVIMgSCib+fXg1qDXJI2/GuMnbgCl76Zov61N8iMO3IXo8rH1505jZ5UcccK9xGre1DDA3Mqxv5OvqySTsSeCCupz+muuR4/0jEnqC6ZLNpI+PajdVdyq7ZdUfO/1q3waN1mQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB8PR04MB7019.eurprd04.prod.outlook.com (2603:10a6:10:12b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Sun, 18 Jun
 2023 18:10:10 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6500.031; Sun, 18 Jun 2023
 18:10:10 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com, robh+dt@kernel.org,
        shenwei.wang@nxp.com, vkoul@kernel.org
Subject: [PATCH v8 08/12] dmaengine: fsl-edma: move clearing of register interrupt into setup_irq function
Date:   Sun, 18 Jun 2023 14:09:21 -0400
Message-Id: <20230618180925.2350169-9-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230618180925.2350169-1-Frank.Li@nxp.com>
References: <20230618180925.2350169-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::23) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB8PR04MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: e0f384a7-a020-4cbf-2e03-08db70274125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rooHwilUaaflQmm5Olsw+0feSXKX+xucW5F5+NMDcCBHqXlD6rgCASxBMmjycnHvG9afJteora2ak7mYa30dR7ychVGRWZU6/4jpozlKI/CKG+o85jLzsPovLcg+iyZ+Ri5AillbWRSxJwIKcIDSxQaoiLiwHwxfCmov8LXLHbGwHKHEl23UTbgb/RaPQJIiHBEDGoViiuZig6e8Q7eO6QFaEYknS9sp5Kk1Nnqz1n0n5uVkkh+qwu6VoZUSpkGxo+puLAAVcPsHWuk4twucPJpgJaYVtZqcYvWxwGtPsDOt/b9L7ezWKBhU2XYVcnuRk0r70LC0v1AsUOyoLuwpBZ8KBGN1h316gCKVCsHMkLbqhGGk8pxOKchhfFCZb8jLDGuEY274hdLZxnsu0uM5eHNeEh4ez6A0tdSCiDbOXx3oglJdOBIDz9zwNTk+8BR0mCDxUNpU3Jgs2R2Am9bzZXWjdH7s2L9eX8bbm/jj866IINffXTd7GJkvCGupnw24/fYDZ/kS7BNdtIAt1+NQOtiJxYZuB67T2nN5jSHKbut3RGmU92A5c0+eQZPtIU78JG3mrEr24CCMChLxiQd7D63CnO3grstr3f0AZnwKFLe+5S9DNO6QMNUH6+xeveR2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199021)(66946007)(316002)(4326008)(478600001)(66476007)(37006003)(66556008)(86362001)(36756003)(186003)(6506007)(1076003)(83380400001)(26005)(6512007)(6486002)(34206002)(8676002)(8936002)(5660300002)(2906002)(6666004)(52116002)(38100700002)(38350700002)(2616005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uwUM1Y7YmNPlr5YTJGGGVDdkbKi/v0YGbCGbtRCmXoNFOBkSWS8hSrCvcOrE?=
 =?us-ascii?Q?MRsOhIJa4TMGpoNBUkFPkqcgMqNBO95WdxK/rTZUFA9Vap6UyvGU3g9Xtxd+?=
 =?us-ascii?Q?BIKUXCXl6hZ0Su06e/d+2jOZbkKdsuv2icUA3Zqef6sacRvOyX1CrWdtvk8U?=
 =?us-ascii?Q?oXtGmD79m/aywzUmPkV3kC+UKvJ/zv/d3R+HUyDN3dSqOml7WYJXdzPaiw8h?=
 =?us-ascii?Q?ANksfXYd10Rz5LA091ZLe7HFabFzrb2okDpL33wR/MIOIRbdSJ7ohff+fwIX?=
 =?us-ascii?Q?9gEZbQeVEfnDSpLfqXz1X/gvXyJKjo1FDGYqZVSyYfsfaGej/g+v8Lt0AZuO?=
 =?us-ascii?Q?i0dZF0303kgmWqcyWrH4sxFWRRtIL9nfHsQi82zAjAXGtYWXq/0yXqytPn4N?=
 =?us-ascii?Q?lGmcurukOeJnbRjehceTVGfDoinxSJeJcdpL5brBKTqlZypfHR9YynAS5BEa?=
 =?us-ascii?Q?gzjUIgo5tg6MV/Axkjlwsd29cn61wKRnD+te+8D7CTXHuiZmDG2YMs+tt+ZU?=
 =?us-ascii?Q?YSU9N7ayE4IIW9usJqi/y5MBFYrQ+MtnMlMFKBDjVRck5S4X4EQmOuDuaB2o?=
 =?us-ascii?Q?8nOJY/L3QaHaRv2G3+Aus6TMw4KrWCgG3xqUvdxf0tjcu9491grHknJYMuqX?=
 =?us-ascii?Q?lLjgTw+5RfkMYyvJAj7kdFRX4ANxw0uJ6znaalQ2YoEHzaSVcQHcfrKhlHQf?=
 =?us-ascii?Q?ssMVizpQq8aTVJPzEMUFKd+FGutMadCcnC7ANuV+BDQscNV6+kqckZD/yrR8?=
 =?us-ascii?Q?VRGXq8C5zv5jSKEWxfFKtCsCxE7dF0x7UnA/Vi+mfbbjkCdI0kaEYeAmKZ5v?=
 =?us-ascii?Q?7B7xIHAnR3U1L/BPAiBRB+UFcXy1t6h9L8RMPUCiw4CCpeN9nT6GzyoywkV4?=
 =?us-ascii?Q?0u4o3CelQ3l6sZo3FUNveU/FbwBdFGwvnpP4QM6js3ivfOqz6rPtnEMqqc3O?=
 =?us-ascii?Q?ag0PqTIA8/OjLeqna8/nUwo2ePgnDyk67drkrVihr07+yuyJU1oMWAE2yyDS?=
 =?us-ascii?Q?o4BqIkY0csgdtVfV7H+H2r10wL3At4m0TjjRAqpttkAm3TVNkUxya7V5zPbe?=
 =?us-ascii?Q?J+yLfcA06ownWLQh236SPHSzFG5/RwYT2dbLJ2ggUjIWc+HW6wJj3KAd8JMx?=
 =?us-ascii?Q?IZOsml/SYYahW7XPDCz0jLifb4s+kLmJARMfPRWwnkQo92QH5kKUh5ktKX11?=
 =?us-ascii?Q?e6TS8U8/nrSJrXEYe5zeRLAW13d2VX0m60K7+D/O8mwOtLhI4K07yoi46T0X?=
 =?us-ascii?Q?P2KY47SHrwncs+tWCuLcAIEsixZw8sqgTQebzklNEScGGgCR3EnN4zKOm5p8?=
 =?us-ascii?Q?E02Zzp89vhg5fiEE/6+xpbnTokA3XyGGSexyow/i51Pdeh3UzZP1k5YMaLBd?=
 =?us-ascii?Q?IFs2O+Lr90MfL+C+jy9JDWswBIgqnKeF2aJbZWCGbnZKADSR6GdB0CvficRJ?=
 =?us-ascii?Q?4J7aqwioMLRzNPgnjdQOULXCc7HY1JkMwQLHMPmnSOtkbyJUyzgX4/k8oIeK?=
 =?us-ascii?Q?nDRJLe38nl9rrro4bPzF4GrZm6YpOozemPAAxuxe+SdlHrgyEsjf+/hiN3p0?=
 =?us-ascii?Q?UHf1tQ8xnldiO6keNpUys2NgfTCSKbiI0ACKHG08?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f384a7-a020-4cbf-2e03-08db70274125
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2023 18:10:10.5398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9G9EASMp5+j8eJupXkCVJt/1ZQwY0HZW7vMFMUKQG2JkLqeXj51LyBj1QNMxrLH5NwoO9z/LBVNUBjkPhqLIhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7019
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

