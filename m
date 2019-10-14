Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E75BDD60F2
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2019 13:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731705AbfJNLJb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Oct 2019 07:09:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:34026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731686AbfJNLJb (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 14 Oct 2019 07:09:31 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 912D420650;
        Mon, 14 Oct 2019 11:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571051370;
        bh=IGUjFKwdFvBuHDUBTTMUkHOqWN+qrspmIFd3EP+r5D0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u6lV4BvTYW8QqsNve4UmSk9Z5IRL6ls+Ne+fUJeDqE/2kdCy6p2B3zszdb8a3CGfJ
         zIUWNfhvJGX46ZQKGt0ADXS2mmtAPaMYHIMnAOQtJjH2drVoNnJIyH6+M8bbZA9fir
         CCH+HHdvDRmqPLE15mDMW7UZttO+u5rVp++pF3JE=
Date:   Mon, 14 Oct 2019 19:09:12 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        frowand.list@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        xen-devel@lists.xenproject.org, linux-tegra@vger.kernel.org,
        linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>, mbrugger@suse.com,
        robin.murphy@arm.com, f.fainelli@gmail.com,
        james.quinlan@broadcom.com, wahrenst@gmx.net,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 07/11] dts: arm64: layerscape: add dma-ranges property to
 qoric-mc node
Message-ID: <20191014110911.GL12262@dragon>
References: <20190924181244.7159-1-nsaenzjulienne@suse.de>
 <20190924181244.7159-8-nsaenzjulienne@suse.de>
 <20191014082847.GH12262@dragon>
 <f6262e61f858c6f50164416f4ea816e203c0704f.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6262e61f858c6f50164416f4ea816e203c0704f.camel@suse.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Oct 14, 2019 at 12:00:25PM +0200, Nicolas Saenz Julienne wrote:
> On Mon, 2019-10-14 at 16:28 +0800, Shawn Guo wrote:
> > On Tue, Sep 24, 2019 at 08:12:38PM +0200, Nicolas Saenz Julienne wrote:
> > > qoriq-mc's dpmacs DMA configuration is inherited from their parent node,
> > > which acts a bus in this regard. So far it maked all devices as
> > > dma-coherent but no dma-ranges recommendation is made.
> > > 
> > > The truth is that the underlying interconnect has DMA constraints, so
> > > add an empty dma-ranges in qoriq-mc's node in order for DT's DMA
> > > configuration code to get the DMA constraints from it.
> > > 
> > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > 
> > Updated subject prefix as 'arm64: dts: ...', and applied the patch.
> 
> Hi Shawn,
> these two patches are no longer needed. This series has been superseded by this
> patch[1] 951d48855d ('of: Make of_dma_get_range() work on bus nodes', available
> in linux-next) which fixed the issue directly in OF code.
> 
> Sorry for the noise.

Okay, thanks for letting me know.  Dropped them.

Shawn
