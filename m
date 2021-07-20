Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A19223CF919
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jul 2021 13:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236874AbhGTLGJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Jul 2021 07:06:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237775AbhGTLD2 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Jul 2021 07:03:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D69946113A;
        Tue, 20 Jul 2021 11:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626781437;
        bh=MHZkExzU8HdUKUa0EhCAB0MiLdwoljiL9Ho9vDzs0HY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mzQ6fmwIsG8MwWggE9QSHUgeypP49IlnS6UMaR6ZMs4bdbM/D9ETK7+JGHmtY2F8s
         LrwgoOW4lMcPIbZMx5EQGSagD2ldDDtjYLX5OAUzUjATcDkGjlwHlg4kMBP5xUXwP+
         lWJ4qgsns0ZFpV6YKHOrujoyKqKszALyffhB0ttKYEcKyRBoGY5t9+GoQacyalDvkv
         tA2znRT8OC4LD3kLsxJa+P93jJCGta2RvJUI70nX++3yA71LJInMElieZF8TQ8LYQZ
         NOtMX85HLS75eKBEqp+mZWyzLITIyzEQdka/IC+qdufQD9wdrv8RFXb9lALkaBwSry
         J+uopTF42Re7g==
Date:   Tue, 20 Jul 2021 17:13:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Kelvin Cheung <keguang.zhang@gmail.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5] dmaengine: Loongson1: Add Loongson1 dmaengine driver
Message-ID: <YPa2+TsdL0PrR3hR@matsya>
References: <20210704153314.6995-1-keguang.zhang@gmail.com>
 <YO5yo8v/tRZLGEdo@matsya>
 <CAJhJPsUNCSK4VYv9Z4ZNDxC03F4CxQoAXCCf+TJmmbdUe4XNNA@mail.gmail.com>
 <YPLrsXEmmHPtbZ+N@matsya>
 <YPMVyYoBojHYsMbJ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YPMVyYoBojHYsMbJ@kroah.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-07-21, 19:39, Greg KH wrote:
> On Sat, Jul 17, 2021 at 08:09:45PM +0530, Vinod Koul wrote:
> > On 17-07-21, 18:57, Kelvin Cheung wrote:
> > > Vinod Koul <vkoul@kernel.org> 于2021年7月14日周三 下午1:14写道：
> > > >
> > > > On 04-07-21, 23:33, Keguang Zhang wrote:
> > > >
> > > > > +static struct platform_driver ls1x_dma_driver = {
> > > > > +     .probe  = ls1x_dma_probe,
> > > > > +     .remove = ls1x_dma_remove,
> > > > > +     .driver = {
> > > > > +             .name   = "ls1x-dma",
> > > > > +     },
> > > > > +};
> > > > > +
> > > > > +module_platform_driver(ls1x_dma_driver);
> > > >
> > > > so my comment was left unanswered, who creates this device!
> > > 
> > > Sorry!
> > > This patch will create the device: https://patchwork.kernel.org/patch/12281691
> > 
> > Greg, looks like the above patch creates platform devices in mips, is
> > that the right way..?
> 
> I do not understand, what exactly is the question?

So this patch was adding Loongson1 dmaengine driver which is a platform
device. I asked about the platform device and was told that [1] creates
the platform device. I am not sure if that is the recommended way given
that you have been asking people to not use platform devices.

[1]: https://patchwork.kernel.org/patch/12281691

So is [1] the correct approach or should this be fixed?

-- 
~Vinod
