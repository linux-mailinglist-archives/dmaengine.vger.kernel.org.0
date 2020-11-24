Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201752C1A85
	for <lists+dmaengine@lfdr.de>; Tue, 24 Nov 2020 02:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgKXBE5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Nov 2020 20:04:57 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:8389 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgKXBE5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 23 Nov 2020 20:04:57 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Cg5QW44hBz72r0;
        Tue, 24 Nov 2020 09:04:35 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Tue, 24 Nov 2020
 09:04:46 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <vkoul@kernel.org>, <thomas.petazzoni@free-electrons.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH] dmaengine: mv_xor_v2: Fix error return code in mv_xor_v2_probe()
Date:   Tue, 24 Nov 2020 09:08:13 +0800
Message-ID: <20201124010813.1939095-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Return the corresponding error code when first_msi_entry() returns
NULL in mv_xor_v2_probe().

Fixes: 19a340b1a820430 ("dmaengine: mv_xor_v2: new driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 drivers/dma/mv_xor_v2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
index 2753a6b916f6..9b0d463f89bb 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -771,8 +771,10 @@ static int mv_xor_v2_probe(struct platform_device *pdev)
 		goto disable_clk;
 
 	msi_desc = first_msi_entry(&pdev->dev);
-	if (!msi_desc)
+	if (!msi_desc) {
+		ret = -ENODEV;
 		goto free_msi_irqs;
+	}
 	xor_dev->msi_desc = msi_desc;
 
 	ret = devm_request_irq(&pdev->dev, msi_desc->irq,
-- 
2.25.4

