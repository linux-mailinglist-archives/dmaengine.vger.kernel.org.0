Return-Path: <dmaengine+bounces-10875-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DQqCVhaFGofMwcAu9opvQ
	(envelope-from <dmaengine+bounces-10875-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 16:19:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4A85CBA94
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 16:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DE163014C30
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 14:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E8B3B4E9A;
	Mon, 25 May 2026 14:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGIMW12u"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397A33B2FDF
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779718571; cv=none; b=jVAx+hvlJCfoFZhltCWYYquwpGFYd4KELmWiup6YLzsEdhncVcM/G0ex+OhYemKht4/ndvP8ynRrCW9HWgBp4NlbvUCbloIndy3CD4dP9MXPMRBrUFGWvZOKbLaG3PwKN3BPb4ZggzH68F+uKBjUDGz3DEuw18wprBrgsnx1UZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779718571; c=relaxed/simple;
	bh=97TcSk7c6BRe9ZZo0iCmpFWTVvCvOAMfpbkGNdYidDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vc0xVR1ys3hY/WPZUk//FO4d4h5aSSwIoe2lPrmTg3eOV+F0j792qiU0MNLAwnaz0onlCKZ2iKEjoJPYcUsf6nnOO6tK2Jki5SM9z/bKdcPxRb82vSIjdY/xS6MP0OyB6peFrq92+fP/fEH3WrDoKiSfNtvri8An7ujrOJ5xGwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGIMW12u; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e568ab0bc5so10478281a34.0
        for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 07:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779718561; x=1780323361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TnXyCVWggg3/qEkvLDg7uPlDc01HqQ/Q3+WVp/VlN0w=;
        b=DGIMW12uCBivuUxH6a+VlhdI2nc8YiI/Aa0Tu0Mjzm+4fD/IG06awA8dFj4v3wxhkn
         DKC19jhdWlKQwnl3ZgbJkJTlyMX3gFTSSQ6GlC5giiBjlusl38UpkdiKN3ocjuW0GOXJ
         MckumuEbOmOB9paqcxO35GjV1pvzLzuL5mQ/JhbcyP+sn/W73YzlHpdSEa9GwEolFOuJ
         ZG+UPiAqTi+oPpAdJxcNgq8LdfQmsEzwTXuSyporEj6gWJDGow8nvJujRta07pXaq14M
         rlFFxyTO1s06oECKpbR3xu7LVxTtvXC7LlzWqPhM8BBUSAQWrFIsNVuKyhAgpvoVROjH
         f21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779718561; x=1780323361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnXyCVWggg3/qEkvLDg7uPlDc01HqQ/Q3+WVp/VlN0w=;
        b=BCouUB5R0K8gWabYUHqON51ENfh9cKsa6NzRaxQn4RIs/7ZSrinY16tJcqZ880RkPU
         XxC9hfISBCArxGManzPILxIHTkY7ki4UYfpT7br4Sod6qcMdCt22oM865bu1yViR5+Aw
         zr5UyYuWXgwTPbDiPugzCUySP1Jlehve/EiCpoYhWkKXSKpJSCSQcgYQQfPfuxhNoV9v
         ZkG/bIgmGWCrZNWwxSoTXxy+dwTegA4O4VGeLyphhPL5Roco8RFPBUVoLekcLYWPVstB
         SwBkBlT23TxzfdS9PArfjJYoK0nYzqbVA1JroAcRNZjZYQwqyjaOjhxfnZr9QDdttAZq
         NKvg==
X-Forwarded-Encrypted: i=1; AFNElJ+ZoFCN7lLUdvEHKIiXYldPCtt5DlZQUxftQnBjjaVVOr8qJCAvZLNLHfpfb2/IKZ/CTnrX7USdJlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU9ga0CZk9LLaXHy6ArHiLZ3828FUTjoICQRFuH5wyAoYIE5Y1
	4Fo32aHSp59nBk/ot1F3DTGng1dvybwflGOXwTucM1B43M2dTerwl6Hf
X-Gm-Gg: Acq92OF/LmT6xJgSL7wpTY19ZF/17wOlEl1j2NuqkRaLvqo+yUP/eH+x6JKdv1fad64
	M4+CJWbzntqqrTbbu/qPAGZ5VqLMqmK+jmBDM0s4p7wEQWZG9FI3XUuzv3f/UVnUBL0Mnnvhd2A
	prlmQPt+tMCqTxX61NzbfIXPKP2JPQdNuXmmC2KYtnaFZDvEx0IdEFlU5Yq52f+jKG5HwzN2+hb
	T78MdzwxdKW98ZwLWZE0OkYWm2KLdU4s3Q8Pt7pcu2kSa7Hur6fdXZI8d/ACiLvdvK4o0Xf1vcu
	0fb1pmKTYbsAV+5F25qn5zrl05xWuoqnC4Mpjn5RZgYnfUWyt07CelLGpOxmTvtwbgMWGw/v9iZ
	0xqWrQZtCW71PvLbBF/pxpg4cz0ME2vBQ1b/0rGbOq+GHaDzctaaG3+Gy9H2A221P22PaV0NlcW
	ocglfAwjcq+W9o/c2tfCEdPJgOGbBfkPcwDAgL8xwy32xDlaMulSw=
X-Received: by 2002:a05:6830:6e0c:b0:7e6:69f:d208 with SMTP id 46e09a7af769-7e6069fd4f3mr5253693a34.2.1779718561041;
        Mon, 25 May 2026 07:16:01 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc812e657csm121728406d6.24.2026.05.25.07.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 07:16:00 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v3] dmaengine: idxd: fix fdev setup failure cleanup in idxd_cdev_open()
