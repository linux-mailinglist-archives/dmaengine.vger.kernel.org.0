Return-Path: <dmaengine+bounces-940-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 007A0848B9C
	for <lists+dmaengine@lfdr.de>; Sun,  4 Feb 2024 07:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C661C21DC8
	for <lists+dmaengine@lfdr.de>; Sun,  4 Feb 2024 06:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA3F79DC;
	Sun,  4 Feb 2024 06:59:50 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9C079CC;
	Sun,  4 Feb 2024 06:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707029990; cv=none; b=ah5zfRgQ1+7l9CwWeHoP1zyd/UtQsucusXzmBCy895K3aahc/TGrGlVA76ZVrpiEXtQ6VBapNj50m5BMCqAgRViHnwXpMKdEQgOAjZXJN/kfYqnk+YDjv/UT4ZwGvlNcxVZnSsYuZWAE47TQcSoi8vetlWbp3ibpPeOUY0EM7uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707029990; c=relaxed/simple;
	bh=nXreGAjrFbd8QOMMOtwFbxJI53YV7XOtsiSG8Cl+1sw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GYOKMUkxV+GngK9WUc8QlAhhisLAvdWMjdfcr08XPqBM7KSHjGj7vlsBchbdiDNAsIi4nbSmOpMDmAQhfwZqSqk64FE8s3W1fl8znZt3r+MrrgY04NoSCzDnTOSadKZWDCWQyikoW0clBDqjmYXXod1lkqmtajOizhAJsEGjh2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 363D021FAA;
	Sun,  4 Feb 2024 06:59:47 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 136131338E;
	Sun,  4 Feb 2024 06:59:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X25xAuM1v2V4ZwAAD6G6ig
	(envelope-from <aporta@suse.de>); Sun, 04 Feb 2024 06:59:47 +0000
From: Andrea della Porta <andrea.porta@suse.com>
To: Vinod Koul <vkoul@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	dmaengine@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Maxime Ripard <maxime@cerno.tech>,
	Dom Cobley <popcornmix@gmail.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH 00/12] Add support for BCM2712 DMA engine
Date: Sun,  4 Feb 2024 07:59:28 +0100
Message-ID: <cover.1706948717.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: ****
X-Spam-Score: 4.10
X-Spamd-Result: default: False [4.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 MID_CONTAINS_FROM(1.00)[];
	 FORGED_SENDER(0.30)[andrea.porta@suse.com,aporta@suse.de];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[cerno.tech,gmail.com,raspberrypi.com,suse.com];
	 FROM_NEQ_ENVFROM(0.10)[andrea.porta@suse.com,aporta@suse.de];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

This patchset aims to update the dma engine for BCM* chipset with respect
to current advancements in downstream vendor tree. In particular:

* Added support for BCM2712 DMA.
* Extended DMA addressing to 40 bit. Since BCM2711 also supports 40 bit addressing,
it will also benefit from the update.
* Handled the devicetree node from vendor dts (e.g. "dma40").

The only difference between the application of this patch and the relative code
in vendor tree is the dropping of channel reservation for BCM2708 DMA legacy
driver, that seems to have not made its way to upstream anyway, and it's
probably used only from deprecated subsystems.

Compile tested and runtime tested on RPi4B only.

Dom Cobley (4):
  bcm2835-dma: Support dma flags for multi-beat burst
  bcm2835-dma: Need to keep PROT bits set in CS on 40bit controller
  dmaengine: bcm2835: Rename to_bcm2711_cbaddr to to_40bit_cbaddr
  bcm2835-dma: Fixes for dma_abort

Maxime Ripard (2):
  dmaengine: bcm2835: Use to_bcm2711_cbaddr where relevant
  dmaengine: bcm2835: Support DMA-Lite channels

Phil Elwell (6):
  bcm2835-dma: Add support for per-channel flags
  bcm2835-dma: Add proper 40-bit DMA support
  bcm2835-dma: Add NO_WAIT_RESP, DMA_WIDE_SOURCE and DMA_WIDE_DEST flag
  bcm2835-dma: Advertise the full DMA range
  bcm2835-dma: Derive slave DMA addresses correctly
  dmaengine: bcm2835: Add BCM2712 support

 drivers/dma/bcm2835-dma.c | 701 ++++++++++++++++++++++++++++++++------
 1 file changed, 588 insertions(+), 113 deletions(-)

-- 
2.41.0


