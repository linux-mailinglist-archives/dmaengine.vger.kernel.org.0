Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33BE21EF19
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2020 13:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgGNLUU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jul 2020 07:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbgGNLSr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Jul 2020 07:18:47 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7F6C08E8AA
        for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2020 04:16:09 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f2so20826588wrp.7
        for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2020 04:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NWVbeI3JQ64+Db8G4vi0TII3jbdljajswVKqeX2AaNk=;
        b=pbKjjlMz+yuId3GnPdr+6e7242L15C8zpZ8cI32mV6xd6AgENPK00kT71vMS4zOEUQ
         BZiKrF66/XjLDH28yMZs8xHjFIparf2OgetsOT625Mif3xJ1q8QNLhyQtuK7TGfZUNIr
         CCj18IDVn978g2dBSbIwr5b38Pq9EwmlS120Y77bC8ePRFzM8Q56ZfUktL7RchA2vkT5
         u5WCyG9mExt5AiqtFF84SoZFQZZshdlOkMoEgh6kK8rhIdvqnnVvWrj3OTAyPe9rWQLc
         ErVVxOlolsFySUFnE8kq65UQFNT1RnKfPw0BhzkytqrRJQZNY7Rt5ThFUPrGUW6rf9Ea
         d7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NWVbeI3JQ64+Db8G4vi0TII3jbdljajswVKqeX2AaNk=;
        b=ME7dMnCwAv06RtcTydQuE/XXgvLwI5NftnNzENfXh9HPtkQ0W5so4u2wV9CU5XSzVT
         7g2yhxrZ6FHSGmeKWLDJjauOu6z6hCo/nhdg9gwW7V0A8vmE/TQRSiaCkhVqbmDbWNpY
         T7th0HvbN2xlWvRpmUXKviiLgW+VmDDyuo8KUHV+EWi0NK+mLu3LFeb8eYd0nJa+sirM
         /+hJkY5Uk+Be3cDACuX7xCNcZqoDFep9Iaxaibjrlub1BUXq5LVhrITfvlqb1cguiAkp
         8sjE66MqebxRqelAvf5x2S30BmwjmnKh9czNoSqC4PZY9GZCyEL7aiPRPeNmGGf47A77
         4gvA==
X-Gm-Message-State: AOAM532R5AOWr02t4HvrLlnIp4YCZjyjSL78EjW5NwXTxE8ZkwvkFOPy
        6THbeKnZoAGhUhgxtkg5JZgKdQ==
X-Google-Smtp-Source: ABdhPJy/Z9vM5I8MKYqwiF/ImZ+zlunr0KhgAAKurSmz0v7+QqjmsliobL9ygI2dqTBBUF+btm1W9g==
X-Received: by 2002:a5d:4a84:: with SMTP id o4mr4756252wrq.104.1594725368354;
        Tue, 14 Jul 2020 04:16:08 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id l8sm28566052wrq.15.2020.07.14.04.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 04:16:07 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: [PATCH 16/17] dma: ioat: init: Correct misspelling of function parameter 'c' for channel
Date:   Tue, 14 Jul 2020 12:15:45 +0100
Message-Id: <20200714111546.1755231-17-lee.jones@linaro.org>
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

 drivers/dma/ioat/init.c:608: warning: Function parameter or member 'c' not described in 'ioat_free_chan_resources'
 drivers/dma/ioat/init.c:608: warning: Excess function parameter 'chan' description in 'ioat_free_chan_resources'

Cc: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/ioat/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
index 20a4f36a2f6ea..8a53f5c96b168 100644
--- a/drivers/dma/ioat/init.c
+++ b/drivers/dma/ioat/init.c
@@ -602,7 +602,7 @@ static void ioat_enumerate_channels(struct ioatdma_device *ioat_dma)
 
 /**
  * ioat_free_chan_resources - release all the descriptors
- * @chan: the channel to be cleaned
+ * @c: the channel to be cleaned
  */
 static void ioat_free_chan_resources(struct dma_chan *c)
 {
-- 
2.25.1

