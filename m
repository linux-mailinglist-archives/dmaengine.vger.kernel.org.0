Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04BC3BB5F5
	for <lists+dmaengine@lfdr.de>; Mon,  5 Jul 2021 05:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhGEDvx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 4 Jul 2021 23:51:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229722AbhGEDvx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 4 Jul 2021 23:51:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE11F6135E;
        Mon,  5 Jul 2021 03:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625456956;
        bh=pSWTYD7+rgxGLmQKw8kDoz3wh1zx9cykgZSMER+kE/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AALlwd+apx3Rbawu+E16+x1jqReiMhNbLFREI5kP0/wjaa+evSt/QvZnHhh0dhHqz
         SSLmqR0JX6qDQiquf7kDmneTIrPGpqRZLoLW3vNqym6ickz2uyu55onDZTHH1BSzcm
         5LKgTgXiQzsg84ER/9j32cVBnwy7v9Bed62Bbblw0L6yHJg2Cg1uWcVxMmO99AabJ6
         fM42ZbiMumO8Pp3k/nyg+XxrOCC5ruP0OMslxZ0HCUegnrHZkeni0RW0j6eBnKZ4ni
         mi5SDyZUc8IqVTPe/9p40pUVffMUsW8M5u5bnzZV3YLzdnWze4oS0THiA+8C4KecRN
         BA0HyYGpPCMew==
Date:   Mon, 5 Jul 2021 09:19:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kelvin Cheung <keguang.zhang@gmail.com>
Cc:     dmaengine@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 RESEND] dmaengine: Loongson1: Add Loongson1 dmaengine
 driver
Message-ID: <YOKBOFpNH0+3GN6e@matsya>
References: <20210520230225.11911-1-keguang.zhang@gmail.com>
 <YL392y4a6iRf1UyQ@vkoul-mobl>
 <CAJhJPsXv42e23tyQjA52_my1Au6nP_VdLX3c_yzk5MxadQ95iw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJhJPsXv42e23tyQjA52_my1Au6nP_VdLX3c_yzk5MxadQ95iw@mail.gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 04-07-21, 22:45, Kelvin Cheung wrote:
> Vinod Koul <vkoul@kernel.org> 于2021年6月7日周一 下午7:07写道：
> >
> > On 21-05-21, 07:02, Keguang Zhang wrote:
> >
> > > +config LOONGSON1_DMA
> > > +     tristate "Loongson1 DMA support"
> > > +     depends on MACH_LOONGSON32
> >
> > Why does it have to do that? The dma driver is generic..
> 
> This driver is only available for LOONGSON32 CPUs.

the underlaying firmware would ensure this driver is probed if you have
such a device, so why have this restriction?

> > > +static struct platform_driver ls1x_dma_driver = {
> > > +     .probe  = ls1x_dma_probe,
> > > +     .remove = ls1x_dma_remove,
> > > +     .driver = {
> > > +             .name   = "ls1x-dma",
> > > +     },
> >
> > No device tree?
> 
> Because the LOONGSON32 platform doesn't support DT yet.

Okay so how is the platform device created?

-- 
~Vinod
