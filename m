Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE18897F6
	for <lists+dmaengine@lfdr.de>; Mon, 12 Aug 2019 09:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfHLHi1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Aug 2019 03:38:27 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45114 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726304AbfHLHi1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 12 Aug 2019 03:38:27 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C6624B928CFFF8E18AE1;
        Mon, 12 Aug 2019 15:38:24 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Mon, 12 Aug 2019 15:38:14 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Mao Wenan" <maowenan@huawei.com>
Subject: [PATCH linux-next] drivers: dma: Fix sparse warning for mux_configure32
Date:   Mon, 12 Aug 2019 15:42:05 +0800
Message-ID: <20190812074205.96759-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There is one sparse warning in drivers/dma/fsl-edma-common.c,
fix it by setting mux_configure32() as static.

make allmodconfig ARCH=mips CROSS_COMPILE=mips-linux-gnu-
make C=2 drivers/dma/fsl-edma-common.o ARCH=mips CROSS_COMPILE=mips-linux-gnu-
drivers/dma/fsl-edma-common.c:93:6: warning: symbol 'mux_configure32' was not declared. Should it be static?

Fixes: 232a7f18cf8ec ("dmaengine: fsl-edma: add i.mx7ulp edma2 version support")
Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 drivers/dma/fsl-edma-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 6d6d8a4..7dbf7df 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -90,8 +90,8 @@ static void mux_configure8(struct fsl_edma_chan *fsl_chan, void __iomem *addr,
 	iowrite8(val8, addr + off);
 }
 
-void mux_configure32(struct fsl_edma_chan *fsl_chan, void __iomem *addr,
-		     u32 off, u32 slot, bool enable)
+static void mux_configure32(struct fsl_edma_chan *fsl_chan, void __iomem *addr,
+			    u32 off, u32 slot, bool enable)
 {
 	u32 val;
 
-- 
2.7.4

