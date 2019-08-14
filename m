Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCDA78CC6C
	for <lists+dmaengine@lfdr.de>; Wed, 14 Aug 2019 09:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfHNHRJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Aug 2019 03:17:09 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56690 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727411AbfHNHRI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 14 Aug 2019 03:17:08 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6221E2DE495F604BF1C8;
        Wed, 14 Aug 2019 15:17:06 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Wed, 14 Aug 2019 15:16:56 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <vkoul@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Mao Wenan" <maowenan@huawei.com>
Subject: [PATCH v2 linux-next 2/2] drivers: dma: change alignment of mux_configure32 and fsl_edma_chan_mux
Date:   Wed, 14 Aug 2019 15:21:05 +0800
Message-ID: <20190814072105.144107-3-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814072105.144107-1-maowenan@huawei.com>
References: <20190814072105.144107-1-maowenan@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The alignment of mux_configure32() and fsl_edma_chan_mux() need 
to be adjusted, it must start precisely at the first column after 
the openning parenthesis of the first line.

Fixes: 9d831528a656 ("dmaengine: fsl-edma: extract common fsl-edma code (no changes in behavior intended)")
Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 drivers/dma/fsl-edma-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 264c448de409..b1a7ca91701a 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -91,7 +91,7 @@ static void mux_configure8(struct fsl_edma_chan *fsl_chan, void __iomem *addr,
 }
 
 static void mux_configure32(struct fsl_edma_chan *fsl_chan, void __iomem *addr,
-		     u32 off, u32 slot, bool enable)
+			    u32 off, u32 slot, bool enable)
 {
 	u32 val;
 
@@ -104,7 +104,7 @@ static void mux_configure32(struct fsl_edma_chan *fsl_chan, void __iomem *addr,
 }
 
 void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
-			unsigned int slot, bool enable)
+		       unsigned int slot, bool enable)
 {
 	u32 ch = fsl_chan->vchan.chan.chan_id;
 	void __iomem *muxaddr;
-- 
2.20.1

