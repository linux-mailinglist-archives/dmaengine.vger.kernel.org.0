Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF8D81368AA
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jan 2020 08:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgAJH7z (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Jan 2020 02:59:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:52616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbgAJH7z (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 10 Jan 2020 02:59:55 -0500
Received: from localhost (unknown [223.226.110.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEE5F20678;
        Fri, 10 Jan 2020 07:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578643194;
        bh=fSEo71p9zQb48cW5EKCC0XtPWrsgJj6gwMDy/N3b5pI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lZ4vHBfN9/+2X+uBsbU6bmE4/Cq8L/fD9ushEVra/69E+nucg59MSWzjmMyPx+bAY
         D8brYk/80/YPfXx4Wpu4DF5wvzTtoeU97clMXiRxUMeeeaNw6fC1Ns+imoyE/85mcZ
         bM6otQcYRma0wjwDPZ6U0xYCbOI5N654ZOMf/KwQ=
Date:   Fri, 10 Jan 2020 13:29:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Lin, Jing" <jing.lin@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>
Subject: Re: [PATCH RFC v3 13/14] dmaengine: idxd: add char driver to expose
 submission portal to userland
Message-ID: <20200110075941.GF2818@vkoul-mobl>
References: <157662541786.51652.7666763291600764054.stgit@djiang5-desk3.ch.intel.com>
 <157662565769.51652.16236917705023398061.stgit@djiang5-desk3.ch.intel.com>
 <20191227055852.GE3006@vkoul-mobl>
 <b2082fce-d56d-9fdf-f844-426bd517138f@intel.com>
 <94878eba-42c2-7b33-d315-a90b225606aa@intel.com>
 <c7ba628c-4ffe-fec9-6832-8139bd7865db@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7ba628c-4ffe-fec9-6832-8139bd7865db@intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-01-20, 13:18, Dave Jiang wrote:
> Dropped everyone except dmaengine and related parties.
> 
> On 1/7/20 11:17 AM, Dave Jiang wrote:
> > 
> > 
> > On 1/7/20 10:45 AM, Dave Jiang wrote:
> > > 
> > > 
> > > On 12/26/19 10:58 PM, Vinod Koul wrote:
> > > > On 17-12-19, 16:34, Dave Jiang wrote:
> > > > > Create a char device region that will allow acquisition of
> > > > > user portals in
> > > > > order to allow applications to submit DMA operations. A char
> > > > > device will be
> > > > > created per work queue that gets exposed. The workqueue type "user"
> > > > > is used to mark a work queue for user char device. For example if the
> > > > > workqueue 0 of DSA device 0 is marked for char device, then
> > > > > a device node
> > > > > of /dev/dsa/wq0.0 will be created.
> > > > 
> > > > do we really want to create a device specific interface..? why not move
> > > > it to dmaengine core and create a dmaengine device for userland to
> > > > submit dma operations?
> > > 
> > > I'm keeping an eye on the uacce framework [1] progress. If that goes
> > > upstream then there's probably not any reason for dmaengine to export
> > > that. Otherwise then yes that would be reasonable. Are you thinking that
> > > the uacce guys should consider doing that for dmaengine instead?
> > > 
> > > The char device export in idxd driver is a bridge solution until we
> > > bottom out on whichever interface to provide the generic framework.
> > 
> > Oops forgot to provide URL
> > 
> > [1]: https://lkml.org/lkml/2019/12/15/332
> 
> So after thinking a bit more and talking to Dan, I think there's some
> confusion that needs explanation on how the idxd user portal works vs
> traditional DMA engines. For idxd, the char device allows the user app to
> mmap() a 4k region called a portal. With that portal address the user can
> use either MOVDIR64B or ENQCMD CPU instruction to directly submit a DMA
> descriptor to the device without touching the kernel. I think this part is
> device specific and probably can only be provided by the driver for now.
> 
> I think you on the other hand are looking for a kernel assisted DMA
> operation submission from userspace through the dmaengine framework correct?
> We would expose a char device for a channel that allows a user app to submit
> DMA operations via ioctls? That is something the idxd driver needs as well
> when the operation hits a point where the user portal is saturated and we
> need kernel assistance to move forward. But I would like to mark this as
> follow on work for me to add to dmaengine as a common framework.

Yeah agreed that is something we would need eventually...

-- 
~Vinod
