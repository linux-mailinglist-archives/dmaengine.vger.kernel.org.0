Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57ABA72D08E
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 22:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbjFLUfI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 16:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237496AbjFLUev (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 16:34:51 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2053.outbound.protection.outlook.com [40.107.8.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E6610C9;
        Mon, 12 Jun 2023 13:34:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUtR74nhU1M+O9tAvKmgvdnIsT5S9K1PRMjAQexJa/KIWEKSqcIowVrTrKooKnnNq26996E29pqGhN6q71RzqdvSHDrUIldueTp+3E/l/oj3gA89ci4VWHBQlXJNCvSW6pjFPxuBYkYvZR+WFs6jdC1yjXUanV1btVYd3LssWLEIu6g5QXqMuZZ7HsFCZp0EeXMHHvz84ZUqGp+X/BmwoTbW57QseFwYuD4HQXS7ZoQFMMzTZoiUv0jl7XQfu+phmSzRr+2WAKRnq9zG0XxYiLsSV0qNe2QjszbMsjwbK5RXzSsVII95igiHvscCPonNtHzuc28w1vo95xjbkCpy+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5Juf3kOYMDDqoTfA5YQdmkMKOm31LEp8hl7IUV/jfw=;
 b=KCjQekf5f+CHxB+inrtv8Ae+haig+cIh85LAudGrQ5SdBZZfrukXL5uy8CtuV+N5WVvAO7FW6Dt1jAzD9oRR2mVJ1W4cifloCdV8/AgM1elCF9nh949vkxDWf+V8M8N4SpMt/bmjMW8r7jzJXv6lXRTNoEWHJRkl2x9BBUyJWLO/1+gOja6lFX4qI/R1qe3etT7WV//i8eSnct0Aa1xhLQfor9y3ZON2DaMQeah045yJVMs2ksAlP9lWvP29EJvfsBEzTXCkHDROHzfVbSHhapLtSSp/kg5ZIEEYb/e+Lc3g517Tx3JQhjB/MTnyxX0UtYgy2m/2q7V/hSfU1ZYOPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5Juf3kOYMDDqoTfA5YQdmkMKOm31LEp8hl7IUV/jfw=;
 b=adiMalOg7xBPYUoL4XJDrjUf+/iWgv0UFqc/UvmxpNUXMTISaYWJAL61K4HgR8FCgfQboh2qeNIq12xQ9CpgRBrsIPTZPeAC3NZ19s2Ya5le+GrLzEutoYg0HRN18GveelNzCDgt626lGdeomQ1pQN6RcG8YFAfTc0dgKd0UqvM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (2603:10a6:803:51::30)
 by AS8PR04MB7975.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Mon, 12 Jun
 2023 20:34:46 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::602f:42ad:882a:5ca7]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::602f:42ad:882a:5ca7%3]) with mapi id 15.20.6455.045; Mon, 12 Jun 2023
 20:34:45 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v4 03/12] dmaengine: fsl-edma: transition from bool fields to bitmask flags in drvdata
