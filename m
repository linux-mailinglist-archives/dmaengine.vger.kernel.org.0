Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559E0248185
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 11:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgHRJJb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 05:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgHRJJa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 05:09:30 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4135AC061389
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:09:30 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id m71so9669645pfd.1
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QgRf+wpU/fZBoNxgl2cgbgUN6DgUelo3akwYgZu93dg=;
        b=MBevEr8IB4/x8f0VlNm0fXNo4Hv+AYU0MLo9z1BZfVCPUscKneitXMTmBWEHXe4NjD
         GSAfxjtq3HjW8GqALW5Il+d7eva1hw6K1m02yiBtPHRuNrZoGyV3ERoqiZZDz9vU3wX0
         0XsewDL9k7bEFRJ8k6c7rsH0dETJO+f3RWPDraUiK+28YPDhT3auyVqUggwjiqjaw5jx
         4tg3GeevQHW6Pe/v4YmtgXFkAuW9mPl/NowNIVrHfQu0blhLiZSUpA87CWf5G8l0ma2M
         ORtGGNkhS7VYg7V7d/znEwrcC526TNxLY0hREM+xSYJPiq3t+s+0mJH8RlaDNcF+Y1MB
         Y5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QgRf+wpU/fZBoNxgl2cgbgUN6DgUelo3akwYgZu93dg=;
        b=mHmsasYZXljkQMPGswEwo3i5j1CRdKyYfxeDy+ncq2RvdEX8gY7xxBpDtrIm0lxU6l
         WV4oe6K7LhxkEjk6g2D6d/A2CpYvA48365wYGtFdRVNGinJgfwewB/w+CawztlyNd1jy
         BsF8GX3XMlUurS1Om1GnKr0y9ScAy2oexUIytXzK2xgmFHkBBcoH5JdX+JASIOrYKkPj
         US8nrHtyOdreHqFoOJgjBO4JeBdg6fiev1OZpDTmhigbsjIbWu+aiCcBITFDvznqQpkv
         dA8p8wTBhOEznNPzDgU+48H5qLfAzHfgw9TG9XZVenE6Lv73PtQNOAyVuMh1fo1l4QOh
         Braw==
X-Gm-Message-State: AOAM533VBz0ZyY9ehlUdcjBWbJ2UORXSaVaL2+LcSEbZ/THSy0DFF2d7
        VjQYde7kxmygO0j4s08fa0w=
X-Google-Smtp-Source: ABdhPJwtzYIgWszkBRLWitNyJpCbbq96nX01hO06CfFBmCFzt17xteBd8lMx/+FrCXpIhpkQD6noTQ==
X-Received: by 2002:a62:90:: with SMTP id 138mr14672366pfa.0.1597741769845;
        Tue, 18 Aug 2020 02:09:29 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.79])
        by smtp.gmail.com with ESMTPSA id na14sm20280788pjb.6.2020.08.18.02.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:09:29 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org, linus.walleij@linaro.org, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org
Cc:     dmaengine@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 33/35] dma: plx_dma: convert tasklets to use new tasklet_setup() API
Date:   Tue, 18 Aug 2020 14:36:36 +0530
Message-Id: <20200818090638.26362-34-allen.lkml@gmail.com>
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
 drivers/dma/plx_dma.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/plx_dma.c b/drivers/dma/plx_dma.c
index db4c5fd453a9..f387c5bbc170 100644
--- a/drivers/dma/plx_dma.c
+++ b/drivers/dma/plx_dma.c
@@ -241,9 +241,9 @@ static void plx_dma_stop(struct plx_dma_dev *plxdev)
 	rcu_read_unlock();
 }
 
-static void plx_dma_desc_task(unsigned long data)
+static void plx_dma_desc_task(struct tasklet_struct *t)
 {
-	struct plx_dma_dev *plxdev = (void *)data;
+	struct plx_dma_dev *plxdev = from_tasklet(plxdev, t, desc_task);
 
 	plx_dma_process_desc(plxdev);
 }
@@ -513,8 +513,7 @@ static int plx_dma_create(struct pci_dev *pdev)
 	}
 
 	spin_lock_init(&plxdev->ring_lock);
-	tasklet_init(&plxdev->desc_task, plx_dma_desc_task,
-		     (unsigned long)plxdev);
+	tasklet_setup(&plxdev->desc_task, plx_dma_desc_task);
 
 	RCU_INIT_POINTER(plxdev->pdev, pdev);
 	plxdev->bar = pcim_iomap_table(pdev)[0];
-- 
2.17.1

