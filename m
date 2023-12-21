Return-Path: <dmaengine+bounces-623-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E2881BC15
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 17:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 430F2B22D16
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 16:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03465821C;
	Thu, 21 Dec 2023 16:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmkEMka5"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D074F58207;
	Thu, 21 Dec 2023 16:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF09C433C7;
	Thu, 21 Dec 2023 16:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703176226;
	bh=+5oiufljMRZTop1sokIuh1irSP8FrIYI3ZjuJb+rbx0=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=EmkEMka5PwRQt939P1w2hGl0c3kIURauT7Ltbfo+vT3Ygjh0RzfaufajKatj56W1a
	 pZvWmj0ZA1Q6tiC6lBm8o5NqKWPEVijWaAG1em6JAq/Djz7jeIbDe6RIsmn+2jfg+m
	 AKWMnGrjlR9v36EdCRfqBRjW1PIdKxi5GoRjS70RUEG5AmwCtqfuO6tVR2oX5E58hM
	 g5t8kWz9u5VWPNPWRv9zq44U7STd14f+I3B6LDJCsygJvMP3hX6vOQJYHr8tk9ZQGm
	 G3s/whhaiTpJbWyNUQEHpqlLOrvYzqcplXhN/5cBkJgKt3B/g1bSZFTuN182TPFFNY
	 FSQciuSdOe6PQ==
From: Vinod Koul <vkoul@kernel.org>
To: lizhi.hou@amd.com, brian.xu@amd.com, raj.kumar.rampelli@amd.com, 
 michal.simek@amd.com, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com, 
 Jan Kuliga <jankul@alatek.krakow.pl>
In-Reply-To: <20231218113904.9071-1-jankul@alatek.krakow.pl>
References: <20231218113904.9071-1-jankul@alatek.krakow.pl>
Subject: Re: [PATCH v5 0/8] Miscellaneous xdma driver enhancements
Message-Id: <170317622335.683420.15291981209572271704.b4-ty@kernel.org>
Date: Thu, 21 Dec 2023 22:00:23 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Mon, 18 Dec 2023 12:39:04 +0100, Jan Kuliga wrote:
> This patchset introduces a couple of xdma driver enhancements. The most
> important change is the introduction of interleaved DMA transfers
> feature, which is a big deal, as it allows DMAEngine clients to express
> DMA transfers in an arbitrary way. This is extremely useful in FPGA
> environments, where in one FPGA system there may be a need to do DMA both
> to/from FIFO at a fixed address and to/from a (non)contiguous RAM.
> 
> [...]

Applied, thanks!

[1/8] dmaengine: xilinx: xdma: Get rid of unused code
      commit: 6e2387183312cdfce6326b2626c0b801c2ffe686
[2/8] dmaengine: xilinx: xdma: Add necessary macro definitions
      commit: 7a9c7f46bd0abea214d96f00f78622f24c798ad8
[3/8] dmaengine: xilinx: xdma: Ease dma_pool alignment requirements
      commit: e5bc76b0e1c54906ca744ed1a7872f4f407d5d2e
[4/8] dmaengine: xilinx: xdma: Rework xdma_terminate_all()
      commit: 2e142cebb1645ac18db1e66f0c30a8d720d00c0b
[5/8] dmaengine: xilinx: xdma: Add error checking in xdma_channel_isr()
      commit: c38d055a7c021145ab3a07cf69992d287440c4cb
[6/8] dmaengine: xilinx: xdma: Add transfer error reporting
      commit: c3fcb6f5575fcfd240baa339319d2a42d137cd8e
[7/8] dmaengine: xilinx: xdma: Prepare the introduction of interleaved DMA transfers
      commit: fa88abfd0d03fea8b800ff1df4f161c804d24c8a
[8/8] dmaengine: xilinx: xdma: Implement interleaved DMA transfers
      commit: 01e6d907656134949c4126e7fd64984d4daa4c1e

Best regards,
-- 
~Vinod



