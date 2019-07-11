Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF3EF65F5F
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jul 2019 20:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbfGKSPc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 11 Jul 2019 14:15:32 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46290 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbfGKSPb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 11 Jul 2019 14:15:31 -0400
Received: by mail-lj1-f193.google.com with SMTP id v24so6727595ljg.13
        for <dmaengine@vger.kernel.org>; Thu, 11 Jul 2019 11:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jys+Aym6KnhbTzR/MDF3RwfjVhOFhB89bd5ypnwJdRw=;
        b=VZ9c25tuP5SguEPOn0Kk7kr8E9e/8wzV/0xutOou+1KW2vM4vdzQH8d5KSvfnRC3SP
         CWdPByjoNq1e4dQn0SFHTzMrMMd3pWT9L5eKEnDRIAqfFH5J8+zJB3hzOlY66MiiTWS2
         mIqyX//9nCQ9U0/G4Ab6vuyaTDP5FczJGXQSOyHOMnnUBYmrNhlS6gofN+Y/DO4MiV3N
         Wdur8kyadou3yq+XLN3iRpPUQpboy20gXB/181UG/gH8Dui5tvSeGG986rIRLL73UfXP
         FZNsFWDlc7x09L9LQ9i1XuLvnkiBskVrixRJ6I0rHYEVEfjjKnRO7x+wnXTfCvjEo0I+
         1+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jys+Aym6KnhbTzR/MDF3RwfjVhOFhB89bd5ypnwJdRw=;
        b=YnrXb6A5gQXP/PBMwMqXiy90kaQbykjxL/ESdJjwcso/HfHJ50JyWzN7fHFr/JSe7O
         g530dG8CX3HSZPoWK18tyfJ45F6LTKjoXUW5OVmSGN3BE26EujJdGjLvZCkitMn8tVJy
         LuqZtASvPQKYADzec1cQRBsRyhS2JNG7jQLOM+211Ko9DFNKgHe+PsXWxCZVwCQkeLE5
         l2MxYflk2BP8oE+TunutoJ+dbgjhTaMyDUI/gCUCwWRm3xBCSHM+I4q/XcUMdtM3skSi
         /8+8emYZ6ubSsPSN2ZjH0ikLcq31hZiEX2a0VpEygG3Kk98Afli5PyrlhMjiTC0QkBhB
         WkQA==
X-Gm-Message-State: APjAAAXi5xV8G4Et3bOSDTDH/59Ur0lT8gRN/SMY1vzDI8ZNGZFBE1W8
        C6kvFIuNnCOVrn//TJMGpv+Bif/gyHB5/Q2/vxTIIg==
X-Google-Smtp-Source: APXvYqwg9+HrHWjwTDM78I11m/8M7PKj7fsOd0SBqm8pYU0n8uC7/Ok9sqDDch2TobcUeAFd9Xv6cEB09jt3/WghsSo=
X-Received: by 2002:a2e:3008:: with SMTP id w8mr3400463ljw.13.1562868929030;
 Thu, 11 Jul 2019 11:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAOReqxhxHiJ-4UYC-j4Quuuy5YP9ywohe_JwiLpCxqCvP-7ypg@mail.gmail.com>
 <20190709131401.GA9224@smile.fi.intel.com> <20190709132943.GB9224@smile.fi.intel.com>
 <20190709133448.GC9224@smile.fi.intel.com> <20190709133847.GD9224@smile.fi.intel.com>
 <CAOReqxgnbDJsEcv7vdX3w44rzB=B69sHj95E8yBZ8DnZq0=63Q@mail.gmail.com>
 <20190710164346.GP9224@smile.fi.intel.com> <CAOReqxgnUp2tTp__YCjF_QH4166FAA1CE8Yq_VdE9jLW6Q4s3A@mail.gmail.com>
 <20190711131232.GS9224@smile.fi.intel.com>
In-Reply-To: <20190711131232.GS9224@smile.fi.intel.com>
From:   Curtis Malainey <cujomalainey@google.com>
Date:   Thu, 11 Jul 2019 11:15:17 -0700
Message-ID: <CAOReqxhUb-47qDaJFQvOHfJQCP8Rz2sYsGpfr2wMgY3D6es=-g@mail.gmail.com>
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

On Thu, Jul 11, 2019 at 6:12 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jul 10, 2019 at 02:24:48PM -0700, Curtis Malainey wrote:
> > On Wed, Jul 10, 2019 at 9:43 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Tue, Jul 09, 2019 at 12:27:49PM -0700, Curtis Malainey wrote:
>
> > > > Thanks for the information, we are running a 4.14 kernel so we don't
> > > > have the idma32 driver, I will see if I can backport it and report
> > > > back if the fix works.
> > >
> > > Driver is supporting iDMA 32-bit in v4.14 AFAICS.
> > > The missed stuff is a split and some fixes here and there.
> > > Here is the list of patches I have in a range v4.14..v5.2
> > > (I deliberately dropped the insignificant ones)
> > >
> > > 934891b0a16c dmaengine: dw: Don't pollute CTL_LO on iDMA 32-bit
> > > 91f0ff883e9a dmaengine: dw: Reset DRAIN bit when resume the channel
> > > 69da8be90d5e dmaengine: dw: Split DW and iDMA 32-bit operations
> > > 87fe9ae84d7b dmaengine: dw: Add missed multi-block support for iDMA 32-bit
> > > ffe843b18211 dmaengine: dw: Fix FIFO size for Intel Merrifield
> > > 7b0c03ecc42f dmaengine: dw-dmac: implement dma protection control setting
> > >
> > > For me sounds like fairly easy to backport.
> > >
> > I got the code integrated, and ran some tests. The test device
> > regularly hits a BUG_ON in the dw/core.c, debug is turned on in dw
> > core
>
> I see. We need ASoC guys to shed a light here. I don't know that part at all.
>
> Only last suggestion I have is to try remove multi-block setting from the
> platform data (it will be emulated in software if needed). But I don't believe
> the DMA for audio has no such feature enabled.
>
In theory, (assuming I understand this correctly) it seems the DMA
driver is failing to probe (from what appears to possibly be a
hardware issue) but we should fallback to a non-DMA/direct method to
load the firmware to keep the system alive.

Also I am still seeing the same dma_sync_wait: timeout! failures with
multi-block commented out.
> > We have only been able to consistently reproduce the DMA boot issue on
> > our original code consistently on 1 device and sporadically on another
> > handful of devices.
> > When the device did finally booted after 2-3 device crashes the device
> > failed to load the DSP.
>
> Yeah, it has something to do with this firmware loader code...
>
> > [    3.709573] sst-acpi INT3438:00: DesignWare DMA Controller, 8 channels
> > [    3.959027] haswell-pcm-audio haswell-pcm-audio: error: audio DSP
> > boot timeout IPCD 0x0 IPCX 0x0
> > [    3.970336] bdw-rt5677 bdw-rt5677: ASoC: failed to init link System PCM
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
