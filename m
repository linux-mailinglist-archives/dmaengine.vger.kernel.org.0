Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7A994DD2
	for <lists+dmaengine@lfdr.de>; Mon, 19 Aug 2019 21:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbfHSTWx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Aug 2019 15:22:53 -0400
Received: from mout.gmx.net ([212.227.15.15]:43601 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728298AbfHSTWx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 19 Aug 2019 15:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566242547;
        bh=N9MF6iOURGarUJuhWGuXwJyw9uV5DgUhoaU/znm23z8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=InYxp/4yjITwJwpUomV+wUEi7TrM29FKnirF73SKOVa4L9oSvKqsqr91RkZYpBDhv
         NMTEjmx4rPJOhu5bxAAQ8KXDIu+RdSs4ChSGVy6Fr6jegnkjPTcx8tFLnCpkiGhzyv
         PmLDDNc7/B8/QFyTLsbo16DEpeMUHFxuG3do+WJU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.106]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MoO6M-1ib0eZ10um-00okv8; Mon, 19
 Aug 2019 21:22:27 +0200
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
Message-ID: <1d29e6a3-0528-2b4b-b8d3-c4bb11934661@gmx.net>
Date:   Mon, 19 Aug 2019 21:22:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cover.1564825752.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:6L5/aXuPy6H9hH8KU97jLb9pvpLYg9y1V3ADPQYxeWFDQMrybkM
 nmEYlnXPr+RZExKgrAvzFVJB9NlMANGygmcFVbTFae1Si3z7o+rPFYiJJn7O5w4qwNHTXGl
 3eLlaReMuokPHw3XdMvnpAFXFMtf64jCkRR8MKgfoKWjs2y7UuZa1LqGgNb6Zez9bJwO18H
 QPbrJkQybER12HvG7ePcA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZX4s/3I+ioE=:uouJgb2xChRLPpJ3OMdFiN
 o0wWxRQDLvrzUQai7N7Ik7SP0LjzAcWUtwWiQRbIZvHNHVVhRoXN+9zpVoCnWT6LOKpbe+o4/
 yv84Gk7YEizUgsMh1czdJFAZD/UVKAIAYfKsZ2ISRDLQC+SRNASrZqfgDN0Fp4nh0ci+JZNS7
 nmS58+BXwGcby3E/LJ3ZYqMgRH/uyI2QgiB0bxySB69F5eaUEa76qMSF3XPbjpr8X4UKIZQPS
 g9g/DYDt4i6bcq2+qHJgwKp6OjQgUBFjOu2N+4yNo34KILLXYOdk794ZmzGsMTMO9IIWowEtD
 llcJW0ANmmKKhRmCgWjpuCyopfA0T471/m/kczHPcqMfq/NUoUI97sH0Qu73WJxfX1QK3Scew
 +6Xmg9qq6rHkNUIkRw3UZXAK/jRRPdZq5cxA2TpJ6cRXstQYhxAL9xK5/ZvhAnbI3uVYLofhY
 IjN45v0fl9K74EsR8FLkyFS8FJcwFUKbG9fpM6tVboQ9wHkMqMxAFD6gngvosy//FhZoxj70v
 yA7inCKCWiy7usXMIM8e4rJh1j1msXkqUYBZnzMsm9dURrxgxuV9A6aXipkrr2Mf17y2y/2Vl
 SVVvnYU7+JuRmTyHZ6JGr9afPI8AUg+f5Tv0fNiuLVl8IT8AU3oI+1wMGI4uicJDqBiwuUtxs
 oWGPfcVwE5w99XiXyCWCZKsGKM1yQBkk/Uuuyd7WDVmBpQ0k8bD8zF2F3HYgxxoVpHUusvKLu
 C1L1gEXAHQFSwCzfutXQ3IPu+Z/5BVo5iG4MCkv+IljA6tYR822880EZb/fugjdo0NANTHEKk
 bS187+fjaWEcUuBMhK53wxNRKN1g23cu5zZAAPb4/sY+X1ku4u3Y1SV/Yto7R4EBzopybIqgb
 zAsRzGBm4gnGSAASr89QDfbZRHlGYOUn7mHQ++7nWzClC6tS2pi0IwAv55oGUhvjvcEtGTWmJ
 ZhpiAtREkQRCZEdFkzckx/UxFyawELxi0x/gGtFuT2xO4iTkGii6VTJ+B1G0UDDFdy9LF/S0k
 ca5Gea13MVxAznIlaxr4E3VO/cIjT+358X0xQs/HSCA0ZLZ08rCbwnzK1d4N/xd6ecD9xcj/+
 MHYhmCpRwoPFQA903PiZUgUe7jLXDRkC79FzaLRQ1Py3VBujK5ALJ0Iq0cQvQ2E3d0m2C2pEV
 BStbo=
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

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
>
> The series is meant to be applied on top of broonie/for-next.
> It can be applied to Linus' current tree if commit
> 8d8bef503658 ("spi: bcm2835: Fix 3-wire mode if DMA is enabled")
> is cherry-picked from broonie's repo beforehand.
>
> Please review and test.  Thank you.
>
> Lukas Wunner (10):
>   dmaengine: bcm2835: Allow reusable descriptors
>   dmaengine: bcm2835: Allow cyclic transactions without interrupt
>   spi: Guarantee cacheline alignment of driver-private data
>   spi: bcm2835: Drop dma_pending flag
>   spi: bcm2835: Work around DONE bit erratum
>   spi: bcm2835: Cache CS register value for ->prepare_message()
>   spi: bcm2835: Speed up TX-only DMA transfers by clearing RX FIFO
>   dmaengine: bcm2835: Document struct bcm2835_dmadev
>   dmaengine: bcm2835: Avoid accessing memory when copying zeroes
>   spi: bcm2835: Speed up RX-only DMA transfers by zero-filling TX FIFO
>
Acked-by: Stefan Wahren <wahrenst@gmx.net>

Sorry, for this late reply

