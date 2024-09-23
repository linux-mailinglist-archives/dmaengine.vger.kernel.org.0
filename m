Return-Path: <dmaengine+bounces-3208-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6C797EBAD
	for <lists+dmaengine@lfdr.de>; Mon, 23 Sep 2024 14:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E256B1F21C6F
	for <lists+dmaengine@lfdr.de>; Mon, 23 Sep 2024 12:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C91196C86;
	Mon, 23 Sep 2024 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebeaGNDV"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D21944F;
	Mon, 23 Sep 2024 12:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727095571; cv=none; b=kxYHkVwUSSdQFelfd0etFPnqD+SE8EQS+oRb3WXWeBWrI89v9Zvjx+NZKIIl4BVmkoko9dJyREHtUN7X0tvQzKrPCXk9H+7B8CwxElkQLmm74AE0ZbmPxF0YMP3kIgfhZsUCfd9dlUrijNbIq8pLThaOKusMLLDxzGeVeACvOQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727095571; c=relaxed/simple;
	bh=H791qJ884RzCrJmXRNtoB/IAOFb3uexgCzojgbcvjao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoGJK8u1CkY3SLGRLjsWofNoqV6pYxGsR3w0WyObGWCuNhI4T3vqTlpk5GP1rg7ju7xtb85/GzuRCmksr/vs+kTjJMz3P5cyKCprNb+9EQ1L6SGVbOMb3E52LjZcEUrS6oSpmOvUCAYtGhvM2iFQnDeOpRr/tnIUE31eAFBwn30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebeaGNDV; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-537a2a2c74fso630917e87.0;
        Mon, 23 Sep 2024 05:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727095568; x=1727700368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qe32yvUb9M7AG5s5hippFPkJFtAeLbHm336wqeEbh3M=;
        b=ebeaGNDVbV5J/0cYhqfhQ3UP8uWhRRgbFV0/N9NwVCkIL0v6CkJuHMsQU23oF1oxrQ
         yhrt6W+Ce2+mIbaGZSCLoSzJN9pDyz0B7CkCMDoyJUJr27i+A8rsuz/OuQdPH9vHObDH
         jgxIGdFEh/SyfBhZQ4apJnniYqsz8OuRsLrsL47zvm5sPgKaNtPJ6cQl2w7qr96NF5Nm
         8neKdvrxWdaYFP8NYG8df3oARs5NPgdSNw80gXpO1vW2UFwA/RjhGzA6MYo3jshbaKNo
         zpY2tuR/9bOomcKUSgAeSKzE5JhCiApOjDFwJVvGZREnSy69qmMfuCZlTcOijKtTJ8Tv
         yEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727095568; x=1727700368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qe32yvUb9M7AG5s5hippFPkJFtAeLbHm336wqeEbh3M=;
        b=jcBXx3F7L5z3WmISdqh+dbsXevQv0s9IF6U7RdVzr1clLC+PWLr7LFgsAc6344X5n9
         XTXz2hGe8qpUHI7GI8cC8O3lu45LBKLK0a3SlyOWQc7I4osvpQ2igWBNSZQmW0subh6y
         SB0FZxpNDbUwD6e6yDKLvOBlaMZCiIqVG29b5w1bt3tzgMRyLjvSdnYU6RblbPpkxX6x
         I9qAsM7aAy6aPB6YHbitDCqeDCMxGEcw9iPfrdpL44+opjJJosXtq7irTCaks4IjIyVy
         m3wz71hq9hitsaxDQnR1ZcN/iKraFxwLA1zuSW3RxP6Snns2jns5xr+JOqnaVUU9itXg
         RqfA==
X-Forwarded-Encrypted: i=1; AJvYcCVJrsHpfLrP2rplPkg7LrZcZ5hbre55iQqSS+rYvIAKwP23zw/MgdNW8Ow1C8vrgABCrdx6a+DadTVJCuw=@vger.kernel.org, AJvYcCWSMGmeCWO4vQLBwMyD0fnRYkxxS6VAdfKq0cTgLosCdvsjpJNW6OTRarcT+eudE3kqhuwAPWO0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+/wb3CAjIpkrSd3PhcryeSpJP7XjWfVkcn0ns9FY37yZOdarE
	bHeD/yI1YTnd6Uzo9GWghZ1oXRpX9FAT33LcgFcp5p+blM0AViJg6kp1oA==
