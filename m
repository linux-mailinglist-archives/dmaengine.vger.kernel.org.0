Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55BD7375B7
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jun 2023 22:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjFTUNE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Jun 2023 16:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjFTUM4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 20 Jun 2023 16:12:56 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2045.outbound.protection.outlook.com [40.107.6.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F031987;
        Tue, 20 Jun 2023 13:12:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oW7+9Q34irE0BsisNVnNxb438j0kmAL9xk9uu6rh6jFCj41/JsbTia2N49CoJNAFxy70lPFOr6cAQAU6Thj4wgWV72waQFxSCNBiv0bmPPj4hEYnfpFnyFB7o4mewY95SMSFkGyav78V7GivBhGbI227vbkoebjbxOtxXJG0MnEN/BBetfrR8Ob/3/KDDl6st6uPP0MpulVpLqQ8lcxxYUmagI6fQhb7ilr0qKnmtu30cvgg1g2oVwTL7l7oILRH9W+yMc7VMBRD31J2QtsVyYanwfHFIqW9pkHdaLcnefg0YbiveqWh2CEfcfJMRh0NkrXDU82s1hGd21k8v9n3jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5Juf3kOYMDDqoTfA5YQdmkMKOm31LEp8hl7IUV/jfw=;
 b=Cv34LkGhRRi4Zv4Lu9KkGe/4YeCuF+kvyXSo1tX2Plml5NJy1Y9TRTzGukZ/XsTVECkf3rymfut3GTbUZgkVFItWR6xl6lExbMwYzMmzcB6wctaIg+zNkHbAK67fLSnQHSncSRzAvNRHnRuiXdxN5cyo6VAOTRdgiEV4aMVUZMMXpx3BO6s+jWH9rBYB7DEyBdWAZBAb0US7O8ldRsR77CAZnQdIxmHGkFRgqqn6sc/TXp+LbNkawK8Pa104gWpboeT25kKiOWoiqfMfRwqSC9RmAq+GIYJSHOjfuaK7tZrSaD5y+pL0Vo3mX0cOiAfMVUVDC+WPYfM6xi8xud/9PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5Juf3kOYMDDqoTfA5YQdmkMKOm31LEp8hl7IUV/jfw=;
 b=YA0Zv42pMo9jl1+JBE9Pvnzxh0MHk47pR1rWYjdRy5Mxd3RgGgktUGDUPIV7Luzv/GPqAM5PoPxwq9h3FlEQKYCzXyq0PYnXzbmucbxSd80cxNn3qGl2PxLbRL12uiabl3Rykrhvp8zUVFc06HhmdAEA+V1Vrv2m8AMylisnj2w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB8903.eurprd04.prod.outlook.com (2603:10a6:10:2e2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 20:12:48 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 20:12:48 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v9 04/13] dmaengine: fsl-edma: transition from bool fields to bitmask flags in drvdata
Date:   Tue, 20 Jun 2023 16:12:12 -0400
Message-Id: <20230620201221.2580428-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620201221.2580428-1-Frank.Li@nxp.com>
References: <20230620201221.2580428-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0086.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::31) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU2PR04MB8903:EE_
X-MS-Office365-Filtering-Correlation-Id: 60745534-d4e0-4ea9-8345-08db71cab7c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KPvIjusApt+nrqa6C7nbqgEJvccRVX4tKAzTNlF1DhRHW/mo9tAd6RTFPYFtVoPSwuynxBY+f5WmcTyG2A4lvufDq/hhYQG0Y50SecqaN587VRL/E/YRHGLTnYJw1w0MD3fZAp40tmkAJcryQzxlKwJ49Ru/gcAUynT4DeRPLe/7y6YEJYgaQICClh4SJDaTXRILSBDZxTI5YqdI6f6oXn+cUIriUHjS3PBVRtSKTU0zKUNg86uDJbyRhwqCJhRjh6tlD+kyCcz2Nzp7ShjzG5/hRzpfBgrtck2KVA06DJIyWV3MXMZADkE9Sk6X43jtA1bhdTMd6JqpDde8mSlB6GFj2CK9mH9uyxjegX3qISQUmWNxUZDIu1Ayyg44YzlxJwL4+EW4NLFi0/6C2N+/8+ta50YZA5RnKDf8fZQbqfFe0XzmDTmyKkUObECdfRUFsW3cIoqdwrrIoYgXgQAMua7zQrfHYAgDkp3r0MgGSL/Zi0y7s5lmPiMA864OExBn01R1Kz87AhnFLsGaltsQiOiU3b4pMZrkIhaVp8JwBEbwJNVOKZTYX0gh7IMYRvMVtT8hEoepzlhksC7kcx1AsclY2qv1pa/JeQ6XZoufbvAilrde7veNHrxpaNF7kegAZvlP657iBQp5iOlLzUSzlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(451199021)(83380400001)(66556008)(316002)(41300700001)(66946007)(66476007)(36756003)(1076003)(6506007)(2906002)(8676002)(8936002)(5660300002)(86362001)(38100700002)(38350700002)(921005)(2616005)(6666004)(478600001)(6512007)(26005)(186003)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UXcSrbKntIEAG8jtCmrV3O8BpEUw11hvgJipgw7wAgYXYo7/dcix9+su2UVf?=
 =?us-ascii?Q?aZkCA/LY6jGKIvN45fT5EFAWy63Y/tpJ4NGUWR7rg1QMhX5w08mpXCv4Whvb?=
 =?us-ascii?Q?SPXo/PCsrf2a6bryZ1cOg6m1fBfHbdJImz0XK8cr5NgxvJw/fzz7vncSZ+IF?=
 =?us-ascii?Q?OuPtRB7jFFqceylcXfUT6hedZxDXj9xe58OskWyN/TcD1cOP3if++fAiLSVL?=
 =?us-ascii?Q?u2BFJietEmVykxl8duLsMhilLahc6tDO0206LXonFMnR/Y4zdI+e91LP/Y1S?=
 =?us-ascii?Q?3rcidnojT05BoGStaI+emm9gi0qMWSF7RGiqq1p1FUNhRGRz5pApnz18+sV9?=
 =?us-ascii?Q?f6DRk1b3Aho2UR9wEq9ySvM6PN7nFejCje7+vxoWZohEm+dL79QfPIZy9whO?=
 =?us-ascii?Q?1gwZjsF0Fjc0cZrqVqaWGKI7tXH7h7Enoh+h6ENu+dlFZiPa+xzjikBQiGaa?=
 =?us-ascii?Q?i6ozZ8NIURUtUypXFALWHH21Z6f7A0S4SopDX+2mqFbly0L8vCppQ8IkHIKq?=
 =?us-ascii?Q?xsGs9+Rvn81ub2I5DFE5z6ULt+xys9sOsjVp7Zbf2waJA9dDeshqN00X4d28?=
 =?us-ascii?Q?kPwl7c3iWexxtslDLoRgozJ4Ytjj49Gco0sZ7KPGjyYQLEqOOqt04U1hZt4P?=
 =?us-ascii?Q?vbyf02cZ5rKE2sFhmU6ey5k16Yd5Oj/Tkp/FNuczSywBy+vfkEYfI9mslWTt?=
 =?us-ascii?Q?lOnIAbWGXh6I4dz3TY/wJkp8qK5w/aS9YwbAXe0a+9Pnh1oFXYju0bBMjKXx?=
 =?us-ascii?Q?E8zve+rVMehni6yycIDEZnAMLKwxGepPvFhajY5mVSFZqOZmSVPpVOQ6L6XG?=
 =?us-ascii?Q?yVlayCzcJkF1SzoHMda1uPN8/CBoFJWDCrI8/l4paclFeL15X9lJkmdJUNtT?=
 =?us-ascii?Q?EVqgmecX7/HF0QAaWKcwoLPkFHDjnLAKEaGr19HBvUSxIRJBBEDqFTJYs4FK?=
 =?us-ascii?Q?uH60aqIn1lEMfgKVyAbDRmrdz0uyLvYw3hegvDg5FvUGYFbjS1WBrzUmS8b6?=
 =?us-ascii?Q?wtK0SuPJj2l4MkmOPJNvAg5q4bKZlpjoVl3cuPyI9vRbP4uiaA68H8lifhB9?=
 =?us-ascii?Q?+1kYARm/8F9HM15aTEBSyqhfmC9qMq/rey1DptQhOITSl2Gjn7lIlZ/4vL0+?=
 =?us-ascii?Q?cbQHIE0NlbeDy17WWLFVDg8gzUqmCOgDxQ4ksdY7ud8LfPWzB22JVLkSjn/y?=
 =?us-ascii?Q?em7v7K75Fk+4INn4SQpm2JidOAxUMmz9LyH6ssNFqfAxStFOnYD2xGrpPyW5?=
 =?us-ascii?Q?Fu74SHMRGymOjppTEHBTwXBjXIVomW0fx4FPAoL4oWK1vzUV54JfndD2Ftbt?=
 =?us-ascii?Q?QMxRvKtKfvcGrB4Hbp/9pvR/HFMZsqxKkrxEeOnoxedvZbjnGbQUA2AQfK1i?=
 =?us-ascii?Q?HrSnCP+SoLhxw/An0nhbCrmwo62IYy0zV8UrMoQK/tstzJ25BBrmIFBarqfy?=
 =?us-ascii?Q?WEiVT07aopXwGwa/Fgmq/28j/CPFZQnezh4s3dhfB2uMLmMlM9UdJG846TXa?=
 =?us-ascii?Q?uBol+NtSn1INlVdXPI754bDWmEo9SnzTWSRKDiSqOTjOax6PfZgBTLqafeTZ?=
 =?us-ascii?Q?0dIabxTMgQbA/+M7B4/29iIC6TjWuv9YZ2VVkBK9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60745534-d4e0-4ea9-8345-08db71cab7c5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 20:12:48.5008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQ4FLdc/vRoC4UvqwS1n6VbKF+VmV0pRAExYFBQmypDc5VmbT3zb7jlM+S1Qndmff3ZktDfDTd+ux7KSmiJN4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8903
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

