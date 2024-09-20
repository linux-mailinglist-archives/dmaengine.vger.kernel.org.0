Return-Path: <dmaengine+bounces-3195-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5451A97D3AE
	for <lists+dmaengine@lfdr.de>; Fri, 20 Sep 2024 11:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78A591C22631
	for <lists+dmaengine@lfdr.de>; Fri, 20 Sep 2024 09:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DB9757F3;
	Fri, 20 Sep 2024 09:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceKtXrCe"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAA0136658;
	Fri, 20 Sep 2024 09:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726824838; cv=none; b=r+fISoHhT9RCGRNKCmn2MrXVfHax7fT7iV7qaUuKNtDMaGPb4gVAqIaw4cegsEBWBRUhi/kkDRhwBUBpTe2F1agqlL8JRjyc7w7P2rEqOSbR4Tvajfb+36tuIxVb2Dm3/1F6f9bfPFxuSrVnpYhmUbqoRJB9o+kyWgHB5q81kNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726824838; c=relaxed/simple;
	bh=UFbl4cZt/wsuZP01cfVUbeRDzPjLazHarkFswDwq4PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgmOLf1tSG5ZWcABtKMUqmuwhlaclkKUI5sWYb8Saz/kf4rUQnKYM7rVRT4uicaRYG0Wqn4WeRExy3P72WpsNZlYyq8RL0yrkDE1Tiu1ACMt08ijhCLD+PVK5ND+W1YO+QZ6difmwm5GQPXbbsiFt/AaEzxjvd+aTME2cgNGMGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ceKtXrCe; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5356aa9a0afso3150427e87.2;
        Fri, 20 Sep 2024 02:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726824835; x=1727429635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zgzYQQIygAr6qxmvFaGpF3Ge/dSNGjAm5OZ5ZHk08eU=;
        b=ceKtXrCej9zCkpmrQ0IT6GxjcSU8zNiG+8mDWl0YiVyFB7wSrj+ZPWHM47DY2HRFqK
         ML8uV8MDQ1dUAKN6fmUgrqlV3+mcYoz+mjDvPwdx8kJFqMyVbnbnSuNMG1SbQBpbSGtp
         GZPRVEuhTrr+45SwDiikvfmnsmh2DwpIupwAfzGdtNHj90vRCP1XA3cc2Zs8D5PiAV4+
         KqcT2LV1lcp2d2nsn0YrVZfYh2/HT+wNkadirf/uvBDb7X8QD8sX7ULiXhlS0qA98MUG
         ch8BHCYSlEq6CWrx73YToza1vOAX7h7z1bfJ62v+S9FhqZGSO155gqTFapUSfLtKu8DX
         xwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726824835; x=1727429635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgzYQQIygAr6qxmvFaGpF3Ge/dSNGjAm5OZ5ZHk08eU=;
        b=cmH78Nu/YIQjmeY8auOYssKjnwaHdQCOCM89SiGNrll8zOiq8t7WX/Q0bPjzlxZdL7
         0AMo/xhHDOYh+Xfn2SaxL7mlw2GGxaRhX2+SlTAlXpbh7GK5UblhOmMyzNefM0RD6EBf
         LWChDe/adt3JWLsryPqfJiewcRUEJxbQUwC2aaesiYLZwWqL/++M61+nv/OtzZW8P4dv
         frolhk+L439qUW9Emuum4vhhjNJ8Wb27DjB7a969H8OOG2BKXa+zpF7ylPS20Zujiva2
         AULtc76h2DTcrsmZfSYgsDLCA+n86CipoHn+Nj9jjA99Y+0BNTlIoRfVo/PeZNvuTJYm
         9SgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4Rjc5TS/U+24oKJfqWzgx1W8vXMrAPdABS60dhSjrYp2+VflPUEAuotQbdXSuOxSu7AAoPU4F9iq8ENjq@vger.kernel.org, AJvYcCVV9XKXRpfbp6TniZN1vtAMyhXJXkHZqXD7mZmV2c/YdaTibEFF2O8XMuZyjp6S05rRyXAI/1YmRrf3blod@vger.kernel.org, AJvYcCWLiys0YZe1fJhhiW7z8Qc4CEJsgomhaSQLjuiAAHgbEuecbWAbk55fULESL+eZeDR6+WIF35dzAc8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi8Wf6NarMUBQLbIBzGdd4oC57ovz09cHI7+7k+vLM52lu380x
	0/4+1Kom77nDsLATS8jHJdmu75j+I2xXgLYp4dRHcZLMhA5Se1/u5EZR5w==
