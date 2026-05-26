Return-Path: <dmaengine+bounces-10897-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IL++NPVeFWp7UgcAu9opvQ
	(envelope-from <dmaengine+bounces-10897-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 10:51:01 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A895D2B17
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 10:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E74AD3037148
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 08:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561553CE4B9;
	Tue, 26 May 2026 08:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAvqGQyM"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F58313534;
	Tue, 26 May 2026 08:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779785242; cv=none; b=fSl66UNIjeF+UvgLEnOEWmBKhDQW6w9dmvMJQy5ub5iULIzCWO8KvIteE9+EpiRVpe7tEP6h/Bk0c6fAFNfTzrpnn9oxmKqh7ZTV0/sNS9JiFJvfEvG2wnQh4x4dWTupLQaXks9p72X7PpjgPCk9I7Wh1utZiUQdUA15rv9pNzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779785242; c=relaxed/simple;
	bh=dF/3Or/APAi8gUCGXHZjbUtWKpklMuylN8JgYPFaQzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c/qJraPmpIA8pgO/k59QEriUnicRrtI2o49ZNBADye95+FrYmE1IKhPpmFmPuoW46tRvS0VFBgWgVERmJqNZWKxblli2APBZRKjNg6tLNtShAcZjof88LNjN4UbR6M85b6cqInxA7waSF4rpILcsiCRXVDJPp5J4lirBTQqJfwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAvqGQyM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724351F000E9;
	Tue, 26 May 2026 08:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779785240;
	bh=eUuIco8b1SWZ0uBpopNB9iCNZoaxcawsnX5tKs/+FWc=;
	h=From:To:Cc:Subject:Date;
	b=BAvqGQyMsHmRs1zoOjzf87v5NNt8xxKzB1IoFRyvWjhGUKVljmoW2Qo2WvDMCZJak
	 2D0Abq4mO7xInYXU1dDDCBKGJcjE6Ix75XMS6YnCKMAcGakMtu9QlRoK1dJ9UFRL4O
	 ZRemp5wtpQKbjRIXq2o7rtsuurYrs6OEm5CEVnDGnmRc5m84CVVqG9VzmYsJlPmHLL
	 kNstqvWJaULT6KpVviVBwpBF7N1jnUqXYJYJpI8juyz7/F557k8I+Z31GIQwPeso8g
	 2G8QTtaxX4XsBCMBrwRPolm++RaIOZYVlpaYEcF5pWmONNxP6htHhnNaynJvhXP6Zm
	 MCpcirfUY1Vtw==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
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
	kuninori.morimoto.gx@renesas.com,
	long.luu.ur@renesas.com
Cc: claudiu.beznea@kernel.org,
	claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v6 00/18] Renesas: dmaengine and ASoC fixes
Date: Tue, 26 May 2026 11:46:52 +0300
Message-ID: <20260526084710.3491480-1-claudiu.beznea@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10897-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 45A895D2B17
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

In case this series will be merged this release cycle, as the audio
patches are acked, best would be to go though the DMA tree.

However, there might be merge conflict on the rz-ssi driver due to the
recently posted patch at [1].

Thank you,
Claudiu

[1] https://lore.kernel.org/all/875x4agb2x.wl-kuninori.morimoto.gx@renesas.com

Changes in v6:
- addressed sashiko review comments
- addressed Frank's review comments
- collected tags

Changes in v5:
- dropped patch "dmaengine: sh: rz-dmac: Do not disable the channel on error"
- added patch "dmaengine: sh: rz-dmac: Add runtime PM support"

Changes in v4:
- collected tags
- addressed review comments got from sashiko.dev. For this:
- added patches:
-- dmaengine: sh: rz-dmac: Move interrupt request after everything is set up
-- dmaengine: sh: rz-dmac: Fix incorrect NULL check on list_first_entry()

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

Claudiu Beznea (18):
  dmaengine: sh: rz-dmac: Move interrupt request after everything is set
    up
  dmaengine: sh: rz-dmac: Fix incorrect NULL check for
    list_first_entry()
  dmaengine: sh: rz-dmac: Use list_first_entry_or_null()
  dmaengine: sh: rz-dmac: Use rz_dmac_disable_hw()
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
  dmaengine: sh: rz-dmac: Adjust rz_dmac_chan_get_residue() to return
    error codes
  dmaengine: sh: rz-dmac: Add runtime PM support
  dmaengine: sh: rz-dmac: Add suspend to RAM support
  ASoC: renesas: rz-ssi: Add pause support
  ASoC: renesas: rz-ssi: Use generic PCM dmaengine APIs
  dmaengine: sh: rz-dmac: Set the Link End (LE) bit on the last
    descriptor

 drivers/dma/sh/rz-dmac.c   | 823 ++++++++++++++++++++++++++-----------
 sound/soc/renesas/Kconfig  |   1 +
 sound/soc/renesas/rz-ssi.c | 399 +++++++-----------
 3 files changed, 723 insertions(+), 500 deletions(-)

-- 
2.43.0


