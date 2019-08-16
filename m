Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 100BA8FC5E
	for <lists+dmaengine@lfdr.de>; Fri, 16 Aug 2019 09:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfHPHel convert rfc822-to-8bit (ORCPT
        <rfc822;lists+dmaengine@lfdr.de>); Fri, 16 Aug 2019 03:34:41 -0400
Received: from ajax.cs.uga.edu ([128.192.4.6]:37590 "EHLO ajax.cs.uga.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbfHPHel (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 16 Aug 2019 03:34:41 -0400
X-Greylist: delayed 2912 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Aug 2019 03:34:40 EDT
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
        (authenticated bits=0)
        by ajax.cs.uga.edu (8.14.4/8.14.4) with ESMTP id x7G6k6pN009281
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Aug 2019 02:46:08 -0400
Received: by mail-lj1-f176.google.com with SMTP id z17so4399867ljz.0;
        Thu, 15 Aug 2019 23:46:07 -0700 (PDT)
X-Gm-Message-State: APjAAAXU+xsv5iWCf0J6nXJxyWFJqG9P2pMuefQplCDajAN3QI5JxbMj
        KirCYl7CcIVicVOaC2DpuCInZAvQ7wU1MF4tojg=
X-Google-Smtp-Source: APXvYqwVudRRgcmnjQiJ+5E7lLs9w4XgPnuG0DOW6TnvkX82j7Yeh0LM/NVK+iIi6fGbne/N8pYFf6O27SBOoihgRbA=
X-Received: by 2002:a2e:7c12:: with SMTP id x18mr4759455ljc.100.1565937966576;
 Thu, 15 Aug 2019 23:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <1565936603-7046-1-git-send-email-wenwen@cs.uga.edu> <f6ddbed6-581c-cf0b-515a-52f9fb4f4fa2@ti.com>
In-Reply-To: <f6ddbed6-581c-cf0b-515a-52f9fb4f4fa2@ti.com>
From:   Wenwen Wang <wenwen@cs.uga.edu>
Date:   Fri, 16 Aug 2019 02:45:29 -0400
X-Gmail-Original-Message-ID: <CAAa=b7duUGPPKDKTn8yeX=8yVB99ftw_u6N_4j0K5DKj0vtxYQ@mail.gmail.com>
Message-ID: <CAAa=b7duUGPPKDKTn8yeX=8yVB99ftw_u6N_4j0K5DKj0vtxYQ@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: ti: Fix a memory leak bug
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Wenwen Wang <wenwen@cs.uga.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Aug 16, 2019 at 2:42 AM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>
>
>
> On 16/08/2019 9.23, Wenwen Wang wrote:
> > In ti_dra7_xbar_probe(), 'rsv_events' is allocated through kcalloc(). Then
> > of_property_read_u32_array() is invoked to search for the property.
> > However, if this process fails, 'rsv_events' is not deallocated, leading to
> > a memory leak bug. To fix this issue, free 'rsv_events' before returning
> > the error.
>
> Can you change the subject to:
> "dmaengine: ti: dma-crossbar: Fix a memory leak bug" ?

No problem. I will rework the patch. Thanks for your suggestion!

Wenwen

>
> Otherwise: Thank you, and
> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>
> >
> > Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
> > ---
> >  drivers/dma/ti/dma-crossbar.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma/ti/dma-crossbar.c b/drivers/dma/ti/dma-crossbar.c
> > index ad2f0a4..f255056 100644
> > --- a/drivers/dma/ti/dma-crossbar.c
> > +++ b/drivers/dma/ti/dma-crossbar.c
> > @@ -391,8 +391,10 @@ static int ti_dra7_xbar_probe(struct platform_device *pdev)
> >
> >               ret = of_property_read_u32_array(node, pname, (u32 *)rsv_events,
> >                                                nelm * 2);
> > -             if (ret)
> > +             if (ret) {
> > +                     kfree(rsv_events);
> >                       return ret;
> > +             }
> >
> >               for (i = 0; i < nelm; i++) {
> >                       ti_dra7_xbar_reserve(rsv_events[i][0], rsv_events[i][1],
> >
>
> - Péter
>
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
