Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D30634C022
	for <lists+dmaengine@lfdr.de>; Mon, 29 Mar 2021 01:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbhC1X5r (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 28 Mar 2021 19:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbhC1X5h (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 28 Mar 2021 19:57:37 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A29EC061756;
        Sun, 28 Mar 2021 16:57:37 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id s2so8204431qtx.10;
        Sun, 28 Mar 2021 16:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qTMepEQ2KULfrsHgV8Kxlgt84PsBxxGqM80tVNIqbWY=;
        b=bTEbIGlULsXvf6mp9eD0MKL9UGtjeyV3vz6uIDnSq3FIpNNN4nSxkCxJXDeGfDDYyB
         zrGFOLTVdImkvTyvLeq0/4E+jnMEn98Q26GKTp+Nz0mhhF+ZDnkEgHrk7CFt7Ca0UvL4
         zn/PcJ5S81UeZvLDHEV66orBfcuymqrZb2/bTljWCMBn9pDs5sHfT9lWNzoSKvdiRlgf
         XdUsJFchXNreOvNlDTRTJnKriv/0ujteXmBg14gklE8iTN8dRgUSPOi0bMkwDOBHnpR4
         zgdlEoqgFMO6iS16vaq1e+iDX2yJvKTuHCAjQVE2Bd5zNUG+/3CwHCC8hFaVUgmb1NiM
         gWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qTMepEQ2KULfrsHgV8Kxlgt84PsBxxGqM80tVNIqbWY=;
        b=IEKpMm2CfQH6N3hrIVRLrcQxn1RYMTuG1uGM3ie7QwmbrvZ5mMiR0fRez9ioBaqPUQ
         he/wN+zG3mHPzh+ufy5J6FW9CMDC1rPTmYBpS2D9ZC2GYJahqbONqjLJaGB5Ptwyin9A
         7TpiHz3yG3tIS6yAwbi2B17WWhVrIKDUqj6pvXi3U7kviKcgT/hizFY8h+hmwU18L8u4
         JvaFe8A2Ysu4iz21ffqdtgTYkqiC6qqwlrTVULTdcd7adaGdS20PErHFB3pliu6grCZP
         kS7dfuAZecqgVFOheXSUxeFs7HYLlsIwyxJnGgzAs2MtrYNaBQHf9Y0wQyxNsVTZ55KK
         I3ZQ==
X-Gm-Message-State: AOAM5321N5OrtvUXKJrEJlHhx78vEa2XyPdrn3nvMLRMonnOfvBg8Pyb
        FVimYYGEvsVvPmAs/3Mqp+wDQd6bEnY87ttw
X-Google-Smtp-Source: ABdhPJwRTC1BpC2ZmqFvyCckRvvuwnANkqHAZvJtuc4Mu8nM99Nfdg+GTNYLo2psV/k5ZUFbmcYhiA==
X-Received: by 2002:ac8:dcc:: with SMTP id t12mr13997202qti.219.1616975856552;
        Sun, 28 Mar 2021 16:57:36 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
        by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 16:57:36 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, dave.jiang@intel.com,
        dan.j.williams@intel.com
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 20/30] at_hdmac.c: Quite a few spello fixes
Date:   Mon, 29 Mar 2021 05:23:16 +0530
Message-Id: <d4e6597ed691d7faf4b35ca75e392706bdb16d1d.1616971780.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616971780.git.unixbhaskar@gmail.com>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

s/tranfers/transfers/
s/maxium/maximum/
s/previouly/previously/
s/broked/broken/
s/embedds/embeds/ .... three different places.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/at_hdmac.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 30ae36124b1d..02c09532a9e4 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -374,11 +374,11 @@ static int atc_get_bytes_left(struct dma_chan *chan, dma_cookie_t cookie)
 		 * a second time. If the two consecutive read values of the DSCR
 		 * are the same then we assume both refers to the very same
 		 * child descriptor as well as the CTRLA value read inbetween
-		 * does. For cyclic tranfers, the assumption is that a full loop
+		 * does. For cyclic transfers, the assumption is that a full loop
 		 * is "not so fast".
 		 * If the two DSCR values are different, we read again the CTRLA
 		 * then the DSCR till two consecutive read values from DSCR are
-		 * equal or till the maxium trials is reach.
+		 * equal or till the maximum trials is reach.
 		 * This algorithm is very unlikely not to find a stable value for
 		 * DSCR.
 		 */
@@ -403,7 +403,7 @@ static int atc_get_bytes_left(struct dma_chan *chan, dma_cookie_t cookie)

 			/*
 			 * DSCR has changed inside the DMA controller, so the
-			 * previouly read value of CTRLA may refer to an already
+			 * previously read value of CTRLA may refer to an already
 			 * processed descriptor hence could be outdated.
 			 * We need to update ctrla to match the current
 			 * descriptor.
@@ -564,7 +564,7 @@ static void atc_handle_error(struct at_dma_chan *atchan)
 	spin_lock_irqsave(&atchan->lock, flags);
 	/*
 	 * The descriptor currently at the head of the active list is
-	 * broked. Since we don't have any way to report errors, we'll
+	 * broken. Since we don't have any way to report errors, we'll
 	 * just have to scream loudly and try to carry on.
 	 */
 	bad_desc = atc_first_active(atchan);
@@ -870,7 +870,7 @@ atc_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 		atc_desc_chain(&first, &prev, desc);
 	}

-	/* First descriptor of the chain embedds additional information */
+	/* First descriptor of the chain embeds additional information */
 	first->txd.cookie = -EBUSY;
 	first->total_len = len;

@@ -1199,7 +1199,7 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	/* set end-of-link to the last link descriptor of list*/
 	set_desc_eol(prev);

-	/* First descriptor of the chain embedds additional information */
+	/* First descriptor of the chain embeds additional information */
 	first->txd.cookie = -EBUSY;
 	first->total_len = total_len;

@@ -1358,7 +1358,7 @@ atc_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
 	/* lets make a cyclic list */
 	prev->lli.dscr = first->txd.phys;

-	/* First descriptor of the chain embedds additional information */
+	/* First descriptor of the chain embeds additional information */
 	first->txd.cookie = -EBUSY;
 	first->total_len = buf_len;

--
2.26.3

