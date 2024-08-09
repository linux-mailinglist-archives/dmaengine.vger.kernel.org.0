Return-Path: <dmaengine+bounces-2826-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F7F94CE9E
	for <lists+dmaengine@lfdr.de>; Fri,  9 Aug 2024 12:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9FD71C2163A
	for <lists+dmaengine@lfdr.de>; Fri,  9 Aug 2024 10:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52202190490;
	Fri,  9 Aug 2024 10:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CD8tFFN6"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2616DBA41;
	Fri,  9 Aug 2024 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723199498; cv=none; b=st5/4CdDCJedm2YGnL37hx+lrRoHuNO6FveVHV/PSMbGEDP4qsDFovF6I2c+sYLEwJdyHKnTnpvgII9FoXiPojCaT5u40rDWYPeCdm4uEtQzpOqLAVcdKfP/aeM5LZZm7Hrm1LJSDQXVcX5KXJdFwTYnO1An45VKwtdFs/BBDHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723199498; c=relaxed/simple;
	bh=Pyn9R7CbJk7AzCg1pklE2Ub+hkwoAnfgt2o4mUVn1Vk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mhLBspRbjT43zhiWtkLhDe4XqcCT7DI7eyEEBtkHfCu5hwzcxBF0NouUM4+0EJeUG21NYODgZJ3bucT2M2bRllqeTVS44ZqKBYAFBEls/TgLbnVuHGdTPXNkNVHEUm4wkRBBh+/MeXuJ4rM4HZgmpjtJmc4JKmR0xtHpJ3LNr3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CD8tFFN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9DC01C32782;
	Fri,  9 Aug 2024 10:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723199497;
	bh=Pyn9R7CbJk7AzCg1pklE2Ub+hkwoAnfgt2o4mUVn1Vk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=CD8tFFN6LHhrM2NTgk7YtGS/7v28M7++MeGWSrBbfHhbOs7ekHy7a3aD/kurb9sPP
	 ZB6zYgs/gw4r6F07CC2jb4OFymVmPGgxYYePxegI+tmPcqJjCAdRfb5yKI0POOgxNO
	 UYpy5gy8wEoux5S/V8A6qvYVNX7Yg5cSPJkl67itGNsqADXV/gfI2HDcR7gE3Gp/cG
	 grX/fSHmbZy3EnxhVf5UhCyYY+jO8xsriyI695SvDgAIPDAQldFwcxN9ikhx238dDL
	 HrazhnJMSXtM3PfZInjNVHxoOtT4Cxp2DklHUO7om94qHgxgmhzKtdLsO54e0WEVZ3
	 KDmwXHFCTgZ6Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898DAC3DA4A;
	Fri,  9 Aug 2024 10:31:37 +0000 (UTC)
From: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>
Subject: [PATCH v12 0/2] Add support for Loongson1 APB DMA
Date: Fri, 09 Aug 2024 18:30:57 +0800
Message-Id: <20240809-loongson1-dma-v12-0-d9469a4a6b85@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOHvtWYC/2XPTU7DMBAF4KtUWeNqZlz/seIeiIVrj1OLJkZJi
 YCqd8fpghZ3OZa+957P3cxT5rl73py7iZc85zLWA+lp04WDH3sWOdaHjoAkIoE4ljL2cxlRxME
 L1NInVgbs3nXVfEyc8tc18PWt3mkqgzgdJvZ/KeDIIqFTcqtop8EKFO/cf9ay7c9a+dIPPh+3o
 Qxr4iHPpzJ9Xxcues1dU3YgUTdbFi1AOIhMQYZQW+6C1i2LudPkWm2qlibula2bIqtW25vWYFp
 tq07OOYqkDClotbvTKFvtqtZoMVEwkQO3GuHGDT18HGHdjvsETnmdvH7wePMW6MFj9VZJR1KZu
 ON/6y+Xyy/5SKoLJwIAAA==
To: Keguang Zhang <keguang.zhang@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723199495; l=3921;
 i=keguang.zhang@gmail.com; s=20231129; h=from:subject:message-id;
 bh=Pyn9R7CbJk7AzCg1pklE2Ub+hkwoAnfgt2o4mUVn1Vk=;
 b=y23OmK3eYx48ro7Gjodr0rifohygfq4gBEa5U9XhQFBKIN3fjy5zJ6PtyYCqK6BE827HWNxqh
 FRD+loTt6c6DWn0sVu7mcehRF80/YCEI6g2yJCH+SBrAmVBSo3tx55n
X-Developer-Key: i=keguang.zhang@gmail.com; a=ed25519;
 pk=FMKGj/JgKll/MgClpNZ3frIIogsh5e5r8CeW2mr+WLs=
X-Endpoint-Received: by B4 Relay for keguang.zhang@gmail.com/20231129 with
 auth_id=102
X-Original-From: Keguang Zhang <keguang.zhang@gmail.com>
Reply-To: keguang.zhang@gmail.com

Add the driver and dt-binding document for Loongson1 APB DMA.

Changes in v12:
- Delete superfluous blank lines in the examples section.
- Move the call to devm_request_irq() into ls1x_dma_alloc_chan_resources()
  to use dma_chan_name() as a parameter.
- Move the call to devm_free_irq() into ls1x_dma_free_chan_resources() accordingly.
- Rename ls1x_dma_alloc_llis() to ls1x_dma_prep_lli().
- Merge ls1x_dma_free_lli() into ls1x_dma_free_desc().
- Add ls1x_dma_synchronize().
- Fix the error handling of ls1x_dma_probe().
- Some minor fixes and improvements.
- Link to v11: https://lore.kernel.org/r/20240802-loongson1-dma-v11-0-85392357d4e0@gmail.com

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

 .../bindings/dma/loongson,ls1b-apbdma.yaml         |  65 ++
 drivers/dma/Kconfig                                |   9 +
 drivers/dma/Makefile                               |   1 +
 drivers/dma/loongson1-apb-dma.c                    | 660 +++++++++++++++++++++
 4 files changed, 735 insertions(+)
---
base-commit: 61c01d2e181adfba02fe09764f9fca1de2be0dbe
change-id: 20231120-loongson1-dma-163afe5708b9

Best regards,
-- 
Keguang Zhang <keguang.zhang@gmail.com>



