Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D76225777E
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 12:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgHaKim (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 06:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgHaKil (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 06:38:41 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0060CC061573
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:38:40 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id n3so2071181pjq.1
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sZgvV7j+m4QOySvO0ZmbvccpTAKnpHlBSbW1gFt1Enc=;
        b=qj9X1oUkvstkNrnsHG/WqZuzw89d6bp34rP16a9wSIIcRZgXs+0n4dP2PucMUfJNWT
         yLM3HKgDC/0/bB97HW2nCfBt5vDBgwcvmD/Yx4RHROLs3Ukq++3sJmbyOpxJyibmSjrg
         TXK7iIOAeR+mJEklT9J0hcqcYkEbAKixpHYv8BtpQFvBVcd47H7Ihx56aUbS1+Llm1eZ
         tTl6jTkykc9o2TcDC3RT9uNH/9EVnA+8IfnrzPiqqq0i9vgwxd22Ilhs/BrhyDUDCcWR
         btfKwid0YgPH4W2+V1u1cBQBSX7Rju11x10vn7BkyhiAlGrV90QgdA7fpBVuDdr/kR6r
         xGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sZgvV7j+m4QOySvO0ZmbvccpTAKnpHlBSbW1gFt1Enc=;
        b=tdaW987U4Sl1E10t+K4uZQOqSlbVLvJu8VxUOKlHWiE3X9xwsPOBlia86/ZDNQHCTi
         0N/oLhAJ6X81nYHxPH1QyPe5B2dp8vzVoZYjmncj3kdN1kIE1H7BKgTHW6GXdRa6/2Af
         TL+oZTIIFowGHU47vqh5V4+3HrfuB1NqgDwJXN8NWxKbyRGqlwFvXTyTdjBKEvaXe2qT
         uvU6EdR6kLKRN01elGeNJwmbsie+8Xh2ekalkqewYcDYxzfJkgRNf4eZc+WQhGb6wuKw
         yQeAdHKqA6629GM7x2+PTsuEQFV7ei3yJaDA/wk1b6z4gE/UaT8c8S9NPwWXQByp/zdZ
         3BUA==
X-Gm-Message-State: AOAM531ebqWYgA/d8kenQ/NSl1wWAOdXSi+JX2kDF0hoWS0rtS+MUTye
        QpUR1nl6E15EGXfkvHmCtAM=
X-Google-Smtp-Source: ABdhPJx88DyqfL91NxnJzxCXbXoerPZ4z3BtdIYsj0bFt5r5E7JH23+8kWMeIWoVMqA7chME5avMQQ==
X-Received: by 2002:a17:90a:fe07:: with SMTP id ck7mr828333pjb.20.1598870320577;
        Mon, 31 Aug 2020 03:38:40 -0700 (PDT)
Received: from localhost.localdomain ([49.207.204.90])
        by smtp.gmail.com with ESMTPSA id x6sm6895449pge.61.2020.08.31.03.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 03:38:40 -0700 (PDT)
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
Subject: [PATCH v3 30/35] dmaengine: virt-dma: convert tasklets to use new tasklet_setup() API
Date:   Mon, 31 Aug 2020 16:05:37 +0530
Message-Id: <20200831103542.305571-31-allen.lkml@gmail.com>
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
2.25.1

