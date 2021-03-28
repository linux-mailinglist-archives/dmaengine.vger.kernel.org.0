Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFB334C00C
	for <lists+dmaengine@lfdr.de>; Mon, 29 Mar 2021 01:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhC1X5N (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 28 Mar 2021 19:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbhC1X4n (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 28 Mar 2021 19:56:43 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E391C061756;
        Sun, 28 Mar 2021 16:56:43 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id o19so5732060qvu.0;
        Sun, 28 Mar 2021 16:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rruIrfqaU4LV0f/3DETW92os/6jYETGIbvTMrRY/HO8=;
        b=bGnHyBFVOutt4P2ONnjyaSIeJvIRzETak6KwFJ7ir2Nn/GqZgVtFuQhT8cWFVCJCF4
         nOmS5/3lsk0F21Pui0C1nfch9n42xfmm27QVRq2RUbd469ITaO2YTyoT6yca1dt3kEIA
         WrrB+5zNMv5REpdJe2JR74UmZr5+PTYnt/XmXcfAg0fv6Fy7GCSeRicj7d/SVnq3Qu/D
         UKRgx0ggNDlvFtQyqwIWq00SNVHxRapkrohVs+rT8HcJE0cam15uS2VWEv/I+wPd8Sx3
         oxsNNTD4FAJ8DW0fVQi+ybJ+sHJ776F4pG4SBgFnsTZUI5HwctVd0uJCZQ7w/2oBe12l
         xa9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rruIrfqaU4LV0f/3DETW92os/6jYETGIbvTMrRY/HO8=;
        b=Hk9CZwrQIGsgjifTXJzQTLf5XcORIDZvNb7xwMdcjfEq8myvch+bx4WRPzpQpG2Q3h
         lw9ExsL5TaZ2QLlCvBEdDptu4VNibPENs/riFYOoWCWMk9WcsyarUDuzJoTuYQHJHRyo
         ebivQNbflLNlaqJqNCgY3HptTEtovWMApzcfp6SK64P2BVUo4pVjUuq6eyNZgRh5RK3M
         t3TZrbIs0VwAgbbyrMX/5w1N52idIqG7xScAbvyVIak1pycu5T8wcM+V192Pn/EDI2pr
         w9V9x9XNHA4wxidrGFdUK89Uv15yYJJfIJcfmA6GF9kYrDjKp7jS0TXwmM7XLHOky1Gy
         ZzqQ==
X-Gm-Message-State: AOAM531QrHtE1FzQwr7USU9XBeJxKjhaQwrcDoS/eaVYDOrQD/LlOf7+
        Sxwn0mFtb9LsDGhwHaft5Ox/sYa/9ax3bHZy
X-Google-Smtp-Source: ABdhPJwGtK6xTmnuLSPnSFT/2CTh7pV1MaTzw54JyGs6QVwUBLmi4sfOAtAfjo+zm2N6Vm+LRKQfow==
X-Received: by 2002:ad4:5614:: with SMTP id ca20mr22679724qvb.37.1616975802324;
        Sun, 28 Mar 2021 16:56:42 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
        by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 16:56:41 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, dave.jiang@intel.com,
        dan.j.williams@intel.com
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/30] mv_xor.h: Fixed a typo
Date:   Mon, 29 Mar 2021 05:23:05 +0530
Message-Id: <c7ff7a7dbd93aecfc5b97f55a3ccaf23fd8a7c6b.1616971780.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616971780.git.unixbhaskar@gmail.com>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

s/writen/written/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/mv_xor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/mv_xor.h b/drivers/dma/mv_xor.h
index d86086b05b0e..c87cefd38a07 100644
--- a/drivers/dma/mv_xor.h
+++ b/drivers/dma/mv_xor.h
@@ -99,7 +99,7 @@ struct mv_xor_device {
  * @common: common dmaengine channel object members
  * @slots_allocated: records the actual size of the descriptor slot pool
  * @irq_tasklet: bottom half where mv_xor_slot_cleanup runs
- * @op_in_desc: new mode of driver, each op is writen to descriptor.
+ * @op_in_desc: new mode of driver, each op is written to descriptor.
  */
 struct mv_xor_chan {
 	int			pending;
--
2.26.3

