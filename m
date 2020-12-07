Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723B22D0A2E
	for <lists+dmaengine@lfdr.de>; Mon,  7 Dec 2020 06:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgLGFYH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Dec 2020 00:24:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:36950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbgLGFYH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 7 Dec 2020 00:24:07 -0500
Date:   Mon, 7 Dec 2020 10:53:22 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607318606;
        bh=mCUznOjbXqYI2bND5qpnl271aklxnGqHkYPfhMN+B1s=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=hhFX7cv2zmKRTlDhCb5OIbP4nfCjPilnplR1u15Jpz+3PvyQv5mOl7qloz1ycRUTW
         GGleRxw5AvzUDEvYYG/ToPRIm/I5SWTsf3iSRBlKvwTnBOtr9OYPW7hHRtiGdih5vP
         RWIuCxO1+Rj5GXeFH9DZk1IaX1zoEegPe5yQ0RvbarDnIuLiKyX8Wg5VPLVwTzeYN2
         URd7GoN10EoQ+1F3+WrOyZ1iOoBrjysumZgsbvmoj5jjudTtxdiWyRCWki3G9UxB/6
         ialwfa1X0B654Cs/2SOUAumrx9oUIQMu8jOVzzN5AQV66TknztO3U7cSmhmllxLZrA
         zee/2uVE/N+gA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Parth Y Shah <sparth1292@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        dan.j.williams@intel.com, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixes kernel crash generating from bam_dma_irq()
Message-ID: <20201207052322.GD8403@vkoul-mobl>
References: <1607250094-21571-1-git-send-email-sparth1292@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607250094-21571-1-git-send-email-sparth1292@gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Parth,

On 06-12-20, 15:51, Parth Y Shah wrote:
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

The change and explanation look good to me, unfortunately the patch
title is incorrect. It describes the fix it does and not the change in
this patch. Also do add subsystem and driver tags to the patch! git log
would tell you this information

Consider: "dmaengine: bam_dma: fix return of bam_dma_irq()" as a
suggestion.

> 
> Signed-off-by: Parth Y Shah <sparth1292@gmail.com>
> ---
>  drivers/dma/qcom/bam_dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index 4eeb8bb..d5773d4 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -875,7 +875,7 @@ static irqreturn_t bam_dma_irq(int irq, void *data)
>  
>  	ret = bam_pm_runtime_get_sync(bdev->dev);

Also this looks wrong to me. get_sync() can sleep and we cant invoke
that in an irq. Srini have you seen this issue

>  	if (ret < 0)
> -		return ret;
> +		return IRQ_NONE;
>  
>  	if (srcs & BAM_IRQ) {
>  		clr_mask = readl_relaxed(bam_addr(bdev, 0, BAM_IRQ_STTS));
> -- 
> 2.7.4

-- 
~Vinod
