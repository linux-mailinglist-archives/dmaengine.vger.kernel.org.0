Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECA43CC4F1
	for <lists+dmaengine@lfdr.de>; Sat, 17 Jul 2021 19:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbhGQRm1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 17 Jul 2021 13:42:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233702AbhGQRmZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 17 Jul 2021 13:42:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EF3B608FE;
        Sat, 17 Jul 2021 17:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626543567;
        bh=Q+2bkD5WfuZSmFgsqVWfw6pshTe4O9qGgeLkE8FzIks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aSUX4iwQlT4MAMXCc0u9QSoN+8U4sRTlIEbQc2QCVHXZ5lmIUGBRnEa7kduKrOZvQ
         5l5fSwyTJbeE6tTv6KBaOJvQ02+pQ21s5OJ/QB9q9KZhaix6rPWkTQKZ8HN0pBIDqu
         ODYgs6tTVN1u58YXt7MjFlsxuepek94iQNJVzmX4=
Date:   Sat, 17 Jul 2021 19:39:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kelvin Cheung <keguang.zhang@gmail.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5] dmaengine: Loongson1: Add Loongson1 dmaengine driver
Message-ID: <YPMVyYoBojHYsMbJ@kroah.com>
References: <20210704153314.6995-1-keguang.zhang@gmail.com>
 <YO5yo8v/tRZLGEdo@matsya>
 <CAJhJPsUNCSK4VYv9Z4ZNDxC03F4CxQoAXCCf+TJmmbdUe4XNNA@mail.gmail.com>
 <YPLrsXEmmHPtbZ+N@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YPLrsXEmmHPtbZ+N@matsya>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Jul 17, 2021 at 08:09:45PM +0530, Vinod Koul wrote:
> On 17-07-21, 18:57, Kelvin Cheung wrote:
> > Vinod Koul <vkoul@kernel.org> 于2021年7月14日周三 下午1:14写道：
> > >
> > > On 04-07-21, 23:33, Keguang Zhang wrote:
> > >
> > > > +static struct platform_driver ls1x_dma_driver = {
> > > > +     .probe  = ls1x_dma_probe,
> > > > +     .remove = ls1x_dma_remove,
> > > > +     .driver = {
> > > > +             .name   = "ls1x-dma",
> > > > +     },
> > > > +};
> > > > +
> > > > +module_platform_driver(ls1x_dma_driver);
> > >
> > > so my comment was left unanswered, who creates this device!
> > 
> > Sorry!
> > This patch will create the device: https://patchwork.kernel.org/patch/12281691
> 
> Greg, looks like the above patch creates platform devices in mips, is
> that the right way..?

I do not understand, what exactly is the question?

thanks,

greg k-h
