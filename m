Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4231E34C028
	for <lists+dmaengine@lfdr.de>; Mon, 29 Mar 2021 01:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbhC1X5r (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 28 Mar 2021 19:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbhC1X5m (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 28 Mar 2021 19:57:42 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782B7C061756;
        Sun, 28 Mar 2021 16:57:42 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id y18so10895530qky.11;
        Sun, 28 Mar 2021 16:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LY04BDMd0/4O0qv+wuAgYKhd3ly3Ph1K7x5mf2r/G+0=;
        b=a+EXa39bteLFKTrEHlbm1+MouCIyb9cV+yaNKyv8dIyxqTAhvd31XrjXWbvHHzVduL
         1m4DojoIjOfiyRN7xcr0QpSrR6ePbNm3KqRQY1gbCFcbd22bLf2BWnHwe8lfTEqTjY7R
         M98mtiq0Pq4n7XXjDGYxi4qsrFmCNnBlY+2L6xSLFCm2xU4u2hVKUVCMMgz+W48T3z+F
         Be8AcFVNT/rv2XLUJvW++tnlcFMq9Mx/WmUVOYgxFXIoTtuxIjemHAh4IiTbpweWxeP6
         Pt8RHzRZ4DYYvL/cvUU4JdOTyLGN/JBiDRnApwCKetCmX6P86BiK0xXGUEADFFqiSdgJ
         skQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LY04BDMd0/4O0qv+wuAgYKhd3ly3Ph1K7x5mf2r/G+0=;
        b=gqry22uFnOm/tJ4eIqFlYzjOrxelHdRSCzgwtYZYn35JCiYptb2eTH6WrYNVPVI4UK
         5CtW7ojeoAyCZCe113t62oKe4GFBWlb8HZP7bkUXEQcRgPJ3cf0WIzKyF7WZyck3X5df
         uef+z6UYyEE/eZyLDI4VCdZNU9YxrXhFcNwcueYSt26wfunLvZgbmFQzrwRlMzLL4LRF
         t2rrMrl37ldEMDHHNBgYPMs7Mn3SZPUZ/Yy4puCoEHSyf4pGMJ1lfuxTbc3xh+l0Ugkx
         pF2+99ztMs49ShqFXbLNmzCUtfX98HuDaI/23ttZDge5sqNIfCj67e52peQUWg+kfww5
         tOIw==
X-Gm-Message-State: AOAM531vC33tua2LuNdBWB/tV3So4cr1TxVo4oBLROUn0hcjEK4mMv+w
        HumH1lcc+hTFpIVMs1TQau3xs5AchFd1ZM9G
X-Google-Smtp-Source: ABdhPJz881qq4XaeZFjTiwc+P8rV7shOVJ9Q+7jnFQ8clBo7myE8qUn50lhxUxxhgg0PUTo5fJ3Apw==
X-Received: by 2002:a05:620a:110a:: with SMTP id o10mr23879687qkk.281.1616975861492;
        Sun, 28 Mar 2021 16:57:41 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
        by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 16:57:40 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, dave.jiang@intel.com,
        dan.j.williams@intel.com
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 21/30] owl-dma.c: Fix a typo
Date:   Mon, 29 Mar 2021 05:23:17 +0530
Message-Id: <2e2a9f4d62fe36079229480bf6f65cea0f5be494.1616971780.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616971780.git.unixbhaskar@gmail.com>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

s/Eventhough/"Even though"/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/owl-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
index 1f0bbaed4643..3c7283afa443 100644
--- a/drivers/dma/owl-dma.c
+++ b/drivers/dma/owl-dma.c
@@ -1155,7 +1155,7 @@ static int owl_dma_probe(struct platform_device *pdev)
 	}

 	/*
-	 * Eventhough the DMA controller is capable of generating 4
+	 * Even though the DMA controller is capable of generating 4
 	 * IRQ's for DMA priority feature, we only use 1 IRQ for
 	 * simplification.
 	 */
--
2.26.3

