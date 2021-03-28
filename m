Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7230B34C033
	for <lists+dmaengine@lfdr.de>; Mon, 29 Mar 2021 01:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbhC1X6R (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 28 Mar 2021 19:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbhC1X5r (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 28 Mar 2021 19:57:47 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882E3C061756;
        Sun, 28 Mar 2021 16:57:47 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id g20so10957137qkk.1;
        Sun, 28 Mar 2021 16:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I1EIk4YVKhOnAZImQsN2ZKDY/BZ5VFtnbICpb2ytuZw=;
        b=dYzr6KWh4SK2C8ze1rrsjBDcu+hcBxWGkb1HkW+qd+/dV31vd3A3Ee2Vxu4ZavXqnU
         o8NDQ+MysLv2Em5XbQ1laoO0P8vfDo77vfaElmp1/5MVQKkCU4xkYBZR1Y8MPoqMfo6V
         0ko2b1t/YU/AM1SxeZ+mvKZbA/x6XJ6/kteEuByX/qo+qxxZ6LTZgy9ICZUMbPMGWoNd
         UclUSFoR61rQ9kcGDjvMWAIuCwmuY+iSBQs/83RVR6BF2KMyUhMQ4juCkRyTGV1Haspm
         asUV/RoPmdZFZFpoRySHsNo2MW5LLW2WQLM3f1CKrl3Ao9QZR9avs1tE9a+FJ+MwI3Vx
         lRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I1EIk4YVKhOnAZImQsN2ZKDY/BZ5VFtnbICpb2ytuZw=;
        b=XnmJGzEhUPHBCvt6hI3fYgQePiIBy9mbxraxr0go6SqlJmS1X7L1ifFo6EIRjUeVJJ
         XnQm4n2UevLZ/b4r9rFlM+CSw0HrtnNEd3/PH0SGLm+0RSmVIOhEMMxg5LvkJwujoOUz
         Uwrwi+8tvoXGbkoijGJJq5+ibD/StKdx0pJGxb4BsR6XEF/q/UmjYCI2NgTqFmuiRYlV
         /ZvPwO0JbaP+eNiBm4UATGyJ0pD6Gc/ijB8BGwqFNnFMKPAfUcW3qlKJlAa7yYCEeRqg
         gaQVOG/kB55CVzrbhK5FTIDIv1C8dreTqilyO8pCLyc57fLIfskZOijdDGCYgMJyVh7B
         yoAw==
X-Gm-Message-State: AOAM530aVIXEg9mXTFE+jMLcvt6HAIAJzCOdSRyLNUqzaLLui5rr6W8f
        P+l3D7+oeDmKpQRMcbqGnUTHD6XZ/2M12K1R
X-Google-Smtp-Source: ABdhPJw/RMK7vmZ45zLUGVxo30c6mvRq7joodocZ04PQOyJJPRklWL/yJc/aDwzeJa2I3aVqupZvhQ==
X-Received: by 2002:a05:620a:2116:: with SMTP id l22mr22838891qkl.377.1616975866552;
        Sun, 28 Mar 2021 16:57:46 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
        by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 16:57:46 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, dave.jiang@intel.com,
        dan.j.williams@intel.com
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 22/30] at_hdmac_regs.h: Couple of typo fixes
Date:   Mon, 29 Mar 2021 05:23:18 +0530
Message-Id: <a588f9e9c32c5af24570ea04c4cd460fb3958147.1616971780.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616971780.git.unixbhaskar@gmail.com>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

s/availlable/available/
s/signle/single/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/at_hdmac_regs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/at_hdmac_regs.h b/drivers/dma/at_hdmac_regs.h
index 4d1ebc040031..46ecc40edaa8 100644
--- a/drivers/dma/at_hdmac_regs.h
+++ b/drivers/dma/at_hdmac_regs.h
@@ -338,7 +338,7 @@ static inline u8 convert_buswidth(enum dma_slave_buswidth addr_width)
  * @ch_regs: memory mapped register base
  * @clk: dma controller clock
  * @save_imr: interrupt mask register that is saved on suspend/resume cycle
- * @all_chan_mask: all channels availlable in a mask
+ * @all_chan_mask: all channels available in a mask
  * @dma_desc_pool: base of DMA descriptor region (DMA address)
  * @chan: channels table to store at_dma_chan structures
  */
@@ -462,7 +462,7 @@ static inline int atc_chan_is_cyclic(struct at_dma_chan *atchan)

 /**
  * set_desc_eol - set end-of-link to descriptor so it will end transfer
- * @desc: descriptor, signle or at the end of a chain, to end chain on
+ * @desc: descriptor, single or at the end of a chain, to end chain on
  */
 static void set_desc_eol(struct at_desc *desc)
 {
--
2.26.3

