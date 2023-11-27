Return-Path: <dmaengine+bounces-267-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4D97FADBF
	for <lists+dmaengine@lfdr.de>; Mon, 27 Nov 2023 23:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03B381C20D49
	for <lists+dmaengine@lfdr.de>; Mon, 27 Nov 2023 22:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3183948CF4;
	Mon, 27 Nov 2023 22:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mrAo9VuM"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on062b.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1e::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874DC1A2;
	Mon, 27 Nov 2023 14:56:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7r/2OlBB+32XX0MImtjzmN88Ons1SKTxi4WF/0rNaDnnDimnCaqDlB76v0CnRaFoCbuR6uOkLIPNABhH0LlrB4PXzBdCyNUCBBa3lDgCxn/PVDIA5fsFuqgcuLH4UwRh8YC6pudPewqy+QMpr9bZsUUQHOR/KirUlwKQTJiDPdz+7obLoPPH9pogH4u/1Zr9jglVQCYGSDoLdL4BoYl1FFqJw5q7DDHFQW7jxI1JwKcd+OZxvTd/THUDGOxvy/CxicrFn0ucSBqllwGrzNyqVUQBOgejAkOIfnB64ktovg9xKmha7/p0GseJDrf6yd/h047Zx0IXLNB/sLDyAF1BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7yVzVo7EuQGlTzc4m2DQUz+qtkprIyQR4WJck0cUOk=;
 b=AuW0Gq1O4vl2musha12t28GTz/LdcH+PhcZ8StnBenuryLUYL4BwVwFKPDVRKDpmUHV7pmXB7eMVMEK7jcp4Lj8AXKMmHIrogNAcBHcPKanTc4rEuPg5iOgExTaHol841fzr2u8lY0bCxE3JtNWOrelCVguPZc/Ve4MbTmVZHICBJs1CP6PEMZA4NCtxGu7VXI4P3RWKLZAepToo1ecZwpbfNuPpUbVz5IgG0u7nU+nCmtfTbmJjk4YZglPGcIOVyqM81ovEoF372kGoeOvF09xWdxYqFw1+v+qzuaacgAqLnYFZb9fMlU4BU58owsG2Zt/jbvqzVzagP9/tYXnAaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7yVzVo7EuQGlTzc4m2DQUz+qtkprIyQR4WJck0cUOk=;
 b=mrAo9VuMFQDro4CejxiDBa5vXWQyWg+GwWvu5SxilT/79RVMSOKPbGPi9iknNHMnhJck3Ss1j9h0JctHrHk2eHFTAp7yyMZGPOvNwpn6Ea8ryE4zc3dIDYgjQ0qSV8jZo33G2cFUpehF3Ui5F6ZAcMx36eMyFwrOylesRY0Ce40=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM8PR04MB7858.eurprd04.prod.outlook.com (2603:10a6:20b:237::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Mon, 27 Nov
 2023 22:56:03 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7046.015; Mon, 27 Nov 2023
 22:56:03 +0000
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
Subject: [PATCH v3 1/6] dmaengine: fsl-edma: involve help macro fsl_edma_set(get)_tcd()
Date: Mon, 27 Nov 2023 17:55:37 -0500
Message-Id: <20231127225542.2744711-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127225542.2744711-1-Frank.Li@nxp.com>
References: <20231127225542.2744711-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0116.namprd05.prod.outlook.com
 (2603:10b6:a03:334::31) To VI1PR04MB4845.eurprd04.prod.outlook.com
 (2603:10a6:803:51::30)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM8PR04MB7858:EE_
X-MS-Office365-Filtering-Correlation-Id: 650225f6-e457-4d02-83ec-08dbef9c082a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	u8JAoU1Ivd0R6A3oDwlkzwXUqF9CVKCrJrvTaKZsmWxPq1xjadslhqwbjCHMru2XdDuwnn/VAHLK8dgZqKcL12+lYHiykmZXjA7WUY2iAJd2OaTTG9gktX9HLF7q4rRDsBVwYX6VXCG88qPNjn55x2Dn/gACBz8/htePl2XtcxDdYz6Bco+BS0MCH2O4yY2slYH+KZutFdq0ZrH0vmyVeyJTNaxoywpDK1VE2/+3O20M6GtZHQi9U9ekSOE0BM29H9JM92OSSZd9QVkKoJQVBYG0RMFzY+Ssgm6s/TrVHwDS3pQYGeoaRQcNZ1Q+l9HjZftkplYvykcI3gAJ1LxDjNZWT9ucQIHaaTeG2MOQ+FiTGxS/fFH2adwbSM7BopwJewgGJ1DaUurixCPJkjsk8eQzVfgUpYwA7jlXNDDEtD1lto/YVEB2DbdQF9ZAe4ViBeyL5B6BpZyZux+dm9cM+z77TGalcTYIaCUOYa8bbd8ukozTH/nvTYd3x76erLjGw4pXxd6Ldf26/yGysPbzPS5cJXrFueNhFwsNOeqk7jMtX5gCJUGJvCFGGdMDr6K6lFN6e7mhBv+DDbbJahxV9u8UvDhtnM1kQ3PsNrvEGhGUYhdocHdhCcjoZJkTKc+e
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(2616005)(26005)(1076003)(6666004)(6506007)(8676002)(52116002)(4326008)(8936002)(6486002)(86362001)(5660300002)(478600001)(316002)(66946007)(66476007)(66556008)(38100700002)(83380400001)(6512007)(38350700005)(2906002)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YuNdakhGWvwnrObqp7S6bMrPS9y/BqY1ykSgPurD726ndwI5tfTJm5eK4k1Y?=
 =?us-ascii?Q?FF/b80vRjQ/QAk1eIQoWJbiXiBl1Jv2TmjMVPiO9PERzO8XCzIkYm8k3KIr8?=
 =?us-ascii?Q?OWeQYzSCqoFYJv4vxPBQ2iISwwyYmFlq+IoZiV8bkpNKj5CIEVdivTl7Pun2?=
 =?us-ascii?Q?4+U6OeBXlJEozjxLq8vlFVppj2EicHC6zVg40I2VkulgAntWFqovzR3oxgyQ?=
 =?us-ascii?Q?k2ljXDjnRSTKNZWGTN+4VsBEjw4vy5rzP0ZtD2QtYidvaQoQpi1Hioe6rdC+?=
 =?us-ascii?Q?JCkiF+Honwh7fwkp5OoeJc5oxXjx21NnUUKx8aJAQLRKj2HIErWv6sOO4GR3?=
 =?us-ascii?Q?aNw/lyG8dO/VHsaCUhXBDA2xRG1NexuojIzXAiZKfYKLH2pRiEwfyHpqHiL+?=
 =?us-ascii?Q?bZFtFOGv2jzSv1L/a0GWWSCcQbw4IgLEOCqcafEcTjab7nYl1TtoVPodLw2F?=
 =?us-ascii?Q?ukDOLSY/uI5ZkOccd8is3cQ3eyPDRHRI2NjiZ+GVgGvwNGnX3dpP944C893r?=
 =?us-ascii?Q?JXXrwMGObxZXybiCKbkWSehlW+Mzxqhav6KLKZ4mVDSsNHT5ojdN9RIOKj/Q?=
 =?us-ascii?Q?zx7xM57FbQgbJHXRJHREwnJtuU5wvH4eeRQMEQ1VWItbGqYr6tSuA7rnBtO0?=
 =?us-ascii?Q?7aglE01AYIoOdGn6ERD51tkgevVr8dmfMWWa1MCuyyT3ZFFGw09Vu3F0yiZ+?=
 =?us-ascii?Q?xMKLaWaCx1aCfDTjkSm6/v76mqtE2nRtXNns6ZtvgRSU7PguKdlUE4EI+iSw?=
 =?us-ascii?Q?lu8i0AFBo7aRQwvkL2pTWNHZokFiSD5tU3IiUnZKSKMOhWX/55N/NpRYfvBT?=
 =?us-ascii?Q?lZVQRh8A9A0pKhNQBnf3Ea+JH9FjJW3L70GzOLrHx14/Q5JKbQCT/wdF+rjk?=
 =?us-ascii?Q?UzWhLkwhJXohCdjt0KLzBrWPsH/YoOHPKeE3b603DdNeIcHdzi+ddZrT/gh6?=
 =?us-ascii?Q?xQdUk6YPi6/UcbU1jenWjTDp1gs2VQv7f/w6yghIF+lvrT5I1WBUQ+Dz3Tjo?=
 =?us-ascii?Q?HN4Xa/gNicV0lZ5dpINGt8xVZtoTuaV2ys0yCIIU/fk3Xq+p6c8Nb3gDfR2q?=
 =?us-ascii?Q?vor1DlSUX3hxKOS8yzf3+tyV2cF+DC+R9Hxlun2rOIK7AwBQVRVT5Z1Zzb4T?=
 =?us-ascii?Q?tIw/HhNoz+2cCVTynJFLFIp6aMUEaMPJm7F/kJK6zq/yT9K8PpVVgpz6UCIy?=
 =?us-ascii?Q?daF15V7Zl007GviZmW4e7hnyQeje+xvpkEr8amFl9hesaw8HOhzaIC1DoLnk?=
 =?us-ascii?Q?3qPkXubZS/hnEajcibxkgO+A+x3WIpAbEu+D3OYrRIPVtAiw3eIefHMMHYBz?=
 =?us-ascii?Q?p65Tc3Lp7h83X60uqP/MuS8Ar7LHZ7K20+1mhPhBrCojdn0zV38W3WE/pJ+j?=
 =?us-ascii?Q?yiftApCwsVLQvKuGkYj8Zs+G3vNLm6tyqaeft9KT8peTlturghaJCxRlClmR?=
 =?us-ascii?Q?nGkHkrKCWNr7rYnocpG3IAduaRCahClKNNUM7EY1v6QgiMVjGG1031HCAS0P?=
 =?us-ascii?Q?16zi6lQ1yGwckzfJ41VsyFAhLRl6XXFFJypW3bizz/vMeMKCKnnjI0KEmbHS?=
 =?us-ascii?Q?wL5tBcgdqrGt6s84aAM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 650225f6-e457-4d02-83ec-08dbef9c082a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 22:56:03.8815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9YKiudgSd23f4n/LiXTCoDYiAdtPIF4tO8/y7csfTZnnvxizwTR0gUVH6HBF0vYE1PRMAO8pCemKTCg/fqXw+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7858

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


