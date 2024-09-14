Return-Path: <dmaengine+bounces-3162-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4573F979338
	for <lists+dmaengine@lfdr.de>; Sat, 14 Sep 2024 21:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29EB4B224C6
	for <lists+dmaengine@lfdr.de>; Sat, 14 Sep 2024 19:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0E18003F;
	Sat, 14 Sep 2024 19:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNVDRS8L"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62771748D;
	Sat, 14 Sep 2024 19:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726341749; cv=none; b=Erog1YvM7o7MAmOMrq2NcdwgbeaLeHQRO1RnOMkfYe+2iafO8I04pO3sz5vemm4VX9Zd18venU//F8a2RC9BBiXBe85Tzdcchb+n0mGlMnzFNjS54zqtjq39ym50309opHjuPvviBqW9lfnDUA+x8wxJlU2BVlcX3hsTq5xtj8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726341749; c=relaxed/simple;
	bh=BLy3wuMimgkHEgEO+X6jkbMBme1EyT8aqQ96gcl8TbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkG2llJrjZ1Rl74wnCD5d2yYpqxcNmcN9gp2VBW94Kz0UJ4dK/SZfpechyuR9GnJLZUrp8N/SVRieKWV9DApaWYSl3QVTEol42OkaAENzLU0se9MyfZ5KtjhHygYtJY4Ztamfgb/hUrOksfddaPKhG2M277nYe54kKeqBRVBJM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNVDRS8L; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso31208005e9.1;
        Sat, 14 Sep 2024 12:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726341745; x=1726946545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HgCkNDgGaXDYlTixMVt+BVNvRuy2skkx8fC6/Xixtvc=;
        b=HNVDRS8L1wifl02DNXBC5w0n6w7OJOOC4UQX0FtXOqB6NCbhzxFaJIb+2YAImljHwm
         McAkoHwuVp23OxvVdMZhB+BYyzWrVHPkk1FKqb9rcOqU87176u3dv5bIMR/5Pclk0UG9
         4jnL0i5fcpIyAzt43WdgyMTG1q8gPCAP9l2a4EruS2yh8+0GZuSZHuSho8Fvd7pyWlEJ
         uAIhVhjjkDGzsIX0gYG92pEZI0T+ZmZfMGXg+AhPbub3uJhJrnpTNXcLqcIy1XwPf77i
         N3fFERKp7Vs46p52C6AGLB3ZY+WZSu7H6YASBPjVDpHXCmP/uv53yFobDPJHm8zr1hrE
         5+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726341745; x=1726946545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgCkNDgGaXDYlTixMVt+BVNvRuy2skkx8fC6/Xixtvc=;
        b=UKDGqu57I8s4XVlnjg81boEZYs+QCsQHHS7lk+ZdKalY4kas3ju2o/qMYCIEDiErDB
         9bqa/2C9FVMUPwLzcJa4wWbS96MaNNYcf9qciUifFbybi0iBpQdPub+ksjJwgIv2ND6O
         1XPcGWB1ooxJ/VERYPmP8cfeTVTIVLV8rDNYGrV/sXwG8ol+iFTbNVj9GYNGAkBKQMV5
         kYQMvf0Yh5DKGkgY+Zih7TtkiS4Xqp5gbaX/UyeC4qbxg2M5xjAE/07gsilF745UGnkR
         Fges/CgpMZNiRPv+M1A9ubit0hkY4moUhVhPqEw3pZL0ursdmwJM0ZlxzhCStlgXvW37
         F0nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyMiqZCfdY0oS0Pv38bE9n/RSkSicwkqlPfQJOB7LOAYdz8Kkr1r0FO7T8kaxB0GQrVduA7eNHgBrx6P/C@vger.kernel.org, AJvYcCWVxxy0rXB02ul1zJENunzxUGyCUenwOngFpZtDqpthelEEDc0XksvNx//abje/Xb5sbUFDBmADOB4=@vger.kernel.org, AJvYcCXjrYc2KsEQIopC0o471cmeqPkegTZRYSZUKHXG1t79Q2af4iBif14q66QNke5+ny8OTDrQNqdEf437sFhR@vger.kernel.org
