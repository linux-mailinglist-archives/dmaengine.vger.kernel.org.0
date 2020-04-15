Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2BA01AB130
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2020 21:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411750AbgDOTHs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Apr 2020 15:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1416882AbgDOSzq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Apr 2020 14:55:46 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC816C061A0F
        for <dmaengine@vger.kernel.org>; Wed, 15 Apr 2020 11:55:45 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id l14so4903752ljj.5
        for <dmaengine@vger.kernel.org>; Wed, 15 Apr 2020 11:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D78ezzgr1zyOlgwKH7QLX+Li2SBqz2uUlzuC9KV6jFg=;
        b=Ow9I7iEN9+wJS6FF5B8WBHiyCZox0Z40+SBu0cl9K6E7AztZehjLEUTLvT4cBrYzk2
         gzX2BI+vld43OaOpaFYJlg3UzWF/jzyNYMCshoLQ43XncVa6WOFhKDvf+/N1kyPs1ZMA
         Pliy2KCXpOEgNmv3NVrZbBO0WzqBHWAEnLKXa+CGUxiZT3ecGVJm2dcDiZ/noHGiJnYd
         HqwI9SiEx5LfvmZDyF/9S+TZETw7hS32v7OcxEfeA+uciipy/kC/oVjVPBT6zw+Z8PpO
         Iyn5m7ncmw/RE2M+LxaMdTxTsZWohK3yfoRWTin8+HrGrYpNraEDEL4UGU0g5w9mHDTS
         nkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D78ezzgr1zyOlgwKH7QLX+Li2SBqz2uUlzuC9KV6jFg=;
        b=HtTr7nh6ePuXHVB3zkljpZSgmzQj9QquUs5+97/c8jK8RXwZcAqf00VMeaycAosiw2
         040FCZdg9YBPhUM8w57GDnibLBhAi23LuWNK0YmX3rshI0mq2XzWWhNVD6LBdDv6yyda
         fjnDfh7LX+MRkdn7wkTSgnSxH4nBBWXzSUqt9DPGDhZM1kEhjfRPBRBIJvI9NVDoJ8mj
         xhR5YElDBGSerQLXpitzceANQEXLOK8suKoPmqt4K3u6qjmsVtJOMQaWAHlCm+4dJp8T
         0q930wRnzYjAtVsse1RphiOXfFHrt+rzrHZRdJvUK09Rm7OcN4gkwk4iPlKxnVHZf156
         POLQ==
X-Gm-Message-State: AGi0PuYVkQChtXMxciKX0L4sFbq4w7/onpj2f5rSM6yDbcuBTkhcTA31
        lq3t0NxC5HW8FKQn1DG3r98NND9GJwENsh1BU53vYA==
X-Google-Smtp-Source: APiQypJXYNw4SDoKStFsU+56gq4FbE8anC1c48YFT200EteZlNxxTaQJtHbqWPO3STrbxva2wApkW5sioh8lhqP8s0Q=
X-Received: by 2002:a2e:3e15:: with SMTP id l21mr4074589lja.251.1586976944036;
 Wed, 15 Apr 2020 11:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <1586916464-27727-1-git-send-email-alan.mikhak@sifive.com>
 <DM5PR12MB1276CB8FA4457D4CDCE3137EDADB0@DM5PR12MB1276.namprd12.prod.outlook.com>
 <CABEDWGwYmO52g6cqvQdWb6HXWEHaMA1rcf96aUqv0f32tJZT-g@mail.gmail.com> <DM5PR12MB1276E09460BD4DB7E70EAF91DADB0@DM5PR12MB1276.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1276E09460BD4DB7E70EAF91DADB0@DM5PR12MB1276.namprd12.prod.outlook.com>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Wed, 15 Apr 2020 11:55:32 -0700
