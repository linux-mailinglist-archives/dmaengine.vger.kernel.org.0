Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430FE3F5187
	for <lists+dmaengine@lfdr.de>; Mon, 23 Aug 2021 21:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhHWTsa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Aug 2021 15:48:30 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:31355
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229558AbhHWTs3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 23 Aug 2021 15:48:29 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3At5RJlKF3m7FQqAzapLqE78eALOsnbusQ8zAX?=
 =?us-ascii?q?PiFKOHhom6Oj/PxG8M5w6fawslcssRIb6LW90cu7IU80nKQdibX5f43SPzUO01?=
 =?us-ascii?q?HHEGgN1+ffKnHbak/D398Y5ONbf69yBMaYNzVHpMzxiTPWL+od?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="390942565"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 21:47:44 +0200
Date:   Mon, 23 Aug 2021 21:47:44 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        gustavo.pimentel@synopsys.com, vkoul@kernel.org,
        vireshk@kernel.org, wangzhou1@hisilicon.com, logang@deltatee.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: switch from 'pci_' to 'dma_' API
In-Reply-To: <fe9d57ff-bd44-3cee-516e-6815213ef467@wanadoo.fr>
Message-ID: <alpine.DEB.2.22.394.2108232145590.17496@hadrien>
References: <547fae4abef1ca3bf2198ca68e6c361b4d02f13c.1629635852.git.christophe.jaillet@wanadoo.fr> <YSNOTX68ltbt2hwf@smile.fi.intel.com> <fe9d57ff-bd44-3cee-516e-6815213ef467@wanadoo.fr>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1370404212-1629748065=:17496"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1370404212-1629748065=:17496
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Mon, 23 Aug 2021, Christophe JAILLET wrote:

> Le 23/08/2021 à 09:29, Andy Shevchenko a écrit :
> > On Sun, Aug 22, 2021 at 02:40:22PM +0200, Christophe JAILLET wrote:
> > > The wrappers in include/linux/pci-dma-compat.h should go away.
> > >
> > > The patch has been generated with the coccinelle script below.
> > >
> > > It has been hand modified to use 'dma_set_mask_and_coherent()' instead of
> > > 'pci_set_dma_mask()/pci_set_consistent_dma_mask()' when applicable.
> > > This is less verbose.
> > >
> > > It has been compile tested.
> >
> > > @@
> > > expression e1, e2;
> > > @@
> > > -    pci_set_consistent_dma_mask(e1, e2)
> > > +    dma_set_coherent_mask(&e1->dev, e2)
> >
> > Can we, please, replace this long noise in the commit message with a link to
> > a
> > script in coccinelle data base?
>
> Hi,
>
> There is no script in the coccinelle data base up to now, and there is no
> point in adding one now.
> The goal of these patches is to remove a deprecated API, so when the job will
> be finished, this script would be of no use and would be removed.
>
> However, I agree that the script as-is is noisy.
>
> I'll replace it with a link to a message already available in lore.

You can perhaps include a script that represents a very typical case or
the specific case that is relevant to the patch.

julia


>
> >
> > And the same comment for any future submission that are based on the scripts
> > (esp. coccinelle ones).
>
> I usually don't add my coccinelle scripts in the log, but I've been told times
> ago that adding them was a good practice (that I have never followed...).
>
> In this particular case, I thought it was helpful for a reviewer to see how
> the automated part had been processed.
>
> >
> > ...
> >
> > > This patch is mostly mechanical and compile tested. I hope it is ok to
> > > update the "drivers/dma/" directory all at once.
> >
> > There is another discussion with Hellwig [1] about 64-bit DMA mask,
> > i.e. it doesn't fail anymore,
>
> Yes, I'm aware of this thread.
>
> I've not taken it into account for 2 reasons:
>    - it goes beyond the goal of these patches (i.e. the removal of a
> deprecated API)
>    - I *was* not 100% confident about [1].
>
> I *was* giving credit to comment such as [2]. And the pattern "if 64 bits
> fails, then switch to 32 bits" is really common.
> Maybe it made sense in the past and has remained as-is.
>
>
> However, since then I've looked at all the architecture specific
> implementation of 'dma_supported()' and [1] looks indeed correct :)
>
>
> I propose to make these changes in another serie which will mention [1] and
> see the acceptance rate in the different subsystems. (i.e. even if the patch
> is correct, removing what looks like straightforward code may puzzle a few of
> us)
>
> I would start it once "pci-dma-compat.h" has been removed.
>
> Do you agree, or do you want it integrated in the WIP?
>
> Anyway, thanks for the review and comments.
>
> CJ
>
> > so you need to rework drivers accordingly.
> >
> > [1]: https://lkml.org/lkml/2021/6/7/398
> >
>
> [2]:
> https://elixir.bootlin.com/linux/v5.14-rc7/source/drivers/infiniband/hw/hfi1/pcie.c#L98
>
--8323329-1370404212-1629748065=:17496--
