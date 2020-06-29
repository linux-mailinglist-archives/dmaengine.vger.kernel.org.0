Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56EA520D791
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2020 22:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733086AbgF2TbE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Jun 2020 15:31:04 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:55083 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732882AbgF2TbD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 Jun 2020 15:31:03 -0400
Received: from oxbsgw01.schlund.de ([172.19.248.2]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MAwsT-1jfFMA3PSL-00BKYS; Mon, 29 Jun 2020 17:18:03 +0200
Date:   Mon, 29 Jun 2020 17:18:03 +0200 (CEST)
From:   Thomas Ruf <freelancer@rufusul.de>
Reply-To: Thomas Ruf <freelancer@rufusul.de>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Federico Vaga <federico.vaga@cern.ch>,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1819433567.1017000.1593443883087@mailbusiness.ionos.de>
In-Reply-To: <1a610c67-73a4-f66d-877a-5c4d35cbf76a@ti.com>
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
Subject: Re: DMA Engine: Transfer From Userspace
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.1-Rev31
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:0alu9hg38pkybOq3iJxwmHVEVhVEw1sr8eQ75Y/nnGhZrOHc56q
 KnCMQxVAAqi6CVKlsvSFzR0miHE0QLtfdHN9FcqgLg/Xp6oA4PW8dfS9HDQj1Rcwup3+vg1
 GAqclm2ZSSRnNifE5kXwXnL/a/i+ZQoGe8iohunl/jWK3XGW6nvHaCdZJVCB0D+Vr1oilu8
 TfvavTwDqsY+QPSw5ckAA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3igQ/si8Atg=:y8YQHiCVrnwZXMe86byMWT
 PP1lHFKq4KUzNb/xf+ZINJpwFQJwBuMf7xY9xMcno54kmAOhoaoRfHCtYGyLUUSs3s2E9Shs8
 IpGZH0/9xkftyoCFhyOE2IRbMqUEX8EamBBikncxjt8RjbCmZ6YH5ibnDaL5bOqFPn8pQHq2m
 Hhvcz+Idzm+0wXoZB0KW3FtbZN0EYIbnfzPDQp3NGRg/HQegXRyT7RiKol4v+flpXpmvEAc7f
 +RuK/hQqVASDgfP6iAhX6M/07fepZkMa2HIev6mlUCar0G47EHayL7Koh8cmYZvsqT5nfNeid
 HsMZZPrXA/OrMhB4Sis2wKMw/QqGsCWHQ0WzhS+d9x1i8FOJsm1YHXoFlNoIPSaHUE4iN969d
 vU4zLDRdZq2Lih8MVoUpbWXwAkdH3AfWERJURzQkNDJolzujHarKN7m1GYn5bLFBLWAFKQCzH
 wDzs7IFor/OJNDrxrG5qdHcLuArH8K80pjPh01REZslbPLod+2LbrUsQCA8K3rG1HM3qKDL9V
 96hDwLSKM9h3QWzO0aY/dw67O15y6BQ/kSIms9zY6/4Q2qDt8CnNUV9ypPdvVp4rbVcJugdS0
 LsZBCLcjlBi4EjWgGy0SWyzAi3il2J5iBHh3BM6EG/wq2Cx6vcgHPU/FardUpLoXqlxqUWg0R
 chSjclEkwoLT4pzS2HmwVRxgjsIHxjPnJIYkHOOjV2RWjC2AO5fgm9fVDtwriLODLwUPV6iLp
 0TMBVe3XLjwAF8KMftfDHFY3OdRpPiaMkBnIpEj1/SWYThPDBL5kKJrEU9oRTVf3jqP/5AqJh
 TlXUdHEQPtf2ToVZ4CuXltCERNy6dix+X2GHjoci5bBZEBpNX8=
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


> On 26 June 2020 at 12:29 Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> 
> On 24/06/2020 16.58, Thomas Ruf wrote:
> > 
> >> On 24 June 2020 at 14:07 Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> >> On 24/06/2020 12.38, Vinod Koul wrote:
> >>> On 24-06-20, 11:30, Thomas Ruf wrote:
> >>>
> >>>> To make it short - i have two questions:
> >>>> - what are the chances to revive DMA_SG?
> >>>
> >>> 100%, if we have a in-kernel user
> >>
> >> Most DMAs can not handle differently provisioned sg_list for src and dst.
> >> Even if they could handle non symmetric SG setup it requires entirely
> >> different setup (two independent channels sending the data to each
> >> other, one reads, the other writes?).
> > 
> > Ok, i implemented that using zynqmp_dma on a Xilinx Zynq platform (obviously ;-) and it works nicely for us.
> 
> I see, if the HW does not support it then something along the lines of
> what the atc_prep_dma_sg did can be implemented for most engines.
> 
> In essence: create a new set of sg_list which is symmetric.

Sorry, not sure if i understand you right?
You suggest that in case DMA_SG gets revived we should restrict the support to symmetric sg_lists?
Just had a glance at the deleted code and the *_prep_dma_sg of these drivers had code to support asymmetric lists and by that "unaligend" memory (relative to page start):
at_hdmac.c         
dmaengine.c        
dmatest.c          
fsldma.c           
mv_xor.c           
nbpfaxi.c          
ste_dma40.c        
xgene-dma.c        
xilinx/zynqmp_dma.c

Why not just revive that and keep this nice functionality? ;-)

