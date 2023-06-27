Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8997274018D
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jun 2023 18:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjF0Qna (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Jun 2023 12:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjF0Qn3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 27 Jun 2023 12:43:29 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F0B109;
        Tue, 27 Jun 2023 09:43:29 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6686a05bc66so3016317b3a.1;
        Tue, 27 Jun 2023 09:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687884208; x=1690476208;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qy8/BA41lOJ9tHciVEFoPKVGOra2xL33Ff1AOugAL5g=;
        b=FwCVNSPx8LXb6QTh7PdSqwrtSvAIf/zDW4EARi28pobQc75y5eN8Z2hpzA14/sX/k4
         sP1RLiYE0RZL/qd4NtLiC///7VDecwKeu7J3hyW0X6zsCgkx5nd0Tt6Rp82j7uNFvXcj
         XEwNwxjKLmYgCJg441CQSefrlqxkjYdO3j2nG1aX4vps+Qhw2Veho45XIKEOY0fap8PR
         3lykX7x3kIQmyuDUm8gu3kt1zdFjl+y/Nv72Cv9eXS9QJ9Jp5hDYpa7lshd7S3exgus0
         pPXWmaDnsdtCbxW7a5UM3bt6lzkbwyLASqBXQ4OIO0FV11ChvuhnuOs0gUDYHBInN2xq
         DbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687884208; x=1690476208;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qy8/BA41lOJ9tHciVEFoPKVGOra2xL33Ff1AOugAL5g=;
        b=HXteeD3HV+Hv9zlUCnKR4m/3W7tJkJLH0oXyqW4ueoeflCfPTqbGFnA5JHDUAAZ4wj
         0aOQ3gQMKAX490O4OB73u9xGi5Hxa9kS6hWJCKWJ43vAmKNvpL7zVLcTUr8MhZqA6Gb2
         Am+DWWGNCLdFAxHCH+lr+P5Ynz2oBaQB3XTVmC6Qqnol8tr5j7AsORuiRmzBZ/aFStx5
         7jGWabVYhempDTM3kYF9+AiINBmlLID3wpyH+lWU/B7YEvgIR9uDQR7a1QdIZTiDYNCQ
         RoGuqe7vKpNv6Tj3x3mka+P94slZUQ1BKv3Gh1FwYDfwZhhSjasf9cgSayix0ISDVgSG
         N1Gw==
X-Gm-Message-State: AC+VfDypZXQbhL14rV3n5PH4BPpk594shU3VAoThsdbwgNgCJ/wFxAEg
        4mRx5Dod7VcTW65a2MX97rChGM9YsELEHg==
X-Google-Smtp-Source: ACHHUZ5nR3SzvcwXIaA2STdJUbtdQU1KzmmjZQuZPBMKm/Wdu30ozJAOtD5F3e9gZWX4UsiH2KBDoA==
X-Received: by 2002:a05:6a20:7f82:b0:11a:efaa:eb43 with SMTP id d2-20020a056a207f8200b0011aefaaeb43mr33140157pzj.3.1687884208460;
        Tue, 27 Jun 2023 09:43:28 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id u5-20020aa78485000000b00671eb039b23sm4410638pfn.58.2023.06.27.09.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 09:43:27 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     sean.wang@mediatek.com, vkoul@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] dmaengine: mediatek: mtk-hsdma: fix potential deadlock on &vc->lock
Date:   Tue, 27 Jun 2023 16:43:09 +0000
Message-Id: <20230627164309.59922-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

As &vc->lock is acquired by the irq mtk_hsdma_irq(), other process
context code acquiring the lock should disable irq. The terminate
callback mtk_hsdma_terminate_all() acquires the same lock without
closing irq.

Possible deadlock scenario:
mtk_hsdma_free_active_desc()
    -> spin_lock(&hvc->vc.lock)
        <irq interrupt>
        -> mtk_hsdma_irq()
        -> mtk_hsdma_free_rooms_in_ring()
        -> spin_lock(&hvc->vc.lock)  (deadlock here)

This flaw was found using an experimental static analysis tool we are
developing for irq-related deadlock.

The tentative patch fix the potential deadlock by spin_lock_irqsave().

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/dma/mediatek/mtk-hsdma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/mediatek/mtk-hsdma.c b/drivers/dma/mediatek/mtk-hsdma.c
index 69cc61c0b262..6b6773575893 100644
--- a/drivers/dma/mediatek/mtk-hsdma.c
+++ b/drivers/dma/mediatek/mtk-hsdma.c
@@ -757,18 +757,19 @@ static void mtk_hsdma_free_active_desc(struct dma_chan *c)
 {
 	struct mtk_hsdma_vchan *hvc = to_hsdma_vchan(c);
 	bool sync_needed = false;
+	unsigned long flags;
 
 	/*
 	 * Once issue_synchronize is being set, which means once the hardware
 	 * consumes all descriptors for the channel in the ring, the
 	 * synchronization must be notified immediately it is completed.
 	 */
-	spin_lock(&hvc->vc.lock);
+	spin_lock_irqsave(&hvc->vc.lock, flags);
 	if (!list_empty(&hvc->desc_hw_processing)) {
 		hvc->issue_synchronize = true;
 		sync_needed = true;
 	}
-	spin_unlock(&hvc->vc.lock);
+	spin_unlock_irqrestore(&hvc->vc.lock, flags);
 
 	if (sync_needed)
 		wait_for_completion(&hvc->issue_completion);
-- 
2.17.1

