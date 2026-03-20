Return-Path: <dmaengine+bounces-9560-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFf9Cd8vvWmI7QIAu9opvQ
	(envelope-from <dmaengine+bounces-9560-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 12:30:39 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A9A2D996B
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 12:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 059DB30074D4
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 11:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFB23806CA;
	Fri, 20 Mar 2026 11:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="IehB20ga"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2058387352
	for <dmaengine@vger.kernel.org>; Fri, 20 Mar 2026 11:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774006126; cv=none; b=bNgFWIlku90Rru97FnQSVX2rQ2fwGZag0r7aFcqCu4yGDtKlu7RZajTQ9BFUPKE1pMVl66lmLf0vLHVsyyD6XRJoNMHcsZELuQ+ohzbuXJCDu6jTo7M9ClfvlTwdBODrJ+nnI0U5DL6s6VBT4LWN6KC7IWs/iUcMjz+3bMU4v1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774006126; c=relaxed/simple;
	bh=vSI4IwqxGu0eFjumdTZBx6cxeXmalzUJA2e4nqdV7cY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GMYsNBrrWtHtZHicqKw+eGsE18kArEuiKUZdVsyknYO5zYWiFnM3CBcR9RoXa0FmFD6JpM6Ahq69vfgfcmL5cL+LDGops/2hjLi6Hj1EIMagR5TDkozHqkXapJgfs1ii3x5D2eDmOIlm3LArj6wVuHzLDr+9qYOhwnaBvtxHWDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=IehB20ga; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-486fda2a389so3767965e9.1
        for <dmaengine@vger.kernel.org>; Fri, 20 Mar 2026 04:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1774006122; x=1774610922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xJs+yjFGc4wxJBOuT7ndvWzC4803vs8mZQN493sbHhM=;
        b=IehB20gaJ9sQr8Ezs9Ubb0LuV6QKdNvKllTIWULzRTJRM0cgqA3IDErWp8/6aJMkzY
         yjy/nVfOotxAAw2JUSbr3TZlWB+nwQF+JvwltkthM4qeAoylrKjNGbf/zdZ7eZhhckK/
         WXQY1uBoEnGDDpXCGzHsfAkTQL7LHJ/uMaHHlzreJhHyANi3MFTiCdDd+PheCesQvZi7
         hMBYfGiyDD24mUAxJmVmwbTAoJTg4F67afO1heI+XCcqOo0THKADZ1Aad1vRuirL1GLA
         ed2PA1cIgTuLRpNrtokLG8tEb57bgv5oTbJvik+p3qxWkWGu1p7kq1kFUR27/XCO1Tsd
         IVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774006122; x=1774610922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJs+yjFGc4wxJBOuT7ndvWzC4803vs8mZQN493sbHhM=;
        b=fWrtdyHeVLjymEd2dlrFsBqsTqqA3rGC+9btpSJ6p6XbFFq5y6vICuu8zUWH8xp5qu
         YPdfKg6he3xRHcOV2ufjoa24/iKlLk96JczJPbF9yW/KIcE1soeyP5jjpwe3XSKZhiMS
         tEqdF5gowA6s0mFQdvFdOLxmwAU8HnFy9Gq/8tCFAmu9PiwCTaxFQT5wqXse4X020aY+
         7ye8OYv2Ee/qhYiZzuoz3ES1WgfFdyRcBhcDHjz0lVhhlIcLkqitDVsFyLrlb8vB1Vd6
         AsAHqfbxlO5fH1/2BvOpV0zTzw/iCShoUphol4iAcPsQ+VM9jVJS31/MCTY+4nIDPhuB
         ayXw==
X-Forwarded-Encrypted: i=1; AJvYcCWcRJp4lwmZZ9TKXA6MQQUYVuu4p++O7wH5jtjDkIxJ2Yr86LhXPiJZ2q+CF5wd2mjFQ/Rw/wOV+QI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVK7T0+dH7rOc7hXy9ZsWQTGAojis8VpLjtxQmtjwCilQprlGd
	nTpEcHlkDrqbZ5LVzB1vpZwMRgj+6x43ppTTtMK/Y2z4bN04Eu6EZJ9y0wl0SahDUpI=
X-Gm-Gg: ATEYQzyeVfQXd5X0pnl8fqVwmDydoSnBzCPtF8lmRHi3KdX5qiYYkjrlS36CnRljkQr
	YkAij+Gl/9DTkKiusuIjxVuuDNhIEHw4SpRcSUz/reFbDdQL8GOKdbY93cSP7XSM9Ay7uVpE0gW
	MQZbLT8GfI7VttQvSB7ZNlOIrZ3C8icyhv1ANQWn7I0FLupowMeiiGS1fA8MX+o7jxB4L0/9tzO
	5a8CU/ZWE9Fk9N2rUTWJ4n62WI+KAM1dKanI9VqelJAar7r3Mb382iEVSG/lW3j3Nd/BXxZWaz8
	wqCHxrR67g3QkEizmqVVXV3tAOJF/TyiGgHjeuoxglNyYiVfH8QA0NXdFC3kxC8KjXw7YpiUD9o
	dexXGnHdGEkGc2FgACsn649JpZJmebyxgMiRWoELY1zmhEKA2B8HSArQik5pAC4oHt5mfbhjZ6A
	gDt5IeEytlxREFujhdus1wigDACHFEtWeQ50tT5hOzDlS3uMsdH6Gf
X-Received: by 2002:a05:600c:3b8c:b0:486:d76c:fa51 with SMTP id 5b1f17b1804b1-486ff03ffa5mr34883115e9.27.1774006121958;
        Fri, 20 Mar 2026 04:28:41 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe836784sm49869935e9.13.2026.03.20.04.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 04:28:41 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	Frank.Li@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	fabrizio.castro.jz@renesas.com,
	john.madieu.xa@bp.renesas.com,
	kuninori.morimoto.gx@renesas.com,
	tommaso.merciai.xr@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 0/7] Renesas: dmaengine and ASoC fixes
