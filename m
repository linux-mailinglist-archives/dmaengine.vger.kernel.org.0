Return-Path: <dmaengine+bounces-3206-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CD397EB23
	for <lists+dmaengine@lfdr.de>; Mon, 23 Sep 2024 13:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5CA9B20818
	for <lists+dmaengine@lfdr.de>; Mon, 23 Sep 2024 11:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6631E74418;
	Mon, 23 Sep 2024 11:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCdLQtDg"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725651E487;
	Mon, 23 Sep 2024 11:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727092655; cv=none; b=JZFuqW9aiSvjEHaZ6Ln22WNllCpD3X39uhfecnYUWQqGAvOcnkooH5T8pSRR8+CSbCBxl0a4CaMjFEyAsgrId0vuXPnHMRZmYv33Yce9TMLa92nnMe4TtEMPGyLTK0jxMJIeG4r149DHJqXpG4OC3dGsnpb+BC3XN/Y/XMNyJRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727092655; c=relaxed/simple;
	bh=HfrV/Cf3Cc3+hkSyVcj2fxQ1sxJ3ffYcjdeE769AnNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNbhy9ASU8WDi2vJMrzxVd9G6DOuDh1Y9GZ3dSA7PpqYiL+JwtGcZes/k77vaA4qdGyJ/HaIgXOjXL6im+Rv4PVt+MMXfaoaEGwE0umHFeNt0P8Jijnx7aARc32+3qv1hAxJINRZd1DVEZnQZ8+1anes7TcCHS+gZtDfY65pOBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCdLQtDg; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5356ab89665so4964606e87.1;
        Mon, 23 Sep 2024 04:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727092651; x=1727697451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mQvCTLA0SRUAuWLPb3QVgTp+ezS69WlS2KAt798er0g=;
        b=WCdLQtDge9JZTlsxQQTk02byK35Yfh8OssULPI7TkMti8RRvCyMuyvvXXwnhwqKB5w
         YvqUWi7BzguVzyKWl0BQe+G+dMy0k1ivGVye5Ll2O3pOamqfYMpdzDmvtDmiRl9trg7o
         yfqU02EW9hNaVCAxqCD9cYdvS3oDsuwTj6CFBxe5+ComLpVpCDx5tAIMzsk9axAy87TR
         z5OBdCdgNhx01/cOby77RNa1Iv1ycFOeYR9UgYkVV1sLJ6YhF9DSBDgD0XLOMBXLZgAX
         hw6tuWKtMRXjQvSCvigcCz6Ece82Qnp57PxtluwRtqqAvu2RcfZgnWKCRo328C0wWcnk
         HGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727092651; x=1727697451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQvCTLA0SRUAuWLPb3QVgTp+ezS69WlS2KAt798er0g=;
        b=dVQfMmegx62MgHO4inMhKBIoFMS4jz7eOIK1lSknwiRrXKxJofGNqJorCu6swnhWpe
         P1JD5XvlgwaK/33Gu3GSMClD4BpE3R+R2GnXRMAfbNRaVJbH1qKdSnFZuPvZzzLjxfHY
         itUa7PVrrlOfX8BrlMphA+pfgPIu2Nh+F5Dn+I85fyo7FZR9gfNONe8e9PJoMn2AQ77C
         7uUB2kJEks72Ub8tjxAjBKY198Idsh97qfmue2Zc05vvNostfuPSnO33nOMhVfR7cB8V
         giVANND2upRd0rdEmBmfwufnFtboNNAiCcWIUZlwQ1yFKZH4apTodqVz3v4BAcs6HmM0
         CbxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6G3CvfSeJKn1uzl4oLe+GdQZHyHsx+SEnKpOij41lu11Xcio8EfDN2rGRwZ9FdiinIzCZ33Ua420UFbE=@vger.kernel.org, AJvYcCWEniK3Oo4+Mw0tgo7MXkRdXDOoM+HrJV6yaHV7sxzFtbB26VZEe02wASJDyDODOcj9+DA1cGQ3@vger.kernel.org
X-Gm-Message-State: AOJu0YxWR4loCd8Y6F6qzb2w5dbHVYoevbmB1sy0MGWE1+cvZeqYuMp7
	paLLTnQSTe03bHJwUJY9nwgo806reigdNPVm3u2rj5mdkz+O0OssKfYGEg==
X-Google-Smtp-Source: AGHT+IEC2D/5jWFkLmCXbXPW2yga9BUimt36+8yXIA3H15LyvCMU/DH68DfrZR7+GEpYmta/+6XINw==
X-Received: by 2002:a05:6512:10d3:b0:533:4c73:a244 with SMTP id 2adb3069b0e04-536ad3e9d01mr4709275e87.61.1727092651058;
        Mon, 23 Sep 2024 04:57:31 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870471a7sm3267221e87.41.2024.09.23.04.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 04:57:30 -0700 (PDT)
Date: Mon, 23 Sep 2024 14:57:27 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>, stable@vger.kernel.org, 
	Ferry Toth <fntoth@gmail.com>
Subject: Re: [PATCH v3 1/1] dmaengine: dw: Select only supported masters for
 ACPI devices
Message-ID: <7cy2ho5lysh4tqk3vqz6rv67dadsi33bszx234vpu7bvslnddp@ed6zxezx7nwf>
References: <20240920155820.3340081-1-andriy.shevchenko@linux.intel.com>
 <ajcqxw6in7364m6bp2wncym65mlqf57fxr6pc4aor3xbokx2cu@2wve6fdtu3vz>
 <ZvElEesYTX-89u_g@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvElEesYTX-89u_g@smile.fi.intel.com>

