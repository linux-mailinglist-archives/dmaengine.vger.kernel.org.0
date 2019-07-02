Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C785C5D1C1
	for <lists+dmaengine@lfdr.de>; Tue,  2 Jul 2019 16:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfGBOaM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Jul 2019 10:30:12 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46103 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbfGBOaM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 2 Jul 2019 10:30:12 -0400
Received: by mail-qt1-f196.google.com with SMTP id h21so18610886qtn.13
        for <dmaengine@vger.kernel.org>; Tue, 02 Jul 2019 07:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0+37WrmHkeGrZ516U4FdIESetYyyKjsXSJpKlimVGr4=;
        b=IgkzDg60+BUBg33O8m1/YKXUpkK6Y3PJKEpERa8Kib0BwlB4JfxIMYjNoyyTpqMXZq
         L5NHshSjx5OahukqYKGoqA90c0Jk+V+JMIxuA2/qI2SpTVmSm5XwLG7J/m6YrhPFBesY
         6Lb5rgS+S7bZDdAPWrTPI+kjT6fRKYaXAQux60QoA7uZ6yf3EePJ2rwOxklC3AMwyQXd
         jOdVDt4f6wZsAQ5yKsd+NOdoiystX2hm0K+U7L3MyO466DP28+gm8j5ah/iCXHYjf7Os
         v60YFMG8p46r8xWNI7V15rE7JfH3qZnhJuMg5FTu4f7S1GHWG8ZOSCJCI+6eG68BxZbp
         sbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0+37WrmHkeGrZ516U4FdIESetYyyKjsXSJpKlimVGr4=;
        b=fu2pk5VAYe4aw15CiHX6cOW31Gzaih/P0yOCBtSefm6LtfdCmVgmo5wETVWCCpsQFc
         8jAXE02Z9VsiCVwHeOqUmguTCuNZUc8+fLgzQRImFQ6FxwZ6AvFZ3+Vr5fnqJHLOtbAD
         zGoEd8m22yuBiEsi5yYy6gULrPQhDs37mIE0r9RAqw9HcCrvQNrGKQBwh4GSESvnx4Cp
         ZS2hlpC4JCzwJQj8O7e62OB0yAsoMi5M6EoYNp5KwLR931vv6fPM2FfWv24yIS5SW9Nk
         Lm0pwYvbVwx6uMv1SVbeJjybTOOGbVohiKJfxWph09wW5w/1O24rk/6JQE5ZEx/cXPK9
         nfJQ==
X-Gm-Message-State: APjAAAVB0poQFnY/C0+WvC5hbkdijM88weYkblvk1G7fQEVBCJLJP4FU
        zP/5uMsg/cV1t4a3A9kHoEI=
X-Google-Smtp-Source: APXvYqwjv/piWbrfdDORIsWlXwRK+dfMb+D+q2J9D+d1vKRxiwN7MYy5cH76ugvPuB1XoALkruW55g==
X-Received: by 2002:a0c:c3c7:: with SMTP id p7mr26165343qvi.125.1562077810998;
        Tue, 02 Jul 2019 07:30:10 -0700 (PDT)
Received: from fabio-Latitude-E5450.am.freescale.net ([2804:14c:482:3c8:56cb:1049:60d2:137b])
        by smtp.gmail.com with ESMTPSA id r189sm5283417qkc.60.2019.07.02.07.30.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 07:30:10 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     vkoul@kernel.org
Cc:     peng.ma@nxp.com, k.kozlowski.k@gmail.com,
        dmaengine@vger.kernel.org, cphealy@gmail.com,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] Revert "dmaengine: fsl-edma: support little endian for edma driver"
Date:   Tue,  2 Jul 2019 11:30:12 -0300
Message-Id: <20190702143012.9472-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This reverts commit 002905eca5bedab08bafd9e325bbbb41670c7712.

Commit 002905eca5be ("dmaengine: fsl-edma: support little endian for edma
driver") incorrectly assumed that there was not little endian support
in the driver.

This causes hangs on Vybrid, so revert it so that Vybrid systems
could boot again.

Reported-by: Krzysztof Kozłowski <k.kozlowski.k@gmail.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/dma/fsl-edma-common.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 6bf238e19d91..680b2a00a953 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -83,14 +83,9 @@ void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
 	u32 ch = fsl_chan->vchan.chan.chan_id;
 	void __iomem *muxaddr;
 	unsigned int chans_per_mux, ch_off;
-	int endian_diff[4] = {3, 1, -1, -3};
 
 	chans_per_mux = fsl_chan->edma->n_chans / DMAMUX_NR;
 	ch_off = fsl_chan->vchan.chan.chan_id % chans_per_mux;
-
-	if (!fsl_chan->edma->big_endian)
-		ch_off += endian_diff[ch_off % 4];
-
 	muxaddr = fsl_chan->edma->muxbase[ch / chans_per_mux];
 	slot = EDMAMUX_CHCFG_SOURCE(slot);
 
-- 
2.17.1

