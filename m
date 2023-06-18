Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D44734776
	for <lists+dmaengine@lfdr.de>; Sun, 18 Jun 2023 20:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjFRSKB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 18 Jun 2023 14:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjFRSJ6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 18 Jun 2023 14:09:58 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2080.outbound.protection.outlook.com [40.107.105.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E0E12D;
        Sun, 18 Jun 2023 11:09:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwSNlKDDuxcbz5mMFgfhmBOC7BKxXZwaehG7OeDeGmqzGV2HBbwtaOSvHtkpwQI1J7SK2bTG0TaEUwFuFUphl4fi7JtfyEnlXyvnKosdlIJbYnzUx/X0Clycj3d4XG77YpYVCRPCbec5TzPoar5BPK4133ZK3ODD+ebHPN1prXOH+OubR06+dWtSR3fE7etMmpC/okhacQitp8Gi6Yqvp1lW6Fqs1ziprH0eIAdNWsfgsfZcxWt5IlnjXRs9cooxq0FJ8kShTyNyXBpR6CCZWns4tE/QOido5L7DnEHyuMdkhJz3q2++BAtGhbYXVi/46CciSeJ+H0Hu4+BUCyTrGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5Juf3kOYMDDqoTfA5YQdmkMKOm31LEp8hl7IUV/jfw=;
 b=kGKartRdaOyxRO9kHyRPYpeR1vnejEed94NA1lkawl52vDZoj98HtK/RHchSdLaBw9pN8sqcCpHHY7QRslC6cy+0R5qUTH02YvZuzcGgHcRXGRZieRLK45ZpH53XitAjhqLHZg9MYwG6OoRKvESGyJOcPpUBQdaS5J03Ul2cbvxXBCJW26BMlcqIYyWv7mAs04BFr1tS53vzGZBOeYuJRb/zgGPo5Ct0VDqVaidSxezgoVawmUVCZRFTRsSTzLw2lKFw2cr4RujGhPlbFCJLYSYEWfYRrL8cBxZWRt3CQz6bKuzVhRxUsyvd3Sdhjm9yWRj00jyR3hAOmaHzKC+oUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5Juf3kOYMDDqoTfA5YQdmkMKOm31LEp8hl7IUV/jfw=;
 b=nuiEUNHt6Plj1WDJ5kg0dFOxEJEuO51ODIOdA/d4gP4xZLbTEaVz3EDPU4GXGTWLTaNPc+0DRHk/EF/yOZNw3eXPN1qc06eBCr1daE6mN3n9ctJzaGIOzxWZpqDGZk6OqAp10ytIA3uxtylFqjmto/y1JQqiDqXcZUjpnYDEk58=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB8PR04MB7019.eurprd04.prod.outlook.com (2603:10a6:10:12b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Sun, 18 Jun
 2023 18:09:54 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6500.031; Sun, 18 Jun 2023
 18:09:54 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com, robh+dt@kernel.org,
        shenwei.wang@nxp.com, vkoul@kernel.org
Subject: [PATCH v8 03/12] dmaengine: fsl-edma: transition from bool fields to bitmask flags in drvdata
Date:   Sun, 18 Jun 2023 14:09:16 -0400
Message-Id: <20230618180925.2350169-4-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5c19964b-b85f-40e3-ba37-08db702737a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w6/pNK5HK0r2YmnlNRt9hnIY5FYLP8C1gTcKMXMfi6G1LIwP2gpwD9DNSWdFDyo3yUZzwl96yVB0U9IcyBrEVGPTwj5aFo5FKgyK7acS4puucDsi/x45qJ2ZW5amj+XwLPIIE8o08L2sNXedAbOoE7by6MM4O27Yyk1bqV4gv1wvVBRDyFg5mNgPUZJJ0iVFMp/ntxC+YaZADdvyKa2fntrNpqzww8KlTYia66TV23uCCTGeFqz7H4iIYQBC/VRtIYXqwYbTqf0Mj3+2NBcqdmcy8OJFCR9VP2W0D2kNn9zAgsn+3bVKKIeYkznvC6nEVxk1jyRWQIiMX1XL+io4RIzFqnvubUSlGUSBTN1ZKhhNvL6DI6lAu6IsX8UmnxjRba2eB+niSG4z+gPBiFtYqPdA21dhxLLl6pMqxCQQ1ajvEcGH9bjCwbk4r51FYBeTmEh43rqJBBSYebAXBDzhbNJpTleLXXqcCrCM1HI+AXqOkP8kuX9u3OfuEYV6sV6bRMNHHyP9lD9Bq3A+7Hre2pEj+rDphOiZ3H5J2YswTNdlbQUtK8yPCEm7omzXtG4vOexqYs0CCqkK0pKHjYlnjqLhEMe+YZCMww5QNfcTNxyn9fslIYzXlEYMYTH8N/uZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199021)(66946007)(316002)(4326008)(478600001)(66476007)(37006003)(66556008)(86362001)(36756003)(186003)(6506007)(1076003)(83380400001)(26005)(6512007)(6486002)(34206002)(8676002)(8936002)(5660300002)(2906002)(6666004)(52116002)(38100700002)(38350700002)(2616005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KMxAhKCJcWpJiE7vxo7X+kxuwd7bMC2c1fARQd/ddPN82taWXL49myme4yXE?=
 =?us-ascii?Q?M2KVYki9oGdTNTtSbjkr0XMQzVL0Y4P6+vXlsHFGUI/vy9yJQWYHfz/B3fYn?=
 =?us-ascii?Q?P5ge7cZ2wBM+GLaD8NF7ZfVqmBGOdAx5s+k7MhD1uAj1mO3FPj899JqUY6x3?=
 =?us-ascii?Q?HBMpsxjxXmqKRIx235vUE2Tf5fSHmD5HOICf18OEzSfhnZwQiNvgvBhUvPvc?=
 =?us-ascii?Q?1/lir7tfhdPYS4zh7IIDwU5QRUvNkPe0RGmRL0Z9OcLDpHUwzLWx1M+FcRzM?=
 =?us-ascii?Q?aN2IdI4QHS6bfEAiWAlMBBusiUhQeTNw+tYueSx5AUwjliRk7m5ABzwbpQCx?=
 =?us-ascii?Q?U7FhNupSU5tYsf6lov2xJ4JN5DddoRMpWt/7xiB8/p/eSrIshIDVMtDSNGNO?=
 =?us-ascii?Q?t8lsDAKa4LVLKCMXeShO7sUywMtPmo3q/JUoxNL4lN0aiXkrDKfmN6nZHCfX?=
 =?us-ascii?Q?NK1O1ko3BEQ2xPxAk0kwORaMcjdFUmaIsjRKdmORfvny2pDbntCQctHeXJuw?=
 =?us-ascii?Q?URwixhyG7Tg0tagpVtN3wHhkUOA5c7Teg+umUREPfhyeMzfbvX00Tv2xKkMs?=
 =?us-ascii?Q?ucMCYaCfqyqFgbtTMEg5DErhzl4n7Gdz3dM2FzIxsnLMsf5K0mQ927uP9dGi?=
 =?us-ascii?Q?7qp4/b4kMR9d1S48UjJMF/wKKJ7rroTikus1NRaSWmN8gLq6HKO/ArXh2yrs?=
 =?us-ascii?Q?XUYzTLAIJ6+KNnWyTYZMrqrIG8cbrsEX8OYxGQMust8v5YoTnSsD4o969yWi?=
 =?us-ascii?Q?yPaoyxshlQrxMQNtH5N7qxBSR9pVMmCSf2ikwACn/XMelRSRCERYAgYPm0n0?=
 =?us-ascii?Q?1wVQ5jeZHS+V89onjOSWIw2YEc86ThZmYMZclKnAayqowPapL58jOFJL/Mhp?=
 =?us-ascii?Q?JT2BonuTeoqYpQCjt02nRZfH2kSpdgmVi8kZOnjHaIPntVr1nGRYliEuZdSg?=
 =?us-ascii?Q?blRi1h+5q+bUn1hiwaan2SQyvt2bhygbpoDhY7+X/+OUtbJ0A5+xe2NtPUqd?=
 =?us-ascii?Q?scl55pwWS20GIsRzERfmHrot3XLBKQlww+VtBLqyJ01Eyvt5Lecx/43RSP31?=
 =?us-ascii?Q?b4xgomE3S66ybFYAa+sv8RZoy6bg3hkcMSMwSH6tu/rU8ZU1vnXgA54B1c6E?=
 =?us-ascii?Q?KG1YJNx0phat5Ezh7PR+e0wq2c/DLq/KJ4fXuZ9bh7CVVGoL5GX/xtaAM5Wg?=
 =?us-ascii?Q?k643ZTCHlE0f/C0/QScqZni8M3zLP7R8sCoPjANTR2gaxRS6WLoMsdm2vXVG?=
 =?us-ascii?Q?ZbaHhipmVcxgpI0lkOlxLEOB0y/Mh7pwfFpsr6MnLfO+WWPD47q0EbYilA7g?=
 =?us-ascii?Q?C7hsFI9jpGGnlEqRkkW0jzFf+EN9/YX6g64Et1HoRlo2ub5Ifk6vyrewWxgS?=
 =?us-ascii?Q?JLkKPag2ikmFHyk4y9GiEf8FjNP7sJOP7Yrmo+QlHsRLUrB1zr5RQUSmmWhB?=
 =?us-ascii?Q?rxIlAxI4+u8m5ds+1rxntFvdewOMtuaDX9h3DIZhlBdNh9hxHR1fO7j3AEyW?=
 =?us-ascii?Q?UFSJIZth7q+zoK9yYme6kZFAl5VfFA0323QrzYiZdeMjRs/0Y2BSuTB9yL4g?=
 =?us-ascii?Q?Ahk+0PKMkQ5AwsevGTxYQHezMU0MwilufBdpPMnx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c19964b-b85f-40e3-ba37-08db702737a0
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2023 18:09:54.3848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jVi/6DCG21piGLsRhBN4ep2A5SoPTkhkZu97MF6ErRGqq9eZpsOo+JZWXJXWlpjn6QbXDuFGzxj99dGkgbPmCg==
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

