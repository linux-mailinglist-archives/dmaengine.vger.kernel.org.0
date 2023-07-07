Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DE774B6BB
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jul 2023 21:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbjGGTBL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Jul 2023 15:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbjGGTBF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Jul 2023 15:01:05 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2088.outbound.protection.outlook.com [40.107.8.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072FD10C;
        Fri,  7 Jul 2023 12:01:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkU8jZ6Kxz/pfmL6HjIG0ZXVmXbA8UZwUYRIQUHARP+XfoXTC5ZW50aSblReHbbuLfwwXBCNm5pz5ToG9X1S/9u/s2za0/cTMZi/fOEmpnlYlkUYtnidO58V/17XP+rbf8tL0AUrefDSQOFuDwAJdCemCEB5NsFh1YsyocN8iR+KLQJ980hmxB1GL3H7fv9I/29puyQ+YOxDQm4XKVL2UCFM8Iol2SrDDJNz08cNIiRfzlJ0hcB781BPdLKAqCQ5Nzp2mYLxpuPl2JR0Z0qTKQEm/yyGu22UDvoPDv2KFj+OiDQy6mw+rp7K6aMkzAOqwLf1aIPl3JAjct3/u23mog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYDV9MILkKaLR+IR6/b8VsBFnagiKkTiFeSxiAj4udI=;
 b=OhaHPwMNt4ckVjv5tpcsHu+htMaUE71/bjXF448l8/2MjzG5jkS68LqKUoCXDw0oCEBzTWH2ccFinT8wAddBql7cbViKVY2msBNwYJS9VLLeKg3wyb/ga2DPAFbckYrHisN/vWduIuWfZUksNci0p1bSbppoTQWeHNu9TKKBFIYfu6fjh5/14NMhByKonpC2JZOq7e3iQAibENTVRUau8TpVzhZnCK5MolFNqJS6OR/XuLbPk1wWVDxL2kqs55NgDPE7hObSzxzfOlYFK/6+8TfZ19jIFXP03r+NYuwOJZ/Q761fXx5anKIDFQPoNxXPFBYeXMHDttgIyy0dI8WnlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYDV9MILkKaLR+IR6/b8VsBFnagiKkTiFeSxiAj4udI=;
 b=bHQ9C1SZUQjiFHelFmbZnQvYjQGWdgRTlyjcxvIj5PrC0h1DDcXlIEOWAsafbQtwCpVv5JGlPfEHDtpVAlmWuQvf98RKYe4Qsi0v0QglK4lr/vGm0AscJidRqDINP4YF2MKoY7SWSI372sCyW4qlG/psF2C028vQd/NK1oEDPw4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8103.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Fri, 7 Jul
 2023 19:00:59 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 19:00:59 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: [PATCH v10 04/12] dmaengine: fsl-edma: Remove enum edma_version
Date:   Fri,  7 Jul 2023 15:00:21 -0400
Message-Id: <20230707190029.476005-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707190029.476005-1-Frank.Li@nxp.com>
References: <20230707190029.476005-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0067.namprd11.prod.outlook.com
 (2603:10b6:a03:80::44) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aef0e11-8e2e-48f5-6fbd-08db7f1c8075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EJn12ebjjhLk/B6MXMT9XPjhRisp7Zh1jHrpJFUY0Jxnty6i7/xXrSBclqEzY7sTgFanMn18JJYj3yHyS/HLmWds/sCr0CBF7P8ax04FJyv5ccx3IK8J2Ap1PRwzd0eu3UH3KrBYj3KpaqMiqIhYSuOpuDq6Eg1R47u6STPZIipAJmQ1v47QwJaQi2+P4tVttIRPG4zzESm5iiqA8fthN/AfJTX3Tm69IxMBw++RwnESz7xmZp+Km9MXbU5d4CDzDFLlY6QY3qz4rwTiavgDGNn3sj2PyUsN35dD2/gpFNaFp0iPcAsWTbgKwpNzuUuXZ7vUI1w2QfoVnTEZ4gBMI9eIM6Ezw2CUBRI1GpjBIVugNwSHhemiljuWF3iX+rJtHAKY8f7F6av3Rv/LD5VLWrcrHZaYC7krqXjOB3q2sixum8/prFTflCLGDE4m/VFRFSdqiUeGBQ1W7VMEK8ZbzAi8+bP5x1yH0bsioCRhVx6V+GFfP4kIGgiCGxp8KTwsrZIRxXEA4CH3B+y/HSTbAIG4IOfbeXiVNqt05QUL/wn8krhCP4bnoB1kxt68cKV55YCLc9IZeWue5jfnfANNalj1a2QGPhyzITziEEne9bjFatAdTHXkT9kMSZsRdOEbnHQmq10sxakDmUn10IiE0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199021)(478600001)(52116002)(6486002)(6666004)(6506007)(1076003)(26005)(6512007)(2906002)(186003)(41300700001)(316002)(4326008)(66946007)(8936002)(8676002)(5660300002)(38100700002)(38350700002)(66556008)(66476007)(86362001)(36756003)(2616005)(83380400001)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qu39vxHcLGKByQEaELBIeilzZDwGrm2tOKazNPE8DWrYDGcJfur6RNq6lFQC?=
 =?us-ascii?Q?jNapvtpCot8T2FP/csapOwruSgmlzTx0HdyuE+ArTFb8zENpbR3nhvnxJPAY?=
 =?us-ascii?Q?7G7aTZjg205LQ50fhC3w+dErABQRE9CS6j0yujn+yPmFbm47EtlnPZwLoyCr?=
 =?us-ascii?Q?ni5irNBBCB9I7+LoEHHtWyQ2H/t1j/TMoUjakLaOD0ZYD5fzzWMJ/x4gaIpB?=
 =?us-ascii?Q?FVy7USLOJqdS4hchSGyU/1sj+Py/JzdJywpOcULJfjtEeTzyP/3xA3mucP6H?=
 =?us-ascii?Q?FGvIq0tQFCrOOeG2z3NlQ8WB+yl73sz9sIC53mAJHePQUcR9P9tPRygds1pj?=
 =?us-ascii?Q?NoaqSyxtcslAroe8mhu53uT6SZ6kktl4p6nblN1F7KpG10I00Gjz9EqFoWkm?=
 =?us-ascii?Q?Ixufs/LTAvNnQwdOh/QdTDov16ztEcfDHiGcnt1pKnfO9gwFltjNsgu7gcGO?=
 =?us-ascii?Q?2Pk5k5jVtK0Yodjl1hfJSFYfH+X2Uhmvy+1uxpBdAqMkKqapNSnE5ENj4LiN?=
 =?us-ascii?Q?GC7lBp20+ahJKNGA02iMlCQMFTYChYWIWVlQ6Iln8CVPROrsMMn9o+SsYV1K?=
 =?us-ascii?Q?JERxbeUJ2pDCdgd5F6VXWlbro+Ec6ubNVOQmLa2gXHvcsHumqfGwHXFCh8iT?=
 =?us-ascii?Q?jBt5oWDSCXN6V3MsH1HMOahHvCyYfZn0CgBQNF7KfhYgOJso915F/yw9pyWB?=
 =?us-ascii?Q?5TbrT35bBANjEmD/CckUHXliEbjx8+0qIr67pJ2JzEWSx0nj+QzvxeYQL0bP?=
 =?us-ascii?Q?voscRRvnsBUJfowJNxbCbkD4E0s/fkbSnUzIgP2CF3f7UC/z241sY+tvapbJ?=
 =?us-ascii?Q?TMaQp2GDcGHP8No/K53p5gNZFaeN+l1Wo6j/qSlzdwAQzfIQFEOnIkvTQ0di?=
 =?us-ascii?Q?86CcRfwTFxuAP3l42406pUuW54JuTvz49jsp6HI/qMHUXC0SvSdWR67hvWBp?=
 =?us-ascii?Q?HcJXO9fKFqjs2AjujssocIF2axbrzscM7VjVm0JggZRsfAMSjaqiPG+eGKIh?=
 =?us-ascii?Q?lCZy2gcbmj+t7zMGGkbH58125uSaS3CoZembS4D7gmEdGX2Bl9uvoo9L4jyt?=
 =?us-ascii?Q?ilOO4u85QdJ8rjHts4Hy9tEE9fXPU0FtdHJ+UyFvxo1hAfa59lUdrgv3t7N4?=
 =?us-ascii?Q?XTSLVCnTaZOK/DLdE2ampMdSDYpIiVA2fuby6M1ocyuO1D8FPfmVETermwuI?=
 =?us-ascii?Q?bKbtxJDDjuQr+BpbHDbGgkMKr3kpTcOc3PSez/MBV/eIC+NYwYl3FYdliIdZ?=
 =?us-ascii?Q?RW6S/kenICqlcy3fuSjIymb8EaJamkja09Cn3FIOW4all4bHPrI+T5FnWD+x?=
 =?us-ascii?Q?HFc2DQ+m4riXS9/7fwyFYMfGnnlCZrpwzx+ZclE4Rc+Am4ICMn5miE68vH3u?=
 =?us-ascii?Q?Aa+QWiQTjpuaV9T/rSkkjhGO/n8giAWLO5fqz+U8U4LDWZToANeTXhAPovoy?=
 =?us-ascii?Q?zXh3MQHDfNv4ESpzk6OKLkuK21+Yctrx6HGrrVgmw9mr6FJY0vVN6gZNtCO9?=
 =?us-ascii?Q?44XPPMl29j2EkPm5YZ16ZC38WY02XG9sZ08eeHtfwnxD3NnoIOr95iUwbbB6?=
 =?us-ascii?Q?vyUQPwY2Qp8P8VJHL/I=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aef0e11-8e2e-48f5-6fbd-08db7f1c8075
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 19:00:59.5785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ebGG7MB6QB5/kgyYd/ou61hKXd9K7O4l1nB6IEX0asRrA1rTRyAa82YQgPk6GeI2IORR4ZVNplwkmUnLcUtofw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8103
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
index 1e1cf0548ac7..be79a06fd6e3 100644
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