> > Don't think that it uses two channels from what a saw in their implementation.
> 
> I believe it was breaking it up like atc_prep_dma_sg did.
> 
> > Of course that was on kernel 4.19.x where DMA_SG was still available.
> > 
> >>>> - what are the chances to get my driver for memcpy like transfers from
> >>>> user space using DMA_SG upstream? ("dma-sg-proxy")
> >>>
> >>> pretty bleak IMHO.
> >>
> >> fwiw, I also get requests time-to-time to DMA memcpy support from user
> >> space from companies trying to move from bare-metal code to Linux.
> >>
> >> What could be plausible is a generic dmabuf-to-dmabuf copy driver (V4L2
> >> can provide dma-buf, DRM can also).
> >> If there is a DMA memcpy channel available, use that, otherwise use some
> >> method to do the copy, user space should not care how it is done.
> > 
> > Yes, i'm using it together with a v4l2 capture driver and also saw the dma-buf thing but did not find a way how to bring this together with "ordinary user memory".
> 
> One of the aim of dma-buf is to share buffers between drivers and user
> space (among drivers and/or drivers and userspace), but I might be
> missing something.
> 
> > For me the root of my problem seems to be that dma_alloc_coherent leads to uncached memory on ARM platforms.
> 
> It depends, but in most cases that is true.
> 
> > But maybe i am doing it all wrong ;-)
> > 
> >> Where things are going to get a bit more trickier is when the copy needs
> >> to be triggered by other DMA channel (completion of a frame reception
> >> triggering an interleaved sub-frame extraction copy).
> >> You don't want to extract from a buffer which can be modified while the
> >> other channel is writing to it.
> > 
> > I think that would be no problem in case of our v4l2 capture driver doing both DMAs:
> > Framebuffer DMA for streaming and Zynqmp DMA (using DMA_SG) to get it to "ordinary user memory".
> > But as i wrote before i prefer to do the "logic and management" in userspace so the capture driver is just using the first DMA and the "dma-sg-proxy" driver is only used as a memcpy replacement.
> > As said this is all working fine with kernel 4.19.x but now we are stuck :-(
> > 
> >> In Linux the DMA is used for kernel and user space can only use it
> >> implicitly via standard subsystems.
> >> Misused DMA can be very dangerous and giving full access to program a
> >> transfer can open a can of worms.
> > 
> > Fully understand that!
> > But i also hope you understand that we are developing a "closed system" and do not have a problem with that at all.
> > We are also willing to bring that driver upstream for anyone doing the same but of course this should not affect security of any desktop or server systems.
> > Maybe we just need the right place for that driver?!
> 
> What might be plausible is to introduce hw offloading support for memcpy
> type of operations in a similar fashion how for example crypto does it?

Sounds good to me, my proxy driver implementation could be a good start for that, too!
 
> The issue with a user space implemented logic is that it is not portable
> between systems with different DMAs. It might be that on one DMA the
> setup takes longer than do a CPU copy of X bytes, on the other DMA it
> might be significantly less or higher.

Fully agree with that!
I was also unsure how my approach will perform but in our case the latency was increased by ~20%, cpu load roughly stayed the same, of course this was the benchmark from user memory to user memory.
From uncached to user memory the DMA was around 15 times faster.

> Using CPU vs DMA for a copy in certain lengths and setups should not be
> a concern of the user space.

Also fully agree with that!

> Yes, you have a closed system with controlled parameters, but a generic
> mem2mem_offload framework should be usable on other setups and the same
> binary should be working on different DMAs where one is not efficient
> for <512 bytes, the other shows benefits under 128bytes.

Usable: of course
"Faster": not necessarily as long as it is an option

Thanks for your valuable input and suggestions!

best regards,
Thomas
