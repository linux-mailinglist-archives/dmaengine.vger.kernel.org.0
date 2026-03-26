Return-Path: <dmaengine+bounces-9675-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBAjM7U3xWn/8AQAu9opvQ
	(envelope-from <dmaengine+bounces-9675-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 14:42:13 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8ED3362B5
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 14:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 464213084AED
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 13:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E332F12C6;
	Thu, 26 Mar 2026 13:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tt8DZY1h"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E8A271A7C;
	Thu, 26 Mar 2026 13:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774532251; cv=none; b=o56M9YsZuSxyyo4UIgZHqMvLBsU7MgPuu7aNHlzG49nv6BH5hLJkMgOe1hf1D7tVWzf7swiRp/iWLaHrpWZgI4FKDu/9oLQcxeGAhLjfV47WmUJ7m+dduvgYFp1ktutyG3BqMVhlcgfpqu1lhHesZHOMaOipxT6fU8WTAbxKAKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774532251; c=relaxed/simple;
	bh=UsmwhaGP+e5WwipGleUgGHqJL8dBThe2HRGuRQN3g7A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UiNwF7vTX3tp8qWGRKx4YIzsmGABLTN5/cRrxbI5X9myIRVmGdUFJqRXmdd/2Fb8/4smboZDqRyKWnpECWApR3BY/NscI3qK6BQghGcc63P0HWPjjE+ZeFNIvwKs4AKOh6N7DRS7GBfXjn7X2orCyH0bdiHWZ70UOzlRK1j6mRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tt8DZY1h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06D1CC2BCB0;
	Thu, 26 Mar 2026 13:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774532251;
	bh=UsmwhaGP+e5WwipGleUgGHqJL8dBThe2HRGuRQN3g7A=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=tt8DZY1hPUw6KnatwIifYovFaZXDPotP8a2q2Rik5SZShX2IbtmCVs3rfTq+erlhr
	 Cc5536y1Cdojhf5bNTVyBpLSq9W/MSNANTt5FwcqIyR4eLYVdJcFOncSCq6ouqIjP8
	 fHpeLhpPRjWlCBseonxg3ulfIxoTxpp4IxZwzJBMb45pClOJ1VUUOXELqUoMOLBsKE
	 eJjgKF+MtAvWTx4+vZFZK9G+4/BPbiGoVPE5ezc36U+evq+iRcccjT0M50zjuQmFiR
	 XRUBd3ozH3C9P+A1OTvXzdhZod4c5kU55y8aWsEkFoogEXwmJ3e71YkCHUTH6b6jSv
	 UDV/JBwV9/RJQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFDF10A62D6;
	Thu, 26 Mar 2026 13:37:30 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH 0/2] dmaengine: dma-axi-dmac: Some memory related fixes
Date: Thu, 26 Mar 2026 13:37:34 +0000
Message-Id: <20260326-dma-dmac-handle-vunmap-v1-0-be3e46ffaf69@analog.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQqDMBBFryKz7kBM1IpXKS5iZmynaJRERRDv3
 lgXf/H4vHdA5CAcockOCLxJlMknyB8ZuI/1b0ahxKCVrpTRJdJorzlMLw2M2+pHO2NdWFVR/6T
 cGEjyHLiX/R9+tTfHtfuyW64anOcP5evccXoAAAA=
X-Change-ID: 20260325-dma-dmac-handle-vunmap-84a06df7d133
To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>, Eliza Balas <eliza.balas@analog.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774532297; l=1511;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=UsmwhaGP+e5WwipGleUgGHqJL8dBThe2HRGuRQN3g7A=;
 b=nkgfcGteA/fbgayHV/UsxRPyYRHyEnS84P0LXM3iOYJyz450JJ50y/a1koPPn0jI9C+yeplRj
 ZLQMLUIgIX6CavXkS6RHXcPPaWYlYkLKQKiXSTd67g5Yn48ahq/rd8S
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9675-lists,dmaengine=lfdr.de,nuno.sa.analog.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[nuno.sa@analog.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,analog.com:email,analog.com:replyto,analog.com:mid]
X-Rspamd-Queue-Id: 0A8ED3362B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series aims to fix some issues with axi-dmac driver related to
memory:

1. When testing the IP on a microblaze based platform, we get vmalloced
   memory when allocation DMAC descriptors which will lead to BUG() when
   releasing them. More on the commit message.
2. The second is related with a well known issues with devm allocations
   of reference counted objects on a provider-consumer relationship.
   Seems to be a knows issue in dmaengine but fix it in the AXI-DMAC
   driver by properly implementing .the device_release() callback.

Didn't add any fixes tag because for 1), it was not an issue when the
drivers was first implemented (just triggered very recently) and for 2),
because it seems like a well known issue. Anyways, for 2) seems more
reasonable to have a fixes tag (IMO) if you want me to add one.

Also note that my signoff on Eliza patch is merely because I'm sending
the patch on her behalf. I had not part in the solution (just improved
comments and commit message a bit).

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
Eliza Balas (1):
      dmaengine: dma-axi-dmac: Defer freeing DMA descriptors

Nuno Sá (1):
      dmaengine: dma-axi-dmac: fix use-after-free on unbind

 drivers/dma/dma-axi-dmac.c | 95 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 78 insertions(+), 17 deletions(-)
---
base-commit: b7560798466a07d9c3fb011698e92c335ab28baf
change-id: 20260325-dma-dmac-handle-vunmap-84a06df7d133
--

Thanks!
- Nuno Sá



