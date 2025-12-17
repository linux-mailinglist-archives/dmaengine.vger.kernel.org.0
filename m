Return-Path: <dmaengine+bounces-7749-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D5CCC8164
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 15:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AAC573007B46
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 14:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F9F37831D;
	Wed, 17 Dec 2025 13:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="PSdkWlVh"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EC7230BD9
	for <dmaengine@vger.kernel.org>; Wed, 17 Dec 2025 13:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979551; cv=none; b=RbgMbBrePExzwxaJlCWyt9Ia8filF5Wzax7sH8zffeGhYrW35Tmae8NbwWnwD387SwzRYZhBfvM6tH+SGIlvHRRJhuqvu1UIgtjTp015M0UN2dGcqCX3tf/urgdQ4mfFSnEu7jDJFsGLlkUu3UwIgQrKaQAqU1dD06EbyPskeB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979551; c=relaxed/simple;
	bh=pwXBE6nXIPhLXqWiJsXmXE5doaQ5fCUQPNT6gkqWtrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K9Vh4bFbBFhhkXBNmoSQp0HU3p79G6nV4wC9El8MKmk7qZm3Z0+zieDcmpcf35hHUjYXl3QmYZPsrYi71Qch7P2FJgFX30+Sogn9svqbZKDIkcegsv+j2ih134aJeUkTqouNU3uDVcBoCEYUJlj8Q7d49m1NhGYqRsICl2RLYBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=PSdkWlVh; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47796a837c7so42607365e9.0
        for <dmaengine@vger.kernel.org>; Wed, 17 Dec 2025 05:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1765979545; x=1766584345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HBodynF7SrNXks4H2GWi7XhN1JOLIeDFQT2O54uJxt0=;
        b=PSdkWlVhWonIgS75A9FBckFemM6RGJRIJuIZrsFb9ru+flOErfhs1afIZyti0YSGem
         ytypC1UU7hxWpYjnKz5aboGSDzaV6lX24p2WAGwCZPLQzB2FpymO0mRWFChO7mtO5Sja
         3iysK36cpMrLXKFiSAZ7uM1S/MJTHp6bjMjVQ+XMngrO8PzZLIJTzeotI57sJ67INk/R
         gmRpxpQo3b0BZ9unwL+sbyFHJME3B6wQyiR5VeKV4+C8WhAfjVIQpmHnPwSNgH+WJZzc
         /aHCznIU/OhxgxvlBMeMJWY8VAl4gIIcak1XgbraeXxj6WQsKzWvsO9yx6f5BgSumGW5
         39BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765979545; x=1766584345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBodynF7SrNXks4H2GWi7XhN1JOLIeDFQT2O54uJxt0=;
        b=qljLv7aQzLmatb8HDkU8Hv0/ZWo/3bkOOOa34mgox1sRHKDarBnRA+9AovAGvOIYgW
         CqjEqLm1kDnudr2DLTL0N1/wANH7fbOdASQKc4YuGCDHB0zZCLosNRiQK/4EN48lyCRU
         TUKgxnE2CgsZSyo2eKNU5o808iHa5sOKtG6Le3hD6L3padSxLw2l4Yk0Sa8asFRc3jPx
         zIXx67Wtm7GTUMjBNVc4oWpbwTxiNtqahcvTY6OvFQmvrYgE4F/1K6EImWrXqtMaDOOO
         QblK49i9UkbGbkv/UqN1qk1R/wQCHtyXmKjPQYUFsYlQZmgVQdEoGt0nSfSYHXRoRpi+
         iegg==
X-Forwarded-Encrypted: i=1; AJvYcCXdGyFvGjiR9tjgD7NZQGLx+pDHy4l3WhZ9Uy5gZr6NQmUIBIznxk9AhP/6lhv7QYzZzhmCAM5MRPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0QOqES4ia0+nhNV2FrrDR48czo+uajP1UxeRDjMuM+N7xccrP
	5lXS94a2wPLfWJpOFDnDyTrcM4uSTlsa+8XrwBun/m/HxXPJabBm9pOjA70jc4Ded4g=
X-Gm-Gg: AY/fxX4JezMKLz5QeLfZsh2sq903MFE1hWCbdOZoC8QmR3fd8w7a2Xgs84JSWchZg2w
	07yRXe8k+6EIohYjZa1Wv2PNDP+4w/aDe9CtWrcNGJB4hS0tfUBK9OScaXNulXaG6H0RDPshTvh
	36oFe4MIK8w4uskWK1i5vbdIw3ez8Caw4V6lULGoP7phAcXPqVvLihdtkeD5RULBqlzB7A/iDh1
	SQA4v6qWGY9A3rVpVqB6MBZXw/V4+6uUtohw0aKGyniyfBKd6Uyr4T1lndOgJ8Ea4CnOUSn/1Fw
	/KgXgnm9BEHkjfdUuZK+yO9gwUW1wuB/vAEEGmLvMVBWQdook69hmJuMTVJ2lY+ueJAguJeYSvB
	54bZPKw3jDXjxN12G/SNHD6V4MMv6lpGlcGcxKMpxxeXZOl0Pva5gHc80WTcRmvvr2BzYQYiiIb
	w0IX/xzn022/qWQnTQXms2tzUQoIbIfOgDwNwzxmdw
X-Google-Smtp-Source: AGHT+IFWUB9/ub8J/4zlBS37nn0rWNyxAo4tGYMQy9tEpqVv/pZQq+c686VLWl0YwlnI82ltMdplxg==
X-Received: by 2002:a05:600c:46cb:b0:47a:810f:1d06 with SMTP id 5b1f17b1804b1-47a8f89cb47mr194004325e9.4.1765979545347;
        Wed, 17 Dec 2025 05:52:25 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310adf701csm4508000f8f.42.2025.12.17.05.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 05:52:24 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	fabrizio.castro.jz@renesas.com,
	biju.das.jz@bp.renesas.com,
	geert+renesas@glider.be,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v5 0/6] dmaengine: sh: rz-dmac: Add tx_status and pause/resume support
Date: Wed, 17 Dec 2025 15:52:07 +0200
Message-ID: <20251217135213.400280-1-claudiu.beznea.uj@bp.renesas.com>
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
Along with it were added fixes identified while working on the above
mentioned enhancements.

Previous versions were addressed by Biju. The previous versions were
posted here:

v4: https://lore.kernel.org/all/20240628151728.84470-1-biju.das.jz@bp.renesas.com/
v3: https://lore.kernel.org/all/20230412152445.117439-1-biju.das.jz@bp.renesas.com/
v2: https://lore.kernel.org/all/20230405140842.201883-1-biju.das.jz@bp.renesas.com/
v1: https://lore.kernel.org/all/20230324094957.115071-1-biju.das.jz@bp.renesas.com/

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

Claudiu Beznea (4):
  dmaengine: sh: rz-dmac: Protect the driver specific lists
  dmaengine: sh: rz-dmac: Move all CHCTRL updates under spinlock
  dmaengine: sh: rz-dmac: Drop unnecessary local_irq_save() call
  dmaengine: sh: rz-dmac: Add device_{pause,resume}() callbacks

 drivers/dma/sh/rz-dmac.c | 265 ++++++++++++++++++++++++++++++++-------
 1 file changed, 222 insertions(+), 43 deletions(-)

-- 
2.43.0


