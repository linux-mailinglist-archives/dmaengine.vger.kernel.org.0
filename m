Return-Path: <dmaengine+bounces-603-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D7C81BAE4
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 16:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC86F289501
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 15:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6338853A1B;
	Thu, 21 Dec 2023 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GHgSpoWZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4736B41C7A;
	Thu, 21 Dec 2023 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVvIQVA9re09S//H7PQLRIlyFsgAQwzvM6CEBPgNQdCXxwMSLa6bfzRhQ+EOZ8AfalVjiNdlBG8tqjd+yqHX9IhHSEnHQOD1rpQWKFm48bfnQ5fZ3CZiRy/yyJrhkOfbk0IHnqUEdhrXA/o6waDgXq8qIP/AyfXBNkClgITABEwBgMjDupQhLevPrmjrcdtAW/XJsvq5rIU5kW/2A3qy3QedPCw2zdLk3IZ50cFdO2Sp57fYrUEWX0TmHAKyPBLq51mBvgL96LzyThjk7zCAcrvvqLcp5xJZgo742QrNy1e8X3RdpgCj3scYaBebmDbztlLssOyoji9I7iGP7/x2UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7yVzVo7EuQGlTzc4m2DQUz+qtkprIyQR4WJck0cUOk=;
 b=EqOPKcpWoBsL9nZgXIvR9T/MTG8/1BmNGXz/Ew8+u0FAZxsptUwCFdNmXgknHNHdYLBszHwB+BmnEBhU8NNMa/RwItUdTlUdf0VnMSzoKOc9V1sp5KI9Yzgb9bPWUEBfHD6c/MzTFqdIAY6PnSq+05puu0gGfSvR1lhNE285sFI5EJuoFIRfHLKIjbJx+FtTHLfG2MkkYyjoVvnl6qnBxCMCCcbvM2Hn58X7q/uDtjdAbPF/VYk8B3BaBwG8TZCTpkE30kDQRZ7x0dCFsDYRwF7N149sSBQnrK3DPszVzg6vcnhEs4gBACQPdEBreJlfxXXpS52e5X0IWpzp4x4nbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7yVzVo7EuQGlTzc4m2DQUz+qtkprIyQR4WJck0cUOk=;
 b=GHgSpoWZKyrfHulysDH2/+yJu0VASZ2giMFtZGotbdAG6Z+kVFElrm8+tfBN+p0g2OzlZaWGsOGHuxR9VsZHWi/tpld/9KZd8/U5lgFN+sw4pu67saWH/Gwslt2th/7YHROlxJyGVHL3/T9fbV7XlqOVHDtD2K/QWa6kkDsaogk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB8194.eurprd04.prod.outlook.com (2603:10a6:20b:3e6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 15:35:48 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 15:35:48 +0000
From: Frank Li <Frank.Li@nxp.com>
To: joy.zou@nxp.com,
	vkoul@kernel.org
Cc: devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	frank.li@nxp.com,
	imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org,
	linux-kernel@vger.kernel.org,
	peng.fan@nxp.com,
	robh+dt@kernel.org,
	shenwei.wang@nxp.com
Subject: [PATCH v4 1/6] dmaengine: fsl-edma: involve help macro fsl_edma_set(get)_tcd()
Date: Thu, 21 Dec 2023 10:35:23 -0500
Message-Id: <20231221153528.1588049-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221153528.1588049-1-Frank.Li@nxp.com>
References: <20231221153528.1588049-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0057.namprd17.prod.outlook.com
 (2603:10b6:a03:167::34) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: 64eba899-3679-4ac0-d488-08dc023a81a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GFaicVVpSB1aErw9DkDvjpQXyeot89gP1IlunJk1suV7r5FxKh4Y+mDBdFtwpRLV5dv0Sdp9Lp96NQed51avP3op56UjA5gj2+ny51i/EW3O0cHgyP4prjQoVVNbHRJhcXVZSqx6myayaoEKNGN+3kqvl8hfJi+hLfAfW1PgxAlYw4XCVHt9pRORikB6lrtC772giqz8+iWZEUkgFGaWKEhmhV99KSVUQ1BU2pqoC94FnDl3ty1qV3hUJUBsrPfBJW00KTE1SZSPJ/ntcbxTpJkBCYhmi8p/3oEznYhvXHWLo1Is4BZO9SeX7uy0wPM3JKDv98tkoQU9LUzsGn/olPffra5ppS2NwS78ntqFipPEtFRyuQaxTe4q1e+duzrWQ3EBG62WqcNR8YZhd2KvJbgJPftl3n7mQmZwZ6mhVOdZZtl7LAOp7Hs6G5lEdqjQSeq3yfu5ZmY6ta0+gTVTZuotx5fAnlmGtRxHA6bRSbd+ABgG0Hplmi4XUM+frEOTlq2e42LOiv0pI43FtA8R7FKnb8rNnkq7/wkgWDCVyZd0SJbCMIVGLluI3p2KQe8B3KFatXfQCSr5+ADSM1D2mNtx/++nor1i7xKtXGuQkGtSP9OzuIWvma6FDNOM2iIC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(136003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6506007)(6512007)(1076003)(2616005)(26005)(6666004)(52116002)(4326008)(83380400001)(8676002)(8936002)(41300700001)(2906002)(6486002)(478600001)(316002)(5660300002)(66946007)(66556008)(66476007)(36756003)(86362001)(38100700002)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/CpX9rRnQuANuEUUm7+7lTmGlvWBunyD94YKwpKH6aGVU8pc7UG1cnqV6R/8?=
 =?us-ascii?Q?WjXJBZcET53VwjAr/OB8LpgL9mlV5OTMR7VlVXi8vlek6UA9xWtX6ZtaZnbj?=
 =?us-ascii?Q?8eZUAOslhut6ym8QDhvkMRBajGqZQN4HMMNrZGKvAVLn30NlRnrL4P50Qmx6?=
 =?us-ascii?Q?/VtT3Bl2tJ2uyNf3dkx2XhAQetvDRPQ/KQGDJH5xmc7vQ+1U+HE9u7IjoDMo?=
 =?us-ascii?Q?z/UwS0aYI3qJqDxUz0Lz4cfHod4Ae1AbvrPZpc27mitysjEk3AidsoNWLUrk?=
 =?us-ascii?Q?VYyNfm2XJzbXIksGuv24h/R9/n0DScxU7ci/N/5+fAJpcW+CGm33w8W453ls?=
 =?us-ascii?Q?79y3FUliTlT/js55luYG8rPvN075QlOzzlIp7DpiNdSRZwj7qddmy6drlykO?=
 =?us-ascii?Q?Dy+OIuWJvV+lEn3yxziLwS/jL0/2SpwMbmOLegphi2xHM+aoVHdbjO8HXM4Y?=
 =?us-ascii?Q?E6Y7f2DAYY6D15+8X2SDkoLYAfM8THNQr6GRifqqYuGawA4dPqYnE47NkgiT?=
 =?us-ascii?Q?I+qrFmGFkeaWyIhkzXBEZjyGWcX0P1PU+QITgiUkXDeHfJnLQmtCNRAZpBUz?=
 =?us-ascii?Q?LFYthRLA1KPxAlRyMIX4/bi+5FHUuePP2FQRsizgajkHoiITgfsytqPhGMVm?=
 =?us-ascii?Q?MtjuQsTJWpokABzdCemoJDFg0FocTNoYzSdU2ylcTS4xJyhk/coo5rztDxzl?=
 =?us-ascii?Q?RUSbMUe9uXQ5UEKJo4dE8kZhJF6XtPmj0jGYj7MYVVfVpa8a7HXTDBa+lZwL?=
 =?us-ascii?Q?eEbUzHrpNOcq4Mbg1JbCi4ohajAnmgcBppHNIJ3nEavqAfoKoIyqri5cmrTZ?=
 =?us-ascii?Q?pmgBW5l7UGSHbclI5voekHxBhOaKOrC0YB7tqD3vHgRO9nWl/mGxpu2MkD1p?=
 =?us-ascii?Q?6YwV0f+LLxZ/p0ZyJuqMkNtHv8yUIQe/DvgSJB7R0hMiDWOiDqw/t5WrTTpB?=
 =?us-ascii?Q?QSPNBLHK5//ABIJWF9vZbuEA/uNON1qLpXt+q/b1ZqOHVY3JuEVG08w4XTlA?=
 =?us-ascii?Q?BWwFdl2wlQ8z7vnmJhGUbL3Em2i1yeq/788siToc7W19GbnfgrDGC5FMZlyN?=
 =?us-ascii?Q?2VchMM4zHcVOEInxm30g4NXEqt1kFUZ2C753WrZzAuMND14VWByJPAJib8MO?=
 =?us-ascii?Q?bIww7Y2Ip/StKfTp7ux98tLB10T58XFwkb9/hbLfsnzk+SdcmRoaPGTwGHAV?=
 =?us-ascii?Q?kVKkaZxw5cmXhWVH8pH65OCJBT3u0dFOUzYYGW3kWdpZXMb6p9G5acQ5Mwcb?=
 =?us-ascii?Q?Ds0wm0+4rOpVg7UxG0k8Wx36e0GlmkDuQnJfI1++0DuI8LJRDQYGJHGNkFc8?=
 =?us-ascii?Q?b9oyBiP+5P/1gmlUljM8MT5ZygmKRzQQ0pRlQ1X9/0/V2xypwhKzvljPVWEF?=
 =?us-ascii?Q?yfTTUl1h2aO26RGQ8ancyHjluPn0kGFeLJUTDG9BOupDZAl0qzyX/ZD3Bnpn?=
 =?us-ascii?Q?PulRLsRJ5dKoQVIVYACGTH2ePnI/PMa/su0FLrc7yqUhho7CqvgUOLsDrqfQ?=
 =?us-ascii?Q?RWz3D6P16hyMDkx8QzoZQmfvlq4GtGZTkGss27gGnLI3PnUuOtbzeuwf/i4H?=
 =?us-ascii?Q?W0bsEU5/pYNkiv+3K9nk1YF0PI6BNm0QouGOTZFQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64eba899-3679-4ac0-d488-08dc023a81a2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 15:35:48.7844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3cMwq4E7e2S2YZX51i6P8E4dgRkym2pxiimZFYcTT0LN6JgN0ijfURWm/flbVVuBKLfwJp+M5vsNICqe2v3kAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8194

Using help macro fsl_edma_set(get)_tcd() and edma_cp_tcd_to_reg() to handle
difference field size. This is not function change and prepare for 64bit
tcd in imx95.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 61 ++++++++++++++++++-----------------
 drivers/dma/fsl-edma-common.h | 23 +++++++++++++
 2 files changed, 54 insertions(+), 30 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index b53f46245c377..50f55d7566a33 100644
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
+	edma_cp_tcd_to_reg(fsl_chan, tcd, saddr);
+	edma_cp_tcd_to_reg(fsl_chan, tcd, daddr);
 
-	edma_write_tcdreg(fsl_chan, tcd->attr, attr);
-	edma_write_tcdreg(fsl_chan, tcd->soff, soff);
+	edma_cp_tcd_to_reg(fsl_chan, tcd, attr);
+	edma_cp_tcd_to_reg(fsl_chan, tcd, soff);
 
-	edma_write_tcdreg(fsl_chan, tcd->nbytes, nbytes);
-	edma_write_tcdreg(fsl_chan, tcd->slast, slast);
+	edma_cp_tcd_to_reg(fsl_chan, tcd, nbytes);
+	edma_cp_tcd_to_reg(fsl_chan, tcd, slast);
 
-	edma_write_tcdreg(fsl_chan, tcd->citer, citer);
-	edma_write_tcdreg(fsl_chan, tcd->biter, biter);
-	edma_write_tcdreg(fsl_chan, tcd->doff, doff);
+	edma_cp_tcd_to_reg(fsl_chan, tcd, citer);
+	edma_cp_tcd_to_reg(fsl_chan, tcd, biter);
+	edma_cp_tcd_to_reg(fsl_chan, tcd, doff);
 
-	edma_write_tcdreg(fsl_chan, tcd->dlast_sga, dlast_sga);
+	edma_cp_tcd_to_reg(fsl_chan, tcd, dlast_sga);
 
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
+	edma_cp_tcd_to_reg(fsl_chan, tcd, csr);
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
index bb5221158a770..ce779274d81e5 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -238,6 +238,9 @@ struct fsl_edma_engine {
 	edma_writel(chan->edma, (u32 __force)val, &chan->tcd->__name) :	\
 	edma_writew(chan->edma, (u16 __force)val, &chan->tcd->__name))
 
+#define edma_cp_tcd_to_reg(chan, __tcd, __name)			\
+	edma_write_tcdreg(chan, __tcd->__name, __name)
+
 #define edma_readl_chreg(chan, __name)				\
 	edma_readl(chan->edma,					\
 		   (void __iomem *)&(container_of(chan->tcd, struct fsl_edma3_ch_reg, tcd)->__name))
@@ -246,6 +249,26 @@ struct fsl_edma_engine {
 	edma_writel(chan->edma, val,				\
 		   (void __iomem *)&(container_of(chan->tcd, struct fsl_edma3_ch_reg, tcd)->__name))
 
+#define fsl_edma_get_tcd(_chan, _tcd, _field) ((_tcd)->_field)
+
+#define fsl_edma_le_to_cpu(x)					\
+(sizeof(x) == sizeof(u32) ? le32_to_cpu((__force __le32)(x)) : le16_to_cpu((__force __le16)(x)))
+
+#define fsl_edma_get_tcd_to_cpu(_chan, _tcd, _field)		\
+fsl_edma_le_to_cpu(fsl_edma_get_tcd(_chan, _tcd, _field))
+
+#define fsl_edma_set_tcd_to_le(_fsl_chan, _tcd, _val, _field)			\
+do {										\
+	switch (sizeof((_tcd)->_field)) {					\
+	case sizeof(u32):							\
+		*(__force __le32 *)(&((_tcd)->_field)) = cpu_to_le32(_val);	\
+		break;								\
+	case sizeof(u16):							\
+		*(__force __le16 *)(&((_tcd)->_field)) = cpu_to_le16(_val);	\
+		break;								\
+	}									\
+} while (0)
+
 /*
  * R/W functions for big- or little-endian registers:
  * The eDMA controller's endian is independent of the CPU core's endian.
-- 
2.34.1


