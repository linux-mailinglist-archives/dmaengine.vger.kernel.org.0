Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD74157C3DB
	for <lists+dmaengine@lfdr.de>; Thu, 21 Jul 2022 07:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiGUF5M (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Jul 2022 01:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiGUF5M (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Jul 2022 01:57:12 -0400
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2700377A51;
        Wed, 20 Jul 2022 22:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=mvqUe
        v+LB1UXQZD1396CqidyMB4qHv2xJiLBDXujia0=; b=G/qj66sUfiy82sPKmLmpI
        28DFFtuyQjTcPWYdvEVkIEJpLPtNwDl/IpVLWCEqsJN0SiIF/XKlqVK93SgSYDMV
        /GsD4s5/mr2QVpbiQYvBMVtoc8vZ0nGlHg9apKS3VK/8LhFfMc8dhQqKaD46Te65
        eFdWhOUFPwnKwt2kWG8bPM=
Received: from localhost.localdomain (unknown [112.97.57.47])
        by smtp3 (Coremail) with SMTP id G9xpCgBnQIqh6thi2SSvQQ--.1748S2;
        Thu, 21 Jul 2022 13:56:52 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     sean.wang@mediatek.com, vkoul@kernel.org, matthias.bgg@gmail.com
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] dmaengine: mediatek: mtk-hsdma: Fix typo 'the the' in comment
Date:   Thu, 21 Jul 2022 13:56:47 +0800
Message-Id: <20220721055647.46085-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgBnQIqh6thi2SSvQQ--.1748S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWUWr1rCr4rCr4ftr4ruFg_yoW3XFg_Wa
        1vqr4xW3WDtFsYyr10kF1Ykry8ta1kur1SqF1ftrWaq34rZF43Zr4vvFZ3GFs8XrZFva47
        AF90q3W8CFsxujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRGNt3UUUUUU==
X-Originating-IP: [112.97.57.47]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiGQRFZFyPdl2hegAAsf
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/dma/mediatek/mtk-hsdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/mediatek/mtk-hsdma.c b/drivers/dma/mediatek/mtk-hsdma.c
index a72e5a096c5c..f7717c44b887 100644
--- a/drivers/dma/mediatek/mtk-hsdma.c
+++ b/drivers/dma/mediatek/mtk-hsdma.c
@@ -138,7 +138,7 @@ struct mtk_hsdma_vdesc {
 
 /**
  * struct mtk_hsdma_cb - This is the struct holding extra info required for RX
- *			 ring to know what relevant VD the the PD is being
+ *			 ring to know what relevant VD the PD is being
  *			 mapped to.
  * @vd:			 Pointer to the relevant VD.
  * @flag:		 Flag indicating what action should be taken when VD
-- 
2.25.1

