Return-Path: <dmaengine+bounces-10991-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKltId0fGGocdggAu9opvQ
	(envelope-from <dmaengine+bounces-10991-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 12:58:37 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC805F0FB3
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 12:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A4E47300B8E5
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 10:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCD13D525E;
	Thu, 28 May 2026 10:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="fxXtWoNj"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45563D413B
	for <dmaengine@vger.kernel.org>; Thu, 28 May 2026 10:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779965743; cv=none; b=JNk3fcUrwCf8zzISPTmD6YQSXeyLA6hBH2/xMTUoiCPqFIb8Mhuv4S+zONrItHkemTxstIlBF6rbq2jCdeDr7YEirzRWHBnttpnGt3jpUEHM7J60lerq5YR27CnzhNliDrUpGtugpvNhmdPgGA4XAlImKCpWaNYxgRcgkhbFFTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779965743; c=relaxed/simple;
	bh=iTwJj6HhTE8Nw1XUKMUfQPoQx6tuqmxV9DmW8D34uIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cg1ITZxI7hw5rVZzZ5NnW1Q2WwejBpY8NBBqG5v9/kqvuPaSCrA/3Vukta6A7V3Osk2AnO7Sult2HAV0uaqzpLIydEkHJjSgt1c9EX6eDZ1p6dVsLowfTwjUS3seAeFjg83WvnkW/UgV3+qoaybVIebgk3RMrSMl6xGVIxB328w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=fxXtWoNj; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490388fd0dbso70224555e9.0
        for <dmaengine@vger.kernel.org>; Thu, 28 May 2026 03:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779965739; x=1780570539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SkYZDAAuUk4AZHgyoQHggUuVydm67IvZHEZcY1Po7w8=;
        b=fxXtWoNjQIUdM2ExfKVbEFjv+/9JlFvtNeg8l1ZBAPr1W76L1XKovTDB8r/kQUucWI
         R386MiN9bp9QGpMODoogunzg2ZyYMBpcH9AFd+PH1zFeWYH3LHcmRus06ux4Hi3U6qUE
         tTNTN/aDFZnrQXI6fTQcDyP0inRgMA/M6fJLSmlG+SudBVEKjvdiWJlcG1cOoXlea6qV
         +SZcCRIEKSNXDmcanlhqGvuNPfcUj/TAmYpudK/3ZS7wTNiT0lYoI7ak99cVzxnBvg+2
         lkty3eWOxdxwumoMaPj3RSkefiS8a+PVsPBYC1s2I7d0rm6E9bqQnffIzJ69R0GIa7vr
         MYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779965739; x=1780570539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkYZDAAuUk4AZHgyoQHggUuVydm67IvZHEZcY1Po7w8=;
        b=HYKWwawYxnc6gTCQopahk6YwrUY5GBwIDOX2eaG2mSVU7JCZYsCIrKFdQRP+ZX9tRQ
         449hI+CZZct5yCEn8slAPGZwMzLDCsMbxOmN1YeSQq2m292Nrost/kxpWeu0EhFxzGDK
         M7xRFAbKuw6ndUaJO7EnyJeeWgqGcNa7VLlA1WIhgJW3Bu3QPCzHf9LspVWsVXQccBMz
         jhh8Vkk2cNCKOM/HOCz1cgLSfqUos8TYeXDIjtY9ysuXkaNkn+KgzYz/ZbEdSyx1Kd3f
         EWRs/w/JOgD7wSF2nQB8j7bRdnwepcS7lZDwrtQS4r+iMJGXcuNcdnM+OrlyNMh+FhtA
         cuMA==
X-Forwarded-Encrypted: i=1; AFNElJ8XBL/BZcWOr4vkM6rNXynhQPG+hOoKZqHs8CBX+GZFRrfHEJFtgXUmxDHKP1L+GdgHSAi2PIQjAtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAonkdce+0VwrVitwmO1u1mqGbgIXqpjpY9/f8BW+F7Om19ysj
	4ytamSYWb0xXvdeXkRhEqh29PU66KAukAtzdajyKRNvw07mEC4QXkhOVejK5Gu0ckY0=
X-Gm-Gg: Acq92OGHhYe2+bpA83Nxe+R01z3TpdRxyCd2j84A5f/kNB+nVAAkNqJAcXEFy8ay2qN
	6i5hUEIg+sfE6xt4imG0srLbqH45f/33NncGmZL7vR9WRFqCIAd+WBm112DGWKrZoLcoQKgOv35
	0hF/Tgf0aoaNyDub/mJ+dgH1VSPLnWq/AXJydPf11cs4bUDPbdup5YXfvzcjvaOCihk4qnJ76mX
	75hCOsjOfbmWTIaYiMA0cXalw4HbviQCokaAAp0dhs/hhuba4I+VfQ65t9ymwOjacyTztvTF9gd
	pfga6gZPx3AeJoW7PHGhxiFoqe+qObVqtLD3T7A8+cvmOGDLdKStoR5L5N1P1lJWTctuJYUgME8
	C93elqlkK4CYxxIcaPPMkAood6qu4O73TEPHbARqdwrr7Kt9NQg6ezy2yUzXNHaK5ImMWXRAJEE
	AphKRkSPqZ5ZCEh4nkTO1gyPijDGo6zkHIhvDFxryd8O59qz6cK/bJ6ox6lv0fPRNRu+AJ+jzaL
	NUhDllTR2sl7cesMsID+aiYSQ==
X-Received: by 2002:a05:600c:6095:b0:490:51b9:2309 with SMTP id 5b1f17b1804b1-49051b924b1mr400826355e9.29.1779965739138;
        Thu, 28 May 2026 03:55:39 -0700 (PDT)
Received: from localhost (p200300f65f47db04e95e43453a0d1648.dip0.t-ipconnect.de. [2003:f6:5f47:db04:e95e:4345:3a0d:1648])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45edb5a2908sm13256294f8f.18.2026.05.28.03.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 03:55:38 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] dmaengine: nbpfaxi: Drop unused platform_device_id array
Date: Thu, 28 May 2026 12:55:33 +0200
Message-ID:  <5f7380828873e2375e319ef091178d11a277a0ac.1779965563.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1769; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=iTwJj6HhTE8Nw1XUKMUfQPoQx6tuqmxV9DmW8D34uIA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqGB8l5CMjPIHX5JOSYSBCwHNTMBLEhohsS5lQV LQV3Kig4ViJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCahgfJQAKCRCPgPtYfRL+ Tkw8CACgGAro3bAXyq0xeIfQID2gSWUm8vbwpks9EKrdyv7gojI3ofgXL+5slKkIbQaHOk8gUQb GUSbPjWqZWW85hfgBVBiqUNFGfFJDqnPdgQ9tZx9g0ZhQ3PpgufBLwV+jwp2a0D3322mXe/0s6h /y42j3zF12qATSUJmPvG55Z8S/EEmdw55b0lWUCsl3LTr5nxnnYD4pcl9OXjaanso4bjiAXphMe wsSEvnnMFsJKY6c+EbJBXbZiWykMuandv4og8Opcv1YQnwHcfqa9z7qc0/Iauii2he+HwCShzP0 RNVBbW/Q7c7b5K5mXPP5ajzXjs+pYswLE2oBlr2x+S4se3R2
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10991-lists,dmaengine=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,baylibre.com:mid,baylibre.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9BC805F0FB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The dma-nbpf driver only probes devices from device tree and fails to
probe devices relying on the traditional platform device probe path. So
the platform_device_id array is unused apart from providing misleading
module meta data.

