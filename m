Return-Path: <dmaengine+bounces-5667-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA06AEBAE1
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 17:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0FA31C202B7
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 15:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B0122F75C;
	Fri, 27 Jun 2025 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHXlsQPS"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65CD1494D8
	for <dmaengine@vger.kernel.org>; Fri, 27 Jun 2025 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751036421; cv=none; b=SfsvAQYty7bdvQdNX+WXLvamw8GNtS4J8LZvXvpL7PcS7/bHF1YGdinEGF9gS4Z1tlciZe8h3bayKbZcNdFsBufEHfEhYt3YGn5zSIwzrDfCdi9FxfX+Mic+9POhNI0HDCgOVB0cmRtvTdzmztrK3RttBTv4bXHznJzw4vebTqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751036421; c=relaxed/simple;
	bh=WFtUBJqlAhF8dGqTN2nXC1pQiRHrSopQJ1PTtE6d/n0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=soj6ET4cTNQrweIvpnrKBoiTTWdmCba8rkl6QlHwsAiRYZM2pGJXkfnWOa+sjMfioW2Aeaow67qK9C7Ozzf09bFdMKMZDlY0MXTNo7V/2BwEK/YkXMqFbmxkIZtp4KEVTnEe0/Jb5sO37MS4WDrCUtZN/bzDYleMLNslkR3Xrb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHXlsQPS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA286C4CEE3;
	Fri, 27 Jun 2025 15:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751036420;
	bh=WFtUBJqlAhF8dGqTN2nXC1pQiRHrSopQJ1PTtE6d/n0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=BHXlsQPS49gMVJ9rDb9ijih/7vQeveMwvwIh2P6oplGbZNwtW0l8RKamW+I1g54uU
	 RyJnwi24L2MORNeeLpx+BvGzuo3VPZ2xzGzvMFLVhj068M7zG+P68W4AY313524Ffq
	 qB07Xz9+W/Mssg1pGYU2fiRTT4vDwAh6aISpP5Bo9bS9NtfQqV5zA6LFdeMvo3ceYC
	 OBnPhTAUvOx1v1n27jSFKZ2LKmNjMAW318xXwpE/K1Tp7fHq8yOpSGRlVi+4Ot7Ibo
	 vVi8NO097t5BbVjp/i3Jp4MQQxjiHhOLKONCpVXefwImKf1noOHLVyZ757gHW3ps9N
	 c/rzNoe7ATt4Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2430C7EE2A;
	Fri, 27 Jun 2025 15:00:20 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH RESEND 0/4] dma: dma-axi-dmac: fixes and improvements
Date: Fri, 27 Jun 2025 16:00:18 +0100
Message-Id: <20250627-dev-axi-dmac-fixes-v1-0-2453674c5b78@analog.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: dmaengine@vger.kernel.org
Cc: Paul Cercueil <paul@crapouillou.net>, 
 Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751036430; l=827;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=WFtUBJqlAhF8dGqTN2nXC1pQiRHrSopQJ1PTtE6d/n0=;
 b=rwKLeV4clHbtKbO46tPy5Npbyhyofib+qEPBzgceDrrntX4FhOKkW8Syqd7ONhihs4RchYOqO
 I3TfU/oH6pGDutnrVguGP1duJQgFXa/boiMRK+xwa9hcj3oOzvlErjX
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

This series adds some fixes to the DMA core with respect with cyclic
transfer and HW scatter gather.

It also adds some improvements. Most notably for allowing bigger that
32bits DMA masks so we do not have to rely on bounce buffers from
swiotlb.

---
Nuno Sá (4):
      dma: dma-axi-dmac: fix SW cyclic transfers
      dma: dma-axi-dmac: fix HW scatter-gather not looking at the queue
      dma: dma-axi-dmac: support bigger than 32bits addresses
      dma: dma-axi-dmac: simplify axi_dmac_parse_dt()

 drivers/dma/dma-axi-dmac.c | 48 +++++++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 15 deletions(-)
---
base-commit: 3c018bf5a0ee3abe8d579d6a0dda616c3858d7b2
change-id: 20250520-dev-axi-dmac-fixes-41502e41d982
--

Thanks!
- Nuno Sá
-- 
Nuno Sá <nuno.sa@analog.com>



