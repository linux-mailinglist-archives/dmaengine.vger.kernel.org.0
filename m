Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C405E72EDF5
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jun 2023 23:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240569AbjFMVcc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jun 2023 17:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjFMVcY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Jun 2023 17:32:24 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E59C7;
        Tue, 13 Jun 2023 14:32:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kftqo9RosOvl+RQbvgvurLp1wioqXdibtl8gD9WSd3lB0PG7Jzdy+rfkowDnmi9fHeBsMaNf6HWlgF6XqIaKgAPK85YHNV4r75LSFy3X0OgNnLY+kQ63/wJjQ5+Of9jCC4OEdi499W8dEhrGad0vJhtgENgYm4AR+BJ5LRSCYL03IhEphaA5ubHHQoKaTIAMP0kxc+yNgOLWPGaEcqR1Ibd2SoGxECtbXNlL44CSeIsveDV4oC+y2K4YJuCSzz0FKbbKedxw8vWuJUdPeNleyQxudqKbgJIr1BNw6uBGqlKp8FLXQXdTXzmD45c/oRGil2PhrrS4ifod/8lw0jYS9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5Juf3kOYMDDqoTfA5YQdmkMKOm31LEp8hl7IUV/jfw=;
 b=JtLA3H2Hqtjw3wgB6j7QfeNjeIOm/3witL4m9Vr+QUNVx/C7T/OtE9I+6gns/K477hTHTcBf3uqgvCAu69uucqjLnC4ECMXd9RAdGjIWAZawbmJy+YJSJuiAIp8iYiuzLkQgSCt9HEh4kRjkOZjbaNpqc41WDp4+pvh5RX+TIRLtMxeW6oTQFgaih8tco34Zf2SReft/XsPOt6f2s0hzfIy/4sZjR07Q2YrvAlkI+QHRaEaGSK1D3JcAsn2zBv0uii54BIQhVr0QPV8y3inxNGg2hHK6QtbuVsgQT2gj6LU2nI2hcbdq+CKDlZQK7VeQscMmIVORvpoKV/bEAHsRAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5Juf3kOYMDDqoTfA5YQdmkMKOm31LEp8hl7IUV/jfw=;
 b=L6YB4TyaltrM+IU0p8jHZrDdxv0sY9dEy4AhdXE4n1ozgp9+w8xsvsWSdRKPX1d2J9KLAzM3ojHXfRZQ/YypPDwuqI0AfrzKUxRIY+OySTIvWHiMaARa6nQKLAr5KvkttKVMwB8vpSg4K5XpBtjJPV4owXX/Nagy6z7NZQoYR2o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS1PR04MB9479.eurprd04.prod.outlook.com (2603:10a6:20b:4d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 13 Jun
 2023 21:32:15 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.035; Tue, 13 Jun 2023
 21:32:15 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v5 03/12] dmaengine: fsl-edma: transition from bool fields to bitmask flags in drvdata
