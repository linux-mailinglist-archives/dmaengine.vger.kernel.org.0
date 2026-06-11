Return-Path: <dmaengine+bounces-11477-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 21pVLyQkK2rK3AMAu9opvQ
	(envelope-from <dmaengine+bounces-11477-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 23:09:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C8467560D
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 23:09:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=UCP7iUXh;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11477-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11477-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EE6E3333104
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 21:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A993437DABE;
	Thu, 11 Jun 2026 21:07:49 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883A637D110
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 21:07:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781212069; cv=none; b=dshN/QFd1HT9auo/wHo2DDVsn9M5aCGdtAIyPjA3SJWJXOz6mNwHfv4ldxVnLgBumG0DW9r/r5awcHkzV6R670EMRC0kj890FCEt8+/PYyPFtAUlOCl8uJIHwtwypbYB3LhV08UM+HkinGqF//yper4Kyb6ukSbQ2h1XRLQs2kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781212069; c=relaxed/simple;
	bh=FhI2APYt+4/QJVRA2SyiUcYBi407KrWDfJ01MWqJtK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kUsvBIA1AG2xDg+3T3N6nb9WhwKcaqrnHAfDKKS5xl1PuWqRknLrMCuxhWa3wEPZZhvQkiMI61H/npK81lIDTvXcIF3v4/DqzlrX6WnlZk4U/zgTXhm2QT+l8Y+y3v/nU+AiTEoZv3v9IvNogqViw47Ja7FX/9/TDJ7nNcQhd28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCP7iUXh; arc=none smtp.client-ip=209.85.214.174
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c0c2d8b95bso2359665ad.1
        for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 14:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781212064; x=1781816864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4LqIqcR28wVKNTcplRcL0sj6x/zHUyaukQuodAoubU=;
        b=UCP7iUXhm+LVdUrz2dtHec7KhoFJbDfm0ljlolJpn/rKtetMRBzzFP1zq3Sn0gak0t
         VqI26Z/L7cQiVJ3oVD0rZkGY7+dKjee6inYKXPxugAICSBcoxg9IIwMcdwYrNpZmzY8X
         QfI//iV3xF/EKq4CwhDiJa+lRskgTDAMssE0NqpNYyfG8h995jwq5j8qJUBgjG/i+pgt
         ksmV4BS0CTD+dgHPQ1jQhMHs7SVJMeLmQxWPKAUCypSOwzkYXWssQvhP0WiGA9c+zIhD
         IVHD86y1hBvfK/1G9Ecs1qItpdZCMCQ9cCLEZfS62d4jAflkbvDfoNds7l2rJCuxkt2D
         WwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781212064; x=1781816864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U4LqIqcR28wVKNTcplRcL0sj6x/zHUyaukQuodAoubU=;
        b=YHxiia1Op0dnFp3pQ1Szc5RLERV6kkUb7hZMHwToLEEsMVqP45uzaMDp1+BZVros8c
         REQVK7knfRcbf6wJFeKc17zikBwCdJqeqYFUJLHAaJzO9xSLJWZwCYoMHSpjsM2eScPV
         Xpe/WynXRZjgF0JKtIW+XKttBkjnaHJ5PWrayE3FwKVTlld4D0c0n7FPwARZTiLO80aE
         zZMuA2jlMLbDF4tLf28bUGbIjDZGzhZlJ9awfNVNo0dHUkB2eMVi4vW1VINAlvYynxYL
         UwEWLZvYG94dXFjlfzBMMNZuaG1a1drVrnwdIhIaIC7BxI9QaUpH0B2xduOvFN7owHl9
         Nl/g==
X-Gm-Message-State: AOJu0YwvtXBi6lpHrR7skqX2dxNlhjYZNjUzK5avk0G7CboCaDr5mRmJ
	qQTdHL7Dh+1f5+lTHmYB5TTWLmN5Sv9P/4pVu9Evmvx4bBjbRWg7P0KwxExVTQ==
X-Gm-Gg: Acq92OHFYGSMqSdYohn+MOKtbQGRjUiKSidf8a/+99e+OuPP9MOQpbuIDq5dem7Bn1/
	px0gJvwZtGab2zzej/Qmk7An+3+RXeumHmkHnZaLwxUEq73qEsVMhYDzpmInpSWXNnwfFca2qFU
	1rW9H4kYj3e7JpP37QLcU1dQ96mag76Dj7bhG0jd49HpBKGw5OO3jGBtZMqPZbW+33lr97tSWCR
	AYkkhd6uONa3Hm8LJVdFLH5MM9q2+oeFgnd92v7CElNoSWch8avG2NRNlNFNhuij8ZMW914AJ6c
	8rG+Gsc9RE3gMrEwjmvV3AtIu6cSY1BLEW3eKgrgVQeEPDFYBO6HbSLoA2Bp+LqQduPqK9kjDIp
	Mk5Po1E3fshw4XZAkvf+PiEQp4g/GGmqDImQwzrRDsPuMrytr1nlZiPp8dd1ifbFTSm3uLHol47
	1kxTfgWhgxh6pZQLiQJ0ijBvh0nVfDwq6PoIXuKlZ2RL82G2mx6lj3nJMrm4RabMKKzJsq3Rpdz
	wSeOWFx5QG5qFEL4wSX7D8epHzQMBstTh0=
X-Received: by 2002:a17:903:298f:b0:2c0:cb0e:ac42 with SMTP id d9443c01a7336-2c410ae2b51mr1097205ad.3.1781212063884;
        Thu, 11 Jun 2026 14:07:43 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:6d3a:64fc:4ee8:9cc3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c411d79289sm389995ad.14.2026.06.11.14.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 14:07:43 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Marcin Wojtas <mw@semihalf.com>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 3/9] dmaengine: mv_xor: bound maximum channels for Armada 37xx
Date: Thu, 11 Jun 2026 14:07:15 -0700
Message-ID: <20260611210721.81979-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611210721.81979-1-rosenp@gmail.com>
References: <20260611210721.81979-1-rosenp@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11477-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:thomas.petazzoni@free-electrons.com,m:gregory.clement@bootlin.com,m:mw@semihalf.com,m:robh@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 34C8467560D

For XOR_ARMADA_37XX the driver set max_channels = num_present_cpus()
without bounding it by MV_XOR_MAX_CHANNELS (2).  On a system with
more than 2 CPUs this lets the probe loop write past the end of the
xordev->channels[] array when the DT describes enough child nodes.
Add the missing min_t() guard.

Assisted-by: opencode:big-pickle
Fixes: ac5f0f3f863e ("dmaengine: mv_xor: add support for Armada 3700 SoC")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/mv_xor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index ef29e8be1db6..588af337afe3 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1387,7 +1387,8 @@ static int mv_xor_probe(struct platform_device *pdev)
 	 */
 	max_engines = num_present_cpus();
 	if (xordev->xor_type == XOR_ARMADA_37XX)
-		max_channels =	num_present_cpus();
+		max_channels = min_t(unsigned int, MV_XOR_MAX_CHANNELS,
+				     num_present_cpus());
 	else
 		max_channels = min_t(unsigned int,
 				     MV_XOR_MAX_CHANNELS,
-- 
2.54.0


