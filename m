Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92F11893A0
	for <lists+dmaengine@lfdr.de>; Sun, 11 Aug 2019 22:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfHKU3G (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 11 Aug 2019 16:29:06 -0400
Received: from anholt.net ([50.246.234.109]:45476 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfHKU3G (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 11 Aug 2019 16:29:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id DDB7010A10CA;
        Sun, 11 Aug 2019 13:29:05 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id KGHKBLsbJF_K; Sun, 11 Aug 2019 13:29:04 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 3DE6110A1066;
        Sun, 11 Aug 2019 13:29:04 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 6A0052FE2547; Sun, 11 Aug 2019 13:29:05 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Lukas Wunner <lukas@wunner.de>, Stefan Wahren <wahrenst@gmx.net>
Cc:     Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-spi@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Nuno Sa <nuno.sa@analog.com>,
        Martin Sperl <kernel@martin.sperl.org>,
        Noralf Tronnes <noralf@tronnes.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Florian Kauer <florian.kauer@koalo.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCH 05/10] spi: bcm2835: Work around DONE bit erratum
In-Reply-To: <20190811195709.u5gkllkfxutufvt7@wunner.de>
References: <cover.1564825752.git.lukas@wunner.de> <edb004dff4af6106f6bfcb89e1a96391e96eb857.1564825752.git.lukas@wunner.de> <35aab039-17a2-ca22-5567-4088c98400f0@gmx.net> <20190811195709.u5gkllkfxutufvt7@wunner.de>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/26.1 (x86_64-pc-linux-gnu)
Date:   Sun, 11 Aug 2019 13:29:05 -0700
Message-ID: <87v9v38mzy.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Lukas Wunner <lukas@wunner.de> writes:

> On Sun, Aug 11, 2019 at 09:45:09PM +0200, Stefan Wahren wrote:
>> Am 03.08.19 um 12:10 schrieb Lukas Wunner:
>> > Commit 3bd7f6589f67 ("spi: bcm2835: Overcome sglist entry length
>> > limitation") amended the BCM2835 SPI driver with support for DMA
>> > transfers whose buffers are not aligned to 4 bytes and require more th=
an
>> > one sglist entry.
>> >
>> > When testing this feature with upcoming commits to speed up TX-only and
>> > RX-only transfers, I noticed that SPI transmission sometimes breaks.
>> > A function introduced by the commit, bcm2835_spi_transfer_prologue(),
>> > performs one or two PIO transmissions as a prologue to the actual DMA
>> > transmission.  It turns out that the breakage goes away if the DONE bit
>> > in the CS register is set when ending such a PIO transmission.
>> >
>> > The DONE bit signifies emptiness of the TX FIFO.  According to the spe=
c,
>> > the bit is of type RO, so writing it should never have any effect.
>> > Perhaps the spec is wrong and the bit is actually of type RW1C.
>> > E.g. the I2C controller on the BCM2835 does have an RW1C DONE bit which
>> > needs to be cleared by the driver.  Another, possibly more likely
>> > explanation is that it's a hardware erratum since the issue does not
>> > occur consistently.
>> >
>> > Either way, amend bcm2835_spi_transfer_prologue() to always write the
>> > DONE bit.
>> >
>> > Usually a transmission is ended by bcm2835_spi_reset_hw().  If the
>> > transmission was successful, the TX FIFO is empty and thus the DONE bit
>> > is set when bcm2835_spi_reset_hw() reads the CS register.  The bit is
>> > then written back to the register, so we happen to do the right thing.
>> >
>> > However if DONE is not set, e.g. because transmission is aborted with
>> > a non-empty TX FIFO, the bit won't be written by bcm2835_spi_reset_hw()
>> > and it seems possible that transmission might subsequently break.  To =
be
>> > on the safe side, likewise amend bcm2835_spi_reset_hw() to always write
>> > the bit.
>>=20
>> has the issue already reported to Raspberry Pi Trading?
>
> You mean to fix such errata in future revisions?
>
> I wouldn't know who to report this to, Roger Thornton or James Adams perh=
aps?
>
> I'm not sure if the SPI controller isn't just an IP block licensed from
> a third party, that might make it difficult to get errata fixed.

It's Broadcom's.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAl1QepEACgkQtdYpNtH8
nugjiQ/7BM8nlTdAiZ/IHoGwmVbikdKFrJfiDS5YFXltKU3STyDpHKI/5IHEILUN
R0o8h4/WWWSO+Y8A5InhQH64bk0/HEjS+O9kcJC1eaTfMpe9/ZoFlbIzo1j+CPjm
smvK1eh41qo6LF/u3lR8FTCSAiI0yCz9QWTxRorq1WncavA3J6UU9AuznvrmGkzy
/VmFrv6PrFnWRCX/GqDiIvVWDaKcNFjsvxMBTXfjn0OT2S6gDJOK/HO0bJiKfQCw
cebCpgGg0QUD6HjcQh6HqKiE0YoavW5oNBGovkS/g1Mu84DTAwTidXczqiTRoEmz
lZ99q5mv+jvKz5FRIWyHOkPwk8RO1JKC3W/rJNW+7F/TlQj8yY7h+G3pVY5kiJvB
c3wbevRw/mB0VAOqcegcG69sD6qWsAMcVnq940dlVjPm8kV5jvpDZaiUdMdxs678
aoWCkmcnQRBi4ZmUa/OezLIyEeGOiNmQ9SNe3qAZh+09l/LqAANxlKjWDStVsV8N
RrguIZMcU10yH0iV03flIU4Q7WAYGSSYjpva2RYEHrkDiQ60ivMTHgrtWSWfClEO
1bEATWhyh7x9bue8QJMnps+PDPBtsaQBQBi03RgEz3GTsGY31K5kWO+AyhUoByJ5
Q5UI91dtdb1bSxljV/xhwCO05Tw5d4RmsR/IT7KTKCIxCpMKjtg=
=+hMe
-----END PGP SIGNATURE-----
--=-=-=--
