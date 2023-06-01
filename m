Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BB871A093
	for <lists+dmaengine@lfdr.de>; Thu,  1 Jun 2023 16:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbjFAOls (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 1 Jun 2023 10:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234363AbjFAOlk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 1 Jun 2023 10:41:40 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37F5132;
        Thu,  1 Jun 2023 07:41:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5k2AAUXdsoGR2APoowJG3qShBVA8qzTH0/P8HhFzwFUhBhZgZxD961pj9Sf0ymvRQJBC0xgOniEq0F6oWiUSrPMVLTXvNZiOfK+rwHGHAL4wGaDUpjNoKYuuMQwNtGkahKqxLzz0kYzRNDLgu4E/kP7RmPcZJQ9x7vc2KekIyzzBifCtQGGdsbyNcYyOsXbAqRV1YuAH1AfRyS36md30xYDkaK6h9oBng3jHbYQNZ5a28jHeEceLK6QlJ7+6wdqe92hgpOAyp9GhmnKvivKcaLpkGaWjn2Vl3dvN8UETiClU72vNo4PhVEBf2jhou3qFE0uR6qX1hlccoEd4XVnUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HFIZH3IzsjxftOGBCtFEvNQkNGKfn6DDnuGmj3ibOo=;
 b=ViznnJcypl+muPqff5BliUmtVcl2/E1zJM8giLkKk3tR9hMbnvMPtNjXUOAGD5LmN1HFhrFIGgerl0MZ+iqkladHCWOsysT8pUsNlpYB2nrKTUX9A+ylY9n3V4vd5HaYoHIuFJusHcnsnzxHxLaFZSJM1EwiuxNPP4I4xyXzdG7wuLharRZMhWeXCidoY22B7D8TAhWB8ev9ZdUQsJaVeCkqnIgnAtYG/pqjQ6nQ4icJvST26C5ofcObKnVQnTH+X3k/JcA9XXgKIHXsfRi6cdsUwCuSuXcHsyVuW2pbuvSgFgGyEF2aCB81kM9VtDqbB8fjNqyEntYuNIGQgxdt1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HFIZH3IzsjxftOGBCtFEvNQkNGKfn6DDnuGmj3ibOo=;
 b=HXryYJpryFj8kQ1tzl3ZnwcMn3p9ec9bfzrKmnP6A9ITMzczV/qmWY+8ORbEhUYLBoyJY+JtZamp9WdCugood7lfx/WRwfgCDindV7NUu4eCtpYDyrAmGz4Vtc5pt5c0dxaCIERUu6M1/vzxpumQRjKD9eULsLyEmo25sHnNTaU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB7603.eurprd04.prod.outlook.com (2603:10a6:20b:2d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 14:41:37 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 14:41:37 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v3 04/12] dmaengine: fsl-edma: Remove enum edma_version
Date:   Thu,  1 Jun 2023 10:40:59 -0400
Message-Id: <20230601144107.1636833-5-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: ec7ded81-6e39-4321-99e9-08db62ae4dc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AvRF4RrowYtOBB/HU1bjPnT6sCjMkJr/bPTip5Vw6XZKr7Zhv1lyGqHZ7+LQK8jPICRXh1w+7FYe9d5m2O2thkJxeK6xJg0RlOHXBlX+hfCxCWu98cYK+3Sxdnb5eWfalrF2P0Zuhmo8grvCfXgSroSsJSFWSjd07cHIwxTuqh08vJyg6ST3OUIYHFuQYjNifv8DY6ziy+OZr/jVn382v973nSH2slyaryn9SdP6c8RdOqVy2z1XTU932U9osJoiHuL7vqFVgeaULjdv2SorTyUJAGVjYcxntODQ2ht/hsrgbZ6XaxXRehf2lbZgYAVtglzdFaMl1/Jud9rxx7oB1sGNJdZqY5EmDUW6mj/8utS2iELfc7Squ8bjQ2MizojLN49smedjSqGQ//IwWvf5HmZnkZrPIGmbrR9POLlso+J+5fv7fzm2zDVu2sLbidgV686iVaJK37AEJ9lS05Itw4g8xuc/Q7PIOwKES8qA5SeQAKEpH7hWwOokwb62Zst1NWii4i/ypQcr5opDoIo0JPyRwJpfC7UnXAgINSZ2V48XB4N4qdodvDFTjWWGh/CyKVHCPoSnLGlH1KOlfA4z1SW3t17xnOZN6cTTV8LOlT+1jkaJqlW4P0TnnggIAwGsZU5tU4LgWUPhjWNT5O0vAyFglQ7vsNvEcFkrDQu52qI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199021)(26005)(36756003)(6506007)(1076003)(6512007)(2616005)(86362001)(186003)(2906002)(478600001)(66946007)(66476007)(66556008)(5660300002)(52116002)(83380400001)(8936002)(6486002)(41300700001)(921005)(38100700002)(8676002)(316002)(38350700002)(6666004)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6jlKrYCAkKFob1aSoPBK3JhqQ2nxQRAaIJZtt1Sv+k/6SwJjkDR6bU5Wj+rM?=
 =?us-ascii?Q?309+PVLHtFUaa5G1Pei0FvDsUz0uVLWNU+UiUExg/pj2npSlb8WxBKlKfmyP?=
 =?us-ascii?Q?kLBL6Q+cVjJx9DB79seLV3WqXwEdSblBpT8f+JWIs7p1XCYS6hQ4nZ3PcyD+?=
 =?us-ascii?Q?iDYo2FnXBkA343atnF2azw+gOtdtmNKCXNf5I2qt1v5gX0qlXAOAQmRw8Q5b?=
 =?us-ascii?Q?jB6GArWeCgWGuH9ILijs/wMMmIP5ojfIBBZHv2kymwkp0aTOBMP2oUeWc0Lm?=
 =?us-ascii?Q?ossvcaKgHbFlYof3V1jsAhcNdpoWY0WF+AmbznNWk9PaRE3pfoYA/12GF2Xy?=
 =?us-ascii?Q?j/AA6jxBTCdEH0rIgZKyeg5St5PqdFUtXgvxomaRgKhY5g8DtFsGoyHkqigj?=
 =?us-ascii?Q?cwgA22iNRUvIHSa0lkSatv2aXluxgokzwqOhadBMsCb618dhcmDazzz2nk9C?=
 =?us-ascii?Q?5Kc1ldz9+wiNtVj8QjVXCu09kq5RWW3GP4LLj3btlNVSmC4JIMJTP4JSMI6y?=
 =?us-ascii?Q?3iOeuB1RGa8Xeq5mE58rW8d6dwtVD5Yxa/sTqXRtQBtzk8F1G8sYpYI9oagE?=
 =?us-ascii?Q?GVYZdreBCqqT9yH1XQ4Uw0/8KP1C6+hK4H/gm2kWO0bVd/RLQDvQ2klcTu1r?=
 =?us-ascii?Q?xBlDeANtng8kD6NNxBJ5QDQWWCVCyjU7Y34nIIjdJMQCecME+L5SanyD5p+2?=
 =?us-ascii?Q?Aff4QfeLUoxE3GXhrgaoeOtE8qKNNlaHDtlvFFK8i5DTQ20ZjI8Wbstm2py9?=
 =?us-ascii?Q?lCfOFh9bZK26VZo25r2CWzU6CGXZJkqEyXH9sfPYvPItnv1tnTEqx1rAMr//?=
 =?us-ascii?Q?K8+9ZkYR+f731PunjiBbdEIDmaajj82ixGJbR4rttYy/NbOcEcr9rFUf+G84?=
 =?us-ascii?Q?YQhynS4gY+74f9GWACAY/HFjjDzb9JyO3SFpGoncRU2d8gtnEmtXO0gwke8F?=
 =?us-ascii?Q?L73b9SJHhglEsr/DZVuJlj+h3c/y9x5Xyjhm8hMZKGodMngY0ybrij3Sz48Y?=
 =?us-ascii?Q?9XIgvLaKvgSmmcT8no5bPk7XgW6jsmdNjMT35+gPmRHUS6EYCIINHF2EqSwe?=
 =?us-ascii?Q?7fNHaVnkbY9vYt79BL//fZrOaJwqZ9Aqh+MKw9lnbHoGnkEItwjFpEGAY+yM?=
 =?us-ascii?Q?uFdwxrI6hb3y01Q/i6G20bwHWHU0U55YF+Too0HPoIeNrZOGOi31MbTB/JxN?=
 =?us-ascii?Q?3eiQ8U/BQt8gBrjRk3wKK3b3riwNKYXdNUOFnLDvYXdwCJJg35bFrmAuQVHC?=
 =?us-ascii?Q?3/tZ1GtG6We4sKsy7DOqZb2PjZn7lE1sZTZKyaMVmBC+LArM1T6FZD5y/aHE?=
 =?us-ascii?Q?RXUjEh43JwWt7DFJJRUbWqUReJqld2L16cL9BZgw1ujemr9FpJmDI3ZByPh8?=
 =?us-ascii?Q?66VjwA/s/HW03IL0YCWFMqXW8prvAHw/VI64XqKXDfkvvVOyUWVrzEecaPWS?=
 =?us-ascii?Q?NwSexT57ZWmFFHgi6AL6Y5s+J0lgExScodVy2yOphwRTXOFL0saXD7dVMpe1?=
 =?us-ascii?Q?hnc5fABa4E2W7CiGSKXtMzbQD4kGgviALTeRWziitxBChiEZYqLy9FjIkGc5?=
 =?us-ascii?Q?1MQU+cgCJCfWZyat6sFNbDh0CwFDe8cnXQZtni80?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7ded81-6e39-4321-99e9-08db62ae4dc3
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 14:41:37.3642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZE34AHkqZy2m5T+1czPxnyGs+UuAjg2NmaDcheJVw5+0qFb0Q73uc8EY7wOdK/jIw1XhBKQ3QNLGhyM2rvPYJw==
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
 drivers/dma/fsl-edma-main.c   |  9 +++----
 drivers/dma/mcf-edma-main.c   |  2 +-
 4 files changed, 26 insertions(+), 42 deletions(-)

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
index f5cf95d185f8..c7f57edd2bb6 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -225,22 +225,19 @@ static void fsl_disable_clocks(struct fsl_edma_engine *fsl_edma, int nr_clocks)
 }
 
 static struct fsl_edma_drvdata vf610_data = {
-	.version = v1,
-	.dmamuxs = DMAMUX_NR,
+	.dmamuxs = DMAMUX_NR | FSL_EDMA_DRV_WRAP_IO,
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

