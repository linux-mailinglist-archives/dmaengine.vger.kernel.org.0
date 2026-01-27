Return-Path: <dmaengine+bounces-8514-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPn1DcIweGk2owEAu9opvQ
	(envelope-from <dmaengine+bounces-8514-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 04:28:02 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B678F91C
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 04:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9860E302689D
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 03:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90016309EE5;
	Tue, 27 Jan 2026 03:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XydDZ319"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEFB284663;
	Tue, 27 Jan 2026 03:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769484479; cv=none; b=uVpM6rZ+VrHSwo4znxtmrw61ea2y2Cf70KMzISPjV54WoXMMNhK7GZzByn3L00M6TlEPYjCyv+9Bu5J1dloWRP1Ai5ShMeKZ6IJzQaNOM8P4bTBuTd+84o83kfHECZ/lY6BmBqf/YL2O6Hs8F1USR27KqhZSlAH5+LsHM+T/bZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769484479; c=relaxed/simple;
	bh=82UInUPaZAsuTnm7Eq2Rk6+iYxY2ts69JzilZc2OUsQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N2tjARn3qf8CGwwEK1f5SSHIXgas36hZ2r0NXkegOw3VF9HMZBOKEpOGE1gko57D0bMDVHiM8Wvr6uPBE8kgkRaCw5UxBWFd+xP3gC2DM0BvjnMr81dKruUdS0u0Q4x3OvZAiWxvjhJ2hISHAqSsHhyKXFfKL8CokMamH5j8vYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XydDZ319; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32FD4C116C6;
	Tue, 27 Jan 2026 03:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769484479;
	bh=82UInUPaZAsuTnm7Eq2Rk6+iYxY2ts69JzilZc2OUsQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=XydDZ319/gvkFBkAWnYNjt25ao4WR3bvRPCk6It5k1K+z4Euvj+kn3oXIjz+3SP7Y
	 +6noowqFxso1ZLhMZFWyrLIIwweg2i06hfCoTodB5pcvOXHVVwruR+EuCeCNVLdbtS
	 06k6z90IHyuiiLNBFn3PvXieXJO8vj70x8k2AQAXNqSc6K+1UZehG8k4wGTHwQzHGw
	 mKjd5JuhmHylDMb7whhhjFTsG+lGeOT4xcTxwH56LnqEN09aXURjM6IvxGZ/pVAt+A
	 /ZQdwsEPRm8xjoV3ihX+zfL6QDKCtuokFYpPPjQBAMAXx62b/p2sZTxucBsNERx6zK
	 nFc7CBxZa/nGw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200A2D25920;
	Tue, 27 Jan 2026 03:27:59 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v2 0/3] Add Amlogic general DMA
Date: Tue, 27 Jan 2026 03:27:51 +0000
Message-Id: <20260127-amlogic-dma-v2-0-4525d327d74d@amlogic.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALgweGkC/1XMQQ7CIBCF4as0sxZTSAFx1XuYLgiM7SRSDBiia
 bi72OjC5T+T922QMRFmOHcbJCyUKa4txKEDt9h1Rka+NYheSC64ZDbc4kyO+WCZNoPWXjov1AB
 tcU94peeuXabWC+VHTK8dL/xz/Tnqzymc9QzFyaDUaJTV4/d7dDHAVGt9A/rhUiKoAAAA
X-Change-ID: 20251215-amlogic-dma-79477d5cd264
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769484476; l=1154;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=82UInUPaZAsuTnm7Eq2Rk6+iYxY2ts69JzilZc2OUsQ=;
 b=5pfGRD1ecIIB6hxFANgbOJ1NQmMd6kd+5Feseh7D/qlkLzwYFtI7HdbLloiExbeHw/v7Hsk5T
 EwCisl719kzCxW9iU3KyLM1/qj+3l2h1IAByGyQMcsZlhF09uAbbavS
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8514-lists,dmaengine=lfdr.de,xianwei.zhao.amlogic.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[xianwei.zhao@amlogic.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amlogic.com:replyto,amlogic.com:email,amlogic.com:mid]
X-Rspamd-Queue-Id: A5B678F91C
X-Rspamd-Action: no action

Add DMA driver and bindigns for the Amlogic SoCs.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Changes in v2:
- Introduce what the DMA is used for in the A9 SoC.
- Some minor modifications were made according to Krzysztof's suggestions.
- Some modifications were made according to Neil's suggestions.
- Fix a build error.
- Link to v1: https://lore.kernel.org/r/20251216-amlogic-dma-v1-0-e289e57e96a7@amlogic.com

---
Xianwei Zhao (3):
      dt-bindings: dma: Add Amlogic A9 SoC DMA
      dma: amlogic: Add general DMA driver for A9
      MAINTAINERS: Add an entry for Amlogic DMA driver

 .../devicetree/bindings/dma/amlogic,a9-dma.yaml    |  70 +++
 MAINTAINERS                                        |   7 +
 drivers/dma/Kconfig                                |   9 +
 drivers/dma/Makefile                               |   1 +
 drivers/dma/amlogic-dma.c                          | 563 +++++++++++++++++++++
 5 files changed, 650 insertions(+)
---
base-commit: 3c8a86ed002ab8fb287ee4ec92f0fd6ac5b291d2
change-id: 20251215-amlogic-dma-79477d5cd264

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



