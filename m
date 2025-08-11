Return-Path: <dmaengine+bounces-5979-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4697BB205F2
	for <lists+dmaengine@lfdr.de>; Mon, 11 Aug 2025 12:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FE6C7AD353
	for <lists+dmaengine@lfdr.de>; Mon, 11 Aug 2025 10:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1B823BCE3;
	Mon, 11 Aug 2025 10:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OzXvTaVS"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9941A2367C9
	for <dmaengine@vger.kernel.org>; Mon, 11 Aug 2025 10:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909032; cv=none; b=EVr+W/3uZuZjhIwMUFIX/M8klfzpIQbJdL5F347+cGjxmfFrN3pSVftfwgQvrHPHygS28EGLjB7U69FIDOOs3nd2AZoCgGkS7U66bXz0P2lnVqiZVp79d5e01rZHlqIk3Mjjr80KZTGI2l/zSqgCrRTXQGHojgPd782KA9yXChs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909032; c=relaxed/simple;
	bh=jjqXaXgDKY6odzDCw+MVbdVk4B3G+zBmo7YkF3nHZYI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eCUWWV/mt5MyOyAtZRbd8gisj/ha2brG0kdSCuy1SC/3VCtGaBb6veaoa7e9uPi6ni24h8deo2/4m9B2y7oPX43hfqRQR5vUFLkJd+mngSbRIKiFu8JRtjCN0qfCr+45CDjQb4zGA9OpDXMFJsshi+0l9MroHakBnaLcg5v2aHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OzXvTaVS; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b78315ff04so3614994f8f.0
        for <dmaengine@vger.kernel.org>; Mon, 11 Aug 2025 03:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754909029; x=1755513829; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SOPcfPUvQvOcfMF7KghzUxDLwNBuyBOE7Sg8u+9nTqY=;
        b=OzXvTaVSAnT0WLWTeZiXo3UgTbx6h9GqUjYAD9zSO4yudh5fnd4Vu9Bjn/TpHvSSjT
         oAmtUx0TK3rA/5Cqo5EsIOKupOhwALxrsQEsH9wQHVLNWpd1O7C/qip3SaXsGxUa7Jt3
         DmjY1uDQmHcqcWvUV6/Qi7AIBwrpyMS2wstAckYllWeRCh4y9j1ILBUuxIHax5aYtXIy
         PxkiwH4C1cqWb99eg63GiUr0NBJv2eKk4qwYXyrYdb00OnEX+bQ93HntDJR/e0a5o5e/
         0DoOTXqmBSPDrVBWgcDovchdL5amKOm6NGYg2QARnhw8O2qFOOrHad2P91CO+8Snlep7
         5WQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754909029; x=1755513829;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SOPcfPUvQvOcfMF7KghzUxDLwNBuyBOE7Sg8u+9nTqY=;
        b=xL5sV0r81GvJG+4nGgbdYL8xiL/68XHSBWpXD0QCZrsN9In1CJzWCk4Xiis5fMRzGD
         HVnZHnrsi207ZRi/1wxYxnQLHH40+Zjq4E6cMYPR9gADzgL3+3MlqsDdE4nwtLXmFoHw
         IL5ZvdSkIkswSi75ZQ0jo8Dk6wmMQ+uhnqnqY1XHsXe1feXeHLfoQH6U5RDsk3Irp2uM
         FxbAH4MYW/DFlTQtpcY1ZBDoLUPapD/13iSdYLRCC4lbU01inzuiIPKUWDPWIOgKGUug
         9dDMaWmEIG+Pvx5X1x/xzWQgkGov7tMrMBoc+uXjS6TF8HDPMMM6VToSpj5Aw/9K872q
         ukfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVADKDjmHzLllN6vimNq+ST0lYgiW7IiipTwlm6RwzYQ0cH+zttSLHsICX2aCZNH1Qj0eGkC25Vgj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOf5tCvoKvwnF7miDRLDz9Z6346DL/5YEqht5045JwmfbtuQjM
	bcsab095b43UYcO7gs9TdlUeAIBxNExsRhQLFxWbcUyEjgJYnkHC1oRZN/kCGaxvTLE=
X-Gm-Gg: ASbGncuXQ4NZJcqwkhBw8TzulBpwvd5i7u7/v3AtPDbUOA9uNjLUPs7ZmrxacYnnTS4
	lPvqUuHOGNP1jRYCrqwBptwW972lSR1fx6XpECOxnwa/ZFOz8aDftZE/xVIuGC/aGGV1cqpT0yQ
	W7167/gHawXoqSQ3r1HifhOwum3zhHcGDXnxVefwYS9J4FGTFV/KX/DmgJUXiMDd78tgMD0ElHx
	KRt413II2nj10xL6DnZsER5w/eW2eRJhI/F4esH/eKmlBThIwrSFwth1OHEIJo5irbZvTXCmR6T
	hANDQgW90MbpGHGm/yTUKrMJWEYvKoTDJVzyTdUlPc3qTrEnUDG5Yd8+S6zJoZ2xQTtm1iQF89i
	GXtBZPlTkzIbf7So6S0aocA+so6Lb0Zik
