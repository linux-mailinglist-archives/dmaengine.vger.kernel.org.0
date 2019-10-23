Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 956A3E22F3
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2019 20:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390366AbfJWS6o (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Oct 2019 14:58:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35137 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387929AbfJWS6o (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Oct 2019 14:58:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id 205so13498010pfw.2;
        Wed, 23 Oct 2019 11:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q/WjrA3enF78wNnnxIx+f9y8uHKmRouHXVbuDW698NY=;
        b=OU9iA/58MyezOXLX8VuLx9/0dvcslj3yeHWj73th65lH4gbDMSPC/n49SfXyVrwWYv
         MV8wfmxTQf7BwdfoZo9/Hz9jVF3r6f/cfGn7dLPogAehym30gmI8J04xsFXHcalt8yJg
         GzI4BW64Q0wENpF9TScO0bGNOB/xKNcACcC4FlNWWD3RMSekjKxahEOsYVAX+xybW5iv
         vGpDDOw+611TRsUB0ohj1NwgVWEUu2pFPx94XZxrK3E0CqhA3XlCXsyuvPCjRJwSmj/r
         VHHO1IIgFGuSSBa3Pw0Mp5jwxrjWTQaMgIDQs1CLkHVr1eX/653ADUMWtDvCLi4nUX3W
         8nnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q/WjrA3enF78wNnnxIx+f9y8uHKmRouHXVbuDW698NY=;
        b=a6FjnXxVIq1oMjdjSjiU2o76LlkxhShdjBEV9os4O+WvlYgm7twUDtAseEc+Efss3/
         sReEv1uC81V4kJ6bxsiYPifOU+ir1hsMWpKI+5c1jUfJ7WOe2b/0VaLyGfkekemkG8Kp
         VKUBQQQHnXt32qiwYC0QicSSDtn5n630Pay2visVpZBC1C2Bxm0JdiVm2pOECBi2Yg1n
         rVKvLpHEfTtAlwBQyQfskhiHPeanXzRn3viA1BxFHNp8x1UL0IWncgFu81GsEInvYrYi
         scn9g+DL2DWtQ8rzbWeC9VxVEDO6o0/zm6Gi5+ZyVDdM856tdA5Trxx/vFO0eNFxsuns
         FFRg==
X-Gm-Message-State: APjAAAUUdKr0Pvewkc8vZek/mNCiCR8YE/d/a0x5+BarXf2GScjPA8Yi
        TH0lxVCoXkaV+NEg08q+fLEl/OPXcSyqApnyi/E=
X-Google-Smtp-Source: APXvYqwDLTuWPFV/0dGQT7a3MzAyvYlxNVNKIGgAImFTzut0NyysuqrskfKJMxdoS/fZpV2O2tkud1q/JYuu1+J3l4A=
X-Received: by 2002:a17:90a:db4a:: with SMTP id u10mr1927692pjx.30.1571857122305;
 Wed, 23 Oct 2019 11:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191023153138.23442-1-tony@atomide.com> <6996a5de-215b-f9a2-1aeb-5eeed1b7cf8d@cogentembedded.com>
In-Reply-To: <6996a5de-215b-f9a2-1aeb-5eeed1b7cf8d@cogentembedded.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 23 Oct 2019 21:58:30 +0300
Message-ID: <CAHp75VfyTJ+ptA8+AAgRgUNETLu=5EBc=bO7tmNhgxtdQq4EUw@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: cppi41: Fix cppi41_dma_prep_slave_sg() when idle
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Bin Liu <b-liu@ti.com>, Daniel Mack <zonque@gmail.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        George Cherian <george.cherian@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Johan Hovold <johan@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        dmaengine <dmaengine@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        giulio.benetti@benettiengineering.com,
        Sebastian Reichel <sre@kernel.org>,
        Skvortsov <andrej.skvortzov@gmail.com>,
        Yegor Yefremov <yegorslists@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Oct 23, 2019 at 9:55 PM Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 10/23/2019 06:31 PM, Tony Lindgren wrote:

> > +     int error;
> > +
> > +     error = pm_runtime_get(cdd->ddev.dev);
> > +     if (error < 0) {
>
>    I'd call that variable 'status', comparison (error < 0) just doesn't look right.
> If it was *if* (error), it would have been more correct.

It's error when it's negative. That's how PM runtime is designed.

> > +             pm_runtime_put_noidle(cdd->ddev.dev);
> > +
> > +             return NULL;
> > +     }

-- 
With Best Regards,
Andy Shevchenko
