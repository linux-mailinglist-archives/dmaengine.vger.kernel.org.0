Return-Path: <dmaengine+bounces-2954-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B2595D3A2
	for <lists+dmaengine@lfdr.de>; Fri, 23 Aug 2024 18:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849691F23273
	for <lists+dmaengine@lfdr.de>; Fri, 23 Aug 2024 16:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6FC18BC06;
	Fri, 23 Aug 2024 16:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQmHvxqb"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6343818A6C7;
	Fri, 23 Aug 2024 16:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724431155; cv=none; b=s2n6ptisuyIQ4PIVlYpdExPARDImcGqSH7l0c9DoBxDit1TDvLc6sZOBd1WTttIHtKE+h65lUpn8QppyLPvdfsw9IM0unRpOFwaTXi09rAVIKpstSk3PLGG/eoaCEvEfTHJYr4HA1gR51uzzk5iQUFxMKDlCqHekeI1R/Xp0VJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724431155; c=relaxed/simple;
	bh=37bNjvVUVCnwm4dabjuxz+DsxHpI2MJeGgPnKPYD6eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0dovCjxwUbEMLNSJu1vEcx4/xvvU2buDaoEQsvfJiRH/fqlJ2CqRnFLV89EdX5/y8GgVrV8wCJL2b1v3fnbAejkjF/tdasm22yKkdYlbZhgIu2haJ9cvtoTGMbWP2si3Ko3wEb1IL9nqzmj+rlu0rxW1aKcC+32xOL3YmsCVxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQmHvxqb; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5333b2fbedaso3542657e87.0;
        Fri, 23 Aug 2024 09:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724431151; x=1725035951; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2WRjvniXybxQWI+iJ2ujBTSF1lPf98KW9vC1KUIKZrI=;
        b=DQmHvxqbMZeuoOWaVdOOVVQYxUgZllenoCH7ZZ/AB9xAdVg7N5K/gt8+ERdzqZC8TE
         wdnZgUfarh4+N8hJtAAS2USf4YqHTmIMpIVnMsTbHJZZYYU0W62c4vrAd4yqWuDlVqot
         Ptj9uWZHAVHVdJZ3uWMR1bCon/BYlrktyi3dKYQeacQTeSipIZdA5aHqgry+qkhj2LjR
         JtkMa6yFKqZXy1fWgoc9BWOoNBNZ4xNVaR0FGrxi1VsBzG4hYBz3jPVU0pEPi0wfK4rA
         cwdhgTnUTUxHfBGV1nktuxyadO6ou5IJtJzxX+fT5PkZIHs2yWO41H7Glx2GEq5Fc1Qb
         zdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724431151; x=1725035951;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2WRjvniXybxQWI+iJ2ujBTSF1lPf98KW9vC1KUIKZrI=;
        b=Vu+aW09CpPXo26MTIsGQVNESPy5SucRZWD+RxebrpIdirVuh9q2+3zlo+DWjv2HHkk
         uEqfIY6VgCXtu5qeCM3VqVDHKsowMnfiDGoOyAJDAAtbpVXgAiX5BDgZwOwItkFcqOg5
         +R+siZXXnIutz0ARizB6nDhOFgeGVz35hRfkvPTfNYgw5vnz5a8hsxv5qp+CE8qNA2Nr
         izOgU0ih2+RByvEaurN2FPQesKYeSWae9UjDgC5LqwtgHJPoVHZqP9DGZFmxaZaJIeMl
         fTW7cFZK+4LOBt3nCvlUG3FzNZYj1fSMQR8VnGxigYDQlKyxS+R1LmyuHFdMwwgMzJfB
         sIvA==
