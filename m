Return-Path: <dmaengine+bounces-4686-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53438A5A5A3
	for <lists+dmaengine@lfdr.de>; Mon, 10 Mar 2025 22:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AA303A6CE6
	for <lists+dmaengine@lfdr.de>; Mon, 10 Mar 2025 21:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6B01E0489;
	Mon, 10 Mar 2025 21:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBszaPdx"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F741DF992;
	Mon, 10 Mar 2025 21:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640811; cv=none; b=PZNhUvVcRbe4XmM88loeeJyE/AcshHdgABMBcTEpkSP4f4Wy8+3+2e0IXJJlfAzcw1hFRRhDzbjlvhDySPcu+nso4jNpPnNge3YFWNoDQIrfG4FP4UMafFZYEBEsdj/t95PlgkSPxHKbozZY7pgK7no9HN1OyjkP7uAZ9OiSJM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640811; c=relaxed/simple;
	bh=XNQvjOMgH5YmwlEN4TzpN/Titmr2rrk3EIejekG61d4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rkSgLiXVqpjMMtiWI4RePWs8+GfDgHVTfGDR6k/FfztZB+VZXnvW8uYFTosPIp3vOCUzzqqdVNqgoLHa1OafnXVtF3kvgzvpcpOPkTbcN/V109V+LwOTy0Pm4u2XADuUkXlUN99d9lkgwOkkQ0P9gj03o887A3UJXz5Z4aIqMV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBszaPdx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B538C4CEE5;
	Mon, 10 Mar 2025 21:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741640810;
	bh=XNQvjOMgH5YmwlEN4TzpN/Titmr2rrk3EIejekG61d4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tBszaPdxUc1FODLBtuqXl8uTm8qlkAGbD45cS3SkQ8mm9n3hf+8ecVqqkAfmt8Mg+
	 jQ0x/BTMk85vdZOcnzxq/x5friRuRg8L+xYWiSHTx1+u/jIwtwRg1BXYpFT0fhRAY4
	 QUhGkT5bTfy/18tsz11+UdQ6ZKq2z/Hjx4eqspI5NTETSPCXHUxHIDVIaDqyQMjNZv
	 gIxhKN0doRL3I8r4Hy4q8ys0REgdUS3YkahDz9wbXcqkqoC8MWWkAUgqjeyl7+Gnys
	 AJ4eOSKEnCmrrwrl4/21nvjka7mRuofkAIBau3MQfwxNZ4qmI7sEj81TihR9fTKfh+
	 zhDEGGt1+BGmA==
From: Vinod Koul <vkoul@kernel.org>
To: Frank.Li@nxp.com, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
In-Reply-To: <20250228071720.3780479-1-peng.fan@oss.nxp.com>
References: <20250228071720.3780479-1-peng.fan@oss.nxp.com>
Subject: Re: [PATCH V4 RESEND 1/2] dmaengine: fsl-edma: cleanup chan after
 dma_async_device_unregister
Message-Id: <174164080823.489187.15604235628505426081.b4-ty@kernel.org>
Date: Tue, 11 Mar 2025 02:36:48 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 28 Feb 2025 15:17:19 +0800, Peng Fan (OSS) wrote:
> There is kernel dump when do module test:
> sysfs: cannot create duplicate filename
> /devices/platform/soc@0/44000000.bus/44000000.dma-controller/dma/dma0chan0
>  __dma_async_device_channel_register+0x128/0x19c
>  dma_async_device_register+0x150/0x454
>  fsl_edma_probe+0x6cc/0x8a0
>  platform_probe+0x68/0xc8
> 
> [...]

Applied, thanks!

[1/2] dmaengine: fsl-edma: cleanup chan after dma_async_device_unregister
      commit: c9c59da76ce9cb3f215b66eb3708cda1134a5206
[2/2] dmaengine: fsl-edma: free irq correctly in remove path
      commit: fa70c4c3c580c239a0f9e83a14770ab026e8d820

Best regards,
-- 
~Vinod



