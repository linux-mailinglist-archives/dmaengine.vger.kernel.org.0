Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6541F34C011
	for <lists+dmaengine@lfdr.de>; Mon, 29 Mar 2021 01:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbhC1X5P (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 28 Mar 2021 19:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbhC1X5D (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 28 Mar 2021 19:57:03 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FDFC061756;
        Sun, 28 Mar 2021 16:57:03 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id o19so5732264qvu.0;
        Sun, 28 Mar 2021 16:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FMNLSlxwy2hAf90gVAHPhiZXHLhbd5qd+n04so3vi0M=;
        b=S8oWEVWMQA7uyNstiZ8vX8xPHLZ0pxra5NLEFFZff7GHfczcuqdPPb1f9FK0XzIuvO
         UzPWul+6fG0QPP5gDQ9IaF5Yimdyc8s/NTyczspVuP9t6SHX6y9UJJ349vESDcVPS68s
         QG5EZ5U5urbmsi3oZ/Xw4TctbB7C20H3xQqhBrA3M1pIYkme4Az2wgoemWBDm4zIM2zF
         S8l8tp27O4LScLIVSPnMu2Tfen8wh0ESoi1br6sQSJgBhywsNStX9yRrFEgJENv3xygU
         JXHw47iftiDyBqQKWUlu3oja/xrWp3CtSbiiUCvlFQoi58veqOhE8AgD5AdpIpuoEvAz
         yjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FMNLSlxwy2hAf90gVAHPhiZXHLhbd5qd+n04so3vi0M=;
        b=p02iFZK06T5pQ2tqJgSWhP0s2AA9u1mwxs73zPQB/D8scSE96X9+HQTyRps9pX2z88
         Muhpf76buqXIrDGgJfOH0PHw/5sW7tEWxNTzL46BAzb8QMQ8FGpSEfqlml8dZalQf5hm
         F57UlJmo+gHpHV6+zAZPCUyzVOcyiKgBRuzADutbZjZm/BOxy1p8c5363jsaW40b6YAc
         vsxrxJTx5NHCSB8vhMpP4MFOZAsd1GtAq4dAo+YXz0ZEBg03sQDnifBx0LfMx8mTKibk
         66/BAT2Mqr3VjhSuDu3A/8ArkLUnrd543ygUukjpgZIaoc5lkUZYJeWbAji9K4CNy0cP
         a+Pw==
X-Gm-Message-State: AOAM531AR5bCClW3wBwm3yzdLkfEO0bm26mPqk77m93MCPB2Z1mkXrWA
        NGgvyyQXTwXgXQmya4sy8dwN88ZixLlgvLqk
X-Google-Smtp-Source: ABdhPJwu7RyqQ3LrL1DwSFaqoUhxFcpLYWZSK3o023jDzT66goaZiw5ZvrOEYhVFXl/O/Q9wP43hfA==
X-Received: by 2002:ad4:55ef:: with SMTP id bu15mr22954074qvb.46.1616975822090;
        Sun, 28 Mar 2021 16:57:02 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
        by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 16:57:01 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, dave.jiang@intel.com,
        dan.j.williams@intel.com
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/30] s3c24xx-dma.c: Fix a typo
Date:   Mon, 29 Mar 2021 05:23:09 +0530
Message-Id: <a2ddb8aea8106bd5552f8516ad7a8a26b9282a8f.1616971780.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616971780.git.unixbhaskar@gmail.com>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

s/transfered/transferred/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/s3c24xx-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/s3c24xx-dma.c b/drivers/dma/s3c24xx-dma.c
index 8e14c72d03f0..c98ae73cdcc3 100644
--- a/drivers/dma/s3c24xx-dma.c
+++ b/drivers/dma/s3c24xx-dma.c
@@ -156,7 +156,7 @@ struct s3c24xx_sg {
  * struct s3c24xx_txd - wrapper for struct dma_async_tx_descriptor
  * @vd: virtual DMA descriptor
  * @dsg_list: list of children sg's
- * @at: sg currently being transfered
+ * @at: sg currently being transferred
  * @width: transfer width
  * @disrcc: value for source control register
  * @didstc: value for destination control register
--
2.26.3

