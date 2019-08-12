Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A94C89AF9
	for <lists+dmaengine@lfdr.de>; Mon, 12 Aug 2019 12:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbfHLKMF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Aug 2019 06:12:05 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:54055 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbfHLKMF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Aug 2019 06:12:05 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MS1G7-1hqoYI2gv5-00TT5D; Mon, 12 Aug 2019 12:11:57 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] dma: ti: unexport filter functions
Date:   Mon, 12 Aug 2019 12:11:43 +0200
Message-Id: <20190812101155.997721-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:uBwRpCRy5yDjgNG/dokHF0MoW+SifCtPmbgwLmiKHzF83+qi8QO
 qxYJmM5hbw49pgx1evLZVOr/zFMJGJgToPOFyn1kY32HM6my5VhoN1YcSEqzg6DAbpSBLak
 PQR4jVF/b0P/Z1HxcC0Ck07SKFQ6LLEni1yH14x4t2+2w+R9OvNfNhhgBaAPtu5uCmQdN/R
 5qqBhSxlExLjZg56HD3PA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zSDZ4EY2AbM=:hvDql46WjA+Aeh43ObcA68
 Ns4FfUQl7+VYKlgQC9V/hLAe9sl4DvP/c6054B0+8mO34E0KS+EUYLNtU+KTIr2dHg3fZIbGT
 /Z2JxAuzhQuk9Anl5ZdA7T8K6Qh3zH0ivxjSwMxJCK2PBbwEa2xFGc4WH2HVQ4BnvGXItdWAO
 mWP4VCghZohBMYE7mZItkSlG6gSx9+ApsRztI4lB8hQ+acNOonlED18GaduoItR9ue91z3mFl
 ck2tyNvTSaAS14M0vUj6ZZ7v6virZgv6QVxvw84Y1bSqiUv4Pi/3wL9bS1UA8xhU0DkHfKwTJ
 VtYZqz1X5jyyVm1XgyZuryaf3hUm+IIDOsThxgRvHTw8amWagZ/RqPKR5qgJQx0al+upGVmRl
 7XIj9ySiLNIJ4yNB3//AOl0GOhf9ck+61BqTO77M5PAQqQhCpSg0isLs385IuQlodIAp/IZ5I
 iC2o0Y546I0ALmY2QoRgetCpWsySjIybf+e/+E94njyLrMn5xieGXRvyfC2qQ72rqCcSOVBeX
 iHj0EyqOcUv+K+x5RZCAY8xeq5cbsB/ryHlo4HOIn1i4cHOBphWsaP0uZ0hrVj6MuzBqNSsIk
 rWj09+de6iw8Z5jT5PLfw4Un74tgOXv4KXWrCP/Dl6dDEuN+j6L1BeNfFmMvKvdbnRrcVeQFM
 PYPhFiG0s5iBdmAc42QMk/Ot0nHkDmjtk25aiH7oHI2/9Kqhxrc3q4lB0LaHAxaNdqMvnRmxq
 iAfciNmaslYBCvGgiDqHeH+RwNLDVemYEDpUbg==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The two filter functions are now marked static, but still exported,
which triggers a coming build-time check:

WARNING: "omap_dma_filter_fn" [vmlinux] is a static EXPORT_SYMBOL_GPL
WARNING: "edma_filter_fn" [vmlinux] is a static EXPORT_SYMBOL

Remove the unneeded exports as well, as originally intended.

Fixes: 9c71b9eb3cb2 ("dmaengine: omap-dma: make omap_dma_filter_fn private")
Fixes: d2bfe7b5d182 ("dmaengine: edma: make edma_filter_fn private")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: fix typo in changelog
---
 drivers/dma/ti/edma.c     | 1 -
 drivers/dma/ti/omap-dma.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index f2549ee3fb49..ea028388451a 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2540,7 +2540,6 @@ static bool edma_filter_fn(struct dma_chan *chan, void *param)
 	}
 	return match;
 }
-EXPORT_SYMBOL(edma_filter_fn);
 
 static int edma_init(void)
 {
diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index 49da402a1927..98b39bcb7b37 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1652,7 +1652,6 @@ static bool omap_dma_filter_fn(struct dma_chan *chan, void *param)
 	}
 	return false;
 }
-EXPORT_SYMBOL_GPL(omap_dma_filter_fn);
 
 static int omap_dma_init(void)
 {
-- 
2.20.0

