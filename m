Return-Path: <dmaengine+bounces-10021-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PafIyr732ntbAAAu9opvQ
	(envelope-from <dmaengine+bounces-10021-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2026 22:55:06 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33705407C46
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2026 22:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2927301D31C
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2026 20:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6535B386C24;
	Wed, 15 Apr 2026 20:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYvP6ToX"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC00829ACC5
	for <dmaengine@vger.kernel.org>; Wed, 15 Apr 2026 20:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776286498; cv=none; b=SsEDs4Wavb72CKuks8HIKV2EDiJXp1WctvdRaEjhykUuF+z4l9YFRf7VIGCjWcwfD+fBDc1w3J3VSfb4LDAwavUCnfmCgGBg6hRFU4dNsCeKKXR4L/oNj8B4VqkQh/hpw5E0Sb7/6v+wkJpgj9F0BHfa7DgE+x8RJv6GUfjmcFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776286498; c=relaxed/simple;
	bh=CIig0oQq5yHGW+pYesGTtuB+dPuvghH25hD6RPj7nUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U/ZcdFt16U71bOVtVill/vp4VE8PlQDo9Fk8WZwS24OdRhiq7sGEBIjRBzhrYO2pF+4M7bSL4p16MfzP1z/5sm5rQKOOQfs7QbmrmrL8MZX1T/eX42xdrS3C9/2hlG/9wTRwHoFDaEObsNTRTKFQVv0NHTzHWf7Jwgnl0j9GV9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rYvP6ToX; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50d6b9bca48so94958571cf.2
        for <dmaengine@vger.kernel.org>; Wed, 15 Apr 2026 13:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776286496; x=1776891296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5wI9Om12pRgMIyRltB1FE+/OLTEU+POmfWziZVV+KeU=;
        b=rYvP6ToXuc9Ym/knEVfkwS/dZ5c9HuVkuq3uIDElWdeVOrPTbGaT2MyWgk4ojqGYL4
         AlqyqND2SHga5Gqeev9hAKZ9CO/0ANb4EKyYCus/QPl2G3elveF3uGHUYhsWIgkFBtWB
         kJbg+6G+j2jfkglq8R2W4lw1JSdHXYdKvk+a5ou3/qcwwZ1pfV0hjd3MkcyqVlF5c0Fl
         xjQSnV8lieAKrMcx1KEwHCw5Y8D1zebRrIyjkVs5KnO1Ys3D6v2Wn+t6BkFbwzT51cbn
         c7Evd+88RN0SMF8s8JJzBAxuZpgEwHOOb62MjGA/lJZ3x+xfRUageFVNQ5eHkgnWNf84
         BKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776286496; x=1776891296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wI9Om12pRgMIyRltB1FE+/OLTEU+POmfWziZVV+KeU=;
        b=L3PZikOdhyZnJQRx8+71AzzGFlL/W6lAz1N358XCrgTPJfgbLAmABfEsTfNnATl2YP
         jxSiuKuIehsey6HJWwUz1Bad7aT7YPHXJ0H3y6UR7/NjoX7E8FPihN6JC5eAnU28WLZS
         6b6lA9uNUAmZHscsrecsnqLcACxSHU7Nu5z0eYH336siNfq7Ue5QDkaog4bmoqdMuFMy
         /bOX8z1N953G9g5VrEqdJWzHPbMRiQpSH/R8LAy0aN4qvBh+okv/LQ5aeVN8SH5fkXNd
         vUoYx4g/WOC+O8Vgy2MiqiAQX/d0PZ7NZtoKGNFmVRQ01seUPbrAP2TBbnxCDsiIG4M+
         EgNQ==
X-Forwarded-Encrypted: i=1; AFNElJ/DK0FYIIe31ztyzlwlLeDfzC1LKju/+YElZfBgKvyRD1z5LntVBrL1dQhwgan8AHMqn/HSmFblOpg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7YkgCYLQTbBOZtb+o29BXMKCugaLuLMLcSABUAJCloqM5e9MK
	3imURxnEFBh+QowyXb4an/CwUfWkronpvVk5JWmH8YGb48GB1urVxpve
X-Gm-Gg: AeBDietH62Xy2ZX7e75TCs/SS91Y8nVpkBcO7zpgGqTO0ut5nl4Hnm9edf4QfQUuTrZ
	Wa6KU5FssIoaWrVsUm3UQIV0qxoVJlDvyoEKGjklnkguqzvpWKojJz9liPQpaQY7JfHat+IKEDa
	9EH08e/gGMTuv/dpn+J1Mv2mQCnITkWtpI+isiOV3EWfAxvZe9ESH7nYtpW7fS+6Di6GlQSeK+M
	eCLY7reHOQpEbnXQLCsu5aYqeTBR4QOVWuTb0OkKQcyAetl5QGDiHcircn5LRbXzWN/k3LRWCP7
	qGTD6Hc4m3sufs4HLGRSpDiMnphm7vKlL02+U+wBVcw60P20+vbM2I5Wh3F0AH3cMBp9Xwnkzrr
	MhEYdAaKex4Z1FEbSZLuNfJd9HWohXgjWT8v1l9XD0ho1+qGB8lkCXvhR5Q4qe8g+0Q5ks5fAp3
	KQu/EaZhxv6sSfjKxXEO5Zmtaka5ZEYcvgFyN7FgUHxlt89gOdHcJHhhc=
X-Received: by 2002:a05:622a:4009:b0:50d:66b6:1564 with SMTP id d75a77b69052e-50dd5bc5171mr357041541cf.14.1776286495729;
        Wed, 15 Apr 2026 13:54:55 -0700 (PDT)
Received: from localhost.localdomain ([104.39.116.151])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1ad9663bsm26078281cf.4.2026.04.15.13.54.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Apr 2026 13:54:55 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v1] dmaengine: idxd: fix double free of wq, engine, and group structs
Date: Wed, 15 Apr 2026 16:54:52 -0400
Message-ID: <20260415205452.67155-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.50.1
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-10021-lists,dmaengine=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dbgh9129@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[dmaengine];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 33705407C46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The release callbacks for wq, engine, and group devices
(idxd_conf_wq_release, idxd_conf_engine_release,
idxd_conf_group_release) each call kfree() on the enclosing struct.
The setup error paths and cleanup functions also call kfree()
explicitly after put_device(), producing a double free whenever
put_device() drops the reference count to zero and fires the release.

