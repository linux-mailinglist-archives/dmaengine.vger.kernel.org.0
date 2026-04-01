Return-Path: <dmaengine+bounces-9790-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFWuN8GTzGmbUAYAu9opvQ
	(envelope-from <dmaengine+bounces-9790-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Apr 2026 05:40:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C06F3747AA
	for <lists+dmaengine@lfdr.de>; Wed, 01 Apr 2026 05:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46E6530398A0
	for <lists+dmaengine@lfdr.de>; Wed,  1 Apr 2026 03:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709E237E308;
	Wed,  1 Apr 2026 03:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Npa5lCQX"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0FF37E2E7
	for <dmaengine@vger.kernel.org>; Wed,  1 Apr 2026 03:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775014596; cv=none; b=PQElR1R64uOo4mLdHnvTBKNYDCBc1A8wSMrmFrY2cImmnl1lMMYA6u30o0/vgjYPFFXlRO5xat1t8kz2MO1rS84VNBISvsF0aAbmqvlm+CfUu5cgcIi/mN92SozdsF1a2nmOn21Ra2fQ4WRxfDdHrRPPh3rz0+usmH9bb2hHBnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775014596; c=relaxed/simple;
	bh=cnZj4Tq75TU+m9MvB0/TuXcjxJ0PZXub5lCKx9Ude6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R3zYLTeHAbSVTowh1UV+gtJzpQv2gkUEC9T4bADeFyRfShtFoMNFyNowBoVRU412qYRWiv/VT1Gqy4rB1RNJdGv5JFXU8KMAOTAXqzl2ws/IHAGG1VH7qKX76gaOct3XIQEJAtJO0bg51IFgwSQZIuk5b8QvLlAyaXcYvVDnOeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Npa5lCQX; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35d971fbcddso331845a91.1
        for <dmaengine@vger.kernel.org>; Tue, 31 Mar 2026 20:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775014594; x=1775619394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R2TCQh4xS6cid2Jzw04r6Vvh+yYWLSOE9opB+QSqdXM=;
        b=Npa5lCQXtkB3b88W8jYPKdAKXO9om4AvUabEihu3j4N7Ol+k7Dzh7hbmATUqJmQ8Ac
         bTrGJ3E7X744/0tJIoxXZjKuXhI7hHJU80LNH3Ojok0GOrNifY0NzFwWSG/O9kxT8UqK
         8gm17FIEsrQNXt1q0/RO2fKP/oeli+ZUJ0tDut7sZs41aZNc8uzPE5DW1biED65bjfHh
         weaqGbA7sfarPm9fzLw+CeNTBu6o2FUfNfkCBVl4vYJMjfwvRQ4NUo4cbklNwhBpl760
         Vlbk/4wHtruBK/E9iHEHnDYUNdouUf11/L/FG9VLKNVNhZzeuuQMbqpNbRV0be/5DXe9
         mI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775014594; x=1775619394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2TCQh4xS6cid2Jzw04r6Vvh+yYWLSOE9opB+QSqdXM=;
        b=Fy/qCLJPNoI75kQ1KmoOBTE3j1E6lqNt06gG1VYHFAGoWGSVAePIcZ21/uEx0syOWJ
         prLFvKPKgG67CVmjSk1hVTQKpYTkTIUlas4IYpY3sQUrup6orrl0MJIvZcPwwMYr20Wq
         f1NR3Y29ErEjWB6iRs4lpY5fhoBKGEiDQqlYK75jllSpkSjrp9WA/ggpFo66ilKdZKxf
         OODde4XfMwoQ/fTkRJ8nktCjFv/m5Ux1tCj+AdJLpDY1KTACpCGp+CGQiclIQmOro+K7
         sB29gFqZtWbuhh0TqCrZeP+GW6gSaowTPpqPpLmhKv+D6V3xV2xM+9YClQulnDRCDW1G
         rM4g==
X-Forwarded-Encrypted: i=1; AJvYcCXcI2fz9PEBtUz4lUt4PWk2EG0psXh6Yw6FXd2tIRXhg1hrqZ+yv+yJTPVL/C54+o8BKzI1xY/jarY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+VxGAKDXPhbdUB9N6jppk+ZVchjfKo0KlDTjGJDTvzrmVv1qb
	NlQ7+434v+0aIRnT0vE/wnTMZAF12QlZunTjAEEI6VKc3xyUBMPqJP1h
X-Gm-Gg: ATEYQzwIaf9jS077+PuF9zICHuPdu7IUfSdM9W1ZuQJ1hDZRAPR8awRNrbcJ5iJb3nq
	2R+uF3hVMKrq4COxCC56Okec2twgaYkU9UUCHJzrgUBW3EnEaLNAUgJ6sTzflZxOKTh3dig/F6C
	lfBIUxWe2zR1ldbjclOZocXT1Q0DwEfGhu8I/jIEM5eLtHu3yADSBTPhx54eFvwB8QMIwOgWkqY
	WxMfeRXbNJCjJewiSVczdUDwPLKmhxjfrJFk16tyAkb374KALFMqXGGI0sDAlF/R+phOWszlraG
	6z+5R9EYDr9O3LBWuJqaoLnh1wcYeknPxikAnajLLgL/u2dSC3oXKeV6/JNYmi0nrdqnKQk1elX
	MkMKJY4P7KbCOR9dfthVrGv/zz0I/3Nug51pUbLZF/ma+DbLAHfi9rUv33Cx2bq+hFjDhylPceO
	uaYw9POHY0gCMtUW3UEWfMmA==
X-Received: by 2002:a17:90b:518e:b0:35c:10e8:1a72 with SMTP id 98e67ed59e1d1-35db8e58d67mr5963651a91.7.1775014594402;
        Tue, 31 Mar 2026 20:36:34 -0700 (PDT)
Received: from lgs.. ([2408:8417:e10:5f85:653:6a84:ffc9:685c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76916cce42sm10470716a12.9.2026.03.31.20.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 20:36:34 -0700 (PDT)
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
Subject: [PATCH] dmaengine: idxd: fix double free in idxd_setup_groups() error path
Date: Wed,  1 Apr 2026 11:36:22 +0800
Message-ID: <20260401033622.1446904-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9790-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5C06F3747AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When an error happens after device_initialize(), idxd_setup_groups()
calls put_device(conf_dev).

The device release callback idxd_conf_group_release() frees group, but
the current error paths then call kfree(group) again, causing a double
free.

Keep the cleanup in idxd_conf_group_release() after put_device() and
avoid freeing group again in idxd_setup_groups().

Fixes: aa6f4f945b10 ("dmaengine: idxd: fix memory leak in error handling path of idxd_setup_groups")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/dma/idxd/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index b782eb3c191d..d9a9d56dd277 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -374,7 +374,7 @@ static int idxd_setup_groups(struct idxd_device *idxd)
 		rc = dev_set_name(conf_dev, "group%d.%d", idxd->id, group->id);
 		if (rc < 0) {
 			put_device(conf_dev);
-			kfree(group);
+
 			goto err;
 		}
 
@@ -399,7 +399,7 @@ static int idxd_setup_groups(struct idxd_device *idxd)
 	while (--i >= 0) {
 		group = idxd->groups[i];
 		put_device(group_confdev(group));
-		kfree(group);
+
 	}
 	kfree(idxd->groups);
 
-- 
2.43.0


