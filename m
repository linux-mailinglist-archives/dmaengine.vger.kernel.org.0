Return-Path: <dmaengine+bounces-4610-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7A8A4A056
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 18:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C823B176241
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 17:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6F118C011;
	Fri, 28 Feb 2025 17:26:41 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C411F4CBB;
	Fri, 28 Feb 2025 17:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740763601; cv=none; b=Xoq8wjFVc/6AzpIp3EZ7ofFoC3LtoKV6/YSIGfidk63dRgfzYv2xflQP5c+43AJAOy30ZTmqVUBY/AlDHgnIy+Yvy5GhJ/qh0F2eABSmZ0RAmwTizqFWSZPUhF+f4Uozgheqv9ZMJ4EChwg/E4oYZeHZD0RvyXOxX7TJ/mlg+CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740763601; c=relaxed/simple;
	bh=rqeIJF1R1xmOLdW1IFxpHK4KDEIQW/PJ6jCVivXuDBk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SHOmdNzVZzM3i8ZxWNsE+dlZGiwsb1vFcAv/gLhe3Leq9y/G1jJtAvKSAdQRaYc9C+qTD4KSCPK+Qo2bKjgTpvhf37++TZ9fQvvc1dmT9Rvr6Lt14Rpmyk7Xw+RKqqZC3gUMcsdnDZmHzIGH/YfAb4QX2bnhtrvmacuKompexu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C75DF150C;
	Fri, 28 Feb 2025 09:26:54 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 08A043F6A8;
	Fri, 28 Feb 2025 09:26:38 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: vkoul@kernel.org
Cc: devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] dmaengine: Add Arm DMA-350 driver
Date: Fri, 28 Feb 2025 17:26:31 +0000
Message-Id: <cover.1740762136.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Vinod,

As it says on the tin, here's an initial driver for the Arm DMA-350[1].
This has the intentions of growing into a fully-featured driver, but so
far my only development platform has been an Arm FVP (software model)
which doesn't emulate peripheral requests, so this is as far as I've
been able to get with dmatest alone. However, I figure it's enough to
be worth posting for review, at the very least.

Thanks,
Robin.

[1] https://developer.arm.com/Processors/CoreLink%20DMA-350


Robin Murphy (2):
  dt-bindings: dma: Add Arm DMA-350
  dmaengine: Add Arm DMA-350 driver

 .../devicetree/bindings/dma/arm,dma-350.yaml  |  44 ++
 drivers/dma/Kconfig                           |   7 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/arm-dma350.c                      | 659 ++++++++++++++++++
 4 files changed, 711 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/arm,dma-350.yaml
 create mode 100644 drivers/dma/arm-dma350.c

-- 
2.39.2.101.g768bb238c484.dirty