Drop it.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/dma/nbpfaxi.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
index 334425faac00..05d7321629cc 100644
--- a/drivers/dma/nbpfaxi.c
+++ b/drivers/dma/nbpfaxi.c
@@ -1486,20 +1486,6 @@ static void nbpf_remove(struct platform_device *pdev)
 	clk_disable_unprepare(nbpf->clk);
 }
 
-static const struct platform_device_id nbpf_ids[] = {
-	{"nbpfaxi64dmac1b4",	(kernel_ulong_t)&nbpf_cfg[NBPF1B4]},
-	{"nbpfaxi64dmac1b8",	(kernel_ulong_t)&nbpf_cfg[NBPF1B8]},
-	{"nbpfaxi64dmac1b16",	(kernel_ulong_t)&nbpf_cfg[NBPF1B16]},
-	{"nbpfaxi64dmac4b4",	(kernel_ulong_t)&nbpf_cfg[NBPF4B4]},
-	{"nbpfaxi64dmac4b8",	(kernel_ulong_t)&nbpf_cfg[NBPF4B8]},
-	{"nbpfaxi64dmac4b16",	(kernel_ulong_t)&nbpf_cfg[NBPF4B16]},
-	{"nbpfaxi64dmac8b4",	(kernel_ulong_t)&nbpf_cfg[NBPF8B4]},
-	{"nbpfaxi64dmac8b8",	(kernel_ulong_t)&nbpf_cfg[NBPF8B8]},
-	{"nbpfaxi64dmac8b16",	(kernel_ulong_t)&nbpf_cfg[NBPF8B16]},
-	{},
-};
-MODULE_DEVICE_TABLE(platform, nbpf_ids);
-
 static int nbpf_runtime_suspend(struct device *dev)
 {
 	struct nbpf_device *nbpf = dev_get_drvdata(dev);
@@ -1523,7 +1509,6 @@ static struct platform_driver nbpf_driver = {
 		.of_match_table = nbpf_match,
 		.pm = pm_ptr(&nbpf_pm_ops),
 	},
-	.id_table = nbpf_ids,
 	.probe = nbpf_probe,
 	.remove = nbpf_remove,
 };

base-commit: e7d700e14934e68f86338c5610cf2ae76798b663
-- 
2.47.3


