Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2557834C00D
	for <lists+dmaengine@lfdr.de>; Mon, 29 Mar 2021 01:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbhC1X5P (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 28 Mar 2021 19:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbhC1X46 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 28 Mar 2021 19:56:58 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22265C061756;
        Sun, 28 Mar 2021 16:56:58 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id x9so8203442qto.8;
        Sun, 28 Mar 2021 16:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V731M1ZjoMObeUPxmfQu760ZEmOVyQS5nvVKDsMpRYg=;
        b=lnZVGx88/Q4RgjL+3hIrxaeLUCknaQO529y1KHYklW+L+nkdj8gpcbnqm8dMc1/+l7
         f6zSHAW3lnPCPRE6I8Y7+qD6NhajFTxCnWDjvRqS+5YTVtxG9RfzFR2gppG6pd2KUONg
         x2Ypd6MdyYMDQxXuVr9h1defti29sytWbU8Ue/Li0RmO+WBaY8GzifXSi3Uzw8ctplXy
         6TXDeusuFr4d4znZtig85zoIyEx6i/oXnzfPQNVFdJWRikFvX9A33V/ZVXPGGkcr9CJy
         RJnXtSxeb6weKiUSJ+4jqKEIqqXxCR3aOs9fIwYirSfoCpnld2ZyldI5xWdSpa4LevUr
         PhOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V731M1ZjoMObeUPxmfQu760ZEmOVyQS5nvVKDsMpRYg=;
        b=HigLl7wu52l14FFoFWUsHaoWT4YkCfjzvRrC7cwu19MWtT76Uc++bci3Alk4S15sBV
         CjvROvC2+RbRtqb9tTC3XSf0Qv0FrJn0NVobYya6suSiupgP02fYmqMloOFvVs+vg21V
         TkdfOQCyGurKonI5otGyVKRGjIrm0Uu1mQZjcOBa+mah479T9ceG7+PZT2DxAHJlxAki
         V9wI86jaocXfRMmZtYqaYc2yBSJXvvIA3uYR+R97x4MTNnFvKQpjwD/FBcmqWNZ7frr8
         3gdkbK5P5rXSvL0FPfh5Mrp9v0JaoylXgM+VRPI/AhF2Ywb/wE7MXDvB4VJORAuyyVI8
         QWMQ==
X-Gm-Message-State: AOAM532W7XDLtvn9XPQq9CM5TEG8XHrAbBP6sGrAHRXPZ+mELIn5q5EW
        +Jcejhipy/idsEjUCaMQDGlDj4pyy188VdQR
X-Google-Smtp-Source: ABdhPJwfkmcNQYJxn4S9wN8jOvwQsIXVBRg1ipQrCtKoJ4PNJU1NU5IafcNZI5PpJzjZHpA0d8+z4w==
X-Received: by 2002:ac8:1098:: with SMTP id a24mr20071293qtj.291.1616975817116;
        Sun, 28 Mar 2021 16:56:57 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
        by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 16:56:56 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, dave.jiang@intel.com,
        dan.j.williams@intel.com
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/30] of-dma.c: Fixed a typo
Date:   Mon, 29 Mar 2021 05:23:08 +0530
Message-Id: <0c3e1bd83c63203a0aad27006fbd369090a69dce.1616971780.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616971780.git.unixbhaskar@gmail.com>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

s/propety/properly/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/of-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
index ec00b20ae8e4..e028acff7fe8 100644
--- a/drivers/dma/of-dma.c
+++ b/drivers/dma/of-dma.c
@@ -337,7 +337,7 @@ EXPORT_SYMBOL_GPL(of_dma_simple_xlate);
  *
  * This function can be used as the of xlate callback for DMA driver which wants
  * to match the channel based on the channel id. When using this xlate function
- * the #dma-cells propety of the DMA controller dt node needs to be set to 1.
+ * the #dma-cells properly of the DMA controller dt node needs to be set to 1.
  * The data parameter of of_dma_controller_register must be a pointer to the
  * dma_device struct the function should match upon.
  *
--
2.26.3

