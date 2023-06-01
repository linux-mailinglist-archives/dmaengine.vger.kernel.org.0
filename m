Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF1C71A08E
	for <lists+dmaengine@lfdr.de>; Thu,  1 Jun 2023 16:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbjFAOlk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 1 Jun 2023 10:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbjFAOli (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 1 Jun 2023 10:41:38 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABC718F;
        Thu,  1 Jun 2023 07:41:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pgbe1LYuLjl8U/3Bud6Sa0XvaXbqOms0oV0uiG4sa7kN9gvru20Pg5nqcnt0GQ+nImNP5lgh7y6e7bO8qeOED2ZQ7LxgGb8nuE3nYkVz/L8T25UY3JCTGoZqW0yLqhQ5fh0v/cNtuvVkkifIBNFHYpS6XATFXBl0OcUz4viBOLzwWZTuAhkawzfg/vZMHmAqCWzRpoK4/YG9QCC1XhelLisE272BCnAJplRHiG6Ntg67SZbmSPV2pDzBX548T0zqhXG/aWElleyyu1otcwOmXcVUDR2NDkjRYudG9T9ZYylUMxpcWgr02OG/pKRKujjmiZALJic/U9K6yPwp8PaRiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5Juf3kOYMDDqoTfA5YQdmkMKOm31LEp8hl7IUV/jfw=;
 b=ihoIzifxtisPSFZG93p1uMy0IsBM7EiCjl6F37pcK7iTRbxM2pp7HxSdsCao692E73xfRlSlhs8wIXSE5BsrJ9EHbInOFIJL3cocK8zCzfeG4FD494QHYWDbO9BZ39eztOkY+shyVE+cZBFNiD5Y4SBXDJv59lOi9ODHGPrcCBZZ/LiemqScpSTUW82lEHLdptLfPpaeje3MWVPDxnQbyHs7ycCCvNAhkPRE1lpsjbVk0Pn+lOZlUKgEL9CiBgNk5beOR28q0byD3VN42T687sOwY/9PmCOLmLpFbhOYup2eBDzIUuTh4FyrwOGuxqEXLDvaMCsESSoZIssnff3QzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5Juf3kOYMDDqoTfA5YQdmkMKOm31LEp8hl7IUV/jfw=;
 b=iShn9RfGTlsN6/f7564ubF7cO8S/dUYZ4dCW/YK+S368NXVxSYHc9SsKvnBxWOFKda6YJiRTwsC0ve8byFqBm0c9AIoPjFGOBo51KvqLyLabIH9VE/m1Vkfcb+AzeMqrJFbwzGpMi64VBOuleRvyvKphgmlkKJEPT16+KTt4qCw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB7603.eurprd04.prod.outlook.com (2603:10a6:20b:2d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 14:41:34 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 14:41:34 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v3 03/12] dmaengine: fsl-edma: transition from bool fields to bitmask flags in drvdata
Date:   Thu,  1 Jun 2023 10:40:58 -0400
Message-Id: <20230601144107.1636833-4-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 32650ccf-8192-4a7a-07cc-08db62ae4be2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 99s7kI6AnmhkDvgDk2+E5bOWDHO5m1zWRZ8Uk7iYUiWqjT2f6GPAZgt19Wkoks+Z28nUegmBmT/Lg6WCD6J5TGN+bCKB6eDMJpFgreBvqxFEjb5Jvc0XdeARKzU3cw7mCBdSjeSiqIomt2Ifx6c9xbG4Wp4jso7xO8xk3Ua+kizkocv+o1fjYRlO50kVwJhBvpZrGCHczSt7z6Fgbk0XL7ge9I3JpcCvd1aEunYNrSNa7FyfqiK8F4Fi9r9R0WpFwrp+f11t7xsVwN5vAOnATJV1nzgqzDyAka/LcqPVUxOH55Q2hryfIYEHXTEsrjVZOXsfgpv4IRBx4M9ichDdyzXxQb1H1cG6fke3vbL/4z8WwTDgvZdpfoIG786X+5A/wf5QiRc651rERtwzc+y1KKESVae9nLYRY2DMhzyYVijmeXi3ReJ4adpjoyhDwoqAs1F6MTxzfywJxTcr/W2ZzNaHOFbfv7IOOehz4WaNvDzM28Q95ivTWKlM8f4HEU8SKVQ5MRIHVSEFzqSpEeHpXGqQK8reGIdj1Bh7iukskcZ8lq047kWQ7bt+5sbnHtVC01YuWK2PqgBN0kuNyU8Ar4pjsXiim0TsHstYuseZhJMpWJogIAXXHP2/cMwAHzGtieNBZDf7npteJ2uW3aYTBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199021)(26005)(36756003)(6506007)(1076003)(6512007)(2616005)(86362001)(186003)(2906002)(478600001)(66946007)(66476007)(66556008)(5660300002)(52116002)(83380400001)(8936002)(6486002)(41300700001)(921005)(38100700002)(8676002)(316002)(38350700002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8baULYf/Boosv/q+nMhkfZ8afi69TWsxJ+SMsO4nOVaMaMTE+dQ/INy0XmqJ?=
 =?us-ascii?Q?F5Ne8x0WIPAcbee2TxW3ToBoDkhmAREc6IM4OiS5IW9DHacsoLRBoXucXsEM?=
 =?us-ascii?Q?JZeKDol2Go80Vb3O8kcoBeKM6koimEBjzTdUOEL2R/0cTEcCccr2DsuSmOfD?=
 =?us-ascii?Q?zAu0P7u+PkQlUeVK8e5UNV3cItfb8YULeKNaDpYz2vGajTc6OYfxt5Hk4izh?=
 =?us-ascii?Q?RVxoAzkVXfqD83snpO3GjEuB8ZoS5OOh7llBwFNw4Px3LXJ8t993HVPy+9OM?=
 =?us-ascii?Q?o90IyQRfaSVoP0G2WM/UokFABBunL7Jww5RFuwWpcwsKawy6Lr0n3VrCjSyI?=
 =?us-ascii?Q?b09DzQVXjAqicdGr4WWuW+bDpTcIh11GA0IYogXYLZEyVE+7Rjst7YT+z3X9?=
 =?us-ascii?Q?KMiqHHO2DcrQXMN+qMyunBb33suq1kto0lzc6CwPxs9DfdKP0i9QOjyLPS1d?=
 =?us-ascii?Q?OdmVz2Ry5KSsP6wZL+RDzoVUgi6e9Rwzk6Wl3uoBcEryMB72niaMSXMLszXy?=
 =?us-ascii?Q?oY6N9ITA/m4NKK4kpgwva0gTne33rPSuq+3lm+1JQaDZse8ktOqRrIITes1w?=
 =?us-ascii?Q?AkShIHyOZs5tPt+/Ij/AT889P1FziGqdkPa2hVtEyh53J8+CZ5q4uRZQ5YGx?=
 =?us-ascii?Q?9q1iB06zPa6bcr7iE87KAYbxLv74qC+ij5eSyxZ6z5W9EQY5RUHVk/tcVGPV?=
 =?us-ascii?Q?hzNnlyNaaZifCn9c1SyxrZ4OBRw9+VJrIdwBN0+5JCM0E773cNETtVpheqOu?=
 =?us-ascii?Q?nrk9YMTIwwxHNZdboPyCrf22Uolv8agBYFpmEIK3KjKDyRidUkMdF1cuUUeZ?=
 =?us-ascii?Q?aV3RLVucA6mlJmt2/hC3xEQ6vqNZnRzMPPb3GSVSyjU3vsYhbrTnRAL5g9dN?=
 =?us-ascii?Q?F/DlDsW1WNAV8eUL1gtbknFTcMzChhEwDwZRwd3RhKW4UEb+zNDFEcynfkG8?=
 =?us-ascii?Q?INalkvKTKQLAe298KZamc5EyfqcPmY7gSifGsPgMhc0ZIRokGe2z/aTv7YlZ?=
 =?us-ascii?Q?6g6tn0qbG5L0eOj7H7/AQK4LXws/bHvrwI4sH+ltg6sle509RPEIlwVD5j73?=
 =?us-ascii?Q?drSCe/otKMYd51TVJfJiO5MSdDUANlwcvIqDZeIC8zRTaayYVZWNrUqUzjDK?=
 =?us-ascii?Q?ZKIuhQfGNDP77ENuopT/wSusqM+/FO/CY40xC5tKaJAXPuIVSr96fql5ACVS?=
 =?us-ascii?Q?nCbRu6PPXc6mHXdI0PJpEl0mg1nUx0zqibjpOsDQcctJx1L3XCPs0DcuB3yb?=
 =?us-ascii?Q?LgLaR1S9E9dgGwRP2UuI7UoHyr8FZx/2IPjxgh0ul1t1FcbbCdf02MnDG1Zm?=
 =?us-ascii?Q?80/PHqXe1pDDhF8FNdsFEVSYzNNYY3SNBsgb9K3bse7eH/0wo0lG5pqoNrME?=
 =?us-ascii?Q?P/SOV9AJ5w3ZbmODUsaGom1jCc1GbDZyOH+ZAzxSWjFXC/iXy0iY/U2HhHuT?=
 =?us-ascii?Q?pGtqgC6cQUiqwXvmh3CO1O0mJ9ubP3assQypoZ7bc9bcNzMsyyxZJSvvflfX?=
 =?us-ascii?Q?E3N4xa02sBlgHL1q0+XZ+6Q0DsuD4GUSHyu8RjLnWnZsjY4CyVj/wiMonvxY?=
 =?us-ascii?Q?BX0yQsQ5B5nMqCk1/bbR0SrmSVUw4dyLrnxzZiQu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32650ccf-8192-4a7a-07cc-08db62ae4be2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 14:41:34.5210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 46lxsmJetZAwDUGfQLDVCL7aSdYSPzTR3+B5dd6zSE30FoigVEc0gHxTy4Y9cLRRtVVIJccAykF+XXIv3bYcjA==
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

