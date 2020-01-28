Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6CB714B41D
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jan 2020 13:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgA1MYV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Jan 2020 07:24:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:48234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgA1MYU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 28 Jan 2020 07:24:20 -0500
Received: from localhost (unknown [223.226.101.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0041C24685;
        Tue, 28 Jan 2020 12:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580214259;
        bh=BtqscQvFbrm9Hvfh2uW51lnqhOWg/ZKqqk/HxI4Up1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qdUQmUtqdRw+9h3xCJxZPnmgPE0w88p/uvrqPvpdpQY2NVJgCVCuG2L2bjiWb+6Ya
         +esNf2jMmYgrO4zO0hnY9k3ICW/kPZa3jeUI5V2DENTSts4MCG59r2ICpRGBtdpHx+
         95VeNeU3w44aK9YXEnraPxKQQRWuZOoQoSWmKgBU=
Date:   Tue, 28 Jan 2020 17:54:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     peter.ujfalusi@ti.com, dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, corbet@lwn.net,
        linux-doc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Docs build broken by driver-api/dmaengine/client.rst ? (was Re:
 [GIT PULL]: dmaengine updates for v5.6-rc1)
Message-ID: <20200128122415.GU2841@vkoul-mobl>
References: <20200127145835.GI2841@vkoul-mobl>
 <87imkvhkaq.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87imkvhkaq.fsf@mpe.ellerman.id.au>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Michael,

On 28-01-20, 22:50, Michael Ellerman wrote:
> Hi Vinod,
> 
> Vinod Koul <vkoul@kernel.org> writes:
> > Hello Linus,
> >
> > Please pull to receive the dmaengine updates for v5.6-rc1. This time we
> > have a bunch of core changes to support dynamic channels, hotplug of
> > controllers, new apis for metadata ops etc along with new drivers for
> > Intel data accelerators, TI K3 UDMA, PLX DMA engine and hisilicon
> > Kunpeng DMA engine. Also usual assorted updates to drivers.
> >
> > The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:
> >
> >   Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)
> >
> > are available in the Git repository at:
> >
> >   git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-5.6-rc1
> >
> > for you to fetch changes up to 71723a96b8b1367fefc18f60025dae792477d602:
> >
> >   dmaengine: Create symlinks between DMA channels and slaves (2020-01-24 11:41:32 +0530)
> >
> > ----------------------------------------------------------------
> > dmaengine updates for v5.6-rc1
> ...
> >
> > Peter Ujfalusi (9):
> >       dmaengine: doc: Add sections for per descriptor metadata support
> 
> This broke the docs build for me with:
> 
>   Sphinx parallel build error:
>   docutils.utils.SystemMessage: /linux/Documentation/driver-api/dmaengine/client.rst:155: (SEVERE/4) Unexpected section title.

Thanks for the report.

>   Optional: per descriptor metadata
>   ---------------------------------
> 
> 
> The patch below fixes the build. It may not produce the output you
> intended, it just makes it bold rather than a heading, but it doesn't
> really make sense to have a heading inside a numbered list.
> 
> diff --git a/Documentation/driver-api/dmaengine/client.rst b/Documentation/driver-api/dmaengine/client.rst
> index a9a7a3c84c63..343df26e73e8 100644
> --- a/Documentation/driver-api/dmaengine/client.rst
> +++ b/Documentation/driver-api/dmaengine/client.rst
> @@ -151,8 +151,8 @@ DMA usage
>       Note that callbacks will always be invoked from the DMA
>       engines tasklet, never from interrupt context.
>  
> -  Optional: per descriptor metadata
> -  ---------------------------------
> +  **Optional: per descriptor metadata**
> +

I have modified this to below as this:

--- a/Documentation/driver-api/dmaengine/client.rst
+++ b/Documentation/driver-api/dmaengine/client.rst
@@ -151,8 +151,8 @@ The details of these operations are:
      Note that callbacks will always be invoked from the DMA
      engines tasklet, never from interrupt context.
 
-  Optional: per descriptor metadata
-  ---------------------------------
+Optional: per descriptor metadata
+---------------------------------
   DMAengine provides two ways for metadata support.
 
   DESC_METADATA_CLIENT

And I will add this as fixes and it should be in linux-next tomorrow

Thanks
-- 
~Vinod
