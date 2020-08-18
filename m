Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680D42483A9
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 13:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgHRLM5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 07:12:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35960 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726703AbgHRLMz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 18 Aug 2020 07:12:55 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1B275EBC7D1B7F763D26;
        Tue, 18 Aug 2020 19:12:53 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Tue, 18 Aug 2020 19:12:46 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>, Hyun Kwon <hyun.kwon@xilinx.com>,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
        Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH -next] dmaengine: xilinx: dpdma: Make symbol 'dpdma_debugfs_reqs' static
Date:   Tue, 18 Aug 2020 19:22:17 +0800
Message-ID: <20200818112217.43816-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The sparse tool complains as follows:

drivers/dma/xilinx/xilinx_dpdma.c:349:37: warning:
 symbol 'dpdma_debugfs_reqs' was not declared. Should it be static?

This variable is not used outside of xilinx_dpdma.c, so this commit
marks it static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 1d220435cab3 ("dmaengine: xilinx: dpdma: Add debugfs support")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/dma/xilinx/xilinx_dpdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
index 7db70d226e89..81ed1e482878 100644
--- a/drivers/dma/xilinx/xilinx_dpdma.c
+++ b/drivers/dma/xilinx/xilinx_dpdma.c
@@ -346,7 +346,7 @@ static int xilinx_dpdma_debugfs_desc_done_irq_write(char *args)
 }
 
 /* Match xilinx_dpdma_testcases vs dpdma_debugfs_reqs[] entry */
-struct xilinx_dpdma_debugfs_request dpdma_debugfs_reqs[] = {
+static struct xilinx_dpdma_debugfs_request dpdma_debugfs_reqs[] = {
 	{
 		.name = "DESCRIPTOR_DONE_INTR",
 		.tc = DPDMA_TC_INTR_DONE,

