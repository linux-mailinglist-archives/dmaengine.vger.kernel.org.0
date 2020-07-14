Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE07E21EF04
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2020 13:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgGNLSw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jul 2020 07:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbgGNLQs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Jul 2020 07:16:48 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E1BC08C5FD
        for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2020 04:16:03 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r12so20829689wrj.13
        for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2020 04:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NnI1Hr8cN1xgbEvUxkhLUJ4OsaPQfVlLvMmqI8pCO3s=;
        b=NQ/hVm91tDxmABEPbH0rNFSS8NGb/3PLnnApSOyHhscglrmoLOMyFWz5wtrlv5WEAc
         w7NAY2gdTBxkp94u7rS0Tgl3QOcWWldpWa1sZatsmBy4bkojuQ84zuqlGEmm43TZlNhe
         7e3tzwADI4qKPfm21AmneVuYTXCGvYdl6nXLIBiAbNSxYm48Go5/XJhJbknaO85600l/
         TzbhOUwbnb14+TgiQxeYmoqM4xnXjKW+V62qGrdsT14LaW6eknTWW9U8wx+FLbneGpIQ
         tr/AyMKX9X+pZ6WHkzUes84iQtVh7eyenP5X+cqfAeZa6IUYaorMUth/P/mYblGq+9S0
         DidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NnI1Hr8cN1xgbEvUxkhLUJ4OsaPQfVlLvMmqI8pCO3s=;
        b=fpr91/BuibXWeX9ZnX15ver0wsgTvQ0BGCoxshuo/OSUrDKnCOXX0GapKawOxWjkmQ
         dQ80piTlENRhM2Mz7NADQsXiY2QCe//PKM50EzNYEi2kkZI2XiLkoWjPIwWevNiMwEpj
         4XWmbBjncqphHHb1FPzoCxRAtxf3rgPhk+6CIfJdTDAh/2IsHwH9Qy0IHjKD1xI4ZfE9
         +gpw1gH2ZBIWKXXDxSzYMd1OrCppNMnBicWBIeGjH44lxF29ZQ8zwLFOJr+Ppw5iEEz3
         Nce0xOiQWCBRELbQDkHeXLKpJyJQD1KTtrTmGW9onoGSYNXgPypMMU0fNdalhR3zEUrb
         i2Nw==
X-Gm-Message-State: AOAM531cON0JrWIKz0h/Eoha1gKbeHuxcAH3zLphG5cDmS2Wl6m4SNyk
        5lF6MgPPAGHu7vtzZzEP9dc5+w==
X-Google-Smtp-Source: ABdhPJzYlJ+XLLzRSmvIFCs1WJ2WYX+Cwdno9y3SVmnqqB4jRMVHTnl+GSY47lUzMwCDxwwOni3Ziw==
X-Received: by 2002:adf:db86:: with SMTP id u6mr4773505wri.27.1594725362227;
        Tue, 14 Jul 2020 04:16:02 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id l8sm28566052wrq.15.2020.07.14.04.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 04:16:01 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH 11/17] dma: imx-sdma: Correct formatting issue and provide 2 new descriptions
Date:   Tue, 14 Jul 2020 12:15:40 +0100
Message-Id: <20200714111546.1755231-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714111546.1755231-1-lee.jones@linaro.org>
References: <20200714111546.1755231-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/dma/imx-sdma.c:383: warning: Function parameter or member 'slave_config' not described in 'sdma_channel'
 drivers/dma/imx-sdma.c:383: warning: Function parameter or member 'context_loaded' not described in 'sdma_channel'
 drivers/dma/imx-sdma.c:383: warning: Function parameter or member 'terminate_worker' not described in 'sdma_channel'

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/imx-sdma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 270992c4fe475..4f8d8f5e11329 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -335,7 +335,7 @@ struct sdma_desc {
  * @sdma:		pointer to the SDMA engine for this channel
  * @channel:		the channel number, matches dmaengine chan_id + 1
  * @direction:		transfer type. Needed for setting SDMA script
- * @slave_config	Slave configuration
+ * @slave_config:	Slave configuration
  * @peripheral_type:	Peripheral type. Needed for setting SDMA script
  * @event_id0:		aka dma request line
  * @event_id1:		for channels that use 2 events
@@ -354,8 +354,10 @@ struct sdma_desc {
  * @shp_addr:		value for gReg[6]
  * @per_addr:		value for gReg[2]
  * @status:		status of dma channel
+ * @context_loaded:	ensure context is only loaded once
  * @data:		specific sdma interface structure
  * @bd_pool:		dma_pool for bd
+ * @terminate_worker:	used to call back into terminate work function
  */
 struct sdma_channel {
 	struct virt_dma_chan		vc;
-- 
2.25.1

