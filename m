Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9C42D78E6
	for <lists+dmaengine@lfdr.de>; Fri, 11 Dec 2020 16:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404175AbgLKPOu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Dec 2020 10:14:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:39904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406549AbgLKPO1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 11 Dec 2020 10:14:27 -0500
Date:   Fri, 11 Dec 2020 19:48:41 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607696329;
        bh=AaWAHxLcS4HDS5ZqYcRul/fH6LvUc3a2LNed66cZd5I=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=al9AwndRpsjir4HzS7G5z8/froC/N0nBPqiDCd0gqHQq/W4OiLEKWj7wIbGlBHvib
         DjeIDWs1Nv04gROQFTR0XOY2dpn6P2AacCA7Ad4UKUdp/0CNyM6PPxncf6+lCDGPgN
         T4sj7PcnEKMB7GKXMMudgSx378l6AZT/vSx8EkFQhQt/MK4p3lvp7m5hySv/rTU31k
         roLRk6FIbzUxso8sga0NsBz7Gd2X+HG4hpobTK80FyQgWA1G3RMiHPppSBrAkECAnP
         4SyXSArKU/g7ie1IAbnzg70eADoI/vbR/qrXkoRvOiRUyF0c+tTkdef5usoHLg5aBr
         +cWEXtJlwqZqA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Parth Y Shah <sparth1292@gmail.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        dan.j.williams@intel.com, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: bam_dma: fix return of bam_dma_irq()
Message-ID: <20201211141841.GX8403@vkoul-mobl>
References: <1607322820-7450-1-git-send-email-sparth1292@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607322820-7450-1-git-send-email-sparth1292@gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-12-20, 12:03, Parth Y Shah wrote:
> While performing suspend/resume, we were getting below kernel crash.
> 
> [   54.541672] [FTS][Info]gesture suspend...
> [   54.605256] [FTS][Error][GESTURE]Enter into gesture(suspend) failed!
> [   54.605256]
> [   58.345850] irq event 10: bogus return value fffffff3
> ......
> 
> [   58.345966] [<ffff0000080830f0>] el1_irq+0xb0/0x124
> [   58.345971] [<ffff000008085360>] arch_cpu_idle+0x10/0x18
> [   58.345975] [<ffff0000081077f4>] do_idle+0x1ac/0x1e0
> [   58.345979] [<ffff0000081079c8>] cpu_startup_entry+0x20/0x28
> [   58.345983] [<ffff000008a80ed0>] rest_init+0xd0/0xdc
> [   58.345988] [<ffff0000091c0b48>] start_kernel+0x390/0x3a4
> [   58.345990] handlers:
> [   58.345994] [<ffff0000085120d0>] bam_dma_irq
> 
> The reason for the crash we found is, bam_dma_irq() was returning
> negative value when the device resumes in some conditions.
> 
> In addition, the irq handler should have one of the below return values.
> 
> IRQ_NONE            interrupt was not from this device or was not handled
> IRQ_HANDLED         interrupt was handled by this device
> IRQ_WAKE_THREAD     handler requests to wake the handler thread
> 
> Therefore, to resolve this crash, we have changed the return value to
> IRQ_NONE.

Applied, thanks

-- 
~Vinod
