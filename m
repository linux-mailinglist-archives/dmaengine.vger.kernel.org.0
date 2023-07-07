Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A3A74B6CC
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jul 2023 21:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjGGTCz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Jul 2023 15:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGGTCt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Jul 2023 15:02:49 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2049.outbound.protection.outlook.com [40.107.104.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B57213D;
        Fri,  7 Jul 2023 12:02:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xb+xiCiTv3aEAaQYTyE3m9lO1kV7iiYqvi+2DRKcRgG0en4OlKjYBwTGkrZ2VAr6vqmdQjjq7mk7ym3tTdF/ceTKd47sGO4OgKMwFwZ9eltlCIN7mSH6FfN3E4qy+QYbTkAA6XgvslQfm2YpiwJ2E6DYeOQ8tO1M7nlQzWyu+uLtj3cIaB2FRQAi4KB88uD+doTag37jlSYJdifv/0IeQYbM69hdOJ1OGSDwgBqsjJjl71RzkmQqqfyh24rkRFuibaqpuTZeq5007tq/qYs4V7QmkErKAZG5gALuYYgLt/s03x1marksu+93APEj4Pu2KYPAUAOI/B5e9muicwNgtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrNz5ylXQ5OWYrkUzvCBAPmoqz/ZD+kybMybpY/+CII=;
 b=Ckano1gMYbENP/d+oNmSE+uCtHBB2c9i/M+yzLgQ31I1aIRLDVWtbUU8vKoZMvOuyuJRSLzBTSlQDiVNaqIq+rhGBZIcrs5zKi3D+DLtQHYo6YYK/oOvrKh4XfyWD70DeVIMofzvMj3uM7irs9Z9fqytcefIhNYJErDjmHoD2JxFpJ7Cyv/6pW0iWulbnoLcp5f7Zo3CwSFMNO53FUag6dnV+yUN3nLi4i6ukhz5b1ALzb8rrn/r7f0n+87tT+Uu+jKB945spRjl+ItQbF5WQXDuZjSmV0xK793cBfUHYdJzp0UVRz70FLHMcXkOLcgfrm9J3nO0X2WAWFSTv6+E2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrNz5ylXQ5OWYrkUzvCBAPmoqz/ZD+kybMybpY/+CII=;
 b=qNDrjZvShklaS8+tgnyFjIwRsTOv27KYlI7dOKezCqy1Id3DtRIemEVJJalra/hA76yFwx3NHxyA9GChthAnKl5hdMylKO65JelZHFayH/Wu0Ev7qG7fPmZpVDxu0Lws6bSVBqW+aiTW0rNYjGBqsH8UaBN76TzXTi2h/yvviQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8612.eurprd04.prod.outlook.com (2603:10a6:20b:427::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 19:01:17 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 19:01:17 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: [PATCH v10 10/12] dmaengine: fsl-edma: move tcd into struct fsl_dma_chan
Date:   Fri,  7 Jul 2023 15:00:27 -0400
Message-Id: <20230707190029.476005-11-Frank.Li@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8612:EE_
X-MS-Office365-Filtering-Correlation-Id: 7547b70e-0d70-47b4-2707-08db7f1c8ae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 85i3SeE1fgCr89HASTBVOdbNmCIAwUzfaaIIaVPh/L77V7pjgxaGnATc8KqJd6P6RZP0fuFefUwQoa/VSIFq/gLQYbTzIu/fEJ5ItiupIpZoVmgT0iUxxFqanquDvMeyqqmO8sPtp4CYrFbUB+8gn8/dQUA2jygtSRF6/sucvxwHlVQ3NApKCXMq78OdJhgVNaTe5SMdvv9ImQUIJUfSmIjr6ulzFPTML7yNeqfECnRXs7Lq8drLbyjOPJuB3+V/Cc0QbYi9vb4BxOppRpXc+rcTZjX0OuQg4MWoan+ufQfdqgmPYXwZmmaqsQODJHwRXjk/YzMoxjr4mTCMJRHnf1b8oVmCHj549zymGk15kdJTYsnUOj/lpFBZhw0O0w3YCWSHBpY5cJGnRdWwZ53tyl7lJjUOJDd/ki7yol3pxZOc9qk9HDROrTfh+YJeUmqnoI4CKwzoUrmyHtRT7ZPNLibCARaTwDzCfnRq/blifZINeARdmYkuPc54tkd/6LJoZpuUUXILtRML8+kFudRCEz1I408aEvk80XQkLNVNskA3K94MeGPA5V2FNaHlVu5an9CMIsGlGutd2Gs69OYd8I94DVjwJqs03A4uL0NpHns=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199021)(2906002)(5660300002)(2616005)(86362001)(66946007)(8676002)(8936002)(66556008)(6666004)(26005)(1076003)(478600001)(52116002)(966005)(186003)(6512007)(38100700002)(38350700002)(83380400001)(4326008)(316002)(66476007)(6506007)(36756003)(6486002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EKN/ArwFd/3aqAFknq09Bkomj092jdNuQBD/8bgSMJoXe8LjDwQMD0stGUvg?=
 =?us-ascii?Q?m9NlK3hZtJuv9LSZ5bcHrURCZkdO0wQNnr6bqnE6St/q5tdzUwttkPNGWHIe?=
 =?us-ascii?Q?ZfNCFEhW479KiqalQLzdx3OU1wKb+XOc4nrS4ziyqTM5KcDpQ83UWErR0EiR?=
 =?us-ascii?Q?+zT6+WkbOyLkltxFDZ6ul/ucfDpiRp1vl6gF8XVVJ/TWMccsy0/Re/MwPY7P?=
 =?us-ascii?Q?ld9pawTAXQT7rLW4QAjt5n5YmTeEfaxgYZ/tle7sF8QEWfcFf59+V3kZqAgB?=
 =?us-ascii?Q?Jafgi0TfsB0W/8mkOFTUqb79iaTw9poh7e+Nrp39UiRP/BBqJwndf+KhXfG6?=
 =?us-ascii?Q?H+nZlkfGzlL+DxO8SMF+r0yPv7SOVmXKVB6O4lGTK/OaegEfvysJyVUhpmyg?=
 =?us-ascii?Q?tpu69xEFRqiqgeykGkYSfngMjXJXELoaObyUrxMUjh6aKzsoR9Uj8+bYKexe?=
 =?us-ascii?Q?opeQaYE0dBcvZwADdY4rafyPY8TmCSpMUdYsh+3TO+f3a2be+J2D6/jQTqqX?=
 =?us-ascii?Q?eJr09Q1pJWunaA+GL6BOOzjnyO+Zbhxql3uJe5d2eLLym0Cl2esGh9aSg3tw?=
 =?us-ascii?Q?yZvdf+EHHUOpUjRg/TRpWFptZSiYLdGyLuJ71nsWGsivGssQlR1cQAEpg1Ru?=
 =?us-ascii?Q?WoJXxXLYeupDz0NOc13/NTjFOW0M7K+Q8jQzIBhaaYzMMgNWXlZPxK/YkMAR?=
 =?us-ascii?Q?UtujQM5pCjyIipZKrOs0MFg0Mh43A5KNA/zZ8W+jdBHHGKcl55v9vD0tK3/a?=
 =?us-ascii?Q?Hsgq71uJaEeTyBmu4ej/V/t97xTVLzD56qu7s0EXOWhIVbsUr1ATHl6qyt6F?=
 =?us-ascii?Q?9wUtwOshcP/1pDQ70j22P4J/ZoiB0JcQpg5IIv5ogFzi/WIaEcLXBL2LcTmv?=
 =?us-ascii?Q?O8X8JcAyD83tzzwnVa17Lg+8QPrx8wLzNxOa92k0C1cZbkv4NmJ66fLv0dFx?=
 =?us-ascii?Q?F1l/p47oiP14MZ723S2sRBxbRzrUhsJ9WPhWLZsYvkAhrAelBFnyVK4q2tGB?=
 =?us-ascii?Q?ESy0usFg483z/Iw9TLP2T/TZmqWInEXWI8/eHpiI+wNXSaxi8fLKp7UeL8Qx?=
 =?us-ascii?Q?JaryXBSsp+yYPYRGtTCndD4ytKtU/icli58xSIgHPgR/NjetrkM5oeAeFSrK?=
 =?us-ascii?Q?VNGyhjFUYQktJhAgNXA37ss0eE5wOpno3YCtAAnInrKcIv48bDmQ2+bdcNKz?=
 =?us-ascii?Q?xGM/aV1o7nfcac1zRrDjfuwkFOtn0ZHli3FnQbT4XUahejWSnsTdavAw8Tmz?=
 =?us-ascii?Q?uv3tOPMX8Ld/E5EAL2BEt9SXij7TGOGSlclLXrccyfsofG7uJs6bifZKk7cD?=
 =?us-ascii?Q?ZbtwYW7/8D+Iz3uZ+ylZ5auhs42vmSXxXM7kbiR3SFrnTOl3cIhxUCNKhJO9?=
 =?us-ascii?Q?MkXi4523X9oe2xQf/NyrbIEk7CTG0LPYwuDnCqDLAdLymoWmmIXl1wjELbNh?=
 =?us-ascii?Q?8T6npk/7Tfgt7mTMiDdybperv3+oNJZeMBHlZIuR+VIJmnOb1ET1mgGfTYsD?=
 =?us-ascii?Q?EgdgIabCe6FC0+J5EImTQb5Iv1B/nIwfgDys3qt5JO33dZoQ85pE2yuFIBFH?=
 =?us-ascii?Q?AwU+rhLf97efJNCAzcI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7547b70e-0d70-47b4-2707-08db7f1c8ae1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 19:01:17.0675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iuhw9BF73K2SCVBKgc/OZfuEI08hmomoCs4GqTOjSwOJQS1Nd7H3o0s4Ahql+A5xN9lGj2HQY1x5LYAT8oZ5uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8612
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
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
index e0f914616c5f..13c328728025 100644
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
@@ -736,8 +728,6 @@ void fsl_edma_setup_regs(struct fsl_edma_engine *edma)
 		edma->regs.errh = edma->membase + EDMA64_ERRH;
 		edma->regs.inth = edma->membase + EDMA64_INTH;
 	}
-
-	edma->regs.tcd = edma->membase + EDMA_TCD;
 }
 
 MODULE_LICENSE("GPL v2");
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
index d39bda95600e..7b15f3c1838c 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -321,9 +321,11 @@ static int fsl_edma_probe(struct platform_device *pdev)
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
 
@@ -431,7 +433,7 @@ static int fsl_edma_resume_early(struct device *dev)
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

