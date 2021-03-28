Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA90D34C034
	for <lists+dmaengine@lfdr.de>; Mon, 29 Mar 2021 01:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhC1X6V (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 28 Mar 2021 19:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbhC1X6D (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 28 Mar 2021 19:58:03 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2C5C061756;
        Sun, 28 Mar 2021 16:58:02 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id u8so8198391qtq.12;
        Sun, 28 Mar 2021 16:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bpe0M5+HDAqDdeQIOejQbDfFbOvYGihGTywPqCQfPxk=;
        b=UBnTpPl9V62AUBrqC/YSqABPupQ76JLXTf9wdWJSwN8Y02M91Cv2rn4ZwjhokBjvOT
         caKPPonpNMbkYJsmubQ2Bumfsz0OvmkkTWS8FwgdpAJJ2UjLRJp7acfTyFudWVBAqVM4
         mAaT3aHaultxmZCgXXXV5OvJ6J1msraQIsZAdfJkw4uSiaZABZyAHr7r8flbrOwvpPZH
         zBFD5EMOq2xPgbxunhlKskRUqPhi8QLQoyZ1kqDj7sVSl05HXPEVHwZylycvJDJMix34
         BhEq84yLvrSkLfYTrEw/MPY6YGk4Ihk/VSSgfbjYkcNwFP0GEpF+EGDzHiMvb4HSukdQ
         PlRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bpe0M5+HDAqDdeQIOejQbDfFbOvYGihGTywPqCQfPxk=;
        b=soMxlOg6TJDfICshsgj86+iIHz6HK1vkXOChd+ZsrJPjFfwbNEwxWaXguYRrAQ6fqy
         z5Ft/43sNKNxB1fMOfxMBtpIloumRVTRi8LvjphuU5mRqgtHo8gzdyat4s7vMuZvIUX1
         8mSPK1BF7Km3aBysjYqGOOtFyTwmJvM4OEBw4QESOYO1QDyvvLouXGnKm5F/YRGFyxUU
         9dMDO79Wj/Oftgq/OIb2GRFSliyz7p6+vjbaSSSXEoxZoXn57VRNu0rLD8qipRkr5Bsi
         lPNB5U1a6GV0k73+HZOb3JAo9+h4CCztYA0h9dbX7hdF3QChpUk2NMHeuTMlCNaBXRF8
         2N/A==
X-Gm-Message-State: AOAM530o9LXXXImHLJDXOOv1nEKxj+4GYfzEmhBrkg/mUimtu8Y/4zoZ
        kCz8sRPSe8W8CFAcevqSflD7ZCBo9kl1U1wD
X-Google-Smtp-Source: ABdhPJz4aA7ldRQgsCMEBAdvXkEvBGcKpJz3Kr32GBN9DAQyr64A5Qqw5tpT7IRp1HeHqf9g6ttT3w==
X-Received: by 2002:ac8:698f:: with SMTP id o15mr21281625qtq.39.1616975881895;
        Sun, 28 Mar 2021 16:58:01 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
        by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 16:58:01 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, dave.jiang@intel.com,
        dan.j.williams@intel.com
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 25/30] ste_dma40.c: Few spello fixes
Date:   Mon, 29 Mar 2021 05:23:21 +0530
Message-Id: <ef2c19d475895f8a627335e37560a18d28c062e9.1616971780.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616971780.git.unixbhaskar@gmail.com>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

s/ealier/earlier/
s/orignal/original/
s/manouver/maneuver/
s/transfer/transfer/
s/succees/success/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/ste_dma40.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 265d7c07b348..39fa2fb74057 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -155,7 +155,7 @@ static __maybe_unused u32 d40_backup_regs[] = {

 /*
  * since 9540 and 8540 has the same HW revision
- * use v4a for 9540 or ealier
+ * use v4a for 9540 or earlier
  * use v4b for 8540 or later
  * HW revision:
  * DB8500ed has revision 0
@@ -382,7 +382,7 @@ struct d40_desc {
  *
  * @base: The virtual address of LCLA. 18 bit aligned.
  * @dma_addr: DMA address, if mapped
- * @base_unaligned: The orignal kmalloc pointer, if kmalloc is used.
+ * @base_unaligned: The original kmalloc pointer, if kmalloc is used.
  * This pointer is only there for clean-up on error.
  * @pages: The number of pages needed for all physical channels.
  * Only used later for clean-up on error
@@ -1630,7 +1630,7 @@ static void dma_tasklet(struct tasklet_struct *t)

 	return;
  check_pending_tx:
-	/* Rescue manouver if receiving double interrupts */
+	/* Rescue maneuver if receiving double interrupts */
 	if (d40c->pending_tx > 0)
 		d40c->pending_tx--;
 	spin_unlock_irqrestore(&d40c->lock, flags);
@@ -1970,7 +1970,7 @@ static int d40_config_memcpy(struct d40_chan *d40c)
 		   dma_has_cap(DMA_SLAVE, cap)) {
 		d40c->dma_cfg = dma40_memcpy_conf_phy;

-		/* Generate interrrupt at end of transfer or relink. */
+		/* Generate interrupt at end of transfer or relink. */
 		d40c->dst_def_cfg |= BIT(D40_SREG_CFG_TIM_POS);

 		/* Generate interrupt on error. */
@@ -3415,7 +3415,7 @@ static int __init d40_lcla_allocate(struct d40_base *base)
 		base->lcla_pool.base = (void *)page_list[i];
 	} else {
 		/*
-		 * After many attempts and no succees with finding the correct
+		 * After many attempts and no success with finding the correct
 		 * alignment, try with allocating a big buffer.
 		 */
 		dev_warn(base->dev,
--
2.26.3

