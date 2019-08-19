Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFE7E94DC7
	for <lists+dmaengine@lfdr.de>; Mon, 19 Aug 2019 21:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbfHSTUw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Aug 2019 15:20:52 -0400
Received: from mout.gmx.net ([212.227.15.15]:48513 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728218AbfHSTUw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 19 Aug 2019 15:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566242427;
        bh=7wbTmbqj2M2bc5xsqy7eOj/3f3y7Rv3gLJGS0QDLn38=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=gALq+XCQU6fTH1SsGUSz35JC8qKP8MycyftJjLd0Nf6cT7rDqpxKmDVc8gpepSHB6
         Q96OxFOfmy0JwuYtQLZgrBCXMCPz8BfB8Q2Ymma1gH41Rne5iij3MudDLxkC03/LP+
         2U4iJSg67Goqfl5MmRBjyDlFZMxfNz4fGNT/l/BI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.106]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4hvR-1iQlno2UQp-011jts; Mon, 19
 Aug 2019 21:20:27 +0200
Subject: Re: [PATCH 05/10] spi: bcm2835: Work around DONE bit erratum
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-spi@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>, Nuno Sa <nuno.sa@analog.com>,
        Martin Sperl <kernel@martin.sperl.org>,
        Noralf Tronnes <noralf@tronnes.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Florian Kauer <florian.kauer@koalo.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
References: <cover.1564825752.git.lukas@wunner.de>
 <edb004dff4af6106f6bfcb89e1a96391e96eb857.1564825752.git.lukas@wunner.de>
 <35aab039-17a2-ca22-5567-4088c98400f0@gmx.net>
 <20190811195709.u5gkllkfxutufvt7@wunner.de>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <b09eae55-04c9-0e22-23d0-4dbc8490ed2f@gmx.net>
