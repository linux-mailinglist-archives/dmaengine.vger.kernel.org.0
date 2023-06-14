Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EC273086A
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jun 2023 21:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237348AbjFNTgh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jun 2023 15:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236965AbjFNTgb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Jun 2023 15:36:31 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2057.outbound.protection.outlook.com [40.107.7.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9869FE4D;
        Wed, 14 Jun 2023 12:36:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpYiqUoRP9Zfby/ws5GF2wLvXyJ4SfnQV9DYiOCf7a7WVyYi2OqJdvZmM4IpilO9PKD79ZEHfA/4eA3sVsJafWDTirRw6o3smUs1339DCVmk+YUtdWK/9Pe3R0UIpRdNIv4REM7AOti1UNoYpl66x59Zo8vvLYPdih9VItZVWZunCjwABT3tlW8yTziZ2FBS98OPWWyI5o3sipuHr2g084prDhqdOOkXuO3NSWRbEiTIhzM7gGbgbQJQpzVPzLFbx026ZXCMlSi6qB5x3Z++AW/nQXsTBQNNSSphiIohOEhryyCbZjmD9YK0f+eUW3O+pApXLF0oDrmA4fkZCiUwSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwWZJ1o2vN7Jj1Wd6gxZKukLqr0NduZpRCO/jcgnVtQ=;
 b=RIJ9n8+ochuJCqL+xH0/JxFmtNACVmx8mRzxi7ykybtyEy+dfPVFs4NeYMYWCmE4xnJ3VNsAVmw3Mv22BbM0szgmXLx1OF0XLgIbCqbeRN2TUAMlt2D3qWFOx7pabsB05sG3EMyzqq3syrY/GEV9MkwupMn+XGM6+yrXtJIce5rE9VBz1ehe8M/eLgGlm1ChwXSW9Gt5+RItXfpBSJc0BoWvZKqKfVGGPSct+8j5Ba/sXldDsrcv/kB9n/HVdfGgMCsbgMJ7ud/evzrPt3mdo2fPXbocKls0bg45MnxHMa3kwN6pWKxy57J0FOdH4rrqFNQz8XzNArR/iWzo0lZwYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwWZJ1o2vN7Jj1Wd6gxZKukLqr0NduZpRCO/jcgnVtQ=;
 b=Q0A8uBwOnXyu8OEabl+9YX7TfbZwoK04eE5pFNr1tA/e2wc6Ofql8SKZLmw1lHKhxQgjz/2bHw+P/OP2zK1kX43eXguXoqnK4JcGK6Q4eK9vDwmwZnm18SeJKlA8snaR71js22jxunD4Pn304CZ+rrv4vTF1VUkh/wQh8AI4KZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by VI1PR04MB9763.eurprd04.prod.outlook.com (2603:10a6:800:1d3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 19:36:28 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.035; Wed, 14 Jun 2023
 19:36:28 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v6 10/12] dmaengine: fsl-edma: move tcd into struct fsl_dma_chan
Date:   Wed, 14 Jun 2023 15:35:42 -0400
Message-Id: <20230614193544.2114603-11-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230614193544.2114603-1-Frank.Li@nxp.com>
References: <20230614193544.2114603-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0051.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::26) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|VI1PR04MB9763:EE_
X-MS-Office365-Filtering-Correlation-Id: 3845525a-447c-4952-9b0b-08db6d0ea599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zdcjtc2nDI5ZIV8hXJaD7ZGjdoHOsTM/WQGzsV5wFD3Y4zmLkAD5yFyxFNmMhToL6kUpta3RvFsoUs1b8FhaxSB0P8j8JbEiVgaLRcXE2WrVloYUGbC4CKlOmdkj5FrhcUG5kz32KgTk+d9wiSqBM7agF7qntLrRmPDkmKhvhxzsf5sKoD+MGkAazgSuK2syX7Wdi3v5f3VciT2HhRd5GA/eEVPQtYP3sx2L3UExPFq5m7D+r+DWZIwYEAoU10+y3MPZDqDP2p0osCacSACDHaltpTrxpBrWI6eQsLyXF5Ziu2VkcWkHlNvGques3ueUFhID78yg+rf9eRx+wqUfzYEN/GG8ZibByJjg84oco3hzaBm9mC7T5XyU24gAfQwu1dKKOYJydMWfv8uXJE4BXn3tFlFre2uvo5ZdCCLoDVFHJmkKTtfhUQ5Mjnjua2epgvSGpn2nLJulzHdIwU+U0iIeDz+OfEflgkI5TSO2IR4aWq2QZUrMzpOsQ83/KRTEsFHftl4zBCIBWz8ZRfeYMmHoOqU6M15Vp/yMQBnMYnZyl5YwX1UW5TOfvVL2l6xQapyGphoFYtztCW9uLhRAM9Atxs2iZwntR6/DRzqBMw0oxlT4c3bbJNvvPZ8X3P2p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199021)(966005)(5660300002)(6486002)(8676002)(52116002)(41300700001)(6666004)(8936002)(66556008)(66476007)(316002)(2906002)(186003)(478600001)(66946007)(83380400001)(38100700002)(38350700002)(921005)(86362001)(36756003)(26005)(6512007)(1076003)(6506007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yYr2+j7oZkXA4hIDNZ28RIXT9fl4y/dfAAp1v/n0+JWdoM9G5+6jVLt1wpXj?=
 =?us-ascii?Q?QdrF70FiOUfnllVIk//0hqXACDtXT1OSw+m/n7Gd5+gXbtMgub5IG+VB+r/o?=
 =?us-ascii?Q?EwweZysAAzWYHqtiD2IEapoOGVzBiGiWuPyhs08bweDtz4s70X/9AGDI/SK2?=
 =?us-ascii?Q?yQ1drMdXo/650uw0XV2tSrHvVwFRd0TNzjBzyOsRc4b0jMXUrpfReKIyDGe6?=
 =?us-ascii?Q?m+kRQEYD4ux224ruV4ySZxW68/zVqGL2VtMIYJHliDFSQC9BkWhNAbN8dkP5?=
 =?us-ascii?Q?TfMsHKp4BK3a4BC/1pAQDfwVtYjXlQ6FZ1VejWMUStb+1nJ4WRUuWif+rrjz?=
 =?us-ascii?Q?8Rdym2sRs/kE5NYyygvfmRHceCC/OLAGCjzT2GRqLJYxH+M1/ZTNceALRORC?=
 =?us-ascii?Q?SSacKMsbwKVofCOk9C1iFRcGMpMjPtv6+CBpAeLb1MOyD6564qqXpJo8lzzk?=
 =?us-ascii?Q?b40yXos6OfpLTTerDnp+klZpTnvwIUQcFv26xodueFTNrhENE4+UCpSK5gPy?=
 =?us-ascii?Q?uFkdCSLcjiyad6FeQxTTpxbEZHcA7MkZWNsIOkDNHTWz73y6U0qWFZq7koze?=
 =?us-ascii?Q?Pwl8blN2hvN6eDHDHDj5ayAeENJPcIMlBf3hpu8rTHYJATqQO+3IdlRI0Fts?=
 =?us-ascii?Q?V9ws9mfxflSWq5YfG9363Mri90G1OMpDetGPL5jw2drkNbfX5LeQluH2nqfV?=
 =?us-ascii?Q?pjtV7TpPWXeP0iK55kxO4WRXlFt30kJvg3b32sdiiQs/Bka3JwQyxEl2lc5Y?=
 =?us-ascii?Q?Fhe3diPV2jHEXWjWu9uZqGSFlSA/ep/euweaaGSZVW7wTVZDYwnZYX6d9fL4?=
 =?us-ascii?Q?sNcogCfrXSPvMrSTPu0iWQHbuEuZjETtn2ujSb8XzA1mgheUDTbxh3PN9e4H?=
 =?us-ascii?Q?EVQ1ZluS6tqjDwBTaLLWP5FVpxvH6LUs25BRuudVppY2oKI2L+KgaL9VEIcM?=
 =?us-ascii?Q?r/+my81MWDyLzw+fTswePGbSab81LDIgBXffpO1sFSBYYsT9kKN7o+BJdyhi?=
 =?us-ascii?Q?GNVfL7RaQhHIq+vXKMalPMizbkUUnXcvYr4h4uko0HCelVfGhpMQKGzjv2hr?=
 =?us-ascii?Q?9MLndNVMXDTJRAV9cBJe5Z1YN+78cIk9m0jaDDr69Gl3CEIsAnvS+TopGMRW?=
 =?us-ascii?Q?Mvyr6eVQrwm/DXCOtOglrbYVNCCedRhyigsE35qxRzVLtq9Kmz+RC3EdZ8/H?=
 =?us-ascii?Q?wia3/3FMntcIRZ5SzPGEyMcDaVHj14tnBFAfmKxdqw1viyg8irSfI+Pe1bmL?=
 =?us-ascii?Q?GBCJ2ObTevKb1ODVZIqUavuafBd04EbbxX1Dzu0jWWifn9bOQfH0oEdvYQEN?=
 =?us-ascii?Q?MglAC+975DHFwLOUjsqGKz60nb11aO6hqe/jajn4Gcwt49Of1QWN2P/Oaegn?=
 =?us-ascii?Q?wdYxOGSFZGTX/4rMZp8lBvAwE7U6VWyLYjKZxTdFd6HtowFiGxDaQZuOqLvi?=
 =?us-ascii?Q?3bNJizywNyyxePtfnD4dKeen7rhYDQq3g3nDqwZrgc5jRcWuo7vPQahFK+z5?=
 =?us-ascii?Q?oHlvyj5tX0K49Bh79fyjJpvzbMtvsRm1n5kQLhzfqfiTU1lskzlerR6TlGPw?=
 =?us-ascii?Q?JSHFDtJtLvwXGnauu58=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3845525a-447c-4952-9b0b-08db6d0ea599
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 19:36:27.9857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FlPRrVmvhEOY+L0pmzKEOifvbiRIShI+A7BV/IuAWpQE3LLBL4QgJiQzwwI7Ulas+sZa3El0T+mAOfV9y9GRjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9763
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

