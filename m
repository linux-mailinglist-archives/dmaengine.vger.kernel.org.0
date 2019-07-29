Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3E278A61
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jul 2019 13:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387647AbfG2LXZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Jul 2019 07:23:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44567 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387450AbfG2LXY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 Jul 2019 07:23:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id p17so61392212wrf.11;
        Mon, 29 Jul 2019 04:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7FSTYRCDuN8ugCkUACc2sS4c/sxO9MPaWoEgh7iEEsE=;
        b=bVgt5oMZu9vka1vXyxfezj5eUPF8tafHtuB8RDF5PL5XefOI5mn84bdcGgEYFQWdBD
         v3/RzVElyj8HrIjajPHz9JfYqtYa1a1yA8hfjYuu81uuZW+L4M6UDlbC+97IeFIaW79S
         VyfhVHIyNKEDN8aDRs1lSXylanKCL5tamDdd0LGZFSuGIdZhIA5YtQMSnnlPGOXYI+uB
         otASFE6nLMIXfBJnLYqx5jtskcjMG1v7YFrGQrTtLxogh4D9ruZUok7QnLA9zT0nF3y9
         Mad/lcbjmcAfGQ+6KgMGFjkt1CTbHPYd7gc6HCKZGD+kgkTJ+bsGFjbvG/audBf5AYAL
         O2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7FSTYRCDuN8ugCkUACc2sS4c/sxO9MPaWoEgh7iEEsE=;
        b=dMkc5k2gWxxoAQgaJU6mKcEv6bVxVspczfTKRuDOZ2NfcHG2MF4EsNUgmfIXE0XYw0
         GLcr1SqxK+e8X0sDbobOIZ+z3aW+R7oiR7CAj30B04oMy6Qpw1SmOd3H/C/+Wcyj86ZW
         ytXaMyoxqgYiEQ4AXmzBJ/cmtkKmlWGoFKgFJcXM1exRFaFI5J5niFkFDnMYji2+KOkJ
         OX9PJ+D4oghLAOChwV+HiM/kc9MTHBLlnWnUXqWd08J06xloCZswIHcAaGRyTHFx5v6u
         U44tQlgXG4+UY0ZkVbPpyy195BSP1G7YMF7534LCOm5Y2nPJrDg5HOa51dQLlZ0p8j7s
         wC8Q==
X-Gm-Message-State: APjAAAUETAvd7ZCTC+tqyM9seHLNOmA2xniwhgJq6rrqr7VZifwnd8IS
        aslE1QdHMzRZhvcJQjU23W2k18oL5yHLJpIEPGY=
X-Google-Smtp-Source: APXvYqyKS6i0fcHmOYx363DJnPTuu/xw0bA5xIlQXAB08qPtFUJYujyOTv9lxMWA//8NpJVOebpAE1xkHqBFV70jCHw=
X-Received: by 2002:a5d:514f:: with SMTP id u15mr21122702wrt.183.1564399401730;
 Mon, 29 Jul 2019 04:23:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190725220215.460-1-paul@crapouillou.net>
In-Reply-To: <20190725220215.460-1-paul@crapouillou.net>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Mon, 29 Jul 2019 13:23:10 +0200
Message-ID: <CAFLxGvyi0+0E3M12A7cRoHfEKd8-7Yr8EMG9J=2XcjCxPWY5pA@mail.gmail.com>
Subject: Re: [PATCH 00/11] JZ4740 SoC cleanup
To:     Paul Cercueil <paul@crapouillou.net>
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
        linux-mtd@lists.infradead.org, dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jul 26, 2019 at 12:02 AM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Hi,
>
> This patchset converts the Qi LB60 MIPS board to devicetree and makes it
> use all the shiny new drivers that have been developed or updated
> recently.
>
> All the crappy old drivers and custom code can be dropped since they
> have been replaced by better alternatives.
>
> Some of these alternatives are not yet in 5.3-rc1 but have already been
> accepted by their respective maintainer for inclusion in 5.4-rc1.
>
> To upstream this patchset, I think that as soon as MIPS maintainers
> agree to take patches 01-03/11 and 11/11, the other patches can go
> through their respective maintainer's tree.

Was this series tested with the Ben Nanonote device?
I have one of these and from time to time I upgrade the kernel on it.

-- 
Thanks,
//richard
