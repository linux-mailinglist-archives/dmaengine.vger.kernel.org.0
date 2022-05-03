Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F42517B6D
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 03:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiECBJv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 May 2022 21:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiECBJu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 May 2022 21:09:50 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60088.outbound.protection.outlook.com [40.107.6.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3847E6A413;
        Mon,  2 May 2022 18:06:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4KvqTpngH+oU+MCI5BErljBjeqSdMizs4gxYn+CegWE7pbt4Dnfik/MrjzlYQ6XhwCzkeEbpfScbOPsPg/7YmZ0fiPzG4KtEn7Eq27P8JPp8urvetpPSD3uYkie04SlbrOdFU3xcuKw5iPUeV141LvSO1mq2ZYgj0xGcKwEHV14lNiIwq6yTABzhnsTvR1ym07YwPEhgcxJQqoxBfTCUqkk5EsXRUy43gOGDX4mlOi0zv8IoIhKJS8K+tRGmcaS5QmY5l0QdAfSHZY7bbTutwrcTb0aXfO+5gd/p4YaiSW+I4dNea1rcLPbSCD2T54cvq1v8pRNbsIf4lXdPJVf3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rqvTkRS1giIz1JrV6Uf834SqvkWapc9CSu8hq6fk3U=;
 b=VS7XrNmnJRlS5l5KAPkKz7fIUlZFPwT4TMMV2iT4K7aORPxaqEkZIuB/r7XBjLfFKaLNqKLDcGlV5hPgcCD1Cuk7cslU27SHnSDuaps4TJGMlVJwZ1Lpl+OVpJyYCtTVa0diSjrUYab5ZeWfkPZLyoB5Q5InjX1w/89vTc44PjlDiOFiLUzLN/22EczsWE1Pwv9/yu7i89V0ovNDgk7foNPvRTpd4e6E2fXrSl5RYHCvqLRZUq2kX7jQkLJ3D3TURF/MYui7dmpV4j2G1KlFIleTFUdVhwVw2ihRSkdeHury7/BR2uh+yRwrY5pIcG3/zlX0qDwCgLQrFQhS8QV2JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rqvTkRS1giIz1JrV6Uf834SqvkWapc9CSu8hq6fk3U=;
 b=V9MVnAlc6b0sCVN7IUegFLvvqNTyO64xgCY0A64epXRSVL19wR7ZfbP1o7Q0ON6ePjJx605DysveIxWl38sL6wuyXg1a1WnWcKfQcCg9j4QimrCBeGYdwS8T/I/VLZwuBG88wIQ380QEmHBmU61MICekov4gc836SAGsqIQ13e4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM8PR04MB7364.eurprd04.prod.outlook.com (2603:10a6:20b:1db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 00:58:29 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a%7]) with mapi id 15.20.5186.021; Tue, 3 May 2022
 00:58:29 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v10 2/9] dmaengine: dw-edma: Detach the private data and chip info structures
