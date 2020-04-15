Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54861AB35A
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2020 23:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442401AbgDOVYW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Apr 2020 17:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2442402AbgDOVYL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Apr 2020 17:24:11 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A1CC061A0F
        for <dmaengine@vger.kernel.org>; Wed, 15 Apr 2020 14:24:04 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q19so5389936ljp.9
        for <dmaengine@vger.kernel.org>; Wed, 15 Apr 2020 14:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zUiwPngCjCOT149YM1CpaUAyMcgHTCV4FZO5uSdXs+4=;
        b=N0VtjTbSPmMQI+RlTx1yObqj6x91R6W/fup4bZ4ZAA+dHBABtXgciXtch5GcEGhoHH
         JmpIDKEpx4dr8jnrsQA60GzCYrlGW1Im7DMFGyc+RQhpSKlgA1M3aP69+t2Ip2Dqd4Qm
         cEOqAB/oeDbu0bTlvmUdRScVlX+VDAHyy4VjpGfwHVHPml+4gftSkW+dnlvSr7e6+z6K
         fDyudV/9jxQQ+0tlIrcRokGYM4WOiJjnPRZKJTpxln1seAqdLqi+lqYzf/JdgR32fPD+
         1W0RZJJw1XOxnLJtjsatcvivLOwJtvEPGPqvG+kdDzn390e0JVGwfXJrIfTR1sKBmDuj
         2Vtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zUiwPngCjCOT149YM1CpaUAyMcgHTCV4FZO5uSdXs+4=;
        b=l2bt07G+uqVABK1ZoFK6RRw9YMdpsDbfM3PHt8ULgiafdIA+ThtB2KKRGje+eejLLF
         2o8t/JOw5js+FEw/2x0vaIEbi0FHlie7EgvzluYveua56iqNB7nkpJVZ1mrGVuckeepa
         0CwEi83RQNwU0YrGtqn0kJyE9PaiZ/musdbP2/20mkKWs3UXIdEmD/Hm2Dbxie8T+Ikj
         sVckoJiDevTr/GM/k/wFD3iRWUfaJVysQHNhitha9iyhuYomQ+psHKvzkSN6jaBJX4pE
         fwx15vmsAgTLDpY/Sx1GxxvDM4+xKrKscOIACglUO9ix9AFrmq/CtvUo1abWFkrKzrPJ
         XTkg==
X-Gm-Message-State: AGi0PuZsNMo11xt9JUERMSEdR41Vygaq8/Cq7n8rAOSoPt2/iRkx4mrH
        2u57aKhw8bhad/CFYPNJ6M8dhTyZFbjrtptt851F5g==
X-Google-Smtp-Source: APiQypIOBCwRkWiDlV64pN+RvUzocju2VTLfH55G/LdorNT2T1+BVYwjjGnn2AsvN+E5sbPB+MNiKYSe4EI4Mugszi4=
X-Received: by 2002:a2e:8056:: with SMTP id p22mr4614252ljg.266.1586985842846;
 Wed, 15 Apr 2020 14:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <1586916464-27727-1-git-send-email-alan.mikhak@sifive.com>
 <DM5PR12MB1276CB8FA4457D4CDCE3137EDADB0@DM5PR12MB1276.namprd12.prod.outlook.com>
 <CABEDWGwYmO52g6cqvQdWb6HXWEHaMA1rcf96aUqv0f32tJZT-g@mail.gmail.com>
 <DM5PR12MB1276E09460BD4DB7E70EAF91DADB0@DM5PR12MB1276.namprd12.prod.outlook.com>
 <CABEDWGw0OyQNppLpDaNgMedfB0Ci=kZVKm+h4T-LJoZYmbSgqA@mail.gmail.com> <DM5PR12MB127673CFDCA38A47E6F6F4DBDADB0@DM5PR12MB1276.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB127673CFDCA38A47E6F6F4DBDADB0@DM5PR12MB1276.namprd12.prod.outlook.com>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Wed, 15 Apr 2020 14:23:51 -0700
Message-ID: <CABEDWGyUfq4c65K+btmKBcGLv59h6PFVUkSD_52kOw9R0Rtynw@mail.gmail.com>
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

