Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE2134BFF5
	for <lists+dmaengine@lfdr.de>; Mon, 29 Mar 2021 01:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhC1X4m (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 28 Mar 2021 19:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhC1X4S (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 28 Mar 2021 19:56:18 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D6AC061756;
        Sun, 28 Mar 2021 16:56:18 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id x27so5714953qvd.2;
        Sun, 28 Mar 2021 16:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qPii/xX6YhM4hcBO+zp3OVMgz+jDeBjNcGIvzkkQGYk=;
        b=bObaSHbQgF7HnhhFevByLeRAEjwh9Xgx/6poqOyVrhU9nI9SQbKZibaot0nVJHtdHK
         o79A8Sp+Gz79oGtGsF5SxsTYB9AMcZOuDAKRePAi8OQlhWEu8LqzdcK18F1hIKWGpwTt
         +hcuXkQ52IF+FdKd1u3A+2KvczRYSW2FxnhgIJbngK13+y5D665LByLLaOIYq5prJ2BB
         q0KPV1xmQES9uuwOigJWctcX+oM6I0mAu6NH+RzVkz/A8hrPHIr5VI27yaHxNHMRhJ9S
         ZkZNPLNBdVtA2r2vkh1TOiWiTBT+BsXGquBT60jgmW2VoagfFPx16zh5v8S/U1Z6V3eJ
         yCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qPii/xX6YhM4hcBO+zp3OVMgz+jDeBjNcGIvzkkQGYk=;
        b=pBXU+S1Zed/wN7RXSBzzyqFDhWS+4jUb4AVoP9UMOklnfE+af8OermVBmPC6hd4LDp
         N0fl/q/Kphq58ZRs4gn/bFZgIXFdbIkAMahvB3EIPZ3H24Hp3yGYER4kCGU8UzzvzNfD
         i8354NYDJTJ/97ECj9GRJW/gTdZ73FKs2wbrbktLuAyN3lLpo1T9mta1LCyuSM+N5Qxe
         /eDsi3g6AwPRbOYtxFVcgl+irzbh1Fh9b8LjDQF2vhZpzVwIHtrlxRmletaCbUP30Wdm
         TvOlyAEyYeCCR0Ob4Y6YZ0EuLkv4jVPShdDG8iYqp3mCr4kLkBSYMEqfkfc8mQv3I43k
         oLnw==
X-Gm-Message-State: AOAM532UR+iePdUjvP0XZfQhzVZ0hk4FrgKhAvKWpzCu4K/eawi8NT2V
        hbXXOxgFFvbmWODqBtYuBpWH//lTNMzKktYy
X-Google-Smtp-Source: ABdhPJyIwQh8O82d8qyrfIuUZz0SqJYcgUURzt27W+q5h1fBWMUvMvJGKHkKfG17NwqDAaW/0JNrSg==
X-Received: by 2002:a05:6214:d85:: with SMTP id e5mr22653184qve.36.1616975777547;
        Sun, 28 Mar 2021 16:56:17 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
        by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 16:56:17 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, dave.jiang@intel.com,
        dan.j.williams@intel.com
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/30] bcm-sba-raid.c: Few typos fixed
Date:   Mon, 29 Mar 2021 05:23:00 +0530
Message-Id: <a421c27ea6dc2808edec25b18238941ab5aefcf4.1616971780.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616971780.git.unixbhaskar@gmail.com>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

s/Maibox/Mailbox/
s/alloced/allocated/
s/atleast/"at least"/
s/parallely/parallel/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/bcm-sba-raid.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
index 64239da02e74..fba1585eb7ad 100644
--- a/drivers/dma/bcm-sba-raid.c
+++ b/drivers/dma/bcm-sba-raid.c
@@ -25,7 +25,7 @@
  * number of hardware rings over one or more SBA hardware devices. By
  * design, the internal buffer size of SBA hardware device is limited
  * but all offload operations supported by SBA can be broken down into
- * multiple small size requests and executed parallely on multiple SBA
+ * multiple small size requests and executed parallel on multiple SBA
  * hardware devices for achieving high through-put.
  *
  * The Broadcom SBA RAID driver does not require any register programming
@@ -143,7 +143,7 @@ struct sba_device {
 	u32 max_xor_srcs;
 	u32 max_resp_pool_size;
 	u32 max_cmds_pool_size;
-	/* Maibox client and Mailbox channels */
+	/* Mailbox client and Mailbox channels */
 	struct mbox_client client;
 	struct mbox_chan *mchan;
 	struct device *mbox_dev;
@@ -328,7 +328,7 @@ static void sba_cleanup_nonpending_requests(struct sba_device *sba)

 	spin_lock_irqsave(&sba->reqs_lock, flags);

-	/* Freeup all alloced request */
+	/* Freeup all allocated request */
 	list_for_each_entry_safe(req, req1, &sba->reqs_alloc_list, node)
 		_sba_free_request(sba, req);

@@ -1633,7 +1633,7 @@ static int sba_probe(struct platform_device *pdev)
 	sba->dev = &pdev->dev;
 	platform_set_drvdata(pdev, sba);

-	/* Number of mailbox channels should be atleast 1 */
+	/* Number of mailbox channels should be at least 1 */
 	ret = of_count_phandle_with_args(pdev->dev.of_node,
 					 "mboxes", "#mbox-cells");
 	if (ret <= 0)
--
2.26.3

