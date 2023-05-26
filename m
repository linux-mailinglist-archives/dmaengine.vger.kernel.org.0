Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CAA71289A
	for <lists+dmaengine@lfdr.de>; Fri, 26 May 2023 16:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243935AbjEZOi7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 May 2023 10:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243923AbjEZOiy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 May 2023 10:38:54 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2044.outbound.protection.outlook.com [40.107.104.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62ED710C4;
        Fri, 26 May 2023 07:38:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbWOkhxjYa05hLMBXB4Kbq6RzNZft/uCAquvn6idVvDu+PuFITHqcXnJ6IAJmFQmwV1kR2nnb3oPTN38vcZfe9V3fM3dUZH+4jhykHSnTmNKWSrAzt+vDq9PWLXDrXD2NbHNfNUxnQ1j/FZ/WNR9va9gF2fcibK0h4HukkpnOMO7kA1F+LVbdsojfCytcL2//PrHHWVYVIl7nd2VGpmmPXaCH3zYiga61dq8r9W2iSzZQz3hGc8WeRJ9MHb/qtQ2T+KlOJFqAzuCwkhf7KAM5/MRzKcDY5VY6YmKHBrz4QUA5RzThFWaz56uKZmSX004bX0VKVzM9bkGE+jhzHhuSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msrt5RHHs6IHX/f7JbgffOTIryNu0J13mXMJS9oOE4A=;
 b=PTTtXrwBvpTiL19ZdOCuc4IYxMTwB9W0vsno6slW5Wzr9VxITBX7RqcymibmfYymBrnmfhb4UB8cO2BN5JwpI89lCRXi5hS002K/n7bcMaAfnAOAUlM5+KQx1Z92+qI82Q7qY8FaSCr/52QAt9HQLLH52602ANmxxSwa83NY2vHVgUznUIy8mGvJ5d75QEJToM2GRtfTbnhl5j2iADnCeHF9/mROxs3jv0LdBYCrJfvNa7d43pblP+IcGYaHZFrUsE2st20werzI3pNmduDRkomLOaXFI/yDRrJmI5gEJ1V1zCBv4yYgHNwLh4O5msvR0fDWcWwbyqqQrDSg2+Az8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msrt5RHHs6IHX/f7JbgffOTIryNu0J13mXMJS9oOE4A=;
 b=lvBsHsATzLkT+TyaoNPqjmbdvlvDzAQBEp5bKCmeMKPCh55gtpMAe6PdZE5ESyGNlvKSDWh8UDQi9hk2MAKqbtSDVaAIVDvaV0ELgA6vvgfqDPE221C0QWwbjJKtsLZhSDMykW1Gxd1Tk4fxzS4kyt/c1rJ1PXlqud9P/I8K+6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8070.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Fri, 26 May
 2023 14:37:11 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6411.028; Fri, 26 May 2023
 14:37:11 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v1 05/12] dmaengine: fsl-edma: move common IRQ handler to common.c
