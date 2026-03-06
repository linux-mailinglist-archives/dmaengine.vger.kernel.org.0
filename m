Return-Path: <dmaengine+bounces-9297-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPXiIQHMqmlWXAEAu9opvQ
	(envelope-from <dmaengine+bounces-9297-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 13:43:45 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D16220DD1
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 13:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 27147300F129
	for <lists+dmaengine@lfdr.de>; Fri,  6 Mar 2026 12:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C71828134F;
	Fri,  6 Mar 2026 12:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ZzQFe0Qs"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BC1245019
	for <dmaengine@vger.kernel.org>; Fri,  6 Mar 2026 12:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772800901; cv=none; b=aUOIOipXGCvx2ZjAscPSAQVA7ljhD8Z8lC6FOHrj2PAao+2IJ4jqA5Yj1m0TVOe7L3vp0IDfCKeVJ4zFPpu+S0hMkpDGndqiBeUOcNh4YE8xFMJd3jTC4DyWBFpEv4QMMtM53h85leIVClZApvbVYm+sNyROmA+sNgxVgX25+ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772800901; c=relaxed/simple;
	bh=T/TzqKUztVwcVczMMW2f9Rz3hVaXHuEUuZMUyuPUlrw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TO3FdUcuMzdTpu4aWYaViUUKOK5H9xFEKon/MtJmDKz+ToxY93+XwmBSsHLP9+ss74l54SmQjOtsoB7woFYASjMaV1BB9oRHHTCSmaAAmpV1boVoaDcVW1SIZ5yWM+DakorEWdm5uClL+i9Kifp3nLYB6M/J3kfyrWXZFOdBNms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ZzQFe0Qs; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so105727325e9.1
        for <dmaengine@vger.kernel.org>; Fri, 06 Mar 2026 04:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1772800897; x=1773405697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2GyGLkPO8y8zRfKUcMFE/QOXCICKajlbCSDRUQR2YMw=;
        b=ZzQFe0QsM1uBUjmMCf8vSJ0heeKp7VE5zSgnaoypj74BVK/4AG4795LH+mDCDuvDeN
         d25I/WQXCOdV3xr6NNyoxaJXgxa3gnhNCXL6bL6fX23jgS2WYPfitr7vho4UOkUqZSSn
         pNUqxEjDqH6Lz3A/UAtogkYYKgSc4cbkkYy6unh3n9xzpdcDYJxIJLuQEOQAIcF9jsFq
         B9Ya4ZXHr1slbBl3PPi9x8AhKI7ZCN/SeWZbx1EDF8jN+V77vXCQMKI0XIaqsPiECQtu
         76JKK6Cjc1iyXg5GENi0cW8mkLNNaoSxYsKQbM8xm5JfGRRNgJW+mPAFmpwk+jBLzFc3
         vtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772800897; x=1773405697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GyGLkPO8y8zRfKUcMFE/QOXCICKajlbCSDRUQR2YMw=;
        b=lNrr2ba24NuoaiBwVohHI37w0rS53/iDDQMjgO3TRwNuH2kQLTJBOZ8vZQAM1WE+cN
         RmK35C4iTeg1SoOLoF0FO89ggdLoJpKAYUw90KAH5km9jAXIgE7XXqbVRJt+Tfr5N/xS
         06QkBwSLFroIWPINgbO2DdnqxCezxrbHvFbfqeBPGo6pbxXPZluEqbCRgM2AFf5UuMiA
         lA0IjJPKLbLvoeQEdO/LwaumV10QZvt06RM8M1Zlx6AsCl3bU/otpGCYpTh2ddptKZSg
         ky/3qPBCfJIooEXsurDJN7UM9rxBQ/z1d6NjmnlM4ACADpTwoRcx6yW/Q5hAUl96KjII
         ZO4w==
X-Forwarded-Encrypted: i=1; AJvYcCVsyMZuJEydAJ5VX0Pdl/KqgB+KB2o46PH03LwP7jUfTdZtGa2NbGzZQMtgZwDE4lOS5UHG+mJnh00=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjo1iXX3+v5Lh+A4/tZ4srQhBgpzHRYe4qDgtV7iHHpmccllqv
	4gP6zS+ah9RUPtpxdv+6Z28XppMyucht7Gi/0tTvzi/L/djR+VQIwwmdG5//Mpw7cis=
X-Gm-Gg: ATEYQzzTiFwv39n3oxYQ9NraHiNvi3ynFggiwPc7N2cFfErvqJuDuo6M03kbIhfSsfh
	A0YxYG0KG6xyhSJy2e4JSLge+JuHiViYgYv4CckZ9egs94tPnyCE+FAhRX+jvX6wKAfQ9R5MXm9
	/2zLNSMLoI7NqgtY3uC42goSzvAe/drs3Uq8gK8Q5BWLzJwLq5TI/ecrRFth5wBJmjXUspeVPLp
	lFm6n80qRqELxe8cXhNp6q8kw2B3Q8OM1VQOrB6YMZvMUIMBas12MguT01uedxNQnSKAY4YuzNh
	Vf1d3inYEXmBKfZW7HEbDHmdTGeoVtqlgsXL2oSnb+nLAi3i+uUGKAFbN9sVeAB5iCPDmmMLU4n
	gHdUYycDmIUM4QY9FwvKybUoy0FHmkBXhYN4wTaI9m6pECj5ok/Xb9O52pbp+3GcMy2YYKtBFvX
	kJ/vLB6DzfrG6/tVhKrlhg4FrZxSeAyXbnwl1MRfEdZjLpa7tNUfjB
X-Received: by 2002:a05:600c:a013:b0:485:17a7:b9cc with SMTP id 5b1f17b1804b1-48526958835mr29611825e9.18.1772800896658;
        Fri, 06 Mar 2026 04:41:36 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485276b0c38sm38150505e9.9.2026.03.06.04.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:41:36 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	Frank.Li@kernel.org,
	biju.das.jz@bp.renesas.com,
	geert+renesas@glider.be,
	fabrizio.castro.jz@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v9 0/8] dmaengine: sh: rz-dmac: Add tx_status and pause/resume support
Date: Fri,  6 Mar 2026 14:41:25 +0200
Message-ID: <20260306124133.2304687-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 13D16220DD1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9297-lists,dmaengine=lfdr.de];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,tuxon.dev:dkim]
X-Rspamd-Action: no action

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

 drivers/dma/sh/rz-dmac.c | 288 ++++++++++++++++++++++++++++++++-------
 1 file changed, 238 insertions(+), 50 deletions(-)

-- 
2.43.0


