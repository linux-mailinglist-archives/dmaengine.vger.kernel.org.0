Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6535F257783
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 12:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgHaKjJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 06:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgHaKjI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 06:39:08 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDCEC061573
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:39:06 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id np15so1130221pjb.0
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GU6do3Sc3Sg8QHCo09pkp5nNRZOgCilbwfzX8rZjCSE=;
        b=bJTBsVRkrm7GUSLuaGwEjeX/BEz6SEWm8uBe4l121B6oW8E4z+5ISU3DsP/HSA3L1z
         GoXfOjEy2VimPUybsOLmDlcavQCkdF2O3fV6a1Hfi+//pa4IH4w9Zn/qHG6ewk5F9N1c
         gV71IVoLDI5Qz5Eeq0vlA9N7grEpD0PNqGHO5vEDiODlxtFcWobFOAWulbRvVUDqng0p
         Kry4qi7wYgM0uDIVyxD5ggfXjYO5HYOYOJM7XmoYnRB17UlKpxjGic9b/4txKhzWiG//
         6DxfsEolGsrKu8TJRCFZD5aGTboVfLDwa0YN9snV0atLSo3ljZg2pLcyCLJHQJlRNxLG
         tE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GU6do3Sc3Sg8QHCo09pkp5nNRZOgCilbwfzX8rZjCSE=;
        b=jW9Uh1S5XlIHeUNHRk3rTjdW7depaVdR1ZQPRTxN6TcEuIWG0jR34J6HLYksJOWRri
         pKn3HVDrchrQYHL7ZB2uXUyfRr4ef8Nm9HH0hlEJzAMa0QlroRBEMP//wN8cx2gadoiL
         kHGwFC4DGuxhMTG0Z3uSqK7RtS6CQD34krkQ6D+1FSDcH1Kemz4bumgDH4t5aSnPI/pA
         sq5XTtmwtziXYPmwnzIyzju/0l8e6YAvXxC7aEGhM1VqBmOTgsC8hc68Kj1V9A/2KrzX
         ShGIzzdpZZ4mF9E6vBIDSOyws6p3B3GMC+ZEyWEAHVXRI5ohRIuQk1ggrivQqQxXQXm9
         Am0Q==
X-Gm-Message-State: AOAM5319nrL3m41w7hRjFMGUsmK3B+jPHNTr1rAajw255j9iFjpA3Wba
        67JPs3b/7B6ESXP0fHRFF1E=
X-Google-Smtp-Source: ABdhPJxIMjt9L3JdQX3FYOOGQGqny0jKO9qzlQJ9XZbDDUfStrKbyaZnSk/4Xg0fmzRTKSzy6F6FkQ==
X-Received: by 2002:a17:90a:a101:: with SMTP id s1mr720573pjp.205.1598870346142;
        Mon, 31 Aug 2020 03:39:06 -0700 (PDT)
Received: from localhost.localdomain ([49.207.204.90])
        by smtp.gmail.com with ESMTPSA id x6sm6895449pge.61.2020.08.31.03.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 03:39:05 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org
Cc:     linus.walleij@linaro.org, vireshk@kernel.org, leoyang.li@nxp.com,
        zw@zh-kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        sean.wang@mediatek.com, matthias.bgg@gmail.com,
        logang@deltatee.com, agross@kernel.org, jorn.andersson@linaro.org,
        green.wan@sifive.com, baohua@kernel.org, mripard@kernel.org,
        wens@csie.org, dmaengine@vger.kernel.org,
        Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH v3 35/35] dmaengine: k3-udma: convert tasklets to use new tasklet_setup() API
Date:   Mon, 31 Aug 2020 16:05:42 +0530
Message-Id: <20200831103542.305571-36-allen.lkml@gmail.com>
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
2.25.1

