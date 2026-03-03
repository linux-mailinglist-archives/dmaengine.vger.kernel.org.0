Return-Path: <dmaengine+bounces-9211-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHXhMNS2pmk7TAAAu9opvQ
	(envelope-from <dmaengine+bounces-9211-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 11:24:20 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4107C1EC9A2
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 11:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F9F5301A7E4
	for <lists+dmaengine@lfdr.de>; Tue,  3 Mar 2026 10:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE6E382382;
	Tue,  3 Mar 2026 10:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jE7qsP1G"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED20E39099A
	for <dmaengine@vger.kernel.org>; Tue,  3 Mar 2026 10:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772533458; cv=none; b=Hnx0jzcoM5e4RH4Gush5F/rsd6weVTU1Brpk/J8uz+Oz/hUWLjUcaZy0syGzambd5una3G2wifytwVwKvt4gQ+I7hcn590DVCmAz10n2d+ZmvCWHBr1znqXHy3HMQQe5rxTr4lVZbX6X2oNKisopPzpRgWe0cqG7s0stxv0NM28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772533458; c=relaxed/simple;
	bh=5w7fBeke7v9YYNTBIFpMrarSRv6BPkQaYufv7XgHXE4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sgJcNH3K+9yGvbTEiiIxFpqxomOwge+k1yYju9xl4GX4TIBJR5+VhwL8EsNXxCD2u8dDse1r46ZD5nxtkBEel5tCknFt5ZHOgtnBE1kEVV14fm6c5K5HItfostQ3GLhpFSPDd3FOyfyK39P9xmgUeHQl696Nn3Fl6D46qeZVjG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jE7qsP1G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5051C2BC9E;
	Tue,  3 Mar 2026 10:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772533457;
	bh=5w7fBeke7v9YYNTBIFpMrarSRv6BPkQaYufv7XgHXE4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=jE7qsP1GU2tH+LL1rL2nedgeuFrovarwNmvMSN/iF6aJRzE7JVN+epnJ8AHSisuy+
	 ZsEJXriY2htc/8KDKmaFhpgxUG1YTp5mmnovqXv86rrCqar9Hmfx3cgCBkwUp5sevO
	 QlD4aMMLRaR0Q+TUyqcFue8rFnzD30uCOiOvq0pb/uHCwxCdQ4VjSRpL3q6q8UzJfQ
	 3hqDGfDfrX3R2J5T4KUCevDoVrOtp6WXH6Oyhxxzqap1BsE4GClZIYiSzqabOS8M3g
	 HcXf7SdRoWaRGLWGz6yhJqoxJrHeuFFLLQzeRMKJ9aqV3ZjC59QHa2Xwz3X0WKbs5L
	 7+ZIvHor/1QJg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF1BEC048B;
	Tue,  3 Mar 2026 10:24:17 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH v2 0/5] dmaengine: dma-axi-dmac: Add cyclic transfer
 support and graceful termination
Date: Tue, 03 Mar 2026 10:24:59 +0000
Message-Id: <20260303-axi-dac-cyclic-support-v2-0-0db27b4be95a@analog.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNwQqDMBBEf6XsuVuStRjoqf9RPKxrqgvWSGJFE
 f+9qdBjj2+GebNB8lF9gttpg+hnTRqGDHQ+gXQ8tB61yQxkqDSWSuRFsWFBWaVXwfQexxAnZFM
 6sjV5axzk8Rj9U5dD/Kgyd5qmENfjZ7bf9Kd0/5SzRYN1Qbnia12Iu/PAfWgvEl5Q7fv+AZqi+
 fi9AAAA
