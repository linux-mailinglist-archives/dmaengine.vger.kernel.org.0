Return-Path: <dmaengine+bounces-9905-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yB4PBTQK1WnMzgcAu9opvQ
	(envelope-from <dmaengine+bounces-9905-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 15:44:20 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 678823AF60E
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 15:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CACCF3093365
	for <lists+dmaengine@lfdr.de>; Tue,  7 Apr 2026 13:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BC72F60CC;
	Tue,  7 Apr 2026 13:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="HWOcSSbu"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C74175A9F
	for <dmaengine@vger.kernel.org>; Tue,  7 Apr 2026 13:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568931; cv=none; b=TZS9jxOwlz5ngSc6DDQHVmyr6KxtKBdyRikkTnee5628EpyO4swMgQwWu7bGlo/4xuRFAq/ymmV0dXExrKfygReiqWtXq/fT9RBpsnURyfm+OwGRBgxW1U239kVmzMfLCSAiT/1sQ9ECBQGidWu/Oo7/nEijbv1lYryL1Di03fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568931; c=relaxed/simple;
	bh=o2x27ie2cRLK3/IPEfnk02K85UTWqTL0Mqeurw5+xuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ff63XGQuwhMf65CfDXpUvo4AFdQpdsZ60+AI19J8PK+MeN+T99vpZer+mhycb8HhgH8DHUgDFoF7QVD7SWeyhT36rkS1pWj7lqoqq26EXCjNQpUNv9dIOQlARoifDtedp5s4bz+oPp82OFAo3JdxeHNOLdqGToTNU1+UTT8zebg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=HWOcSSbu; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso38740855e9.3
        for <dmaengine@vger.kernel.org>; Tue, 07 Apr 2026 06:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775568927; x=1776173727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3LJdsgaB5y8vkydWsyskwB8EOPuNOYx+V9eGhmYtIWE=;
        b=HWOcSSbuHU50E8X5N0fRdRYw2ke82F9562zLH/FqwSKBDBmiOoOUfS1CqypkIxZpWT
         9ObXM7ptdG+ioAb7GqDek/zNK0aBP8pH533qOkW49HrRebxGARMjeVya7msSuwP+d0kZ
         TNLK0q6N/8ART6WB40GxogAneM9Ts80JVFakMyCM0+4H5+t5yN3PNHgzKtxYtRYLnFLb
         ZcSN1//kL8f6yZVeSLJIoBNHq58BhpSJYQNk8IuiSGRIGIUjYlopUBWSwwmypOOZAYpU
         SJ7pTQw+PKveEkn8xDvz/gRHj0c1AzdiWGga1nI+ie/Vr6PjRcMP+cJYxs5Hc/Aiublx
         MPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775568927; x=1776173727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LJdsgaB5y8vkydWsyskwB8EOPuNOYx+V9eGhmYtIWE=;
        b=k560Swad7hPi4K6Ik3wBnixtkG19PcT8OinMtbGN60+4EAakBGRC3j33jwxQYdjblE
         2kplZDlgk+HBLWUvTduI8/Wc1bs3ub1XkXte3i2yLfBkUnZ0NYamxqAMzbGlZ2tJEd3l
         gas0Ns2wMaHkbrJUH9ZW0dMhyY9wOwYBF5e7dqrKYfdfLQgG9Wq5LfqrSXP5/nK8HdLB
         lu//+G41e5w5zy9BZXfNEsO4B13TN5aOXlhDonJEoXtWmd23AHyPLecMV7thu2fPuIZ/
         pgznqbf3/MJf/CGuWU74gMo1Xb4iDZS+v3SWCRzKtgm8x11WUXe5YcfJyykxAqbr21uD
         pN7g==
X-Forwarded-Encrypted: i=1; AJvYcCVDcNlmFAmNIWobhvFNUr7dHS3nUIdji6D6ZcLXKJ6hyYjdg3TWzwGiLfDaZQ3+hsIUpMQ3JgxByqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0c1M+RgKWEC8SKoexLHZIPPNOXjhRey06MfevNGiBL9+IRRGk
	qJmOcKjuW437Hu7yAkCZ9duLNOVzfbwKgCp/N3c3E7e9pnAexiGAy6cnNDBKsjUNziQ=
X-Gm-Gg: AeBDiet2OhOeBfzbh6SEYKHspEQndpIgXGdLEpvnab1HWA3cJyfEBVF25qDjvOZtozk
	aeBeoKhKa1A0GcGwP8RvsV/QwjHZ16XbZ+oGHuz46T0OS5sbxH1UEoB41KKY8rgS+hTjug9u9Zw
	lmrPIE0+RGD69BKlg7bUAY/BPlW6szJPdnWGAQ8ee8oe2+E0hXUKGfWe6IywDnuGmC7VzMyJoVc
	tqZGF+62iXQzBBU71cyxKgIL51OSgUY7geRszBQqK8PNO6sPxJsGlAovfalKvlc9lliJcC/PMuz
	ZoxQL6H2j5UKAjkGAfnAU2O49AN9TZ3hqYbiAIQd5RLTXuTrGwUilVRbIMqmF7gI8jgF8rY/64W
	3//4m/ijUcOF0QC2fqqWKBgD+EuEkIiK/FC01jpandlVb18pT4NKxiKLSY0LrWY5kXK3T6r4Zi3
	CkPbiilwgqa8yCUpxCBWtvpXhcsa2IXEGicVGTi2XSCg34D3t1uI7N
X-Received: by 2002:a05:600c:1e24:b0:488:c078:bfda with SMTP id 5b1f17b1804b1-488c078f73fmr30084395e9.26.1775568926571;
        Tue, 07 Apr 2026 06:35:26 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488a91686f9sm285777675e9.10.2026.04.07.06.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 06:35:26 -0700 (PDT)
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
	fabrizio.castro.jz@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 00/15] Renesas: dmaengine and ASoC fixes
