Return-Path: <dmaengine+bounces-6666-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D23B8D992
	for <lists+dmaengine@lfdr.de>; Sun, 21 Sep 2025 13:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0486F7A2EDA
	for <lists+dmaengine@lfdr.de>; Sun, 21 Sep 2025 11:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CFC258CEF;
	Sun, 21 Sep 2025 11:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBxtlNSj"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F2C155A30;
	Sun, 21 Sep 2025 11:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758452649; cv=none; b=AkHrBqFH/mZS6E6RjvVKORoqj14EihjoaqepILlSlzmdnt4jeUPFukINV0SGhdImIWPmSKVUX5MjYQR2lPxdTgljBt7l3DCBYHNC4QU8pVEn+wgJa0/LB6LmK6pwVoSXjCG4Yn4YrLOAxVuHGj4a2U7QFJaapX/LFH4i9N0bFZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758452649; c=relaxed/simple;
	bh=zfFGum9b0/BleKUZeCTKfLnLOBtKdYp2e9/Jc3IpdTQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PEAkdUGFEuJ5ZSIfTbolt5eDiBS8gQLIOwYE1OPNbsXjnZpO6YtQVhpVsHlgN1NbJ+DD+PlPGUu4tZrzRjpUDKwX85g6/bkwg47GFHI9d/1tpp/E4LmfC4yFds4y4rffTwpyO8LreeDH4e1h1qLrUjzPSY3Ohl5zkinBCMDg3OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBxtlNSj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0582CC4CEE7;
	Sun, 21 Sep 2025 11:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758452649;
	bh=zfFGum9b0/BleKUZeCTKfLnLOBtKdYp2e9/Jc3IpdTQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=cBxtlNSj9/iDkZtPyO7LpMwcoOHRtvNZukkGVFWUw8U6mbcpDlZdkfbTZN4i/dLjJ
	 YTyfYBx3JVvVcEE++n0oQUF++0ud6sWCGcLcyNRNHwirmjZh9+r0MME6UbUcurJkb/
	 E7TxEkisbqgyQqO9ihC4I+4Cqm9gUwyDCVy3rhi6ECkKkADqk6yBElPXS0WWfUlD+5
	 xJ2TsON32V9qPpWMkZSUSCd2KY8qXKAkFktcp4lENj5MIqu2uHtG42MW1pHYX2tSvR
	 s9xvvRKM2GHP6to/lXX676O54bmyhRivhTcQhfo/OqiDb13yN+N4xg8lFl8StwjTY6
	 wVS00FwxsB7oA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5498CAC59A;
	Sun, 21 Sep 2025 11:04:08 +0000 (UTC)
From: Max Shevchenko via B4 Relay <devnull+wctrl.proton.me@kernel.org>
Subject: [PATCH 0/3] Rewrite MediaTek UART APDMA driver to support more
 than 33 bits
Date: Sun, 21 Sep 2025 14:03:39 +0300
Message-Id: <20250921-uart-apdma-v1-0-107543c7102c@proton.me>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIvbz2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSyND3dLEohLdxIKU3ERdy8RUc7NUE6M0I0NjJaCGgqLUtMwKsGHRsbW
 1ABs0505cAAAA
X-Change-ID: 20250921-uart-apdma-9ae76e42f213
To: Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Long Cheng <long.cheng@mediatek.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Max Shevchenko <wctrl@proton.me>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758452646; l=1014;
 i=wctrl@proton.me; s=20250603; h=from:subject:message-id;
 bh=zfFGum9b0/BleKUZeCTKfLnLOBtKdYp2e9/Jc3IpdTQ=;
 b=Quibm1DVcGl0mSoso1wZuKD1LG4vQ1WaKLN47ZGF1Ghf4HYVz2LEe84dbtvy0i9yXo49BuSCK
 r48rMZ4pJgKAXvMo/b1LwQAGKfFUn70yV3rHmeoxZI6PX4WuBaNbKmU
X-Developer-Key: i=wctrl@proton.me; a=ed25519;
 pk=JXUx3mL/OrnRvbK57HXgugBjEBKq4QgDKJqp7BALm74=
X-Endpoint-Received: by B4 Relay for wctrl@proton.me/20250603 with
 auth_id=421
X-Original-From: Max Shevchenko <wctrl@proton.me>
Reply-To: wctrl@proton.me

This patch series aims to support more than 33 bits for the MediaTek
APDMA driver, since newer SoCs like MT6795, MT6779 or MT6985 have higher
values for the DMA bitmask.

The reference SoCs for bitmask values were taken from the downstream
kernel (6.6) for the MT6991 SoC. 

Signed-off-by: Max Shevchenko <wctrl@proton.me>
---
Max Shevchenko (3):
      dt-bindings: dma: mediatek,uart-dma: drop mediatek,dma-33bits property
      dmaengine: mediatek: mtk-uart-apdma: support more than 33 bits for DMA bitmask
      arm64: dts: mediatek: mt6795: drop mediatek,dma-33bits property

 .../devicetree/bindings/dma/mediatek,uart-dma.yaml | 11 ++---
 arch/arm64/boot/dts/mediatek/mt6795.dtsi           |  4 +-
 drivers/dma/mediatek/mtk-uart-apdma.c              | 47 ++++++++++++++++------
 3 files changed, 39 insertions(+), 23 deletions(-)
---
base-commit: f83ec76bf285bea5727f478a68b894f5543ca76e
change-id: 20250921-uart-apdma-9ae76e42f213

Best regards,
-- 
Max Shevchenko <wctrl@proton.me>



