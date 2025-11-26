Return-Path: <dmaengine+bounces-7353-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A20EC88AB4
	for <lists+dmaengine@lfdr.de>; Wed, 26 Nov 2025 09:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCE823AACAA
	for <lists+dmaengine@lfdr.de>; Wed, 26 Nov 2025 08:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E84319847;
	Wed, 26 Nov 2025 08:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLZmXv/X"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1C83195FC;
	Wed, 26 Nov 2025 08:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764146164; cv=none; b=EE3cxNo7Dw0DeTGxWfk5iTTBj34vUGq5JtuU9W1ifTdpr3inTPAA2Kp+tuHaB2ROw3Q3rRPalJWjHbrx3vDzJEsloRNkJ1MC2l8IGC5TBevfi1cQSADcpHfhaHR1hg4zexvoV/sa1xtJ8X/iO3bScN+tbLi1im2gy2Kq1OKXoZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764146164; c=relaxed/simple;
	bh=6/eSDcaslo9+vYL42NakAq96GQDj2C5lZPUYENmliC4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UhemBE4Bq/V3n6OkbM/jb0WgS7Q1tn7ZXTH0NwsuzjIZDVHvfEaHzDiK4PooBqH4PD4GKvEJvYQsi23hn4MayjWzAHxxhpF3iKOVELkxhn0dQmqqIsEkOg6jlHMjPyuoc4eP26f9pQxOdf9j8RzRSJ6p02lZAYfXh6+8CHfqN0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLZmXv/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB2A2C16AAE;
	Wed, 26 Nov 2025 08:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764146163;
	bh=6/eSDcaslo9+vYL42NakAq96GQDj2C5lZPUYENmliC4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=eLZmXv/X1ePgxGEQpXg3u6/y83vDaIw18lix3NagTGvASfbaoryDTwHdlL6G4t3ez
	 BD6OHBZ+zlaHxKudVQyLrQh/b9nEfkRX3XYgh9CZEVvb8Sn/YyVKOs/6ZaZRfCmTlz
	 4vapBTrq02BM8xHBMTE81OMILh4DK/IPBUz+FnIN+m7lYEEOvcZvkk7w51Ctkyt1te
	 WLvJ34v6Vwd7tITJPpdh6zGQECKeVP466zfL7rBZWDH6bVD9YNNCektlb/RPpnWGdB
	 XGsc4L5B3PYiw80kxkmHVXCNx1NJlYbVyX9lVtTPeS6iGYi+lXjqKjSyxyBXyV7qzz
	 WxX3JTBCqSnKA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF829D10381;
	Wed, 26 Nov 2025 08:36:03 +0000 (UTC)
From: Jean-Michel Hautbois via B4 Relay <devnull+jeanmichel.hautbois.yoseli.org@kernel.org>
Subject: [PATCH v2 0/5] dma: fsl/mcf-edma: Bug fixes and enhancements for
 ColdFire support
Date: Wed, 26 Nov 2025 09:36:01 +0100
Message-Id: <20251126-dma-coldfire-v2-0-5b1e4544d609@yoseli.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPG7JmkC/1XMSwrCMBSF4a2UOzbSvEp15D6kg5jctBdqUxIJl
 pK9GwsOHP4HzrdDwkiY4NrsEDFTorDUEKcG7GSWERm52iBaoTkXkrmnYTbMzlNEpr3sDCJX8iG
 hXtaInt4Hdx9qT5ReIW6Hnvl3/UHqH8qctczZ3l8k77Xq1G0LCWc6hzjCUEr5APeA+fepAAAA
X-Change-ID: 20251123-dma-coldfire-5f36aee143b3
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
 Angelo Dureghello <angelo@sysam.it>
Cc: Greg Ungerer <gerg@linux-m68k.org>, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linux-kernel@vger.kernel.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764146162; l=1724;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=6/eSDcaslo9+vYL42NakAq96GQDj2C5lZPUYENmliC4=;
 b=fC5GVRJPXlfdpSiN+oM08RMzdhnInV/phbe9d8m3soqlu4CGAT57yFCvITtNID/Mhwtzo+rKz
 HymH4w0dgnSCYLt80WZyTR2umnlzBWarKN8YEjIHtMxEOho8dK79CCj
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=MsMTVmoV69wLIlSkHlFoACIMVNQFyvJzvsJSQsn/kq4=
X-Endpoint-Received: by B4 Relay for
 jeanmichel.hautbois@yoseli.org/20240925 with auth_id=570
X-Original-From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Reply-To: jeanmichel.hautbois@yoseli.org

This series addresses several bugs in the fsl-edma and mcf-edma drivers
affecting MCF54418 ColdFire processors.

Patch 1 adds the FSL_EDMA_DRV_MCF flag to fix byte-lane addressing for
MCF54418.

Patch 2 adds per-channel IRQ naming for easier debugging.

Patches 3-5 fix the interrupt and error handlers for all 64 DMA
channels:
- Patch 3 fixes the interrupt handler to process all 64 channels
- Patch 4 moves the error handler out of the header file for clarity
- Patch 5 fixes the error handler for all 64 channels with proper types

Tested on a custom MCF54418-based platform with slave DMA transfers.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
---
Changes in v2:
- Check devm_kasprintf() return value
- Keep request_irq on one line in naming patch
- Remove non needed memory barrier
- Remove the interleave patch for now
- Link to v1: https://lore.kernel.org/r/20251124-dma-coldfire-v1-0-dc8f93185464@yoseli.org

---
Jean-Michel Hautbois (5):
      dma: fsl-edma: Add FSL_EDMA_DRV_MCF flag for ColdFire eDMA
      dma: mcf-edma: Add per-channel IRQ naming for debugging
      dma: mcf-edma: Fix interrupt handler for 64 DMA channels
      dma: fsl-edma: Move error handler out of header file
      dma: mcf-edma: Fix error handler for all 64 DMA channels

 drivers/dma/fsl-edma-common.c |  5 +++
 drivers/dma/fsl-edma-common.h | 11 +++----
 drivers/dma/mcf-edma-main.c   | 72 +++++++++++++++++++++++++------------------
 3 files changed, 52 insertions(+), 36 deletions(-)
---
base-commit: ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d
change-id: 20251123-dma-coldfire-5f36aee143b3

Best regards,
--  
Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>