Date:   Fri, 26 May 2023 10:36:32 -0400
Message-Id: <20230526143639.1037099-6-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8cbe387d-67fb-4c02-16f3-08db5df6b0db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y4qY9lHNgRfPCcD3PXcIKTg2zYCTySwqEjgYZbAp3OPUPTIE6UY+hZNcgnMHD+ZxsdjXYf5MfStkucxMNgeWqZCWaFc+yKV82DWJsMHBQuxPJrSJSRsEMeG7zCgGyFLaGMPKW1opn4Nb8foNNd1/CCMKB7RI6dyibLg7TxyalGUQg1naJA8P48vN6Nw9Y5EVko8nIhkf0Hrql4bvvdaRUbxt+6SCQczU0fJxk8S3dPfL9PCZBDpqWpi0sscJyuUIlNrYANmBDidBE/ONq6vtJ3+ei7sXwb+Iz05I5+IQV3yM6rvUDSFhk4EMBeLir2BXpXrR30w7g3n6orEpFza3EoLSP3e04pHuLbYgyVCI27goA+whx/H5wTKIwSBlU2gXfS8fJRzKE8tXfj/H5xaKo/tJYd1/qriYJKqIjXvDX1WVu+IHWLbAmjCBqylcv5oXnKQnmR3Cscs+0dUv0BDnrRPGp9yCB9eweQTMy085fc6qym/ye5QqRbLgKf6h157hOp0B7qq16zotYkHzlBzS+2CXmZNTfRBgPN3a4FrPCdhBi9BYO7OVhRlgxmpqHihrKsgKqKW6Ks/shGFdUpzSYiiFjACHulsh8ittT1x2e3bSgGIk9l9ZLcqcjZIkkCglRyKV25QzO3nG0J2XyUwpBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199021)(38350700002)(38100700002)(8936002)(8676002)(5660300002)(478600001)(6486002)(316002)(6666004)(52116002)(41300700001)(921005)(66946007)(66556008)(66476007)(36756003)(2616005)(86362001)(186003)(2906002)(83380400001)(6506007)(6512007)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q+HkumrnFXlk/b8ciXvAACCli/90rfZCtSajkmw79ZzeW14uYPFTMY5121dM?=
 =?us-ascii?Q?um7BpOhML1ybK+6uUpkvXrUZq2IQ2ARVCTf3IMJd+dVEZmFNXDI6D1RyxTKA?=
 =?us-ascii?Q?lqNhoeHD+F2KYNTau6PHr/slN2KM73LbKzalrTmwoHbJ0sIhfuvq0bMY59gw?=
 =?us-ascii?Q?okt9S+qXVH/mg9ViyB4riYbeWigSCVgx/ic6Azvw81RAE1m2eFXpfqoSSI10?=
 =?us-ascii?Q?WI6n+O3uQ24iBcr7GktruuYG5rNorxm8jUI2BNZg8Y8P/tTmoiZb5b08pwlq?=
 =?us-ascii?Q?7TM2fW3gzpb2aD4fZIoTPs6m6Q6jbuyE4uuHFAMSIF2KN3Y+U64El/pV7S6I?=
 =?us-ascii?Q?0i45qsoAgp3FRZ4EZ9+Fu/RJxU2uuD/p2oEZZhen79X9atuINqgWoCQfDtO4?=
 =?us-ascii?Q?isnTTU36suyylLis76oKl+gZDP8ArAyjrHouD/QZlT+ePE4ZaFMzkzQFhRs4?=
 =?us-ascii?Q?wt2sqAszpp1dPeRRNqSA/WSKd+tG14AGukQVEXZ8XcEJ89l1jZui6qGz1puq?=
 =?us-ascii?Q?SHI+BUGL15UFEo5SFd/Wykpn0Bs+8WiXDXiCKtcaz002P54e6do1qP9vJz2L?=
 =?us-ascii?Q?MeTl62S+/oa/S78DVeE4nC9kOPWTwt9gI4RQE3lG2J5PiCTiQV2ZBj/6UgMe?=
 =?us-ascii?Q?NzBGyxIB6nxUMaJrm7thlj5srXw4h7R8DS5xrCx11Nzhkisy9/GDAgPST2qP?=
 =?us-ascii?Q?TddtrgWLH45wlgDn7bKcPvpBqE7ef3sCO0nbW40/I1ShQxj70Ifi7QaRUS6M?=
 =?us-ascii?Q?lz1Z8nLkaaHN/Ciiv/Nq7fucMylTqV7wm9on8uzZMHdWLuf25zNhmM6UCM3H?=
 =?us-ascii?Q?XnzxmgfmTdUblM8lKfPhbRM33ZFIspSX7FmVqyb8BFLZRsaFkHTA6z6GsczX?=
 =?us-ascii?Q?3Yp9UcEp78TsqgwRW7NLANzFrLvcEiHESqRDriwINYqpIimCYjJpWX/lT/Z9?=
 =?us-ascii?Q?6FjjVWni6RAq7q3sXgFsNR+4T6L6+SxPGRcP1x6qfdvIoz74v/G/44nZwMH2?=
 =?us-ascii?Q?iPBHbkZSbHLHgzOpxrJsPIskGhQYeylZOl26ZG3BJzuOBMXv/aTrPT+7hdYg?=
 =?us-ascii?Q?C2B4MsGFPfqnwFJGrkDNgorL/bNsfLihuBvkiolGbbeZuNrJCBhWnwsotujA?=
 =?us-ascii?Q?zQN9XH9kOiHYYQwSTfesXqxxNSKjTdmOJM8Pz2egvdJmS/nW6g3ALKWcGCLH?=
 =?us-ascii?Q?RfIkDIru3kKoggAO625g4xrN1jw9xFgA3MUt9GaV6tSH4ZEF4dyRKnXj3e2R?=
 =?us-ascii?Q?lrnHWmtK3qhPGqdHcqVJtycNgdCCQqOYhnEp4XNGoRslSZsUzSy5+ZvJgafW?=
 =?us-ascii?Q?MFTdbiAvyGjop/8WUaa1BBq+TMdrJNhtzKZWJ9oMiu10SPklME5sYf8RepFT?=
 =?us-ascii?Q?EJz0qDtyWKxSDGrHj52F2D7Bnail3LaOOKg6s7AIKspaaifI5dfe8+CW3mzA?=
 =?us-ascii?Q?7D7+XLungzDgi3ckjrc1kF5k6OSRkfgrl8S37CpNdvjWMBq1CKauaSVEdvVO?=
 =?us-ascii?Q?Cy2flOfvW6ytPS+NkFMXlT6ePlQlWX1TLjofrrEvdPdmPX6Lbg80JRtyFrET?=
 =?us-ascii?Q?FHBuaO4c5bxwkKO375zQsINrHZIBYI0zj+4IH6PG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbe387d-67fb-4c02-16f3-08db5df6b0db
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 14:37:11.5288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wsfZ+Ds89PTNx6v6eETJUFoEZFeHn0leJeflf0ni5WDou9K3386hqZeicUFMPB7Kn+oW6vK/j1G8JCRXiCdiFA==
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