X-Gm-Message-State: AOJu0YwHk42u0Wo+S/lJQQRkq5B5VSExm4/Bm1my8GA0m6buKkur+rji
	t/VQResc0II9Sd/7KDNZX0SHwI0rkneawXAYXgwIOJNokeeFRDs5
X-Google-Smtp-Source: AGHT+IFjc+UFlMY8gctqPDoBf3Tlap/C8bAos9lI1cJhThqwxBjLaxuty5HWVKDGcJ+Lxfj8YWkigw==
X-Received: by 2002:a05:600c:45cf:b0:428:f0c2:ef4a with SMTP id 5b1f17b1804b1-42cdb531c3dmr96752455e9.13.1726341745346;
        Sat, 14 Sep 2024 12:22:25 -0700 (PDT)
Received: from mobilestation ([5.227.29.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e780e14fsm2627364f8f.117.2024.09.14.12.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 12:22:24 -0700 (PDT)
Date: Sat, 14 Sep 2024 22:22:22 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ferry Toth <ftoth@exalondelft.nl>, Viresh Kumar <vireshk@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4 1/6] dmaengine: dw: Add peripheral bus width
 verification
Message-ID: <wghwkx6xbkwxff5wbi2erdl2z3fmjdl54qqb3rfty7oiabvk7h@3vpzlkjataor>
References: <20240802075100.6475-1-fancer.lancer@gmail.com>
 <20240802075100.6475-2-fancer.lancer@gmail.com>
 <ZuXgI-VcHpMgbZ91@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuXgI-VcHpMgbZ91@black.fi.intel.com>

On Sat, Sep 14, 2024 at 10:12:35PM +0300, Andy Shevchenko wrote:
> On Fri, Aug 02, 2024 at 10:50:46AM +0300, Serge Semin wrote:
> > Currently the src_addr_width and dst_addr_width fields of the
> > dma_slave_config structure are mapped to the CTLx.SRC_TR_WIDTH and
> > CTLx.DST_TR_WIDTH fields of the peripheral bus side in order to have the
> > properly aligned data passed to the target device. It's done just by
> > converting the passed peripheral bus width to the encoded value using the
> > __ffs() function. This implementation has several problematic sides:
> > 
> > 1. __ffs() is undefined if no bit exist in the passed value. Thus if the
> > specified addr-width is DMA_SLAVE_BUSWIDTH_UNDEFINED, __ffs() may return
> > unexpected value depending on the platform-specific implementation.
> > 
> > 2. DW AHB DMA-engine permits having the power-of-2 transfer width limited
> > by the DMAH_Mk_HDATA_WIDTH IP-core synthesize parameter. Specifying
> > bus-width out of that constraints scope will definitely cause unexpected
> > result since the destination reg will be only partly touched than the
> > client driver implied.
> > 
> > Let's fix all of that by adding the peripheral bus width verification
> > method and calling it in dwc_config() which is supposed to be executed
> > before preparing any transfer. The new method will make sure that the
> > passed source or destination address width is valid and if undefined then
> > the driver will just fallback to the 1-byte width transfer.
> 
> This patch broke Intel Merrifield iDMA32 + SPI PXA2xx configuration to
> me. Since it's first in the series and most likely the rest is
> dependent and we are almost at the release date I propose to roll back
> and start again after v6.12-rc1 will be out. Vinod, can we revert the
> entire series, please?

I guess it's not the best option, since the patch has already been
backported to the stable kernels anyway. Rolling back it from all of
them seems tiresome. Let's at least try to fix the just discovered
problem?

Could you please provide more details about what exactly happening?

-Serge(y)

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

