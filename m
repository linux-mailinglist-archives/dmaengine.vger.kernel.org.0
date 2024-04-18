Return-Path: <dmaengine+bounces-1892-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 249F88A9EEC
	for <lists+dmaengine@lfdr.de>; Thu, 18 Apr 2024 17:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5F5D1F22810
	for <lists+dmaengine@lfdr.de>; Thu, 18 Apr 2024 15:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF7716F82C;
	Thu, 18 Apr 2024 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5NBinHQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF0F4D9E8;
	Thu, 18 Apr 2024 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713455234; cv=none; b=IOSK7KTR91t8r/YgzcMXDQL5cror50LIZL9Lzicz13zEy8rcWd2ql4gW0dzUZcftPh2C4ldOoMWNtJI50GTnt+2KrxcJNPIhrbSQXzkwR5lTZLTf3VFTST5chhjJtrk146nmJQBIiOdZWv4B8KF0we3KbWEFTeZYhjtv1JSAiFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713455234; c=relaxed/simple;
	bh=M+QSrsfB7NABO5qemPEQ3RI5tFnJexvhpiIJ/e7kwxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6JFb1ZtRIWbg3hQnsk/5agEY0048yUovS3648XlgW9uvfdqHhb+Lb5kgX9ecnkIYqs7gcN5w4aNanTVPbXcVmaP0+2AnMAxqfon8Gul8dt4Wx15/SG/LBZpDM2KQu0z/MuQuDIKsUw58PPl15yyHpdDDukYe1rn9v+X/GJLcS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5NBinHQ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-516d0c004b1so1298927e87.2;
        Thu, 18 Apr 2024 08:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713455231; x=1714060031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pgivi16PEU1cW2TB4a2zL/2NxGpEoLOZG1KSg6mlhCw=;
        b=W5NBinHQQ8in4PfmEo5tN1J9N1StCnje+HRndcv9T0B+DF8lNzCDpNPOLCKopH2JuT
         hiZTjz/bX9FLw/fUyHTi7hHj5r9X6ajy55T9X+cWFKsHKOYnAA6uJt2gjA5RUbgIg9J/
         PQFmW6zXBQS1ViLPnNS3PKDSehtOmhVu+QsSriAu8cCRyGS6D2DRV8HUQIWgds+ILTpJ
         m+BVas4CXVkubE3ol1+8s6AHuMtPiKpUWnf9prVoWcaDaaiixJtHjvR/BtmoUPq+aXd/
         b4fhv+UO46G2nB78jiOT1NIi0+8FlfefgaBWG9foO/WZOaIqy2+dFi0SvJRCbvWT8FFB
         Hitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713455231; x=1714060031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgivi16PEU1cW2TB4a2zL/2NxGpEoLOZG1KSg6mlhCw=;
        b=iRF4m7QAOJFYYmpFSKZzJ7y0uvWPggL/yIc0VhLh8bznn3nfQX/uFGvlxahRPKE4kJ
         yEkIvUlOoO9vrdkM3vJads6VFG/rcRNEN1+h2xM+phsk+eiQNhee/y1Z3hwZm/ty+T4j
         FXVI/LJGv+QvoS05OwNjunD6P/+Xf3BG118H4MoCuHiJPAyIWnCj8LeWBW5qL3pe23c8
         PJDORiWaSJBUXdtaQWc8MZo5PAUuz8FevBdzqqtqr+0c7oYnKNgyCF/7ghQeANqCPU9a
         4aPmk2OBQfSollS8giw/5tZ5qdNhu80t3Uq9rdVWXEalIHtRf0ZO15gFKulz9LCCJOfB
         6bbg==
X-Forwarded-Encrypted: i=1; AJvYcCU0BTKYYxYthCvQl4eujexbxwlXBOgNzw/qKKMF+zcXLYNxuUBh27lhWSTZA8G7R99HBYIoCdVD/Li0APejI7YyvtD09/M5oPUl04GSOIyhefYxSCNBtp5mHj0yjUW8aYIfymQ6TfIP7A8DzZf6TQotPZN47hmYjQFMwRfY51kAA9iRcQG9
X-Gm-Message-State: AOJu0YwKoGmGXMO5JHO0DfVrPHlV5kEGttAvlAKAeJLDtEmSGeQTeCqZ
	tuA+ZSxOxWNnCqhCF7dKNv15MvFCQikZ7KZzbDWwhlMwXrQwWTh8
