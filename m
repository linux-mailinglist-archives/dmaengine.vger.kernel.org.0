Return-Path: <dmaengine+bounces-1893-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074558A9F1E
	for <lists+dmaengine@lfdr.de>; Thu, 18 Apr 2024 17:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 393731C20F21
	for <lists+dmaengine@lfdr.de>; Thu, 18 Apr 2024 15:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D0516F29A;
	Thu, 18 Apr 2024 15:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9NC9Dkl"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D6C2AEFA;
	Thu, 18 Apr 2024 15:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713455572; cv=none; b=K8AsT+WxkVvgwSEY8SI7ppO6blYm/2IXkQT2MLUO+Q2nZrnsK4+usySTLIv1NSuQIScn5KKd5y5zJoDFj2fqjfrpY3tOHzdz/3inkIqR1ff7qIEpJp0QqEK5m6w/VMqYXvONO/xRU6+rPa0Os+oXjw5SbrkQABP9/lnFOi2cJ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713455572; c=relaxed/simple;
	bh=WkAAHyvVDeP+e2sfdfroKn2jp46qnZOOyePAl/GIvN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JW4SprdEczPrGYzUAvCsgvUajWsa8iF69iwiexislr0HYx5XzlO6oUv6jNRDOEBi6vAHLo2f5rjMZw/SZMZRabk2KwAYGTwnbAjXFYfqECVpoHEb3me4Gg9NFmutPC+qOAYNGEj8zd4WBfwkL2QCqV7Q+s1RjLsl+Odb91TGAfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9NC9Dkl; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2da01cb187cso18945281fa.0;
        Thu, 18 Apr 2024 08:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713455569; x=1714060369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=80IOZRJAg3n+luujCnfZpyZXCYpVPrOJyohSTrYNWpc=;
        b=V9NC9DklaVLSNmAGDOUQSqSzz7hqln20JAwF4NWJgR7+5SE2/bfcXeflRpkt2Jdgho
         /ve4JrSY9OQfZGSS9Nv9C/Lk1bCp3adMMlFw2EmHZ8ZVi/szD5LG7QHf/bt1ZKXI8SFQ
         7S1sQSQeecv2amrrhgqaKsT5iDSI+9gnhZ7ww2BBlG07PLpbHtaY/PojwUPu4MRDro0o
         eZ1nYRgmSLxFFloBdFVHcPVATLHUe1WO6gC6JaJIHvz4t97J6ZLZWDKinVlkCxfPtUvv
         61RcjSO8UnqtUgqE635H9PSHSQziZ3eyUMj6XWzHlipjcfeB37n8nXqD7SlMEDUIIBSh
         1rsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713455569; x=1714060369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80IOZRJAg3n+luujCnfZpyZXCYpVPrOJyohSTrYNWpc=;
        b=wjqMyRQ1rTimONuhToMsVNjBbqEGPP6lx4iOsowZBdnMcgMSzGjhhvqly4x+1/nSMO
         TFPBJUo41cZEsNsNL6l/TcS2Xc3K3/hmWSo54qU4mnCmvzISrTdPf0cEzkDp5GdxYEU1
         Iy3mQAsazR3UFuwb/juVTR/vMtReAqwFL5VTs3AXFSFQHrDIZpIe5E+nmqp7zMW9SVIc
         Hu/e/hSwcU4+KdxdoVhhU1+VBTtygUG4tqNY+kkHXsblVgeTvBUAO85fx0BlT3mRftXE
         0c340V1hbLUc5foP/UL3J2UOrifmJ54qGJufuXfoRtpwaPbgS6P+U6Ud3gsPcUYN9ae+
         yhcA==
X-Forwarded-Encrypted: i=1; AJvYcCXkrY5GKNEtoR1mWvEBBehTx3t/69Y743C347kRD/77WTFKdbVnU3gerj0nwWsUVQE8Htb8v39CN6S+hgM9D8YvV0hFOmyXcdLVfl20NKInF3S3VWysQHu3FYvFT+eM+x3+ZeqaImAKeU9b5LLlAhVAfWlOOHNU9DSipmCt31Qx1FDYnaSm
X-Gm-Message-State: AOJu0Yx7h3uPbvQBy5aEzzYf3oa6o9bk87z+IvV2VpF8vMxDgTPku14K
	JZnCDGEOhiz784y+37E/i4AY3GcyVMxJnlm/9LmlDAmmcRueDL5z
X-Google-Smtp-Source: AGHT+IGQBxhUssFgYIcYFhb0iGzTgiERBaBVOH1kvO22eJtoubzPk2q+XBi65mwuJxQjyxgWfAYq9g==
X-Received: by 2002:a2e:908e:0:b0:2da:7cd1:3f1f with SMTP id l14-20020a2e908e000000b002da7cd13f1fmr2175351ljg.52.1713455568884;
        Thu, 18 Apr 2024 08:52:48 -0700 (PDT)
Received: from mobilestation.baikal.int ([94.125.187.42])
        by smtp.gmail.com with ESMTPSA id h25-20020a2e3a19000000b002da968f03f9sm237734lja.89.2024.04.18.08.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 08:52:48 -0700 (PDT)
Date: Thu, 18 Apr 2024 18:52:46 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/4] dmaengine: dw: Add memory bus width verification
Message-ID: <3aias5ufn2gdta7lr4g2phzg4vfynarrup36zmiuxndd6zgzqc@6z57kf4wk4ut>
References: <20240416162908.24180-1-fancer.lancer@gmail.com>
 <20240416162908.24180-3-fancer.lancer@gmail.com>
 <Zh7Hpuo-TzSmlz69@smile.fi.intel.com>
 <lzipslbrr4fkpqc3plfllltls2sy2mrlentp7clpjoppvgscoi@zlmysqym2kyb>
 <ZiAGpsldQMB-dKkn@smile.fi.intel.com>
 <nroj7c7hvo5ao5gfuububc2zqj7z4rpkoji5flhbrie3xrmgwg@6rhzllxwgj4w>
 <ZiDpxb-diEt91My4@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiDpxb-diEt91My4@smile.fi.intel.com>

On Thu, Apr 18, 2024 at 12:37:09PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 17, 2024 at 09:52:42PM +0300, Serge Semin wrote:
> > On Wed, Apr 17, 2024 at 08:28:06PM +0300, Andy Shevchenko wrote:
> > > On Wed, Apr 17, 2024 at 08:13:59PM +0300, Serge Semin wrote:
> 
> ...
> 
> > > Got it. Maybe a little summary in the code to explain all this magic?
> > 
> > Will it be enough to add something like this:
> > /*
> >  * It's possible to have a data portion locked in the DMA FIFO in case
> >  * of the channel suspension. Subsequent channel disabling will cause
> >  * that data silent loss. In order to prevent that maintain the src
> >  * and dst transfer widths coherency by means of the relation:
> >  * (CTLx.SRC_TR_WIDTH * CTLx.SRC_MSIZE >= CTLx.DST_TR_WIDTH)
> >  */
> 
> Yes, and you may add something like
> "Look for the details in the commit message that brings this change."
> at the end of it.

Agreed. Thanks.

-Serge(y)

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

