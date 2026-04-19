Return-Path: <dmaengine+bounces-10025-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJ02Fv3h5Gn7bQEAu9opvQ
	(envelope-from <dmaengine+bounces-10025-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 19 Apr 2026 16:09:01 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1174244F7
	for <lists+dmaengine@lfdr.de>; Sun, 19 Apr 2026 16:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F12AE30058DD
	for <lists+dmaengine@lfdr.de>; Sun, 19 Apr 2026 14:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC9237C925;
	Sun, 19 Apr 2026 14:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBEf8YYD"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A865A37D11F
	for <dmaengine@vger.kernel.org>; Sun, 19 Apr 2026 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776607736; cv=none; b=b/AgahPgBI7KIY0blHFfcPRYvgKtGHns32GiDYfxlQtdEbkygT3TC4kPgipMYENUYRUrBD1YS08qnybDVp8rwryEuUwHaeq8LcJ92g1WC0qO9trUyJHQPycfE2N4AFa897+oYJptIU4wXfCUgVgUQ1/wvGAjqFh03Il8hyZQjFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776607736; c=relaxed/simple;
	bh=5NZkfsTPzvAFcy5UFeBzMenTqECDDXUswA9pAZDzBhY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M1KV06ocJFzH7ZPPpQI0prhaRt5KpgXUizcIIsd58S3B1UwHVAp3emnSPOH1qCxQv2DZeJVQnhzklJvKHpE9DkDrZbW9aHH7+RHNoT4Um6JFVKEAtHV9K93eXPP73qeT44AMHj9/ci1NPNRCijW5H0555Y6lMy+MKS0b5yNtuGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBEf8YYD; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b2ea1b3962so13255275ad.0
        for <dmaengine@vger.kernel.org>; Sun, 19 Apr 2026 07:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776607734; x=1777212534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bb6WKor5gs4NUo2Ed/ILzdJqmo1MvLE8Py2tsx0kHJ8=;
        b=KBEf8YYDYNe1fLZeMMnp95+U1rdQnFMMS+YtxaESge8zo2xsiP0J+vwjckpGsNtaHF
         xCQR2iGqTr3NuOQZJnSq4pZBHrBzr3f6fGyANk5OgTxvsY7FYt5jbCg4J5sq8hJTQeax
         kn9WZDK3M4KpWXKIqfX9UDmWrD8pPTJCOv6NSnMdFJf4rUWxUkbzI/+DiiV6f3IX3OJn
         nfyUVg8no5d5Se5uW6GdKjIE1WqcLyImElh9Vl/wwMno9ei1uOWyh2yqLWckNR8MHzXr
         YT6snJNmT460uoGmG5izPL0k0lw9uWVrV5/vibLgq/WGvCaRN3HNyhvzxgFu1jgTnekf
         vPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776607734; x=1777212534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bb6WKor5gs4NUo2Ed/ILzdJqmo1MvLE8Py2tsx0kHJ8=;
        b=jroQjVBiND5QlZB9Dq9KGmn9rWLrO8inBOmXNLs7OnViPWEYuLAJp/ZfRhr8fH+kjY
         Sa7njmLBDxObBIOXAAGUIGiAqK6zNkzag4x3N26YpAjngyi8h6xcvEJRayI3/ZgTnnMa
         I9LnhWD8Aax2sQDevHqaZ7WEi8d9BqH+0cSiy/OTgU4mJS3DXQ06eRjv+bVhNcH2suYZ
         foVijdp+upWCYA0O4L5FKku845UsQKP9PPpw3L+xzZiGzLmnSoyURgxt7lrqCD+dQZZj
         Vph7wbfYwXKWKZbCtF97PHr28IGrOQcJ/RsJDYp9iuydncFIYWwtv2Ubu9XDIevwoHl8
         exUw==
X-Forwarded-Encrypted: i=1; AFNElJ/xz7l+ZjduJZz2CbUD3/XQW0Qi4a7kPcRu8dFMzdqBI/Ir8BR8BxpFVzlAhllwREn8uyUldLQs4aA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5YioIUUDX5iYlqa4ZD8ilh+3d1pKqKzvzFzXr9fw0VYdaw7pD
	fz98Lx+boKhulTxw82VYBBfbGja92ipV7ZgobTC7y2bLJEl7vYHe4eAC
X-Gm-Gg: AeBDiesCEA8RC2fgLMr01pxQqVBEOpRwBJOhp9rjVumqHIzJzUJfWATDbHmk6kXYHc0
	gOgLCZ1cyp0p5bvU6FiWYfwxv6rHyXGG66bwk1FC60nuRw/m3/yFpRdV+L1Lx4qSGIBc40TDMaG
	LLlz0xmuCoC/dJ+DYbYuOBO0ZNJcKJ8UaWKVS96VZ4dMFZnZX+KGgDHrm11WfEgUV7BwG6dXeBK
	oGf0rx+xri+FstaFFsDRUIDH1vXq1d+RY2+swjcL36f/QjHSTQdO4Ej7TOe5ToJCeVrFl/9g5J3
	s6zjXkVFcIqfnTZDNvUX7fOOwxgVfjMt8BugLe3cfFdz/AqRZuHtop9tsVsZHSnM0b7kBke0HEs
	Gsk6ezHUwKxBXQwyCeTMnGWOygcNeylLFlKB+M0D3altjHwHyDeR3saMF+Rscew01No0QA2qslt
	GS01dL43LrYTsO9ZAHcpDDoTmQc8OUYg56Fa664JZ1OfM=
X-Received: by 2002:a17:902:a717:b0:2b2:501c:bc0 with SMTP id d9443c01a7336-2b5f9eaf69bmr75431475ad.7.1776607733800;
        Sun, 19 Apr 2026 07:08:53 -0700 (PDT)
Received: from lgs.. ([2408:8417:d50:4775:fc0:88de:ed15:556b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff98csm74800725ad.3.2026.04.19.07.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 07:08:53 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] dmaengine: idxd: Fix saved engines array leak in config save
Date: Sun, 19 Apr 2026 22:08:39 +0800
Message-ID: <20260419140839.99672-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-10025-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF1174244F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

idxd_device_config_save() uses cleanup.h helpers for temporary
allocations while saving device configuration. The saved_groups and
saved_wqs pointer arrays are declared with __free(kfree), and ownership
is transferred to idxd_saved with no_free_ptr() on the success path.

The saved_engines pointer array follows the same ownership pattern on the
success path, but it is not declared with __free(kfree). As a result, if
an error happens after saved_engines is allocated, idxd_free_saved()
frees the saved engine objects but not the saved_engines array itself.

This leaks saved_engines on error paths such as:
  - failure to allocate an individual saved engine
  - failure to allocate saved_wq_enable_map
  - failure to allocate saved_wqs
  - failure to allocate an individual saved WQ

Declare saved_engines with __free(kfree) so the array is released
automatically on failure, matching saved_groups and saved_wqs. The success
path is unchanged because ownership is already transferred with
no_free_ptr().

Fixes: 6078a315aec1 ("dmaengine: idxd: Add idxd_device_config_save() and idxd_device_config_restore() helpers")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/dma/idxd/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index f1cfc7790d95..02210f16d391 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -880,7 +880,7 @@ static int idxd_device_config_save(struct idxd_device *idxd,
 		saved_groups[i] = no_free_ptr(saved_group);
 	}
 
-	struct idxd_engine **saved_engines =
+	struct idxd_engine **saved_engines __free(kfree) =
 			kcalloc_node(idxd->max_engines,
 				     sizeof(struct idxd_engine *),
 				     GFP_KERNEL, dev_to_node(dev));
-- 
2.43.0


