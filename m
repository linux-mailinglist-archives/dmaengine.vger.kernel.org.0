Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5D57334FF
	for <lists+dmaengine@lfdr.de>; Fri, 16 Jun 2023 17:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbjFPPhI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Jun 2023 11:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346070AbjFPPhD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Jun 2023 11:37:03 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A47B3C0F;
        Fri, 16 Jun 2023 08:36:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejaJlj3xR+dps6WmueMiXpwWEONrxR4a7tC/FU9l3b6kU7zEOIBYZC/xeG3JYgVlIe/4WSd89P2wQ14MqdNayuyusnR3uEkKbFjuCsr4i1sENL4Wyy38U4yz6Uv2MGCimUFO89GA9CZMMevW+EjDrkTOy7h9WvuTYti94XJH2hYF2NdnGbwEcjLfultj8f6W1BAKQzcheDG6nfe00NG+8bhnzZcfwAdeGf92IvEaWdRgXP1XDHctZXbktX0APjySS1qnzYd18EgZ9UCyEfkjPoXb19VuAjoj91JK1siR+Wa9ws9+VH/5XurXjOHZND/Gf+3pjcYKuEeiWRa5+IrDkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwWZJ1o2vN7Jj1Wd6gxZKukLqr0NduZpRCO/jcgnVtQ=;
 b=GJ64CVVselD7dUxy8QCXfqFLI08bxpH8NHBOycTI9zxlBWYsDU0kSWvLeN3IC2xiMauvWfxYLY5ufgKD/3nNn1GVU9wmXK28XZ4OddyJV2A4v/VtSTSaL5BkqV7+PBiOqd+iMYCtXRQtFmIRNvi/Rd5+AUYYAlbK8RcWJfDK/WK5e9gz0G9DFZQ2dCOSUeE1mggoOAMyP5qZTcZ+aNfpgd20tyHIXqzzM6BpnXYsAS5rFcLAj8Vjg4XeoHy/KmYMSHS6/PwzoJG+gpffLwAxCce07CD7QdkC0DgpOlTqaNC3H406De79IfoTJTaYMCU0RuuBWHWbFrGWI87PWuBMBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwWZJ1o2vN7Jj1Wd6gxZKukLqr0NduZpRCO/jcgnVtQ=;
 b=jP3ch+5h6mDGQNj8/n4nosztz+sczuwmjr1zKyoP56XgjRwSKsJ+1BD2kYhNm2gGK7pS3t0Wu0Y1KvxbeEpkCXhpLUtReETNiTRGiQfBdnPJ0GajpM/OLjPD2VrNGIqveBiVzv1gf3eIeiJ1fQGbML0KR91a4I1hEggOBg581CY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PR3PR04MB7339.eurprd04.prod.outlook.com (2603:10a6:102:8b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Fri, 16 Jun
 2023 15:35:23 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.035; Fri, 16 Jun 2023
 15:35:23 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v7 10/12] dmaengine: fsl-edma: move tcd into struct fsl_dma_chan
