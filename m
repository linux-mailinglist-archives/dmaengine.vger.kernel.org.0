Return-Path: <dmaengine+bounces-10485-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHCTImAwB2p3sgIAu9opvQ
	(envelope-from <dmaengine+bounces-10485-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2026 16:40:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93141551958
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2026 16:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 68273302EC91
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2026 14:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08185320A37;
	Fri, 15 May 2026 14:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrR3BwkJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E7D224B05
	for <dmaengine@vger.kernel.org>; Fri, 15 May 2026 14:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778855189; cv=none; b=rkiXMjSGZU4jy4yUTMBfh86W14Nj/f2TfEJocglZBBOfLYqxdI/KuXZNcCyeq4Jkft06a7xscf+HFPXqsgPsBrVcEDGd5XkItLTUnG6CGnS7xaNd4awi9Avv7fmmRqBx4XRazBzlTVjoXMlcZ8hvu88A7v1/zrmXXhoYIxLtF38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778855189; c=relaxed/simple;
	bh=VOVg/TTcxbvis97d0X2PIuJPa+g5VbyjJLt+s8JUxbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r1QSdhmaLlApdxzGOfNGAHAeOYQ9mc4uGSTxFWPlkb/I6+4oi3TtfAcOcTzguiK3GXLl3ZXpHKuV0g8TFdxYCIIuJh6JdczcDxl/CmqpIZBsxRbP18VZqsfsUPJnoWNrUnXeDVAErLtnlnNk8KlubzsG2sUYvg1DbnnqQugZGQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrR3BwkJ; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-90fc979d84cso224247385a.1
        for <dmaengine@vger.kernel.org>; Fri, 15 May 2026 07:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778855188; x=1779459988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fbh4cgdubzbkagDA05ojWdi0ovR3y6wVbfyyv65VFcw=;
        b=IrR3BwkJ5co7Gy/uTC3NOaHHltRxTCz+FP07uYwngPSZHkSEIQ8zwkQu+Hb6IebXWk
         DBjGGjtFRf3m6DMn1+rPRdC58D6MbZMNRVUjU7vCRtCHmmhxOlpsqmIqQkkU5UL7eDW1
         Zc7g5vPCZ7uCFrEuOyWA5d05vrxEjeaOpjzd/OdYjkbZMWjg/V+CzpLELrYBbkd4RevT
         3LInfeml9CByU8EP+rY0YvZ450uENEfhN0fAB2hVJTbDi/m31eUPWoVUe8tRgHpAEiBR
         D9WQ++Drsyv7QD319HpJZJ9aIEHS33BkUtzd7lxLXcPPl+Vhpbt9gEk6H0zTRamc2tGY
         o61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778855188; x=1779459988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fbh4cgdubzbkagDA05ojWdi0ovR3y6wVbfyyv65VFcw=;
        b=cnUIvxTVb+mWKx88+b08TYUsM0VR7HZ9kHB6L3Ca9FS5+2gN6LfTxXPXBgdb6v6ilR
         /7i7S0npYYT5ireg5gLAjhwbv/6N+lT4NCxD81Hm+jInNqiLEURB6wbp2hSuF9LVrmDX
         vQtvY+s/MVutZtaLwknjvk46rDAYwJfUZR6tgLhQSg0KB3qfctyDYfGV8iTH9uvHJDHo
         kBsqfP9KyQRbxFscGnyS5/LbvocWcR/6fI6PaFVu0ms2JDsYviFKweaYJr3CXLnsIbQX
         gFMnmsDeVGHu3JgjtIzZPTmBStHtDvTjhungXEnQeiI26KrKdrwUNUaKo40xYxXvi9ps
         TEKg==
X-Forwarded-Encrypted: i=1; AFNElJ+q9dEtmLCY9s+jhWTeqWnmYwkV+heoPbxr2BVaG96OeFc80tJMPOTtMmrOLFta0iCskJ0dAxObmYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ0c60Q4kROMcU2aUkmDLf5in3YzUU0h5edV8bbRY6ppliSp68
	I5IfceyFlDEgwmzv6GfXqaofpEaiPKwPC6ZAXAS0ffdNSg8H25UJnYnQ
X-Gm-Gg: Acq92OF1Z/mPRXkE4V2r86u/pObmHZqGaldnGFRbxzdPIbl361gQseAk/RAHoTI3nGe
	xr07ABqU1o7UZ+8CGiC/htvQzX/v6OzHqqvE8F5lL/ErF05MfLBpGtYj65QcJSr5M9XRuKvhR4Q
	rRA7C0inKzNEKJIyDiqq8omhfNcnye8RELmMwfdNocFvP3AzVunh1K+RTfodrj56myDtJsSZZO5
	oMNuAov2eLbuhywB2gC4vntww7MU44+GM+KCSimpsoxOAGej/Y0JlWu/FWRebVxFfK8ocdq5GEa
	v7NM06mIx57EJFS+c+0+lKqX8PCIVtlFoe/DXci+zOyUijIduYNvR8DKkSe/JmmbPN7QASF12TG
	KU6ELXs4wgxnBmU34We6Y4rdBUpnmpCfcuIg6U5kHFLXE5NQfxunX5zHYX3ehhqDXdRxqoewZaA
	OfND5KNkHH9r9LnUgkHwNeXPmb0A7o6PcnwDI2ocdX3iYvfr5R+vo=
X-Received: by 2002:a05:620a:3708:b0:8cf:d3ca:535c with SMTP id af79cd13be357-911cd469227mr693948085a.4.1778855187568;
        Fri, 15 May 2026 07:26:27 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bcf3732dsm544054385a.33.2026.05.15.07.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 07:26:27 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v2] dmaengine: idxd: fix deadlock and double free in idxd_cdev_open()
