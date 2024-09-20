Return-Path: <dmaengine+bounces-3197-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9057B97D728
	for <lists+dmaengine@lfdr.de>; Fri, 20 Sep 2024 16:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 538E828799D
	for <lists+dmaengine@lfdr.de>; Fri, 20 Sep 2024 14:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7A617C21C;
	Fri, 20 Sep 2024 14:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRJyeB0F"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D0679C0;
	Fri, 20 Sep 2024 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726844191; cv=none; b=p9xmDmJYez6RHlim4GENTwT4ZFNOipwoWncQLausWipJPE9kKYkPh9rgBrctv3uyj8TgQ9pgj6uRFepblTW60hoSO0/vm0uV5y4NPWLwBsExrbzBVfk/ONBaPrv0ldhISL6jHZKDaZpMeAmA4/70ZHp2R5D9ZzNOteMe5TX5p7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726844191; c=relaxed/simple;
	bh=nAwIst1FqVNp0n8NkCbxv3NMglRg6tFVzk56NQ8RaY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0XlVLTQzNDVYRihYnc5anIItLOFHmSV6VFxxo1/90QR8i4BMqCj/DVNTuPVM7R1ZSZiwrtQ7hlb5BhjrQkf0V5CK00xQO81qyFiJTSFNio3r9R5aG0a9QWZmWAjRUHMHH7R6tPFfveEF5pRwruWBXTqCeBIx9FnDqh5SAHXSsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRJyeB0F; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5366fd6fdf1so2577482e87.0;
        Fri, 20 Sep 2024 07:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726844188; x=1727448988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=emJoM9U+GKECg0xUETh97PyhRRrj7p7mKcHXD32vXKQ=;
        b=KRJyeB0FX+UYTdJlRdgUshAXdmpBYVy3R8RHOpsuPu+09YRDJNUVrrXvOhp3vJedaV
         qB5ybyAR0dTP9C977rQJ+vc//07dvisezkNbG4BhRdwvOMTyyGZtDMYSEUuRmO9QwBpo
         Tsia0ixZ67P6uShuNm8rLwYC7qOFtWrP87uyfDBSI36hIJiFTPJo8aiUvwxH/uBDfvzO
         0x+vSDIe6YP8Mi7wDWLWHGn9T70JuoDzJn6G4e7w9B5wIRyfW6+s2gGy+EpvHFKMN1bd
         UctgakYqA1VM583HL2a/v+rspWpiMmj3CIuUC5VqjkQZy3dlJcBpZNZDmqLGApBLb6E4
         mb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726844188; x=1727448988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emJoM9U+GKECg0xUETh97PyhRRrj7p7mKcHXD32vXKQ=;
        b=JlV8w1PMSMpk8VJ6Qs9uxHVQ5yNpTDD17FwAnOYVYtHNyhgZU0/4dEsLDnGlqvVHJQ
         wGuC2/TJ8qcGCFl0wVYmvowJd0xB7lOC2CbKl17MRpKSTibi6ebQHdXhv9O3EO/PeFsD
         BdawPB2FoOvkehOmIyd5f+JU18eUghsZ1+KA0qAK2LiLmUAJ39d9FhE4ZxCoKzDKzq/d
         /Zk5bQv75rF6ErrKwk5EgZOw9rKARnm11quh8cg9Q7/LwPqcWc6Kp01vaBihwB6eJyWt
         TzaXKMmKZ8SuaWbSO8HJsLtgOKe2w3xeG/m8ID/hbMJrp1f+RuwhZzcaIrNS/zJKZmyF
         ow3w==
X-Forwarded-Encrypted: i=1; AJvYcCV1W5MDTqFF/tYjj9rJ3cVL5TNlp9Bz3NmLwXdf3BNlmMig89uh8UMXDWcAacgqZnBxv/Gj3ULXuJ8=@vger.kernel.org, AJvYcCXRXzsfA8Xvbnor3kleVACaRUT07xerLQu0Ot7yqKkudhxv/1FfFuFemK4wOKPt/32ZVnclpRQ1iotsUEQ4@vger.kernel.org, AJvYcCXYl90OGbVBOvrUYuV4YMsWtUiCOPXhemj5AbaouMRx7nEzO477J3hifXRj6rBcIpz9DQ1ap3bp2Vh2sXl/@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgy1tzj0yWpRPUYuXpZT50Sg4qzEUUb6GQxMqxAG9CSLqCBlAu
	J6KRSU4Nr3HfLxGAUb26WcvkdsiFzReA+5uwuZkDSw+P1LrHyCoa
X-Google-Smtp-Source: AGHT+IEi4kM0xge4IWO1VQHG4RPXSxai4omuIUiBkbn08Jun+nhFwyQ/xyBM6aSKKi3nmAx5Zl6iXQ==
X-Received: by 2002:a05:6512:31c3:b0:535:6892:3be6 with SMTP id 2adb3069b0e04-536ad3df1aamr2025591e87.54.1726844187593;
        Fri, 20 Sep 2024 07:56:27 -0700 (PDT)
