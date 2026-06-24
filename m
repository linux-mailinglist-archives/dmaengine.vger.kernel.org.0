Return-Path: <dmaengine+bounces-11762-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tsT+HJ+KO2rxZQgAu9opvQ
	(envelope-from <dmaengine+bounces-11762-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2026 09:43:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EEC6BC456
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2026 09:43:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=B0KDhad6;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11762-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11762-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83C703015445
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2026 07:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E603002DD;
	Wed, 24 Jun 2026 07:43:24 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A95242D6C
	for <dmaengine@vger.kernel.org>; Wed, 24 Jun 2026 07:43:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782287004; cv=none; b=qTo3DoMrL4AynT+BXsItzMTOHYIY5rNA8Rup3KgxrSaV7GFMBle4gqLDuJ0UvnYAAlk+6NxO08MmbmUeYBD1QVsA1p5CfonJ+S4HtwMnejnUlDR1d0wTLr2Nzq3e/ieybHpNlmJqlz+2Xu0gipkS0eRbSQ+0+KOmE25F3LGIARU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782287004; c=relaxed/simple;
	bh=Kuvy+OfsXtSSXfL34f4t5wLQGVTkYVjAg5fwW4xQXbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kev46Cb/CVolYZ7JYjlRiVX1I5qLku5I6j5QjZ4INPZRv39Nn+jE/1yc5AH2+cUeg0988g/K5PhQwURRlmzlzmNoEZhCh6oud8y6ZbCAIfb7QVidow6w5yooVzjsvKlygw2RDwVpU2cAdyI4GS1e0AmdF0NeJd5cd4GcnaKiAFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0KDhad6; arc=none smtp.client-ip=209.85.216.45
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36dac5d5d05so321572a91.2
        for <dmaengine@vger.kernel.org>; Wed, 24 Jun 2026 00:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782287002; x=1782891802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AE8r8HJ/ms/z4I8NZ9JR5bCm2+oEquECrpJz+7QqcPU=;
        b=B0KDhad6hJa3Zj62ZwUCGv6IAD8q+uLGvxAsLUGQyLEbGft5B4gJ8us2B3ugrda0Tx
         zTM60HvyDOBcDztSKUkb+OdEFc+LtrxNjaJlSOPKgNiM4W0c/Lh/BZd6e/FmOxYOgkX+
         NH2+zebqj+oNv29wK8WV5NOEz5Dwb3OYZmKJSYatjcvg96XOv6LsJWqUxiXLCAKqiKlX
         2mCp+bwl6DteaKZXHV3zUTd2tH/bSaBgTzRZ7xhUeGAAxRZ9k1avOj9ZKsa5wKOoMYWo
         qY9QrntTU7R37r4T68ndVeZwnNhLWgv8XnGSdXLjdweg/HgsAHIu1xKdciMGStHSZaol
         8sFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782287002; x=1782891802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AE8r8HJ/ms/z4I8NZ9JR5bCm2+oEquECrpJz+7QqcPU=;
        b=bjc3iVlow7v73INoeUvgnG3u4JwU3LVTcpOm4AlhxLkYFMqQif6RY22FKLxF/wo8ra
         TdauJ7/rIqM/jS+Lvj1ERTMtJTtRhaxZRoUKXW/I4Ija9wUvF2q85BSYPEL1MHVdreJ2
         nZOXaYbSN1g9safaNpg8YSIHpkYQFkeeMAw17xwRukUH1Aw1A1WD9YzAevLyQdJ1jeQf
         7Wzk0AAr6RCBC+Tys9PcHDpHYlvmcjT00Z2bRA51jHo0fBTmFsQrJS/iAE6TC3drUm0H
         wd2xiikmzZVntuJXsiBHg3KdMDUtye/vlicTZsTZq2o7bkDLOIgqzGQ574DcSiB+CKEY
         GEjA==
X-Gm-Message-State: AOJu0Yye0gkFds/2oltoPlCXs6cMAfzGGOUAH+lMmoRAIn3QvuKJRXs/
	Pg10KypM82gmIIJ3E/ihSfP/sjJME+PFpwmgh16NVihQapbUcQqv7IYSGbhiVlI=
X-Gm-Gg: AfdE7ckAYqXoLkOARbQfySF4fxRq6lnKrCYwu3sAs1zwewSxnLc8RWrTxgc4Q1bziFW
	p4F3mddm31zCAfKCrRFIghCtn7xKnq7ljBOy5p6nvwUR4mw6nfPsa5G0BkxKBOfFFxn6zBU+icy
	Y7jw3v/HqYcpUtunyFQrFgmFuHFRqp5qlZp9hQM1C9QZJDC8QIUoYlvrTq7Tw0d+euBxgnbxIFR
	gEUm2O72B/m5wuJQfWKv//KirhXT3QDv+6Vk1DN261wNz7kMh9R3cJB4Dt/xDIBMQgn40vwWpVO
	XPgQn9UaSOKyB1ZK3ysX/rge55Hvnnkw3FC+NRF7wWjKw1vTbewFYmZmOZ6uuqMsVhEsXobWtcl
	AKIV5RsPBOm0hcDZ/VPA0t2N6QS7Ia8sDtsy9PDYhFQYAauxxo4VgJig0u1oXYitsk5D0a/XvBV
	gJXryP/GfhnApE1rk5g26DdgDpKigjXuwsEmY7IsrtueCYWSurnXIhHebN3G4/X7/o
X-Received: by 2002:a17:90b:280d:b0:37d:83f8:dff4 with SMTP id 98e67ed59e1d1-37de418e12emr2136579a91.4.1782287002029;
        Wed, 24 Jun 2026 00:43:22 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37de3cf70b0sm1610076a91.11.2026.06.24.00.43.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 24 Jun 2026 00:43:21 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] dmaengine: dw-axi-dmac: Fix cfgr_clk leak in resume error path
Date: Wed, 24 Jun 2026 16:43:04 +0900
Message-ID: <20260624074307.68365-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11762-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Eugeniy.Paltsev@synopsys.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mhun512@gmail.com,m:ae878000@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mhun512@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhun512@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C2EEC6BC456

axi_dma_resume() enables cfgr_clk before enabling core_clk.  If enabling
core_clk fails, the function currently returns the error without disabling
cfgr_clk.

This path is reachable from dw_probe(), which calls axi_dma_resume()
directly after pm_runtime_get_noresume().  The probe error path only
disables runtime PM, so cfgr_clk can remain prepared and enabled after a
failed probe.

Unwind cfgr_clk when core_clk enable fails so the resume helper keeps the
clock state balanced on all error paths.

Fixes: 1fe20f1b8454 ("dmaengine: Introduce DW AXI DMAC driver")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 5d74bc29cf..001ab7464e 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1333,12 +1333,17 @@ static int axi_dma_resume(struct axi_dma_chip *chip)
 
 	ret = clk_prepare_enable(chip->core_clk);
 	if (ret < 0)
-		return ret;
+		goto err_disable_cfgr_clk;
 
 	axi_dma_enable(chip);
 	axi_dma_irq_enable(chip);
 
 	return 0;
+
+err_disable_cfgr_clk:
+	clk_disable_unprepare(chip->cfgr_clk);
+
+	return ret;
 }
 
 static int __maybe_unused axi_dma_runtime_suspend(struct device *dev)
-- 
2.47.1

