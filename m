Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D3A34C020
	for <lists+dmaengine@lfdr.de>; Mon, 29 Mar 2021 01:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbhC1X5q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 28 Mar 2021 19:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbhC1X5X (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 28 Mar 2021 19:57:23 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116D1C061762;
        Sun, 28 Mar 2021 16:57:23 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id q12so5691211qvc.8;
        Sun, 28 Mar 2021 16:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=88PkT7hzmP9uvlnh5Rsb8g3TAFEqqGGj/lMcm5Asd2s=;
        b=nhwORjtTIVMJ/bsMdgqNd8uoq6Cs7JgZ8YX00vhjlbEVgF9lqTcrqqFaLOyxT8TLmh
         j6eMqWWGzth2rPMVS5X9Py/JgSls2R8a2uGKjK3d5fC2UATp6PvzmH8o1b0Mwf8b65lN
         G7gn7A7icEPgpkHDfLnDY7hh3mIJWxLbFHLnxEqNn3Fu2pc/RESJ5ASbqfbzt/i7hEtx
         3vCsh8h26Ppie6GrkT09TmUYmLAv9ciFcoOuelozIQy08XsWgtc/dxh4NJROi75XMo0Z
         FyLuydql2Ggr5IOC0fjXSjXU0gxU7nIxd+O7/qC10kapvV2kBr9ZwJXc62om9niJbwtV
         rKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=88PkT7hzmP9uvlnh5Rsb8g3TAFEqqGGj/lMcm5Asd2s=;
        b=qOTUtBsb0nV3NsvpLr053prX8PmInfIWRSYMipDI1NpJ0jp61gjt1c60XAnNtXveb5
         63z6dqmucHhFv+LMGtkxaHG7ABoLGa5LpgQPpTtGc3aa6wWM0ITSiZz4YE/nFNVgSy52
         /6DBiBqUrnVwj7sbaDY+FFjhfa3JU43W5CNsENY2xzrErDPn5G3tX2wal2GHchLP5v7J
         fJgplFH6L5tm+oJYKinrXxqQ3aFg271YaEjcL7KHnNr6zk2Fli0MKe3lMgAJNB4pqU+N
         094hN0qTvcKgdHiqBX94h6DUuajEjCwmZlq8PwpccXM/xLA73PVAzQCTAfU+XxIbyfn3
         zPIQ==
X-Gm-Message-State: AOAM531lejzYbdINVHix6eKKlstV5rRMFZA80Qz4NCQ9BIA5bgafbgiA
        A3EXtYPFADCPX6sQ4e5VSLjT3UHWYMYrkCu8
X-Google-Smtp-Source: ABdhPJzeNlXwPF2gtbpUnH5nSpOqRgSvlEoS3IIvNxtfx5u/w6b4BkxwheKjinYT+tl9BHqoU9Rugg==
X-Received: by 2002:a0c:df02:: with SMTP id g2mr22814769qvl.40.1616975842037;
        Sun, 28 Mar 2021 16:57:22 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
        by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 16:57:21 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, dave.jiang@intel.com,
        dan.j.williams@intel.com
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/30] ste_dma40_ll.h: Fix a typo
Date:   Mon, 29 Mar 2021 05:23:13 +0530
Message-Id: <90dd5516285c43fb91103905b72d522ae4bf7a58.1616971780.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616971780.git.unixbhaskar@gmail.com>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

s/directy/directly/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/ste_dma40_ll.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ste_dma40_ll.h b/drivers/dma/ste_dma40_ll.h
index c504e855eb02..2e30e9a94a1e 100644
--- a/drivers/dma/ste_dma40_ll.h
+++ b/drivers/dma/ste_dma40_ll.h
@@ -369,7 +369,7 @@ struct d40_phy_lli_bidir {
  * @lcsp02: Either maps to register lcsp0 if src or lcsp2 if dst.
  * @lcsp13: Either maps to register lcsp1 if src or lcsp3 if dst.
  *
- * This struct must be 8 bytes aligned since it will be accessed directy by
+ * This struct must be 8 bytes aligned since it will be accessed directly by
  * the DMA. Never add any none hw mapped registers to this struct.
  */

--
2.26.3

