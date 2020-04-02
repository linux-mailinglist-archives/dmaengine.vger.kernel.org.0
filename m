Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 605B919BA3E
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2020 04:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732732AbgDBCVM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Apr 2020 22:21:12 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34875 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732682AbgDBCVM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Apr 2020 22:21:12 -0400
Received: by mail-ed1-f65.google.com with SMTP id a20so2329433edj.2
        for <dmaengine@vger.kernel.org>; Wed, 01 Apr 2020 19:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1M7OKSUxjChEcoYNZEaRS2w/Ep5Pr9E1TfTyAyCSCGU=;
        b=fKlJIQaa53eGN4Fy8VcYUy2a7XjrwmByQurko1/ikVYzWFoz/xwrPeVDsSf75GRHNb
         29jlaC2ZDgSU9LJNvdMKB2kqVdFMrpnwMZFTKVBFD0Q0IH+V60MrGYiSLW6wns572Moy
         3r8nX5Vf0MvcNdCoe9xvYjC9IHbGlkESNk9f03WyB4aU/VG0I2Q1raTqiD8iFz2q1BK2
         h23PBhxaU5/ij1/ndAfqXEZepXeK5tLctgdeE4W5Gzab9mcgnE8lC2HOge7jRFDvN8p9
         FachXdeFSlB+iofoxgQfzaORIvhx6yVpZflU+kgmz6DsHLDYWrct1S2aAcni+Qie0rNI
         Znyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1M7OKSUxjChEcoYNZEaRS2w/Ep5Pr9E1TfTyAyCSCGU=;
        b=oDWuP7Bt3eE0yqQCndWc4WEf+jQfI99HyeQLT8Vf3Pib12OD+cMNxdxlqpVpmZmGeA
         kUT6SfxAFYL7TZ7Fa0tDVQR7J8WvNFixEQeae1B+wIIVd4cRNhlx1Gmry0G+bi1jX7ze
         1RF2Y7cmjAvIIS5rLuOGvwd2jn5niUsgGQHxgxIyXPxqkdjC8jgCffBVnWL+1LTG2ceM
         rAmuRSv5uwXcrpnoisxrhH32xQtO8/opPDBcofvNHdc4+wVP2pf1MIl4J6O2tTsc9qny
         5py+UWwlcGkO3jjfDs75rXCGhuFWmjhj6qNAm55yqkO3qSizAAg1mgDcrVgq12X6qbA6
         Kyaw==
X-Gm-Message-State: AGi0PubhPparcvq+MHtCk5IZFnw78Xx6J+S6a9fF8PtMtZEu3TkjhA0j
        IiTSveUhrzVr5E20VFBqD+3Gyx3jz97BJ4F/Lddqbw==
X-Google-Smtp-Source: APiQypLfWzzdPhYu8JstE8xaJceriFzU0asNEFuyamP/TyOhBMVKn0U8IqjgkCH+xJCJO/KoFgheuGPAIuQ9Y/y0nk8=
X-Received: by 2002:aa7:c609:: with SMTP id h9mr755033edq.93.1585794070492;
 Wed, 01 Apr 2020 19:21:10 -0700 (PDT)
MIME-Version: 1.0
References: <158560290392.6059.16921214463585182874.stgit@djiang5-desk3.ch.intel.com>
 <158560362665.6059.11999047251277108233.stgit@djiang5-desk3.ch.intel.com> <20200401071851.GA31076@infradead.org>
In-Reply-To: <20200401071851.GA31076@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 1 Apr 2020 19:20:59 -0700
Message-ID: <CAPcyv4iE_-g8ymYe75bLKmVUvTVtp8GJm3xqUoiscbyTxoUnbQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] pci: add PCI quirk cmdmem fixup for Intel DSA device
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, dmaengine@vger.kernel.org,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-pci@vger.kernel.org,
        "Luck, Tony" <tony.luck@intel.com>, Jing Lin <jing.lin@intel.com>,
        Sanjay K Kumar <sanjay.k.kumar@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Apr 1, 2020 at 12:19 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Mar 30, 2020 at 02:27:06PM -0700, Dave Jiang wrote:
> > Since there is no standard way that defines a PCI device that receives
> > descriptors or commands with synchronous write operations, add quirk to set
> > cmdmem for the Intel accelerator device that supports it.
>
> Why do we need a quirk for this?  Even assuming a flag is needed in
> struct pci_dev (and I don't really understand why that is needed to
> start with), it could be set in ->probe.

The consideration in my mind is whether this new memory type and
instruction combination warrants a new __attribute__((noderef,
address_space(X))) separate from __iomem. If it stays a single device
concept layered on __iomem then yes, I agree it can all live locally
in the driver. However, when / if this facility becomes wider spread,
as the PCI ECR in question is trending, it might warrant general
annotation.

The enqcmds instruction does not operate on typical x86 mmio
addresses, only these special device portals offer the ability to have
non-posted writes with immediate results in the cpu condition code
flags.
