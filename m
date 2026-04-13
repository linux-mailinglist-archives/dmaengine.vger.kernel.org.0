Return-Path: <dmaengine+bounces-10008-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMhcNXjW3GmcWQkAu9opvQ
	(envelope-from <dmaengine+bounces-10008-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Apr 2026 13:41:44 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F0F3EB6D1
	for <lists+dmaengine@lfdr.de>; Mon, 13 Apr 2026 13:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2D44302D5E2
	for <lists+dmaengine@lfdr.de>; Mon, 13 Apr 2026 11:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7473C2763;
	Mon, 13 Apr 2026 11:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGl2PfJT"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6653603E0
	for <dmaengine@vger.kernel.org>; Mon, 13 Apr 2026 11:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776080382; cv=none; b=onnFaRUJ0LrXpmslDOW44wVoc6e8CUQohhAvAPWzE8ZsWCklST+KpByd5yINuxgfgUMaFxM8fngrqN70twro1nz5EDUQcQyFwct/zC28QkVqrBBIb+P5CxfgX0YqIqWOQSQHjJpVy1v6LVTD5LvQejptcm4uFBWCxwf8xwh+qI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776080382; c=relaxed/simple;
	bh=YntEt/LZoVGnThRGEiUzRWkG7HPchILZZyy2yOKUjvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MjyaKq3Y89EjuWBE1iu92TQ2K3tfywJUJibPzdlXcaOaS9jhYsW1UYoKQgv0EozKzI5Juti46To7PcyxWvgVH8xtVRyP3lMQ7lhiPFR9TvczKVBcINQOL0o0ieSpEJ1/bqO8ANcSThI+LWBCeWnEZNR3K9QoOnpNgb5hPiGNlzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGl2PfJT; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35d9923eec5so2483361a91.2
        for <dmaengine@vger.kernel.org>; Mon, 13 Apr 2026 04:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776080380; x=1776685180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sKy2zr8o44SlqpTL5OnNaWPmsx1DrrUAZd9+1Le4qeA=;
        b=hGl2PfJTnjuCwxYEWAfQfovu7QfrVAkyOBKiN5iFIQyNeUXHHzmnl3AbZmVVBRKLRJ
         I/h5PhvSBA3ySE9hfF8RlMZUawrxGjePHufSb/pX/+V4cEnDWuQEAs1UBnCxqkZ7pzjT
         bsmVGTGWz8dR2s7PfCP8tt8Z7Ez4qxFthWXiV0x4vqvaypA2r83I7QPQoYR9lamm23N0
         cR0vbHz5fmWdTDxcDjcBlPLBHqSIQjV29HLZKa9oqM2UPqSuwRzM3mVTvgaViULcZDhD
         UJ40Ns40Tp2edVMhcKJ8LBFQsGbhKsl1J70TKtoFoxmLu9t6iwuWTmo6Thj2GHXxS2XF
         6Z3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776080380; x=1776685180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKy2zr8o44SlqpTL5OnNaWPmsx1DrrUAZd9+1Le4qeA=;
        b=ZVf634IGmr7o9KYQQWmFLdV4UoFlDWgDoMfrUbny2VZlIB6/qbWnKg3pj9oOf7RDt2
         5/u9dg//aLwMzDFTcZD9JzCGHIWUEMA2cZqDEn+JxTEkPtStdJYfeVq3aMJg+Kuosh7a
         NRwOL30OJDauiCs4dlquA3Mnk3fBKzdm9/Ys5b0prCzWp9WldA+tbeNG7Nx4QnBrZJs1
         QrmUec1FqV7tNP81hV1bD/AENSNjrUrpwwmdl7NUb9RY2VBZ4ecj1c5SdKqUwHg9t6WY
         oXaFETIPVqkwDj5fHtwxzI/RJ+1ODUqC577z/A/OfLjuz+LIfQr1mAZk+jasjYMjYkST
         sqWw==
X-Forwarded-Encrypted: i=1; AFNElJ9PoCLew+IPFAbw3YlRuoIguFg/0se7pn8FkOuAH6Ostk6N2oDtwCzkwdn1lhDYat4nIfKIX8uev8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFf7tKFx2udYZPoyLjmHmuTosMWfDjvc/8q0zyEPm66CX3iLgg
	4GvGxkWKXCUPz5Ha1enrvdUi1ISfvXePO98xGkQiQ3p6qaNOGK9PLAa/k+Ow27uL1cA=
X-Gm-Gg: AeBDieudVl7fve6rl6artSI3nJ9iNf+DMJyannPjx3QDlpNKhMNnh0DN1lmCmOfoKAM
	7o4+a+2wHtlt1vI+alkOe5HgL8x+Ff7UpehdppwAsPty11HE86G+6aBOCfkZuXxsmDxQ3vvhPAI
	8khKtd/HUDoBF5mQm3K2SCZD61K6sO+Lv44S18n5mrtqnaAdoeIqwtPRolLZfaCZcRgDQ/FQOlz
	lIePCYDJjvsfSQSPCvlWM9fLRGt7xtjYlw3qn+U1SwLVCntJ6EyFRqw4ihT680W9mu3Krr7kI/B
	MzMgXnwYnz6Yi2T26qYwAy1QI7v59qbFkE98RdUmXH0LEaIksmwUMRa6dcVF5zb9FWbJaXG1UFz
	rrZR4l7FqyPXEGiMgD2aGBaxkY7ZRfU0knivlPx+zJtrW+7apx0x934O+suK4YheWZynbC9N2a7
	08zf2Pqfhe8E7BJp0lpoNAag==
X-Received: by 2002:a17:90b:1d86:b0:35b:93d8:6aaf with SMTP id 98e67ed59e1d1-35e42827d1emr12889237a91.19.1776080379468;
        Mon, 13 Apr 2026 04:39:39 -0700 (PDT)
Received: from lgs.. ([112.224.67.108])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e4133695bsm15853279a91.13.2026.04.13.04.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 04:39:39 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] dmaengine: idxd: fix double free in idxd_cdev_open() error path
Date: Mon, 13 Apr 2026 19:39:27 +0800
Message-ID: <20260413113927.2753349-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-10008-lists,dmaengine=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[dmaengine];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 32F0F3EB6D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When dev_set_name() or device_add() fails, the call chain is:

