Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C70413C0BE
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jan 2020 13:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgAOMY4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jan 2020 07:24:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:48456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbgAOMY4 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Jan 2020 07:24:56 -0500
Received: from localhost (unknown [223.226.122.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89A8C207E0;
        Wed, 15 Jan 2020 12:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579091095;
        bh=ahmB3AGmjfviPDPt7/xzlcU9opl/jgG4htJShn4RCHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0vD+1T6TFbmLwi41Mk8DctL7OIhqe0KQdMWLSpWDtlMSdJi3XHfQUZjrupUJjDwC0
         6kFS6WzZAgdrTU0m0auMbhuW+lGpXNuSNICfTLKfGn1en6bTVkuGERtea0KVYi+lMf
         PHqhrB3PXofPJ54HXd2qi2jYCzxEE3pSmRAkwMEU=
Date:   Wed, 15 Jan 2020 17:54:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        santosh.shilimkar@oracle.com
Cc:     Sekhar Nori <nsekhar@ti.com>, robh+dt@kernel.org, nm@ti.com,
        ssantosh@kernel.org, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        grygorii.strashko@ti.com, lokeshvutla@ti.com, t-kristo@ti.com,
        tony@atomide.com, j-keerthy@ti.com, vigneshr@ti.com,
        frowand.list@gmail.com
Subject: Re: [PATCH v8 02/18] soc: ti: k3: add navss ringacc driver
Message-ID: <20200115122440.GI2818@vkoul-mobl>
References: <20191223110458.30766-1-peter.ujfalusi@ti.com>
 <20191223110458.30766-3-peter.ujfalusi@ti.com>
 <6d70686b-a94e-18d1-7b33-ff9df7176089@ti.com>
 <900c2f21-22bf-47f9-5c3c-0a3d95a5d645@oracle.com>
 <ea6a87ae-b978-a786-27eb-db99483a82d9@ti.com>
 <f0230e88-bd9b-cd6d-433d-06d507cafcbd@ti.com>
 <9177657a-71c7-7bd0-a981-3ef1f736d4dc@oracle.com>
 <2c933a6c-37c6-3ef6-7c37-ae36e8c49bf7@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c933a6c-37c6-3ef6-7c37-ae36e8c49bf7@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-01-20, 11:44, Peter Ujfalusi wrote:
> 
> 
> On 14/01/2020 20.06, santosh.shilimkar@oracle.com wrote:
> >>>>> Can you please giver your Acked-by for the ringacc patches if they are
> >>>>> still OK from your point of view as you had offered to take them
> >>>>> before
> >>>>> I got comments from Lokesh.
> >>>>>
> >>>> Sure. But you really need to split the series so that dma engine and
> >>>> soc driver patches can be applied independently.
> >>>
> >>> The ringacc is a build and runtime dependency for the DMA. I have hoped
> >>> that all of them can go via DMAengine (hence asking for your ACK on the
> >>> drivers/soc/ti/ patches) for 5.6.
> >>>
> >>>> Can you please do that?
> >>>
> >>> This late in the merge window that would really mean that I will miss
> >>> another release for the KS3 DMA...
> >>> I can live with that if you can pick the ringacc for 5.6 and if Vinod
> >>> takes the DMAengine core changes as well.
> >>>
> >>> That would leave only the DMA drivers for 5.7 and we can also queue up
> >>> changes for 5.7 which depends on the DMAengine API (ASoC changes, UART,
> >>> sa2ul, etc).
> >>>
> >>> If they go independently and nothing makes it to 5.6 then 5.8 is the
> >>> realistic target for the DMA support for the KS3 family of devices...
> >>
> >> Thats too many kernel versions to get this important piece in.
> >>
> >> Santosh, if you do not have anything else queued up that clashes with
> >> this, can the whole series be picked up by Vinod with your ack on the
> >> drivers/soc/ti/ pieces?
> >>
> > I would prefer driver patches to go via driver tree.
> 
> Not sure what you mean by 'driver patches'...
> The series to enable DMA support on TI's K3 platform consists:
> Patch 1-2: Ring Accelerator _driver_ (drivers/soc/ti/)
> Patch 3-6: DMAengine core patches to add new features needed for k3-udma
> Patch 7-11: DMA _driver_ patches for K3 (drivers/dma/ti/)
> 
> Patch 10 depends on the ringacc and the DMAengine core patches
> Patch 11 depends on patch 10
> 
> I kept it as a single series in hope that they will go via one subsystem
> tree to avoid build dependency issues and will have a good amount of
> time in linux-next for testing.
> 
> >> Vinod could also perhaps setup an immutable branch based on v5.5-rc1
> >> with just the drivers/soc/ti parts applied so you can merge that branch
> >> in case you end up having to send up anything that conflicts.
> >>
> > As suggested on other email to Peter, these DMA engine related patches
> > should be queued up since they don't have any dependency. Based on
> > the status of that patchset, will take care of pulling in the driver
> > patches either for this merge window or early part of next merge window.
> 
> OK, I'll send the two patch for ringacc as a separate series.
> 
> Vinod: Would it be possible for you to pick up the DMAengine core
> patches (patch 3-6)?
> The UDMA driver patches have hard dependency on DMAengine core and
> ringacc, not sure how they are going to go in...

Since they have build dependency, the usual method for this is:

1. Santosh acks the dependent patches and I will apply the rest (nice
and simple)

2. Santosh picks up ring driver patches, provides a signed immutable tag
which I will pull in and apply the rest, i.e., dmaengine updates and new
dmaengine driver

That way we are all okay and changes get merged now.. there is a 3rd
option

3. Santosh picks ring driver patches, and Vinod picks rest after next
rc1 (provided they make to linus in merge window)

I would love to see either 1 or 2 whichever way folks are comfortable
to deal with :)

-- 
~Vinod
