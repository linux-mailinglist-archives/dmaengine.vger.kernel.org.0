Return-Path: <dmaengine+bounces-5986-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C916BB2111F
	for <lists+dmaengine@lfdr.de>; Mon, 11 Aug 2025 18:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 595601883714
	for <lists+dmaengine@lfdr.de>; Mon, 11 Aug 2025 16:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF902D47F2;
	Mon, 11 Aug 2025 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYCjsXXb"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080F92D47EC
	for <dmaengine@vger.kernel.org>; Mon, 11 Aug 2025 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927797; cv=none; b=o0XKg2lpMU72RcG7ntuHstwOhg7HcfVoAA96wz8eBzr48hAJBGY32QsegCkModInvMdkWpLuvFW6PE93m/v+LLA/UupRLmb5iTrNfxDdYI+KLYgvbFOpHvQoj41cSfyrBUKkT1blq/1FWpih0LkLlZIqTQUwjTFmTHOE+8ncHs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927797; c=relaxed/simple;
	bh=WFtUBJqlAhF8dGqTN2nXC1pQiRHrSopQJ1PTtE6d/n0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QfUu2tvlEaE0mUH1r21pb6x4Hqzt3jJoeO02LNd6gSmD5fSH51tiT3Xjr9Hu/qsZl3mMoMvrzsKWAMeu+XVgM0sH52sQ97S72pdJJld6C5Xrx5RuE2Za13OSouDnPTIcpzncyeZ7qViFQ35SFfrIS7jtOCkj6avEyOy+ACjw3ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYCjsXXb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0487C4CEF9;
	Mon, 11 Aug 2025 15:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754927796;
	bh=WFtUBJqlAhF8dGqTN2nXC1pQiRHrSopQJ1PTtE6d/n0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=pYCjsXXbZc571c3XMYzLNQRLqvRVt6RlTxW1bwcnkufktVC0Pn1NB/PE0417QazBJ
	 Y4V5hjsHAvYxJACSN5ZHl/8H3xX+s5O/YbhFJtHalglRCM66FHmJS2pspuMLUOQduP
	 rnrzEt18fxvJLB1oXBqMSgGdu8sW/49674ZTZ1jiSyjDv8Ep8YP6OEnD3+GX+d5Hk2
	 AiM1AJM8uO/WImHJlK2URbwQvcCSOHoeok1qm+arrgrxDfnwKFUkWIVLYXqE7IuoLZ
	 vQcoWAEVvshYmK4el/7Ap1rEBOfw0swO+qfNPUte4HTtmZomEfE4Fy+DzixKEjRlOj
	 VsCYBacqKWrQA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9069FCA0ED3;
	Mon, 11 Aug 2025 15:56:36 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH RESEND 0/4] dma: dma-axi-dmac: fixes and improvements
Date: Mon, 11 Aug 2025 16:56:35 +0100
Message-Id: <20250811-dev-axi-dmac-fixes-v1-0-8d9895f6003f@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754927814; l=827;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=WFtUBJqlAhF8dGqTN2nXC1pQiRHrSopQJ1PTtE6d/n0=;
 b=OyByseYEvyFwEihQe+zOfye+NdGpaIBYrFuWweqMljrNrH7YPk0GE9Z1voM3bzXJB4xF1mg3M
 +l7tpjLOVjMAoc/R2q8FB48R5A340rfeuchZMGWZv3MXJH8x6qCqTmu
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



