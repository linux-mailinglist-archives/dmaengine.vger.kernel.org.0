Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1D672D094
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 22:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbjFLUfO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 16:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjFLUfE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 16:35:04 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2082.outbound.protection.outlook.com [40.107.8.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1848E56;
        Mon, 12 Jun 2023 13:35:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAq2kT+GSd4AV/OoOrGMSyqSLcdztV0PytzVYhGHtCEZhMcKdiGA2pzviaE0DINkjdDtsNc/E1CaIQMDgrGfvJMJPdYH3+uGLRq9Yd9/e+CsfM6XNbb8vuB54SkcwuU3KJg9HZoPJIiNOgTrEllLBS/v8VjuMLzFOXaDSWFZBHdX+y2eUo4xEghY3P3TWdq6RHFgvcCeJw2ny/MkLe5TQdpSFakM3CkxGYmuYcCYivX7dfXvEAWp2CaNLK83aWUQxaUwOmR1IjT54sJzPbuPw5OELpKVzoCRWCU2FdrHE2Ot62uZgQkG1X2FlVBdRijxyoxZ0gOtUo1JnhZ9eY5jUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3jlBv0SLDnSXx5LFjozJINPkoX9ob6AsqXt6WuD2a0=;
 b=Vticdgo8uN20oYU1gCZXFbXyBqBiM63KacFBqoMNVgG0874c5L4WMDieJ76UXTsJRXE+88eJGmY25ctxW1RrU7o1Q8uGlSZBDu10OmG3einwbZ2w7DRGxRineXnVIRCZmDjWDfDcVRdSCUB2ttWLc8teCLlyEKk637fOne6VLOfm+UTQSfP8KS0kfeQh0ZBAcrDm3Hy6GWSjn+SLDDRXcvcOAOZLZqB1hQlOHheJq0xFOir9ku7KyeumUY/JymRzOf3bAgHSUVp3c6LgWVHSpRjSn0DO27buzIM3iLdafBjRSfi6ozxIZr/o5sYGr/joQNin/FI243pgRZbd+u0UNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3jlBv0SLDnSXx5LFjozJINPkoX9ob6AsqXt6WuD2a0=;
 b=Of71S04DEZnXTCVP/lt1+CAIwbSc3YpnjvejPOxYns6pm3xg+2NMQpxWfuII8xqqYdi9OSmbArpJdCTmMUxh5QG1mUlgCeI0EFNMzxPnmTnF3FF6P90TEE4q0GuG1CKkkxEWB9BjR5+1znl+Au1zrAetkw2LeqEIbUrF0eaaxK8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (2603:10a6:803:51::30)
 by AS8PR04MB7975.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Mon, 12 Jun
 2023 20:35:01 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::602f:42ad:882a:5ca7]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::602f:42ad:882a:5ca7%3]) with mapi id 15.20.6455.045; Mon, 12 Jun 2023
 20:35:01 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v4 08/12] dmaengine: fsl-edma: move clearing of register interrupt into setup_irq function
