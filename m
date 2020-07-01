Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37265211056
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2020 18:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731894AbgGAQN5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Jul 2020 12:13:57 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:38169 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730645AbgGAQN5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Jul 2020 12:13:57 -0400
Received: from oxbagw00.schlund.de ([172.19.245.10]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MOm9H-1jSFQC0Orf-00Q878; Wed, 01 Jul 2020 18:13:47 +0200
Date:   Wed, 1 Jul 2020 18:13:46 +0200 (CEST)
From:   Thomas Ruf <freelancer@rufusul.de>
Reply-To: Thomas Ruf <freelancer@rufusul.de>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Federico Vaga <federico.vaga@cern.ch>,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <449688975.51579.1593620026422@mailbusiness.ionos.de>
In-Reply-To: <391e0aee-e35b-fa39-ab86-18fe33a776ee@ti.com>
References: <5614531.lOV4Wx5bFT@harkonnen>
 <fe199e18-be45-cadc-8bad-4a83ed87bfba@intel.com>
 <20200621072457.GA2324254@vkoul-mobl>
 <20200621203634.y3tejmh6j4knf5iz@cwe-513-vol689.cern.ch>
 <20200622044733.GB2324254@vkoul-mobl>
 <419762761.402939.1592827272368@mailbusiness.ionos.de>
 <20200622155440.GM2324254@vkoul-mobl>
 <1835214773.354594.1592843644540@mailbusiness.ionos.de>
 <2077253476.601371.1592991035969@mailbusiness.ionos.de>
 <20200624093800.GV2324254@vkoul-mobl>
 <3a4b1b55-7bce-2c48-b897-51e23e850127@ti.com>
 <1666251320.1024432.1593007095381@mailbusiness.ionos.de>
 <1a610c67-73a4-f66d-877a-5c4d35cbf76a@ti.com>
 <1819433567.1017000.1593443883087@mailbusiness.ionos.de>
 <391e0aee-e35b-fa39-ab86-18fe33a776ee@ti.com>
Subject: Re: DMA Engine: Transfer From Userspace
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.1-Rev31
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:YQ5W6ylaeMA5dpF4vIOq0nmsJPbv1263ZseTm3PhFbiJmwULMMT
 IEZxVJDQ3Kwfvod9HAi/AKOf+oU2R7UMuvc/hqKbBOaEhPsJDlEDzZkaoHaxHdydawJD2rA
 YAPeKtNyniqcyKpXurj+2hck3sUacedn75dEMDep35rfIb+9MFg5JXa3ktbV1W5wKwZh2oe
 SEuV2CUHS09+3AO56qT2w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TpkBnOBjGNo=:USjjnKpSjvo9B9ZKzStK5p
 0Elll93db5KN903n/ukfvmjOwVnYHV1ET2opJX0iKCBcfEFgFYN6wJ4eUYNzPuLPUFpc9AzsD
 fQ+D8ffj7xjoIExEFEZaAJPW+k5iasYzIBpnrf9XpNT2Y7e4MyUFP2hUOEFzlTFeoj8etXsGG
 HDM1GQ+cppDk4vzAdqLg4pHnhs9YfG44HmCE2irT14CxiDZp4KQfpibxeRLWJu2mgpLY3FzUY
 KkCuRHsFmE7h+JIUsm3T7g7AJM09N2Wji0AkMdxrVt76jfX/i741WA4l6fPtIEXrxcqxo9cD8
 eTHRMlcA18XAHbOCidvSsTgChuDDJgE0uXJ4nzKecdcod3ZgLkjqikdK86ua5qBDyvYg9AhGh
 aKd4wC2aRZeiFtqaukVU4ZJmobEFrf0T+5AhbCwId9En/763kFaWma8lTJHWi5tGWzqEdcXfL
 kikpsFIERzv8OLnrWfO0JTGroqTMw/HR4PAc34jYRaZGywfxlOg5YgY3tBnWGK4GX0uQlauA8
 pDv4rmaCZv4eqAgFOlcSsF/4Z+EVMHAYcD6KIfelRk122loItQ6wTJmyfBu7aI2cJcWPFj/Em
 O0VjNLB9y9/cSiAZYEvDRxPNLrveQGV6Dq2pwDTsEAfnw+K0nNcNRtAy8DAtDKgQpz+iHRgcq
 9UF89357FfvZ0XNdZ2ZbFk2hH5NtevyYKVNB8EvYqXwUBb+G+/s+xKu0JDrmNP6HXQXguurHg
 Llzukc15plkBXhFFLLYC9uz0FtPNey75bm+x2ARs9vkCM57EQqr0fpkXwBf4K/fW8INGWopH1
 5FvlTwlCJhki7fYfrb5UbjzAKVLTlXiegjTRv3uhhLRHDyI/98=
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


> On 30 June 2020 at 14:31 Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> 
> 
> 
> 
> On 29/06/2020 18.18, Thomas Ruf wrote:
> > 
> >> On 26 June 2020 at 12:29 Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> >>
> >> On 24/06/2020 16.58, Thomas Ruf wrote:
> >>>
> >>>> On 24 June 2020 at 14:07 Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> >>>> On 24/06/2020 12.38, Vinod Koul wrote:
> >>>>> On 24-06-20, 11:30, Thomas Ruf wrote:
> >>>>>
> >>>>>> To make it short - i have two questions:
> >>>>>> - what are the chances to revive DMA_SG?
> >>>>>
> >>>>> 100%, if we have a in-kernel user
> >>>>
> >>>> Most DMAs can not handle differently provisioned sg_list for src and dst.
> >>>> Even if they could handle non symmetric SG setup it requires entirely
> >>>> different setup (two independent channels sending the data to each
> >>>> other, one reads, the other writes?).
> >>>
> >>> Ok, i implemented that using zynqmp_dma on a Xilinx Zynq platform (obviously ;-) and it works nicely for us.
> >>
> >> I see, if the HW does not support it then something along the lines of
> >> what the atc_prep_dma_sg did can be implemented for most engines.
> >>
> >> In essence: create a new set of sg_list which is symmetric.
> > 
> > Sorry, not sure if i understand you right?
> > You suggest that in case DMA_SG gets revived we should restrict the support to symmetric sg_lists?
> 
> No, not at all. That would not make much sense.

Glad that this was just a misunderstanding.

> > Just had a glance at the deleted code and the *_prep_dma_sg of these drivers had code to support asymmetric lists and by that "unaligend" memory (relative to page start):
> > at_hdmac.c         
> > dmaengine.c        
> > dmatest.c          
> > fsldma.c           
> > mv_xor.c           
> > nbpfaxi.c          
> > ste_dma40.c        
> > xgene-dma.c        
> > xilinx/zynqmp_dma.c
> > 
> > Why not just revive that and keep this nice functionality? ;-)
> 
> What I'm saying is that the drivers (at least at_hdmac) in essence
> creates aligned sg_list out from the received non aligned ones.
> It does this w/o actually creating the sg_list itself, but that's just a
> small detail.
> 
> In a longer run what might make sense is to have a helper function to
> convert two non symmetric sg_list into two symmetric ones so drivers
> will not have to re-implement the same code and they will only need to
> care about symmetric sg lists.

