Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A32257763
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 12:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgHaKgs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 06:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbgHaKgp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 06:36:45 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D52C061575
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:36:45 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id a8so2836778plm.2
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wq3OAA05Kkqf9o/BX5uLXvcYXIy2kW0ifbKYiZ0Coj8=;
        b=fWYI4R3BZ7qC37XBCN42a3qBKv5yt1FS05tHq6nSfvlX5N8ltwn2RWgbV1kekwGBBt
         LQiYJjOGKTxZuc0h9mRG1V7W0aP/AsF3kURNnlo2loYFOezUlPpRy7T7ec3PaZJDn/Mk
         LAuP++ucdlvofE/41kxE9522+ipUwMooY8XqyQBNXfdVpbTGDrs1guGa/41FCQKng8NQ
         5GDrxkSFAbj6yPeZRKraLfiCE47r5FIv3rPxH7GgM7Tyl4eMT+nLrWJhbn1ujbgeF7Mj
         lMw1lUdHrQes4jXdMT2amMX0c6a/Dt+Gxg3jEepWXlJr0OeogZbp0k7DOPLBQY5VBtBU
         EgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wq3OAA05Kkqf9o/BX5uLXvcYXIy2kW0ifbKYiZ0Coj8=;
        b=bIBN6+xVH/Dst2Au0bXyzc+i1GqCIHj1TgNjPdFDv1rlWU7eN5LliLTAENfDMcOpGe
         nssDbpGiVOS0IC0+R25wK32ONGbSfLUjFQDHVOoZMmvJ3zTF5ck7ewLW+ln4XfP47x7V
         rPzola6guH4E+TPg/b2g7dBikySuZw/D1iJ53f1wLyCX98Qe6Fb1o+CZ2a7ntSbDHh3r
         r+ZnEgWIkPcOEhtHMvpR0+/hV/17RhSko9++3IqvJJjZTKBham9gO8e8Be5ZwtkJ9U+2
         EwTM/CK8jSkYWkOhDSPmy9CTRJdufQ1vb35n6mgk1YJL0bHRkO9fRXTqh34m6HHsDM28
         1Gww==
X-Gm-Message-State: AOAM530XIJOIjAjafeKpc8Q44c+HnKiSclTBhz7x8Hzzj+KFVEZQqcEy
        pNN72GaeHFKJK2O8JzBbNyw=
X-Google-Smtp-Source: ABdhPJw1HtSTtyJ4HnF1/COWzae7icQQ9kF9xfV72WE1eTogMGpHQ1u29uOumR1FCevHQ/yAmMoDNA==
X-Received: by 2002:a17:90a:bc96:: with SMTP id x22mr848465pjr.164.1598870204722;
        Mon, 31 Aug 2020 03:36:44 -0700 (PDT)
Received: from localhost.localdomain ([49.207.204.90])
        by smtp.gmail.com with ESMTPSA id x6sm6895449pge.61.2020.08.31.03.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 03:36:44 -0700 (PDT)
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
Subject: [PATCH v3 08/35] dmaengine: imx-dma: convert tasklets to use new tasklet_setup() API
Date:   Mon, 31 Aug 2020 16:05:15 +0530
Message-Id: <20200831103542.305571-9-allen.lkml@gmail.com>
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
 drivers/dma/imx-dma.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index 88717506c1f6..04c24be2b2d9 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -613,9 +613,9 @@ static int imxdma_xfer_desc(struct imxdma_desc *d)
 	return 0;
 }
 
-static void imxdma_tasklet(unsigned long data)
+static void imxdma_tasklet(struct tasklet_struct *t)
 {
-	struct imxdma_channel *imxdmac = (void *)data;
+	struct imxdma_channel *imxdmac = from_tasklet(imxdmac, t, dma_tasklet);
 	struct imxdma_engine *imxdma = imxdmac->imxdma;
 	struct imxdma_desc *desc, *next_desc;
 	unsigned long flags;
@@ -1169,8 +1169,7 @@ static int __init imxdma_probe(struct platform_device *pdev)
 		INIT_LIST_HEAD(&imxdmac->ld_free);
 		INIT_LIST_HEAD(&imxdmac->ld_active);
 
-		tasklet_init(&imxdmac->dma_tasklet, imxdma_tasklet,
-			     (unsigned long)imxdmac);
+		tasklet_setup(&imxdmac->dma_tasklet, imxdma_tasklet);
 		imxdmac->chan.device = &imxdma->dma_device;
 		dma_cookie_init(&imxdmac->chan);
 		imxdmac->channel = i;
-- 
2.25.1

