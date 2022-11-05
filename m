Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E9F61D84B
	for <lists+dmaengine@lfdr.de>; Sat,  5 Nov 2022 08:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiKEHSC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 5 Nov 2022 03:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiKEHSB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 5 Nov 2022 03:18:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DD33134C;
        Sat,  5 Nov 2022 00:17:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7032EB81611;
        Sat,  5 Nov 2022 07:17:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836C3C433C1;
        Sat,  5 Nov 2022 07:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667632676;
        bh=AO2A+xmnRi0pG5stiCNRsgnaUdvVQ0QmnxWdno8n/6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QPsVKSIjpm45QFI1Fym8iYVrJ973T2/9umU6Wg3ORq/gad8G8YMSJ6QicxfY1D9zi
         NW/jiDSm0X13zUJoyQ3SkNjsRkMaijM09BQWtseJBIyq9n+p5pQxQVvQQMlT68/s01
         gOtE3E/vZ/5gvVHPln/mabQM2Z/WNTXlfatM+DR3m/fmdTMiYjf2RmDVMPSpnzRATU
         MuYsn43MmmC5s8AYF3PX4rE7M6z2+0N09lprl97BLVNyYdy07OeUKfj4aq5yrtvJ8y
         SxaDoYcRwAx2f0gMMcr3B1R4jPv5Gvw1yIJfjp92J7E6SMueTrTcInIs/ukWI4pLDO
         op58PeuRmYe4A==
Date:   Sat, 5 Nov 2022 12:47:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, tumic@gpxsee.org, max.zhen@amd.com,
        sonal.santan@amd.com, larry.liu@amd.com, brian.xu@amd.com
Subject: Re: [PATCH V9 XDMA 1/2] dmaengine: xilinx: xdma: Add xilinx xdma
 driver
Message-ID: <Y2YOHx3RBJxdx9xz@matsya>
References: <1666720638-33496-1-git-send-email-lizhi.hou@amd.com>
 <1666720638-33496-2-git-send-email-lizhi.hou@amd.com>
 <Y2Uidg/iuQdxwSaG@matsya>
 <73ab286c-f8c7-8c4b-0508-5df8dde8e305@amd.com>
 <Y2VSfjWZSWY0f2n4@matsya>
 <e1244ca1-18bd-d6c9-6101-9b20940fda72@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e1244ca1-18bd-d6c9-6101-9b20940fda72@amd.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 04-11-22, 11:17, Lizhi Hou wrote:
> On 11/4/22 10:57, Vinod Koul wrote:
> > On 04-11-22, 09:57, Lizhi Hou wrote:
> > > On 11/4/22 07:32, Vinod Koul wrote:
> > > > On 25-10-22, 10:57, Lizhi Hou wrote:

> > > > > +static inline int xdma_write_reg(struct xdma_device *xdev, u32 base, u32 reg,
> > > > > +				 u32 val)
> > > > > +{
> > > > > +	return regmap_write(xdev->regmap, base + reg, val);
> > > > > +}
> > > > Do you really need one more level indirection?
> > > Do you mean using readl / writel instead of regmap_* here?
> > Nope, I refer to using regmap_write() intead of xdma_write_reg()
> 
> Ok. As you mentioned below,
> 
>    why not move err into xdma_write_reg(), rather than adding in each
>    helper!
> 
> If I use regmap_write() directly, I will not be able to move err into
> xdma_write_reg(). Having a inline function might be useful to add debug
> code.  May I keep xdma_write_reg()?

Okay, either way if xdma_write_reg() is doing only regmap_write() then
no, if it has extra logic like logging on error etc then it makes sense

> > > > > +failed:
> > > > > +	xdma_free_desc(&sw_desc->vdesc);
> > > > who will free sw_desc here?
> > > sw_desc is freed by xdma_free_desc(). xdma_free_desc() is virt-dma callback
> > > it converts struct virt_dma_desc pointer to driver sw_desc pointer and free
> > > the whole thing.
> > IN case of error, you are returning NULL, so allocated descriptor leaks
> 
> I meant the descriptor is freed inside xdma_free_desc() which is called
> before 'return NULL'.
> 
> xdma_free_desc(struct virt_dma_desc *vdesc)
> 
> {
> 
>         sw_desc = to_xdma_desc(vdesc);
> 
>         .....
> 
>         kfree(sw_desc);
> 
> }

ok

> > > > > +#ifndef _PLATDATA_AMD_XDMA_H
> > > > > +#define _PLATDATA_AMD_XDMA_H
> > > > > +
> > > > > +#include <linux/dmaengine.h>
> > > > > +
> > > > > +/**
> > > > > + * struct xdma_chan_info - DMA channel information
> > > > > + *	This information is used to match channel when request dma channel
> > > > > + * @dir: Channel transfer direction
> > > > > + */
> > > > > +struct xdma_chan_info {
> > > > > +	enum dma_transfer_direction dir;
> > > > > +};
> > > > > +
> > > > > +#define XDMA_FILTER_PARAM(chan_info)	((void *)(chan_info))
> > > > > +
> > > > > +struct dma_slave_map;
> > > > > +
> > > > > +/**
> > > > > + * struct xdma_platdata - platform specific data for XDMA engine
> > > > > + * @max_dma_channels: Maximum dma channels in each direction
> > > > > + */
> > > > > +struct xdma_platdata {
> > > > > +	u32 max_dma_channels;
> > > > > +	u32 device_map_cnt;
> > > > > +	struct dma_slave_map *device_map;
> > > > > +};
> > > > why do you need this plat data
> > > max_dma_channels is used to specify the maximum dma channels will be used.
> > What is the device mode, who creates this dma device, devicetree or
> > something else?
> 
> This dma engine is on PCI device (exposed on PCI BAR). Thus, the pci device
> driver creates this dma device.

So it is a platform_device type? Why not make it something like auxdev?

-- 
~Vinod
