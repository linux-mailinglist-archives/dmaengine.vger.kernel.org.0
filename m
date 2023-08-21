Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9829782E1A
	for <lists+dmaengine@lfdr.de>; Mon, 21 Aug 2023 18:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236488AbjHUQRA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Aug 2023 12:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236522AbjHUQQ5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Aug 2023 12:16:57 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2055.outbound.protection.outlook.com [40.107.241.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C612911C;
        Mon, 21 Aug 2023 09:16:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/MLe/TIi/hD2s1ObSyE5Ebeupgvrr9qyA/+MCPQ1qX/5euyD2uhlmgZI48NSU4aial1sWQI+zO148/uA9UM8Sc6v4sfJDVCWYJdJWXHuq/1HjwutSAY//fZdlFdgPcK9ayG5dM8bAEIoPoq63Tb6NPWepxgKGcMUREgq2Vz6XQ7p803WH+xOK5BXGBngbK9gd7Kbs45O+hdz//vEJfmT8vwRA8FLPUFIDy865nBJmfbQAV8lzCjBNrofxZh7JcnerRttt8el59FT8A1RyRk2L+rMlHnm84aaOImHxy2X09eAPo97tg2KWXROxY9DTKZA2GMHIreS1IYK2M/PAyixg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vz1471MgBEeJGDlASCztYbpqUHzcyFSt7u0fe41vZKk=;
 b=Ckb1zJbE87GS5ypnCkUcRCi5gcRi2lMQZuqBpQLeMaePIvbiTcvaM3QAr8RZHIepyhg0JDc4AZaIVzuFBnBrpj5O56AM5iBZbY41q/xkhSBEJvOEJwAMHsJxlStMcg2eX4muAbNHG12KP8CsjQZS319Gd3JxXM3pDppHcs52EENoj92l1ClP8FkegaylL4ovlvYHNftr5UOYasKzddu6eGlo1W/fjBXaBCWR5HMWs2YJp4/q4PlcoPiHozFRXuAYvs1z7STKTetM+0vCovOnPBs2XUjyxFbIwRmuJ1XEJjZtkdVmjhWEaKlmbk+9+i9pkAbjXHUdQWmAsTJIO4oE2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vz1471MgBEeJGDlASCztYbpqUHzcyFSt7u0fe41vZKk=;
 b=jFj7pJimNW7zCOh+qVWjH5csBneNCRvuTV/9dNRCWfd2x0rkw9LXKOoOoasWP93KK/blmdu1vJncU03In4WwPVRTH1fubcMsyGl5FNAnLL8WDGaL2rIMSIdlLzwUaovJWE28QfecFvBYvPbOvOldzyj2T61kE5R/ZNvwRM+KiEg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB10042.eurprd04.prod.outlook.com (2603:10a6:20b:67e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 16:16:48 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 16:16:48 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: [PATCH v11 04/12] dmaengine: fsl-edma: Remove enum edma_version
Date:   Mon, 21 Aug 2023 12:16:09 -0400
Message-Id: <20230821161617.2142561-5-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 21ab2614-def7-4138-e9ef-08dba262051d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U/W13tWnZETYSZ68SxTG8vTMcuebQpX/gGSoX3Zmr9qIuP2mu/U2NTG8ASxP+GAwGauR2FgeLcRaek14lkL2xuBjVt0K539SqVFkWH+U//1bHmWpC7LqK4DyzKjnNYj1dZiJjJifGBjI2oRfMNSKvFAKWcPVL3x5QjTvGIi2Ffu16QgFjP6Kcckj4zzB5+4IYyw1+Bz3+54SGm4m64Ciw0AmegXWWnvInoXC/ky2zrN49FaaBnQMMyzvQ0plh0PNRaiC9fd0uoh1EWAlVJOEvXx9ZEi44FTst2LEK1R3mb4aZjM3Boo6Whhwsd9Xb255S5yNNr6j87MjeePdLeKlPeL7qOKStZyU38khvHDOXWs5gyhYWRtNxyQm+wlDoUOU1IRgCbl9SNN2VKReLVEw31xG1ePVXuLs1L/jyu/1L5FK+FUFJJVnPg1hwLF8VT/rb80bB8DrHJh+m7f5o9+PcxpJC0MZ1WiwvgeVBGKtQQR67eJ4JSvzS/a2hxSkBYW2+02vSOD95ullzlsxwfE/8SLfceNY0lkR6ub7RNgqolUW2oKM8Dm6t9X0GGTCMXFzQ4qP2kIK2hlP9An29QHDA9XDtAVE7CCPifVjp7kSxphiCZ0kCpec3dyzUhd25I+R1Q4FR3EqJe0bQcyqPzETcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199024)(1800799009)(186009)(2906002)(52116002)(38350700002)(38100700002)(6486002)(6506007)(83380400001)(5660300002)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(316002)(6512007)(66946007)(66556008)(66476007)(478600001)(6666004)(36756003)(41300700001)(1076003)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OZ2X8Ih/z6Zozu7c80niGh7/33Yesl9ip78LLA7OrHN/KYHN15yEN9UBBN8Q?=
 =?us-ascii?Q?0LxeI9COJO3thAbkWzIcp5zZH4Qt9h1JpBm7KR3mBhdMpIlXgkhFrs+4SZX5?=
 =?us-ascii?Q?9RFRniA5DxXV2LD31pfQIdjlSOHCcWxmv78DSNI3H5dkLeDg2Bn2i7yW1wK5?=
 =?us-ascii?Q?wwjYOxrJCm7g/lCu7V2EXnKmkpU/x5gBbIPsMGQl+xmFqtpBy/KzmlMpB14V?=
 =?us-ascii?Q?KrCqfkT5niIxIV5O3i0nH0W5fzWvDUnCMAEakVQBGyV6A0uuExFGFZeoqDB7?=
 =?us-ascii?Q?4zNu5X2DtfqVus7lCSfxphfoopY11NcKh6m21mxZaoc+OuVPOYhlAptEuGIN?=
 =?us-ascii?Q?EhnughmZAGQXpLxgJlst3BAI0rhn34Yao5XKzuc6T94Dw1MT93FPOCTY4DaK?=
 =?us-ascii?Q?kJPW5OK1h1JEZ1MN6w5/IX/1LLd8bjqmHcaA5ymY+lvUM9hhfC0uCGpdw12p?=
 =?us-ascii?Q?4LAOL6x0yhN8K64qm51Asne+NXeg3t8OZ0nt9K62DglOs5YWyW8C5tUraJ4V?=
 =?us-ascii?Q?Gz5NgXL8MORArVss8CEBjcxy05deuTaoLnENIRduprdBA72vvbK0r3ggblnj?=
 =?us-ascii?Q?rRe5PoTn9AVuWfpMa4j5934qhUJ8r1pkNDvMyCiS6HbvnpX90GjMxs9zmX5C?=
 =?us-ascii?Q?vtfq8omjTfcmSDiOv5nWB2NBGZ4nUys5X5k20ekKeuazCz+wR5crqnjOlFKL?=
 =?us-ascii?Q?3ar6tlTqfp1GMKpG8uk1qOKcq5PoiFtM3ojGu4BwxVoE9JqJnLG6qEZZoCwG?=
 =?us-ascii?Q?98pYbbVkGHRHcLlEV4H/SDSR2O9BbVbnnb+Wdctd++8u02iT9//YVwQ1xg2e?=
 =?us-ascii?Q?YJncOj3DBVmuvVZZnr1jbDK6V5lfPIP6HXhgLjm2wuoiIwQ/yTkFhyiU+3m5?=
 =?us-ascii?Q?r1WVI9XOUDa/Z/HDcm2fEDJxTRSsLnV1l74Gy2EzYapiQEjSwfwjtO8S3vjC?=
 =?us-ascii?Q?KoQ4p20X4/DserOIoPeaNDfzvKEB0k2kwT5heagjUoJgWjvs3BW9a7wA08zX?=
 =?us-ascii?Q?M1ZCmV26RqxVL5qcpcuPtkriNSdTJ7PVudQPXCRJrBOTqXbSEW9SqH51JQsQ?=
 =?us-ascii?Q?NiW31REWu9DLxdcI5j0LMi3XfXYzaTK9QA28geGGhMb0Wq/sJzzWE+JtpHrh?=
 =?us-ascii?Q?rH27Hfde/Mz1FLUrKbH/NvPND1mpo+eGppcdOdYoygL7eA7zUKHQcRmn2pO+?=
 =?us-ascii?Q?L4q/bJ+L8VZBM3Xahu+UYWxH6RBT8/+7kvoGACu8s4pr2c7lcX/acy37Ahbh?=
 =?us-ascii?Q?EcGIWAr7DBJux0Fn5nY/HYEXwT6SbZrlWVkL1XEa17YBBOO9PPECsQmeTUa9?=
 =?us-ascii?Q?u4TtT9w5uttY5y9ht/FpDpRShxEyJb5LUTzqCBmasbGJK6j5ob4B4kmi9HyR?=
 =?us-ascii?Q?bnaf7c74l+HDSVk48zxxTz4SYaSP7p85TsWbZDOi2x2VJd7+Qs4sP9seEi1l?=
 =?us-ascii?Q?DBRIKjqWxNMXcLdUmObazxgK22Drz5+sR54n2VdPIltR+GwfxmtImZtMutSZ?=
 =?us-ascii?Q?5f/C9Y/1ESHJfJRd56/y3PVAtDj3pXwNVYmR4X+S1JjTxslgWxxrzQkaIyiM?=
 =?us-ascii?Q?mNOZCXju5wWuZ0+7kEU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ab2614-def7-4138-e9ef-08dba262051d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 16:16:48.2829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3qoxV3u1VkFIDaymp6uVgyT9hPl8+3OUPiuRkBvXsYeCL2OqxTWxYnY4jcQAA7t+HQ4s8SsNyIVEpOX3g8BqaA==
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
index 2549a727913f..5800747b8fb3 100644
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
index a318ad6e40c2..389e5f9875dc 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -236,22 +236,20 @@ static void fsl_disable_clocks(struct fsl_edma_engine *fsl_edma, int nr_clocks)
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
index 28304dd8763a..aec22711b654 100644
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

