Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1117F34C01F
	for <lists+dmaengine@lfdr.de>; Mon, 29 Mar 2021 01:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbhC1X5p (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 28 Mar 2021 19:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbhC1X5N (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 28 Mar 2021 19:57:13 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08697C061756;
        Sun, 28 Mar 2021 16:57:13 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id c6so8262695qtc.1;
        Sun, 28 Mar 2021 16:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VFtxWE0StKfcC+URsv7nAjsC2Kf78xuu9a0HtqKdSlU=;
        b=nofPQHYz+R+Oh7tBn2NrHqcJ60wz0I6awH3+nn+VeY57PjK9/aNKapSiLLecIClvPE
         Wv+VWFlug249FdqQUEnblJ5mnlCINYaNx63BE/qOihUhCU+JaQ/WqSPiCuKhfSjQbhGv
         sBRNZ9lVKQXJGBC11+kHxahv9pSjNr/fTi0d+YVlFs4PWEH7ZQGtYbkuhE6TF9M1XIi2
         OaPcpcSIEMOOc32j/1qRcNe0pfEquahJ0sNCoEtLMNpLSu5FueclTvKRvW/OcNHihNtC
         0IMi3H/cpoMpeAJG9jiZpJyTWlCGbUvhb9/0lczXT1gcHms5Qe+Z9kXEzBI1StWYjMxW
         2wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VFtxWE0StKfcC+URsv7nAjsC2Kf78xuu9a0HtqKdSlU=;
        b=BjiZRxsYDGUo9RXy1oS9qQmquYuq95NCVhypLbmgcG3+tocOC2xmovsj6ntKBwilWV
         nkpVRgrRXZU63E+i6NytwackW1Q3aA48f+/zNQEjNFMaRf3FkSTUx+wxxmXczMaAlnDc
         pGtUblgNfNNVU1ngTvFGeiRmNd1H/G53CUYTqtKaV8tsSJUlJyKuhG4ipq1edNo/jZxZ
         ty/gUCiJCiabeMpwYshDocU18JwK1uoH9JHUIsk7LsFYz5iwbZYaQP36bfFM9nEos0wZ
         xfZ3Y83eHzrprWsBp2SlQ76MrZxq6Zu2gd6Osbj+WFy4Zc5wDIleskRC7DQ91zsN90gZ
         mJsw==
X-Gm-Message-State: AOAM5335vrGK34OFGKSXVnKi963/b7E8H9DKuyWbOytiTxWbFpRZlvcZ
        E4rklj5KJ/u6ZVt8BsVF38Qb7ewCVSwTOzSj
X-Google-Smtp-Source: ABdhPJzdepGd4ibSSylbqz3lykO6e7Iu/C1yudQOjI9dZGJHJpjheIp8QepnwzKrjFLrJcsbOfjQlg==
X-Received: by 2002:ac8:7fcd:: with SMTP id b13mr20277139qtk.68.1616975832021;
        Sun, 28 Mar 2021 16:57:12 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
        by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 16:57:11 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, dave.jiang@intel.com,
        dan.j.williams@intel.com
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 15/30] s3c24xx-dma.c: Few typos fixed
Date:   Mon, 29 Mar 2021 05:23:11 +0530
Message-Id: <062bbb694c995aad9ca17a80bbc63716f116fd9f.1616971780.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616971780.git.unixbhaskar@gmail.com>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

s/transfered/transferred/
s/desintation/destination/  ...two different places.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/s3c24xx-dma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/s3c24xx-dma.c b/drivers/dma/s3c24xx-dma.c
index 8e14c72d03f0..045f2f531876 100644
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
@@ -920,7 +920,7 @@ static struct dma_async_tx_descriptor *s3c24xx_dma_prep_dma_cyclic(
 	}

 	/*
-	 * Always assume our peripheral desintation is a fixed
+	 * Always assume our peripheral destination is a fixed
 	 * address in memory.
 	 */
 	hwcfg |= S3C24XX_DISRCC_INC_FIXED;
@@ -1009,7 +1009,7 @@ static struct dma_async_tx_descriptor *s3c24xx_dma_prep_slave_sg(
 	}

 	/*
-	 * Always assume our peripheral desintation is a fixed
+	 * Always assume our peripheral destination is a fixed
 	 * address in memory.
 	 */
 	hwcfg |= S3C24XX_DISRCC_INC_FIXED;
--
2.26.3

