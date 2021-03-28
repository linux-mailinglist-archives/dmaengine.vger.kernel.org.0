Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18EF234C010
	for <lists+dmaengine@lfdr.de>; Mon, 29 Mar 2021 01:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbhC1X5P (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 28 Mar 2021 19:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbhC1X5I (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 28 Mar 2021 19:57:08 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26017C061756;
        Sun, 28 Mar 2021 16:57:08 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id q26so10932656qkm.6;
        Sun, 28 Mar 2021 16:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ZQIptdaKO+NG6KGHA5S2pjM0OS7naQnCt9zgnNYCE0=;
        b=Gm9tUcw1/+mThRDpyyzzMTwMHDKH9vZpafertqfrSZ5YO9KbE3sAww3oZ8XGMiAhRt
         kgtAGKj9dtXo99Szxu7K4JpbuKgBBIZREfyljwoHuiTIM5ZAd/CKQ0umxuj//O71kbxD
         Eorzfcnc99sIfIq6B+POBj5vgl6pz1tdC7ugns0aQrf9x/NJct0viJIWVNhC6Y2Bw3k5
         +zV83HR64ZTrH1sIkOEbsmWYi035hsyGGF+Rxz5h3YrJ34Fc/SSZo4abf7eLvn47HyCZ
         1VehmmjVpqRm3naf7dKNpOzu4sq3YMJBnKtBt196sX4MubPgCqv7idERRFBCAhH7OBQ+
         GtVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ZQIptdaKO+NG6KGHA5S2pjM0OS7naQnCt9zgnNYCE0=;
        b=VhPn/r3h6LWckdEFZNaKiSyEe6DihKsdJWEOo/mk65WEy0cwlkaS/S/sLLZifdIrxx
         MIgrVo36pScymqImiPkTMCDTHUtjCWGVynqJX9CF2RiPl/7NS/htG2NeDD6Q22j5ZfR5
         WjJL5wNDg5APu1HYTvuGsVz/RyyjT8goqOMj/9lAKYLTpt37fGJfTckMZhq2sKHBIarE
         /z1KgkjcqHLZOk3HrtWX1KLAV7WHNVguDjBw8LDIuiFichLzVKdPrUQVcWnqZjOeLQVg
         kiw5j2nkDJmlmaWT4tL9F3q3G+J8OnMaNaY23jtfqMOIGMwrIajMFKKOiUy204j7Rw+y
         h1+A==
X-Gm-Message-State: AOAM531b50Uh3v6L/JgQw9lhyg4n05+/mwhkYet7/WSdUficnw2iG4NO
        A9bXibAgdyP6CdLIX61+pY6J2Fc+SWpNsQ7J
X-Google-Smtp-Source: ABdhPJwgPDn63+t8WI0ESglt0cdz3qRSIBNoBZJfy0KnIfKji8LoJbUHTl3eZXAtTJ+tyoAIdpJzMw==
X-Received: by 2002:a05:620a:cf4:: with SMTP id c20mr22556318qkj.134.1616975827140;
        Sun, 28 Mar 2021 16:57:07 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
        by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 16:57:06 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, dave.jiang@intel.com,
        dan.j.williams@intel.com
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/30] Revert "s3c24xx-dma.c: Fix a typo"
Date:   Mon, 29 Mar 2021 05:23:10 +0530
Message-Id: <1d989f71fbebd15de633c187d88cb3be3a0f2723.1616971780.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616971780.git.unixbhaskar@gmail.com>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

s/transferred/transfered/

This reverts commit a2ddb8aea8106bd5552f8516ad7a8a26b9282a8f.
---
 drivers/dma/s3c24xx-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/s3c24xx-dma.c b/drivers/dma/s3c24xx-dma.c
index c98ae73cdcc3..8e14c72d03f0 100644
--- a/drivers/dma/s3c24xx-dma.c
+++ b/drivers/dma/s3c24xx-dma.c
@@ -156,7 +156,7 @@ struct s3c24xx_sg {
  * struct s3c24xx_txd - wrapper for struct dma_async_tx_descriptor
  * @vd: virtual DMA descriptor
  * @dsg_list: list of children sg's
- * @at: sg currently being transferred
+ * @at: sg currently being transfered
  * @width: transfer width
  * @disrcc: value for source control register
  * @didstc: value for destination control register
--
2.26.3

