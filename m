Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6731515D2B
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2019 08:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfEGGKj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 May 2019 02:10:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36810 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfEGGKi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 May 2019 02:10:38 -0400
Received: by mail-pf1-f193.google.com with SMTP id v80so8081709pfa.3
        for <dmaengine@vger.kernel.org>; Mon, 06 May 2019 23:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=MjWLMAdBW11KI57uPKHpmOc8QO2EQsc2Bw5TFtq2aeM=;
        b=EPTCkX6PIWp6H6mHi0TmZyBHNTkNiDCOjwIvq4y+k7bAcUKgg+aAQYSeUiGtcEFhac
         uMQAb8Ce8bUqBZz0qzb3QD+1St8FT3LKJBOg2WJ79dLdgMiEnyhT6dED9GpA50HiDYXN
         g0cKvEmfcBjAZftLALFM6YJyyLCO2jGotOdpdiT+Jjqk4ZyUCejl/+4S7hjOJBIeAEgH
         EAM3+6a/PJghpLImXKKWgX2TNnpm0v9a0iYFb5ZHU9heUH6Nziw1o22ZNlXNQi/VzWyP
         yMjMvo3QcgAZii1n18z4Ol2nN+x5pdXG7MSREtWPwYDbLaQVwGa4WWigS7aVj5XMz8ac
         hXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=MjWLMAdBW11KI57uPKHpmOc8QO2EQsc2Bw5TFtq2aeM=;
        b=odSiZxdGj1Uq3o/g83PfqFdHzAqxud8Ki0MeiJQgrntjMeKdI5gHjulY8t98Q1No9X
         Cy1+kSVNvZGzMJ4VJ3CMGCVaMwvY5WlIEYAx+Yr2z1gl0wMtV6zWghtOElK//pnkSnHK
         gk0TxsvJHaP1rc7XkgmVj1muaTV1AAgriPIQPXeSpOB+F0U71g9edH31tdIFzoLJPi6R
         95O2OqbDddpYmDeuy3WGVmqrlqvl6C9EPHNwJhlJTcACqvODsAc+woOjeTws0X5ZSih0
         Emp0czltyLs7DQ4cI/VRYbwQpjiE6LJ+XDivNlpaT7K9V5UhkpnKs/bsq7YjTYVkNyqo
         /xaQ==
X-Gm-Message-State: APjAAAV3xbL5vFa8i1EP+w0W4MPkbUgHSoTmWQhX8tnEH8t6jfC/9xUb
        fbNE/Jve2S6rPgq3IyzFVGLK5w==
X-Google-Smtp-Source: APXvYqxLVILAxDHZN2kRQScJnvark6ssZgdEGaBWmo/QMwC9MFS0hSHYzRT49kNXNOF1nEGRxtcIsw==
X-Received: by 2002:aa7:90ca:: with SMTP id k10mr1280408pfk.20.1557209438341;
        Mon, 06 May 2019 23:10:38 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e184sm30786325pfc.102.2019.05.06.23.10.33
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 23:10:37 -0700 (PDT)
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
Subject: [PATCH 6/8] dmaengine: mxs-dma: Let the core do the device node validation
Date:   Tue,  7 May 2019 14:09:43 +0800
Message-Id: <c9b8865e869b4ca0bfcbaf04a997c4883dd8e15e.1557206859.git.baolin.wang@linaro.org>
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
 drivers/dma/mxs-dma.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index 22cc7f6..8ce5e79 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -716,7 +716,6 @@ static int __init mxs_dma_init(struct mxs_dma_engine *mxs_dma)
 }
 
 struct mxs_dma_filter_param {
-	struct device_node *of_node;
 	unsigned int chan_id;
 };
 
@@ -727,9 +726,6 @@ static bool mxs_dma_filter_fn(struct dma_chan *chan, void *fn_param)
 	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
 	int chan_irq;
 
-	if (mxs_dma->dma_device.dev->of_node != param->of_node)
-		return false;
-
 	if (chan->chan_id != param->chan_id)
 		return false;
 
@@ -752,13 +748,13 @@ static struct dma_chan *mxs_dma_xlate(struct of_phandle_args *dma_spec,
 	if (dma_spec->args_count != 1)
 		return NULL;
 
-	param.of_node = ofdma->of_node;
 	param.chan_id = dma_spec->args[0];
 
 	if (param.chan_id >= mxs_dma->nr_channels)
 		return NULL;
 
-	return dma_request_channel(mask, mxs_dma_filter_fn, &param);
+	return __dma_request_channel(&mask, mxs_dma_filter_fn, &param,
+				     ofdma->of_node);
 }
 
 static int __init mxs_dma_probe(struct platform_device *pdev)
-- 
1.7.9.5

