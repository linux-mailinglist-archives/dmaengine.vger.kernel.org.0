Return-Path: <dmaengine+bounces-1170-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D67F86BA27
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 22:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 511211C21D90
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 21:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BB67004C;
	Wed, 28 Feb 2024 21:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZtLJz/W4"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C047004A
	for <dmaengine@vger.kernel.org>; Wed, 28 Feb 2024 21:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709156773; cv=none; b=Xk9eqF4ap/R+ZAi8zPdUzGUzgOgICqfgLCHNxgDjrKAQR1t/lj5NlB5pr4GnmDPzC4g7EXS8uckC58Twt1KIoewYFgKTleFlTaN01Pg//m/NhDy3pJ7adgbNbkJibWrr4N6bG7CS+Ml9rYkRqC6p7XDMIrWi5Aav0zvq6lh8FC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709156773; c=relaxed/simple;
	bh=fcDVrwhc94lvkdvuNxLBpqQuiN5giB/sSTSBYGUgGIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7BH1VeYxgPfg3SPZE3alGTsluqYq6kA4+/brabsyTHob2sH3BTjknBLWrislnSucmSsx0AvjbsGdDS4JSN1PHnFWzC03Nv80UZTbh1hNR9xN+AlWBg+nHQ99GUS26uLgZ9M6SVfDQOj/+UNC9NWaWiRLzMW0qlD4MyptTqvjhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZtLJz/W4; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dcb3e6ff3fso2592465ad.2
        for <dmaengine@vger.kernel.org>; Wed, 28 Feb 2024 13:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709156771; x=1709761571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YdpR7cAKDSC45Ra+lrCp3FSf1aPEjcGJZRBQhc0h7f4=;
        b=ZtLJz/W4FVvtDRebNbxjo9KAbyrivuwW7+Y8BDkVKdrGwX6LFTJ541BhPJLPafiylL
         L1pr8exLx7rY4kcmGR46OVXlksD5v1A+XiM1EMekDxwic601QGOOpe9j/cXgjsOoXyoy
         eX4Xe+VYEYoDAYDRSvSJtR2m0DxJiFFjHoCIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709156771; x=1709761571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdpR7cAKDSC45Ra+lrCp3FSf1aPEjcGJZRBQhc0h7f4=;
        b=bpI213K7zCNYnCWRqInW0x6qpfKKxH7Bwsa9hTNQ0QTfUiGf+Xj1nzIj7MDFStCiQE
         o+zDKQEEknCNKA02/AX2lgkymcZ2xTUOPUR/Yee45aeKsW7cvaUIyl7la26xf0M9mdkY
         Sv4ydqld4yW+GvgxLoGsqamnT4vnnn8t3VxQtOICoTcnffVbNlkTyyf+OzFieo3hQsNT
         yhjFeEJ0q+2AsGJyK2p1ODHHOwW8Yavq9GQq+zP8mgHv9aJ7kJ1YA+lbn5hyH5C1Yu2S
         ev9Sy8FvhE5+BHWsxx0rzPof9DYE5q5paQs1D1LEVoDjoBillE2njKYWdKCwzo8oe7G5
         prow==
X-Forwarded-Encrypted: i=1; AJvYcCU+xKdFA+xyBio26L5TysgIjqpOF1UrIGxnFGU0hguV8AwROqA09BgKfxTS+KGEWRTcW0+nmgLio9jLpEKSsPaZ0+gcHk5nhHYc
X-Gm-Message-State: AOJu0YysHmbiMIV2n5agnjEnCfunGKx+i1rmoEWr5thycZE5VeExhw4m
	E/Z9cDf+aqB8p1djJEhhMoAsaRBz1V2XHiXrYlY87RzGC0YsACilJct5zWLDdA==
X-Google-Smtp-Source: AGHT+IFK5KehNOc+U2G0Wb+EMlndfkoXfMOcgULHS3OIVI0AWPxjaSZUD8y4ptkj3iwHc9bqJccSpg==
X-Received: by 2002:a17:902:ec81:b0:1dc:696d:6bb0 with SMTP id x1-20020a170902ec8100b001dc696d6bb0mr246471plg.6.1709156771102;
        Wed, 28 Feb 2024 13:46:11 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id je6-20020a170903264600b001dc23e877bfsm3733240plb.268.2024.02.28.13.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 13:46:10 -0800 (PST)
Date: Wed, 28 Feb 2024 13:46:10 -0800
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vinod Koul <vkoul@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-spi@vger.kernel.org, netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v4 7/8] net-device: Use new helpers from overflow.h in
 netdevice APIs
Message-ID: <202402281341.AC67EB6E35@keescook>
References: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com>
 <20240228204919.3680786-8-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228204919.3680786-8-andriy.shevchenko@linux.intel.com>

On Wed, Feb 28, 2024 at 10:41:37PM +0200, Andy Shevchenko wrote:
> We have two new helpers struct_size_with_data() and struct_data_pointer()
> that we can utilize in alloc_netdev_mqs() and netdev_priv(). Do it so.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/netdevice.h |  3 ++-
>  net/core/dev.c            | 10 +++++-----
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index c41019f34179..d046dca18854 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -25,6 +25,7 @@
>  #include <linux/bug.h>
>  #include <linux/delay.h>
>  #include <linux/atomic.h>
> +#include <linux/overflow.h>
>  #include <linux/prefetch.h>
>  #include <asm/cache.h>
>  #include <asm/byteorder.h>
> @@ -2668,7 +2669,7 @@ void dev_net_set(struct net_device *dev, struct net *net)
>   */
>  static inline void *netdev_priv(const struct net_device *dev)
>  {
> -	return (char *)dev + ALIGN(sizeof(struct net_device), NETDEV_ALIGN);
> +	return struct_data_pointer(dev, NETDEV_ALIGN);
>  }

I really don't like hiding these trailing allocations from the compiler.
Why can't something like this be done (totally untested):


diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 118c40258d07..dae6df4fb177 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2475,6 +2475,8 @@ struct net_device {
 	/** @page_pools: page pools created for this netdevice */
 	struct hlist_head	page_pools;
 #endif
+	u32			priv_size;
+	u8			priv_data[] __counted_by(priv_size) __aligned(NETDEV_ALIGN);
 };
 #define to_net_dev(d) container_of(d, struct net_device, dev)
 
@@ -2665,7 +2667,7 @@ void dev_net_set(struct net_device *dev, struct net *net)
  */
 static inline void *netdev_priv(const struct net_device *dev)
 {
-	return (char *)dev + ALIGN(sizeof(struct net_device), NETDEV_ALIGN);
+	return dev->priv_data;
 }
 
 /* Set the sysfs physical device reference for the network logical device
diff --git a/net/core/dev.c b/net/core/dev.c
index cb2dab0feee0..afaaa3224656 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10814,18 +10814,14 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 		return NULL;
 	}
 
-	alloc_size = sizeof(struct net_device);
-	if (sizeof_priv) {
-		/* ensure 32-byte alignment of private area */
-		alloc_size = ALIGN(alloc_size, NETDEV_ALIGN);
-		alloc_size += sizeof_priv;
-	}
+	alloc_size = struct_size(p, priv_data, sizeof_priv);
 	/* ensure 32-byte alignment of whole construct */
 	alloc_size += NETDEV_ALIGN - 1;
 
 	p = kvzalloc(alloc_size, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
 	if (!p)
 		return NULL;
+	p->priv_size = sizeof_priv;
 
 	dev = PTR_ALIGN(p, NETDEV_ALIGN);
 	dev->padded = (char *)dev - (char *)p;


-- 
Kees Cook