X-Google-Smtp-Source: AGHT+IEZw33lFEgDQbTs/1HGnrG9vMhwEkSnbqvhxO5oF309XqhOuIj8ZmqezF+isCotfBHS+GFgNQ==
X-Received: by 2002:a05:6512:33ca:b0:52e:936e:a237 with SMTP id 2adb3069b0e04-536ac2e5b7amr1513374e87.16.1726824834373;
        Fri, 20 Sep 2024 02:33:54 -0700 (PDT)
Received: from mobilestation ([93.157.254.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536a687cfc9sm519861e87.189.2024.09.20.02.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 02:33:53 -0700 (PDT)
Date: Fri, 20 Sep 2024 12:33:51 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Viresh Kumar <vireshk@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] dmaengine: dw: Fix sys freeze and XFER-bit set error
 for UARTs
Message-ID: <kpujn6pqnxerasd6zhkfgxrgyidb3tmxuoqgauheoosdhnwatr@spdtf46m7bnu>
References: <20240911184710.4207-1-fancer.lancer@gmail.com>
 <ZugsFPWRZQnH9RaS@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZugsFPWRZQnH9RaS@smile.fi.intel.com>

Hi Andy

On Mon, Sep 16, 2024 at 04:01:08PM +0300, Andy Shevchenko wrote:
> On Wed, Sep 11, 2024 at 09:46:08PM +0300, Serge Semin wrote:
> > The main goal of the series is to fix the DW DMAC driver to be working
> > better with the serial 8250 device driver implementation. In particular it
> > was discovered that there is a random system freeze (caused by a
> > deadlock) and an occasional "BUG: XFER bit set, but channel not idle"
> > error printed to the log when the DW APB UART interface is used in
> > conjunction with the DW DMA controller. Although I guess the problem can
> > be found for any 8250 device using DW DMAC for the Tx/Rx-transfers
> > execution. Anyway this short series contains two patches fixing these
> > bugs. Please see the respective patches log for details.
> > 
> > Link: https://lore.kernel.org/dmaengine/20240802080756.7415-1-fancer.lancer@gmail.com/
> > Changelog RFC:
> > - Add a new patch:
> >   [PATCH 2/2] dmaengine: dw: Fix XFER bit set, but channel not idle error
> >   fixing the "XFER bit set, but channel not idle" error.
> > - Instead of just dropping the dwc_scan_descriptors() method invocation
> >   calculate the residue in the Tx-status getter.
> 

> FWIW, this series does not regress on Intel Merrifield (SPI case),
> Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 

Great! Thanks.

> P.S.
> However it might need an additional tests for the DW UART based platforms.
> Cc'ed to Hans just in case (it might that he can add this to his repo for
> testing on Bay Trail and Cherry Trail that may have use of DW UART for BT
> operations).

It's not enough though. The DW UART controller must be connected to
the DW DMAC handshaking interface on the platform. The kernel must be
properly setup for that too. In that case the test would be done on
a proper target. Do the Bay Trail and Cherry Trail chips support such
HW-setup? If so the additional test would be very welcome.

Sometime ago you said that you seemed to meet a similar issue on older
machines:
https://lore.kernel.org/dmaengine/CAHp75VdXqS6xqdsQCyhaMNLvzwkFn9HU8k9SLcT=KSwF9QPN4Q@mail.gmail.com/
If it's still possible could you please perform at least some smoke
test on those devices?

In case of my device this series and a previous one
https://lore.kernel.org/dmaengine/20240802075100.6475-1-fancer.lancer@gmail.com/
fixed all the critical issues for the DW UART + DW DMAC buddies:
1. Sudden data disappearing at the tail of the transfers (previous
patch set).
2. Random system freeze (this patch set).

There is another problem caused by the too slow coherent memory IO on
my device. Due to that the data gets to be copied too slow in the
__dma_rx_complete()->tty_insert_flip_string() call. As a result a fast
incoming traffic overflows the DW UART inbound FIFO. But that can be
worked around by decreasing the Rx DMA-buffer size. (There are some
more generic fixes possible, but they haven't shown to be as effective
as the buffer size reduction.)

-Serge(y)

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
> 

