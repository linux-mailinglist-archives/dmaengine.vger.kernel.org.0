Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DC54884B1
	for <lists+dmaengine@lfdr.de>; Sat,  8 Jan 2022 17:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbiAHQrW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 8 Jan 2022 11:47:22 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51974 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbiAHQrW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 8 Jan 2022 11:47:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1EC460BC1;
        Sat,  8 Jan 2022 16:47:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391E3C36AE0;
        Sat,  8 Jan 2022 16:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641660441;
        bh=U9npFUY7iCNVH3ln8/o5iklMBDi5AfqGyHfPSKi4pr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GcJMkICcYbl5UyZ4Yp0+pox+Oo8YbsFZkKbAFVDDmO5pP1ot9LxvD/waLiUakx34k
         Gw1FY+79d0l/itXMxsr0dxr3WqkDQuNDpMTnFHoZSLo6GuWuiUfplBhfxLg9HuSllJ
         pC3ZDeUdwSUlM9Nn/LOvQGlBMQOHV7WKX+Vs0w7bBEnOli2yxtkAOvOiYr18okSDwO
         L6qO7DQ9IThNYJU7PcfyrZjFInjpDVHF4hsE5J0k+U0fK2GXqeHtxIey1U5NeaI/+i
         uWCWf9oXlAzQCgCrHL5OZ85rTAQlqKeivTJSa9Sqd2q49QKIxSeM6GMhiHI+qiLUS6
         KdgE3YfRiz/UQ==
Date:   Sat, 8 Jan 2022 22:17:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        dmaengine@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH 07/16] dmaengine: pch_dma: Remove usage of the deprecated
 "pci-dma-compat.h" API
Message-ID: <YdnAFMnXq0h8wj9V@matsya>
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
 <b88f25f3d07be92dd75494dc129a85619afb1366.1641500561.git.christophe.jaillet@wanadoo.fr>
 <CAK8P3a2J_QZtqq8_y8hwSo4T_Dh_4f_WXy9osomHeBND3-abgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2J_QZtqq8_y8hwSo4T_Dh_4f_WXy9osomHeBND3-abgA@mail.gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-01-22, 19:56, Arnd Bergmann wrote:
> On Thu, Jan 6, 2022 at 4:52 PM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
> >
> > In [1], Christoph Hellwig has proposed to remove the wrappers in
> > include/linux/pci-dma-compat.h.
> >
> > Some reasons why this API should be removed have been given by Julia
> > Lawall in [2].
> >
> > A coccinelle script has been used to perform the needed transformation.
> > It can be found in [3].
> >
> > [1]: https://lore.kernel.org/kernel-janitors/20200421081257.GA131897@infradead.org/
> > [2]: https://lore.kernel.org/kernel-janitors/alpine.DEB.2.22.394.2007120902170.2424@hadrien/
> > [3]: https://lore.kernel.org/kernel-janitors/20200716192821.321233-1-christophe.jaillet@wanadoo.fr/
> >
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> Vinod, can you apply this one to the dmaengine tree? It has no other
> dependencies.

Sure, applied now.

Thanks
-- 
~Vinod
