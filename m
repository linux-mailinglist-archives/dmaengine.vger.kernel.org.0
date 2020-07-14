Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E853121EF1E
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2020 13:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgGNLUg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jul 2020 07:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbgGNLSr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Jul 2020 07:18:47 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74D8C08E8AB
        for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2020 04:16:11 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o8so4768253wmh.4
        for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2020 04:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+6/z2bmjZMbhtqS1hEM9SRMyZids/5Sm1LJ5PQCQzW4=;
        b=olMroX2nvIY5Lf+mJdh7YdFYN9DJVM3DML7ddb9rOUmNTds3C+m2JdC3mqOc4y2yki
         oCjN/ROWc7AHqc9tDEJzhS48Ft6N8WDIfr4nT2lTE5jdLWQGIWrolpNjO+lPcicdCRRM
         2fCsqXPM7bJUnvwrgFNVo7ICmUoZdIFs0+zJzOFi3XIgI9grTk89B6Pv4TQQAvkhtRye
         9sjSmijV4C2Z3rQ8tSb74WzoWGcSTqF9z7JoxwTfy5DhX28xoARq2ihF4ykZe7GW8r58
         nDxZdTjaN05xW+eeHH3pFOqwpav7WW2J+QyIHz+GahF3UcEzGl7obV8i3hDK+YXlBs7R
         Pf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+6/z2bmjZMbhtqS1hEM9SRMyZids/5Sm1LJ5PQCQzW4=;
        b=OyYs/dYx8sdl4nkqv++QdHfFkv5yZ7FHzkjKRmCFrD5XLhdwKucQoFajHNe8NwmArt
         TdjDUfrXvzLXWPdfV7K5b5mVR/2ukpQ13vMLjIofirL3mfm/QW62dHY9GrdH16fI4oOo
         nRN22u+L85HRi6Zkm5YKWqpBnByS5ceXp5CxmeQR2rOEo7jRu3Cw1fxmHYoHqOf31Lyl
         A6hO3MB6Y6iSmzVaXtt4AOn8qRwwGiu7oQH5aFpssCnUEmyU8GeQGoC8hK03bWLb+F9p
         9Qo9B43lnQA2r74HpHebxVUmDAQIuFKGj++Z+KoTT2ARgAwPl/PcMxf3uNt6vyQ0KklP
         yS4w==
X-Gm-Message-State: AOAM531FYehaHnYpU8o5jibfI3HVYfiv4J6lbZ5h2xfEcowgzvyznNlo
        y+0VAucn41WsmAsMaUmHsIyUwg==
X-Google-Smtp-Source: ABdhPJzfCBA237+MDiPPiC6gnBUiuuivn5CvYJKDoBxN2PB52EY3xNb72wTKP7tCyZ9qJUnt4SpQXw==
X-Received: by 2002:a1c:7209:: with SMTP id n9mr3892120wmc.150.1594725369516;
        Tue, 14 Jul 2020 04:16:09 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id l8sm28566052wrq.15.2020.07.14.04.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 04:16:08 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Leonid Ravich <Leonid.Ravich@emc.com>
Subject: [PATCH 17/17] dma: ioat: dma: Fix some parameter misspelling and provide description for phys_complete
Date:   Tue, 14 Jul 2020 12:15:46 +0100
Message-Id: <20200714111546.1755231-18-lee.jones@linaro.org>
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

 drivers/dma/ioat/dma.c:202: warning: Function parameter or member 'ioat_chan' not described in 'ioat_update_pending'
 drivers/dma/ioat/dma.c:202: warning: Excess function parameter 'ioat' description in 'ioat_update_pending'
 drivers/dma/ioat/dma.c:465: warning: Function parameter or member 'ioat_chan' not described in 'ioat_check_space_lock'
 drivers/dma/ioat/dma.c:465: warning: Excess function parameter 'ioat' description in 'ioat_check_space_lock'
 drivers/dma/ioat/dma.c:591: warning: Function parameter or member 'ioat_chan' not described in '__cleanup'
 drivers/dma/ioat/dma.c:591: warning: Function parameter or member 'phys_complete' not described in '__cleanup'
 drivers/dma/ioat/dma.c:591: warning: Excess function parameter 'ioat' description in '__cleanup'

Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Leonid Ravich <Leonid.Ravich@emc.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/ioat/dma.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
index fd782aee02d92..a814b200299bf 100644
--- a/drivers/dma/ioat/dma.c
+++ b/drivers/dma/ioat/dma.c
@@ -193,7 +193,7 @@ void ioat_issue_pending(struct dma_chan *c)
 
 /**
  * ioat_update_pending - log pending descriptors
- * @ioat: ioat+ channel
+ * @ioat_chan: ioat+ channel
  *
  * Check if the number of unsubmitted descriptors has exceeded the
  * watermark.  Called with prep_lock held
@@ -457,7 +457,7 @@ ioat_alloc_ring(struct dma_chan *c, int order, gfp_t flags)
 
 /**
  * ioat_check_space_lock - verify space and grab ring producer lock
- * @ioat: ioat,3 channel (ring) to operate on
+ * @ioat_chan: ioat,3 channel (ring) to operate on
  * @num_descs: allocation length
  */
 int ioat_check_space_lock(struct ioatdma_chan *ioat_chan, int num_descs)
@@ -585,7 +585,8 @@ desc_get_errstat(struct ioatdma_chan *ioat_chan, struct ioat_ring_ent *desc)
 
 /**
  * __cleanup - reclaim used descriptors
- * @ioat: channel (ring) to clean
+ * @ioat_chan: channel (ring) to clean
+ * @phys_complete: zeroed (or not) completion address (from status)
  */
 static void __cleanup(struct ioatdma_chan *ioat_chan, dma_addr_t phys_complete)
 {
-- 
2.25.1

