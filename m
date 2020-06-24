Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97658207512
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2020 15:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391062AbgFXN62 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Jun 2020 09:58:28 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:36891 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389484AbgFXN62 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Jun 2020 09:58:28 -0400
Received: from oxbsgw04.schlund.de ([172.19.248.7]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N8XHV-1ijuKP0IJF-014Qx8; Wed, 24 Jun 2020 15:58:16 +0200
Date:   Wed, 24 Jun 2020 15:58:15 +0200 (CEST)
From:   Thomas Ruf <freelancer@rufusul.de>
Reply-To: Thomas Ruf <freelancer@rufusul.de>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Federico Vaga <federico.vaga@cern.ch>,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1666251320.1024432.1593007095381@mailbusiness.ionos.de>
In-Reply-To: <3a4b1b55-7bce-2c48-b897-51e23e850127@ti.com>
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
Subject: Re: DMA Engine: Transfer From Userspace
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.1-Rev31
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:ZBfT/UeW/LXGLEVtPuKecLJW94asLyjfD3Obh+lLCiFdtM5i8Fc
 mwxM+RB4KIyVrMoHJkU+Qw4B+jlEdTfCtEpItXBfsKAGjcc6YC6cwp5ZnqwqQLyL0c/CEF6
 pldzObn4pXLWixPR/GdhkOskMWOnfEpgtBitI7xQD258moZsZDpb2suHQ6M7b2j93zCMlEz
 DQmaQ2efYe7thbztXh84A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cYIjz2bXiFo=:UL1jBVi7h8H+tqcGlMLtDs
 Z4zBeatKITkR7IMu23faR2gObmijbUnqv8hu37r5zFaK4w59EWjbhYJVhQkyk40mRETLqjcXi
 Hc5JC0MVA585lMRI4w5WNaOrbtCTgq8YUnr7TS5uDqurwm9goB2vpB6fYezwRSQcbVXrtmfjw
 wsvQpEfJz4vLJIINnbPNxUMDbLa/m+h9LrfQ2ILgC8owxCZpWZao0TyjEYJ9YUo9zEI6dNX0k
 9Ni+C30dVjIApkN6KGGGpUEKNCuOqc4nX8JRncACnHloS4tu+CX3wbo9/3JB0mU0Y342MPxLc
 1/WgkddbKtKS56DzYw7awdeo+b/e+ES0m5uJHn4xt4LZle5YxHLA2ztAGEsLz/fIBWYj3Lvi+
 6segxA/d2WCOkdPx6nxCyOndo0xcb9E00rwKf9YQT3SdNOfzcT5LJNHpGZIR0Jr5dAI0toQw2
 9U0x2MDeJKzIHVhub3fvxTo+w/nfplUxFEOs84p0UdVNKk5RhbDlix2wTmHENt3mzmjS8xITu
 ACZd+30tqKBxk71YFtuG9rFByV4c2svLPhW1gHsK81gh3pgOPAy18prnC7iXiCYa84/s2BQZx
 tfM/L0qUBkWMGm2a7HzzyvK/DAnN0hDDNqSrdgPmT3l0o9ftC/XqjvmzGYGlvsivaL46BcIPE
 lqS4Qn15M1jHn4hTkWUWjb3PrCG8z490gnwmkSjVozumpI5WKsmRg5Cm0797u6PwPEyDeB+Rm
 vRHP/c8sSGFdtbMxk3orQ6EiwoH2SR4wseoXyg5LcgY0L0+tUlUrlQUVIzmYMH4b9ArQf6Ytk
 JfN19ir1S7XBKJjBPTx+Xv8WDLB2oDWhOq92KFk0khXehf+bMHed259L+xlj96EwJRDFEMT
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


> On 24 June 2020 at 14:07 Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> On 24/06/2020 12.38, Vinod Koul wrote:
> > On 24-06-20, 11:30, Thomas Ruf wrote:
> > 
> >> To make it short - i have two questions:
> >> - what are the chances to revive DMA_SG?
> > 
> > 100%, if we have a in-kernel user
> 
> Most DMAs can not handle differently provisioned sg_list for src and dst.
> Even if they could handle non symmetric SG setup it requires entirely
> different setup (two independent channels sending the data to each
> other, one reads, the other writes?).

Ok, i implemented that using zynqmp_dma on a Xilinx Zynq platform (obviously ;-) and it works nicely for us.
Don't think that it uses two channels from what a saw in their implementation.
Of course that was on kernel 4.19.x where DMA_SG was still available.

> >> - what are the chances to get my driver for memcpy like transfers from
> >> user space using DMA_SG upstream? ("dma-sg-proxy")
> > 
> > pretty bleak IMHO.
> 
> fwiw, I also get requests time-to-time to DMA memcpy support from user
> space from companies trying to move from bare-metal code to Linux.
> 
> What could be plausible is a generic dmabuf-to-dmabuf copy driver (V4L2
> can provide dma-buf, DRM can also).
> If there is a DMA memcpy channel available, use that, otherwise use some
> method to do the copy, user space should not care how it is done.

Yes, i'm using it together with a v4l2 capture driver and also saw the dma-buf thing but did not find a way how to bring this together with "ordinary user memory". For me the root of my problem seems to be that dma_alloc_coherent leads to uncached memory on ARM platforms. But maybe i am doing it all wrong ;-)

> Where things are going to get a bit more trickier is when the copy needs
> to be triggered by other DMA channel (completion of a frame reception
> triggering an interleaved sub-frame extraction copy).
> You don't want to extract from a buffer which can be modified while the
> other channel is writing to it.

I think that would be no problem in case of our v4l2 capture driver doing both DMAs:
Framebuffer DMA for streaming and Zynqmp DMA (using DMA_SG) to get it to "ordinary user memory".
But as i wrote before i prefer to do the "logic and management" in userspace so the capture driver is just using the first DMA and the "dma-sg-proxy" driver is only used as a memcpy replacement.
As said this is all working fine with kernel 4.19.x but now we are stuck :-(

> In Linux the DMA is used for kernel and user space can only use it
> implicitly via standard subsystems.
> Misused DMA can be very dangerous and giving full access to program a
> transfer can open a can of worms.

Fully understand that!
But i also hope you understand that we are developing a "closed system" and do not have a problem with that at all.
We are also willing to bring that driver upstream for anyone doing the same but of course this should not affect security of any desktop or server systems.
Maybe we just need the right place for that driver?!
Not sure if staging would change your concerns.

Thanks and best regards,
Thomas
