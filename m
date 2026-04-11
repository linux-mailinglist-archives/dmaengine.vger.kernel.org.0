Return-Path: <dmaengine+bounces-10004-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 95kYLvpv2mk02ggAu9opvQ
	(envelope-from <dmaengine+bounces-10004-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 17:59:54 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0874C3E0BCE
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 17:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D87330209F7
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 15:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5573B3A9626;
	Sat, 11 Apr 2026 15:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdx8Dk7f"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1340035B62C
	for <dmaengine@vger.kernel.org>; Sat, 11 Apr 2026 15:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775923191; cv=none; b=gKV79ssAEPa49Nv0/BWnqzJcHouaNUc3s+ZViMpy4dZYZfOD6bixRO/CFJaSrZSC60WTYSWiclG1DzF4Mm33FhGzL4rgjz/obbs2Glw4x7jnQ7dPQ6DfGLKaEHWVFS7X3G7gQYJY63PcpavnLUD4t/zsN3Dkl+ar4H+qPkQfOH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775923191; c=relaxed/simple;
	bh=2KuqzLq2TTMM7/M26PrKOuxml9mVo/X+sBMTMo+n/ss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EGHCXNNnd4N2HroWC3uOiFONW92ucVjCyWsjM2thQMcKSjQj7r6lqwlXkZa3+li6ZpK7klUjflD7/xTP3aLqAYBoDXSgU/afcuPUrR8uTWzB19VbRAjdi5P2l/WjB6v2V/UmSB1O7j+fEl+H2xdGxN4zOI+LXRWkcjjkqdHcwOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdx8Dk7f; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82cdb4ab547so1531319b3a.2
        for <dmaengine@vger.kernel.org>; Sat, 11 Apr 2026 08:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775923189; x=1776527989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/oUmcpWT9pX8ZG0MeVbZtVLCnJJW8fXpeclOgK9M9OY=;
        b=kdx8Dk7fwqM70jy7Z2Io+uCnYeCL1MlyxqePS7ftruugosq5YDD3O1ItCX4XtfiV3S
         XRyyLTe+scGaOrNhKNCqDlDGpuXetwulzDGFjC6ul6epesDz2VlMb553MPQPdQ/CFVGz
         pR4x+oDo6s7FnIRgQa/CJFSmgJUtTAG3bD9F86SR62Xi+NAOCCXj5r0PMIhguNOkwcjG
         bmKuncLs4cZlfHbRIvmtU1wNkp7TIBkdj0MFYRMdxAT9Ulb7ZZfcsdC5vZIl1MRRuonb
         ACXnHCznnqK9+x4eVx1nhhp8Zoih4acUQdZY4Zb9TSWHWxVz8zCQm4j8TX1R13TGAf8s
         1TUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775923189; x=1776527989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oUmcpWT9pX8ZG0MeVbZtVLCnJJW8fXpeclOgK9M9OY=;
        b=P444pb3RplSa/Fyw+CHGJqKUdt7611lDGsdbTqxuqxEVy7eMp7WIwBnhSydj1worKJ
         ArfaGAOu/MWxLzpG+G0cyvDX57lmJ2moPdqhtA3SlO551W9Il6OfywJlZb4S2xXUNNMm
         WQ5Uxtc8TmUIpp7pHnx4q1yyb5owDItAzyp3oOGtdTlc0lmtMXJSiS/NHAduMKCEyMcg
         K+moFBPKEFvhIdiyo2KscoUiC7kp2r8XhFHApwcwf5fVPpRn4ptFzddt6bXkWKmMBZAd
         s44JPiW3Bl5iGdf437LUCyWDW8EQUICz2upWlfZ2MMn2kVJxKNlP1230Lk4tHG8E8fEP
         L3jw==
X-Forwarded-Encrypted: i=1; AJvYcCVYRpzYdm+22EcH/MHDwGR8zmEjGh8iN8+R5Covb3vQZwmme+KuaIGY0Qo9hK8Y8PkuvqNut3rktfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzglAvTav79CQN0d9iQtz3SJh4s8BxT4dV+FtNkIrUsX22S8D0e
	x0JwoVX1xDByKgS2gTQgjVkbAhpkkgujZKCD0yfd45ngA2c3OdQbEZ5u
X-Gm-Gg: AeBDiesD3gRPhpqZgDBMT0gfkXwkOc+L6H3D2ltiIZrsgTgHfLAyH0ppWeMjyHmL5k0
	S9x0gLAvxgyg/xkCWkg4uRhvs4Err5iIyj978ndM6TtBMdsx1zYuPEtAYSR6GdGqlVBeAbwfauJ
	FnvMjBoJiUEATZTV6/H47aDBeo5nmEilqmH/wo9X4352Mqe379aukJkg8EMHqAUIbCwzwOL9Tg8
	dpDxJKNxT6OtpCyuaJ7nvoeDX8Fb91MxFOik4Zwox4yIadHCQdE5Lr+atm3vVbAXcb7zbQAH6fc
	4YmkogojdNV9Ybi7ZgCET+Yi0j1lsil9rS654B1dwM/SgzxVjutSQ3efqolc87SFuhyA9++eKNq
	L+o5jNeOtfy55ng/qxNbYLZGHdAZnMLBuRd85/sGxoI3xwfDjcfD7lDcVD4x2RLKruqQkQ7+uEE
	wT8iLF0TF2Aqnn1g==
X-Received: by 2002:a05:6a00:3987:b0:82c:249d:d84f with SMTP id d2e1a72fcca58-82f0c38a1demr8020722b3a.37.1775923189476;
        Sat, 11 Apr 2026 08:59:49 -0700 (PDT)
Received: from lgs.. ([101.32.189.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4df7f5sm8009079b3a.43.2026.04.11.08.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 08:59:49 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] dmaengine: Fix refcount leak in channel register error path
Date: Sat, 11 Apr 2026 23:59:38 +0800
Message-ID: <20260411155938.2350613-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-10004-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0874C3E0BCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After device_register(), the lifetime of the embedded struct device is
expected to be managed through the device core reference counting.

In __dma_async_device_channel_register(), if device_register() fails,
the error path frees chan->dev directly instead of releasing the device
reference with put_device(). This bypasses the normal device lifetime
rules and may leave the reference count of the embedded struct device
unbalanced, resulting in a refcount leak and potentially leading to a
use-after-free.

Fix this by using put_device() in the device_register() failure path and
let chan_dev_release() handle the final cleanup.

Fixes: d2fb0a043838 ("dmaengine: break out channel registration")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/dma/dmaengine.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index ca13cd39330b..6bb1212ae0e1 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1111,8 +1111,12 @@ static int __dma_async_device_channel_register(struct dma_device *device,
 
  err_out_ida:
 	ida_free(&device->chan_ida, chan->chan_id);
+	put_device(&chan->dev->device);
+	chan->dev = NULL;
+	goto err_free_local;
  err_free_dev:
 	kfree(chan->dev);
+	chan->dev = NULL;
  err_free_local:
 	free_percpu(chan->local);
 	chan->local = NULL;
-- 
2.43.0


