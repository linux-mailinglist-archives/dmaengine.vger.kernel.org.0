Return-Path: <dmaengine+bounces-2792-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F53D947B02
	for <lists+dmaengine@lfdr.de>; Mon,  5 Aug 2024 14:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEA371C20F07
	for <lists+dmaengine@lfdr.de>; Mon,  5 Aug 2024 12:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CCE158D7E;
	Mon,  5 Aug 2024 12:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Je+EWFEq"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24D4158877;
	Mon,  5 Aug 2024 12:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722860743; cv=none; b=SRRIRuhGUZI8vZim7NGgkgSo0rCyGQ33qJGKdSdzgUP72H/oD78oYWFhAr40l8XU4WYWrxM3nkfoXR5DRanbSQUecrSSswnW4XQZVqXDGxtVKrtHrOHXPP2VdeECOEzMt51Efd4BfqPq387/bQSKobtlVUc6oeldqNTveoGKPDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722860743; c=relaxed/simple;
	bh=Qdc/hZK/izOikXRxIcKspd4asGIzYcNYPJjK6mYBy2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtnrP7EfifGKXa4NnW6AJd8z87qHHXJKRec5tWVpCxc176MH02jgs7ryPEIqANOkw8JMOnYdPGQht/sFdUFXjv7KPf0/uQueA9gtQl5Lx7w3CDJt9Tc/TfRfA+J0d4gmaTnHSYd4TxRmf3Lme3Y3kCZOJ8a04IGBc+FSligqJWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Je+EWFEq; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52f01b8738dso9952533e87.1;
        Mon, 05 Aug 2024 05:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722860740; x=1723465540; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ODibAriCCYBMir2Y+K6rxvL6CWMqoMJ8J2HVzExd6tg=;
        b=Je+EWFEqZ1MBRPgg9nvlTEy1IY20urHo7YNoerCLRqAmR4tjHFG0De1SLDYthXz9nh
         EmcU3dmcw6C7MB9PhfrZIcpvttBoUoVlL1tuqjM2yzUQ1mWu8uJzDsvlajhB3TuxqnaI
         kX6PKpghYUxzkM+DWkUrwcWd/aFxc5ak5tUDcNQcIr3cI4ki2KcXfWZgdwRDdDcS+FQH
         63TYDJw6XVe3DwjLj1c0cIz2d1Hk69khAS6fU/2NgmgEZelaNfrvuqUrrL6hYwvc36xw
         0Wx2YXzVXM7vT3yxImWEVwiI/qv4pL+5Sg/1MJEls5h4ts1HYaKOoZ/G6HB2aDlXPR5L
         8iCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722860740; x=1723465540;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ODibAriCCYBMir2Y+K6rxvL6CWMqoMJ8J2HVzExd6tg=;
        b=tpCkt5gwZ+CLdpAPV7ptnq1+e1FhzxSbJ2z78TwrnC/co7VbXWLWmSK7K81+W70MsC
         zkpWM0k2itcJ+ERLJsvfuBNtSUrA7DIYiaWNW3xjkGmuwCCaCT22DH0B/1CxrjsDI7np
         gkO0sQxz4XRnWFHlHFIzdphIAqLuz13Ed5e6oahXEn39nPQwl9ePmRgPcjyyRvJQ5Plt
         LpRXeOc+HUP1fStp+aytDlY0Qba3fKU3TkJzbhy9j7a5Frl4lEwbva90s+wkWGt97xqT
         6KOe22oJr36K+AOLgELNL+BIzQSzjlCG97v227rhbx+Fbc/fVxi6Fwopi8xUrp22Cbnd
         QXsw==
X-Forwarded-Encrypted: i=1; AJvYcCUFlY2feO8EIyxpm7vPd9c9SSk5WyddjWnrzWV0CDZBODC5uVRV9ZFYXHKcWFS7LLKLYHg4kKZM8myDrUNqKxddk4gydixCRLLorqs25mRzdrQ0p///48u7fyq9A0Kp7iJzKpfv4m6AQo7ZTaKktPkBkotVa+UvMNob6ig/8sRV+WVIz+kw
X-Gm-Message-State: AOJu0Ywdxzu12Mi/xn9Yvh/ZNjy9iD3KuiuoT+xr3gv2jwwLII0taCgu
	tAJ6wHPHK4vFdnjwwRbsm7/eSl0tdybD3TB6tWB0akalrAqyByJQm0upaw==
X-Google-Smtp-Source: AGHT+IHKYTLyUlq5cKTn+hicB3zQJ94PwanCSK0swvjV1cQHCdeJJsfITovQjZT6HDu+i2BpIfU0MA==
X-Received: by 2002:a05:6512:3ba9:b0:52e:6d71:e8f1 with SMTP id 2adb3069b0e04-530bb3b434bmr7985979e87.53.1722860739280;
        Mon, 05 Aug 2024 05:25:39 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba10dedsm1115827e87.79.2024.08.05.05.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 05:25:38 -0700 (PDT)
Date: Mon, 5 Aug 2024 15:25:35 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4 0/6] dmaengine: dw: Fix src/dst addr width
 misconfig
Message-ID: <rsy7z45nhl74nzvq5a2ij4eeqgzu3htje2xpparxgam7jowo6a@6l75wjh2dqll>
References: <20240802075100.6475-1-fancer.lancer@gmail.com>
 <CAHp75VcnfrOOC610JxAdTwJv8j1i_Abo72E0h1aqRbrYOWRrZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VcnfrOOC610JxAdTwJv8j1i_Abo72E0h1aqRbrYOWRrZw@mail.gmail.com>

Hi Andy,

On Sat, Aug 03, 2024 at 09:29:54PM +0200, Andy Shevchenko wrote:
> On Fri, Aug 2, 2024 at 9:51 AM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > The main goal of this series is to fix the data disappearance in case of
> > the DW UART handled by the DW AHB DMA engine. The problem happens on a
> > portion of the data received when the pre-initialized DEV_TO_MEM
> > DMA-transfer is paused and then disabled. The data just hangs up in the
> > DMA-engine FIFO and isn't flushed out to the memory on the DMA-channel
> > suspension (see the second commit log for details). On a way to find the
> > denoted problem fix it was discovered that the driver doesn't verify the
> > peripheral device address width specified by a client driver, which in its
> > turn if unsupported or undefined value passed may cause DMA-transfer being
> > misconfigured. It's fixed in the first patch of the series.
> >
> > In addition to that three cleanup patches follow the fixes described above
> > in order to make the DWC-engine configuration procedure more coherent.
> > First one simplifies the CTL_LO register setup methods. Second and third
> > patches simplify the max-burst calculation procedure and unify it with the
> > rest of the verification methods. Please see the patches log for more
> > details.
> >
> > Final patch is another cleanup which unifies the status variables naming
> > in the driver.
> 
> Acked-by: Andy Shevchenko <andy@kernel.org>

Awesome! Thanks.

-Serge(y)

> 
> -- 
> With Best Regards,
> Andy Shevchenko

