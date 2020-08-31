Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1325257771
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 12:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgHaKhk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 06:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgHaKhh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 06:37:37 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A0CC061755
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:37:37 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 5so381287pgl.4
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZZYdafVz5V8oniNxBBRSsVonTbPwIZcuQC3+ufpV9Xk=;
        b=EpQCSmBV6hx5qH4Ktm7KK9nPZt00x9+0YrRHR/bRM+PB9gONq3BS/duPLTz4bTFWyu
         HMKY6VHnoweXmQYvKplDqiEXWeL3dDqqXF+E0cYQGy0AbTDxZjYN2ecgEOw8czxR2twj
         FiJZFU2yv8tVp5Uaidav9Q6gs6/t4dtnp+YekSWXqobW+dyZ/urTQvWrOWa+AAhVKd17
         PWdBfUoWJmyJIKIsBc2PJpulGmsmiHDc5/2MUSCJYbB4vbeCtG8SL1yo7dChDm20YD7M
         ZOtcTOQDPa7jt7qpZyc1R9lg7or1ZNEPK/GmsFVufcQox4XMTr4Ia0eo7+jA8LwMricC
         VifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZZYdafVz5V8oniNxBBRSsVonTbPwIZcuQC3+ufpV9Xk=;
        b=FeVKnbu5VL7zoLh1M7nJAK7pI+8cKuVivOd1iFf6Z1jrYnhn5H4Dpkrb9m6AF3WajF
         IKMT+H9Uo+tj28+WvfayKBYRGkVfbuI25WrdkXKjvQF8RSfNIop/3WAzpcuG5PAHtP7i
         GCzxSx8DTyAzeldCLhDMnCXAHFcuhz6Km8YvY0ueufk76qurj/kbmhA3mRMV9BbsmO+C
         +4t6lzXnIoZ1lQJD3C2HjuXtI44wjVVpMJ4UfT1acwberY4t+1NNa4ktxEvxHbLDlHk1
         hui3GHvYtO64X572PFsZe4HiyOpumh7uwlyguYP4zL1hCp3sldXwFgYkyHQKZ84aOalm
         FW6Q==
X-Gm-Message-State: AOAM530Q8XQZltP9BWkG3YqBEZfbh+aqtoFuf0OFNP5yC2BAGCxNmH6j
        tEctbMOMJeiFMDjKPNpv5NLryitaDeqJ6g==
X-Google-Smtp-Source: ABdhPJwWZPLL3bZXY2IQigXynHJ+6gdL0FEIFoog4XUvJlulD30Hcbhim5iW4MS7O4Amg/OY+ADC/g==
X-Received: by 2002:a63:5b05:: with SMTP id p5mr59670pgb.154.1598870256984;
        Mon, 31 Aug 2020 03:37:36 -0700 (PDT)
Received: from localhost.localdomain ([49.207.204.90])
        by smtp.gmail.com with ESMTPSA id x6sm6895449pge.61.2020.08.31.03.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 03:37:36 -0700 (PDT)
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
Subject: [PATCH v3 18/35] dmaengine: nbpfaxi: convert tasklets to use new tasklet_setup() API
Date:   Mon, 31 Aug 2020 16:05:25 +0530
Message-Id: <20200831103542.305571-19-allen.lkml@gmail.com>
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
 drivers/dma/nbpfaxi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
index ca4e0930207a..9c52c57919c6 100644
--- a/drivers/dma/nbpfaxi.c
+++ b/drivers/dma/nbpfaxi.c
@@ -1113,9 +1113,9 @@ static struct dma_chan *nbpf_of_xlate(struct of_phandle_args *dma_spec,
 	return dchan;
 }
 
-static void nbpf_chan_tasklet(unsigned long data)
+static void nbpf_chan_tasklet(struct tasklet_struct *t)
 {
-	struct nbpf_channel *chan = (struct nbpf_channel *)data;
+	struct nbpf_channel *chan = from_tasklet(chan, t, tasklet);
 	struct nbpf_desc *desc, *tmp;
 	struct dmaengine_desc_callback cb;
 
@@ -1260,7 +1260,7 @@ static int nbpf_chan_probe(struct nbpf_device *nbpf, int n)
 
 	snprintf(chan->name, sizeof(chan->name), "nbpf %d", n);
 
-	tasklet_init(&chan->tasklet, nbpf_chan_tasklet, (unsigned long)chan);
+	tasklet_setup(&chan->tasklet, nbpf_chan_tasklet);
 	ret = devm_request_irq(dma_dev->dev, chan->irq,
 			nbpf_chan_irq, IRQF_SHARED,
 			chan->name, chan);
-- 
2.25.1

