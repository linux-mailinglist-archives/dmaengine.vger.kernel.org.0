Return-Path: <dmaengine+bounces-1395-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B97A87D9F2
	for <lists+dmaengine@lfdr.de>; Sat, 16 Mar 2024 12:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9417C1C20C14
	for <lists+dmaengine@lfdr.de>; Sat, 16 Mar 2024 11:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FF8179B2;
	Sat, 16 Mar 2024 11:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuGhTzzP"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FAD14A9D;
	Sat, 16 Mar 2024 11:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710588852; cv=none; b=Ez5LttSoS4mJSH7u8Q/D1waLuAWUNwM8y3VSLA4LcSeZprDXiuTXqnGuVhFH2agns8VeGDgSfgfD/bgc8fC856KoiUOrWBjWqBn5VtP/RXVRWZVOBaYKfxNqnJVjZz6FMEv2r2dwbfoodXfQBYavBKch6GLm56R9lFXZphCppWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710588852; c=relaxed/simple;
	bh=4L4tGD1DKV+mZjgPQTvkjdRdWNUjXgMgRTBy+sDZ4xg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SA5k6jgrME+lEtJiqnOoqPwA4ywTLqKbTOO9FkEDTJl3gaL+p//UW3Q8/RA4fhqPbwteRPdP3iFYUSqE3+YEijt6JDDFIw1BbU8W7nXzPdYz85lQRScPvUB0S4gU83gN61T72mSaBNZ4WG+nX8xnOuLpfVb+bG11p+DGeUvGdHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuGhTzzP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2FDEC433C7;
	Sat, 16 Mar 2024 11:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710588851;
	bh=4L4tGD1DKV+mZjgPQTvkjdRdWNUjXgMgRTBy+sDZ4xg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=IuGhTzzPUp/V7LrkG+np+N2ddC+ZfIanfodbb3o9EqLnyaP1jOVvLDTPtL8/36iRG
	 cM6BW8prCN24tZmY/jEeoBLiB1GUHQB7OapG7emqSsTMk+SDnSWAX33jim3LbqV0Ns
	 OwsQ7u1mL61Dt8ZSKJPB/nDlJm3yok5a+stvVEbn2Qn3BEtLf1SduKSNaL0eH9c9HV
	 hm6SKE6T+YyqbltME8iKFo4z1IeAelAD0hBs8rlA+vdT0rXmo4O3RS3PFCjitAlBgT
	 UPkfZhn1Swx2xBmmfmhnTO3F4Shg1cOB2GszBIynL+dT6TMg5TPDnjGYr7ZNbPQXId
	 c61Ooyy+T+NVw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE655C54E5D;
	Sat, 16 Mar 2024 11:34:11 +0000 (UTC)
From: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>
Subject: [PATCH v6 0/2] Add support for Loongson1 DMA
Date: Sat, 16 Mar 2024 19:33:52 +0800
Message-Id: <20240316-loongson1-dma-v6-0-90de2c3cc928@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKCD9WUC/z2NQQ6CMBAAv0L27JJukQqc/IfxUGFbGmlrWjVGw
 t+tHjzOYWZWyJwcZxiqFRI/XXYxFFC7CsZZB8vopsIghWyIpMAlxmBzDIST10iq0Ybbg+guPRT
 nlti41693Ohc2KXq8z4n1vyJ62ZGkvm3qVu6V6JDwyvZRZvX7uzxar91Sj9HDtn0AHlUeF6EAA
 AA=
To: Keguang Zhang <keguang.zhang@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710588849; l=2457;
 i=keguang.zhang@gmail.com; s=20231129; h=from:subject:message-id;
 bh=4L4tGD1DKV+mZjgPQTvkjdRdWNUjXgMgRTBy+sDZ4xg=;
 b=p93Izz5hHhY6H2wDb31zXn4GqlnZAT04fm48vFU46D5x+W2hAJuZ7arhkDP9w1U14HnAr8S+d
 jxo/7SN/W01D1vWzFQJVw/LAcnoytJr8L3ue7qsMRIWH0kgx1a2WZdx
X-Developer-Key: i=keguang.zhang@gmail.com; a=ed25519;
 pk=FMKGj/JgKll/MgClpNZ3frIIogsh5e5r8CeW2mr+WLs=
X-Endpoint-Received:
 by B4 Relay for keguang.zhang@gmail.com/20231129 with auth_id=102
X-Original-From: Keguang Zhang <keguang.zhang@gmail.com>
Reply-To: <keguang.zhang@gmail.com>

Add the driver and dt-binding document for Loongson1 DMA.

Changelog
V5 -> V6:
   Change the compatible to the fallback
   Implement .device_prep_dma_cyclic for Loongson1 sound driver,
   as well as .device_pause and .device_resume.
   Set the limitation LS1X_DMA_MAX_DESC and put all descriptors
   into one page to save memory
   Move dma_pool_zalloc() into ls1x_dma_alloc_desc()
   Drop dma_slave_config structure
   Use .remove_new instead of .remove
   Use KBUILD_MODNAME for the driver name
   Improve the debug information
   Some minor fixes
V4 -> V5:
   Add the dt-binding document
   Add DT support
   Use DT information instead of platform data
   Use chan_id of struct dma_chan instead of own id
   Use of_dma_xlate_by_chan_id() instead of ls1x_dma_filter()
   Update the author information to my official name
V3 -> V4:
   Use dma_slave_map to find the proper channel.
   Explicitly call devm_request_irq() and tasklet_kill().
   Fix namespace issue.
   Some minor fixes and cleanups.
V2 -> V3:
   Rename ls1x_dma_filter_fn to ls1x_dma_filter.
V1 -> V2:
   Change the config from 'DMA_LOONGSON1' to 'LOONGSON1_DMA',
   and rearrange it in alphabetical order in Kconfig and Makefile.
   Fix comment style.

Keguang Zhang (2):
  dt-bindings: dma: Add Loongson-1 DMA
  dmaengine: Loongson1: Add Loongson1 dmaengine driver

 .../bindings/dma/loongson,ls1x-dma.yaml       |  64 +++
 drivers/dma/Kconfig                           |   9 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/loongson1-dma.c                   | 492 ++++++++++++++++++
 4 files changed, 566 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/loongson,ls1x-dma.yaml
 create mode 100644 drivers/dma/loongson1-dma.c

--
2.39.2

base-commit: 719136e5c24768ebdf80b9daa53facebbdd377c3
---
Keguang Zhang (2):
      dt-bindings: dma: Add Loongson-1 DMA
      dmaengine: Loongson1: Add Loongson1 dmaengine driver

 .../devicetree/bindings/dma/loongson,ls1x-dma.yaml |  66 ++
 drivers/dma/Kconfig                                |   9 +
 drivers/dma/Makefile                               |   1 +
 drivers/dma/loongson1-dma.c                        | 665 +++++++++++++++++++++
 4 files changed, 741 insertions(+)
---
base-commit: a1e7655b77e3391b58ac28256789ea45b1685abb
change-id: 20231120-loongson1-dma-163afe5708b9

Best regards,
-- 
Keguang Zhang <keguang.zhang@gmail.com>


