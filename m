Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 126FB8935E
	for <lists+dmaengine@lfdr.de>; Sun, 11 Aug 2019 21:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfHKTpn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 11 Aug 2019 15:45:43 -0400
Received: from mout.gmx.net ([212.227.15.18]:55049 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfHKTpn (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 11 Aug 2019 15:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565552711;
        bh=fZaKg6gd1EQ+a8z4bF2A/YHyBDJAJCvWQejuZHpWnQs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Rq9qF7OAHrK357Ln+LM9B3Z++PwkI+iz3G1MF9MnvBhQGUDnR80fk/sityDYuGHd9
         eBzr00vKn9kdBv1NbWn+CuOZIzE+e9tB3WEgODiUX5Tf0AF7oOj918t71x68wMRIQA
         1pHrg9TUVL02j29G4S55oovfLZYN1pQe2XYsHutU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.106]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7b2d-1hw4R02zwj-00824T; Sun, 11
 Aug 2019 21:45:11 +0200
Subject: Re: [PATCH 05/10] spi: bcm2835: Work around DONE bit erratum
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
 <edb004dff4af6106f6bfcb89e1a96391e96eb857.1564825752.git.lukas@wunner.de>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <35aab039-17a2-ca22-5567-4088c98400f0@gmx.net>
Date:   Sun, 11 Aug 2019 21:45:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <edb004dff4af6106f6bfcb89e1a96391e96eb857.1564825752.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:gAHu6DGkMnC/FihHDYlwSLrcswaAp6mfQR9qsg787Bz4rxpaHb7
 5fS0LzjyliFDgfJdDuyCbLfvsQ7/e5fz6HiSr4omq9fbNk9GnxfT/smr7GXtvDATqwho0Mu
 vIcnvWRudmQlU08cZXlePnXw1gZFesOiEpdyX7CqgpLKOhh/w3jb8QDQkZ+KVihgMdBk+vl
 cnxqrTUyvGifBGp65VLsw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fsmT6u/6ktg=:IArHnkPxJRL/qsl+XaFUMi
 j8bLZvoinlk8vbBZ65lO8m1hNSgvwTTXnbFOq/RMWudcf9cWvr9DWKAU52cvjHoKeXEdGpSfg
 +qNfu+OmjQU05QQzV3gvpiJ2ZXBQF7XX4UnEkJY0UwxF1dlszjvi9uLtrftChsNvHHRMk8VWB
 Z/lPEnX9wlw94Ln4DHjjMXIeQ+/9+rx3qfGIE9Rm5RE35IFBoi/22TOsr9wwGrMFBQwhT2QBU
 YGEzhWj9oQow1IWuiCqWDYBsdqdfIh0IKbd3P29f/P3wuTZblh7oEA2dtHvy9L/n1nAUQG7WX
 zxruoUIN/v9JBFo2gLdp/nXRHfg9XWfpLJLvQLsOtwMec6AcD2V4Hy+9YNI444MPIndoCNaAt
 HSajN69shECbKfe9YNucs3PfU90RLjsd2uOnTRKOF7z0mihzP83f0Y3+4Y39pBiD7syWZskz6
 avd7x4qZ9y6gJDt63ZMNGwHXLWxTDwRgB/sQk/+V7PglnsC8t0BS1idjlrinBPGgcxhMVv3hi
 7DHPWDi0VflJwA5Cr2uUVr9xmY15ZuX1BLO7ChdqirP4hqPtD2M+4cRb4G1AAT2f/EKa2lmTv
 21VKF0quS/cTk0h6tDPY+PjqFuTgL75g/pU8LrdMKhdcwyNBA2pLHqs18oIJkkYQg9NlTAyEw
 T/7LICx+tXF72r08glLs8wMwv2XvUHdQk2GeOwzcUVPAaUd2DHhDUkAO8dYozpGXJR/dWqF5Y
 oSW820CliG4hRuTN718SftX/F0lN1rar9WVXcnidjrDrnx3QCdMke3h4eeESXNyjCsjiaWuv2
 hK4hOOOUVvSdh30oj8XHfNQEy/XKtQOn++LrfsglmGDdfqivagy9dHyDNfq4b9otB2QIMRSXo
 0kxJlHqkTxogwyaXa5LXJoLSce2JjnfdZ8ZsCRhnM3TMgEd50eCwxf+XYU//sn8HLsv0bTeSl
 ia/iHrsx+3SXxX67hIDlNL4WmmqtCSuDezXayuXG0TC7gmQnvX0jTxeS1PFL/OBwrd04r0bBp
 DGUvmI7TAmSQqY8b4GjbJ2oH5+BBb9j2mqHcbuY5BM+KTTmZX7SPQoPnSLWOlGUVRQqJDARz4
 pZXiL52BkoyRYe4lLiRJ5z2bY5fg+XkUEG2Yf55J1eM4SStoybjWOwQFFcSDk9gnk4/PaIO4f
 12NA4=
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Lukas,

Am 03.08.19 um 12:10 schrieb Lukas Wunner:
> Commit 3bd7f6589f67 ("spi: bcm2835: Overcome sglist entry length
> limitation") amended the BCM2835 SPI driver with support for DMA
> transfers whose buffers are not aligned to 4 bytes and require more than
> one sglist entry.
>
> When testing this feature with upcoming commits to speed up TX-only and
> RX-only transfers, I noticed that SPI transmission sometimes breaks.
> A function introduced by the commit, bcm2835_spi_transfer_prologue(),
> performs one or two PIO transmissions as a prologue to the actual DMA
> transmission.  It turns out that the breakage goes away if the DONE bit
> in the CS register is set when ending such a PIO transmission.
>
> The DONE bit signifies emptiness of the TX FIFO.  According to the spec,
> the bit is of type RO, so writing it should never have any effect.
> Perhaps the spec is wrong and the bit is actually of type RW1C.
> E.g. the I2C controller on the BCM2835 does have an RW1C DONE bit which
> needs to be cleared by the driver.  Another, possibly more likely
> explanation is that it's a hardware erratum since the issue does not
> occur consistently.
>
> Either way, amend bcm2835_spi_transfer_prologue() to always write the
> DONE bit.
>
> Usually a transmission is ended by bcm2835_spi_reset_hw().  If the
> transmission was successful, the TX FIFO is empty and thus the DONE bit
> is set when bcm2835_spi_reset_hw() reads the CS register.  The bit is
> then written back to the register, so we happen to do the right thing.
>
> However if DONE is not set, e.g. because transmission is aborted with
> a non-empty TX FIFO, the bit won't be written by bcm2835_spi_reset_hw()
> and it seems possible that transmission might subsequently break.  To be
> on the safe side, likewise amend bcm2835_spi_reset_hw() to always write
> the bit.
has the issue already reported to Raspberry Pi Trading?
