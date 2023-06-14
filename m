Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C95F730859
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jun 2023 21:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236593AbjFNTgN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jun 2023 15:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjFNTgM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Jun 2023 15:36:12 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2081.outbound.protection.outlook.com [40.107.7.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991272116;
        Wed, 14 Jun 2023 12:36:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKx4IVUyVzkqKE4cFKZikiz4cyfTHHLULvG6lEYcDuMYVLZv8sYDMVgea8vgRDG1IXOIcCQ0FU3eF4Bz0XLmtb0vBy59DKe8vR3KWDBKiHC5glfSLxax+GVGtJANZNSIAwt7Nnu86Hv8fN9izmspGqhJTGRobjXsQC9yaTdKt4cyhQetE2ZepFTPETNjEbyJ9DmI52E52kMuDnFeoY+9Kv45ArAp/agOKuOR0zTtuLaJOfa26B/+kqkfX92+4WDIRLargHOtSFb+oVT5vKFXUMmg8XLwhfd5S0hvIIEGvE3WCztlskHb3+fIMm7NOPXjziHll2arUSZZ/ou7yYBpfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5Juf3kOYMDDqoTfA5YQdmkMKOm31LEp8hl7IUV/jfw=;
 b=JYWmvxLl+xK+VpPfl+g2zjUlsQ01pzY6n8kOOc6GJ0VW66OESL5ntw4edLd6o8KQ6A+S+fX+TRFDHbfdTn2rD1Js6jfvn+WiPBd6KCO9p4o5h8Ib+E+gKLdHNRNT3Zz/YbWAK0CyANvtVR1lherkptb1CN1jTfwxq191DiHrUGOq8rwSYbDIrg4lq9W7KzxG3Vjv/hvbfrSK480RDxYVzJiipHd3G/lvWu5wg5FWlP+ccwMBr4D/O6rdYHd2sSkj5rdcZlOQpLfBK6K1kDvg4JvfoNhYk7KEMHxDyj32qeyAXAG4LLIMXvp8lfpecUfe+7h6E1LfHGIIBRtzuWvVLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5Juf3kOYMDDqoTfA5YQdmkMKOm31LEp8hl7IUV/jfw=;
 b=dmoFzVpl2LpIAikoJjAlpn7yc2o2e/N32QamOh8OifLEbv3rrsB3EgXvdVDjQmhnXhxQlsiv5QUEryWqtms//6i+NTUmK1GCxQMrCLpR9TxomeQJKp7hi7RtvZWbGjxbz4lUYDoJ+YbApmC4SI/fsEg7E/0WzCR1Cv2FjM9NDKI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by VI1PR04MB9763.eurprd04.prod.outlook.com (2603:10a6:800:1d3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 19:36:08 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.035; Wed, 14 Jun 2023
 19:36:08 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v6 03/12] dmaengine: fsl-edma: transition from bool fields to bitmask flags in drvdata
