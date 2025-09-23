Return-Path: <dmaengine+bounces-6695-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7E9B94F8A
	for <lists+dmaengine@lfdr.de>; Tue, 23 Sep 2025 10:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068DD164D47
	for <lists+dmaengine@lfdr.de>; Tue, 23 Sep 2025 08:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B74031A056;
	Tue, 23 Sep 2025 08:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFLAhRRi"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEBE2E92BC
	for <dmaengine@vger.kernel.org>; Tue, 23 Sep 2025 08:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758615788; cv=none; b=rHpFs4SDkQXmvMz2yPCK32DlQrmNiqZXkZqOsuBni3UpuTYldQfKQdMwUFhsfh3v+n6V1pVuw59lnUfHHidIaVo5hV/HfFrRrVlO+nPbIIlzMgIyPKcA9xvW+lzlloAbYHg1gJE5K/dsQWW53cgzYhSfA8ybnpastS1+ah2FTaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758615788; c=relaxed/simple;
	bh=aEcU6mSTdWkmiEX7gNxqh2qLkoNW20dvqKm8ckSwD/c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BA3OH1CbzpHUxc9Vq3BzF/i0TSRafEV6MYH3hd+pmRl5E8WWcO2yW73HVr32BDIb8habmq4Q5QWuy1aSi59s3/kqcLpvDj1cTRc+ZwoG+4QsROzDJFOHsH2EjKvsYzydL7nM03V+4DlNMTlytebSTUfsAbF3EW1jgvA4FKk0ha4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFLAhRRi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6EA1CC4CEF5;
	Tue, 23 Sep 2025 08:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758615788;
	bh=aEcU6mSTdWkmiEX7gNxqh2qLkoNW20dvqKm8ckSwD/c=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=nFLAhRRiSIwE1Zius5Cpd7gkO0WJ9Tv238uAo8RXCU1jtpHkBCrx3rfVfZ82xTnTZ
	 Ys6FgxNwgaIoyTcWIOlBh7kHiVT0xLp03Sv0ms/iBb2tJpxTx/0lRjHVi8kjf7SjOk
	 4fC6MGORXm8Ld8gl4lPh9S4olWfrKBrngAAdCXjPZFBPr6xfXsglGv6X9t4MD1zvk/
	 xK4epQWjLaHedhdYyrDFSpKNb9uO+++KkOrod/JRcCgx215KeFyIthw+04he7EsG1r
	 /WruoI+c68j49sb6PDu08H2kMvBX6Mc6BOnwv6wIcWsAuQUtNjPpLn6kHWG26mAgLv
	 H2K7KnbnpL2gA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD35CAC5B0;
	Tue, 23 Sep 2025 08:23:08 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH RESEND 0/4] dma: dma-axi-dmac: fixes and improvements
Date: Tue, 23 Sep 2025 09:23:34 +0100
Message-Id: <20250923-b4-dev-axi-dmac-fixes-v1-0-5896dcbbd909@analog.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAZZ0mgC/x3LuwqDQBBG4VeRqR3QIQZMra2FKSXFXv5NpvDCL
 oggvrtLyo/DOSkhKhK9ipMidk26Lhl1WZD7meULVp9NUklTtSJsH+yxszmU/WwcBz2Q2NrwlOA
 boHWU3y3iH/I60di/+6Gjz3Xddxj4728AAAA=
X-Change-ID: 20250922-b4-dev-axi-dmac-fixes-bbf62fd5ee9c
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Paul Cercueil <paul@crapouillou.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758615815; l=794;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=aEcU6mSTdWkmiEX7gNxqh2qLkoNW20dvqKm8ckSwD/c=;
 b=jtQbHQyTX3z+s2B0dfVGKudcqIclK98s6CBhhMTYpem83HtdpHKle4a474nE88KR6SkLuJ77E
 Tgxc6uH7uxyBNAnpfyZ0Q0rQDoVBo5IiOdNTpZ+phcEKTn0DBwjs6K+
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
base-commit: cc0bacac6de7763a038550cf43cb94634d8be9cd
change-id: 20250922-b4-dev-axi-dmac-fixes-bbf62fd5ee9c
--

Thanks!
- Nuno Sá



