Return-Path: <dmaengine+bounces-11556-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Pj4PBIJxMWrNjQUAu9opvQ
	(envelope-from <dmaengine+bounces-11556-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 17:53:38 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4AE69179E
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 17:53:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=JsEiA380;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11556-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11556-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0C9F1301CF56
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 15:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9909D4611EE;
	Tue, 16 Jun 2026 15:39:53 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D5545BD7B;
	Tue, 16 Jun 2026 15:39:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624393; cv=none; b=HJZnKtVp9/lIHUeVc6olEYupjTZ0NR/bpLuMOBq+3SPEY/KBbN3aZrj0+ryKLJLjfKs6YDlzvc0GcOrfhzgVKzI2pp3CqSqzWFypRYlNGFsbcVwdhh9VgfIr9tdZ6LmvnBBcANtx2XdhOOuYeHm3ikR9HtgHpzvIlkuRLOzCM90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624393; c=relaxed/simple;
	bh=+QIasRBIyKP+WO6TXZ4SAPt7bwYYwVLv6m09mqd7suk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XazVkf4vrEkz1YoXEqkWuAoqlyFOmJUeFfLu2APRhpYThqsRj0WNTx/z6DDonmnwzBlGcEmfTt0rnUl+FA3LWNDiAVfAbAQNVG7x8XYLUS/U49fz07leMoksCNbUu1TEmm6UbsDegdF/8xgNtnsSqZYCRYMNsCVOyaYvWfmxTCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JsEiA380; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24704C2BCB8;
	Tue, 16 Jun 2026 15:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781624393;
	bh=+QIasRBIyKP+WO6TXZ4SAPt7bwYYwVLv6m09mqd7suk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=JsEiA380aj0j9LMObot7jmLtf+FKXqw9tgLs2YnVufvU/YsPY/6ZVvXxXSqZjLlXJ
	 RMLLy47FV/r2gyRUvLHhC9TwBw8a/npPmx9Wj4ZJE+Uw8Lu1SP76zIsNR1WSczAgSn
	 1CMAcrnnGah/FShzOSjYdgUXAGefEckkrPtPt0xq5k5eMzk+WMYL7ajwUGhNp6caRP
	 0RF2zit2Pzi437fgwU4i1Dov15cKVHIpxFBNgfHYdvXfXh7SxCrULTgzH89TWRbbVN
	 1Wyam9R+rOjZgNl+yD5u/W4par+gu6rbqPnl4WVGwKCVuvv+ezXDjE5Ty8DM8tueCh
	 8rHp16bEo982g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A828CD98DA;
	Tue, 16 Jun 2026 15:39:53 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH RFC 0/3] dmaengine: Support address bus widths of 32 bytes
 and above
Date: Tue, 16 Jun 2026 16:40:51 +0100
Message-Id: <20260616-dmaengine-support-wider-dma-masks-v1-0-da23a8dcb756@analog.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNywrCMBAAf6Xs2YUm2Ba9Cn6AV/GwJmtdpWnI9
 iGU/rupHmcOMwsoJ2GFY7FA4klU+pDB7ApwTwoto/jMYEtbl7Wp0HfEoZXAqGOMfRpwFs9p89i
 RvhUrImfs/tCwbSB3YuKHfH6PK1zOJ7j9pY73F7thq8O6fgGmfC+IigAAAA==
X-Change-ID: 20260615-dmaengine-support-wider-dma-masks-5aac12497e27
To: dmaengine@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781624455; l=3227;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=+QIasRBIyKP+WO6TXZ4SAPt7bwYYwVLv6m09mqd7suk=;
 b=tmf6UE3hfFI9WDOrUkRnTII+gZl3A+Vv7vcWdbRAns06aGK8bkU1u75Fgv3aTUwKERpKBz1vT
 6OwhDyHlp6tAkBYJavrwXTdFMq+JocGbj3yAVY8J96Qm/9RwqSIdw9p
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11556-lists,dmaengine=lfdr.de,nuno.sa.analog.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:linux-iio@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:lars@metafoo.de,m:jic23@kernel.org,m:dlechner@baylibre.com,m:andy@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[nuno.sa@analog.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:replyto,analog.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D4AE69179E

The DMA engine slave capabilities advertise the supported source and
destination bus widths in src_addr_widths / dst_addr_widths. These are
plain u32 bitmasks where a set bit's position equals the corresponding
enum dma_slave_buswidth value, e.g. DMA_SLAVE_BUSWIDTH_4_BYTES sets
bit 4.

The consequence is that widths of 32 bytes and above cannot be
represented at all: DMA_SLAVE_BUSWIDTH_32/64/128_BYTES would need bits
32, 64 and 128, which simply do not fit in a u32. Hardware with wider
data paths is becoming common, so we need a representation that can
express these widths while still using enum dma_slave_buswidth.

This series switches the masks to bitmaps that span the full enum
range. Because there are many producers (DMA controllers) and a number
of consumers spread across the tree, converting everything in one go is
not realistic. To allow an incremental migration, the legacy u32 fields
are kept alongside the new bitmaps:

- producers set the bitmap via the new dma_set_{src,dst}_addr_mask()
helpers, which also mirror the low 32 bits back into the legacy u32;
- legacy producers that still assign the u32 directly keep working, and
dma_get_slave_caps() folds such a u32 into the bitmap it returns, so
new consumers always see a complete bitmap;
- consumers can read either the legacy u32 or the new bitmap during the
transition.

The axi-dmac controller and the IIO dmaengine buffer are converted as
examples of a producer and a consumer. And this actually fixes a very
open coded path to undefined behavior in the axi-dmac driver and
possibly others.

The end goal is to convert every producer and consumer, then drop the
legacy u32 src/dst_addr_widths fields and rename the *_mask members.
I cannot commit to a timeline for that conversion (it touches a lot of
drivers across several subsystems), but I do intend to see it through.

Sending as RFC mainly to agree on the approach!

I'm also not sure if the dma_slave_caps_get_{src,dst}_width_min() accessors
are worth having? Their purpose is purely to keep consumers from touching
the representation directly, so that the eventual u32 removal + mask
rename is a no-op for consumers. The alternative is to let consumers use
the bitmap directly (find_first_bit()/test_bit()/etc.) and just delete the
u32 members at the end. I mean, now we do have a bitmask so the _mask
suffix can of makes sense.

This issue was discussed before here:

https://lore.kernel.org/dmaengine/abkoXXbaxaiqbBuX@vaman/

---
Nuno Sá (3):
      dmaengine: Support address bus widths of 32 bytes and above
      dmaengine: dma-axi-dmac: Switch to bitmap-based address width masks
      iio: buffer-dmaengine: Use dma_slave_caps width accessors

 drivers/dma/dma-axi-dmac.c                         |  12 ++-
 drivers/dma/dmaengine.c                            |  18 ++++
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |  15 ++--
 include/linux/dmaengine.h                          | 100 ++++++++++++++++++++-
 4 files changed, 129 insertions(+), 16 deletions(-)
---
base-commit: 7524fe142b5a772f8421aeee2132cf7e21a00103
change-id: 20260615-dmaengine-support-wider-dma-masks-5aac12497e27
--

Thanks!
- Nuno Sá