Date:   Fri, 16 Jun 2023 11:34:36 -0400
Message-Id: <20230616153438.2299922-11-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6f7802b2-e41e-455b-4204-08db6e7f4d20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BJeP33faT6vii8tWWnydh8f2BzQ0b7lyJCiTX7OTQVQI+Ndx8yNp8L5eF/gVBCAUeYUEmr1sXJgpIf+Rr5/nK4pk9Hod/Re18enpZ/dyGPhoNbS60nonqgqYnz+QKcrHTOvWGdLt7wmJ7L7ujTu3hWGuNuNg9K8yv80sChk4OAA+wg+NhXnvnhAzyPNgxIxkw9hghgzc9tT85vqD2YeTjx2rHbQt8sV3ApDvcPQRLP1ayhsgq+YVMjn+ZjfoseozwY1C+YPydRs2rd67OgmBx9kFtimANQkMZqOhJDefNzxUzLaGqG54BRoERx3az3MJTpY5Os6NBx/tjZndDlo1jsgWCgY+ZtP9dwERHSIn0Lb2Dj8T29y7wEdDZIKtLz8h7CjShlRnd+FT9+8fHiXi8pwDGSgWbpnaHEkGB+ZG3Kiep6VrzEYg+rb7ft0fCRW6Hi/TQRpagE7FmBeRS10gbYXbRtCmt9qEXlVxUgebME/VRryKnEtFOBXfsq4q5qj9pSyvZ8fHqP7l/JTC5X01TQ52RA9WrTBijtHm0mmfTQzbn4Flce56i+tVPU/tPmXyBpZ1+rmevoZeXdA7HoDLbOT27Wg+hrQnygZRCXHh0qpbe8r93wbwHVr9VPZSIxuJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(38100700002)(66476007)(66556008)(921005)(66946007)(316002)(2616005)(38350700002)(86362001)(966005)(186003)(52116002)(36756003)(6486002)(6666004)(26005)(6506007)(6512007)(1076003)(478600001)(2906002)(8936002)(8676002)(5660300002)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Me1gvLefRBRNp61LzEdO+9wRbB+PWsCLXi0gC2z539CKLPEQUGCPFc2J01Dw?=
 =?us-ascii?Q?ZktxkWzQafH72rM3QGs+kyKtk0bBETSTht1LCJBK/2O00OYgwpMQ8Q+xfrvT?=
 =?us-ascii?Q?xHWmNsrUsPVpeQzCvur+XHwFcnRDzJgMtBBctIlc83JSz5ehPdJ3oo98oH5D?=
 =?us-ascii?Q?N6g6uKm8m8vwNltKu4lnCIRNZf9E5SCNsUkmWJQ+rQ/TuzQIfeRS7mR9uFAO?=
 =?us-ascii?Q?PoyrB+DWg5zUWcdKgnSHkhYwPS+KkXTRTRbw/3zSPC03XxZQjRBc+tRTVxO5?=
 =?us-ascii?Q?QwqtC+YdKTe1LayrVZEzPUuwqw5ZdgSo2AT5HPUQassi+DYYrUnHpqnYE+zA?=
 =?us-ascii?Q?RBoud58dT0zCBXyHXAbXH23N0pitRq73OCjg6H+pB2hk/bUfAN1HlPggi5UQ?=
 =?us-ascii?Q?/x7LcEPIcztuhfEH2UDMwv272DnOKfK78IZEqSWrOA15iHYYJcUr/5rw9UBY?=
 =?us-ascii?Q?bCxJ3zp+ggf2tVKnWE+VCpjXuQ4SWk8M1zldmeC4rVHse97OZR3xFNBdllmZ?=
 =?us-ascii?Q?zyEnTAUp42D7177+m4tVlplC24T4BiiuX7tuQOXlFa7xNplmjlLsCHtHaMxu?=
 =?us-ascii?Q?V5BhRCLjIEo8LswBPFkVzcNwLdycxh5De/p5OwiIc3CyFvYStHGixeCbzg7R?=
 =?us-ascii?Q?xRiMOSph1diRckmw0wlw27Htvp/tJ1xare2ckbIKnI14FjTJnIKVLscKnO0Q?=
 =?us-ascii?Q?N4xWkZ7mBYsBPDDPU3IwBzY9g+G0St7MQRws4597FxqdQpPMini8WpTeMEjk?=
 =?us-ascii?Q?kvuliIoZhZjjEvt8y2U96Ldj1VA8GHqQBAAwxOHawzPuOGCqlbgziu1/HLsV?=
 =?us-ascii?Q?mMDQxNgU7GTdYQIWS7YhgpioDYrlM+3tszhRBMwTLxxxHd6/TaoPOqODA+QC?=
 =?us-ascii?Q?SzDxf7JidGhQ6Feu9vytgy4YUJU3mv61kJVaUHP+d8F16VtqLFkhH+YXVKLg?=
 =?us-ascii?Q?xVMHr+0s7JaQU6AXIGJUgzWeFXWXRCPL37u0XkJzj8ayWuJQFmZ1+AtwDubB?=
 =?us-ascii?Q?ADu8sf8YCRyfmA4cB8DCikckcAdJmdGDt4NoKDO8rhwpgvtAIXVVTSFssaH5?=
 =?us-ascii?Q?4m7eDZouzGo9KQyxOKI5Z64HMZb+2GolRWkYYfxgZrRsPFZ5ceED0Ya8la+w?=
 =?us-ascii?Q?DE4HkQlIUTfhvjFZB+1Mu8eixrbIiUd66GsvuV2GORJObPQPaNxvXuPAWzqS?=
 =?us-ascii?Q?1u0ohHSQdUaT5TRNrtrF247Fft95UO3vsSAjkvDMGnXXPpY3N+ONqbnp06zC?=
 =?us-ascii?Q?T8V2yuD95OCXWWval159Bdr5TRA0a9e4HgeYbP2sGLhIYA1BXyna97aTrUp5?=
 =?us-ascii?Q?mD7jQYV5HYY9C+LKrhGPwQglAM4zfKsAfgroVVECfSBuwcekXxz9pXDzW5A3?=
 =?us-ascii?Q?kVE3cyj/h1fcO5Mt9vubcxpBHPdZ84wYiwQv0jhR1oopd50+iF6pGx0y+v5U?=
 =?us-ascii?Q?mUWP3f4cEM0N9sDKb/x+crxPvPxEKiYXLgXUcPxLYYChDvdbaceWVafELZat?=
 =?us-ascii?Q?ak41hEPU8DBHFx2lTtXC49HISrh97e+XLQ83tKAK2kz7UrYqVy+31wwIaP31?=
 =?us-ascii?Q?ju/OVYwrzjtBwvmhcF4GrvaMroT8oN5pObue3ECc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7802b2-e41e-455b-4204-08db6e7f4d20
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 15:35:23.8721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TxHYCUC5Fv7Wg2hNpXdrLGUNkhLThExbssZncjgHxlmT6teRhNBvv3yxg5AnPn8EGXqV16YqcCwZyflSNS1eIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7339
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Relocates the tcd into the fsl_dma_chan structure. This adjustment reduces
the need to reference back to fsl_edma_engine, paving the way for EDMA V3
support.

