Return-Path: <dmaengine+bounces-1211-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D61DC86D636
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 22:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89341283362
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 21:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8606D50B;
	Thu, 29 Feb 2024 21:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Otdgupdr"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CF516FF58
	for <dmaengine@vger.kernel.org>; Thu, 29 Feb 2024 21:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709242307; cv=none; b=k8G8OypwvTpQMrs2lAGBRWFxXYHWMoX6Gdsjsmuye9ALG/XN0f5W2o0FK7vJRZnKlX1LzQHLFdmeHNqIaJ/pkUL7/c7/DvbagDgjSqmiu4MmZccM29jckfSl9xNXXBtTzMC+5u8oRhxxlTWH4YGzafg3T43zn/9s+oMATcJtGwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709242307; c=relaxed/simple;
	bh=QzZTm6RzwKOCXz1s1DDgA6t36vWxFMgXU9qMOsdvjRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TcWziGbA4gSHS/fqKT391YCelo712um/pgH4W/Rja3xV+/mvavzJe3AglY14PLlEOenBG3i+BN+bmdiiE5XKCWMngjPnx/HFVFGqVj4Ah5PaRoc56GnI1DJzP1WuVe7qPwFgL1PvHhLaDAYWVAeI/vtVYcOn94ls3a3tSdweVgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Otdgupdr; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dc0e5b223eso13742485ad.1
        for <dmaengine@vger.kernel.org>; Thu, 29 Feb 2024 13:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709242305; x=1709847105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fi9gJh0JIT3rydMe7Re3YRcK5pxmffs/i/bQwJvpoAc=;
        b=OtdgupdrMqUU6v6YG5ItdSUVYWtggtW7CLi08MPwU/tGTaozH8afksz/j9WnraUdkZ
         gQO7+saJw0TruPFKJJShHIMwzH14EPnGlOS+T/kEWAOEPVR4l6UaIrHpoabCCEf3XPtP
         BuKQeG2cQ0ZPa/TIhRpwB3WIcITiVw6Bv0O6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709242305; x=1709847105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fi9gJh0JIT3rydMe7Re3YRcK5pxmffs/i/bQwJvpoAc=;
        b=SgcD4jOIIuhkJ1cLAPrRT2ii+Wr8bhREeGHELRRBpdBaBrA4gYoG5ePY48wx7O6J6y
         cNKcQuP+om05d0QLw+FHtEzqTpTF8FkAJxXGULkVLwRZYo0Df59SWVUpPiSAzJXnVfz1
         jZ/DKe5XjT+C43kILpwFhYb2yoAU+l2ZV1bdbrMMJJ5UpB8v6QDHCZNXhV+f17jfueVh
         Rka1YR2hlnCixt8Uo6O+6uun5IxyzmXGCf1RrjP7bbD8gkiL8E8ekISzu9YkawbCRO+C
         ypukFzSysv1voPCahdYIMxcJ31c3bgi2QMO9WMmNxyqC1otqCrkJ4L9HOQ739JlmM5ax
         sE/A==
X-Forwarded-Encrypted: i=1; AJvYcCW0RULKWN+8uU0LMT7m4BDl7zm4qql20W7TZJpTC9y/iSB3EiYz1Yd6VilKRMo07X3CQInGKrJ3C7cqKNhGJau2PwRLXZn5HRiA
X-Gm-Message-State: AOJu0YwPx9NZ77NFKphsBbOR3LQ8v7TSD1iB6n0dk7kjePBooYo0wX1Z
	RmOu7Zh7Pf1NwJeOVjD/apfnVf6WGF7RuGobJZuU02khUunKOZT086vf5ggG4A==
X-Google-Smtp-Source: AGHT+IE+DUv8Qdh0LZ32jo8m9iF3a01wivEsDDN/MHriPt719iWzbKIbR1Qbd56MoYjYqe7Ub9Claw==
X-Received: by 2002:a17:902:654a:b0:1dc:ca72:8318 with SMTP id d10-20020a170902654a00b001dcca728318mr2807886pln.37.1709242304905;
        Thu, 29 Feb 2024 13:31:44 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y9-20020a1709027c8900b001db717d2dbbsm1954387pll.210.2024.02.29.13.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 13:31:44 -0800 (PST)
Date: Thu, 29 Feb 2024 13:31:43 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-spi@vger.kernel.org, netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v4 7/8] net-device: Use new helpers from overflow.h in
 netdevice APIs
Message-ID: <202402291330.0510946B67@keescook>
References: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com>
 <20240228204919.3680786-8-andriy.shevchenko@linux.intel.com>
 <202402281341.AC67EB6E35@keescook>
 <20240228144148.5c227487@kernel.org>
 <202402281554.C1CEEF744@keescook>
 <20240228165609.06f5254a@kernel.org>
 <202402291059.491B5E03@keescook>
 <20240229113706.42c877a1@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229113706.42c877a1@kernel.org>

On Thu, Feb 29, 2024 at 11:37:06AM -0800, Jakub Kicinski wrote:
> On Thu, 29 Feb 2024 11:08:58 -0800 Kees Cook wrote:
> > > And some seem to be cargo-culted from out-of-tree code and are unused :S  
> > 
> > Ah, which can I remove?
> 
> The one in igc.h does not seem to be referenced by anything in the igc
> directory. Pretty sure it's unused.

I'll double check. After trying to do a few conversions I really hit
stuff I didn't like, so I took a slightly different approach in the
patch I sent.

-- 
Kees Cook

