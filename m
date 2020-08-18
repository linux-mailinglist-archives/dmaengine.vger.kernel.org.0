Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B8C24817B
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 11:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgHRJI5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 05:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgHRJI5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 05:08:57 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F48C061389
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:08:57 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id c6so9138287pje.1
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ScSchtGkwbuHnxQx7iSsqRyAzIGJLK/PgYB9DNEv3wQ=;
        b=D7b95IPq/n0LVi51sL02NIbvwh/B1XLu3sdT27gvlPxqQ2wkB2x+fHZFlqQupXS9iU
         unwreiXc3MrJmeKJUgNdCxm5Mk5au/bUdhdNJLwDVdEv3b+1WOBz56MO9HofpgZjgnK5
         igatfRLWFO+teUJR+1UobqSFM5BqXio9f5jgNLNYHraDwnsJb6SdEOvskUXO2zvWUUZU
         Wg1ITy5XAb7JhFTLDjR0+yoeKOaRpJXiLlZEkoGcCi5E/qZymwmBo/LgbjEGV2x8F5FA
         6njNh1tUFxSRFdIqyvjYJPBCDVjpiVwtHe4qfJn/TSyjNqGsTajxRmB//ip8/L3cOQXO
         BP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ScSchtGkwbuHnxQx7iSsqRyAzIGJLK/PgYB9DNEv3wQ=;
        b=Nnvp7q+r77HWzqab/vrcWEM3Be4nm7pTZSQVVGH4PRcsOmmux8HXL9e+87A0It0fN0
         fl5U+w3HEUrNAar4JgpfKkB8+Q6epmJCU61VNSpm5Vq1lay7xOudQveuemytf+QKc32A
         P39NvSzZL6FmD7jH2WbCs/65SXYa0gK5xu1NRZhvCsEAimVu/6uebd4jFO6nxVSWiKWn
         1f5vd3fvBvoED/O1VCRqioGLiVfI+WNmZ0gjPD6p8A4qERRXTpWF2RKt5VpobaNeGz/O
         NYVzMdRxG3J+eM6kmrCrrEQIMEc84R+a1oaTXw5ePQdFuccI0n7EStgRgQ+dDWSaK9AU
         VFIg==
X-Gm-Message-State: AOAM533W57NwrdjPLK74RapM8hdzeOhhMa+3sQGgNFU1Mv/c5EH99JM/
        FPzuZu4Qrx3qZ5ABVscuMsw=
X-Google-Smtp-Source: ABdhPJwc0FN8gzIrwnq3T8k032QB+lR3viTGEl115UUukePXHwONrstFRYcfwTrklMvPwVOxBepnGg==
X-Received: by 2002:a17:90a:f83:: with SMTP id 3mr15611180pjz.7.1597741736654;
        Tue, 18 Aug 2020 02:08:56 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.79])
        by smtp.gmail.com with ESMTPSA id na14sm20280788pjb.6.2020.08.18.02.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:08:56 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org, linus.walleij@linaro.org, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org
Cc:     dmaengine@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 26/35] dma: sun6i: convert tasklets to use new tasklet_setup() API
Date:   Tue, 18 Aug 2020 14:36:29 +0530
Message-Id: <20200818090638.26362-27-allen.lkml@gmail.com>
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
2.17.1