Move the common part of IRQ handler from fsl-edma-main.c and
mcf-edma-main.c to fsl-edma-common.c. This eliminates redundant code, as
the both files contains mostly identical code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 26 ++++++++++++++++++++++++++
 drivers/dma/fsl-edma-common.h |  7 +++++++
 drivers/dma/fsl-edma-main.c   | 30 ++----------------------------
 drivers/dma/mcf-edma-main.c   | 30 ++----------------------------
 4 files changed, 37 insertions(+), 56 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index e5c7497c1ff3..839471c42758 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -42,6 +42,32 @@
 
 #define EDMA_TCD		0x1000
 
+void fsl_edma_tx_chan_handler(struct fsl_edma_chan *fsl_chan)
+{
+	spin_lock(&fsl_chan->vchan.lock);
+
+	if (!fsl_chan->edesc) {
+		/* terminate_all called before */
+		spin_unlock(&fsl_chan->vchan.lock);
+		return;
+	}
+
+	if (!fsl_chan->edesc->iscyclic) {
+		list_del(&fsl_chan->edesc->vdesc.node);
+		vchan_cookie_complete(&fsl_chan->edesc->vdesc);
+		fsl_chan->edesc = NULL;
+		fsl_chan->status = DMA_COMPLETE;
+		fsl_chan->idle = true;
+	} else {
+		vchan_cyclic_callback(&fsl_chan->edesc->vdesc);
+	}
+
+	if (!fsl_chan->edesc)
+		fsl_edma_xfer_desc(fsl_chan);
+
+	spin_unlock(&fsl_chan->vchan.lock);
+}
+
 static void fsl_edma_enable_request(struct fsl_edma_chan *fsl_chan)
 {
 	struct edma_regs *regs = &fsl_chan->edma->regs;
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 2f13e687a721..71e19e20f1cb 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -223,6 +223,13 @@ static inline struct fsl_edma_desc *to_fsl_edma_desc(struct virt_dma_desc *vd)
 	return container_of(vd, struct fsl_edma_desc, vdesc);
 }
 
+static inline void fsl_edma_err_chan_handler(struct fsl_edma_chan *fsl_chan)
+{
+	fsl_chan->status = DMA_ERROR;
+	fsl_chan->idle = true;
+}
+
+void fsl_edma_tx_chan_handler(struct fsl_edma_chan *fsl_chan);
 void fsl_edma_disable_request(struct fsl_edma_chan *fsl_chan);
 void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
 			unsigned int slot, bool enable);
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 31531b8bde78..9c0b6fb4cb8f 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -33,7 +33,6 @@ static irqreturn_t fsl_edma_tx_handler(int irq, void *dev_id)
 	struct fsl_edma_engine *fsl_edma = dev_id;
 	unsigned int intr, ch;
 	struct edma_regs *regs = &fsl_edma->regs;
-	struct fsl_edma_chan *fsl_chan;
 
 	intr = edma_readl(fsl_edma, regs->intl);
 	if (!intr)
