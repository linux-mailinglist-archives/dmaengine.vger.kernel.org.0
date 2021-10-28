Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A55E43E6E6
	for <lists+dmaengine@lfdr.de>; Thu, 28 Oct 2021 19:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhJ1RPP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Oct 2021 13:15:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230407AbhJ1RPO (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 28 Oct 2021 13:15:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8B10610D2;
        Thu, 28 Oct 2021 17:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635441167;
        bh=ibmNM5CAP+qkvNSTKFVFajWtkJ/8NkO96LVf+y9D+nY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ltwsdmgN3hZPosmJF9mNYeN9Be8c7B9vhCrXv1fYbzGAg2V9dkqkElleQgHLjP9H+
         rd/KtukSITnYFE1yc3NinjDiyMFQPDmrmqcKG89A6jEnZjCwRQ+kW6PnmdWdsF6cnh
         cmcgoABtLQm2QmWLb/FTCvdkLa3F0Xyk3Oyw303Ix7TuHcPSiX/VIqCMmCd6nAYui8
         nVRly0H/n8r3unTTFxUlxAfleWEKLD7HPIpNSdDUf1rOduopBn9NrpHcHU2cnuAyvl
         UEeVTZsb2nBbVS5yqM/whlUXgBq6lqTxsTPel8NvuO47fqoE1163y7gVgHQYBUFOQ8
         v0LUUJIjObC+g==
Date:   Thu, 28 Oct 2021 22:42:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 0/2] dmaengine: qcom: bam_dma: Add "powered remotely"
 mode for BAM-DMUX
Message-ID: <YXraCwi0RpShcYnQ@matsya>
References: <20211018102421.19848-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018102421.19848-1-stephan@gerhold.net>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-10-21, 12:24, Stephan Gerhold wrote:
> The BAM Data Multiplexer (BAM-DMUX) provides access to the network data
> channels of modems integrated into many older Qualcomm SoCs, e.g.
> Qualcomm MSM8916 or MSM8974.
> 
> Shortly said, BAM-DMUX is built using a simple protocol layer on top of
> a DMA engine (Qualcomm BAM DMA). For BAM-DMUX, the BAM DMA engine runs in
> a special mode where the modem/remote side is responsible for powering
> on the BAM when needed but we are responsible to initialize it.
> The BAM is powered off when unneeded by coordinating power control
> via bidirectional interrupts from the BAM-DMUX driver.
> 
> This series adds one possible solution for handling the "powered remotely"
> mode in the bam_dma driver.

Applied, thanks

-- 
~Vinod
