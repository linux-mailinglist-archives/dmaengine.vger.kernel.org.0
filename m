Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFBD712895
	for <lists+dmaengine@lfdr.de>; Fri, 26 May 2023 16:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243917AbjEZOiu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 May 2023 10:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243899AbjEZOis (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 May 2023 10:38:48 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2053.outbound.protection.outlook.com [40.107.104.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7A3E57;
        Fri, 26 May 2023 07:38:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nb98wC1cpiaPbA3q6A+fXbFiZVoe9hu95Z/hdTgzQHlwfb1xVpYYwUYWAh66FWCxiB62AMvTMQ3NOeAtnNprR+3gaNHYBi2v6JlaaZKYuEZIOoVlon5pCq+xD7/M5YnniWAq7kgf731JmmES/Q3KMRbFYiWux0gusZXZtbdmq0xjFbaLK5/USADofnp4f7wY8xWCgKadX/3gR0J7vb+YyrZmGu9nEMCsYRBxAlGUtpP4eS4V4rvyBJN4jVRk2rKRM2d75nJ5Ol2jkxOIuZxT0w2OrADm33LW/DLzcxEyTKWkEbsu/FUjEV7TPplmCmMzUUKNBQ392p6+P/MrhMw1pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5IwFxfjsLIuwWG9lLuAPQ9Ft0G9NDt16kTGP8ogl6Y=;
 b=b2y9kgz/dtHx6Ed/xiG46zAN/qy0dVxKh22hjzm6E2L9HY4vBn/F1FRiXGWNkS1dq4KjycFUvCk42eFAQL3dfa1v/cjxOVX4DSHdcBM3qU8kj9q92lGTaiMgT8ijJ/jA0xxvvw7qoEtYH0ZAAux60KToTxFE2wUv66BTl5+aRxM/5QCZBk192YVm+PJAvvueaN8CiEj0s7uuZrqT7lAmcDokkv9kMqcf4BdqtghOaheqp14lWRdu847GEX5imbEqAQUQ/DrW6GdXbrLy4zWYlu3L9CJWWGDnT7C2s7IlzwLT8LSCoGb3bx1GX1rUuUcamCgQYMDtRhjZC42tmsB9ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5IwFxfjsLIuwWG9lLuAPQ9Ft0G9NDt16kTGP8ogl6Y=;
 b=R89xnde8W3jRRXlySpSZGM+Iuc2PXilQm3g+dfZPc/Lj0AUkc/OfpoxECcTEF4cTTA3NK3mVgLUskMJZFdsWzV5ekLfbEZRXHEzSJFiQgZD/UyKldeASARimvmYZmp1PJEcSmmaTleC8C38YV6pPafLG+TbrZmTTcwWhtkyNiRI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8070.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Fri, 26 May
 2023 14:37:06 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6411.028; Fri, 26 May 2023
 14:37:06 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v1 03/12] dmaengine: fsl-edma: transition from bool fields to bitmask flags in drvdata
Date:   Fri, 26 May 2023 10:36:30 -0400
Message-Id: <20230526143639.1037099-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230526143639.1037099-1-Frank.Li@nxp.com>
References: <20230526143639.1037099-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0212.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::7) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: c0cf8376-3651-4951-6187-08db5df6ad8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h4djMMuSHXhjuB9qAWADuofkHpFZkZICBk9JeSD0NraRqk2a0xaJJXqlIsOsVR+FDIeQ8DNLSKzXtXx0q82d2edif0bmRrGaLENnkl9j41Qji/hf7QtiFIu2CO6YMVUFIHQKOt75mM+8u6wOIocz/GodMPojEcilsrs858ORFxbxDPK32V/V42tEwb+r6bBveq+hPsrlZcItDTg23wYASYP9UWqirrp4fTcK7xZpytChR+N3OBwa+k25bGmv4lIPakrOQ3xq54sYV8SR2LehRWx3AguhSAyRog64Fl1UVGTjvSxQSBIJHlhyRT6LsdQWjLrFmEOxvl5W0PZDfmk+J6hdgHMlDYknNZ5NoceB/4GwJRGJP1lBpzwHmN4TmDs5hTfoJnpAhwiIBTxG8nKsc9o8zIWKv92Z3Ts70AhAelH6EvsxxyrUfIxA49uoQkpmNh4eQqoTSS+0sGaP2hckOsJ6hoEDFQvIrlNOjXL7F/nWpcrFiKiwxqYZvG+ceke2IWzhHQjIMKBYKlEVBlxlvfzM8pOrnIN1eNbxmr+OjO2LoSHWh0dQ5lWXxBgBbXZ8tW8nT/NG8E3LFvhPlzFc1n+tusKsnIpy9NR/HlrCfVfcsaTtvEmvHZpnERsXRAcIe5c3uyhJ+IYs6RSIJQXF1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199021)(38350700002)(38100700002)(8936002)(8676002)(5660300002)(478600001)(6486002)(316002)(6666004)(52116002)(41300700001)(921005)(66946007)(66556008)(66476007)(36756003)(2616005)(86362001)(186003)(2906002)(83380400001)(6506007)(6512007)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3fDbgYPooDfSVvV/HHQbi8610qK1rotvFmfeJxRg3xxfK9+MPhLjXmB0/1GW?=
 =?us-ascii?Q?Tk3k0KMTW2Wfs4UtODCUHIDMNsJlAdHCUVQ5N7EcL/gSQG3OUfxe8lYkT2+P?=
 =?us-ascii?Q?YMamQfFYCYZ+ffhViycmLEqhueltMNMtWa1Pm9IM4UzVt4L+Q3m4yTyaG6c8?=
 =?us-ascii?Q?A70llvOFuWCD3EzANyCQcNE3VgbM8Q3EoEMi4QTliH2/6HJlwPaj+gWjVI2O?=
 =?us-ascii?Q?NpvsBksZPh7ZXkSJW48hdB527SykXqNa7o3F0EvRh9Yehv+ChsTM86Q89lyu?=
 =?us-ascii?Q?aV5vaYGEZPlp3aHHjGNbKh7A4CVt9vL6pPjZj0ibkeyO1DwlASqE3vBpTedF?=
 =?us-ascii?Q?H0l7jriwMzXPxxzi7wbmb1cwDa8gmqkPODek9A4tID2zMoT+b8cfcp2Kunqw?=
 =?us-ascii?Q?XCsyP0JJ3E5i9ffr0GUgS2rrKZIuDao4iFmbVKnF1Us5LF9a9yhreizAAyx7?=
 =?us-ascii?Q?zieH7qAhxhjGL3fFK5zXZdHjiY7JbN6wajnn1ze85dl3n2tutxxgF4tUEV9m?=
 =?us-ascii?Q?42hjvcB7ydIs9xuXkfciU0aTUXH5YrN0LxgwjuNgNOyqtcwCjhZ7X58cQOYA?=
 =?us-ascii?Q?IIq8XyYVXGctsrg86u5dPOcP7UDFAJVk8FVV+BwfFVOFid2FewQxzFTI7CBe?=
 =?us-ascii?Q?ckM4MEOd8HaoCc0UXjKBM+iPIX2SgnQhPAK7DarHD86MDaA5BD7ivEOiN9hm?=
 =?us-ascii?Q?RHFTU3Uw5E09TOxhO0RGbAiMletT2yjXL5r0eokFNPOmBNMCsDg+RSlRfi11?=
 =?us-ascii?Q?UmrXOis4LB8Vj6QS15Ztm1vQGpTDZ+VZzsBGf8vPBP5UxwsZW5y1TbRvKxOc?=
 =?us-ascii?Q?giJjdx5KrBfvy1zDJgJBCZSZ9T6BeKyfGkZAV1r7C20rfKNMKZohbvStn5Fl?=
 =?us-ascii?Q?lsBMP06XxNX3FNbu6TD+aIkQUPvAInrpCBTpLLLGd0J1QASVrcFcD9CgtCSk?=
 =?us-ascii?Q?rtK3+cu8AejAWu99WfrH1ImRUfnOATSPkajzkEqRI21O6LFoHBY+KJ57EKaB?=
 =?us-ascii?Q?74mXJTB9/kV7fLcG1HYTMFes+ASQWdg5pNb3G285hSvOoFqCqGDwp0bWtNtt?=
 =?us-ascii?Q?K6VxSHvtHCDjaVENWALcZA/SiWqjQ6IE6xfu9xa32NueZvUM8zAlw2pz7BEW?=
 =?us-ascii?Q?+gjL5xtJFVpUeRYyBrlGqVIzdeJI0FLdNdhfy2osnujPXIMQAH+QRe5vPwtP?=
 =?us-ascii?Q?FJBwS0y2CEr/O/z1fw7How2lUq3pB6GnnkZteHcBlUZrcevCdwzOFCpYhaqH?=
 =?us-ascii?Q?Kb8ULx8NfNHX9xgUwFVf/aup7EWXVQ+7hr+hlcjzWwzrStO1wgOzxKxfCj8g?=
 =?us-ascii?Q?wVGplNXSxEblzC0AumYmF9WTtPjSw5TRd4V96ktCB0jf8hiHyPYVOM84C1lE?=
 =?us-ascii?Q?5oUONY6HrqkwIon2mXhOvTruw2A+tmSYpmp1mi7K3/nKD+FoS/PzoxXNJMLg?=
 =?us-ascii?Q?HRqfIt0X2gQhrJUvGn9ZHR+ySAJ3eN1kfgPuB7Z52bC/b1ln18Pow4I8XZ6d?=
 =?us-ascii?Q?ryTLHkY5WuqBscNf70L98mdamBYefQ8z6E8rh/v8dYdU4xZi+OOsybvUszKS?=
 =?us-ascii?Q?nNragHQvhb+wHFUlzii8pmh/fEO9KqnKXWqMVvd+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0cf8376-3651-4951-6187-08db5df6ad8a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 14:37:05.9833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MHNmZB721+DYHJPp+bMK0vMJYv+mi0JEfctImcFwogiHvWLFS+POgAY7jFUfp6Jcl0Pxr28tTUeHvkf5Tw2vzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8070
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