Date:   Mon,  2 May 2022 19:57:54 -0500
Message-Id: <20220503005801.1714345-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503005801.1714345-1-Frank.Li@nxp.com>
References: <20220503005801.1714345-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::32) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9397a181-a7ef-46d1-702d-08da2ca00946
X-MS-TrafficTypeDiagnostic: AM8PR04MB7364:EE_
X-Microsoft-Antispam-PRVS: <AM8PR04MB73647D67E029B88C3E56E1F388C09@AM8PR04MB7364.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mgR8TcUQeWESoj3QfIIwVTwbRLrHCi9sq9GTHU9YwkBdHh0HYWNN7ihiCWbFvAmcax4IQGcUpZ+yJasNO/jCo3w5gf+w7LpzWVuJZXgQvo4gzlJxYLntt0myVz1v6Tv2ho3FswSwoT8Vl0IzUFFxzKsQRJs5WXjXmYLkguhPgVD8hdI/KxxTxkCGSX3HkmZ7OukW8T+jbn/7fzv/aqXYYofApcUYQxYFFBnxneG40wIDYwq63lE6rB4Klb7Pg5cz1whh+u8etPvS5qoUTTwLfeZmpGDGgVvgg7XFOHDojEYR5J+QYhlMpFsBvqGd8ClBxA5PR4kMo9QLvdfISI6i29hAvKpen8skf3Frc8cqkCC1rpdO0HIzPC1wh0uTk/4lKp9bNYjL7aTMuSYDj3C3rVi/uoq+ZcLVGAd7LRGlVEGAhLnDgz7Z6TGAb2yeA5QI7Pzds5raAV/REtQZ1mbAdIxpOYGhZtxjOzovIsDE+36JHRWuqZeF90fuJDUhkj7wcQ0Fo36Pcl4gscSXWfbVZRyyuh+eHnTxSYIm7RbT319f/mU1BAugxjzFC8yN4C8vcL7qf0zbhuGfyFufQbEaqx+bTzg9YAlo5UBSbax1N+N+dNVQ7RziMhQ7yL6+H4PXJzDg1Pu1Wy8hUGalOO+DFA3plpsP3p12KHSxG0h3nUxv8//A1L3tqd3suVcv3P1VCmKmqF48Tqpb4wr99Lq6uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(66556008)(66946007)(4326008)(2906002)(36756003)(66476007)(6512007)(6666004)(316002)(6506007)(26005)(83380400001)(1076003)(86362001)(186003)(38100700002)(7416002)(8936002)(38350700002)(508600001)(5660300002)(2616005)(52116002)(30864003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pvyYvZPAsVbtwUROwQjs1ji1fAEbjlpf2s2qu6aBeIOSy9U68m8z9T+gHcXG?=
 =?us-ascii?Q?wgZ+oyKPamzIId5CEf+heVQGDX3vk0Pz3B99kk2OppI1rF+JUIHbX1WS8pOp?=
 =?us-ascii?Q?TdTctER0cXia+gPG2LldR7z41cRJSATqpqY3jtXy39+Q3ZSJpOVSlHpAwKiI?=
 =?us-ascii?Q?YLyrCUwierZFDTo4tfydCl8kGjhtI8K+Lo3ucQkGDkjv/IsSOczVT5zJmZHX?=
 =?us-ascii?Q?bSKGjLehQ7jFR2ZSE0ohq6ZD5jW0LSb+8KuFtn5pedd/l9OS+dUR4Rbdr93s?=
 =?us-ascii?Q?4IKtVlHKZydPGDNCseuNwyuF9GaDAtRpechOz0NkAo2FyNF7IMbP4RR6Eevr?=
 =?us-ascii?Q?E+IApb9Rj3UqbDlXZDLCqzjJ2pj0A1d3BnfLY2G86891tThean3r7CyLfTWg?=
 =?us-ascii?Q?lj6b2ClRdvDNaXaEJyymHNkh7LYclASUbeKi5iCvqqo4KXWS4/yLhEKVSdta?=
 =?us-ascii?Q?2P6HiYO8XiPCWG3ukKBjHCFZmeILROM13I8aKZrnNcymFRFkpAttoHxUV7ql?=
 =?us-ascii?Q?GFELwMxtYCkUpFD2AX4yd3eOsAvP0/tKd3psBjA1/oGbCCrkBSL6WcEuwz8o?=
 =?us-ascii?Q?Xlb6psaITkvBzEkO0waUqBIeclO0jh39G78U8CDAys26mazddK1+gJ8mRFuq?=
 =?us-ascii?Q?P33W48mbi8Kp2ZHGwGK6eJ2RCFtul99CqmVlNRr4RfS191Ge4IlqJ4emN2fv?=
 =?us-ascii?Q?zLv04eiFoz5puK9gMvXc6TX/OhqxK3uoU0qXzetrF+ggTnLXIkelzty6Fx6X?=
 =?us-ascii?Q?ZrNKFljwuMSQI/XVfVGbqpowaZJrStQO90yBjf/iOtjNPTP+dxPHsLPIC/s6?=
 =?us-ascii?Q?5Wc2EknsWAwiwvlzJaeqnki7acqOad4C+lViWfK1ZokoRk8PgKfgijqG2LvW?=
 =?us-ascii?Q?xPzawTIAe7CmvpHiHZfvos0jnoXbCZQxjiyAUGR44VDYBnq3y/aDdsx9n4u+?=
 =?us-ascii?Q?pJ4PqJ3Yz6Icl6ZWNHvpn7h56ZDMFtQ1W5+rKiHf+iy+wIp0ol3aTj/DI30o?=
 =?us-ascii?Q?dL/4T8fIvIaTT51TMuodLcTs3IORpda7JlAAGGiAyMBOP+51QVX8N3Hivwws?=
 =?us-ascii?Q?ZBPclVDJ3UK0GEdn8vj5g0gDFjMWz63OfrJUxzSluzfLloMGlJ1pWw4S3Z/p?=
 =?us-ascii?Q?yoG+l2PorgLD82waiMvI7z03oZTXSC+MncVFweX/lx0T03xp1mk9ZWP0Tf+N?=
 =?us-ascii?Q?EluNbyU7Pl3OwZdmFYZM1ksrXJhvGj6fNHFamL8MUVGdBl+p1vPxXy6HSt3F?=
 =?us-ascii?Q?zX7Mf7USswJAFeaSZZlFa7ICaWK45nA8Orsy95Z6UYUX6PeqA/M0eE37TvJe?=
 =?us-ascii?Q?JdhVIbBAA2CYYv/zsnHaRX8IbrwkDbBDFxxoslqv2IPYJxB8BzxJYv5DxFsC?=
 =?us-ascii?Q?eoN9sFG1IYCWOw2uzzVJyqsVtdc2wnQiTW6Ds4WD82LP3nJkPZWLiSPWnBC7?=
 =?us-ascii?Q?0hZu9rJvMdkAmZtvTyChDLu+o8nSJyjSSPXFEsFIXo3GjAWJq7cYT0rFaJIO?=
 =?us-ascii?Q?UCTZtQ+E74hSUscnqCk5LTHZczPHddVZwMYzWQYuBaua0RsWAO+q1r4Y/rhC?=
 =?us-ascii?Q?KrQCFvFZXOdgjZW4YbOwgm7JGsjDeEVxN+ZQWoGSOWjy3VIQAcbRRXSbCOYK?=
 =?us-ascii?Q?djkFw3DMnhOlwHi6ZRHGoD2PyucNNzvpNde5OiQ8Lc0R7GbxFoIpSb2qY+NA?=
 =?us-ascii?Q?7DKWympmeBUiDVwpS2hnQ72HB3+tCtBQly/v4sN0CdLhRXkQiNftE6YwBmSN?=
 =?us-ascii?Q?4ukjmGwkXw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9397a181-a7ef-46d1-702d-08da2ca00946
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 00:58:29.1471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UiWSpnVufh9xrUuKeBv2ZjR6Q31FMnDO8qDYIPFW60wBBZnmc2j7gxhPCGWyOMwbH0TZQkqmLk6URMvfVFfBew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7364
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

