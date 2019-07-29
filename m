Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 938A7791BE
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jul 2019 19:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbfG2RFw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Jul 2019 13:05:52 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:39114 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbfG2RFv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 Jul 2019 13:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1564419948; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ct5sfA9aKEmr8hMlVPpfoX1PCyM/MxIecN3pTsFsbo=;
        b=tGIbEOveRSTKHoZcpg/izsWRXZB3sJbHvlT52bDMqqruC35KNldtJ6Z1UumMknOBTmqxkS
        L0QxFFWQrtfalRctJpTe/AFwPD5hYLu/miXPRxLnpxQZvMuW30gWEtzMHrKJVpyhyW4MrF
        oruZx2tu/qGuw0Xp6xod1DxlnpMTbLU=
Date:   Mon, 29 Jul 2019 13:05:21 -0400
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 00/11] JZ4740 SoC cleanup
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Sebastian Reichel <sre@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org,
        alsa-devel <alsa-devel@alsa-project.org>,
        linux-pm@vger.kernel.org, linux-mips@vger.kernel.org,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, od@zcrc.me,
        linux-mtd@lists.infradead.org, dmaengine@vger.kernel.org,
        Artur Rojek <contact@artur-rojek.eu>
Message-Id: <1564419921.1759.1@crapouillou.net>
In-Reply-To: <CAFLxGvyi0+0E3M12A7cRoHfEKd8-7Yr8EMG9J=2XcjCxPWY5pA@mail.gmail.com>
References: <20190725220215.460-1-paul@crapouillou.net>
        <CAFLxGvyi0+0E3M12A7cRoHfEKd8-7Yr8EMG9J=2XcjCxPWY5pA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Richard,


Le lun. 29 juil. 2019 =E0 7:23, Richard Weinberger=20
<richard.weinberger@gmail.com> a =E9crit :
> On Fri, Jul 26, 2019 at 12:02 AM Paul Cercueil <paul@crapouillou.net>=20
> wrote:
>>=20
>>  Hi,
>>=20
>>  This patchset converts the Qi LB60 MIPS board to devicetree and=20
>> makes it
>>  use all the shiny new drivers that have been developed or updated
>>  recently.
>>=20
>>  All the crappy old drivers and custom code can be dropped since they
>>  have been replaced by better alternatives.
>>=20
>>  Some of these alternatives are not yet in 5.3-rc1 but have already=20
>> been
>>  accepted by their respective maintainer for inclusion in 5.4-rc1.
>>=20
>>  To upstream this patchset, I think that as soon as MIPS maintainers
>>  agree to take patches 01-03/11 and 11/11, the other patches can go
>>  through their respective maintainer's tree.
>=20
> Was this series tested with the Ben Nanonote device?
> I have one of these and from time to time I upgrade the kernel on it.

Yes! Artur (Cc'd) tested it.

You can test it yourself, after merging this patchset with:
https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/slave-dma.git=20
branch next,
git://git.freedesktop.org/git/drm-misc branch drm-misc-next.

These will be in 5.4-rc1.

Cheers,
-Paul

=