Message-ID: <CABEDWGw0OyQNppLpDaNgMedfB0Ci=kZVKm+h4T-LJoZYmbSgqA@mail.gmail.com>
Subject: Re: [PATCH RFC] dmaengine: dw-edma: Decouple dw-edma-core.c from
 struct pci_dev
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Apr 15, 2020 at 11:17 AM Gustavo Pimentel
<Gustavo.Pimentel@synopsys.com> wrote:
>
> Hi Alan,
>
> > > I like your approach, it separates the PCIe glue logic from the eDMA
> > > itself.
> > > I would suggest that pcitest would have multiple options that could be
> > > triggered, for instance:
> > >  1 - Execute Endpoint DMA (read/write) remotely with Linked List feature
> > > (from the Root Complex side)
> > >  2 - Execute Endpoint DMA (read/write) remotely without Linked List
> > > feature (from the Root Complex side)
> > >  3 - Execute Endpoint DMA (read/write) locally with Linked List feature
> > >  4 - Execute Endpoint DMA (read/write) locally without Linked List
> > > feature
> > >
> >
> > I have all of the above four use cases in mind as well. At the moment,
> > only #4 is possible with pcitest.
> >
> > Use case #3 would need a new command line option for pcitest such as -L
> > to let its user specify linked list operationwhen used with dma in
> > conjunction with the existing -D option.
> >
> > Use cases #1 and #2 would need another new command line option such as -R
> > to specify remotely initiated dma operation in conjunction with -D option.
> >
> > New code in pci-epf-test and pci_endpoint_test drivers would be needed
> > to support use cases #1, #2, and #3. However, use case #4 should be
> > possible without modification to pci-epf-test or pci_endpoint_test as long
> > as the dmaengine channels become available on the endpoint side.
>
> I would suggest something like this:
>
> -L option, local DMA triggering
> -R option, remote DMA triggering
> -W <n> option, to select the DMA write channel n => (0 ... 7) to be
> used
> -R <n> option, to select the DMA read channel n => (0 ... 7) to be
> used
> -K option, to use or not the linked list feature (K presence enables
> the LL use)
> -T <n> option, to select which type of DMA transfer to be used => (n = 0
> - scatter-gather mode, 1 - cyclic mode)
> -N <n> option, to define the number of cyclic transfers to perform in
> total
> -C <n> option, to define the size of each chunk to be used
> -t <time> option, to define a timeout for the DMA operation

That looks like a more complete set of command line options.

>
> Also, the use of this options (especially when using the remote DMA
> option) should be checked through the pci_epc_get_features(), which means
> probably we need to pass the EP features capabilities to the
> pci_endpoint_test Driver, perhaps using some sets of registers on located
> on BAR0 or other.

That is a great point. There may be changes required below pci-epf-test
in the endpoint framework stack.

>
> > At the moment, pci-epf-test grabs the first available dma channel on the
> > endpoint side and uses it for either read, write, or copy operation. it is not
> > possible at the moment to specify which dma channel to use on the pcitest
> > command line. This may be possible by modifying the command line option
> > -D to also specify the name of one or more dma channels.
>
> I'm assuming that behavior is due to your code, right? I'm not seen that
> behavior on the Kernel tree.
> Check my previous suggestion, it should be something similar to what is
> been done while you select the MSI/MSI-X interrupt to trigger.

I believe this behavior exists in the kernel tree because the call to
dma_request_chan_by_mask() always specifies channel zero. The user
of pcitest has no way of specifying which one of the available dma channels
to use.

>
> > Also, pci-epf-test grabs the dma channel at bind time and holds on to it
> > until unloaded. This denies the use of the dma channel to others on the
> > endpoint side. However, it seems possible to grab and release the dma
> > channel only for the duration of each read, write, or copy test. These are
> > improvements that can come over time. It is great that pci-epf-test was
> > recently updated to include support for dma operations which makes such
> > improvements possible.
>
> Check my previous suggestion. I think by having a timeout for the DMA
> operation we can provide a way to release the dma channel.
> Or we could provide some kind of heart beat, once again through some
> register in a BAR.

I believe this behavior exists in the kernel tree because the call to
dma_request_chan_by_mask() happens during the execution of
pci_epf_test_bind() and the call to dma_release_channel() happens
during the execution of pci_epf_test_unbind(). As long as pci-epf-test
is bound, I cannot use another program such as dmatest from the
endpoint-side command prompt to exercise the same channel.

What I was suggesting is perhaps pci-epf-test can be modified to
acquire and release the channel on each call to pci_epf_test_read(),
...write(), or ...copy() when the pcitest user specifies -D option.

>
> > > Relative to the implementation of the options 3 and 4, I wonder if the
> > > linked list memory space and size could be set through the DT or by the
> > > configfs available on the pci-epf-test driver.
> > >
> >
> > Although these options could be set through DT or by configfs, another
> > option is to enable the user of pcitest to specify such parameters on
> > the command line when invoking each test from the host side.
>
> That would be an easy and quick solution, but so far as I know there is a
> movement in the Kernel to avoid any configuration through module
> parameters. So I'm afraid that you have to choose by DT or configfs
> strategy. Kishon can help you on this matter, by telling you what he
> prefers.

Thanks for that reminder. I will check before getting too invested in a
specific implementation. Just to clarify, I was suggesting giving the
user of pcitest a way to specify which one of the available dma channel to
use on each invocation of pcitest, not what dma channels are available on
the endpoint side. I assumed the strategy for which dma channels do
become present and available on endpoint would be by DT or configfs.

>
> Regards,
> Gustavo
>
>
