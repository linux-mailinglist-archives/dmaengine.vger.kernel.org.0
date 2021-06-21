Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4A03AE340
	for <lists+dmaengine@lfdr.de>; Mon, 21 Jun 2021 08:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbhFUGdT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Jun 2021 02:33:19 -0400
Received: from m12-17.163.com ([220.181.12.17]:49664 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229641AbhFUGdT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 21 Jun 2021 02:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=u6hdI
        srs/V2lafii/maxw5n7uLgulGr69u1vMtVbjTg=; b=Bn9hr3KKSw9migEdJLagL
        DCoyTSpINFl5H6Y4cRzHxe4TQGXDepwx2emDbT8u1R9HR8WwdRV3m5eykp3IzRP1
        oJ1lFtv62NsJuuX1uHrXJTLB0UEwQb6SXfV9mh1b4kT0QRt0/A+FcKk0dBttFOW0
        FAIrWyAd07uLG0iGNlsqqg=
Received: from yangjunlin.ccdomain.com (unknown [218.17.89.92])
        by smtp13 (Coremail) with SMTP id EcCowACXbGQBMtBgMeQF8w--.52581S2;
        Mon, 21 Jun 2021 14:30:26 +0800 (CST)
From:   angkery <angkery@163.com>
To:     sean.wang@mediatek.com, vkoul@kernel.org, matthias.bgg@gmail.com,
        long.cheng@mediatek.com
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Junlin Yang <yangjunlin@yulong.com>
Subject: [PATCH v1] dmaengine: mediatek: Return the correct errno code
Date:   Mon, 21 Jun 2021 14:20:48 +0800
Message-Id: <20210621062048.1935-1-angkery@163.com>
X-Mailer: git-send-email 2.24.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowACXbGQBMtBgMeQF8w--.52581S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF1kXryxXFyxJr1kGFW5Awb_yoWfWrc_ua
        yvvrZ7WF1DAwnayr1rGr1UuryayFWkuF1fWF45Kr13ZrW5CrsrCrWq9r9avw43X3Z2vFn7
        GF1UZrn3uFsxCjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeveHDUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5dqjyvlu16il2tof0z/xtbBFAK4I1aD-8Sw1QAAsG
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Junlin Yang <yangjunlin@yulong.com>

When devm_kzalloc failed, should return ENOMEM rather than ENODEV.

Fixes: 9135408c3ace ("dmaengine: mediatek: Add MediaTek UART APDMA support")
Signed-off-by: Junlin Yang <yangjunlin@yulong.com>
---
Changes in v1:
Add fixes tags.

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


