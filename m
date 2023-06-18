Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E2173477A
	for <lists+dmaengine@lfdr.de>; Sun, 18 Jun 2023 20:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjFRSKE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 18 Jun 2023 14:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjFRSKC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 18 Jun 2023 14:10:02 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2072.outbound.protection.outlook.com [40.107.105.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90817121;
        Sun, 18 Jun 2023 11:10:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5u0+Tcj5mCzxTF001dTas/zI/8POfv1MHqnsA+gbgfQxOMu7ZuSoh/5RaHHjgD4ESHTL+pZdbZq3xQNT+86sIoDWpV2rNF8A0RNzs323B3/b8sFPxtHUCWCBmvBPP2XKkvMT7Yf4XWuHvEFJ2ISlaTXeFUdfK3a2anyMJIvaegnxR7s4GjBVAlNVqlM/gcmZwSVjfQBIFm/ZJkm0op8wMI+1HnuN4bPEgMoKRLyGdtFZpDykFTN7M5VFJvusXHsoEl8fi0i7K4U0TP2tm/XHUqWfkgXPgRbMg/fdzqHaIUbkhrvX2iZX3EycFZvXr6KZW2fNUxxCyrheczCSxjVhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtVmb2w/gc4SRB2f37IwBcHKtbBBAdft6k4Ina+w9xI=;
 b=FzwsOlhkoYhwn4el6eYoG/xeEFFpO8mZ8ZN2fQSd1d5FtD2LwevKrkdzNcv7OtHNyhDkFg5F+O+s5i3LOgF6sUFeaEH3LaWENBe/N8sputpcUsS6v/ADc7XmcD/Iqbwjqdp9eER43hwVH0Av8IS6jTAi7H0vTBRw6Hcvu5oTPabenH2JzXK8q3uNQDOxVIJMCGA66oi5anWO0P+R2ze7PKACzunt+AZVGQU4WmRHyY3wABJtyzkMC0QC4dgAJEFygznh30J1TYM7v/uGcTS1PFno7Dz2W5m3LPFZI9ZNGAoA7Hdb8Qco/JECPzrX52nlDzX6M+arO8wu/5v2wEOy8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtVmb2w/gc4SRB2f37IwBcHKtbBBAdft6k4Ina+w9xI=;
 b=d1p2DWwIeeX3HsZRYSuenTZDjNdOr7PzrB3b7HHXthKEWnzH7FIPCpI3u3ZBKAdmp+y4kHA7nkpSOgF6md5G0VAPr2QdH9PBSpqrfrTCPGKfEXHfZA4rRz4S7HwYHdS/s2SK9xQ1EA+RfUu+JvLGpOewAkeJ4IfOXe72fsTapQs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB8PR04MB7019.eurprd04.prod.outlook.com (2603:10a6:10:12b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Sun, 18 Jun
 2023 18:09:57 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6500.031; Sun, 18 Jun 2023
 18:09:57 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com, robh+dt@kernel.org,
        shenwei.wang@nxp.com, vkoul@kernel.org
Subject: [PATCH v8 04/12] dmaengine: fsl-edma: Remove enum edma_version
Date:   Sun, 18 Jun 2023 14:09:17 -0400
Message-Id: <20230618180925.2350169-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230618180925.2350169-1-Frank.Li@nxp.com>
References: <20230618180925.2350169-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::23) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB8PR04MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: 172087d1-cae4-4a57-c2bb-08db70273978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5r/OJF/J4QgzYqtLNeyoulzOgg/Puxh98K+HdW2TqX+bPoWHDG9zBm8SoW7O+1cZ+pL30xJOZbIqvbVOYuZabbcQJ3md/dnDTNyFgAWHnN8oDEeYdD/LpjQaNVnU2gLH85AdXvf2MatvgUFAjKteplavz7nS/TSsQk3UTIVYO7LL2mbI4kxXLMhs4R1VlFkVEP/H1ssSYd8iVbHlpDG5eBNpjzqFaAo089yDdXW165CTN88FkSWmnxKdLiArHqRrXOD3acNoCFQRD4ranr6aHd8ZrvPxYn+NeBpMVw0meHMy8e+EDjpJzr65xwgSRofW00UJr5kInFt1VX7Fk5nQX4b63YncYf1UJxCTk5ik16tlZxOlmhzZPeYbmFsnmG6oLxL+TLpxt19ju5IuuFzyUoqeD8md4Pt69ZKXQspA3oRoF/bLRQjZdctpb5Z0lWVpXDlNvxYE1DWrBAsQLYgK6SMWrlo6mmnM4p0G1VphVeSxQFU6TJrKbj5BzOUxS23DX6ueVtZiQXFH42F4/JjSz9pMiK/toE8Qm5kHez4VgHUlhQ8EG/h+LWW+91rY7Nj7RuPTFzhIxNf3AdISYoKcOBd0jGTIV/xJzfi4+h72/bPoVVEe9Y2popAy8OGKg2vnzsb2YCX8wgtx1URTfaatXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199021)(66946007)(316002)(4326008)(478600001)(66476007)(37006003)(66556008)(86362001)(36756003)(186003)(6506007)(1076003)(83380400001)(26005)(6512007)(6486002)(34206002)(8676002)(8936002)(5660300002)(2906002)(6666004)(52116002)(38100700002)(38350700002)(2616005)(41300700001)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9stiuZVlmjjt8onW3QGZLO1ZJFcRUMxIHzU5OM4uTri9gbajB9bQijWjc8qS?=
 =?us-ascii?Q?11go43eBBP4HMJhh1nBz9VKyQeAOGxD1TwcI+Te46mjcuATWsl0QFT7UwqyI?=
 =?us-ascii?Q?tE1IZNEwYg8IVj+EOP9BrjzloV+Gx0M6RYObNAY6QTghraoiq/bQIENiRUib?=
 =?us-ascii?Q?dSLj9jzwvfRMv26Yv5RtaqwY++LeOtVMtC+8bk7JKKTjsP3ytHricrOtPn3F?=
 =?us-ascii?Q?jUq72fSuQ/8pqu5/ZqmJ90q91AfzYif/fj4zNj7ZpxZxROC2bv1SDvvH9x11?=
 =?us-ascii?Q?Rk77MsydTH3qHBLdEHNsLP4fWcDxfjYeVXGbnwxm869cHvYvywT75HcmRWQn?=
 =?us-ascii?Q?5tKsOipZck4lbFkEv8Odi/tX24m7F/DoTl2LffBTdMdVsXWZxSkOod+4M6lb?=
 =?us-ascii?Q?ff79GnRh0nmvwWqR0X7KUTU4tofkHAZU2q3IBefWRE41gJ5fcLdLqKuhGAyH?=
 =?us-ascii?Q?5y/ZGaKug4rlcszSLJPMYp5pR2ij1/vbw48k1WCEBZemA+k7nUyFNmwep1y5?=
 =?us-ascii?Q?hK0dnzT/VmYobo2PCLGZwNAn7IBHuIRoqVOea3scGSSjsnCkaguTebMj/LwB?=
 =?us-ascii?Q?3+8RxoXAIbreganLBJc+TxZtjXVJUlQpB/qgEgjdbHQgxYdHsre5aDX0dcC9?=
 =?us-ascii?Q?dLcYGHA+n5Zq9Ifj0bCpQV4zD5UB84ZO6Y1M+F6LA9xI3UVEKhaM89pPjUrW?=
 =?us-ascii?Q?nWvRqKuPJdGdw1azc22kKJLgmNvu9R03GOmK8DsADxp2Ia4mgSkQi/cyNAdq?=
 =?us-ascii?Q?z/izJCJDZ6IEiJgUchDxfdHs6V9XujlAX9tUALkMTUbTUD2a1lI5QCUOySuW?=
 =?us-ascii?Q?KZNBE2bISsPVpZls7eo/cs+6wr79nVhf4U/QyxWMPMQltjOFNrQoCevzOywl?=
 =?us-ascii?Q?LUFXAzOPE9F0gVFEMcysViJjtoFYAxtdZikW7GzJQ117zcVTPjMP7YVXmZ55?=
 =?us-ascii?Q?3lbeqd+xNHbJ/Nr4E/wyoLoPAf/NJzLjuNWU8d5RChxYEAT+CONF9lHNNcNi?=
 =?us-ascii?Q?y9JYjL/IAEg458X3BOp8YUvv1jCm1YeQrcW7nEJR47vq0iH9rLljEiixlbsQ?=
 =?us-ascii?Q?r1nyHsUQ+glbRlpxLQ1qIV/Bl+CKlshEc3Fob6VJmaUCMP0KJev7/AE1CYKr?=
 =?us-ascii?Q?+KYc8QeGV3fdj0a6ReRefNYHKwiF5SgMwf4H2HdgQIzIY5xzyAvLVPBu8S4t?=
 =?us-ascii?Q?1PwsahMEJyghjS3BeXP7Adnk7bd6jF98PTGDHewFSC1MkkjMQdMSjrIBoE+i?=
 =?us-ascii?Q?6kHq79kXUPC07RJmYqOdXjsD3jv46E7I5U7QRGcelox7DqHnNgH4HUoesYXg?=
 =?us-ascii?Q?E1SFXL0g+tGXAPeh0kIWZ5h7YHb6DScJRlEBsv3bo0fvUdNx/fXrlwiAnhD5?=
 =?us-ascii?Q?fva+oYnDSW1qODes7toIQbzUbj806Vzt99kS6k/RqlXXi9dRSFAzjd7wFfiV?=
 =?us-ascii?Q?HvOtwBRUakFBnyt+2PKzjnzHkT/co8Jv6mahlj5tFzAkQePcWk7oO4BPJ1kt?=
 =?us-ascii?Q?2hbe5jEXBs4Lr4BypNCjyMC2Sg4sEf5oc5w6RQKUgyXgYrVokM84OVvpkuWB?=
 =?us-ascii?Q?6BKaiBSEsfTNaZf56gjTG6aP1CXmH8vPOS5KJVMe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 172087d1-cae4-4a57-c2bb-08db70273978
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2023 18:09:57.5020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: he+U1wIXMw7gPg5LeZ6B//+BzmSJphLFqcA2tC5CmVWHithzJslos7HngY9SzzOpv+rhU8B+bc9SEjpf7cZO7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7019
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

