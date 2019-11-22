Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD1F51079B3
	for <lists+dmaengine@lfdr.de>; Fri, 22 Nov 2019 22:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfKVVBV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Nov 2019 16:01:21 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35490 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfKVVBV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Nov 2019 16:01:21 -0500
Received: by mail-oi1-f194.google.com with SMTP id a69so530208oib.2
        for <dmaengine@vger.kernel.org>; Fri, 22 Nov 2019 13:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ILSZGGm7QSx3PdU1qLsdt69tl8AFDunS479DgX6F4Bo=;
        b=kh80/zLjvg/MndD6Asgkf+9hVicNjw851+U/2dwR7L1ah4TyiU5XqUgbWHuv53l4ID
         0xEcah08GvOf3iVDWzlMHd704BRqZh8WMGG8ywjM3ldpt+XF6AvLKjIxoRp6ydktNRaq
         6q/jc5Zp0gAHGoR8TPJxoDM/ds4k5S7PZBpWxAqki9ryxU5kEG1i4olKYYk9bOkSQXBw
         gbeu6O3bMW7Z1IPNmtHGBMneAq+Pcw2D4dA1osFcjt4X6YKmIsvMyYRDs1ew5Fwpl65R
         +vS43E4dmdb97gHjr3UACfB6cOmOiU4BGPpMZgXZc1njFAppePN7l6PTqY/pH9NcKGEK
         l76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ILSZGGm7QSx3PdU1qLsdt69tl8AFDunS479DgX6F4Bo=;
        b=KZZFs26kePO0BOt5nWkUUFp1/w5X0B84mo0gLChobxRmbgvA3X+kkknDOkJrfOj6CK
         ICnKTTZ+O6090Dch90ykqGBYw/vfUT0lO6JtMlFHEbe//wdfXtmhYvr8rQbhI/lW6Qyp
         vF2fIf+8cDLiTeOvqoqZLqiDq+LQhvxBWbZW0hKEf7qjWRoOw//BK1I6wbcfFdWSRkJy
         0eOlCkK2T3/iGRANpVtFcb4VqrEr/U0ZNvm5IeV9GinKU07gnHoL34HDL0wISQAoxIJT
         THs919P713+cV2fRLv7HHH0XDnSAj+8B1edFUi9xJH6OsB9mneYmj7XFTGHo9/NOGE+l
         opuA==
X-Gm-Message-State: APjAAAU2jdL1b+0ilZcxCLFO/Z0jJOpWuF4Ogd9jKKXKXUgVEO2en0u2
        lRoJMCUq/Ah/Mr/SPVajZWA8rtOWiHZAD5bGh2zE94zq
X-Google-Smtp-Source: APXvYqzR69xVj1nvhC0VTf+5jd9GcXVruWxEn9VCUxgYKMoZpJBhz3dqFvxV6O+5ri0JXI2yXf4j/jJ8rsBfLgURJ7c=
X-Received: by 2002:aca:ea57:: with SMTP id i84mr13409682oih.73.1574456479982;
 Fri, 22 Nov 2019 13:01:19 -0800 (PST)
MIME-Version: 1.0
References: <20191022214616.7943-1-logang@deltatee.com> <20191022214616.7943-2-logang@deltatee.com>
 <20191109171853.GF952516@vkoul-mobl> <3a19f075-6a86-4ace-9184-227f3dc2f2d3@deltatee.com>
 <20191112055540.GY952516@vkoul-mobl> <5ca7ef5d-dda7-e36c-1d40-ef67612d2ac4@deltatee.com>
 <20191114045555.GJ952516@vkoul-mobl> <fa45de06-089f-367c-7816-2ee040e41d24@deltatee.com>
 <20191122052010.GO82508@vkoul-mobl> <4c03b5c6-6f25-2753-22b9-7cdcb4f8b527@intel.com>
 <CAPcyv4iOjSX=Diw3Gs0Xnpe4HmVZ0xxD_13aQcCMomqUJWr58A@mail.gmail.com> <dd40f8ff-62bb-648c-eb65-7e335cde6138@deltatee.com>
In-Reply-To: <dd40f8ff-62bb-648c-eb65-7e335cde6138@deltatee.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 22 Nov 2019 13:01:09 -0800
Message-ID: <CAPcyv4gnvQsAen0DUW3o4Kv1WPW28Q00+mxBowUN8yMy6Kmgvw@mail.gmail.com>
Subject: Re: [PATCH 1/5] dmaengine: Store module owner in dma_device struct
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Nov 22, 2019 at 12:56 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2019-11-22 1:50 p.m., Dan Williams wrote:
> > On Fri, Nov 22, 2019 at 8:53 AM Dave Jiang <dave.jiang@intel.com> wrote:
> >>
> >>
> >>
> >> On 11/21/19 10:20 PM, Vinod Koul wrote:
> >>> On 14-11-19, 10:03, Logan Gunthorpe wrote:
> >>>>
> >>>>
> >>>> On 2019-11-13 9:55 p.m., Vinod Koul wrote:
> >>>>>> But that's the problem. We can't expect our users to be "nice" and not
> >>>>>> unbind when the driver is in use. Killing the kernel if the user
> >>>>>> unexpectedly unbinds is not acceptable.
> >>>>>
> >>>>> And that is why we review the code and ensure this does not happen and
> >>>>> behaviour is as expected
> >>>>
> >>>> Yes, but the current code can kill the kernel when the driver is unbound.
> >>>>
> >>>>>>>> I suspect this is less of an issue for most devices as they wouldn't
> >>>>>>>> normally be unbound while in use (for example there's really no reason
> >>>>>>>> to ever unbind IOAT seeing it's built into the system). Though, the fact
> >>>>>>>> is, the user could unbind these devices at anytime and we don't want to
> >>>>>>>> panic if they do.
> >>>>>>>
> >>>>>>> There are many drivers which do modules so yes I am expecting unbind and
> >>>>>>> even a bind following that to work
> >>>>>>
> >>>>>> Except they will panic if they unbind while in use, so that's a
> >>>>>> questionable definition of "work".
> >>>>>
> >>>>> dmaengine core has module reference so while they are being used they
> >>>>> won't be removed (unless I complete misread the driver core behaviour)
> >>>>
> >>>> Yes, as I mentioned in my other email, holding a module reference does
> >>>> not prevent the driver from being unbound. Any driver can be unbound by
> >>>> the user at any time without the module being removed.
> >>>
> >>> That sounds okay then.
> >>
> >> I'm actually glad Logan is putting some work in addressing this. I also
> >> ran into the same issue as well dealing with unbinds on my new driver.
> >
> > This was an original mistake of the dmaengine implementation that
> > Vinod inherited. Module pinning is distinct from preventing device
> > unbind which ultimately can't be prevented. Longer term I think we
> > need to audit dmaengine consumers to make sure they are prepared for
> > the driver to be removed similar to how other request based drivers
> > can gracefully return an error status when the device goes away rather
> > than crashing.
>
> Yes, but that will be a big project because there are a lot of drivers.

Oh yes, in fact I think it's something that can only reasonably be
considered for new consumers.

> But I think the dmaengine common code needs to support removal properly,
> which essentially means changing how all the drivers allocate and free
> their structures, among other things.
>
> The one saving grace is that most of the drivers are for SOCs which
> can't be physically removed and there's really no use-case for the user
> to call unbind.

Yes, the SOC case is not so much my concern as the generic offload use
cases, especially if those offloads are in a similar hotplug domain as
a cpu.
