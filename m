Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565864D0B62
	for <lists+dmaengine@lfdr.de>; Mon,  7 Mar 2022 23:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241115AbiCGWtM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Mar 2022 17:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343869AbiCGWtM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Mar 2022 17:49:12 -0500
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30049.outbound.protection.outlook.com [40.107.3.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671B0641D;
        Mon,  7 Mar 2022 14:48:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2Jredeux9diQ6ujESHEye1wu46tMcmfZQQI6BCZTp7BtUwY/vFEP3csXzvngCWAOd+opHmGQLAo2z3wqSqTHDpPRH+GcA2teuxdZsHJ+OJIGV8dwek2eL40Kz7tcGr4nzLju0t6EIo3yLx0xtNc4/XM/+ks9U5t8zHldS8PSUda4uPAZTd8ZZdeHTQsX297sVgXxQfB76To3CCkmitphvKM78aChqwO7vBmWcGUZkniQHye8s7y/MGH74VG8SfJzbJ/0GNfB8lUpLZQCFZO4YpmQ2jLGN/QWX+OGDn/0IwWYihuqJHLptssDrd4K2tCmrEO6Jy13C1fapfUxaBUsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZJ8P6i6nW7geaUWXGlygn5GEoit4xRthIO/Uahb3+g=;
 b=VIpRnAHz26nHP9XEaXhl9UuA7aYBK4/9YUYV35whAkC1SHsmaKdDTQ/3sRJQCSbQO7yEzsQv2J3IcaEM7VKiDC5fsNL+NTlxFyjBmdhPuhqgTqXcOtmduZTCQRC6+BZWg4WIq6S6bXwUx0O42iT1uYqglYnZd+YFf33zLsMAH9uShZmJYJYlhRFubDoU8AktA6iQ0uThZjOBXR5SMvd1QMJta9YgjGda1eeJbI7eVNqDvAJllEfB4bPAbxTxPymUY7N9ad+eXEI7BL3tjtEssLU4ZMT8P5S6ww5LzvOGrk/Yc6qgEPAinEA45tqwreZVNCdj5KjLN2H9Zz8oMEmltQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZJ8P6i6nW7geaUWXGlygn5GEoit4xRthIO/Uahb3+g=;
 b=p0NvVU1RJLdQxU9ML7AyAm2ZStSNevTliA3PRmPluvzM1SR1nXvVeGG48jR6sjpKvnaR4nU4imf8S0bwQoMFCjhEv7sz2L38OltcxGLAHiChrN2lKRc4H56snMZwVsqM4TAi5nQcfYDfhrIJLG3OSk2q2XcidM0B+MjYQJAwcSc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM0PR04MB4946.eurprd04.prod.outlook.com (2603:10a6:208:c0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Mon, 7 Mar
 2022 22:48:11 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8%7]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 22:48:10 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, shawnguo@kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v3 1/6] dmaengine: dw-edma: fix dw_edma_probe() can't be call globally
