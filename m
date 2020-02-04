Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABAC01519CA
	for <lists+dmaengine@lfdr.de>; Tue,  4 Feb 2020 12:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgBDLVJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Feb 2020 06:21:09 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42964 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbgBDLVI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Feb 2020 06:21:08 -0500
Received: by mail-pf1-f193.google.com with SMTP id 4so9306047pfz.9;
        Tue, 04 Feb 2020 03:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=etkzxQdonYJKMTHRqSVIxyc50MlvlU1LrQeOV4a4eFk=;
        b=PIRI49xc04/X0a8DT1CIRCvr2/mgyzDfnaH9DdnMmIZbmCYVnMSpJhynEmGudh5hDO
         kVywtrYnr1vRzyqzoru71Fes/x3ooibD9Uqd895xrv9y0yN5ECuVgYh6i0NCQRqUDhyJ
         qO/t/LY+TELglPmEJCIFcolOV8ow1gOutzm2X7/cKDcQupCEEfZVUVo1/YSCyQdUwDSz
         5/9f29STvTaZmVDO19GCRyVvBa9rXdFAKdLOnMmVgQYCbkdZYg1fmqJP1iBZsKNeqLWy
         HfBK1sK9PaokmKWzOFGeMbuUZ+orx+WcSN+ZMje9YdGfzp8Kv7GKh8Ax/rt/3m6aqsWh
         7GoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=etkzxQdonYJKMTHRqSVIxyc50MlvlU1LrQeOV4a4eFk=;
        b=pc6gDTN3mOiBahi3MRqt7tt6mW8pSttBQrVR9VHuYfSPdQKnVnAb12UkQLaOTULtaH
         tOopDofcD57e8xFi5HsZBFmzHVsTaAQQKduN4L8sxzOgH4zDqfxW+vgTeJFvKblGjEru
         rdND7K8r+BKiG84kW0wQBWmmCpCthkLXN0ySlrJ/9u7GtRWTgH2x0SbpRduOvpK9OUIg
         jDWPB6df1Ljw+SDTH2wGzOPvcUeg61HIRrKIxMIRseWUZh9D/yErNB0UmzcrZDd08Uo8
         mcP4BdwJmwYKAKqV5LxAFMwtKWCb37JDAn40BBkjQC7Ft/FBPfkQjRkhMg9W5ysSwkEs
         XOdg==
X-Gm-Message-State: APjAAAWYrhQv8xUaySIOiI4DRATs/38lJT1yrLIdFxa4ExLc71Vv/uwa
        EIvqM3p+FI3/Hm0kSWEl0s9QuhpYj7t05Ceq6qc=
X-Google-Smtp-Source: APXvYqwt7q/UzXE/AqPSMjFYF/rze2eiuvxrpzsXScsHqjQIuEpbdTYlvnclZB19Uhn2efeEopSNoRVRDT2HM64mxy4=
X-Received: by 2002:a65:4685:: with SMTP id h5mr32235446pgr.203.1580815268189;
 Tue, 04 Feb 2020 03:21:08 -0800 (PST)
MIME-Version: 1.0
References: <20200203101806.2441-1-peter.ujfalusi@ti.com> <CAHp75Vf__isc59YBS9=O+9ApSV62XuZ2nBAWKKD_K7i72P-yFg@mail.gmail.com>
 <20200204062118.GS2841@vkoul-mobl>
In-Reply-To: <20200204062118.GS2841@vkoul-mobl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 Feb 2020 13:21:00 +0200
Message-ID: <CAHp75VeRemcJkMMB7D2==Y-A4We=s1ntojZoPRdVS8vs+dB_Ew@mail.gmail.com>
Subject: Re: [PATCH 0/3] dmaengine: Stear users towards dma_request_slave_chan()
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Feb 4, 2020 at 8:21 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 03-02-20, 12:37, Andy Shevchenko wrote:
> > On Mon, Feb 3, 2020 at 12:32 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> >
> > > dma_request_slave_channel_reason() no longer have user in mainline, it
> > > can be removed.
> > >
> > > Advise users of dma_request_slave_channel() and
> > > dma_request_slave_channel_compat() to move to dma_request_slave_chan()
> >
> > How? There are legacy ARM boards you have to care / remove before.
> > DMAengine subsystem makes a p*s off decisions without taking care of
> > (I'm talking now about dma release callback, for example) end users.
>
> Can you elaborate issue you are seeing with dma_release callback?


[    7.980381] intel-lpss 0000:00:1e.3: WARN: Device release is not
defined so it is not safe to unbind this driver while in use

It's not limited to that driver, but actually all I'm maintaining.

Users are not happy!

-- 
With Best Regards,
Andy Shevchenko