Received: from mobilestation ([93.157.254.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870a85fesm2186809e87.207.2024.09.20.07.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 07:56:25 -0700 (PDT)
Date: Fri, 20 Sep 2024 17:56:23 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Viresh Kumar <vireshk@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] dmaengine: dw: Fix sys freeze and XFER-bit set error
 for UARTs
Message-ID: <3zoeze233vpxoet2tpqayxq4z2covha2p5ymio5lxrbvmp54fs@lqo4ix3hr6gy>
References: <20240911184710.4207-1-fancer.lancer@gmail.com>
 <ZugsFPWRZQnH9RaS@smile.fi.intel.com>
 <kpujn6pqnxerasd6zhkfgxrgyidb3tmxuoqgauheoosdhnwatr@spdtf46m7bnu>
 <Zu2FpaBQymPJSAY-@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zu2FpaBQymPJSAY-@smile.fi.intel.com>

On Fri, Sep 20, 2024 at 05:24:37PM +0300, Andy Shevchenko wrote:
> On Fri, Sep 20, 2024 at 12:33:51PM +0300, Serge Semin wrote:
> > On Mon, Sep 16, 2024 at 04:01:08PM +0300, Andy Shevchenko wrote:
> > > On Wed, Sep 11, 2024 at 09:46:08PM +0300, Serge Semin wrote:
> > > > The main goal of the series is to fix the DW DMAC driver to be working
> > > > better with the serial 8250 device driver implementation. In particular it
> > > > was discovered that there is a random system freeze (caused by a
> > > > deadlock) and an occasional "BUG: XFER bit set, but channel not idle"
> > > > error printed to the log when the DW APB UART interface is used in
> > > > conjunction with the DW DMA controller. Although I guess the problem can
> > > > be found for any 8250 device using DW DMAC for the Tx/Rx-transfers
> > > > execution. Anyway this short series contains two patches fixing these
> > > > bugs. Please see the respective patches log for details.
> > > > 
> > > > Link: https://lore.kernel.org/dmaengine/20240802080756.7415-1-fancer.lancer@gmail.com/
> > > > Changelog RFC:
> > > > - Add a new patch:
> > > >   [PATCH 2/2] dmaengine: dw: Fix XFER bit set, but channel not idle error
> > > >   fixing the "XFER bit set, but channel not idle" error.
> > > > - Instead of just dropping the dwc_scan_descriptors() method invocation
> > > >   calculate the residue in the Tx-status getter.
> > 
> > > FWIW, this series does not regress on Intel Merrifield (SPI case),
> > > Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Great! Thanks.
> > 
> > > P.S.
> > > However it might need an additional tests for the DW UART based platforms.
> > > Cc'ed to Hans just in case (it might that he can add this to his repo for
> > > testing on Bay Trail and Cherry Trail that may have use of DW UART for BT
> > > operations).
> > 
> > It's not enough though. The DW UART controller must be connected to
> > the DW DMAC handshaking interface on the platform. The kernel must be
> > properly setup for that too. In that case the test would be done on
> > a proper target. Do the Bay Trail and Cherry Trail chips support such
> > HW-setup? If so the additional test would be very welcome.
> 

> I'm not sure I understand what HW setup you mean.

I meant exactly what you explained in the next sentence - whether the
Bay Trail and Cherry Trail have the DW UART capable to work with the
DW DMAC.

> 
> Bay Trail and Cherry Trail uses a shared DW DMA controller with number of
> peripheral devices, HS UART (also DW) is one of them.

Ok. Thanks. Testing the patch set on these platforms make sense then,
but of course with the kernel configured to have the DW UART device
handling the in-/outbound traffic by the DW DMA controller.

> 
> > Sometime ago you said that you seemed to meet a similar issue on older
> > machines:
> > https://lore.kernel.org/dmaengine/CAHp75VdXqS6xqdsQCyhaMNLvzwkFn9HU8k9SLcT=KSwF9QPN4Q@mail.gmail.com/
> > If it's still possible could you please perform at least some smoke
> > test on those devices?
> 
> That mainly was exactly about Bay Trail and Cherry Trail machines
> (and may be Broadwell and Haswell, but the latter two is not so
>  distributed nowadays).
> 
> > In case of my device this series and a previous one
> > https://lore.kernel.org/dmaengine/20240802075100.6475-1-fancer.lancer@gmail.com/
> > fixed all the critical issues for the DW UART + DW DMAC buddies:
> > 1. Sudden data disappearing at the tail of the transfers (previous
> > patch set).
> > 2. Random system freeze (this patch set).
> > 
> > There is another problem caused by the too slow coherent memory IO on
> > my device. Due to that the data gets to be copied too slow in the
> > __dma_rx_complete()->tty_insert_flip_string() call. As a result a fast
> > incoming traffic overflows the DW UART inbound FIFO. But that can be
> > worked around by decreasing the Rx DMA-buffer size. (There are some
> > more generic fixes possible, but they haven't shown to be as effective
> > as the buffer size reduction.)
> 

> This sounds like a specific quirk for a specific platform. In case you
> are going to address that make sure it does not come to be generic.

Of course reducing the buffer size is the platform-specific quirk.

A more generic fix could be to convert the DMA-buffer to being
allocated from the DMA-noncoherent memory _if_ the DMA performed by
the DW DMA-device is non-coherent anyway. In that case the
DMA-coherent memory buffer is normally allocated from the
non-cacheable memory pool, access to which is very-very slow even on
the Intel/AMD devices.  So using the cacheable buffer for DMA, then
manually invalidating the cache for it before DMA IOs and prefetching
the data afterwards seemed as a more universal solution. But my tests
showed that such approach doesn't fully solve the problem on my
device. That said that approach permitted to execute data-safe UART
transfers for up to 460Kbit/s, meanwhile just reducing the buffer from
16K to 512b - for up to 2.0Mbaud/s. It's still not enough since the
device is capable to work on the speed 3Mbit/s, but it's better than
460Kbaud/s.

-Serge(y)

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

