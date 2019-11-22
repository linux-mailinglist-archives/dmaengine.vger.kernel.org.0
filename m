Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42F7A105F61
	for <lists+dmaengine@lfdr.de>; Fri, 22 Nov 2019 06:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbfKVFGu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Nov 2019 00:06:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:36322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbfKVFGu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 22 Nov 2019 00:06:50 -0500
Received: from localhost (unknown [171.61.94.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D6B82068E;
        Fri, 22 Nov 2019 05:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574399209;
        bh=o9P+CVnroeoeDkGZ+LQ16OPYhmH/QzjmVRjx/5JnAL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YN+4aXsR/BUW7qoSgA3XoVlN2adRpnGpvvqamoVtbMt5egAYIfqbBn1kVrG8VbhgG
         ei56tZpdkKvB3SpLzzGmSyVSN2OzoVkeisNubyhnQwa0sF1qjSfQdhmQ+dzrvK/dNa
         3PmARuGyKD7z/K1Abqmy3SixFKUfDIp9O+O0ZjF8=
Date:   Fri, 22 Nov 2019 10:36:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Alexander Gordeev <a.gordeev.box@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH RFC v5 2/2] dmaengine: avalon-test: Intel Avalon-MM DMA
 Interface for PCIe test
Message-ID: <20191122050643.GM82508@vkoul-mobl>
References: <cover.1573052725.git.a.gordeev.box@gmail.com>
 <948f34471b74a8a20747311cc1d7733d00d77645.1573052725.git.a.gordeev.box@gmail.com>
 <20191114050331.GL952516@vkoul-mobl>
 <20191114155331.GA19187@AlexGordeev-DPL-IR1335>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114155331.GA19187@AlexGordeev-DPL-IR1335>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-11-19, 16:53, Alexander Gordeev wrote:
> On Thu, Nov 14, 2019 at 10:33:31AM +0530, Vinod Koul wrote:
> > On 06-11-19, 20:22, Alexander Gordeev wrote:
> > > This is a sample implementation of a driver using "avalon-dma" to
> > > perform data transfers between target device memory and system memory:
> > > 
> > >     +----------+    +----------+            +----------+
> > >     |   RAM    |<-->|  Avalon  |<---PCIe--->|   Host   |
> > >     +----------+    +----------+            +----------+
> > >
> > > The target device is expected to use only Avalon-MM DMA Interface for
> > > PCIe to initiate DMA transactions - without custom hardware specifics
> > > to make such transfers possible.
> > > 
> > > Unlike "dmatest" driver, the contents of DMAed data is not manipulated by
> > > "avalon-test" in any way. It is basically pass-through and the the data
> > > are fully dependent on the target device implementation. Thus, it is up
> > > to the users to analyze received or provide meaningful transmitted data.
> > 
> > Is this the only reason why you have not used dmatest. If so, why not
> > add the feature to dmatest to optionally not check the DMAed data
> > contents?
> 
> The main reason is that "dmatest" does not support DMA_SLAVE type of
> transactions.

That is correct, but it can be added!

> I considered adding DMA_SLAVE to "dmatest". But it would break the 
> current neat design and does not appear solving the issue of data
> verification. Simply besause in general DMA_SLAVE case there is no

Am not sure why it break the current design. We have to skip the
verification part. It would not only help you but also other to have
this support in dmatest

> data integrity criteria easily available to the driver. I.e if the
> data is a sensor image then verifying it in the driver would be
> pointless.

The biggest issue with slave and dmatest is how to setup slave

> So in case of "avalon-test" I offloaded the task of data verification
> to the user. The driver itself just streams user data to/from device.
> 
> In fact, this approach is not "avalon-dma" specific and could be used
> with any "dmaengine" compatible driver. Moreover, it would be quite
> useful for bringing up devices in embedded systems. I.e one could
> master a raw display frame in user space and DMA it via the driver -
> without graphic stack involved.

Right and having it in dmatest makes more sense for everyone :)

> The only missing functionality I could think of is using DMABUFs, but that
> is very easy to add.
> 
> Actually, "avalon-test" is rather a presentation of how I tested
> "avalon-dma". I understand "dmatest" is more easy to trust and I could
> probably make it working with DMA_SLAVE type. But that would entail
> hardware design requirements:
> 
>   - DMA slave should both respond to read and write transactions;
>   - data read should always be the same as data written;
> 
> I have such version of hardware design, but I doubt majorify of devices
> out there can honor the above requirements. 
> 
> Summarizing - I would suggest not to change "dmatest" and bring in a
> generalized version of "avalon-test" if you find it useful for a wider
> audience.

I would still think adding to dmatest makes more sense!

-- 
~Vinod
