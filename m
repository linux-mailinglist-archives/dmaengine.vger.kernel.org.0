Return-Path: <dmaengine+bounces-8106-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BED97D02323
	for <lists+dmaengine@lfdr.de>; Thu, 08 Jan 2026 11:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BF0030BB656
	for <lists+dmaengine@lfdr.de>; Thu,  8 Jan 2026 10:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5684BB0B7;
	Thu,  8 Jan 2026 10:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="YALbVOd1"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1394B9E76
	for <dmaengine@vger.kernel.org>; Thu,  8 Jan 2026 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767868591; cv=none; b=hwmRfN7F3CY5tBfH3nhi7bqzILTK42POionwE1F4VYJctVyVDcazFPBiLUs6n1kh8RNhgB2F7jg2jdHo3t3GO36BN9UZ5ub8MfgRiSUEv0Cybk6T3akQoN7mvQIHsW5jCPvLn8vdoapNKrsj69gKMm79ilhoW2idLKJDnkYWwPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767868591; c=relaxed/simple;
	bh=wnK7QZWEdjbRSd+ckGKjMNtsLt/n6eI8Vz+g54tbC+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sr/eDfoStk/nnCK4YiOCBHOqH6GDvw8zhEHB9N3BH2DLBmKo0E1/HonMUdQEbRf+9kuBgx5v0WBvfLjFT8YJWC8w2dsWv4ardip2q9VNlMqAzSP8yW0IWQi3cIyDq2A243ONqSruocGzTf5gLIZDnQskNEphHIj/hP3GdKFGYdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=YALbVOd1; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-4327555464cso1705201f8f.1
        for <dmaengine@vger.kernel.org>; Thu, 08 Jan 2026 02:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1767868582; x=1768473382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iW0aR/BFqnFRZ5JzecJqpzmhmWQzbJ3SDfxxLqkiE2g=;
        b=YALbVOd198I0/KrzhrrQmGbnf9lsbg0stnLZQSS0bfFRr4vL6SwUe2YndHnxYxlXOJ
         DaX92mk1mCqhjx/yW9boiHoC3j3JzIrKp2kowIdagyMaWgnw5g/RP//XChZUaLD2nXIj
         JVpdz6KQMIX84deDxw14SSGdMId8XM8lrtBEZ7ijeEZghyg/WIcPPfqAWAifJlIVYeJT
         8BbwWaLxIZ+hRWu3jcjHeZ8b7B+dEp0sQv3FS7nmycJ9MWnVTsD72cy6aRkm6T0uHT8I
         2rQGRlBmWxhFg5szQ3YkcZRHh4Szsb2kOolqJPShPsJRtGLVup1ps/PNOyH8rW+pGnDZ
         Gbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767868582; x=1768473382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iW0aR/BFqnFRZ5JzecJqpzmhmWQzbJ3SDfxxLqkiE2g=;
        b=X0gVgWzPPx8ujZNXxP1sfrD2IgYE+mV327X2cTwL232sCpRQz0b3i53pBoVoIKOWWW
         8aiAdHtg7mmfF89bBxt/JvjgtxEf195wpaPfIfM43cLF2evcRWdA43UFN4nFg6adZEo2
         E0EdwvMesRXlVi8o2M4zcGeORbT6Eveq/T1xPVanFcQNz673f1GJeP03j1YaUA83PAIK
         5CaI6LmeUp14nmc0sfJcUdzXwPTHMuirl49NVEdOD3jWRtDWCfk0TixHEkma2KOX5eCL
         eqwujJmTeU6xNDXrxjD6omXDtWiKlddQx57auldQU5z6GPd2en2yqIl8mR2QUBS06WmD
         NBLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTJgHEuD+NnbhVpKw+63FlnaOXSDHski1s6bEFHZPwcktKK1R5LP6XtiV6q/uWy+qXTORn1k7K8Ow=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN/ES4kpj4UZtyQf2HAyqL+mFyL0UXalTgvHonSF2A0dQJvdUw
	bWbzu9pLwfMzXPQ8HCnjXdJbq2SetWFiLok1U3mFUkVuKV68fHPZdXi/sZmVGOXBYZA=
X-Gm-Gg: AY/fxX60pmJqT3mGptCF+/2nsqD0qAvnyWAmB/ZrqM4m6+h7W6n7jlk7FxAxsB+xiv8
	I09VNBUvDyYkEIqeX7I1xt2IFT4QvVqGSe7gh4NCzBiAEB0P2e/MYRAt9m/A2nui3tvautSP2Pp
	fIPrzcRqgQ98WG08T8Tq4zx9994yM64fe1QDO7qsLqI70n1eDg6fR3soxft6cvw2KQNihGCKjmD
	W6zjtL8q0F7rcE6Pe9JitZasRbX5WB/zBq6mmer+dMk+O7t3IIGqWNa43eJEXiPL+n6CTZFx8by
	k1dcB9UV3vPQZVqeTEb2ppUeKnDlPSg/NjDupYWxoPb5OO/9D/KwlD5WeMUot7glb6ScnWfooJk
	Kk+H3kLQq2v+3gkHP7gOZPVjpAKi9WML4koZUnUaw4ll5qxD29j/vN60vxusVSWeumeBcDKrz00
	cBDvUrsDjw5HV3ksRFtAMje8uuyTY+xIxC3MMkny0=
X-Google-Smtp-Source: AGHT+IEw4qrDEXmjZPid0SAgx92vHxoeKBWnaNYmuWTONQxS178/XrjYlMowupgNc3euDV/He7jZeg==
X-Received: by 2002:a05:6000:18a6:b0:431:2b2:9629 with SMTP id ffacd0b85a97d-432c37a6c08mr6750050f8f.51.1767868582443;
        Thu, 08 Jan 2026 02:36:22 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee243sm15399033f8f.31.2026.01.08.02.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 02:36:22 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	fabrizio.castro.jz@renesas.com,
	geert+renesas@glider.be,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	biju.das.jz@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/8] dmaengine: sh: rz-dmac: Add tx_status and pause/resume support
Date: Thu,  8 Jan 2026 12:36:12 +0200
Message-ID: <20260108103620.3482147-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

 drivers/dma/sh/rz-dmac.c | 281 ++++++++++++++++++++++++++++++++-------
 1 file changed, 231 insertions(+), 50 deletions(-)

-- 
2.43.0


