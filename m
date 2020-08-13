Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5C8243957
	for <lists+dmaengine@lfdr.de>; Thu, 13 Aug 2020 13:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgHMLaP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Aug 2020 07:30:15 -0400
Received: from mail2.skidata.com ([91.230.2.91]:34726 "EHLO mail2.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgHMLaO (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 13 Aug 2020 07:30:14 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Aug 2020 07:30:12 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=skidata.com; i=@skidata.com; q=dns/txt; s=selector1;
  t=1597318212; x=1628854212;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=89bAGdQq58IWsLtFPLh9wpw9ICJ6Mc83yC/h2CpVF7Y=;
  b=gmiIs9xB40mH5A5EZR2XIW6s9njJ+NmW1Jbq8TKZrHpuAX42r+Qo2ETa
   MEkO42ZuX6gv+G+6Dt7Zk68YEc836Z4GbWXRS8+7emfWPQKZ54ThPsLBL
   cNORA9GoL4kI1YtlLLMEl8KS4d82vdXrwZiRSt6uOJSgAknvzTBHDgzeQ
   GlXOrV2WmuYbi+UNI/BrybRyWROEvHqKzGIjdfCJRe9vPHiPvgVhtqwYQ
   xS64s8kIFaZZOAmNcXl01Ewkci2pB5eZcsSYk/KOsJ/1eRuxK4iKQyfr1
   H/XLIFePptK55urI2+7zpSuugKYtVo0GjQpw9Cx0zzyVhu1Xd9caC+SMn
   w==;
IronPort-SDR: g2o/GJDhU0h+zjPmQsuKI9ODAT/nVkeCiipCpG2uwpWm3Ae9iIIdcYGq0fMra8Ta3DFaRKw9EN
 QHBiww9oRQd1JARQBabv+Mtm/liFgUXSvJNk1lVA4Sn+BgZlk68O6Yp7I/qdZbSH89QuUn4G8p
 bHRgOEaC8nffSuA5+pzf4rHSs7uX7mvkRpbaWzW3tNAD61xzP6sUICpmgLgiQ3BHpmpR4MGc0n
 Z3a5yxwqqljYiuMXgJWpi4RtTZw/LJi7D9uHi++qB7ptZ6mu0pQJA9I0ZlmGWFaIjYC/4aIRDr
 TJ4=
X-IronPort-AV: E=Sophos;i="5.76,308,1592863200"; 
   d="scan'208";a="2640424"
Date:   Thu, 13 Aug 2020 13:22:58 +0200
From:   Richard Leitner <richard.leitner@skidata.com>
To:     <dmaengine@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <timur@kernel.org>, <nicoleotsuka@gmail.com>, <vkoul@kernel.org>,
        <dan.j.williams@intel.com>, <linux-imx@nxp.com>,
        <shawnguo@kernel.org>, <kernel@pengutronix.de>,
        Benjamin Bara <benjamin.bara@skidata.com>
Subject: pcm|dmaengine|imx-sdma race condition on i.MX6
Message-ID: <20200813112258.GA327172@pcleri>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex6srv.skidata.net (192.168.111.84) To
 sdex5srv.skidata.net (192.168.111.83)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,
we've found a race condition with the PCM on the i.MX6 which results in
an -EIO for the SNDRV_PCM_IOCTL_READI_FRAMES ioctl after an -EPIPE (XRUN).

A possible reproduction may look like the following reduced call graph
during a PCM capture:

us -> ioctl(SNDRV_PCM_IOCTL_READI_FRAMES)
      - wait_for_avail()
        - schedule_timeout()
   -> snd_pcm_update_hw_ptr0()
      - snd_pcm_update_state: EPIPE (XRUN)
      - sdma_disable_channel_async() # get's scheduled away due to sleep
us <- ioctl(SNDRV_PCM_IOCTL_READI_FRAMES) returns -EPIPE
us -> ioctl(SNDRV_PCM_IOCTL_PREPARE) # as reaction to the EPIPE (XRUN)
us -> ioctl(SNDRV_PCM_IOCTL_READI_FRAMES) # next try to capture frames
      - sdma_prep_dma_cyclic()
        - sdma_load_context() # not loaded as context_loaded is 1
      - wait_for_avail()
        - schedule_timeout()
# now the sdma_channel_terminate_work() comes back and sets
# context_loaded = false and frees in vchan_dma_desc_free_list().
us <- ioctl returns -EIO (capture write error (DMA or IRQ trouble?))


What we have found out, based on our understanding:
The dmaengine docu states that a dmaengine_terminate_async() must be
followed by a dmaengine_synchronize().
However, in the pcm_dmaengine.c, only dmaengine_terminate_async() is
called (for performance reasons and because it might be called from an
interrupt handler).

In our tests, we saw that the user-space immediately calls
ioctl(SNDRV_PCM_IOCTL_PREPARE) as a handler for the happened xrun
(previous ioctl(SNDRV_PCM_IOCTL_READI_FRAMES) returns with -EPIPE). In
our case (imx-sdma.c), the terminate really happens asynchronously with
a worker thread which is not awaited/synchronized by the
ioctl(SNDRV_PCM_IOCTL_PREPARE) call.

Since the syscall immediately enters an atomic context
(snd_pcm_stream_lock_irq()), we are not able to flush the work of the
termination worker from within the DMA context. This leads to an
unterminated DMA getting re-initialized and then terminated.

On the i.MX6 platform the problem is (if I got it correctly) that the
sdma_channel_terminate_work() called after the -EPIPE gets scheduled
away (for the 1-2ms sleep [1]). During that time the userspace already
sends in the ioctl(SNDRV_PCM_IOCTL_PREPARE) and
ioctl(SNDRV_PCM_IOCTL_READI_FRAMES).
As none of them are anyhow synchronized to the terminate_worker the
vchan_dma_desc_free_list() [2] and "sdmac->context_loaded = false;" [3]
are executed during the wait_for_avail() [4] of the
ioctl(SNDRV_PCM_IOCTL_READI_FRAMES).

To make sure we identified the problem correctly we've tested to add a
"dmaengine_synchronize()" before the snd_pcm_prepare() in [5]. This
fixed the race condition in all our tests. (Before we were able to
reproduce it in 100% of the test runs).

Based on our understanding, there are two different points to ensure
the termination:
Either ensure that the termination is finished within the previous
SNDRV_PCM_IOCTL_READI_FRAMES call (inside the DMA context) or finishing
it in the SNDRV_PCM_IOCTL_PREPARE call (and all other applicable ioclts)
before entering the atomic context (from the PCM context).

We initially thought about implementing the first approach, basically
splitting up the dma_device terminate_all operation into a sync
(busy-wait) and a async one. This would align the operations with the
DMAengine interface and would enable a sync termination variant from
atomic contexts.
However, we saw that the dma_free_attrs() function has a WARN_ON on irqs
disabled, which would be the case for the sync variant.

Side note: We found this issue on the current v5.4.y LTS branch,
but it also affects v5.8.y.

Any feedback or pointers how we may fix the problem are warmly welcome!
If anything is unclear please just ask :-)

regards;
Richard Leitner
Benjamin Bara

[1]https://elixir.bootlin.com/linux/v5.8/source/drivers/dma/imx-sdma.c#L1066
[2]https://elixir.bootlin.com/linux/v5.8/source/drivers/dma/imx-sdma.c#L1071
[3]https://elixir.bootlin.com/linux/v5.8/source/drivers/dma/imx-sdma.c#L1072
[4]https://elixir.bootlin.com/linux/v5.8/source/sound/core/pcm_lib.c#L1825
[5]https://elixir.bootlin.com/linux/v5.8/source/sound/core/pcm_native.c#L3226
