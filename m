Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0651125777C
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 12:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgHaKid (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 06:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgHaKib (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 06:38:31 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA88C061573
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:38:30 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id q3so2816570pls.11
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C6MEjzmg2ijL2wEG4EWscVIYo5yhxVz96yVi0O0ZzBA=;
        b=uNm1PMCnoEqkPIEekFNZWiKhfXIMMUC0CtR92q3dLSd1QCCqwKwYZ6m9EAspLmXqfL
         PX7n0K6WkkLlXS4Y8c47QtfOqyNhanjqr6lmcmO97oZ/UW6aTTd92wHgnWGqa0rEJiRM
         5gPlxmwDeSU1z1X8BIFmh71p24ztfrmf1t/r9MmnRr0VunS4hQciJLqGTJmxWwOkFmu4
         ouyI3hvL0WkkHvkvpIgihnobl4KsQfk5ctq7iIUkw7RU9HZ8M+5A44NDGgZhgvR+9pJC
         x1WGAJf5Gc0CkiGwBeRkyuJDNIMDlrVRkodZuDDqwPolwpIdbcnM8u4H/O1lw22o9k5r
         qIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C6MEjzmg2ijL2wEG4EWscVIYo5yhxVz96yVi0O0ZzBA=;
        b=RiLKsLyJ+7mKhf/9jzBXL4I9X0TTcfElyZK3yrBUu0KMbkJes5ursqwph6YPd9VEX0
         RfcfbKq6OfUFKwd/lfcfoei5blix3Ksgz6j2cJPtuG1iw67T1sbbKWu+CThI6gX3npBm
         WZYclPNJxELM8zBFfKc6/HqX+82U18eDOlszp/s16C+QujWivQsnlNE3GeANp8EhcMOD
         1ro8WMFw3R8vIQZ/lOf09sJIkRtS61G6KR8c+OvcsI8hkctunNGyylxH/o1BX1p6kSnt
         31vmTyX+LEyfIRJ/zbx2lg+PhzNggww9EFN0PIt3keRCK8diUIv3+CU9h2hhqaOOl0I0
         dvrg==
X-Gm-Message-State: AOAM533g3Xhwde0FM7AFCyuInA+yJDfC91tmkc0Uikj8F+AuAlhPNwtg
        dMhqUCjv/8CDWsXD2oJcwMI=
X-Google-Smtp-Source: ABdhPJwyxVJEpRrmkxukM9mew5f89HfoIN8SWVc3VgMZgtP2H5BJ0x2QjwbwbaN/wAVx7HC2rA160w==
X-Received: by 2002:a17:90a:aa90:: with SMTP id l16mr801895pjq.210.1598870309885;
        Mon, 31 Aug 2020 03:38:29 -0700 (PDT)
Received: from localhost.localdomain ([49.207.204.90])
        by smtp.gmail.com with ESMTPSA id x6sm6895449pge.61.2020.08.31.03.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 03:38:29 -0700 (PDT)
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
Subject: [PATCH v3 28/35] dmaengine: timb_dma: convert tasklets to use new tasklet_setup() API
Date:   Mon, 31 Aug 2020 16:05:35 +0530
Message-Id: <20200831103542.305571-29-allen.lkml@gmail.com>
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
 drivers/dma/timb_dma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/timb_dma.c b/drivers/dma/timb_dma.c
index 68e48bf54d78..3f524be69efb 100644
--- a/drivers/dma/timb_dma.c
+++ b/drivers/dma/timb_dma.c
@@ -563,9 +563,9 @@ static int td_terminate_all(struct dma_chan *chan)
 	return 0;
 }
 
-static void td_tasklet(unsigned long data)
+static void td_tasklet(struct tasklet_struct *t)
 {
-	struct timb_dma *td = (struct timb_dma *)data;
+	struct timb_dma *td = from_tasklet(td, t, tasklet);
 	u32 isr;
 	u32 ipr;
 	u32 ier;
@@ -658,7 +658,7 @@ static int td_probe(struct platform_device *pdev)
 	iowrite32(0x0, td->membase + TIMBDMA_IER);
 	iowrite32(0xFFFFFFFF, td->membase + TIMBDMA_ISR);
 
-	tasklet_init(&td->tasklet, td_tasklet, (unsigned long)td);
+	tasklet_setup(&td->tasklet, td_tasklet);
 
 	err = request_irq(irq, td_irq, IRQF_SHARED, DRIVER_NAME, td);
 	if (err) {
-- 
2.25.1