"struct dw_edma_chip" contains an internal structure "struct dw_edma" that
is used by the eDMA core internally. This structure should not be touched
by the eDMA controller drivers themselves. But currently, the eDMA
controller drivers like "dw-edma-pci" allocates and populates this
internal structure then passes it on to eDMA core. The eDMA core further
populates the structure and uses it. This is wrong!

Hence, move all the "struct dw_edma" specifics from controller drivers
to the eDMA core.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
---

Change from v9 to v10
 - add doc for dt_region_wr/dt_region_rd

Change from v8 to v9
 - remove chip->ops check at dw_edma_irq_request()

Change from v7 to v8
 - Check chip->ops at probe()
 - use struct edma_dw at dw_edma_v0_debugfs_on/off()

Change from v6 to v7
 - Move nr_irqs and chip->ops check into dw_edma_irq_request()
 - Move dw->irq devm_kcalloc() into dw_edma_irq_request()
 - Change dw->nr_irqs after request success
 - Fix wrong use chip->nr_irqs when remove

Change from v5 to v6
 - Don't touch chip->nr_irqs
 - Don't set chip->dw utill everything is okay
 - dw_edma_channel_setup() and dw_edma_v0_core_debugfs_on/off() methods take
   dw_edma structure pointer as a parameter

Change from v4 to v5
 - Move chip->nr_irqs before allocate dw_edma
Change from v3 to v4
 - Accept most suggestions of Serge Semin
Change from v2 to v3
 - none
Change from v1 to v2
 - rework commit message
 - remove duplicate field in struct dw_edma

 drivers/dma/dw-edma/dw-edma-core.c       | 90 +++++++++++++-----------
 drivers/dma/dw-edma/dw-edma-core.h       | 31 +-------
 drivers/dma/dw-edma/dw-edma-pcie.c       | 82 +++++++++------------
 drivers/dma/dw-edma/dw-edma-v0-core.c    | 32 ++++-----
 drivers/dma/dw-edma/dw-edma-v0-core.h    |  4 +-
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 18 ++---
 drivers/dma/dw-edma/dw-edma-v0-debugfs.h |  8 +--
 include/linux/dma/edma.h                 | 46 ++++++++++++
 8 files changed, 163 insertions(+), 148 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 53289927dd0d6..58e91fe384282 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -64,8 +64,8 @@ static struct dw_edma_burst *dw_edma_alloc_burst(struct dw_edma_chunk *chunk)
 
 static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
 {
+	struct dw_edma_chip *chip = desc->chan->dw->chip;
 	struct dw_edma_chan *chan = desc->chan;
-	struct dw_edma *dw = chan->chip->dw;
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
@@ -664,7 +664,7 @@ static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
 	if (chan->status != EDMA_ST_IDLE)
 		return -EBUSY;
 
-	pm_runtime_get(chan->chip->dev);
+	pm_runtime_get(chan->dw->chip->dev);
 
 	return 0;
 }
@@ -686,15 +686,15 @@ static void dw_edma_free_chan_resources(struct dma_chan *dchan)
 		cpu_relax();
 	}
 
-	pm_runtime_put(chan->chip->dev);
+	pm_runtime_put(chan->dw->chip->dev);
 }
 
