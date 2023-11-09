Return-Path: <dmaengine+bounces-61-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DE87E7386
	for <lists+dmaengine@lfdr.de>; Thu,  9 Nov 2023 22:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B604B20FCF
	for <lists+dmaengine@lfdr.de>; Thu,  9 Nov 2023 21:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D30374F6;
	Thu,  9 Nov 2023 21:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pitp5c7b"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2740D374E8;
	Thu,  9 Nov 2023 21:21:40 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2083.outbound.protection.outlook.com [40.107.105.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC363C0A;
	Thu,  9 Nov 2023 13:21:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RS9IJvfKsXmOgPlah5wHlguZVciNL+kbtCE7mF9d5cCoZMvMPsTw1MYV6N0HOaQtzP65xNCW7qwtH668+XOv0az6f+1O5nrpyo/bSUnNvC1xTaT0VbaIxUXk5eCh5ZVuvcNtbk0LCFM6kYKKp20xy3eudwF88n/m0VRUTINYGAxs7ulFA3mw4LqXZbzB/1skscXqM7sPfjHc4uXuudiaOWvcPSVFNHpA24i8wI6YbP2mmOwXUNHh6fPy2vb6zZklW7XI1v8Q3E/EevS3m9OxMlx1S6EOS/gKE+VKXn0k/klvBIEy4oH8NZKGegBSJdjnmf+z3YFIi7eduPCUIY4/xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZ89+LfuS0wEaJjHZ0T4E6Y0YCjCxdeIQ+7QlqEDYqc=;
 b=MRdbXo7mJH+xb6Ds/fJUvdanfb59RTRDjpz249baqKe4ibMy9KZi/H47c4R169ptfcBHpgzs4LMKR5pE88L0QL6PAqT4ZsV/gAAHhBoXZyT0/Ixd7+wn9Q2baUKqyrvcuSLDhPOlo7QpHtaG/L7A37Xyu5z/hm+ClxUvmXl9spusbHvUHiE2ppNr0QMxcjwEH4d94k102vJlOF+Q5S+wmXgzl9xM9UaSQWVckDW7UhZAFf76AoScvDtzt9rAV3ho2vlvHwgrB4py0H9fxY3axJjSop1+NUeAtUgJ4Tw4v83MyS/ZKHf3pF3x95GT1iBUSv++TjzlC+jH8xXAVT0TJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZ89+LfuS0wEaJjHZ0T4E6Y0YCjCxdeIQ+7QlqEDYqc=;
 b=pitp5c7bVykANoI/DqC8Vf9NQ4Pg82Hmo1A/M9YXO+1IUxaW1YawXoNX8pPJfaqpmkXlGZgKD/iFEx88FA14rNx5ETrN+b2AlM95BDzEJJye3xGRODb14r01poytXyL196ClBmEFxpy5z5nYTpdwmux1mwHBtLGzvdFyj74v9bA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DBBPR04MB7836.eurprd04.prod.outlook.com (2603:10a6:10:1f3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.7; Thu, 9 Nov
 2023 21:21:37 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::55e7:3fd0:68f4:8885]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::55e7:3fd0:68f4:8885%4]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 21:21:36 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com
Cc: devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	imx@lists.linux.dev,
	joy.zou@nxp.com,
	krzysztof.kozlowski+dt@linaro.org,
	linux-kernel@vger.kernel.org,
	peng.fan@nxp.com,
	robh+dt@kernel.org,
	shenwei.wang@nxp.com,
	vkoul@kernel.org
