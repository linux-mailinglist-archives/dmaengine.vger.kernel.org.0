Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF03729B4
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jul 2019 10:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfGXIQW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Jul 2019 04:16:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33577 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfGXIQW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Jul 2019 04:16:22 -0400
Received: by mail-pg1-f193.google.com with SMTP id f20so11591114pgj.0;
        Wed, 24 Jul 2019 01:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UKu4ag1FmHjYtjYW+CMCBAQuhxQ6kM/fKKzKkjZJgHU=;
        b=pyfIH581kKyg3SluiHcyj8vETKepVhm6oRKb+sUkYTCPMAmOLcSEXjxKZUkMK6wv7h
         VEgo0GOmiuw1Y/gNziSfr2BWwTPeK4cA4kIu90H8cDAM2iJZEN3ZwFXs/kGdGANWCqs6
         P5NS3brOcUAituR3pb2WfdP8mcTGmzo6RCuGPWGPfLj0bOR31ebip3mVB9VjmDnSw+SP
         kNBXigb9vMBmyB2w2eBIGa2Jun0EfIYlty+BDB0rU575xd64OeMz3gp2KivcVbPjfIoy
         kCwM72V6qg7XJ6os4oE8+DJCQ7mXkSHxIwfULY0XcU0A4bJgUUhto9Gj4532ZB2IdhGV
         kReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UKu4ag1FmHjYtjYW+CMCBAQuhxQ6kM/fKKzKkjZJgHU=;
        b=erMJQe7a4A/Kh1dwy2Eq/A64cGC8gYZbgLudAiteSqUMt6ppwMErVl7ZOtjTvsWmAt
         gROwco6qchtn0THoiJu+8lxRasA/VB1ed1BngmqAzd+VOmsSSpksQXZf6gJO+pnBEwRH
         f76/G/V10mETXQxuSrC27ganzGf0jwkJNwAuxw/ujM21L11+axJLI2NbfQ0bZCjt0NFV
         JYXaiZhGkgyVQiUZhs7PcTE33D0cNtYyxrUReBUekh9FWFuEGrbtWiHLTvTP7HNsIGdR
         UMmcFIQdZs6qh/Vr3g7aRlbTQM+EqNPfLYEJpUfzYF0r9GRHwBV09UZkYv9bDFJ7tJbT
         Ludg==
X-Gm-Message-State: APjAAAUFAP2w2NHtc1+MNpJfHKdP1q7jutX9k6wdriL/UwkngymwIugS
        QqKskboGlaykRNh+32L86/o=
X-Google-Smtp-Source: APXvYqw9RmLNie/aY3kugAEekqK3Xf8pC8MGD13PNtXTwM3QjoBhtleaGBl/jaPHnS94EHz5FqkGyg==
X-Received: by 2002:a17:90a:9a83:: with SMTP id e3mr84858295pjp.105.1563956181475;
        Wed, 24 Jul 2019 01:16:21 -0700 (PDT)
Received: from localhost.localdomain ([110.227.69.93])
        by smtp.gmail.com with ESMTPSA id r188sm72204789pfr.16.2019.07.24.01.16.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 01:16:21 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     okaya@kernel.org, agross@kernel.org, vkoul@kernel.org,
        dan.j.williams@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH v2] dma: qcom: hidma_mgmt: Add of_node_put() before goto
Date:   Wed, 24 Jul 2019 13:46:09 +0530
Message-Id: <20190724081609.9724-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Each iteration of for_each_available_child_of_node puts the previous
node, but in the case of a goto from the middle of the loop, there is
no put, thus causing a memory leak. 
Hence add an of_node_put under the label that the gotos point to.
In order to avoid decrementing an already-decremented refcount, copy the
original contents of the label (including the return statement) to just
above the label, so that the code under the label is executed only when
a goto exit from the loop occurs.
Additionally, remove an unnecessary get/put pair from the loop, as the
loop itself already keeps track of refcount.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
Changes in v2:
- Move the put under the label instead of above each individual goto.
-Remove the get/put pair.

 drivers/dma/qcom/hidma_mgmt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/qcom/hidma_mgmt.c b/drivers/dma/qcom/hidma_mgmt.c
index 3022d66e7a33..43f806c8b51e 100644
--- a/drivers/dma/qcom/hidma_mgmt.c
+++ b/drivers/dma/qcom/hidma_mgmt.c
@@ -388,7 +388,6 @@ static int __init hidma_mgmt_of_populate_channels(struct device_node *np)
 			ret = PTR_ERR(new_pdev);
 			goto out;
 		}
-		of_node_get(child);
 		new_pdev->dev.of_node = child;
 		of_dma_configure(&new_pdev->dev, child, true);
 		/*
@@ -396,9 +395,14 @@ static int __init hidma_mgmt_of_populate_channels(struct device_node *np)
 		 * platforms with or without MSI support.
 		 */
 		of_msi_configure(&new_pdev->dev, child);
-		of_node_put(child);
 	}
+
+	kfree(res);
+
+	return ret;
+
 out:
+	of_node_put(child);
 	kfree(res);
 
 	return ret;
-- 
2.19.1

