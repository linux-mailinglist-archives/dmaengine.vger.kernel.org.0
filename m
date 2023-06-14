Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B287073085E
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jun 2023 21:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbjFNTgS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jun 2023 15:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236818AbjFNTgO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Jun 2023 15:36:14 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2081.outbound.protection.outlook.com [40.107.7.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C618D2;
        Wed, 14 Jun 2023 12:36:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljd7h9TyKc4MGOKi3vsPrvrNWEi8vLcvyACGesFmdNTo9/odUbu82WLTYOlQta6ZmwU4ATRYDUU7cfMTQVzpMe0S0NSsELv/FMc15jKfBWM7J95Gwk6g1/sEjmgq7740/Kr8MTYkOcsLGf9T2uRlVTF04ZBV7EjMvovPEv61d2QST/ALy2E413lcXhwI7KvbwWUEuvOmXZokSeM/zSMO9zLSgdvLBIoHd9Cl6SkO3m7CwaSvf0powGIK8K2oHTOqFrSjThLbvrduYgYAU3uoeIcJrFOqpFbcBih1ZtEHXyB6P/4FGeRHoxsv7QkSYtOu0zTtOmQ0OoruKRgNGv6AzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtVmb2w/gc4SRB2f37IwBcHKtbBBAdft6k4Ina+w9xI=;
 b=g+IjQdct8nxPMeMC69PqczRREceeYgV2u4+TP8nMQCla0ja6emUt9m3NAk0HIYsONnrVpyKhJ/DiAdmrQZ6VfNuQgIPeCFgfWUmJ2BOK/sELuvBBNW5Cjji2yPzIgUP37wUq8K4ROpnN5w78dtcd3ZUWAD8vbU+Rrahl7jGdqKRbmw7jrgAPTcJEJmbnkTWL0eCwDjLlxnSy5iU89AVIlAr5dTVJMhW6ZoSyBxXsvimrYi0m9JOXC6IoGv5omCTxklBopDgSrhFsfbURRIxM5f/8psclAjTSU09v+nd/eZvRckyihfU0Mk95g3yFsALFsDqUb+7X8ghzYUr+Ij8cEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtVmb2w/gc4SRB2f37IwBcHKtbBBAdft6k4Ina+w9xI=;
 b=jqdNZ7lqx/tTr0HOrHbCCFFUyCEdfoTNxfMBByv7zo6QhmKSLQRE2MuoluHXcMzFadwch1DVK3NZCKIGD/JeX9ecoiD5Ng3wZ2nlBOwSivB7l1OCEYxpolnVr7Nb2qSzwozsXJoyE2mMUmCdqI/lVHPZBbQtkbdBJ5g65J/N8W0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by VI1PR04MB9763.eurprd04.prod.outlook.com (2603:10a6:800:1d3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 19:36:11 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.035; Wed, 14 Jun 2023
 19:36:11 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v6 04/12] dmaengine: fsl-edma: Remove enum edma_version
Date:   Wed, 14 Jun 2023 15:35:36 -0400
Message-Id: <20230614193544.2114603-5-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 75621706-03f8-4398-3e4a-08db6d0e9bac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jzvUBH9GiFmUeUrtR8Tq75WOmQmq5DgngEITGNbyuA/HlP/l7oaGAyNIRuyzBxJYjuBmTvyHUC0hpwYUmgtQxZP8RKEO6SfS0IXgx/aqT9wi8kdQ91eIAsmem8sEM8VT0nk1jZ/dwr2viBH81Ele6LpuEzQB3GWsiRhAFj1vY+j7rtG9FyTSzbF/hsQ6kt8rmfeW/YGgDwvgDLHLR4OHW6aKWwfYgsGgfkUWj1yWh02eT1g/kQbaanXBKYKL9KlE7fGteA53zxM4f2GHz1JWCZOJbWchpXARNDzxoRsQY7rIgONdaQdUo9HX4IV5Xo94+23QNfQ44+G8fxZDn1TsYcVcYLbqm+5EIbH7qoCcJSBwQ6nU05mVg5siL+TLfyxOTLOg3y3jT0+5Un5kR0Dt5QAUCYdRuNeRwiJ4btpax1whgRpXkw6py6g0CXZSeLyhEBAZiR35vbK0co8xaHUXYNSIkoUUhaImTajkuHvPLToPhlVN3wsRus9Agjfo3qB+Ab1FbyPvwK5ax0Il1+uALNw3BaZ3R6v8LjFydUskUrQOVo/NCnjqa7zaA6kvPCcscVUItAIQB7n/cQ14xgIFJWYZt+SPKz3VuksAX/UknGVaeFL/qi79JggW2m8EyKLDV76phRU9+cAuihY5yROwD8N4c9NdpHgQcwhaZO5Vd2w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199021)(5660300002)(6486002)(8676002)(52116002)(41300700001)(6666004)(8936002)(66556008)(66476007)(316002)(2906002)(186003)(478600001)(66946007)(83380400001)(38100700002)(38350700002)(921005)(86362001)(36756003)(26005)(6512007)(1076003)(6506007)(2616005)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kypQp/otbrD6Hhk2WfrP1EDFr0XDNuFONb1HwTIp7Muv2me5WVaH7hw1a8nM?=
 =?us-ascii?Q?Pgorc3ZdSxZkYCqk0aTkeCERGIxzeSLUMYMDlm/M9OnMK5vIK3d9XonF3n6l?=
 =?us-ascii?Q?EHowWmIJhH6K+udzKuooEi3FRrHJiLF8AsXO1FiBS2li8T80X77uYMNauhK7?=
 =?us-ascii?Q?O1aYt1PlTsndw9oNHnzGv3oEssurWU1f35fF3IZ1Z7w1HA0Dh6IlzTPF5rsR?=
 =?us-ascii?Q?zTwxuyCgx24tH2H/vecAkpyhYbD7yq7hL03XP2Ph79VfYbyE2jH74brv3HEU?=
 =?us-ascii?Q?4RCYnzQn8rK0vt9vUMOZSNBWbHl9nu+EmRrr29YYGfGdABMj3uCD4ksSu3zP?=
 =?us-ascii?Q?8AzhNShQE10bBZ/vq2m+1U8pWiJVyD8Dzl2w2jvb6LNG+HLU+bx6+sJlbJ89?=
 =?us-ascii?Q?DDBiyqHObk0iipiDRi+bj4X+GDG8sYuhMqiYm5QmbV6xgK/EeEFAX6wxzsBH?=
 =?us-ascii?Q?xsB6eukFAFTU0Gz6tjHKQCYyr02d/91940kTiHqGwDVuGBGRifroML0uHcHJ?=
 =?us-ascii?Q?5V5jUg1KUb/cioLh7D9zZEHPzNLStfcLAzcdElWPaC85uKYrn55C2nPG8fa0?=
 =?us-ascii?Q?pVOnlI4YZiFjuoyWNRaJrU0OXThCMV+y+uJmvvMFZr1ZNT51qqxK635BTRlF?=
 =?us-ascii?Q?ulAt3KLJvhJxRqVG4bW9Q09GcVq56Xu+wDruu+0Sp+VgR8wMAoJt6IEduZqc?=
 =?us-ascii?Q?Tq7k1soLkW/7M28UuNSLV5Y9Rg1cdPoX3o/mTig5QJSKDCFN8puRcLXWV9ue?=
 =?us-ascii?Q?YCgZoyAjBDE5hmqh+OAo5Slto0hx473X2Vdu3lPwajJaNRJ2zrVROzM97BGg?=
 =?us-ascii?Q?eYWGn73tqI39fiy0bKfnG52CPPTu/I4aRtscrh4X9QTC0Svpx1GtcOjF/Rqy?=
 =?us-ascii?Q?r+oCxu+sXnB0S5tltS4kKLFj/0ip2dJjT+dMARBQH7g8GUJS5+8gveRXgYAj?=
 =?us-ascii?Q?is4EbHzUT7/a/8B1dYunO+0/TkN3wRvZCzj+d6/2lWS/g2M6bf+OVzCohOVv?=
 =?us-ascii?Q?4c4U6PyBqdwqCCR5xnMdVuUBLlvYI0Dt42pG3Tp0dlf1L/epTFkr4JeUBuuY?=
 =?us-ascii?Q?oeeR/mGl/zdnZeDUxsxZ8ThdiMvhtC4fYBiASXaAkPbtRfzjIuR4JuzkosFG?=
 =?us-ascii?Q?e1V/KsLGfwXqWkQlfxx8ELCISyafLVQvo27B+H2jIVoS6PaqXXfZJCXkUX2Y?=
 =?us-ascii?Q?iDeOy9jQSSlp9eIh5dMfJVliIcyJ/J3gXO1TIPLCQXRIPh2Swua+XMXjcP5Y?=
 =?us-ascii?Q?YJodS2V6KQcAbBdiK5XGwUWz69+K2mWhJnxXKx/NoHLDwjD1Xv9cNp9ufuxz?=
 =?us-ascii?Q?dqcc+Op1eTiBlrQhLkmX2M++1syGjHaPX8rST82UikxSQo4o5FqrJAeb9KpD?=
 =?us-ascii?Q?lQ+/W/mQt+jMuFy2ioAieF/uMjoiIDlxtDl0oquhEysMEjc9G99S9SXKEseL?=
 =?us-ascii?Q?1a7DyEdL6lXPxHu6PXpPxw5Pued3Peel3X3GwlAuRTd2GvFcemoC1VtsgxQW?=
 =?us-ascii?Q?gvqXhIOM87d7LZ8AWzkz1IMZCmGcEDXO0liXbEYh1R35NVvR3IaENy5aaKK0?=
 =?us-ascii?Q?XnzdWNc70AiD/SiM+PAj+OvpcRXp8Zt3M1MxY565?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75621706-03f8-4398-3e4a-08db6d0e9bac
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 19:36:11.3204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FBAaRiaOWhJJ+/FCi36Q7//gNJQew4U3RxHAvRSOrwOle1rLPRwv+w3iIpVe6/mQ9S1EF2zC7ows4BGNbtcPLg==
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

