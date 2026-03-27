Return-Path: <dmaengine+bounces-9696-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDBUAya3xmnoNwUAu9opvQ
	(envelope-from <dmaengine+bounces-9696-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 27 Mar 2026 17:58:14 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BD893347F41
	for <lists+dmaengine@lfdr.de>; Fri, 27 Mar 2026 17:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B80E3035A4C
	for <lists+dmaengine@lfdr.de>; Fri, 27 Mar 2026 16:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8093644C0;
	Fri, 27 Mar 2026 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDxDoTZx"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D018C36405F;
	Fri, 27 Mar 2026 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774630672; cv=none; b=sixyAExJNNxKLQfdYYcQnnzkWF51ZL5aON4C6oydCgu29GOXGog3SzLCbMhd6Qm89JY8HnMwXgMKb2PMf7P/dT4/IkKJRDM0BNEbogLnshcDPRawdc+fYbMnIr1G0UqiuTe3mESW8z017j1GZU07ux2fHq5vpm1o6280j27HLkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774630672; c=relaxed/simple;
	bh=sIUaoSXsT5CAZce6MTex4xhkMIXKMV1V7N/fTuD9Qns=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KOH2r+CLYdKYzVI8ludZvERz83EJMWZiwGDgRs5KW/6lyk8YtchvQ27wmBp8SWujl7wP8UYNnbOyKtLV545J5hOZll3+os58smJtN7DPdC0f7Zh4NDd+rbC2p5xVtvqGDRCdJyacNgy/glFAh1PESPGZjazaKPTwO4t9cvm9Yfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDxDoTZx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A30EC19423;
	Fri, 27 Mar 2026 16:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774630672;
	bh=sIUaoSXsT5CAZce6MTex4xhkMIXKMV1V7N/fTuD9Qns=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=JDxDoTZxGgBfh5knqxRtKf4yTaRyNb9Y6Iya/TE1HtLl0pBHNA0k+2DtgRKDQLW2+
	 mT6pSqXO3h7JFKkLZyuJAS+7prdpCZTU4Mw9pq5K4CE5fsBYh90jhMMxw8JOge/qI2
	 /+rzZAme4TYYsfiNpZab+FYHdgI0Kj/Boh2sY0z6fuIINsiFX1l0Cbhkblm9FuA/bl
	 DQVUPXJuJ1aH1DDU2BEzTH0aE5hZvAGMUk59EUzSPPCFzzgziV436chuht6Ui3vE8P
	 Zpw6JKXtfLSVdOx9QLsSDUYBvfKGuHDFsb1CwOv+EYlnp9jTRQ0QROdtN+sYYuX2/z
	 z061cusEZ5qpQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD7710F2859;
	Fri, 27 Mar 2026 16:57:52 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH v2 0/4] dmaengine: dma-axi-dmac: Some memory related fixes
Date: Fri, 27 Mar 2026 16:58:37 +0000
Message-Id: <20260327-dma-dmac-handle-vunmap-v2-0-021f95f0e87b@analog.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw6DIBBFf8WwLg2CpY9V/6NxgTAojYIBJW0M/
 16w6bKLWZzMvfdsKIA3ENCt2pCHaIJxNgM9VEgOwvaAjcqMKKGcMHrCahLlJM5fNQKOq53EjC+
 NIFzps6oZQ7k8e9DmtQ8/2i+HtXuCXMpaSQwmLM6/d3OsS+4n4f8kscYEd8Cg4VoLza93YcXo+
 qN0E2pTSh9SV3dOzwAAAA==
X-Change-ID: 20260325-dma-dmac-handle-vunmap-84a06df7d133
To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>, Eliza Balas <eliza.balas@analog.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774630718; l=2035;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=sIUaoSXsT5CAZce6MTex4xhkMIXKMV1V7N/fTuD9Qns=;
 b=XjJ008vde2HzUu9jC0uuA6Uklh1HpL/1Ng0PNAeXfUl+yidN+Ro5JearkUJLNuWsnnaQSJdTh
 RU1hmVwAuNDAMEWpaoAsUjYs2TAiEbgPpBEEYu4csnRl56qy+9zizpw
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9696-lists,dmaengine=lfdr.de,nuno.sa.analog.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[nuno.sa@analog.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,analog.com:replyto,analog.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BD893347F41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ok, I rushed into v2 because I saw (based on AI review) that I already
had some fundamental issues. Some fairly straight (a bit embarrassing tbh)
but others not so much. Another thing to notice is that I changed the
order between "fix use-after-free on unbind" and "Defer freeing DMA
descriptors" because it just makes more sense given that using the
worker only works 100% if we don't have our DMA object bounded with the
platform driver.

Anyways, more details on the changelog.

Also note the addition of two new patches. The dmaengine one seems legit
but I want to note it was just by code inspection.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
Changes in v2:
- Patch 1:
  * New patch.
- Patch 2:
  * New patch.
- Patch 3:
  * Use __free() to allocate the ojject so we don't leak in early
    errors. Note that after dmaenginem_async_device_register(), the
    object lifetime is handled by dmaengine;
  * Move get_device() to after registering the device;
  * Still allow to free DMA descriptors in axi_dmac_terminate_all();
  * Use spin_lock_irqsave() to avoid possible deadlocks. 
  * Include spinlock.h
- Patch 4:
  * Include workqueue.h;
  * Save struct device directly in struct axi_dmac_desc and get a
    reference when allocating. Give the reference when freeing the
    descriptor.
- Link to v1: https://patch.msgid.link/20260326-dma-dmac-handle-vunmap-v1-0-be3e46ffaf69@analog.com

---
Eliza Balas (1):
      dmaengine: dma-axi-dmac: Defer freeing DMA descriptors

Nuno Sá (3):
      dmaengine: Fix possuible use after free
      dmaengine: dma-axi-dmac: Properly free struct axi_dmac_desc
      dmaengine: dma-axi-dmac: fix use-after-free on unbind

 drivers/dma/dma-axi-dmac.c | 122 ++++++++++++++++++++++++++++++++++++---------
 drivers/dma/dmaengine.c    |   3 +-
 2 files changed, 100 insertions(+), 25 deletions(-)
---
base-commit: b7560798466a07d9c3fb011698e92c335ab28baf
change-id: 20260325-dma-dmac-handle-vunmap-84a06df7d133
--

Thanks!
- Nuno Sá



