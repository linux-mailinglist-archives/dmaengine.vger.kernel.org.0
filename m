Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299B37334F7
	for <lists+dmaengine@lfdr.de>; Fri, 16 Jun 2023 17:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346013AbjFPPgg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Jun 2023 11:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbjFPPgf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Jun 2023 11:36:35 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FBF3C31;
        Fri, 16 Jun 2023 08:36:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuRU0EXATR/0Ck/N/Vcge8T/+qgFiYW8gcS1yD5INcCIXgDsdSYo4RUb/G4oNfR39INnFyvc+2qfNBvjcRi36hhHVJrd6VtvNFErDPv/55O7ygMSlACxPjEVEOp76gQH0EnLEu/WlldM3cpXE+ky4HALVwApJsPUyzqaxRBnW9A6kAcBtjtARd02QxGQnhIyv6vd3ETSJTvBLGkujS6/dlIHRMb9v0fwInBLLsIvX0BNV0UeiaQALflF6o1mf66lNQsagh1aBBoE+KTaHiz31tSHbYTdRwi99dlyK0j1Rhpf33aV1W3YEL7ogBAcQud+28QBx0iHlH49ikIQIfOuaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3jlBv0SLDnSXx5LFjozJINPkoX9ob6AsqXt6WuD2a0=;
 b=WzQptPPgwJGfsoVBQsf+jSQSS8aVtQIoBARY8j6nN2DtFJJ0t9YpTYxjk31CAHJiAgLt8Ip9Z8MXkddbprWWwkPQX0ULneTydCv6npxigiyYnk2HW5dCo3eUDWDy6TdLmRcvUaI/VNHr4CfNyZAVF+p5ikj8ldDFIluQtb8JBi23PNepO2YDr1H5CN/kGNCiD6Vfdviq+rRlylluNXSKM2xup8gvkVbbIbjgK0CL5NJ9TV8xCPxSVLGkXNH6BUIxEq9NIxscwFPOguysDg2/oclyg4nQ2WaaqdHu2O95dF6LnRniZXEk5jGod/r6PwLX+X5ranEI9f13mRwQz8eSBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3jlBv0SLDnSXx5LFjozJINPkoX9ob6AsqXt6WuD2a0=;
 b=CJcQNTMTrUsFcimHHXU30G3SCngtCpng15E42SWQiwm3TyCKnkgV13qdDTaYMuRm+VSm95+vCz0wrWqFfRdmRat7m7tMFDNNtWEic+Zlb5g2YBlxyffp5QWIVTe2ujuh1+Ax0OcQ9ya+9sC7URX50ihO2wvq9eFhVklO1yKczss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PR3PR04MB7339.eurprd04.prod.outlook.com (2603:10a6:102:8b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Fri, 16 Jun
 2023 15:35:18 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.035; Fri, 16 Jun 2023
 15:35:18 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v7 08/12] dmaengine: fsl-edma: move clearing of register interrupt into setup_irq function
