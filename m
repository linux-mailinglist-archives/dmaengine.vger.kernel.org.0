Return-Path: <dmaengine+bounces-8532-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFPyLtXMeGmNtQEAu9opvQ
	(envelope-from <dmaengine+bounces-8532-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 15:33:57 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D3295C82
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 15:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 256703007E3C
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 14:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6772635B139;
	Tue, 27 Jan 2026 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gP0BGBHm"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3192335B62C
	for <dmaengine@vger.kernel.org>; Tue, 27 Jan 2026 14:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769524065; cv=none; b=ssveR3N0lkt3f0dMRY5go5BuGrl88QgLKIKxTlsLaF41vj9i8IC0scg16J31eXcQJ2D+tLOvW/WMHK2HK0Ho11R3WfnmJJp+wyNU+rHIsY2R+/0GaUBHGxKE0tfPClPhTP0vLTLxSrEMo+PRKJ+0lJgz+jBp5C3Nga0CmUz/NwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769524065; c=relaxed/simple;
	bh=3HvqTBYkV3aATja0J5KbViF7E4aOH3n6falxINzDQoc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=py9So6qj8b7y/PsGJnTZPgQ+8brwmx7/FuxOAj/IOv/m8tjW0M9xnHoTUgJhk1j9Dd46wlXqEz4FBwYO0Laq3WcI8nykxZa+moEaFCLVs0ggpEYz3TXGRAimShW9Ptu7FJs/sGKqearWCh4jKCu9o74CvDOPLGpGlJl8C5+qEJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gP0BGBHm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2154C116C6;
	Tue, 27 Jan 2026 14:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769524064;
	bh=3HvqTBYkV3aATja0J5KbViF7E4aOH3n6falxINzDQoc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=gP0BGBHmEnGHyidHwPEllJzy15vB9n8UDkqFN+kf3+qCOgcAV8qZrhhXmVBmCBAko
	 2MICfLFyyh8G34+P/A0qC6NmrmlAdwnYIs4x9MTqMEhEIN/nQUo5rMwts2Gm5S/HkF
	 gOxaYa9d6J5jXiq95Gh4VIEMA+bwRZjTklSHUtiZAj7cxIs1wywd1CamV+CrkINNha
	 OS3AevXnv5nwYbnZXsNFTVOrGOhHpoIg+h3LH26sx7bfVVzVw12Edq+Ig85BwiRs/8
	 /i/lHUYXRikA/hNnaPgpqnuzQftiFSYfecHZCBFTOoyyHsWOUjOC8pV6R94hcH5Z+1
	 6TLAkPP8C1ZyA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB7AD2F033;
	Tue, 27 Jan 2026 14:27:44 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH 0/5] dma: dma-axi-dmac: Add cyclic transfer support and
 graceful termination
Date: Tue, 27 Jan 2026 14:28:21 +0000
Message-Id: <20260127-axi-dac-cyclic-support-v1-0-b32daca4b3c7@analog.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MMQqAMAxA0atIZgNthgpeRRxqGjUgWloVRby7x
 fEN/z+QJalkaKsHkpyadVsLbF0Bz36dBDUUAxlyxpJDfykGz8g3L8qYjxi3tKM3riE7kFjTQIl
 jklGvf9z17/sBqTiTdGgAAAA=
X-Change-ID: 20260126-axi-dac-cyclic-support-a06721b2e107
To: dmaengine@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769524107; l=2413;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=3HvqTBYkV3aATja0J5KbViF7E4aOH3n6falxINzDQoc=;
 b=SKdghfEKEFUwl8IYf7tgeKB/NB4V6xg6OM4tUd4y7LQBtZtAONewZnjW70nLg+JCC+XGPplbH
 TgE6qNxTz5FCZfJ50lQ80G2sYQyDczNgrwElEDrpMgEQJaprDUEFF2T
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8532-lists,dmaengine=lfdr.de,nuno.sa.analog.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	HAS_REPLYTO(0.00)[nuno.sa@analog.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,analog.com:mid,analog.com:replyto]
X-Rspamd-Queue-Id: 40D3295C82
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

[1]: https://lore.kernel.org/dmaengine/ZhJW9JEqN2wrejvC@matsya/

---
Nuno Sá (5):
      dmaengine: Document cyclic transfer for dmaengine_prep_peripheral_dma_vec()
      dma: dma-axi-dmac: add cyclic transfers in .device_prep_peripheral_dma_vec()
      dma: dma-axi-dmac: add helper for getting next desc
      dma: dma-axi-dmac: Gracefully terminate SW cyclic transfers
      dma: dma-axi-dmac: gracefully terminate HW cyclic transfers

 drivers/dma/dma-axi-dmac.c | 170 +++++++++++++++++++++++++++++++++++++++------
 include/linux/dmaengine.h  |   3 +-
 2 files changed, 151 insertions(+), 22 deletions(-)
---
base-commit: 3c8a86ed002ab8fb287ee4ec92f0fd6ac5b291d2
change-id: 20260126-axi-dac-cyclic-support-a06721b2e107
--

Thanks!
- Nuno Sá



