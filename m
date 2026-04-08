Return-Path: <dmaengine+bounces-9935-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMNcHzFO1mm8DQgAu9opvQ
	(envelope-from <dmaengine+bounces-9935-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Apr 2026 14:46:41 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E98743BC5BE
	for <lists+dmaengine@lfdr.de>; Wed, 08 Apr 2026 14:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A40E300A120
	for <lists+dmaengine@lfdr.de>; Wed,  8 Apr 2026 12:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3226D3C872A;
	Wed,  8 Apr 2026 12:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/E17zcm"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F0F38CFF4;
	Wed,  8 Apr 2026 12:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775652112; cv=none; b=UbBhqBT0PI2zvIxgk1j7AvSkXVBnLuAmT76MUQXSc761qKao4SQZhu5/rBHGcQCgUOgEfzgkscGOAhW1bHB8go4Qc/IrV6v1OHyD3hiV9+K4fZaTg+flK8zGM3JB7Qfc124jwenN2S5mvgzDSnbhOfhoSWdhXDIXx8ruZ9O66Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775652112; c=relaxed/simple;
	bh=LMqWJzfF94rZChyrIXed1rTS6WeTaHpN2Sas+xgnyR8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=I+S2KXI4myRS1pPDeCrm+xOKndDUrbTnElVr5LqEzXGl5PKjNV3ty1c7C+AL5GA9+RrPlAn9RMVa+SwpU9NXFjYC6C0Fo7MUlMB/Ul3dD6mtnvoZM1yPHBRUs8GRl7c0f8Fe7ZF/xb0f0BdIBQHhelSQ7KbpBFOcrR1CsyFwHzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/E17zcm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D688DC19421;
	Wed,  8 Apr 2026 12:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775652111;
	bh=LMqWJzfF94rZChyrIXed1rTS6WeTaHpN2Sas+xgnyR8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=c/E17zcmQn9YWD5UaLh7wdfYd8MsSfNhvfo9YBSVzYea3T/hNHP18Ug55qO61dUkU
	 b/zHHNtNPNaDQlPXF71TLU/PgrwIwEvrjApZp8QUAoXPwZM4QGhL41w3S7wlKH1KSh
	 zVYkizSR2dpproLx92d54utf1KBn4E66NXRLeYRGwEAgsutt61YKbfWRu4poE4rxUR
	 QE48AQdst6c22krZZD+FxmgdvNFZ8C95/LvFfUciqXP1DDt6hKPCFnOvTs7+eH9L/I
	 4sAaG6XaCjJ2CYjnIot7rhp7+TLD+mWUHhlV1Ltwa8578B0G7H8vZTLKhMi9tEtDix
	 kXQoYqH4rc/zg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03501073C93;
	Wed,  8 Apr 2026 12:41:51 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH v3 0/4] dmaengine: dma-axi-dmac: Some memory related fixes
Date: Wed, 08 Apr 2026 13:42:39 +0100
Message-Id: <20260408-dma-dmac-handle-vunmap-v3-0-2456ad292154@analog.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw6DIBBFf8WwLg2ConbV/2i6QBiUxldASRvjv
 xdsmrQLF7O4mXvPWZEDa8ChS7IiC944Mw4hsFOCZCuGBrBRISNKKCeM5lj1Ip7E4as6wH4ZejH
 hMhOEK12olDEUxpMFbZ47+Hb/ZLfUD5BzpMVGa9w82tdu9mnsfSX8SOJTTHANDDKutdC8uopBd
 GNzlmOPosXTX05xyKGBQ2iqq1wTKIv6j7Nt2xs7bu+sFwEAAA==
X-Change-ID: 20260325-dma-dmac-handle-vunmap-84a06df7d133
To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775652161; l=943;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=LMqWJzfF94rZChyrIXed1rTS6WeTaHpN2Sas+xgnyR8=;
 b=eiR8vmLkZWNGkruGVJcJLXhrucZQ49hJrYwO99kKDtqx+5Krgy6XkIythBNZgvtd9EjE0FS52
 lSn0kNJPs2OBQdre+ahw3cQjy7IO05Vp9q7AXxKDnlVXVp6AO9mQW20
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9935-lists,dmaengine=lfdr.de,nuno.sa.analog.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[nuno.sa@analog.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,analog.com:email,analog.com:replyto,analog.com:mid]
X-Rspamd-Queue-Id: E98743BC5BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Here it goes v3. Given there are some discussions about adding devlinks
in damengine, I dropped the patch implementing the .device_release() for
now.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
Changes in v3:
 - Drop commit ("dmaengine: dma-axi-dmac: fix use-after-free on unbind")
 - Patch 3:
   * New patch
 - Patch 4:
   * Rework to use DMA Pool API.

---
Nuno Sá (4):
      dmaengine: Fix possible use after free
      dmaengine: dma-axi-dmac: Properly free struct axi_dmac_desc
      dmaengine: dma-axi-dmac: Drop struct clk from main struct
      dmaengine: dma-axi-dmac: Fig BUG() on vunmap()

 drivers/dma/dma-axi-dmac.c | 77 +++++++++++++++++++++++++++-------------------
 drivers/dma/dmaengine.c    |  3 +-
 2 files changed, 47 insertions(+), 33 deletions(-)
---
base-commit: b7560798466a07d9c3fb011698e92c335ab28baf
change-id: 20260325-dma-dmac-handle-vunmap-84a06df7d133
--

Thanks!
- Nuno Sá



