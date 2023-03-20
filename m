Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BE16C2618
	for <lists+dmaengine@lfdr.de>; Tue, 21 Mar 2023 00:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjCTXv3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Mar 2023 19:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjCTXv1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Mar 2023 19:51:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16E0F77D
        for <dmaengine@vger.kernel.org>; Mon, 20 Mar 2023 16:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679356151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dzrLAVGbWNN8AGVBKViLJqvzv9bGR8wwpK1Vk6d6ayk=;
        b=W5nUphSrmSpX4C5HPinO6Az48i4dAcM5vArQbEBWzIM+z+cy6ee1l1/1YUj1u667H+XM1t
        qeWtIvqC/EoWVCzUJnCuoflWNddNt6xVFHy+TR3tHH6EAYW6DAyWpw6aJCjzeoU2OhwfT2
        qPYxWFTOfIv47ZUFr9H2ROjVZfja1MI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-8n76NqRsN2e3IBuD8VM-VQ-1; Mon, 20 Mar 2023 19:49:10 -0400
X-MC-Unique: 8n76NqRsN2e3IBuD8VM-VQ-1
Received: by mail-qv1-f69.google.com with SMTP id e11-20020ad4536b000000b005a9292e8c2bso6931045qvv.1
        for <dmaengine@vger.kernel.org>; Mon, 20 Mar 2023 16:49:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679356150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dzrLAVGbWNN8AGVBKViLJqvzv9bGR8wwpK1Vk6d6ayk=;
        b=qRBRK5axa6gH5W/quWlBNhwTd4KvWYhSMncbAqVHB0py9fjVSbxN98upNsw7Og3/gU
         SDs1XDP90BaxNlf+3ygQV4W0RI98aMbJJROZ5DqtzFq3jThZf1mZAJu8xt40O+bD64TV
         dbeYCw8dwFVEXg6gQneEEDtD1WmDnIanSqzzRhhoI2lovK+QBHLAfvLkCY77K6FBiT6s
         R//la4lHdTRyaVIjaHuXsvWHkMzBbhswQFGUg4Onr800nBi+ZzWZfMPYLR/pRciT7Ig5
         gfzB4oyXfsDtR6BCKXMXTEOdatXJh3GCpUFOt+yILRF+GdnJycgel9nt4FE+44SchpRs
         52TQ==
X-Gm-Message-State: AO0yUKWVFDptsLs1sbjFDCMJI2C/5wzyzwkcmeeQinhNp+fnICoiBuW9
        Ula/wRrOeWVda6iXt4iHA2kw8ehqRELHJtUwZLwM97e7iu89JgYx8qVywQoDAeyZjKY+Kdci8Qo
        rQtC2xJJPxBM5cbRaf67R
X-Received: by 2002:a05:6214:20c1:b0:5c7:d03c:f2b2 with SMTP id 1-20020a05621420c100b005c7d03cf2b2mr1237652qve.28.1679356149797;
        Mon, 20 Mar 2023 16:49:09 -0700 (PDT)
X-Google-Smtp-Source: AK7set+HWnOT0a3RXFRf6pXRq8qqZoMF+FEMmcYh3Ut0IOG4Mn7s6l8sswr2ELFJPesX7ToFbhnqcA==
X-Received: by 2002:a05:6214:20c1:b0:5c7:d03c:f2b2 with SMTP id 1-20020a05621420c100b005c7d03cf2b2mr1237632qve.28.1679356149549;
        Mon, 20 Mar 2023 16:49:09 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id g2-20020a37b602000000b0071aacb2c76asm8104474qkf.132.2023.03.20.16.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 16:49:09 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     gustavo.pimentel@synopsys.com, vkoul@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] dmaengine: dw-edma: remove unused readq_ch and writeq_ch functions
Date:   Mon, 20 Mar 2023 19:49:06 -0400
Message-Id: <20230320234906.1730308-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

clang with W=1 reports
drivers/dma/dw-edma/dw-edma-v0-core.c:162:20: error:
  unused function 'writeq_ch' [-Werror,-Wunused-function]
static inline void writeq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
                   ^
drivers/dma/dw-edma/dw-edma-v0-core.c:185:19: error:
  unused function 'readq_ch' [-Werror,-Wunused-function]
static inline u64 readq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
                  ^
These functions and their wrapping macros are not used, so remove them.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 56 ---------------------------
 1 file changed, 56 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 72e79a0c0a4e..32f834a3848a 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -159,62 +159,6 @@ static inline u32 readl_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 #define GET_CH_32(dw, dir, ch, name) \
 	readl_ch(dw, dir, ch, &(__dw_ch_regs(dw, dir, ch)->name))
 
-static inline void writeq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
-			     u64 value, void __iomem *addr)
-{
-	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY) {
-		u32 viewport_sel;
-		unsigned long flags;
-
-		raw_spin_lock_irqsave(&dw->lock, flags);
-
-		viewport_sel = FIELD_PREP(EDMA_V0_VIEWPORT_MASK, ch);
-		if (dir == EDMA_DIR_READ)
-			viewport_sel |= BIT(31);
-
-		writel(viewport_sel,
-		       &(__dw_regs(dw)->type.legacy.viewport_sel));
-		writeq(value, addr);
-
-		raw_spin_unlock_irqrestore(&dw->lock, flags);
-	} else {
-		writeq(value, addr);
-	}
-}
-
-static inline u64 readq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
-			   const void __iomem *addr)
-{
-	u64 value;
-
-	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY) {
-		u32 viewport_sel;
-		unsigned long flags;
-
-		raw_spin_lock_irqsave(&dw->lock, flags);
-
-		viewport_sel = FIELD_PREP(EDMA_V0_VIEWPORT_MASK, ch);
-		if (dir == EDMA_DIR_READ)
-			viewport_sel |= BIT(31);
-
-		writel(viewport_sel,
-		       &(__dw_regs(dw)->type.legacy.viewport_sel));
-		value = readq(addr);
-
-		raw_spin_unlock_irqrestore(&dw->lock, flags);
-	} else {
-		value = readq(addr);
-	}
-
-	return value;
-}
-
-#define SET_CH_64(dw, dir, ch, name, value) \
-	writeq_ch(dw, dir, ch, value, &(__dw_ch_regs(dw, dir, ch)->name))
-
-#define GET_CH_64(dw, dir, ch, name) \
-	readq_ch(dw, dir, ch, &(__dw_ch_regs(dw, dir, ch)->name))
-
 /* eDMA management callbacks */
 void dw_edma_v0_core_off(struct dw_edma *dw)
 {
-- 
2.27.0

