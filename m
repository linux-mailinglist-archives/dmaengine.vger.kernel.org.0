Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA87134D80
	for <lists+dmaengine@lfdr.de>; Tue,  4 Jun 2019 18:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfFDQbw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Jun 2019 12:31:52 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33400 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727463AbfFDQbv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Jun 2019 12:31:51 -0400
Received: by mail-lj1-f195.google.com with SMTP id v29so9046060ljv.0;
        Tue, 04 Jun 2019 09:31:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dr/nOXRAFiRM2FTVnZh4DqIXuqTo0SpqUZyUwpEnF3s=;
        b=DIrH3fNG7qnYZfcAfWu3PgtgAZ/9NV5YPW91cNqcZ4F1b8qH/qB3vYEpx6WtWAHjPP
         kfxIl2TNpLR0xgRaPtFYdRf/1zisoBf8EwYvPuWLdkq3ku4J60fXpG2SLl8eGlAL9LSD
         kKhEkhQPDrBb6KnrFnaVVP/dfh4CQqcps5YZ+P8PFANr8m+yfqcLD0xJZZd60bXbK9HY
         INzkGSja5I8BmtoaMU2YIKMfpHvy5tzWt1UGuoiDL4wiMWRNCpcXOZskBSZ5aRLj4Dg4
         XdpvE6oS4KUnadOpZAKxnpG76kusES64TpkpJNagw2MFb9nZRWic6ypIxERv2sxxrPmf
         3z8A==
X-Gm-Message-State: APjAAAUnR7yuQZj6s280qBQREPWxrSJg0GT3UbSs6W519svEUa9+vj7S
        0o5SqpT6t1XbPzram6lcoBw6qjCs0o8egL59SDRrr+nl
X-Google-Smtp-Source: APXvYqzonb/0f6m6MbT3aCz2kl2NHdg6Gf+vGXLioLGKHFEKMH/KR0ciiqrRgL+gJgG3XTjw40K+6Zvcy80+Z5pQ2Ds=
X-Received: by 2002:a2e:9255:: with SMTP id v21mr10419283ljg.178.1559665909291;
 Tue, 04 Jun 2019 09:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190524002847.30961-1-dinguyen@kernel.org> <20190524002847.30961-2-dinguyen@kernel.org>
 <20190604121424.GW15118@vkoul-mobl> <1dd97825-f6a2-7a1b-33ef-e28e00cc8506@kernel.org>
In-Reply-To: <1dd97825-f6a2-7a1b-33ef-e28e00cc8506@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Jun 2019 18:31:36 +0200
Message-ID: <CAMuHMdV+_DzS+LD720BeAn05RzYGO9rS51-ucicP=8D0wz9Psg@mail.gmail.com>
Subject: Re: [PATCH 2/2] dmagengine: pl330: add code to get reset property
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Dinh,

On Tue, Jun 4, 2019 at 4:21 PM Dinh Nguyen <dinguyen@kernel.org> wrote:
> On 6/4/19 7:14 AM, Vinod Koul wrote:
> > On 23-05-19, 19:28, Dinh Nguyen wrote:
> >> The DMA controller on some SoCs can be held in reset, and thus requires
> >> the reset signal(s) to deasserted. Most SoCs will have just one reset
> >> signal, but there are others, i.e. Arria10/Stratix10 will have an
> >> additional reset signal, referred to as the OCP.
> >>
> >> Add code to get the reset property from the device tree for deassert and
> >> assert.
> >>
> >> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> >> ---
> >>  drivers/dma/pl330.c | 38 ++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 38 insertions(+)
> >>
> >> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> >> index 6e6837214210..6018c43e785d 100644
> >> --- a/drivers/dma/pl330.c
> >> +++ b/drivers/dma/pl330.c
> >> @@ -29,6 +29,7 @@
> >>  #include <linux/err.h>
> >>  #include <linux/pm_runtime.h>
> >>  #include <linux/bug.h>
> >> +#include <linux/reset.h>
> >>
> >>  #include "dmaengine.h"
> >>  #define PL330_MAX_CHAN              8
> >> @@ -500,6 +501,9 @@ struct pl330_dmac {
> >>      unsigned int num_peripherals;
> >>      struct dma_pl330_chan *peripherals; /* keep at end */
> >>      int quirks;
> >> +
> >> +    struct reset_control    *rstc;
> >> +    struct reset_control    *rstc_ocp;
> >>  };
> >>
> >>  static struct pl330_of_quirks {
> >> @@ -3028,6 +3032,30 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
> >>
> >>      amba_set_drvdata(adev, pl330);
> >>
> >> +    pl330->rstc = devm_reset_control_get_optional(&adev->dev, "dma");
> >> +    if (IS_ERR(pl330->rstc)) {
> >> +            dev_err(&adev->dev, "No reset controller specified.\n");
> >
> > Wasnt this optional??
>
> Yes, this is optional. The call devm_reset_control_get_optional() will
> just return NULL if the reset property is not there, but an error
> pointer if something really went wrong. Thus, I'm using IS_ERR() for the
> error checking.

So the error message is incorrect, as this is a real error condition?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
