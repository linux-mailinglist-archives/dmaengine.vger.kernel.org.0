Return-Path: <dmaengine+bounces-8396-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNkLAqt1cGktYAAAu9opvQ
	(envelope-from <dmaengine+bounces-8396-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 07:43:55 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDB9523E9
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 07:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E60CB5E397B
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 13:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757EF42EED6;
	Tue, 20 Jan 2026 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="TtszEVGo"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FB042DFF7
	for <dmaengine@vger.kernel.org>; Tue, 20 Jan 2026 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768916024; cv=none; b=iFFY7rKEqDk7RdESR6xbvK6b2gInpFEqExNVI82HslOuALqcTmAW6eaZGSk4FRUtgzbAmMcPaIYZsCjWPt16PRDAbZwr1Nkbfa6FCMUs2xMkjITugijvqrY+dt6u6AP6G0yLWd3vp3dY0ddzdX3uA+vKLXxf8PueanQzkCVgiJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768916024; c=relaxed/simple;
	bh=oTjfGQT2FjM/cuHaC7IEGo1JAHptevPPzViZHO6P8ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZaOU7c25Vvue/JDdmel0bqBWO7YazHb8dRK8BA6lnzh3NuTZK+LKX43eVJtq95y7kqaPcDhUm19A5DAq0H+zi3URftGwejwX8AFdgFsHepTbNz2FNhp1zLR1k65Y5eyKuOWC9DS0Uh6LkHkU0r9qF/5bUKQ7PUggi30skd4xrjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=TtszEVGo; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4801c1ad878so42543725e9.1
        for <dmaengine@vger.kernel.org>; Tue, 20 Jan 2026 05:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768916020; x=1769520820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PWw1fTHTZFxcfrCh20jqtyvWPLjj0yv9m81mAILZSPA=;
        b=TtszEVGopXMKj3GlMuV1qCWDt60pgkPD8tYKB6jRtxr3t82DCZF4XvZpBQ9/MAcVpp
         JEq70APvQQ3bFpUHYvMBVps1JgStynk0auM31g60l0q3N6eRKqiSq2KjQubVMV6S/av2
         DCELFW7BFBcfApxE5j6l8CltZl0CddEHxN4Gu7PqgSYQd06hChpO4qnC6t2x4/nEbqqr
         SMHgpd5Ok6SBBzgJL3RSmlFl1Eb2Wq4b3kXQG6bEJcQn1PcHtbQribXh01grXVmm8gjQ
         ziWm1lo/GhCMa40FrTUC7cmCeNv929SmT2unj/TcL3NsN12823+gwE1xbAXmKEJrcGZ9
         CorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768916020; x=1769520820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWw1fTHTZFxcfrCh20jqtyvWPLjj0yv9m81mAILZSPA=;
        b=wzQp+7yRis4bAFNycOybanB+0oJCwHHfJIeBA/ZdCTzQAYJVaDm42beT6gSxJkUL0Y
         4adA6hkvTUDCnB8+njV5U1y5erVPk+n3GrE3ZlOpoOSVtmnoXKao9p+zPcmpjA6qyzee
         qVmZlfucd/XDpWHhzB8t9s+s7mxooQD5N9KUNl4fXTE03AbaZ2cHNXrtQVOkvU129i2P
         /QmnTov1yu4asbEr4Jlh5Azoy/jRCINocdav/JCIMZrvJRs3mkQPmPlK40JPFVCzarv3
         5nmKiX/zCCw8qwobkw1SGzydR0Jc5EdKU5udVi4rCivAOhN9TIPyq+x7P+OFoodIt7ec
         1snA==
X-Forwarded-Encrypted: i=1; AJvYcCUbUUQAI0VHpwCBDQfxHedMGHciaN1AuubKmODItVvvvC5tm6Cikacc3i94EceOCUB83fRheKb5HxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzKy9Qm4p54xwmJPKyQ/s+bA0EWIuPbBSs1oSpOmhh2wwhv/Sm
	GUB/ThuKxMMqLn19fdZj6jUTgub9NkSvNttgAOMe2aUdIWeVNvkaqelCT5XxOhdLpow=
X-Gm-Gg: AY/fxX5R7NbwavoZ5tOPlpR1JHmfKtcU4RuJoB23W+yTCfCE1ViTEdshxg7vFBKAPyb
	xWxEYbnYyZKHv6F1l7/uvhrFlTGawDrJOLOrvl5ZfWygeTj35DcGLLB1yM4cNfC4d9Kcpk70OnX
	t2QBtZ03zDgG03GUkg+fgZkKqAGArphIuSL65Meb8QMyK9d6/KstqvD6NW7yqaGM5PtAbDF5j8a
	UeqQsfQIXEcW2QG2srQ0HF3ysgRhz8wHMGNiHQSVFhUxY97LElORbwYWOQ0PwUsXCj7rL7rTblV
	UTOWgDwLYZu+BPYiDf1wUA5HD5+gKV2pthPOylhC4x5Ra20nnAwBLDltBOv9nEDZLBeD+EUHyu+
	zCKdBIznz4RwRnQW2FCnunwEc1rvx5ZHn2gpbvBkQc7ymZekF8X1x5EWEsFIass0sYDm5UP6g3R
	Oz7lx7q/tc8C54ZfEVAn7azywlmgtRT0LbiHwpQ467t/CnYens9w==
X-Received: by 2002:a05:600c:8217:b0:47d:5d27:2a7f with SMTP id 5b1f17b1804b1-4803e7f18eamr26048425e9.26.1768916020264;
        Tue, 20 Jan 2026 05:33:40 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356996dad0sm29331439f8f.27.2026.01.20.05.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 05:33:39 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	geert+renesas@glider.be,
	biju.das.jz@bp.renesas.com,
	fabrizio.castro.jz@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v8 0/8] dmaengine: sh: rz-dmac: Add tx_status and pause/resume support
Date: Tue, 20 Jan 2026 15:33:22 +0200
Message-ID: <20260120133330.3738850-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8396-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tuxon.dev];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bp.renesas.com:mid,tuxon.dev:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,renesas.com:email]
X-Rspamd-Queue-Id: 8EDB9523E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

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

Biju Das (2):
  dmaengine: sh: rz-dmac: Add rz_dmac_invalidate_lmdesc()
  dmaengine: sh: rz-dmac: Add device_tx_status() callback

Claudiu Beznea (6):
  dmaengine: sh: rz-dmac: Protect the driver specific lists
  dmaengine: sh: rz-dmac: Move CHCTRL updates under spinlock
  dmaengine: sh: rz-dmac: Drop read of CHCTRL register
  dmaengine: sh: rz-dmac: Drop goto instruction and label
  dmaengine: sh: rz-dmac: Drop unnecessary local_irq_save() call
  dmaengine: sh: rz-dmac: Add device_{pause,resume}() callbacks

 drivers/dma/sh/rz-dmac.c | 289 ++++++++++++++++++++++++++++++++-------
 1 file changed, 239 insertions(+), 50 deletions(-)

-- 
2.43.0


