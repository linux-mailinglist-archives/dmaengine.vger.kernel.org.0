Return-Path: <dmaengine+bounces-1901-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A49A8AA28A
	for <lists+dmaengine@lfdr.de>; Thu, 18 Apr 2024 21:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB8591C20D91
	for <lists+dmaengine@lfdr.de>; Thu, 18 Apr 2024 19:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D7A17AD97;
	Thu, 18 Apr 2024 19:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f52zaE4M"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FDF177980;
	Thu, 18 Apr 2024 19:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713467409; cv=none; b=gcpNszYRZFmIwP4nPLQh9vfs3eBrL64m7StT6B9xZnQ/MJeBlDeuAKp6yQIv55DQ4qWtp7Pdm87+d4JWbC/Ed+cIKcasukn8308mUjJHal6PtnkRM/Y91aF78buJTcpxTQv7wF2YiTJRmERn+kTbBvuoK+7/zdTAE1H1oABtF8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713467409; c=relaxed/simple;
	bh=LNYSLafohNI3OcAPQLdlG1Op1X2KxPSSInkwWTm9e9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i03DPz2NzCwqyIZ/lu+9TYK66QNBe8WcwJjJkRPcCqPux09rEiAlRL8g4W6Cr4FNRGodz0yNMpFIOGmFPYlFoeLvp83vliJHb8Z6yjDx98HvjhwWB4TPm0/1/vJjn34OhBt3BiGoxie9yWXuTNREKYkwBAhWHqyg8frp6x/ffcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f52zaE4M; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-518f8a69f82so1511055e87.2;
        Thu, 18 Apr 2024 12:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713467406; x=1714072206; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LFCOV5/FbvZyadb0eigbmic/UPzgGtARohnH/S7yn5M=;
        b=f52zaE4MY0RS5TFgCrG79fG0RkfpF+xLXDYU0+/bYKXVbENGgdFdq6XagTqNarcHan
         KpPkv7naSQ/lzIdOtZlaMUz+JdA/iO6luBGWC2CrUas78pQumhH4ouWBSRtvMzB+5tAf
         M78YhkvOdRhKu0wjyp25Ji4LDTZaMtgW3DVsfsxLbfqerF9o06YomjjI2M+ChogwRZV7
         Vo1YSUwoDTueBeeIS4AEaUkOjBMtnx81o8FluaflRbCLqJZYu54nx1jF0kjoWqJ5P90W
         oaPxMrfVmWtJtULoLuZYMLs2CgFtDPjdJooDErfP38K6bWnu3WUNb3aPMckp3lA/77TF
         lptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713467406; x=1714072206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFCOV5/FbvZyadb0eigbmic/UPzgGtARohnH/S7yn5M=;
        b=F9vAG/VnSmY7QZS25HusxlT1CE4c3NV1Bsmn8CzNpGKHe0xJDNuuDY4AMirBX7AlQ/
         UHLs46eIxiZFoZnWi1hudeXsRsz1qFDr/U1Rj5JhhKYIhkSlgaKLFs/RzRUW1OEBer3j
         aYA29PWowWlHAR9GH1A6at0szc7ZTmEOzrC0baYDdIL8DVfatDfB9IVUMfJDMUIntwgq
         0qSX+nVYXwdOn6IF16YAcGt4EeBRodEp23bqMaUSHZvp9I1cXz66x07ZpelzW3FsdIGL
         Jilse5DPaJA/YeGMsOxd6zU87VtCI1T4LipnHkVoSwRbOk51RVsbXLaRsVKgyJxFvfWw
         7rYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVczPUEmJfiBPi9qyVY5qd2gWzEqpN6AYGAPtJeYZkFeUtOHlMIL08PSAw53ASs75ILhr74rtpdQ1LTlbnIyM1ZwUu6irzLBIPtmSzxQH4nJRelqwe8XZ/VJgOcEhdc0TlQfPSdba2vwsjR+Hjrrq5k09QCqep41YvTbDaec3vMz+kHiExa
X-Gm-Message-State: AOJu0YyW0AjKU6jUhlp8cKvqldBlNnqSwYBIxfrIhihMqf0KNzQx/8Jj
	cmz/KMorm8gezg/bhedz+jx8V7lmJWzwlNM0K/HKfmvqMGBeSf+v
X-Google-Smtp-Source: AGHT+IHeGbZo3NR5cIAMrdyKdsxgouRoWv0Ml67OyFVx/dFz8bHvQmI84/kBwrtuR7IbXbEyjH6uzw==
X-Received: by 2002:ac2:4836:0:b0:516:d3ba:5602 with SMTP id 22-20020ac24836000000b00516d3ba5602mr2273115lft.16.1713467406333;
        Thu, 18 Apr 2024 12:10:06 -0700 (PDT)
Received: from mobilestation.baikal.int (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id a22-20020a195f56000000b00518e16f8297sm352294lfj.55.2024.04.18.12.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 12:10:05 -0700 (PDT)
Date: Thu, 18 Apr 2024 22:10:04 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] dmaengine: dw: Simplify max-burst calculation
 procedure
Message-ID: <2htaobgfle7glf4t7v5vjlhx6hdzja6bbwn3fonhejs3dbxgij@puaipep4ycwp>
References: <20240416162908.24180-1-fancer.lancer@gmail.com>
 <20240416162908.24180-5-fancer.lancer@gmail.com>
 <Zh7NfmffgSBSjVWv@smile.fi.intel.com>
 <tez5uqt4lg2qf5nooxuqo2rqhkqzzzbpeysdcbljokznbztkhj@j5t7cy4gd4pd>
 <ZiEIxq8dHxObrYZx@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiEIxq8dHxObrYZx@smile.fi.intel.com>

On Thu, Apr 18, 2024 at 02:49:26PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 17, 2024 at 11:35:39PM +0300, Serge Semin wrote:
> > On Tue, Apr 16, 2024 at 10:11:58PM +0300, Andy Shevchenko wrote:
> > > On Tue, Apr 16, 2024 at 07:28:58PM +0300, Serge Semin wrote:
> 
> ...
> 
> > > > +static void dwc_verify_maxburst(struct dma_chan *chan)
> > 
> > > It's inconsistent to the rest of _verify methods. It doesn't verify as it
> > > doesn't return anything. Make it int or rename the function.
> > 
> > Making it int won't make much sense since currently the method doesn't
> > imply returning an error status. IMO using "verify" was ok, but since
> > you don't see it suitable please suggest a better alternative. mend,
> > fix, align?
> 

> My suggestion is (and was) to have it return 0 for now.

Ok. Let's have it returning zero then.


-Serge(y)

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

