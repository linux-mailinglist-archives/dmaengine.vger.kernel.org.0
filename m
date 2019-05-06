Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE1514549
	for <lists+dmaengine@lfdr.de>; Mon,  6 May 2019 09:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfEFH3E (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 May 2019 03:29:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44306 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfEFH3E (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 May 2019 03:29:04 -0400
Received: by mail-pf1-f195.google.com with SMTP id y13so6272920pfm.11
        for <dmaengine@vger.kernel.org>; Mon, 06 May 2019 00:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=+ZQ7qGOLCohxzfhci4Colal/Wo1QqAxCtZ4JkQsFwsU=;
        b=m2MNCVwUhd8v/6Vi+YLmIm4RORKUiK2+BdHKTpNvCPAn0wxJbDla+fHvLPcWFxF24t
         T84EOuE6HFY1fWHQmAWxAqsqCJE28N/Q0G7KNTmeQMle8HgYrJSPmR5KWP3wr/cLnM1j
         /c0f7R2vJZshddyoxk2SyPRQECINjDxmV9fqQncGVl/QA9GvfeiJszqIDU4dgDaaIQaI
         WQrX8pw24wULbhMr1vlYfJW2Et9TjSTQaAOJsfn6a/mZ/NWRPupVVl3sEhHeRAs3cufW
         Ifjyz6nHqboVfhQov7y4HniXpqwS8tdMWA3pnpWPwTtmvsy43maQ5kGmZOYGwavkSJLB
         ta6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=+ZQ7qGOLCohxzfhci4Colal/Wo1QqAxCtZ4JkQsFwsU=;
        b=ieaYHqbIkSSMj+QBs+uOphDMAv8Var1HUjOR6GhYilCwaaUeQ+7CT4O+coAKdz1VfT
         Y3cSLKMzVZVyO65CP8iAWUudBNQOgcEeVACJtxqW27RdG3xMP8iZRImgImM/ZkLbwiml
         ELrOofUMFWk0f8LTZVobQEsfbdTNqQdaQEeNAnT1MdFLC8MPpOWn9BWCJO8GPsjc7XUt
         0j9/K8FXPnFLxfxmGAssSFdz2YTsU2gBEJmuvMqe9iK5teHC+fbpCi4DPrLAx/2UqoEM
         Bp9AKPdY/b35+nhjdTuOafk+jmRDjpdD8/aO1HQu8Mm13yTGFlg2/e2Vqo6pbScrwUFX
         0FvQ==
X-Gm-Message-State: APjAAAXTnfgt3OddJVeCpabkZw/AJC6vFwfNqPwj3SRgXx22TBlNIDPI
        r3gE24aWP4VkMPzZLwYe4AOBhw==
X-Google-Smtp-Source: APXvYqwWb4P6O7/nv5TFfuz5VLxhEIjbuhhBJ23cJf8CsXjlTK7gH97n3xhYJyCDvh9Jbr5aDD8xSA==
X-Received: by 2002:a63:1a03:: with SMTP id a3mr1369341pga.412.1557127743650;
        Mon, 06 May 2019 00:29:03 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id w38sm21700894pgk.90.2019.05.06.00.29.00
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 00:29:03 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     eric.long@unisoc.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        vincent.guittot@linaro.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] dmaengine: sprd: Fix block length overflow
Date:   Mon,  6 May 2019 15:28:31 +0800
Message-Id: <8f9a1748488e9d890995c158375482285253cc46.1557127239.git.baolin.wang@linaro.org>
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

The maximum value of block length is 0xffff, so if the configured transfer length
is more than 0xffff, that will cause block length overflow to lead a configuration
error.

Thus we can set block length as the maximum burst length to avoid this issue, since
the maximum burst length will not be a big value which is more than 0xffff.

Signed-off-by: Eric Long <eric.long@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sprd-dma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 0f92e60..a01c232 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -778,7 +778,7 @@ static int sprd_dma_fill_desc(struct dma_chan *chan,
 	temp |= slave_cfg->src_maxburst & SPRD_DMA_FRG_LEN_MASK;
 	hw->frg_len = temp;
 
-	hw->blk_len = len & SPRD_DMA_BLK_LEN_MASK;
+	hw->blk_len = slave_cfg->src_maxburst & SPRD_DMA_BLK_LEN_MASK;
 	hw->trsc_len = len & SPRD_DMA_TRSC_LEN_MASK;
 
 	temp = (dst_step & SPRD_DMA_TRSF_STEP_MASK) << SPRD_DMA_DEST_TRSF_STEP_OFFSET;
-- 
1.7.9.5