Date:   Mon,  7 Mar 2022 16:47:45 -0600
Message-Id: <20220307224750.18055-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.24.0.rc1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::24) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f608747-821e-44d4-82ff-08da008c8e19
X-MS-TrafficTypeDiagnostic: AM0PR04MB4946:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB494618AF73ACD2326D1EEAF488089@AM0PR04MB4946.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WiRNRBGmx6xNSilZx7MlLOPvI/FeVZNpVsTf1rtiX8anNrTqs2fpMehPv2IkUUua/+NklqcAZPa6rYE2kMzYhAni3FIeJQMU0IYApW5JH7tRqk1+8S1TN1Pbga+jK/NUGCHdFTaqHySefd6SkSC+KyVgcomL2hvB8x0javn7OnJEFEnZWoLc2ML3jq6O4/WKo8Jh3Dgd5t6OXNtvnb5kserwrp+db8gS7F/ut4YZy9UrSrcGKcQOR+xM3r698oBROQv9RM1uB8P4Lt2Pb9T0fpQIBIYFvoxl3BzcGO+5MXugnF/VOXB2eUPAoW9VvTvBOcEn2vYGK+HxAOI5eTb3Wm+5brrT7BCpF3lFgzyNE9/Np4h8U0hEwHnOt3MNzf9z6XWEBP8xyKp2fpO67CoGSUu2VJET6+9zw0eOCQ9t1TbcLD3D46qabwmE/4fmq1XqGk1eO0kxwcRhjgN+yaayiAQoZIdzrLjJMkvcDgK/8yOhdWxjleUZFfqD5CmLnjVVqnA6uB8UA9CVLbQEZQdQWZZQODUccrCwHc1hZY3fFGLT7zmzZiu7q3bY4+y+sZ6dPXSjvk2ApgumOM4ky1UB/VRA6+DmugTTsNWF+iRrqQe1IIRIUPMXqpN4NByeeiocA5UZb6LcNkrSr9KU66byRnI9mokrfQE9CCejWi75HFyQKqgYkJIXoUq9Yic0LxjcL4ZebvzZaCKGed1nJBFlqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(5660300002)(86362001)(30864003)(8676002)(498600001)(7416002)(66476007)(66946007)(66556008)(4326008)(6512007)(8936002)(6486002)(6666004)(6506007)(52116002)(83380400001)(38350700002)(1076003)(186003)(26005)(36756003)(2616005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l0clYozaxaP21I/EIbH7j3KAyBQKVQW4wyXMFRaZA7HbvRKGR9hqq9UhP0yq?=
 =?us-ascii?Q?d9rwNQwvHEGPeSBe4uEzPaz6mq1+TbDt4yCA80LnFwMreYUE1p3J9DSSyh2u?=
 =?us-ascii?Q?6k+m4nZMOBdTB89aEQUrfpkc7mcIvNGqEfu2yEXF44l303dPtfqj+V10MKBp?=
 =?us-ascii?Q?vls4zZl+F9A3OYG+V0GY5J0RD3cTKn9QKJINx4EO9dpIl43QU5wt0vYShdiM?=
 =?us-ascii?Q?A2+aRxXTvF/7IO2FYXPHOOpIrSjzI6bIHV6xlxlGbs5xnJLQ5MPuZ0+WeBir?=
 =?us-ascii?Q?8MZ/CBT5L1mryONNPUZ2U+yInO6139Ex+Zv+jL+7SqaNhAmpW+VpZ8DWJkkg?=
 =?us-ascii?Q?SD5MFE9c/Cum1PGpX240vQyXkcaRdJwhhFIGUn47c7VWUxom+QSqfDuFMmbP?=
 =?us-ascii?Q?mJIcKviqNbWXMeKTR70xQMO1sJBrYmiPOq7Hx7S+PhWXMy5yCpdtjqkV089X?=
 =?us-ascii?Q?3Cqrna5NFujOCEEOdBHJ1P5LleYM9pbmKuI9OTB6fo0XhXAhnkrz/jgGtPJ2?=
 =?us-ascii?Q?LWHpFjcluLyOznSVIDrGGfvLMaKj6tYqcc0UHR/+EO95rThMy54sM7CtaKAR?=
 =?us-ascii?Q?weI/fyLjqxuQ3jQAfPjNKyRG8/H7gWLas1RBN6zSR6Wz+YCLgXCQxV+pBoxU?=
 =?us-ascii?Q?Z7WXKVlB5sbrTuFNVYF1KPCRDC3hF5Fm2VTasTpmVzsx0LfTwTxbdyMHoelk?=
 =?us-ascii?Q?swjVh07APs7ccuPtuNSJZ9Iygte3CqKS0bWGnaFENpyw+ToerRNh/jcyiaw6?=
 =?us-ascii?Q?9W0nzvrsGSRIQ/wOlNBkBxtINZhgpAASMCFPOE/Pjb9qtVt4lh5cs40T1RYs?=
 =?us-ascii?Q?+PSZA13sFNIGzXcNY2O3sjlRJ4zBxAM2ZG8zNz5rE1kJGQdJHH8FvYp025S4?=
 =?us-ascii?Q?hiE1niq5J+K/pJF6pxkY+3Py787fDYogkBozhFy5bKgp0UI/HVFzqYaNsIdP?=
 =?us-ascii?Q?N982aGyxId5L+n4wAfXZqdo4EvIUXXkFZEczOVcivhhwf4Fvpljme3AzC389?=
 =?us-ascii?Q?FrXFgWcEbZJxger4IcQsFJ12jHkH2Cd1CuRVsalD6Uo0G8+V/3wsA6LbnDZF?=
 =?us-ascii?Q?hidFBbCMUMwSroGAcE11dOIw6A5KB9hDAZmSa2/UHk3kpGGHNtYqTAh0lcX7?=
 =?us-ascii?Q?/f420a6bAD0DuyXC0jLcprXMLLZo0W5u3HFgW+VmQBydBeHAc1Hcos4bLNQz?=
 =?us-ascii?Q?ZRJq86tZ9o5w/20harUnYlFWfgrx9t/YnvjMk5gidA18gFgXTAgso83ji8yZ?=
 =?us-ascii?Q?dTfyf1aYXJiMtgmAS7QEpDFK9GmW33y6b4P9+Id5HyHi0qvnA88O0m/RUBQq?=
 =?us-ascii?Q?/ePD7/k9vDm96vzB1LzP3a55kPYvl11Kla0rSVycSiZVh7hlMAdxGzxj44WI?=
 =?us-ascii?Q?IqElJ9Xp51LZGRr6Eu8aYTkFTZ+08MPXB43AuQP1jkHD4fG6ych8t+JpOjCv?=
 =?us-ascii?Q?EDfMtBtbiaCR7jGpec0CvJQRd3RLwa8x8nLr9fvN9jlValBIMZvQrMleKfB+?=
 =?us-ascii?Q?2w4S1B3s+4Aw7hN7J9xes7fhTosoMhx6rnNX2ree4y30xmF1g5rwZPWh2pal?=
 =?us-ascii?Q?TsQbtKz8zvgNMqUeTx4KCI8hKLfZa3ZQ3JQN8rMYbBVWjSb5fizh7Lpbp6mv?=
 =?us-ascii?Q?wGrTOCNi3ogTgo30Bk8y0bQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f608747-821e-44d4-82ff-08da008c8e19
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 22:48:10.9241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: orjaSJdbWmmFMRCnYRhLoeCG7ww3eXI0ZGZgdAXrK+PJHP4bBC2tynJSI4Aby7Mn1QCxZ4uElra82bdvnAZiig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4946
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

"struct dw_edma_chip" contains an internal structure "struct dw_edma" that is
used by the eDMA core internally. This structure should not be touched
by the eDMA controller drivers themselves. But currently, the eDMA
controller drivers like "dw-edma-pci" allocates and populates this
internal structure then passes it on to eDMA core. The eDMA core further
populates the structure and uses it. This is wrong!

Hence, move all the "struct dw_edma" specifics from controller drivers
to the eDMA core.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Resend added dmaengine@vger.kernel.org

Change from v2 to v3
 - none
Change from v1 to v2
 - rework commit message
 - remove duplicate field in struct dw_edma

 drivers/dma/dw-edma/dw-edma-core.c       |  91 +++++-----
 drivers/dma/dw-edma/dw-edma-core.h       |  30 +---
 drivers/dma/dw-edma/dw-edma-v0-core.c    | 206 ++++++++++++-----------
 drivers/dma/dw-edma/dw-edma-v0-core.h    |   8 +-
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c |  37 ++--
 include/linux/dma/edma.h                 |  47 +++++-
 6 files changed, 230 insertions(+), 189 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 53289927dd0d6..0cb66434f9e14 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -65,7 +65,7 @@ static struct dw_edma_burst *dw_edma_alloc_burst(struct dw_edma_chunk *chunk)
 static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
 {
 	struct dw_edma_chan *chan = desc->chan;
-	struct dw_edma *dw = chan->chip->dw;
+	struct dw_edma_chip *chip = chan->chip;
 	struct dw_edma_chunk *chunk;
 
 	chunk = kzalloc(sizeof(*chunk), GFP_NOWAIT);
@@ -82,11 +82,11 @@ static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
 	 */
 	chunk->cb = !(desc->chunks_alloc % 2);
 	if (chan->dir == EDMA_DIR_WRITE) {
-		chunk->ll_region.paddr = dw->ll_region_wr[chan->id].paddr;
-		chunk->ll_region.vaddr = dw->ll_region_wr[chan->id].vaddr;
+		chunk->ll_region.paddr = chip->ll_region_wr[chan->id].paddr;
+		chunk->ll_region.vaddr = chip->ll_region_wr[chan->id].vaddr;
 	} else {
-		chunk->ll_region.paddr = dw->ll_region_rd[chan->id].paddr;
-		chunk->ll_region.vaddr = dw->ll_region_rd[chan->id].vaddr;
+		chunk->ll_region.paddr = chip->ll_region_rd[chan->id].paddr;
+		chunk->ll_region.vaddr = chip->ll_region_rd[chan->id].vaddr;
 	}
 
 	if (desc->chunk) {
@@ -601,7 +601,8 @@ static void dw_edma_abort_interrupt(struct dw_edma_chan *chan)
 static irqreturn_t dw_edma_interrupt(int irq, void *data, bool write)
 {
 	struct dw_edma_irq *dw_irq = data;
-	struct dw_edma *dw = dw_irq->dw;
+	struct dw_edma_chip *chip = dw_irq->chip;
+	struct dw_edma *dw = chip->dw;
 	unsigned long total, pos, val;
 	unsigned long off;
 	u32 mask;
@@ -616,7 +617,7 @@ static irqreturn_t dw_edma_interrupt(int irq, void *data, bool write)
 		mask = dw_irq->rd_mask;
 	}
 
-	val = dw_edma_v0_core_status_done_int(dw, write ?
+	val = dw_edma_v0_core_status_done_int(chip, write ?
 							  EDMA_DIR_WRITE :
 							  EDMA_DIR_READ);
 	val &= mask;
@@ -626,7 +627,7 @@ static irqreturn_t dw_edma_interrupt(int irq, void *data, bool write)
 		dw_edma_done_interrupt(chan);
 	}
 
-	val = dw_edma_v0_core_status_abort_int(dw, write ?
+	val = dw_edma_v0_core_status_abort_int(chip, write ?
 							   EDMA_DIR_WRITE :
 							   EDMA_DIR_READ);
 	val &= mask;
@@ -718,7 +719,7 @@ static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
 	}
 
 	INIT_LIST_HEAD(&dma->channels);
-	for (j = 0; (alloc || dw->nr_irqs == 1) && j < cnt; j++, i++) {
+	for (j = 0; (alloc || chip->nr_irqs == 1) && j < cnt; j++, i++) {
 		chan = &dw->chan[i];
 
 		dt_region = devm_kzalloc(dev, sizeof(*dt_region), GFP_KERNEL);
@@ -735,15 +736,15 @@ static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
 		chan->status = EDMA_ST_IDLE;
 
 		if (write)
-			chan->ll_max = (dw->ll_region_wr[j].sz / EDMA_LL_SZ);
+			chan->ll_max = (chip->ll_region_wr[j].sz / EDMA_LL_SZ);
 		else
-			chan->ll_max = (dw->ll_region_rd[j].sz / EDMA_LL_SZ);
+			chan->ll_max = (chip->ll_region_rd[j].sz / EDMA_LL_SZ);
 		chan->ll_max -= 1;
 
 		dev_vdbg(dev, "L. List:\tChannel %s[%u] max_cnt=%u\n",
 			 write ? "write" : "read", j, chan->ll_max);
 
-		if (dw->nr_irqs == 1)
+		if (chip->nr_irqs == 1)
 			pos = 0;
 		else
 			pos = off_alloc + (j % alloc);
@@ -755,7 +756,7 @@ static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
 		else
 			irq->rd_mask |= BIT(j);
 
-		irq->dw = dw;
+		irq->chip = chip;
 		memcpy(&chan->msi, &irq->msi, sizeof(chan->msi));
 
 		dev_vdbg(dev, "MSI:\t\tChannel %s[%u] addr=0x%.8x%.8x, data=0x%.8x\n",
@@ -767,13 +768,13 @@ static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
 		vchan_init(&chan->vc, dma);
 
 		if (write) {
-			dt_region->paddr = dw->dt_region_wr[j].paddr;
-			dt_region->vaddr = dw->dt_region_wr[j].vaddr;
-			dt_region->sz = dw->dt_region_wr[j].sz;
+			dt_region->paddr = chip->dt_region_wr[j].paddr;
+			dt_region->vaddr = chip->dt_region_wr[j].vaddr;
+			dt_region->sz = chip->dt_region_wr[j].sz;
 		} else {
-			dt_region->paddr = dw->dt_region_rd[j].paddr;
-			dt_region->vaddr = dw->dt_region_rd[j].vaddr;
-			dt_region->sz = dw->dt_region_rd[j].sz;
+			dt_region->paddr = chip->dt_region_rd[j].paddr;
+			dt_region->vaddr = chip->dt_region_rd[j].vaddr;
+			dt_region->sz = chip->dt_region_rd[j].sz;
 		}
 
 		dw_edma_v0_core_device_config(chan);
@@ -840,16 +841,16 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
 
 	ch_cnt = dw->wr_ch_cnt + dw->rd_ch_cnt;
 
-	if (dw->nr_irqs < 1)
+	if (chip->nr_irqs < 1)
 		return -EINVAL;
 
-	if (dw->nr_irqs == 1) {
+	if (chip->nr_irqs == 1) {
 		/* Common IRQ shared among all channels */
-		irq = dw->ops->irq_vector(dev, 0);
+		irq = chip->ops->irq_vector(dev, 0);
 		err = request_irq(irq, dw_edma_interrupt_common,
 				  IRQF_SHARED, dw->name, &dw->irq[0]);
 		if (err) {
-			dw->nr_irqs = 0;
+			chip->nr_irqs = 0;
 			return err;
 		}
 
@@ -857,7 +858,7 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
 			get_cached_msi_msg(irq, &dw->irq[0].msi);
 	} else {
 		/* Distribute IRQs equally among all channels */
-		int tmp = dw->nr_irqs;
+		int tmp = chip->nr_irqs;
 
 		while (tmp && (*wr_alloc + *rd_alloc) < ch_cnt) {
 			dw_edma_dec_irq_alloc(&tmp, wr_alloc, dw->wr_ch_cnt);
@@ -868,7 +869,7 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
 		dw_edma_add_irq_mask(&rd_mask, *rd_alloc, dw->rd_ch_cnt);
 
 		for (i = 0; i < (*wr_alloc + *rd_alloc); i++) {
-			irq = dw->ops->irq_vector(dev, i);
+			irq = chip->ops->irq_vector(dev, i);
 			err = request_irq(irq,
 					  i < *wr_alloc ?
 						dw_edma_interrupt_write :
@@ -876,7 +877,7 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
 					  IRQF_SHARED, dw->name,
 					  &dw->irq[i]);
 			if (err) {
-				dw->nr_irqs = i;
+				chip->nr_irqs = i;
 				return err;
 			}
 
@@ -884,7 +885,7 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
 				get_cached_msi_msg(irq, &dw->irq[i].msi);
 		}
 
-		dw->nr_irqs = i;
+		chip->nr_irqs = i;
 	}
 
 	return err;
@@ -905,18 +906,24 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 	if (!dev)
 		return -EINVAL;
 
-	dw = chip->dw;
-	if (!dw || !dw->irq || !dw->ops || !dw->ops->irq_vector)
+	dw = devm_kzalloc(dev, sizeof(*dw), GFP_KERNEL);
+	if (!dw)
+		return -ENOMEM;
+
+	chip->dw = dw;
+
+	if (!chip->nr_irqs || !chip->ops)
 		return -EINVAL;
 
 	raw_spin_lock_init(&dw->lock);
 
-	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt,
-			      dw_edma_v0_core_ch_count(dw, EDMA_DIR_WRITE));
+
+	dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt,
+			      dw_edma_v0_core_ch_count(chip, EDMA_DIR_WRITE));
 	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
 
-	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt,
-			      dw_edma_v0_core_ch_count(dw, EDMA_DIR_READ));
+	dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt,
+			      dw_edma_v0_core_ch_count(chip, EDMA_DIR_READ));
 	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
 
 	if (!dw->wr_ch_cnt && !dw->rd_ch_cnt)
@@ -934,7 +941,11 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 	snprintf(dw->name, sizeof(dw->name), "dw-edma-core:%d", chip->id);
 
 	/* Disable eDMA, only to establish the ideal initial conditions */
-	dw_edma_v0_core_off(dw);
+	dw_edma_v0_core_off(chip);
+
+	dw->irq = devm_kcalloc(dev, chip->nr_irqs, sizeof(*dw->irq), GFP_KERNEL);
+	if (!dw->irq)
+		return -ENOMEM;
 
 	/* Request IRQs */
 	err = dw_edma_irq_request(chip, &wr_alloc, &rd_alloc);
@@ -960,10 +971,10 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 	return 0;
 
 err_irq_free:
-	for (i = (dw->nr_irqs - 1); i >= 0; i--)
-		free_irq(dw->ops->irq_vector(dev, i), &dw->irq[i]);
+	for (i = (chip->nr_irqs - 1); i >= 0; i--)
+		free_irq(chip->ops->irq_vector(dev, i), &dw->irq[i]);
 
-	dw->nr_irqs = 0;
+	chip->nr_irqs = 0;
 
 	return err;
 }
@@ -977,11 +988,11 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 	int i;
 
 	/* Disable eDMA */
-	dw_edma_v0_core_off(dw);
+	dw_edma_v0_core_off(chip);
 
 	/* Free irqs */
-	for (i = (dw->nr_irqs - 1); i >= 0; i--)
-		free_irq(dw->ops->irq_vector(dev, i), &dw->irq[i]);
+	for (i = (chip->nr_irqs - 1); i >= 0; i--)
+		free_irq(chip->ops->irq_vector(dev, i), &dw->irq[i]);
 
 	/* Power management */
 	pm_runtime_disable(dev);
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 60316d408c3e0..885f6719c9462 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -15,20 +15,12 @@
 #include "../virt-dma.h"
 
 #define EDMA_LL_SZ					24
-#define EDMA_MAX_WR_CH					8
-#define EDMA_MAX_RD_CH					8
 
 enum dw_edma_dir {
 	EDMA_DIR_WRITE = 0,
 	EDMA_DIR_READ
 };
 
-enum dw_edma_map_format {
-	EDMA_MF_EDMA_LEGACY = 0x0,
-	EDMA_MF_EDMA_UNROLL = 0x1,
-	EDMA_MF_HDMA_COMPAT = 0x5
-};
-
 enum dw_edma_request {
 	EDMA_REQ_NONE = 0,
 	EDMA_REQ_STOP,
@@ -57,12 +49,6 @@ struct dw_edma_burst {
 	u32				sz;
 };
 
-struct dw_edma_region {
-	phys_addr_t			paddr;
-	void				__iomem *vaddr;
-	size_t				sz;
-};
-
 struct dw_edma_chunk {
 	struct list_head		list;
 	struct dw_edma_chan		*chan;
@@ -106,11 +92,7 @@ struct dw_edma_irq {
 	struct msi_msg                  msi;
 	u32				wr_mask;
 	u32				rd_mask;
-	struct dw_edma			*dw;
-};
-
-struct dw_edma_core_ops {
-	int	(*irq_vector)(struct device *dev, unsigned int nr);
+	struct dw_edma_chip		*chip;
 };
 
 struct dw_edma {
@@ -122,19 +104,9 @@ struct dw_edma {
 	struct dma_device		rd_edma;
 	u16				rd_ch_cnt;
 
-	struct dw_edma_region		rg_region;	/* Registers */
-	struct dw_edma_region		ll_region_wr[EDMA_MAX_WR_CH];
-	struct dw_edma_region		ll_region_rd[EDMA_MAX_RD_CH];
-	struct dw_edma_region		dt_region_wr[EDMA_MAX_WR_CH];
-	struct dw_edma_region		dt_region_rd[EDMA_MAX_RD_CH];
-
 	struct dw_edma_irq		*irq;
-	int				nr_irqs;
-
-	enum dw_edma_map_format		mf;
 
 	struct dw_edma_chan		*chan;
-	const struct dw_edma_core_ops	*ops;
 
 	raw_spinlock_t			lock;		/* Only for legacy */
 #ifdef CONFIG_DEBUG_FS
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 329fc2e57b703..6e2f83e31a03a 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -23,92 +23,94 @@ enum dw_edma_control {
 	DW_EDMA_V0_LLE					= BIT(9),
 };
 
-static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
+static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma_chip *chip)
 {
-	return dw->rg_region.vaddr;
+	return chip->reg_base;
 }
 
-#define SET_32(dw, name, value)				\
-	writel(value, &(__dw_regs(dw)->name))
+#define SET_32(chip, name, value)				\
+	writel(value, &(__dw_regs(chip)->name))
 
-#define GET_32(dw, name)				\
-	readl(&(__dw_regs(dw)->name))
+#define GET_32(chip, name)				\
+	readl(&(__dw_regs(chip)->name))
 
-#define SET_RW_32(dw, dir, name, value)			\
+#define SET_RW_32(chip, dir, name, value)			\
 	do {						\
 		if ((dir) == EDMA_DIR_WRITE)		\
-			SET_32(dw, wr_##name, value);	\
+			SET_32(chip, wr_##name, value);	\
 		else					\
-			SET_32(dw, rd_##name, value);	\
+			SET_32(chip, rd_##name, value);	\
 	} while (0)
 
-#define GET_RW_32(dw, dir, name)			\
+#define GET_RW_32(chip, dir, name)			\
 	((dir) == EDMA_DIR_WRITE			\
-	  ? GET_32(dw, wr_##name)			\
-	  : GET_32(dw, rd_##name))
+	  ? GET_32(chip, wr_##name)			\
+	  : GET_32(chip, rd_##name))
 
-#define SET_BOTH_32(dw, name, value)			\
+#define SET_BOTH_32(chip, name, value)			\
 	do {						\
-		SET_32(dw, wr_##name, value);		\
-		SET_32(dw, rd_##name, value);		\
+		SET_32(chip, wr_##name, value);		\
+		SET_32(chip, rd_##name, value);		\
 	} while (0)
 
 #ifdef CONFIG_64BIT
 
-#define SET_64(dw, name, value)				\
-	writeq(value, &(__dw_regs(dw)->name))
+#define SET_64(chip, name, value)				\
+	writeq(value, &(__dw_regs(chip)->name))
 
-#define GET_64(dw, name)				\
-	readq(&(__dw_regs(dw)->name))
+#define GET_64(chip, name)				\
+	readq(&(__dw_regs(chip)->name))
 
-#define SET_RW_64(dw, dir, name, value)			\
+#define SET_RW_64(chip, dir, name, value)			\
 	do {						\
 		if ((dir) == EDMA_DIR_WRITE)		\
-			SET_64(dw, wr_##name, value);	\
+			SET_64(chip, wr_##name, value);	\
 		else					\
-			SET_64(dw, rd_##name, value);	\
+			SET_64(chip, rd_##name, value);	\
 	} while (0)
 
-#define GET_RW_64(dw, dir, name)			\
+#define GET_RW_64(chip, dir, name)			\
 	((dir) == EDMA_DIR_WRITE			\
-	  ? GET_64(dw, wr_##name)			\
-	  : GET_64(dw, rd_##name))
+	  ? GET_64(chip, wr_##name)			\
+	  : GET_64(chip, rd_##name))
 
-#define SET_BOTH_64(dw, name, value)			\
+#define SET_BOTH_64(chip, name, value)			\
 	do {						\
-		SET_64(dw, wr_##name, value);		\
-		SET_64(dw, rd_##name, value);		\
+		SET_64(chip, wr_##name, value);		\
+		SET_64(chip, rd_##name, value);		\
 	} while (0)
 
 #endif /* CONFIG_64BIT */
 
-#define SET_COMPAT(dw, name, value)			\
-	writel(value, &(__dw_regs(dw)->type.unroll.name))
+#define SET_COMPAT(chip, name, value)			\
+	writel(value, &(__dw_regs(chip)->type.unroll.name))
 
-#define SET_RW_COMPAT(dw, dir, name, value)		\
+#define SET_RW_COMPAT(chip, dir, name, value)		\
 	do {						\
 		if ((dir) == EDMA_DIR_WRITE)		\
-			SET_COMPAT(dw, wr_##name, value); \
+			SET_COMPAT(chip, wr_##name, value); \
 		else					\
-			SET_COMPAT(dw, rd_##name, value); \
+			SET_COMPAT(chip, rd_##name, value); \
 	} while (0)
 
 static inline struct dw_edma_v0_ch_regs __iomem *
-__dw_ch_regs(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch)
+__dw_ch_regs(struct dw_edma_chip *chip, enum dw_edma_dir dir, u16 ch)
 {
-	if (dw->mf == EDMA_MF_EDMA_LEGACY)
-		return &(__dw_regs(dw)->type.legacy.ch);
+	if (chip->mf == EDMA_MF_EDMA_LEGACY)
+		return &(__dw_regs(chip)->type.legacy.ch);
 
 	if (dir == EDMA_DIR_WRITE)
-		return &__dw_regs(dw)->type.unroll.ch[ch].wr;
+		return &__dw_regs(chip)->type.unroll.ch[ch].wr;
 
-	return &__dw_regs(dw)->type.unroll.ch[ch].rd;
+	return &__dw_regs(chip)->type.unroll.ch[ch].rd;
 }
 
-static inline void writel_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
+static inline void writel_ch(struct dw_edma_chip *chip, enum dw_edma_dir dir, u16 ch,
 			     u32 value, void __iomem *addr)
 {
-	if (dw->mf == EDMA_MF_EDMA_LEGACY) {
+	struct dw_edma *dw = chip->dw;
+
+	if (chip->mf == EDMA_MF_EDMA_LEGACY) {
 		u32 viewport_sel;
 		unsigned long flags;
 
@@ -119,7 +121,7 @@ static inline void writel_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 			viewport_sel |= BIT(31);
 
 		writel(viewport_sel,
-		       &(__dw_regs(dw)->type.legacy.viewport_sel));
+		       &(__dw_regs(chip)->type.legacy.viewport_sel));
 		writel(value, addr);
 
 		raw_spin_unlock_irqrestore(&dw->lock, flags);
@@ -128,12 +130,13 @@ static inline void writel_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 	}
 }
 
-static inline u32 readl_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
+static inline u32 readl_ch(struct dw_edma_chip *chip, enum dw_edma_dir dir, u16 ch,
 			   const void __iomem *addr)
 {
+	struct dw_edma *dw = chip->dw;
 	u32 value;
 
-	if (dw->mf == EDMA_MF_EDMA_LEGACY) {
+	if (chip->mf == EDMA_MF_EDMA_LEGACY) {
 		u32 viewport_sel;
 		unsigned long flags;
 
@@ -144,7 +147,7 @@ static inline u32 readl_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 			viewport_sel |= BIT(31);
 
 		writel(viewport_sel,
-		       &(__dw_regs(dw)->type.legacy.viewport_sel));
+		       &(__dw_regs(chip)->type.legacy.viewport_sel));
 		value = readl(addr);
 
 		raw_spin_unlock_irqrestore(&dw->lock, flags);
@@ -166,10 +169,12 @@ static inline u32 readl_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 
 #ifdef CONFIG_64BIT
 
-static inline void writeq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
+static inline void writeq_ch(struct dw_edma_chip *chip, enum dw_edma_dir dir, u16 ch,
 			     u64 value, void __iomem *addr)
 {
-	if (dw->mf == EDMA_MF_EDMA_LEGACY) {
+	struct dw_edma *dw = chip->dw;
+
+	if (chip->mf == EDMA_MF_EDMA_LEGACY) {
 		u32 viewport_sel;
 		unsigned long flags;
 
@@ -180,7 +185,7 @@ static inline void writeq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 			viewport_sel |= BIT(31);
 
 		writel(viewport_sel,
-		       &(__dw_regs(dw)->type.legacy.viewport_sel));
+		       &(__dw_regs(chip)->type.legacy.viewport_sel));
 		writeq(value, addr);
 
 		raw_spin_unlock_irqrestore(&dw->lock, flags);
@@ -189,12 +194,13 @@ static inline void writeq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 	}
 }
 
-static inline u64 readq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
+static inline u64 readq_ch(struct dw_edma_chip *chip, enum dw_edma_dir dir, u16 ch,
 			   const void __iomem *addr)
 {
+	struct dw_edma *dw = chip->dw;
 	u32 value;
 
-	if (dw->mf == EDMA_MF_EDMA_LEGACY) {
+	if (chip->mf == EDMA_MF_EDMA_LEGACY) {
 		u32 viewport_sel;
 		unsigned long flags;
 
@@ -205,7 +211,7 @@ static inline u64 readq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 			viewport_sel |= BIT(31);
 
 		writel(viewport_sel,
-		       &(__dw_regs(dw)->type.legacy.viewport_sel));
+		       &(__dw_regs(chip)->type.legacy.viewport_sel));
 		value = readq(addr);
 
 		raw_spin_unlock_irqrestore(&dw->lock, flags);
@@ -228,25 +234,25 @@ static inline u64 readq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 #endif /* CONFIG_64BIT */
 
 /* eDMA management callbacks */
-void dw_edma_v0_core_off(struct dw_edma *dw)
+void dw_edma_v0_core_off(struct dw_edma_chip *chip)
 {
-	SET_BOTH_32(dw, int_mask,
+	SET_BOTH_32(chip, int_mask,
 		    EDMA_V0_DONE_INT_MASK | EDMA_V0_ABORT_INT_MASK);
-	SET_BOTH_32(dw, int_clear,
+	SET_BOTH_32(chip, int_clear,
 		    EDMA_V0_DONE_INT_MASK | EDMA_V0_ABORT_INT_MASK);
-	SET_BOTH_32(dw, engine_en, 0);
+	SET_BOTH_32(chip, engine_en, 0);
 }
 
-u16 dw_edma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
+u16 dw_edma_v0_core_ch_count(struct dw_edma_chip *chip, enum dw_edma_dir dir)
 {
 	u32 num_ch;
 
 	if (dir == EDMA_DIR_WRITE)
 		num_ch = FIELD_GET(EDMA_V0_WRITE_CH_COUNT_MASK,
-				   GET_32(dw, ctrl));
+				   GET_32(chip, ctrl));
 	else
 		num_ch = FIELD_GET(EDMA_V0_READ_CH_COUNT_MASK,
-				   GET_32(dw, ctrl));
+				   GET_32(chip, ctrl));
 
 	if (num_ch > EDMA_V0_MAX_NR_CH)
 		num_ch = EDMA_V0_MAX_NR_CH;
@@ -256,11 +262,11 @@ u16 dw_edma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
 
 enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan)
 {
-	struct dw_edma *dw = chan->chip->dw;
+	struct dw_edma_chip *chip = chan->chip;
 	u32 tmp;
 
 	tmp = FIELD_GET(EDMA_V0_CH_STATUS_MASK,
-			GET_CH_32(dw, chan->dir, chan->id, ch_control1));
+			GET_CH_32(chip, chan->dir, chan->id, ch_control1));
 
 	if (tmp == 1)
 		return DMA_IN_PROGRESS;
@@ -272,30 +278,30 @@ enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan)
 
 void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan)
 {
-	struct dw_edma *dw = chan->chip->dw;
+	struct dw_edma_chip *chip = chan->chip;
 
-	SET_RW_32(dw, chan->dir, int_clear,
+	SET_RW_32(chip, chan->dir, int_clear,
 		  FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id)));
 }
 
 void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan)
 {
-	struct dw_edma *dw = chan->chip->dw;
+	struct dw_edma_chip *chip = chan->chip;
 
-	SET_RW_32(dw, chan->dir, int_clear,
+	SET_RW_32(chip, chan->dir, int_clear,
 		  FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id)));
 }
 
-u32 dw_edma_v0_core_status_done_int(struct dw_edma *dw, enum dw_edma_dir dir)
+u32 dw_edma_v0_core_status_done_int(struct dw_edma_chip *chip, enum dw_edma_dir dir)
 {
 	return FIELD_GET(EDMA_V0_DONE_INT_MASK,
-			 GET_RW_32(dw, dir, int_status));
+			 GET_RW_32(chip, dir, int_status));
 }
 
-u32 dw_edma_v0_core_status_abort_int(struct dw_edma *dw, enum dw_edma_dir dir)
+u32 dw_edma_v0_core_status_abort_int(struct dw_edma_chip *chip, enum dw_edma_dir dir)
 {
 	return FIELD_GET(EDMA_V0_ABORT_INT_MASK,
-			 GET_RW_32(dw, dir, int_status));
+			 GET_RW_32(chip, dir, int_status));
 }
 
 static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
@@ -357,109 +363,109 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
-	struct dw_edma *dw = chan->chip->dw;
+	struct dw_edma_chip *chip = chan->chip;
 	u32 tmp;
 
 	dw_edma_v0_core_write_chunk(chunk);
 
 	if (first) {
 		/* Enable engine */
-		SET_RW_32(dw, chan->dir, engine_en, BIT(0));
-		if (dw->mf == EDMA_MF_HDMA_COMPAT) {
+		SET_RW_32(chip, chan->dir, engine_en, BIT(0));
+		if (chip->mf == EDMA_MF_HDMA_COMPAT) {
 			switch (chan->id) {
 			case 0:
-				SET_RW_COMPAT(dw, chan->dir, ch0_pwr_en,
+				SET_RW_COMPAT(chip, chan->dir, ch0_pwr_en,
 					      BIT(0));
 				break;
 			case 1:
-				SET_RW_COMPAT(dw, chan->dir, ch1_pwr_en,
+				SET_RW_COMPAT(chip, chan->dir, ch1_pwr_en,
 					      BIT(0));
 				break;
 			case 2:
-				SET_RW_COMPAT(dw, chan->dir, ch2_pwr_en,
+				SET_RW_COMPAT(chip, chan->dir, ch2_pwr_en,
 					      BIT(0));
 				break;
 			case 3:
-				SET_RW_COMPAT(dw, chan->dir, ch3_pwr_en,
+				SET_RW_COMPAT(chip, chan->dir, ch3_pwr_en,
 					      BIT(0));
 				break;
 			case 4:
-				SET_RW_COMPAT(dw, chan->dir, ch4_pwr_en,
+				SET_RW_COMPAT(chip, chan->dir, ch4_pwr_en,
 					      BIT(0));
 				break;
 			case 5:
-				SET_RW_COMPAT(dw, chan->dir, ch5_pwr_en,
+				SET_RW_COMPAT(chip, chan->dir, ch5_pwr_en,
 					      BIT(0));
 				break;
 			case 6:
-				SET_RW_COMPAT(dw, chan->dir, ch6_pwr_en,
+				SET_RW_COMPAT(chip, chan->dir, ch6_pwr_en,
 					      BIT(0));
 				break;
 			case 7:
-				SET_RW_COMPAT(dw, chan->dir, ch7_pwr_en,
+				SET_RW_COMPAT(chip, chan->dir, ch7_pwr_en,
 					      BIT(0));
 				break;
 			}
 		}
 		/* Interrupt unmask - done, abort */
-		tmp = GET_RW_32(dw, chan->dir, int_mask);
+		tmp = GET_RW_32(chip, chan->dir, int_mask);
 		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
 		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
-		SET_RW_32(dw, chan->dir, int_mask, tmp);
+		SET_RW_32(chip, chan->dir, int_mask, tmp);
 		/* Linked list error */
-		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
+		tmp = GET_RW_32(chip, chan->dir, linked_list_err_en);
 		tmp |= FIELD_PREP(EDMA_V0_LINKED_LIST_ERR_MASK, BIT(chan->id));
-		SET_RW_32(dw, chan->dir, linked_list_err_en, tmp);
+		SET_RW_32(chip, chan->dir, linked_list_err_en, tmp);
 		/* Channel control */
-		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
+		SET_CH_32(chip, chan->dir, chan->id, ch_control1,
 			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
 		/* Linked list */
 		#ifdef CONFIG_64BIT
-			SET_CH_64(dw, chan->dir, chan->id, llp.reg,
+			SET_CH_64(chip, chan->dir, chan->id, llp.reg,
 				  chunk->ll_region.paddr);
 		#else /* CONFIG_64BIT */
-			SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
+			SET_CH_32(chip, chan->dir, chan->id, llp.lsb,
 				  lower_32_bits(chunk->ll_region.paddr));
-			SET_CH_32(dw, chan->dir, chan->id, llp.msb,
+			SET_CH_32(chip, chan->dir, chan->id, llp.msb,
 				  upper_32_bits(chunk->ll_region.paddr));
 		#endif /* CONFIG_64BIT */
 	}
 	/* Doorbell */
-	SET_RW_32(dw, chan->dir, doorbell,
+	SET_RW_32(chip, chan->dir, doorbell,
 		  FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
 }
 
 int dw_edma_v0_core_device_config(struct dw_edma_chan *chan)
 {
-	struct dw_edma *dw = chan->chip->dw;
+	struct dw_edma_chip *chip = chan->chip;
 	u32 tmp = 0;
 
 	/* MSI done addr - low, high */
-	SET_RW_32(dw, chan->dir, done_imwr.lsb, chan->msi.address_lo);
-	SET_RW_32(dw, chan->dir, done_imwr.msb, chan->msi.address_hi);
+	SET_RW_32(chip, chan->dir, done_imwr.lsb, chan->msi.address_lo);
+	SET_RW_32(chip, chan->dir, done_imwr.msb, chan->msi.address_hi);
 	/* MSI abort addr - low, high */
-	SET_RW_32(dw, chan->dir, abort_imwr.lsb, chan->msi.address_lo);
-	SET_RW_32(dw, chan->dir, abort_imwr.msb, chan->msi.address_hi);
+	SET_RW_32(chip, chan->dir, abort_imwr.lsb, chan->msi.address_lo);
+	SET_RW_32(chip, chan->dir, abort_imwr.msb, chan->msi.address_hi);
 	/* MSI data - low, high */
 	switch (chan->id) {
 	case 0:
 	case 1:
-		tmp = GET_RW_32(dw, chan->dir, ch01_imwr_data);
+		tmp = GET_RW_32(chip, chan->dir, ch01_imwr_data);
 		break;
 
 	case 2:
 	case 3:
-		tmp = GET_RW_32(dw, chan->dir, ch23_imwr_data);
+		tmp = GET_RW_32(chip, chan->dir, ch23_imwr_data);
 		break;
 
 	case 4:
 	case 5:
-		tmp = GET_RW_32(dw, chan->dir, ch45_imwr_data);
+		tmp = GET_RW_32(chip, chan->dir, ch45_imwr_data);
 		break;
 
 	case 6:
 	case 7:
-		tmp = GET_RW_32(dw, chan->dir, ch67_imwr_data);
+		tmp = GET_RW_32(chip, chan->dir, ch67_imwr_data);
 		break;
 	}
 
@@ -478,22 +484,22 @@ int dw_edma_v0_core_device_config(struct dw_edma_chan *chan)
 	switch (chan->id) {
 	case 0:
 	case 1:
-		SET_RW_32(dw, chan->dir, ch01_imwr_data, tmp);
+		SET_RW_32(chip, chan->dir, ch01_imwr_data, tmp);
 		break;
 
 	case 2:
 	case 3:
-		SET_RW_32(dw, chan->dir, ch23_imwr_data, tmp);
+		SET_RW_32(chip, chan->dir, ch23_imwr_data, tmp);
 		break;
 
 	case 4:
 	case 5:
-		SET_RW_32(dw, chan->dir, ch45_imwr_data, tmp);
+		SET_RW_32(chip, chan->dir, ch45_imwr_data, tmp);
 		break;
 
 	case 6:
 	case 7:
-		SET_RW_32(dw, chan->dir, ch67_imwr_data, tmp);
+		SET_RW_32(chip, chan->dir, ch67_imwr_data, tmp);
 		break;
 	}
 
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.h b/drivers/dma/dw-edma/dw-edma-v0-core.h
index 2afa626b8300c..01a29c74c0c43 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.h
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.h
@@ -12,13 +12,13 @@
 #include <linux/dma/edma.h>
 
 /* eDMA management callbacks */
-void dw_edma_v0_core_off(struct dw_edma *chan);
-u16 dw_edma_v0_core_ch_count(struct dw_edma *chan, enum dw_edma_dir dir);
+void dw_edma_v0_core_off(struct dw_edma_chip *chip);
+u16 dw_edma_v0_core_ch_count(struct dw_edma_chip *chip, enum dw_edma_dir dir);
 enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan);
 void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan);
 void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan);
-u32 dw_edma_v0_core_status_done_int(struct dw_edma *chan, enum dw_edma_dir dir);
-u32 dw_edma_v0_core_status_abort_int(struct dw_edma *chan, enum dw_edma_dir dir);
+u32 dw_edma_v0_core_status_done_int(struct dw_edma_chip *chip, enum dw_edma_dir dir);
+u32 dw_edma_v0_core_status_abort_int(struct dw_edma_chip *chip, enum dw_edma_dir dir);
 void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first);
 int dw_edma_v0_core_device_config(struct dw_edma_chan *chan);
 /* eDMA debug fs callbacks */
diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
index 4b3bcffd15ef1..5819a64aceb0f 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
@@ -38,7 +38,7 @@
 #define CHANNEL_STR				"channel"
 #define REGISTERS_STR				"registers"
 
-static struct dw_edma				*dw;
+static struct dw_edma_chip			*chip;
 static struct dw_edma_v0_regs			__iomem *regs;
 
 static struct {
@@ -53,8 +53,10 @@ struct debugfs_entries {
 
 static int dw_edma_debugfs_u32_get(void *data, u64 *val)
 {
+	struct dw_edma *dw = chip->dw;
+
 	void __iomem *reg = (void __force __iomem *)data;
-	if (dw->mf == EDMA_MF_EDMA_LEGACY &&
+	if (chip->mf == EDMA_MF_EDMA_LEGACY &&
 	    reg >= (void __iomem *)&regs->type.legacy.ch) {
 		void __iomem *ptr = &regs->type.legacy.ch;
 		u32 viewport_sel = 0;
@@ -127,6 +129,8 @@ static void dw_edma_debugfs_regs_ch(struct dw_edma_v0_ch_regs __iomem *regs,
 
 static void dw_edma_debugfs_regs_wr(struct dentry *dir)
 {
+	struct dw_edma *dw = chip->dw;
+
 	const struct debugfs_entries debugfs_regs[] = {
 		/* eDMA global registers */
 		WR_REGISTER(engine_en),
@@ -173,7 +177,7 @@ static void dw_edma_debugfs_regs_wr(struct dentry *dir)
 	nr_entries = ARRAY_SIZE(debugfs_regs);
 	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dir);
 
-	if (dw->mf == EDMA_MF_HDMA_COMPAT) {
+	if (chip->mf == EDMA_MF_HDMA_COMPAT) {
 		nr_entries = ARRAY_SIZE(debugfs_unroll_regs);
 		dw_edma_debugfs_create_x32(debugfs_unroll_regs, nr_entries,
 					   regs_dir);
@@ -195,6 +199,8 @@ static void dw_edma_debugfs_regs_wr(struct dentry *dir)
 
 static void dw_edma_debugfs_regs_rd(struct dentry *dir)
 {
+	struct dw_edma *dw = chip->dw;
+
 	const struct debugfs_entries debugfs_regs[] = {
 		/* eDMA global registers */
 		RD_REGISTER(engine_en),
@@ -242,7 +248,7 @@ static void dw_edma_debugfs_regs_rd(struct dentry *dir)
 	nr_entries = ARRAY_SIZE(debugfs_regs);
 	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dir);
 
-	if (dw->mf == EDMA_MF_HDMA_COMPAT) {
+	if (chip->mf == EDMA_MF_HDMA_COMPAT) {
 		nr_entries = ARRAY_SIZE(debugfs_unroll_regs);
 		dw_edma_debugfs_create_x32(debugfs_unroll_regs, nr_entries,
 					   regs_dir);
@@ -264,6 +270,7 @@ static void dw_edma_debugfs_regs_rd(struct dentry *dir)
 
 static void dw_edma_debugfs_regs(void)
 {
+	struct dw_edma *dw = chip->dw;
 	const struct debugfs_entries debugfs_regs[] = {
 		REGISTER(ctrl_data_arb_prior),
 		REGISTER(ctrl),
@@ -282,13 +289,15 @@ static void dw_edma_debugfs_regs(void)
 	dw_edma_debugfs_regs_rd(regs_dir);
 }
 
-void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
+void dw_edma_v0_debugfs_on(struct dw_edma_chip *p)
 {
-	dw = chip->dw;
-	if (!dw)
+	struct dw_edma *dw;
+	chip = p;
+	if (!chip)
 		return;
 
-	regs = dw->rg_region.vaddr;
+	dw = chip->dw;
+	regs = chip->reg_base;
 	if (!regs)
 		return;
 
@@ -296,19 +305,19 @@ void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
 	if (!dw->debugfs)
 		return;
 
-	debugfs_create_u32("mf", 0444, dw->debugfs, &dw->mf);
+	debugfs_create_u32("mf", 0444, dw->debugfs, &chip->mf);
 	debugfs_create_u16("wr_ch_cnt", 0444, dw->debugfs, &dw->wr_ch_cnt);
 	debugfs_create_u16("rd_ch_cnt", 0444, dw->debugfs, &dw->rd_ch_cnt);
 
 	dw_edma_debugfs_regs();
 }
 
-void dw_edma_v0_debugfs_off(struct dw_edma_chip *chip)
+void dw_edma_v0_debugfs_off(struct dw_edma_chip *p)
 {
-	dw = chip->dw;
-	if (!dw)
+	chip = p;
+	if (!chip)
 		return;
 
-	debugfs_remove_recursive(dw->debugfs);
-	dw->debugfs = NULL;
+	debugfs_remove_recursive(chip->dw->debugfs);
+	chip->dw->debugfs = NULL;
 }
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index cab6e18773dad..fcfbc0f47f83d 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -12,19 +12,62 @@
 #include <linux/device.h>
 #include <linux/dmaengine.h>
 
+#define EDMA_MAX_WR_CH                                  8
+#define EDMA_MAX_RD_CH                                  8
+
 struct dw_edma;
 
+struct dw_edma_region {
+	phys_addr_t	paddr;
+	void __iomem	*vaddr;
+	size_t		sz;
+};
+
+struct dw_edma_core_ops {
+	int (*irq_vector)(struct device *dev, unsigned int nr);
+};
+
+enum dw_edma_map_format {
+	EDMA_MF_EDMA_LEGACY = 0x0,
+	EDMA_MF_EDMA_UNROLL = 0x1,
+	EDMA_MF_HDMA_COMPAT = 0x5
+};
+
 /**
  * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
  * @dev:		 struct device of the eDMA controller
  * @id:			 instance ID
- * @irq:		 irq line
+ * @nr_irqs:		 total dma irq number
+ * reg64bit		 if support 64bit write to register
+ * @ops			 DMA channel to IRQ number mapping
+ * @wr_ch_cnt		 DMA write channel number
+ * @rd_ch_cnt		 DMA read channel number
+ * @rg_region		 DMA register region
+ * @ll_region_wr	 DMA descriptor link list memory for write channel
+ * @ll_region_rd	 DMA descriptor link list memory for read channel
+ * @mf			 DMA register map format
  * @dw:			 struct dw_edma that is filed by dw_edma_probe()
  */
 struct dw_edma_chip {
 	struct device		*dev;
 	int			id;
-	int			irq;
+	int			nr_irqs;
+	const struct dw_edma_core_ops   *ops;
+
+	void __iomem		*reg_base;
+
+	u16			ll_wr_cnt;
+	u16			ll_rd_cnt;
+	/* link list address */
+	struct dw_edma_region	ll_region_wr[EDMA_MAX_WR_CH];
+	struct dw_edma_region	ll_region_rd[EDMA_MAX_RD_CH];
+
+	/* data region */
+	struct dw_edma_region	dt_region_wr[EDMA_MAX_WR_CH];
+	struct dw_edma_region	dt_region_rd[EDMA_MAX_RD_CH];
+
+	enum dw_edma_map_format	mf;
+
 	struct dw_edma		*dw;
 };
 
-- 
2.24.0.rc1

