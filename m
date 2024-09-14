Return-Path: <dmaengine+bounces-3159-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCAD97931D
	for <lists+dmaengine@lfdr.de>; Sat, 14 Sep 2024 21:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 575EA1F2217B
	for <lists+dmaengine@lfdr.de>; Sat, 14 Sep 2024 19:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918A478276;
	Sat, 14 Sep 2024 19:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJEtLFcN"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4389BA49;
	Sat, 14 Sep 2024 19:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726340780; cv=none; b=jxolTjYWDvPL5k+18SNVHGfwnKcTZsyznuGkGzkBqoDTPszHZzDe2t/wpFBSXqWEBi96TOyg/mDPAg/jgoPBj2gDIgfSgivwLlMNYTksc2SffAmRqEDw00syClVSeMCLzXh1GhW1ouPj9z4e2DThMmpQ36n/yG3ngts8r3owOZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726340780; c=relaxed/simple;
	bh=CmPs93dkNOpUxrHVTG6C0mEVmM3qCYnJgM1VMOxxHlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLgpAvKwPdkP9qRZUN12eKiv+AQEhT6hgAG/miraSaW1JsThOw6jnHf51iB94b4WLjWmkIwMsvYpJrHvCIY7KYUVlrfEym/YjgYJoM/NFD0c372fIbDhjdn4ymI0Gd/1XLxC7+d7JSxDGo31W58uPXcsWAU1RHma0ivySPp+aLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJEtLFcN; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-374cacf18b1so1980207f8f.2;
        Sat, 14 Sep 2024 12:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726340777; x=1726945577; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LuNYzT43Vkmg8RXSZdViTvcj8HasFgQbtLREqQgw8Tw=;
        b=QJEtLFcNQYNgqpf09J1W4CdJW0TW+ER0c1KZZDIWeR7q4sxgVHOfZV2PB92JJvWqJw
         KNcAyJO0Zb8aFmC7+d7b0RDPyTcrSBDkenTgHpv0PwuOMmwjGFu+e70/rcOqvdxPpMbW
         o9D5vT9OOhBTxo8eBgM85qua/wTJmHPNQjk0Vf7jzwEy5K3iPAobPKP2HkeCnffuTkGp
         K0fcTKMj+cu1neMbnCkHV8XXmEus9clrCsUzti/zNoki/WHv4ziy8aIE1gKXqJKk0otZ
         5MoJy72EYUGXgpFqLOMTBFnrRSV338PkDvZiYLppN54K4soiKfKSyVlA4cVoYV8ZL1bd
         WATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726340777; x=1726945577;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LuNYzT43Vkmg8RXSZdViTvcj8HasFgQbtLREqQgw8Tw=;
        b=Zp8z69D8rpzEDwqYlrPaZDioJbJE8r3wFWPX0+pIFs+t/gp0qSsybQJWTa3Ce4Sstt
         Fv5TJNECmWDnjQgPtrMfIX7g1EIkFyhjhy7+PBm6r6ExTi7CMN2j/o82RaDhMa/E2Fqj
         ESdraExJa5Gq/4EZ2U/j6ScJMn0LsHLADJKEsG8Ax3ccQKIJdRkBE84oPcSxYCOb9UDE
         HuHfa4k9fA1C7A5OFjskqvqVjL9HxngWABEeQcwAHYAN9y899+ZIHaf3U54Vrtsc2xK0
         hzglJPGb14cJPJPDkcT0FNzykKzeWbRD7ELJSiyIaZijwuGLUUyPM/gG4ph8cMid3Fpi
         YkWA==
X-Forwarded-Encrypted: i=1; AJvYcCUL2J0tOVueB2GiyomAIfpMmWb+hTsWvOZn4zfqODr8Vv70t+OzyJzcM7kn1c7k0yamX3rmXogmiv6X1nlC@vger.kernel.org, AJvYcCVrwOmYuPGsUYRjX1o0RIorrhicEb5P3xdcOpWyo1ZUrt2C9o4mwi121yfopss/sSRGEiU/fh/feTXggVEY@vger.kernel.org, AJvYcCXVCyQ6BxLwz9EVQdeSFN6z5ECKh0d8jOwOSQ4TU21TggsLtuxlmBeX7N2slIQpafP5z20T2wlfQ/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9WO9bs0+97KxPHzw86iUznvvQ9k6q9F5PAV6yvehj06yDcaNK
	7YVdDV7xZx6HhS15OQUnPpD7B0j2Fxo13Y+2p7vAD3W5LUSnb4zM
