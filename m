Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E8C537229
	for <lists+dmaengine@lfdr.de>; Sun, 29 May 2022 20:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiE2SXL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 29 May 2022 14:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiE2SXK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 29 May 2022 14:23:10 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6B587A1B;
        Sun, 29 May 2022 11:23:09 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id y13so17173343eje.2;
        Sun, 29 May 2022 11:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition;
        bh=UrB6JZivFqE5OCWeNQt/i/4T12gkvv9wdeSvo/EtH7o=;
        b=fTWVqF/+400H+4XSXZFH4QSsVwcU21XPB5zGmKB/Zhd75m9njKnRpQdrSRG0bZ04h2
         GHwaG48I8vqzLWNIkK+YmrXAZQwHIm57y+7r8CSGhdrhQL4fYC3xLXxHKIQ0fFqsfk4v
         mmHY49JgVWaDqxI03gVoc/geL3K+uruDklX46wkbTXtSZh6ZCpG70Bw8UXOHdZlRK7e1
         4weqysRT9/HDJpi94f0jRCohkHF0kU/PTxa8pwhsTKsJVF1NcbDce1PsJEvn3LtjzGzr
         gUQhUZMifbYhufou3qrlDecmAF+cOQWq5pA0wSw2w6yNEvqSbAcp4TxIuVjGOTmSBSap
         JJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mime-version:content-disposition;
        bh=UrB6JZivFqE5OCWeNQt/i/4T12gkvv9wdeSvo/EtH7o=;
        b=5eyxttauxl/wsGJs/gscqnx10YP0ypn9CjR+/wDqvrZ9XMwvTg/+C96Y/lijL9mfL+
         JqhIpFTEMG7Az3RBT8o15MIP1gBvYy/lm9qyUG+appzueQMhaHdW4n7rU18RziZxGqk4
         qLNfqx3hkny11FoY7eF/j0/BRtJ2m2QxIOLjkeRCIIjC4NM6bYPc77k5jSsx+YEQIl9W
         Uoxm7+PyZMsCFO264rxzD+fwao2yXftV3gK906cNig6dTMZYtE1KpUy3T09HCdbc2Tsr
         91SVVNQhH6MUrx4Z0NXBJ2Znc+ckVr8eO/rIz+8/Hk8gyTVfLg3PM23Jh8U6FY+p/kzW
         LQbg==
X-Gm-Message-State: AOAM5312dPfmWra3W8FwPIYhlM0J6g8EV56rGYOboByuo/53E/nb9Jpk
        ENBaqiABgJV2hDXxtF4WsA97Ma6lJ+o=
X-Google-Smtp-Source: ABdhPJyNLnaJpg//7cB2Is+8TQU3+GcS4ChmwkKKuYNb9290clnRIRZCn31NdKWKqcAyQ/FJwWo/sw==
X-Received: by 2002:a17:907:d86:b0:6ff:1557:a080 with SMTP id go6-20020a1709070d8600b006ff1557a080mr18997528ejc.678.1653848587589;
        Sun, 29 May 2022 11:23:07 -0700 (PDT)
Received: from nam-dell ([2a02:8109:afbf:ed88:435:610d:d1eb:dc05])
        by smtp.gmail.com with ESMTPSA id a9-20020a170906190900b006fec3b388edsm3325759eje.95.2022.05.29.11.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 11:23:07 -0700 (PDT)
Date:   Sun, 29 May 2022 20:23:06 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     vkoul@kernel.org, sr@denx.de
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] dmaengine: altera-msgdma: correct mutex locking order
Message-ID: <20220529182306.GA26782@nam-dell>
Reply-To: 20220529172554.GA22554@nam-dell
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The order of spin_unlock and spin_lock seems wrong. Correct it.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
Changes in v2:
	- Get rid of dirty index problem due to the patch being manually editted.

 drivers/dma/altera-msgdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
index 6f56dfd375e3..e35096c12abc 100644
--- a/drivers/dma/altera-msgdma.c
+++ b/drivers/dma/altera-msgdma.c
@@ -591,9 +591,9 @@ static void msgdma_chan_desc_cleanup(struct msgdma_device *mdev)
 
 		dmaengine_desc_get_callback(&desc->async_tx, &cb);
 		if (dmaengine_desc_callback_valid(&cb)) {
-			spin_unlock(&mdev->lock);
-			dmaengine_desc_callback_invoke(&cb, NULL);
 			spin_lock(&mdev->lock);
+			dmaengine_desc_callback_invoke(&cb, NULL);
+			spin_unlock(&mdev->lock);
 		}
 
 		/* Run any dependencies, then free the descriptor */
-- 
2.25.1

