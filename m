Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1450C74E99
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jul 2019 14:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388175AbfGYM5U (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Jul 2019 08:57:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387901AbfGYM5U (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 25 Jul 2019 08:57:20 -0400
Received: from localhost (unknown [49.207.58.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43F4C21951;
        Thu, 25 Jul 2019 12:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564059439;
        bh=FlAS0meNcpi2B0Olgi6LqXwhxBfLfEwcgPcnvyz/KMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GsetMlTR3gjxQwbPFOilUpyFZPxSm9wmQ/kh98l9cwra9w6gtXpX61HdhzABxdpot
         CBMgzydkiflCOC3OBrzhXkoJbQkWrX255IDJZ1bidMMtiR5z6wGCU3NZY6QX6VZlSI
         a1rLbMeXueZ3R+in4qEayP1crfUM4OPqOIuP46RE=
Date:   Thu, 25 Jul 2019 18:26:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        Sameer Pujar <spujar@nvidia.com>
Subject: Re: [RESEND PATCH] dmaengine: tegra210-adma: Don't program FIFO
 threshold
Message-ID: <20190725125604.GU12733@vkoul-mobl.Dlink>
References: <20190705091557.726-1-jonathanh@nvidia.com>
 <20190705130531.GE2911@vkoul-mobl>
 <ac13d007-4b42-c3af-70db-de06703eb154@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac13d007-4b42-c3af-70db-de06703eb154@nvidia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10-07-19, 10:11, Jon Hunter wrote:
> 
> On 05/07/2019 14:05, Vinod Koul wrote:
> > On 05-07-19, 10:15, Jon Hunter wrote:
> >> From: Jonathan Hunter <jonathanh@nvidia.com>
> >>
> >> The Tegra210 ADMA supports two modes for transferring data to a FIFO
> >> which are ...
> >>
> >> 1. Transfer data to/from the FIFO as soon as a single burst can be
> >>    transferred.
> >> 2. Transfer data to/from the FIFO based upon FIFO thresholds, where
> >>    the FIFO threshold is specified in terms on multiple bursts.
> >>
> >> Currently, the ADMA driver programs the FIFO threshold values in the
> >> FIFO_CTRL register, but never enables the transfer mode that uses
> >> these threshold values. Given that these have never been used so far,
> >> simplify the ADMA driver by removing the programming of these threshold
> >> values.
> >>
> >> Signed-off-by: Jonathan Hunter <jonathanh@nvidia.com>
> >> Acked-by: Thierry Reding <treding@nvidia.com>
> >> ---
> >>
> >> Resending the patch rebased on top next-20190704. I have added Thierry's
> >> ACK as well.
> > 
> > Thanks but this fails as well. I had applied few tegra patches so I
> > suspect that is causing issues now. It would have been nice to have them
> > in series.
> > 
> > Would you rebase on
> > git.kernel.org/pub/scm/linux/kernel/git/vkoul/slave-dma.git next (yeah
> > this is different location, i dont see to push to infradead today)
> 
> So this patch should apply cleanly on top of the fixes series I sent for
> v5.2 [0] which you merged and is now in mainline. So if I rebase on the
> above, I wondering if it is then going to conflict with mainline? Looks
> like the above branch is based upon v5.2-rc1 and hence the conflict.

Can you resend this now that merge window is closed and dependent
patches are merged.

Thanks
-- 
~Vinod
