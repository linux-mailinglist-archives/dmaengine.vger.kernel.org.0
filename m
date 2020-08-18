Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA68D24815C
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 11:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgHRJG7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 05:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgHRJG7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 05:06:59 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7BAC061389
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:06:59 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id e4so9142625pjd.0
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PpOwkkESLwiuZVXjbiIFtl9hpeTezLFpf6exIb06VVg=;
        b=So1dqjtq/rsoQEngc50dAkRGjiN1WiKCX0vx46zWF6X/ztPpVTSZRt6GeSOm1WtNWh
         SoC8NCRSkShSI7Qq3GlDXMT1BrJVSsZZgtS7IQ9p35N+4A2wGAcE59h5ImLBLCUiKIVm
         bYDP8hTor0eLxQtSWkA8IzxNC9efAbBjXyV6elbSOT/taLmHIkpGVjXAm95zRndTclYj
         nnHALtFT4OaPU2rfuDYzPjuKJwYnfPBk9D7Eg8wj3m2OVTXqSfucaJZc1L3R4qbSJOvJ
         2RcQpEutblIonjX0MADPa+0kewJjNdhbN+ohHYXKBiQXAM7qdWbvdx+ygH4R5DS3cmxL
         OPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PpOwkkESLwiuZVXjbiIFtl9hpeTezLFpf6exIb06VVg=;
        b=o9ZH3pBgpB7FeMlHy35d61sHke1qllqBRJVE/PF5BTj/94FAYfEI3TG4242RAxAphN
         wj7QTELNJHxXgepxp75E6FQj8yvlPNS75WcxQL7BboAP3CK0FWxCtC/Vw4i/eMLXZAHD
         R++lXY4fMeASYFq/d99seiCdD/v3aIQw5kDqm2EhDBRQvRs9HYpyAuScKA+mzNHRuLMK
         748jkbm7R/3BLBUvyN67x6+ryXtb837tsJyV8thvoXzLaZwF4kOKKBWnLkQ/a2iSbW7x
         B6nCAQ83HR/iN/p/PjE9WHpiC4Hcmkq1YRkWVL1r5SYGTNjP5bfnF4eRuG+h+tBi9DC5
         IkHQ==
X-Gm-Message-State: AOAM531nONH/aN105Ckz/Sd/unFKg2Yj7ZNKs6+rIVtwYMmVBaGpQcFe
        GS/m9mJVUmmI/5/vQYu7zOc=
X-Google-Smtp-Source: ABdhPJw5tA5J97dP/RG8Mw+LwMTCf52URfshG3/biRK+o7ovzWhbLTIlzl1A0jvEYB9QFqOHrwhd2Q==
X-Received: by 2002:a17:90a:36a7:: with SMTP id t36mr16186137pjb.36.1597741618543;
        Tue, 18 Aug 2020 02:06:58 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.79])
        by smtp.gmail.com with ESMTPSA id na14sm20280788pjb.6.2020.08.18.02.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:06:58 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org, linus.walleij@linaro.org, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org
Cc:     dmaengine@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 01/35] dma: altera-msgdma: convert tasklets to use new tasklet_setup() API
Date:   Tue, 18 Aug 2020 14:36:04 +0530
Message-Id: <20200818090638.26362-2-allen.lkml@gmail.com>
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
 drivers/dma/altera-msgdma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
index 321ac3a7aa41..4d6751bf6f11 100644
--- a/drivers/dma/altera-msgdma.c
+++ b/drivers/dma/altera-msgdma.c
@@ -680,9 +680,9 @@ static int msgdma_alloc_chan_resources(struct dma_chan *dchan)
  * msgdma_tasklet - Schedule completion tasklet
  * @data: Pointer to the Altera sSGDMA channel structure
  */
-static void msgdma_tasklet(unsigned long data)
+static void msgdma_tasklet(struct tasklet_struct *t)
 {
-	struct msgdma_device *mdev = (struct msgdma_device *)data;
+	struct msgdma_device *mdev = from_tasklet(mdev, t, irq_tasklet);
 	u32 count;
 	u32 __maybe_unused size;
 	u32 __maybe_unused status;
@@ -830,7 +830,7 @@ static int msgdma_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	tasklet_init(&mdev->irq_tasklet, msgdma_tasklet, (unsigned long)mdev);
+	tasklet_setup(&mdev->irq_tasklet, msgdma_tasklet);
 
 	dma_cookie_init(&mdev->dmachan);
 
-- 
2.17.1

