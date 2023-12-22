Return-Path: <dmaengine+bounces-641-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CE781CE44
	for <lists+dmaengine@lfdr.de>; Fri, 22 Dec 2023 19:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5577B21731
	for <lists+dmaengine@lfdr.de>; Fri, 22 Dec 2023 18:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2012C190;
	Fri, 22 Dec 2023 18:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hoMX/lvn"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E612C18E;
	Fri, 22 Dec 2023 18:06:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6855FC433C7;
	Fri, 22 Dec 2023 18:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703268409;
	bh=R22+CnodvVYDrZNCk7av0uKuvv/+igMAIQJpzYsYOak=;
	h=From:Subject:Date:To:Cc:From;
	b=hoMX/lvnXTbBHvD4fhc97/hJpLxrpGFvuGCuKRsMlSprEQ3BySIc4uL7n/u40XaYs
	 y+tkibKR3Yd4InfLhIsNrYsGJ/RU1Xn/yPEqYbgJPq2azrL7xUXNztUIzsOQ+mZLvc
	 m4BuaXYTIaVjfm+PqRAUzkKT0NWUQJz+nTu9SRWGkV3x1pTjCU1QJ8aAFweS33AxV/
	 W/hCaxcY6DMW/hge6AoTOlZt9HpI4r1ua1IbqpPw7HfWu4OFZ2Gi1cJOEpNbVUe1hx
	 zz/brMxG+TpW8fV+MoNOiBsh+1+iX8lN8lXmXyZR+nEB5D9a8W8c6LPvpgT/IbqbLD
	 1sHWYtIQGuxcQ==
From: Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 0/2] dmaengine: xilinx: xdma: Fix two clang warnings
Date: Fri, 22 Dec 2023 11:06:43 -0700
Message-Id: <20231222-dma-xilinx-xdma-clang-fixes-v1-0-84a18ff184d2@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADTQhWUC/x2MQQqAMAwEvyI5G9AUD/oV8aBtqgGt0oIUpH83e
 tthh3kgcRROMFQPRL4lyRkU2roCu81hZRSnDNSQaYkI3TFjll1Cxvxtu6uFXjInXHpL1vjONd6
 AFq7I/6GBcSrlBavfjittAAAA
To: lizhi.hou@amd.com, brian.xu@amd.com, raj.kumar.rampelli@amd.com, 
 vkoul@kernel.org, jankul@alatek.krakow.pl
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 llvm@lists.linux.dev, patches@lists.linux.dev, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=736; i=nathan@kernel.org;
 h=from:subject:message-id; bh=R22+CnodvVYDrZNCk7av0uKuvv/+igMAIQJpzYsYOak=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKmtFyy+LDvwxeXi+/bdzPM/qX66W5weZJK550bglvqJq
 cXfS58YdpSyMIhxMciKKbJUP1Y9bmg45yzjjVOTYOawMoEMYeDiFICJ8M5gZPg1oS3N50Wmy1+9
 k89FLzd4PJ9S6my/MH1FuVz+w6iNy7oZfrNxNPwTPH9Hu2X+vstXvmS4J6y/dXUXu+G/6Xf697D
 VpfIBAA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Hi all,

This series fixes two clang warnings that I see after
commit 2f8f90cd2f8d ("dmaengine: xilinx: xdma: Implement interleaved DMA
transfers"). They have just been build tested but I think the logic is
sound, please double check though.

---
Nathan Chancellor (2):
      dmaengine: xilinx: xdma: Fix operator precedence in xdma_prep_interleaved_dma()
      dmaengine: xilinx: xdma: Fix initialization location of desc in xdma_channel_isr()

 drivers/dma/xilinx/xdma.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)
---
base-commit: 3d0b2176e04261ab4ac095ff2a17db077fc1e46d
change-id: 20231222-dma-xilinx-xdma-clang-fixes-b9c2c3f5d0f3

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


