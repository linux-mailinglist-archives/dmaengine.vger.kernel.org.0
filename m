Return-Path: <dmaengine+bounces-11127-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id comaAdqaH2rYngAAu9opvQ
	(envelope-from <dmaengine+bounces-11127-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 05:09:14 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 519ED633C64
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 05:09:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ApqJlwAB;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11127-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11127-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EAE3303280B
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jun 2026 03:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A743D811E;
	Wed,  3 Jun 2026 03:08:14 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628D53074A1
	for <dmaengine@vger.kernel.org>; Wed,  3 Jun 2026 03:08:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780456094; cv=none; b=uAwJsUx4Zs+0sumPYbdzUq5vTENhhRFtvt8ti8BNy35av9poQvf0xePNqr5SdwJ+UKNeIANCZRJSk4b+4PqxaV/ly7jRrykF19r2y5QS6cBfxDYPGMjz1wmbJ9W51LVWlIPEW3oJyGeuzhKB8wGqA8vuQ5LN5Sk+z8Gfv/NNgAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780456094; c=relaxed/simple;
	bh=DS2KjsxpIBAcucsz1q8RcEDoe7sdgP1JDn5kIURjHks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SuwilqdOGJSFZ2s8BRJm9PtY8njI9HlfgFcfkpjX0/fDIfbFIq/JsVqBgFzhcAT2HK2hR4hkI7hbJ/AJxODw5zfUqQfoZIYO2xfxDrSSr2kkrWr2Pz4JfLB3FTf1Dw9P+WcBrejFN/4+mh+ULTWpuYujkxoZSVZdHEtXoJjt1kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApqJlwAB; arc=none smtp.client-ip=209.85.216.41
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36b9b15af73so5618949a91.0
        for <dmaengine@vger.kernel.org>; Tue, 02 Jun 2026 20:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780456092; x=1781060892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SzR8b8HqOe9R9dNLngX1HGRIqKkTWTema1bE7iFLv2U=;
        b=ApqJlwABKJyNWYT9Dmkz//cBZUyDVMfSOwZlkm4T12JL5yZGbSjriHpKvzTyzZlrv5
         0wkNu5lEpvJOVCyolsoyC2p337YoooFzD/BXhnROQHuKYilFZMltr4KP3vpfrXzc9YXq
         mVkZmFPk41YARpMw3cwSJF6NcJXWSjJlPFZXIeuUErkDskESZJjk3DhJ2g2ZTlyRTUFg
         v2MyHyt0KO13CTm/Namo2zNAT/h99OSzQdZV6kKgSiPPMR287kVyQWsucyS43JK8mwDE
         axcpYNf15I9lXV/f3lPJoniD9+cSk2lunWF2sjpPoJtiH1vq15/SK/00McrG9Pj19rB5
         uBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780456092; x=1781060892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzR8b8HqOe9R9dNLngX1HGRIqKkTWTema1bE7iFLv2U=;
        b=sgl0/7CevGmJw7yw1VEJJr3CVmOqf+0rlk7JeGbRUpVg5WrasGGHsT3T8Arqokl5ut
         isdVFLoozkw2KWds5KC/ooV8WkbxkarVSEMSE4yAnQxLQwckUcKo/F0bNGY2/ep3RgWZ
         1NZ4LCV9VoXoGsMrKhScOWIhvgHChCyyv45M397IsBO33EIUXTRQ/ADXjp35GF/CkMxf
         noAMiTY23GuCLtd6W60m6p55UKAoo0sa57QoulYtSEx8xGNiOfgS8eDKwgz/VSlMOWKZ
         fwWRPsh1z6D3h0ViTXNxJ+87yiq0tvF6VK+7llCK8v6iov3ne2CFxGcAd5Bo6sbwX4cZ
         dNDw==
X-Gm-Message-State: AOJu0YybRQFeiGC67zuy4ao/NhgfWV0S/kFPrWrX4uopugLty8VcsXXK
	1vdfxf64wqhmUoVebmvqzSuakgCFd5bevLZdo2TjZ/22NXADUGEKw3jcszAQbMsI
X-Gm-Gg: Acq92OFrcNR6k94mWtSvaMO6LC+mo0QhlbnvUwSOnJq4x2/jwmebdO1mXLswZtLz58G
	zt62jYb5OEfs9BWZ5unjkfHC68y8xYTjSO+QczqzBJi+zLLeW/aqRQq8y+cVSVZTgCqONjf+xCY
	t7ZryPe6Qo5cuXeMpWavAoM3eCsD19lTu6EyME7PIP9UEK9c3ev7UloioZt+tsBo2bOTdN7vJ0N
	fKLmogXEfKt7MyKkZT1IPVki/CeuvkQTPdt/x4igOtYlLZAUOOJpaMSr9JtToMG68hnKBAPJZJK
	LkKiuoQc0JpUp7rQ+NGLJ9i57Xq2UJSp6BYxRI+66AYi7zZqqJ/qiSigWn0iLv9w3mVskjfciHZ
	9Le6t0isRL6xzOUV4Bcwn2Lb75k4GiNv7IrmJ0FK0cJZM6E3cWcALycdvj5pil4tD7+AAG8EfE7
	MBGNwFrOw0ADhIV98eQNtf33Ea5dI4AAcR5srcTaRjqH8ScJndcy0u0kR/a64suXW2hJ41k2ysh
	pkTQAy8JIWKdbyf4m2lwKDtrdh6q37HqbM7clPLYOffzQ==
X-Received: by 2002:a17:90b:3f90:b0:36b:71e6:3de8 with SMTP id 98e67ed59e1d1-36e34770907mr1461244a91.24.1780456092659;
        Tue, 02 Jun 2026 20:08:12 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36e0a186741sm1247102a91.8.2026.06.02.20.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 20:08:11 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Haotian Zhang <vulab@iscas.ac.cn>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCH v3 0/8] dmaengine: ti: omap-dma: probe/remove bug fixes and cleanup
