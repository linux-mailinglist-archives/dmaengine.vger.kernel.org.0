Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 262D3143C95
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jan 2020 13:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgAUMOI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Jan 2020 07:14:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:42134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727817AbgAUMOI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 Jan 2020 07:14:08 -0500
Received: from localhost (unknown [171.76.119.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B222A2073A;
        Tue, 21 Jan 2020 12:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579608847;
        bh=Qq3v/FQs81Z4u3h/BT7zP7lIhmAukfuHUqvLomvAe2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M3SfLdxAoH9lXTgviaGdxEEl8nstuFNd2zRY3BHNhdqp7YUCg7QXEXKixsKmRxHX3
         9F0Fa3pogu6a6IKs20YUE+vsokLsny+vHu5lpHCodkcVtQ6ZtO+ZwVolZpTq89HxKb
         C+IU7xZmZtRhEW3HAO68Aly8DcgIt2c0aG6kJffQ=
Date:   Tue, 21 Jan 2020 17:44:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stefan Mavrodiev <stefan@olimex.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:DRM DRIVERS FOR ALLWINNER A10" 
        <dri-devel@lists.freedesktop.org>, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/2] dmaengine: sun4i: Add support for cyclic requests
 with dedicated DMA
Message-ID: <20200121121402.GP2841@vkoul-mobl>
References: <20200110141140.28527-1-stefan@olimex.com>
 <20200110141140.28527-2-stefan@olimex.com>
 <20200115123137.GJ2818@vkoul-mobl>
 <20200115170731.vt6twfhvuwjrbbup@gilmour.lan>
 <20200121083514.GE2841@vkoul-mobl>
 <54b1a38f-3903-49b7-d20b-f97824a528ba@olimex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54b1a38f-3903-49b7-d20b-f97824a528ba@olimex.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-01-20, 13:37, Stefan Mavrodiev wrote:
> 
> On 1/21/20 10:35 AM, Vinod Koul wrote:
> > On 15-01-20, 18:07, Maxime Ripard wrote:
> > > On Wed, Jan 15, 2020 at 06:01:37PM +0530, Vinod Koul wrote:
> > > > On 10-01-20, 16:11, Stefan Mavrodiev wrote:
> > > > > Currently the cyclic transfers can be used only with normal DMAs. They
> > > > > can be used by pcm_dmaengine module, which is required for implementing
> > > > > sound with sun4i-hdmi encoder. This is so because the controller can
> > > > > accept audio only from a dedicated DMA.
> > > > > 
> > > > > This patch enables them, following the existing style for the
> > > > > scatter/gather type transfers.
> > > > I presume you want this to go with drm tree (if not let me know) so:
> > > > 
> > > > Acked-by: Vinod Koul <vkoul@kernel.org>
> > > There's no need for it to go through DRM, it can go through your tree :)
> > okay in that case I have applied now :), thanks
> > 
> Hi,
> 
> Should I keep this patch in the future series or drop it?

Drop it :) It would be in linux-next tomorrow!

-- 
~Vinod