Unified the edma_writel and edma_writew functions for accessing TCD
(Transfer Control Descriptor) registers. A new macro is added that can
automatically detect whether a 32-bit or 16-bit access should be used
based on the structure field definition. This provide better support
64-bit TCD with future v5 version.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202305271951.gmRobs3a-lkp@intel.com/
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 38 +++++++++++++----------------------
 drivers/dma/fsl-edma-common.h | 22 +++++++++++++++++++-
 drivers/dma/fsl-edma-main.c   |  6 ++++--
 drivers/dma/mcf-edma-main.c   |  4 +++-
 4 files changed, 42 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 51fbd7531c74..eead6a4765f7 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -40,8 +40,6 @@
 #define EDMA64_ERRH		0x28
 #define EDMA64_ERRL		0x2c
 
-#define EDMA_TCD		0x1000
-
 void fsl_edma_tx_chan_handler(struct fsl_edma_chan *fsl_chan)
 {
 	spin_lock(&fsl_chan->vchan.lock);
@@ -285,8 +283,6 @@ static size_t fsl_edma_desc_residue(struct fsl_edma_chan *fsl_chan,
 		struct virt_dma_desc *vdesc, bool in_progress)
 {
 	struct fsl_edma_desc *edesc = fsl_chan->edesc;
-	struct edma_regs *regs = &fsl_chan->edma->regs;
-	u32 ch = fsl_chan->vchan.chan.chan_id;
 	enum dma_transfer_direction dir = edesc->dirn;
 	dma_addr_t cur_addr, dma_addr;
 	size_t len, size;
@@ -301,9 +297,9 @@ static size_t fsl_edma_desc_residue(struct fsl_edma_chan *fsl_chan,
 		return len;
 
 	if (dir == DMA_MEM_TO_DEV)
-		cur_addr = edma_readl(fsl_chan->edma, &regs->tcd[ch].saddr);
+		cur_addr = edma_read_tcdreg(fsl_chan, saddr);
 	else
-		cur_addr = edma_readl(fsl_chan->edma, &regs->tcd[ch].daddr);
+		cur_addr = edma_read_tcdreg(fsl_chan, daddr);
 
 	/* figure out the finished and calculate the residue */
 	for (i = 0; i < fsl_chan->edesc->n_tcds; i++) {
@@ -358,9 +354,6 @@ enum dma_status fsl_edma_tx_status(struct dma_chan *chan,
 static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
 				  struct fsl_edma_hw_tcd *tcd)
 {
-	struct fsl_edma_engine *edma = fsl_chan->edma;
-	struct edma_regs *regs = &fsl_chan->edma->regs;
-	u32 ch = fsl_chan->vchan.chan.chan_id;
 	u16 csr = 0;
 
 	/*
@@ -369,23 +362,22 @@ static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
 	 * big- or little-endian obeying the eDMA engine model endian,
 	 * and this is performed from specific edma_write functions
 	 */
-	edma_writew(edma, 0,  &regs->tcd[ch].csr);
+	edma_write_tcdreg(fsl_chan, 0, csr);
 
-	edma_writel(edma, (s32)tcd->saddr, &regs->tcd[ch].saddr);
-	edma_writel(edma, (s32)tcd->daddr, &regs->tcd[ch].daddr);
+	edma_write_tcdreg(fsl_chan, tcd->saddr, saddr);
+	edma_write_tcdreg(fsl_chan, tcd->daddr, daddr);
 
-	edma_writew(edma, (s16)tcd->attr, &regs->tcd[ch].attr);
-	edma_writew(edma, tcd->soff, &regs->tcd[ch].soff);
+	edma_write_tcdreg(fsl_chan, tcd->attr, attr);
+	edma_write_tcdreg(fsl_chan, tcd->soff, soff);
 
-	edma_writel(edma, (s32)tcd->nbytes, &regs->tcd[ch].nbytes);
-	edma_writel(edma, (s32)tcd->slast, &regs->tcd[ch].slast);
+	edma_write_tcdreg(fsl_chan, tcd->nbytes, nbytes);
+	edma_write_tcdreg(fsl_chan, tcd->slast, slast);
 
-	edma_writew(edma, (s16)tcd->citer, &regs->tcd[ch].citer);
-	edma_writew(edma, (s16)tcd->biter, &regs->tcd[ch].biter);
-	edma_writew(edma, (s16)tcd->doff, &regs->tcd[ch].doff);
+	edma_write_tcdreg(fsl_chan, tcd->citer, citer);
+	edma_write_tcdreg(fsl_chan, tcd->biter, biter);
+	edma_write_tcdreg(fsl_chan, tcd->doff, doff);
 
-	edma_writel(edma, (s32)tcd->dlast_sga,
-			&regs->tcd[ch].dlast_sga);
+	edma_write_tcdreg(fsl_chan, tcd->dlast_sga, dlast_sga);
 
 	if (fsl_chan->is_sw) {
 		csr = le16_to_cpu(tcd->csr);
@@ -393,7 +385,7 @@ static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
 		tcd->csr = cpu_to_le16(csr);
 	}
 
-	edma_writew(edma, (s16)tcd->csr, &regs->tcd[ch].csr);
+	edma_write_tcdreg(fsl_chan, tcd->csr, csr);
 }
 
 static inline
@@ -736,7 +728,5 @@ void fsl_edma_setup_regs(struct fsl_edma_engine *edma)
 		edma->regs.errh = edma->membase + EDMA64_ERRH;
 		edma->regs.inth = edma->membase + EDMA64_INTH;
 	}
-
-	edma->regs.tcd = edma->membase + EDMA_TCD;
 }
 
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 316df42ae5cb..cfc41915eaa1 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -48,6 +48,8 @@
 
 #define DMAMUX_NR	2
 
+#define EDMA_TCD                0x1000
+
 #define FSL_EDMA_BUSWIDTHS	(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
 				 BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
 				 BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) | \
@@ -93,7 +95,6 @@ struct edma_regs {
 	void __iomem *intl;
 	void __iomem *errh;
 	void __iomem *errl;
-	struct fsl_edma_hw_tcd __iomem *tcd;
 };
 
 struct fsl_edma_sw_tcd {
@@ -117,6 +118,7 @@ struct fsl_edma_chan {
 	u32				dma_dev_size;
 	enum dma_data_direction		dma_dir;
 	char				chan_name[32];
+	struct fsl_edma_hw_tcd __iomem *tcd;
 };
 
 struct fsl_edma_desc {
@@ -156,6 +158,16 @@ struct fsl_edma_engine {
 	struct fsl_edma_chan	chans[];
 };
 
+#define edma_read_tcdreg(chan, __name)				\
+(sizeof(chan->tcd->__name) == sizeof(u32) ?			\
+	edma_readl(chan->edma, &chan->tcd->__name) :		\
+	edma_readw(chan->edma, &chan->tcd->__name))
+
+#define edma_write_tcdreg(chan, val, __name)			\
+(sizeof(chan->tcd->__name) == sizeof(u32) ?			\
+	edma_writel(chan->edma, (u32 __force)val, &chan->tcd->__name) :	\
+	edma_writew(chan->edma, (u16 __force)val, &chan->tcd->__name))
+
 /*
  * R/W functions for big- or little-endian registers:
  * The eDMA controller's endian is independent of the CPU core's endian.
@@ -170,6 +182,14 @@ static inline u32 edma_readl(struct fsl_edma_engine *edma, void __iomem *addr)
 		return ioread32(addr);
 }
 
+static inline u16 edma_readw(struct fsl_edma_engine *edma, void __iomem *addr)
+{
+	if (edma->big_endian)
+		return ioread16be(addr);
+	else
+		return ioread16(addr);
+}
+
 static inline void edma_writeb(struct fsl_edma_engine *edma,
 			       u8 val, void __iomem *addr)
 {
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index e2fbfaf9155d..8ba705080f5d 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -310,9 +310,11 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		fsl_chan->idle = true;
 		fsl_chan->dma_dir = DMA_NONE;
 		fsl_chan->vchan.desc_free = fsl_edma_free_desc;
+		fsl_chan->tcd = fsl_edma->membase + EDMA_TCD
+				+ i * sizeof(struct fsl_edma_hw_tcd);
 		vchan_init(&fsl_chan->vchan, &fsl_edma->dma_dev);
 
-		edma_writew(fsl_edma, 0x0, &regs->tcd[i].csr);
+		edma_write_tcdreg(fsl_chan, 0, csr);
 		fsl_edma_chan_mux(fsl_chan, 0, false);
 	}
 
@@ -419,7 +421,7 @@ static int fsl_edma_resume_early(struct device *dev)
 	for (i = 0; i < fsl_edma->n_chans; i++) {
 		fsl_chan = &fsl_edma->chans[i];
 		fsl_chan->pm_state = RUNNING;
-		edma_writew(fsl_edma, 0x0, &regs->tcd[i].csr);
+		edma_write_tcdreg(fsl_chan, 0, csr);
 		if (fsl_chan->slave_id != 0)
 			fsl_edma_chan_mux(fsl_chan, fsl_chan->slave_id, true);
 	}
diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
index 316e637b00c4..bccb5448e492 100644
--- a/drivers/dma/mcf-edma-main.c
+++ b/drivers/dma/mcf-edma-main.c
@@ -200,7 +200,9 @@ static int mcf_edma_probe(struct platform_device *pdev)
 		mcf_chan->dma_dir = DMA_NONE;
 		mcf_chan->vchan.desc_free = fsl_edma_free_desc;
 		vchan_init(&mcf_chan->vchan, &mcf_edma->dma_dev);
-		iowrite32(0x0, &regs->tcd[i].csr);
+		mcf_chan->tcd = mcf_edma->membase + EDMA_TCD
+				+ i * sizeof(struct fsl_edma_hw_tcd);
+		iowrite32(0x0, &mcf_chan->tcd->csr);
 	}
 
 	iowrite32(~0, regs->inth);
-- 
2.34.1

