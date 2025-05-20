Return-Path: <dmaengine+bounces-5212-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE8FABD97E
	for <lists+dmaengine@lfdr.de>; Tue, 20 May 2025 15:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6AEE4C3920
	for <lists+dmaengine@lfdr.de>; Tue, 20 May 2025 13:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DCD2417E4;
	Tue, 20 May 2025 13:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oH54qChz"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E55522D7B8
	for <dmaengine@vger.kernel.org>; Tue, 20 May 2025 13:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747747910; cv=none; b=FVTUT95VtR1KhAQz4MVwiqf7EHDEsj7kz7V0KGwV/YMSmsYCNbAlb0iZJt3Ww1I/vaM+CB2tjjX+8TDmDvpLKckYC8oUWZE4BmLms1r2mYs/ENGJeuNTkfFC57kpDkbof2YG8epgixXG+Q8JLK+bnFvnVT83tYgIPcPbMed+zxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747747910; c=relaxed/simple;
	bh=bQplEFaliKEKoH2ZDbrTHL2azpLej98i3LppExx6HI0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RzErVdWOHz+SmPKqmD4r/bY2I0AbmAQBxB6xkljOoExbB10SXLWLnvaIFIT7uz2Hbie6F1kgYhJJ/mxsDQJq68Zovmw1Xrfrxu12+a4srt6AzKPWOE6gSUsrAAXAcrowDeqgX6/Ln2o3GJW5FnEI5tPAKGijQzJYzIo0VgkimnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oH54qChz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 110A1C4CEE9;
	Tue, 20 May 2025 13:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747747910;
	bh=bQplEFaliKEKoH2ZDbrTHL2azpLej98i3LppExx6HI0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=oH54qChztWL3Zbjl6PXEpa8JozNDr2BHfm0/wZs0C8SlNGrrDuZCWHGLwFUis2ryS
	 SWmslPdqmil8Z7PrP4hlPLUe5fWim5MMdFQAmKFXQ1G4S/LLSbMtD760TFSWSIEMdP
	 ir3DzGhe+OkkELUxiqGC1YZHQOnjMpveL45CIcHdFmXqUN2jtykqp4zJe5HPdlMg/q
	 p28Zlb8QzgVJ24pG26WlEsb6cPppLa2ooj2ManPPA0MAZFQ3pd76R7kYMdCT4kv92X
	 kUvK9/m/U/P5yYtLJWjM/UuU4H49WCuxuJcF8BnXSY/GKAx7Q2oPcUaonnrxEm3QKz
	 94StTZCT+ZLlg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1284C3DA6D;
	Tue, 20 May 2025 13:31:49 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH 0/4] dma: dma-axi-dmac: fixes and improvements
Date: Tue, 20 May 2025 14:31:50 +0100
Message-Id: <20250520-dev-axi-dmac-fixes-v1-0-b849ea23f80b@analog.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEaELGgC/x3LQQqAIBBA0avErBvQQaG6SrSQnGoWWSiIIN49a
 fn4/AqJo3CCZagQOUuSJ3TocYD9cuFkFN8NpMgqSwo9Z3RF0N9ux0MKJzTaKmKj/TwR9PGN/If
 +rVtrH8O2ypNkAAAA
X-Change-ID: 20250520-dev-axi-dmac-fixes-41502e41d982
To: dmaengine@vger.kernel.org
Cc: Paul Cercueil <paul@crapouillou.net>, 
 Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747747912; l=791;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=bQplEFaliKEKoH2ZDbrTHL2azpLej98i3LppExx6HI0=;
 b=NkJGwJtQBYB6Yx01OpTnqgU1nxKwFcABMV36cmNR6J4JBrbawFnZ/UbT3aKzcYCz3eWvFFQSO
 NXsVRuYuOvwBM88MfPVd7AGMbg3Gp9NdZb3EXU6e+szYD20bxgclwTk
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



