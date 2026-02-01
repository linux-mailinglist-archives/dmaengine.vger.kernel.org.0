Return-Path: <dmaengine+bounces-8639-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DBoLbiYfmltbQIAu9opvQ
	(envelope-from <dmaengine+bounces-8639-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 01 Feb 2026 01:05:12 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9FDC46EA
	for <lists+dmaengine@lfdr.de>; Sun, 01 Feb 2026 01:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 332E03016934
	for <lists+dmaengine@lfdr.de>; Sun,  1 Feb 2026 00:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B713D6F;
	Sun,  1 Feb 2026 00:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIvYY1Co"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703493EBF22
	for <dmaengine@vger.kernel.org>; Sun,  1 Feb 2026 00:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769904307; cv=none; b=F43LxxX/516cl3bPpi3790zKqo6WvRHgsSn9/hMNKgTeVq+jNxWpOvaWn5mGuiN1EhjNIyt455vR9iGdbZyK2Zr3nxJZHppPNx84T9zIRIgwoWzd1NmxLabyQmM7UZgWaeWUedsV4tS9sOOd12EhcIkI0fVVb8PDCeqekKKjrK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769904307; c=relaxed/simple;
	bh=kuQBc36Dize+k+bhG58X3zqYcPyQWYlfN17k2PgfCCw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Spfy0mUPGx0U1jLlnRR7lipRnTM3pe1jsiK0QvGgFv+Hmw6pyAOz2JM5kUFfw9YqDkjIOn41Lhds3PR68nr/j2XISF6N8ig+XpYSR1bOOZQUVQMPLnWtGzrW9JyY/Vp69WLyK/6Z3JsuBS49izm2u1PGAXzumIv5BkSeMZukqfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIvYY1Co; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c6541e35fc0so1904695a12.3
        for <dmaengine@vger.kernel.org>; Sat, 31 Jan 2026 16:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769904306; x=1770509106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EQ0W2my/dt/8jBO8j9dDlrQdI6FtvDMxcBB4UjizeCI=;
        b=jIvYY1CoLmBWpXb+Lg+L4bREXlv/zSrev8hAx/sMyIu/mNPjjz7gjUsuuC++5GSti1
         s5DB6B8X6UifBpi/U3ggstB12wj35+5beTABbjYb6m0tbZNE2+CL77QlpH57DGNtQoiJ
         +TIcIgxSMpMCsQt6Nq8ROu6iNFvAG40CkqBfakVjVuXC2/VwtovFmy6uMz6pcy1WEd0V
         YaBeYkMYw8vf93JI7MTV46IbrKeFlrfviSYxYIV+HFfamECTixNsWAfucC/EIRtVvG8C
         00Jr3lgM1lolvikr4Wj60ssjBAblFYpNLyOhKVaPz/Ypiz7pYo6V2KnZVdGAjxJxn1qT
         SLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769904306; x=1770509106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EQ0W2my/dt/8jBO8j9dDlrQdI6FtvDMxcBB4UjizeCI=;
        b=Zi9K8kLdWDUYT84iwXHj5EBJFXPcHMYJEEVeK9nniq0NGhKOhTtIavt4o2bpQzqleU
         sOaHhgytHgL96SvKB/q6+wdyeU2utZdesHPQWNKvS/cROhVx9hLU9y7CQgMQHy9SvOK8
         QXEqGMiEW+edLMHKyY8mUkbyYODKDP2E8epeRLcieI9lHHwUzbHuSwW63ZiRlmTRtujM
         8M36b/YiE0cH+SAlACqgkuQoXd3wqexlTdkmEgrbispjZoNvezZzjJhP396wwDHdBph8
         80qN2IPOocLNtbJUMargSwNoe0JtKd9sDMO/nNSOJQDJjJqGwsjhEKv13fojyb4QZSAv
         mJFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSVbHwuDx3Sz1JfW7Lub8OZvv5jtZX9k4/Eg23QIPe/kH7esuRT+DgsT4lDhXip9qX2DGeNLCFCrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiwdBpLZn39p9yVbAF4d1Kr8Je3PmpCtook1qH6VFcJ02ZUbBK
	lSCw87HOAvsPrxkowLEILosXLfpvh70EEeDwrocFr/9yl6plaliqPQ8a
X-Gm-Gg: AZuq6aI+Oi4YLNQoB3jBN44JDUWyWov8uAF+nJBzTKFH1ZMDjTjO4h3eo7los2dbVLI
	cPJFZDmd4k4Sh75vURQlbITYmroFRyTFarc1ZFvuLBMBSn85N7jp1i15zPk8gPI3QTryAKHEBvd
	5aZGzhUvuPdhwEjnbobdiCUktLN/gKv0m6kT05DbkIgB8p1Vgr8NYCWuqSY18GsjhLsfdFi+gvf
	LswoNIFHqUKEDJdEcE5tPYpJxf74SrcTqjFYdzCsoR8PofGU1EP/GTu+ILhwO7nrpgm0s7Isr9n
	I6LiqwdvZLfWVChfU8s/Uvvsd8Om6TPWastYXyQAy2Q8pg5DAILHCK9/f4qBlFvL61XTuPEae5d
	p+CfGj3peZZ+lG5fM3KlPVzDkthO0rDQEmTopjKVOZ65/+ZBuaVZsfQlIDKDJ/JdYrwUUMtvnTm
	AeJdz2gJWg4ZxDr2J8vxUA6YjkHT5IsWRya1Q=
X-Received: by 2002:a05:6a20:c997:b0:38b:eb25:7741 with SMTP id adf61e73a8af0-392dfff52fcmr7079061637.1.1769904305774;
        Sat, 31 Jan 2026 16:05:05 -0800 (PST)
Received: from localhost.localdomain ([60.51.11.72])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a9f539dsm10295901a12.26.2026.01.31.16.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 16:05:04 -0800 (PST)
From: Khairul Anuar Romli <karom.9560@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus.Elfring@web.de,
	Khairul Anuar Romli <karom.9560@gmail.com>
Subject: [PATCH v6 0/3] dmaengine: dw-axi-dmac: Coding style cleanups
Date: Sun,  1 Feb 2026 08:04:49 +0800
Message-ID: <20260201000500.11882-1-karom.9560@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=Y
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8639-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[synopsys.com,kernel.org,vger.kernel.org,web.de,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karom9560@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[checkpatch.pl:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2C9FDC46EA
X-Rspamd-Action: no action

This series contains a single patch that fixes minor coding style issues in
the Synopsys DesignWare AXI DMA Controller platform driver. This adjustment
possibilities were detected with the help of the analysis tool
“checkpatch.pl".

The changes are purely cosmetic:
- Adjust indentation of function arguments and debug messages
- Remove an unnecessary `return;` statement
- Add a blank line for readability between functions

These updates improve code readability and maintain consistency with
kernel coding style guidelines. No functional changes are introduced.

---
Notes:
This patch series is applied on dmaengine maintainer's tree
https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/log/?h=next

Changes in v6:
	- Refine commit message on the patches.
Changes in v5:
	- Refine the commit message of each patch to mention the use of
          checkpatch.pl analysis tool for the fix.
Changes in v4:
	- Improve the description on every patch.
	- Mentioned the commit the patches addressed.
Changes in v3:
	- Split into smaller patches based on warning type
Changes in v2:
	- Rebase on top of newer merge commit
v1:
https://lore.kernel.org/all/20260104093529.40913-1-karom.9560@gmail.com/
---
Khairul Anuar Romli (3):
  dmaengine: dw-axi-dmac: fix Alignment should match open parenthesis
  dmaengine: dw-axi-dmac: Add blank line after function
  dmaengine: dw-axi-dmac: Remove not useful void return function
    statements

 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

-- 
2.43.0