Subject: [PATCH 1/4] dmaengine: fsl-edma: involve help macro fsl_edma_set(get)_tcd()
Date: Thu,  9 Nov 2023 16:20:56 -0500
Message-Id: <20231109212059.1894646-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109212059.1894646-1-Frank.Li@nxp.com>
References: <20231109212059.1894646-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0013.namprd17.prod.outlook.com
 (2603:10b6:510:324::6) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DBBPR04MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d2710eb-ca06-4b3e-29b0-08dbe169db20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mtxURoLNxgBJmNZd3P3rreoPgqIjY4aj2oaEIJZ5iyV5px/wIhjFYHuBxH5GwVeWD2yzPrcyibBP+CaLLGMaxtHKGT5PjU/LTNA19/L/E42LobiiBvM8TFWzXrNmBi63a/eX5xwGsrTHgKSbFKvfiRVwwVmXsjk/453QXjoxEOHs5bxo+FYWUU0TIwOzf9qMbxJ9UyMQi4SE1enipjWywRgxz3I/hY+B85bYKBrYk4Oo8fNb7p19CYDFP+Y5O1zYtOsRZxkDfN3FSWdL/NO7O86E31dUCiaCgLT9P7IEi7pqKjIVf0mDnQFjdAgzJ4D83VmzBjPpWLfNq/VzTQZf2rpk/5DnVGLHp9k0lEqzj6njdeglJlYao+rnAnsqrTUkTAyPSoR6VI4cDdnUWkPL85HtRAitp2JlTEbOTBEwvnuk05DDlGAxz1dR/8e676X4uRJldDFGPyzOlisDWi+NRgAJtKbtKimnpjw5x+wVfZAdpu4OLCVtX3G3Bt0jqGNaeNvb15qEZbEgzRYIm2luuStYzoDsaIOBhSOaiKEaV6GY0h7jzrMFSj6TBDZHsZZSmKsAQqWIdTBRSoXBUYEFuide5iPdjTQhvOaD/sNzwMOS+yZfPY5jkySPVpivgNBc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(66556008)(66476007)(316002)(37006003)(1076003)(6512007)(6486002)(52116002)(26005)(66946007)(6666004)(8676002)(83380400001)(8936002)(6506007)(4326008)(34206002)(2616005)(478600001)(5660300002)(86362001)(38100700002)(41300700001)(2906002)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y99l/i+I4ujUYi3wLgh4ObBdidB/I/tGi3lTmmnT+Ia617WF9NIs2BHLz2Ss?=
 =?us-ascii?Q?NNxeTSHxBl/wL2LnSFO3rcseJP0Ni4WqizhtsZcXwrXbEaR+HCAueOfz6qz0?=
 =?us-ascii?Q?09W5+VtaiBw4NgSSQDW2bayy7uHb5Ngykf17yb1TQgG92wSGz94ED4aPrfMt?=
 =?us-ascii?Q?IDxsfTGTEK0R/C0CzVYqG0wlFMDe8U+cI5jm/E1+vLRofByJn6DpJMK5edO5?=
 =?us-ascii?Q?7zU36uM6zr/dv4yATEMeBGpnoeAD4Wzqw2diRK8vFJCLn5tGga9eZ/4WwMX6?=
 =?us-ascii?Q?MPSNAeVJ2i+WJLFyDguYh8D3qHiOXXVd51v1X1GlWSEzXYBguCtc6wHtffDp?=
 =?us-ascii?Q?cku8SkdihQ0KZgPhPZhcb2TNBbyJhoKS83ce2l6xTM6Yv2w98yfcwYLXTj9p?=
 =?us-ascii?Q?I41FPoXf1yYMnFImqDvP1c+UPJCxP+mSj6Yspn/glLzQ5wqpgK8kPfDftW1m?=
 =?us-ascii?Q?TN/ydOOn+oDCn7wZ+rtI6ZVtdiq9sMBDo4InMvBby8U+rGvxS/E0aN8fnLrv?=
 =?us-ascii?Q?LzMBgEQrUL2lurFhhRg2/xSVy7Kz49tHYnAoGkXLTlUqUhQ76Mlvzf980Bra?=
 =?us-ascii?Q?k9u3IawaHK5nOx3YBBiW43ovj/glpYDKZSS5XU4GaNWRSyl/UjeVsj37j039?=
 =?us-ascii?Q?2iBEL77eDuk9akeVaZ5HH8xC2Vx00lOxMduJHdTa9uoJr0RRuZFQgnsHRby9?=
 =?us-ascii?Q?iRpJxEmVGWUWhdNWfVO6GB0PvwrM3k9PghSeek+HoeJaUCJCUpzWlf/O204z?=
 =?us-ascii?Q?F7W14hSlgQA0uLPP6l9R9oq/E5qBsHfKVnfhGDip2axDHLs8fS25GOi5Y4n3?=
 =?us-ascii?Q?gtugyoOZC33mlx7oNYqEZy1aB8539By/z/MqLiyQA3K4SygL5sVXz3H98kil?=
 =?us-ascii?Q?K+8L8b+R+Q2IUnkxXIh0NGvb89hBsW0GPSghQ21KaY4WI9yueYAUi1NEhOmc?=
 =?us-ascii?Q?xpc9jqKNRDb2w8gNpMBnXDGDUZ2n8TlyV455cqgeQtRNMFkmplm/lGmphO1u?=
 =?us-ascii?Q?QTrITDxrnS6cJJDY/nsqIR3UVJ0M3w0iacDadDKpWNNhFMI3TeeRFdN6eX/P?=
 =?us-ascii?Q?yK84g67ZumObJt4SAjdJ6smidkDGkBznhGSrj6iHWcZ8evXoUst0MzNA0hMv?=
 =?us-ascii?Q?djWiAJrq6ToYyHVh2BL3kYbTC/n5mOU0oidOBTs/ei4eMRVNU9Ak6h5ADlMl?=
 =?us-ascii?Q?smkplaDzqkyAbvwJESHQj9SNbD9vcAbpKuSsTpvc0yOUQAJhPRidsBjCVbKz?=
 =?us-ascii?Q?g4s3XGejckufjuByFCFuXzn8roU0kg+tHAQbwTmtJxo5xv94Vp+05nmLGGOe?=
 =?us-ascii?Q?KTA6x7sCw2LAIYrP0OPo23KDwL34nkS/S+9GshJMxumgstMn17eKN8CVVBos?=
 =?us-ascii?Q?Buar7zYYf62H3JiHU607JyA6/kSbz79TDhuYxORmzFtL0qCEVZLdGNMrSK+R?=
 =?us-ascii?Q?ueLYNhTqUddUmk9KEULI6nobfdaMWPgTUOo9s2iYPFX8Pk/MsCKE35hFvsra?=
 =?us-ascii?Q?cM6wKq78LSSvolcT9OXLbMxUYl85cSLyaiaXrq4qYA4TfAAWNX31PoEp8etl?=
 =?us-ascii?Q?Rn2j8tBDc7TX0LOV7BYJv1ryzJrquRSOqi2ZPY9Y?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2710eb-ca06-4b3e-29b0-08dbe169db20
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 21:21:36.9123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1et9vcmP9x5mJeh6eOOp6zbHGH0xcLKr4UUZ6OO2I2qEC0lFMYucA3qfLmRTFR3nT3/REksVymfJwjncVWBiuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7836

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