X-Google-Smtp-Source: AGHT+IEoKZah9+MftPbBQW73l8XG1j93fsqlfYPRssafg2fQyBW8LdAoxhPgqdAJfc48CXHoj8GNlg==
X-Received: by 2002:a5d:4983:0:b0:368:7f4f:9ead with SMTP id ffacd0b85a97d-378c2cd546fmr6106937f8f.7.1726340776081;
        Sat, 14 Sep 2024 12:06:16 -0700 (PDT)
Received: from mobilestation ([5.227.29.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42da22b8b15sm27289315e9.4.2024.09.14.12.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 12:06:15 -0700 (PDT)
Date: Sat, 14 Sep 2024 22:06:13 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Ferry Toth <ftoth@exalondelft.nl>
Cc: Ferry Toth <ftoth@exalondelft.nl>, Viresh Kumar <vireshk@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4 0/6] dmaengine: dw: Fix src/dst addr width
 misconfig
Message-ID: <hp2n4efzoe5n5zvgaygv4pz4rwip2iwj5nwpaofdwgzv65735b@bp4hn4aqkwrk>
References: <20240802075100.6475-1-fancer.lancer@gmail.com>
 <CAHp75VcnfrOOC610JxAdTwJv8j1i_Abo72E0h1aqRbrYOWRrZw@mail.gmail.com>
 <rsy7z45nhl74nzvq5a2ij4eeqgzu3htje2xpparxgam7jowo6a@6l75wjh2dqll>
 <ZuXbCKUs1iOqFu51@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZuXbCKUs1iOqFu51@black.fi.intel.com>

Hi Andy

On Sat, Sep 14, 2024 at 09:50:48PM +0300, Andy Shevchenko wrote:
> On Mon, Aug 05, 2024 at 03:25:35PM +0300, Serge Semin wrote:
> > On Sat, Aug 03, 2024 at 09:29:54PM +0200, Andy Shevchenko wrote:
> > > On Fri, Aug 2, 2024 at 9:51 AM Serge Semin <fancer.lancer@gmail.com> wrote:
> > > >
> > > > The main goal of this series is to fix the data disappearance in case of
> > > > the DW UART handled by the DW AHB DMA engine. The problem happens on a
> > > > portion of the data received when the pre-initialized DEV_TO_MEM
> > > > DMA-transfer is paused and then disabled. The data just hangs up in the
> > > > DMA-engine FIFO and isn't flushed out to the memory on the DMA-channel
> > > > suspension (see the second commit log for details). On a way to find the
> > > > denoted problem fix it was discovered that the driver doesn't verify the
> > > > peripheral device address width specified by a client driver, which in its
> > > > turn if unsupported or undefined value passed may cause DMA-transfer being
> > > > misconfigured. It's fixed in the first patch of the series.
> > > >
> > > > In addition to that three cleanup patches follow the fixes described above
> > > > in order to make the DWC-engine configuration procedure more coherent.
> > > > First one simplifies the CTL_LO register setup methods. Second and third
> > > > patches simplify the max-burst calculation procedure and unify it with the
> > > > rest of the verification methods. Please see the patches log for more
> > > > details.
> > > >
> > > > Final patch is another cleanup which unifies the status variables naming
> > > > in the driver.
> > > 
> > > Acked-by: Andy Shevchenko <andy@kernel.org>
> > 
> > Awesome! Thanks.
> 
> Not really :-)
> This series broke iDMA32 + SPI PXA2xx on Intel Merrifield. 

Damn. Sorry to hear that.(

> I haven't
> had time to investigate further, but rolling back all patches helps.
> 
> +Cc: Ferry who might also test and maybe investigate as he reported the
> issue to me initially.

Ferry, could you please roll back the series patch-by-patch to find
out the particular commit to blame?

-Serge(y)

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
> 