Date: Tue,  7 Apr 2026 16:34:52 +0300
Message-ID: <20260407133507.887404-1-claudiu.beznea.uj@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9905-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tuxon.dev:dkim,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bp.renesas.com:mid,renesas.com:email]
X-Rspamd-Queue-Id: 678823AF60E
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

Changes in v3:
- addressed review comments got from sashiko.dev. For this:
- added patches 1-9
- added patch "ASoC: renesas: rz-ssi: Add pause support"
- dropped patches:
-- dmaengine: sh: rz-dmac: Add enable status bit
-- dmaengine: sh: rz-dmac: Add pause status bit

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


Claudiu Beznea (15):
  dmaengine: sh: rz-dmac: Use list_first_entry_or_null()
  dmaengine: sh: rz-dmac: Use rz_dmac_disable_hw()
  dmaengine: sh: rz-dmac: Do not disable the channel on error
  dmaengine: sh: rz-dmac: Add helper to compute the lmdesc address
  dmaengine: sh: rz-dmac: Save the start LM descriptor
  dmaengine: sh: rz-dmac: Add helper to check if the channel is enabled
  dmaengine: sh: rz-dmac: Add helper to check if the channel is paused
  dmaengine: sh: rz-dmac: Use virt-dma APIs for channel descriptor
    processing
  dmaengine: sh: rz-dmac: Refactor pause/resume code
  dmaengine: sh: rz-dmac: Drop the update of channel->chctrl with
    CHCTRL_SETEN
  dmaengine: sh: rz-dmac: Add cyclic DMA support
  dmaengine: sh: rz-dmac: Add suspend to RAM support
  ASoC: renesas: rz-ssi: Add pause support
  ASoC: renesas: rz-ssi: Use generic PCM dmaengine APIs
  dmaengine: sh: rz-dmac: Set the Link End (LE) bit on the last
    descriptor

 drivers/dma/sh/rz-dmac.c   | 673 ++++++++++++++++++++++++++-----------
 sound/soc/renesas/Kconfig  |   1 +
 sound/soc/renesas/rz-ssi.c | 375 +++++++--------------
 3 files changed, 599 insertions(+), 450 deletions(-)

-- 
2.43.0


