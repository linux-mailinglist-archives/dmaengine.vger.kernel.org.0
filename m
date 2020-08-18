Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B303124818A
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 11:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgHRJJk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 05:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbgHRJJj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 05:09:39 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD3CC061389
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:09:39 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id q19so8941633pll.0
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8m7i7NFD9jtK5LLWJqp7H8mCeAZp9HPWo5wwi/RHp1g=;
        b=IWvaFW5t/tQ5Ec0pHpah8O0iYlnKY0i/HYB3DSErpmpGV8923bgaEW3Radly/M1qoO
         X7v3ipu+ArviukMrtP1cAKC9fdTo7iDIFvrnLagdzl3rGnzQ89pUEQNlJdMZ5xuErGjM
         +MitwlobH48u5YHv0040XDrMRBAr8td5d8McaxNr/tu1iymC3j7By88SubklbkD5cm9z
         c/BD0t4CZ+Wu190SoOJoHDf3sJs6nQotWx7Mxa8zYt5jhNxWT94xR5Rq3WsZ83QwjyAd
         lXnXGxFschOZ8ZjSZBY98iKe3zS43D1gjo5vL2BIPP5phIBj6HLNgNAirnSz+jnJLLVr
         ti6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8m7i7NFD9jtK5LLWJqp7H8mCeAZp9HPWo5wwi/RHp1g=;
        b=DWiwF3OEo4qC8I1bFx09VkSMBu6FAO4blbrDGYkM2P+g+Ua+QFPorJ39OO7qhrHHPG
         ZakCaNYj+rMqI0kaDcLh0a8BpXb5Vzmd1pvYQyMlzwGvJZK6VT0gNBrLfl0cpuipW98m
         eH++aYO/BNz+MZ4s596ee/YU7MScYfAoXhD9l/AzgM8P0bDnNDtZ1WI9emagSWbXxMTm
         +RhL368rmHOevKjid2gjB5VZghp2/26H8KIJSbTVGphj46Xahr8ro/EFuVUbIq+2wDdZ
         pXSEf5SiSgAJoOYWI/L3RN9VWeUMJO7ouvWLI/NiThbcriUeBCLozBnPy99I06Jqnh+S
         XOzg==
X-Gm-Message-State: AOAM532J3gKQs62g00v+SIpgvAml9m7MBfyng331DS4TvFaxnIJi8Guc
        cjt1IsoC4nrjEVrRY547Qk0=
X-Google-Smtp-Source: ABdhPJxRrNfmJ8kSm2ku0uvnjS7+sdjQ1fHE9r73/o9470S1jcm8/mVU+CuUW6bsUwppEkkAz5ro6w==
X-Received: by 2002:a17:902:5985:: with SMTP id p5mr14395696pli.73.1597741778821;
        Tue, 18 Aug 2020 02:09:38 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.79])
        by smtp.gmail.com with ESMTPSA id na14sm20280788pjb.6.2020.08.18.02.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:09:38 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org, linus.walleij@linaro.org, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org
Cc:     dmaengine@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 35/35] dma: k3-udma: convert tasklets to use new tasklet_setup() API
Date:   Tue, 18 Aug 2020 14:36:38 +0530
Message-Id: <20200818090638.26362-36-allen.lkml@gmail.com>
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

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/dma/ti/k3-udma.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index c14e6cb105cd..59cd8770334c 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -2914,9 +2914,9 @@ static void udma_desc_pre_callback(struct virt_dma_chan *vc,
  * This tasklet handles the completion of a DMA descriptor by
  * calling its callback and freeing it.
  */
-static void udma_vchan_complete(unsigned long arg)
+static void udma_vchan_complete(struct tasklet_struct *t)
 {
-	struct virt_dma_chan *vc = (struct virt_dma_chan *)arg;
+	struct virt_dma_chan *vc = from_tasklet(vc, t, task);
 	struct virt_dma_desc *vd, *_vd;
 	struct dmaengine_desc_callback cb;
 	LIST_HEAD(head);
@@ -3649,8 +3649,7 @@ static int udma_probe(struct platform_device *pdev)
 
 		vchan_init(&uc->vc, &ud->ddev);
 		/* Use custom vchan completion handling */
-		tasklet_init(&uc->vc.task, udma_vchan_complete,
-			     (unsigned long)&uc->vc);
+		tasklet_setup(&uc->vc.task, udma_vchan_complete);
 		init_completion(&uc->teardown_completed);
 		INIT_DELAYED_WORK(&uc->tx_drain.work, udma_check_tx_completion);
 	}
-- 
2.17.1

