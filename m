Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC8734C00B
	for <lists+dmaengine@lfdr.de>; Mon, 29 Mar 2021 01:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhC1X5O (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 28 Mar 2021 19:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbhC1X4s (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 28 Mar 2021 19:56:48 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB5BC061756;
        Sun, 28 Mar 2021 16:56:48 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id q26so10932218qkm.6;
        Sun, 28 Mar 2021 16:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p8tgWIwF1h1UyJsPg+lZdKEi7xs5ze/71DPorsIrKaw=;
        b=QluZ0Za6bZK99BZdD6eZ6JK4FwNMO4t5rMeypTHxnNI3xBR1C2N9OlpcqyHrjbfiG7
         Mq+uCBl35SjAQuc4Cd3qJdRpJ8vzBl4D90dLBtuXnvkjJv+cBZgbaWDnKk0zLxPYIS5s
         yLVuS7nx+qZck+0nJsmLB5ns+K+JwVd6Y6pl1A4EIAd++4AWNUtouvQSF69/S9sHRHtI
         82eWm4rI6oMz57f/q2nVm5TOpV26u7QBwLLqbGpcE8fk9pIhGRBUJPEzl+czndefkZ/p
         YmPsBvQP7Bqq6+uK2YKh2oXukU70f0KR3ysooGwavL9tHQRwV60nHxsIuviiOJDcFJf8
         +KmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p8tgWIwF1h1UyJsPg+lZdKEi7xs5ze/71DPorsIrKaw=;
        b=p+ZiUClWd3XdFWQ1McEem1/YPiJ6smicCCpzHxqy5crYLpI81oxuVeja7fFpBBf/QA
         0keuTp9zH5HwtmQBJHhkcKjTPsZS1Pfn8+IB1O9+Kg9L6wYt1u9FD1SwUcOxrPArcS26
         DmxLO2p6hk2VBo2UNWur3+F/0iRYwWHrXQx5cSpC1Bx/jM2lnrPGuYcMRFOxQZwuFwQc
         i+kquNT1L8dyE7cWt04QhqsTn7nrpwQWQsH5XS3p/Za3kALE/aGZpodo9qkJKn295pEf
         kASX5m2sPhBKWzTVJ5XsKFXy1GZmOUioh8uM8ALE8VpiR6+kEgvpezG81orAhzkmfTMr
         vDWg==
X-Gm-Message-State: AOAM5326avya/FVpYhruEOUtH9YnVPV5BhbsaigzN5sMgDFDi11Vo2jW
        u3z0SQCgeDt6UVxU3XcFxOnV0yJFgVB8AxZM
X-Google-Smtp-Source: ABdhPJzpxSRSjtr4pJygkDPBEhRffmMMyfd9P0g2mrERYszZ3+DVR0YWumqOtPLQE4YK+O+8QPuhTQ==
X-Received: by 2002:a05:620a:2915:: with SMTP id m21mr22225739qkp.147.1616975807180;
        Sun, 28 Mar 2021 16:56:47 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
        by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 16:56:46 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, dave.jiang@intel.com,
        dan.j.williams@intel.com
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/30] mv_xor_v2.c: Fix a typo
Date:   Mon, 29 Mar 2021 05:23:06 +0530
Message-Id: <c2a5a94826aa421f14b4ee7cbf99f74b82f91d32.1616971780.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616971780.git.unixbhaskar@gmail.com>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

s/assosiated/associated/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/mv_xor_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
index 9b0d463f89bb..8a45861299a0 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -175,7 +175,7 @@ struct mv_xor_v2_device {
  * struct mv_xor_v2_sw_desc - implements a xor SW descriptor
  * @idx: descriptor index
  * @async_tx: support for the async_tx api
- * @hw_desc: assosiated HW descriptor
+ * @hw_desc: associated HW descriptor
  * @free_list: node of the free SW descriprots list
 */
 struct mv_xor_v2_sw_desc {
--
2.26.3

