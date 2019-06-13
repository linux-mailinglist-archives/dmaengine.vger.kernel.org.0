Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2B1043BB7
	for <lists+dmaengine@lfdr.de>; Thu, 13 Jun 2019 17:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfFMPa6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Jun 2019 11:30:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728641AbfFMLGe (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 13 Jun 2019 07:06:34 -0400
Received: from localhost (unknown [122.167.115.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B0A221721;
        Thu, 13 Jun 2019 11:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560423993;
        bh=XDQr+qoInVgE+aU3q1x+Me+5mPriKhlcp+T0v66tN24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kbIaeXp+vdvXnTR8du/ADgav63Wt6IyfifVXvc+ctveMuww6Bv2hPf0Rujo7CQpef
         UpUNMStJma1uV7zaK0E723Fzrhay3rM0To+8T3uMKE43AHidiii+2Kg2CmGUqYtOEc
         TsleUH3XXu9p1eikRsOp7D+fYd7mruK71+g0so60=
Date:   Thu, 13 Jun 2019 16:33:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: Re: [EXT] Re: [V3 2/2] dmaengine: fsl-dpaa2-qdma: Add NXP dpaa2 qDMA
 controller driver for Layerscape SoCs
Message-ID: <20190613110325.GD9160@vkoul-mobl.Dlink>
References: <20190409072212.15860-1-peng.ma@nxp.com>
 <20190409072212.15860-2-peng.ma@nxp.com>
 <20190429053203.GF3845@vkoul-mobl.Dlink>
 <VI1PR04MB4431B87A1F712DC232A46ECBED130@VI1PR04MB4431.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB4431B87A1F712DC232A46ECBED130@VI1PR04MB4431.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10-06-19, 09:51, Peng Ma wrote:

> >> +                     goto err;
> >> +
> >> +             comp_temp->fl_virt_addr =
> >> +                     (void *)((struct dpaa2_fd *)
> >> +                             comp_temp->fd_virt_addr + 1);
> >
> >casts and pointer math, what could go wrong!! This doesnt smell right!
> >
> >> +             comp_temp->fl_bus_addr = comp_temp->fd_bus_addr +
> >> +                                     sizeof(struct dpaa2_fd);
> >
> >why not use fl_virt_addr and get the bus_address?
> What you mean is I should use virt_to_phys to get the bus_address?

Yes instead of maintaining both pointers, just use one and then when
required use one to get other. For bus address I would prefer
dma_map_single rather than virt_to_phys()
-- 
~Vinod
