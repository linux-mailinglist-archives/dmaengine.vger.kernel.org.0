Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A73257760
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 12:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgHaKgg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 06:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgHaKgf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 06:36:35 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC720C061573
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:36:34 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 5so380082pgl.4
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4UF96c6tilIEXEsA4F4M1+JIF6S4A/ycLHEkv4/aigc=;
        b=aw8mLuLWoSHXQs21woSjLv4K91w5Rx0SUJaqI8CuQQe19KnUsu1TGOMQLOwm+pXQ3j
         Fl1Z3Er+cmXBero6k3I2hLv6fM9PipW5iPp4mMcE4wSm6AvzRCRRMhvNsnEMPn+4SdBA
         ndLli2ogyLcBoFBIr9aNZkwgZxRTjcu0cB3wFQmTwbxwpV2b32QvCTb18jD0xBieaWbx
         whWevUR4E2m4txLtaPWVmk+Gg9NRwnobsEFzLHX/rUFgMj65f9GNBsSpIkRJMw15KrGc
         Kqr1CRyjDIjXxw9LWDlGAWGtiUQShNsjJlr4Tjn/K0DiVDzRtFwMTemmlEvFZ3GuLqhY
         gI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4UF96c6tilIEXEsA4F4M1+JIF6S4A/ycLHEkv4/aigc=;
        b=ShWxiAMRzDz4Xf9fPQ+mmskckvtvfeZe7OESOQmvpy+kZSJ+DPT9K2ayspwHX/Evq5
         BKsUveeY4IrMV+ryUE6UekqwwSduBBulCxPgBRSuSimSjKG2AtqXuvVtbX6I54Anughn
         KIbs5gENS8fhADaAFYejJkkrFhnDGj1E5U5fbXHXXpg6lbBwCtphwjRaxWhrulD8+X/w
         MCUEOUt6vDDEhQzN6ldXxfgn1fZYUlSQWzbKXNp2Iz1oihP4HsNgHcN5g89winWapg63
         jCn6Bbyobamw+WvHlQ9VB0w73ZxsnSphm41bXXddM0fIlab8r/1E3OQVCLZN67u2DCax
         I0ug==
X-Gm-Message-State: AOAM530WjR8pkJO/uvY1M7rHA2ONgB6f8OXZdrcWHfyT9FWlWZSI3ufU
        /WIiUxkNXhEkauuYvynX+wXrArFfi+D20g==
X-Google-Smtp-Source: ABdhPJyl+6Jtj2LXnHqNeCZzStqufMzktJWY0UqLMUZaedf6qY7ZXwemZWLoVeGgFV2Skgfrs15lKg==
X-Received: by 2002:a65:66c6:: with SMTP id c6mr769819pgw.206.1598870194543;
        Mon, 31 Aug 2020 03:36:34 -0700 (PDT)
Received: from localhost.localdomain ([49.207.204.90])
        by smtp.gmail.com with ESMTPSA id x6sm6895449pge.61.2020.08.31.03.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 03:36:34 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org
Cc:     linus.walleij@linaro.org, vireshk@kernel.org, leoyang.li@nxp.com,
        zw@zh-kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        sean.wang@mediatek.com, matthias.bgg@gmail.com,
        logang@deltatee.com, agross@kernel.org, jorn.andersson@linaro.org,
        green.wan@sifive.com, baohua@kernel.org, mripard@kernel.org,
        wens@csie.org, dmaengine@vger.kernel.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH v3 06/35] dmaengine: ep93xx: convert tasklets to use new tasklet_setup() API
Date:   Mon, 31 Aug 2020 16:05:13 +0530
Message-Id: <20200831103542.305571-7-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831103542.305571-1-allen.lkml@gmail.com>
References: <20200831103542.305571-1-allen.lkml@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/dma/ep93xx_dma.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
index 87a246012629..01027779beb8 100644
--- a/drivers/dma/ep93xx_dma.c
+++ b/drivers/dma/ep93xx_dma.c
@@ -745,9 +745,9 @@ static void ep93xx_dma_advance_work(struct ep93xx_dma_chan *edmac)
 	spin_unlock_irqrestore(&edmac->lock, flags);
 }
 
-static void ep93xx_dma_tasklet(unsigned long data)
+static void ep93xx_dma_tasklet(struct tasklet_struct *t)
 {
-	struct ep93xx_dma_chan *edmac = (struct ep93xx_dma_chan *)data;
+	struct ep93xx_dma_chan *edmac = from_tasklet(edmac, t, tasklet);
 	struct ep93xx_dma_desc *desc, *d;
 	struct dmaengine_desc_callback cb;
 	LIST_HEAD(list);
@@ -1353,8 +1353,7 @@ static int __init ep93xx_dma_probe(struct platform_device *pdev)
 		INIT_LIST_HEAD(&edmac->active);
 		INIT_LIST_HEAD(&edmac->queue);
 		INIT_LIST_HEAD(&edmac->free_list);
-		tasklet_init(&edmac->tasklet, ep93xx_dma_tasklet,
-			     (unsigned long)edmac);
+		tasklet_setup(&edmac->tasklet, ep93xx_dma_tasklet);
 
 		list_add_tail(&edmac->chan.device_node,
 			      &dma_dev->channels);
-- 
2.25.1

