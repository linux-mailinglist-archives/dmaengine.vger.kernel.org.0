Return-Path: <dmaengine+bounces-11413-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g2nNBSQxKmpQjwMAu9opvQ
	(envelope-from <dmaengine+bounces-11413-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 05:53:08 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 669A966E096
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 05:53:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=kbjQa1HF;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11413-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11413-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BD6130ACA01
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 03:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5F833260B;
	Thu, 11 Jun 2026 03:53:05 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885DF3314B7
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 03:53:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781149985; cv=none; b=AzRU0wu8dzcSoGw/nocuDTuXynuw+DvnaWTR503yVYBy2n+FM2kG/RDghYFYtvsI91fEBjiBGVYXYiHAojjaskbhNtWga8thJ1wlPCU140tz3VK26v4+9lHTTSX0JKlr+yJj4BK9NhZmP76WehuneMZNo7H6K5CLG5L3WfBzLy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781149985; c=relaxed/simple;
	bh=RHxXzobTNxLOuRQySHEzFJkDtz+/dee3kZtQg5Fy0Fw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m2n4s2NYnNuZL7/sguNq5+9o/BkUeNBf5a8XRaejpCN1V5QClGHkfQgm20+vVNCuSizkio559ayOF1aqgx801sHTIvmudERqD1SmBqs432LEAwDAZrBQNP+kCvZLqr6Dk6lrzpPpS5siojlY6LqIn2aXocH9YvNdR3PB4+pQ0n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbjQa1HF; arc=none smtp.client-ip=209.85.216.41
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36d98b68d68so4797787a91.2
        for <dmaengine@vger.kernel.org>; Wed, 10 Jun 2026 20:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781149984; x=1781754784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sw1Cja1RhTfP4kS/GYb7UquNtVaGdBSxdFT1BKiN0hY=;
        b=kbjQa1HFbUC2mx2XMAdhupICGaIfD68ANEr2/Au7eitZGiq43FPtdR9cgu1D9V34yB
         +M4PQ6bsIx8TKFI9NNi5O+qnapCZ9PcwmW0c288AygSaRd3BTq5t+9TieJ54PR7fPNB6
         dWZJBp1zdVAoK5fIq4zNI9GCCPLEk+9NDGIX7aDgla9o8YDbX6mYRQQkhbc58d4w1a0y
         USEoAMrxnlGZptvN7zQ4FfOvduWvwViV75Acs0N+deQa93X6MpSm7b6nQSXH0qeaxwAF
         E7uLuXClPGNzhflqQuBULQxOB3XxrXIWPABRITsAscZPegXrLfPg22autDssTmjZJXIv
         Z4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781149984; x=1781754784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sw1Cja1RhTfP4kS/GYb7UquNtVaGdBSxdFT1BKiN0hY=;
        b=CN7icTSWI9qp0VtmyODIH29cI0zfiXoge6O/o2IwxoABl15S6sFEh1IqlDLx80tPWB
         1B7JMk4eWN7ndOuiua44U9hPIbppVDnOAyb41f9+hZDCCzm4fxOHXKZVUfSPRa3Rbeub
         liYUPpY0SxCAEGble95UjqZV3L/rmuPnz1UBYrZDnYjPqeWxq1p8monh4JQX87e8kSYw
         XOKABfYQ97Ox+8kS+2yGuuMifyZ76HUiwn4MhYpNXiNnJwYFLlkBxJwsEpzOCFa+M8n4
         /B+VCey+//+03R3FJQPABbUUEvEI2S73aYS0aahKUgFbmDF5zU6g+JGngujLxUJpqEPt
         E3Xw==
X-Gm-Message-State: AOJu0YwgukY8xNYZ3Ssooy1A4jLPHvfeYpU68v5Pys5ZFzjDLrnBQAL/
	dOLtJ68hW0wg9TjIRvlUKuvQsFdCE+EaaHWunLpETnDfxUW+JU23whSpnMcjlA==
X-Gm-Gg: Acq92OF0tFZuW+/hzxHJ+D8jPo5D92AoQVZJS2uKXe1+hnIxOJsb7hcbxknDhSOp6+m
	tc/3sdEoO7puK5i5lTUOdm+sZzFMRegI8VpTCoNWs95UbBKTJZz3BKpEYACOXAiRADbqVSdgVK3
	2NuIQqiBZtDn/mcGi5GPfk2Gw3/N7nwMEPZdcJ7toKMCIkvjaOO/acRoKMpV5pUsIL0rSU5+biY
	5CHGlu+SHVr+2rnlMbiNd+k0DA6OuJvn10DLVAR7dQjZuimTSiSOCTJZBlv4zCnLw8sCMLtMTk+
	aqw4EGdy3jmFDtUig2mOhrdkvehv7kLEvkE6+gDdDXhNyBgJb3BBT3dRiH/1/L3mSa/O0p0GmQc
	zHZOOKPY+hdlJTYkPn5Z/k0yz59rUUffeuMhRZ3yjcEtTaec6s9we6XuCpWaZQutut4kU5yPo7h
	ZjMZoqWMUC1vVGNkiPitQOi4tDu+acSfsU0lV3zTofFxv7lBHgX9NLCUIrxoMwGJu9POi+hsFvU
	cGgqGtNLNQ/xC88K6Pe+Y8ZqkjP1hmiOxIoyYGbTbT7wQ==
X-Received: by 2002:a17:90b:3808:b0:36b:b06c:30a1 with SMTP id 98e67ed59e1d1-3779bdbe7e8mr1273257a91.1.1781149983868;
        Wed, 10 Jun 2026 20:53:03 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-377522a188asm910131a91.3.2026.06.10.20.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:53:03 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Zhang Wei <zw@zh-kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org (open list),
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE DMA DRIVER),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [PATCHv4 00/15] dmaengine: fsldma: devm conversion, fixups, and cleanups
Date: Wed, 10 Jun 2026 20:52:30 -0700
Message-ID: <20260611035245.13439-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zh-kernel.org,gmail.com,google.com,vger.kernel.org,lists.ozlabs.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11413-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:zw@zh-kernel.org,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,lkml];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 669A966E096

