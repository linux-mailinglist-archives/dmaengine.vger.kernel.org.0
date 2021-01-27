Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55DF305FF7
	for <lists+dmaengine@lfdr.de>; Wed, 27 Jan 2021 16:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbhA0Pot (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Jan 2021 10:44:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:36580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236236AbhA0PnF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 27 Jan 2021 10:43:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F6F8207CC;
        Wed, 27 Jan 2021 15:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611762145;
        bh=hTTKruYKBe92ui3jqhTUD4Nv5kSB/j+ATAzHAvegku0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qTDJm0UOXGy1TM4Bk3E42hB2CzgjJ+zAA0BW2Hz67WXWg6TYvay6NEGSiIZmSL3AD
         8Ug6ZXF4Kx7ZkYJ7aLIzlUPF4G3K/qzvNlChP7qGrI/8pnp43+c1X2gdEHCXaadgWR
         Eida5XTdN6u7KMSLPxvAcSl+AH7fbTPp7Z7XNFh4zdrVHB3swWJoI2dheXAZTdFTCQ
         xfjsnKjVvbbld5TrDpq9m5HQPICi7Lsi1PrEn70EiGk0ZjAxuJmyHtpPZ9KIklQHWf
         aEbevlVOrWTzczKRgBP8/8URuqo8ZtnYHyi39HDznPMeM/Yl2dWNwyoZ6KdWeh89T0
         VGX+C2YBEh22w==
Date:   Wed, 27 Jan 2021 21:12:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        dan.j.williams@intel.com, shawn.guo@linaro.org,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dma: qcom: bam_dma: Manage clocks when
 controlled_remotely is set
Message-ID: <20210127154221.GD2771@vkoul-mobl>
References: <20210126211859.790892-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126211859.790892-1-thara.gopinath@linaro.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-01-21, 16:18, Thara Gopinath wrote:
> When bam dma is "controlled remotely", thus far clocks were not controlled
> from the Linux. In this scenario, Linux was disabling runtime pm in bam dma
> driver and not doing any clock management in suspend/resume hooks.
> 
> With introduction of crypto engine bam dma, the clock is a rpmh resource
> that can be controlled from both Linux and TZ/remote side.  Now bam dma
> clock is getting enabled during probe even though the bam dma can be
> "controlled remotely". But due to clocks not being handled properly,
> bam_suspend generates a unbalanced clk_unprepare warning during system
> suspend.
> 
> To fix the above issue and to enable proper clock-management, this patch
> enables runtim-pm and handles bam dma clocks in suspend/resume hooks if
> the clock node is present irrespective of controlled_remotely property.

Applied after fixing subsystem name, thanks

-- 
~Vinod