On Wed, Apr 15, 2020 at 1:58 PM Gustavo Pimentel
<Gustavo.Pimentel@synopsys.com> wrote:
>
> Hi Alan,
>
> > > > At the moment, pci-epf-test grabs the first available dma channel on the
> > > > endpoint side and uses it for either read, write, or copy operation. it is not
> > > > possible at the moment to specify which dma channel to use on the pcitest
> > > > command line. This may be possible by modifying the command line option
> > > > -D to also specify the name of one or more dma channels.
> > >
> > > I'm assuming that behavior is due to your code, right? I'm not seen that
> > > behavior on the Kernel tree.
> > > Check my previous suggestion, it should be something similar to what is
> > > been done while you select the MSI/MSI-X interrupt to trigger.
> >
> > I believe this behavior exists in the kernel tree because the call to
> > dma_request_chan_by_mask() always specifies channel zero. The user
> > of pcitest has no way of specifying which one of the available dma channels
> > to use.
>
> I think we were discussing different things. I was referring to the
> pci-epf-test code, that I wasn't being able to find any instruction to
> call the DMA driver which had the described behavior.
>
> I think you can do it by doing this:
>
> Pseudo code:
>
> #define EDMA_TEST_CHANNEL_NAME                  "dma%uchan%u"
>
> static bool dw_edma_test_filter(struct dma_chan *chan, void *filter)
> {
>         if (strcmp(dev_name(chan->device->dev), EDMA_TEST_DEVICE_NAME) ||
> strcmp(dma_chan_name(chan), filter))
>                 return false;
>
>         return true;
> }
>
> static void dw_edma_test_thread_create(int id, int channel)
> {
>         struct dma_chan *chan;
>         dma_cap_mask_t mask;
>         char filter[20];
>
>         dma_cap_zero(mask);
>         dma_cap_set(DMA_SLAVE, mask);
>         dma_cap_set(DMA_CYCLIC, mask);
>
>         snprintf(filter, sizeof(filter), EDMA_TEST_CHANNEL_NAME, id,
> channel);
>         chan = dma_request_channel(mask, dw_edma_test_filter, filter);
>
>         [..]
> }

Thanks Gustavo, This pseudo code is very useful. Now I know how to do
that part of the change.

What I have further in mind is to enable the pcitest user to specify some
arbitrary string with -D option to select one or more of the dma channels
that are available on the endpoint side. Since the user executes pcitest
from host-side command prompt and pci-epf-test executes in kernel on the
endpoint side, the messaging between userspace pcitest and kernel-space
pci_endpoint_test as well as the messaging across the bus between
pci_endpoint_test and pci-epf-test needs to be expanded to pass the user
string from the host to the endpoint. Upon receiving each read, write, or
copy message, pci-epf-test could then try to acquire the specified dma
channel and execute the user command or fail it if no such channel is
available at that moment.

>
> > I believe this behavior exists in the kernel tree because the call to
> > dma_request_chan_by_mask() happens during the execution of
> > pci_epf_test_bind() and the call to dma_release_channel() happens
> > during the execution of pci_epf_test_unbind(). As long as pci-epf-test
> > is bound, I cannot use another program such as dmatest from the
> > endpoint-side command prompt to exercise the same channel.
>
> Ok, I understood it now. Right, you can't use the dmatest here, even
> because, as far as I know, it is only MEM TO MEM operations and we need
> DEVICE_TO_MEM and vice-versa.
>
> >
> > What I was suggesting is perhaps pci-epf-test can be modified to
> > acquire and release the channel on each call to pci_epf_test_read(),
> > ...write(), or ...copy() when the pcitest user specifies -D option.
>
> Right, you are on the right track.
> Perhaps you could take a look at patch [1] that I have done some time ago
> for testing the eDMA, I think you have all the tools/guideline there to
> do this adaption.
> Another thing,
>
> [1] https://patchwork.kernel.org/patch/10760521/

Thanks for the guidance and reference code patch [1]. I will definitely
take a close look at [1].

>
>
>
