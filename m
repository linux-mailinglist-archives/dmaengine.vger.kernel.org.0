Return-Path: <dmaengine+bounces-2673-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0C192E530
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jul 2024 12:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A76B1C22890
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jul 2024 10:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C110158A1E;
	Thu, 11 Jul 2024 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afjNT8fB"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18843155C8F;
	Thu, 11 Jul 2024 10:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720695355; cv=none; b=BWRvecGNvGRiSteuc3LQTstz6Ta53x7imgbhArghGE5x4UsMIsINQNL6dQN25aKMyJzHxu3yDi80OEK+g3Nuf/vba80dQ3yYqYI2jOg7gUf6DU9aAniscuRTNOwXy+UQ2FxlaggFzqu0WPPT/gCGvdA9O6zdoMG8W8nVbNtDq7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720695355; c=relaxed/simple;
	bh=HwivC1YSyiPpQ5PwufJY8pxz6NX1ZCCTtPty8vus00c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KMb4vN4bxiZRBfwekc4a8tEHIu8HCBq8IHdtDoaogP9cgfxNIPBx0PWQuiNbGGuIsYHlNzO3kobMmPhO07cCIYJlqhH/YbyMxD+thxiUi5/woncSD57Eyh7RV1h3TYzILdpyREvnJBnxRTHALm+Tvact6c/kjYlzksNNIbrqt+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afjNT8fB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9937AC116B1;
	Thu, 11 Jul 2024 10:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720695354;
	bh=HwivC1YSyiPpQ5PwufJY8pxz6NX1ZCCTtPty8vus00c=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=afjNT8fB3zUOrdezvdow7e/Gmoa9sAkV8Re+lgNOhlo8naFYNYF3elo7ltW7HNi+q
	 lN6zwZ1/5GIk7iVS1Rq0JZRtvw2IyXY6WnRi5O3q7HiFAR3JVG4ca3tnMJ+feQ/GVr
	 WZdyUINN4gfEWUWd2wI8oh/5Y713rQT5VipByrl895aVy/1ddnlVPSjeU7TevFsMHu
	 7R9eSldvRPvCBIwTlYb3/en4BZgvm0xOHgHgRdcwbdEB3fElj8aP6ums4Waad7nQsv
	 1h/Uw+ymwnHjzv7i03Cw+exCpWDVkLpG0NA0bpmA2aYzM0rK4Yv85xpDxfRlBRyOsQ
	 qZAinA3pQ/ETA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87715C3DA41;
	Thu, 11 Jul 2024 10:55:54 +0000 (UTC)
From: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>
Subject: [PATCH RESEND v9 0/2] Add support for Loongson1 APB DMA
Date: Thu, 11 Jul 2024 18:55:36 +0800
Message-Id: <20240711-loongson1-dma-v9-0-5ce8b5e85a56@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Keguang Zhang <keguang.zhang@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720695351; l=2719;
 i=keguang.zhang@gmail.com; s=20231129; h=from:subject:message-id;
 bh=HwivC1YSyiPpQ5PwufJY8pxz6NX1ZCCTtPty8vus00c=;
 b=QyBxFrcnMjDaxOUrz7fmfRhMp+ZFmKh4f5TgsKWUwSDt4UQMt4kT+iskDLYQKaRyjP1g3rZEz
 DfHCQxLL2PjDjMps93gf5zb1jhmrhpNB7234spPWRWOmmYB/WOoD1G3
X-Developer-Key: i=keguang.zhang@gmail.com; a=ed25519;
 pk=FMKGj/JgKll/MgClpNZ3frIIogsh5e5r8CeW2mr+WLs=
X-Endpoint-Received: by B4 Relay for keguang.zhang@gmail.com/20231129 with
 auth_id=102
X-Original-From: Keguang Zhang <keguang.zhang@gmail.com>
Reply-To: keguang.zhang@gmail.com

Add the driver and dt-binding document for Loongson1 APB DMA.

---
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
- as well as .device_pause and .device_resume.
- Set the limitation LS1X_DMA_MAX_DESC and put all descriptors
- into one page to save memory
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
 drivers/dma/loongson1-apb-dma.c                    | 665 +++++++++++++++++++++
 4 files changed, 742 insertions(+)
---
base-commit: d35b2284e966c0bef3e2182a5c5ea02177dd32e4
change-id: 20231120-loongson1-dma-163afe5708b9

Best regards,
-- 
Keguang Zhang <keguang.zhang@gmail.com>



