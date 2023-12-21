Return-Path: <dmaengine+bounces-608-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2199981BAF2
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 16:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DD2E1F27F63
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 15:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1929353A15;
	Thu, 21 Dec 2023 15:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="n1IKRRUl"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2061.outbound.protection.outlook.com [40.107.20.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6CE53A0F;
	Thu, 21 Dec 2023 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtsmVTvdijMturvY/lWlVnuk+OR2Dkd/kq1oPgqxJmF30E5FSMbUaNyd/YgG5eY4OaTr9hvX0cGPI9g0+7C7pI6QQZP4IuI4P44baM/EctDKdU321KK5UDpYq93rz8As8F+724InKeSbM1M25Wg2KvZljMv1H7/G9xOAyx4sQSk+RECIhjBzVTryt15sTR6pYiGLUk/cfRtH8xFep7UoVVhA+0+RxnmUnaejbiGtMOjT5kEkyKNc/d/rf7bEqLRKJVZIvuEeouHDDm6XKZhAXTd+C84IrsK1nYGP1IKZL2xNJm2+K21S7fyYLQ+xnpUYODxUNEkmAk3oeYfiymYsjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fg3/I2epJCN12Yfy7TkORnxiBn7fEjrtF+pEfKtPJQY=;
 b=MrFniwAUoGua4Ss6exBBneguz3V4Vo2a2OWXQxmOEwnDaAdx0YCTSglN6ZviVYfgoHwGA41CVTgyFb6x9BetVTR+jgfW6vSJPAcmN+2FBt5UJwxEu71PFRrzoXP59acEfUco50ks8xZ7B7/IYtaBK87OAughNsXDLZPWGx+mDCKdpDyS1TdpIRTuwOCtqxzZF8HTc1vQte9dk+OnbqL2vU5tg2pQxYlD/xsuNWUdiOvxg2p0xQItAvDU2JH6rV2JKeHptBhPgzC7+uPKyADiDfzYtw1T9rwBOJupoxuN1ZQa04mrOIRKf/NaVHUZwFZPeL9VNaEgsB+CXv1Xllxm2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fg3/I2epJCN12Yfy7TkORnxiBn7fEjrtF+pEfKtPJQY=;
 b=n1IKRRUl4E+qxFcAs88ozs3QxYPrwkDXso3b6Tkpg09JbkMSE/m1jEBXpaxRpV1W9aKkyoJB8pzC4AuPVPsmHJtPdY8/7qp1MUfxcNS4vRaXBpVaBXfRyYT0EDsDmK6LQLl1HFWw0Z4uvjZcmNbUImsLLExinByMn9bZE2OPRbo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB8194.eurprd04.prod.outlook.com (2603:10a6:20b:3e6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 15:36:04 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 15:36:04 +0000
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
Subject: [PATCH v4 6/6] dmaengine: fsl-edma: integrate TCD64 support for i.MX95
Date: Thu, 21 Dec 2023 10:35:28 -0500
Message-Id: <20231221153528.1588049-7-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a8543698-f151-41c6-db31-08dc023a8aeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0931sv6qpmBlBvcPDx+bcm44U793ufxuCJ9+Y2hneWfQycxoQWPS0DqPWu//j/W0b28pMIvpcxMJy7P/5uLpGO/WPPjxUUCN0qYqPLud/3D+h7aaZeIlDJWu8XOO2iH2Ha481MamiuYWCODkxE+P3sLv7GenjstJGEidcxGJvtS7AHqzjsJ2zcw9K/uix56jXX8Q0yrnHR8OjuuP8vYsRgYYUJyExGktmZSTu2XZ1e9bkhhzifZuXJ//s6SwmPCDxF4ieLCu0fNVc9PHWwJ7H2tq+dT2pFhRbyG4YtjIEbY+ity5Eh4110TqM8HpXJXwJzm5b6Z9SSkk12lKWQ88HhXm01VNTPQARvJT8vdFAZbdIcGU+5Wlvwp3poj6rkbJHk0J/vTjBJKNhWtzMH5H8ohTv+IGvD9RiJjrnXtpeaddIoUyAQaJ5b6bDynJMeVjO0rZXAUaypDfW1UnQuMS3gmspSR1I+eFZ+CdzR3iGWwgMwfcvaKDlncey/bWzFVRFzrk1WWooJMxrY1Lk5dp6qA5dzLl3Pbyo5LpPAFV257sSs2DcRtK/oUw3mYAbcNhkP+xBCUKd/qHqv6kbPIZqRcZ2PvLymsGfN7ahYagVLzRFGnmuW+TRN/Te0fp6kmG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(136003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6506007)(6512007)(1076003)(2616005)(26005)(6666004)(52116002)(4326008)(83380400001)(30864003)(8676002)(8936002)(41300700001)(2906002)(6486002)(478600001)(316002)(5660300002)(66946007)(66556008)(66476007)(36756003)(86362001)(38100700002)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MoG1wwY1nzWdfwj8tP2KsdH8XykR89O02ht7COct5rkgp2nb3QOdRokJhR0i?=
 =?us-ascii?Q?P/2xOogfGrTZlOcutTziVu3WZxuBtXYceGBD4rYrX+0vSNBH/67bsQ1IHu04?=
 =?us-ascii?Q?26AJPflXy8DUyALIilHQurfKUtHSKemO+k9OLMk1/tL2FtgCHnu4t+Oq9t5V?=
 =?us-ascii?Q?VV9NtpmtkKxWFrVSZ8XS1CwFYp+kCxcZqizcUbaw/WtQzjMLEOkPOWRFrfcF?=
 =?us-ascii?Q?YB2X50WLk2Sb+qgTa0Y43Vry8LfW9MUi2YxIIABd1fwh0AAlA0h+RDf0HQe6?=
 =?us-ascii?Q?n96TgGQzh7RoCnyFpj5kPL9CEAkS2Wv4fEbVrSG1B7gdJYVeHecYRDSuT6ue?=
 =?us-ascii?Q?Bb6d4OEl8GxMHuAF8UoBsYTVJ3PqONYZsXKRQl//GEyxtUdig/FDrduXLAOn?=
 =?us-ascii?Q?zEE5U53WicJsxKw/KtBL7bBV7dHNC1dwbFZfI+PRASfMGuD9sBEQq8Z0heCm?=
 =?us-ascii?Q?LPIozzjUdzLndQbdCCr6i8W9Vq5S5yD8ir5+xW1139HI8FqJLrpXULm4DTnh?=
 =?us-ascii?Q?+Mv9Nh1cNnHGpQWlFWu3jLBjp7fjJsxlxiEHl6xah/27/nfv1hjDBZ+UheUC?=
 =?us-ascii?Q?ET5Hyj3ahG+tb2q4Ol93MxtJ37/EaUEdFvx4IWiiG+OlyqXfvF9M2miAEwGW?=
 =?us-ascii?Q?XakNxQPL/ehzLA7HaQfwZRVxt3eNpgW3tFyNfB52Dxct3CAZ/IO8aN4cBD0c?=
 =?us-ascii?Q?jdNf1AQyIV851PAHCvKcBLnetGmLwDErWcFYWBiRufhvUTdXYCEXYfmdmw1j?=
 =?us-ascii?Q?vTlWeAs7A2e5THxMt7BLJWNVcPWckyoEreXBjbiDrRY276L5i8Mh4z0ltxJo?=
 =?us-ascii?Q?Mpaj7IGrCwN01fi3xcB4+xJZ64M1fcETmAnk3VnjC95wWBAfbVw3B9OVQgMR?=
 =?us-ascii?Q?Y6Rv/PVDh45qLBLGhlSODwv/c2rR8q+vP/RkB7uJ7JvK8NETgX4Ues5gyvoC?=
 =?us-ascii?Q?Ttq1drWpharr9jVPaIBNapHLiGJmgx3Jpsl3VEh2oU0/JzprI23T/hSKrZvU?=
 =?us-ascii?Q?ITl/3u9p8DAIt/OIeI3FhseBLsZEEbKrCh6SXnXAQUPXTdx0rbRnKmNIYgaT?=
 =?us-ascii?Q?jAggmQ9pMsaGNwOuoXue3ekU5/FRcB6uRVYiqRbSHyXnqb2NUDDj4omLlVPG?=
 =?us-ascii?Q?PHcc0PDhmppwmst8fUD4/QbjrtoJIiVxMKnyV95EKsj+PaoRYrRLuec0+Gkh?=
 =?us-ascii?Q?K/GTn27SQDAwe1FJC4oHUd55oVQAuWn1UKQ03AlUogzKyMvtJ7qvtoTh7Aa1?=
 =?us-ascii?Q?G2f1CNLy7IN/C8Htfcjw/N2ZbcqvQeEFzH/gRgixhbzltCfh/dEIqgIRXnNt?=
 =?us-ascii?Q?ZNpZ+jakWwvHrhZetoWzsNrowtffuTqFfHPFFT0wky4aDZzvlawv3xHc/F9r?=
 =?us-ascii?Q?pwIqlGAhP33OToUpeO2OZ0oysfjoWIo9Hyd5HiDySOzcfw9ZXngGt9fdM/6Q?=
 =?us-ascii?Q?vTTQ3x9UIDhgdWWS+5FSYkgUb5UtTf5cor0GJvwtoYL6wkoZ6qI/wuEnWs9i?=
 =?us-ascii?Q?JPeCcPW/H80WDDPYUipa59huHpPB1dl1pqwRmk2vyaGt7f4+vHHN0ST6Ocjm?=
 =?us-ascii?Q?ASk8W5bi38QPAKUxS6k=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8543698-f151-41c6-db31-08dc023a8aeb
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 15:36:04.4993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6XbkzpYQre3bkkIaZCQ30D/ED046TgLcMULwZY/evI2imN4gE4dGoqbty+cR8WK3zulFSP90lby4rYUWyxEBYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8194

In i.MX95's edma version 5, the TCD structure is extended to support 64-bit
addresses for fields like saddr and daddr. To prevent code duplication,
employ help macros to handle the fields, as the field names remain the same
between TCD and TCD64.

Change local variables related to TCD addresses from 'u32' to 'dma_addr_t'
to accept 64-bit DMA addresses.

Change 'vtcd' type to 'void *' to avoid direct use. Use helper macros to
access the TCD fields correctly.

Call 'dma_set_mask_and_coherent(64)' when TCD64 is supported.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c |  34 ++++---
 drivers/dma/fsl-edma-common.h | 165 +++++++++++++++++++++++++++-------
 drivers/dma/fsl-edma-main.c   |  14 +++
 3 files changed, 170 insertions(+), 43 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 65f466ab9d4da..c8acff09308fd 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -351,7 +351,7 @@ static size_t fsl_edma_desc_residue(struct fsl_edma_chan *fsl_chan,
 {
 	struct fsl_edma_desc *edesc = fsl_chan->edesc;
 	enum dma_transfer_direction dir = edesc->dirn;
-	dma_addr_t cur_addr, dma_addr;
+	dma_addr_t cur_addr, dma_addr, old_addr;
 	size_t len, size;
 	u32 nbytes = 0;
 	int i;
@@ -367,10 +367,16 @@ static size_t fsl_edma_desc_residue(struct fsl_edma_chan *fsl_chan,
 	if (!in_progress)
 		return len;
 
-	if (dir == DMA_MEM_TO_DEV)
-		cur_addr = edma_read_tcdreg(fsl_chan, saddr);
-	else
-		cur_addr = edma_read_tcdreg(fsl_chan, daddr);
+	/* 64bit read is not atomic, need read retry when high 32bit changed */
+	do {
+		if (dir == DMA_MEM_TO_DEV) {
+			old_addr = edma_read_tcdreg(fsl_chan, saddr);
+			cur_addr = edma_read_tcdreg(fsl_chan, saddr);
+		} else {
+			old_addr = edma_read_tcdreg(fsl_chan, daddr);
+			cur_addr = edma_read_tcdreg(fsl_chan, daddr);
+		}
+	} while (upper_32_bits(cur_addr) != upper_32_bits(old_addr));
 
 	/* figure out the finished and calculate the residue */
 	for (i = 0; i < fsl_chan->edesc->n_tcds; i++) {
@@ -426,8 +432,7 @@ enum dma_status fsl_edma_tx_status(struct dma_chan *chan,
 	return fsl_chan->status;
 }
 
-static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
-				  struct fsl_edma_hw_tcd *tcd)
+static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan, void *tcd)
 {
 	u16 csr = 0;
 
@@ -478,9 +483,9 @@ static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
 
 static inline
 void fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
-		       struct fsl_edma_hw_tcd *tcd, u32 src, u32 dst,
-		       u16 attr, u16 soff, u32 nbytes, u32 slast, u16 citer,
-		       u16 biter, u16 doff, u32 dlast_sga, bool major_int,
+		       struct fsl_edma_hw_tcd *tcd, dma_addr_t src, dma_addr_t dst,
+		       u16 attr, u16 soff, u32 nbytes, dma_addr_t slast, u16 citer,
+		       u16 biter, u16 doff, dma_addr_t dlast_sga, bool major_int,
 		       bool disable_req, bool enable_sg)
 {
 	struct dma_slave_config *cfg = &fsl_chan->cfg;
@@ -581,8 +586,9 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 	dma_addr_t dma_buf_next;
 	bool major_int = true;
 	int sg_len, i;
-	u32 src_addr, dst_addr, last_sg, nbytes;
+	dma_addr_t src_addr, dst_addr, last_sg;
 	u16 soff, doff, iter;
+	u32 nbytes;
 
 	if (!is_slave_direction(direction))
 		return NULL;
@@ -654,8 +660,9 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
 	struct fsl_edma_desc *fsl_desc;
 	struct scatterlist *sg;
-	u32 src_addr, dst_addr, last_sg, nbytes;
+	dma_addr_t src_addr, dst_addr, last_sg;
 	u16 soff, doff, iter;
+	u32 nbytes;
 	int i;
 
 	if (!is_slave_direction(direction))
@@ -804,7 +811,8 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
 
 	fsl_chan->tcd_pool = dma_pool_create("tcd_pool", chan->device->dev,
-				sizeof(struct fsl_edma_hw_tcd),
+				fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_TCD64 ?
+				sizeof(struct fsl_edma_hw_tcd64) : sizeof(struct fsl_edma_hw_tcd),
 				32, 0);
 	return 0;
 }
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 4f39a548547a6..a05a1f283ece2 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -87,6 +87,20 @@ struct fsl_edma_hw_tcd {
 	__le16	biter;
 };
 
+struct fsl_edma_hw_tcd64 {
+	__le64  saddr;
+	__le16  soff;
+	__le16  attr;
+	__le32  nbytes;
+	__le64  slast;
+	__le64  daddr;
+	__le64  dlast_sga;
+	__le16  doff;
+	__le16  citer;
+	__le16  csr;
+	__le16  biter;
+} __packed;
+
 struct fsl_edma3_ch_reg {
 	__le32	ch_csr;
 	__le32	ch_es;
@@ -96,7 +110,10 @@ struct fsl_edma3_ch_reg {
 	__le32	ch_mux;
 	__le32  ch_mattr; /* edma4, reserved for edma3 */
 	__le32  ch_reserved;
-	struct fsl_edma_hw_tcd tcd;
+	union {
+		struct fsl_edma_hw_tcd tcd;
+		struct fsl_edma_hw_tcd64 tcd64;
+	};
 } __packed;
 
 /*
@@ -125,7 +142,7 @@ struct edma_regs {
 
 struct fsl_edma_sw_tcd {
 	dma_addr_t			ptcd;
-	struct fsl_edma_hw_tcd		*vtcd;
+	void				*vtcd;
 };
 
 struct fsl_edma_chan {
@@ -144,7 +161,7 @@ struct fsl_edma_chan {
 	u32				dma_dev_size;
 	enum dma_data_direction		dma_dir;
 	char				chan_name[32];
-	struct fsl_edma_hw_tcd __iomem *tcd;
+	void __iomem			*tcd;
 	void __iomem			*mux_addr;
 	u32				real_count;
 	struct work_struct		issue_worker;
@@ -188,6 +205,7 @@ struct fsl_edma_desc {
 #define FSL_EDMA_DRV_CLEAR_DONE_E_SG	BIT(13)
 /* Need clean CHn_CSR DONE before enable TCD's MAJORELINK */
 #define FSL_EDMA_DRV_CLEAR_DONE_E_LINK	BIT(14)
+#define FSL_EDMA_DRV_TCD64		BIT(15)
 
 #define FSL_EDMA_DRV_EDMA3	(FSL_EDMA_DRV_SPLIT_REG |	\
 				 FSL_EDMA_DRV_BUS_8BYTE |	\
@@ -231,18 +249,61 @@ struct fsl_edma_engine {
 	struct fsl_edma_chan	chans[] __counted_by(n_chans);
 };
 
-#define edma_read_tcdreg(chan, __name)				\
-(sizeof(chan->tcd->__name) == sizeof(u32) ?			\
-	edma_readl(chan->edma, &chan->tcd->__name) :		\
-	edma_readw(chan->edma, &chan->tcd->__name))
+#define edma_read_tcdreg_c(chan, _tcd,  __name)				\
+(sizeof((_tcd)->__name) == sizeof(u64) ?				\
+	edma_readq(chan->edma, &(_tcd)->__name) :			\
+		((sizeof((_tcd)->__name) == sizeof(u32)) ?		\
+			edma_readl(chan->edma, &(_tcd)->__name) :	\
+			edma_readw(chan->edma, &(_tcd)->__name)		\
+		))
+
+#define edma_read_tcdreg(chan, __name)								\
+((fsl_edma_drvflags(chan) & FSL_EDMA_DRV_TCD64) ?						\
+	edma_read_tcdreg_c(chan, ((struct fsl_edma_hw_tcd64 __iomem *)chan->tcd), __name) :	\
+	edma_read_tcdreg_c(chan, ((struct fsl_edma_hw_tcd __iomem *)chan->tcd), __name)		\
+)
+
+#define edma_write_tcdreg_c(chan, _tcd, _val, __name)				\
+do {										\
+	switch (sizeof(_tcd->__name)) {						\
+	case sizeof(u64):							\
+		edma_writeq(chan->edma, (u64 __force)_val, &_tcd->__name);	\
+		break;								\
+	case sizeof(u32):							\
+		edma_writel(chan->edma, (u32 __force)_val, &_tcd->__name);	\
+		break;								\
+	case sizeof(u16):							\
+		edma_writew(chan->edma, (u16 __force)_val, &_tcd->__name);	\
+		break;								\
+	case sizeof(u8):							\
+		edma_writeb(chan->edma, (u8 __force)_val, &_tcd->__name);	\
+		break;								\
+	}									\
+} while (0)
 
-#define edma_write_tcdreg(chan, val, __name)			\
-(sizeof(chan->tcd->__name) == sizeof(u32) ?			\
-	edma_writel(chan->edma, (u32 __force)val, &chan->tcd->__name) :	\
-	edma_writew(chan->edma, (u16 __force)val, &chan->tcd->__name))
+#define edma_write_tcdreg(chan, val, __name)							   \
+do {												   \
+	struct fsl_edma_hw_tcd64 __iomem *tcd64_r = (struct fsl_edma_hw_tcd64 __iomem *)chan->tcd; \
+	struct fsl_edma_hw_tcd __iomem *tcd_r = (struct fsl_edma_hw_tcd __iomem *)chan->tcd;	   \
+												   \
+	if (fsl_edma_drvflags(chan) & FSL_EDMA_DRV_TCD64)					   \
+		edma_write_tcdreg_c(chan, tcd64_r, val, __name);				   \
+	else											   \
+		edma_write_tcdreg_c(chan, tcd_r, val, __name);					   \
+} while (0)
 
-#define edma_cp_tcd_to_reg(chan, __tcd, __name)			\
-	edma_write_tcdreg(chan, __tcd->__name, __name)
+#define edma_cp_tcd_to_reg(chan, __tcd, __name)							   \
+do {	\
+	struct fsl_edma_hw_tcd64 __iomem *tcd64_r = (struct fsl_edma_hw_tcd64 __iomem *)chan->tcd; \
+	struct fsl_edma_hw_tcd __iomem *tcd_r = (struct fsl_edma_hw_tcd __iomem *)chan->tcd;	   \
+	struct fsl_edma_hw_tcd64 *tcd64_m = (struct fsl_edma_hw_tcd64 *)__tcd;			   \
+	struct fsl_edma_hw_tcd *tcd_m = (struct fsl_edma_hw_tcd *)__tcd;			   \
+												   \
+	if (fsl_edma_drvflags(chan) & FSL_EDMA_DRV_TCD64)					   \
+		edma_write_tcdreg_c(chan, tcd64_r,  tcd64_m->__name, __name);			   \
+	else											   \
+		edma_write_tcdreg_c(chan, tcd_r, tcd_m->__name, __name);			   \
+} while (0)
 
 #define edma_readl_chreg(chan, __name)				\
 	edma_readl(chan->edma,					\
@@ -254,24 +315,41 @@ struct fsl_edma_engine {
 		   (void __iomem *)&(container_of(((__force void *)chan->tcd),\
 						  struct fsl_edma3_ch_reg, tcd)->__name))
 
-#define fsl_edma_get_tcd(_chan, _tcd, _field) ((_tcd)->_field)
-
-#define fsl_edma_le_to_cpu(x)					\
-(sizeof(x) == sizeof(u32) ? le32_to_cpu((__force __le32)(x)) : le16_to_cpu((__force __le16)(x)))
-
-#define fsl_edma_get_tcd_to_cpu(_chan, _tcd, _field)		\
-fsl_edma_le_to_cpu(fsl_edma_get_tcd(_chan, _tcd, _field))
+#define fsl_edma_get_tcd(_chan, _tcd, _field)			\
+(fsl_edma_drvflags(_chan) & FSL_EDMA_DRV_TCD64 ? (((struct fsl_edma_hw_tcd64 *)_tcd)->_field) : \
+						 (((struct fsl_edma_hw_tcd *)_tcd)->_field))
+
+#define fsl_edma_le_to_cpu(x)						\
+(sizeof(x) == sizeof(u64) ? le64_to_cpu((__force __le64)(x)) :		\
+	(sizeof(x) == sizeof(u32) ? le32_to_cpu((__force __le32)(x)) :	\
+				    le16_to_cpu((__force __le16)(x))))
+
+#define fsl_edma_get_tcd_to_cpu(_chan, _tcd, _field)				\
+(fsl_edma_drvflags(_chan) & FSL_EDMA_DRV_TCD64 ?				\
+	fsl_edma_le_to_cpu(((struct fsl_edma_hw_tcd64 *)_tcd)->_field) :	\
+	fsl_edma_le_to_cpu(((struct fsl_edma_hw_tcd *)_tcd)->_field))
+
+#define fsl_edma_set_tcd_to_le_c(_tcd, _val, _field)					\
+do {											\
+	switch (sizeof((_tcd)->_field)) {						\
+	case sizeof(u64):								\
+		*(__force __le64 *)(&((_tcd)->_field)) = cpu_to_le64(_val);		\
+		break;									\
+	case sizeof(u32):								\
+		*(__force __le32 *)(&((_tcd)->_field)) = cpu_to_le32(_val);		\
+		break;									\
+	case sizeof(u16):								\
+		*(__force __le16 *)(&((_tcd)->_field)) = cpu_to_le16(_val);		\
+		break;									\
+	}										\
+} while (0)
 
-#define fsl_edma_set_tcd_to_le(_fsl_chan, _tcd, _val, _field)			\
-do {										\
-	switch (sizeof((_tcd)->_field)) {					\
-	case sizeof(u32):							\
-		*(__force __le32 *)(&((_tcd)->_field)) = cpu_to_le32(_val);	\
-		break;								\
-	case sizeof(u16):							\
-		*(__force __le16 *)(&((_tcd)->_field)) = cpu_to_le16(_val);	\
-		break;								\
-	}									\
+#define fsl_edma_set_tcd_to_le(_chan, _tcd, _val, _field)	\
+do {								\
+	if (fsl_edma_drvflags(_chan) & FSL_EDMA_DRV_TCD64)	\
+		fsl_edma_set_tcd_to_le_c((struct fsl_edma_hw_tcd64 *)_tcd, _val, _field);	\
+	else											\
+		fsl_edma_set_tcd_to_le_c((struct fsl_edma_hw_tcd *)_tcd, _val, _field);		\
 } while (0)
 
 /*
@@ -280,6 +358,21 @@ do {										\
  * For the big-endian IP module, the offset for 8-bit or 16-bit registers
  * should also be swapped opposite to that in little-endian IP.
  */
+static inline u64 edma_readq(struct fsl_edma_engine *edma, void __iomem *addr)
+{
+	u64 l, h;
+
+	if (edma->big_endian) {
+		l = ioread32be(addr);
+		h = ioread32be(addr + 4);
+	} else {
+		l = ioread32(addr);
+		h = ioread32(addr + 4);
+	}
+
+	return (h << 32) | l;
+}
+
 static inline u32 edma_readl(struct fsl_edma_engine *edma, void __iomem *addr)
 {
 	if (edma->big_endian)
@@ -325,6 +418,18 @@ static inline void edma_writel(struct fsl_edma_engine *edma,
 		iowrite32(val, addr);
 }
 
+static inline void edma_writeq(struct fsl_edma_engine *edma,
+			       u64 val, void __iomem *addr)
+{
+	if (edma->big_endian) {
+		iowrite32be(val & 0xFFFFFFFF, addr);
+		iowrite32be(val >> 32, addr + 4);
+	} else {
+		iowrite32(val & 0xFFFFFFFF, addr);
+		iowrite32(val >> 32, addr + 4);
+	}
+}
+
 static inline struct fsl_edma_chan *to_fsl_edma_chan(struct dma_chan *chan)
 {
 	return container_of(chan, struct fsl_edma_chan, vchan.chan);
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index d767c89973b69..c2c0c3effc8cb 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -364,6 +364,16 @@ static struct fsl_edma_drvdata imx93_data4 = {
 	.setup_irq = fsl_edma3_irq_init,
 };
 
+static struct fsl_edma_drvdata imx95_data5 = {
+	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_DMACLK | FSL_EDMA_DRV_EDMA4 |
+		 FSL_EDMA_DRV_TCD64,
+	.chreg_space_sz = 0x8000,
+	.chreg_off = 0x10000,
+	.mux_off = 0x200,
+	.mux_skip = sizeof(u32),
+	.setup_irq = fsl_edma3_irq_init,
+};
+
 static const struct of_device_id fsl_edma_dt_ids[] = {
 	{ .compatible = "fsl,vf610-edma", .data = &vf610_data},
 	{ .compatible = "fsl,ls1028a-edma", .data = &ls1028a_data},
@@ -372,6 +382,7 @@ static const struct of_device_id fsl_edma_dt_ids[] = {
 	{ .compatible = "fsl,imx8qm-adma", .data = &imx8qm_audio_data},
 	{ .compatible = "fsl,imx93-edma3", .data = &imx93_data3},
 	{ .compatible = "fsl,imx93-edma4", .data = &imx93_data4},
+	{ .compatible = "fsl,imx95-edma5", .data = &imx95_data5},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_edma_dt_ids);
@@ -513,6 +524,9 @@ static int fsl_edma_probe(struct platform_device *pdev)
 			return ret;
 	}
 
+	if (drvdata->flags & FSL_EDMA_DRV_TCD64)
+		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+
 	INIT_LIST_HEAD(&fsl_edma->dma_dev.channels);
 	for (i = 0; i < fsl_edma->n_chans; i++) {
 		struct fsl_edma_chan *fsl_chan = &fsl_edma->chans[i];
-- 
2.34.1


