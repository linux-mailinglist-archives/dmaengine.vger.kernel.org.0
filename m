Return-Path: <dmaengine+bounces-11020-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OakAGqpGGrclwgAu9opvQ
	(envelope-from <dmaengine+bounces-11020-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 22:45:30 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8B35F97AB
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 22:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 19CCC3054975
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 20:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC4334887B;
	Thu, 28 May 2026 20:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMvBPWNN"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F6733B6FC
	for <dmaengine@vger.kernel.org>; Thu, 28 May 2026 20:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000554; cv=none; b=InANsAaB5/i+HHnYyWpOV6m/vFj3qAq3j1CkR/vu1zrij47lE9TXLMsV7CRgsLQY3hK+xTVQcU4CD5ji1frSmVh/2ap2XewPrxllADb7ie4o6E6klnyAgKlWW4JdXYb6feO5I4xbv5c+5Pif+YX+fmX7Po9XavF4Xv5wrKILxdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000554; c=relaxed/simple;
	bh=bgAvbJC42wjKMPX9CuchBcmr/0oSvJm/iUaHeAa0vDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jE+dmreNAPQ6bNQ+Of+z5vJN2xc2EIWZxySDIypOwSsHq4ikGrNN63nX8LjyryLfpjKqxVy+Z8n3tb2vPm3c2ZI8zDjdYxHyyQeBh9hbKQE8nyWQUSMa9YRufLkT7GEHthbm+I5N7QkMRjiOaZeZgMGSUNI9LRR8z31B4XWAdpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMvBPWNN; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c822652f82aso10648175a12.3
        for <dmaengine@vger.kernel.org>; Thu, 28 May 2026 13:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780000552; x=1780605352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mMGlKzvZTRv0YMZaIIbJ/KBZw5RUEsHZGKOz3BAMHmc=;
        b=UMvBPWNNQpnYulpRcEhwUZTBHbdwZhG54YjUt2LERWJaF5ZYfPS8tSRaJmZZQYvjiv
         4kRhDfamGulFqLpB9Yh5CenCP/OG6iQHF/PFYIb+6aV35o96j4XDKGgOuogVgpU6/Mjq
         O416JA3qWDv4wnDXsiBSH6e8lRqfdV+yS1rVCBddo2W7WlkqQGDAIiBK2hRF/PfIiYbX
         s9QrjK2Xva8504HyrjapkM2SozwuqalhEqaO4pwIrrbpgTXtY1QQHiF6HTsbWuwFG8i2
         hKhkGFO8UZDF9TbQbSKjeobWAcE3HsF4cLfbGNXL4T+dLQ/sAv5QmbuBPKbp2Yhf2Htz
         u8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780000552; x=1780605352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMGlKzvZTRv0YMZaIIbJ/KBZw5RUEsHZGKOz3BAMHmc=;
        b=YwOOSgvv1x+NcFZ2KdvrfgVDm4yiLJ6bIsb3So9SKSYyZBsLnCMvWX6zBdSpG5sg1A
         Pl++e3ZibhFthqYkU5XxorZJC3VDGYQnTel7WK+0VRT4lsZKInMgaC6GiHcMfhjx69/u
         qBIsUQ/dpy07blbVtBpkH8DdWy7PMm5lkfhMJL7RSuV4L1ttfOSWsIajfmPplU9HAfXl
         VtnPylLxO51x/1NS5FU/T3wkej8pU3YC3V3yJVD62i7f1hxYVtjCu0d/VsSm22ZXf2Xk
         lOfX165MmFXgI9ejvFS1OclWyucuAApnxcqVkrSeCp+pFGQhv+SjwFbdmidRFtSj0fIj
         FTJQ==
X-Gm-Message-State: AOJu0Yxx7zshmSW8dl4RbJdl2jcxcrIceB3qoMPBO4PDK08/usbELptt
	xfl/0NNz/wLNPTw48CmVPI2P7hN6l5gX3RjlhGcDdMRXHaHWUlKDX9NZB9GmlqM+
X-Gm-Gg: Acq92OFvYwMVqKP5kO5eX4wsi/kYIONar9Kq9brDtHYxcx922bj/fcFqBJ62OKDkXLx
	A+pPxRgqTdsAVzonKUfgNmibseCdr6lh+07mGe5cWVjF/jeFi1VrddZW8R/Uckdezj7Q8z8nuAK
	Dm2Uv9GQctYhagd4qCOxZ4eHF2r9/y0P+9ELle7mXc99J8lSNtWx/twGnCYsLv75mg13KyNAYxU
	2KzKrcIqdYkPLlYjvH5cBwHomOvoXl98sTKdT/mapSs3m++t7agpa/bhUHHjbvTCuAxKejcNOBK
	MMx+NuBM432oI4ulPuB3yZxkTGEcbESevDD5aGdDimJ4+XdY9o00gZxhbNxicCnUB5SParjiJZC
	UgLOgeJBUDbvZB0zumGvT54MeuxoStn7pBHdTkkYwfx+TeYZbVvJxbsGa3Too0tNZeLj2YT4U4K
	1nX7bt1pLe+l69CVnL+9SkpuNvY8exkud7a41F3y5LbGtgAo0zT1VCGpEQHN6MJ+bz0CFwD2pcb
	auu2DhndZNJ+Vp4hyvJPFAjjdHUskak6yz73cVCqe+MOg==
X-Received: by 2002:a05:6a21:685:b0:398:89b6:1b41 with SMTP id adf61e73a8af0-3b40e60747amr345604637.32.1780000551961;
        Thu, 28 May 2026 13:35:51 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8572e70d19sm152803a12.1.2026.05.28.13.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 13:35:51 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] dma: bestcomm: gen_bd: split struct bcom_psc_params from array definition
Date: Thu, 28 May 2026 13:35:34 -0700
Message-ID: <20260528203534.137794-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11020-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3E8B35F97AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The combined struct-definition-with-initializer pattern confuses the
kernel-doc parser. Split into separate struct definition and array
declaration.

Assisted-by: Opencode:Big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/bestcomm/gen_bd.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/bestcomm/gen_bd.c b/drivers/dma/bestcomm/gen_bd.c
index 8a24a5cbc263..0b400a76adcf 100644
--- a/drivers/dma/bestcomm/gen_bd.c
+++ b/drivers/dma/bestcomm/gen_bd.c
@@ -253,18 +253,14 @@ EXPORT_SYMBOL_GPL(bcom_gen_bd_tx_release);
  * PSC support code
  */

-/**
- * bcom_psc_parameters - Bestcomm initialization value table for PSC devices
- *
- * This structure is only used internally.  It is a lookup table for PSC
- * specific parameters to bestcomm tasks.
- */
-static struct bcom_psc_params {
+struct bcom_psc_params {
 	int rx_initiator;
 	int rx_ipr;
 	int tx_initiator;
 	int tx_ipr;
-} bcom_psc_params[] = {
+};
+
+static struct bcom_psc_params bcom_psc_params[] = {
 	[0] = {
 		.rx_initiator = BCOM_INITIATOR_PSC1_RX,
 		.rx_ipr = BCOM_IPR_PSC1_RX,
--
2.54.0


