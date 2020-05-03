Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC86D1C3005
	for <lists+dmaengine@lfdr.de>; Mon,  4 May 2020 00:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbgECW26 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 3 May 2020 18:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729191AbgECW26 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 3 May 2020 18:28:58 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED601C061A0F
        for <dmaengine@vger.kernel.org>; Sun,  3 May 2020 15:28:57 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id g26so8721922qtv.13
        for <dmaengine@vger.kernel.org>; Sun, 03 May 2020 15:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uZ+K+ih0mNuF/pOvIE/xKN1vFjcEACHdo80ycEUlHfg=;
        b=LWRjvDWvojMKjrn+WxzIqCeWuxOhHJ6+/ybhiASHHGUUEt6RiHvB34fY9XpWF4RhLP
         t+CRl/TGVKUFpA22wbbMNsoxdDzu1saejrWFriYJCHU471wwifSDFYr4GPPEmaPCce7I
         qjrwcOXVnhBsEpNANWD5sbULmDYM/R89PYiQWwU7bisbB18hqpsVz5tSRVzH7z3VXlhf
         hxPNS6cJ+RlDHJ/N2TdiwPiosWaAPQAANOnlXGNiKcNxbCF4AxXutsVim/L4GmSYuvmP
         l2gQRMQGZc+aIsZyq0rFZcBfX1Xbu+4nXPjB085vgLB/Sb1FmVnWI3PaW0jAOzHuI7Xl
         RN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uZ+K+ih0mNuF/pOvIE/xKN1vFjcEACHdo80ycEUlHfg=;
        b=p9hrfF05mHCasvA8RORTfJW6Fkqp+yvc5zD//ukOhWf92LaZWOetF4qETWNMnB4bHm
         15FqExeqJ8SN+4j29qylqP/gUgVe7C5nGE5xPOE9ccrPISrj2T1ydfk72OgtDXixo1Me
         fLTZ+M24xEUQhUB+Xdu+Yj6wpkqu+ZzkgtI2yarYxom3/U0m9C140lPjZdPtGwjAo8i3
         pg7JTVAcGdh/Zipm6K2psn2Svs9yHurNKPrV/cq6TnoJXGexvZVEJaMC1ADT4l1gM3MK
         9YbPBLh0kwAP/C+V6HrLmIBaZd8kM5r1ZIdmCc133JBLH8Rufku4z3fXOpecjiyUX51N
         zMAg==
X-Gm-Message-State: AGi0PuZm/69RpiSoZF+0tFvwNZD8VxiHWwePHT4wsGcZwOyxqTiw2nCA
        CD6rt/ugr5FJlkMaOeP0yF0P6A==
X-Google-Smtp-Source: APiQypKYxrNhYHbmyIb1vKCNt8ennSGrROO729y1tL1l5VbHybFfkW5ZWT7zTe85CeHXC40l6+RsVQ==
X-Received: by 2002:aed:2591:: with SMTP id x17mr14119279qtc.76.1588544937120;
        Sun, 03 May 2020 15:28:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id k2sm9657677qta.39.2020.05.03.15.28.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 May 2020 15:28:56 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jVN6W-0002Vu-0N; Sun, 03 May 2020 19:28:56 -0300
Date:   Sun, 3 May 2020 19:28:55 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Dey, Megha" <megha.dey@linux.intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, vkoul@kernel.org,
        maz@kernel.org, bhelgaas@google.com, rafael@kernel.org,
        gregkh@linuxfoundation.org, tglx@linutronix.de, hpa@zytor.com,
        alex.williamson@redhat.com, jacob.jun.pan@intel.com,
        ashok.raj@intel.com, yi.l.liu@intel.com, baolu.lu@intel.com,
        kevin.tian@intel.com, sanjay.k.kumar@intel.com,
        tony.luck@intel.com, jing.lin@intel.com, dan.j.williams@intel.com,
        kwankhede@nvidia.com, eric.auger@redhat.com, parav@mellanox.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-pci@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH RFC 07/15] Documentation: Interrupt Message store
Message-ID: <20200503222855.GT26002@ziepe.ca>
References: <158751095889.36773.6009825070990637468.stgit@djiang5-desk3.ch.intel.com>
 <158751207000.36773.18208950543781892.stgit@djiang5-desk3.ch.intel.com>
 <20200423200436.GA29181@ziepe.ca>
 <afd2ae49-ed65-5cde-c867-a923ac9bf8ac@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afd2ae49-ed65-5cde-c867-a923ac9bf8ac@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, May 01, 2020 at 03:32:22PM -0700, Dey, Megha wrote:
> Hi Jason,
> 
> On 4/23/2020 1:04 PM, Jason Gunthorpe wrote:
> > On Tue, Apr 21, 2020 at 04:34:30PM -0700, Dave Jiang wrote:
> > 
> > > diff --git a/Documentation/ims-howto.rst b/Documentation/ims-howto.rst
> > > new file mode 100644
> > > index 000000000000..a18de152b393
> > > +++ b/Documentation/ims-howto.rst
> > > @@ -0,0 +1,210 @@
> > > +.. SPDX-License-Identifier: GPL-2.0
> > > +.. include:: <isonum.txt>
> > > +
> > > +==========================
> > > +The IMS Driver Guide HOWTO
> > > +==========================
> > > +
> > > +:Authors: Megha Dey
> > > +
> > > +:Copyright: 2020 Intel Corporation
> > > +
> > > +About this guide
> > > +================
> > > +
> > > +This guide describes the basics of Interrupt Message Store (IMS), the
> > > +need to introduce a new interrupt mechanism, implementation details of
> > > +IMS in the kernel, driver changes required to support IMS and the general
> > > +misconceptions and FAQs associated with IMS.
> > 
> > I'm not sure why we need to call this IMS in kernel documentat? I know
> > Intel is using this term, but this document is really only talking
> > about extending the existing platform_msi stuff, which looks pretty
> > good actually.
> 
> hmmm, so maybe we call it something else or just say dynamic platform-msi?
> 
> > 
> > A lot of this is good for the cover letter..
> 
> Well, I got a lot of comments internally and externally about how the cover
> page needs to have just the basics and all the ugly details can go in the
> Documentation. So well, I am confused here.

Documentation should be documentation for users and developers.

Justification and rational for why functionality should be merged
belong in the commit message and cover letter, IMHO.

Here too much time is spent belabouring IMS's rational and not enough
is spent explaining how a driver should consume it or how a platform
should provide it.

And since most of this tightly related to platform-msi it might make
sense to start by documenting platform msi then adding a diff on that
to explain what change is being made to accommodate IMS.

Most likely few people are very familiar with platform-msi in the
first place..

Jason
