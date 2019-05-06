Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A792714548
	for <lists+dmaengine@lfdr.de>; Mon,  6 May 2019 09:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfEFH3A (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 May 2019 03:29:00 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36853 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbfEFH3A (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 May 2019 03:29:00 -0400
Received: by mail-pl1-f196.google.com with SMTP id cb4so1999891plb.3
        for <dmaengine@vger.kernel.org>; Mon, 06 May 2019 00:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=l9ir60nNJwBbII3Z7YfygeQjey9MNonvD8+mCs5l+c4=;
        b=n2PSKrwdQj4XW6hHAVV1KikTlODEKZzE2pd01SXQRpdWNe17PsxQpsoO8+rpMrDU4+
         gjX+fvva0GM0YwQOAlkH3bQ0L3gN6CvjXX8LKTjcLnJ8JfIYMAaJMJ0Rt/HGr9KwWi3q
         sno8NGTlrG+7pdn6+ZSh+MtYL71LgwDH70MupbV4iBGbY+dgGqLU2A9QmIc30OtJC3eJ
         SJhoBXHge6hQ8fZ34sSO0YDLThB5T70SfFYgmEPtROCObtK38067TZ1Y6vyWKBJCgwfe
         vOc7avrYdgMQdfGTpjGs7b/OBoQXeMno7vWPv2+VHoI3Vw5np1I8CNc5t2EOAR9dYB59
         a1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=l9ir60nNJwBbII3Z7YfygeQjey9MNonvD8+mCs5l+c4=;
        b=Wte/1lE/Z1svuQA6IsmEHcouAhe3M1Bc8jdce8Qm42FFPABSiYEVUWMkVkziw0R/rR
         Rb5OmuJ4aK8wOWy+GzqdtbRCtAlyP6EL1+lIOk588pJogu34yXsvtNQEfirhLZ4dqTcv
         0B8c3/AS0EJ4eTzkIvBBW1/hWAoKMWKMxzQBkYn2voBxddS6965DK1N9hII57/CkazDL
         43O2W7DOK1G/z3xCy1AOysbwv4W5Dkcsi8SlW2n7XaVObKAyX3efD+I7Sphx0m5lwulY
         Lp4YjCDcLRX5F0B60OcBGgKEjBwzaBGQxOyjp9KwHXQiiY/l8QDO9wIs/XPsJOk/iaw7
         XBkg==
X-Gm-Message-State: APjAAAWlzT0muHs1cfBDkBP4p2rbo3H/W/ra6GtFnsTWJOhClSupVRkd
        rYjQ4BSaMJTMrdPDrMFCuOLmCA==
X-Google-Smtp-Source: APXvYqzDakPzBV2yCvqDzE+c+yTPMnu+jdQfQeYEh/K2/WSAjZD3Nyf1PYODBQn9UQlykVynV2T3PQ==
X-Received: by 2002:a17:902:141:: with SMTP id 59mr30356662plb.132.1557127740096;
        Mon, 06 May 2019 00:29:00 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id w38sm21700894pgk.90.2019.05.06.00.28.56
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 00:28:59 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     eric.long@unisoc.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        vincent.guittot@linaro.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] dmaengine: sprd: Fix the incorrect start for 2-stage destination channels
Date:   Mon,  6 May 2019 15:28:30 +0800
Message-Id: <dc1c179c93ac1cc2d6f19d0675f3241900813900.1557127239.git.baolin.wang@linaro.org>
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

The 2-stage destination channel will be triggered by source channel
automatically, which means we should not trigger it by software request.

Signed-off-by: Eric Long <eric.long@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sprd-dma.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 431e289..0f92e60 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -510,7 +510,9 @@ static void sprd_dma_start(struct sprd_dma_chn *schan)
 	sprd_dma_set_uid(schan);
 	sprd_dma_enable_chn(schan);
 
-	if (schan->dev_id == SPRD_DMA_SOFTWARE_UID)
+	if (schan->dev_id == SPRD_DMA_SOFTWARE_UID &&
+	    schan->chn_mode != SPRD_DMA_DST_CHN0 &&
+	    schan->chn_mode != SPRD_DMA_DST_CHN1)
 		sprd_dma_soft_request(schan);
 }
 
-- 
1.7.9.5