@@ -42,31 +41,7 @@ static irqreturn_t fsl_edma_tx_handler(int irq, void *dev_id)
 	for (ch = 0; ch < fsl_edma->n_chans; ch++) {
 		if (intr & (0x1 << ch)) {
 			edma_writeb(fsl_edma, EDMA_CINT_CINT(ch), regs->cint);
-
-			fsl_chan = &fsl_edma->chans[ch];
-
-			spin_lock(&fsl_chan->vchan.lock);
-
-			if (!fsl_chan->edesc) {
-				/* terminate_all called before */
-				spin_unlock(&fsl_chan->vchan.lock);
-				continue;
-			}
-
-			if (!fsl_chan->edesc->iscyclic) {
-				list_del(&fsl_chan->edesc->vdesc.node);
-				vchan_cookie_complete(&fsl_chan->edesc->vdesc);
-				fsl_chan->edesc = NULL;
-				fsl_chan->status = DMA_COMPLETE;
-				fsl_chan->idle = true;
-			} else {
-				vchan_cyclic_callback(&fsl_chan->edesc->vdesc);
-			}
-
-			if (!fsl_chan->edesc)
-				fsl_edma_xfer_desc(fsl_chan);
-
-			spin_unlock(&fsl_chan->vchan.lock);
+			fsl_edma_tx_chan_handler(&fsl_edma->chans[ch]);
 		}
 	}
 	return IRQ_HANDLED;
@@ -86,8 +61,7 @@ static irqreturn_t fsl_edma_err_handler(int irq, void *dev_id)
 		if (err & (0x1 << ch)) {
 			fsl_edma_disable_request(&fsl_edma->chans[ch]);
 			edma_writeb(fsl_edma, EDMA_CERR_CERR(ch), regs->cerr);
-			fsl_edma->chans[ch].status = DMA_ERROR;
-			fsl_edma->chans[ch].idle = true;
+			fsl_edma_err_chan_handler(&fsl_edma->chans[ch]);
 		}
 	}
 	return IRQ_HANDLED;
diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
index ebd8733f72ad..af1b0e8a3021 100644
--- a/drivers/dma/mcf-edma-main.c
+++ b/drivers/dma/mcf-edma-main.c
@@ -19,7 +19,6 @@ static irqreturn_t mcf_edma_tx_handler(int irq, void *dev_id)
 	struct fsl_edma_engine *mcf_edma = dev_id;
 	struct edma_regs *regs = &mcf_edma->regs;
 	unsigned int ch;
-	struct fsl_edma_chan *mcf_chan;
 	u64 intmap;
 
 	intmap = ioread32(regs->inth);
@@ -31,31 +30,7 @@ static irqreturn_t mcf_edma_tx_handler(int irq, void *dev_id)
 	for (ch = 0; ch < mcf_edma->n_chans; ch++) {
 		if (intmap & BIT(ch)) {
 			iowrite8(EDMA_MASK_CH(ch), regs->cint);
-
-			mcf_chan = &mcf_edma->chans[ch];
-
-			spin_lock(&mcf_chan->vchan.lock);
-
-			if (!mcf_chan->edesc) {
-				/* terminate_all called before */
-				spin_unlock(&mcf_chan->vchan.lock);
-				continue;
-			}
-
-			if (!mcf_chan->edesc->iscyclic) {
-				list_del(&mcf_chan->edesc->vdesc.node);
-				vchan_cookie_complete(&mcf_chan->edesc->vdesc);
-				mcf_chan->edesc = NULL;
-				mcf_chan->status = DMA_COMPLETE;
-				mcf_chan->idle = true;
-			} else {
-				vchan_cyclic_callback(&mcf_chan->edesc->vdesc);
-			}
-
-			if (!mcf_chan->edesc)
-				fsl_edma_xfer_desc(mcf_chan);
-
-			spin_unlock(&mcf_chan->vchan.lock);
+			fsl_edma_tx_chan_handler(&mcf_edma->chans[ch]);
 		}
 	}
 
@@ -76,8 +51,7 @@ static irqreturn_t mcf_edma_err_handler(int irq, void *dev_id)
 		if (err & BIT(ch)) {
 			fsl_edma_disable_request(&mcf_edma->chans[ch]);
 			iowrite8(EDMA_CERR_CERR(ch), regs->cerr);
-			mcf_edma->chans[ch].status = DMA_ERROR;
-			mcf_edma->chans[ch].idle = true;
+			fsl_edma_err_chan_handler(&mcf_edma->chans[ch]);
 		}
 	}
 
-- 
2.34.1

