Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99F84792D2
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jul 2019 20:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbfG2SIm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+dmaengine@lfdr.de>); Mon, 29 Jul 2019 14:08:42 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:42270 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbfG2SIm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 Jul 2019 14:08:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E832A60632C0;
        Mon, 29 Jul 2019 20:08:38 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ehX5VuQgnl7G; Mon, 29 Jul 2019 20:08:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 70E276083139;
        Mon, 29 Jul 2019 20:08:38 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XjNoOe8nauWF; Mon, 29 Jul 2019 20:08:38 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id D590B608311C;
        Mon, 29 Jul 2019 20:08:37 +0200 (CEST)
Date:   Mon, 29 Jul 2019 20:08:37 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org,
        alsa-devel <alsa-devel@alsa-project.org>,
        linux-pm@vger.kernel.org, linux-mips@vger.kernel.org,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, od@zcrc.me,
        linux-mtd <linux-mtd@lists.infradead.org>,
        dmaengine@vger.kernel.org, Artur Rojek <contact@artur-rojek.eu>
Message-ID: <339409106.53616.1564423717793.JavaMail.zimbra@nod.at>
In-Reply-To: <1564419921.1759.1@crapouillou.net>
References: <20190725220215.460-1-paul@crapouillou.net> <CAFLxGvyi0+0E3M12A7cRoHfEKd8-7Yr8EMG9J=2XcjCxPWY5pA@mail.gmail.com> <1564419921.1759.1@crapouillou.net>
Subject: Re: [PATCH 00/11] JZ4740 SoC cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF60 (Linux)/8.8.12_GA_3809)
Thread-Topic: JZ4740 SoC cleanup
Thread-Index: pyW9XJwx/g8VXIVrZC/ODWU++joHAw==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

----- Ursprüngliche Mail -----
>> Was this series tested with the Ben Nanonote device?
>> I have one of these and from time to time I upgrade the kernel on it.
> 
> Yes! Artur (Cc'd) tested it.
> 
> You can test it yourself, after merging this patchset with:
> https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/slave-dma.git
> branch next,
> git://git.freedesktop.org/git/drm-misc branch drm-misc-next.
> 
> These will be in 5.4-rc1.

Awesome! Thanks a lot for cleaning this up.

Thanks,
//richard