Sounds like a superb idea!

> Note, some DMAs can actually handle non symmetric src and dst lists, but
> I believe it is rare.

So i was a bit lucky that the zynqmp_dma is one of them.
 
> >> What might be plausible is to introduce hw offloading support for memcpy
> >> type of operations in a similar fashion how for example crypto does it?
> > 
> > Sounds good to me, my proxy driver implementation could be a good start for that, too!
> 
> It needs to find it's place as well... I'm not sure where that would be.
> Simple block-copy offload, sg copy offload, interleaved offload (frame
> extraction) offload, dmabuf copy offload comes to mind as candidates.

And who would decide that...

> >> The issue with a user space implemented logic is that it is not portable
> >> between systems with different DMAs. It might be that on one DMA the
> >> setup takes longer than do a CPU copy of X bytes, on the other DMA it
> >> might be significantly less or higher.
> > 
> > Fully agree with that!
> > I was also unsure how my approach will perform but in our case the latency was increased by ~20%, cpu load roughly stayed the same, of course this was the benchmark from user memory to user memory.
> > From uncached to user memory the DMA was around 15 times faster.
> 
> It depends on the size of the transfer. Lots of small individual
> transfers might be worst via DMA do the the setup time, completion
> handling, etc.

Yes, exactly.

Thanks again for your great input!

best regards,
Thomas

PS: I am on vacation for the next two weaks and probably will not check this mailing list till 20.7. But will fetch later.
