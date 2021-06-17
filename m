Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C643AB4D9
	for <lists+dmaengine@lfdr.de>; Thu, 17 Jun 2021 15:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbhFQNhC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Jun 2021 09:37:02 -0400
Received: from m12-15.163.com ([220.181.12.15]:39069 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231355AbhFQNhB (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 17 Jun 2021 09:37:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=yvhTj
        szTo8tQ9r8I8hyR5rQ1GLc/Yb4fdHEDaHDNtsI=; b=iDLkQfZIEndzvU8CZWiRM
        C3yefEKCEbeVs3sB1d1sOSRlml12CCGExYw+PWpN+18i3YhKnUfo+sHjRh3tDGJi
        LrBZ5HYYAB5xPcw+jpx9+1qGihk+o3cbzo4eKDKoot3ozk/pQUOSQ92725ePMqZN
        l8uYe0Qi03p/PJBSJF58JY=
Received: from yangjunlin.ccdomain.com (unknown [218.17.89.92])
        by smtp11 (Coremail) with SMTP id D8CowADHz3ciT8tgUvmYAA--.257S2;
        Thu, 17 Jun 2021 21:34:36 +0800 (CST)
From:   angkery <angkery@163.com>
To:     sean.wang@mediatek.com, vkoul@kernel.org, matthias.bgg@gmail.com
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Junlin Yang <yangjunlin@yulong.com>
Subject: [PATCH] dmaengine: mediatek: Return the correct errno code
Date:   Thu, 17 Jun 2021 21:32:29 +0800
Message-Id: <20210617133229.1497-1-angkery@163.com>
X-Mailer: git-send-email 2.24.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowADHz3ciT8tgUvmYAA--.257S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF1DJw45ZFyDGFyxGrWfKrg_yoW3Wwb_u3
        4v9rWxWF1DAwn3Ar1rWr1Uury7tFZ5uF1fWF43Kr1avrW5ur4DCryq9rnIvw43Xwn2vF97
        WF1UZrnakFsxGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5PuctUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5dqjyvlu16il2tof0z/1tbiLAy0I1spa1-21wAAsQ
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Junlin Yang <yangjunlin@yulong.com>

When devm_kzalloc failed, should return ENOMEM rather than ENODEV.

Signed-off-by: Junlin Yang <yangjunlin@yulong.com>
---
 drivers/dma/mediatek/mtk-uart-apdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/mediatek/mtk-uart-apdma.c b/drivers/dma/mediatek/mtk-uart-apdma.c
index 375e7e6..a4cb30f 100644
--- a/drivers/dma/mediatek/mtk-uart-apdma.c
+++ b/drivers/dma/mediatek/mtk-uart-apdma.c
@@ -529,7 +529,7 @@ static int mtk_uart_apdma_probe(struct platform_device *pdev)
 	for (i = 0; i < mtkd->dma_requests; i++) {
 		c = devm_kzalloc(mtkd->ddev.dev, sizeof(*c), GFP_KERNEL);
 		if (!c) {
-			rc = -ENODEV;
+			rc = -ENOMEM;
 			goto err_no_dma;
 		}
 
-- 
1.9.1

