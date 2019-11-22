Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42E3910799D
	for <lists+dmaengine@lfdr.de>; Fri, 22 Nov 2019 21:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfKVUui (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Nov 2019 15:50:38 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38569 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfKVUui (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Nov 2019 15:50:38 -0500
Received: by mail-oi1-f193.google.com with SMTP id a14so7726329oid.5
        for <dmaengine@vger.kernel.org>; Fri, 22 Nov 2019 12:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rtynH85gyGlDq0GrY2joukq6gyAjnsOTrDAsOTjdu4s=;
        b=nH3Z0qYFEFLQ1V2rk/5yw6r3/SQTV6v0Qvnr/Q1K4l4ESIE0Get+jNzXQgZ5WSiUM4
         zoSkq9fKNz7iAGTHDlmJdJDP/lGGEMOfnBss60N+37tTguVsPLxXn+DOp8uvJymHkFAs
         S8kNl/30NszwrzSh9PUPGVriKUjXEnVqoAWBGjlLKeQHvZ5a92F+AE1Z6Jn94tUqCSo2
         JAGbwZGJjh8xPXSeAEb//Tq6Q4GVyQmh8nK9Wgwz5co1bVMe1/OD4PmySXCTHpI+DxdW
         rMD90Ij2pN74gdq/KUjeMuIwPsJg3YL9yBX1jxT/l8RN3hAUYKu64iK2AuK3C3VUA1UB
         CvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rtynH85gyGlDq0GrY2joukq6gyAjnsOTrDAsOTjdu4s=;
        b=N+g5iYFP4eBddvSWQPQ1NOhr5/9FQBzYgVs9lFYV0oc0/v/f1KYWpb0F71KSUe/wSo
         bN/UnswTJfToibmAxIrh/KYMjZqf8pGMpY1SWPhVNTYwdwM7pF91sfm25YJtMkdp5mq+
         gayEsReCS20s1InDd0Wcaix9ZEAX3F8b5tuRVXphzTjeJSitT3YXncsBQ6aqZrr7yNgv
         JtXxh9Cq9HLeWLeX3Am2WwOBPGZc62ApEGABIJm6RgI3ARtqXwZNnThV5vZjUD1JYb6f
         /hHHa9q705Kg9exQ8OxHJ26dss8tqjUHs8qZu/R1gdbv11Ii7bv24PK3TkCYXDL+wS8d
         0+hw==
X-Gm-Message-State: APjAAAWeCYhIEfdRhR0vdo7/0kKCKxDrWTHpouFm47jF65kPC707t6eo
        oXQGQB/viaB9gjgZWqmY169l0Is1ohMYY5Xhf8DkDg==
X-Google-Smtp-Source: APXvYqykbOKyt7iq29g8ba+chVdC5xtEHNFoNedLG+79HyMuarno1DwxvKJh1zrDlJTVJSTJqDcV2WGdfPX+DQAEWrQ=
X-Received: by 2002:a05:6808:1da:: with SMTP id x26mr14315269oic.149.1574455837194;
 Fri, 22 Nov 2019 12:50:37 -0800 (PST)
MIME-Version: 1.0
References: <20191022214616.7943-1-logang@deltatee.com> <20191022214616.7943-2-logang@deltatee.com>
 <20191109171853.GF952516@vkoul-mobl> <3a19f075-6a86-4ace-9184-227f3dc2f2d3@deltatee.com>
 <20191112055540.GY952516@vkoul-mobl> <5ca7ef5d-dda7-e36c-1d40-ef67612d2ac4@deltatee.com>
 <20191114045555.GJ952516@vkoul-mobl> <fa45de06-089f-367c-7816-2ee040e41d24@deltatee.com>
 <20191122052010.GO82508@vkoul-mobl> <4c03b5c6-6f25-2753-22b9-7cdcb4f8b527@intel.com>
In-Reply-To: <4c03b5c6-6f25-2753-22b9-7cdcb4f8b527@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 22 Nov 2019 12:50:26 -0800
Message-ID: <CAPcyv4iOjSX=Diw3Gs0Xnpe4HmVZ0xxD_13aQcCMomqUJWr58A@mail.gmail.com>
Subject: Re: [PATCH 1/5] dmaengine: Store module owner in dma_device struct
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Nov 22, 2019 at 8:53 AM Dave Jiang <dave.jiang@intel.com> wrote:
>
>
>
> On 11/21/19 10:20 PM, Vinod Koul wrote:
> > On 14-11-19, 10:03, Logan Gunthorpe wrote:
> >>
> >>
> >> On 2019-11-13 9:55 p.m., Vinod Koul wrote:
> >>>> But that's the problem. We can't expect our users to be "nice" and not
> >>>> unbind when the driver is in use. Killing the kernel if the user
> >>>> unexpectedly unbinds is not acceptable.
> >>>
> >>> And that is why we review the code and ensure this does not happen and
> >>> behaviour is as expected
> >>
> >> Yes, but the current code can kill the kernel when the driver is unbound.
> >>
> >>>>>> I suspect this is less of an issue for most devices as they wouldn't
> >>>>>> normally be unbound while in use (for example there's really no reason
> >>>>>> to ever unbind IOAT seeing it's built into the system). Though, the fact
> >>>>>> is, the user could unbind these devices at anytime and we don't want to
> >>>>>> panic if they do.
> >>>>>
> >>>>> There are many drivers which do modules so yes I am expecting unbind and
> >>>>> even a bind following that to work
> >>>>
> >>>> Except they will panic if they unbind while in use, so that's a
> >>>> questionable definition of "work".
> >>>
> >>> dmaengine core has module reference so while they are being used they
> >>> won't be removed (unless I complete misread the driver core behaviour)
> >>
> >> Yes, as I mentioned in my other email, holding a module reference does
> >> not prevent the driver from being unbound. Any driver can be unbound by
> >> the user at any time without the module being removed.
> >
> > That sounds okay then.
>
> I'm actually glad Logan is putting some work in addressing this. I also
> ran into the same issue as well dealing with unbinds on my new driver.

This was an original mistake of the dmaengine implementation that
Vinod inherited. Module pinning is distinct from preventing device
unbind which ultimately can't be prevented. Longer term I think we
need to audit dmaengine consumers to make sure they are prepared for
the driver to be removed similar to how other request based drivers
can gracefully return an error status when the device goes away rather
than crashing.
