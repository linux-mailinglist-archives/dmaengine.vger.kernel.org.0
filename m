Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33560150AE
	for <lists+dmaengine@lfdr.de>; Mon,  6 May 2019 17:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfEFPux (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 May 2019 11:50:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbfEFPux (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 6 May 2019 11:50:53 -0400
Received: from localhost (unknown [106.200.210.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E124205C9;
        Mon,  6 May 2019 15:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557157852;
        bh=VmODjgCEfNbg84zHmsep9/NhTAqtKDbXTzQElxkQq4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zSVwbaCp/CHyVwI8HkEpTblO/cpm7zMRnhxx4PtW/QSOv6Ly+0wvwiEbqYeXbJSgH
         wYZfEvWM3SVKoGiRqFougr1CYO6CzgxzSh3IRN6kOml77/87/KYht4Bm0NyMCEmvMU
         zp1qAzKngFiEDsOxTz0v/UQ7vvImXOS7D8ChhX2Q=
Date:   Mon, 6 May 2019 21:20:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     dan.j.williams@intel.com, tiwai@suse.com, jonathanh@nvidia.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        sharadg@nvidia.com, rlokhande@nvidia.com, dramesh@nvidia.com,
        mkumard@nvidia.com
Subject: Re: [PATCH] [RFC] dmaengine: add fifo_size member
Message-ID: <20190506155046.GH3845@vkoul-mobl.Dlink>
References: <1556623828-21577-1-git-send-email-spujar@nvidia.com>
 <20190502060446.GI3845@vkoul-mobl.Dlink>
 <e852d576-9cc2-ed42-1a1a-d696112c88bf@nvidia.com>
 <20190502122506.GP3845@vkoul-mobl.Dlink>
 <3368d1e1-0d7f-f602-5b96-a978fcf4d91b@nvidia.com>
 <20190504102304.GZ3845@vkoul-mobl.Dlink>
 <ce0e9c0b-b909-54ae-9086-a1f0f6be903c@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce0e9c0b-b909-54ae-9086-a1f0f6be903c@nvidia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-05-19, 18:34, Sameer Pujar wrote:
> 
> On 5/4/2019 3:53 PM, Vinod Koul wrote:
> > On 02-05-19, 18:59, Sameer Pujar wrote:
> > > On 5/2/2019 5:55 PM, Vinod Koul wrote:
> > > > On 02-05-19, 16:23, Sameer Pujar wrote:
> > > > > On 5/2/2019 11:34 AM, Vinod Koul wrote:
> > > > > > On 30-04-19, 17:00, Sameer Pujar wrote:
> > > > > > > During the DMA transfers from memory to I/O, it was observed that transfers
> > > > > > > were inconsistent and resulted in glitches for audio playback. It happened
> > > > > > > because fifo size on DMA did not match with slave channel configuration.
> > > > > > > 
> > > > > > > currently 'dma_slave_config' structure does not have a field for fifo size.
> > > > > > > Hence the platform pcm driver cannot pass the fifo size as a slave_config.
> > > > > > > Note that 'snd_dmaengine_dai_dma_data' structure has fifo_size field which
> > > > > > > cannot be used to pass the size info. This patch introduces fifo_size field
> > > > > > > and the same can be populated on slave side. Users can set required size
> > > > > > > for slave peripheral (multiple channels can be independently running with
> > > > > > > different fifo sizes) and the corresponding sizes are programmed through
> > > > > > > dma_slave_config on DMA side.
> > > > > > FIFO size is a hardware property not sure why you would want an
> > > > > > interface to program that?
> > > > > > 
> > > > > > On mismatch, I guess you need to take care of src/dst_maxburst..
> > > > > Yes, FIFO size is a HW property. But it is SW configurable(atleast in my
> > > > > case) on
> > > > > slave side and can be set to different sizes. The src/dst_maxburst is
> > > > Are you sure, have you talked to HW folks on that? IIUC you are
> > > > programming the data to be used in FIFO not the FIFO length!
> > > Yes, I mentioned about FIFO length.
> > > 
> > > 1. MAX FIFO size is fixed in HW. But there is a way to limit the usage per
> > > channel
> > >     in multiples of 64 bytes.
> > > 2. Having a separate member would give independent control over MAX BURST
> > > SIZE and
> > >     FIFO SIZE.
> > > > > programmed
> > > > > for specific values, I think this depends on few factors related to
> > > > > bandwidth
> > > > > needs of client, DMA needs of the system etc.,
> > > > Precisely
> > > > 
> > > > > In such cases how does DMA know the actual FIFO depth of slave peripheral?
> > > > Why should DMA know? Its job is to push/pull data as configured by
> > > > peripheral driver. The peripheral driver knows and configures DMA
> > > > accordingly.
> > > I am not sure if there is any HW logic that mandates DMA to know the size
> > > of configured FIFO depth on slave side. I will speak to HW folks and
> > > would update here.
> > I still do not comprehend why dma would care about slave side
> > configuration. In the absence of patch which uses this I am not sure
> > what you are trying to do...
> 
> I am using DMA HW in cyclic mode for data transfers to Audio sub-system.
> In such cases flow control on DMA transfers is essential, since I/O is

right and people use burst size for precisely that!

> consuming/producing the data at slower rate. The DMA tranfer is enabled/
> disabled during start/stop of audio playback/capture sessions through ALSA
> callbacks and DMA runs in cyclic mode. Hence DMA is the one which is doing
> flow control and it is necessary for it to know the peripheral FIFO depth
> to avoid overruns/underruns.

not really, knowing that doesnt help anyway you have described! DMA
pushes/pulls data and that is controlled by burst configured by slave
(so it know what to expect and porgrams things accordingly)

you are really going other way around about the whole picture. FWIW that
is how *other* folks do audio with dmaengine!

> Also please note that, peripheral device has multiple channels and share
> a fixed MAX FIFO buffer. But SW can program different FIFO sizes for
> individual channels.

yeah peripheral driver, yes. DMA driver nope!

-- 
~Vinod