X-Google-Smtp-Source: AGHT+IGWcN3FvGWp6gZos5U+UHsVlZJR/jG/G6MZjGQIeNt/Fu7eNSkwawtWUFXFo+Y7+tpmVTxOiw==
X-Received: by 2002:a19:910c:0:b0:515:ab7f:b13e with SMTP id t12-20020a19910c000000b00515ab7fb13emr2560271lfd.33.1713455230894;
        Thu, 18 Apr 2024 08:47:10 -0700 (PDT)
Received: from mobilestation.baikal.int (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id e24-20020ac25478000000b00518eb215bbfsm284403lfn.107.2024.04.18.08.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 08:47:10 -0700 (PDT)
Date: Thu, 18 Apr 2024 18:47:08 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dmaengine: dw: Add peripheral bus width verification
Message-ID: <uvun5magjf4wy4qcwzhzrwfqoquktsgdk7rr7dx6avl5zun37h@i3fx4irnkcx4>
References: <20240416162908.24180-1-fancer.lancer@gmail.com>
 <20240416162908.24180-2-fancer.lancer@gmail.com>
 <Zh680h4h6hURIb82@smile.fi.intel.com>
 <ut5notgwnjdj7ex3jeo7jnbdc2vhopebdg3miepto2wfrxti4b@b2xksvotrgph>
 <ZiDrPSb7YxeooHzC@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiDrPSb7YxeooHzC@smile.fi.intel.com>

On Thu, Apr 18, 2024 at 12:43:25PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 17, 2024 at 10:54:42PM +0300, Serge Semin wrote:
> > On Tue, Apr 16, 2024 at 09:00:50PM +0300, Andy Shevchenko wrote:
> > > On Tue, Apr 16, 2024 at 07:28:55PM +0300, Serge Semin wrote:
> 
> ...
> 
> > > > +	if (reg_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
> > > > +		reg_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
> > > > +	else if (!is_power_of_2(reg_width) || reg_width > max_width)
> > > > +		return -EINVAL;
> > > > +	else /* bus width is valid */
> > > > +		return 0;
> > > > +
> > > > +	/* Update undefined addr width value */
> > > > +	if (dwc->dma_sconfig.direction == DMA_MEM_TO_DEV)
> > > > +		dwc->dma_sconfig.dst_addr_width = reg_width;
> > > > +	else /* DMA_DEV_TO_MEM */
> > > > +		dwc->dma_sconfig.src_addr_width = reg_width;
> > > 
> > 
> > > So, can't you simply call clamp() for both fields in dwc_config()?
> > 
> > Alas I can't. Because the addr-width is the non-memory peripheral
> > setting. We can't change it since the client drivers calculate it on
> > the application-specific basis (CSR widths, transfer length, etc). So
> > we must make sure that the specified value is supported.
> 
> What I meant is to convert this "update" part to the clamping, so
> we will have the check as the above like
> 
> _verify_()
> {
> 	if (reg_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
> 		return -E...;
> 	if (!is_power_of_2(reg_width) || reg_width > max_width)
> 		return -EINVAL;
> 
> 	/* bus width is valid */
> 	return 0;
> }
> 
> dwc_config()
> {
> 	err = ...
> 	if (err = ...)
> 		clamp?
> 	else if (err)
> 		return err;
> }
> 
> But it's up to you to choose the better variant. I just share the idea.

Ok. Thanks for the suggestion. But I'll stick to my solution then. The
specified *_addr_width values can't/shouldn't be clamped anyway and
having a single verification function will comply to what will be
implemented for the rest of the dwc_onfig() parts in this patchset.

> 
> > > > +	return 0;
> > > > +}
> 
> ...
> 
> > > > +	int err;
> > 
> > > Hmm... we have two functions one of which is using different name for this.
> > 
> > Right, the driver uses both variants (see of.c, platform.c, pci.c too).
> > 
> > > Can we have a patch to convert to err the other one?
> > 
> > To be honest I'd prefer to use the "ret" name instead. It better
> > describes the variable usage context (Although the statements like "if
> > (err) ..." look a bit more readable). So I'd rather convert the "err"
> > vars to "ret". What do you think?
> 

> I'm fine with any choice, just my point is to get it consistent across
> the driver.

Ok. "ret" it is then.

-Serge(y)

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

