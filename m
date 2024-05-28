Return-Path: <dmaengine+bounces-2188-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BDC8D1431
	for <lists+dmaengine@lfdr.de>; Tue, 28 May 2024 08:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 729F92838E5
	for <lists+dmaengine@lfdr.de>; Tue, 28 May 2024 06:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5861650297;
	Tue, 28 May 2024 06:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="us73uEGj"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8AD4D11B;
	Tue, 28 May 2024 06:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716876565; cv=none; b=Ve/aRsjIIe2zHscHOC8gDfOwYpEAd326vTOnmHtjbN0Da+TK1kfGTzZNwGMZW11LGD9U3HotJOFzG43LD8EfAphd+gpbGrIeHtZT16nYKwuROdouUS6x/zWFR10KNr0ExT6+alOuxGxY6glunnRCMSIZx4JygfzRJGWkqLOJq1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716876565; c=relaxed/simple;
	bh=yL9QuRyCclHUhhy3AcGDuaeU09XaZ3aXaTF2FrRGqEQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OSoweSt6w/mzBWFBc9RC0B9erqxoBu1ZUa3Knb9eLNpoUagtP+8eQKc5TMMprK6jIPonODUnfb7IS4xiWkbsPBDZTWtGYZzBEh3IBQmBmyFBtRrhVdgEJiu/mDr2qjDycibGjKylYWIunhaXN0f+Fniuwwy2wlnxDmE0BcfO+sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=us73uEGj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9BF2C3277B;
	Tue, 28 May 2024 06:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716876564;
	bh=yL9QuRyCclHUhhy3AcGDuaeU09XaZ3aXaTF2FrRGqEQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=us73uEGjnmXxoVlTmdl967pSD78BNNqud12LFijTKsZ1Bm1FkQ7zo73RMV5o6hgwl
	 rKNcCFR4a+ELHaPxcspIISmS2X9Eb8MQ4Z3s8Ygw7Qk4AzBUvlfC2aLTr88x8jAKV0
	 DOSRa96vRPaixa1kgKKHYjVqbCUpi8Fw8dj8bAyeE4rJ0hwS4aPw8o43HTP18XcavV
	 IeRppfFRgamIMdCMD9FG+HEa+Tpgjh2Y5BxHGGSfxiQHGOyxv1U3VhmcmXPi8M2QWq
	 kFA5dLvsTplDyM5JGD3RwZPhxJJ6QVVwus1p0MLRb/vB7IJQc0UdioaMnjDu7AHO9S
	 lfPaBB8/iShdw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38BCC25B78;
	Tue, 28 May 2024 06:09:24 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+n.shubin.yadro.com@kernel.org>
Subject: [PATCH v2 0/3] dmaengine: ioatdma: Fix mem leakage series
Date: Tue, 28 May 2024 09:09:22 +0300
Message-Id: <20240528-ioatdma-fixes-v2-0-a9f2fbe26ab1@yadro.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABJ1VWYC/3WNMQ6DMAxFr4I8NxVEIKBT71ExOI5TPEAqB6Eix
 N0b2Du+9/X0d0iswgkexQ7KqySJcwZ7K4BGnN9sxGcGW9q6bGxtJOLiJzRBvpwMdoHIY+9820N
 uHCY2TnGm8awmTAvrOXyUryLb15B5lLRE3a7ftTrtv4u1MqVxbdeEKrRIRM8NvcY7xQmG4zh+i
 CioVsMAAAA=
To: Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
 Logan Gunthorpe <logang@deltatee.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux@yadro.com, 
 Nikita Shubin <n.shubin@yadro.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716876563; l=1143;
 i=n.shubin@yadro.com; s=20230718; h=from:subject:message-id;
 bh=yL9QuRyCclHUhhy3AcGDuaeU09XaZ3aXaTF2FrRGqEQ=;
 b=K4gvr1A5/gyMVLHQfIfsxddXfjDgycKJo70pdAg85txaURyEa+qlUCFPsS5oPFoUE7Sg1sKc6lG8
 rm8wd6zPD+hBhf85i+hCRkyQERBYdLmxp7yd95vJWjTCJIIqhNon
X-Developer-Key: i=n.shubin@yadro.com; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for n.shubin@yadro.com/20230718 with
 auth_id=161
X-Original-From: Nikita Shubin <n.shubin@yadro.com>
Reply-To: n.shubin@yadro.com

Started with observing leakage in patch 3, investigating revealed much
more problems in probing error path.

Andy you are always welcome to review if you have a spare time.

Thank you Andy and Markus for your comments.

Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
---
Changes in v2:
- dmaengine: ioatdma: Fix error path in ioat3_dma_probe():
  Markus:
    - fix typo

- dmaengine: ioatdma: Fix kmemleak in ioat_pci_probe()
  Andy:
    - s/int/unsigned int/
    - fix spelling errors
    - trimmed kmemleak reports

- Link to v1: https://lore.kernel.org/r/20240524-ioatdma-fixes-v1-0-b785f1f7accc@yadro.com

---
Nikita Shubin (3):
      dmaengine: ioatdma: Fix leaking on version mismatch
      dmaengine: ioatdma: Fix error path in ioat3_dma_probe()
      dmaengine: ioatdma: Fix kmemleak in ioat_pci_probe()

 drivers/dma/ioat/init.c | 54 ++++++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 25 deletions(-)
---
base-commit: 6d69b6c12fce479fde7bc06f686212451688a102
change-id: 20240524-ioatdma-fixes-a8fccda9bd79

Best regards,
-- 
Nikita Shubin <n.shubin@yadro.com>



