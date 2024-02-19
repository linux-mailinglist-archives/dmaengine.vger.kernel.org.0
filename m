Return-Path: <dmaengine+bounces-1037-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7307E85A7F6
	for <lists+dmaengine@lfdr.de>; Mon, 19 Feb 2024 16:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F38BB1F25DDE
	for <lists+dmaengine@lfdr.de>; Mon, 19 Feb 2024 15:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338B639FC5;
	Mon, 19 Feb 2024 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AEOvFmq0"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2087.outbound.protection.outlook.com [40.107.14.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164D93A1D0;
	Mon, 19 Feb 2024 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358267; cv=fail; b=kmNkth9KCzEvD1OMkHM+s6Aepd8cg7QLJtE/EedldxtXuatzyGeXKS7V0zaNjn2PoSYwFmTHUd65t3sSxh+qkcu8VqTO7zGr/ykM0BV+DSjZH7GETK1epeliuteeyR8VlkHIAgeCvMjbEoh9y8kYHpbRPBnbz7DPjjTzbZMOjjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358267; c=relaxed/simple;
	bh=eJNxE6nRQlBvNXRhKUmHShP4Bsm+42d6Qm6TJMRTsm8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=NoYcx0XwtvbCFCalcB3C4te7b2/p11IuoWNHBEaDHwDDeNwwd2oDoHo0ezCBMD9isBNXv3Ze9ZIsX78CVXfZBOEQCx8sGtuv++/C1k8gGMVznC6N07HYiMb1FrDGoVeNTyZoP9HnNb/mwHCU/VOn2Up5PRu625b8ywL8Xy1LU1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=AEOvFmq0; arc=fail smtp.client-ip=40.107.14.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CA3QmyMSwY6i/Wi18VlsuTNwD0lazMUhTXZ+TrsUeW4DEy/otahe1slPISvpcYDlIbFoFlzB8OL2JQZL0NLKuVNQUWikWjbjZSjE4GuCdXlk2DAMPk+zw+OH3LhI/0ZBnGKwsJR7lSIRKsZWjnjE7f/J4JC9DbrD/zfW6jyO72K/f2e8jl8yfcQpmRYpJh/ba6FG5Dl1ZQONWzOS6Cmo8scOFz+VtnMR7JcfmRohfLekAf4f9kMFU1jF2gQgj0+9veBJtc1Nt4wHgQpFUbwHrPTJYC1Jbmdm6w2+KaJAxqrT4Y/agfJANHS+i4mrWaFp2D2LOnAl4E/+Ehe0ytSSSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QR9JHvOYDB7WaZoNx3oAvzHoFGlMIBRxyB/mZOX6yY=;
 b=BI/BE3s0An2s9g2nuEC3XmPrx3IWqPu1bhRj0ocHiaba6E+pLkfYrif5mheTADoZT/1YRcnVWlBlqfl8PzYM+sXp97btvp8bmcjsisIa4Bcw6AXDDylB7nRCzop3xvllYS0IElka07CmL7tN/l86hrgpmOkXHliDxWb9XkEK5XWGvGGQ9wkRwLB4neiRXUbWGkZ1G902nI2SwaPXc6w90Eh/ertwwtUJexLnqW/bNi5MxNynw3BQ9fMZuj5r6DLtkiwM+rNccVFx23lwl8wgV01GvDGNDw+WINrGwbCPfSa2hbqj3CeTpicYNXyhkYPoOHovS0vTmIb5/4gTyMXeqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QR9JHvOYDB7WaZoNx3oAvzHoFGlMIBRxyB/mZOX6yY=;
 b=AEOvFmq00SoR8XgVVVmRm5k1YAxjgANiPDPDLcmLN1f+d6AoujRQTF6IJi1yJukmYujOjBeT2qZZC8sp2WP5cEZqCVszTEKN2xhHA8Yz2aGtGf8x1kwfbMyDOdXYYRPjzfmbCaL9GaEWJ1aiwfKFz4RYD9xdtH8q/MCXGNaLHKE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7369.eurprd04.prod.outlook.com (2603:10a6:102:89::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 15:57:42 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 15:57:42 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dmaengine: mxs-dma: switch from dma_coherent to dma_pool
Date: Mon, 19 Feb 2024 10:57:27 -0500
Message-Id: <20240219155728.606497-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0028.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: 73c2a603-728f-4160-675f-08dc3163813c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ymFT7SZK0zWKvJgloo27uQv8Dir39FMM/SbRCmqXvMqzr6T2ro6xR0Msk79XzHqIe5DO+ekKtQup+Aelr9qiv/BulAWYrWMEccxyObJ3An5SxukO6Ud/aYUWpHFugDpb0w0mavpQJvsA2unlbhHpHnvIJxsr8LsYWXxPe3/3fHO+2C0dxmR19j+d7by7CTwu701KVWdGnMmswBeJYyZ6I1IpgcVdsE7LJMMca+rkbAAZyYiSxNtoBiUMmq258yPOQjCrk0anQvvfSIz3YZA/nq6+YMxyphHMglor9Fi5Mq8LHmJovp0XOeMI4W51xKdUSx441MB5W3Y1wEpNeaijwDUZjwdA5i5cMye52epzp44oy/3aNB8IWoLRObpr1HIOMooYZMnPFPkMrd/LO24ubVhYmZwoc5vtVpVXVGRC2wJVT7NCQztVCtUx3tdeFR8d/NpzF+Uops8ZjqJRQTPEgOSrx1FEvMYbCgf//B+1pKbUH78JNFp8z9fdlT6H3eQeAkCF/flOC3rUxdl9jhMmCQQ87UfLzgdtxBggAbTvleKZIRak9IRkQjKkGmgBwLbPC1wJgR/sYY0RP5U8NA7s/HxkbBmF2OkLrcRiYPTkSzBP98zv0ATO+9AqhM751UK+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SpoVnCW1xe06J2MT48aqJzRj8TCVsG7UV/xTCKJDhZQd6EfXIbaE0vebyx/G?=
 =?us-ascii?Q?wrOt1YboyjYQ66eUh6yJcjJrE/i9T83n/TzFAfrtcwZA19D0EbczNwbfh7nE?=
 =?us-ascii?Q?arF/yxcXSkd1EFV70eU2PmQY58tTEI9pGf/k8GFRVsMjWTLkBAmG+ADvSIth?=
 =?us-ascii?Q?3jmKRo0TGrFI2AniVgReAjqC+7W7KdFhBrh7b1urFF/lztpyH0FVjm16mSdJ?=
 =?us-ascii?Q?igxjKf9h0tl8Kcbkiv5elRojMzXNROIjnOqEd0e6obOIxyOZ2XPzedFpDUlj?=
 =?us-ascii?Q?662/prt1TrVCDzyah87uST926QCwH2r8zQ6ceoPwBSGVl0lC/QQHepEZyfPm?=
 =?us-ascii?Q?wnpHrG2VqYu9tJJUoMmZB9LrnnSEPhc/5ZaA8gvnPe4h3LH+6cMnIR7ctrK0?=
 =?us-ascii?Q?lkyC1594XneZfZ6EL2tbBW27Bhlq9ZmGuUoyDzDU+9yAkpgt2SgTUJh7EqtP?=
 =?us-ascii?Q?Mfgq9Ha00LfA/RnOenxt+DFHzlsQNQfG9aMfZu6hf0N9/YAvNoacTmQEfMBn?=
 =?us-ascii?Q?US9q3kqL0iW0mb/53euYCqHi52+glg/VJMIx1n3fNiwqKbK7SaKySfbkqFnV?=
 =?us-ascii?Q?diXYEP8UTGHEMASzQsa7S0DN2lGEcegcXpp+tNSPCla1hAPeCBGQjRcbYs8i?=
 =?us-ascii?Q?pr7LE0jYHn5rExwEUUyLxCvF4uFa0ULfPmwCBWHJOzrvXGQQjZHwHck8YOGB?=
 =?us-ascii?Q?cnbavGACSSfVQRLwRs7fkffdIF7iJ9fVpf+rTQd1EVCC5Rrgh6jegC9Jxpjj?=
 =?us-ascii?Q?iHwtMuEAHXGZhB3e+L0N6uxfGd0l2NZB9f2Vt+e7eHINn+782DcFPZplwKIH?=
 =?us-ascii?Q?RRlTIkoR4Npg+omVm7SGysoCkT0gTeNFsQHfE7sV1wtgQ2cKIYN+E8TgUhzb?=
 =?us-ascii?Q?ZKoNTIyogwysVKy7Dm44tvtXW3UwJ/OmpXfRL18yvdbKeFNVunIAYL7FMecG?=
 =?us-ascii?Q?r7kai2H3k70redTjGsL+Ke4VxhEjqaDXktZ/OUy+Z5RH/GXHjbLpmPVQgfr5?=
 =?us-ascii?Q?DOQzl5JWPZVL45lspw/gD3qe5/ElPGu6cSyfV1KfywrppaUI6lW5nKEZ9Mlc?=
 =?us-ascii?Q?PqpBkAZOu34V7sKvK5UryYYOnZ30gOXxSLzDxkjILIk4ASfYKDptheveTKnv?=
 =?us-ascii?Q?YB25aN6RfgBW4zfacsvos7QQEPeqEZOh0EV12nOqwbmWBJnEh5qn2ZeAul+d?=
 =?us-ascii?Q?K1KI9kC8HnzU+zACMk8JCdGay/BThsItOi+ezuOVEI3Q1reIqjyohfN/suXr?=
 =?us-ascii?Q?yowB/oNOGcFdZ0hCQuOIwOasYqQyUV99gpugFlMOKRne9zufKcGQcJVqsXGD?=
 =?us-ascii?Q?9ObI9xGvTo4vy469913DdU5kFP5RrisAysrQ2bYDCMb/CdvML0AXuKw3/eau?=
 =?us-ascii?Q?Mk2/wWiTEGMRUydEyQp3PwvAL5dipXQMRWwDlCNX0iGd3Q63YySYH2aswrh5?=
 =?us-ascii?Q?phAccJ7sJpguzcKIgBtfeIXLMHdc9rCdwI8cz+wWcKlU7t3U3pqRkzuW98Uj?=
 =?us-ascii?Q?ePnL1klGBbO40isZMLCEzoNW9fYrrmk7VV0EsCGNad6a8JvaGxNXhL5gGn3G?=
 =?us-ascii?Q?uEs3XCkuKpL/iRxj/zOu1zsi1m3KEHCOPKXjdzqC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c2a603-728f-4160-675f-08dc3163813c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 15:57:42.0299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E8NpVxe/+TiUjGR6Xt+LW6x8frIdrVN6l8c0ntuq/CtSsqNBfzmzHjBIN8ediIrvLsxz3k+bxZEpcEEQZ1X8xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7369

From: Han Xu <han.xu@nxp.com>

Using dma_pool to manage dma descriptor memory.

Signed-off-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/mxs-dma.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index cfb9962417ef6..a60bf7a22492d 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -24,6 +24,7 @@
 #include <linux/of_dma.h>
 #include <linux/list.h>
 #include <linux/dma/mxs-dma.h>
+#include <linux/dmapool.h>
 
 #include <asm/irq.h>
 
@@ -104,6 +105,7 @@ struct mxs_dma_ccw {
 
 #define CCW_BLOCK_SIZE	(4 * PAGE_SIZE)
 #define NUM_CCW	(int)(CCW_BLOCK_SIZE / sizeof(struct mxs_dma_ccw))
+#define CCW_BLOCK_ALGIN	32
 
 struct mxs_dma_chan {
 	struct mxs_dma_engine		*mxs_dma;
@@ -117,6 +119,7 @@ struct mxs_dma_chan {
 	enum dma_status			status;
 	unsigned int			flags;
 	bool				reset;
+	struct dma_pool			*ccw_pool;
 #define MXS_DMA_SG_LOOP			(1 << 0)
 #define MXS_DMA_USE_SEMAPHORE		(1 << 1)
 };
@@ -398,9 +401,8 @@ static int mxs_dma_alloc_chan_resources(struct dma_chan *chan)
 	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
 	int ret;
 
-	mxs_chan->ccw = dma_alloc_coherent(mxs_dma->dma_device.dev,
-					   CCW_BLOCK_SIZE,
-					   &mxs_chan->ccw_phys, GFP_KERNEL);
+	mxs_chan->ccw = dma_pool_zalloc(mxs_chan->ccw_pool, GFP_ATOMIC, &mxs_chan->ccw_phys);
+
 	if (!mxs_chan->ccw) {
 		ret = -ENOMEM;
 		goto err_alloc;
@@ -428,8 +430,7 @@ static int mxs_dma_alloc_chan_resources(struct dma_chan *chan)
 err_clk:
 	free_irq(mxs_chan->chan_irq, mxs_dma);
 err_irq:
-	dma_free_coherent(mxs_dma->dma_device.dev, CCW_BLOCK_SIZE,
-			mxs_chan->ccw, mxs_chan->ccw_phys);
+	dma_pool_free(mxs_chan->ccw_pool, mxs_chan->ccw, mxs_chan->ccw_phys);
 err_alloc:
 	return ret;
 }
@@ -443,8 +444,7 @@ static void mxs_dma_free_chan_resources(struct dma_chan *chan)
 
 	free_irq(mxs_chan->chan_irq, mxs_dma);
 
-	dma_free_coherent(mxs_dma->dma_device.dev, CCW_BLOCK_SIZE,
-			mxs_chan->ccw, mxs_chan->ccw_phys);
+	dma_pool_free(mxs_chan->ccw_pool, mxs_chan->ccw, mxs_chan->ccw_phys);
 
 	clk_disable_unprepare(mxs_dma->clk);
 }
@@ -745,6 +745,7 @@ static int mxs_dma_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	const struct mxs_dma_type *dma_type;
 	struct mxs_dma_engine *mxs_dma;
+	struct dma_pool *ccw_pool;
 	int ret, i;
 
 	mxs_dma = devm_kzalloc(&pdev->dev, sizeof(*mxs_dma), GFP_KERNEL);
@@ -797,6 +798,15 @@ static int mxs_dma_probe(struct platform_device *pdev)
 	mxs_dma->pdev = pdev;
 	mxs_dma->dma_device.dev = &pdev->dev;
 
+	ccw_pool = dma_pool_create("ccw_pool", mxs_dma->dma_device.dev, CCW_BLOCK_SIZE,
+				   CCW_BLOCK_ALGIN, 0);
+
+	for (i = 0; i < MXS_DMA_CHANNELS; i++) {
+		struct mxs_dma_chan *mxs_chan = &mxs_dma->mxs_chans[i];
+
+		mxs_chan->ccw_pool = ccw_pool;
+	}
+
 	/* mxs_dma gets 65535 bytes maximum sg size */
 	dma_set_max_seg_size(mxs_dma->dma_device.dev, MAX_XFER_BYTES);
 
-- 
2.34.1