In the setup functions, device_initialize() is called before
device_add(), so the reference count is exactly 1 at the error sites.
put_device() unconditionally fires the release, which frees the struct;
the subsequent explicit kfree() then operates on freed memory.

For idxd_setup_wqs(), the wq release callback also owns opcap_bmap
and wqcfg. The error unwind additionally freed those fields explicitly
before calling put_device(), causing further double frees on both.

Remove the redundant explicit kfree() calls from all setup error paths
and cleanup functions for wq, engine, and group structs, delegating
sole ownership of those allocations to the release callbacks.

Fixes: 7c5dd23e57c1 ("dmaengine: idxd: fix wq conf_dev 'struct device' lifetime")
Fixes: 75b911309060 ("dmaengine: idxd: fix engine conf_dev lifetime")
Fixes: defe49f96012 ("dmaengine: idxd: fix group conf_dev lifetime")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
 drivers/dma/idxd/init.c | 36 +++++-------------------------------
 1 file changed, 5 insertions(+), 31 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index f1cfc7790d950..4b827a3297564 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -159,18 +159,12 @@ static void idxd_cleanup_interrupts(struct idxd_device *idxd)
 
 static void idxd_clean_wqs(struct idxd_device *idxd)
 {
-	struct idxd_wq *wq;
 	struct device *conf_dev;
 	int i;
 
 	for (i = 0; i < idxd->max_wqs; i++) {
-		wq = idxd->wqs[i];
-		if (idxd->hw.wq_cap.op_config)
-			bitmap_free(wq->opcap_bmap);
-		kfree(wq->wqcfg);
-		conf_dev = wq_confdev(wq);
+		conf_dev = wq_confdev(idxd->wqs[i]);
 		put_device(conf_dev);
-		kfree(wq);
 	}
 	bitmap_free(idxd->wq_enable_map);
 	kfree(idxd->wqs);
@@ -212,7 +206,6 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		rc = dev_set_name(conf_dev, "wq%d.%d", idxd->id, wq->id);
 		if (rc < 0) {
 			put_device(conf_dev);
-			kfree(wq);
 			goto err_unwind;
 		}
 
@@ -227,7 +220,6 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		wq->wqcfg = kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(dev));
 		if (!wq->wqcfg) {
 			put_device(conf_dev);
-			kfree(wq);
 			rc = -ENOMEM;
 			goto err_unwind;
 		}