X-Google-Smtp-Source: AGHT+IG0ravrynpY15kze3mYxWIzwLW/5/aen3QDh1FeTgm/ACIuqbr2R1w9fseNZY6MZKwA1ZpxfQ==
X-Received: by 2002:a05:6000:1ac7:b0:3b7:6d95:56d2 with SMTP id ffacd0b85a97d-3b900b449b0mr8903590f8f.7.1754909028830;
        Mon, 11 Aug 2025 03:43:48 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-459dcb86d6asm299844695e9.5.2025.08.11.03.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:43:44 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:43:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>,
	Colin Ian King <colin.i.king@gmail.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Fenghua Yu <fenghuay@nvidia.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] dmaengine: idxd: Fix double free in idxd_setup_wqs()
Message-ID: <aJnJW3iYTDDCj9sk@stanley.mountain>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The clean up in idxd_setup_wqs() has had a couple bugs because the error
handling is a bit subtle.  It's simpler to just re-write it in a cleaner
way.  The issues here are:

1) If "idxd->max_wqs" is <= 0 then we call put_device(conf_dev) when
   "conf_dev" hasn't been initialized.
2) If kzalloc_node() fails then again "conf_dev" is invalid.  It's
   either uninitialized or it points to the "conf_dev" from the
   previous iteration so it leads to a double free.

It's better to free partial loop iterations within the loop and then
the unwinding at the end can handle whole loop iterations.  I also
renamed the labels to describe what the goto does and not where the goto
was located.

Fixes: 3fd2f4bc010c ("dmaengine: idxd: fix memory leak in error handling path of idxd_setup_wqs")
Reported-by: Colin Ian King <colin.i.king@gmail.com>
Closes: https://lore.kernel.org/all/20250811095836.1642093-1-colin.i.king@gmail.com/
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/dma/idxd/init.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 35bdefd3728b..dda01a4398e1 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -189,27 +189,30 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 	idxd->wq_enable_map = bitmap_zalloc_node(idxd->max_wqs, GFP_KERNEL, dev_to_node(dev));
 	if (!idxd->wq_enable_map) {
 		rc = -ENOMEM;
-		goto err_bitmap;
+		goto err_free_wqs;
 	}

 	for (i = 0; i < idxd->max_wqs; i++) {
 		wq = kzalloc_node(sizeof(*wq), GFP_KERNEL, dev_to_node(dev));
 		if (!wq) {
 			rc = -ENOMEM;
-			goto err;
+			goto err_unwind;
 		}

 		idxd_dev_set_type(&wq->idxd_dev, IDXD_DEV_WQ);
 		conf_dev = wq_confdev(wq);
 		wq->id = i;
 		wq->idxd = idxd;
-		device_initialize(wq_confdev(wq));
+		device_initialize(conf_dev);
 		conf_dev->parent = idxd_confdev(idxd);
 		conf_dev->bus = &dsa_bus_type;
 		conf_dev->type = &idxd_wq_device_type;
 		rc = dev_set_name(conf_dev, "wq%d.%d", idxd->id, wq->id);
-		if (rc < 0)
-			goto err;
+		if (rc < 0) {
+			put_device(conf_dev);
+			kfree(wq);
+			goto err_unwind;
+		}

 		mutex_init(&wq->wq_lock);
 		init_waitqueue_head(&wq->err_queue);
@@ -220,15 +223,20 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		wq->enqcmds_retries = IDXD_ENQCMDS_RETRIES;
 		wq->wqcfg = kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(dev));
 		if (!wq->wqcfg) {
+			put_device(conf_dev);
+			kfree(wq);
 			rc = -ENOMEM;
-			goto err;
+			goto err_unwind;
 		}

 		if (idxd->hw.wq_cap.op_config) {
 			wq->opcap_bmap = bitmap_zalloc(IDXD_MAX_OPCAP_BITS, GFP_KERNEL);
 			if (!wq->opcap_bmap) {
+				kfree(wq->wqcfg);
+				put_device(conf_dev);
+				kfree(wq);
 				rc = -ENOMEM;
-				goto err_opcap_bmap;
+				goto err_unwind;
 			}
 			bitmap_copy(wq->opcap_bmap, idxd->opcap_bmap, IDXD_MAX_OPCAP_BITS);
 		}
@@ -239,13 +247,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)

 	return 0;

-err_opcap_bmap:
-	kfree(wq->wqcfg);
-
-err:
-	put_device(conf_dev);
-	kfree(wq);
-
+err_unwind:
 	while (--i >= 0) {
 		wq = idxd->wqs[i];
 		if (idxd->hw.wq_cap.op_config)
@@ -254,11 +256,10 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		conf_dev = wq_confdev(wq);
 		put_device(conf_dev);
 		kfree(wq);
-
 	}
 	bitmap_free(idxd->wq_enable_map);

-err_bitmap:
+err_free_wqs:
 	kfree(idxd->wqs);

 	return rc;
--
2.47.2

