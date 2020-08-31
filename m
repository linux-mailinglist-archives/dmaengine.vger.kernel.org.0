Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 433FE257778
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 12:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgHaKiP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 06:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgHaKiO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 06:38:14 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64083C061573
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:38:14 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id i10so388597pgk.1
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3EjQWuA4o0fFlB6s6vdr8ocrryUZe2bpIMOhyKU6Di4=;
        b=aEeSH/zDZ113mPFb8CdOlajdrmf4eOx8Z0Rk8DCUZMVwT/7tkkiDSK8qKreJhoGBNt
         NjsgE+VaMl4G9luGfl7AmthPFe9R6ug/gQUgMP0K4uO2WfwViMQo2XOVAgdJogZT6GAj
         edfu5Pclgcv43jOe5AXmI7t2R5DzbHVZhbDpT2lJbggexMezSu7CVMscYuL1j8+WfaTy
         s5HvCFbDUdX2Ct2xCR8WziM4bSzAeJaTAYlk5KcsSUV2CWguhLckki66TGWDcNjEbPv0
         cbQSVXIPyl2m+vFLVbThL1TRYY6SVaIVHzDGHftlHaZ+xpKyWRvF0jANzT/SzUuG/3Bn
         1LYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3EjQWuA4o0fFlB6s6vdr8ocrryUZe2bpIMOhyKU6Di4=;
        b=Jm+FBiEzuDICrQ1m2/ldAF1jwp97RlwaKhjRBdAty5yOcxoCGBAYltZWZWDBnYk95g
         m/aw/VkUfSUXRa0hLbWEWr7z60NXezVquWuLKl3neRdY8iKheOwuX1ycPibEOclh+kON
         ZNzY30KzZktZL8k95nzsf+T0OQv7arO44jd6DX/8nTGWp7HtG0GXGwatbVt4dKRvDbKW
         ILFcH4tC9QeyWMUfqdRb9D3UtgR4x+IH2XxTAPQFIHH2OjF5ZyNWl41Pe+kmc48IEfLf
         njHdKBJNYK2hscsVecDpsg6GVkqP65Jxr4F8p9yf2UmAadbdX21d0sY4RWUFlsGcjcaU
         EZxw==
X-Gm-Message-State: AOAM531Y47hDMsNvpevF7lNb9goxE0Tnm7M8Ws1aOvqOmszmHK04BlOF
        U1FlfHLCwUkmx6KiB/HrqMM=
X-Google-Smtp-Source: ABdhPJw3WkjqU1oFeFKuFBqJFcL27N7s5b1JXBAMyo9HmTjiqJ/nV+O0u7ZsgiQKBZPD62Z610FEYQ==
X-Received: by 2002:aa7:8c0f:: with SMTP id c15mr788815pfd.284.1598870294003;
        Mon, 31 Aug 2020 03:38:14 -0700 (PDT)
Received: from localhost.localdomain ([49.207.204.90])
        by smtp.gmail.com with ESMTPSA id x6sm6895449pge.61.2020.08.31.03.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 03:38:13 -0700 (PDT)
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
Subject: [PATCH v3 25/35] dmaengine: ste_dma40: convert tasklets to use new tasklet_setup() API
Date:   Mon, 31 Aug 2020 16:05:32 +0530
Message-Id: <20200831103542.305571-26-allen.lkml@gmail.com>
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
 drivers/dma/ste_dma40.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 21e2f1d0c210..ec4611ae7230 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -1573,9 +1573,9 @@ static void dma_tc_handle(struct d40_chan *d40c)
 
 }
 
-static void dma_tasklet(unsigned long data)
+static void dma_tasklet(struct tasklet_struct *t)
 {
-	struct d40_chan *d40c = (struct d40_chan *) data;
+	struct d40_chan *d40c = from_tasklet(d40c, t, tasklet);
 	struct d40_desc *d40d;
 	unsigned long flags;
 	bool callback_active;
@@ -2806,8 +2806,7 @@ static void __init d40_chan_init(struct d40_base *base, struct dma_device *dma,
 		INIT_LIST_HEAD(&d40c->client);
 		INIT_LIST_HEAD(&d40c->prepare_queue);
 
-		tasklet_init(&d40c->tasklet, dma_tasklet,
-			     (unsigned long) d40c);
+		tasklet_setup(&d40c->tasklet, dma_tasklet);
 
 		list_add_tail(&d40c->chan.device_node,
 			      &dma->channels);
-- 
2.25.1