Date:   Fri, 16 Jun 2023 11:34:34 -0400
Message-Id: <20230616153438.2299922-9-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b92f94bd-41dd-4e85-b4e7-08db6e7f49b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8LOqkvey9xQ8j3Qz7vYJ4w55qfS0aP6jzynCcbpOjqo2WI2A7OdC/brtjc7Ywxhk7vhAKeVmT4QbjYrNZydHDpg+lYhkmoCyVGqc3spLQ0xE+2h76MeuhxOjoebXehrtyAOqbCdYHKutLubU1BMv7ph9a/uFHRKmRJe/HiCcouGhFXtyimLnLRMIC0C1tJX1ijcqTT9KS7dl2khPUBT2SKH0IGBVeoeK3lh6V6VBrkavvaTv1M3b41lttPeggkPFAPbXTYDVFx5mWnUFOtxD7OQBLD2ziZJu81B83XINQvpqRYq9X4QgUjThP35yBJuY6moKzWAPCywiybay53uVhIG76CY2NXHOz94eLtHbTFO/pBujIu2qDOpnEJwF1C9pgCYlNuQbWrRtrshidj3uZh2y4XrWH81wOqgI+2zoQdKfiQpMGHEb9l58RQpBL/JaEk+OB14XyfcifvUn/ViUX1zHCYv3tKZrV4ISAcvaEE0oxrLbJvc58H1Rc302W2sLtHaFFLErtbTN4MIjUWPXFI5exCRfehpdSYPWzL1rhb3L3McyMd6F3BEuC2hAsW7EfJG7A6GiON0SwHpoCblW+ytl2ABd/xb1yHFggEhm0Yn7ALWQtTeMldvi5E2ZTA6uUvvItlbfiNS1KpOI/UAZxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(38100700002)(66476007)(66556008)(921005)(66946007)(316002)(2616005)(38350700002)(86362001)(186003)(52116002)(36756003)(6486002)(6666004)(26005)(6506007)(6512007)(1076003)(478600001)(2906002)(8936002)(8676002)(5660300002)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lpywZzstlmufl4S3zV8hnMAKbwDSiDfUJvg1SlPoTFe1QTL+GlSfOdHhT0BM?=
 =?us-ascii?Q?TiRXW/5PI1iVa4Yj2Tq9X6TXH4whyLvvYOnE/S4E8o037nGj7KxeZX7yr+aL?=
 =?us-ascii?Q?2YrAx+vjFMI0JoZkvkefq6YAf8EUnpgz5QzWtm2F0CIaNCT72hAFSPIycUkO?=
 =?us-ascii?Q?R0lIo4PxF0tsEeMQHd3vaa9J0D9GglIa3uuG9iDiL8bomLDJMKjDhmskLMuf?=
 =?us-ascii?Q?YvPqF0DeEzr7FZc/3Dj+lw+m2Na0scdnNNxSSJ8e40jqkEEjYG67YyFsBfpw?=
 =?us-ascii?Q?IYJSHMJP8VXIIr3cgz1XnHcsrA31d+FXJF9a0RWT+XZknA52JxbbZreGnsyz?=
 =?us-ascii?Q?JD24hMYRGlB05WqRBEQU7lyuw73wd8IuoAZUQeAwS8mX9NgNN8hV/O4tI12f?=
 =?us-ascii?Q?K9mJ1D16YhYj1MBa26S/i2/ouJ4J1xBiYXCkxHSSFHMn8hXkFgd5r+earWt3?=
 =?us-ascii?Q?YtJQeMTwTYqzxZuH4oUkNqmuIUEhGOwWVIaI2XvlAUEimbo0sLaDAm5fQxKL?=
 =?us-ascii?Q?5d9aYJGihJSxy8+/piOR3W3rJcZaWJA14mMuDcCc3g2E1dK6Mx7cJDMp+nRy?=
 =?us-ascii?Q?7cH043e8nQ95vrkzROMkITvJwGlXqffi3vQXKz6YX+QxNye1AKeZxh3SCzi7?=
 =?us-ascii?Q?lotaQ0Kr3Jl7rJvwvmSWQ+OFVdHhb2JWRRqBYNPdC1bTDxcyXqbAtKaZRM5A?=
 =?us-ascii?Q?umCEBM58HnCrQEFr5Lp11upJ4kl7yuDItyGqWoJZ//j81U3e38hdRiF+VojZ?=
 =?us-ascii?Q?ApFr59cSPuOu0YOSeYZwFjTTz6KvnY1wkJYb6zlRoYrPUi60gmN4enqZMBy/?=
 =?us-ascii?Q?ND6iEQywLQWZitE2ttaXqazJj/zlvge8TCz9XZsI6AfJsXge+pBk3gzi49ue?=
 =?us-ascii?Q?QGlODCp4One2Dx4Ipr7EY6nnJ16hL8LVmggGC4S26WpSLa/GACoHOiyyB35s?=
 =?us-ascii?Q?CxrfNvaXtR/6IaivqYIOP3GlNDaT226qx4PjA+8AySmwM8Pk32k5QqMrDHRl?=
 =?us-ascii?Q?Zqu5rwKqZZnVAVn5pGYvtzy3b2luGmhZpW7rvQjxyt9E6hgDCfW4aKCUpKk6?=
 =?us-ascii?Q?4z4GJ9jdGWFVM/QSkVw6uORUCgoPfgqXQ1BrvmvpqRxwkfHITGeKygjzdWt+?=
 =?us-ascii?Q?LjsVd432Zt/Nq2F8ilgcvfI5s6ds0MGDOxvPyfaOzeH4Ca2QESQ7HSIBFHIg?=
 =?us-ascii?Q?wtgyY0eLSXhCTYmu6FaL7WRNk68rkq9fXklI10p+YbiGPFcRpIk3r2nepQN0?=
 =?us-ascii?Q?7sOY5p8w8vv2eyr9vs6/FAm6JWEX2oHZsSk+JIBuo8H3TBBH6uAFIU09FVvd?=
 =?us-ascii?Q?JfjHYKY8Hty6UCx1M6UXBBs9LNXqoNeuZC7OlNYtKJO2rePBDNCDUIj28UN1?=
 =?us-ascii?Q?H4qzVrxE/vY9ANCSIAj3t13Pd9A48I/tV5D/SMk9q5iFPu4MNIlP7y6rZtlb?=
 =?us-ascii?Q?aypwhzxuKRosZQDkj6y37MdmLwEaH2tRrSBsr1/Qx39PagMEbsv98afvYXSn?=
 =?us-ascii?Q?rvr8UYMO19thcP+ZQl6N3Vc1Tk0GcoJ5efxhXUYOCDEvreN7L7FFchXcMpX4?=
 =?us-ascii?Q?341LNaU2TElSR46xyDyfDxUDtzA/pTCnmTVHlnTW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b92f94bd-41dd-4e85-b4e7-08db6e7f49b7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 15:35:18.1018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JSPdHUvvGHrEUxXVll62Tw75WpA0xyo6JeOnr3WyxgMrY9NICo0/Kc2e+fNT09AENReaAoZh4Iz50jOhtp1naQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7339
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

