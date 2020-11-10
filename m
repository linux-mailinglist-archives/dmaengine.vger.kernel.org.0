Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396A32AD685
	for <lists+dmaengine@lfdr.de>; Tue, 10 Nov 2020 13:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbgKJMlV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Nov 2020 07:41:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:37810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgKJMlV (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 10 Nov 2020 07:41:21 -0500
Received: from localhost (unknown [122.179.121.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0257F20781;
        Tue, 10 Nov 2020 12:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605012081;
        bh=ard1d19oRDra6MZ9aZxhbhFaafZydasHklvznOS+FDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w1wbeq71/B+KKPK42SjE+1euAGBMPU+9cLeJRu4GN5/KRuCvNBWQCTC9lUZVhz0t9
         WvGOmuzNB7a3Wg95rLPb5Yhd+4dSUFikvzE2CofARSB36DQckBiOxwtMxQNN/E8JaF
         pXWTNTcuAUd4RKY0te5LPaXeScKxW6jNgt/3uaBc=
Date:   Tue, 10 Nov 2020 18:11:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Block PM if SDMA is busy to fix
 audio
Message-ID: <20201110124116.GS3171@vkoul-mobl>
References: <20201109154013.11950-1-tony@atomide.com>
 <acf280b4-f34d-cfc6-874c-48843cd54365@ti.com>
 <39089a2c-a883-d9b4-f1d6-493af2190410@ti.com>
 <20201110113346.GD26857@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110113346.GD26857@atomide.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10-11-20, 13:33, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [201110 07:59]:
> > Hi,
> > 
> > On 10/11/2020 9.58, Peter Ujfalusi wrote:
> > > Hi Tony,
> > > 
> > > On 09/11/2020 17.40, Tony Lindgren wrote:
> > >> We now use cpu_pm for saving and restoring device context for deeper SoC
> > >> idle states. But for omap3, we must also block idle if SDMA is busy.
> > >>
> > >> If we don't block idle when SDMA is busy, we eventually end up saving and
> > >> restoring SDMA register state on PER domain idle while SDMA is active and
> > >> that causes at least audio playback to fail.
> > > 
> > > Thanks for the fix!
> > > 
> > > Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > > Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > > 
> > > Vinod: Can you take this for 5.10 as a fix? The off mode got enabled by
> > > default in 5.10-rc1 and audio got broken out of box.
> > 
> > to Vinod with corrected email address..
> 
> Sorry about that, I've bounced the original patch too. Vinod let me know if
> you want me to resend the patch.

That is okay, we have b4 now, so not much of a hassle to grab, review
and apply, will do that shortly

And here is my rant to use get_maintainers.pl which should have pointed
you to the correct address ;-)

-- 
~Vinod
