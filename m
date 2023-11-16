Return-Path: <dmaengine+bounces-120-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AE57EE93B
	for <lists+dmaengine@lfdr.de>; Thu, 16 Nov 2023 23:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3A241C20A3B
	for <lists+dmaengine@lfdr.de>; Thu, 16 Nov 2023 22:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4133588C;
	Thu, 16 Nov 2023 22:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="efMF9VMv"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2040.outbound.protection.outlook.com [40.107.13.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313E8BC;
	Thu, 16 Nov 2023 14:28:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VC7QevsGflojuFSCMh0iT6hFenTsemXbjo8WhfYKpiPopA6ztxyuD4lUyIpsdG53mFATEfwW/ATNoUyfjm0YH0iEdXTLRa2s3LS/Khe+I0OLdu+AI+xjaYxXtKNT3Btz4pqodZS6ngjY++ZordFWtkdYKwY+XfmcyhY2dhmjgzFudfytMfn5xVYr3sWAnUWWZYO8vagGVWSeENT6O20FABpCVAmkXIkDcvVmK7aRXhzRu4YNG/C7GWeerC1efDRuDi7t1BRCz/rGnxBRiNaJ3CC6f/pzYjAB6O04k3RAwcQO7y1bqMjVbybImQaXP+rlaHvPQgxZ/SErZUg3yFiCWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZ89+LfuS0wEaJjHZ0T4E6Y0YCjCxdeIQ+7QlqEDYqc=;
 b=fQI1N13jQ1sAn8GNijwAPHadz0kRImCEt3K6Rd07riTnn0obeE9H2V/ImXG4NWg7i8LTybmlsYIC9jrEl8U1zZgoiWhKZYH/aKjPgNjq9Rfr+2JiBqFo8HF31T4rrb5nC0A5r6/VUsgtHAPpYI8/btZAyivBdMdQm7X/osLczFDTaIqBnWUgmpDwRT3gbXxumPpvltHyojNG8v1OJDIHGwevbFaUSXEc6+BUtzcLoo756NK2RQZFy3ulrbcjoyKlJwxbiLgoSOwtH+2noQ+DeEcFKzMyvFDkz+ZLrrc0KhmS7SpfQaR2gt6ZBE5hLFBkPQEz8tJvxZJBwPxVm05W5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZ89+LfuS0wEaJjHZ0T4E6Y0YCjCxdeIQ+7QlqEDYqc=;
 b=efMF9VMvukIRDobRcZTw+tQOrvPjBHiAyenVJOgHqO9SnUwyi7xJUixrhBJYnen4PdA9BVY7eqqtzusepZ5NcvCIwJtmDB1DGUZgeawZ9oaYZQfPRp3HnOUGMknY2bKI/3a5GovjqqF2JNTvAMCJZp2coYOP4IgozYC1TNBBXw0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB8857.eurprd04.prod.outlook.com (2603:10a6:20b:408::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.19; Thu, 16 Nov
 2023 22:28:04 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::c048:114f:b7c2:7dcf]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::c048:114f:b7c2:7dcf%3]) with mapi id 15.20.7025.007; Thu, 16 Nov 2023
 22:28:04 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com,
	vkoul@kernel.org
Cc: devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	imx@lists.linux.dev,
	joy.zou@nxp.com,
	krzysztof.kozlowski+dt@linaro.org,
	linux-kernel@vger.kernel.org,
	peng.fan@nxp.com,
	robh+dt@kernel.org,
	shenwei.wang@nxp.com
Subject: [PATCH v2 1/5] dmaengine: fsl-edma: involve help macro fsl_edma_set(get)_tcd()
Date: Thu, 16 Nov 2023 17:27:39 -0500
Message-Id: <20231116222743.2984776-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231116222743.2984776-1-Frank.Li@nxp.com>
References: <20231116222743.2984776-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0071.namprd02.prod.outlook.com
 (2603:10b6:a03:54::48) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB8857:EE_
