Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53D8E8B4DA
	for <lists+dmaengine@lfdr.de>; Tue, 13 Aug 2019 12:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfHMKCA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Aug 2019 06:02:00 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:59160 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbfHMKCA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Aug 2019 06:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1565690517; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZbzHVM6ENaR4P/6+oOoubZ60cH5LA2N4J6V2DJChuP0=;
        b=pFFfezQjKuJRCyCrZ9/ijjroaefD35Husngjhtv0sS9eRbULkJZieHwFjjUUwZHaOSMVhv
        Jym9DJW3vwQNxQw4SI21TSkg5AYgp4PLMnIjtp7Fi2rteFN9o2S3rSBW+rrUXddKsUjfoL
        iN4pdyxvhjsec4lYAWRoFxESQB5CuEc=
Date:   Tue, 13 Aug 2019 12:01:48 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 10/11] mfd: Drop obsolete JZ4740 driver
To:     Philippe =?iso-8859-1?q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Sebastian Reichel <sre@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, od@zcrc.me,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org,
        Artur Rojek <contact@artur-rojek.eu>
Message-Id: <1565690508.1856.0@crapouillou.net>
In-Reply-To: <4b48e597-951e-45fd-dfb2-4a1292a8b067@amsat.org>
References: <20190725220215.460-1-paul@crapouillou.net>
        <20190725220215.460-11-paul@crapouillou.net> <20190812081640.GA26727@dell>
        <4b48e597-951e-45fd-dfb2-4a1292a8b067@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Philippe,


Le mar. 13 ao=FBt 2019 =E0 10:44, Philippe=20
=3D?iso-8859-1?q?Mathieu-Daud=3DE9?=3D <f4bug@amsat.org> a =E9crit :
> Hi Lee,
>=20
> On 8/12/19 10:16 AM, Lee Jones wrote:
>>  On Thu, 25 Jul 2019, Paul Cercueil wrote:
>>=20
>>>  It has been replaced with the ingenic-iio driver for the ADC.
>>>=20
>>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>>  Tested-by: Artur Rojek <contact@artur-rojek.eu>
>>>  ---
>>>   drivers/mfd/Kconfig      |   9 --
>>>   drivers/mfd/Makefile     |   1 -
>>>   drivers/mfd/jz4740-adc.c | 324=20
>>> ---------------------------------------
>>>   3 files changed, 334 deletions(-)
>>>   delete mode 100644 drivers/mfd/jz4740-adc.c
>>=20
>>  Applied, thanks.
>=20
> It seems the replacement is done in "MIPS: qi_lb60: Migrate to
> devicetree" which is not yet merged.

It's merged in the MIPS tree, though, so it'll blend together just
fine in linux-next.

>=20
> Probably easier if this patch goes thru the MIPS tree as part of the
> "JZ4740 SoC cleanup" series.
>=20
> Regards,
>=20
> Phil.

=