Date:   Mon, 12 Jun 2023 16:34:14 -0400
Message-Id: <20230612203418.2017769-9-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9730f1b7-34e1-4e17-dbae-08db6b847ee7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j2n94GRwifVvmgtAXrYHKA8lYKLvuYF+h6URXNLZIfTOLIcyOk1DjjmqMTX160OEKOMkIlXQPs+6seKEg92uDrpQUF+UH27184FbJ3i3/9yfuya5CKj1/qezvYDU3B5g6hQAipvIBNQnKV5ItRoeg+KB1HaK3VqIrMs1Z5BRUjtu0sMisLLQnzQtvjluVRX8C7IXepHstfRqD0lCbzP1rDEqdqPfDSmLw69b1W5M5cM1c9TTGUOmykmwi3pN9kEL1FueEI3eGkVTTpEYePul/PLM13V04etJmtVr0jHub7Zk4eUhzKMsfoRsafb/RAZ4245i7bwE6YLUCfYLi9rfaOX3vTkQlKY0gxDVvNJaYVAewcQ7aYWiiH+6DwhryYfca8f3wk38UPE9AxNKom4ulgpjKdX5ZaSzYOOOktfsLegnc3zPdrvNAunZIywvc9puQ6BVYSAlDHW/mZ6/fL6ANOVp22Hcqzd46SkhzuGKGm2wA1Ic53CLyf8XeDGgdRNvvExpEBl9BhwoZcO2LZtIy58QrNyX5Kea1gc7V1CJty76/dBZwPOLjUQ7CMWbjZsXcQjmTTUUl2sUsQo6CGk0hcxwCNNYntM51ADvrAUCmMd/OhKZP+M8Inry7AUW07DAMHuNh7H+Itp1iBBNmpsvmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4845.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(36756003)(1076003)(26005)(6512007)(186003)(5660300002)(41300700001)(6506007)(478600001)(8676002)(2616005)(66556008)(66946007)(83380400001)(66476007)(6666004)(8936002)(2906002)(6486002)(38350700002)(38100700002)(316002)(86362001)(52116002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?veJVLMIAQm4hJYu9ZrsX/npx8JJ27QU8E1ohpGCLi1QHAEpJIBEclgiU3K46?=
 =?us-ascii?Q?KdeJL6ZMjOSGo+nTRI3g/Ze8xGLVx8CZT64/D0rY+jkVXwBxRT7HCXjEd865?=
 =?us-ascii?Q?ZaR/LxvNH5mfZHZ9A3xnPI/6JEN6RN9PyICbv4T/Ffb2HKGdTtXp21fFBei/?=
 =?us-ascii?Q?0N3pqp+8xFIDXz5vZPYMt3uHdf5fs6fxzY3JnmaPTP9HhiEh2HFPFBFiPkdO?=
 =?us-ascii?Q?LgiJS7fGddw0kjJnqsugIng16VEHL1zx/mNjDRXTNDd+p6ABzPb85dh+H+X0?=
 =?us-ascii?Q?rbDSwmXHkQiORIDRVZQIeiFfPX/UyUhMhsNsIq74+qRMNvpgLbA9glILG24n?=
 =?us-ascii?Q?RoJQbBtaLcuuozV7F/zLTfRyVpeCLaYLDViPCAafRtCccT8ku5QZNJh0IJOp?=
 =?us-ascii?Q?7aUopji3U29uSuHG5R+j386x56xbZE8Z4sGs6+FoN1njgjtZjxWvxZH/y2QA?=
 =?us-ascii?Q?/mY6uLmGqn/5sGJKXikzpPP5mONJRYBa9g7CCE8K/06ua/TXlQwT7mZSy9H7?=
 =?us-ascii?Q?V0a1w99i8RREP4INpD37k5FchHDAAEY0H4AeWvBa700l32qNzwvEuN9nDIc/?=
 =?us-ascii?Q?d4fP6KszMPccCsPnOfHxphljtDfqR6fXrXtv5jn2RiaxaunuOJBAIznTnKnz?=
 =?us-ascii?Q?KCcLgc4yXWz/tmj6SRrpL+ZkTgVWuVWhC5f/L5rErdllzdaZnH0wMX3vKmo4?=
 =?us-ascii?Q?K0qy6Fxt8AAMsXGcUdCJGZcWeMw425pn4xEH464JGMjThtNwR9pL6FRtvDAW?=
 =?us-ascii?Q?I8KceyUzzlHW3uvfRceHAUdC6SYvhgyUDYmeDimmSHaAf2kHq/tCB/SMmOV1?=
 =?us-ascii?Q?gOxx7REpq3hB3EWJGQr4+XU7+EOi+nPLNdJ79WTUUTbh4KuxC+Qdzv4sdYf/?=
 =?us-ascii?Q?L6gFG4m+wB5LW1pSUHRy9TwSuftym3vUrKqR24fgoPItR60t1N0+ToESBkjx?=
 =?us-ascii?Q?ZBs3lYDqIAw1O15X7e7oH0utmsKiqNErf81fOSWmFeoJ5j9H61TPHRnZgG9p?=
 =?us-ascii?Q?E7ty3H3V6CoxpmF3cBvQfBZqb8i6elrhCW2CKGX3mRqLSXA0QSstNXyGrmUD?=
 =?us-ascii?Q?+m9DYTNQII1vLspLCz2tSQuoLCM0DDKUFZ/ewWeP9q53xqcvQW9edYl8YGkW?=
 =?us-ascii?Q?Py3OW06GFwv8oeaN6jxDjWEz2DminTscBBvi5ILVtEyqsNcpt73/TIK+uP4j?=
 =?us-ascii?Q?GqGk9wWmC7+4nYpDgqwib6IlnQALHHOBaVi3aKZ+3i7dWOB3bOxlp0kteuaA?=
 =?us-ascii?Q?RDQcRX3cHeTZL61PqIhSNkAJVvdapqMmSKDZXQyczlON60P2ybr38IxhXGQh?=
 =?us-ascii?Q?KEEUFHRcU6L35h5WYoD300CTaRKAQa2uuF29kgaMIrUuuuojqAujIrvAx8R7?=
 =?us-ascii?Q?sQx9sVlroNA1xR3vLNWy1O9uv6QcgWHiojMJqT8STqkhwsr2+IpxVXHb69DB?=
 =?us-ascii?Q?znKlpmbJz3Gk9DBIY1H31ciimZ039p2mbk+3LGC/fFFBXUsJ5Yexvz1fUgCq?=
 =?us-ascii?Q?54UnNVflTLGiMZ3v7USlYUtEXAwHcNMDU+WQ0Fof+uLJNuYAMWXBqVEPWD7D?=
 =?us-ascii?Q?oVVvvzbm12VfappzFZAq/mtlMm3zuoKqSM1ydFPR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9730f1b7-34e1-4e17-dbae-08db6b847ee7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 20:35:01.5237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oopAH/xFhAAQw8JfDmk1piPQbNKITP6Ttm+2NxoH7wFZig9GYhvalpPotSBSFwrUC2IZlBcqp0PAhOPk4l/i3g==
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