@@ -235,9 +227,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		if (idxd->hw.wq_cap.op_config) {
 			wq->opcap_bmap = bitmap_zalloc(IDXD_MAX_OPCAP_BITS, GFP_KERNEL);
 			if (!wq->opcap_bmap) {
-				kfree(wq->wqcfg);
 				put_device(conf_dev);
-				kfree(wq);
 				rc = -ENOMEM;
 				goto err_unwind;
 			}
@@ -252,13 +242,8 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 
 err_unwind:
 	while (--i >= 0) {
-		wq = idxd->wqs[i];
-		if (idxd->hw.wq_cap.op_config)
-			bitmap_free(wq->opcap_bmap);
-		kfree(wq->wqcfg);
-		conf_dev = wq_confdev(wq);
+		conf_dev = wq_confdev(idxd->wqs[i]);
 		put_device(conf_dev);
-		kfree(wq);
 	}
 	bitmap_free(idxd->wq_enable_map);
 
@@ -270,15 +255,12 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 
 static void idxd_clean_engines(struct idxd_device *idxd)
 {
-	struct idxd_engine *engine;
 	struct device *conf_dev;
 	int i;
 
 	for (i = 0; i < idxd->max_engines; i++) {
-		engine = idxd->engines[i];
-		conf_dev = engine_confdev(engine);
+		conf_dev = engine_confdev(idxd->engines[i]);
 		put_device(conf_dev);
-		kfree(engine);
 	}
 	kfree(idxd->engines);
 }
@@ -313,7 +295,6 @@ static int idxd_setup_engines(struct idxd_device *idxd)
 		rc = dev_set_name(conf_dev, "engine%d.%d", idxd->id, engine->id);
 		if (rc < 0) {
 			put_device(conf_dev);
-			kfree(engine);
 			goto err;
 		}
 
@@ -324,10 +305,8 @@ static int idxd_setup_engines(struct idxd_device *idxd)
 
  err:
 	while (--i >= 0) {
-		engine = idxd->engines[i];
-		conf_dev = engine_confdev(engine);
+		conf_dev = engine_confdev(idxd->engines[i]);
 		put_device(conf_dev);
-		kfree(engine);
 	}
 	kfree(idxd->engines);
 
@@ -336,13 +315,10 @@ static int idxd_setup_engines(struct idxd_device *idxd)
 
 static void idxd_clean_groups(struct idxd_device *idxd)
 {
-	struct idxd_group *group;
 	int i;
 
 	for (i = 0; i < idxd->max_groups; i++) {
-		group = idxd->groups[i];
-		put_device(group_confdev(group));
-		kfree(group);
+		put_device(group_confdev(idxd->groups[i]));
 	}
 	kfree(idxd->groups);
 }
@@ -377,7 +353,6 @@ static int idxd_setup_groups(struct idxd_device *idxd)
 		rc = dev_set_name(conf_dev, "group%d.%d", idxd->id, group->id);
 		if (rc < 0) {
 			put_device(conf_dev);
-			kfree(group);
 			goto err;
 		}
 
@@ -402,7 +377,6 @@ static int idxd_setup_groups(struct idxd_device *idxd)
 	while (--i >= 0) {
 		group = idxd->groups[i];
 		put_device(group_confdev(group));
-		kfree(group);
 	}
 	kfree(idxd->groups);
 
-- 
2.50.1 (Apple Git-155)