idxd_cdev_open()
-> device_initialize(fdev)
-> dev_set_name() / device_add()
-> failure
-> put_device(fdev)
-> idxd_file_dev_release()
-> kfree(ctx)

Then control returns to idxd_cdev_open(), where the error path continues
with:

failed:
-> kfree(ctx)

Thus, ctx is freed twice.

In addition, idxd_file_dev_release() also calls ida_free() and
idxd_wq_put(), but in the current code ctx->id is allocated and the wq
reference is taken only after device_add() succeeds. If put_device(fdev)
runs the release callback before that point, the cleanup is not balanced.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Allocate the file ida and take the wq reference before
device_initialize(), so the device release callback can own the cleanup
after put_device(). For the dev_set_name() and device_add() failure path,
let put_device() and the release callback handle resource teardown.

Fixes: e6fd6d7e5f0fe ("dmaengine: idxd: add a device to represent the file opened")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - note that the issue was identified by my static analysis tool
  - and confirmed by manual review

 drivers/dma/idxd/cdev.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 7e4715f92773..001d233e091c 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -225,6 +225,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 	struct iommu_sva *sva = NULL;
 	unsigned int pasid;
 	struct idxd_cdev *idxd_cdev;
+	bool wq_ref = false;
 
 	wq = inode_wq(inode);
 	idxd = wq->idxd;
@@ -280,12 +281,15 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 		}
 	}
 
-	idxd_cdev = wq->idxd_cdev;
 	ctx->id = ida_alloc(&file_ida, GFP_KERNEL);
 	if (ctx->id < 0) {
 		dev_warn(dev, "ida alloc failure\n");
 		goto failed_ida;
 	}
+	idxd_wq_get(wq);
+	wq_ref = true;
+
+	idxd_cdev = wq->idxd_cdev;
 	ctx->idxd_dev.type  = IDXD_DEV_CDEV_FILE;
 	fdev = user_ctx_dev(ctx);
 	device_initialize(fdev);
@@ -305,20 +309,23 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 		goto failed_dev_add;
 	}
 
-	idxd_wq_get(wq);
 	mutex_unlock(&wq->wq_lock);
 	return 0;
 
 failed_dev_add:
 failed_dev_name:
 	put_device(fdev);
-failed_ida:
+	mutex_unlock(&wq->wq_lock);
+	return rc;
 failed_set_pasid:
 	if (device_user_pasid_enabled(idxd))
 		idxd_xa_pasid_remove(ctx);
 failed_get_pasid:
 	if (device_user_pasid_enabled(idxd) && !IS_ERR_OR_NULL(sva))
 		iommu_sva_unbind_device(sva);
+failed_ida:
+	if (wq_ref)
+		idxd_wq_put(wq);
 failed:
 	mutex_unlock(&wq->wq_lock);
 	kfree(ctx);
-- 
2.43.0


