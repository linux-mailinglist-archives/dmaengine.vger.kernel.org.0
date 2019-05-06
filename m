Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 875911454A
	for <lists+dmaengine@lfdr.de>; Mon,  6 May 2019 09:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfEFH3I (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 May 2019 03:29:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37160 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfEFH3H (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 May 2019 03:29:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id e6so6035901pgc.4
        for <dmaengine@vger.kernel.org>; Mon, 06 May 2019 00:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=f7WxjUUjnOPlZM9+bRj5MrZBRrYrZS5QSjQsKajsB4c=;
        b=fczeMukFRjRRR+1aDX01a1Sr2mHi7DtR4Gtz1E36ZgvfNGRxI7VHRp63sJWk5xuUVd
         o0Wb7seFcinpcZpharAZaaHr5ZZGvvzOMV9ME0H6FOdjrsnB9mbgM93u5eeuFSKsbI6j
         NYjZlaRe0WtRif1binGpkerwbW13qWMjK1tvAo/3YmkGInyZMpD9Y32gNvCyAB646HIy
         Z6vrWTbuSTDgmZ2BDBFp/TwHbNsDAHuQJYFoyyKd2YCECrvm4levP/dICyXtI8vJfDDQ
         OxWW8Ms0qtuB4MaRHjZs4uGlgrQRnwXpWURKM/IG96X4PBlpNiPvTTlbvE622E9RtDPk
         X/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=f7WxjUUjnOPlZM9+bRj5MrZBRrYrZS5QSjQsKajsB4c=;
        b=Ht/y4OCC6Urqt3tCJb8grPPwYP4ntIsKrcdmrGM/SpaeYZ+OyGXkDb0mLsJ0fjboNN
         3pYINdGsiaaCjya3qnQHvcRGFgaYG0yMbJ87ewCnabBJj/z9+c7p1aV97lKZp8rGI8J6
         mo/K700wbIis3I9HXy6U7Xi28RsFMB0Un/WFI9XkxLhxP1/ruS+ALLDBvId0Ibly0ivz
         t9T7RYwTXrYh96bR6M/DBG8efU5NxiyGpZuIwc8HshnTayWcIaJnfwiLqiAAt5+3zJvR
         8/RDO7Me6pOQ5bjQRP4A35BzWfu5IulE6Y6puFNpyedrGK6BCYhPLTijuZCP+m94G0ye
         nYEw==
X-Gm-Message-State: APjAAAVZsnwrvWH1PQoEtFBptw8j90fGuj+lVoAOrd2KvSxoC5zq9oaU
        9cyuRhkB3gc1vPkiC9cnVi59cg==
X-Google-Smtp-Source: APXvYqw0/jP7NTJPqlt/wBZcCyCNPM0vzi6zk1f3mzoj6y3qOVMIOC7nx5Jf7rPfTEARDSVfB5uhLQ==
X-Received: by 2002:a63:e451:: with SMTP id i17mr30530636pgk.312.1557127746838;
        Mon, 06 May 2019 00:29:06 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id w38sm21700894pgk.90.2019.05.06.00.29.03
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 00:29:06 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     eric.long@unisoc.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        vincent.guittot@linaro.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] dmaengine: sprd: Fix the right place to configure 2-stage transfer
Date:   Mon,  6 May 2019 15:28:32 +0800
Message-Id: <7eb64b3319cfa1859f2912398700d4204553c028.1557127239.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1557127239.git.baolin.wang@linaro.org>
References: <cover.1557127239.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1557127239.git.baolin.wang@linaro.org>
References: <cover.1557127239.git.baolin.wang@linaro.org>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Eric Long <eric.long@unisoc.com>

Move the 2-stage configuration before configuring the link-list mode,
since we will use some 2-stage configuration to fill the link-list
configuration.

Signed-off-by: Eric Long <eric.long@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sprd-dma.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index a01c232..01abed5 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -911,6 +911,12 @@ static int sprd_dma_fill_linklist_desc(struct dma_chan *chan,
 		schan->linklist.virt_addr = 0;
 	}
 
+	/* Set channel mode and trigger mode for 2-stage transfer */
+	schan->chn_mode =
+		(flags >> SPRD_DMA_CHN_MODE_SHIFT) & SPRD_DMA_CHN_MODE_MASK;
+	schan->trg_mode =
+		(flags >> SPRD_DMA_TRG_MODE_SHIFT) & SPRD_DMA_TRG_MODE_MASK;
+
 	sdesc = kzalloc(sizeof(*sdesc), GFP_NOWAIT);
 	if (!sdesc)
 		return NULL;
@@ -944,12 +950,6 @@ static int sprd_dma_fill_linklist_desc(struct dma_chan *chan,
 		}
 	}
 
-	/* Set channel mode and trigger mode for 2-stage transfer */
-	schan->chn_mode =
-		(flags >> SPRD_DMA_CHN_MODE_SHIFT) & SPRD_DMA_CHN_MODE_MASK;
-	schan->trg_mode =
-		(flags >> SPRD_DMA_TRG_MODE_SHIFT) & SPRD_DMA_TRG_MODE_MASK;
-
 	ret = sprd_dma_fill_desc(chan, &sdesc->chn_hw, 0, 0, src, dst, len,
 				 dir, flags, slave_cfg);
 	if (ret) {
-- 
1.7.9.5

