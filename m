Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 367411525A7
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2020 05:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgBEEnG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Feb 2020 23:43:06 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:51466 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727879AbgBEEnG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 4 Feb 2020 23:43:06 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1FE8CC8171B8065DF288;
        Wed,  5 Feb 2020 12:42:59 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Wed, 5 Feb 2020
 12:42:51 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <mripard@kernel.org>, <wens@csie.org>, <stefan@olimex.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] dmaengine: sun4i: remove set but unused variable 'linear_mode'
Date:   Wed, 5 Feb 2020 12:42:47 +0800
Message-ID: <20200205044247.32496-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

drivers/dma/sun4i-dma.c: In function sun4i_dma_prep_dma_cyclic:
drivers/dma/sun4i-dma.c:672:24: warning:
 variable linear_mode set but not used [-Wunused-but-set-variable]

commit ffc079a4accc ("dmaengine: sun4i: Add support for cyclic requests with dedicated DMA")
involved this unused variable.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/dma/sun4i-dma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
index bbc2bda..501cd44 100644
--- a/drivers/dma/sun4i-dma.c
+++ b/drivers/dma/sun4i-dma.c
@@ -669,7 +669,7 @@ sun4i_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf, size_t len,
 	dma_addr_t src, dest;
 	u32 endpoints;
 	int nr_periods, offset, plength, i;
-	u8 ram_type, io_mode, linear_mode;
+	u8 ram_type, io_mode;
 
 	if (!is_slave_direction(dir)) {
 		dev_err(chan2dev(chan), "Invalid DMA direction\n");
@@ -684,11 +684,9 @@ sun4i_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf, size_t len,
 
 	if (vchan->is_dedicated) {
 		io_mode = SUN4I_DDMA_ADDR_MODE_IO;
-		linear_mode = SUN4I_DDMA_ADDR_MODE_LINEAR;
 		ram_type = SUN4I_DDMA_DRQ_TYPE_SDRAM;
 	} else {
 		io_mode = SUN4I_NDMA_ADDR_MODE_IO;
-		linear_mode = SUN4I_NDMA_ADDR_MODE_LINEAR;
 		ram_type = SUN4I_NDMA_DRQ_TYPE_SDRAM;
 	}
 
-- 
2.7.4


