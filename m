Return-Path: <dmaengine+bounces-3780-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 248699D757A
	for <lists+dmaengine@lfdr.de>; Sun, 24 Nov 2024 16:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F2671684D6
	for <lists+dmaengine@lfdr.de>; Sun, 24 Nov 2024 15:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB6642AA6;
	Sun, 24 Nov 2024 15:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2lf8B3d"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109B32500C6;
	Sun, 24 Nov 2024 15:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732463317; cv=none; b=WC9tPa+pJLmfhcE/OmIX/cGPxWh0f0GwTS/We7oOlQAH6oit90Bgr9DWjMh4OXaVgic69HtSG4bwGUg6a/tqdflQmMzCsbQGTIVmhef//L7lgSPocFn2jnMB7Yf/z+/z7uMmwbXf2ua1IlDSo1bBxBHIrMAJJ72jx9vPQV5pHBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732463317; c=relaxed/simple;
	bh=hFy8l4XZP0/+kbC7Zjr0Hr9qaIpfqI/wYZHM5yGyXOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cUF1bn9vtrVjHewVKw3Qx6OyO5cmCm35PNNnZmZwX4mW4bSQSWvFwhPCYnOUg5NCWIeC05QX+Qi5YnuZ4pG+KocnyG4g2wGyNAuNO82h6WNutHxXN8aki52xtQvaq0RHAxcXj0mNSFTBF/3vh74CGtRTLzggux6ON2t25l/QaVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2lf8B3d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 854B6C4CECC;
	Sun, 24 Nov 2024 15:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732463316;
	bh=hFy8l4XZP0/+kbC7Zjr0Hr9qaIpfqI/wYZHM5yGyXOQ=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=E2lf8B3dr6gbecqvE0H2OIcnahCDfgeIYX/bez9XGZPrtUam3k12sU1mHpWH+Zbpj
	 D5Va2nN7CsQy+2ZIRTkDLY2vr5nc9qRfe6Nvmwmxh+9uce4JELhKjByjOlFAtxD4CC
	 zmxY93akVN6/N/Il18BQeXeDK1yeigpgfK01i4YlIBQRglaJ6FMP3eL/8KVceEmMLp
	 Tzb4MPWLwywBE2PP3sIKMQRCmtgB6uGuU22F141mxRPEo45l0oHvhe/tujneyUjOGP
	 F+9+Rx7rsDpG/e5JW4MdoGdKg6xi4p4IKe7RFxYFbeUkCg8Q0BA90Sp4iuZNU0y2xl
	 IbSIWXAe+urqw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDF1E668B2;
	Sun, 24 Nov 2024 15:48:36 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Date: Sun, 24 Nov 2024 16:48:28 +0100
Subject: [PATCH] dmaengine: apple-admac: Avoid accessing registers in probe
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241124-admac-power-v1-1-58f2165a4d55@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMtKQ2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQyMT3cSU3MRk3YL88tQiXfM0Y6Nko0RDC1ODRCWgjoKi1LTMCrBp0bG
 1tQAYOnwwXQAAAA==
X-Change-ID: 20241124-admac-power-7f32c2a1850a
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Vinod Koul <vkoul@kernel.org>, 
 =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732463315; l=1574;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=fzYr2mOnaTThuwM8nzcfIvcWzFVACOsEp4j04pez3Us=;
 b=RMWELGTjitjliRQGKVjh9SJeijRLX/Kvt/3E/LLmmy3YJdBhs3xVJh9TFlJpN0Hg+IxvsqdiH
 zT/+9C3lwZEAHnQOhKvdsR7FrdibkKVGBpZb3XTTIDy4zEzccMhr/E3
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=aSkp1PdZ+eF4jpMO6oLvz/YfT5XkBUneWwyhQrOgmsU=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20241124 with
 auth_id=283
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: fnkl.kernel@gmail.com

From: Sasha Finkelstein <fnkl.kernel@gmail.com>

The ADMAC attached to the AOP has complex power sequencing, and is
power gated when the probe callback runs. Move the register reads
to other functions, where we can guarantee that the hardware is
switched on.

Fixes: 568aa6dd641f ("dmaengine: apple-admac: Allocate cache SRAM to channels")
Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
 drivers/dma/apple-admac.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/apple-admac.c b/drivers/dma/apple-admac.c
index 9588773dd2eb670a2f6115fdaef39a0e88248015..037ec38730cf980eee11ebb8ec17be7623879cf8 100644
--- a/drivers/dma/apple-admac.c
+++ b/drivers/dma/apple-admac.c
@@ -153,6 +153,8 @@ static int admac_alloc_sram_carveout(struct admac_data *ad,
 {
 	struct admac_sram *sram;
 	int i, ret = 0, nblocks;
+	ad->txcache.size = readl_relaxed(ad->base + REG_TX_SRAM_SIZE);
+	ad->rxcache.size = readl_relaxed(ad->base + REG_RX_SRAM_SIZE);
 
 	if (dir == DMA_MEM_TO_DEV)
 		sram = &ad->txcache;
@@ -912,12 +914,7 @@ static int admac_probe(struct platform_device *pdev)
 		goto free_irq;
 	}
 
-	ad->txcache.size = readl_relaxed(ad->base + REG_TX_SRAM_SIZE);
-	ad->rxcache.size = readl_relaxed(ad->base + REG_RX_SRAM_SIZE);
-
 	dev_info(&pdev->dev, "Audio DMA Controller\n");
-	dev_info(&pdev->dev, "imprint %x TX cache %u RX cache %u\n",
-		 readl_relaxed(ad->base + REG_IMPRINT), ad->txcache.size, ad->rxcache.size);
 
 	return 0;
 

---
base-commit: 9f16d5e6f220661f73b36a4be1b21575651d8833
change-id: 20241124-admac-power-7f32c2a1850a



