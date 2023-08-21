Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBE6782E16
	for <lists+dmaengine@lfdr.de>; Mon, 21 Aug 2023 18:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236514AbjHUQQv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Aug 2023 12:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236503AbjHUQQt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Aug 2023 12:16:49 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2083.outbound.protection.outlook.com [40.107.7.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9DE100;
        Mon, 21 Aug 2023 09:16:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTnWj89kmbQZOmrnxySXe4XGNZ332xeP63ZV24lEan4Tf9Xnmy5D2C4EQ/P0V2xBW62fzFaRA5R5mmWKeBOGJzOk/RBY0iM3RxhXxPV2DJYjvdFap6WdqwlsKWTkWGC6D3rRRI0ibDbrHGVMClmUnahB2AmA3jmMWCWNdIJIk72Wi0KI1odOMkH95La4hHW8K1Yd+MKMcCNG6gKO5eGKqh50m5cG3tZ4TKCP1NNzA3lu1ceQ+C4i5vU9p9/7lr1sajgIUJFL7bK77jLg+gATNO05ECp1QWtDcyK8RMwbxUpFpztSPS2cy1/Gbnexc7oN3CbWZYcXgIDR0MzeLMTBdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRPIuDooRTbTaTypXEGNysaiq5m1mMvXL38u7iVQGcc=;
 b=TMv0pcifkfx+K1tgqlkDF22ouIS/Fe0Iv/WIJt/yNabL6Meu0p9qYbEoJtMSxKhresUVebYPTofYqGkWWf2eZ9u9imEW8oDK2vywkKe1IdtTRMAWwRPPq09CrtkjXQgWh5tdsMeKsuvwEjKGumiD8khOFUJznO8uIkTK0gqZfaupYb2OUsrcwWav21TloHTmc075ZmdkedHcmM9g/TU7IxRvqbTfXQs5EIViVNk5ifrXyJuIMP7V41fIITD31HhhtFj0rjUIblIrE35+dVkV/0k9x7vCT0mfi4INcWBl7aF/yDV2aVN5WAaGYcHtjQJTX+DPmBsQXTLAxYzmX2+bdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRPIuDooRTbTaTypXEGNysaiq5m1mMvXL38u7iVQGcc=;
 b=KKMeCrBKsVpPLrVKT+dZD/bXMAAnzcIiKxFD/hG22z5BFm3nJXGtJ2koaxf4dZAiYSodzv9p6b96jsGmLb1X8h04grKmEi6deuyjg7f4yEMRilLZK438qMnyZ4zaqA7+hJPCdDsLCsFbOIZbVrs+XzQjoeC+Nc6UV8KBqAimNms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB10042.eurprd04.prod.outlook.com (2603:10a6:20b:67e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 16:16:45 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 16:16:45 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: [PATCH v11 03/12] dmaengine: fsl-edma: transition from bool fields to bitmask flags in drvdata
Date:   Mon, 21 Aug 2023 12:16:08 -0400
Message-Id: <20230821161617.2142561-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821161617.2142561-1-Frank.Li@nxp.com>
References: <20230821161617.2142561-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:a03:74::30) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS5PR04MB10042:EE_
X-MS-Office365-Filtering-Correlation-Id: be4f0770-f8fa-4580-a35a-08dba2620369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pfEztdYF/+YB8FehgRQAAR7HCwBbOgtZiNp51RhMHGTq420psr0D+PBUkXU1e3PJbIsLAYBfuhvyZeNPz3SRoGS6uXd1HfXX4XWVeVQiSdopXM06dTOSBLMhZdr4HaOGQwQWha0Rlip04z18EwTE0XAzcsGNNt5qh2oShStAZZBekz+L0yn+yxlBos7zuUSNaxBwd3TJOF3HUnb3HgzCQH01Op8zGSfN87NI2aGoC/wNqO9oLEpUXGIpSEvdGD476WjZw9Enkf98kQUE5KDgPoG22gRmcqr8I9F48/zEeHoktQPuYAZ/Cd+u4xzL26vzeedm5J9TB1qdo93ZTyIH44Mk2xZN1KwF9J1mjChw7GiSUw1Kcn8O9xmevZr8Pbm1PPpJyoYxkxstY0zlaQZ8erjMTCuhyO1nkGI4pj09tcOr9Aqk/MWNQnc2LjKnIbp24Vtx0AkwspVuue8YpeaTitaRzOaxykTtwDhhitBmIvoTw94wN0JcDRohp9jZJegwnEr41kmceKrQ/dBX9GvZLSDIc62IU3YKmDgqPfDSDxqMxKf/URkV+0nGCOTg1JZ00q3tjNo9go/8InRoSvpKCzV8SABreQEv/hcLpMf0ALEHhP1rst/Y5kFkC7KluJG0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199024)(1800799009)(186009)(2906002)(52116002)(38350700002)(38100700002)(6486002)(6506007)(83380400001)(5660300002)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(316002)(6512007)(66946007)(66556008)(66476007)(478600001)(6666004)(36756003)(41300700001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QePSRMsB0ZtMR/G4CFmbm2xzl3JZ8L6lwGPr88ynRbu3V2Mr9Ukp4g3o5TUj?=
 =?us-ascii?Q?yOfZNCta6NA/K9X3YQZyGoO0d8RhqK3SUnkFbMm6IjsQbnXZLEl+FKU32fWL?=
 =?us-ascii?Q?jlgdVGmIyzeGJ24Ge//rQAf2um3ZXgGamqmHWzkKOoH1+gm0l1/KyhMMVvS4?=
 =?us-ascii?Q?BWGw/VaU7TS9mGHGbG6UQiOFjKXtGyhKqTF9WDvB9++e6XWqRep4vXBnHUeY?=
 =?us-ascii?Q?PaLF8YLJhsBdPMbChPnfKocRFdmc2mcEC99/copSixRsZcz+EvIF3gqu9fMQ?=
 =?us-ascii?Q?CXrp3AxtC735jX1AMkrsah+4jx63mKKsqkHIc2MdjtJlLnVWH+7IDEIkVsDL?=
 =?us-ascii?Q?jIstFyzhEzsIe7TeMK5FkyjQQHpDpKflyKl/oH/E5dGox3JdyYviDnE+kBga?=
 =?us-ascii?Q?j++xIaVa+zSXEmM9z6K06ZOUj/MN41INKjWoDlpVfVjivk+wzFyryvcwcJY0?=
 =?us-ascii?Q?gNpRSHEEXf5Nsnd5EX4YbY6DivCd+xpbDKs0FfdUBQnMCtgeq4w6aOeFW3Uq?=
 =?us-ascii?Q?linNjw3tktNaBCainnmzLbzK5C8n+FJlZDsS/KzGnUJlldVwu7D3gECSSCpR?=
 =?us-ascii?Q?+I58nGCDRND6doV+JWbsG5+AjjEWJnOJOnl/bZCqJzB71mZhU95L2xw7H/3E?=
 =?us-ascii?Q?fw6C5qpHq6ilEqBFsFZRnGwQ5QNv/q/3QYAGvolcF6oHU7L3/9wJ6tN8z7XL?=
 =?us-ascii?Q?DUenYCeK2HITDOUE20HCoJ8tk8Kj7N16oKAybiauVO2FKbaJHY9E+h+UjmtZ?=
 =?us-ascii?Q?uoyHGDEaE44eBAp3HLB+i/2/C3oMiiZiW7ypwppNd+5YwNq8CUkg9jQ5bjeZ?=
 =?us-ascii?Q?XJ20GX0o18eJl63+zK2VMSfpxfG8jH5g7z4RKfXnxhloN/9rbOLLjnCQ5UbK?=
 =?us-ascii?Q?204vlHDKPFB76xMdhVB2PD1rsEyG6uo8ofXEXRBwtpNFYKK16Npc4FYfmQqA?=
 =?us-ascii?Q?Czz/lfzNc5EwZfJslniy4e5YN89RR0r0CHogDoKdmTJbsCH8pQ5mDg9Y1iED?=
 =?us-ascii?Q?hF8hoqygD0JqdlE1OL8VpTlBbZduDD09gkQ+HbYY/ILiKhgkgeM7j1F6vUT+?=
 =?us-ascii?Q?p8OYeKh3LwUOn91ywdJvuXjs0I8IPSWStNWhwCYWRWTplW0xT7ornAY/HnUO?=
 =?us-ascii?Q?b7EH4sBF7QHMwuKrYAG/S3ztGSKoeFEIpjQFeXFZQPhhhkCYyv1zhI5r1kc6?=
 =?us-ascii?Q?eFoZMTXOlW4vhNbqcd+pemTUpliKnrRPkX9c5X6HeuxmeOrv2vWrkeSr7L5a?=
 =?us-ascii?Q?ovEar65O3tXXzsqSG3AVRW6pBb0O52v2y96AZxrDuyPIyfHEx0XOW/kFboDR?=
 =?us-ascii?Q?x9tjaIaNo4uY0avaX6FFXVybBrVIj+WKjqwXCjamAhbhGUyrF0cFtHK85Ztp?=
 =?us-ascii?Q?c9E9nYBy7c0SYL9pxE7lkgikGTOvsGGI2W0ChRakkakroqxDGwiOQDAAUx3H?=
 =?us-ascii?Q?bfHFbPgtStY3dUaY9mpVwgNYHITpwcqTAr+8Fy194NsGXbDOO3UU815MjWyR?=
 =?us-ascii?Q?fvl8L99JpV5WLTIP8h0C2VZcRmQaHeuOmqHufETWBhddqvFCwlkZFrG49qzN?=
 =?us-ascii?Q?AZEyeuVYUWwBhuaE56k=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be4f0770-f8fa-4580-a35a-08dba2620369
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 16:16:45.2296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sBnGPYvQjzWVthdhn2+1IUmctdDjMzViyIog5hq1LfqbQBy67XngTitUrhxXaFasRd5DCJFp7EfBp2TBNBefQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10042
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 89b0d09c13ff..2549a727913f 100644
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
index 8c9ee9fc7240..a318ad6e40c2 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -244,14 +244,14 @@ static struct fsl_edma_drvdata vf610_data = {
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
 
@@ -303,7 +303,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	fsl_edma_setup_regs(fsl_edma);
 	regs = &fsl_edma->regs;
 
-	if (drvdata->has_dmaclk) {
+	if (drvdata->flags & FSL_EDMA_DRV_HAS_DMACLK) {
 		fsl_edma->dmaclk = devm_clk_get(&pdev->dev, "dma");
 		if (IS_ERR(fsl_edma->dmaclk)) {
 			dev_err(&pdev->dev, "Missing DMA block clock.\n");
-- 
2.34.1

