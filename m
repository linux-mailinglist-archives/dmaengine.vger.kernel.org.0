Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3092A37B5FD
	for <lists+dmaengine@lfdr.de>; Wed, 12 May 2021 08:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhELGXb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 May 2021 02:23:31 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2567 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhELGXa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 May 2021 02:23:30 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fg4Q434XlzwSZx;
        Wed, 12 May 2021 14:19:40 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 14:22:13 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <krzysztof.kozlowski@canonical.com>, <vkoul@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] dmaengine: s3c24xx: add missing MODULE_DEVICE_TABLE
Date:   Wed, 12 May 2021 14:39:15 +0800
Message-ID: <1620801555-18805-1-git-send-email-zou_wei@huawei.com>
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
 drivers/dma/s3c24xx-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/s3c24xx-dma.c b/drivers/dma/s3c24xx-dma.c
index 8e14c72..f1ebaa6 100644
--- a/drivers/dma/s3c24xx-dma.c
+++ b/drivers/dma/s3c24xx-dma.c
@@ -1175,6 +1175,7 @@ static const struct platform_device_id s3c24xx_dma_driver_ids[] = {
 	},
 	{ },
 };
+MODULE_DEVICE_TABLE(platform, s3c24xx_dma_driver_ids);
 
 static struct soc_data *s3c24xx_dma_get_soc_data(struct platform_device *pdev)
 {
-- 
2.6.2

