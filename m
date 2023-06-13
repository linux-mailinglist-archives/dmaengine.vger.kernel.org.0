Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD5572EE0E
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jun 2023 23:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjFMVfI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jun 2023 17:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241164AbjFMVfA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Jun 2023 17:35:00 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D86B26AB;
        Tue, 13 Jun 2023 14:34:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBJs7k7//Ulnz/ic0jTJelv25D8/7yZbsy3crtVmwJfBRKm9n18+z8uHEyRMr0kRa5CVXHL7NpvFvP/LRCflsLl9NkQPDdTy09thbTI+v0ftWY/5JPUkI4ikBBgXh9eCn2gKTfWwWqQYa3e0dbwD+1V8jv32CIOdGRpAnh7FfIF5d7tH+FcHPYsrxMo1hvN3H/sBnNwwUGoFARyhW93QI8c2Wn8qac1lxepnKm+9icxqYI7DXUex+K7vmDJhuoBJGV+ECqKyjpdEALTkJgI8kMdTw+C4sKH8eRIu/qN96DlL2QMJTcrYmZ8dYDovPlp9d2ozUdyyX2PrWB8TxV9WwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwWZJ1o2vN7Jj1Wd6gxZKukLqr0NduZpRCO/jcgnVtQ=;
 b=gYW0A6MMVWWtO+gnYtC/BhFUC2fl9rPCDD8j/AI2tgWoT/U9W0Zstmls11q5/k875Ha94h64LcHXYGE4tywMejhVJym4qhS+IABWpSWOv6bZFqmQ10VcAw63xgTuYmvnXTgtk8DzWHTn8nZ4AYDBnCZRwbvFoXQfwa7+oQqv/jG6D9+ZiYkJIcSbpMKELMakAnFRfhT5ZBF6eU8HQQTdwe46Iql0aL8oUmc+gN7cedcBP5cqB8HJ2Rr0UlnWfMxKqB5LMNKv7mcmib1XiXlNtwp4hkJ22aWwhFt/dcpBRLY1RI1+f1vtmYMF1Ei4M9fnwCURjGXJ22XOHuYJbY39Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwWZJ1o2vN7Jj1Wd6gxZKukLqr0NduZpRCO/jcgnVtQ=;
 b=NoH26mFVD4JMmmBDECZ7FKyopA9IWR9wmPsPrxzwkkSW62Kstniw53SMx3IT+lYdBc4Aoop7uguzpiGmXweCpDehqew5uSBANiPY3jn7ink0Dsj5L4zTN9vxM0gPwuelMsKgzUI9RQAUAqFTfDKbbXXZP59mufHN7f+PLqqQRWM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS1PR04MB9479.eurprd04.prod.outlook.com (2603:10a6:20b:4d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 13 Jun
 2023 21:32:35 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.035; Tue, 13 Jun 2023
 21:32:35 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v5 10/12] dmaengine: fsl-edma: move tcd into struct fsl_dma_chan