The enum edma_version, which defines v1, v2, and v3, is a software concept
used to distinguish IP differences. However, it is not aligned with the
chip reference manual. According to the 7ulp reference manual, it should
be edma2. In the future, there will be edma3, edma4, and edma5, which
could cause confusion. To avoid this confusion, remove the edma_version
and instead use drvdata->flags to distinguish the IP difference.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 47 ++++++++++++++---------------------
 drivers/dma/fsl-edma-common.h | 10 +++-----
 drivers/dma/fsl-edma-main.c   |  8 +++---
 drivers/dma/mcf-edma-main.c   |  2 +-
 4 files changed, 26 insertions(+), 41 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 10dcc1435d37..9948babcadf6 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -47,7 +47,7 @@ static void fsl_edma_enable_request(struct fsl_edma_chan *fsl_chan)
 	struct edma_regs *regs = &fsl_chan->edma->regs;
 	u32 ch = fsl_chan->vchan.chan.chan_id;
 
-	if (fsl_chan->edma->drvdata->version == v1) {
+	if (fsl_chan->edma->drvdata->flags & FSL_EDMA_DRV_WRAP_IO) {
 		edma_writeb(fsl_chan->edma, EDMA_SEEI_SEEI(ch), regs->seei);
 		edma_writeb(fsl_chan->edma, ch, regs->serq);
 	} else {
@@ -64,7 +64,7 @@ void fsl_edma_disable_request(struct fsl_edma_chan *fsl_chan)
 	struct edma_regs *regs = &fsl_chan->edma->regs;
 	u32 ch = fsl_chan->vchan.chan.chan_id;
 
-	if (fsl_chan->edma->drvdata->version == v1) {
+	if (fsl_chan->edma->drvdata->flags & FSL_EDMA_DRV_WRAP_IO) {
 		edma_writeb(fsl_chan->edma, ch, regs->cerq);
 		edma_writeb(fsl_chan->edma, EDMA_CEEI_CEEI(ch), regs->ceei);
 	} else {
@@ -120,7 +120,7 @@ void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
 	muxaddr = fsl_chan->edma->muxbase[ch / chans_per_mux];
 	slot = EDMAMUX_CHCFG_SOURCE(slot);
 
-	if (fsl_chan->edma->drvdata->version == v3)
+	if (fsl_chan->edma->drvdata->flags & FSL_EDMA_DRV_CONFIG32)
 		mux_configure32(fsl_chan, muxaddr, ch_off, slot, enable);
 	else
 		mux_configure8(fsl_chan, muxaddr, ch_off, slot, enable);
@@ -682,9 +682,8 @@ void fsl_edma_cleanup_vchan(struct dma_device *dmadev)
 }
 
 /*
- * On the 32 channels Vybrid/mpc577x edma version (here called "v1"),
- * register offsets are different compared to ColdFire mcf5441x 64 channels
- * edma (here called "v2").
+ * On the 32 channels Vybrid/mpc577x edma version, register offsets are
+ * different compared to ColdFire mcf5441x 64 channels edma.
  *
  * This function sets up register offsets as per proper declared version
  * so must be called in xxx_edma_probe() just after setting the
@@ -692,33 +691,25 @@ void fsl_edma_cleanup_vchan(struct dma_device *dmadev)
  */
 void fsl_edma_setup_regs(struct fsl_edma_engine *edma)
 {
+	bool is64 = !!(edma->drvdata->flags & FSL_EDMA_DRV_EDMA64);
+
 	edma->regs.cr = edma->membase + EDMA_CR;
 	edma->regs.es = edma->membase + EDMA_ES;
 	edma->regs.erql = edma->membase + EDMA_ERQ;
 	edma->regs.eeil = edma->membase + EDMA_EEI;
 
-	edma->regs.serq = edma->membase + ((edma->drvdata->version == v2) ?
-			EDMA64_SERQ : EDMA_SERQ);
-	edma->regs.cerq = edma->membase + ((edma->drvdata->version == v2) ?
-			EDMA64_CERQ : EDMA_CERQ);
-	edma->regs.seei = edma->membase + ((edma->drvdata->version == v2) ?
-			EDMA64_SEEI : EDMA_SEEI);
-	edma->regs.ceei = edma->membase + ((edma->drvdata->version == v2) ?
-			EDMA64_CEEI : EDMA_CEEI);
-	edma->regs.cint = edma->membase + ((edma->drvdata->version == v2) ?
-			EDMA64_CINT : EDMA_CINT);
-	edma->regs.cerr = edma->membase + ((edma->drvdata->version == v2) ?
-			EDMA64_CERR : EDMA_CERR);
-	edma->regs.ssrt = edma->membase + ((edma->drvdata->version == v2) ?
-			EDMA64_SSRT : EDMA_SSRT);
-	edma->regs.cdne = edma->membase + ((edma->drvdata->version == v2) ?
-			EDMA64_CDNE : EDMA_CDNE);
-	edma->regs.intl = edma->membase + ((edma->drvdata->version == v2) ?
-			EDMA64_INTL : EDMA_INTR);
-	edma->regs.errl = edma->membase + ((edma->drvdata->version == v2) ?
-			EDMA64_ERRL : EDMA_ERR);
-
-	if (edma->drvdata->version == v2) {
+	edma->regs.serq = edma->membase + (is64 ? EDMA64_SERQ : EDMA_SERQ);
+	edma->regs.cerq = edma->membase + (is64 ? EDMA64_CERQ : EDMA_CERQ);
+	edma->regs.seei = edma->membase + (is64 ? EDMA64_SEEI : EDMA_SEEI);
+	edma->regs.ceei = edma->membase + (is64 ? EDMA64_CEEI : EDMA_CEEI);
+	edma->regs.cint = edma->membase + (is64 ? EDMA64_CINT : EDMA_CINT);
+	edma->regs.cerr = edma->membase + (is64 ? EDMA64_CERR : EDMA_CERR);
+	edma->regs.ssrt = edma->membase + (is64 ? EDMA64_SSRT : EDMA_SSRT);
+	edma->regs.cdne = edma->membase + (is64 ? EDMA64_CDNE : EDMA_CDNE);
+	edma->regs.intl = edma->membase + (is64 ? EDMA64_INTL : EDMA_INTR);
+	edma->regs.errl = edma->membase + (is64 ? EDMA64_ERRL : EDMA_ERR);
+
+	if (is64) {
 		edma->regs.erqh = edma->membase + EDMA64_ERQH;
 		edma->regs.eeih = edma->membase + EDMA64_EEIH;
 		edma->regs.errh = edma->membase + EDMA64_ERRH;
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index db137a8c558d..5f3fcb991b5e 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -138,16 +138,12 @@ struct fsl_edma_desc {
 	struct fsl_edma_sw_tcd		tcd[];
 };
 
-enum edma_version {
-	v1, /* 32ch, Vybrid, mpc57x, etc */
-	v2, /* 64ch Coldfire */
-	v3, /* 32ch, i.mx7ulp */
-};
-
 #define FSL_EDMA_DRV_HAS_DMACLK		BIT(0)
 #define FSL_EDMA_DRV_MUX_SWAP		BIT(1)
+#define FSL_EDMA_DRV_CONFIG32		BIT(2)
+#define FSL_EDMA_DRV_WRAP_IO		BIT(3)
+#define FSL_EDMA_DRV_EDMA64		BIT(4)
 struct fsl_edma_drvdata {
-	enum edma_version	version;
 	u32			dmamuxs;
 	u32			flags;
 	int			(*setup_irq)(struct platform_device *pdev,
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index f5cf95d185f8..47bfef1c562c 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -225,22 +225,20 @@ static void fsl_disable_clocks(struct fsl_edma_engine *fsl_edma, int nr_clocks)
 }
 
 static struct fsl_edma_drvdata vf610_data = {
-	.version = v1,
 	.dmamuxs = DMAMUX_NR,
+	.flags = FSL_EDMA_DRV_WRAP_IO,
 	.setup_irq = fsl_edma_irq_init,
 };
 
 static struct fsl_edma_drvdata ls1028a_data = {
-	.version = v1,
 	.dmamuxs = DMAMUX_NR,
-	.flags = FSL_EDMA_DRV_MUX_SWAP,
+	.flags = FSL_EDMA_DRV_MUX_SWAP | FSL_EDMA_DRV_WRAP_IO,
 	.setup_irq = fsl_edma_irq_init,
 };
 
 static struct fsl_edma_drvdata imx7ulp_data = {
-	.version = v3,
 	.dmamuxs = 1,
-	.flags = FSL_EDMA_DRV_HAS_DMACLK,
+	.flags = FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_CONFIG32,
 	.setup_irq = fsl_edma2_irq_init,
 };
 
diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
index ebd8733f72ad..7b05e303ba51 100644
--- a/drivers/dma/mcf-edma-main.c
+++ b/drivers/dma/mcf-edma-main.c
@@ -172,7 +172,7 @@ static void mcf_edma_irq_free(struct platform_device *pdev,
 }
 
 static struct fsl_edma_drvdata mcf_data = {
-	.version = v2,
+	.flags = FSL_EDMA_DRV_EDMA64,
 	.setup_irq = mcf_edma_irq_init,
 };
 
-- 
2.34.1

