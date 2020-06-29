Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51C220E5BA
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2020 00:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbgF2Vk6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Jun 2020 17:40:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728214AbgF2SkV (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 29 Jun 2020 14:40:21 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 994E1235FF;
        Mon, 29 Jun 2020 09:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593424331;
        bh=FvnI01MrqwrGCSn1pXUy+BedbEZpbcC56ZDWbIF8mFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SBvp+p2JVOK+mbuCO0DyD4m6cTuqvLnfQwf0MoDwwc8qToNCpesGe8dGwvR4NHuwO
         Um0wpFOI/f3glHy7M5ECcY13Z3m0pS1xZjX2DpfInnFAL2wXMZ7j9bYOC/Yc/h/5lx
         oe0ArLBMZ0u5XA50l1TuR2YiQ+bH3SrCAP+UPgQ0=
Date:   Mon, 29 Jun 2020 15:22:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amit Tomer <amittomer25@gmail.com>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH v4 02/10] dmaengine: Actions: Add support for S700 DMA
 engine
Message-ID: <20200629095207.GG2599@vkoul-mobl>
References: <1591697830-16311-1-git-send-email-amittomer25@gmail.com>
 <1591697830-16311-3-git-send-email-amittomer25@gmail.com>
 <20200624061529.GF2324254@vkoul-mobl>
 <CABHD4K-Z7_MkG-j1uAt6XGnz4zWzNYeuEgq=BwE=NXPwY6gb6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABHD4K-Z7_MkG-j1uAt6XGnz4zWzNYeuEgq=BwE=NXPwY6gb6g@mail.gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-06-20, 13:49, Amit Tomer wrote:
> Hi Vinod,
> 
> Thanks for having a look and providing the comments.
> 
> > Is the .compatible documented, Documentation patch should come before
> > the driver use patch in a series
> 
> Yes, this new compatible string is documented in patch (05/10).
> I would make it as a patch (1/10).
> 
> > >  static int owl_dma_probe(struct platform_device *pdev)
> > >  {
> > >       struct device_node *np = pdev->dev.of_node;
> > >       struct owl_dma *od;
> > >       int ret, i, nr_channels, nr_requests;
> > > +     const struct of_device_id *of_id =
> > > +                             of_match_device(owl_dma_match, &pdev->dev);
> >
> > You care about driver_data rather than of_id, so using
> > of_device_get_match_data() would be better..
> 
> Okay. would take care of it in next version.
> 
> > >       od = devm_kzalloc(&pdev->dev, sizeof(*od), GFP_KERNEL);
> > >       if (!od)
> > > @@ -1083,6 +1116,8 @@ static int owl_dma_probe(struct platform_device *pdev)
> > >       dev_info(&pdev->dev, "dma-channels %d, dma-requests %d\n",
> > >                nr_channels, nr_requests);
> > >
> > > +     od->devid = (enum owl_dma_id)(uintptr_t)of_id->data;
> >
> > Funny casts, I dont think you need uintptr_t!
> 
> But without this cast, clang compiler emits following warning:
> 
> warning: cast to smaller integer type 'enum owl_dma_id' from 'const void *'
>           [-Wvoid-pointer-to-enum-cast]

If you use of_device_get_match_data() you will not fall into this :)

-- 
~Vinod
