Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91846438EF9
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 07:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhJYFuf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 01:50:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229499AbhJYFue (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 01:50:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29FEB60EB1;
        Mon, 25 Oct 2021 05:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635140893;
        bh=F2y/3o0zeB+0SRvUByeG1vgqp+2aD7kVr/HEc0mfDEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Shb3DBNa5iVgE4FvIvujpFPciXMjDKsRAhi00MZgn6qF03aUTWtffz3Dnjkl3ChVC
         7MtwWXiTgK4lfWVCuKROwN7Cp1abf/sqJ2N3xxqzAqX8tqKTKnkNtWn3Bn/ernxBMX
         Qm2VAXIatDZW65/SGTFeoTseEAnLRnbrQ6sp4vjdz848gS/eSTIx1i+ENRkPszIvMu
         JkokHQHJejY7HthZtnMZ5kpwtToaKEydubHWLCUq1GyS87fFdc+zOqah0HtBaHRHxB
         uIx+vnzh22rb7Z4ew4hyUKVUNCAVDdiEer0ot5F8A+c7oTXc8qMnOti0mheMeCV2h+
         KlVxmaqwQFyww==
Date:   Mon, 25 Oct 2021 11:18:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 0/2] dmaengine: qcom: bam_dma: Add "powered remotely"
 mode for BAM-DMUX
Message-ID: <YXZFGFH5lxDKeenw@matsya>
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

This looks good me me. Bhupesh/Stephan what was the conclusion on the
the discussion you folks had?

> 
> For more information about BAM-DMUX itself, see the series on netdev:
> https://lore.kernel.org/netdev/20211011141733.3999-5-stephan@gerhold.net/
> 
> Changes in v3:
>   - Split dmaengine changes to a separate series
>   - Address review comments from Bjorn
> 
> v2: https://lore.kernel.org/netdev/20211011141733.3999-1-stephan@gerhold.net/
> RFC: https://lore.kernel.org/netdev/20210719145317.79692-1-stephan@gerhold.net/
> 
> 
> Stephan Gerhold (2):
>   dt-bindings: dmaengine: bam_dma: Add "powered remotely" mode
>   dmaengine: qcom: bam_dma: Add "powered remotely" mode
> 
>  .../devicetree/bindings/dma/qcom_bam_dma.txt  |  2 +
>  drivers/dma/qcom/bam_dma.c                    | 90 ++++++++++++-------
>  2 files changed, 59 insertions(+), 33 deletions(-)
> 
> -- 
> 2.33.0

-- 
~Vinod
