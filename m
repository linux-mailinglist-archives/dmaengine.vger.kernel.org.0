Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D97A615D34
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2019 08:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfEGGKu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 May 2019 02:10:50 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35105 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbfEGGKt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 May 2019 02:10:49 -0400
Received: by mail-pf1-f195.google.com with SMTP id t87so7502830pfa.2
        for <dmaengine@vger.kernel.org>; Mon, 06 May 2019 23:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=kSx/2bQ8k2nUJmyS2liy45fCcO2iYHSDnrOKKw/RGV4=;
        b=S9Cy/p1GeoEOtS8YQZgB0lYyFi1dHKS/HGpgplRm+Jl+6OwdRLa3AqzF/D5EUzwLum
         6hKH5eF/hHqGo6nqyFFDunpeoF4PfUOZ4/3aiB1lh7Zg+TO0UrCiOOaD7NClpHGZAiY0
         TW96Fv/P4Z05tGlR7xVhb505XEaI4omMP478SFFOL/CUS/3EEQurGtDg+8HfcBpLYr8W
         Sk+/f/aBON9i+QLuBzR1USCQJWELEUjdKzeNLt2a/DSVGTvrqPvpmw3vwNaYio7Muj4g
         1s+6KN1usY/566XMORgT84favpF5luB63k/rnOCSRzVpCQhtbAJPLNl4Coh1vz8pOguZ
         +IIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=kSx/2bQ8k2nUJmyS2liy45fCcO2iYHSDnrOKKw/RGV4=;
        b=k4Stb9JF9nHLxRDl8Uj4iZ722sBuGZn7vS5hzH1RbynE36xM0GCjz5IR9n0YFZ0fr0
         Q8739VpG4vjzngtsCfWc5MRV9v5qATM8C34IalxsFfFt4ncpK852mSW2dtlJtr3r7uwJ
         /WaZw8Rz7P9ND6GSJAIO0JMHoRujI6WmK247OU8AgEL7yzqU6qzpvhjZFs56oiROmUV+
         uDkF4pyhlDMGbsgjQ4cNYgaX4+L/ag8AnxxHCILUKt2SUMk4E8u2ikCIo0X27XgI9zmw
         qWcpm2vehPEfzYmSLUoJ0IWfIJAYpWFvXnUBdPVlRXBY9ocgWYTc8292Oi2EB7nIkTJ8
         hX/g==
X-Gm-Message-State: APjAAAUqIBT0CQMmcCXBZmMxRa0/WmXMtvI3gy/F6ItBNwMwopU60HBz
        VAdNbsJ6XNj2oa1EQXphKhAuNw==
X-Google-Smtp-Source: APXvYqzZDYlq7eyLwOtGEhDSsOmFAWA99COPckp4Min5Ajit5tRyKl66VcQ9loYKdX1dxZ/egVqG6g==
X-Received: by 2002:a63:1706:: with SMTP id x6mr4603838pgl.280.1557209449086;
        Mon, 06 May 2019 23:10:49 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e184sm30786325pfc.102.2019.05.06.23.10.43
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 23:10:48 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Zubair.Kakakhel@imgtec.com,
        wsa+renesas@sang-engineering.com, jroedel@suse.de,
        vincent.guittot@linaro.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 8/8] dmaengine: sh: usb-dmac: Let the core do the device node validation
Date:   Tue,  7 May 2019 14:09:45 +0800
Message-Id: <6dc4f90df68276e6c21f7e0087b91e95b153f85f.1557206859.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1557206859.git.baolin.wang@linaro.org>
References: <cover.1557206859.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1557206859.git.baolin.wang@linaro.org>
References: <cover.1557206859.git.baolin.wang@linaro.org>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Let the DMA engine core do the device node validation instead of drivers.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sh/usb-dmac.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
index 59403f6..0afabf3 100644
--- a/drivers/dma/sh/usb-dmac.c
+++ b/drivers/dma/sh/usb-dmac.c
@@ -636,9 +636,6 @@ static bool usb_dmac_chan_filter(struct dma_chan *chan, void *arg)
 	struct usb_dmac_chan *uchan = to_usb_dmac_chan(chan);
 	struct of_phandle_args *dma_spec = arg;
 
-	if (dma_spec->np != chan->device->dev->of_node)
-		return false;
-
 	/* USB-DMAC should be used with fixed usb controller's FIFO */
 	if (uchan->index != dma_spec->args[0])
 		return false;
@@ -659,7 +656,8 @@ static struct dma_chan *usb_dmac_of_xlate(struct of_phandle_args *dma_spec,
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	chan = dma_request_channel(mask, usb_dmac_chan_filter, dma_spec);
+	chan = __dma_request_channel(&mask, usb_dmac_chan_filter, dma_spec,
+				     ofdma->of_node);
 	if (!chan)
 		return NULL;
 
-- 
1.7.9.5

