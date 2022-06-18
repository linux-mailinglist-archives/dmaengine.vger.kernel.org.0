Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17D55504EF
	for <lists+dmaengine@lfdr.de>; Sat, 18 Jun 2022 15:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbiFRNBs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 18 Jun 2022 09:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbiFRNBr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 18 Jun 2022 09:01:47 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A636D1A04F;
        Sat, 18 Jun 2022 06:01:41 -0700 (PDT)
X-QQ-mid: bizesmtp90t1655557292terbxivu
Received: from localhost.localdomain ( [125.70.163.206])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 18 Jun 2022 21:01:27 +0800 (CST)
X-QQ-SSF: 01000000002000D0I000B00A0000000
X-QQ-FEAT: hAQ2xUxVESxJFg0WB9u41LXUwqDfZn4GaCTsfAn4T20imGjVopH5O7LZcG2lH
        nj3VQsAkX8YI6WJm6qWWUnXouOAsWJI88i9rmIdFy6SD8V0r3UDlxwgXI71nHAnfErpgte9
        /TyOSxv+tOPKA3qw280CrncSF/dvl6JzYL+inSCk1rRNRdtag0n98wPkcUQ91FsM1D4ma7d
        bPrH7xQ8Auz0QFh/Od7tqXS1VoQ+pnlf60XzopBAYm13ZvuJiSu6dQ8/k7VY39d/+XaHQJC
        KquW7J70+KIsdlNd6a54cAmiJAf+/WzaA8Z2mCXsMC37lvUdq70WNAKFg=
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     sean.wang@mediatek.com
Cc:     vkoul@kernel.org, matthias.bgg@gmail.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] dmaengine: mediatek: mtk-hsdma: Fix typo in comment
Date:   Sat, 18 Jun 2022 21:01:20 +0800
Message-Id: <20220618130120.9783-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Delete the redundant word 'be'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 drivers/dma/mediatek/mtk-hsdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/mediatek/mtk-hsdma.c b/drivers/dma/mediatek/mtk-hsdma.c
index 9ebd9231f62f..a72e5a096c5c 100644
--- a/drivers/dma/mediatek/mtk-hsdma.c
+++ b/drivers/dma/mediatek/mtk-hsdma.c
@@ -761,7 +761,7 @@ static void mtk_hsdma_free_active_desc(struct dma_chan *c)
 	/*
 	 * Once issue_synchronize is being set, which means once the hardware
 	 * consumes all descriptors for the channel in the ring, the
-	 * synchronization must be be notified immediately it is completed.
+	 * synchronization must be notified immediately it is completed.
 	 */
 	spin_lock(&hvc->vc.lock);
 	if (!list_empty(&hvc->desc_hw_processing)) {
-- 
2.36.1

