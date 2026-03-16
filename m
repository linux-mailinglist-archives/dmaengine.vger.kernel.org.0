Return-Path: <dmaengine+bounces-9430-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0B5SCjAIuGkWYQEAu9opvQ
	(envelope-from <dmaengine+bounces-9430-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 14:40:00 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C4629A98B
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 14:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DFC33030B1E
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 13:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83DC399358;
	Mon, 16 Mar 2026 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Gl610XXE"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9973976B3
	for <dmaengine@vger.kernel.org>; Mon, 16 Mar 2026 13:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773667985; cv=none; b=XXF+iVo75s5S87ZLco76dCKHDGZwXvjZ5fisxXRYpsaJzgg4U9+TtVCnonMYhsOUfzHZxM4cUlcYVMwGloEMSNKzFugThDhYpNj9uuKeKXTn/XEiplFrAUM5WhbvANj8K/gnxNkHDjx7QjJOgfkOG19caXU+aPlkO9ZA/R2nRVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773667985; c=relaxed/simple;
	bh=5y/EAb032AMPdcOu4ynOYBjpIW7z7sKn43dms4BhIzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pBJ5mwnytuBYuviya2Wx+o12kjLA2jRUMCpodkRsFGAGsRosy3hzq1gUnhl0PRewy4/IS4mvcgFX6jHV0UqDbSmVMiTjqH6iGMtaIp213bFDpIA7tJpEZsGBT6/iYdN/F3W62ir7ByhoDA5hP+ZfkG+OXpUj5wd2a4bXtG/BtWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Gl610XXE; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b941762394aso565692166b.1
        for <dmaengine@vger.kernel.org>; Mon, 16 Mar 2026 06:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773667982; x=1774272782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xcNojtWEZMAv4eQbKBUIo67pydMoo7pfLvHPfp9OEOQ=;
        b=Gl610XXEyYKh7vCeSqO3D5DbUvhPpjdUWk4mZtMGz+vAH4IOapez8N4EWURdIrp4EW
         xMk51RcyLN5aV7913UsXHrPEeeMRChWL2SleEOJSPQiCd/fGLFt7A5bBSHqvElZO4CWI
         ab+dbBLaqlW9G5hs/QYF1tbS8Ka1X+a/vsN74GF6L3vYyq4zcLX9fYaoPJB5DmDuLOIx
         wIVW8IWYKEJm5WnNhPnNnlqpBHxkU7+NkQbDQnwJvD/+eVzkV4jPWfwr10SWvIaqpJ9Z
         DzY5kibB006AjG7L4wZ63hBjAXBbqiEB/RPkgSDP84Fwvp0X3TCOZtueXJwYy+fCg+N9
         u3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773667982; x=1774272782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcNojtWEZMAv4eQbKBUIo67pydMoo7pfLvHPfp9OEOQ=;
        b=I8DPTfISjGt3qfKprAttC+PQbm5+jff41vD9++GhJILfKqg3O4gSYMjzbJf/aqU4j2
         vYRd0wVPaz7+N/KoED4vXbjlZesfWbxlLsqfubgWf+qJlNdnwJZVqOET1pyHuXjV4s3D
         nXtmMkeJPQAEEhM1zp8ZwhuHAuov4zsSdgNEFW6VQQAD4FU5XEcBEaoWVsWfKmJJCgVK
         vPwn0opku2/BgeqENK/g0UZ0ryLGuwgr48AYuYEmwPhUaErxY9GZG8uvuQsafhGII54R
         Fp5/wlRfXSBA8SBT58Tyanu5oL+xkL/oez7M+wthgUWdRkzp5Ea8J0MIyBvKrVaFE3L6
         Ds/g==
X-Forwarded-Encrypted: i=1; AJvYcCWdXM6TEbRWRtGVnVKHRFxtDas4pJQh7PRMhoNZe6HucNjjf6lZOE40SLO3BaYTUzRACClYy4xXKV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4EeSdfY0MdH153UOOxaXrSDmTovhKfaRKqA+B8QNSqbVZOg3z
	xcu3YyeXMzJ06np+vBVNJvT5GaFSrcXGeQAK8Moq14ZqfRcSJLOjlEoQ2CqkXyNxZwo=
X-Gm-Gg: ATEYQzzwkulaaTaA8OwtZwB/uhzrIM8sdpTr6RfxazvUklzI68wjieYKUXPB2jfxdLW
	3qVp0ys0sycUGAmYUHjyRdLGcJiUICr1GKFZCwexEkH0yrBkWXrjJrUBz2JKHi2/2Spi598N/7c
	qiPJSrml6QWP8IFEZXJP5G2BZB+u1MY2MuRbmUFewxYkejHr5qloNe1dSVO0D77xEmgFtnQ4Rql
	IbEJRGXFtz6gzd/ijETBrFziQTkJpyzM4xqlNhywQEXm/sVjWiu6ElovLMyrzr92JW1X+6vpQzN
	PSnGPDAQ5ThtElZimGlqDql5x/g+CGdoP4vGQ7I/NLErN0UdjsjpZ9WE6irxu56phGoTsfacfCu
	vfFfxOVnCtwo+uFWxKfNuHvM8yKkFZWBmzEgelgc+LqChQzF8vZLDer07Q/AvUnztfvjL6+eNFC
	DsASw1Qw05OUZKYCrNBX8RBaDxmRJrmNRRaiV4QKz2sKG19xTEoMqbXv8E0kWS4sg24yHRqhUWq
	xdD6bI=
X-Received: by 2002:a17:907:a0c9:b0:b8f:b32e:e196 with SMTP id a640c23a62f3a-b9765141719mr785588566b.30.1773667982234;
        Mon, 16 Mar 2026 06:33:02 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6208:0:c5e3:3624:ad1c:6b4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b419270efsm11629888f8f.16.2026.03.16.06.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 06:33:01 -0700 (PDT)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	Frank.Li@kernel.org,
	geert+renesas@glider.be,
	biju.das.jz@bp.renesas.com,
	john.madieu.xa@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v10 0/8] dmaengine: sh: rz-dmac: Add tx_status and pause/resume support
