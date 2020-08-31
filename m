Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6655E257766
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 12:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgHaKhD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 06:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbgHaKhB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 06:37:01 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C6AC061573
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:37:00 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k13so2807598plk.13
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F2FnoBqi5NH706AoRxBmENjM5xfxPQEIU49AcdTrV8I=;
        b=k92LWmh0iXe/RIX+VUg33GvTZ5+nhFcUjf7V9ZmKTh5/XboYDXlV+BlnyyiBRJ4B70
         AFNvaOCl3E4MOkpWo8k0jw8CVAXWDVBeuhjjqmnEZ/r9+auHGXlYq4/Sa9yKM/9He4tn
         pmJeO6pDhpCVEXFhA2LNmf/MaR0J6Cr8EbX9Gqgd/8B5y9DUiGxLmedrWCoV+zoEbRHx
         5pHHZmBW+N6xDUgLjBeka/VlCX4xsfUl8juLaQ/DqpOVAX/vqg2KY+vQGqM4CRoBkI6z
         5TIGYEbhQOLfeSS/mbn6vm4KLOcZSLgYFBAiWetAkJiif7YlEfzyWYM+A+7SaT06OUpM
         WNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F2FnoBqi5NH706AoRxBmENjM5xfxPQEIU49AcdTrV8I=;
        b=PBRBVMj6X1dLGWVhtEjnS/WEmkdojS9iktlZ+nmomwmqnxAU4ZYmS6lQhX2oH3FewZ
         eVlSCJiAWA7f/MAtSQGLWbyHnpIId1svqdnEN+qhoLC9TC8S+MPD/xUXxzH2woGuNR1r
         cuUGLzEwbXHWTUDX7f2UbWGyyn8tEAKPd1kbmseJnYWkt3/sNf3tmxSBgOH9lOYqwDzT
         pimecbMNDCj/t8yl5Agb203e/adTDvSmBREnkKKajSMFqvnW36HtPYSnPPlDKXTtrDdg
         /Iu0c62RbmZkglth8f7nXuPCQU2IBI4YBEnzNWfWZ1J1e0qAAZWRY2JuH20EJP4RdjJ5
         BIyw==
X-Gm-Message-State: AOAM532M991qqWhFVeYiN0kvTBJAePVlSYo2mf7cRS4UQJoMFyRNlpv5
        TXx2Ql0+tOq27FWGGwJdia0=
X-Google-Smtp-Source: ABdhPJw80wRV5ua3sfGR1EMfQjbNW6Ft+ksuFQFki1qi5RfaWPgjKddjb82B8qsae1bbfPEpqw+2rQ==
X-Received: by 2002:a17:902:fe02:: with SMTP id g2mr557710plj.315.1598870220333;
        Mon, 31 Aug 2020 03:37:00 -0700 (PDT)
Received: from localhost.localdomain ([49.207.204.90])
        by smtp.gmail.com with ESMTPSA id x6sm6895449pge.61.2020.08.31.03.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 03:36:59 -0700 (PDT)
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
Subject: [PATCH v3 11/35] dmaengine: ipu: convert tasklets to use new tasklet_setup() API
Date:   Mon, 31 Aug 2020 16:05:18 +0530
Message-Id: <20200831103542.305571-12-allen.lkml@gmail.com>
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
 drivers/dma/ipu/ipu_idmac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ipu/ipu_idmac.c b/drivers/dma/ipu/ipu_idmac.c
index 0457b1f26540..38036db284cb 100644
--- a/drivers/dma/ipu/ipu_idmac.c
+++ b/drivers/dma/ipu/ipu_idmac.c
@@ -1299,9 +1299,9 @@ static irqreturn_t idmac_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void ipu_gc_tasklet(unsigned long arg)
+static void ipu_gc_tasklet(struct tasklet_struct *t)
 {
-	struct ipu *ipu = (struct ipu *)arg;
+	struct ipu *ipu = from_tasklet(ipu, t, tasklet);
 	int i;
 
 	for (i = 0; i < IPU_CHANNELS_NUM; i++) {
@@ -1740,7 +1740,7 @@ static int __init ipu_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_idmac_init;
 
-	tasklet_init(&ipu_data.tasklet, ipu_gc_tasklet, (unsigned long)&ipu_data);
+	tasklet_setup(&ipu_data.tasklet, ipu_gc_tasklet);
 
 	ipu_data.dev = &pdev->dev;
 
-- 
2.25.1