X-Google-Smtp-Source: AGHT+IHk6NjA1nCO9EGYuyJyNTjpXX7J+9fc5rK0kGf2gQON0pK7wvVqX5mVF2/DtDvbkTM3NkdroQ==
X-Received: by 2002:a05:6512:1105:b0:52e:fa08:f0f5 with SMTP id 2adb3069b0e04-536abb33545mr3660434e87.13.1727095567270;
        Mon, 23 Sep 2024 05:46:07 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5368704c35esm3290102e87.77.2024.09.23.05.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 05:46:06 -0700 (PDT)
Date: Mon, 23 Sep 2024 15:46:04 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>, stable@vger.kernel.org, 
	Ferry Toth <fntoth@gmail.com>
Subject: Re: [PATCH v3 1/1] dmaengine: dw: Select only supported masters for
 ACPI devices
Message-ID: <onfkegjjn7psbhc44fhjmp5ttbuthiscpccywaxxwabalpmudo@xhfdlxi762o6>
References: <20240920155820.3340081-1-andriy.shevchenko@linux.intel.com>
 <ajcqxw6in7364m6bp2wncym65mlqf57fxr6pc4aor3xbokx2cu@2wve6fdtu3vz>
 <ZvElEesYTX-89u_g@smile.fi.intel.com>
 <7cy2ho5lysh4tqk3vqz6rv67dadsi33bszx234vpu7bvslnddp@ed6zxezx7nwf>
 <ZvFecC6u0rFczFR9@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvFecC6u0rFczFR9@smile.fi.intel.com>

On Mon, Sep 23, 2024 at 03:26:24PM +0300, Andy Shevchenko wrote:
> On Mon, Sep 23, 2024 at 02:57:27PM +0300, Serge Semin wrote:
> > On Mon, Sep 23, 2024 at 11:21:37AM +0300, Andy Shevchenko wrote:
> > > On Mon, Sep 23, 2024 at 01:01:08AM +0300, Serge Semin wrote:
> > > > On Fri, Sep 20, 2024 at 06:56:17PM +0300, Andy Shevchenko wrote:
> 
> ...
> 
> 
> Yes, I still prefer mine.
> 
> > But, again IMO, it seems to be
> > better to add the default_{m,p}_master/d{p,m}_master/etc fields to the
> > dw_dma_platform_data structure since the platform-specific controller
> > settings have been consolidated in there. The dw_dma_chip_pdata
> > structure looks as more like generic driver data storage.
> 
> I don't think that is correct place for it. The platform data is specific
> to the DMA controller as a whole and having there the master configuration
> will mean to have the arrays of them. This OTOH will break the OF setup
> where this comes from the slave descriptions and may not be provided with
> DMA controller, making it imbalanced. Yes, I may agree with you that chip data
> is not a good place either, but at least it isolates the case to PCI + ACPI /
> pure ACPI devices (and in particular we won't need to alter Intel Quark case).
> 

> Ideally, we should parse the additional properties from ACPI for this kind
> of DMA controllers to get this from the _slave_ resources. Currently this is
> not done, but anyone may propose a such

I guess it would also mean to fix all the firmware as well, wouldn't it?
Do the Intel/AMD/etc ACPI firmware currently provide such a data? In
anyway it would be inapplicable for the legacy hardware anyway.

> (would you like to volunteer?).

not really.) Maybe in some long-distance future when I get to meet a
device on the ACPI-based platform with the DW DMAC + some peripheral
experiencing the denoted problem, I'll think about implementing what
we've discussed here.

> 
> ...
> 
> TL;DR: If you are okay with your authorship in v3, I prefer it over other
> versions with the explanations given in this email thread.

Ok. Let's leave it as of your preference.

-Serge(y)

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

