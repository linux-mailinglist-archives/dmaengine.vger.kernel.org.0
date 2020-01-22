Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9F111450B3
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jan 2020 10:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733311AbgAVJkJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jan 2020 04:40:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:58680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387405AbgAVJkI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 22 Jan 2020 04:40:08 -0500
Received: from localhost (unknown [122.178.236.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B55C24684;
        Wed, 22 Jan 2020 09:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579686007;
        bh=k2bF29vbO4gdaC0R6XuDL1eqr9ESgfDtamKRRnvdJSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HVrFrHiw4x2TulvgoJcp0AK51hGJ3DGtBt28CAp3cmmMAYFgRKuS5J3YwayzbRy05
         nzPk9BYdzU60kzXXVG84/dfEF6+bPNg7PsZQK/oUqsbmyWmI1+Pf9izkflwW7eFpBh
         oYw9Le46eQc2a6BLizw4/WCsfD88dRi6bcRlQxD8=
Date:   Wed, 22 Jan 2020 15:10:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] dmaengine: Create symlinks between DMA channels and
 slaves
Message-ID: <20200122094002.GS2841@vkoul-mobl>
References: <20200117153056.31363-1-geert+renesas@glider.be>
 <d2b669e7-a5d4-20ec-5b54-103b71df7407@ti.com>
 <CAMuHMdVzQCWvH-LJ9ME5dRyafudZBHQLaJQzkSCPnughv_q2aA@mail.gmail.com>
 <1cdc4f71-f365-8c9e-4634-408c59e6a3f9@ti.com>
 <CAMuHMdU=-Eo29=DQmq96OegdYAvW7Vw9PpgNWSTfjDWVF5jd-A@mail.gmail.com>
 <f7bbb132-1278-7030-7f40-b89733bcbd83@ti.com>
 <CAMuHMdXDiwTomiKp8Kaw0NvMNpg78-M88F0mNTWBOz5MLE4LtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXDiwTomiKp8Kaw0NvMNpg78-M88F0mNTWBOz5MLE4LtQ@mail.gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hey Geert,

On 21-01-20, 21:22, Geert Uytterhoeven wrote:
> On Mon, Jan 20, 2020 at 1:06 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> > On 20/01/2020 12.51, Geert Uytterhoeven wrote:
> > > On Mon, Jan 20, 2020 at 11:16 AM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> > >> On 20/01/2020 11.01, Geert Uytterhoeven wrote:
> > >>> On Fri, Jan 17, 2020 at 9:08 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> > >>>> On 1/17/20 5:30 PM, Geert Uytterhoeven wrote:
> > >>>>> Currently it is not easy to find out which DMA channels are in use, and
> > >>>>> which slave devices are using which channels.
> > >>>>>
> > >>>>> Fix this by creating two symlinks between the DMA channel and the actual
> > >>>>> slave device when a channel is requested:
> > >>>>>   1. A "slave" symlink from DMA channel to slave device,
> > >>>>
> > >>>> Have you considered similar link name as on the slave device:
> > >>>> slave:<name>
> > >>>>
> > >>>> That way it would be easier to grasp which channel is used for what
> > >>>> purpose by only looking under /sys/class/dma/ and no need to check the
> > >>>> slave device.
> > >>>
> > >>> Would this really provide more information?
> > >>> The device name is already provided in the target of the symlink:
> > >>>
> > >>> root@koelsch:~# readlink
> > >>> /sys/devices/platform/soc/e6720000.dma-controller/dma/dma1chan2/slave
> > >>> ../../../ee140000.sd
> > >>
> > >> e6720000.dma-controller/dma/dma1chan2/slave -> ../../../ee140000.sd
> > >> e6720000.dma-controller/dma/dma1chan3/slave -> ../../../ee140000.sd
> > >>
> > >> It is hard to tell which one is the tx and RX channel without looking
> > >> under the ee140000.sd:
> > >>
> > >> ee140000.sd/dma:rx -> ../e6720000.dma-controller/dma/dma1chan3
> > >> ee140000.sd/dma:tx -> ../e6720000.dma-controller/dma/dma1chan2
> > >
> > > Oh, you meant the name of the channel, not the name of the device.
> > > My mistake.
> > >
> > > As this name is a property of the slave device, not of the DMA channel,
> > > I don't think it belongs under dma*chan*.
> >
> > Right, but it gives me only half the information I need to be a link useful.
> > I know that device X is using two channels but I need to check the
> > device X's directory to know which channel is used for what purpose.

I gave the patch a spin on my board, I like some things and I dont like
few things :)

Having name of slaves is a good thing, but i had to resort to search of
channels, the controller I have has 18 channels and only 4 were in use,
so took a bit of time to find things.

Start with /sys/class/dma/ to find the controller node
then from controller node find the channels with slave
and then get to the clients!

So i would say it is better than what we have today, but we could do
better :)

> >
> > >> Another option would be to not have symlinks, but a debugfs file where
> > >> this information can be extracted and would only compiled if debugfs is
> > >> enabled.
> > >
> > > Like /proc/interrupts?
> >
> > More like /sys/kernel/debug/gpio
> >
> > > That brings the complexity of traversing all channels etc.
> >
> > Sure, but only when the file is read.
> > You can add
> > #ifdef CONFIG_DEBUG_FS
> > #endif
> >
> > around the slave_device and name in struct dma_chan {}
> >
> > and when user reads the file you print out something like this:
> > cat /sys/kernel/debug/dmaengine
> >
> > e6700000.dma-controller:
> > dma0chan0               e6e20000.spi:tx
> > dma0chan1               e6e20000.spi:rx
> > dma0chan2               ee100000.sd:tx
> > dma0chan3               ee100000.sd:rx
> > ...
> > dma0chan14              non slave
> > ...
> >
> > e6720000.dma-controller:
> > dma1chan0               e6b10000.spi:tx
> > dma1chan1               e6b10000.spi:rx
> > ...

I like the idea of adding this in debugfs and giving more info, I would
actually love to add bytes_transferred and few more info (descriptors
submitted etc) to it...

> > This way we will have all the information in one place, easy to look up
> > and you don't need to manage symlinks dynamically, just check all
> > channels if they have slave_device/name when they are in_use (in_use w/o
> > slave_device is 'non slave')
> >
> > Some drivers are requesting and releasing the DMA channel per transfer
> > or when they are opened/closed or other variations.
> >
> > > What do other people think?
> 
> Vinod: do you have some guidance for your minions? ;-)


That said, I am not against merging this patch while we add more
(debugfs)... So do my minions agree or they have better ideas :-)

-- 
~Vinod