Date: Mon, 16 Mar 2026 15:32:44 +0200
Message-ID: <20260316133252.240348-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	TAGGED_FROM(0.00)[bounces-9430-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A2C4629A98B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Series adds tx_status and pause/resume support for the rz-dmac driver.
Along with it were added fixes and improvements identified while working
on the above mentioned enhancements.

Previous versions were addressed by Biju. The previous versions were
posted here:

v4: https://lore.kernel.org/all/20240628151728.84470-1-biju.das.jz@bp.renesas.com/
v3: https://lore.kernel.org/all/20230412152445.117439-1-biju.das.jz@bp.renesas.com/
v2: https://lore.kernel.org/all/20230405140842.201883-1-biju.das.jz@bp.renesas.com/
v1: https://lore.kernel.org/all/20230324094957.115071-1-biju.das.jz@bp.renesas.com/

Changes in v10:
- dropped patch "dmaengine: sh: rz-dmac: Add rz_dmac_invalidate_lmdesc()"
  and use the already available rz_lmdesc_setup() function as suggested
  by John internally
- rebased on top of latest next

Changes in v9:
- collected tags
- in patch 7/8 droppped contributions from the SoB list, used
  Co-developed-by tag, and added Long Luu as well; also used
  ctra as member of rz_dmac_calculate_residue_bytes_in_vd() to
  avoid re-reading it again in rz_dmac_calculate_residue_bytes_in_vd()
- adjusted the patch description for patches 7/8, 8/8

Changes in v8:
- rebased on top of https://lore.kernel.org/all/20260105114445.878262-1-cosmin-gabriel.tanislav.xa@renesas.com/
- populated engine->residue_granularity in patch 7/8
- report proper residue in case the channel is paused in patch 8/8

Changes in v7:
- adjusted the pause/resume support
- collected tags

Changes in v6:
- added patches:
-- dmaengine: sh: rz-dmac: Drop read of CHCTRL register
-- dmaengine: sh: rz-dmac: Drop goto instruction and label
- use vc lock in IRQ handler only for the error path
- fixed typos
- adjusted patch
  "dmaengine: sh: rz-dmac: Add device_{pause,resume}() callbacks"

Changes in v5:
- added patches
-- dmaengine: sh: rz-dmac: Add rz_dmac_invalidate_lmdesc()
-- dmaengine: sh: rz-dmac: Protect the driver specific lists
-- dmaengine: sh: rz-dmac: Move all CHCTRL updates under spinlock
-- dmaengine: sh: rz-dmac: Drop unnecessary local_irq_save() call
-- dmaengine: sh: rz-dmac: Add device_{pause,resume}() callbacks
-- dmaengine: sh: rz-dmac: Add rz_dmac_invalidate_lmdesc()
- for pause/resume used the DMA controller support to pause/resume
  transfers compared with previous versions
- adjusted patches:
-- dmaengine: sh: rz-dmac: Add device_tx_status() callback

Thank you,
Claudiu

Biju Das (1):
  dmaengine: sh: rz-dmac: Add device_tx_status() callback

Claudiu Beznea (6):
  dmaengine: sh: rz-dmac: Protect the driver specific lists
  dmaengine: sh: rz-dmac: Move CHCTRL updates under spinlock
  dmaengine: sh: rz-dmac: Drop read of CHCTRL register
  dmaengine: sh: rz-dmac: Drop goto instruction and label
  dmaengine: sh: rz-dmac: Drop unnecessary local_irq_save() call
  dmaengine: sh: rz-dmac: Add device_{pause,resume}() callbacks

John Madieu (1):
  dmaengine: sh: rz-dmac: Use rz_lmdesc_setup() to invalidate
    descriptors

 drivers/dma/sh/rz-dmac.c | 281 ++++++++++++++++++++++++++++++++-------
 1 file changed, 231 insertions(+), 50 deletions(-)

-- 
2.43.0


