Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33260257768
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 12:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgHaKhN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 06:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgHaKhL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 06:37:11 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBCEC061573
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:37:11 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id v15so376869pgh.6
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bcs8JsY906p9sVQx2Y1h6Mu+4edvE8Y3MxMSl8WvT/o=;
        b=bkJMTsVEhzR4tT17N5NgVTQn2p+1TckdpLKu6xioPCmpD5vcN8dW3H4uxEB9ROA6I4
         fsoMLAjRQ/s8WrsfzQZ/V+RvkbZqZvJs27fhX2uWAK02agIb9kLwUAraoeAtARFOmGu5
         IrHGOZcvOnj0mjOqr5e8WKthn6PiubSe72HrSKe1fjEQ2MfCqwxFC0na6fV1KYJXZalF
         L8tbTKA3usq9B5a+kcKYKnj4hEoXn/rhT2owVk/zNrUuxz75j+9g4JLYS6b5ThEblnLz
         EBAoAL9EMdntyEwe/2lJL61yE+n37osjaZ0M7v2xOQICLqTTVFmli5rDYAqwDUYXgJMT
         qPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bcs8JsY906p9sVQx2Y1h6Mu+4edvE8Y3MxMSl8WvT/o=;
        b=TVWgNEREz/vaTKUPD25kPzabvElbzYaD2/tPeJos9XU7lbfmFnpf43rXas2Q3vi4Vc
         juoAvddzwoYxEElKYUa/Zho3uoaTfUWaVpAlMpi6q4j1t1PeuTCI/XNWyH1yLuC1n6an
         TfpMMdIk8PaaSDBgh5ZD99+Pcvj0WnRvmTks2j8idK3pEYRqQXRkHVgNdZyGH7UjfBxl
         wvKJ6NdEHRQyVxWXDbLGNZTy2qLHpvd3GE8cGtNKLolpASALneINgtJMmIPCGu76QbSM
         Rf+qM2DhM5VS7L18lo/HeVNr0Pac5snJH4jrYi+v05bLkrb5GVsiXsEjlXrWYqY7rsQO
         C6YQ==
X-Gm-Message-State: AOAM531ta6x8RtO/aI72+gt6ghTCrMfMmCCLsPz+dNIvi44nW4MzWoWa
        FzKrbmQEmbUWICZmLYEApIQ=
X-Google-Smtp-Source: ABdhPJzvlWTvpJ5wdKyCdlUzVwHA6Hev8H6cupedYynmMPDjc1dUJrT+aUEOFnYA7w3HjLnPW/4tvg==
X-Received: by 2002:aa7:9aa4:: with SMTP id x4mr631149pfi.141.1598870230766;
        Mon, 31 Aug 2020 03:37:10 -0700 (PDT)
Received: from localhost.localdomain ([49.207.204.90])
        by smtp.gmail.com with ESMTPSA id x6sm6895449pge.61.2020.08.31.03.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 03:37:10 -0700 (PDT)
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
Subject: [PATCH v3 13/35] dmaengine: mediatek: convert tasklets to use new tasklet_setup() API
Date:   Mon, 31 Aug 2020 16:05:20 +0530
Message-Id: <20200831103542.305571-14-allen.lkml@gmail.com>
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
 drivers/dma/mediatek/mtk-cqdma.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/mediatek/mtk-cqdma.c b/drivers/dma/mediatek/mtk-cqdma.c
index 6bf838e63be1..41ef9f15d3d5 100644
--- a/drivers/dma/mediatek/mtk-cqdma.c
+++ b/drivers/dma/mediatek/mtk-cqdma.c
@@ -356,9 +356,9 @@ static struct mtk_cqdma_vdesc
 	return ret;
 }
 
-static void mtk_cqdma_tasklet_cb(unsigned long data)
+static void mtk_cqdma_tasklet_cb(struct tasklet_struct *t)
 {
-	struct mtk_cqdma_pchan *pc = (struct mtk_cqdma_pchan *)data;
+	struct mtk_cqdma_pchan *pc = from_tasklet(pc, t, tasklet);
 	struct mtk_cqdma_vdesc *cvd = NULL;
 	unsigned long flags;
 
@@ -878,8 +878,7 @@ static int mtk_cqdma_probe(struct platform_device *pdev)
 
 	/* initialize tasklet for each PC */
 	for (i = 0; i < cqdma->dma_channels; ++i)
-		tasklet_init(&cqdma->pc[i]->tasklet, mtk_cqdma_tasklet_cb,
-			     (unsigned long)cqdma->pc[i]);
+		tasklet_setup(&cqdma->pc[i]->tasklet, mtk_cqdma_tasklet_cb);
 
 	dev_info(&pdev->dev, "MediaTek CQDMA driver registered\n");
 
-- 
2.25.1

