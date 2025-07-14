Return-Path: <dmaengine+bounces-5806-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8750DB0446B
	for <lists+dmaengine@lfdr.de>; Mon, 14 Jul 2025 17:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5561D166F34
	for <lists+dmaengine@lfdr.de>; Mon, 14 Jul 2025 15:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B64A25BF1B;
	Mon, 14 Jul 2025 15:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNRZNXWJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1518E253F30
	for <dmaengine@vger.kernel.org>; Mon, 14 Jul 2025 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507541; cv=none; b=W6Lz0uHkH304Qhiwl1+MI6XuPGIGkE+rKqapBkhG3ljQ3h1LdTSZ5WF6x3SMNE0AkHrXN7ZJkeupFjTScIfMS5VPlWW4NrUnRtiv/O5ZlYabccmLZttLidGtblKuQnZiO02tEsOsAI7K2U3ThcwYya+nTCooVyup3w1D8P5H+ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507541; c=relaxed/simple;
	bh=WFtUBJqlAhF8dGqTN2nXC1pQiRHrSopQJ1PTtE6d/n0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SpqoYl6HEZbrjPjH8DWFvMGzMS612cG3grCp19U8vepdCo72yzgjgda4kHml9fkFAV8Oh0FzENIQ6L6nDPY6iSzeQXYxCDckxZAiS9eiNpUNW8MYrJWZZbAk/m4b05OROrdJUKeeqtNabJ32Wdm1+KRhwompbTiyI3q6lLtmL/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNRZNXWJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 985A9C4CEF0;
	Mon, 14 Jul 2025 15:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752507540;
	bh=WFtUBJqlAhF8dGqTN2nXC1pQiRHrSopQJ1PTtE6d/n0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=mNRZNXWJvGdrLj9JY7XDNmhWwS3YyKj6cW6fZL7BRngZYcidjJH0EoSKJO7qRZPjP
	 rfYcOm8towkYtytGTECw7Jt13UotUySxLXfS62GSow+WVqF4GY/xMdvVDjLt9F48rW
	 1knMpTTt8MRpBA1Njm4Xc6lbkmx6EMQVKTcC9NZjeTSJAYcHN/XpO2KBHcXnIoxHhJ
	 QRssb46NIXQVl0iFzR3YeflWW+6Hu2WGtjOZAuk+8+oX7//teX6Br72+DU9g8tBN0w
	 JC3Wzv4vNX9cid1bV+QoPIdH0Xj4f2CTUDGYPMu+0feGTxyxRpoUR/3O9X8gNA06iI
	 bG4S7j3cID8jQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890BAC83F17;
	Mon, 14 Jul 2025 15:39:00 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH RESEND 0/4] dma: dma-axi-dmac: fixes and improvements
Date: Mon, 14 Jul 2025 16:39:06 +0100
Message-Id: <20250714-dev-axi-dmac-fixes-v1-0-c3888b0d671b@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752507553; l=827;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=WFtUBJqlAhF8dGqTN2nXC1pQiRHrSopQJ1PTtE6d/n0=;
 b=3ok2fFkrfW44j04sii5qHrmmXVYMG2uUVYPY8C0t+W0kYm8PyeMIvmb+x/kK6BoawGjpMxtUD
 MiLZ3qFXykNDw9HU5R7eRH0/5MeQeNBmot/apEUVAvTHr9U2vnzX1+4
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