Date:   Wed, 14 Jun 2023 15:35:35 -0400
Message-Id: <20230614193544.2114603-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230614193544.2114603-1-Frank.Li@nxp.com>
References: <20230614193544.2114603-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0051.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::26) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|VI1PR04MB9763:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a10ee68-629c-4491-45c1-08db6d0e9a06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ueqCbXYx0cVSGbctVbu2V6qJhON2SlNwiZaDzCg+YvUBoyZElKf85JsulCrMPwkZf7WgaCqvkeIpIAhn+lR6R8QxoxBvwNFmTj9qy0GeW7eJFLDk2NOXTzL0O3qEcMzBjI7lF7waHFZMCf7NLw1NMOSMQUZJHtV8MxFWSH5Mi2pkkdMyAzHyOglvCZEaDfIi4f2vg1bQrZTjdpIOUtyE3nuY/LC9RH5WZw82WTDJp3/vYKJKwoz72PH6MXfp3KeStCiiekR9RmBanQmSVZwXiLDhZpx8z08YH13d62MIiLbBpSYNfc8Bp2EGS6rwBvThnyqqMkgMKfWG9ZAURRYwF+b1tOdEscfwfe2rgEQJUtKBl6ze6T9/hrO8ve2xTEFpLJ1rVgjcRNB1Xk8+rzChaixpHaj+D4H/mEuphUxqV38wxxAU+4ASVwXmdGlDjbEhxO0oofv2DkYtdc2te4fZ9jRlb+XPtzVEO5EcNze3QkTZOfUPN/CzZS9RanHR3MvWP8NnFxgjV8nDeIi+5xYzfwhV4d35ZocwhKzrCjfpZGrltk+u7NaLd8ExEgaAtuXbeOQOkw0qNaXIWqKe2JOuzDVmBSW7ye4R9E0s7yEtcJLzHkLpHWZrGsAg8zqlwI+QSkAAHNV9rA7X/3NGYMq/Bg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199021)(5660300002)(6486002)(8676002)(52116002)(41300700001)(6666004)(8936002)(66556008)(66476007)(316002)(2906002)(186003)(478600001)(66946007)(83380400001)(38100700002)(38350700002)(921005)(86362001)(36756003)(26005)(6512007)(1076003)(6506007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sd0YdUmJdStZzF6v/JzaQo7lAVuamI8vHQ33Rwv6M0C6MtgZOb1ThYuXVqBN?=
 =?us-ascii?Q?3cmt28ZkgEgiRL/jf0LDls+qsiSJk4lwSBS7W5GTwwjqlrIE41x8ZQdLCZbo?=
 =?us-ascii?Q?6Lyr0hBuyfz8L8G/p3ZYFHlHEtp7BvxbciH78tGDfcOZ4ratk+M0l2kyYvyA?=
 =?us-ascii?Q?iHGAG5BhS4EWSHnJfDcHLdStY4EBmd6zmTcHe6Tn61diDyyI1SE3ezTqC5iU?=
 =?us-ascii?Q?tMn3pphRjZUXdCZSOSRkL+nYSfCAoz+kqpDo2+lk+h1KeGkrSIpMOfDXVs/a?=
 =?us-ascii?Q?HA6on9MDlKxOuyjQJsCiwij0JG2O0qfhMoyhbiAVjv3FxMHTo7ycM5JZS9BN?=
 =?us-ascii?Q?HdYRnRfyxq+8SBu1iaP7XJ4Ji0+WNh8zGOk81FYVYTbscesWgheMCwsYFH1q?=
 =?us-ascii?Q?/4ujubgqX2XMPD6ckUdR0cY7dQfQ/dTPwNAgrwcpIJU0gUIHgmbPHlT2I8k3?=
 =?us-ascii?Q?70p/dgo5wCIUUWasfeDGkrAt8A2+kJoyfvNltZZ+dqjIPlcEPtMAzAtWNews?=
 =?us-ascii?Q?LAmAuju9okMV1F2poB+2+y7iw8lwPyUw+eSXJyoJkLK9NWj5/Rogm6PyAFjq?=
 =?us-ascii?Q?L8Jli/uvFn1252K7zyVc0zsJE+znGHwcV6Y5/VJIIPEhCC0QFXdkkHpdjU46?=
 =?us-ascii?Q?hPS3koFOtJGJn579cLLrReQ5ENT7ZuGSE+O+EDG0p+/+j28raKEmf00zQ/7k?=
 =?us-ascii?Q?3A2J5nMastKLrk+Z4GsRg17/peRRAU4vOs+Im1uifFeqIdR9kzZcA1HhTvPb?=
 =?us-ascii?Q?t9ckVUAIeWTM5ACAQQOeL8jIDUZtEdRsjFwsqzMdoFXCnh1RA06u977fVEhL?=
 =?us-ascii?Q?hlAa4q6EMFMbH96PUx8sBnSfEg2/bW91vPH92QsNZGFy96R3mj9jgjACdWke?=
 =?us-ascii?Q?9h7Cqi6ME4WCTcY0tVLErkjtVrIEscjxIrUITmMIzH5DT/pPzgUI/J/bZZ96?=
 =?us-ascii?Q?BV6iXAc6VAuAzZX0ABkgMmMIXNSk6FLGN7tHcEcvfxKYgmqthtBoI/UZIK7k?=
 =?us-ascii?Q?Zj4bgqD+HWH6Qym80BfKw74w5H2LwafJsV2+h6af+3i/EO3llrw8g6DU3CxG?=
 =?us-ascii?Q?4Va8rm5scyGLGfiBEWg/pYG3pIuLBa0QYtF9fXyaG2ip5zmNyY01M/7s0JYb?=
 =?us-ascii?Q?Ge6pNARAQPOuTcm+BxRBMCMGNiPKhp+ZRtaDRXHNkhApm+ukgRJboHGaRyjH?=
 =?us-ascii?Q?8t2cW46V+FXpLte68JrFRz2bltpyKhq5DfFdemsr1+igpQkK05R2Hi39jYs9?=
 =?us-ascii?Q?y4Ps2MmqNq6ZTCtGXg1TgtcLPZynOagJOFozZHUpSlbBgeCQPuA1NpgtLMO0?=
 =?us-ascii?Q?lXZXIefyBETonJW7cinAolCy63K/+9eUgBPcr064U4SbfuVsHXadZnlnb2ai?=
 =?us-ascii?Q?8ccwBbxr0TBV3OWTMN18kpt5ZEt2ffG1BftzOxImwx8nZSWIktO4FjL1gwmZ?=
 =?us-ascii?Q?WQtAdVdDA+/lutmYB59SWtoPM7aL9pAU547gnw8Wjn6DUiX0HrfaqqTftZ4N?=
 =?us-ascii?Q?uuAwuLQ4YpVHoNDXnATql8KmIEtjM9u2C0JeWo7aT4ppzON6FG9PQ4UKsl0d?=
 =?us-ascii?Q?a7EPaHF54wRsLnCekb6xSe1//oOm7aHF+2U0+Flc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a10ee68-629c-4491-45c1-08db6d0e9a06
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 19:36:08.5683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mVWd4m682OrVjwdtCXhBL2NUDb2iRwhkdnED3KYQFMrz1D0+5zeNcFuHztLZzcgjImtGdqRZsYNc4ih/oSyDDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9763
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

