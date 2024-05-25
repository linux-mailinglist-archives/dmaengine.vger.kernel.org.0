Return-Path: <dmaengine+bounces-2174-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3A48CEF8F
	for <lists+dmaengine@lfdr.de>; Sat, 25 May 2024 16:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 171B11F211FB
	for <lists+dmaengine@lfdr.de>; Sat, 25 May 2024 14:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408C55A109;
	Sat, 25 May 2024 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYHCHhdH"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784EF3C08F;
	Sat, 25 May 2024 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716649107; cv=none; b=LmMW4YGIle2fmKPktOo18bmSYysxeqhbKzOQM/4tXcRn/h9lMnAp/JN/yRm+chczC70oNNHknsZwBKeZ7LImgtapnaXxeIFgjtDVu6J4uczHEzARxWBX8rOd8APJ7QqUJ8b6IMLweg2rtcVcpn579u1jBr9yhvhtRo8Fyf/Jzl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716649107; c=relaxed/simple;
	bh=y07DZNM/QDvEedbvvJlMHk1r5ZGYfBSPPra93Momo0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hf0NAVTIQXXOXke/PmX5TA52y4qi+WoHmsDqGfw+tlx3D3WJr+a+H5yww4KkiCTdHsPs+J3woNylMrZGFU9WRW9Qvae5m5MDbbo0hHBs9tDmyQ4PNbFj3J96Qus4lg9BT0b0CGYS1oMwzgTrLhGrwGZnFh+T252Ufz/QddcTELY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYHCHhdH; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6265d3ccf7so213646766b.0;
        Sat, 25 May 2024 07:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716649104; x=1717253904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5jpB4fiszoJDHewi5PTIYyY+d12c+mT7kvwJL6peD4=;
        b=lYHCHhdHjptz2Pc2o7mb410suBMyeW0+9S+RyYL1FOsREfiM6PGTQOqTqFNGdeYK8K
         RBamUhTl1vUFDcS+OfUq7Zjnna0pLlflI2k7O4lOhrSApQufLKW5r9hxW0PzoOovx/a1
         +9IIBSXmON3dWKh0/gZPDNGeq2d6EGJQjlDT4K2PACPvvYC1pv2i9XiDjOIw+/F4actN
         E/Ie250Egt/bm3is1wuPlxkjygkIrtO8U2iq/UqhYRv/aKW7kVPQjZpJ/rTGOA43I3mA
         W8cdOCpUGQ+jba0MLV5BwNQF91FCvMgieNjTA1WvX7EhdrTTnweZivwZLKlwF1Urw1mD
         1Sug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716649104; x=1717253904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5jpB4fiszoJDHewi5PTIYyY+d12c+mT7kvwJL6peD4=;
        b=KR+OWcMcduVaNxHyDAYZxTGIwqH+mTI8iZZTUKA7f7jKa2C6gys+JKZeqygr/d4spY
         aEVTlAv/mUPcppN11YAhEE9nLT3Z87Ww2V/G6OO94sadjNHRLINC8f+I6r74jQMX8Hp4
         sNuo+BzOh/pFD1eKrZmkKsszodOVLWUdLhH7eQ1SCScqozF0NoTrIZkKuJepC12mXnZe
         PiJ2WkgZFVKD5Eam6XWLmL1GjF7Shgk1tgmIidOTppoLxo+0ezmMkiif0K/rERPb37fB
         CfVXCy3TX27/3ewFnYr9rRQdTTJAmvSKsAQQ+gDY+eEX2VCFe7T24w8XO3umN7LCgaDm
         F8xw==
X-Forwarded-Encrypted: i=1; AJvYcCVBJ6WupDySnqFFqDP7xL7D0uhtZeaN3s5DMfLI80vnCrqicKN0GJC80Br9s87eky+vWT24g3273BwSLYG9UaCBiGmr9CtNYa6x5fhvg6dgEMDHz5kI1Tpc2xkbJ3/WTWUlxdg+YXMv
X-Gm-Message-State: AOJu0YybB6zHMXCeIxbLNnbhEVTbSTDP/CSt3gxDsd4zhclMeav2BbM5
	SdDM7DLdi8g23iDnq4JkV9u8M3Sft0XcfYVFpmDBchd4rCAT5KsGbiJZRcYzjw9EV7bEQI6aabG
	4ksTGQShsCuUB178ibkh68BnF9HU=
X-Google-Smtp-Source: AGHT+IFl9IYSmRIHAQ2JRUkfyUpWDshgscT9Icfine2tPalV0L8rIirAWlBF7oh28M86LpzfGNLAXACOy6Dx5O1utkY=
X-Received: by 2002:a17:906:e84:b0:a62:404a:d0d0 with SMTP id
 a640c23a62f3a-a62643e458cmr329166366b.42.1716649103717; Sat, 25 May 2024
 07:58:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524-ioatdma-fixes-v1-0-b785f1f7accc@yadro.com> <20240524-ioatdma-fixes-v1-3-b785f1f7accc@yadro.com>
