Return-Path: <dmaengine+bounces-9791-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDQnDCCUzGmbUAYAu9opvQ
	(envelope-from <dmaengine+bounces-9791-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Apr 2026 05:42:24 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC0C3747E6
	for <lists+dmaengine@lfdr.de>; Wed, 01 Apr 2026 05:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD4E93015718
	for <lists+dmaengine@lfdr.de>; Wed,  1 Apr 2026 03:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1FF35C180;
	Wed,  1 Apr 2026 03:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6Lx3deD"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A764B31F9B7
	for <dmaengine@vger.kernel.org>; Wed,  1 Apr 2026 03:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775014843; cv=none; b=rhw5j3Xg7m4ETz/kDw5IeJnSnWNO15dqa8AmnSLqLMoL4Rhe/wpgeSyRhOJrCM7NrO0kEfYADwNYUJ2mhi0H5475DdzSr30RMzOtAreJx4SWHEtcMAZQLQkeGogAnlBjqg1J6RGisc4DWMuV5X8Ky4oOH6pasiH9v9ybllbN3Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775014843; c=relaxed/simple;
	bh=ONt+NLYwBfQsWKrB7SVz0tjFHaNo2vk8LWO78PzsWOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T1bx2mf6dhwrAjCdTWh8YRBRg82pxVy4mPtP+fkhm42X/mG3VJ/RIHohUoYlbnFnf9GM3zPa8EuQ6WhHk9d/YvDmzeJ963+LUlIKZS7CK+xFHUhAYEz/844USwis4oYfpE+B6YGMxxZRbtngE/pxjTP1uwSDhw88rVOzId24Y88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6Lx3deD; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so3804135a91.0
        for <dmaengine@vger.kernel.org>; Tue, 31 Mar 2026 20:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775014842; x=1775619642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vc5pDezw6rbZBqfkyYlJJ2XpaK+6r4fOQMnx2LPA6Vs=;
        b=D6Lx3deDmtzESukF3bmkFb8sL+5t5uDzwMU/SHfELWShUcOhT6CTeX5LYkG+MEpsvH
         DK3n11KrlUYiNNoI1W8wqjV4Kp8fTlLpRwd3gyFu79cMVTCDvB1CFfNp+YZ82Uohn+4d
         iJxs4ldytNdku78HVDDzLt7F2D7CaFeeN+KNcuAwVFa7Ze9M1Gsdv/cLj8sKTdPpd1kR
         qdKlTKTZ+Q6zzj3383wKoVNgl451jFsbIUOlK6z657LTcOK4pl6KvIh4dA66etx5W6IW
         /fO8+W2k2B76AT//+sgquBnY5BkNTy8QLYKr+laH2zkl1pgwUKTcsvB0w2kD2D8Y2K1k
         qYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775014842; x=1775619642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vc5pDezw6rbZBqfkyYlJJ2XpaK+6r4fOQMnx2LPA6Vs=;
        b=Q5VMU9Vb8sXK632Mbw5nuiIH0PQ3CPjSjUcCm82X1+q3ReZAeZcff52fMl80CwdmDX
         8QA8gXF7TKgzV8R/vh+sC54ONzZww2A0XGAiiWwi9e1uCOFJEq4lN7Stc5Fh/xNoFtCF
         EAMUXHKNM+Uo8+nDhjLNKL/7Y3UxwkfCJkITzStouflveff1ZHaIe2RsfNVApkV9x97p
         D4vQ79U8f4UAyiT7hrusxKsFc0hKtWGLFFusva/9NCjVjrt3cT43CizjOwqbvlkCl48V
         d6w4+zRtLi+66oFxPgInQx3V0ebmEv9uyIAmeZshIEV78JFUGyo44cA7vB9n/Lbb91l4
         KONg==
X-Forwarded-Encrypted: i=1; AJvYcCXNkIHZTIKXllxGQyvCotFiSn7WU3dX3LL2s+13jwqMtAEldumC5zJSKr9peNMx2zmZK8BVbxNlZLc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi2CAmd+pztYp6GSe2V0TRqUZiz4s23PDsfcGzemrlRZ1EsxCE
	6ZYpsCppK/8/hnkoR7cNiEqADE66r9D7kU55FCjl6sKugC1O/J22G22S
X-Gm-Gg: ATEYQzzOoPKISI+VY3gcyQbDlt5vsJ0FH2QFkK/KG5xfgoOM9UO6payceRY7mjWZSxj
	bEDjJgye7pXaxOaNAwz0f7ImvWi9+xstJHiP3IBo/EyDDm/oD2dulBp5zBbUu/Uu0ZQAol05ZPw
	j7LkAvkLGypYwW9PuWFxEOxMyiMlJOCm8EKrfc0pgTjs9hQcTh5rpKhezixjrAJDeSxuNfHtLUS
	y9oKg0CkaPQwdKsslUt4yxbt2fFVtRa8hsBwaITP/fmPTofMstU+DucYxe7MGS9sInV1DKkProB
	c/1Vs9/fSv7EaI8XH1U0f5nMmxgxQMCSitj6048NklDb0ts7huvtDXss7mNeGBHBgIic6iV2Duy
	St89dkCY3ytr59+6E8W5pH3uOF+L6NaF+DkyayTkBgC/AHzyIOs1eIwiXiOi3XcMgetFVMJOhHa
	9ixaL10tIoawZf7IMSMas9bg==
X-Received: by 2002:a17:90b:1d4c:b0:35d:9cda:ba08 with SMTP id 98e67ed59e1d1-35dc6fc9f4dmr1828798a91.31.1775014841924;
        Tue, 31 Mar 2026 20:40:41 -0700 (PDT)
Received: from lgs.. ([2408:8417:e10:5f85:653:6a84:ffc9:685c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe637250sm3192267a91.6.2026.03.31.20.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 20:40:41 -0700 (PDT)
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
Subject: [PATCH] dmaengine: idxd: fix double free in idxd_setup_engines() error path
Date: Wed,  1 Apr 2026 11:40:29 +0800
Message-ID: <20260401034029.1457489-1-lgs201920130244@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-9791-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9FC0C3747E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When an error happens after device_initialize(), idxd_setup_engines()
calls put_device(conf_dev).

The device release callback idxd_conf_engine_release() frees engine,
but the current error paths then call kfree(engine) again, causing a
double free.

Keep the cleanup in idxd_conf_engine_release() after put_device() and
avoid freeing engine again in idxd_setup_engines().

Fixes: 817bced19d1d ("dmaengine: idxd: fix memory leak in error handling path of idxd_setup_engines")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/dma/idxd/init.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index d9a9d56dd277..4eff74182225 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -310,7 +310,7 @@ static int idxd_setup_engines(struct idxd_device *idxd)
 		rc = dev_set_name(conf_dev, "engine%d.%d", idxd->id, engine->id);
 		if (rc < 0) {
 			put_device(conf_dev);
-			kfree(engine);
+
 			goto err;
 		}
 
@@ -324,7 +324,7 @@ static int idxd_setup_engines(struct idxd_device *idxd)
 		engine = idxd->engines[i];
 		conf_dev = engine_confdev(engine);
 		put_device(conf_dev);
-		kfree(engine);
+
 	}
 	kfree(idxd->engines);
 
@@ -374,7 +374,6 @@ static int idxd_setup_groups(struct idxd_device *idxd)
 		rc = dev_set_name(conf_dev, "group%d.%d", idxd->id, group->id);
 		if (rc < 0) {
 			put_device(conf_dev);
-
 			goto err;
 		}
 
@@ -399,7 +398,6 @@ static int idxd_setup_groups(struct idxd_device *idxd)
 	while (--i >= 0) {
 		group = idxd->groups[i];
 		put_device(group_confdev(group));
-
 	}
 	kfree(idxd->groups);
 
-- 
2.43.0


