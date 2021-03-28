Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210D934C041
	for <lists+dmaengine@lfdr.de>; Mon, 29 Mar 2021 01:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbhC1X6v (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 28 Mar 2021 19:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbhC1X6Y (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 28 Mar 2021 19:58:24 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB40C061756;
        Sun, 28 Mar 2021 16:58:22 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id o5so10968810qkb.0;
        Sun, 28 Mar 2021 16:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OzLTjr1QMwsBd8ul22IMj5qh7q/mkchMq8nJkxCkqyY=;
        b=r9e3a2wKOgpXCJCo+aWL5/d9M1nteMw5u0JfcT5v+U1WeLlFsUdTJtF08TixWpxMKN
         YOD1u3JG8FP2VSPHIxLAz8eyeTW7mKistUjRXRPuJmpwD4BMio2K3MX1BHXh30tgr+HS
         WkzGAULz8HC3J2TiK1vBwO2PBVjrMfhok856SYM9QI5K2u/kKIUyC6gGKYdErlSpXQ4X
         n5ywUcSi2xtng/Z0W39xMqETvdlLlYlXLhEnBKsLgR7MX8S21rvncu5XNVqEvqtPGWsi
         BDbqqdTj0jxa+LbMW45UGa5pH81aWPydRGGHPaGxa/5YSoAfD3YkO5GRqeKV5jDkYTwr
         0RTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OzLTjr1QMwsBd8ul22IMj5qh7q/mkchMq8nJkxCkqyY=;
        b=q9lKQ0tEsf435tXXUSwqUcmHVBRaETsrZ9QjbAQkXMC6+89WocoDrKtq7geefmsZkm
         ffWkPgSy2H4kEv+iD6Aw61emlYvJQ1W+sKSwarFM1axaYJhCfI8iYbEtrQ7A9dXgNnbB
         ZVWP+ap5pg6ra5JwtE2qbHH+bkGsCForSFb+3wYQKfEE7iYo8BD+aSh+gQjEgLpDWeIL
         nFktApcXdEvtoE2onxEiMHkiYkvown7AjzKN39dh2heJlhNYiRgSoyBrEmrtNwjY6OUQ
         /eMWQ3NgJ6Z9t5yVjE9NOcXuD0wXvQRDCHwtNJaDi02cxNtiIeNPJzfwxZ1vj3wR29/O
         dLtg==
X-Gm-Message-State: AOAM532h1MxdPovB5BCRKj+6EO84e6Jil8Hc8XjhwHy9/wcA1GRmMgGX
        n3sn3Dl8ZeZfJDMlyRwkNaGmGq1dgHx/q98S
X-Google-Smtp-Source: ABdhPJzZMvKYIloLfO2fexs1vtEuZv6khlYZUkE/hvVvZgpuiguBiwDPE1c2rtdyr/QBSVJvO+1KkQ==
X-Received: by 2002:a37:6a47:: with SMTP id f68mr23321069qkc.12.1616975901742;
        Sun, 28 Mar 2021 16:58:21 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
        by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 16:58:21 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, dave.jiang@intel.com,
        dan.j.williams@intel.com
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 29/30] edma.c: Fix a typo
Date:   Mon, 29 Mar 2021 05:23:25 +0530
Message-Id: <28685183e34f3ae6839eb73265f9055f554ad6f1.1616971780.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616971780.git.unixbhaskar@gmail.com>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

s/transfering/transferring/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/ti/edma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 35d81bd857f1..5ad771e34457 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -1815,7 +1815,7 @@ static void edma_issue_pending(struct dma_chan *chan)
  * This limit exists to avoid a possible infinite loop when waiting for proof
  * that a particular transfer is completed. This limit can be hit if there
  * are large bursts to/from slow devices or the CPU is never able to catch
- * the DMA hardware idle. On an AM335x transfering 48 bytes from the UART
+ * the DMA hardware idle. On an AM335x transferring 48 bytes from the UART
  * RX-FIFO, as many as 55 loops have been seen.
  */
 #define EDMA_MAX_TR_WAIT_LOOPS 1000
--
2.26.3

