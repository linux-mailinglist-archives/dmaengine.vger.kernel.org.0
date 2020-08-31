Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3B125777D
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 12:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgHaKig (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 06:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgHaKif (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 06:38:35 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9622EC061573
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:38:35 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t11so2830617plr.5
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/d/z16dzFhV3Oc6TlAqrRnq4hKiydAqPeWfQIWRXnyA=;
        b=LvuQ6IZHkL0tXlLAONFqmK6lqW4b0ygP77HSztXWFpRjZYwG9D3K4kHKwFWehPBNxN
         lc+RQsPONvtJEePwRASKC5kDvwP+Qyq9a1wNc95hjFDmlHFhMlhYQAGezSXfj9XjOug/
         AmCG6Nh0qwls/+MG2G5Ps2iZJJm3DJQiaCCprdskKFU/YcredpDtOro2teIRW2HVm3l8
         +GNR0g5ZGth+WFcnn9AxhLX8P7HOXdJN2ix6GEvFqcZ3LX1o4K6nMo7PpkR+hM3QHONC
         B730JLSkA8Lv0kT+BzOZDzJroFU6OnySVnpHtMOpg3gImNrfAjS6FLRe1HQcgj9KoJ3x
         kD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/d/z16dzFhV3Oc6TlAqrRnq4hKiydAqPeWfQIWRXnyA=;
        b=jNnR1exTkgqo6YD9X3gvfpnrTtP/8NCgTqr60I9M2NPfaUhi2v/fQ1Z0uNaIGQUCS/
         Gisux/PRPq1Mhqk1FN1o8+f554qUe5BHqS4QXD6mpLViQaNy74+4c24fx0F6MMqBA3vv
         ETj0s1tRBANAdmOuEzaIWEPeKf+6GTIhm7erXu5kXGtJDKhzda8Ovxl48EqjZjr5b8sv
         DAsTWpUD5f+Q6BE4PY20SM5bjB08Uve4CLsmh1437WPs9mcXx1qB1aqn2tplY8Q2UtL8
         MVjoPN+JVWXfwVJP1pwmlgRdG0q28dm57EmQ/cSLBJIJ9IgP1GFQPbLrMISx9fDryhgq
         ZEgg==
X-Gm-Message-State: AOAM5320M40W7aZzugKlMd78WldByeeT14cLxGm/L6w1erCRzIvaaeGH
        VHvELgJTj0sqXLuPiMiJLykru+pW9/yoDg==
X-Google-Smtp-Source: ABdhPJwFwCBa/+FR924oIA6oQs5g8ug5xySeeAg1vJreuRD1viBMdDLQ7bGTY95/TFissiVi3ny3+w==
X-Received: by 2002:a17:90b:885:: with SMTP id bj5mr743646pjb.133.1598870315187;
        Mon, 31 Aug 2020 03:38:35 -0700 (PDT)
Received: from localhost.localdomain ([49.207.204.90])
        by smtp.gmail.com with ESMTPSA id x6sm6895449pge.61.2020.08.31.03.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 03:38:34 -0700 (PDT)
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
Subject: [PATCH v3 29/35] dmaengine: txx9dmac: convert tasklets to use new tasklet_setup() API
Date:   Mon, 31 Aug 2020 16:05:36 +0530
Message-Id: <20200831103542.305571-30-allen.lkml@gmail.com>
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
 drivers/dma/txx9dmac.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/txx9dmac.c b/drivers/dma/txx9dmac.c
index 628bdf4430c7..5b6b375a257e 100644
--- a/drivers/dma/txx9dmac.c
+++ b/drivers/dma/txx9dmac.c
@@ -601,13 +601,13 @@ static void txx9dmac_scan_descriptors(struct txx9dmac_chan *dc)
 	}
 }
 
-static void txx9dmac_chan_tasklet(unsigned long data)
+static void txx9dmac_chan_tasklet(struct tasklet_struct *t)
 {
 	int irq;
 	u32 csr;
 	struct txx9dmac_chan *dc;
 
-	dc = (struct txx9dmac_chan *)data;
+	dc = from_tasklet(dc, t, tasklet);
 	csr = channel_readl(dc, CSR);
 	dev_vdbg(chan2dev(&dc->chan), "tasklet: status=%x\n", csr);
 
@@ -638,13 +638,13 @@ static irqreturn_t txx9dmac_chan_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void txx9dmac_tasklet(unsigned long data)
+static void txx9dmac_tasklet(struct tasklet_struct *t)
 {
 	int irq;
 	u32 csr;
 	struct txx9dmac_chan *dc;
 
-	struct txx9dmac_dev *ddev = (struct txx9dmac_dev *)data;
+	struct txx9dmac_dev *ddev = from_tasklet(ddev, t, tasklet);
 	u32 mcr;
 	int i;
 
@@ -1113,8 +1113,7 @@ static int __init txx9dmac_chan_probe(struct platform_device *pdev)
 		irq = platform_get_irq(pdev, 0);
 		if (irq < 0)
 			return irq;
-		tasklet_init(&dc->tasklet, txx9dmac_chan_tasklet,
-				(unsigned long)dc);
+		tasklet_setup(&dc->tasklet, txx9dmac_chan_tasklet);
 		dc->irq = irq;
 		err = devm_request_irq(&pdev->dev, dc->irq,
 			txx9dmac_chan_interrupt, 0, dev_name(&pdev->dev), dc);
@@ -1200,8 +1199,7 @@ static int __init txx9dmac_probe(struct platform_device *pdev)
 
 	ddev->irq = platform_get_irq(pdev, 0);
 	if (ddev->irq >= 0) {
-		tasklet_init(&ddev->tasklet, txx9dmac_tasklet,
-				(unsigned long)ddev);
+		tasklet_setup(&ddev->tasklet, txx9dmac_tasklet);
 		err = devm_request_irq(&pdev->dev, ddev->irq,
 			txx9dmac_interrupt, 0, dev_name(&pdev->dev), ddev);
 		if (err)
-- 
2.25.1

