Return-Path: <dmaengine+bounces-9789-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMOYLFaRzGk7UAYAu9opvQ
	(envelope-from <dmaengine+bounces-9789-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Apr 2026 05:30:30 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA96374651
	for <lists+dmaengine@lfdr.de>; Wed, 01 Apr 2026 05:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE86D300AD7B
	for <lists+dmaengine@lfdr.de>; Wed,  1 Apr 2026 03:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D499D37D10D;
	Wed,  1 Apr 2026 03:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0bMMrXp"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6033286D57
	for <dmaengine@vger.kernel.org>; Wed,  1 Apr 2026 03:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775014225; cv=none; b=pujqSi9Ci5oRpjbcJNmXab81ZLouPlgZF6hQBr69sHIZW32KfInhZvi6ujAYzJF4OH8jc0kyOqJV3TqG3kjQ7s4qrdsh+NlsvbySjScBfzvTIs/Pj5D9UZBxg7/PWNrZ9gTrIPteIOTRBA3X2Q8Okt1lI1cmtvHE2IItDy0LlG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775014225; c=relaxed/simple;
	bh=hxXLF5lyQ0tyXHzP24s/EoG6WZkR9hY6mbKxFS7/gIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OCVBA5Mi3gpb6K3XpCnWueyzTdWPLcRRROPVYRsW31fmqHYV+us9i3NsxsvPRKXhjVx/uupy1RDZrN7tb9SlLOuaEljOootW0P+czYZUACNGJTUWjpRg8BFtApSZVJFgYbjCZ6N0o5Qo8MON5yK/sgII3hqJD+P0H9CvPGOblus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0bMMrXp; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-356337f058aso3768478a91.2
        for <dmaengine@vger.kernel.org>; Tue, 31 Mar 2026 20:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775014224; x=1775619024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9P47rW39jbyc8421UN3l72weYmCGnxeZ7bLfcFbS7SM=;
        b=g0bMMrXpwoB/CO/dEnOQ5Rzfz0twtVzdElG2ZCt7mgooDFH4k/cov2vHZyTC9McCEf
         YZu6EV8mmXa+3uwkKvLO7L3ofKvCHU+Rcf3My5aWxczqhLAiC5ljp865XnTuLsbh7Gpi
         DdDG03ZyDvVEGnYErKzbAS7HO7rWCDjWE+TKrIVkQKtqTGODFy5qTkazQH0WAmBbaoB+
         EFR1z6zptTObM1SD+CxImS20GNDUANpNUxYchy/uZuDWPyvDMikXMm45T0fckSghwsAE
         Xdip0Q/Za6mh1184u8MEmgdsztcnVLRhpvajS2k6kaJxjqsxacW3r5m8FPNy6iG+vXu9
         O93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775014224; x=1775619024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9P47rW39jbyc8421UN3l72weYmCGnxeZ7bLfcFbS7SM=;
        b=dBo/nK75itYzENIstMXQr9wi6g0bHuTMuambGum3xinsMf9HwcLxSKQ/pzpQrd8Dod
         ThDYyt0j2agXXjNHhuFtudvkBDTuJjr0Xzw4GuGDA4zozLU7mUhACZ/CD/YjBvp3NA/U
         0zTWOJOzOLvanPLB0ZTOoFEgnWolvci+WFkJxyk7GQ0d5egDimGiR711kaxXEcUtWT4j
         ZtGrRREoGlW3H1di3n1+otA+zx31oqCXI8KkWhamw/TSsNM2qJEcJtdiHdttw17KGAve
         ZubHw2huz0D0lLTxEGr2qFvXwUnl5eO7o6lDjzM/xfYI1EcGiaaq96pNLqmrHnhVG0Kr
         1BFA==
X-Forwarded-Encrypted: i=1; AJvYcCUAaQ0ds91qSAJIvjpzsAnF1hxKpnRHcDX0nS9NmMqW76VA+1lZQTgpQZAgEH1meGmigbXe8GbrRnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3FjLEn7bAeRiekrhPMQ/usRipU1hkzDPzj/mtD90sUYY0bcZm
	vwToMCcUOC2oygIja9ZVHgsuSrShcCwVenm4HYpGXerXVvKuIFsoAp+s
X-Gm-Gg: ATEYQzzhgkld6JHibqNjqwmA478uakyBukySZcApRSj4TcwavMgMPyUN2CiMJbdtESa
	amJbbPnr6ZfUE+CX2XcpZ5RQ0J8RugLPR4nvYZQ2vxx3Y1xRZTG/BxEVm6MSo38gPwjHATzFvFQ
	UzyMTYRYIMrvomgX5j9u4I6Ivys7WCqvnnADnocs9apqI21yPxcTB/OQA9IyXvoH/41O5RQzDXc
	PDytsEghCs6o5r2eJ10CVyY73gT6Zx5aBrJyXChHHnD1FVQ698WFUK1K1hkD6NU881/0lv7Olwf
	wdrgNQW3uevfuSZwLlnEQREXVyu2+JNZfFG/WFSdMYBelHRCDMNcX7YKpL0Sg6+ZgsLl/CO85IS
	uX90CjJSCyFnMxKdKlnyKE2ph9Ci1PPQBm+z/R730EYkUM4oCNul/4v6DoYotWlwVGdySoLEhlb
	J7r7Taf8ozxboIIFd540ekCQ==
X-Received: by 2002:a17:90b:528c:b0:35d:a0b7:9608 with SMTP id 98e67ed59e1d1-35dc6e7b1d8mr1756731a91.7.1775014223910;
        Tue, 31 Mar 2026 20:30:23 -0700 (PDT)
Received: from lgs.. ([2408:8417:e10:5f85:653:6a84:ffc9:685c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe41b11fsm3075358a91.0.2026.03.31.20.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 20:30:23 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] dmaengine: idxd: fix double free in idxd_setup_wqs() error path
Date: Wed,  1 Apr 2026 11:30:13 +0800
Message-ID: <20260401033013.1434986-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9789-lists,dmaengine=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[dmaengine];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BCA96374651
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When an error happens after device_initialize(), idxd_setup_wqs()
calls put_device(conf_dev).

The device release callback idxd_conf_wq_release() frees wq,
wq->wqcfg, and wq->opcap_bmap, but the current error paths then free
them again directly, causing a double free.

Keep the cleanup in idxd_conf_wq_release() after put_device() and
avoid freeing those objects again in idxd_setup_wqs().

Fixes: 39aaa337449e7 ("dmaengine: idxd: Fix double free in idxd_setup_wqs()")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/dma/idxd/init.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 2acc34b3daff..b782eb3c191d 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -212,7 +212,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		rc = dev_set_name(conf_dev, "wq%d.%d", idxd->id, wq->id);
 		if (rc < 0) {
 			put_device(conf_dev);
-			kfree(wq);
+
 			goto err_unwind;
 		}
 
@@ -226,7 +226,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		wq->wqcfg = kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(dev));
 		if (!wq->wqcfg) {
 			put_device(conf_dev);
-			kfree(wq);
+
 			rc = -ENOMEM;
 			goto err_unwind;
 		}
@@ -234,9 +234,9 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		if (idxd->hw.wq_cap.op_config) {
 			wq->opcap_bmap = bitmap_zalloc(IDXD_MAX_OPCAP_BITS, GFP_KERNEL);
 			if (!wq->opcap_bmap) {
-				kfree(wq->wqcfg);
+
 				put_device(conf_dev);
-				kfree(wq);
+
 				rc = -ENOMEM;
 				goto err_unwind;
 			}
@@ -252,12 +252,10 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 err_unwind:
 	while (--i >= 0) {
 		wq = idxd->wqs[i];
-		if (idxd->hw.wq_cap.op_config)
-			bitmap_free(wq->opcap_bmap);
-		kfree(wq->wqcfg);
+
 		conf_dev = wq_confdev(wq);
 		put_device(conf_dev);
-		kfree(wq);
+
 	}
 	bitmap_free(idxd->wq_enable_map);
 
-- 
2.43.0


