Return-Path: <dmaengine+bounces-11358-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7RFKANWRKGqIGQMAu9opvQ
	(envelope-from <dmaengine+bounces-11358-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 00:21:09 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48066664861
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 00:21:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=qrdWflBD;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11358-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11358-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 844E2304D5DD
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2026 22:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6095A3B5E01;
	Tue,  9 Jun 2026 22:19:47 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A4F350D7D
	for <dmaengine@vger.kernel.org>; Tue,  9 Jun 2026 22:19:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781043587; cv=none; b=AQ3/37sL/3FvTnDRvJKpjmoHPoIoUaUfCrsjsfS5pijGOZUm0JQC7FTP55fPjtpaV9z4oou4p/WESWC/ZfEqvNkLlZd3o01AYTY5G8hH75aGzlcO0oR4Nk4WfmhSAZ5kpR+1/+rDUY6jPE4WWYrLXYfvFUxjflevCIeAxWTuPgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781043587; c=relaxed/simple;
	bh=4/M/Z2Yw+2EJSZ+xE69ERPp/09jQ6db4A4lE0jGTRKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VXscnkiKEMXcCBgxPWyD79D7twShlW2QjWLbV58nEUXSdJD2SSs01OL2dOUKjwcLKpEUTHDx/M2b5FSEevqXfwj3Yg1NgJGU99ymMQkCTKU05vc+KiHK61YztyrRgurAoZX194d0FzuQKfRDtswFC3UVoUfpoMxf7htHpKHevzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qrdWflBD; arc=none smtp.client-ip=209.85.215.181
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c85a2ca7bf7so2244319a12.3
        for <dmaengine@vger.kernel.org>; Tue, 09 Jun 2026 15:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781043584; x=1781648384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u+enzAQ5tSvqZYMQTM27Sa9xGue4NUeyFXwU532vPXo=;
        b=qrdWflBD5wTTnvGe4ZxaHWkYRr4Yr7qpXv+F8hXzbV3lf7GqMappgRVF7PzR25hwES
         3fhUCEBUdXTnR1IOl4VKaiUx/U0YWYvxrSqQRMkTg83K5zvedDGQwxNfN7ZR/xiOdKij
         T1KsoG3aN7sZTR6Fvmt2wDjIyUNJe4AzNQ/yvD5zVEJhsj84JXvq01Zyi+HrRuTkQwQ+
         N8W4CaFL2YKYEh1mP8f0IvS0ISQG/gG36XFdwzdE12/CvQH54FldCQRgrvlxkJB4Db98
         /z8dJvoSDWEfrwZzfMwFPQScmCOPyxngivTzUeTOlnzic9nGnP6/ijFRxi6eiSYL3+Cp
         FEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781043584; x=1781648384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+enzAQ5tSvqZYMQTM27Sa9xGue4NUeyFXwU532vPXo=;
        b=Wbg+2KYjPp4BBEz4983thUILoNdmjbDmSF/w2DVDq7+sPa5bKoV5ra3XPvI7hLWxOd
         HmEnfBflwIr4PP5s9K9QuAULzrZbsP0g8tyNTgFp12Rrc3VzU8ub0K2zCsTRir93cSK4
         WYbUedCVY9ZiUyT0PSLMzPhVM9d8wcWLue7dYVuIViu1aYK9kajwMhtL6sNTr6EA+xxW
         57+YCkrwMPqhxeUgXgJ2E9BKS4GV2cbLk8JJF91h8JWh4q6wvPrhmpixFJmaj6V04iBV
         qIpZVBaEKkROwM0f08MjZwjv4espCqKoaI+vc3g6Y4HVgcDzQmose3nSY9QYSlp9W/SN
         biLg==
X-Gm-Message-State: AOJu0Yzwwoq7noz2oBzrQFQ+aTGyHCaSwYyKfizDWbf2zuQPw8UJ2up8
	gYFwQkIJ+KFKWUdHOPpOWhGU3QfY2bUMzNnFoftCmaYIixmCa4ftKtwdRHsG/yt+
X-Gm-Gg: Acq92OFIkBi6Ph8svbI3RMG1rp9jSYGYlubVRqgNQwsMo+XTj67gXiqhsC9NEHvZRNO
	voGoMAd0IZFWGAEmYdcWiAEMx2ZrDRlGpBpe4HwvfJuRjXPI5Wfxy1XgBY3CfV0Tav0UCR1QO0O
	3YjdztMWObvGTbDeMEPdMpsN/PG/ZTTFenYzrvRvHBqOLRDuRzOlfA/w+AredDsWjD4YGn/Lj3i
	ed3vIkR3KJw2loisaCxvA6sMdIcjxGw3gy/swQdHynOATFtI5HNuMqF7FocTNzMt9BiW3PUPVdo
	9ehAOXC1StEg4n6lq+kyABMNC6Kp9vfn6POMS9A8Y8a3zorcxIkxuoIAsw12xkVY8XlY94Xuxuq
	+nFd4JyKS+ARlmZrbb/4s7pEoAu7rlMJ+0JM8mhZpeIzAt8YpVKvaTk1O+7SsjjWEbzF/si55WM
	W7Ux/hJCOdq5NvM6kfv3I68LFe9MDyCEgI0Dn1xfl5dU+RKFxm3/OXtjYDmipvbe4JmpU7g3t92
	bQbjtn7acv+HzHdu1HH/ZO8zi9TaR/HKPBYiLO1/W63bg==
X-Received: by 2002:a05:6a20:158c:b0:3a2:d838:bfca with SMTP id adf61e73a8af0-3b4cccfdeb8mr26870997637.3.1781043584305;
        Tue, 09 Jun 2026 15:19:44 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04ff24sm19661834a12.14.2026.06.09.15.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:19:43 -0700 (PDT)
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
Subject: [PATCHv3 00/15] dmaengine: fsldma: devm conversion, fixups, and cleanups
Date: Tue,  9 Jun 2026 15:19:11 -0700
Message-ID: <20260609221926.35538-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zh-kernel.org,gmail.com,google.com,vger.kernel.org,lists.ozlabs.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11358-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:zw@zh-kernel.org,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 48066664861

  - Kill the channel tasklet before removal to prevent a race with
    the IRQ handler.
  - Check the return value of dma_async_device_register() instead
    of silently returning success.
  - Replace the powerpc-specific I/O accessors with portable
    generic ones so the driver can be built on non-powerpc
    architectures.

Build-tested with LLVM=1 ARCH=powerpc allmodconfig

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
  dmaengine: fsldma: use devm for kzalloc()
  dmaengine: fsldma: use devm_platform_ioremap_resource()
  dmaengine: fsldma: convert channel allocation to devm_kzalloc()
  dmaengine: fsldma: use devm for of_iomap()
  dmaengine: fsldma: replace irq_of_parse_and_map with of_irq_get
  dmaengine: fsldma: replace ppc-specific accessors with portable
    generic ones
  dmaengine: fsldma: fix kernel-doc param names to match function
    signatures

 drivers/dma/Kconfig  |   2 +-
 drivers/dma/fsldma.c | 253 +++++++++++++++++++++++--------------------
 drivers/dma/fsldma.h |  35 +++++-
 3 files changed, 167 insertions(+), 123 deletions(-)

--
2.54.0


