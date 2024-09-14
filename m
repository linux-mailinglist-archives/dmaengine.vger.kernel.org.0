Return-Path: <dmaengine+bounces-3160-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF9397931F
	for <lists+dmaengine@lfdr.de>; Sat, 14 Sep 2024 21:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85D371C20F8E
	for <lists+dmaengine@lfdr.de>; Sat, 14 Sep 2024 19:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B857878C7E;
	Sat, 14 Sep 2024 19:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGOHQLpk"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1D054767;
	Sat, 14 Sep 2024 19:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726340919; cv=none; b=AxZraVIhkVOHXFoakhCIVVAgBazwkj9EH1nn0BR21+NxzfQ+WTz9REGwaKNoMMyfwuEIu6qZZkqzCc92YuZ+oTcINOeuVGd68TdE2TjvV4mFkW5bDF8dIRPEs/OLmilVFvQvhW+jjCqxbRGjSbZCFgy2GLLvkdKJ2YXXkz6guZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726340919; c=relaxed/simple;
	bh=9ohf7Z7sefkcndjhU8HAC56rRFHPdng3K1pRkVM+QEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHWDeB7sRpBBTmmeh2/rabF3H2gQnEuDUnLofgyyJUUWML67BDHpS4XlQS+gW6tSnpZBnYYkqkHrh+/kUbguVWNKgAvrVNOehgnMro6+TKJrzs/westYsXQSlxZjuWad8A/+kzXIDRr/gTrrnqrRuDbM//XpsCiOQy8JInDtg8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGOHQLpk; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cba0dc922so25212345e9.3;
        Sat, 14 Sep 2024 12:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726340916; x=1726945716; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GIb7wWomHE6G9cZ51iPDSEoQc1TA9FQ16n5axiQdFKM=;
        b=NGOHQLpkuD3KOV+DrtZnvV1eBfo0vqusXDP86FhuIJmz8Tzw1QIVxgb+MYZQBlYLbw
         pWDSF/crv62XMWmR2b+0IxN5yTU7C1N5c/9HuyoVydcABEn5/JiEXRw3yN7C2TRSkjcd
         +PZ6bmOH7RJQOorXsqC7OQiYaD+PCTevaKnDyHjjef5Vb3QWg3c37m6STy093ZIRuCLj
         MfpPv2g2Ls8JNLb1MCbSyqgmShONdHLIQhoR70Yba8INOmaO6xnz8WM4TSTnu25d1RRK
         EaRKP+bVMC7rFNTfAN0rXwhQDej/OY6Eh+ZP95b1QJcWCH04VoTOPPV8iUHwSYrXGEuz
         z57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726340916; x=1726945716;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GIb7wWomHE6G9cZ51iPDSEoQc1TA9FQ16n5axiQdFKM=;
        b=VZ/kALEUiOc5QAC/h+tqcCEar2C+iGQHv4mudZ2pWb6ik9lT9mEpyFmK8SA1nBxPll
         lIUcztxgRMXCp7bmXREewuH2DanMxkmQaFQPzTFrBjOdCf6sJ24lm28lqCTxs/Swzvjq
         0nwRgSa5+R81QB14w+lKHl15lt1U/xXuvzX53jIEviVXU6axWiZgFNqUdLptqccXn4ef
         7WujfxTBsdot9Eq1V+SFgcy/R0tRSO9Zfrkw0TJQoWbFyd0ZCm3LW2vBqUsFg8owDC0G
         3FYm4b8mRPhiV9ysm4ie+pdgp5aQ1Kv/yc80xoqoc6xd99x2sjyEDbi/832wF6OuRdIC
         vmSw==
X-Forwarded-Encrypted: i=1; AJvYcCV2u6bVvarNUW1UeeMx/ex92E6Wvj3v5km13AS+cz0ryqGI++AR5zkmsDbqmV5gX9qPrH9maiMCajyD6Bzu@vger.kernel.org, AJvYcCVLySoE8cJzqoVzr4LbMF9Pfx41bQNsBYJkJ8VBa0MBkKfZ880CrEmz2+TxHrkZ5IG9+zGdqYxJvf8=@vger.kernel.org, AJvYcCWccjali+5N4fBrPQWj8ZXeuReP5JexizgAzdGlXowsgiSELHpCoVZT2Cl3MshXpjEsXsKQmgrjTAzrR9FH@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu0LhBJC0qL/rrVmR+vbjgfmApv9LRkox0AmO8BcMqu850YJ9M
	R8cwtKCzTP+BSGavHRIPtjfLy9l24oNxkMFcNl9zNx4bvxXeaG9F
