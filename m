Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8D78CC66
	for <lists+dmaengine@lfdr.de>; Wed, 14 Aug 2019 09:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfHNHRJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Aug 2019 03:17:09 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56688 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727414AbfHNHRI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 14 Aug 2019 03:17:08 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5C588903AA47602AB115;
        Wed, 14 Aug 2019 15:17:06 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Wed, 14 Aug 2019 15:16:55 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <vkoul@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Mao Wenan" <maowenan@huawei.com>
Subject: [PATCH v2 linux-next 1/2] drivers: dma: make mux_configure32 static
Date:   Wed, 14 Aug 2019 15:21:04 +0800
Message-ID: <20190814072105.144107-2-maowenan@huawei.com>
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

There is one sparse warning in drivers/dma/fsl-edma-common.c:
drivers/dma/fsl-edma-common.c:93:6: warning: symbol 'mux_configure32'
was not declared. Should it be static?

Fix it by setting mux_configure32() as static.

Fixes: 232a7f18cf8ec ("dmaengine: fsl-edma: add i.mx7ulp edma2 version support")
Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 drivers/dma/fsl-edma-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 6d6d8a4e8e38..264c448de409 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -90,7 +90,7 @@ static void mux_configure8(struct fsl_edma_chan *fsl_chan, void __iomem *addr,
 	iowrite8(val8, addr + off);
 }
 
-void mux_configure32(struct fsl_edma_chan *fsl_chan, void __iomem *addr,
+static void mux_configure32(struct fsl_edma_chan *fsl_chan, void __iomem *addr,
 		     u32 off, u32 slot, bool enable)
 {
 	u32 val;
-- 
2.20.1

