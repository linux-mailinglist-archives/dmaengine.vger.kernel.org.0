Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09A625777A
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 12:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgHaKiV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 06:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgHaKiU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 06:38:20 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A85C061573
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:38:19 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id o20so344597pfp.11
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mKpwzGrdE8EpGNZD5pwonhuABYkMlUq+l/59IUCbMrQ=;
        b=OFNY0IJg4EmQlueaTOO15HfdSC7mvhSOQQEmRz6pdf6r4wKNdV9bpbiL+VNSs2kbUu
         l/os4F/gLnMKrmHzLF3BESviRW3XgsCfykwhqmhg5AEZmhmG481x55ToaHpCgHvp0Ift
         mAKpP0Re2jQui/CcM9cb5765Rrg5NhCn0GimQagLlvYIFWYIBYPAO2qXeEg0ypoG2ocH
         /iz7QDoOgrsSgf264D7DEZl/WL/EZCCEa8WVUZMkWJ3PgyZKrOhveY3T5+V0/A8I8zsl
         VLcfV7s91B2Ld+c7tkbGNIMQNSvKdOCIozHhEs5CHrvAdj7501g1NhOYFpbIJ+XZAbnB
         iQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mKpwzGrdE8EpGNZD5pwonhuABYkMlUq+l/59IUCbMrQ=;
        b=ILJGWGwWL2MtD9KURLG5H6mq/yqx+lRyrM3kRVeMCAhKxphAKKfd8tgyaqJOXZZgIk
         YD1XWQ9Wy/b1BkGdHNaXzrl87U1JOz+lCx15hfj2EL2rp2bKd1+ZvMt44dgnVtuKuoXj
         RkiWHWUzlzKS4uFhY3zaWGltviAr4lEEJnUZrFWJy70nXRWcYQpQojkWIeuonxxfRKJ0
         bNSFsyhmeocqjtP3kUODs9aQ5O/X2G3fjhTkXvimALqIlQ8uLR1BXYM1LH9LIlKm+EqR
         uXnbQKs9/aFjWvxBQruxQv3EVzsUhAAfIw112sePwIIaXpHet/cgyf2NtcgE6nMJn+xK
         jH3Q==
X-Gm-Message-State: AOAM532iN1I7+pvwJLHAhCMywqjYH+RlGGYJ8fNPMYLnJwfgf/+RcXu5
        x8VaN/4l+PcI5p7Es5osc08=
X-Google-Smtp-Source: ABdhPJy45b3yqXFddAR7+DtLtd6PvHW/yYVD1DcFfFMaP9LXq74E97G80M9R2eDcXDJEmqIBFDonlw==
X-Received: by 2002:a63:4443:: with SMTP id t3mr785288pgk.9.1598870299281;
        Mon, 31 Aug 2020 03:38:19 -0700 (PDT)
Received: from localhost.localdomain ([49.207.204.90])
        by smtp.gmail.com with ESMTPSA id x6sm6895449pge.61.2020.08.31.03.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 03:38:18 -0700 (PDT)
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
Subject: [PATCH v3 26/35] dmaengine: sun6i: convert tasklets to use new tasklet_setup() API
Date:   Mon, 31 Aug 2020 16:05:33 +0530
Message-Id: <20200831103542.305571-27-allen.lkml@gmail.com>
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
 drivers/dma/sun6i-dma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 06cd7f867f7c..f5f9c86c50bc 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -467,9 +467,9 @@ static int sun6i_dma_start_desc(struct sun6i_vchan *vchan)
 	return 0;
 }
 
-static void sun6i_dma_tasklet(unsigned long data)
+static void sun6i_dma_tasklet(struct tasklet_struct *t)
 {
-	struct sun6i_dma_dev *sdev = (struct sun6i_dma_dev *)data;
+	struct sun6i_dma_dev *sdev = from_tasklet(sdev, t, task);
 	struct sun6i_vchan *vchan;
 	struct sun6i_pchan *pchan;
 	unsigned int pchan_alloc = 0;
@@ -1343,7 +1343,7 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 	if (!sdc->vchans)
 		return -ENOMEM;
 
-	tasklet_init(&sdc->task, sun6i_dma_tasklet, (unsigned long)sdc);
+	tasklet_setup(&sdc->task, sun6i_dma_tasklet);
 
 	for (i = 0; i < sdc->num_pchans; i++) {
 		struct sun6i_pchan *pchan = &sdc->pchans[i];
-- 
2.25.1