X-Google-Smtp-Source: AGHT+IH6VW6f/Z96/dPyfgSGcCElAnhPjUS8VF5Bi51hqLXgmCqKbO/fYnIJkpoAkeGIw36ib5ICRA==
X-Received: by 2002:a05:600c:5253:b0:428:1e8c:ff75 with SMTP id 5b1f17b1804b1-42cdb5783cemr66953545e9.35.1726340915905;
        Sat, 14 Sep 2024 12:08:35 -0700 (PDT)
Received: from mobilestation ([5.227.29.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42da22d8212sm27090305e9.14.2024.09.14.12.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 12:08:35 -0700 (PDT)
Date: Sat, 14 Sep 2024 22:08:33 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Ferry Toth <ftoth@exalondelft.nl>
Cc: Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4 0/6] dmaengine: dw: Fix src/dst addr width
 misconfig
Message-ID: <jsiriw6kumswijb6wxdcjqnq3tdu524hveh7dezqdzutduvt2d@5xcdjwd6aj3f>
References: <20240802075100.6475-1-fancer.lancer@gmail.com>
 <CAHp75VcnfrOOC610JxAdTwJv8j1i_Abo72E0h1aqRbrYOWRrZw@mail.gmail.com>
 <rsy7z45nhl74nzvq5a2ij4eeqgzu3htje2xpparxgam7jowo6a@6l75wjh2dqll>
 <ZuXbCKUs1iOqFu51@black.fi.intel.com>
 <hp2n4efzoe5n5zvgaygv4pz4rwip2iwj5nwpaofdwgzv65735b@bp4hn4aqkwrk>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <hp2n4efzoe5n5zvgaygv4pz4rwip2iwj5nwpaofdwgzv65735b@bp4hn4aqkwrk>

On Sat, Sep 14, 2024 at 10:06:16PM +0300, Serge Semin wrote:
> Hi Andy
> 
> On Sat, Sep 14, 2024 at 09:50:48PM +0300, Andy Shevchenko wrote:
> > On Mon, Aug 05, 2024 at 03:25:35PM +0300, Serge Semin wrote:
> > > On Sat, Aug 03, 2024 at 09:29:54PM +0200, Andy Shevchenko wrote:
> > > > On Fri, Aug 2, 2024 at 9:51 AM Serge Semin <fancer.lancer@gmail.com> wrote:
> > > > >
> > > > > The main goal of this series is to fix the data disappearance in case of
> > > > > the DW UART handled by the DW AHB DMA engine. The problem happens on a
> > > > > portion of the data received when the pre-initialized DEV_TO_MEM
> > > > > DMA-transfer is paused and then disabled. The data just hangs up in the
> > > > > DMA-engine FIFO and isn't flushed out to the memory on the DMA-channel
> > > > > suspension (see the second commit log for details). On a way to find the
> > > > > denoted problem fix it was discovered that the driver doesn't verify the
> > > > > peripheral device address width specified by a client driver, which in its
> > > > > turn if unsupported or undefined value passed may cause DMA-transfer being
> > > > > misconfigured. It's fixed in the first patch of the series.
> > > > >
> > > > > In addition to that three cleanup patches follow the fixes described above
> > > > > in order to make the DWC-engine configuration procedure more coherent.
> > > > > First one simplifies the CTL_LO register setup methods. Second and third
> > > > > patches simplify the max-burst calculation procedure and unify it with the
> > > > > rest of the verification methods. Please see the patches log for more
> > > > > details.
> > > > >
> > > > > Final patch is another cleanup which unifies the status variables naming
> > > > > in the driver.
> > > > 
> > > > Acked-by: Andy Shevchenko <andy@kernel.org>
> > > 
> > > Awesome! Thanks.
> > 
> > Not really :-)
> > This series broke iDMA32 + SPI PXA2xx on Intel Merrifield. 
> 
> Damn. Sorry to hear that.(
> 
> > I haven't
> > had time to investigate further, but rolling back all patches helps.
> > 
> > +Cc: Ferry who might also test and maybe investigate as he reported the
> > issue to me initially.
> 
> Ferry, could you please roll back the series patch-by-patch to find
> out the particular commit to blame?

Plus to that it would be nice to have some log/info/details/etc about
what exactly is happening.

-Serge(y)

> 
> -Serge(y)
> 
> > 
> > -- 
> > With Best Regards,
> > Andy Shevchenko
> > 
> > 
> > 

