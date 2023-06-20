Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB237375D0
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jun 2023 22:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjFTUNg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Jun 2023 16:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjFTUND (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 20 Jun 2023 16:13:03 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2045.outbound.protection.outlook.com [40.107.6.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C27B19B2;
        Tue, 20 Jun 2023 13:12:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQnAmdkPBiwl9eBgju5XXL/XKVnjgeYrd+q0Em1vc0m7f22KCnvvTgf9ASYBh4lB6+Z4t8fRm9Xlno4lk4nIXCpLZ49us2M4XgUoIsV7JnYAfFKv0EXUxX4kJ6QxCpKgqg9l7l1hT8pFXxxia0/l/ZtV1rvoDODth9AGIdTRGhy9uA11domaIMSIFZ6UiwU6MBUF+mGvDgPD7rnNb0vF46if+NwfCDsvhdAlXr+cPLNbm+wCN5uskdAPY2SFS+bD1biVUVaeRGUyZrzeBEhcIK6psgVPNM8ZorTIGIo3h6QLEqcyzXd2BDJA7KaB15hhofpeXlPhusIS0gCdsQvrJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtVmb2w/gc4SRB2f37IwBcHKtbBBAdft6k4Ina+w9xI=;
 b=npvlVuE0t21KGizOZ1v2RLAX1vb8sY1F9DIJ9RG7aA/bhxMbGKx2v2Bz86XfMA5Msp4yZwyFYc3Sda3azAvSsXuncNlFp0d34SCQA+UiPJhBjvOayh64y8sITJidwHQE1FTr7NjJILIiUDvuIAWrJj5UkeqgutOYt8vP0zWYCo09r2WPsZPptVF0IjdCCdy3kExajUGn83HBbqPj2AzhDYHTecwJzX1Tsh9e3StjgvFL2gU1LSWCW8syrZaOuvYZsZ9yOs7djRrbW73JQUqifjrOtcmMLj0zKIlSWEkp6qO7OSaOMWFwaZavSkDmJpoHKwkTcslANmulMkLwBJ25TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtVmb2w/gc4SRB2f37IwBcHKtbBBAdft6k4Ina+w9xI=;
 b=YlP+dS9ON4dwxUnqowDyXKDDPm5F0/UpVhjns+prpdkqwJ/SpwqewnnSszU7+wEPP6lpVP4W02XHz6f1vVU4VS2blu/wIwwhWsSHLGHcFSDGZyjDcn6AoTsVlvSBv+CZlzbA4gAvXiMVVzrzt4KpFlV39YH3JENTxUrNQ3e3PXw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB8903.eurprd04.prod.outlook.com (2603:10a6:10:2e2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 20:12:51 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 20:12:51 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v9 05/13] dmaengine: fsl-edma: Remove enum edma_version
Date:   Tue, 20 Jun 2023 16:12:13 -0400
Message-Id: <20230620201221.2580428-6-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 77ae3abb-3004-4a1e-546f-08db71cab964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qhNbVE0oDsVguqaP6xvtrEpQNteteW7H43ZNOKkEka5sP2FrstSpoAk30jWnGcmMzSCov3kdPb7F5FbfHDI1TJX2y8/8Fkkq+giJANiuRqb2sAuD0QCSfp2JgIy9UCRMNpoWjo6N8X7UN11UQKYtJWC3xIxtoyPSMkNzWD2yWY0ljkTaajvbnq3O8udE4GO4fr3hZk3FFvoxVOAMCpQpqJJgb7bvCHEdCoXEG5g8fctzFzjyqibJAft0RwNk2FGoVMCdJ2cCLmSETsRGBfC7yUFmi7Wd+g2/z5RVWnri5Lg4jlbCDVhdmwieD30F+uKQQ4xJUOdigR1mMoREDK8lozmlt2cSJ0YwkPjVyddBQG4EP/GKMRkFiL4vgDUey63lJvaTk+Zs19hWlmLWCouZFteD2mbuF5ME1vAHOkm0Qu+t6xNeMlYRS/RVqvPzzbGuKMbwW0BwEAZeTyfk6EsRHaAK0Iz+ScvgR4+MTesOEILRJA57MBY7/BNgswbRAV5BHgXG2lyMEMXLL1bAox7w47n+eKrcJqs2lQyQZ6yWSdRChs4k/5kxZLXU0LpaOZZ8tdp7a3VM5nMszxFzjplKwNCqJcfdqkTxtc9maIP7mCw3s3SbABpLmBS+Q1ZtZgTOVaUsdEKpITrRr8nBULfrZOkeevvumZQkCkC822dX00Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(451199021)(83380400001)(66556008)(316002)(41300700001)(66946007)(66476007)(36756003)(1076003)(6506007)(2906002)(8676002)(8936002)(5660300002)(86362001)(38100700002)(38350700002)(921005)(2616005)(6666004)(478600001)(6512007)(26005)(186003)(52116002)(6486002)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4CPMEJaeJzRzlhOVORV+hIJGsWsvRT6aUbzlVCHoT3HjlMUEjtGKwTHKrIR+?=
 =?us-ascii?Q?Zks7UKtPaBe9/jCn0bqCfCi+GRUqhfsJ8AHu8EZtOIqAEaqyKMHydD73NU6X?=
 =?us-ascii?Q?C7ezP8XXgnQubvySr96e67c2+OYCoSpS+moAMkSrejEZFg8Qg/BrFN7LJ+eW?=
 =?us-ascii?Q?bny/Lv1Wrew3yJ0aUpxmyRuQy1wAKXL0KrDsUL1p/ocRWmel8lTA3lxN46xP?=
 =?us-ascii?Q?xhAmpTPKdtG+//5HQt8DohbBBe5iWqTZlUuvSE79WoxoyiNATGy0r/HrDMK3?=
 =?us-ascii?Q?rH1oyOnv5zalKYKeD0cr5eki5jvPuUh28EMcAgdXQqVqvB2ZQ6rNnDjuUc69?=
 =?us-ascii?Q?tG0GXJNbBCDSpcq+k8SPcmfdBvHh13K6nQm34pj9eP4NKlAP9ooPIwH1Ddny?=
 =?us-ascii?Q?D/nmiegKna02a0yi/Hou7K/ePM2pZ+KSC98KXIw9olbVHeZht5RnzjfgJUIr?=
 =?us-ascii?Q?c/nHDMm9Vq/QzmCTNycXhz+8PhPfQTY4YuO2Kqx2a6xeNqY59VESK9RQQ9wK?=
 =?us-ascii?Q?pLKLvMvhEE0p7PHPW9ZuqNnRmy8zglQdeO8wnwmp+vgBETm2xqqFTbJ2HahG?=
 =?us-ascii?Q?sgpgIOmG3xoMIiGdYPQnmNpL7/8BuViBtb6pHCByCaW2UxyMKrtFFxIoQFH2?=
 =?us-ascii?Q?d+GB08yato7XVQ+x7pa3zDrW0ElHUbtxuBOWvtUTEehgDdp/13S9XKk0jYw8?=
 =?us-ascii?Q?KdaSOtZlztU8W4FXuyginO5SnmwHtEgATR5X4TY1wxpnr62mcw8X1tINU5HB?=
 =?us-ascii?Q?8rsR0OOBzeed9lz6KituOJwkIP7cXSsjrtjFJ0uSGWtVk9T9msVbXonGH8AS?=
 =?us-ascii?Q?9T7kFULf0Z0SuA4Uw1h8KbLIacLg5JldhgQkb+iIqUxtdGKqWXq/QqqHVkFp?=
 =?us-ascii?Q?85xWrGLkETve+zLBmMHmPaMR/FcE37KyK5xvP99Lg8C63QEqQa6pDC7Grb2X?=
 =?us-ascii?Q?+tlanAB32NTDro6vme50Mq3Ho7ZcuSTURQ968Qg1vLwS+ITBo2ZZtyUnzqnY?=
 =?us-ascii?Q?vExrIt9d754sy86oS9ogDmrcNLoTtbHUABxHCS5HCKcMBSuDGdkcP94gEvks?=
 =?us-ascii?Q?KN5wX7YQyDhguBfIACFIM6xEuruLiBVGm9RtQB6FpbXvZdeVUwLAVOO40/m5?=
 =?us-ascii?Q?FDfzzDA7Ij0/88zpVx44r2J75edNHH0/GswI7DwCc4ntjuoAGeUJpuSftU0e?=
 =?us-ascii?Q?hDcpezlbNwhEU4NQvmHce8QgirxSJxdXHpfrQkBwivfJCz4ByMnOvaR9Edb8?=
 =?us-ascii?Q?97bOjR2JE55u5Uin9ebpWLRoRJ96xcSELpHH9ItOL0jkrCd/iC+DWJ2rXXGv?=
 =?us-ascii?Q?RNT75GZxJXDkOpe+xz1LHmxiR5wko+l9rjOAmQZe55ZnJwo6iWhW7YEidEBT?=
 =?us-ascii?Q?JoA6jUBVuvzmwQvkYa17/zMejopbZSHO9k6L1ng478KC1/e+RQN+H7ITpe5u?=
 =?us-ascii?Q?FHqEtTYtTNTwr0m11QSP30WXrKyPUNY9XO4zkQHybsEnwo9OZAv5I5SDGTBN?=
 =?us-ascii?Q?TEZYRDHf+YLnIub0E+qSxRzHm7/Tq40pPRo4g8yn9D4Fr3UGE/mP8DXrB65u?=
 =?us-ascii?Q?3R/YV7wktqHjgGgyzAlNCsKLTan0fsfdnWE7k4V1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ae3abb-3004-4a1e-546f-08db71cab964
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 20:12:51.2430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLfRWuZ1o1i5UcoyLjlNmM8/YKFqDAmeUH7JAVZb7dDO837KIHb4tkeGOG1wvYwVC9n2oIpiluEMhT0SJNlgpQ==
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