Date:   Mon, 19 Aug 2019 21:20:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190811195709.u5gkllkfxutufvt7@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:1BetNGRwZEoGzC8N9rA6ZYiDVkPw3o8uw2npgSVkAAkPubOXGH9
 X9fo041jzr2/itbH9sNThFe//d/AI38F5btZDXfa64oTvJYpq4hCYvCC+jso6culD+ftazM
 vgqWIM4fBu7wQNg9DMHuQGBrIKuIWbn9W0/tH6KZEYaPf0VsX+l6vx2buAr3VYEsYLpstYw
 wZLF6a0+OhW+PfY3Hu72w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WaBCb7IjlaA=:xZD+uPSZnmwfuWX12EuOvc
 qa5qKLd76q7XjuZrcQL3731FTJ8FLG0bcy32EC0k60L07Z8CZ4qTTu/bajTcbYeRVGwjfGOdN
 XWFvFp+TR0dshV5ovac8G7BXS8t5y6jiEtgo6ljBWLwngXCf+N5GBIYx+pdPi15lHYDenXvzX
 tk+FOy9Rw60Wjnk+tIylHONKaggX6OfkVGe022PsANAwqc4nIxyHfKrZvEKNlcFhkU0jl2ywS
 slH/r12rRiLOrFb4CGwB5M/C10vmb1xGrZlifFwxjkCVN/GR9qPx4dGyo0mw+54NLqin+amoL
 maWO9+bLhAXk9cFxyStHbcSIgBImddzmJavnix0Tbz9C9LJYDGRa/BQZd3FaJp2WrGZWMsk/b
 /OGIBg3A7k1cUtEobNr2W5MvMS4a7ha2E3HhEtuMpt5Ua9zPYJ+/4NEmFSZR7Wwj2eFbZ8MDJ
 gscLRfRzusIpcAwpwwJiRflYqsNXhsjalVStJefeNXI9NY43G6tBSnQBqdFF5xmfxn3hSUQZr
 jsd/YKWaL2m4HcTiCnQ4L8jPO88Ol+zVBnmNOse12ZMbF24iEOnxsoerHdkW+iUWwdlwPIzfc
 UKmswxPi/m2AD0cHCC6vAdje0fhKrB2amy0VjsJgxSAgjbnx9v7YBFS5jY/UiDhrrzzjnd640
 RqB+4wqfqzeR+mPCFex770Zf5QUOy597BV08NFtTeHenq/KPeT2V5TDXKpWqNRsgqb8zkKtFu
 GDc2eEEOrwSojHWyQI/DLXeC28ix88bL3zVcDa2FIlAJds0sIpYNi/XlMZZA0ap/1+JKMU/BC
 8S1bV/XeX+RXEpPH2jzYaakd3kPyt9AoFeaKST6sET9xnKGpzb/kGtZjPTdoOYz57MaJsE3mY
 9DrkKMfRGzeTacsG0SZAF1SL9IngHrwwnen12DwGV66MRJ3kRuBh/hX48YKPBrlom2gpyhepT
 UIl/wOeCD1T4Mp1bY5lTCJvp7MVaYGaqR0CwD7qd9+c3zGJysSXJegaCz8+7QXq00QXtaaTKK
 /2CINdZoHjQa0pueq/cCm5w6UnpgqkjFpuCnXcQzVCRiYJV8BPOw5GBK/MZByEVX0Tcsmuph2
 el9vxF1SPF5UDFaBj5kaV924lk/HcOBIRmHqc2EMMCX0H7j7UaNyJj5iulAF33w6x3lKjjAqX
 IAZpY=
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Am 11.08.19 um 21:57 schrieb Lukas Wunner:
> On Sun, Aug 11, 2019 at 09:45:09PM +0200, Stefan Wahren wrote:
>> Am 03.08.19 um 12:10 schrieb Lukas Wunner:
>>> Commit 3bd7f6589f67 ("spi: bcm2835: Overcome sglist entry length
>>> limitation") amended the BCM2835 SPI driver with support for DMA
>>> transfers whose buffers are not aligned to 4 bytes and require more than
>>> one sglist entry.
>>>
>>> When testing this feature with upcoming commits to speed up TX-only and
>>> RX-only transfers, I noticed that SPI transmission sometimes breaks.
>>> A function introduced by the commit, bcm2835_spi_transfer_prologue(),
>>> performs one or two PIO transmissions as a prologue to the actual DMA
>>> transmission.  It turns out that the breakage goes away if the DONE bit
>>> in the CS register is set when ending such a PIO transmission.
>>>
>>> The DONE bit signifies emptiness of the TX FIFO.  According to the spec,
>>> the bit is of type RO, so writing it should never have any effect.
>>> Perhaps the spec is wrong and the bit is actually of type RW1C.
>>> E.g. the I2C controller on the BCM2835 does have an RW1C DONE bit which
>>> needs to be cleared by the driver.  Another, possibly more likely
>>> explanation is that it's a hardware erratum since the issue does not
>>> occur consistently.
>>>
>>> Either way, amend bcm2835_spi_transfer_prologue() to always write the
>>> DONE bit.
>>>
>>> Usually a transmission is ended by bcm2835_spi_reset_hw().  If the
>>> transmission was successful, the TX FIFO is empty and thus the DONE bit
>>> is set when bcm2835_spi_reset_hw() reads the CS register.  The bit is
>>> then written back to the register, so we happen to do the right thing.
>>>
>>> However if DONE is not set, e.g. because transmission is aborted with
>>> a non-empty TX FIFO, the bit won't be written by bcm2835_spi_reset_hw()
>>> and it seems possible that transmission might subsequently break.  To be
>>> on the safe side, likewise amend bcm2835_spi_reset_hw() to always write
>>> the bit.
>> has the issue already reported to Raspberry Pi Trading?
> You mean to fix such errata in future revisions?
I thought about document this issue in some kind of errata or on their
website.
>
> I wouldn't know who to report this to, Roger Thornton or James Adams perhaps?
>
> I'm not sure if the SPI controller isn't just an IP block licensed from
> a third party, that might make it difficult to get errata fixed.
>
> Thanks,
>
> Lukas