Date: Fri, 20 Mar 2026 13:28:31 +0200
Message-ID: <20260320112838.2200198-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tuxon.dev];
	TAGGED_FROM(0.00)[bounces-9560-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	NEURAL_HAM(-0.00)[-0.960];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 24A9A2D996B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

This series addresses issues identified in the DMA engine and RZ SSI
drivers.

As described in the patch "dmaengine: sh: rz-dmac: Set the Link End (LE)
bit on the last descriptor", stress testing on the Renesas RZ/G2L SoC
showed that starting all available DMA channels could cause the system
to stall after several hours of operation. This issue was resolved by
setting the Link End bit on the last descriptor of a DMA transfer.

However, after applying that fix, the SSI audio driver began to suffer
from frequent overruns and underruns. This was caused by the way the SSI
driver emulated cyclic DMA transfers: at the start of playback/capture
it initially enqueued 4 DMA descriptors as single SG transfers, and upon
completion of each descriptor, a new one was enqueued. Since there was
no indication to the DMA hardware where the descriptor list ended
(though the LE bit), the DMA engine continued transferring until the
audio stream was stopped. From time to time, audio signal spikes were
observed in the recorded file with this approach.

To address these issue, cyclic DMA support was added to the DMA engine
driver, and the SSI audio driver was reworked to use this support via
the generic PCM dmaengine APIs.

Due to the behavior described above, no Fixes tags were added to the
patches in this series, and all patches should be merged through the
same tree.

In case this series will be merged this release cycle, best would
be to go though the DMA tree as the DMA changes are based on the series
at [1] which was merged on March 17th. Otherwise, any of the ASoC or DMA
tree should be good.

Thank you,
Claudiu

Changes in v2:
- fixed typos in patch descriptions and patch titles
- updated "ASoC: renesas: rz-ssi: Use generic PCM dmaengine APIs"
  to fix the PIO mode
- in patch "dmaengine: sh: rz-dmac: Add suspend to RAM support"
  clear the RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED status bit for
  channel w/o RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL
- per-patch updates can be found in individual patches changelog 
- rebased on top of next-20260319
- updated the cover letter

[1] https://lore.kernel.org/all/20260316133252.240348-1-claudiu.beznea.uj@bp.renesas.com/

Claudiu Beznea (7):
  dmaengine: sh: rz-dmac: Add enable status bit
  dmaengine: sh: rz-dmac: Add pause status bit
  dmaengine: sh: rz-dmac: Drop the update of channel->chctrl with
    CHCTRL_SETEN
  dmaengine: sh: rz-dmac: Add cyclic DMA support
  dmaengine: sh: rz-dmac: Add suspend to RAM support
  ASoC: renesas: rz-ssi: Use generic PCM dmaengine APIs
  dmaengine: sh: rz-dmac: Set the Link End (LE) bit on the last
    descriptor

 drivers/dma/sh/rz-dmac.c   | 403 ++++++++++++++++++++++++++++++++++---
 sound/soc/renesas/Kconfig  |   1 +
 sound/soc/renesas/rz-ssi.c | 348 +++++++++-----------------------
 3 files changed, 470 insertions(+), 282 deletions(-)

-- 
2.43.0


