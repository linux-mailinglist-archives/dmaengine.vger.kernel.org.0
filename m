Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B728763BE8
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jul 2019 21:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfGIT2D (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 9 Jul 2019 15:28:03 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42932 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfGIT2D (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 9 Jul 2019 15:28:03 -0400
Received: by mail-lj1-f195.google.com with SMTP id t28so20678661lje.9
        for <dmaengine@vger.kernel.org>; Tue, 09 Jul 2019 12:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jTMRQzTd2NAnqgiomIAA7+pDC1dbYmFpkxB/bf6Q4tM=;
        b=EYrtokQhnehr0WcObqpbJeY4e2nB9fRRTmznqmWADY5QLwarOLh9ftLlJoWuDbj9Ws
         LKlV2E0mrFvWSV5mfasr+HW1IUsQyjfPgofJwMETkEUeeMOyWuSmWPWisu5vtWN9idGP
         iE4dfOXxNRYePbaDKrVABpd0sY3E+x0wicoVTYViorHOrNfljzjbewh71v7GdlHJjGfF
         XBZ1OWzLSfe+uQP4VKVVSqrMQKO5g/9xnKJtPJs7SjwscxAMcEZJqiqet+KX/Nn2W2Ju
         ERuKU8w+aaUdG0Pli0BVCAV+o6aMX8dcdZsTbvMuKLhsrkTyXUfSBFl/GyzVtaO+LNxk
         EDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jTMRQzTd2NAnqgiomIAA7+pDC1dbYmFpkxB/bf6Q4tM=;
        b=T64NXQXqxD0NW9VHaV19Zkv3S6O+gs7DuPkIetDWQjFApw15ZbVD9GZmSiMagMCy/g
         u7jLOXkWfbS2XkzVT5TBvPFIkPWviM9vp3kVoIOU78nbJ1QF3oLmWhhkW5irAnODCKq+
         kugfyy3TD1RP/saC+s00IrEIi8ofIZVbXA8vg6eN+1ajJZ1NzsqHhZSC3+qNxVyoc4+d
         djthqgXji4TEvRToz6mpAqbQkFRlF7FbvOI5LJPwvcNQYyKX+6jCotcl9sLpW2esTDZu
         shNSktNqxdeUHQ2qpv8+nWHcuv7tL8+nEo0ENQbpaFueLMfNLJ7Aa+0Et/MBQZ4aZwEp
         sCTw==
X-Gm-Message-State: APjAAAVM/7pW/MEBtc5dvkoah4AtYQYJfc0cdfyEJ/w9gGQQ7jfVykJf
        KV6uGvPX41k2Yj0sR1OjwCJ1M+ip/EbGFzZMnshwjA==
X-Google-Smtp-Source: APXvYqwM9kzkFtX3di4fu6k88dButQR4p9Lc7mMJUSG+58pifQxeL7fqmYaJSuErAlCvKbsWOEDiIXfK1HjZ4SeqrtU=
X-Received: by 2002:a2e:3008:: with SMTP id w8mr15177510ljw.13.1562700480420;
 Tue, 09 Jul 2019 12:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAOReqxhxHiJ-4UYC-j4Quuuy5YP9ywohe_JwiLpCxqCvP-7ypg@mail.gmail.com>
 <20190709131401.GA9224@smile.fi.intel.com> <20190709132943.GB9224@smile.fi.intel.com>
 <20190709133448.GC9224@smile.fi.intel.com> <20190709133847.GD9224@smile.fi.intel.com>
In-Reply-To: <20190709133847.GD9224@smile.fi.intel.com>
From:   Curtis Malainey <cujomalainey@google.com>
Date:   Tue, 9 Jul 2019 12:27:49 -0700
Message-ID: <CAOReqxgnbDJsEcv7vdX3w44rzB=B69sHj95E8yBZ8DnZq0=63Q@mail.gmail.com>
Subject: Re: DW-DMA: Probe failures on broadwell
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Ross Zwisler <zwisler@google.com>,
        Fletcher Woodruff <fletcherw@google.com>,
        dmaengine@vger.kernel.org,
        ALSA development <alsa-devel@alsa-project.org>,
        Pierre-louis Bossart <pierre-louis.bossart@intel.com>,
        Liam Girdwood <liam.r.girdwood@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Andy,

Thanks for the information, we are running a 4.14 kernel so we don't
have the idma32 driver, I will see if I can backport it and report
back if the fix works.

Thanks.

On Tue, Jul 9, 2019 at 6:38 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Jul 09, 2019 at 04:34:48PM +0300, Andy Shevchenko wrote:
> > On Tue, Jul 09, 2019 at 04:29:43PM +0300, Andy Shevchenko wrote:
> > > On Tue, Jul 09, 2019 at 04:14:01PM +0300, Andy Shevchenko wrote:
> > > > On Mon, Jul 08, 2019 at 01:50:07PM -0700, Curtis Malainey wrote:
> > >
> > > > So, the correct fix is to provide a platform data, like it's done in
> > > > drivers/dma/dw/pci.c::idma32_pdata, in the sst-firmware.c::dw_probe(), and call
> > > > idma32_dma_probe() with idma32_dma_remove() respectively on removal stage.
> > > >
> > > > (It will require latest patches to be applied, which are material for v5.x)
> > >
> > > Below completely untested patch to try
> >
> > Also, it might require to set proper request lines (currently it uses 0 AFAICS).
> > Something like it's done in drivers/spi/spi-pxa2xx-pci.c for Intel Merrifield.
>
> And SST_DSP_DMA_MAX_BURST seems encoded while it's should be simple number,
> like 8 (bytes). Also SPI PXA is an example to look into.
>
> I doubt it has been validated with upstream driver (I know about some internal
> drivers, hacked version of dw one, you may find sources somewhere in public).
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