- Kill the channel tasklet before removal to prevent a race with
  the IRQ handler.
- Check the return value of dma_async_device_register() instead
  of silently returning success.
- Replace the powerpc-specific I/O accessors with portable
  generic ones so the driver can be built on non-powerpc
  architectures.

Build-tested with LLVM=1 ARCH=powerpc allmodconfig

v4: address review comments
v3: even more sashiko fixes
v2: add extra fixes to satisfy sashiko

Rosen Penev (15):
  dmaengine: fsldma: kill tasklet before removing channel
  dmaengine: fsldma: drop desc_lock before invoking client callback
  dmaengine: fsldma: halt DMA engine before freeing resources
  dmaengine: fsldma: provide device_release callback
  dmaengine: fsldma: check dma_async_device_register() return value
  dmaengine: fsldma: fix probe error path not freeing IRQs
  dmaengine: fsldma: fix request_irqs unwind freeing unregistered IRQ
  dmaengine: fsldma: convert to platform_get_irq_optional()
  dmaengine: fsldma: use devm_kzalloc() to simplify code
  dmaengine: fsldma: use devm_platform_ioremap_resource()
  dmaengine: fsldma: convert channel allocation to devm_kzalloc()
  dmaengine: fsldma: use devm_of_iomap() to simplify code
  dmaengine: fsldma: replace irq_of_parse_and_map with of_irq_get
  dmaengine: fsldma: replace ppc-specific accessors with portable
    generic ones
  dmaengine: fsldma: fix kernel-doc param names to match function
    signatures

 drivers/dma/Kconfig  |   2 +-
 drivers/dma/fsldma.c | 258 ++++++++++++++++++++++---------------------
 drivers/dma/fsldma.h |  35 +++++-
 3 files changed, 168 insertions(+), 127 deletions(-)

--
2.54.0


