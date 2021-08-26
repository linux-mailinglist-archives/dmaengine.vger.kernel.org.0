Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B283E3F8810
	for <lists+dmaengine@lfdr.de>; Thu, 26 Aug 2021 14:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbhHZMxr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Aug 2021 08:53:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233687AbhHZMxq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 26 Aug 2021 08:53:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD68060184;
        Thu, 26 Aug 2021 12:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629982379;
        bh=XHhGpjY0FA2y0UYa/0RXWRkT6z4HWanfCrqmAUxRmO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uTiaD/jEL++G5HYo4eHyvw6VjyMszGD8TQHVq2zS0Ton8am0AB5iST1JevpEsS6kK
         vGYfEiGUbBNVDbLAXcy0brHC47rBC52Ba2jRCvPWUSS9s9Dt17Kk8tjErije2rPXLj
         LktqGb733czXFrFPolxzku+wRqq9ecVBKxDHsLvpspbrKJfyKjnb7Pz1170OS75B/x
         +CMA45L0SYcBCsDP+XR5yFW049hWu09HGQVPbZyicML2lTd5u1xHmcvFPLBI8h7mJx
         6dopyD6b4IUr5DbZP4ir5YLSyzGg4/ToMbt1jwd1przuHDv6BlbqSI9SnVtunWIvjz
         Y6resBAhV9SqA==
Date:   Thu, 26 Aug 2021 18:22:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        patches@linaro.org, Haavard Skinnemoen <hskinnemoen@atmel.com>,
        =?iso-8859-1?Q?H=E5vard?= Skinnemoen <hskinnemoen@gmail.com>
Subject: Re: [PATCH 1/2] Documentation: dmaengine: Add a description of what
 dmatest does
Message-ID: <YSeOpxIVJNCcKtEV@matsya>
References: <20210818151315.9505-1-daniel.thompson@linaro.org>
 <20210818151315.9505-2-daniel.thompson@linaro.org>
 <CAHp75VdDZJ+aUtx-A3y62WQ5+OtrS47Ts6PDe1bGQ0OcRRV+7Q@mail.gmail.com>
 <20210819091328.6up4oprx4j7u5bjl@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819091328.6up4oprx4j7u5bjl@maple.lan>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-08-21, 10:13, Daniel Thompson wrote:
> On Wed, Aug 18, 2021 at 06:27:52PM +0300, Andy Shevchenko wrote:
> > On Wed, Aug 18, 2021 at 6:15 PM Daniel Thompson
> > <daniel.thompson@linaro.org> wrote:
> > >
> > > Currently it can difficult to determine what dmatest does without
> > > reading the source code. Let's add a description.
> > >
> > > The description is taken mostly from the patch header of
> > > commit 4a776f0aa922 ("dmatest: Simple DMA memcpy test client")
> > > although it has been edited and updated slightly.
> > 
> > > Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
> > 
> > Not sure if you can use it like this (I mean the above SoB)
> 
> I wondered about that.
> 
> In the end I concluded that if I had picked up code from an old patch
> and edited to this degree then I would probably consider it a new
> patch but be clear about credit and preserve the original SoB. I saw no
> real reason to treat the contents of a patch header much different.
> 
> However, I'm very happy to make the credit more informal if needed.

It would be better if we be formal when giving credit. I am okay with
sob by Haavard if he acks it...
Daniel, Yes the intention is very noble, but I would have Haavard ack
before applying a patch with his sob, if not lets drop it and give
credit in changelog :)

-- 
~Vinod