Date:   Tue, 13 Jun 2023 17:31:47 -0400
Message-Id: <20230613213149.2076358-11-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b98dcc5b-0f75-4589-80dc-08db6c55b3e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qApSwyKzd8px/JGCQRPHtGNjo3GBCrcPpfsf6q0O3cpETpdQ/Ci9PfWP1HaMCrN4eqCVC9BKO7MdpfY+//U30MjwLNDejipyGsrUtnYE2Qt0m6kR+vBAWhn0RI+v/VyjZeyo5MgWYCcg8to/mQsIwzq6cnltAbWXa4SUv3rEU7M46EijWZEe8TmSG1SYRSTwV1Ba29o3CVYgB6RZxDFQuqkDAFDxeaF1jQhf1jK137LJUQoxsZ0IXu6v8U940WoxfafykqeaCaaxl0GEYynDs6Hg6WsPtnnKLebCdwkcqviISkotF0wv5jifi6fV+ljc8pFUJh5xXXXdArrOCzDr1Qq0XbwdWYDbPZMOpzGFMvGntlZgPyUrZ/jzNwRQa1fnNAHQ/TkKJ19wo9qhIS4UWOBol5AHQyCem8khx+8lWdbFmIlKtkP6aR72WNsVIRuw25NbBQmg4x0vDkX3JHY5+IYGUiKeYaehA6S3jycPsQuy/c7VxN8vGviQncA81OiDdLD50mAwhmycDS7WDjjzJ90Ef9JAlGP0zrvocO7nVJ+usnthV1zv7EDfm+Z7+OvPS1u1K2fI6RQ0PpLs7obZDO2Qk9diNW9Ec9IdiiLUUyepE0daQAKafOV7RDZ4QYHY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199021)(2616005)(36756003)(86362001)(66556008)(478600001)(966005)(66946007)(6666004)(66476007)(316002)(6486002)(52116002)(8676002)(41300700001)(2906002)(8936002)(5660300002)(921005)(38100700002)(38350700002)(186003)(83380400001)(26005)(1076003)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PpRMewCpA7YDsRcEf/+ylhiPqgi2MIxU8Vezsj2cu9WQpsaLKFMfaLDd7wcK?=
 =?us-ascii?Q?s4K8VSoVeWWAQhTFKo3fAzI80/CKCiYLN4g7xbyJGaM80TPN3kKQJdCLN5M8?=
 =?us-ascii?Q?kOyJnqkYtWGnlnc1DKAXR8mlJ/PP8c/siiQJ31VU3pYZAXs1tT+Ji1UIpmAP?=
 =?us-ascii?Q?5/sGyjCio08vU2k8CfwZMzwQu/xHrYjtkd8H8mMm/goLHpGUMjGSOh193WFQ?=
 =?us-ascii?Q?WAtiR5jOeNvWapJDLbKmmgmBHQatIrY9vTrp6vjKxJ+moxWEpAzhpOXtORYu?=
 =?us-ascii?Q?86oGg+sFYI0FFQb8msgpXb5nLqs6G05RRdTOwf0x7r3YkMC1MpI5nOm7VUA8?=
 =?us-ascii?Q?Sa3hfnL58MW0pqCRqsPKhVelLOdxrBnlMWH9EAgNIqXIw8410GFDeAAsNt+c?=
 =?us-ascii?Q?njZPzV5Op83+tTh+rTYVZfCatUwun2usCZvaSl+rPtIBF044ZtWlXUmC5whU?=
 =?us-ascii?Q?ohxQH7QwXioHhFKrXW/489apE2y999iU1gcOxeOE0BnEmBDMxoc/Wwwk9j6P?=
 =?us-ascii?Q?0cJCOXhAHxZJdhFfm6JxaEazmHIjDRKOCeVCZNXuiX+n6qr4yEgN6ENFfVnR?=
 =?us-ascii?Q?xm373/dTq3C6RALex3WI2bq6CNJazPjtLUGTJYmVJEPzsnhDtu2L6F6ksMoL?=
 =?us-ascii?Q?czKQkI9dI42JNFSevRDW1SOcxwov1ABCW68e6kESzTiulPtB7oUBMBlqRUcy?=
 =?us-ascii?Q?8NGitsyxM5gsg1LkaSgZQzdc3UkRATSFgjheR17uVIfikIbtVMXizz/7DASH?=
 =?us-ascii?Q?G2DA791TEwT1awhw3vvxgJ20tkYLSQ6DUIOXn8OvwLt12HiD9qT0dzoJ0ywQ?=
 =?us-ascii?Q?jNUSQXGOCrMu6DE1KjvWpC2M76ifQ/D/gXmy+PEjyM8w0BwauSgE1LboQx8D?=
 =?us-ascii?Q?+1udDLeReHSwdJ0Z29tHM4ooiHoohJqlY33IMovusY/2v8KBn7WEvO9h4FS6?=
 =?us-ascii?Q?BVpbC5SRCnGpJ4eLB0Zyf4W8epA5kEokg6oEN2zo6EgWnjrGROROdp8YkVTa?=
 =?us-ascii?Q?YrxCV0nsD1DT7X/yvdGkz4Ang/CzGu5vbVQWNnEbrFtjgwgX9EZlR16yKOBQ?=
 =?us-ascii?Q?xGIlj6PqFsSIXVZaLEE9J/oOsRQ6ry0iGRoBYMAMllOmSNLDyBSP0YNZJDbr?=
 =?us-ascii?Q?TFdX+vruRFipzDAWma17A6o4WZ/WyZfXZQ8SHbO925hzEBNVA7OyQ7bcunl5?=
 =?us-ascii?Q?v81xsKvlkFSo2cn8D6qvQcGGCvpWtbOQCu9zHxRcF6dniQnJTNfUwwNLDGgA?=
 =?us-ascii?Q?T/KBLFh/QErGiO7Zs54i8naPr5AeY0rCvq1jl6oo29txjZCiL21UCxHvIAjb?=
 =?us-ascii?Q?HTXFgljvPwRgDLtapPzBaS/6XwrWt3b/dEhrYDpbDEkV55H/umT6L4YyAU2E?=
 =?us-ascii?Q?ZPxjFurxk+jLh6VnMQwaGoPG4zqOeFdERDaI+GecLz2h2RbfUoxnroe/Yn93?=
 =?us-ascii?Q?BOT8sEhFZF/G/3YHFy4MyySHMJd+WqzuEci1LS9/Db0QJ6tzB9YH0rUrAhT1?=
 =?us-ascii?Q?ikw26kEqH7ondiuqkdbxOG7cyt7e0XdQzQLVCquXNSX1gMdkyQRMm6HVbJ4x?=
 =?us-ascii?Q?fg536aUDN39SEkloa9E=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b98dcc5b-0f75-4589-80dc-08db6c55b3e4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 21:32:35.1029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BfFDIuWxU9+Brv+giarMGwleUw4Gh+aqALqfkxYtG9W7o00uCnWvXBXOwd7y+CHz9W+pHxhDXfXTHIRpuoEHKw==
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

