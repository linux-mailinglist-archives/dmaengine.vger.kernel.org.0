Return-Path: <dmaengine+bounces-6161-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA11B329F8
	for <lists+dmaengine@lfdr.de>; Sat, 23 Aug 2025 17:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A73377BB8F9
	for <lists+dmaengine@lfdr.de>; Sat, 23 Aug 2025 15:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAD329D294;
	Sat, 23 Aug 2025 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+eMjV70"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8253F2080E8;
	Sat, 23 Aug 2025 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964650; cv=none; b=D2DqQspkU981yhMXtg+6SmFZQsJhYWcLbH/WOTaGhYDKxKSU6tlZpm+mx9t/h8dQCBWMyGHPi1xIPsbSfyCNRzPxQ3q5dR8ZesTPBNYHvy9hmWjAwF8LBieICIfv/wQLpW1UbwrftZhYKxk+VAy309EibIWSw45Cb9PVb43aMJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964650; c=relaxed/simple;
	bh=0XuIgGw0B2/H3cOMG5TY7c8D1m3XnC9XDsKnG2GChy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W5Amk99/0RgeOPJQKilbzCyygylWgtpWoU4JUZ5GCL4cfmYL+pbkygAh+rcYJazRCKF/OOOOouFJEGrg2DDD4QeLmdhqukO7QWh5lCwaTncnLT7FnsVajhiXI8MOLLSxdT81RIt7zx2D1I9/izRSRz5ygpqz+IHi9tVc+pevY/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+eMjV70; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D1FC4CEE7;
	Sat, 23 Aug 2025 15:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755964650;
	bh=0XuIgGw0B2/H3cOMG5TY7c8D1m3XnC9XDsKnG2GChy8=;
	h=From:To:Cc:Subject:Date:From;
	b=d+eMjV70Mk0uZnsqOzD2NOWsm7XUzl02UNnvcJIZi1lBB+/+6we7LqsOzXAWMI/sD
	 NYEuKrT+DCb30sVv4a6fBv+9V1wdpbAW/c6MMXCwNXuKX6usZVTQTCYK42RH3DJjwM
	 FbQ3rpcfDTzfTQFIWQz5N6QrjTYgsbIM0kNFxDsUozcYBpm08MqOF0ik+I7v3hyFT1
	 MhNRomCend1nsP3UXJ40dtY5tV2/5esbwidDrBtHZMWaT959ikcOKVMl69vg/eS4S+
	 /p0F7+o+S/oMm/WvH2fTAl6+XVbYiSarWUkLMnt7OASCIJ4IbYNJ0CcxGVPyv9zrJd
	 ymTk14LPL7moA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/14] dmaengine: dma350: Support slave_sg, cyclic and DMA-250
Date: Sat, 23 Aug 2025 23:39:55 +0800
Message-ID: <20250823154009.25992-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series firstly does some cleanups, then add support of
device_prep_slave_sg and device_prep_dma_cyclic to DMA-350. 

Lastly, add support for ARM DMA-250 IP. Compared with DMA-350, DMA-250
is a simplified version. They share many common parts, but they do
have difference. Add DMA-250 support by handling their difference by
using different device_prep_slave_sg, device_prep_dma_cyclic and
device_prep_dma_memcpy. DMA-250 doesn't support device_prep_dma_memset.


Jisheng Zhang (14):
  dmaengine: dma350: Fix CH_CTRL_USESRCTRIGIN definition
  dmaengine: dma350: Add missing dch->coherent setting
  dmaengine: dma350: Check vchan_next_desc() return value
  dmaengine: dma350: Check dma_cookie_status() ret code and txstate
  dmaengine: dma350: Register the DMA controller to DT DMA helpers
  dmaengine: dma350: Use dmaenginem_async_device_register
  dmaengine: dma350: Remove redundant err msg if platform_get_irq()
    fails
  dt-bindings: dma: dma350: Document interrupt-names
  dmaengine: dma350: Support dma-channel-mask
  dmaengine: dma350: Alloc command[] from dma pool
  dmaengine: dma350: Support device_prep_slave_sg
  dmaengine: dma350: Support device_prep_dma_cyclic
  dt-bindings: dma: dma350: Support ARM DMA-250
  dmaengine: dma350: Support ARM DMA-250

 .../devicetree/bindings/dma/arm,dma-350.yaml  |   6 +
 drivers/dma/arm-dma350.c                      | 909 ++++++++++++++++--
 2 files changed, 852 insertions(+), 63 deletions(-)

-- 
2.50.0


