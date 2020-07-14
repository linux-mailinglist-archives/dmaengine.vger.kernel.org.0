Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA7121EEE5
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2020 13:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgGNLRA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jul 2020 07:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgGNLQk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Jul 2020 07:16:40 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08825C08C5DE
        for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2020 04:15:53 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b6so20886296wrs.11
        for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2020 04:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8AHNAOGxoWBX3bXCs6Dh5/0gSXTq0LMXanlZCN8dNwA=;
        b=sx/RKyQ9jzgAwx3JUl7dyzFreyfVZjEL/DUHRuGpwSBUKhEE64OoYSqxjGFVirc7Gk
         sryFAxXibssYup3dVrT2uC4aq0mcmalkbq93JYSCp+BwRLD89Pv+5kz4oOojBTVD6WrI
         ahvJMu6FY2XT9T7OraeUW0dHR9cOdvO/2/IlNgYTkZD69LmCXDobV3qC8Noc5zlOMwgv
         c8k9E73fAGNjkpPwVPp4//NZ/4D4LjQ+03Bry7q7c7JxzRjVhem6LUJ20JsV5NOal6eh
         /ghvlJF4oOsqxuRZCbzwXiSGso3UnKH7O7X45+VT50Cn4Ete91et4bDQ6N+ZMBcH0aiX
         q0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8AHNAOGxoWBX3bXCs6Dh5/0gSXTq0LMXanlZCN8dNwA=;
        b=NW3iyBEs9ES2oxQck7VDLX2y16qlVSVi/LCrhRY1t6JIw8m1tUSvzrDSoJBoPKgYlL
         VfLdC7/7aT+otPqqIQaXJZlYPPD3xRAdrQyRLnfjDdVQC7943RYZXD3XoWKlwyI2gpWe
         ALm/tWaZThZLQJNTWi2JRyb5vsbSxUW8/y73AsS5cEmiujSVS88v5yBs79nlvr1Q567C
         5S2VM5FGS1IsjeL5ta/Yra16CgOUnUSRdi1iPIWFPhOdM0Br3JRI6GSMVizpi4AE1vXM
         3lqs/oXnC4vpz2hgx3989dyDQmG72uqAx1ezIdnA3vAH/LKGHdKm9NWHTdK6hygO1eAL
         SFeA==
X-Gm-Message-State: AOAM5319g8UMcOKQdpmgZNyJGeE4TdpiHh62gHtSx4WkZk5KBUOs7Fm1
        IVsRtSA+B3LAyFPrkbDI9rOpDg==
X-Google-Smtp-Source: ABdhPJz+RcOyEJB9HyBPqs6LMXrDgN6dj+1DlUqwXuNalPd8xjE66KHEGwQS5Q1S0C8zFN0qvlHVrg==
X-Received: by 2002:a05:6000:cf:: with SMTP id q15mr4734329wrx.203.1594725351797;
        Tue, 14 Jul 2020 04:15:51 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id l8sm28566052wrq.15.2020.07.14.04.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 04:15:51 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 02/17] dma: of-dma: Fix misspellings/formatting issues in some function headers
Date:   Tue, 14 Jul 2020 12:15:31 +0100
Message-Id: <20200714111546.1755231-3-lee.jones@linaro.org>
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

 drivers/dma/of-dma.c:57: warning: Function parameter or member 'ofdma' not described in 'of_dma_router_xlate'
 drivers/dma/of-dma.c:57: warning: Excess function parameter 'of_dma' description in 'of_dma_router_xlate'
 drivers/dma/of-dma.c:107: warning: Function parameter or member 'data' not described in 'of_dma_controller_register'
 drivers/dma/of-dma.c:308: warning: Function parameter or member 'ofdma' not described in 'of_dma_simple_xlate'
 drivers/dma/of-dma.c:308: warning: Excess function parameter 'of_dma' description in 'of_dma_simple_xlate'
 drivers/dma/of-dma.c:338: warning: Function parameter or member 'ofdma' not described in 'of_dma_xlate_by_chan_id'
 drivers/dma/of-dma.c:338: warning: Excess function parameter 'of_dma' description in 'of_dma_xlate_by_chan_id'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/of-dma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
index b2c2b5e8093cf..863f2aaf5c8f7 100644
--- a/drivers/dma/of-dma.c
+++ b/drivers/dma/of-dma.c
@@ -46,7 +46,7 @@ static struct of_dma *of_dma_find_controller(struct of_phandle_args *dma_spec)
 /**
  * of_dma_router_xlate - translation function for router devices
  * @dma_spec:	pointer to DMA specifier as found in the device tree
- * @of_dma:	pointer to DMA controller data (router information)
+ * @ofdma:	pointer to DMA controller data (router information)
  *
  * The function creates new dma_spec to be passed to the router driver's
  * of_dma_route_allocate() function to prepare a dma_spec which will be used
@@ -92,7 +92,7 @@ static struct dma_chan *of_dma_router_xlate(struct of_phandle_args *dma_spec,
  * @np:			device node of DMA controller
  * @of_dma_xlate:	translation function which converts a phandle
  *			arguments list into a dma_chan structure
- * @data		pointer to controller specific data to be used by
+ * @data:		pointer to controller specific data to be used by
  *			translation function
  *
  * Returns 0 on success or appropriate errno value on error.
@@ -295,7 +295,7 @@ EXPORT_SYMBOL_GPL(of_dma_request_slave_channel);
 /**
  * of_dma_simple_xlate - Simple DMA engine translation function
  * @dma_spec:	pointer to DMA specifier as found in the device tree
- * @of_dma:	pointer to DMA controller data
+ * @ofdma:	pointer to DMA controller data
  *
  * A simple translation function for devices that use a 32-bit value for the
  * filter_param when calling the DMA engine dma_request_channel() function.
@@ -323,7 +323,7 @@ EXPORT_SYMBOL_GPL(of_dma_simple_xlate);
 /**
  * of_dma_xlate_by_chan_id - Translate dt property to DMA channel by channel id
  * @dma_spec:	pointer to DMA specifier as found in the device tree
- * @of_dma:	pointer to DMA controller data
+ * @ofdma:	pointer to DMA controller data
  *
  * This function can be used as the of xlate callback for DMA driver which wants
  * to match the channel based on the channel id. When using this xlate function
-- 
2.25.1

