Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E40A414C706
	for <lists+dmaengine@lfdr.de>; Wed, 29 Jan 2020 08:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgA2Hr6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jan 2020 02:47:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54284 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgA2Hr6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Jan 2020 02:47:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JU/A4UwJ1IyRTopX0f87qbebUP5pLV938wEWT8rjTKI=; b=i1HVuSu/uukfS5FFNTLzBhEdc
        KWZiBYHMCU2/yaBXk0tb61vn9HfCggj+zMmnIq0pskPY7uMyrsStXjnTZc5+foMYWNgYTPGNvmN2u
        6U/hnaJ7CFhmvPiHOTGGSTYBVUy+Cw4xnZsliWernV9hu7aSssSh9eqeYcD8AiH1xBGKyJBeAqTCs
        hPDktNYanUerbgoPzp3LdXA0WZzn5bm/k6kiYclisJxbwjHSe4XCudwh1YW7Nbh31zzEo+nZys1Ny
        bme8Ia6QaX59CDFSH5tuUnJL7j0Qo75s+tv4fbZpo6r6YkqBccYcrVlr94TrRiqnnroNx71qN2G2S
        Az10mVT4g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwi4o-0004ho-Te; Wed, 29 Jan 2020 07:47:54 +0000
Date:   Tue, 28 Jan 2020 23:47:54 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, corbet@lwn.net,
        linux-doc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Docs build broken by driver-api/dmaengine/client.rst ? (was Re:
 [GIT PULL]: dmaengine updates for v5.6-rc1)
Message-ID: <20200129074754.GG6615@bombadil.infradead.org>
References: <20200127145835.GI2841@vkoul-mobl>
 <87imkvhkaq.fsf@mpe.ellerman.id.au>
 <20200128122415.GU2841@vkoul-mobl>
 <f88ed09c-6244-71e5-3be4-b733ee348b79@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f88ed09c-6244-71e5-3be4-b733ee348b79@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Jan 28, 2020 at 02:35:17PM +0200, Peter Ujfalusi wrote:
> Hi Michael, Vinod,
> 
> On 28/01/2020 14.24, Vinod Koul wrote:
> > Hi Michael,
> > 
> > On 28-01-20, 22:50, Michael Ellerman wrote:
> >> Hi Vinod,
> >>
> >> Vinod Koul <vkoul@kernel.org> writes:
> >>> Hello Linus,
> >>>
> >>> Please pull to receive the dmaengine updates for v5.6-rc1. This time we
> >>> have a bunch of core changes to support dynamic channels, hotplug of
> >>> controllers, new apis for metadata ops etc along with new drivers for
> >>> Intel data accelerators, TI K3 UDMA, PLX DMA engine and hisilicon
> >>> Kunpeng DMA engine. Also usual assorted updates to drivers.
> >>>
> >>> The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:
> >>>
> >>>   Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)
> >>>
> >>> are available in the Git repository at:
> >>>
> >>>   git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-5.6-rc1
> >>>
> >>> for you to fetch changes up to 71723a96b8b1367fefc18f60025dae792477d602:
> >>>
> >>>   dmaengine: Create symlinks between DMA channels and slaves (2020-01-24 11:41:32 +0530)
> >>>
> >>> ----------------------------------------------------------------
> >>> dmaengine updates for v5.6-rc1
> >> ...
> >>>
> >>> Peter Ujfalusi (9):
> >>>       dmaengine: doc: Add sections for per descriptor metadata support
> >>
> >> This broke the docs build for me with:
> >>
> >>   Sphinx parallel build error:
> >>   docutils.utils.SystemMessage: /linux/Documentation/driver-api/dmaengine/client.rst:155: (SEVERE/4) Unexpected section title.
> > 
> > Thanks for the report.
> > 
> >>   Optional: per descriptor metadata
> >>   ---------------------------------
> >>
> >>
> >> The patch below fixes the build. It may not produce the output you
> >> intended, it just makes it bold rather than a heading, but it doesn't
> >> really make sense to have a heading inside a numbered list.
> >>
> >> diff --git a/Documentation/driver-api/dmaengine/client.rst b/Documentation/driver-api/dmaengine/client.rst
> >> index a9a7a3c84c63..343df26e73e8 100644
> >> --- a/Documentation/driver-api/dmaengine/client.rst
> >> +++ b/Documentation/driver-api/dmaengine/client.rst
> >> @@ -151,8 +151,8 @@ DMA usage
> >>       Note that callbacks will always be invoked from the DMA
> >>       engines tasklet, never from interrupt context.
> >>  
> >> -  Optional: per descriptor metadata
> >> -  ---------------------------------
> >> +  **Optional: per descriptor metadata**
> >> +
> > 
> > I have modified this to below as this:
> > 
> > --- a/Documentation/driver-api/dmaengine/client.rst
> > +++ b/Documentation/driver-api/dmaengine/client.rst
> > @@ -151,8 +151,8 @@ The details of these operations are:
> >       Note that callbacks will always be invoked from the DMA
> >       engines tasklet, never from interrupt context.
> >  
> > -  Optional: per descriptor metadata
> > -  ---------------------------------
> > +Optional: per descriptor metadata
> > +---------------------------------
> >    DMAengine provides two ways for metadata support.
> >  
> >    DESC_METADATA_CLIENT
> > 
> > And I will add this as fixes and it should be in linux-next tomorrow
> 
> Sorry for breaking the build and thanks Vinod for the quick fix!

Can I suggest, in future, 'make W=1'.  That will run the kernel-doc
script which would presumably have caught this problem.  If we get all
the existing doc errors cleaned up, we can promote that to be run as
part of the standard build, but until then we don't want to dump 700
new errors on everybody.
