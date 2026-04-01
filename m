Return-Path: <dmaengine+bounces-9797-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEcKBsHrzGk/XwYAu9opvQ
	(envelope-from <dmaengine+bounces-9797-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Apr 2026 11:56:17 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFCA37812B
	for <lists+dmaengine@lfdr.de>; Wed, 01 Apr 2026 11:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 60EBD30678F3
	for <lists+dmaengine@lfdr.de>; Wed,  1 Apr 2026 09:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967C13A8746;
	Wed,  1 Apr 2026 09:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ss2mXuD4"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA673B6C13
	for <dmaengine@vger.kernel.org>; Wed,  1 Apr 2026 09:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775036464; cv=none; b=sSOQRQu8/RlDf7W7rJNPK62t51wAwsi/NguliA7ASui/VD00ImlDcNA3Y254ZHI5guYCJXGA6Z08cGxgx3d6Lz96n52g7FYo/VRSSRfup0LEZ2TBGXI3j3jC0OenZLQVqgdQLIM3+ruryWZMev5x9fb0D0f++r9UuittAIlt4DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775036464; c=relaxed/simple;
	bh=OYYUWkgCxAQGpQCSIvAQ1bkD3r6IuE5Qn3pidaElBqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YaxTvvZ8AtgK6oQubaaEWdHB5N70ggNtILGIPr0tb7tlraiY+Q3RDFhEDAqARVjfGG+eGD0QQPhYWhG3vRVe+T74j/JxNuK296EijsCngV/E/Gw57f0RyoOy07bF2dHeEKdYaByRxQ23yZmgvtFtxVtxFUmHS6/Soo0eWGa7vrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ss2mXuD4; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35d9923eec5so2696521a91.2
        for <dmaengine@vger.kernel.org>; Wed, 01 Apr 2026 02:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775036461; x=1775641261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RO4ZhYSZqYOFn/guHJmRqbXOWS6aNnS9NZJLkKz5OII=;
        b=Ss2mXuD4qD61P+GugJKl1FNimk0k84zHilguKNwscc0FoGm+EOH6VFaKhQSibXg4wC
         ZXf1B7oDno1nvem7exL0sJ7N6YW7GO2nd/HdpOB/Ks5sx/rbcgqoS5j7qfwcrMAg9PsD
         dBxRLQwAfZM9KMB8f3JuxE7QHZyhHEsbBRnf4UhgU24rV+chWFhZPVeaMo8to4z/ny0E
         NP4VPUgX4fCuHHwjGdaoYrJCxi61aTZnJ4+vCgVB4cMUEBrXI914UWybIHpqDoFbVvTA
         zun2hy/eYeGtStOTnmdinAvHeCiHmzOsp32zflyAiuBOPkTciwbTI/wtR1hF7frtqBBk
         TrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775036461; x=1775641261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RO4ZhYSZqYOFn/guHJmRqbXOWS6aNnS9NZJLkKz5OII=;
        b=TGuV5lA1frZYsgtppSY+1PzdqZ0tkDocKaCydO+pVSO1JeX3oIiqE1c1vghqHNXIL8
         fZzQBnibCbhzzkqJK1A1mBrTivo9xosBCTQp0oGXrIHzvHs+kig4MLbBwkjG28Gioh8t
         Yw1f/DZZnqMfbA6zhyu9ilI1aMqpVDjAPjBHYMKzujaulQaKt/vmSacVMBvwal/NA6Ak
         eqVWXMe+UFveQnCwglXvKMbPU33bYN3iqp+HmnZeJSKjrBDwjgHt8W8GQUBD2ailZ4ls
         aw1scpNQt/En3I5pega7sowRZBK9JhPoeCRC3ujFxxQKs7m5m9QhKHwj09Ifi8QlsZGQ
         kohw==
X-Forwarded-Encrypted: i=1; AJvYcCWhqSgPnYzc1CaK7CWHsvptDDcdd9Rr2nMdInRRPe5MGuRRTLSuT62XhKrLNjiLybPxluviscOE53g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2OWakeMoR+skPQVCSMo8niVhS6yO4ZYQ3gFLwGkGd/ALg+Drq
	i2iKSk/Mi1Z6x5th3uVL5ITPV+vinJ//5NHmuzW4yS3vycQmbNmNvaJZ
X-Gm-Gg: ATEYQzzqs3NvU7FKWqMwy8JhokzI9ssjrF92k6x4W5w4Mt3oXtET6vxYu+gO0xHc3sm
	j0VUIYhWxyvj5G52zKopV1Q1eRHkndEU4nKC8tZjPM8Xz0b46vP5Ck8BQ3cZlTXeLiszftfDG4+
	EkyH/aHP2zzsGVn3PDr9GxIbwbezYjOv8n/8A9ehPOpCwEcKmit9yGs24cN2VTMGhuzUziQOvTW
	0/HL/cKpgO9qLyvSU0zFKB2uIJVhx4Mf1mrgPW+sX7EP9By+aAWtjPi+21oYLRboT0de49BZu0E
	XgrLOPJQFq0Wqn8f+xu9tuXSB8HYcqZH4HPMf04rpoxA9pVXgGvnTrizVY8Z4tTCk1KPPho+bHL
	YyUa0NX+/6aBXMDyjUxjJUYp12YgFJwl/ZkBpPCvWMsgZNmX109P9dDKnJXp8RngAFGdHIPQQeK
	df45xEF9Ap7TlJjaKWGf20
X-Received: by 2002:a17:902:7610:b0:2b0:6365:21a9 with SMTP id d9443c01a7336-2b269c3f058mr21308135ad.31.1775036461375;
        Wed, 01 Apr 2026 02:41:01 -0700 (PDT)
Received: from lgs.. ([223.80.110.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242642913sm140147225ad.10.2026.04.01.02.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 02:41:01 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Fenghua Yu <fenghuay@nvidia.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] dmaengine: idxd: fix double free in idxd_alloc() error path
Date: Wed,  1 Apr 2026 17:40:03 +0800
Message-ID: <20260401094003.1482794-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9797-lists,dmaengine=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[dmaengine];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1CFCA37812B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When dev_set_name() fails after device_initialize(), idxd_alloc()
calls put_device(conf_dev).

For these devices, conf_dev->type is set from idxd->data->dev_type,
which resolves to dsa_device_type or iax_device_type, and both use
idxd_conf_device_release() as their release callback.

That release callback frees idxd, idxd->opcap_bmap, and releases
idxd->id, but the current error path then frees those resources again
directly, causing a double free.

Keep the cleanup in idxd_conf_device_release() after put_device() and
avoid freeing idxd-managed resources again in idxd_alloc().

Fixes: 46a5cca76c76 ("dmaengine: idxd: fix memory leak in error handling path of idxd_alloc")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/dma/idxd/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 4eff74182225..94ce52565e7a 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -635,7 +635,7 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_d
 
 err_name:
 	put_device(conf_dev);
-	bitmap_free(idxd->opcap_bmap);
+	return NULL;
 err_opcap:
 	ida_free(&idxd_ida, idxd->id);
 err_ida:
-- 
2.43.0


