Return-Path: <dmaengine+bounces-3165-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C386979931
	for <lists+dmaengine@lfdr.de>; Sun, 15 Sep 2024 23:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 950031C21065
	for <lists+dmaengine@lfdr.de>; Sun, 15 Sep 2024 21:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C627E3C488;
	Sun, 15 Sep 2024 21:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSMmt6rx"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22D545007;
	Sun, 15 Sep 2024 21:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726436067; cv=none; b=SDLCbnYFLk1SCj2ijC8MZbQmOXs4MTObR6Qq9lsydpY7X+qTcE5ifieVly9fCdVEilZcRZMpKAhQf0oCGiYF6XMOpftbRWYBplHVmNceK25jpj2429E/N0IlAlYxNTcNFOVHz3VI7lbLfp/7N7YviF984x6N0c9AGeDhSZy6V+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726436067; c=relaxed/simple;
	bh=rOJ76WfIbDA0DYYgc87kBrKXHKwX2sCAia7OU6ePV1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhBFqX49x4/MGY0RJXglor+VCW7RCh525B/gCpm3zuZPNZ3POMSiqj6uXB1wPAHnki1O2SOSyC4sFSVhBFqIKFG45wu+cOja82GvlS4fCEWXXmWpM/Kb2Byi/CUcGl4OpUQH/BKrNH+ExBfrjokqE82xPBC/B85SquKg1SeYAEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSMmt6rx; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f75b13c2a8so42095151fa.3;
        Sun, 15 Sep 2024 14:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726436063; x=1727040863; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hzKaPg24dkMcNByqeKWtBck9nkaK/5xO4axudwUtPbs=;
        b=KSMmt6rxaTgJXqG//ogUDKmwCl/t2t+Gm7mm5BuTCgROO0/2A4mgmihLSnaMAqe1os
         lXU6f+2r8TmK09U6R32A0HNenJxfYvolG/f5ZrWXHVRWM3s1NpRhkzpp9FKUffPlGuiN
         JwH0kzsc+LdUMIkkUz3DI9aOzpUKX3MDZFD1FhgaVBcKeGn0RCXNcIHSdZg8m+GZ0PM/
         aeJGoLQtQg/E1kIwx+NQnDM3NbuYtHmJMKcZPtSQVwbRld7lul6IrvZ7oVFcuAXSlwDT
         zRBaGli1Q2l+tfRUCuLJgP7VHuK9003EisKjEz1Kjtc9I7x19GJObRZqpVwp9dcAUGI6
         4/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726436063; x=1727040863;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hzKaPg24dkMcNByqeKWtBck9nkaK/5xO4axudwUtPbs=;
        b=s/e3ebJ4aOvKQDFUvxl0vCwVyl6uuwcpO2nNA3og8GrtOgq5duA4eNFa51UsnpF0Ag
         eEX1iZrUgihMiOSGnzmIJsGXJrVcWbM9/XtG1vAEK73IAos5l5MhlqdJMKg/hjlka8yi
         D7Jh6XQWJLCxnuGqEC5MOI4ipvk+l9JGohguAdJofK6nQL9mhCn3qvLcorvKVR3CyGZM
         UJBs9KqPiziKhIPf82owzS7D8dhiSa0xh1lVyCIO+HJF0g3lObqU6XauPk0qajhq0dpK
         /DB3w26JygDaMFu/sVOwN1EVNVwe4RknRTDS820CQ0EDXfZbPPyl7Jr3FUCod5NppPNp
         LBWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1V1qAhQ3Hk02wEb3RVAJrfPzZWNaDJAHxyNuueZZ6U4RByIKsyP/QNoNBDxaMlOtr7gZMCaDFLVo=@vger.kernel.org, AJvYcCWnwP/DKRMLlhPhjEdPlGmB5NaWnlktHrOiUvYsnoaL7KZT5nMV2MTvzZXY+HcBJvhvyX4pfOpOPZGC5/ZR@vger.kernel.org, AJvYcCXTvc50gV5j4WSFgwBFAp2MPYTJHbSflMQMZQJrXQQyV+xoAWCTVC4ti6bnkgDIBKtuvnDmI0LaVS9Y+B6w@vger.kernel.org
X-Gm-Message-State: AOJu0YylQSHU55vim1r7gi1o3pOMaeSwNq8HJwqFGWik06Pw0oX5h7sr
	3vy0cy46IIYD5sHCP3faT5kEwQgwTl6olbqXpnBcIwjxH4Q/aaqErS3gCw==
X-Google-Smtp-Source: AGHT+IGiRYX6/oipf0GNDJKT8kg6glNTU2U/MXZN/ippopO7njKupSh2cDfW701eVR5b8fKg51Q0Xg==
X-Received: by 2002:a05:651c:506:b0:2f7:663c:48da with SMTP id 38308e7fff4ca-2f787f435b7mr65300551fa.42.1726436061862;
        Sun, 15 Sep 2024 14:34:21 -0700 (PDT)
Received: from mobilestation ([95.79.225.241])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f79d30130esm6283591fa.38.2024.09.15.14.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 14:34:21 -0700 (PDT)
Date: Mon, 16 Sep 2024 00:34:19 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Ferry Toth <ftoth@exalondelft.nl>, Viresh Kumar <vireshk@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4 0/6] dmaengine: dw: Fix src/dst addr width
 misconfig
