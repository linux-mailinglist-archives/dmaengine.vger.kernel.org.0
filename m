Return-Path: <dmaengine+bounces-3189-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF87E97CAAA
	for <lists+dmaengine@lfdr.de>; Thu, 19 Sep 2024 16:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82E8C283F4C
	for <lists+dmaengine@lfdr.de>; Thu, 19 Sep 2024 14:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B818919E7FA;
	Thu, 19 Sep 2024 14:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Arl24N4M"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0060519B59D;
	Thu, 19 Sep 2024 14:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726754650; cv=none; b=ReDc5zASLMIFQY2TJXXRqg0IRT+p7jt9ZqlC+0LWq+PJxMR+jNf92lEAJ5cbVvvmGFmAsU75bw3RSC4olJ/AvSFL/dLY93lwzue7pTe6Fjc5KalJZUZ38DdA4tjUppvBvHNjgnnxDadHxDE37JVojKqrH2ifP36ODTZ0S6r4eXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726754650; c=relaxed/simple;
	bh=JbCykuO6u4vJ7p18eSR0Qpq0Y5JftAjdVM8Uovg9S+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4NGpXGMUQeRw7FNx/1oSfQ+3kjmQDlP/S0V8s4VqZh1CAGl9EDf46gSRf1x2RcFgCKSvtl3WS/dyrlH4orZB+r6+Sw+siFAR8EixIvwG71at5UTeSc+GXxK5jxeaPK4T7eer9h8D+ostVOol8I+SVt6EW87H9hU135a5zp8FbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Arl24N4M; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f752d9ab62so9010291fa.3;
        Thu, 19 Sep 2024 07:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726754647; x=1727359447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eaMKXN8S5mdEgXcU+DcNkbVwT8O5pkxCLbzD3WHX46o=;
        b=Arl24N4MxaSSmwreg+2M1zUmj0lHz0P/X617McUIfLWubjiTwi2w2sjW9exKFosPnl
         H64VHHyAQMxD4I+EVCXGWz0GHCmb5l+XejomU0lPd3AYde/Ymo8phPMiI35N7kUUCghx
         04sd5mzs2e9I4njOWKxBCQvAbgZxi6oRXEp9YZa/Pe3+XF7fQ3PKn/U9DJpg8ObwBPW0
         LiA85svxdMJnQEuFvipkWntdBjpwM6bwQz19YvqQs9UAjomatAngMjYvrN/nZon0F7pP
         UA0Cd+mscVTZRfpbNYZZ30pbvsY+Vhq7h3gxUypaW4RxpxXblp0UHlqUVSuP4dc63Xfi
         rPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726754647; x=1727359447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eaMKXN8S5mdEgXcU+DcNkbVwT8O5pkxCLbzD3WHX46o=;
        b=FpKRgmrAA3YJ+Ni9lB3QlIS3SgIwupXGtmgwNf/4jJeFM3xOryLY/pKr7knRSmzzpd
         +HmfnuOsCJK9qqWOA7O2534bC+hTWuosKJ9fzAme9PPcsJPnPaD/MM9VigBZfYZK+z1m
         KQA2QKLH+kr1HES7irL2bqcWEF1n+RUh80X2+Ec6zAvtKcfIg0qz8/1vgxe6pzIPvByn
         q+gx1exd0cvAWV6ThqC3HPq7Bgr2rs4KwmBe2IMrTtBdRUlOLLGG0devaPGaVxr87cxR
         vdcZtPRFUolkfz157jAmLsksMJK6NIkCVOdKogVq6udJF4bQYWjgH2h1z9ab3POli6z1
         Cebw==
X-Forwarded-Encrypted: i=1; AJvYcCU/aNWus1VewOrWBZ00veqd0nuEQ6XttAG1LkJL6NRaYMIBwWB7ghhalygUVRXqCFPc0kSojaEBcxkQVsnt@vger.kernel.org, AJvYcCUgT4PZJGw4OWhJCCu7Mn+FXtbgpnh2xyI/FgtlI7EKl4l884OvlrdB4xPM752g5dCn5t9Gg36wD8c=@vger.kernel.org, AJvYcCXAvUHMmA6hu+ouGGBSOXFiYhXF+JNsSdQ19M8RK/zvRRPZGDi7b8q7np3+ExA6nIBnXPKdlFAngUwb4eal@vger.kernel.org
X-Gm-Message-State: AOJu0YzwDna1R7HtcN6B50KvezeFlyXrpKOMKje8UZfPgjrr2AY/OK96
	0gtUfxW3APnfoIPzuOVDWgJOTQvNV4UUfiX373WU5cjCJtMWIgpueZ/HaA==
X-Google-Smtp-Source: AGHT+IGDuYOPk1ULsZO8+xgTnGrHWCVFUW6m4V3dBHVAZRbWSxKIMfeydVFsFfLwTOVGQtt2SFhfYQ==
X-Received: by 2002:a05:651c:154a:b0:2ef:1b1f:4b4f with SMTP id 38308e7fff4ca-2f791a5845amr111022471fa.34.1726754646680;
        Thu, 19 Sep 2024 07:04:06 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f79d3018bfsm16395391fa.50.2024.09.19.07.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 07:04:05 -0700 (PDT)
Date: Thu, 19 Sep 2024 17:04:01 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Ferry Toth <ftoth@exalondelft.nl>, Ferry Toth <fntoth@gmail.com>
Cc: Ferry Toth <ftoth@exalondelft.nl>, Viresh Kumar <vireshk@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4 1/6] dmaengine: dw: Add peripheral bus width
 verification
Message-ID: <s35lzbqfogeaoog4yhqki2b6hkpuepkhd6w5ln7w3e2y5h6uzy@5qdy4tpi4evb>
References: <20240802075100.6475-1-fancer.lancer@gmail.com>
 <20240802075100.6475-2-fancer.lancer@gmail.com>
 <ZuXgI-VcHpMgbZ91@black.fi.intel.com>
 <wghwkx6xbkwxff5wbi2erdl2z3fmjdl54qqb3rfty7oiabvk7h@3vpzlkjataor>
 <ZugZ9NcnPMNTH_ZQ@smile.fi.intel.com>
 <ZugaZbSIFqUujD5r@smile.fi.intel.com>
 <ZugdQyQNhxzaDZpV@smile.fi.intel.com>
 <ZugotKRM7_zIoMKI@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZugotKRM7_zIoMKI@smile.fi.intel.com>

Hi Andy, Ferry

On Mon, Sep 16, 2024 at 03:46:44PM +0300, Andy Shevchenko wrote:
> On Mon, Sep 16, 2024 at 02:57:56PM +0300, Andy Shevchenko wrote:
> > On Mon, Sep 16, 2024 at 02:45:41PM +0300, Andy Shevchenko wrote:
> 
> ...
> 
> > Okay that was the theory, now I made a hack patch, i.e. supply 0 in acpi.c in
> > the filter function and everything starts to work. So, my theory is correct.
> 
> FWIW, I have reapplied the whole series and it seems fine, so the only regression
> is that I described in the previous replies.

Just submitted a fix of the issue based on the Andy' and my problem
investigation. You've been Cc'ed. Please test the patch out on your
hardware:
https://lore.kernel.org/dmaengine/20240919135854.16124-1-fancer.lancer@gmail.com

Hope it works.

-Serge(y)

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

