Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429D13CC3DA
	for <lists+dmaengine@lfdr.de>; Sat, 17 Jul 2021 16:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbhGQOmr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 17 Jul 2021 10:42:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230003AbhGQOmr (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 17 Jul 2021 10:42:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B0BA760E09;
        Sat, 17 Jul 2021 14:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626532790;
        bh=jSANJ0/el7ihd7VvMP/MhVzdYyqyakZNBGb3sbTjMhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JwmtKQf44aJ2ds/I4uS5SUkcYz2fnqUnxmHXx72WKevPLvyCYGbB69TLGzOzhjI3y
         QKfrBa388PZnKgivxkhdfzNkUPpsncOifgcI88fhFNbMTY2hegcNo+mXCE2McBqGdE
         J1oF4T9L+D7gCsqxnAARKEwWp6qX8z4Iafx+g78d/Fnv1BtR8dTYh2v+YW6sGAeBbF
         WIYzjYUdSBws0PYcxEXYJgRJRGCeXsMP5eCr7NwOhdVari5+SXqL7T5bUeqWZ+jWh6
         rc3tPl7HTL4aWfZglRPpMhiHjltH3/yCXbyC93LypDYzUsLNzv32qz99ezJU2h2qk8
         +nyKMEWQHZVlg==
Date:   Sat, 17 Jul 2021 20:09:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kelvin Cheung <keguang.zhang@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5] dmaengine: Loongson1: Add Loongson1 dmaengine driver
Message-ID: <YPLrsXEmmHPtbZ+N@matsya>
References: <20210704153314.6995-1-keguang.zhang@gmail.com>
 <YO5yo8v/tRZLGEdo@matsya>
 <CAJhJPsUNCSK4VYv9Z4ZNDxC03F4CxQoAXCCf+TJmmbdUe4XNNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJhJPsUNCSK4VYv9Z4ZNDxC03F4CxQoAXCCf+TJmmbdUe4XNNA@mail.gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-07-21, 18:57, Kelvin Cheung wrote:
> Vinod Koul <vkoul@kernel.org> 于2021年7月14日周三 下午1:14写道：
> >
> > On 04-07-21, 23:33, Keguang Zhang wrote:
> >
> > > +static struct platform_driver ls1x_dma_driver = {
> > > +     .probe  = ls1x_dma_probe,
> > > +     .remove = ls1x_dma_remove,
> > > +     .driver = {
> > > +             .name   = "ls1x-dma",
> > > +     },
> > > +};
> > > +
> > > +module_platform_driver(ls1x_dma_driver);
> >
> > so my comment was left unanswered, who creates this device!
> 
> Sorry!
> This patch will create the device: https://patchwork.kernel.org/patch/12281691

Greg, looks like the above patch creates platform devices in mips, is
that the right way..?

-- 
~Vinod