Message-ID: <635sp3moq2csr34yeut5tedmehpr5brejed5hlrj25u63hg5tw@6v36r2emdt7d>
References: <20240802075100.6475-1-fancer.lancer@gmail.com>
 <CAHp75VcnfrOOC610JxAdTwJv8j1i_Abo72E0h1aqRbrYOWRrZw@mail.gmail.com>
 <rsy7z45nhl74nzvq5a2ij4eeqgzu3htje2xpparxgam7jowo6a@6l75wjh2dqll>
 <ZuXbCKUs1iOqFu51@black.fi.intel.com>
 <hp2n4efzoe5n5zvgaygv4pz4rwip2iwj5nwpaofdwgzv65735b@bp4hn4aqkwrk>
 <jsiriw6kumswijb6wxdcjqnq3tdu524hveh7dezqdzutduvt2d@5xcdjwd6aj3f>
 <CAHp75VfQP6Ta=TVLCCPyPxnVrh7jwmWPUTcOYaRf3kdVJPR_rA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VfQP6Ta=TVLCCPyPxnVrh7jwmWPUTcOYaRf3kdVJPR_rA@mail.gmail.com>

On Sun, Sep 15, 2024 at 02:43:19PM +0300, Andy Shevchenko wrote:
> On Sat, Sep 14, 2024 at 10:08 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > On Sat, Sep 14, 2024 at 10:06:16PM +0300, Serge Semin wrote:
> > > Hi Andy
> > >
> > > On Sat, Sep 14, 2024 at 09:50:48PM +0300, Andy Shevchenko wrote:
> > > > On Mon, Aug 05, 2024 at 03:25:35PM +0300, Serge Semin wrote:
> > > > > On Sat, Aug 03, 2024 at 09:29:54PM +0200, Andy Shevchenko wrote:
> > > > > > On Fri, Aug 2, 2024 at 9:51 AM Serge Semin <fancer.lancer@gmail.com> wrote:
> > > > > > >
> > > > > > > The main goal of this series is to fix the data disappearance in case of
> > > > > > > the DW UART handled by the DW AHB DMA engine. The problem happens on a
> > > > > > > portion of the data received when the pre-initialized DEV_TO_MEM
> > > > > > > DMA-transfer is paused and then disabled. The data just hangs up in the
> > > > > > > DMA-engine FIFO and isn't flushed out to the memory on the DMA-channel
> > > > > > > suspension (see the second commit log for details). On a way to find the
> > > > > > > denoted problem fix it was discovered that the driver doesn't verify the
> > > > > > > peripheral device address width specified by a client driver, which in its
> > > > > > > turn if unsupported or undefined value passed may cause DMA-transfer being
> > > > > > > misconfigured. It's fixed in the first patch of the series.
> > > > > > >
> > > > > > > In addition to that three cleanup patches follow the fixes described above
> > > > > > > in order to make the DWC-engine configuration procedure more coherent.
> > > > > > > First one simplifies the CTL_LO register setup methods. Second and third
> > > > > > > patches simplify the max-burst calculation procedure and unify it with the
> > > > > > > rest of the verification methods. Please see the patches log for more
> > > > > > > details.
> > > > > > >
> > > > > > > Final patch is another cleanup which unifies the status variables naming
> > > > > > > in the driver.
> > > > > >
> > > > > > Acked-by: Andy Shevchenko <andy@kernel.org>
> > > > >
> > > > > Awesome! Thanks.
> > > >
> > > > Not really :-)
> > > > This series broke iDMA32 + SPI PXA2xx on Intel Merrifield.
> > >
> > > Damn. Sorry to hear that.(
> > >
> > > > I haven't
> > > > had time to investigate further, but rolling back all patches helps.
> > > >
> > > > +Cc: Ferry who might also test and maybe investigate as he reported the
> > > > issue to me initially.
> > >
> > > Ferry, could you please roll back the series patch-by-patch to find
> > > out the particular commit to blame?
> >
> > Plus to that it would be nice to have some log/info/details/etc about
> > what exactly is happening.
> 

> For me with patch
> 
> spitest -l -s1000000 -b128 /dev/spidev5.1
> SPI: [mode 0x20, bits_per_word 8, speed 1000000 Hz]
> [  164.525604] pxa2xx_spi_pci 0000:00:07.1: DMA slave config failed
> [  164.536105] pxa2xx_spi_pci 0000:00:07.1: failed to get DMA TX descriptor
> [  164.543213] spidev spi-SPT0001:00: SPI transfer failed: -16
> [  164.550140] spi_master spi5: failed to transfer one message from queue
> [  164.557126] spi_master spi5: noqueue transfer failed
> spitest: SPI transfer failed in iteration #0: Device or resource busy

Thanks for the log. As I suspected there is a safety-check failure,
which prevents the client driver from using the DMA-controller with
the specified transfer parameters.

It would be helpful if you find out which conditional statement in the
dwc_verify_p_buswidth(), dwc_verify_m_buswidth() methods cause the
failure. Also it would be useful to get the max_width, mem_width,
reg_width and reg_burst variables values.

-Serge(y)

> 
> Without
> 
> spitest -s 1000000 -b 128 -l /dev/spidev5.1
> SPI: [mode 0x20, bits_per_word 8, speed 1000000 Hz]
> SEND: [00000000] ff 97 d0 54 d5 69 85 6e ca e7 b3 e1 a1 e5 1a 9d
> ...
> RECV: [00000000] ff 97 d0 54 d5 69 85 6e ca e7 b3 e1 a1 e5 1a 9d
> ...
> 
> `spitest` is our internal tool, so what it does there is:
> 1) opens SPI device for speed 1MHz in loopback mode
> 2) generates 128 byte of random data
> 3) tries to send and receive them
> 4) compares
> 
> I believe the similar behaviour can be achieved with the one that is
> in the kernel tree.
> 
> -- 
> With Best Regards,
> Andy Shevchenko

