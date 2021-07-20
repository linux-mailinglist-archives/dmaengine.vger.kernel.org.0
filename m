Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777723CF973
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jul 2021 14:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235524AbhGTLhs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Jul 2021 07:37:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234417AbhGTLhr (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Jul 2021 07:37:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D31B6113B;
        Tue, 20 Jul 2021 12:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626783505;
        bh=VIQnM/IKpMG9t235B8zbrp4hUhe5FWvYJ4Jx0VCgmh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q9kiumv2VZXe4Bjzpjb/1THxPHpv0nZeR8RbhNvHwMRkBatuvXLGejbTlYjr/m4lH
         ctgUV94yu61G3yQISVN5+LTKycqI+XilAWRp1Ar/NiqmsHJMNXlE/KlxqG0Y+yGFgk
         /163Z3npgPrMurRMFzF662r0TlgHEqBxb8BWNOWbvxfsmaui7ZHIebj7/bNZS0YioQ
         1ClnU9YJQTBolW8UEMi9lH71UK6nFmfNt36Z/VpiViaen735egkL0pCIgJIVzaJZqr
         cbBK7iDdQO0OFDd4w3PvKXlHy3jZ5T9m7ii4jHKaaU8B250FHKozwhTcSMX3O40gs0
         QEgfX4rkQAr2w==
Date:   Tue, 20 Jul 2021 17:48:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Kelvin Cheung <keguang.zhang@gmail.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5] dmaengine: Loongson1: Add Loongson1 dmaengine driver
Message-ID: <YPa/DsO1vWcXKJKd@matsya>
References: <20210704153314.6995-1-keguang.zhang@gmail.com>
 <YO5yo8v/tRZLGEdo@matsya>
 <CAJhJPsUNCSK4VYv9Z4ZNDxC03F4CxQoAXCCf+TJmmbdUe4XNNA@mail.gmail.com>
 <YPLrsXEmmHPtbZ+N@matsya>
 <YPMVyYoBojHYsMbJ@kroah.com>
 <YPa2+TsdL0PrR3hR@matsya>
 <YPa4IAk3sh7bai15@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YPa4IAk3sh7bai15@kroah.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-07-21, 13:48, Greg KH wrote:
> On Tue, Jul 20, 2021 at 05:13:53PM +0530, Vinod Koul wrote:
> > On 17-07-21, 19:39, Greg KH wrote:
> > > On Sat, Jul 17, 2021 at 08:09:45PM +0530, Vinod Koul wrote:
> > > > On 17-07-21, 18:57, Kelvin Cheung wrote:
> > > > > Vinod Koul <vkoul@kernel.org> 于2021年7月14日周三 下午1:14写道：
> > > > > >
> > > > > > On 04-07-21, 23:33, Keguang Zhang wrote:
> > > > > >
> > > > > > > +static struct platform_driver ls1x_dma_driver = {
> > > > > > > +     .probe  = ls1x_dma_probe,
> > > > > > > +     .remove = ls1x_dma_remove,
> > > > > > > +     .driver = {
> > > > > > > +             .name   = "ls1x-dma",
> > > > > > > +     },
> > > > > > > +};
> > > > > > > +
> > > > > > > +module_platform_driver(ls1x_dma_driver);
> > > > > >
> > > > > > so my comment was left unanswered, who creates this device!
> > > > > 
> > > > > Sorry!
> > > > > This patch will create the device: https://patchwork.kernel.org/patch/12281691
> > > > 
> > > > Greg, looks like the above patch creates platform devices in mips, is
> > > > that the right way..?
> > > 
> > > I do not understand, what exactly is the question?
> > 
> > So this patch was adding Loongson1 dmaengine driver which is a platform
> > device. I asked about the platform device and was told that [1] creates
> > the platform device. I am not sure if that is the recommended way given
> > that you have been asking people to not use platform devices.
> 
> Yes, but this link:
> 
> > [1]: https://patchwork.kernel.org/patch/12281691
> 
> Does look like a "real" platform device in that you have fixed resources
> for the device and no way to discover it on your own.
> 
> But why are you not using DT for this?  That looks like the old platform
> data files.

Apparently I was told that this platform does not use DT :( Looking at
it it should.. Maybe Kelvin can explain why..

-- 
~Vinod
