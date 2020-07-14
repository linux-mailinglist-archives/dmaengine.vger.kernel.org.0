Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6110A21EF03
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2020 13:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgGNLSw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jul 2020 07:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbgGNLQs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Jul 2020 07:16:48 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852EBC08C5FF
        for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2020 04:16:04 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z15so20874385wrl.8
        for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2020 04:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NG9Wo5yoqPGjiyqodzKSv+oNiGoDZQc2LrtiOZLw/AM=;
        b=QMwhtxDa+JsIYLGkUIZnWg3AJTpgFH0ficDCJzPtKLoaZCg8YduENGKsRoTzfb0QTz
         Gyu3Cqsat4DTRiNwff9MhhGJxWAsooiZxVz2Yp/6x0RpBecs9ejTuRPUEpJUZG75fi3X
         +P6gjwJGwpRpgD6jnp7+9mxe0EtP29RHfFxLUFtSXHH/C+je3VQ7E40NHqdEoGoiuWAD
         bIbdmUhQEcsv+lomE5TNhgItLBYNn65TwW9BP3v2Bw4Ie4p4y+BC0M4QzjX5NB01jxyG
         VlD9mWRFwKCxJVSb/6HyXNPrS6UmSuXj9Ya3O8ddMBXpU5Ree0hlB8zVke5Id4lo3q6n
         u0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NG9Wo5yoqPGjiyqodzKSv+oNiGoDZQc2LrtiOZLw/AM=;
        b=OhUM7z5JX31qh7JxCy3iOPaoTqFkUFH7iiBPoMqG191fSUwn25AONSjTRZ9vrAemtp
         St6u40jb9m9Uy1fpRsg5sfPX+czPYkdIFf8rv/P7mAXSdXA5gfds2rR/alFZ+E6JXEwy
         Z03806IpmcHXh2OT1mnoRWtdM9tL1HSnaigeq1CRhlRAcYdZ3qUL93g3HyuiYl27W8dM
         TQE0m4NXPwOCPAWg634S1X8VtF2nwXRDyKQ/B0lbaBF+IY8A9AyE5KWgh9eJyIJz1rtk
         /XiHmyte0NmvCSmIdUSQi9PEk5Eq6kYF/XGXLGC83f+AQv7XTrGrl67KBYkjDIofVKSx
         QTNw==
X-Gm-Message-State: AOAM531U95/DwT8ze+FK+Z6DbfdQcdTMp1YqSWuW/Z663GugxKBtRLYz
        k/77B9Nnw57oO1R3HrtBNlvbcw==
X-Google-Smtp-Source: ABdhPJzQhzUPxkgJqMX4nrpyi4zj2gxa+lDyykGrb8nrWKpjpsCsNGmOs+AiZhWEbBSh2KpnpmRSug==
X-Received: by 2002:adf:f388:: with SMTP id m8mr4801297wro.338.1594725363325;
        Tue, 14 Jul 2020 04:16:03 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id l8sm28566052wrq.15.2020.07.14.04.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 04:16:02 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 12/17] dma: iop-adma: Function parameter documentation must adhere to correct formatting
Date:   Tue, 14 Jul 2020 12:15:41 +0100
Message-Id: <20200714111546.1755231-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714111546.1755231-1-lee.jones@linaro.org>
References: <20200714111546.1755231-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Also remove superfluous entry.

Fixes the following W=1 kernel build warning(s):

 drivers/dma/iop-adma.c:418: warning: Function parameter or member 'chan' not described in 'iop_adma_alloc_chan_resources'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/iop-adma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/iop-adma.c b/drivers/dma/iop-adma.c
index db0e274126fb7..3350bffb2e937 100644
--- a/drivers/dma/iop-adma.c
+++ b/drivers/dma/iop-adma.c
@@ -406,8 +406,7 @@ static void iop_chan_start_null_xor(struct iop_adma_chan *iop_chan);
 
 /**
  * iop_adma_alloc_chan_resources -  returns the number of allocated descriptors
- * @chan - allocate descriptor resources for this channel
- * @client - current client requesting the channel be ready for requests
+ * @chan: allocate descriptor resources for this channel
  *
  * Note: We keep the slots for 1 operation on iop_chan->chain at all times.  To
  * avoid deadlock, via async_xor, num_descs_in_pool must at a minimum be
-- 
2.25.1

