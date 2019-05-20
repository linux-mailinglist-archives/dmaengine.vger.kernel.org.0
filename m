Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA5523293
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2019 13:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732974AbfETLdG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 May 2019 07:33:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43683 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732971AbfETLdG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 May 2019 07:33:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id c6so7076910pfa.10
        for <dmaengine@vger.kernel.org>; Mon, 20 May 2019 04:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=S4gzzO6EwH6f41hdnpuqebXlIsK5G8TT4DFszJQHgV0=;
        b=kGzjAWx09b8i614qTj93eApuhAYdKFfSCQb0+hZtpocLm2MSIaH0rF9+HiZf0A+vcj
         DFTljdFN5pWcPxuYfUOJ68tQFKj30ZgtibGH2S3BXHbVCKNLZZhwrhp/XsRkXdFInukP
         Xjk9fWaCFqZJ8jZcXhR3aezzU8FJfnpD/f2ytgb8QX23t5dF/R+yuoTqXH0C0ZF9DjXK
         kK/Z6PNz6xn9BbWuEogWU+jIyoiUOisWLQVu90JBLpFdeKSeAFeaYkcaW1tllFwwnKdZ
         nJfsJF6cAcVhHJ/woNRx2z15cQYdmwdMhtceda3QpfeXnUfr/bh84yM2S2fBpXB8Pd1R
         Y6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=S4gzzO6EwH6f41hdnpuqebXlIsK5G8TT4DFszJQHgV0=;
        b=ZkZ2DIhP6XCdf3YCxehKrIGeiD0MJ/qfsMu4l3ZFqecjFf6vFopRz2j/Dn0SdhK/ap
         jY7NQbJi3lksC2CuMx0uml1rbwEUVfADgs5iAgI/JnInuvo2akzLhz2n5wXZ++Ln1OHA
         ARzXuf6jvhkfxyqZMqEyNZbWoZ3wH4B3ZHXGtuFMwbluWpBBO7FtgkCH80WrdxqrBcdl
         JVIxit9FC6tc3dDUHZLps0sX2R9sb3f14/fbJANUMWkPgsRnlo0/Khh1Pmij/KbR2CmR
         SGn8ODTdehQMX3mUGt5u3/DRt1q7oXuwVVmdOmtV+79SyDN/9pBNBj4a8TylVNniFP4j
         TFrw==
X-Gm-Message-State: APjAAAXnyH1fwRmQ98rwTx2bntj2IQpGtvEuHmy/8c1GMe6I62Gb50OI
        jkVcNb+fell2r1Eh024Mrnn+zg==
X-Google-Smtp-Source: APXvYqz1+ao7UVqG40GQmasG5WxCT+39UIx+E5Jw485BRv+ugxfxElvHdFQ11VJd43Wx3nTx7nGipA==
X-Received: by 2002:a63:6cc5:: with SMTP id h188mr13909311pgc.105.1558351985496;
        Mon, 20 May 2019 04:33:05 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id z124sm21310020pfz.116.2019.05.20.04.33.00
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 04:33:05 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, wsa+renesas@sang-engineering.com,
        jroedel@suse.de, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 7/8] dmaengine: sh: rcar-dmac: Let the core do the device node validation
Date:   Mon, 20 May 2019 19:32:20 +0800
Message-Id: <6e544656cea22f93bdb2626620b381b00d1b38bf.1558351667.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1558351667.git.baolin.wang@linaro.org>
References: <cover.1558351667.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1558351667.git.baolin.wang@linaro.org>
References: <cover.1558351667.git.baolin.wang@linaro.org>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Let the DMA engine core do the device node validation instead of drivers.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sh/rcar-dmac.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 33ab1b6..67df54a 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -1654,8 +1654,7 @@ static bool rcar_dmac_chan_filter(struct dma_chan *chan, void *arg)
 	 * Forcing it to call dma_request_channel() and iterate through all
 	 * channels from all controllers is just pointless.
 	 */
-	if (chan->device->device_config != rcar_dmac_device_config ||
-	    dma_spec->np != chan->device->dev->of_node)
+	if (chan->device->device_config != rcar_dmac_device_config)
 		return false;
 
 	return !test_and_set_bit(dma_spec->args[0], dmac->modules);
@@ -1675,7 +1674,8 @@ static struct dma_chan *rcar_dmac_of_xlate(struct of_phandle_args *dma_spec,
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	chan = dma_request_channel(mask, rcar_dmac_chan_filter, dma_spec);
+	chan = __dma_request_channel(&mask, rcar_dmac_chan_filter, dma_spec,
+				     ofdma->of_node);
 	if (!chan)
 		return NULL;
 
-- 
1.7.9.5

