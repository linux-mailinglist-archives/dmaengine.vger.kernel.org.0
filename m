Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC6F257781
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 12:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgHaKi5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 06:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgHaKi4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 06:38:56 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB8BC061573
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:38:56 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id n12so373622pgj.9
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HH0dPF0UC4vFvuuGJrp3W/Fupq0oQF41Jn8PhR40Ayg=;
        b=pzTL5G64iRgNSLbtHaHeA/ye/j+7874WN33H9RWT7/xjLran++ebbuZ4iBeXkNE4P2
         DAo3dRZTJUDP8ez4FhhqMPALV2JiMfnQIC8Hx4ZJM45fauxZceNYbh8azZHiPVNkoIPL
         XrdHSp/8/c+3VoOtOYhmV6XaAEqTj5pS7bzplmewP8oQPiZ8sGuxeUA1t7/cnvcg80Y5
         e90Dsk+HBB+OU+/xZaaR+Wb/OY580nCFIx8Pz46aStDdMTduKBt5u/9dbo0DoNx4PfeJ
         vN/koHT15EFf9nSm+3h7Y8lX4KT0VGx0SKnlO9b+xLRR4y8zedIV8QTwMEIBTYgv2Igt
         PSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HH0dPF0UC4vFvuuGJrp3W/Fupq0oQF41Jn8PhR40Ayg=;
        b=ej/h0Knfjrso575EKUvZ4ElaLuwPcR2VoQRvE06aQFm7SdP1IwPrN0JL3ACTiAC7/I
         nRLhgPF33hvROe2zwXzPG445TPGdvgBib3B4ntFBnh6tLZC8Erak9u14JVY3ExCd/i5L
         Uscq+XRXCQ9UN8jXTnwC3SjqeyvShayCevNH3NTWxVW0OSBKZ1O0xmApomiuW8SstCYu
         2e8zR1RnayALvepxSqSy+BwVzS7yoOlyPBHePk56sBEmx6HVFGPsfbQrtCJqKft4ROfK
         6SS5Yj3IVmFKBqHF/cR7BLzZzaP2QrmL5EePs6aXSCWI5uP9YLkp6nVjVZpBnv4selIn
         RVpQ==
X-Gm-Message-State: AOAM533jNbymU40U+ehqbtTpJMnY0quQ6jslrO2SyUsJySH+JKhBWgdF
        7SZ0Qx47GgiLthrNT8iiCEs=
X-Google-Smtp-Source: ABdhPJygIq/URbWgyZHdgf8agoNjluus7O3UNtJrCRep5/DbTo2If5QAlZGWJMw7KlIzHbmBveuuvQ==
X-Received: by 2002:a62:78cb:: with SMTP id t194mr726094pfc.171.1598870336153;
        Mon, 31 Aug 2020 03:38:56 -0700 (PDT)
Received: from localhost.localdomain ([49.207.204.90])
        by smtp.gmail.com with ESMTPSA id x6sm6895449pge.61.2020.08.31.03.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 03:38:55 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org
Cc:     linus.walleij@linaro.org, vireshk@kernel.org, leoyang.li@nxp.com,
        zw@zh-kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        sean.wang@mediatek.com, matthias.bgg@gmail.com,
        logang@deltatee.com, agross@kernel.org, jorn.andersson@linaro.org,
        green.wan@sifive.com, baohua@kernel.org, mripard@kernel.org,
        wens@csie.org, dmaengine@vger.kernel.org,
        Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH v3 33/35] dmaengine: plx_dma: convert tasklets to use new tasklet_setup() API
Date:   Mon, 31 Aug 2020 16:05:40 +0530
Message-Id: <20200831103542.305571-34-allen.lkml@gmail.com>
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
2.25.1

