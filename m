Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7911437245A
	for <lists+dmaengine@lfdr.de>; Tue,  4 May 2021 04:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbhEDCGx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 May 2021 22:06:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17586 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhEDCGx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 May 2021 22:06:53 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FZ36360R6z16Nn7;
        Tue,  4 May 2021 10:03:23 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Tue, 4 May 2021 10:05:50 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <vkoul@kernel.org>, <orsonzhai@gmail.com>,
        <baolin.wang7@gmail.com>, <zhang.lyra@gmail.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] dmaengine: sprd: Add missing MODULE_DEVICE_TABLE
Date:   Tue, 4 May 2021 10:22:57 +0800
Message-ID: <1620094977-70146-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch adds missing MODULE_DEVICE_TABLE definition which generates
correct modalias for automatic loading of this driver when it is built
as an external module.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/dma/sprd-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 0ef5ca8..4357d23 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -1265,6 +1265,7 @@ static const struct of_device_id sprd_dma_match[] = {
 	{ .compatible = "sprd,sc9860-dma", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, sprd_dma_match);
 
 static int __maybe_unused sprd_dma_runtime_suspend(struct device *dev)
 {
-- 
2.6.2

