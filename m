Return-Path: <dmaengine+bounces-2785-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D65AB945CCE
	for <lists+dmaengine@lfdr.de>; Fri,  2 Aug 2024 13:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F29528335B
	for <lists+dmaengine@lfdr.de>; Fri,  2 Aug 2024 11:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128711DE872;
	Fri,  2 Aug 2024 11:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LI4QrYw/"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D863F14C59C;
	Fri,  2 Aug 2024 11:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722596909; cv=none; b=esWkCel2s6jeX+85xqYtRhUx1tXixiw7PUEeHO7xAQMY6whtJdDPbUSNbB31Dgq27afmcOac6W/8uU4O8JCUqUdAM7J2Uqgbm5u9T1Wy4K9vJs16oUHABQtlnQFG8IKN6beh73Y8UcddvIVKYVzPWOiEVGp/StG0SPxCXfQWjnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722596909; c=relaxed/simple;
	bh=zgrHw3h2FsQ+ar5R5HLD4fj3FgMDxw+ohlAAeoAIebU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Vnx6GOHKT+CTqWWG/NkXjf4SDAbNZ6LWcoFTagPXyxIohKW7s9ccmvF5bMzycPWl+LqC/Lr8NwxQE9lEjAmoz2N4Mk/jwimcxv5TNMgN76ArCudJzFfNGMeoElKJMgTfhuY+DJaZcz/CtBS3Zqx/DsiJIR0WOmiAfUKeiGzIZ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LI4QrYw/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 712BFC4AF0B;
	Fri,  2 Aug 2024 11:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722596908;
	bh=zgrHw3h2FsQ+ar5R5HLD4fj3FgMDxw+ohlAAeoAIebU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=LI4QrYw/l8pSR80E+rTxiQY2cTKqPQqGE9PTK81SXoADRPwLVVm2bIVYhulUM3h8y
	 xjJon7373Z98qNNYXtuw2sWf7JMkrFUCqHu6Hx8R7+f/skcXsbzf7KvRRLiLi03rua
	 qAkIyKyk1Ro0ZgybI3h4vMKbqDN7R4f+WbMsG/UczGaEEarzWk3I1yzcEK9JwGInln
	 IxLhOv7XS1RyD3b7i7LJOfs3R/N8hdbrSYPgF1H5zLTKuNMrgRlRnOuSxf1oifJyCV
	 lChgBxLumpOBXleAkDizSIh/FAQbsV+JQJKKuMOIjYo8qoTFEi/5C8p42gQokHoFyE
	 a7jnKqkh6jeYw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515D2C52D6D;
	Fri,  2 Aug 2024 11:08:28 +0000 (UTC)
From: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>
Subject: [PATCH v11 0/2] Add support for Loongson1 APB DMA
Date: Fri, 02 Aug 2024 19:08:18 +0800
Message-Id: <20240802-loongson1-dma-v11-0-85392357d4e0@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACK+rGYC/2XPy07DMBAF0F+pssbRzLh+seI/EAvHj8SiiVFSI
 qDKv+N0QSOzHEvn3utbs4Q5haV5Pt2aOaxpSXkqB+LTqXGDnfrAki8PDQFxRAJ2yXnqlzwh86N
 lKLmNQSjQnWmK+ZhDTF/3wNe3csc5j+w6zMH+pYAhjYRG8FbQWYJmyN5D/1nK2p+98qUfbbq0L
 o974pCWa56/7wtXuefuKWfgKKstq2TADPhAjjtXWg5B+5ZVHTSZWquiufKd0GWTD6LW+qElqFr
 roqMxhjwJRQJqbQ4aea1N0RI1RnLKBxdqjfDgiv59HGHfjl0EI6yMVh79tm2/2ZKKIecBAAA=