Date:   Mon, 12 Jun 2023 16:34:09 -0400
Message-Id: <20230612203418.2017769-4-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 798bc50a-1f92-4c2d-0147-08db6b84759f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KLTclB9Ems7IXImSVZbJ8nud2XqO8C06DcKo+ygH/whmwD3nT0/UCdvhZmklauQXloGCvfgcZssKt97hqJVPclUQy/xb3U+UOGpCqZJqnjgT5eLzlIBueiSds/lhe8stvkAsPydfMsfv349kmWhSqaDSI+DD0yAdiu9tnzJrW9IiQKkjG8xnYgt9PhwGWfY2T/WGfAVFSXl8lypQfRu4bdAm5FWlRxNmLa/MFdmxSYXdJn5tEB7VIMU/atRlRnvqhrvGVXft1T5DCBprJpC4MZpH83eg6yF6rdkIuHEobpqwuVvfqgvnknXoLkZ/gCkoq3IbBlUJVS/7C+EBsyb9pFH+k6F+/GULpSLyjxEMZZFfQrv5UMbOoe71soP5FZpEgDoj7gJViqHvM74pZvTB1JT3Md9EJtu0Ka6tsR9H4nKONcwXOEQJbyRQu+vBgKbdt3j7sKWHZtCylaoboL4f7jHTXYXLz/o/PWcQGBF1WcGkCmzHRw/ZFwmQ1JxD2vFpV2X8EtJyhh+RPdNtoHHpv2xD/DWZtYVBww/rCDKYlY0J4RWpJDl+yRWQtYVHyQmxx+SYgdJFP8zwm5MFpAjGMoowSVizn7YWMRwzunr3rCRULkOrxcz9rnxHQaOuMMALTjUq3pZNNsZUWn9lwjwAng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4845.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(36756003)(1076003)(26005)(6512007)(186003)(5660300002)(41300700001)(6506007)(478600001)(8676002)(2616005)(66556008)(66946007)(83380400001)(66476007)(6666004)(8936002)(2906002)(6486002)(38350700002)(38100700002)(316002)(86362001)(52116002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FlOEpsdPzi3NqAMM3DaZNq1ykxNEO4A9DlFMc6J8kshokoG4VuQ+RLMlULXe?=
 =?us-ascii?Q?m4k3YwqPvDftm4oI6Vp28xL4mzj6W7LdVqEuOaoGxOHp0Tv7uhgDGLyQSuj/?=
 =?us-ascii?Q?KXQamLGdGyl7jYLiF40yMmH8Gqx97YcMHMMxsTTqRiafRju7euupJVThTRus?=
 =?us-ascii?Q?B68XOYQ440v61dISPTX1mSLequF2Ji+i3dFCYLkPzMEf7CQ0ViuB3OoGDFVN?=
 =?us-ascii?Q?2KJmvvAZbJmBEM2vNxn7Re4fKM8fLbnB4V12rM21SAThG98D2NMXAs5UDYhj?=
 =?us-ascii?Q?/HeA0MC9zZqYiN6KHr8q1EzbWHynr7IvPkOb/Gr6aMSb1CJSHQ3hEN9wtStM?=
 =?us-ascii?Q?2WApXfd168csiWro/exHZleNBGkfEqW6CRkfIicJHSnFdwIV9uCzw9tlLll6?=
 =?us-ascii?Q?j+nY9l31NiYzh6qqExyWNrBE+/A9FQcLGMPc1smeuXSrV/vbZOGp9cJ6oY1n?=
 =?us-ascii?Q?huJF7Ehy8brRYtfhEP/bvSJEWKq71lIr2gTGvw6OxkdETHCoxs8hbPnVKHKf?=
 =?us-ascii?Q?JT3N1u91Jx6VqoiJ70nmj8+1H8beGsIOxC/oIRvUObqzDI7eIGbW0pTAQIae?=
 =?us-ascii?Q?o3e56BTaJ8Kpe1TKHk742iEDWZtFKEe4IkgIYyXvQ/lxdOXWsm2lGVarzeKG?=
 =?us-ascii?Q?VfrbsioTP9pg3Q1tZ+MNQUJDTl/r89MDDJTYk/jMISik2G6xJGxGF3qwwA7U?=
 =?us-ascii?Q?7XtIsWDhcjH4i26YEKcWMgH4ZScuvY/jb41LKUOaBXx3UWo+MYsgZr1hOeiv?=
 =?us-ascii?Q?MfULkGID53RfgU3Hql3wFp3xOXzXSt+vQjxLnWN4NPVRA36LCypNJTdTXOQ7?=
 =?us-ascii?Q?t//JVy4lSKvfp1XEgsQh0asyJO2e5djzxFz21ztn8TRUlPdjIWDIOsjq9REL?=
 =?us-ascii?Q?Aox4Dq3lrn7xLQ9qrqV4ULUzaGTLBroo/YIt9vWFHgyf8O3+vcmSFgBRcCX3?=
 =?us-ascii?Q?jeOxEmX6ObliXk313+cgTBSY1R0vwoL85KGbBOOWQoY9xp68IXejZ+eeOctX?=
 =?us-ascii?Q?Hk8R3hT0UQshs+R/a/JH5vxrNEWK0j+wo+SvJBxD+ykURkveSuOh0SxSgcgJ?=
 =?us-ascii?Q?n2TcqBfSpc3RTIRpJJCvzps8XQ5ebtgsZb3DBRWtZhCEQ/bwvd8z+n6YRgFX?=
 =?us-ascii?Q?3mviY1CQ5Jv2bjXWZliSkZY2wH4U+5XrU+nW3Ie8YZ1AMIxePCk57RK7Nh8I?=
 =?us-ascii?Q?3pwnOrr/GCKEqib3rT8UYHn2xYpVnqehJ5N0WPSxvLrULDvqKZclQ8gxDzHs?=
 =?us-ascii?Q?tfRmknkA3C6h+S0CsPVrQZ6vs4ZZbLm4j8uqc1XNN+pOkx/6MUUpjpeYPTSH?=
 =?us-ascii?Q?ZYymgibhjoXda+QyOFc2xvHyXgsBgrKh2su5YdFPgqtcuaUGFdJqjmVTckbf?=
 =?us-ascii?Q?k+b41U+XYhe5r9siFGGb1SAtisolJ+YB3r3u9q409xMzrJGwKVRXFEJ1Z6N6?=
 =?us-ascii?Q?c9kRzb9x/0WgvMsNrWgyX36L+ag30eOoDjiK9fvW66DAfWDJATPxlAq4jqMt?=
 =?us-ascii?Q?g8Gusjx7NNxXQzcb/deNl0ltXeb5rISUOk8ASw+lBX+E81B1GzZ4956Sdz7D?=
 =?us-ascii?Q?x2MpFTDsGuaG+Tw66zyt2CFdoti8eajxBTYG44kd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 798bc50a-1f92-4c2d-0147-08db6b84759f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 20:34:45.8441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E3HEMhIJQYYUgcL5Y/sBg6ZJ32MtdKFPLrPn+NiLYUvCtEssJCdVbvkjjLFMx4W/hluVx5Ki3Ihv44xzfxEhDA==
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

Replace individual bool fields with bitmask flags within drvdata. This
will facilitate future extensions, making it easier to add more flags to
accommodate new versions of the edma IP.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 2 +-
 drivers/dma/fsl-edma-common.h | 5 +++--
 drivers/dma/fsl-edma-main.c   | 6 +++---
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index ce8d7c9eaf77..10dcc1435d37 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -114,7 +114,7 @@ void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
 	chans_per_mux = fsl_chan->edma->n_chans / dmamux_nr;
 	ch_off = fsl_chan->vchan.chan.chan_id % chans_per_mux;
 
-	if (fsl_chan->edma->drvdata->mux_swap)
+	if (fsl_chan->edma->drvdata->flags & FSL_EDMA_DRV_MUX_SWAP)
 		ch_off += endian_diff[ch_off % 4];
 
 	muxaddr = fsl_chan->edma->muxbase[ch / chans_per_mux];
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 004ec4a6bc86..db137a8c558d 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -144,11 +144,12 @@ enum edma_version {
 	v3, /* 32ch, i.mx7ulp */
 };
 
+#define FSL_EDMA_DRV_HAS_DMACLK		BIT(0)
+#define FSL_EDMA_DRV_MUX_SWAP		BIT(1)
 struct fsl_edma_drvdata {
 	enum edma_version	version;
 	u32			dmamuxs;
-	bool			has_dmaclk;
-	bool			mux_swap;
+	u32			flags;
 	int			(*setup_irq)(struct platform_device *pdev,
 					     struct fsl_edma_engine *fsl_edma);
 };
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 16305bb9a2ef..f5cf95d185f8 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -233,14 +233,14 @@ static struct fsl_edma_drvdata vf610_data = {
 static struct fsl_edma_drvdata ls1028a_data = {
 	.version = v1,
 	.dmamuxs = DMAMUX_NR,
-	.mux_swap = true,
+	.flags = FSL_EDMA_DRV_MUX_SWAP,
 	.setup_irq = fsl_edma_irq_init,
 };
 
 static struct fsl_edma_drvdata imx7ulp_data = {
 	.version = v3,
 	.dmamuxs = 1,
-	.has_dmaclk = true,
+	.flags = FSL_EDMA_DRV_HAS_DMACLK,
 	.setup_irq = fsl_edma2_irq_init,
 };
 
@@ -293,7 +293,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	fsl_edma_setup_regs(fsl_edma);
 	regs = &fsl_edma->regs;
 
-	if (drvdata->has_dmaclk) {
+	if (drvdata->flags & FSL_EDMA_DRV_HAS_DMACLK) {
 		fsl_edma->dmaclk = devm_clk_get(&pdev->dev, "dma");
 		if (IS_ERR(fsl_edma->dmaclk)) {
 			dev_err(&pdev->dev, "Missing DMA block clock.\n");
-- 
2.34.1