Date: Mon, 25 May 2026 10:15:50 -0400
Message-ID: <20260525141550.1385581-1-dbgh9129@gmail.com>
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
	FREEMAIL_CC(0.00)[intel.com,kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-10875-lists,dmaengine=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dbgh9129@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[dmaengine];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7E4A85CBA94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The failed_dev_add and failed_dev_name paths drop the file-device
reference while wq->wq_lock is still held. If put_device(fdev) drops the
last reference, idxd_file_dev_release() runs synchronously and tries to
take wq->wq_lock again, deadlocking.

Those paths also fall through into the later ctx cleanup labels even
though idxd_file_dev_release() owns that cleanup and frees ctx. This can
make idxd_xa_pasid_remove(ctx) and kfree(ctx) operate on a freed context.

Move idxd_wq_get() before file-device setup can fail, since the release
callback always calls idxd_wq_put(). Then unlock wq->wq_lock before
put_device(fdev) and return directly from the file-device setup failure
path, leaving ctx cleanup to the release callback.

Fixes: e6fd6d7e5f0fe ("dmaengine: idxd: add a device to represent the file opened")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
Changes in v3:
- Drop scoped __free(put_device) cleanup and use explicit cleanup, as
  suggested by Dave Jiang.
- Keep idxd_wq_get() before file-device setup can fail so the release
  callback always balances a matching WQ reference.
Changes in v2:
- Use __free(put_device) for the file-device reference.
- Take the WQ reference before fdev can be released so the release
  callback's idxd_wq_put() has a matching idxd_wq_get().

 drivers/dma/idxd/cdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 0366c7cf3502..82b07cf942ef 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -288,6 +288,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 	fdev->parent = cdev_dev(idxd_cdev);
 	fdev->bus = &dsa_bus_type;
 	fdev->type = &idxd_cdev_file_type;
+	idxd_wq_get(wq);
 
 	rc = dev_set_name(fdev, "file%d", ctx->id);
 	if (rc < 0) {
@@ -301,13 +302,14 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 		goto failed_dev_add;
 	}
 
-	idxd_wq_get(wq);
 	mutex_unlock(&wq->wq_lock);
 	return 0;
 
 failed_dev_add:
 failed_dev_name:
+	mutex_unlock(&wq->wq_lock);
 	put_device(fdev);
+	return rc;
 failed_ida:
 failed_set_pasid:
 	if (device_user_pasid_enabled(idxd))
-- 
2.43.0


