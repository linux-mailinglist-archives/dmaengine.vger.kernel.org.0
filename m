Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B25782E2C
	for <lists+dmaengine@lfdr.de>; Mon, 21 Aug 2023 18:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbjHUQSm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Aug 2023 12:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbjHUQSl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Aug 2023 12:18:41 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2052.outbound.protection.outlook.com [40.107.7.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FE012B;
        Mon, 21 Aug 2023 09:18:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfEJZbYewsOBRlOmrcYP4WpBTBi7WJkxUjtd/mdUraKDOE9KZJyz9hGzA/O9JCQGB2YCl21T+MBA8SSbqzPXeJfuVJG13XiMTpZWkzcD7KXyn6gDQRFEmEOBblsw/x4c+vYWrwegXM5CvZlbtPGPYoY5TSREpfOGkvW2OP+ok4yv3bJGROt4VsBt/wN02uhcSzMaKyuyXxSSldfKqWwqbuJU6sK6bb2K7FmRkg+CS79VLxn9ykUTm1bWKY96W1Kbu7eMmcSWIK8EXhhDxiJJqGhtXOw99EUZU5LBVjz1JHc/5/3X9nzb9GlABqUdaizkQ4d4FqScpD9ueEI42VicHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8AiVCfce1vUOagQqJWk7iO4Cpafo4/S74118RC9b4o=;
 b=nwJknhFUouTPvb6bQyiVg2PipY7TcPcnrFSe6LrKsux0B1SiF2SzWwm+78sCL0rusVYgix3DIqCGlAS5zHODq9tvgQfranYeN8/cyw9GbBF78bAeB3hyLYz80cLKvgffKVXQuUsDiafVrknlBCyBhxykA27gS9Ie+sPox4VKIBdyTaA1tKXE5zTY3daB0XiBkXAkq0mZNmugdS3i5npFatjZ+fLzBBLMq5SXvY+2UbUiBX2ZJ494hn8UcZ12CO53po02UNVqBPMAMP/31AE7hLIdni9cgcmvI6dwzQyso3LCYTxX0nIlE7OvagMM0kfmlShs7TfDjnwGAtUxMa41jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8AiVCfce1vUOagQqJWk7iO4Cpafo4/S74118RC9b4o=;
 b=gBYeiTFFoLkqRh5fg6HZysr/h6I8OCfn1QyhYq5jdmB1PyzH2FbSD1HzmMn5ZJsaxWSDPijCO17CDhZlKYNvIF/9//MiCBhmI9qcqUCuAZqzdzgJnLS75DjEFGipk/DWv4UQaHilxD7GHHX6YHljh4cSkp8IME03x8PONg8SRpo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB10042.eurprd04.prod.outlook.com (2603:10a6:20b:67e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 16:17:08 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 16:17:08 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: [PATCH v11 10/12] dmaengine: fsl-edma: move tcd into struct fsl_dma_chan
Date:   Mon, 21 Aug 2023 12:16:15 -0400
Message-Id: <20230821161617.2142561-11-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 07357dca-dacf-4ab7-0d45-08dba2621164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3h87ZQd7GYRQsByMrkY0ASZEOgqlpZ71y6OwlsxTseEmzKwEcYyMhBqlG6XOAoyO1bYyppeWMjGztbcLIlFqDVJRUF/uivyuRxd4jMgaSM5+zy9mP8fsqCE4Rh2NcVUF0IukdDPyZY74mHeOvwwyocQaSu+ItoJQZgXA4LrQJZwm4JIuGG7sIRwXvHS7SqceiQnZi0iB8HLAgKLQsay+UkP6rFpfW5sgv1ByBqZk5k++indS8ADiuZDqMDxB2ZoQgPUbJjPZvxV1Ignx6dZL91P+yoKJX11s5kvjLeEJu33LVEPp6e1227SfNYwxP7vuMbH19iHv1dXooFJfN1z+NFd9o3tiDyUOOMCtjodoCL72jUM/k5f/p/AEtxzRe4yjYe+6nYAcEB6MP2ya7aIEWheX5GhYQsIqxqh0u4Hvo9egx/c+wDwUeau//vnZcD+tc/O9ZHZoBJKaegD0xK3RjpWOMk729eKOVlHzk08sUKY0XuiHyj7kVehToAlOGVMY5TeqJKoL5V3dmNrJonz47tQBTxo51vflT7H4EeFFT0ODRe7qFPSJbA+D09lDH6zOEey8Ay1WAJxPPzw3O2EUAbxxefDOhKz1/2WHC/Yq104=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199024)(1800799009)(186009)(2906002)(52116002)(38350700002)(38100700002)(6486002)(6506007)(83380400001)(5660300002)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(316002)(6512007)(66946007)(66556008)(66476007)(966005)(478600001)(6666004)(36756003)(41300700001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H/BFvoxtx7I9CUXu0lCfYgsxYyJHVmjRIin7yduJPCQ+ZfveTMU1wrIEckgo?=
 =?us-ascii?Q?hyVnZHwT0+iMnqSMtEamTvnuxtnU7f6VxBeAJEiL8B1GAtUwB+0AFdOVkI6w?=
 =?us-ascii?Q?xz1FH3j7OFEEYzsZJnCdn4Wn0uPaieVnpQA/7F9N/7jN4IY8C7hMqv/vOQ6c?=
 =?us-ascii?Q?GdcriuscJ9fxvMKEp17L8lx3XqPwO7dNbYxYwKJK/X2nkjMarK+zsXDH8ePb?=
 =?us-ascii?Q?D5+IlGJ/JywPe+MK9K6U45Z/qQKUHJCxQV/5M8VTkGH2kxN+Tj5Mcmt1M0w+?=
 =?us-ascii?Q?CjVpnir7csi5V2ahFXZub7PPm6wIQNu9dvv6Ehqn+HGAvyI9tLzZbRTl3L6+?=
 =?us-ascii?Q?b+7RE1Kht05zAX96htcOAAXm/q86dma1D/fxzVD2FXYXXWiNANhtVIpyCMLV?=
 =?us-ascii?Q?XHDQtA5PERBaT3aZ+Lrd4fmQ9nfJgoUJCWwQHaXcGJ3soMFf7zKmc5nDNLyc?=
 =?us-ascii?Q?FJzJCRheXCyC4AUB7wgYoa8V+ZEEucjGIgj8DS6zMjEhbRfV8MBHLxRE41kJ?=
 =?us-ascii?Q?53PYesMPNvaneSwZDA/CdggqaLRphPIpatk10gtNWC4cQD1XqSuqp34B9zpA?=
 =?us-ascii?Q?Lruz7rXJuRovw1MCTz6L1Z3lF3mLd/+syE6OCIEaM2xFJF35POUc4rLK8Jcq?=
 =?us-ascii?Q?s/AFeikL4RQgxnKpuuPxKuGOWgEr3V8XwoNjMV314nFN3QYoNCukrdbiW8pr?=
 =?us-ascii?Q?aKo2wbBvM0DV94i79KDozPMLNUnrg6T3hEto9jcjCWPwjqA1T2nKNz5eQNpB?=
 =?us-ascii?Q?3/xPvsfqTnuVT/LVLFzhPgwXZJUkmRE4ZVW+OqBy1gSramI80CGHG2SXd/QE?=
 =?us-ascii?Q?AkrHD0dQysU246qTp6yMSH4I2UeZgIE0QIJoxQwki/hxm06hJ3GrmeDNKw8x?=
 =?us-ascii?Q?FuU/UZEHcVD8he4rCPt/ld4MtEIGbyaJ8p6pselZ6PynWq9Hcz1Squ3owUSp?=
 =?us-ascii?Q?qYeL7P0Ob0WdO2rUq8KVk2OzLGxz6TWCVYD6aJDIeNpOihIWrb72h6iq7gzg?=
 =?us-ascii?Q?XI3ejfBuLaDSQEASRVUBXgGGHQFit3V3mD3DOO4DpC0OEnjM5kvJ7CzW9SeA?=
 =?us-ascii?Q?r478Lic/99VmiFJ7C6PNGqI1wEqTI0nByUINTxm2oM+nCuQZLmCXTlm0lb1W?=
 =?us-ascii?Q?Olt9tg5oxZKBud1Oql1o/e7zZo4VchqZ6GyKnwefkBv7XpRb1jIJJbgO+IGd?=
 =?us-ascii?Q?ASlZ5u2+Y9p5teEKj/B/3FZEGJDPwVEFZrynsfCFH2dEgQ3MGAMqrLTJmE/k?=
 =?us-ascii?Q?5EBLEqBBdInYyl8WtLwrpyP5ptZt9B32NzUQChxr/XioJ+n+zwIr4sL1e+9L?=
 =?us-ascii?Q?B4d2G/rYbtLOVHsrn0n+/TsJ3LSB7mjTu+x8p7vGcNfTfXkhHml3GFDihIzZ?=
 =?us-ascii?Q?1mTyGqmvL3OQLqKc1uesUiS5Lxs/lRiCe0HDhww+7wS2smenNj335XiyN3vk?=
 =?us-ascii?Q?nZYCvSRggqZ5FsUYZSdIRRnqhQQbOndTiRHbdijD2kv9HBOOzMElL8fve7Fq?=
 =?us-ascii?Q?BdtVYBFMolJVvRfCgNDgslyixrP8SsizQniZsu9ghqEeT0uWwydXSE4RFcNU?=
 =?us-ascii?Q?qDW8ceSdO6QSWi2t81oQIZ/s6d4O/IJHicWv0xOa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07357dca-dacf-4ab7-0d45-08dba2621164
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 16:17:08.7078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F40adjL8ZnRk9KywcNEua9uiyEVrpkjnMlYaWU4VkSSRImhGHgwh0umoXAO49y4SWh+kbqas9XE0kQrN61aUYQ==
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
index d68ea16ddf1b..72b7587226df 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -320,9 +320,11 @@ static int fsl_edma_probe(struct platform_device *pdev)
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
 
@@ -430,7 +432,7 @@ static int fsl_edma_resume_early(struct device *dev)
 	for (i = 0; i < fsl_edma->n_chans; i++) {
 		fsl_chan = &fsl_edma->chans[i];
 		fsl_chan->pm_state = RUNNING;
-		edma_writew(fsl_edma, 0x0, &regs->tcd[i].csr);
+		edma_write_tcdreg(fsl_chan, 0, csr);
 		if (fsl_chan->slave_id != 0)
 			fsl_edma_chan_mux(fsl_chan, fsl_chan->slave_id, true);
 	}
diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
index ec8a8e1930b5..a903461da5bd 100644
--- a/drivers/dma/mcf-edma-main.c
+++ b/drivers/dma/mcf-edma-main.c
@@ -199,7 +199,9 @@ static int mcf_edma_probe(struct platform_device *pdev)
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

