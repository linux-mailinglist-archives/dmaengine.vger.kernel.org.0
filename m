Return-Path: <dmaengine+bounces-10587-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHnOLMtCDmrV9QUAu9opvQ
	(envelope-from <dmaengine+bounces-10587-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 01:24:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5654359CB81
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 01:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DA273047BFE
	for <lists+dmaengine@lfdr.de>; Wed, 20 May 2026 22:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AD93C09F7;
	Wed, 20 May 2026 22:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qLvkc+Ia"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1A03C13EE
	for <dmaengine@vger.kernel.org>; Wed, 20 May 2026 22:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779316648; cv=none; b=E7npUUa42icA/Mar37LaBY6asQ5XLrIWahriEkln4DH3iv4mNbp3iFYmmFFFklrDvePTEXCn7zn+KaHwqjx9HyGJUDSNLr2rwFr5UAiFF4O1PHEpjPVl7F7Eth1SSIdcz0DiIpNdws7XX0bIfCqj1g8sKmx79I/1RTXBdIhfckk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779316648; c=relaxed/simple;
	bh=x5iofzhh9Kv4/fDT7xcT8nMb8+L0WfH1J+TTWcQfTws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QK4KjezihRiWYkdqUE7revjEVNeCx7deyg9ZgPr/qTJeHGphJTHqYtq4E+k27VzSnsg/J4I9wQjwMmpCkqBJBe8TH7WOnHM4jMtLdc9VpGcGBQNLPY/B8w1kHPYTq13yQJtY2bH5W7guahBu2fwlYci9Crp37J3B4pqj6aEPVvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qLvkc+Ia; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-367c2a39fcfso2540944a91.3
        for <dmaengine@vger.kernel.org>; Wed, 20 May 2026 15:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779316642; x=1779921442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+3DLl7Yg6VwAfpyI8SGBLVVQzN80urNsEnQ3t3qUrLo=;
        b=qLvkc+Ia09URLlD4sVABd6OkeNj9iAV8gCOq3d66pbL0v5G6I5asKdrvdVH25Zj75i
         kiRbg6fIziVs7Fjo5Ei7Ff9tIrx/4h6sS8GbcI003pkhFSKEswbyl8s/JYA3jhxbrmLt
         QVoIy3l0Pz94qlhJO1BeWsQzWy/pFkbWAj9IQiaf8rCl+Oq/m3rPNnOsH/e4Er2jV0zS
         O464nZSFLRwPGDYoH1MFl8KUHLYjiV8Dcdb5JI10mgMYVtGRJTEANF7XYzVhxQCq7EtB
         ZL3zlYU52FvcKzOkAKxEsbtZS3KJx/zbRmsb+aOoiDUK5VadbJdwCbEPKp26Y0JSlUJL
         /CSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779316642; x=1779921442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3DLl7Yg6VwAfpyI8SGBLVVQzN80urNsEnQ3t3qUrLo=;
        b=NsXkinOS0Hk2F/PeciXa/Jd1H4lKje4uADDzU3LirbdaP5rkuMUtZqNSP+8l/XiGTo
         /GKj9HVRwGD7rTkHhiqfpiFG3KwBRSTf/Q30V8vXbn0BV8sdMepcE4Ks4lfgxalvlhmY
         8nP+huYLfB3+u0z8hw+4/dvlfjUyxybujiQ9sfIVBGU2RjLNGtzn8Zwzdv4v3a4sGU61
         gH06/88G8QiMxsFR8MymXNJw2OIJaDTRlnASrYFVqq7bcGhiRO78tsT1dQwP0WoDnIO+
         eVIz6NhESpjc8e9EUnCy7wf9rNMFgILACw1VIs2Fic78nCCxqwcO8+e3+1HjUmw0Idn4
         KiGA==
X-Gm-Message-State: AOJu0YxaIFuA+WzFgHSDPgsIy6hbzBRVNZlxgGs5LcpbZNjQ8H1lRG+c
	yCSdKQdsGk6XhxDqcpa02PmjzZ2gRhzbe8SSPFImmOKVrThQz+vEwrIB3CIXXw==
X-Gm-Gg: Acq92OEKpKAUhQ53VJ0d4F0TLu4LI5hcb2YiSIHX7wuH8yIYI+/Rx8BD7rp0Qm+N2N1
	BoP3Kf5DNgQw3NK/SUONfXQC0QUxp8BsT2qdwUG+D9rsDrazvlipiOR3KqaBOOeXdlXXT0DANv4
	YZVeie0XbYEQVZKMPIqA+vqY4tk1l/91CYTAeAVxLTYKexuWM7zeIBj/gmc2SYwnI80x2UtSrez
	jTehTh9Y+ZdEbm3jx1hgQYpbqU9VpEJBSDOGp1sEuoZkV5fRWCPAPNQkfKBss/3Jj3Qjf2CRlEW
	J6uMtbs2ZpFr93vfV3rN6qKdhlUwVZh/pviwA1bel1NVLYv1CkS45bCLyI7y8qsBbcB8WiZ1iD+
	OUqxO5vMSm0K9VQI3Yh3BVGjtFLPhhfbWe/LUh1GMfrm8cgtKqf4Vqej96zoTx6fWiN7fhEqPYj
	/npoCH+DJquPicSJ3qoIJQjqLwByZhkYrxaOTpdfmsYwc2CMl/DrdckCpj2ke1fBP4ILI0YW4gi
	xQQBUSlE2zHYIgO/PCqcy/aj4MPX0Zxj8WUfhbHK1CAnA==
X-Received: by 2002:a17:90a:d64f:b0:35f:b714:e516 with SMTP id 98e67ed59e1d1-36a4560485cmr457936a91.16.1779316642448;
        Wed, 20 May 2026 15:37:22 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a3cc4b345sm638986a91.7.2026.05.20.15.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:37:21 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] dmaengine: bestcomm: Enable compile testing
Date: Wed, 20 May 2026 15:37:04 -0700
Message-ID: <20260520223704.39320-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-10587-lists,dmaengine=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5654359CB81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Allow the BestComm DMA engine to be selected for PowerPC
compile-test builds.

Make PATA_MPC52xx depend on PPC_BESTCOMM directly so selecting
PPC_BESTCOMM_ATA does not bypass the helper dependency.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/Kconfig          | 2 +-
 drivers/dma/bestcomm/Kconfig | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 28ca856ecc75..6e25e9fcadb2 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -823,7 +823,7 @@ config PATA_MARVELL
 
 config PATA_MPC52xx
 	tristate "Freescale MPC52xx SoC internal IDE"
-	depends on PPC_MPC52xx && PPC_BESTCOMM
+	depends on PPC_BESTCOMM
 	select PPC_BESTCOMM_ATA
 	help
 	  This option enables support for integrated IDE controller
diff --git a/drivers/dma/bestcomm/Kconfig b/drivers/dma/bestcomm/Kconfig
index 5dd437295964..153b5492c93c 100644
--- a/drivers/dma/bestcomm/Kconfig
+++ b/drivers/dma/bestcomm/Kconfig
@@ -5,7 +5,7 @@
 
 config PPC_BESTCOMM
 	tristate "Bestcomm DMA engine support"
-	depends on PPC_MPC52xx
+	depends on PPC_MPC52xx || (PPC && COMPILE_TEST)
 	default n
 	select PPC_LIB_RHEAP
 	help
@@ -34,4 +34,3 @@ config PPC_BESTCOMM_GEN_BD
 	depends on PPC_BESTCOMM
 	help
 	  This option enables the support for the GenBD tasks.
-
-- 
2.54.0


