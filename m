Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00CF589363
	for <lists+dmaengine@lfdr.de>; Sun, 11 Aug 2019 21:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbfHKTus (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 11 Aug 2019 15:50:48 -0400
Received: from mout.gmx.net ([212.227.15.15]:35145 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfHKTus (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 11 Aug 2019 15:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565553020;
        bh=/l9xgJdATrfRjOi4+IR9VrotpqmGWD5Z3J7zZdEMGos=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=BGtN/+rCW2Qkj7QVzTKqjz/kb4szdqZcgihkHNKIa6UMyh4dZkMz1ntp8AJ732j9E
         n2N7S1ICaj7Ivwbp1iym08D7JtUQdeVwAp9XQElYRPCxXGjF/Nqtu0jIQqnlqr+G5v
         ACJHj/3vhid9+rMFHjcbgm57es2/b3RTRhJbcU68=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.106]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LpKrt-1iTCGX2paX-00f7df; Sun, 11
 Aug 2019 21:50:20 +0200
Subject: Re: [PATCH 00/10] Raspberry Pi SPI speedups
To:     Lukas Wunner <lukas@wunner.de>, Mark Brown <broonie@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, linux-spi@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Eric Anholt <eric@anholt.net>, Nuno Sa <nuno.sa@analog.com>,
        Martin Sperl <kernel@martin.sperl.org>,
        Noralf Tronnes <noralf@tronnes.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Florian Kauer <florian.kauer@koalo.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
References: <cover.1564825752.git.lukas@wunner.de>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <fc10f730-6916-7f24-3185-5bdb39a965c9@gmx.net>
Date:   Sun, 11 Aug 2019 21:50:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cover.1564825752.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:3CK50yV8jzQB85JkuX0VH/gz4hYHd66gPR6wK5JVFZaQMmaEvPD
 BKy8p1ynoJsEgMfT/q21ff1F317zTg+hNQdcocVANiU89x5ivV25eHXiZU9nIfAD+oCfklK
 vN5oUYlw6y1FLDMxaHXnoR/HhPMKCjPQ41cQocHIeHoNvW7awXSOX1BB0QHtul6mL9IHEvP
 TS2/LjLtyoRsqLdWXHt9A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yBVpSNGWGlM=:2+of0D0JPi5QmYjrq5E6Jq
 AscObkbHZhFm5nlOWg4MA/GLlTbyzKq4XyudIeUPDDCH8TmFdZo4ticc2JIqCUBDilv1mCh3D
 doHJv4ZvwnifE4rYenMLFga2awwADdWRJZdNpRyg39a2EFOg79ch1QoQWzEPpWmwWt3pWXma4
 vWEuwwdZ1g5VafQ7h6xkIZfZIA8zL95Ge9guqccw6Y3ovHiiacZfwgIO863Z8KiakyQY14WZX
 O5+v0/XjWTOGkb3Yi/rIEBAudE/z7S7KCYTGCIN7VJ9ZNeACRFrBi6M7a/3VopX83foBdfS4X
 foHxNqj0RbD3TWmUXLf3EhYBmYZkbEcAdyErxpaK+117bb4dtzB1L4LUFn5n/Kgu8vrhMxwdm
 cuoCkn/u+6htEJkny0ys9RB95bPkmcIO6MYG0itqaehSATUoOLWNu9UUy3PXN3OYbZjVezRYx
 KtlXiL+SnBLhx9eVLtdj5yZu7g/SCEIsh9OEqELGTtKz6jH2qQb7B6wrrGQpGrDedNxG72nHn
 zI1Vae9hYnuf04IOBzFayJOpEldupe1eCrM7UPKamPoNEuhN/Ih/Zbd03Lx+T3YMgAmd0TnzI
 Ym5SxcWNiyePyLrLUMW/msBm6LxMJsrzX/fRIUPXn2C8npDjt72pZHEU8SSu4fw3buqJprEaa
 HEmHxJZ0EFU+txzUDVXO6iijtPcUi5haJI7OF2qnHDNachGpykh/3p8AJ5jswdsaJBiJU8dcu
 ujITXiVaSiOB0caU3q4t8eXSqvFvtHzBFYBgrRqodkL1RNXKXhWZLYo8xQsHxYlBqNmqQV6WI
 hJcxKbyY+ZN6Y+kQm0s2SVVgk50KLZUlSjkSgBkiSH3CdK5YD+mQxJuTQJzyyBefABqGGKrmQ
 07VaQ+5dJfXxzd0btzk3gLH3Znm+vN2jR0o3RrIJdyL483b25DkYeEV1R0P8JQo76/e0FpKea
 Nb3FNPcKJyKcjugw6l9k5DAld2SgxN64AVVU7P90gqXb896tsQhqmJQQ39Sf+q0upYubeA06B
 JBgoJrB8SIf5QnFRyMfkyYgcIZV8CF6H+kwd1Dt0LyFLewk7LaoowpO7TqQ69HAC6GL3k2Cj0
 D12rUQWYOtcfu1nkuefcyjV8abfGeJLzieQLLoahzqLRu7SammW3XYV+GdY0wUIC07Ixw82h9
 XNgUw=
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Lukas,

Am 03.08.19 um 12:10 schrieb Lukas Wunner:
> So far the BCM2835 SPI driver cannot cope with TX-only and RX-only
> transfers (rx_buf or tx_buf is NULL) when using DMA:  It relies on
> the SPI core to convert them to full-duplex transfers by allocating
> and DMA-mapping a dummy rx_buf or tx_buf.  This costs performance.
>
> Resolve by pre-allocating reusable DMA descriptors which cyclically
> clear the RX FIFO (for TX-only transfers) or zero-fill the TX FIFO
> (for RX-only transfers).  Patch [07/10] provides some numbers for
> the achieved latency improvement and CPU time reduction with an
> SPI Ethernet controller.  SPI displays should see a similar speedup.
> I've also made an effort to reduce peripheral and memory bus accesses.

i know the BCM2711 / Raspberry Pi 4 isn't upstreamed yet, but this
series hasn't been tested with RPi 4?

I only want to know.

