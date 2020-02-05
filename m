Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCD6C1525AA
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2020 05:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgBEEn6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Feb 2020 23:43:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:50606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727879AbgBEEn5 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 4 Feb 2020 23:43:57 -0500
Received: from localhost (unknown [49.207.63.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14CAC2085B;
        Wed,  5 Feb 2020 04:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580877837;
        bh=k4/1T+HhTSCuFjv1n9/8fjT04o7baYWhF50eAka6OQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yB/Eet4KOP/iwRCK+7Yenry7SZkZfkA27+2iwcxdJL4S0ffJkrjw0mqyYIdTLk/oL
         htxDkACD6d66vStqduOxElwJQ4ohy89ieIORJIuEfKngjiogSuE05QFmdKP0nQ+o0C
         jg0zpeExl/Htr/WAnFAskSNgpWHguQVypEa9M7eE=
Date:   Wed, 5 Feb 2020 10:13:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 0/3] dmaengine: Stear users towards
 dma_request_slave_chan()
Message-ID: <20200205044352.GC2618@vkoul-mobl>
References: <20200203101806.2441-1-peter.ujfalusi@ti.com>
 <CAHp75Vf__isc59YBS9=O+9ApSV62XuZ2nBAWKKD_K7i72P-yFg@mail.gmail.com>
 <20200204062118.GS2841@vkoul-mobl>
 <CAHp75VeRemcJkMMB7D2==Y-A4We=s1ntojZoPRdVS8vs+dB_Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeRemcJkMMB7D2==Y-A4We=s1ntojZoPRdVS8vs+dB_Ew@mail.gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 04-02-20, 13:21, Andy Shevchenko wrote:
> On Tue, Feb 4, 2020 at 8:21 AM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > On 03-02-20, 12:37, Andy Shevchenko wrote:
> > > On Mon, Feb 3, 2020 at 12:32 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> > >
> > > > dma_request_slave_channel_reason() no longer have user in mainline, it
> > > > can be removed.
> > > >
> > > > Advise users of dma_request_slave_channel() and
> > > > dma_request_slave_channel_compat() to move to dma_request_slave_chan()
> > >
> > > How? There are legacy ARM boards you have to care / remove before.
> > > DMAengine subsystem makes a p*s off decisions without taking care of
> > > (I'm talking now about dma release callback, for example) end users.
> >
> > Can you elaborate issue you are seeing with dma_release callback?
> 
> 
> [    7.980381] intel-lpss 0000:00:1e.3: WARN: Device release is not
> defined so it is not safe to unbind this driver while in use

Yes that is expected but is not valid in your case.

Anyway this will be turned off before the release.

> It's not limited to that driver, but actually all I'm maintaining.
> 
> Users are not happy!
> 
> -- 
> With Best Regards,
> Andy Shevchenko

-- 
~Vinod