X-Change-ID: 20260126-axi-dac-cyclic-support-a06721b2e107
To: dmaengine@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772533501; l=3322;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=5w7fBeke7v9YYNTBIFpMrarSRv6BPkQaYufv7XgHXE4=;
 b=g5QOgICB0KLtNVxTU1Y5x8hfqCLCgIjbdQQj2lvERSzwC0fZju40o+ffVvvq+AsuX9RKMhnSk
 YlXEB1BtZvYBKZv/NIJFFexBBcNebXTeCYuemeHGt6+tMvUDFVDOUa1
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com
X-Rspamd-Queue-Id: 4107C1EC9A2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9211-lists,dmaengine=lfdr.de,nuno.sa.analog.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	HAS_REPLYTO(0.00)[nuno.sa@analog.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,analog.com:replyto,analog.com:mid]
X-Rspamd-Action: no action

This series adds support for cyclic transfers in the .device_prep_peripheral_dma_vec()
callback and implements graceful termination of cyclic transfers using the
DMA_PREP_LOAD_EOT flag. Using DMA_PREP_REPEAT and DMA_PREP_LOAD_EOT is
based on the discussion in [1].

Currently, the only way to stop a cyclic transfer is through brute force using
.device_terminate_all(), which terminates all pending transfers. This series
introduces a mechanism to gracefully terminate individual cyclic transfers when
a new transfer flagged with DMA_PREP_LOAD_EOT is queued.

We need two different approaches:

1. Software-managed cyclic transfers: These generate EOT (End-Of-Transfer)
   interrupts for each cycle. Hence, termination can be handled directly
   in the interrupt handler when the EOT interrupt fires, making the
   transition to the next transfer straightforward.

2. Hardware-managed cyclic transfers: These are optimized to avoid interrupt
   overhead by suppressing EOT interrupts. Since there are no EOT interrupts,
   termination must be detected at SOF (Start-Of-Frame) when new transfers
   are being considered. The transfer is marked for termination and the
   hardware is configured to end the current cycle gracefully.

For HW-managed cyclic mode, the series handles both scatter-gather and non-SG
variants. With SG support, the last segment flags are modified to trigger EOT.
Without SG, the CYCLIC flag is cleared to allow natural completion. A workaround
is included for older IP cores (pre-4.6.a) that can prefetch data incorrectly
when clearing the CYCLIC flag, requiring a core disable/enable cycle.

Frank, I opted to not go with your style suggestion for axi_dmac_get_next_desc()
given that it seems to boil down to preference preference (there's no
80 col limit cross) and I do have a slight preference for the current
style. So, unless Vinod jumps in with some preference, I would prefer to
keep it.

Another meaningful change is that ADI hdl team will start to use
semantic versioning for the hdl cores [2]. So increasing the minor number to
6 will lead to 4.6.0 instead of 4.6.a.

[1]: https://lore.kernel.org/dmaengine/ZhJW9JEqN2wrejvC@matsya/
[2]: https://github.com/analogdevicesinc/hdl/pull/1831

---
Changes in v2:
- All patches but 1:
  * Be consistent with git subject.
- Patch 4:
  * Refactor commit message to avoid "we".
- Patch 5:
  * Use semantic versioning for the condition detecting
    hw_cyclic_hotfix. 
- Link to v1: https://lore.kernel.org/r/20260127-axi-dac-cyclic-support-v1-0-b32daca4b3c7@analog.com

---
Nuno Sá (5):
      dmaengine: Document cyclic transfer for dmaengine_prep_peripheral_dma_vec()
      dmaengine: dma-axi-dmac: Add cyclic transfers in .device_prep_peripheral_dma_vec()
      dmaengine: dma-axi-dmac: Add helper for getting next desc
      dmaengine: dma-axi-dmac: Gracefully terminate SW cyclic transfers
      dmaengine: dma-axi-dmac: Gracefully terminate HW cyclic transfers

 drivers/dma/dma-axi-dmac.c | 170 +++++++++++++++++++++++++++++++++++++++------
 include/linux/dmaengine.h  |   3 +-
 2 files changed, 151 insertions(+), 22 deletions(-)
---
base-commit: c8e9b1d9febc83ee94944695a07cfd40a1b29743
change-id: 20260126-axi-dac-cyclic-support-a06721b2e107
--

Thanks!
- Nuno Sá



