Return-Path: <dmaengine+bounces-1654-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBE58917B3
	for <lists+dmaengine@lfdr.de>; Fri, 29 Mar 2024 12:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50BFE1C22977
	for <lists+dmaengine@lfdr.de>; Fri, 29 Mar 2024 11:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9166A33A;
	Fri, 29 Mar 2024 11:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyQfeNIq"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4CE13ACB;
	Fri, 29 Mar 2024 11:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711711678; cv=none; b=i8NI5JynF7rrk4Yy6fiSm4bnvAL7pwLmMb27sSoJwZYBhA9LPedLe833axi8VDfZxgYKg88lLsEiawFsVckDg76lPAn7+wuCtt77zyb2id0JxVRkjYtHWDP9sxKwxIl0w+T1tOwz3lcioCEB4L2SXfoLce707EXMn2pvpic3mPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711711678; c=relaxed/simple;
	bh=pB9M95X+mXq7mLeBjyS+gbUvkiSUn2UFn0TswCd0KdU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N5mcbWr74Nx2Vu9aRBil8hKxDw4ylv8TaLYe8mul97I+rVdQ3AsOkL687bf+qVE+VhBtE8x9pccK+QkgUYDQYSC6DmAu1hLsXPfs0kfqWQ2Umc/8zECMjESQtihTm6DakvdGs5NYHMnUY8G8cC1wr9B1oX59vBzygepkq32B8AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyQfeNIq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DFAC7C433C7;
	Fri, 29 Mar 2024 11:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711711678;
	bh=pB9M95X+mXq7mLeBjyS+gbUvkiSUn2UFn0TswCd0KdU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=lyQfeNIqdlYFPgYQh+txECZJoEuFvve/z+oCprMXe1fckZL9pI9PSmChdFS5znexm
	 6++1MDuXJ7OZ6OhzBjDExEbJOmSmnIhkKYVUDJFtp5zFXrdFXHYqaV4W1HhmPvAYiq
	 EfnuWggK63d/R3uVfXPdBkQvQt0N40lZj2fYBEmTwc7DC7k4fBYlrh4VLCsBYDyLSc
	 0CXuza/DXT40Qd3lTfkkYspm3RWGe4I379iGOPNo1RxT0KIuLIo7bKoyew/6abEQBx
	 VVwd5xe0bfj2o0qtQEXwcYpW2nrEm2Ya7APgwC5WcLAAOgV3GmCBTGDqsoFul7OMRD
	 +1dnYpx5GjO8g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A86CD128A;
	Fri, 29 Mar 2024 11:27:57 +0000 (UTC)
From: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>
Subject: [PATCH v7 0/2] Add support for Loongson1 APB DMA
Date: Fri, 29 Mar 2024 19:26:56 +0800
Message-Id: <20240329-loongson1-dma-v7-0-37db58608de5@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIClBmYC/12Oyw6CMBQFf8V07SV9QKGu/A/DopZLaQRqWiQq4
 d8tLIxxOYszcxYSMTiM5HRYSMDZRefHBOXxQEynR4vgmsSEUy4Y4xR670cb/cigGTQwKXSLRUm
 rqyJpcw/Yuufuu9SJ2+AHmLqA+muhileMM1WIrOC5pBUwuKF9pFj23pJnO2jXZ8YPm7FzcfLht
 R+c5ebdLDkVTP59mSVQULRBboQxqfIjqtd1/QCOc4A+7AAAAA==
To: Keguang Zhang <keguang.zhang@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Huacai Chen <chenhuacai@kernel.org>
Cc: linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711711676; l=2386;
 i=keguang.zhang@gmail.com; s=20231129; h=from:subject:message-id;
 bh=pB9M95X+mXq7mLeBjyS+gbUvkiSUn2UFn0TswCd0KdU=;
 b=fmvKGnrYZtLwAB8SPn36qCHcowVqWJ110I6MjqN4/qCkPrpXsomsDoPZfb60T9iPbrzHQV34u
 46ub50gRDCfBEJNfRtmCbaHqK2yFVOq6VpDZLD2/niLBdanVa6gjwnZ
X-Developer-Key: i=keguang.zhang@gmail.com; a=ed25519;
 pk=FMKGj/JgKll/MgClpNZ3frIIogsh5e5r8CeW2mr+WLs=
X-Endpoint-Received: by B4 Relay for keguang.zhang@gmail.com/20231129 with
 auth_id=102
X-Original-From: Keguang Zhang <keguang.zhang@gmail.com>
Reply-To: keguang.zhang@gmail.com

Add the driver and dt-binding document for Loongson1 APB DMA.

Changes in v7:
- Change the comptible to 'loongson,ls1*-apbdma' (suggested by Huacai Chen)
- Update the title and description part accordingly
- Rename the file to loongson,ls1b-apbdma.yaml
- Add a compatible string for LS1A
- Delete minItems of 'interrupts'
- Change patterns of 'interrupt-names' to const
- Rename the file to loongson1-apb-dma.c to keep the consistency
- Update Kconfig and Makefile accordingly
- Link to v6: https://lore.kernel.org/r/20240316-loongson1-dma-v6-0-90de2c3cc928@gmail.com

Changes in v6:
- Change the compatible to the fallback
- Implement .device_prep_dma_cyclic for Loongson1 sound driver,
- as well as .device_pause and .device_resume.
- Set the limitation LS1X_DMA_MAX_DESC and put all descriptors
- into one page to save memory
- Move dma_pool_zalloc() into ls1x_dma_alloc_desc()
- Drop dma_slave_config structure
- Use .remove_new instead of .remove
- Use KBUILD_MODNAME for the driver name
- Improve the debug information
- Some minor fixes
- 
Changes in v5:
- Add the dt-binding document
- Add DT support
- Use DT information instead of platform data
- Use chan_id of struct dma_chan instead of own id
- Use of_dma_xlate_by_chan_id() instead of ls1x_dma_filter()
- Update the author information to my official name
- 
Changes in v4:
- Use dma_slave_map to find the proper channel.
- Explicitly call devm_request_irq() and tasklet_kill().
- Fix namespace issue.
- Some minor fixes and cleanups.
- 
Changes in v3:
- Rename ls1x_dma_filter_fn to ls1x_dma_filter.
- 
Changes in v2:
- Change the config from 'DMA_LOONGSON1' to 'LOONGSON1_DMA',
- and rearrange it in alphabetical order in Kconfig and Makefile.
- Fix comment style.

---
Keguang Zhang (2):
      dt-bindings: dma: Add Loongson-1 APB DMA
      dmaengine: Loongson1: Add Loongson-1 APB DMA driver

 .../bindings/dma/loongson,ls1b-apbdma.yaml         |  65 ++
 drivers/dma/Kconfig                                |   9 +
 drivers/dma/Makefile                               |   1 +
 drivers/dma/loongson1-apb-dma.c                    | 665 +++++++++++++++++++++
 4 files changed, 740 insertions(+)
---
base-commit: a6bd6c9333397f5a0e2667d4d82fef8c970108f2
change-id: 20231120-loongson1-dma-163afe5708b9

Best regards,
-- 
Keguang Zhang <keguang.zhang@gmail.com>



