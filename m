Return-Path: <dmaengine+bounces-10007-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GE0LMCbU3GmcWQkAu9opvQ
	(envelope-from <dmaengine+bounces-10007-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Apr 2026 13:31:50 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9A53EB531
	for <lists+dmaengine@lfdr.de>; Mon, 13 Apr 2026 13:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D09E301C6D4
	for <lists+dmaengine@lfdr.de>; Mon, 13 Apr 2026 11:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D1D3C0612;
	Mon, 13 Apr 2026 11:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOYocntj"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EF2E555
	for <dmaengine@vger.kernel.org>; Mon, 13 Apr 2026 11:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776079889; cv=none; b=RICLYndmJ3NwhRxKIjVcoawTUWrOz4MMJJQszWvENCML1h+PCpPQNv9IJefVfkAvlyjDReEqWXtHVmMbEApHXnQ7sPT1LZTX1mFqPMbom2wJ3kx+GkyHpDHvhA2QZz9l3si03/ta4PsQfB4tpArqvbFi6WIcMFWOX8z2tQOZEBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776079889; c=relaxed/simple;
	bh=DbVXFzZyjAoVeJHskZ1L0eh18MtWBJ4jGV+rreaw/s0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=maWUlNldYCH7XSxVLBl0tnBGOOPze90xo+eHwtsMmQqLPRzyq20qd/GRwWz73vfvNqxfJmM7gcAeXdVvlncYhoQZYEPbEqwNYwfa0xqOCuVMf0trEKXTTdblqOwkA2SDC9y2SD8z+Vc+qWGbmReuvkMo55kUfeSfrcFYLekS8Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOYocntj; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82f41fce3e6so317235b3a.1
        for <dmaengine@vger.kernel.org>; Mon, 13 Apr 2026 04:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776079887; x=1776684687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/It8wJpFq48iLElY6BoKRmtjgHX5ES0T9yGLlkbn8w=;
        b=MOYocntjYxXsd6g86Z+bIpSZBqs/1+7IJSYOvKWo/gPgys9wIooQdC0Kkoo7EuR5Cr
         2QcntVRXJqwnHDirKcxBh4F2K4RvCN74RbMGPgKXZKnsDkt2SqBbFF+i1FR2U30xA6QP
         eqeCc4jou4Un98grJQ1W1zmVOBgooh8OEq8TbP3/5hqVywiG0UfjEmDkpxwoEy+kuaqG
         3w8PsLI0A6icPsKwI+5Vi7glS+OPkybcBPiTgjQvDOOsK62cHREFtKZc9mDNRZhaIAJY
         iR7HjkkF2+RgQ9Y9hINAfB+54q2KUejq+sozneHDurBA6MBFVV2A/r42N8bkbmR9vP2O
         ZwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776079887; x=1776684687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/It8wJpFq48iLElY6BoKRmtjgHX5ES0T9yGLlkbn8w=;
        b=XX7skb64G5heVCB97SyKqSiMDg0/VBundie3woDGlXCaMqjMZq84yzC0odhvjWdj9X
         jRjXk9hFkQ/9vQtRCBEp2Y2b9NajN9zt4Ek7doVhVL/Uyl4pu16ZoVB8mhs7FI9d5ckv
         M2HWuqtMIMz61BvMPNX5iBkTjWlQ03h+kA73eUIV1mlJb0imp2c5BIElviTdHexRLUT8
         2miTID4wO99HXoaQjmvtIDRUzGl8Z0rBwrVmM6C6YFu0pXoeTa+uLmmvSbgFCIJVX2gA
         GHfBoTQx70hCFYn++1JF08z+YKcKmRm2olc09A1IR085NxesNqwiXaiv32FL4Xhj4DVF
         73YA==
X-Forwarded-Encrypted: i=1; AFNElJ+pyI8FRBC3aXek/B0fzzF7N0Z4XPNM+bt444d/yBGvNsawwp5zmnpcSTRhDVnFN6GBWgAJPt+tLgY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe4sVzlbUMsKGpQMERY2R3dctVTriSDOgHl6kNwZr4FNuyOvQH
	1EN2S3UCVwXuQA9FvzaKwkq9F3tuNhGO+4gElyJa02VBmZu5fMRqDGPz
X-Gm-Gg: AeBDievSAgUi9N9wFcYeRPcM7trvSi3V4tXfem3VhMiYdemh3yohhikbck4LnEdLQ2T
	PIvE1vzOh+YmwRMywdwWTDinvgJ5xOZXTCa+C4lGWStR51PNK2n3SR9GaNOCgzpl6yg0U8hewtL
	RDpgMnTdwZanwjN1z9cQh/+hjPKR34f6o7c2oXF8f40d3UwslKyb+WIOWxhBYjUSQ4fyL7W1KYY
	T16NJLSXvAIllAagbWy7kV0ikHTvFqtApicc8hpRTikA5WOj6xjoa9+5fhfmIDxSpgUySTwFfHF
	IAVP6EQ2z0Etssdi6fuTDcP2JbAOTXi99wGwyeub8Z3c65SoH9qLo0yu53g11eyWJBda1TcBKNa
	e7llQmVzYqPAjMFCer07YzHMQj4o4k6qrvYHfY7Jx+Bg60ge0LBQ1n/fUsj4jASgntK+mW7lQJ5
	s/fZq/J5qctKDOGawHoH/MLRf3ltI6RdGr
X-Received: by 2002:a05:6a00:114f:b0:82c:e0d7:2681 with SMTP id d2e1a72fcca58-82f0c276ff3mr13615144b3a.16.1776079886925;
        Mon, 13 Apr 2026 04:31:26 -0700 (PDT)
Received: from lgs.. ([112.224.67.108])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c36130csm11037040b3a.24.2026.04.13.04.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 04:31:26 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Fenghua Yu <fenghuay@nvidia.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] dmaengine: idxd: fix double free in idxd_alloc() error path
Date: Mon, 13 Apr 2026 19:31:13 +0800
Message-ID: <20260413113113.2725940-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-10007-lists,dmaengine=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.997];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[dmaengine];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3E9A53EB531
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When dev_set_name() fails after device_initialize(), idxd_alloc()
calls put_device(conf_dev).

For these devices, conf_dev->type is set from idxd->data->dev_type,
which resolves to dsa_device_type or iax_device_type, and both use
idxd_conf_device_release() as their release callback. That release
callback frees idxd, idxd->opcap_bmap, and releases idxd->id, but
the current error path then frees those resources again directly,
causing a double free.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Keep the cleanup in idxd_conf_device_release() after put_device() and
avoid freeing idxd-managed resources again in idxd_alloc().

Fixes: 46a5cca76c76 ("dmaengine: idxd: fix memory leak in error handling path of idxd_alloc")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - note that the issue was identified by my static analysis tool
  - and confirmed by manual review

 drivers/dma/idxd/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index f1bd9812c90d..20505e14ef9f 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -631,7 +631,7 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_d
 
 err_name:
 	put_device(conf_dev);
-	bitmap_free(idxd->opcap_bmap);
+	return NULL;
 err_opcap:
 	ida_free(&idxd_ida, idxd->id);
 err_ida:
-- 
2.43.0


