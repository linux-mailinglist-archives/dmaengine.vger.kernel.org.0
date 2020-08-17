Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB204245C15
	for <lists+dmaengine@lfdr.de>; Mon, 17 Aug 2020 07:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgHQFpx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Aug 2020 01:45:53 -0400
Received: from mail1.skidata.com ([91.230.2.99]:13573 "EHLO mail1.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbgHQFpu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 17 Aug 2020 01:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=skidata.com; i=@skidata.com; q=dns/txt; s=selector1;
  t=1597643148; x=1629179148;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nC3QtiPkc2ash+7NhCkNY1Q6+j1FJN1xDaKIPykDIQE=;
  b=snSaim4MyjjKLZX3jWEe33Gahv/MJHf1llcgkhiDZqhoX+FP0fEXSaMU
   dOcTrj3pqWJGcrdoWj2QpqMaFFWRx9athoJQs8XaijFCv9ZkGoxeE9yX4
   X5i4ra6JFa5HUeOlWTX48+cIvSzcBk4AMYsytEG5MJi3b2dBuGD72DnLU
   y586m8PnqBCWThnVN4ZPWmDeRil3gxLSdvngA4ipcv2QgRg5Mq/MCvPzu
   8foGPropu2Nu+dV/7vU6EqcqImmI0CKXL86Re7mspL4ylEUjba0uZUme1
   gyM4X8hTGytmtGDJTJNvLZAc2lchxCww1dUTll9TiU90VqjCM1n4AnT2U
   A==;
IronPort-SDR: Cyb4DgRj+rCeSt/lc6ca/UWAxILZY3BwglmUQTpWJKQHBZEMAjDzPsI/XWGEqNlWzWLVt2G5t0
 ftCvLYazD3V9kXiumE7Dl9j53lr16eEt+XMB1S73ckdJQOEgch5Laa9QH2iMy1OOOEVG94MmRg
 eI1QfaSCRzXL/yYa0rMlnC+FXRsAypoOJKqbBx9YX3zNK5O6JBvu19RU57ttVdjfR64ruRgtyz
 DC2rVUWr89IXhyUIsDZjAO5qfLdU7CDpruLk5D66jwnhCxXbO6t/cAHKtunyJaZMyvRnOESEV4
 fkA=
X-IronPort-AV: E=Sophos;i="5.76,322,1592863200"; 
   d="scan'208";a="26161395"
Date:   Mon, 17 Aug 2020 07:38:36 +0200
From:   Richard Leitner <richard.leitner@skidata.com>
To:     Robin Gong <yibin.gong@nxp.com>
CC:     <dmaengine@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <timur@kernel.org>,
        <nicoleotsuka@gmail.com>, <vkoul@kernel.org>,
        <dan.j.williams@intel.com>, dl-linux-imx <linux-imx@nxp.com>,
        <shawnguo@kernel.org>, <kernel@pengutronix.de>,
        Benjamin Bara - SKIDATA <Benjamin.Bara@skidata.com>
Subject: Re: pcm|dmaengine|imx-sdma race condition on i.MX6
Message-ID: <20200817053836.GC551027@pcleri>
References: <20200813112258.GA327172@pcleri>
 <VE1PR04MB6638EE5BDBE2C65FF50B7DB889400@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <7f98cd6d30404e4d9d621f57f45ae441@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7f98cd6d30404e4d9d621f57f45ae441@skidata.com>
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex6srv.skidata.net (192.168.111.84) To
 sdex5srv.skidata.net (192.168.111.83)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Aug 14, 2020 at 11:18:10AM +0200, Robin Gong wrote:
> 
> On 2020/08/13 19:23: Richard Leitner <richard.leitner@skidata.com> wrote:
> > Hi,
> > we've found a race condition with the PCM on the i.MX6 which results 
> > in an -EIO for the SNDRV_PCM_IOCTL_READI_FRAMES ioctl after an -EPIPE (XRUN).
> > 
> > A possible reproduction may look like the following reduced call graph 
> > during a PCM capture:
> > 
> > us -> ioctl(SNDRV_PCM_IOCTL_READI_FRAMES)
> >       - wait_for_avail()
> >         - schedule_timeout()
> >    -> snd_pcm_update_hw_ptr0()
> >       - snd_pcm_update_state: EPIPE (XRUN)
> >       - sdma_disable_channel_async() # get's scheduled away due to sleep us
> > <- ioctl(SNDRV_PCM_IOCTL_READI_FRAMES) returns -EPIPE
> > us -> ioctl(SNDRV_PCM_IOCTL_PREPARE) # as reaction to the EPIPE (XRUN)
> > us -> ioctl(SNDRV_PCM_IOCTL_READI_FRAMES) # next try to capture frames
> >       - sdma_prep_dma_cyclic()
> >         - sdma_load_context() # not loaded as context_loaded is 1
> >       - wait_for_avail()
> >         - schedule_timeout()
> > # now the sdma_channel_terminate_work() comes back and sets # 
> > context_loaded = false and frees in vchan_dma_desc_free_list().
> > us <- ioctl returns -EIO (capture write error (DMA or IRQ trouble?))
>
> Seems the write error caused by context_loaded not set to false before
> next transfer start? If yes, please have a try with the 03/04 of the below
> patch set, anyway, could you post your failure log?
> https://lkml.org/lkml/2020/8/11/111

Thanks for the pointer to those patches. I've tested them on top of the
v5.8 tag during the weekend. It seems those patches are mitigiating
the described EIO issue.

Nonetheless IMHO this patches are not fixing the root cause of the
problem (unsynchronized sdma_disable_channel_async / sdma_prep_dma_cyclic).
Do you (or somebody else) have any suggestions/comments/objections on that?

regards;rl

> 
> > 
> > 
> > What we have found out, based on our understanding:
> > The dmaengine docu states that a dmaengine_terminate_async() must be 
> > followed by a dmaengine_synchronize().
> > However, in the pcm_dmaengine.c, only dmaengine_terminate_async() is 
> > called (for performance reasons and because it might be called from an 
> > interrupt handler).
> > 
> > In our tests, we saw that the user-space immediately calls
> > ioctl(SNDRV_PCM_IOCTL_PREPARE) as a handler for the happened xrun 
> > (previous ioctl(SNDRV_PCM_IOCTL_READI_FRAMES) returns with -EPIPE). In 
> > our case (imx-sdma.c), the terminate really happens asynchronously 
> > with a worker thread which is not awaited/synchronized by the
> > ioctl(SNDRV_PCM_IOCTL_PREPARE) call.
> > 
> > Since the syscall immediately enters an atomic context 
> > (snd_pcm_stream_lock_irq()), we are not able to flush the work of the 
> > termination worker from within the DMA context. This leads to an 
> > unterminated DMA getting re-initialized and then terminated.
> > 
> > On the i.MX6 platform the problem is (if I got it correctly) that the
> > sdma_channel_terminate_work() called after the -EPIPE gets scheduled 
> > away (for the 1-2ms sleep [1]). During that time the userspace already 
> > sends in the
> > ioctl(SNDRV_PCM_IOCTL_PREPARE) and
> > ioctl(SNDRV_PCM_IOCTL_READI_FRAMES).
> > As none of them are anyhow synchronized to the terminate_worker the
> > vchan_dma_desc_free_list() [2] and "sdmac->context_loaded = false;" 
> > [3] are executed during the wait_for_avail() [4] of the 
> > ioctl(SNDRV_PCM_IOCTL_READI_FRAMES).
> > 
> > To make sure we identified the problem correctly we've tested to add a 
> > "dmaengine_synchronize()" before the snd_pcm_prepare() in [5]. This 
> > fixed the race condition in all our tests. (Before we were able to 
> > reproduce it in 100% of the test runs).
> > 
> > Based on our understanding, there are two different points to ensure 
> > the
> > termination:
> > Either ensure that the termination is finished within the previous 
> > SNDRV_PCM_IOCTL_READI_FRAMES call (inside the DMA context) or 
> > finishing it in the SNDRV_PCM_IOCTL_PREPARE call (and all other 
> > applicable ioclts) before entering the atomic context (from the PCM context).
> > 
> > We initially thought about implementing the first approach, basically 
> > splitting up the dma_device terminate_all operation into a sync
> > (busy-wait) and a async one. This would align the operations with the 
> > DMAengine interface and would enable a sync termination variant from 
> > atomic contexts.
> > However, we saw that the dma_free_attrs() function has a WARN_ON on 
> > irqs disabled, which would be the case for the sync variant.
> > Side note: We found this issue on the current v5.4.y LTS branch, but 
> > it also affects v5.8.y.
> > 
> > Any feedback or pointers how we may fix the problem are warmly welcome!
> > If anything is unclear please just ask :-)
> > 
> > regards;
> > Richard Leitner
> > Benjamin Bara
