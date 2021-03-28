Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B084F34BFE8
	for <lists+dmaengine@lfdr.de>; Mon, 29 Mar 2021 01:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhC1X4L (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 28 Mar 2021 19:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhC1X4I (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 28 Mar 2021 19:56:08 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C45C061756;
        Sun, 28 Mar 2021 16:56:08 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id o19so5731685qvu.0;
        Sun, 28 Mar 2021 16:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cGEIwK2mIWlt0praWPVjHqx3787sD2c2+ZgIrWeWC10=;
        b=MHcOVXxwuQq9uqXkVVuBX0gJCRJ7glGGeVEfFXw0gIUK0eSzsVxe1AZARAhuSRj3YZ
         fN0P0USAorbIlhKL+tBir5YICqCcUJgAHIdtl7kbbjsKMDY4jYibPNUn3NaaV7Q8EWoo
         SLCd3+axdfEe2JQgQ0IA5JDtmlwwY/78RnCy1OD6/3OYMG9Pi0P4Td5hpINwGDG0ZVHP
         /wwa+3iDJ6RBYE1AEyFziDbGBYl8YxN7l4N0Nj3tZs04HUgSpxd0XYTb+bpMd7rAFOv/
         Ka2nQ91BkVfuIiwh7j5oP5m22bSKTwFZz8/56aHeupoIJtY5Q6H7slSTKfgf7lJTmOyP
         yQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cGEIwK2mIWlt0praWPVjHqx3787sD2c2+ZgIrWeWC10=;
        b=neZnDjKCHrNDH4YbU45qa/J9ahvRvUZ2UFc8/NBc/zNbdJzTbMFsTET5QFBp6OC7wR
         YK49Qw72hsZINxV0K5557nx1izYbrYmIBspmOHPFEb3bmtej1TQVPN0FpQeiluP2IOty
         1/hFIVmuXygzzrVfBPzIz3u4a8pATbMalfx3hsMPYYRrnmL15rtxW6h7hqZC9mvdeR/k
         cZjN/qCDlERD/EDHos5viX2fne7MtkuowOGIuC/w75QkCF6NmLElsXexlX94TPOjs+9Q
         beotPkPLeJvlzm17n8fUrxi1rjlX4EyzRKYMqXL+X6FjSQX0pgkJpuhjLHg+Q1pz4I72
         eo1Q==
X-Gm-Message-State: AOAM530jPxkGlBm5V3hMhPInTtXIDIDSm55r9i8VVEhSzaeIFToRY+Tb
        0ZDytvoqB4os6zW2ao46aFBcauzT+jQSf0Mc
X-Google-Smtp-Source: ABdhPJzupTYmpyqK8HSRMpnyKZA7fy0qU0f4/K+gj2k9q8PjKZlDEA4s8A98+bzdSWZWkwnQeq1lbQ==
X-Received: by 2002:a0c:ea81:: with SMTP id d1mr23183110qvp.57.1616975767611;
        Sun, 28 Mar 2021 16:56:07 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
        by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 16:56:07 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, dave.jiang@intel.com,
        dan.j.williams@intel.com
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/30] altera-msgdma.c: Couple of typos fixed
Date:   Mon, 29 Mar 2021 05:22:58 +0530
Message-Id: <c9dc34e16508c7444d3407d775eb6f921ff81f06.1616971780.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616971780.git.unixbhaskar@gmail.com>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

s/assosiated/associated/
s/oder/order/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/altera-msgdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
index 9a841ce5f0c5..c3483bf2aaa7 100644
--- a/drivers/dma/altera-msgdma.c
+++ b/drivers/dma/altera-msgdma.c
@@ -152,7 +152,7 @@ struct msgdma_extended_desc {
 /**
  * struct msgdma_sw_desc - implements a sw descriptor
  * @async_tx: support for the async_tx api
- * @hw_desc: assosiated HW descriptor
+ * @hw_desc: associated HW descriptor
  * @node: node to move from the free list to the tx list
  * @tx_list: transmit list node
  */
@@ -510,7 +510,7 @@ static void msgdma_copy_one(struct msgdma_device *mdev,
 	 * of the DMA controller. The descriptor will get flushed to the
 	 * FIFO, once the last word (control word) is written. Since we
 	 * are not 100% sure that memcpy() writes all word in the "correct"
-	 * oder (address from low to high) on all architectures, we make
+	 * order (address from low to high) on all architectures, we make
 	 * sure this control word is written last by single coding it and
 	 * adding some write-barriers here.
 	 */
--
2.26.3