Date: Fri, 15 May 2026 10:26:23 -0400
Message-ID: <20260515142623.793549-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 93141551958
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-10485-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The failed_dev_add and failed_dev_name error paths in idxd_cdev_open()
drop the file-device reference while still holding wq->wq_lock. If this
is the last reference, put_device(fdev) runs idxd_file_dev_release(),
which takes wq->wq_lock again and deadlocks.

Those error paths also fall through into the later ctx cleanup labels
after idxd_file_dev_release() has already freed ctx. This can make
idxd_xa_pasid_remove(ctx) operate on freed memory and can later free ctx
again at the failed label.

Use scoped put_device() cleanup for fdev and return from the fdev setup
failure path after unlocking wq->wq_lock. Take the WQ reference before
fdev can be released so idxd_file_dev_release() always balances a
matching idxd_wq_get().

Fixes: e6fd6d7e5f0fe ("dmaengine: idxd: add a device to represent the file opened")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
Changes in v2:
- Use __free(put_device) for the file-device reference.
- Take the WQ reference before fdev can be released so the release
  callback's idxd_wq_put() has a matching idxd_wq_get().

 drivers/dma/idxd/cdev.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 0366c7cf3502..18ff29118d12 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -216,7 +216,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 	struct idxd_user_context *ctx;
 	struct idxd_device *idxd;
 	struct idxd_wq *wq;
-	struct device *dev, *fdev;
+	struct device *dev, *fdev __free(put_device) = NULL;
 	int rc = 0;
 	struct iommu_sva *sva = NULL;
 	unsigned int pasid;
@@ -289,6 +289,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 	fdev->bus = &dsa_bus_type;
 	fdev->type = &idxd_cdev_file_type;
 
+	idxd_wq_get(wq);
 	rc = dev_set_name(fdev, "file%d", ctx->id);
 	if (rc < 0) {
 		dev_warn(dev, "set name failure\n");
@@ -301,13 +302,14 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 		goto failed_dev_add;
 	}
 
-	idxd_wq_get(wq);
+	fdev = NULL;
 	mutex_unlock(&wq->wq_lock);
 	return 0;
 
 failed_dev_add:
 failed_dev_name:
-	put_device(fdev);
+	mutex_unlock(&wq->wq_lock);
+	return rc;
 failed_ida:
 failed_set_pasid:
 	if (device_user_pasid_enabled(idxd))
-- 
2.43.0


