Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC70777E5
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jul 2019 11:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbfG0Jae (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 27 Jul 2019 05:30:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39595 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbfG0Jad (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 27 Jul 2019 05:30:33 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so25888776pgi.6;
        Sat, 27 Jul 2019 02:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=z5sjwqVGCxUQk+QSQ9chKyttBvfdYpP7hwc20jtvK+s=;
        b=YBfh5b4c27FdX9goY2NwNFVVkc7/LBvWciAxEdHe5TqJ91KWXuQkW6IJ2tt38Y0Afb
         rGT7GA1eMt6XSzc1Cmf5PvyD+4rnLQb6XwnjbYIQZGP38tGqhzv5qpbjsewYqSvvySbr
         Qwf0FqLvl4UvYL+7OK4cRrmMlfG4EImnLM4DRiHYjqoFuqUSlIx8kUahVK2I7NCz5B7S
         VuFvu5Jfbm/nHvLr+7bY1QHFEt39tYg3emOfOFg+mTwT+4rvTzaG9rrVHo6HupPuB3fg
         vTXUe9CBC1QJpG7YsInSTHkbffOGS7hUZkLW2m7AO7N9ZdbCZQtwA45PsjwFa6xSshNV
         JaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=z5sjwqVGCxUQk+QSQ9chKyttBvfdYpP7hwc20jtvK+s=;
        b=tLvNVIvb9FWTZwsDgmeKLFpIZ3+JMo+OPcCBB9FLHb4jLkAMAPCFg/U8IK2qOTITqi
         2vs0QnUwQPQbvguzYmyrTfQVxcQ45TT2U6/q6a+seveXKWoHvaSPYMSBaQgf0qNjRF5H
         vo4D9rKyksw8qGW+vCq3rA4YZTeCFaqq6nXidx/xxsiigbiNOjz7n6kgz1IsnNO2WTWX
         2rbfyQ/qHGvfPhfJAiv9MLVHxwZOD9u0OmEdviZf1jRecRvsh6FkeLR5Ud1kbWlQsFTK
         +pQv+skmfW5vX8VC638CezT1++m7dlr+CnOXvcN2Z5BGsvIAiiUPvXTN9EMJA+Wdxb+K
         rRWg==
X-Gm-Message-State: APjAAAU9WkSdYya1KMvFHzRqHZYBOiHjhRA0cWRvDS/qE0N2daZgcBnW
        kXVwwFchQGl+Qvp8csIM8jE=
X-Google-Smtp-Source: APXvYqy7WYLMlwSTVgB+dPwq8qrugVlz8KAywUvi0p/+dVAWFow6ZnujVnwVJPvmTOtHll1h9oSvtA==
X-Received: by 2002:aa7:8804:: with SMTP id c4mr26416099pfo.65.1564219833191;
        Sat, 27 Jul 2019 02:30:33 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id i137sm53435357pgc.4.2019.07.27.02.30.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jul 2019 02:30:32 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] dma: mv_xor: Fix a possible null-pointer dereference in mv_xor_prep_dma_xor()
Date:   Sat, 27 Jul 2019 17:30:27 +0800
Message-Id: <20190727093027.11781-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In mv_xor_prep_dma_xor(), there is an if statement on line 577 to check
whether sw_desc is NULL:
    if (sw_desc)

When sw_desc is NULL, it is used on line 594:
    dev_dbg(..., sw_desc, &sw_desc->async_tx);

Thus, a possible null-pointer dereference may occur.

To fix this bug, sw_desc is checked before being used.

This bug is found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/dma/mv_xor.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 0ac8e7b34e12..08c0b2a9eb32 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -589,9 +589,11 @@ mv_xor_prep_dma_xor(struct dma_chan *chan, dma_addr_t dest, dma_addr_t *src,
 		}
 	}
 
-	dev_dbg(mv_chan_to_devp(mv_chan),
-		"%s sw_desc %p async_tx %p \n",
-		__func__, sw_desc, &sw_desc->async_tx);
+	if (sw_desc) {
+		dev_dbg(mv_chan_to_devp(mv_chan),
+			"%s sw_desc %p async_tx %p \n",
+			__func__, sw_desc, &sw_desc->async_tx);
+	}
 	return sw_desc ? &sw_desc->async_tx : NULL;
 }
 
-- 
2.17.0

