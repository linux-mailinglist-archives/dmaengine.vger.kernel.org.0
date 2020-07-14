Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C4E21F756
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2020 18:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgGNQ36 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jul 2020 12:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgGNQ35 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Jul 2020 12:29:57 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6135FC061755;
        Tue, 14 Jul 2020 09:29:57 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id r19so23584426ljn.12;
        Tue, 14 Jul 2020 09:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E/fd4+ve+l+H502mXoaxeDxS6PWJ8G8plZiirt47oHI=;
        b=uq83Pv7tgDH64WUNzFYrrR/E48jCN43Bab8+SBAdg7Zxs21SYFXCB6Hgt/BI+7G/yg
         /Aw+42AAusY9mpF+olBfZW2YIYSKMQsI9W1Rqmi6DHDzPLitDgopQcp7TDJLyrZEsEJW
         RSN2awUtFQXolcQXDu33ArWY0ZJqjYL3NXRA8D4mhsEa+i5LyCUxMq7d7nvPMOIpcL23
         A7dgn9vaHkAUilwwpriMcL+f9scnNfW0Drqq9pneDe2qI3iJqOSeR4YbOsitpqnXs7Yg
         LpxYGXTW/w2y1Vx3d38wZ5kErFALrrVBVrEUG43dCYZiIpfd8wat/ANV/ZkY8WHYyIY6
         CcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E/fd4+ve+l+H502mXoaxeDxS6PWJ8G8plZiirt47oHI=;
        b=rrcf6JxjfEKUZdgCspJKJ78/rCFmLc/kWpJg3GjjXRqx5Dp1Fw3wLVJHiXVTMwiaPL
         70M9xMdNndTab7sqj7KSA1p35SSo6ZUNrixseEF6nTjNsmuD8yqgafQL3dwp156MBgAd
         i2tBlUtNjNjSk9nCHZSYA1ShUUzHG3ly7UKoSUxoX9uk8tLHEpQRJfCVU59HlFot7r/W
         OU8oO21MVqUgT2QF18C99P344NqzUePeNU95yNOZYp10EUm268OTU1bI1ss07tHzmnAH
         RVw9W5Rh6dQU/xPFVebPsiJar6xpVuAL6i+cdejmR2uJb/ih+l41Eg189O6c5RtV9zrk
         bnRA==
X-Gm-Message-State: AOAM532pHKJU/K0g2M5ovDTF+GTeO/lxzh98MKWh0rySPspmTBU6ZHHE
        kaXZxsh0sjh3282inkbTV+zLatO3
X-Google-Smtp-Source: ABdhPJy9XKMKAljS+dkH2V3EUqJ2kMbCeozYPbmE/34AgjNG/i4cmBWv9BCRezuYGsgLO2RdiWykwQ==
X-Received: by 2002:a2e:3c0e:: with SMTP id j14mr2764753lja.25.1594744195878;
        Tue, 14 Jul 2020 09:29:55 -0700 (PDT)
Received: from mobilestation ([95.79.139.207])
        by smtp.gmail.com with ESMTPSA id u7sm7283067lfi.45.2020.07.14.09.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 09:29:55 -0700 (PDT)
Date:   Tue, 14 Jul 2020 19:29:53 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 05/11] dmaengine: Introduce DMA-device device_caps
 callback
Message-ID: <20200714162953.2333hke6pfvovjuk@mobilestation>
References: <20200709224550.15539-1-Sergey.Semin@baikalelectronics.ru>
 <20200709224550.15539-6-Sergey.Semin@baikalelectronics.ru>
 <20200710084503.GE3703480@smile.fi.intel.com>
 <20200710093834.su3nsjesnhntpd6d@mobilestation>
 <07d4a977-1de6-b611-3d4f-7c7d6cd7fe5f@intel.com>
 <20200714160830.GL34333@vkoul-mobl>
 <f746fafd-851e-f402-3755-03ef94a65988@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f746fafd-851e-f402-3755-03ef94a65988@intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Jul 14, 2020 at 09:18:16AM -0700, Dave Jiang wrote:
> 
> 
> On 7/14/2020 9:08 AM, Vinod Koul wrote:
> > On 13-07-20, 13:55, Dave Jiang wrote:
> > > 
> > > 
> > > On 7/10/2020 2:38 AM, Serge Semin wrote:
> > > > On Fri, Jul 10, 2020 at 11:45:03AM +0300, Andy Shevchenko wrote:
> > > > > On Fri, Jul 10, 2020 at 01:45:44AM +0300, Serge Semin wrote:
> > > > > > There are DMA devices (like ours version of Synopsys DW DMAC) which have
> > > > > > DMA capabilities non-uniformly redistributed between the device channels.
> > > > > > In order to provide a way of exposing the channel-specific parameters to
> > > > > > the DMA engine consumers, we introduce a new DMA-device callback. In case
> > > > > > if provided it gets called from the dma_get_slave_caps() method and is
> > > > > > able to override the generic DMA-device capabilities.
> > > > > 
> > > > 
> > > > > In light of recent developments consider not to add 'slave' and a such words to the kernel.
> > > > 
> > > > As long as the 'slave' word is used in the name of the dma_slave_caps
> > > > structure and in the rest of the DMA-engine subsystem, it will be ambiguous
> > > > to use some else terminology. If renaming needs to be done, then it should be
> > > > done synchronously for the whole subsystem.
> > > 
> > > What about just calling it dma_device_caps? Consider this is a useful
> > > function not only slave DMA will utilize this. I can see this being useful
> > > for some of my future code with idxd driver.
> > 
> > Some of the caps may make sense to generic dmaengine but few of them do
> > not :) While at it, am planning to make it dmaengine_periph_caps to
> > denote that these are dmaengine peripheral capabilities.
> > 
> 

> If the function only passes in periph_caps, how do we allow the non periph
> DMA utilize this function?

Hello Dave. That seems reasonable. "dma_device_caps" or even "dma_chan_caps"
might be more suitable seeing after this patchset merged in the "dma_slave_caps"
may really provide the DMA channel-specific configs. Moreover that structure is
accessible only by means of the dma_chan descriptor:

int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps);

which makes those caps being the channel-specific even without this patchset.

So as I see it "dma_chan_caps" might be the better choice.

-Sergey
