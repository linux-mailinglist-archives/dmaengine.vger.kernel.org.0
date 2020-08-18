Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348F3248181
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 11:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgHRJJR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 05:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgHRJJQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 05:09:16 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A357DC061389
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:09:16 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id r4so8929586pls.2
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qnSx2Xs+5F55vipJ1GlRPOngMDb///4cheR/5/8gimc=;
        b=G+InBvA0AHY+2BgVRZYYjeQnvXUOfZOwVcy0Cd6eYrt7ovegDF8JstW2RPWu3fgMet
         ygUu4YCm+I/qdlQrT9R7OvOtMwzgMt4IGhQRWiNwl+FhM27KoP1crF33yvDPVO+GTJfY
         8bh5fx/IhHCH3eE+p9zwzWALFdZspHQ5HBMymRkLR8/OukU7hMBe6qCaXzloKJpZVxNJ
         8BAiO1RZOR3+G5bJYWfypzA2KZG+5j7iZ5gxrqAqhok7Qvuvy9V6bIYg3jD3mbvPVdSG
         MPP0CfWHfGUpmFKiKAX5QstAUG/0uS1AaEXU+Y6ba3RImJX7GPPgdaSQBzA0S3A/Vi3i
         2dwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qnSx2Xs+5F55vipJ1GlRPOngMDb///4cheR/5/8gimc=;
        b=GaEqUzaqGysxpBC9RuasD6ZvqbYAfoL6INpG5fATEDlmxW15RZp/MJ06hKzgots109
         pOHptjBtGH9Qnn8C0As2wOOWzoQly4bsb8Mi5lqOdI/7Sq6DhKmctL2TsrVBRCYhlOUY
         +hfbsTNXo7vggVr4foQ/DURkUPrw1qPzRBDD/Zt3a3ZmyxDylSimWSG18uGXhkIkgFBm
         NnXsxKKwyQu5ORv3G674hquh9sD/7/hr/xiGjx6dWERjhP/etm8D7Vo2giGl2WFaie0/
         ans4dl5tC3afWsqIqFYuk5trc18WJf4BWq6Bu4Q6MXDZhe2FYdK8Dc8LeQVGm78OUViL
         sW1A==
X-Gm-Message-State: AOAM531FPPe3FQT1kk86gIoZdAJuG1rk8J5kGzFuQ2Yhx7Nt1Zeq7mxj
        v8n4Fksx130A4OUYOiPqTo0=
X-Google-Smtp-Source: ABdhPJzEa/y8tzQ4H/1crjzlP/eValSheK+DcgowKho2t3/omkejbuUdNwthHAX5GpXErqXFliy91A==
X-Received: by 2002:a17:90a:9b88:: with SMTP id g8mr15975569pjp.143.1597741756037;
        Tue, 18 Aug 2020 02:09:16 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.79])
        by smtp.gmail.com with ESMTPSA id na14sm20280788pjb.6.2020.08.18.02.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:09:15 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org, linus.walleij@linaro.org, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org
Cc:     dmaengine@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 30/35] dma: virt-dma: convert tasklets to use new tasklet_setup() API
Date:   Tue, 18 Aug 2020 14:36:33 +0530
Message-Id: <20200818090638.26362-31-allen.lkml@gmail.com>
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
 drivers/dma/virt-dma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/virt-dma.c b/drivers/dma/virt-dma.c
index 23e33a85f033..a6f4265be0c9 100644
--- a/drivers/dma/virt-dma.c
+++ b/drivers/dma/virt-dma.c
@@ -80,9 +80,9 @@ EXPORT_SYMBOL_GPL(vchan_find_desc);
  * This tasklet handles the completion of a DMA descriptor by
  * calling its callback and freeing it.
  */
-static void vchan_complete(unsigned long arg)
+static void vchan_complete(struct tasklet_struct *t)
 {
-	struct virt_dma_chan *vc = (struct virt_dma_chan *)arg;
+	struct virt_dma_chan *vc = from_tasklet(vc, t, task);
 	struct virt_dma_desc *vd, *_vd;
 	struct dmaengine_desc_callback cb;
 	LIST_HEAD(head);
@@ -131,7 +131,7 @@ void vchan_init(struct virt_dma_chan *vc, struct dma_device *dmadev)
 	INIT_LIST_HEAD(&vc->desc_completed);
 	INIT_LIST_HEAD(&vc->desc_terminated);
 
-	tasklet_init(&vc->task, vchan_complete, (unsigned long)vc);
+	tasklet_setup(&vc->task, vchan_complete);
 
 	vc->chan.device = dmadev;
 	list_add_tail(&vc->chan.device_node, &dmadev->channels);
-- 
2.17.1