To: Keguang Zhang <keguang.zhang@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722596906; l=3324;
 i=keguang.zhang@gmail.com; s=20231129; h=from:subject:message-id;
 bh=zgrHw3h2FsQ+ar5R5HLD4fj3FgMDxw+ohlAAeoAIebU=;
 b=QXh8VpVynRtj+oFKHNT14Y5r9wOThX7T8Bx4xYTe7gM7zjqxKAQI+GYGOkodShYVch24udHjy
 2hPTVDtfwL+DaIYJAmBSJCbZOtTsaYMsItuRW/GDSnJCAaolVyPayB5
X-Developer-Key: i=keguang.zhang@gmail.com; a=ed25519;
 pk=FMKGj/JgKll/MgClpNZ3frIIogsh5e5r8CeW2mr+WLs=
X-Endpoint-Received: by B4 Relay for keguang.zhang@gmail.com/20231129 with
 auth_id=102
X-Original-From: Keguang Zhang <keguang.zhang@gmail.com>
Reply-To: keguang.zhang@gmail.com

Add the driver and dt-binding document for Loongson1 APB DMA.

---
Changes in v11:
- Use guard notation to acquire the spinlock.
- Fix the build error of LS1X_DMA_LLI_ALIGNMENT.
- Some minor fixes.
- Link to v10: https://lore.kernel.org/r/20240726-loongson1-dma-v10-0-31bf095a6fa6@gmail.com

Changes in v10:
- Implement the hwdescs by link list to eliminate the limitation of the desc number.
- Add the prefix 'LS1X_' for all registers and their bits.
- Drop the macros: chan_readl() and chan_writel().
- Use %pad for printing a dma_addr_t type.
- Some minor fixes.
- Link to v9: https://lore.kernel.org/r/20240613-loongson1-dma-v9-0-6181f2c7dece@gmail.com

Changes in v9:
- Fix all the errors and warnings when building with W=1 and C=1
- Link to v8: https://lore.kernel.org/r/20240607-loongson1-dma-v8-0-f9992d257250@gmail.com

Changes in v8:
- Change 'interrupts' property to an items list
- Link to v7: https://lore.kernel.org/r/20240329-loongson1-dma-v7-0-37db58608de5@gmail.com

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
  as well as .device_pause and .device_resume.
- Set the limitation LS1X_DMA_MAX_DESC and put all descriptors
  into one page to save memory
- Move dma_pool_zalloc() into ls1x_dma_alloc_desc()
- Drop dma_slave_config structure
- Use .remove_new instead of .remove
- Use KBUILD_MODNAME for the driver name
- Improve the debug information
- Some minor fixes

Changes in v5:
- Add the dt-binding document
- Add DT support
- Use DT information instead of platform data
- Use chan_id of struct dma_chan instead of own id
- Use of_dma_xlate_by_chan_id() instead of ls1x_dma_filter()
- Update the author information to my official name

Changes in v4:
- Use dma_slave_map to find the proper channel.
- Explicitly call devm_request_irq() and tasklet_kill().
- Fix namespace issue.
- Some minor fixes and cleanups.

Changes in v3:
- Rename ls1x_dma_filter_fn to ls1x_dma_filter.

Changes in v2:
- Change the config from 'DMA_LOONGSON1' to 'LOONGSON1_DMA',
- and rearrange it in alphabetical order in Kconfig and Makefile.
- Fix comment style.

---
Keguang Zhang (2):
      dt-bindings: dma: Add Loongson-1 APB DMA
      dmaengine: Loongson1: Add Loongson-1 APB DMA driver

 .../bindings/dma/loongson,ls1b-apbdma.yaml         |  67 +++
 drivers/dma/Kconfig                                |   9 +
 drivers/dma/Makefile                               |   1 +
 drivers/dma/loongson1-apb-dma.c                    | 660 +++++++++++++++++++++
 4 files changed, 737 insertions(+)
---
base-commit: 048d8cb65cde9fe7534eb4440bcfddcf406bb49c
change-id: 20231120-loongson1-dma-163afe5708b9

Best regards,
-- 
Keguang Zhang <keguang.zhang@gmail.com>



