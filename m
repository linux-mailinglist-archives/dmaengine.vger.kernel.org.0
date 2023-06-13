Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876DC72EDF6
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jun 2023 23:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240572AbjFMVce (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jun 2023 17:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjFMVcZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Jun 2023 17:32:25 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD091BF0;
        Tue, 13 Jun 2023 14:32:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ve5jmmCBGWurYfsXRJjxTBQ+ANsObAcJWhOMBKMgRbe4EnSxTArpr/F7Hs2xUpOAAH5ZMGaiNBE5lls2K2P25C7eB6Oyuiwz0MTHNiT5gtON0ckOs1jva3Hzwql/JlZRqtWQmQPCrYbKTb1U3zT/C057b8myBX7hY7qrYfwuPpGAelsOSXszu2iB7y02M57c1N8w7t5rQx6U/l2NaGsmEWyaCPYqwgTce2cenaYrrN1j8fxzs978mMUHqQ6Vox5tuz3TFQN/l0+UrkrWuWIW4r1Pgf14QuEr3S3TWIE9+B7AwJ5Op4L8YHfoQ6RmAWz3YVEhCQahGpKvyq9b+99O2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtVmb2w/gc4SRB2f37IwBcHKtbBBAdft6k4Ina+w9xI=;
 b=iRFytWhk0yfMc+ZokDkZfzQgwyQgqaR9boH1kYEDV5x2lU2W6DZynmfAVvLpCDIDaesLD+8GsNUED5CkMHwCDqgPKU+C1h0ssEk+ceyCRQQwEKFr9Kv3TOhh4XVCBuDsya+Vbl9DPY8UpwccCRK1Qzg57AjV1kh3ASWtRjXck79mtuP0eWt3q9czIbtTk8QPJBCe7RLz5Ld2k3yXyQhAydl81XItqfwZWV3XByl9fQn22BAt7zmcPlPS9pRkNzK3IkTXtHliPsxJwiOpCtf+ppJQPeSN9WSD0fI79qyeHjnXwdKk0+ttRcLgdVBZS+nyvISMbAVXyUl8Rx5J+a5v8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtVmb2w/gc4SRB2f37IwBcHKtbBBAdft6k4Ina+w9xI=;
 b=AT/zg1mWr3waX/rRdNlQ/43VVuU/0QvusWKA8oxx57RdD6xtdpgD5RbBi0LPMnaTTOx2/EUeJiD26JUtHUMVNx1/OibFA7RCW1j3Zwlbrk+N30S986KK4dNPognXO27f4FPGTJpS3jSi/sdMEtYzW+wnsVH56mHMrjKMoPtc3ys=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS1PR04MB9479.eurprd04.prod.outlook.com (2603:10a6:20b:4d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 13 Jun
 2023 21:32:18 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.035; Tue, 13 Jun 2023
 21:32:18 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v5 04/12] dmaengine: fsl-edma: Remove enum edma_version
Date:   Tue, 13 Jun 2023 17:31:41 -0400
Message-Id: <20230613213149.2076358-5-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3b3e134e-69da-4160-eb46-08db6c55a9dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IM4CKMNtXO8diM6wz+Qbp76eR8hSzb2JLL9uFTeUfqIXESLOZ9L8j6AYnoSHGF40beeYfIfr6tmAIgg5Gr0wwqLWn+QVrFk5GjPjB08kSY4wHY9JxPy/NFu9hc12bi5ODGZBhomlhHBVRNjrb7Zmo6tJFvj59XgNmSzP+NnpquyV6FcEb/NtyaqDM7vz/e1fFklTPQRn+ujiExpW6a8ufmWlzC4NPCYY62JXXeppsh6whvhMlR1jHIYDwQIQJ+hqwCN5lyY46SG3/PIk4SP3pFkkcdQ112DcWkhrvOHwhTTN3BwCXsKze1InfamN8vh5OGUOrilKQK5M3GtvNMso33LrS4d2e4p1ZIGulXX5xemyTuwXGZNA5M1lvGxWOGLx+QrUZLuu20yHd1Bs+PGKOwLrI9DYO9xPhfoNK76SN8Gwp1ueJ0L5SaSn93h3o7i2I52YrK/GQ+sMFZWv0LD9KXHGn5Tro0x9Tx305qfGN4/TikHitKkYVSpOW0Fty7SOtHrCzdtjrndsvPE/97pZpvIZuFG3QkF9QaXR5XlFEisDYO5KXKtToH/LvmGPjUz3Hy5lcJ4SIOD/5+bfImATp3UW+ItEKhRx0PCzmH0pR+qOVIgnxoUXkgeE6gJFvjMkhn4duURNTw/vJqwRf3EoixQ/bMsaYn5hns7Louw9gDE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199021)(2616005)(36756003)(86362001)(66556008)(478600001)(66946007)(6666004)(66476007)(316002)(6486002)(52116002)(8676002)(41300700001)(2906002)(8936002)(5660300002)(921005)(38100700002)(38350700002)(186003)(83380400001)(26005)(1076003)(6506007)(6512007)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xEbcduWY71FLfNbjjaF0KvYh+vwOUcLK/siGB2iMH+QogqM45WZ/jekDvOIy?=
 =?us-ascii?Q?y7HbpLMqgJmnWxecIak34mBxlOGgOoxnDqRdBUok/jwkrEbNIgT6/Tt0GfT4?=
 =?us-ascii?Q?pZNjtY3Zab2f8OHd7FNsdKRrWnqNUI+jYSGMFzYP6CoLYwoIklv5LBxOPt4h?=
 =?us-ascii?Q?dZOjHzNFlzUJwgxEMLkAenSRFkZSvFmYnQzodh8pDkg2Ihv+ZlJlxYzTOAsu?=
 =?us-ascii?Q?rn9MSHjkvU/AQ+y8j2SbLKiWr0d/Pf36T1NmgSyE+7hi66TXW8LmZUG4hHJ9?=
 =?us-ascii?Q?yk6NHjpBi2veArDTBFXHuGElMEJxHLBBAxy9qAoPtHnq4V0SUEZDhb3DzWif?=
 =?us-ascii?Q?0jexnUfpwrWtcjbTcybg//nZw2rg2vRckeNAb9kfasfvz0VjVuGG8B9nli9G?=
 =?us-ascii?Q?hZ39ZjcIKJzZeCeR4kUdzQ5tqpXCCyF6VNmJBIcBTutLPa4n/mrNTpUc+TS+?=
 =?us-ascii?Q?OSyOfiyTdoRL7SlISDDMF0b7QNVIB2fq/oBRSUcvugeMVyxbgOA6nli2UZ9z?=
 =?us-ascii?Q?twxdBWdszqX3xqTXRQy6XwOz1r792GrMe5eB90Hf//ftpkzI0z13VVq/fqvp?=
 =?us-ascii?Q?kRdezVYiQ5mLF1X6lF6RloemmaOwtEoiVDHmsZjk9iinTPQKqkDtlyQTL3t2?=
 =?us-ascii?Q?1Unk/98hTkNtV/xLvKH/gd3XUrcnzCh0R2z/BNQMDscksb57v5JBefYt7gbf?=
 =?us-ascii?Q?rQ3RkDqwqJjpWrI66ZRcO3k+wufVDUSjEFQMB5+Ak8TIIWr4QP+PXvnP9VAL?=
 =?us-ascii?Q?KxsujgP5gI5v8asXSeswk++FUHNcHBL26v4bmhXzSGn4BcAEtCUBYc7ekqIl?=
 =?us-ascii?Q?Sszs/nohNAh3s3cpjqz6eO6PzhGHh98UW8TQp1/YcUMyudLD5mBUIgwPqxfb?=
 =?us-ascii?Q?+qILPLPsAKzqCAlY4dqMMovpcXurePfCDFNciwBlKV07g0KXcA7NdMUQdIg8?=
 =?us-ascii?Q?iYeN+nhu7Rf9KGQkL2Pr0zYFOELU/xkeRRPiFWNTly8N/Ok4F1hMQCsBjAhh?=
 =?us-ascii?Q?Hk/Hj/+ouGHwUaz69nmfy1cemQXcTyqLuFydwpXi8spH3oVCCBoyLuKcY6XT?=
 =?us-ascii?Q?0TCPUwrdY2/JtQtmy1DpKbDV1drNZnmg54Z7rJSeePesqwCFEZSzjKza5RIs?=
 =?us-ascii?Q?rm/qiMaiDmf9egHsH/L3DTKRUDfgkqzAVcSRVDMgrCBvyPF+9gpjYdEPV4bI?=
 =?us-ascii?Q?a4ULx7WRme04kq/GSUSLPMqtHsJmn9FLQ2hq+AZYhMJgSxFsgy1XtXoDh8Pw?=
 =?us-ascii?Q?SITy/ocSyj/zs8axmLLqaUm0tWVqIZNk8F8gVLxh8ANsO8jmNdTOZjNCzmWf?=
 =?us-ascii?Q?Vme51EzOmOBlkzi98XiyVGMy41uqV5GkF8u/18IKSRRVCB7iGBr/0mb3/mpa?=
 =?us-ascii?Q?ou5wttD+PdDTZ6vCANZMvpY77mJxbVqm13gZdmWkwbCfF/1/URVH/R99DyyC?=
 =?us-ascii?Q?EIjy/Klq0OlprALU9ofVeUpgWnxsNr57B3j0klNIJ4KzKzAIdJAeqrqxH3w6?=
 =?us-ascii?Q?3JdQF6v/1Ecbmz83yI4980S2SPxUKbRMCgPQsdXcAhH8XCF0EvX7C5M4eBnH?=
 =?us-ascii?Q?1Z9ohHOy4N8Xk1rJ78I=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3e134e-69da-4160-eb46-08db6c55a9dc
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 21:32:18.2756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pjJ2Khfn/75y3IJNOBPjRCkIuf0M77BmBxMugQmGteqeI7qwTp3Whu1hhcxebSFxBPVoJf8RePbSTBT1uVC2dg==
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

