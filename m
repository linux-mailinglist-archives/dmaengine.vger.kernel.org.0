Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3152367CA6
	for <lists+dmaengine@lfdr.de>; Thu, 22 Apr 2021 10:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235481AbhDVIjH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 22 Apr 2021 04:39:07 -0400
Received: from inva020.nxp.com ([92.121.34.13]:34362 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235469AbhDVIjG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 22 Apr 2021 04:39:06 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 907F61A0A22;
        Thu, 22 Apr 2021 10:38:31 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 456D91A1A53;
        Thu, 22 Apr 2021 10:38:29 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 3BD5F40366;
        Thu, 22 Apr 2021 10:38:02 +0200 (CEST)
From:   Guanhua Gao <guanhua.gao@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>, Yi Zhao <yi.zhao@nxp.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guanhua Gao <guanhua.gao@nxp.com>
Subject: [PATCH v2 1/3] dmaengine: fsl-dpaa2-qdma: Fix the size of dma pools
Date:   Thu, 22 Apr 2021 16:44:12 +0800
Message-Id: <20210422084412.796-1-guanhua.gao@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In case of long format of qDMA command descriptor, there are one frame
descriptor, three entries in the frame list and two data entries. So the
size of dma_pool_create for these three fields should be the same with
the total size of entries respectively, or the contents may be overwritten
by the next allocated descriptor.

Signed-off-by: Guanhua Gao <guanhua.gao@nxp.com>
---
Change in v2:
 - Add comments for changes.
 - Update copyright year.

 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
index 4ec909e0b810..de3eff3f3de3 100644
--- a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
+++ b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-// Copyright 2019 NXP
+// Copyright 2019-2021 NXP
 
 #include <linux/init.h>
 #include <linux/module.h>
@@ -32,21 +32,29 @@ static int dpaa2_qdma_alloc_chan_resources(struct dma_chan *chan)
 	struct dpaa2_qdma_engine *dpaa2_qdma = dpaa2_chan->qdma;
 	struct device *dev = &dpaa2_qdma->priv->dpdmai_dev->dev;
 
+	/* dma pool for compound command descriptor */
 	dpaa2_chan->fd_pool = dma_pool_create("fd_pool", dev,
 					      sizeof(struct dpaa2_fd),
 					      sizeof(struct dpaa2_fd), 0);
 	if (!dpaa2_chan->fd_pool)
 		goto err;
 
-	dpaa2_chan->fl_pool = dma_pool_create("fl_pool", dev,
-					      sizeof(struct dpaa2_fl_entry),
-					      sizeof(struct dpaa2_fl_entry), 0);
+	/*
+	 * dma pool for descriptor entry, source data entry, and
+	 * destination data entry.
+	 */
+	dpaa2_chan->fl_pool =
+		dma_pool_create("fl_pool", dev,
+				 sizeof(struct dpaa2_fl_entry) * 3,
+				 sizeof(struct dpaa2_fl_entry), 0);
+
 	if (!dpaa2_chan->fl_pool)
 		goto err_fd;
 
+	/* dma pool for source descriptor and destination descriptor */
 	dpaa2_chan->sdd_pool =
 		dma_pool_create("sdd_pool", dev,
-				sizeof(struct dpaa2_qdma_sd_d),
+				sizeof(struct dpaa2_qdma_sd_d) * 2,
 				sizeof(struct dpaa2_qdma_sd_d), 0);
 	if (!dpaa2_chan->sdd_pool)
 		goto err_fl;
-- 
2.25.1