X-Forwarded-Encrypted: i=1; AJvYcCUSTWbxQRwrlrw7YukxOS14IhSejq4s/ZpwQWiU1J4Mz7NpoBJtfLFkSxTwK2u4jT5WadbEVjO9mIeWyeul@vger.kernel.org, AJvYcCUwyd1O1UQQ1Q8MC7ertWGZ+HsluP2JY5ywgtfgteQWAY32xg9QBrJ3k+7QdfnHPKsNdc2OEaKS4J629uF2@vger.kernel.org, AJvYcCV5qRYVDXBEmXrpo1uh6Ua2t515nI0I0THRoEd7MIIR6hi0opex6OOrtPUSKFz/drdaeAxg5Une3nQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgDDTh2LfdR+sj/FxYA/+yEQZUCf/Wm9eZqj5dSQucjqI1YOnu
	72cVZcJpE8Cx1aVfCRHVCq9mB+HtkEAjmBcCN6lVA8VNO80ZuLqF
X-Google-Smtp-Source: AGHT+IGiGfLhmgN/ZEt1qGQRBjLYK4n4/sf9dIyAH2LAsgYySPXwh7hMCdqr9AL1FkYv2kkstxYUqA==
X-Received: by 2002:a05:6512:318f:b0:52c:d834:4f2d with SMTP id 2adb3069b0e04-5343877ab14mr1678549e87.18.1724431150764;
        Fri, 23 Aug 2024 09:39:10 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea5940asm607500e87.159.2024.08.23.09.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 09:39:10 -0700 (PDT)
Date: Fri, 23 Aug 2024 19:39:07 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Viresh Kumar <vireshk@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Vinod Koul <vkoul@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] dmaengine: dw: Prevent tx-status calling desc
 callback (Fix UART deadlock!)
Message-ID: <mdyifrhjufjwp2tko54gfw34riepov5bo4a4tefhrtfmuystao@wpjfsgikebki>
References: <20240802080756.7415-1-fancer.lancer@gmail.com>
 <n6grskuq722vnogwp5obiwzv4pxs5bbqddadesffezhvba5cjh@d6shcrvpxujg>
 <CAHp75VdXqS6xqdsQCyhaMNLvzwkFn9HU8k9SLcT=KSwF9QPN4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdXqS6xqdsQCyhaMNLvzwkFn9HU8k9SLcT=KSwF9QPN4Q@mail.gmail.com>

Hi Andy

On Fri, Aug 23, 2024 at 04:21:24PM +0300, Andy Shevchenko wrote:
> On Fri, Aug 23, 2024 at 12:48 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > Hi folks
> >
> > Any comments or suggestion about the change? The kernel occasionally
> > _deadlocks_ without it for the DW UART + DW DMAC hardware setup.
> 
> I have no time to look at that, but FWIW with a stress tests on older
> machines I have seen something similar from time to time (less than
> 10% reproducibility ration IIRC).

Thanks for the response. I also used to have the system hanging up at
the very rare occasion, but after I decreased the size of the Rx
DMA-buffer (to fix a platform-specific problem) and sped up the port
the deadlock probability dramatically increased so I managed to debug
the hanging ups.

> 
> P.S. Is there is any possibility to have a step-by-step reproducer?

There is a good chance that my approach might be platform-specific
(but the problem is general for sure), but here is what I did to
make the deadlock reproducible at the reasonable time:
1. Revert the patch in the subject (if it's applied)
2. Decrease the Rx DMA-buffer size:
drivers/tty/serial/8250/8250_dma.c: dma->rx_size = SZ_512;
3. Increase the serial communication baud-rate:
stty -F /dev/ttyS1 1500000 raw -echo -echok -echoe;
4. Loopback the ttyS1 interface: connect Tx and Rx pins.
5. Start pushing data to the ttS1 interface by the chunks someway
greater than 512 bytes. Like this:
while :; do echo -n "-"; head -c 65536 /dev/zero > /dev/ttyS1; done

In my case the system almost always hangs up after 10-50-100-200
iterations of the one-liner above.

> Also can we utilise (and update if needed) the open source project
> https://github.com/cbrake/linux-serial-test?

I guess the utility can be used to reproduce the problem, but the
data integrity check wasn't required in my case. I am also not sure
whether the loopback-test is required to reproduce the denoted
deadlock, since only the Rx code-path causes it. So most likely the
heavy inbound traffic shall be enough.

-Serge(y)

> 
> -- 
> With Best Regards,
> Andy Shevchenko

