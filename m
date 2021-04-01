Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF9B351EB7
	for <lists+dmaengine@lfdr.de>; Thu,  1 Apr 2021 20:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbhDASpt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 1 Apr 2021 14:45:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16321 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239363AbhDASkV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 1 Apr 2021 14:40:21 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FB1jC3k75z9vGX;
        Thu,  1 Apr 2021 19:50:55 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Thu, 1 Apr 2021 19:52:53 +0800
From:   Hao Fang <fanghao11@huawei.com>
To:     <vkoul@kernel.org>, <mchehab@kernel.org>,
        <zhangfei.gao@linaro.org>, <dmaengine@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <prime.zeng@hisilicon.com>,
        <fanghao11@huawei.com>
Subject: [PATCH v2] dmaengine: k3dma: use the correct HiSilicon copyright
Date:   Thu, 1 Apr 2021 19:50:20 +0800
Message-ID: <1617277820-26971-1-git-send-email-fanghao11@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

s/Hisilicon/HiSilicon/g.
It should use capital S, according to the official website.

Signed-off-by: Hao Fang <fanghao11@huawei.com>
---
V2:
 -remove the terms of use link.
---
 drivers/dma/k3dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index d0b2e60..ecdaada9 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2013 - 2015 Linaro Ltd.
- * Copyright (c) 2013 Hisilicon Limited.
+ * Copyright (c) 2013 HiSilicon Limited.
  */
 #include <linux/sched.h>
 #include <linux/device.h>
@@ -1039,6 +1039,6 @@ static struct platform_driver k3_pdma_driver = {
 
 module_platform_driver(k3_pdma_driver);
 
-MODULE_DESCRIPTION("Hisilicon k3 DMA Driver");
+MODULE_DESCRIPTION("HiSilicon k3 DMA Driver");
 MODULE_ALIAS("platform:k3dma");
 MODULE_LICENSE("GPL v2");
-- 
2.8.1

