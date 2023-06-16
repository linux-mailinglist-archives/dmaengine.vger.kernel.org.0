Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222727334E9
	for <lists+dmaengine@lfdr.de>; Fri, 16 Jun 2023 17:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345705AbjFPPfZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Jun 2023 11:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345789AbjFPPfS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Jun 2023 11:35:18 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2041.outbound.protection.outlook.com [40.107.104.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A82030C3;
        Fri, 16 Jun 2023 08:35:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RO78FdRPW+2XNwRWeKDLRsHrpssHRXS4HiTp3xXLYV5/Pb3zBQZB+qEnCiV8LJoYbCma88SmElQAnJ1uS6iijWMEBXqi5juvH3Sp1qbCZyD/Y7Au3NNu9EXHskvoJA6aZ3m989EPbuchDsPcrZMcaTUbSFdWUwktXAja4RKxOHcATaU5VsC/ObhFv8y0zMCFjI94l8QIMeaApOYJgWE84KdGzx4HU+Ub3N4ipvpIsO8cT8iFwckmQK+97miwSYRwJZ349QHHbMBbLnleShgVsh4EYrJa+OgIg1WiaNgDEy/CGfPyefO+NV4eN4qKCXwOhYTnDUgmejFKGG+YBXWeQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtVmb2w/gc4SRB2f37IwBcHKtbBBAdft6k4Ina+w9xI=;
 b=BmKecR/98jJGzCeD8JQloMFAHlwcvuvlzUR0VxzcW94pzqKXZtWIcFRE/1zodici/h2d3WOMEZiAmhgEwfNiUnGx9WjDWxa8ApKy83mrTB6XmaMqKCG8zPLQVUov2pjGRSTY21IEsAwxXbvvpU67h5Tw3/10+4T94F3EsfHMDKfpSMpJTfdzE3SrXzRS3sN0nWYUgdLlKhEwCW80mLBgBZnQpZuNcTHKMd/YfLUe9Nn6n2V87OMhzt8G1Gq5DOvgzW4RtqjRhXqudjuB4G7sMpM/qmN9pL7jbhgo3d1wxEUrlnfBu9feUKrdEGTcJB9e77/+GVW5EY1nje+RYoXSTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtVmb2w/gc4SRB2f37IwBcHKtbBBAdft6k4Ina+w9xI=;
 b=AKXPize+Xwt03GQR/DLfNvrI4uZ3lz14y1CzQRrfMA+MzRfgt7MJ6bS5mKBcs6W7jg1mDnkzizpZlHtpjmp8uj3S1VHRUHOCKvFJipgOVu4o41gEiVX8WuIfhb0u0EuU8gHujz/bxPoIEVWk795LngNXgF4GkLwnmGoCJP0/OLw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PR3PR04MB7339.eurprd04.prod.outlook.com (2603:10a6:102:8b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Fri, 16 Jun
 2023 15:35:07 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.035; Fri, 16 Jun 2023
 15:35:07 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v7 04/12] dmaengine: fsl-edma: Remove enum edma_version
Date:   Fri, 16 Jun 2023 11:34:30 -0400
Message-Id: <20230616153438.2299922-5-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9ef31637-f875-45a5-3472-08db6e7f4322
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tzyS1fVSRX1zlYnNrT75PHD+RLcJSdoG4DkouJJxEGK6bB/vu71aRQEAJTZGvyo/OxmLIK6gsFOVew0VgLeD+2mGMpc3tRgtpjUY5CAzzmi5GoZRblCENle17lMAiEt4/DO+BjfJA/u34qK+/NaSvpDyddeX77qRw88e3vHBJtNeBp1UKdmsKoeja+pSBD9YK73rmJoPJsdn4bi8L7j37V2E9DwN6yZ3Ksu17OnxGOEbKwtgVjavrWQTQzVymF4tH/zihtEx4UjYxr3+qGKOC3H0zQHpTZCve9cdTNPfZJ/1DbEiQMv/CFlViUinH2+SAtdMK9G150QjicbuvIJUBP3cLVfehgtisZuoiS9X1fGPRo7JVEnIj5EKfB8KggaBbQpSVAWCK/zGbf33lfOlIVRyVPWREzHfnsc2uZ6olG7estSb6gV1d0ZlS6LqU+ZPDp+7Op28cBL3xK9TTaIvvUTynFdobGY+EZOgCl3CPOhZLvzEWSn4NPSsvVlXqjZv+noHEOFwPVlMGdHePeMp7rJolcc/5IBPxMs9DSgFvwsmytWu7hEhDX3GO2yJ9EtZl5q+PRY08LIaC4wpjuCR8+K3np1eROZNlHLOw3Kt4xErP5iOMIInQbgeICtbs49CVMD6OTX0yMoBr5fS6Hlel16rQTUbE2ElGPZ0YxZt1+o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(38100700002)(66476007)(66556008)(921005)(66946007)(316002)(2616005)(38350700002)(86362001)(186003)(52116002)(36756003)(6486002)(6666004)(26005)(6506007)(6512007)(1076003)(478600001)(2906002)(8936002)(8676002)(5660300002)(83380400001)(41300700001)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?epQLXtPNJEOGvQ3UNALRhi/pOt8sF0uRqOQaKTMPXOdhV+6WsfBSLGQj5m8T?=
 =?us-ascii?Q?vgsNmz4OQn7bKHI2krw9y8YJaJBUJVuP5wzR7ZAISnP4O9ZxvVNxP5x+PFvS?=
 =?us-ascii?Q?qtoBom50Ly0Pqt8xaQM9TEgYQWabKtLAdZlqqLZrSQaV9cA4mpQcVGFItXzE?=
 =?us-ascii?Q?yp/BT6cqyI3Zs5WI5t9iXvRdD4NFKNlI07lvqi+3tHSPHE2yA32yac60sd70?=
 =?us-ascii?Q?TpbA8hgcl5hmxVjAnSmx0zShOXbMxVdtULdvyq+1Ufmi99YaOBKUZHoERNJY?=
 =?us-ascii?Q?g75Dls0yo23Nq9AQ5A4oA5O/yqxYWDQ2D2YmaM3mfP72uFTusJqePfFLbGgi?=
 =?us-ascii?Q?Jjbr5Xxc8S4VR8WJwEzeiymqCNZ2C+JB2Ys7QXTSXoZUXjMBKyQtICVWxN+7?=
 =?us-ascii?Q?IUgbhItXSd+DQI1QoH6mdu5jQnCAnO6tawTUfUWhMWTh+DS2v4aX6f15Pu09?=
 =?us-ascii?Q?ve4CY64ipaPMoa9BK6KqHu9LA03mg9cDMZqLDqJVhmMxcfNlsMYLbZCpLqSe?=
 =?us-ascii?Q?gZX9YdpA+riQWJYKpbMcnwoJwoFwc70xk8iZ4XBvAgHLo8ZZK/Mvo6U6DNuj?=
 =?us-ascii?Q?b0/GmMoKqZ5VtmsF/+x7f5I7NXozXIK+miREOiSE5clmL6wEgbod3GJsgdlg?=
 =?us-ascii?Q?ny689JZcM/6H5GQdbm4mCxttjmukMkCXM5aD44U68fgZ0wL5z4Un46ezajwm?=
 =?us-ascii?Q?qaj1vGG4uOjxJ6o+YFLljObUklblYErSKjdmFk0Dg1MUNDOAA57AoyP+ouPO?=
 =?us-ascii?Q?a6FpRUajDfANddkDcMUJK1MerGBonfMZ04S+o9PfU7OspoM6CTPMz/pPsBxX?=
 =?us-ascii?Q?tW5s8L1SIA8irHn23CLbYnfn2ptrUsrM+ldswXtax3i4LTkmASJwXRRxNId+?=
 =?us-ascii?Q?8llBsZDpD3CMJwo7vxZEaL+9pg3T3Di11MtYLQLAmW4W2BvwwzG/PMQX9Vg8?=
 =?us-ascii?Q?bElK9Ripa7oPVPPIh07pYWmNd3PSIpQoP8hZ3Bycu1E6leRjxGm83NMOBjPq?=
 =?us-ascii?Q?dbY1kCbmYNmkkBGXX/aHtV2bxlEO+cU6TTJQZNfF5CoTsZ1uoxkw66x/e7U0?=
 =?us-ascii?Q?R1CJ1ZlEhZ9ANVhwSjOEkSsLBTS4DKzGdo4RRDmT3HdwuIt7zgGedy7w78WJ?=
 =?us-ascii?Q?BwsLlOLNU4PCYOiRcRoNtRPS8kStOs4vwFTPBT/2VjOTytulqWshFa8F5Rkt?=
 =?us-ascii?Q?b5ewg+u1pYj8r/13N06XsFOi9Bs3gPVDUtrpTH00Iu/vHhiL2F86Jaj5gDdM?=
 =?us-ascii?Q?qs2aBgzE7yNz04Hu9+LP8Z1kjKf2it4KQP30uhp5uunwHF0HWq4FNBfXXFEl?=
 =?us-ascii?Q?NC+bHcknIPFqFnjMNA5VU5ySgpaOOVmAFdKAim5QkencL9J9N3evWPhaJGFN?=
 =?us-ascii?Q?0jvysBIp9jhU8OSnVOaTH4PnbU0JRwwa5bKofaJKYSQgnALwWCAr0X1awmxR?=
 =?us-ascii?Q?ahGTT+733P8aGVJbEcPVucCxJ2p2xXJP/OhGnTV7S4gwtKHoMR7QVsgJfgcM?=
 =?us-ascii?Q?BGOpvtcyeM6TbE2r4vo/XY2a6ohKln+L5/+FuE2u+CqP0Xpz415R2rVcfgyo?=
 =?us-ascii?Q?Yhx2bqnxGSogJdoBDa8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef31637-f875-45a5-3472-08db6e7f4322
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 15:35:07.0842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxmJOrK6HLFO1zpO4KVIAPoGLpeMYfZzKgfufYGz36RI6MQG3PWJkGwI8j64QR2T/VMFqEV+MNTOc+VaW6o1rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7339
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
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

