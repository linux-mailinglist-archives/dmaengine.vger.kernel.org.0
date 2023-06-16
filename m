Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D207334E6
	for <lists+dmaengine@lfdr.de>; Fri, 16 Jun 2023 17:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346041AbjFPPfN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Jun 2023 11:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346015AbjFPPfL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Jun 2023 11:35:11 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2041.outbound.protection.outlook.com [40.107.104.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9315835A0;
        Fri, 16 Jun 2023 08:35:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hI+v5nETUDfgHIcyeLvwAKbD5XWHL8SS2/Ui//pxsCAaswUizrsBhPOYjsWzv/0VT2i2gQSo7gLfetJUA5qdbmINeCy4pUJja4ackvzeiUw6bMeAD6QstKH+wyDrayWd8K0zAA5Dy7Wa1vs130dSER8KFeHIgVoVBc1B7mAef2XKvPD/TP3OVSBpc40E6Q7/FkRemWIo/LfHGq+TC1T+Tm8wRfpr5YDB0wV3WB6mJk4XzgpP9UpOKLjlurn7h1cDQmZhSlSMeOqHUAejAHVfLFiJywMGHIyEVgByVnp6U7H5o9z4yfS1btuQoJGnYMGZicqkPufU+LDaRvrFCbRLKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5Juf3kOYMDDqoTfA5YQdmkMKOm31LEp8hl7IUV/jfw=;
 b=Z5N6OOn9TzrJTGzqO1bHsHx/Kdl4QGasHQ9uNMd0VO4VYVqIEWubX8aFd7RnaibqV6p0wzT4x2aM42RuKFm7nwE5pzixX2GaLptk3nq8qCLPxqugmlpdEF1pyufb8cx7fo0B6kp/02ajBYcHxSOYkQEHZn61M9L95pVE2KHQsks4VJsCnav/cIFSNzAlIvYpkLVxD8OU/vMItrUAnBFV/IfZfYt7v7lnGO1D9aFCVK/b29Abbzzgrz5lQjdN9m1+RWpcdUPgeW9ZgQS8XbO4tUe/KZSYs9uKUy0ZaDEBvdLKZFRo+h8Kt7cpBTPnSayAEyeW/AjObVZmtHqYAfB7Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5Juf3kOYMDDqoTfA5YQdmkMKOm31LEp8hl7IUV/jfw=;
 b=H4HECgoMZoU+OicUH9V5oLyBFvdS1igiBlEZiWbo+9SUhCJtZ2NeiUYLZTO1UZP7wYyg3+Je1UKibXYnwcez2pFL+itQij4prcgn9BqAlOhYzmxHw1nk1p7/Af0b5KtX/MF/4IOJnp2PCGDuLyYQK/IhIp0IBCFcjVqDTk0q5Rg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PR3PR04MB7339.eurprd04.prod.outlook.com (2603:10a6:102:8b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Fri, 16 Jun
 2023 15:35:04 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.035; Fri, 16 Jun 2023
 15:35:04 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v7 03/12] dmaengine: fsl-edma: transition from bool fields to bitmask flags in drvdata
Date:   Fri, 16 Jun 2023 11:34:29 -0400
Message-Id: <20230616153438.2299922-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616153438.2299922-1-Frank.Li@nxp.com>
References: <20230616153438.2299922-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:a03:331::12) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PR3PR04MB7339:EE_
X-MS-Office365-Filtering-Correlation-Id: 27e86d94-b88a-4299-ede7-08db6e7f416d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SCf2zrnbiOrqqSStCKqOj8dDjnv9RVZMlehuo+nrt0LzABxWJLAqNh+v+FbC1pmqYfbqadIbQqdyvpJFlES+dffzZY7Hctq0s/m/b+eXky0f+FkoIAI7yLGcc9fMPbOu5Xu3FtQL3PSUhmX0AxNDRloVOpEdDj+sCrNvcnHQKH0MX9DduA4nc5WFNjoWsu4vYXsNCrd9lpl0LnixRVHxGR18w/AjhGDRcIFIh7omnHip1yO8llAGGmqLNxcrLhntnVvKvOfAUxjpxmFD7DRCQ8NZagwjYWfkodcMaEIqrOtgAef6YHZUr6kYRouGHjETDppp8QznBV7/UXje3Wt8JTift5yxZ1V5RsYsiIbxEMr7aY0wrjWuJiPG9yZVm7R4ujtC131wBk7I+twTN68GO8sE0wwPmKPUU6U4YC8w+D7AUR2uRMY0xaMPebyrHX0lpDbRLOYz3jPj61F6IctSwkAkcI7lCIoAPW8Eaa2AauU7mDoT69h3hI/50Ep/4pTa91pNNbDngnz7BQ97PpzZdrhOuHArSrMot4ciOYwXwhB2yLmfzoGgkZudMHyKpKJfapYsln0joCKzuE+HoTct8snEcCouKCN+P+d+LqiJAJgPAU7aMKU//TsHHanqrt9Vg7gieFx3PQxI19Pt5LHHnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(38100700002)(66476007)(66556008)(921005)(66946007)(316002)(2616005)(38350700002)(86362001)(186003)(52116002)(36756003)(6486002)(6666004)(26005)(6506007)(6512007)(1076003)(478600001)(2906002)(8936002)(8676002)(5660300002)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xgMoei7UTXlfF/jOg3+wRyvIdNsSXpA9KSa7kPWTi7q7nkrU5ma5Zn8q0XAi?=
 =?us-ascii?Q?ncX6KsSKkcxLo1L97L9qzcZzvEXWAz7BAV/nMUYjH4vX1ZSzOrIXUBl82//2?=
 =?us-ascii?Q?C2vRkdir0TWW47x0eYOm4pjffvSwg0w5+ppazXqXujfR3gLtdqVk+w4sQHrI?=
 =?us-ascii?Q?y1MEz+3HKhVYF127s6IGtYeHrC5F5U1hb9+315/RrLsE9mspMfDPTg32M4VQ?=
 =?us-ascii?Q?6znRc+ZzeyEz8hDLFjkarrVRlfF+jvL2DVXlJxXbA79fpRgJa9GkhXZ6pFwY?=
 =?us-ascii?Q?cjm/g+nUwF+HBGeDG0S0zPJOJLPmnJHqXXUT6OaCk+5I+7VkXzlCMNx1vwv+?=
 =?us-ascii?Q?ioX8w8uEq5THErxO6VkN7I0+RirSpF0fSsj4G87uO41TEjhYyrfWlprLfOCp?=
 =?us-ascii?Q?NNL2p7u7TBYH7Dnrhn7+3I0AuqLhRJDdK3lWGD1m2taohdOQmF6a7u5SZBum?=
 =?us-ascii?Q?RHK9J4oajbR6JjytRB0e+1D2IysKNb4i2eP0ZYRRCVCwZ5aXMGItu90DBf/a?=
 =?us-ascii?Q?k7W86FEmZijAbSgMqqOUE5lCcDcLlJMw8GXh2uAAyI/8e7gqhj/vy/ZbFR9D?=
 =?us-ascii?Q?r3VxCsCIm6wzPJqlEM42w8Cjhn45iaJHsWpaXbMss5FrxM6kGew0QzJ3HbpZ?=
 =?us-ascii?Q?aMSjwtzAM7jl7qSnXGJ5EQ8t92bIoKMFBZ2sY+GzyQL5aQs1LS+ZT/KPw4GW?=
 =?us-ascii?Q?NVPr5CRIGYAy7TB4qV+xFHaG7DWbqVRVeXNUVXc9b9d2tErUdhjv+j7ejs8M?=
 =?us-ascii?Q?2Kj/E3B7L0mATMfib97JXQSY8DrJ4k7H33zjbJ2en64xmHpL1FU4yw7uwX31?=
 =?us-ascii?Q?hoKwNgKixyEZ1df5I63KpeJVuqVYnaSmyTm0ahE9R0p2juHqWnytXKcP03jU?=
 =?us-ascii?Q?TcUNVx7yB3oGHt2SiGHDsova85Xdw5/YHzMYOrlqz7veC+11RMZbs4r04Mz2?=
 =?us-ascii?Q?+MJb0OciAdCqk9fyqAXFWekzcjDAMp/eWp6o1cGd9/U03XIoCcBKSAX4mkn0?=
 =?us-ascii?Q?o2huO8hOQz1aqlDT1B8DpucnJ2BxWN8rm11yMq9BNaTANVN2Qa0B+JZpfRgO?=
 =?us-ascii?Q?1Gm3MgowBm8pzXsuUOEyilIpbqOLMeT8LO3MqB3M1QVn56kOlzDAAS6p0PQk?=
 =?us-ascii?Q?anFiFHV/1AwhgTErt9jI+cRBooU+IasitzJjq454iqJkhfMIJRZLoFlcZwYD?=
 =?us-ascii?Q?FX3QkJLVMko6XNUt+ejbC8d+V5KQxSPb2SXrEhajwqOfF5s5soEcMgc6YY9L?=
 =?us-ascii?Q?bF1sB/NV9QTfwVWnIlM9uuoSGsQCTEAuYB9Pc9ot7ItX6v8mH58ihwCuZkDG?=
 =?us-ascii?Q?EFe6A3yrlZGcqOfGXeFstTEHaoIx2z90PtvclyAJw4UbIFB/iSgjsdTBtct5?=
 =?us-ascii?Q?R1w9H+dnbrpOdr+QJlCoFGVaotJMmi0VGKBWv6XS4bYqnld8veF3L8qN1z1z?=
 =?us-ascii?Q?Fv7Ieo4/f7xbKMLxH3mDCG3/Xk4Bcjhpq/ma2pUbJvSHi5A4Jl3ZKTJaeOYZ?=
 =?us-ascii?Q?sz/GOcfuWetRaXgf70zsiIONegcRM3TZpcHPj0hudzqvy1aJ4RTGJS7u9Ox7?=
 =?us-ascii?Q?BkgAjOXRzeSLBz866iM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e86d94-b88a-4299-ede7-08db6e7f416d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 15:35:04.2421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EPYewqSnELxkdWqDnlZovac/2aHt4uTg8hwy2pqSTSVBQcMdvHV5/zDEZo3TI2Xc6apSLQHFkzd8AmIogLIO7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7339
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
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

