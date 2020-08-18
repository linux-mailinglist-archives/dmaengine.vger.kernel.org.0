Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D3D248175
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 11:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgHRJIf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 05:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgHRJIe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 05:08:34 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A146C061389
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:08:34 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d188so9657836pfd.2
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y9TFyb5YPU9meSmmE+/B5Cy2MtU4Ivp78FeC1LNG7+4=;
        b=CkkBQIatZUceRWcF/t0p9T/hy51Fl7sYx4b7Svr20wyB5LX0Y81XNm6Tpr8WgQN2x/
         14xEI260gAvzaTfJuVT/etOB45KivGtxRraH3NAbJHpFe/RbSH6/Vns0JqzgyRFhzgsS
         cS1KSX61SkLmRJoRN4zQNX4CLoQ/3/gNV7ekLr66wRfSaXpretBZoIGy1h1cjUkxoWBU
         7oY27jL0o+RM6FY4CxPjROqqCbFmI3amH/dCNk07H/A89YNapaUbVBuW9Bkrt2HbPExl
         b/GXjY7dXplZ+lWOlEKxNdxn9TSCJqxJm3rv/76YLTQguyfDCp/0fM05X7gOZ3NgpVqv
         0lag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y9TFyb5YPU9meSmmE+/B5Cy2MtU4Ivp78FeC1LNG7+4=;
        b=ppekX+sat43nuN379ELcUeQTeSrgQVdcFeRTbPGsjkMhRppveh5aAGywZRtIH7AhrF
         W6uVXwxgNM/KuRIILe3O/SpRct9YhOBwpmLppN97lKtVXwls5aqxn8KCFYyGiCZPPhhl
         P1pPMeh6i5e+MimS+SpvG9QL/9h3hfJFP83dUJxjcXXKFF9c6kFYKI88PASmseJQaSKp
         WvFe4WScK/y+ZGxy5vqms9AQzMJurkc4bkLOTSpOZ8vQufSbQkV+LOCxAZsMo09CIKjG
         qDSzesO8zjI802hSP+CrTlVRRcwujpmN4naYwKCLZrIbDC+4jK7e4/+8d0TU1HMtW5M3
         qe2g==
X-Gm-Message-State: AOAM532rMpMRFbMeqR+XyLMXZckY+eCGn31YwQ4L8bv2Nvx4AIWjp1Qn
        tVewZpMcucdsI7kn+RmZi4A=
X-Google-Smtp-Source: ABdhPJyf++SOpjAgflml2CZzAn1c0a5I6Od0Tk3xNXRLgcm63H27ZkKZtQDIX0s76WN2+xAin9RzuQ==
X-Received: by 2002:a63:a84b:: with SMTP id i11mr12645660pgp.79.1597741713722;
        Tue, 18 Aug 2020 02:08:33 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.79])
        by smtp.gmail.com with ESMTPSA id na14sm20280788pjb.6.2020.08.18.02.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:08:33 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org, linus.walleij@linaro.org, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org
Cc:     dmaengine@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 21/35] dma: ppc4xx: convert tasklets to use new tasklet_setup() API
Date:   Tue, 18 Aug 2020 14:36:24 +0530
Message-Id: <20200818090638.26362-22-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200818090638.26362-1-allen.lkml@gmail.com>
References: <20200818090638.26362-1-allen.lkml@gmail.com>
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
 drivers/dma/ppc4xx/adma.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ppc4xx/adma.c b/drivers/dma/ppc4xx/adma.c
index 4db000d5f01c..71cdaaa8134c 100644
--- a/drivers/dma/ppc4xx/adma.c
+++ b/drivers/dma/ppc4xx/adma.c
@@ -1660,9 +1660,9 @@ static void __ppc440spe_adma_slot_cleanup(struct ppc440spe_adma_chan *chan)
 /**
  * ppc440spe_adma_tasklet - clean up watch-dog initiator
  */
-static void ppc440spe_adma_tasklet(unsigned long data)
+static void ppc440spe_adma_tasklet(struct tasklet_struct *t)
 {
-	struct ppc440spe_adma_chan *chan = (struct ppc440spe_adma_chan *) data;
+	struct ppc440spe_adma_chan *chan = from_tasklet(chan, t, irq_tasklet);
 
 	spin_lock_nested(&chan->lock, SINGLE_DEPTH_NESTING);
 	__ppc440spe_adma_slot_cleanup(chan);
@@ -4141,8 +4141,7 @@ static int ppc440spe_adma_probe(struct platform_device *ofdev)
 	chan->common.device = &adev->common;
 	dma_cookie_init(&chan->common);
 	list_add_tail(&chan->common.device_node, &adev->common.channels);
-	tasklet_init(&chan->irq_tasklet, ppc440spe_adma_tasklet,
-		     (unsigned long)chan);
+	tasklet_setup(&chan->irq_tasklet, ppc440spe_adma_tasklet);
 
 	/* allocate and map helper pages for async validation or
 	 * async_mult/async_sum_product operations on DMA0/1.
-- 
2.17.1