On Mon, Sep 23, 2024 at 11:21:37AM +0300, Andy Shevchenko wrote:
> On Mon, Sep 23, 2024 at 01:01:08AM +0300, Serge Semin wrote:
> > On Fri, Sep 20, 2024 at 06:56:17PM +0300, Andy Shevchenko wrote:
> 
> ...
> 
> > > Fix the problem by specifying the default master ID for both memory
> > > and peripheral devices in the driver data. Thus the issue noticed for
> > > the iDMA 32-bit controllers will be eliminated and the ACPI-probed
> > > DW DMA controllers will be configured with the correct master ID by
> > > default.
> 
> > > ---
> > > v3: rewrote to use driver_data
> > > v2: https://lore.kernel.org/r/20240919185151.7331-1-fancer.lancer@gmail.com
> > 
> > IMO v2 looked better for me.
> 
> I disagree, obviously, since I sent a v3.

> (I can drop your authorship and tags in v4)

No need in that. See my further comments.

> 
> > I am sure you know, but Master IDs is a
> > platform-specific thing specific for each slave/peripheral device
> > connected to the DMA controller. Depending on the chip design one
> > peripheral device can be accessed over the one master IDs, another
> > device/memory may have another master connected (can be up to four
> > master IDs in general). That's why the master IDs have been declared
> > in the dw_dma_slave structure.
> 
> Correct.
> 
> > So adding them to struct
> > dw_dma_chip_pdata doesn't seem like a good idea seeing it contains the
> > generic DW DMA controller info.
> 
> So far there is no evidence that the channels are integrated differently on
> the same DMA controller over all hardware that uses this IP.

I've got one device (which currently isn't supported by the vanilla
kernel) which DW DMA-controller have a weird feature of being able to
communicate with one of the peripherals via both available masters.)
So the master IDs order can differ from what is currently set by
default (for ACPI).

Anyway regarding the amount of the master I/F-es, yes, I failed to
find any platform with more than two masters synthesized in. But based
on the DW DMAC IP-core databook there can be up to four of them (see
the DMAH_NUM_MASTER_INT parameter).

> 
> > On the contrary my implementation
> > seems a bit more coherent since it just changes the default slave IDs
> > defined in the dw_dma_acpi_filter() method and initialized in the
> > dw_dma_slave instance without adding slave-specific fields to the
> > generic controller data.
> 

> The default enumeration for PCI + ACPI or pure ACPI devices is not
> changed with my patch, but actually makes it better (increases granularity).
> The defaults are platform specific and that's what driver_data is for.

Since it's a default setting for the particular controller then it
seems it would be better to signify that semantic in the fields name.
Moreover seeing it's a per-platform setup I would recomment to move
these fields to the dw_dma_platform_data structure instead.
(Please see my last comment regarding this.)

> 
> While you like your solution, the problem with it that it doesn't cover
> different orders, so it's half-baked solution, I think. Mine doesn't
> change the status quo about integration (see above) and has better approach
> regarding different ordering.

Well, your solution doesn't cover the different order of the master
IDs either, because the IDs order is still fixed but on the per-controller
basis. Yes, in that regard your approach is bit more comprehensive,
but it still remains half-baked since, as you said yourself further,
it doesn't cover the cases of the non-default master IDs combination.

My solution doesn't change the status quo either, but merely fixes the
case which is currently incorrectly handled in the
dw_dma_acpi_filter() method. The rest remains the same.
(See further before responding to this comment.)

> Both implementations have a flaw regarding per-channel master configuration.

Right, none of our approaches provide a complete solution of the
problem with a per-peripheral device master IDs setup. Based on this and
what was said in the previous comments chunk, I would normally prefer to
choose a simpler, more localised, less invasive fix, which is provided
in my version of the change. That's why I started the discussion
in the first place.
(Please see my last comment before answering to this one.)

> 
> > What seems like a much better alternative to the both approaches, is
> > to use the dw_dma_slave instance defined in the mrfld_spi_setup()
> > method for the Intel Merrifield SPI PXA2xx DMA-interface in
> > drivers/spi/spi-pxa2xx-pci.c. But AFAICT that data is left unused
> > since the DMA-engine handle and connection parameters are determined
> > by the channel name. Right? Is it possible to make use of the
> > filter-function specified to the dma_request_slave_channel_compat()
> > method?
> 

> Unfortunately no, in ACPI case the only data we use is the name (index) of
> the channel in the respective resources. Everything else is done automatically.

Right, but AFAICS ACPI doesn't provide the complete settings in this
case. I thought about some combined solution: retrieve the DMAC
channel via the standard name/index-based approach and then pass the
dw_dma_slave settings via the custom filter method specified by the
client driver, thus making use of what is implemented in the
Merrifield SPI PXA2xx driver. Alas implementing this approach would
require to alter the generic DMA-engine core somehow.(

In anyway if you prefer your version of the fix, fine by me. I've
provided my reasoning above. If it wasn't enough to persuade you I
won't be insisting on my change anymore especially seeing its your and
Varesh duty to maintain the driver. But, again IMO, it seems to be
better to add the default_{m,p}_master/d{p,m}_master/etc fields to the
dw_dma_platform_data structure since the platform-specific controller
settings have been consolidated in there. The dw_dma_chip_pdata
structure looks as more like generic driver data storage.

-Serge(y)

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

