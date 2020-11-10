Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78ECF2AD6C8
	for <lists+dmaengine@lfdr.de>; Tue, 10 Nov 2020 13:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgKJMsf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Nov 2020 07:48:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:40060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgKJMsf (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 10 Nov 2020 07:48:35 -0500
Received: from localhost (unknown [122.179.121.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 274B220637;
        Tue, 10 Nov 2020 12:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605012514;
        bh=HqIlZJaFEcBlGvTPmE4/CCgkt70rXFffPU39yaxTjmE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DBAL5u1I4TzkVzdXuoV3Ai5oHJZmFiicO/oeiVsBnxBqZfIy7HD4oEyq7v4EX8RtU
         TXEzqzjHJ13slfR1iCfqUsCSrf2OTWNfUx/zQAEH76ivOjVVRYjaAqv2jF1QWzmTAb
         RPWU3YmrUBn1V7mT06dG6xz5435t1JnGh3eZL0Rc=
Date:   Tue, 10 Nov 2020 18:18:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Frank Lee <frank@allwinnertech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, kishon@ti.com,
        wim@linux-watchdog.org, Guenter Roeck <linux@roeck-us.net>,
        dan.j.williams@intel.com, Linus Walleij <linus.walleij@linaro.org>,
        wsa+renesas@sang-engineering.com, dianders@chromium.org,
        marex@denx.de, Colin King <colin.king@canonical.com>,
        rdunlap@infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        rikard.falkeborn@gmail.com, dmaengine@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SECURE DIGITAL HO..." <linux-mmc@vger.kernel.org>,
        linux-watchdog@vger.kernel.org,
        linux-gpio <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH 00/19] Second step support for A100
Message-ID: <20201110124829.GB161013@vkoul-mobl>
References: <20201110040553.1381-1-frank@allwinnertech.com>
 <CAEExFWsc4Rx2U+BVuqTJkL0wj-gdNcF=emJRcStQ2Uq=FQEx1g@mail.gmail.com>
 <CAJKOXPf4ARNnSnvDpn7vVC0kGNd+m_dkfgKkmH_bca2AZ_Osyg@mail.gmail.com>
 <CAEExFWv2o9aTfUVM5NzZz10kAO_Ya8VJvJrmyjh55=U_5G8RJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEExFWv2o9aTfUVM5NzZz10kAO_Ya8VJvJrmyjh55=U_5G8RJw@mail.gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10-11-20, 16:51, Frank Lee wrote:
> On Tue, Nov 10, 2020 at 4:43 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On Tue, 10 Nov 2020 at 07:00, Frank Lee <tiny.windzz@gmail.com> wrote:
> > >
> > > It seems that sending too many e-mails at one time will cause some
> > > emails to fail to be sent out. I will try again.
> >
> > Hi,
> >
> > Instead please reduce the address list to relevant people, as pointed
> > out by scripts/get_maintainer.pl. Don't Cc irrelevant developers
> > unless a file is abandoned and you need to get as much audience as
> > possible... but sunxi is not abandoned.
> 
> Thank you for the reminder. I resend the version in the afternoon,
> only CC the relevant people. I'm not sure. Should the cover be copied
> to everyone?

Any reason why this should be a single series.. why not split it to
bunch of chunks, one per subsystem like pinctrl, phy, dmaengine, etc...
And then DTS parts and CC relevant list and maintainers. I do not think
there is any dependency, right?

-- 
~Vinod