X-MS-Office365-Filtering-Correlation-Id: f86e98c5-eb26-4e90-7f7a-08dbe6f34ce1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	inhZmBakLwItPOBjBzA2Bn9/dAIjrIyDGlzpL3bci+/lRUlKHM+I6v3wpSXeMzhevw6vIynwq1MwAW1+1jD7jsJ4Sqs6zONWwAv+gVbOu/p/QDVxUh62YvqVK5NGSP1FUrKthOtRR+5baxRJxspMNxhCbbC+AuJKH+ziB9fc0Mnf2PKOFfHKlIUbzgOZtkpt0NVacSj4d0aKtGjPOztjlRMLVFdiTuhQhaxCMW9aI/Ma5w59NkdlQ5/ltZgwt27udKIEn8xwkQH1dQqQ/90njtX4WaESnTulEb31P3js6wVbOnfAQzeFgg5rNkdHavapZlLH6uRROqfA106mmuVuGSrYOtzb10LAUQ+I7zPhugFobGVCk9djkb5QURB7FqtS0668su2ksnxDq5ZUteZ5Xfg1n/m5nGieTxKFxJfM9PznYl0UP51L8pnVLduYsbghU5kp7fKZJ+LFlDWdKVc4Jg5HGYsnR65VE3D/wGae2fec+Ccq9z2yugqobmTqyqNmaQmcLBEwub+yut/PqE3lN/Y8G0wfL4PZQC/PSpLZ/iAU4ekYLa0mZ2t3qXDXzQ4MhNu0sD8Qs9gwLG9x4CH9Xybuqnvdh/ywsXEFuI3VyAwo3xgwaplla1FXDrucy1pv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(6486002)(478600001)(6666004)(2906002)(2616005)(6506007)(5660300002)(52116002)(86362001)(8676002)(4326008)(8936002)(6512007)(66476007)(66946007)(66556008)(316002)(41300700001)(83380400001)(38100700002)(26005)(36756003)(38350700005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qT6v1oWR7sjzjWKFFhzy+1wHlDr6yZuOR5dO33xCWeoQKutHOuV4QQhQRFH7?=
 =?us-ascii?Q?qLLkxIzqyWhrOzjYbMhLyRnxjTfUOk9cTKseT58xmojXvqMciK0VnUY1bUsr?=
 =?us-ascii?Q?eSW9xdd0QNL0y/V13n3yAre/TnK38m5FmUGlm35KgRSei0sR47675wHMt4pc?=
 =?us-ascii?Q?mlJM4s7TsLc8qmwA2Oe+0YDNxOPqpjaTC39ttAY1KXLPE7gObQ95efg+GXS2?=
 =?us-ascii?Q?GI7bpGYYSa93itSFy97DSnPRMZ/DwFjb1MHn3oDg/UDf2CT7SC9bQAMPl9Ai?=
 =?us-ascii?Q?v+KNFLMioSOSIcywAcdR5R3rBXM9f2xj4g3rtvGzvxygqsXYgdw/ELqY0vuI?=
 =?us-ascii?Q?LKMPESmwkxk3hv4GODvL4NtGVV86+iQ7ONEZZtIFOdKKp1U/5kEaHSsYSFX0?=
 =?us-ascii?Q?6bTq6p8d1EvhHj/r0U5hOV7SGnrD+SZsRAVnDJHCe/GiytrubpTj1/CqSJ6e?=
 =?us-ascii?Q?VpCB2EQLypeaJwXlje7RVH0YPOQ5mql4+yhyME/tupc8vE3/lMLBgNkaYGXP?=
 =?us-ascii?Q?ADLNjY9TlsmathRqPeOwtVLw5no3u0JTEcxvLVGIwrYJd33E/DyxYVjwdsDo?=
 =?us-ascii?Q?+hSgndRKzNFgyLhTDI6sB0sYWlmDIjv/NkXP/eCV/WqPGPmbhtm1wVGbI4p9?=
 =?us-ascii?Q?f3PwX8mZiCyKllWusTuU9fCRI64VNw+rfE39gNe7m0VUn0HoGdO3zu2qWDbA?=
 =?us-ascii?Q?KQygYZrcaa9I4tln8HUm1Dsdp4fQeHvK2nIDNGsluLoGyR8joY4w/nJpM7ys?=
 =?us-ascii?Q?oDbVI0lMqIjRwGRf1yGB3yFevdmEgjOxKlVDcLEIm4Sz14uhN3kiXb2vq62J?=
 =?us-ascii?Q?HQKWv1s/AG/MP+YkyadR+wuqIhbSwsKaAazsIi1DGy77ISz0+Ext0SypxFAt?=
 =?us-ascii?Q?FSTDnIk6B+5hJJ8sx+g5NlHknmS3XBMM6+605GzhGGnjXT45dUxDbLQ1GQ9M?=
 =?us-ascii?Q?x7d+V/B2J8rwBQlVgEdYBrg19NBcS3KXiQS1tbgy0xXKTfeXifCowv8kNMQV?=
 =?us-ascii?Q?I2itwsDD6Es32lcnbcg2ZrIHGsA9QXI7N/+/x8YRG1M8r7r4H1X1hLTqdvj8?=
 =?us-ascii?Q?Qw94jojhgICIqY0SSmJN9u0J6E+MVxU6ORIDjBO0gkp7g0zh2WVTJgmKMFNn?=
 =?us-ascii?Q?upH9sKT1CAl5XkYOdWNdhGepAb+FTck9VEL5kz+pyxtXHzh5SVHOJHkLyTvJ?=
 =?us-ascii?Q?Y1etKXcVsZlRP1L/gBZGFXVMHHb6VrUZ9xh2pNLZxZlw2CGRqEuk0t/NzZe2?=
 =?us-ascii?Q?A/okfdKvuYl0nVrm4vxCwV2Mh+lRFpl/VIN9szml488/FITJ5RUToEPfpQDa?=
 =?us-ascii?Q?FxEAw0NJDIkHZ2JMQsOSMbksHtOzDKylRt8CK8yldr2k+hMMnQdufLg/xyr6?=
 =?us-ascii?Q?6xejerssaGrf/jtUrrSR8RNhj2mvQ6NVkwj1Rviir8cdPA5eMnSX1BE1T85w?=
 =?us-ascii?Q?CofVbLFB501EbBV6AntXodFyYY43ucBqgSC3rLtUtYFEB/btPkJ75XUpxJq7?=
 =?us-ascii?Q?BlHeKQjSvhfqYZviT+YYV+939+4Nfs9dbDxn4up91rVmTDo4jhVwvJppjlyU?=
 =?us-ascii?Q?eIMvkiQ1cZ43/llg2oin1zXgiq5MEjfjv2hlFjEa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f86e98c5-eb26-4e90-7f7a-08dbe6f34ce1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 22:28:04.5625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7acYbY7DiCSWpDtfut7BnwL8e4xzL8F991vKxptxWZlyBz4JJ/gjfrU/OGSXdATCmb3Qgt5+mR5j72t+Za3xQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8857

Using help macro fsl_edma_set(get)_tcd() to handle difference field size.
This is not function change and prepare for 64bit tcd in imx95.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 61 ++++++++++++++++++-----------------
 drivers/dma/fsl-edma-common.h | 20 ++++++++++++
 2 files changed, 51 insertions(+), 30 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 6a3abe5b17908..1cd9cf51b16eb 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -358,10 +358,10 @@ static size_t fsl_edma_desc_residue(struct fsl_edma_chan *fsl_chan,
 
 	/* calculate the total size in this desc */
 	for (len = i = 0; i < fsl_chan->edesc->n_tcds; i++) {
-		nbytes = le32_to_cpu(edesc->tcd[i].vtcd->nbytes);
+		nbytes = fsl_edma_get_tcd_to_cpu(fsl_chan, edesc->tcd[i].vtcd, nbytes);
 		if (nbytes & (EDMA_V3_TCD_NBYTES_DMLOE | EDMA_V3_TCD_NBYTES_SMLOE))
 			nbytes = EDMA_V3_TCD_NBYTES_MLOFF_NBYTES(nbytes);
-		len += nbytes * le16_to_cpu(edesc->tcd[i].vtcd->biter);
+		len += nbytes * fsl_edma_get_tcd_to_cpu(fsl_chan, edesc->tcd[i].vtcd, biter);
 	}
 
 	if (!in_progress)
@@ -374,16 +374,16 @@ static size_t fsl_edma_desc_residue(struct fsl_edma_chan *fsl_chan,
 
 	/* figure out the finished and calculate the residue */
 	for (i = 0; i < fsl_chan->edesc->n_tcds; i++) {
-		nbytes = le32_to_cpu(edesc->tcd[i].vtcd->nbytes);
+		nbytes = fsl_edma_get_tcd_to_cpu(fsl_chan, edesc->tcd[i].vtcd, nbytes);
 		if (nbytes & (EDMA_V3_TCD_NBYTES_DMLOE | EDMA_V3_TCD_NBYTES_SMLOE))
 			nbytes = EDMA_V3_TCD_NBYTES_MLOFF_NBYTES(nbytes);
 
-		size = nbytes * le16_to_cpu(edesc->tcd[i].vtcd->biter);
+		size = nbytes * fsl_edma_get_tcd_to_cpu(fsl_chan, edesc->tcd[i].vtcd, biter);
 
 		if (dir == DMA_MEM_TO_DEV)
-			dma_addr = le32_to_cpu(edesc->tcd[i].vtcd->saddr);
+			dma_addr = fsl_edma_get_tcd_to_cpu(fsl_chan, edesc->tcd[i].vtcd, saddr);
 		else
-			dma_addr = le32_to_cpu(edesc->tcd[i].vtcd->daddr);
+			dma_addr = fsl_edma_get_tcd_to_cpu(fsl_chan, edesc->tcd[i].vtcd, daddr);
 
 		len -= size;
 		if (cur_addr >= dma_addr && cur_addr < dma_addr + size) {
@@ -439,26 +439,26 @@ static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
 	 */
 	edma_write_tcdreg(fsl_chan, 0, csr);
 
-	edma_write_tcdreg(fsl_chan, tcd->saddr, saddr);
-	edma_write_tcdreg(fsl_chan, tcd->daddr, daddr);
+	edma_write_tcdreg(fsl_chan, fsl_edma_get_tcd(fsl_chan, tcd, saddr), saddr);
+	edma_write_tcdreg(fsl_chan, fsl_edma_get_tcd(fsl_chan, tcd, daddr), daddr);
 
-	edma_write_tcdreg(fsl_chan, tcd->attr, attr);
-	edma_write_tcdreg(fsl_chan, tcd->soff, soff);
+	edma_write_tcdreg(fsl_chan, fsl_edma_get_tcd(fsl_chan, tcd, attr), attr);
+	edma_write_tcdreg(fsl_chan, fsl_edma_get_tcd(fsl_chan, tcd, soff), soff);
 
-	edma_write_tcdreg(fsl_chan, tcd->nbytes, nbytes);
-	edma_write_tcdreg(fsl_chan, tcd->slast, slast);
+	edma_write_tcdreg(fsl_chan, fsl_edma_get_tcd(fsl_chan, tcd, nbytes), nbytes);
+	edma_write_tcdreg(fsl_chan, fsl_edma_get_tcd(fsl_chan, tcd, slast), slast);
 
-	edma_write_tcdreg(fsl_chan, tcd->citer, citer);
-	edma_write_tcdreg(fsl_chan, tcd->biter, biter);
-	edma_write_tcdreg(fsl_chan, tcd->doff, doff);
+	edma_write_tcdreg(fsl_chan, fsl_edma_get_tcd(fsl_chan, tcd, citer), citer);
+	edma_write_tcdreg(fsl_chan, fsl_edma_get_tcd(fsl_chan, tcd, biter), biter);
+	edma_write_tcdreg(fsl_chan, fsl_edma_get_tcd(fsl_chan, tcd, doff), doff);
 
-	edma_write_tcdreg(fsl_chan, tcd->dlast_sga, dlast_sga);
+	edma_write_tcdreg(fsl_chan, fsl_edma_get_tcd(fsl_chan, tcd, dlast_sga), dlast_sga);
 
-	csr = le16_to_cpu(tcd->csr);
+	csr = fsl_edma_get_tcd_to_cpu(fsl_chan, tcd, csr);
 
 	if (fsl_chan->is_sw) {
 		csr |= EDMA_TCD_CSR_START;
-		tcd->csr = cpu_to_le16(csr);
+		fsl_edma_set_tcd_to_le(fsl_chan, tcd, csr, csr);
 	}
 
 	/*
@@ -473,7 +473,7 @@ static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
 		edma_writel_chreg(fsl_chan, edma_readl_chreg(fsl_chan, ch_csr), ch_csr);
 
 
-	edma_write_tcdreg(fsl_chan, tcd->csr, csr);
+	edma_write_tcdreg(fsl_chan, fsl_edma_get_tcd(fsl_chan, tcd, csr), csr);
 }
 
 static inline
@@ -493,12 +493,12 @@ void fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
 	 * So we put the value in little endian in memory, waiting
 	 * for fsl_edma_set_tcd_regs doing the swap.
 	 */
-	tcd->saddr = cpu_to_le32(src);
-	tcd->daddr = cpu_to_le32(dst);
+	fsl_edma_set_tcd_to_le(fsl_chan, tcd, src, saddr);
+	fsl_edma_set_tcd_to_le(fsl_chan, tcd, dst, daddr);
 
-	tcd->attr = cpu_to_le16(attr);
+	fsl_edma_set_tcd_to_le(fsl_chan, tcd, attr, attr);
 
-	tcd->soff = cpu_to_le16(soff);
+	fsl_edma_set_tcd_to_le(fsl_chan, tcd, soff, soff);
 
 	if (fsl_chan->is_multi_fifo) {
 		/* set mloff to support multiple fifo */
@@ -515,15 +515,16 @@ void fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
 		}
 	}
 
-	tcd->nbytes = cpu_to_le32(nbytes);
-	tcd->slast = cpu_to_le32(slast);
+	fsl_edma_set_tcd_to_le(fsl_chan, tcd, nbytes, nbytes);
+	fsl_edma_set_tcd_to_le(fsl_chan, tcd, slast, slast);
 
-	tcd->citer = cpu_to_le16(EDMA_TCD_CITER_CITER(citer));
-	tcd->doff = cpu_to_le16(doff);
+	fsl_edma_set_tcd_to_le(fsl_chan, tcd, EDMA_TCD_CITER_CITER(citer), citer);
+	fsl_edma_set_tcd_to_le(fsl_chan, tcd, doff, doff);
 
-	tcd->dlast_sga = cpu_to_le32(dlast_sga);
+	fsl_edma_set_tcd_to_le(fsl_chan, tcd, dlast_sga, dlast_sga);
+
+	fsl_edma_set_tcd_to_le(fsl_chan, tcd, EDMA_TCD_BITER_BITER(biter), biter);
 
-	tcd->biter = cpu_to_le16(EDMA_TCD_BITER_BITER(biter));
 	if (major_int)
 		csr |= EDMA_TCD_CSR_INT_MAJOR;
 
@@ -539,7 +540,7 @@ void fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
 	if (fsl_chan->is_sw)
 		csr |= EDMA_TCD_CSR_START;
 
-	tcd->csr = cpu_to_le16(csr);
+	fsl_edma_set_tcd_to_le(fsl_chan, tcd, csr, csr);
 }
 
 static struct fsl_edma_desc *fsl_edma_alloc_desc(struct fsl_edma_chan *fsl_chan,
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index bb5221158a770..72104d775e562 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -246,6 +246,26 @@ struct fsl_edma_engine {
 	edma_writel(chan->edma, val,				\
 		   (void __iomem *)&(container_of(chan->tcd, struct fsl_edma3_ch_reg, tcd)->__name))
 
+#define fsl_edma_get_tcd(_chan, _tcd, _field) ((_tcd)->_field)
+
+#define fsl_edma_le_to_cpu(x)					\
+(sizeof(x) == sizeof(u32) ? le32_to_cpu(x) : le16_to_cpu(x))
+
+#define fsl_edma_get_tcd_to_cpu(_chan, _tcd, _field)		\
+fsl_edma_le_to_cpu(fsl_edma_get_tcd(_chan, _tcd, _field))
+
+#define fsl_edma_set_tcd_to_le(_fsl_chan, _tcd, _val, _field)	\
+do {								\
+	switch (sizeof((_tcd)->_field)) {				\
+	case sizeof(u32):					\
+		(_tcd)->_field = cpu_to_le32(_val);		\
+		break;						\
+	case sizeof(u16):					\
+		(_tcd)->_field = cpu_to_le16(_val);		\
+		break;						\
+	}							\
+} while (0)
+
 /*
  * R/W functions for big- or little-endian registers:
  * The eDMA controller's endian is independent of the CPU core's endian.
-- 
2.34.1


