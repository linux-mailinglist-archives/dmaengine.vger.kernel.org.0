Return-Path: <dmaengine+bounces-12525-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TfuXNZzIVmqoBAEAu9opvQ
	(envelope-from <dmaengine+bounces-12525-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 01:39:08 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A317597A5
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 01:39:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=jr7Q75uL;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12525-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12525-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D9433028F39
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 23:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCC637268B;
	Tue, 14 Jul 2026 23:39:00 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17F2429CF5
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 23:38:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784072340; cv=none; b=Xgxgld0MkYhqiiuD1slWge4caC78bF4Vn9ucKpGh4VCtczpCOknWYsbt0mGInsmJYwnKAibQNl7qhFCAjVJaI4MMZqPy67mmuVvdcDPj1yCYPslloPsAgj7skp9101W35aeUY+OdF7gdbURUrOdzgsDH+CjEuCvUqglrHQY/28E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784072340; c=relaxed/simple;
	bh=v6WAPbAYE+d2s2MzHulI+UqwgZ+bGYugTfrrPIE0bXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SydRY6EIsQ0sO65zRPnRoi7V/2S89FQAsIyd2Y84aFzu9mgu2RhyGYthXp1a9FKH/oyJ4dTiIQwozl2OGycvuf8NS5+16NO08HRpt7I/OAzq3hIdGxDJfuX/H94jXCEQk+K1hRzlvqsz99sHs6uTH3wleWgznNvQaJGCaLwbpiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jr7Q75uL; arc=none smtp.client-ip=209.85.216.50
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so1661612a91.0
        for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 16:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784072338; x=1784677138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=p9+t8xvcugZNtYVCV6tCJrKVM7SCPfJPg/Q/lRbMPO8=;
        b=jr7Q75uLjH35maippZy/ulxBjDJvWeqe8Bl1kXbqO9j6mLb693/KfWOKfVC9YMlbvB
         dlkjss0f71rFpo1g7qVjZmJh2PCI2qDVQClE035WBgw66A/Yiu+7dIKAfPzEGhMiTiOL
         U/npFKgNUUOxtJIs3xQZOsnYuLJJ6+K/rRb8vxesorEXGc30t1aZdXWJHtpbDDucM27e
         o2YSf/o0nM1Ab7LOs+MbiskzqjITRDHivGzy4mk6tcaGQCaPMeOHf+4y9o8Ko/cZtFBn
         D6ose8nsmYG0cVxjpInzyg+nix61M/WBwsrETOujOH4l1OgkXljTyCYszJQu7Ddjz0n/
         4rBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784072338; x=1784677138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p9+t8xvcugZNtYVCV6tCJrKVM7SCPfJPg/Q/lRbMPO8=;
        b=EfGM98uaQI+bsiwR4usXR5jwChanbaM9hD8AOQuldfUtTXS0yGd5KsbyBRExuLG3om
         g6D9oGgNa6RJg8xiqaLjr5gfz0C+x3z2ooTK/epOkP4ee/Zjiefd5BgHihwxpU/W+rsO
         ZoeK57JfWwPtHopbJDWKOnzRxEq3tD270jRwxbSvWDZt12UqSfw+PFkcZKeOxRQz172y
         KSE8kyTinajwdCIfXUsDE9PlHd15qKzXUHX1XqP8V68eG5SOfQooo3wignPNvmetrhtb
         fFXfSi95RQ15phJbSVFPSCJkiViovAQyfhjWSmPhkwVFRh0HY8PWv6s4IgsnNmLvar6+
         F/Jw==
X-Gm-Message-State: AOJu0YyIVA7ZE/dNnHzyCyxVmnO2DGv4Z6ZVD+Y+3G/3Jzy979gtktuT
	4FL/WNpHfjXE30+xSCuFti/rk9OHvawh8nEpwWPzSYhq50nZ6jGjrnvt/ESO3Q==
X-Gm-Gg: AfdE7ck8IagI1ju5y1nLymy/rpeOc5sFkZhmsK3PtNZ0mkRmChNwQ4kSNo5+lBalVk0
	v1iowZoYnffognrfy6pT+lyj3PEXy8SifReZlvYbOWJBT3wcGhK6jPCnNUtwYypJQDbO75neD0A
	+cQ1LBUA4DreQppMbeS2qwTzW1rz8COoCZSVSVse7D5H80q/LrIFZyZOMTq0Ajpf+NmnRalc9W4
	AOaeBNwpX56QCGAr/TfqWkcG+/0ER+eQcpxqW/zzd10q7gATT0jNKoOw/Cb9MCBrxwgAaO1SsVq
	sOMd+N8EA3fZCzBpm7g22L0r1Ml2A4LEbGrOtKbxdc6nX7CtpKrtvQxYGCKn4Td2FK56zxCjE5I
	f3cgGRK4LRKTMBAr3CQowXYQry9mLD/el3fY3OuCYzD+Mk9SilFQiMtjn2IPaOoCD6Ume4bY1t6
	AUuyUjkuZVG3tEODDGmTzodDqUSo1FEugAwdWckeSM6gzojnI1pbTgJWLiu1Yn1MVE50o0XcYvl
	knpzybsuw//1j5R+HRUOhrkqLGa2UHR+qa5wEA8t8JXLYDjp9eYsNZ8EomGo/UTpO34vWGznQ+m
X-Received: by 2002:a17:90b:4c08:b0:37f:9cdf:f03d with SMTP id 98e67ed59e1d1-38dc7b96c48mr13154742a91.32.1784072337915;
        Tue, 14 Jul 2026 16:38:57 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118389d9bcsm72317509eec.20.2026.07.14.16.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 16:38:57 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/3] dma: fsl_raid: fix sparse warnings and simplify probing
Date: Tue, 14 Jul 2026 16:38:52 -0700
Message-ID: <20260714233855.870797-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-12525-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 74A317597A5

This series cleans up the fsl_raid driver to address issues reported by
sparse and to simplify its MMIO handling.

Patch 1 fixes the endianness of in-memory descriptor stores. The
descriptor structs are handed to the device as big-endian, but the driver
stored CPU-endian values directly, which is both incorrect and flagged by
sparse as a base-type mismatch. The stores are wrapped in cpu_to_be32()
and the final-frame bit is now passed as an argument rather than
read-modify-written.

Patch 2 keeps the MMIO bases (re_regs and jrregs) as void __iomem *
instead of typed register struct pointers, eliminating "different address
spaces" sparse warnings on every register access. Each accessor derives a
local __iomem-qualified typed pointer.

Patch 3 replaces the open-coded platform_get_resource() +
devm_ioremap() sequence with devm_platform_ioremap_resource().

Rosen Penev (3):
  dma: fsl_raid: fix endianness of in-memory descriptor stores
  dma: fsl_raid: keep MMIO bases as void __iomem and cast at access
  dma: fsl_raid: use devm_platform_ioremap_resource

 drivers/dma/fsl_raid.c | 109 ++++++++++++++++++++---------------------
 drivers/dma/fsl_raid.h |   4 +-
 2 files changed, 54 insertions(+), 59 deletions(-)

-- 
2.55.0