Date: Tue,  2 Jun 2026 20:07:46 -0700
Message-ID: <20260603030754.288757-1-rosenp@gmail.com>
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
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iscas.ac.cn,atomide.com,arm.linux.org.uk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11127-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:peter.ujfalusi@gmail.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:kees@kernel.org,m:gustavoars@kernel.org,m:vulab@iscas.ac.cn,m:tony@atomide.com,m:rmk+kernel@arm.linux.org.uk,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:peterujfalusi@gmail.com,m:rmk@arm.linux.org.uk,s:lists@lfdr.de];
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
	TAGGED_RCPT(0.00)[dmaengine,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 519ED633C64

Fix several bugs in the omap-dma driver's probe error and remove paths:
missing return after failure, CPU PM notifier leaks and missing RCU
synchronization, channels freed without stopping hardware, IRQs left
enabled during teardown, descriptor pool destroyed too early, wrong
interrupt register used in remove, and a flexible array conversion.

v3: Address remaining review comments:
  - Split CPU PM notifier fix into leak fix + RCU sync
  - Add missing return in probe error path
  - Guard IRQENABLE_L1 accesses for legacy platforms
v2: Fix sashiko comments and add extra patch

Rosen Penev (8):
  dmaengine: ti: omap-dma: fix missing return in probe error path
  dmaengine: ti: omap-dma: synchronize CPU PM notifier removal
  dmaengine: ti: omap-dma: fix CPU PM notifier leak
  dmaengine: ti: omap-dma: stop channels during teardown
  dmaengine: ti: omap-dma: disable IRQs on probe failure
  dmaengine: ti: omap-dma: destroy descriptor pool last
  dmaengine: ti: omap-dma: fix interrupt handling in remove
  dmaengine: ti: omap-dma: turn lch_map into a flexible array

 drivers/dma/ti/omap-dma.c | 122 +++++++++++++++++++++++---------------
 1 file changed, 74 insertions(+), 48 deletions(-)

--
2.54.0


