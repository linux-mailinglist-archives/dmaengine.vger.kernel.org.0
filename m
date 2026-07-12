Return-Path: <dmaengine+bounces-12356-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fafqOY0OVGr2hQMAu9opvQ
	(envelope-from <dmaengine+bounces-12356-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 00:00:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F72746167
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 00:00:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cFITpBrN;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12356-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12356-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C2CEC3002315
	for <lists+dmaengine@lfdr.de>; Sun, 12 Jul 2026 22:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4656836604C;
	Sun, 12 Jul 2026 22:00:43 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108A6449985
	for <dmaengine@vger.kernel.org>; Sun, 12 Jul 2026 22:00:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783893643; cv=none; b=OaRVuds0OZV6bChswY5iRoFrDK2QH1IO9pJQzsx3hA3awy88Gv92Ce+F0jYwOrhmtqLkLnv985XvEQiK1ZkyjFZ+yE07XX2HVM1uFfiZhKli12ko0hcLLndbM2zRFXJhzFKUk3hX2IQVqUOcwyZVNUTEh84K5yoAlRRBgGHfnJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783893643; c=relaxed/simple;
	bh=rSZSRyjlEY0I56GUB2ttg+LeJKLDJz1BOhO4bU2aDco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N0lxioO4FhCHFk6nEvuxORscnYUKbWHgD0+JnKg0OoXvkzUu6DjgjmMNh7KkPFBeRBIDmtev9Vy668nJlqV7JX3bDt8L7QUhG/yZYUK7jUsxdX7mObonvf4eEeHchCjH/NDpkOdeDk4uOG6kPZe5/K/soXKY8KNJm2IhZ2877hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFITpBrN; arc=none smtp.client-ip=209.85.215.171
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-ca7c1176317so1807624a12.1
        for <dmaengine@vger.kernel.org>; Sun, 12 Jul 2026 15:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783893641; x=1784498441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1ROlD6mdfN7+CvBywkSTjOBx4JT6mtPJE0JLh+dzz94=;
        b=cFITpBrN4oqt6wS+Z+aSoLPbPhWqczp+7BGmI12uxmm4pR+RanpI2AIUVfzsjwGqX0
         Ygj931IVx7AgL2EK5Yx0wt0dcjvTl6ZseZHRJ+NyHoRkvpSJaAIWntMexjc72yMZOIaJ
         6WzC0nb3d7q3bS18+Hb143dB6Xd1rxPYTeB/oigGVPzYFTjdCPwx2OUnO5BGJfMsP9Y5
         OjuBalcRg++/oSUu0zwo07GSaronX6RLfear5YO6Lyko7MK76z3ofFSKakN2uGlAbi0O
         OJwfm9il7CN44w307rHFq4XEYQu6QbCnluJWVgbowb0kAlr+lvtUN/BdVsfASOHYFGO8
         9vvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783893641; x=1784498441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1ROlD6mdfN7+CvBywkSTjOBx4JT6mtPJE0JLh+dzz94=;
        b=gGdB0h/9oVPEIR+vcOlt7ydtrU5x9X/kCLTsowTw/jTI6EEqWK4FhVNm3yuDGICO/j
         UTqI0Q449G9qDCa8pjntVbLOi6duZmkSFWKidUfslXZ5ujExsYlvs7TGtU3E9h4x8HJo
         K4VgeZArgne91b96SL45ZUIKkYUAUDnLqIf+jkjiJblDoRib1G1GbGNgWUNYBXIGTRpK
         +IBJVGWIgb8mUQ0wyvjBFMHM/M/U4Pc0UJRRtgSJsu+2oNeqzDJurfatkiO56Dg6Wg9i
         3HqclzdPYfoTY52Oxb4YHi7hi2ET0ZojmrzQwIYRe6Cq6LW6xMrIlD/dZvdZhey2+Y0e
         WfSw==
X-Gm-Message-State: AOJu0YxlkGxa5qGwCLvcegwL0xM4bLdV8VQlw5ypf8P5JlzpnmE+KFWy
	MKrm5A4aOAPQNbfR2EtTRI6aR/gRz6YrVPFDUu0aR9UQPkxGE2/ynaILRknqgQ==
X-Gm-Gg: AfdE7cl1XHXuUO9HZx4IYPIriALqtll+/+gFvkrmp67CLky9R7IAaSEYfWb7wPTp9Sp
	CssF5/SRFKH4Ysz5AZ4QXiYbUiiGzf3b4KujzNcY4pnFVYkcX5V8hv8+Wxz2I9qu+gQaSqOeuiY
	xkX+koHoD07ia8tNzl6P/4YLdBml76z2qS7Cvuwgt6AamdOr1rINeXOw7Gdx1fAJDF1UDLJzGGT
	r0ow7iS7Qg8UosJUhXc0ClgDD727Fi9BlmD7LEC/5VHZ5Aw9Ql7khAcHs9TM0tjciymo1MIiRoz
	B2UlKLvtp4D7zSZJ/cuN6X4IGhRKBdiwVBNq0LlmJdWTR1fq/NKkSPU8c9H667meSNXGsLhipow
	08QlAGSXstbzKxhjWPMl1e1TqMq/qiMtwnQG3ecwTSDB97ShQ5OGJMNK5AFgMv38duhM+27p+g2
	J8NueTRXqRCNPEs2r6pmJ/MnHMGQX6AXO2Ae5TYfRS0JPyAjDnSavZblOAeaEq/pVJdyGSEDWEB
	Rf7HQjjXyy1yknL4waxolqRHx7lknlX4MmhUzjNJ2Bid6woSU+1kZ4e1NvGjeSoDQ==
X-Received: by 2002:a05:6a21:7483:b0:3bf:a0e5:99a1 with SMTP id adf61e73a8af0-3c110a1a59dmr7803427637.51.1783893641417;
        Sun, 12 Jul 2026 15:00:41 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313cb804197sm14856305eec.13.2026.07.12.15.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 15:00:40 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCHv2 0/2] dmaengine: idma64: descriptor allocation and length limit fixes
Date: Sun, 12 Jul 2026 15:00:37 -0700
Message-ID: <20260712220039.924958-1-rosenp@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12356-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:andriy.shevchenko@linux.intel.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:kees@kernel.org,m:gustavoars@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 74F72746167

This small series cleans up the idma64 descriptor allocation and fixes a
long-standing truncation bug in idma64_prep_slave_sg().

Patch 1 replaces the open-coded two-stage allocation in
idma64_alloc_desc() with kzalloc_flex() using a flexible array member
for the hardware descriptor list, annotated with __counted_by for extra
runtime bounds checking. The now-redundant helper is removed.

Patch 2 addresses the hardware limit. The iDMA 64-bit CTL_HI BLOCK_TS
field is only 17 bits (IDMA64C_CTLH_BLOCK_TS_MASK = 0x1ffff), so when a
scatterlist entry exceeds that size the driver would silently truncate
the transfer length. Use sg_nents_for_dma() to size the descriptor ring
after splitting oversized entries, and iterate the new per-chunk loop so
each hardware descriptor stays within the field.

Rosen Penev (2):

Rosen Penev (2):
  dmaengine: idma64: use kzalloc_flex
  dmaengine: idma64: use sg_nents_for_dma to respect hardware descriptor
    length limit

v2: add second patch

 drivers/dma/idma64.c | 70 ++++++++++++++++++++------------------------
 drivers/dma/idma64.h |  7 +++--
 2 files changed, 36 insertions(+), 41 deletions(-)

Changes since v1:
- (fill in changes here)

-- 
2.55.0


