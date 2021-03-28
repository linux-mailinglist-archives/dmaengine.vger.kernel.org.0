Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D370334BFF9
	for <lists+dmaengine@lfdr.de>; Mon, 29 Mar 2021 01:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhC1X4n (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 28 Mar 2021 19:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbhC1X4d (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 28 Mar 2021 19:56:33 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498F9C061756;
        Sun, 28 Mar 2021 16:56:33 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id q3so10893347qkq.12;
        Sun, 28 Mar 2021 16:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0BnZu67viS33aGYohPjcgklvkVxQfW/8GD9rnxEtwd4=;
        b=DZtvetYyyMD2lBKzbBM4H/FNDCw5hl88bdIconXcj2qDm/jFPH8aghuq5QsYihTAkF
         e50DD81/iTN58j6xxgKz550PmMPq8BQ9hEfPPph+WIdC73rdzg8dJ+UXCMCfg/eL6rpL
         bpYG8Qer1UHLBNEjXOk5LiOfjLy04zj5RiWzpfm0AGaIiSGGdOOUyINW+fPqgXEZLBWI
         ZJCp/duHr3bDu8WGMaUyF5991YwUfo18A+oY2EylsV72rLburV0Y8KLkYvuhvMNXoarO
         w5WASyKO9yq4Ox1RbNmZX7VpJeVNZW6LB+RXDNbwuj6DZyPA6KZYbK1dc6YXhqfBkLPO
         QxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0BnZu67viS33aGYohPjcgklvkVxQfW/8GD9rnxEtwd4=;
        b=iAjfXZzRk1alatwTvezH5l1fNfD61sfl9KtqMDOrM18im60IRAca72OOCuYdztmi1i
         AJ5ZufU1Quy3EVDGROq6BT1cYdiDbJE4V2Hqx2sERFomxg9GKItEWbYNvtwcW6nANV9J
         xaZQIy/UHwYNe5IO41gplvdbIcLJOHqslVwLx6qzcq9y9Z7bxcRZ0mXWQqNZN6pKmHr7
         UWzhFIfaN0QsxMZbvMVWwOkKvSBobdoXnZvhWcoTPOMi65oRC/vizHTHXBKVUcDqA1Q1
         O5G+28NQoRbHwO8ZGDFCPG+U4hJlt9ZiTRXLNnpGrdPdDbBnSA7itv4USDUQO1IrdXZ2
         7H8g==
X-Gm-Message-State: AOAM530nHPgeubC3i97VCmHDwCldQfIxRSqpRoKYrxbIxJ0OLrC96jvM
        qABoGeKRO/uEZ2THK2N89NCvZuKk3TX8zMne
X-Google-Smtp-Source: ABdhPJyLnsSA7aDZpYL8OgcC6cA3c2KI3g1ctb8AbY5iG8YBuQoLtMdy1CH0E4ijQxDfED6WKrLV5g==
X-Received: by 2002:a05:620a:31a:: with SMTP id s26mr23221107qkm.355.1616975792270;
        Sun, 28 Mar 2021 16:56:32 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
        by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 16:56:31 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, dave.jiang@intel.com,
        dan.j.williams@intel.com
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/30] iop-adma.c: Few typos fixed
Date:   Mon, 29 Mar 2021 05:23:03 +0530
Message-Id: <a5e2587318ef5fc4e140caf86cfd89ff01027c72.1616971780.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616971780.git.unixbhaskar@gmail.com>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

s/asynchrounous/asynchronous/
s/depedency/dependency/
s/capabilites/capabilities/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/iop-adma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/iop-adma.c b/drivers/dma/iop-adma.c
index 310b899d581f..81f32dc964e2 100644
--- a/drivers/dma/iop-adma.c
+++ b/drivers/dma/iop-adma.c
@@ -5,7 +5,7 @@
  */

 /*
- * This driver supports the asynchrounous DMA copy and RAID engines available
+ * This driver supports the asynchronous DMA copy and RAID engines available
  * on the Intel Xscale(R) family of I/O Processors (IOP 32x, 33x, 134x)
  */

@@ -243,7 +243,7 @@ static void iop_adma_tasklet(struct tasklet_struct *t)
 	struct iop_adma_chan *iop_chan = from_tasklet(iop_chan, t,
 						      irq_tasklet);

-	/* lockdep will flag depedency submissions as potentially
+	/* lockdep will flag dependency submissions as potentially
 	 * recursive locking, this is not the case as a dependency
 	 * submission will never recurse a channels submit routine.
 	 * There are checks in async_tx.c to prevent this.
@@ -1302,7 +1302,7 @@ static int iop_adma_probe(struct platform_device *pdev)

 	adev->id = plat_data->hw_id;

-	/* discover transaction capabilites from the platform data */
+	/* discover transaction capabilities from the platform data */
 	dma_dev->cap_mask = plat_data->cap_mask;

 	adev->pdev = pdev;
--
2.26.3

