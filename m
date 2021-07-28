Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3ED3D8C75
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jul 2021 13:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbhG1LIF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Jul 2021 07:08:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231994AbhG1LIF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Jul 2021 07:08:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF9A260F9C;
        Wed, 28 Jul 2021 11:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627470483;
        bh=trE/tVDwca/JiD/LF2rEncqmVvjl7sCjg9XNKytSN+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sZcH+JeIi/3tL5+A8Mkxm39almtmSyzdLZ7dd8HlI//ZxDjmhIAjPeHlub78DVyHv
         sSJ+utpd1jtxYFi0HrvdZ1hvyYPMZFV7CyQowIuEwtdIFfLZL4OUG+MMGWsCUwIsLk
         iVhvdAf04qodbmx3bEomCfkA/qDTnUlZ7if2GqmYWPWS1C+VMERKNY/RNnxHWFTMfw
         PHuCB5+ymEG4GqGG2be9AWi6OJx/2W9meaycfJR7uMZisqeXjcEzduBKnMJx4L+dST
         AjL2zmnN9kZ1+eRwyVyfjZgP/BQ66kvE2mr40M+flmkjFX1czagdkoZy9QWs+lXYWd
         NeWAekxEtMzwA==
Date:   Wed, 28 Jul 2021 16:37:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Marek Vasut <marex@denx.de>
Cc:     dmaengine@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>,
        Kedareswara rao Appana <appana.durga.rao@xilinx.com>,
        Michal Simek <monstr@monstr.eu>,
        Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] dmaengine: xilinx: Add empty device_config function
Message-ID: <YQE6j/ycDSOf76s+@matsya>
References: <20210716182241.218705-1-marex@denx.de>
 <YPLAs49jy3OGF1aT@matsya>
 <d0009412-abc1-68cb-e7c4-1a11d6ea0fe4@denx.de>
 <YPLqisxSMe6wzQuk@matsya>
 <0aa86cfb-09e7-df99-1a28-dd9086d64058@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0aa86cfb-09e7-df99-1a28-dd9086d64058@denx.de>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-07-21, 16:48, Marek Vasut wrote:
> On 7/17/21 4:34 PM, Vinod Koul wrote:
> > On 17-07-21, 14:01, Marek Vasut wrote:
> > > On 7/17/21 1:36 PM, Vinod Koul wrote:
> > > > On 16-07-21, 20:22, Marek Vasut wrote:
> > > > > Various DMA users call the dmaengine_slave_config() and expect it to
> > > > > succeed, but that can only succeed if .device_config is implemented.
> > > > > Add empty device_config function rather than patching all the places
> > > > > which use dmaengine_slave_config().
> > > > 
> > > > .device_config is optional, Yes the dmaengine_slave_config() will check
> > > > and return error...
> > > > 
> > > > I think it would make sense to handle this in caller... (ignore
> > > > ENOSYS..) rather than add a dummy one
> > > 
> > > That's what I was trying to avoid -- patching all the places in kernel which
> > > might fail. Why handle it in caller ?
> > 
> > And how many places would that be..? The xilinx driver using xilinx
> > dma right>
> 
> git grep indicates around 170 matches on dmaengine_slave_config. In my case,
> it is generic PCM DMA in sound/soc/soc-generic-dmaengine-pcm.c .

Okay lets have this. Looks like kbuild-bot is not happy, can you fix
that and send update

-- 
~Vinod
