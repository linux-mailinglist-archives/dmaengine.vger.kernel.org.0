Return-Path: <dmaengine+bounces-9869-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sP3CKt6XzmkBowYAu9opvQ
	(envelope-from <dmaengine+bounces-9869-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 18:22:54 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFBA38BC9A
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 18:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A03D301AE4C
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2026 16:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D5C350A18;
	Thu,  2 Apr 2026 16:22:50 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2715D2FFF88;
	Thu,  2 Apr 2026 16:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775146970; cv=none; b=m1Z89RXWxA9sDcrawU1k/1inz8whF+O5cQc7avTkJbYzkUKLWtPi5IRf0lBqFCuP/xg/EdbgQDlTqHtUfH3chgQsu8lBlbzz81EaONOK1z5saZ3l95ovxE3Q132id1nNCCaNzBLuuH9qcTDVsuCLFikdncOVEQTX2a7rBzuHMHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775146970; c=relaxed/simple;
	bh=U55cP8B1ToQ9f1m/8NPsW0EGmfynU3+pr5QquYQhc2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=soqvYDk1m134DmCTVnQeivp3WRRchEmRSPpMaZh5m2ZMS/DxALrKJy6NjPfXHlPnpMfBAxwaB1zhfekImVqFPRPSLXvSmiuC6YRJiDOrpW+GYvGRPXPLDP0L4fpShpTft66TKt0Dwcv3JqOtSIYAQYuPGGc0ntcaE5/Xl8A+Drs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: +C7Yu6UbQm6yTKfOhPds6Q==
X-CSE-MsgGUID: 5RwOdQVGQQKxIoua29eE7Q==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 03 Apr 2026 01:22:42 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.38])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 843054017C54;
	Fri,  3 Apr 2026 01:22:38 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	john.madieu@gmail.com,
	linux-renesas-soc@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [PATCh v3 0/2] Add DMA ACK signal routing for RZ/V2H family
Date: Thu,  2 Apr 2026 18:22:10 +0200
Message-ID: <20260402162212.12016-1-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9869-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[tuxon.dev,bp.renesas.com,renesas.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.969];
	FROM_NEQ_ENVFROM(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3AFBA38BC9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some peripherals on RZ/V2H, RZ/V2N, and RZ/G3E SoCs require explicit
DMA ACK signal routing through the ICU for level-based DMA handshaking.

Rather than encoding the ACK signal number as a second DMA specifier
cell, derive it in-driver from the MID/RID request number using
arithmetic formulas based on ICU Table 4.6-28 (3 linear peripheral
groups). It must also be noted that DMA ack register is located in
the ICU block


This series adds:
  - ICU driver extension to register/deregister DMA ACK signals
    (DMA ACK register is located in the ICU block)
  - rz-dmac driver support for ACK signal routing via MID/RID lookup,
    including restore on system resume

Note: patch 2/2 depends upon [1], the Cyclic DMA series from Claudiu.

Changes:

v3:
 - Splitout from v2 [2] into DMA-specific series 
 - No code change

v2:
 - Drop DMA ACK second cell from DT specifier
 - Derive ACK signal number in-driver from MID/RID using arithmetic
   formulas per ICU Table 4.6-28 (3 linear peripheral groups)

[1] https://lore.kernel.org/all/20260320112838.2200198-1-claudiu.beznea.uj@bp.renesas.com/
[2] https://lore.kernel.org/all/20260402090524.9137-1-john.madieu.xa@bp.renesas.com/

John Madieu (2):
  irqchip/renesas-rzv2h: Add DMA ACK signal routing support
  dma: sh: rz-dmac: Add DMA ACK signal routing support

 drivers/dma/sh/rz-dmac.c                  | 72 +++++++++++++++++++++++
 drivers/irqchip/irq-renesas-rzv2h.c       | 40 +++++++++++++
 include/linux/irqchip/irq-renesas-rzv2h.h |  5 ++
 3 files changed, 117 insertions(+)

-- 
2.25.1