In-Reply-To: <20240524-ioatdma-fixes-v1-3-b785f1f7accc@yadro.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 25 May 2024 17:57:47 +0300
Message-ID: <CAHp75VePTCdWTSSH_Hdmn4nDX3LWRMvsQsfSHUrgJA2r1Qhf_Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] dmaengine: ioatdma: Fix kmemleak in ioat_pci_probe()
To: n.shubin@yadro.com
Cc: Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Logan Gunthorpe <logang@deltatee.com>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 1:24=E2=80=AFPM Nikita Shubin via B4 Relay
<devnull+n.shubin.yadro.com@kernel.org> wrote:
>
> From: Nikita Shubin <n.shubin@yadro.com>
>
> If probing fails we end up with leaking ioatdma_device and each
> allocated channel.
>
> Following kmemleak is easy to be reproduced by injecting error in

easy to reproduce

an error

> ioat_alloc_chan_resources() when doing ioat_dma_self_test().
>
> unreferenced object 0xffff888014ad5800 (size 1024):
>   comm "modprobe", pid 73, jiffies 4294681749
>   hex dump (first 32 bytes):
>     00 10 00 13 80 88 ff ff 00 c0 3f 00 00 c9 ff ff  ..........?.....
>     00 ce 76 13 80 88 ff ff 00 00 00 00 00 00 00 00  ..v.............
>   backtrace (crc 1f353f55):
>     [<ffffffff827692ca>] kmemleak_alloc+0x4a/0x80
>     [<ffffffff81430600>] kmalloc_trace+0x270/0x2f0
>     [<ffffffffa000b7d1>] ioat_pci_probe+0xc1/0x1c0 [ioatdma]
>     [<ffffffff8199376a>] local_pci_probe+0x7a/0xe0
>     [<ffffffff81995189>] pci_call_probe+0xd9/0x2c0
>     [<ffffffff81995975>] pci_device_probe+0xa5/0x170
>     [<ffffffff81f5f89b>] really_probe+0x14b/0x510
>     [<ffffffff81f5fd4a>] __driver_probe_device+0xda/0x1f0
>     [<ffffffff81f5febf>] driver_probe_device+0x4f/0x120
>     [<ffffffff81f6028a>] __driver_attach+0x14a/0x2b0
>     [<ffffffff81f5c56c>] bus_for_each_dev+0xec/0x160
>     [<ffffffff81f5ee1b>] driver_attach+0x2b/0x40
>     [<ffffffff81f5e0d3>] bus_add_driver+0x1a3/0x300
>     [<ffffffff81f61db3>] driver_register+0xa3/0x1d0
>     [<ffffffff8199325b>] __pci_register_driver+0xeb/0x100
>     [<ffffffffa003009c>] 0xffffffffa003009c
>
> repeated for each ioatdma channel:
>
> unreferenced object 0xffff8880148e5c00 (size 512):
>   comm "modprobe", pid 73, jiffies 4294681751
>   hex dump (first 32 bytes):
>     40 58 ad 14 80 88 ff ff 00 00 00 00 00 00 00 00  @X..............
>     01 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc fbc62789):
>     [<ffffffff827692ca>] kmemleak_alloc+0x4a/0x80
>     [<ffffffff81430600>] kmalloc_trace+0x270/0x2f0
>     [<ffffffffa0009641>] ioat_enumerate_channels+0x101/0x2d0 [ioatdma]
>     [<ffffffffa000b266>] ioat3_dma_probe+0x4d6/0x970 [ioatdma]
>     [<ffffffffa000b891>] ioat_pci_probe+0x181/0x1c0 [ioatdma]
>     [<ffffffff8199376a>] local_pci_probe+0x7a/0xe0
>     [<ffffffff81995189>] pci_call_probe+0xd9/0x2c0
>     [<ffffffff81995975>] pci_device_probe+0xa5/0x170
>     [<ffffffff81f5f89b>] really_probe+0x14b/0x510
>     [<ffffffff81f5fd4a>] __driver_probe_device+0xda/0x1f0
>     [<ffffffff81f5febf>] driver_probe_device+0x4f/0x120
>     [<ffffffff81f6028a>] __driver_attach+0x14a/0x2b0
>     [<ffffffff81f5c56c>] bus_for_each_dev+0xec/0x160
>     [<ffffffff81f5ee1b>] driver_attach+0x2b/0x40
>     [<ffffffff81f5e0d3>] bus_add_driver+0x1a3/0x300
>     [<ffffffff81f61db3>] driver_register+0xa3/0x1d0

Please, read
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#back=
traces-in-commit-messages
and follow the advice given there.

...

> +       int err, i;

Why signed?

--=20
With Best Regards,
Andy Shevchenko