Date:   Tue, 13 Jun 2023 17:31:40 -0400
Message-Id: <20230613213149.2076358-4-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2e5933e9-a438-4d7f-19ae-08db6c55a83e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TasjUgIq8gnQO+YetTLqhaZBPvv8B6W/CB0feo2RaSbtUNrX5wKK+xA0S3xYh23ZrkonxGZzbn4Mr3cgby7/Sw+s1QHvmjxUkcSI8Y8AotT/wplxlic0BhxmsSfU0IZTBFHrf4soy61pDwcgoYuhTziEy3+t54GxG2+t6zP0KgHP8Xh8Qmy6I6/NkdNu+GV67vZRFQDs+kgU/Sc4wm/wXVe/Rdu5XpBU3ADOiKQUc6YyiGcXzEoGMybJC15FOn66MB+jZ5AJOsJ/Nxakkvv1LPCPnmMslu2lKVAYy1cy2eiQAoidbAOGUyQ6wKiXgYjuUB1BL4CPHkPU0Cn0ve5XBAKJGmtNPb2vf1hqwfmLlDA6BZ/R4tMDHr9MJc3g7+wvN+NXxw+bigXJV6OLRI3f8NV6GcEarFvuLcER6rjG8RxCztJ0ES/Zr/S9nNpndQdEcUAr6zN969o589MSHVTrQG5StDOatYyEn5sJ49SR1Vc8jqIp/6MB+J7p9bM7X9V7lQgnXJCRduHyPVZ6S7gJIYsbeTshGv4EAA8IX5bgU6WcLWuy8H3LIOkviI+kXcanYBbUMB8H+F32uwLiHQN7mFq3IOZZRUAzaUlSSWqY4BSGbVuQpirdv0kvAhUGoKdHIZ8ltArfV5L9SAKoCLg3Ow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199021)(2616005)(36756003)(86362001)(66556008)(478600001)(66946007)(6666004)(66476007)(316002)(6486002)(52116002)(8676002)(41300700001)(2906002)(8936002)(5660300002)(921005)(38100700002)(38350700002)(186003)(83380400001)(26005)(1076003)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zGXidXc44BPBSPVoWn0zmbtnsOHR8qpGQqNbvfukRRy3oGHROppdkum8y4IW?=
 =?us-ascii?Q?czEXLNR7242MW/cfFhF70n/54t6HF8M4Z4OIpeUGCXiaM6Qcf5Nh6cI9XLmw?=
 =?us-ascii?Q?GHE2DxNMajQar8Y8nVN3kiGhoOrM+FwFHckdPfVLZpVbOGsLfcrAXhpM7An2?=
 =?us-ascii?Q?U2NL4rLWOg+kokdKRs2H1joL6Z1OtzBbuZnesGtDCa75BxZ1ZLefDIPT/qNI?=
 =?us-ascii?Q?/amEUkhYidCCgaaknSbfsw6gRfGV/D1Ep5GAzI/thW+5perr+G9nbmGZHEYU?=
 =?us-ascii?Q?BC0svXrc8zt/uGae3VHOg0TuJodBIS6Uo2L8g4g9/3u5SLVBlNvgcXWwJwLZ?=
 =?us-ascii?Q?PjQolBVy0DyvSg+s3zj7yNWkibWREZQbYXlVdg9mz/tFL/ppdBk13+4hrRD/?=
 =?us-ascii?Q?a1i2Bg1wS2P/CZJA694W4ZwJx2Ezkvi4mZ6BpfspCRw2UrkS/QyxzvSC8lAJ?=
 =?us-ascii?Q?6nkdcSpNDEH9jlJImNDMpdCPuVxazcZJXjdBzu6m7KzoDlwCyqysrjvecQRF?=
 =?us-ascii?Q?75y8L9qeb7OFbWh+RfZ5KbC4jao2litOU3qJuhqE/Bmw1kJm3rI5WpvVNWVG?=
 =?us-ascii?Q?mOEEK1FxYaXR1QGxEDiI8XsSXA/wGBb8swxBf9eDk1PYld+yX/WUnIMz5CDY?=
 =?us-ascii?Q?oxUFiucwXr010FwL32yB54yaRD89IRDte4MKaKz2s1pbpLSKNALkPtO1kQNI?=
 =?us-ascii?Q?duK38Sc4rcz5ZLmLwu4nKkyCgXRKDV9AoH/wKv4xVQePti6WqxiUO1PccSmz?=
 =?us-ascii?Q?7k233KeHcHwOSzTPNZlBHtqDBRZae2WEVAj7iY5/sQj2EyRBI5zrMdCfLspN?=
 =?us-ascii?Q?LSWBu0Cmj2djtOsCCOBSscSXE5h+X4D15JyaRRx/8XyxGqWzDmFpQYImKkI/?=
 =?us-ascii?Q?2yJjalz60SKGFwEDk8AGGvQxCMpN+NEDbBlw6i/1I6rAXUVExw1BLlLdZull?=
 =?us-ascii?Q?1CzOkkLWJ9o1b7rUA9b2RkrO1jgTgLvNlwNVB4obRn7uVotRwWkoPdpF+K+3?=
 =?us-ascii?Q?eQLjViKrKbTUYBv1UegW/hnbY1INSKxGCAptcTnNKX7bSvTFoKMWXxMrmI9T?=
 =?us-ascii?Q?/LQ/W5BvLz95AKT9AVCNyMwKdbQOoLSnDCottfpViuHyJr8HkJpRHOyJkMIs?=
 =?us-ascii?Q?CIX6f2jwHWOxS0v3WHn7xmKsKPvjV6lqHSgRyzgZw3Jni4wB140WX74up5MY?=
 =?us-ascii?Q?RBXbjRnyskDoDuN82Fzym8d433Dec09hxCygihoWqG4IF+CHT/r5O+SYfmMF?=
 =?us-ascii?Q?Gv2EDPtg9kAYQu+SqCTD90I9FuUU04fCRW8Clvmw4xDOxx3BrdUxT6FyfaPZ?=
 =?us-ascii?Q?NTUDoxyaIa6EPWz9q3CrwErpPbliSLl5sRo3rqGr1zQdcfNHW5/k3ZUvJEEc?=
 =?us-ascii?Q?3R6Kx4c6Ff1TCNSCtm2Dc3r66Im9veDKL1pwZG0rv8ODh++LOBHryPbSEM7E?=
 =?us-ascii?Q?6oIvAX8GEjlRugo12QuyRx2efSI8YyfksUGdKEe83izlrWOQlDjc9582khxP?=
 =?us-ascii?Q?mcAtgHJ9Hm9I8fnh70eGTtpuTxaBAZ1JcZIKd9LNjdSNemkfxUm8QF/YkA0N?=
 =?us-ascii?Q?7MIl+lKnE60sd4RHmJQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5933e9-a438-4d7f-19ae-08db6c55a83e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 21:32:15.5274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckuvZ/Glwpye2Ou/DDLn3aoR9tMjWeSRXFNDzii0VUEpYxt/R8z8VzxTICdVgGe7LRdF7T5hsrS29NOjwkk0Tw==
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