-static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
+static int dw_edma_channel_setup(struct dw_edma *dw, bool write,
 				 u32 wr_alloc, u32 rd_alloc)
 {
+	struct dw_edma_chip *chip = dw->chip;
 	struct dw_edma_region *dt_region;
 	struct device *dev = chip->dev;
-	struct dw_edma *dw = chip->dw;
 	struct dw_edma_chan *chan;
 	struct dw_edma_irq *irq;
 	struct dma_device *dma;
@@ -727,7 +727,7 @@ static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
 
 		chan->vc.chan.private = dt_region;
 
-		chan->chip = chip;
+		chan->dw = dw;
 		chan->id = j;
 		chan->dir = write ? EDMA_DIR_WRITE : EDMA_DIR_READ;
 		chan->configured = false;
@@ -735,9 +735,9 @@ static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
 		chan->status = EDMA_ST_IDLE;
 
 		if (write)
-			chan->ll_max = (dw->ll_region_wr[j].sz / EDMA_LL_SZ);
+			chan->ll_max = (chip->ll_region_wr[j].sz / EDMA_LL_SZ);
 		else
-			chan->ll_max = (dw->ll_region_rd[j].sz / EDMA_LL_SZ);
+			chan->ll_max = (chip->ll_region_rd[j].sz / EDMA_LL_SZ);
 		chan->ll_max -= 1;
 
 		dev_vdbg(dev, "L. List:\tChannel %s[%u] max_cnt=%u\n",
@@ -767,13 +767,13 @@ static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
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
@@ -827,11 +827,11 @@ static inline void dw_edma_add_irq_mask(u32 *mask, u32 alloc, u16 cnt)
 		(*mask)++;
 }
 
-static int dw_edma_irq_request(struct dw_edma_chip *chip,
+static int dw_edma_irq_request(struct dw_edma *dw,
 			       u32 *wr_alloc, u32 *rd_alloc)
 {
-	struct device *dev = chip->dev;
-	struct dw_edma *dw = chip->dw;
+	struct dw_edma_chip *chip = dw->chip;
+	struct device *dev = dw->chip->dev;
 	u32 wr_mask = 1;
 	u32 rd_mask = 1;
 	int i, err = 0;
@@ -840,12 +840,16 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
 
 	ch_cnt = dw->wr_ch_cnt + dw->rd_ch_cnt;
 
-	if (dw->nr_irqs < 1)
+	if (chip->nr_irqs < 1 || !chip->ops->irq_vector)
 		return -EINVAL;
 
-	if (dw->nr_irqs == 1) {
+	dw->irq = devm_kcalloc(dev, chip->nr_irqs, sizeof(*dw->irq), GFP_KERNEL);
+	if (!dw->irq)
+		return -ENOMEM;
+
+	if (chip->nr_irqs == 1) {
 		/* Common IRQ shared among all channels */
-		irq = dw->ops->irq_vector(dev, 0);
+		irq = chip->ops->irq_vector(dev, 0);
 		err = request_irq(irq, dw_edma_interrupt_common,
 				  IRQF_SHARED, dw->name, &dw->irq[0]);
 		if (err) {
@@ -855,9 +859,11 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
 
 		if (irq_get_msi_desc(irq))
 			get_cached_msi_msg(irq, &dw->irq[0].msi);
+
+		dw->nr_irqs = 1;
 	} else {
 		/* Distribute IRQs equally among all channels */
-		int tmp = dw->nr_irqs;
+		int tmp = chip->nr_irqs;
 
 		while (tmp && (*wr_alloc + *rd_alloc) < ch_cnt) {
 			dw_edma_dec_irq_alloc(&tmp, wr_alloc, dw->wr_ch_cnt);
@@ -868,7 +874,7 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
 		dw_edma_add_irq_mask(&rd_mask, *rd_alloc, dw->rd_ch_cnt);
 
 		for (i = 0; i < (*wr_alloc + *rd_alloc); i++) {
-			irq = dw->ops->irq_vector(dev, i);
+			irq = chip->ops->irq_vector(dev, i);
 			err = request_irq(irq,
 					  i < *wr_alloc ?
 						dw_edma_interrupt_write :
@@ -902,20 +908,22 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 		return -EINVAL;
 
 	dev = chip->dev;
-	if (!dev)
+	if (!dev || !chip->ops)
 		return -EINVAL;
 
-	dw = chip->dw;
-	if (!dw || !dw->irq || !dw->ops || !dw->ops->irq_vector)
-		return -EINVAL;
+	dw = devm_kzalloc(dev, sizeof(*dw), GFP_KERNEL);
+	if (!dw)
+		return -ENOMEM;
+
+	dw->chip = chip;
 
 	raw_spin_lock_init(&dw->lock);
 
-	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt,
+	dw->wr_ch_cnt = min_t(u16, chip->wr_ch_cnt,
 			      dw_edma_v0_core_ch_count(dw, EDMA_DIR_WRITE));
 	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
 
-	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt,
+	dw->rd_ch_cnt = min_t(u16, chip->rd_ch_cnt,
 			      dw_edma_v0_core_ch_count(dw, EDMA_DIR_READ));
 	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
 
@@ -937,17 +945,17 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 	dw_edma_v0_core_off(dw);
 
 	/* Request IRQs */
-	err = dw_edma_irq_request(chip, &wr_alloc, &rd_alloc);
+	err = dw_edma_irq_request(dw, &wr_alloc, &rd_alloc);
 	if (err)
 		return err;
 
 	/* Setup write channels */
-	err = dw_edma_channel_setup(chip, true, wr_alloc, rd_alloc);
+	err = dw_edma_channel_setup(dw, true, wr_alloc, rd_alloc);
 	if (err)
 		goto err_irq_free;
 
 	/* Setup read channels */
-	err = dw_edma_channel_setup(chip, false, wr_alloc, rd_alloc);
+	err = dw_edma_channel_setup(dw, false, wr_alloc, rd_alloc);
 	if (err)
 		goto err_irq_free;
 
@@ -955,15 +963,15 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 	pm_runtime_enable(dev);
 
 	/* Turn debugfs on */
-	dw_edma_v0_core_debugfs_on(chip);
+	dw_edma_v0_core_debugfs_on(dw);
+
+	chip->dw = dw;
 
 	return 0;
 
 err_irq_free:
 	for (i = (dw->nr_irqs - 1); i >= 0; i--)
-		free_irq(dw->ops->irq_vector(dev, i), &dw->irq[i]);
-
-	dw->nr_irqs = 0;
+		free_irq(chip->ops->irq_vector(dev, i), &dw->irq[i]);
 
 	return err;
 }
@@ -981,7 +989,7 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 
 	/* Free irqs */
 	for (i = (dw->nr_irqs - 1); i >= 0; i--)
-		free_irq(dw->ops->irq_vector(dev, i), &dw->irq[i]);
+		free_irq(chip->ops->irq_vector(dev, i), &dw->irq[i]);
 
 	/* Power management */
 	pm_runtime_disable(dev);
@@ -1002,7 +1010,7 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 	}
 
 	/* Turn debugfs off */
-	dw_edma_v0_core_debugfs_off(chip);
+	dw_edma_v0_core_debugfs_off(dw);
 
 	return 0;
 }
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 60316d408c3e0..85df2d511907b 100644
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
@@ -87,7 +73,7 @@ struct dw_edma_desc {
 
 struct dw_edma_chan {
 	struct virt_dma_chan		vc;
-	struct dw_edma_chip		*chip;
+	struct dw_edma			*dw;
 	int				id;
 	enum dw_edma_dir		dir;
 
@@ -109,10 +95,6 @@ struct dw_edma_irq {
 	struct dw_edma			*dw;
 };
 
-struct dw_edma_core_ops {
-	int	(*irq_vector)(struct device *dev, unsigned int nr);
-};
-
 struct dw_edma {
 	char				name[20];
 
@@ -122,21 +104,14 @@ struct dw_edma {
 	struct dma_device		rd_edma;
 	u16				rd_ch_cnt;
 
-	struct dw_edma_region		rg_region;	/* Registers */
-	struct dw_edma_region		ll_region_wr[EDMA_MAX_WR_CH];
-	struct dw_edma_region		ll_region_rd[EDMA_MAX_RD_CH];
-	struct dw_edma_region		dt_region_wr[EDMA_MAX_WR_CH];
-	struct dw_edma_region		dt_region_rd[EDMA_MAX_RD_CH];
-
 	struct dw_edma_irq		*irq;
 	int				nr_irqs;
 
-	enum dw_edma_map_format		mf;
-
 	struct dw_edma_chan		*chan;
-	const struct dw_edma_core_ops	*ops;
 
 	raw_spinlock_t			lock;		/* Only for legacy */
+
+	struct dw_edma_chip             *chip;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry			*debugfs;
 #endif /* CONFIG_DEBUG_FS */
diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index b8f52ca10fa91..2c1c5fa4e9f28 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -148,7 +148,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	struct dw_edma_pcie_data vsec_data;
 	struct device *dev = &pdev->dev;
 	struct dw_edma_chip *chip;
-	struct dw_edma *dw;
 	int err, nr_irqs;
 	int i, mask;
 
@@ -214,10 +213,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	if (!chip)
 		return -ENOMEM;
 
-	dw = devm_kzalloc(dev, sizeof(*dw), GFP_KERNEL);
-	if (!dw)
-		return -ENOMEM;
-
 	/* IRQs allocation */
 	nr_irqs = pci_alloc_irq_vectors(pdev, 1, vsec_data.irqs,
 					PCI_IRQ_MSI | PCI_IRQ_MSIX);
@@ -228,28 +223,23 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	}
 
 	/* Data structure initialization */
-	chip->dw = dw;
 	chip->dev = dev;
 	chip->id = pdev->devfn;
 
-	dw->mf = vsec_data.mf;
-	dw->nr_irqs = nr_irqs;
-	dw->ops = &dw_edma_pcie_core_ops;
-	dw->wr_ch_cnt = vsec_data.wr_ch_cnt;
-	dw->rd_ch_cnt = vsec_data.rd_ch_cnt;
+	chip->mf = vsec_data.mf;
+	chip->nr_irqs = nr_irqs;
+	chip->ops = &dw_edma_pcie_core_ops;
 
-	dw->rg_region.vaddr = pcim_iomap_table(pdev)[vsec_data.rg.bar];
-	if (!dw->rg_region.vaddr)
-		return -ENOMEM;
+	chip->wr_ch_cnt = vsec_data.wr_ch_cnt;
+	chip->rd_ch_cnt = vsec_data.rd_ch_cnt;
 
-	dw->rg_region.vaddr += vsec_data.rg.off;
-	dw->rg_region.paddr = pdev->resource[vsec_data.rg.bar].start;
-	dw->rg_region.paddr += vsec_data.rg.off;
-	dw->rg_region.sz = vsec_data.rg.sz;
+	chip->rg_region.vaddr = pcim_iomap_table(pdev)[vsec_data.rg.bar];
+	if (!chip->rg_region.vaddr)
+		return -ENOMEM;
 
-	for (i = 0; i < dw->wr_ch_cnt; i++) {
-		struct dw_edma_region *ll_region = &dw->ll_region_wr[i];
-		struct dw_edma_region *dt_region = &dw->dt_region_wr[i];
+	for (i = 0; i < chip->wr_ch_cnt; i++) {
+		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
+		struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
 		struct dw_edma_block *ll_block = &vsec_data.ll_wr[i];
 		struct dw_edma_block *dt_block = &vsec_data.dt_wr[i];
 
@@ -272,9 +262,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		dt_region->sz = dt_block->sz;
 	}
 
-	for (i = 0; i < dw->rd_ch_cnt; i++) {
-		struct dw_edma_region *ll_region = &dw->ll_region_rd[i];
-		struct dw_edma_region *dt_region = &dw->dt_region_rd[i];
+	for (i = 0; i < chip->rd_ch_cnt; i++) {
+		struct dw_edma_region *ll_region = &chip->ll_region_rd[i];
+		struct dw_edma_region *dt_region = &chip->dt_region_rd[i];
 		struct dw_edma_block *ll_block = &vsec_data.ll_rd[i];
 		struct dw_edma_block *dt_block = &vsec_data.dt_rd[i];
 
@@ -298,45 +288,45 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	}
 
 	/* Debug info */
-	if (dw->mf == EDMA_MF_EDMA_LEGACY)
-		pci_dbg(pdev, "Version:\teDMA Port Logic (0x%x)\n", dw->mf);
-	else if (dw->mf == EDMA_MF_EDMA_UNROLL)
-		pci_dbg(pdev, "Version:\teDMA Unroll (0x%x)\n", dw->mf);
-	else if (dw->mf == EDMA_MF_HDMA_COMPAT)
-		pci_dbg(pdev, "Version:\tHDMA Compatible (0x%x)\n", dw->mf);
+	if (chip->mf == EDMA_MF_EDMA_LEGACY)
+		pci_dbg(pdev, "Version:\teDMA Port Logic (0x%x)\n", chip->mf);
+	else if (chip->mf == EDMA_MF_EDMA_UNROLL)
+		pci_dbg(pdev, "Version:\teDMA Unroll (0x%x)\n", chip->mf);
+	else if (chip->mf == EDMA_MF_HDMA_COMPAT)
+		pci_dbg(pdev, "Version:\tHDMA Compatible (0x%x)\n", chip->mf);
 	else
-		pci_dbg(pdev, "Version:\tUnknown (0x%x)\n", dw->mf);
+		pci_dbg(pdev, "Version:\tUnknown (0x%x)\n", chip->mf);
 
-	pci_dbg(pdev, "Registers:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
+	pci_dbg(pdev, "Registers:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p)\n",
 		vsec_data.rg.bar, vsec_data.rg.off, vsec_data.rg.sz,
-		dw->rg_region.vaddr, &dw->rg_region.paddr);
+		chip->rg_region.vaddr);
 
 
-	for (i = 0; i < dw->wr_ch_cnt; i++) {
+	for (i = 0; i < chip->wr_ch_cnt; i++) {
 		pci_dbg(pdev, "L. List:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
 			i, vsec_data.ll_wr[i].bar,
-			vsec_data.ll_wr[i].off, dw->ll_region_wr[i].sz,
-			dw->ll_region_wr[i].vaddr, &dw->ll_region_wr[i].paddr);
+			vsec_data.ll_wr[i].off, chip->ll_region_wr[i].sz,
+			chip->ll_region_wr[i].vaddr, &chip->ll_region_wr[i].paddr);
 
 		pci_dbg(pdev, "Data:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
 			i, vsec_data.dt_wr[i].bar,
-			vsec_data.dt_wr[i].off, dw->dt_region_wr[i].sz,
-			dw->dt_region_wr[i].vaddr, &dw->dt_region_wr[i].paddr);
+			vsec_data.dt_wr[i].off, chip->dt_region_wr[i].sz,
+			chip->dt_region_wr[i].vaddr, &chip->dt_region_wr[i].paddr);
 	}
 
-	for (i = 0; i < dw->rd_ch_cnt; i++) {
+	for (i = 0; i < chip->rd_ch_cnt; i++) {
 		pci_dbg(pdev, "L. List:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
 			i, vsec_data.ll_rd[i].bar,
-			vsec_data.ll_rd[i].off, dw->ll_region_rd[i].sz,
-			dw->ll_region_rd[i].vaddr, &dw->ll_region_rd[i].paddr);
+			vsec_data.ll_rd[i].off, chip->ll_region_rd[i].sz,
+			chip->ll_region_rd[i].vaddr, &chip->ll_region_rd[i].paddr);
 
 		pci_dbg(pdev, "Data:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
 			i, vsec_data.dt_rd[i].bar,
-			vsec_data.dt_rd[i].off, dw->dt_region_rd[i].sz,
-			dw->dt_region_rd[i].vaddr, &dw->dt_region_rd[i].paddr);
+			vsec_data.dt_rd[i].off, chip->dt_region_rd[i].sz,
+			chip->dt_region_rd[i].vaddr, &chip->dt_region_rd[i].paddr);
 	}
 
-	pci_dbg(pdev, "Nr. IRQs:\t%u\n", dw->nr_irqs);
+	pci_dbg(pdev, "Nr. IRQs:\t%u\n", chip->nr_irqs);
 
 	/* Validating if PCI interrupts were enabled */
 	if (!pci_dev_msi_enabled(pdev)) {
@@ -344,10 +334,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		return -EPERM;
 	}
 
-	dw->irq = devm_kcalloc(dev, nr_irqs, sizeof(*dw->irq), GFP_KERNEL);
-	if (!dw->irq)
-		return -ENOMEM;
-
 	/* Starting eDMA driver */
 	err = dw_edma_probe(chip);
 	if (err) {
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 329fc2e57b703..6cf6c28ce0cc9 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -25,7 +25,7 @@ enum dw_edma_control {
 
 static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
 {
-	return dw->rg_region.vaddr;
+	return dw->chip->rg_region.vaddr;
 }
 
 #define SET_32(dw, name, value)				\
@@ -96,7 +96,7 @@ static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
 static inline struct dw_edma_v0_ch_regs __iomem *
 __dw_ch_regs(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch)
 {
-	if (dw->mf == EDMA_MF_EDMA_LEGACY)
+	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY)
 		return &(__dw_regs(dw)->type.legacy.ch);
 
 	if (dir == EDMA_DIR_WRITE)
@@ -108,7 +108,7 @@ __dw_ch_regs(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch)
 static inline void writel_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 			     u32 value, void __iomem *addr)
 {
-	if (dw->mf == EDMA_MF_EDMA_LEGACY) {
+	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY) {
 		u32 viewport_sel;
 		unsigned long flags;
 
@@ -133,7 +133,7 @@ static inline u32 readl_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 {
 	u32 value;
 
-	if (dw->mf == EDMA_MF_EDMA_LEGACY) {
+	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY) {
 		u32 viewport_sel;
 		unsigned long flags;
 
@@ -169,7 +169,7 @@ static inline u32 readl_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 static inline void writeq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 			     u64 value, void __iomem *addr)
 {
-	if (dw->mf == EDMA_MF_EDMA_LEGACY) {
+	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY) {
 		u32 viewport_sel;
 		unsigned long flags;
 
@@ -194,7 +194,7 @@ static inline u64 readq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 {
 	u32 value;
 
-	if (dw->mf == EDMA_MF_EDMA_LEGACY) {
+	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY) {
 		u32 viewport_sel;
 		unsigned long flags;
 
@@ -256,7 +256,7 @@ u16 dw_edma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
 
 enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan)
 {
-	struct dw_edma *dw = chan->chip->dw;
+	struct dw_edma *dw = chan->dw;
 	u32 tmp;
 
 	tmp = FIELD_GET(EDMA_V0_CH_STATUS_MASK,
@@ -272,7 +272,7 @@ enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan)
 
 void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan)
 {
-	struct dw_edma *dw = chan->chip->dw;
+	struct dw_edma *dw = chan->dw;
 
 	SET_RW_32(dw, chan->dir, int_clear,
 		  FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id)));
@@ -280,7 +280,7 @@ void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan)
 
 void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan)
 {
-	struct dw_edma *dw = chan->chip->dw;
+	struct dw_edma *dw = chan->dw;
 
 	SET_RW_32(dw, chan->dir, int_clear,
 		  FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id)));
@@ -357,7 +357,7 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
-	struct dw_edma *dw = chan->chip->dw;
+	struct dw_edma *dw = chan->dw;
 	u32 tmp;
 
 	dw_edma_v0_core_write_chunk(chunk);
@@ -365,7 +365,7 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 	if (first) {
 		/* Enable engine */
 		SET_RW_32(dw, chan->dir, engine_en, BIT(0));
-		if (dw->mf == EDMA_MF_HDMA_COMPAT) {
+		if (dw->chip->mf == EDMA_MF_HDMA_COMPAT) {
 			switch (chan->id) {
 			case 0:
 				SET_RW_COMPAT(dw, chan->dir, ch0_pwr_en,
@@ -431,7 +431,7 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 
 int dw_edma_v0_core_device_config(struct dw_edma_chan *chan)
 {
-	struct dw_edma *dw = chan->chip->dw;
+	struct dw_edma *dw = chan->dw;
 	u32 tmp = 0;
 
 	/* MSI done addr - low, high */
@@ -501,12 +501,12 @@ int dw_edma_v0_core_device_config(struct dw_edma_chan *chan)
 }
 
 /* eDMA debugfs callbacks */
-void dw_edma_v0_core_debugfs_on(struct dw_edma_chip *chip)
+void dw_edma_v0_core_debugfs_on(struct dw_edma *dw)
 {
-	dw_edma_v0_debugfs_on(chip);
+	dw_edma_v0_debugfs_on(dw);
 }
 
-void dw_edma_v0_core_debugfs_off(struct dw_edma_chip *chip)
+void dw_edma_v0_core_debugfs_off(struct dw_edma *dw)
 {
-	dw_edma_v0_debugfs_off(chip);
+	dw_edma_v0_debugfs_off(dw);
 }
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.h b/drivers/dma/dw-edma/dw-edma-v0-core.h
index 2afa626b8300c..75aec6d31b210 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.h
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.h
@@ -22,7 +22,7 @@ u32 dw_edma_v0_core_status_abort_int(struct dw_edma *chan, enum dw_edma_dir dir)
 void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first);
 int dw_edma_v0_core_device_config(struct dw_edma_chan *chan);
 /* eDMA debug fs callbacks */
-void dw_edma_v0_core_debugfs_on(struct dw_edma_chip *chip);
-void dw_edma_v0_core_debugfs_off(struct dw_edma_chip *chip);
+void dw_edma_v0_core_debugfs_on(struct dw_edma *dw);
+void dw_edma_v0_core_debugfs_off(struct dw_edma *dw);
 
 #endif /* _DW_EDMA_V0_CORE_H */
diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
index 4b3bcffd15ef1..b765adb969998 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
@@ -54,7 +54,7 @@ struct debugfs_entries {
 static int dw_edma_debugfs_u32_get(void *data, u64 *val)
 {
 	void __iomem *reg = (void __force __iomem *)data;
-	if (dw->mf == EDMA_MF_EDMA_LEGACY &&
+	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY &&
 	    reg >= (void __iomem *)&regs->type.legacy.ch) {
 		void __iomem *ptr = &regs->type.legacy.ch;
 		u32 viewport_sel = 0;
@@ -173,7 +173,7 @@ static void dw_edma_debugfs_regs_wr(struct dentry *dir)
 	nr_entries = ARRAY_SIZE(debugfs_regs);
 	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dir);
 
-	if (dw->mf == EDMA_MF_HDMA_COMPAT) {
+	if (dw->chip->mf == EDMA_MF_HDMA_COMPAT) {
 		nr_entries = ARRAY_SIZE(debugfs_unroll_regs);
 		dw_edma_debugfs_create_x32(debugfs_unroll_regs, nr_entries,
 					   regs_dir);
@@ -242,7 +242,7 @@ static void dw_edma_debugfs_regs_rd(struct dentry *dir)
 	nr_entries = ARRAY_SIZE(debugfs_regs);
 	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dir);
 
-	if (dw->mf == EDMA_MF_HDMA_COMPAT) {
+	if (dw->chip->mf == EDMA_MF_HDMA_COMPAT) {
 		nr_entries = ARRAY_SIZE(debugfs_unroll_regs);
 		dw_edma_debugfs_create_x32(debugfs_unroll_regs, nr_entries,
 					   regs_dir);
@@ -282,13 +282,13 @@ static void dw_edma_debugfs_regs(void)
 	dw_edma_debugfs_regs_rd(regs_dir);
 }
 
-void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
+void dw_edma_v0_debugfs_on(struct dw_edma *_dw)
 {
-	dw = chip->dw;
+	dw = _dw;
 	if (!dw)
 		return;
 
-	regs = dw->rg_region.vaddr;
+	regs = dw->chip->rg_region.vaddr;
 	if (!regs)
 		return;
 
@@ -296,16 +296,16 @@ void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
 	if (!dw->debugfs)
 		return;
 
-	debugfs_create_u32("mf", 0444, dw->debugfs, &dw->mf);
+	debugfs_create_u32("mf", 0444, dw->debugfs, &dw->chip->mf);
 	debugfs_create_u16("wr_ch_cnt", 0444, dw->debugfs, &dw->wr_ch_cnt);
 	debugfs_create_u16("rd_ch_cnt", 0444, dw->debugfs, &dw->rd_ch_cnt);
 
 	dw_edma_debugfs_regs();
 }
 
-void dw_edma_v0_debugfs_off(struct dw_edma_chip *chip)
+void dw_edma_v0_debugfs_off(struct dw_edma *_dw)
 {
-	dw = chip->dw;
+	dw = _dw;
 	if (!dw)
 		return;
 
diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.h b/drivers/dma/dw-edma/dw-edma-v0-debugfs.h
index d0ff25a9ea5c9..3391b86edf5ab 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.h
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.h
@@ -12,14 +12,14 @@
 #include <linux/dma/edma.h>
 
 #ifdef CONFIG_DEBUG_FS
-void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip);
-void dw_edma_v0_debugfs_off(struct dw_edma_chip *chip);
+void dw_edma_v0_debugfs_on(struct dw_edma *dw);
+void dw_edma_v0_debugfs_off(struct dw_edma *dw);
 #else
-static inline void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
+static inline void dw_edma_v0_debugfs_on(struct dw_edma *dw)
 {
 }
 
-static inline void dw_edma_v0_debugfs_off(struct dw_edma_chip *chip)
+static inline void dw_edma_v0_debugfs_off(struct dw_edma *dw)
 {
 }
 #endif /* CONFIG_DEBUG_FS */
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index d4333e721588d..86697d33e0610 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -12,17 +12,63 @@
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
+ * @nr_irqs:		 total dma irq number
+ * @ops			 DMA channel to IRQ number mapping
+ * @wr_ch_cnt		 DMA write channel number
+ * @rd_ch_cnt		 DMA read channel number
+ * @rg_region		 DMA register region
+ * @ll_region_wr	 DMA descriptor link list memory for write channel
+ * @ll_region_rd	 DMA descriptor link list memory for read channel
+ * @dt_region_wr	 DMA data memory for write channel
+ * @dt_region_rd	 DMA data memory for read channel
+ * @mf			 DMA register map format
  * @dw:			 struct dw_edma that is filed by dw_edma_probe()
  */
 struct dw_edma_chip {
 	struct device		*dev;
 	int			id;
+	int			nr_irqs;
+	const struct dw_edma_core_ops   *ops;
+
+	struct dw_edma_region	rg_region;
+
+	u16			wr_ch_cnt;
+	u16			rd_ch_cnt;
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
2.35.1

