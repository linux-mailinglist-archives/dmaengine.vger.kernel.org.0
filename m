Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787453CC593
	for <lists+dmaengine@lfdr.de>; Sat, 17 Jul 2021 20:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbhGQTAx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 17 Jul 2021 15:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234308AbhGQTAw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 17 Jul 2021 15:00:52 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07939C061762;
        Sat, 17 Jul 2021 11:57:54 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id e20so18904460ljn.8;
        Sat, 17 Jul 2021 11:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G7SgY/YkC3Ua+jZHJBroQqKVwZij5nIyA73xwLEzGtY=;
        b=azpXn0L6T/BYABVMVJEUJotU+wwq+cL167r2uYNQs+8UylC9M3oqcSAxr2mo67Aiqj
         tHKWmFZwluW9IhlIIJL5jh5LRr4YBkzEcnieZ+VTe4kSlt3Huuf6xJ16bHB62qJC945w
         zamxsXltj95M9is/WUEgPH8TP4VQ5pqV8/xNdS92qjtuxjhWUWvKzT41Bw6r0D1M0+of
         jFqspNyjhZp1rqj8rucQuNi3d+p03jm8dvFevosce9nVAzeFLSxIlxeViXN/KrYz08RY
         36QHs6rm5KX+G6XacgBrvXAbhWizYtEIeGMLAAgFn+rWsQnZ7adJ8+JIRU3VIn3XOFkS
         FP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G7SgY/YkC3Ua+jZHJBroQqKVwZij5nIyA73xwLEzGtY=;
        b=NJKHcBMwwx7xclaS3DP26u5EW3WG4raPRJpkD6Ol5+9IK7fsBcl5hY3zNAAmGKGmny
         7r6LZe+61syHiL27sMslIhscYmK341dg4NfyR2bTl/7+66yP3VLPZpeYU7TJ7/f91hfX
         VhuqzG+swvCYxxjZ60F67+nbf6aHZ8wZenWPl6Alznyvc4oLF6SetriuiYkvDc4sbA6L
         iSc7mqfQ1vAsfDPxltAxTZ0IxCzlyXfxzyNt7IeTaDpfJVaxXq8+8pwBnguv/2jTFLSB
         ICo2qzSPuwXZEU1MFvVA5uheQLidCjwotTFyks3I+qKf+mXuSjQTF8XpmfecjDuJCJ8N
         uzYw==
X-Gm-Message-State: AOAM531L9TaiX4Yl7f6D3H93vd2Hr6lerjaqxUHNLiIPblTXbcmgXZ9J
        A9TBDAKzQ0BybC8GxuIUZKU=
X-Google-Smtp-Source: ABdhPJytwHKWFIxg2qCR2S1vk1mrAMA0owY0ottAGsurh4pfMKr5eVxPEAWChikE6waQ2Fpnvz1WzQ==
X-Received: by 2002:a05:651c:882:: with SMTP id d2mr5538178ljq.370.1626548273245;
        Sat, 17 Jul 2021 11:57:53 -0700 (PDT)
Received: from localhost.localdomain (91-155-111-71.elisa-laajakaista.fi. [91.155.111.71])
        by smtp.gmail.com with ESMTPSA id a26sm1406319ljq.120.2021.07.17.11.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 11:57:52 -0700 (PDT)
From:   Peter Ujfalusi <peter.ujfalusi@gmail.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com
Subject: [PATCH] dmaengine: of-dma: router_xlate to return -EPROBE_DEFER if controller is not yet available
Date:   Sat, 17 Jul 2021 22:00:21 +0300
Message-Id: <20210717190021.21897-1-peter.ujfalusi@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

If the router_xlate can not find the controller in the available DMA
devices then it should return with -EPORBE_DEFER in a same way as the
of_dma_request_slave_channel() does.

The issue can be reproduced if the event router is registered before the
DMA controller itself and a driver would request for a channel before the
controller is registered.
In of_dma_request_slave_channel():
1. of_dma_find_controller() would find the dma_router
2. ofdma->of_dma_xlate() would fail and returned NULL
3. -ENODEV is returned as error code

with this patch we would return in this case the correct -EPROBE_DEFER and
the client can try to request the channel later.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
---
Hi,

I have noticed the descibed failure sequence on Beagle-x15 board (McASP fails to
probe). It must have been broken for some time, I have not booted the board for
about a year or so...

Regards,
Peter

 drivers/dma/of-dma.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
index ec00b20ae8e4..ac61ecda2926 100644
--- a/drivers/dma/of-dma.c
+++ b/drivers/dma/of-dma.c
@@ -67,8 +67,12 @@ static struct dma_chan *of_dma_router_xlate(struct of_phandle_args *dma_spec,
 		return NULL;
 
 	ofdma_target = of_dma_find_controller(&dma_spec_target);
-	if (!ofdma_target)
-		return NULL;
+	if (!ofdma_target) {
+		ofdma->dma_router->route_free(ofdma->dma_router->dev,
+					      route_data);
+		chan = ERR_PTR(-EPROBE_DEFER);
+		goto err;
+	}
 
 	chan = ofdma_target->of_dma_xlate(&dma_spec_target, ofdma_target);
 	if (IS_ERR_OR_NULL(chan)) {
@@ -89,6 +93,7 @@ static struct dma_chan *of_dma_router_xlate(struct of_phandle_args *dma_spec,
 		}
 	}
 
+err:
 	/*
 	 * Need to put the node back since the ofdma->of_dma_route_allocate
 	 * has taken it for generating the new, translated dma_spec
-- 
2.32.0

