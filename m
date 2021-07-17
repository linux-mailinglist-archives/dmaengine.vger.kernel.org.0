Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB3A63CC3D5
	for <lists+dmaengine@lfdr.de>; Sat, 17 Jul 2021 16:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbhGQOhv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 17 Jul 2021 10:37:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:53254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230003AbhGQOhv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 17 Jul 2021 10:37:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 610896108B;
        Sat, 17 Jul 2021 14:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626532495;
        bh=zrqph7ltfF3P3SzKZwcuOE0cYjNrKQVF7mgim6YCDIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RO7vUrJzHlACLCoUIXMrGN+nbOTqoWstu8lmz6sUjfxEblopiiF2S5KXK+kvigGz2
         OUueFLtKns5qgwo0N3MfnBnR5hbZOOnJLBnaHjDNqTCh1pCxEBtQstgO7t7by6nilY
         kWFd0TVqEJFZcRQcOH8L1yzntvJV3k+0e/EYoeqEFoYeH6zAocPczh1yPGM9Abc0R7
         B5L9pbYiMyM8r5LhstPFyOPztP8lecS9qSLobzSB09Ncy9RAbPIhnHrwWYPftzjyi8
         +HlVKy+qasxBx+ptwkAtsQnQCEy/PM1UWMrfeTvLnb+2ANcjZspgadUfItF+0OwjJk
         tEHjB9aqbHs1A==
Date:   Sat, 17 Jul 2021 20:04:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Marek Vasut <marex@denx.de>
Cc:     dmaengine@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>,
        Kedareswara rao Appana <appana.durga.rao@xilinx.com>,
        Michal Simek <monstr@monstr.eu>,
        Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] dmaengine: xilinx: Add empty device_config function
Message-ID: <YPLqisxSMe6wzQuk@matsya>
References: <20210716182241.218705-1-marex@denx.de>
 <YPLAs49jy3OGF1aT@matsya>
 <d0009412-abc1-68cb-e7c4-1a11d6ea0fe4@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0009412-abc1-68cb-e7c4-1a11d6ea0fe4@denx.de>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-07-21, 14:01, Marek Vasut wrote:
> On 7/17/21 1:36 PM, Vinod Koul wrote:
> > On 16-07-21, 20:22, Marek Vasut wrote:
> > > Various DMA users call the dmaengine_slave_config() and expect it to
> > > succeed, but that can only succeed if .device_config is implemented.
> > > Add empty device_config function rather than patching all the places
> > > which use dmaengine_slave_config().
> > 
> > .device_config is optional, Yes the dmaengine_slave_config() will check
> > and return error...
> > 
> > I think it would make sense to handle this in caller... (ignore
> > ENOSYS..) rather than add a dummy one
> 
> That's what I was trying to avoid -- patching all the places in kernel which
> might fail. Why handle it in caller ?

And how many places would that be..? The xilinx driver using xilinx
dma right>

> > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > Cc: Akinobu Mita <akinobu.mita@gmail.com>
> > > Cc: Kedareswara rao Appana <appana.durga.rao@xilinx.com>
> > > Cc: Michal Simek <monstr@monstr.eu>
> > > Cc: Vinod Koul <vinod.koul@intel.com>
> > 
> > ummm..? you really need to update this :)
> 
> I had the patch around for a while indeed, it fell through the cracks.

This has to be more than 3 yrs old then!

-- 
~Vinod
