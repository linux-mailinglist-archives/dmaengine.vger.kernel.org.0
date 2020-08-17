Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B97245E1D
	for <lists+dmaengine@lfdr.de>; Mon, 17 Aug 2020 09:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgHQHfr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Aug 2020 03:35:47 -0400
Received: from mail1.skidata.com ([91.230.2.99]:52668 "EHLO mail1.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgHQHfr (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 17 Aug 2020 03:35:47 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Aug 2020 03:35:43 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=skidata.com; i=@skidata.com; q=dns/txt; s=selector1;
  t=1597649744; x=1629185744;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+RD2yN5N1q3un9IT1M50pdc25CeJUXzpLiptrNEMp4I=;
  b=DzfAMctkhSF9NTcFvvu0VFB8aR9syhGL+H0Hx2MLIzNAfLn4YIgPrcJo
   FUWQ8NyL3bfPsgi6Z4BqlwBq50rSNSowGNCIXmtD+QtCbJlrh5xDY8q9i
   f3VCTxb8JAzQ+D9xpJWG/4MYFxA7jzaSMh8u8SUwBrlPh1uhKpOysVTfU
   hX5/myX6Tagvxl/ldf+yF++kCPlzsHhlC2AYmxOVJ5zID+MNFo3WXt+5g
   ptwal9D4byfDpWzstp9E7RnKJm+JzXlxVdW9DPLPXIg6gt5jlQrni/9F6
   0yoFmA9QNsPD3tXeES+/4cnfO36EyFsQy/BYsdVFJQOCpi2C8BJW5Nvbb
   g==;
IronPort-SDR: jiDMR+V544j3gOce62tFfWKGXrrLqEe/pdjucy+gw24PjZnbDl329ICrdflz8SEFksEsf2k0jV
 54mCnrEMkI6c/MniViVITnAcoy8eKx0GutP6stpU9hnISpJWeJftEEWEXrvQXzZYTtGuqYkRas
 Fmah0qd/0n5Y2jgBxCKMGHuyBpjyuZmFt51gQ/cJ8OiiBPV6+KZ+nXMjJZdUj8jTvq/siUl/Yz
 MyGnkKLE6fCmbZ/eASzZD0PGpr6AyxoACu573PAA0QSL/YljSVQR4qC4u13NB1Y2l0K37WHGff
 NIU=
X-IronPort-AV: E=Sophos;i="5.76,322,1592863200"; 
   d="scan'208";a="26167241"
From:   Benjamin Bara - SKIDATA <Benjamin.Bara@skidata.com>
To:     Robin Gong <yibin.gong@nxp.com>
CC:     "timur@kernel.org" <timur@kernel.org>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Richard Leitner - SKIDATA <Richard.Leitner@skidata.com>
Subject: RE: pcm|dmaengine|imx-sdma race condition on i.MX6
Thread-Topic: pcm|dmaengine|imx-sdma race condition on i.MX6
Thread-Index: AQHWcWQZKYOChL0mPkuCFeZyDJy6mKk3KiiAgABS1/A=
Date:   Mon, 17 Aug 2020 07:28:31 +0000
Message-ID: <61498763c60e488a825e8dd270732b62@skidata.com>
References: <20200813112258.GA327172@pcleri>
 <VE1PR04MB6638EE5BDBE2C65FF50B7DB889400@VE1PR04MB6638.eurprd04.prod.outlook.com>
In-Reply-To: <VE1PR04MB6638EE5BDBE2C65FF50B7DB889400@VE1PR04MB6638.eurprd04.prod.outlook.com>
Accept-Language: en-US, de-AT
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.111.252]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

We think this is not an i.MX6-specific problem, but a problem of the DMAeng=
ine usage from the PCM.
In case of a XRUN, the DMA channel is never closed but first a SNDRV_PCM_TR=
IGGER_STOP next a
SNDRV_PCM_TRIGGER_START is triggered.
The SNDRV_PCM_TRIGGER_STOP simply executes a dmaengine_terminate_async() [1=
]
but does not await the termination by calling dmaengine_synchronize(),
which is required as stated by the docu [2].
Anyways, we are not able to fix it in the pcm_dmaengine layer either at the=
 end of
SNDRV_PCM_TRIGGER_STOP (called from the DMA on complete interrupt handler)
or at the beginning of SNDRV_PCM_TRIGGER_START (called from a PCM ioctl),
since the dmaengine_synchronize() requires a non-atomic context.

Based on my understanding, most of the DMA implementations don't even imple=
ment device_synchronize
and if they do, it might not really be necessary since the terminate_all op=
eration is synchron.

With the i.MX6, it looks a bit different:
Since [4], the terminate_all operation really schedules a worker which wait=
s the required ~1ms and
then does the context freeing.
Now, the ioctl(SNDRV_PCM_IOCTL_PREPARE) and the following ioctl(SNDRV_PCM_I=
OCTL_READI_FRAMES),
which are called from US to handle/recover from a XRUN, are in a race with =
the terminate_worker.
If the terminate_worker finishes earlier, everything is fine.
Otherwise, the sdma_prep_dma_cyclic() is called, sets up everything and
as soon as it is scheduled out to wait for data, the terminate_worker is sc=
heduled and kills it.
In this case, we wait in [5] until the timeout is reached and return with -=
EIO.

Based on our understanding, there exist two different fixing approaches:
We thought that the pcm_dmaengine should handle this by either synchronizin=
g the DMA on a trigger or
terminating it synchronously.
However, as we are in an atomic context, we either have to give up the atom=
ic context of the PCM
to finish the termination or we have to design a synchronous terminate vari=
ant which is callable
from an atomic context.

For the first option, which is potentially more performant, we have to leav=
e the atomic PCM context
and we are not sure if we are allowed to.
For the second option, we would have to divide the dma_device terminate_all=
 into an atomic sync and
an async one, which would align with the dmaengine API, giving it the optio=
n to ensure termination
in an atomic context.
Based on my understanding, most of them are synchronous anyways, for the cu=
rrently async ones we=20
would have to implement busy waits.
However, with this approach, we reach the WARN_ON [6] inside of an atomic c=
ontext,
indicating we might not do the right thing.

Ad Failure Log (at bottom):
I haven't added the ioctl syscalls, but this is basically the output with a=
dditional prints to
be able to follow the code execution path.
A XRUN (buffer size is 480 but 960 available) leads to a SNDRV_PCM_TRIGGER_=
STOP.
This leads to terminate_async, starting the terminate_worker.
Next, the XRUN recovery triggers SNDRV_PCM_TRIGGER_START, calling sdma_prep=
_dma_cyclic
and then waits for the DMA in wait_for_avail().
Next we see the two freeings, first the old, then the newly added one;=20
so the terminate_worker is back at work.
Now the DMA is terminated, while we are still waiting on data from it.

What do you think about it? Is any of the provided solutions practicable?
If you need further information or additional logging, feel free to ask.

Best regards
Benjamin


[1] https://elixir.bootlin.com/linux/latest/source/sound/core/pcm_dmaengine=
.c#L209
[2] https://www.kernel.org/doc/html/latest/driver-api/dmaengine/client.html=
#further-apis
[3] https://elixir.bootlin.com/linux/latest/source/sound/core/pcm_dmaengine=
.c#L189
[4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Db8603d2a5795c42f78998e70dc792336e0dc20c9
[5] https://elixir.bootlin.com/linux/v5.8/source/sound/core/pcm_lib.c#L1875
[6] https://elixir.bootlin.com/linux/latest/source/kernel/dma/mapping.c#L30=
6


*Failure Log from latest 5.4 LTS kernel:*
[  535.201598] imx-sgtl5000 sound: snd_pcm_period_elapsed()
[  535.201610] imx-sgtl5000 sound: snd_pcm_period_elapsed: calls snd_pcm_up=
date_hw_ptr0()
[  535.201626] imx-sdma 20ec000.sdma: sdma_tx_status channel: 2
[  535.201640] snd_pcm_capture_avail: hw_ptr: 960, appl_ptr: 0, avail: 960,=
 boundary: 2013265920
[  535.201655] imx-sgtl5000 sound: snd_dmaengine_pcm_trigger command: 0
[  535.201664] imx-sdma 20ec000.sdma: sdma_disable_channel_async channel: 2
[  535.201672] imx-sdma 20ec000.sdma: sdma_disable_channel channel: 2
[  535.201752] imx-sgtl5000 sound: wait_for_avail: tout=3D999, state=3D4
[  535.201760] imx-sdma 20ec000.sdma: sdma_channel_terminate_work channel: =
2
[  535.201877] imx-sgtl5000 sound: snd_pcm_do_reset: ioctl SNDRV_PCM_IOCTL1=
_RESET
[  535.201888] imx-sgtl5000 sound: snd_pcm_lib_ioctl_reset: calls snd_pcm_u=
pdate_hw_ptr()
[  535.201912] imx-sgtl5000 sound: snd_dmaengine_pcm_trigger command: 1
[  535.201922] imx-sdma 20ec000.sdma: sdma_prep_dma_cyclic channel: 2
[  535.201931] imx-sdma 20ec000.sdma: sdma_config_write channel: 1
[  535.201939] imx-sdma 20ec000.sdma: sdma_config_channel channel: 2
[  535.201948] imx-sdma 20ec000.sdma: sdma_disable_channel channel: 2
[  535.201959] imx-sdma 20ec000.sdma: sdma_load_context channel: 2
[  535.201967] imx-sdma 20ec000.sdma: sdma_transfer_init channel: 2
[  535.201983] imx-sdma 20ec000.sdma: sdma_load_context channel: 2
[  535.201995] imx-sdma 20ec000.sdma: entry 0: count: 256 dma: 0x4a300000  =
intr
[  535.202005] imx-sdma 20ec000.sdma: entry 1: count: 256 dma: 0x4a300100  =
intr
[  535.202014] imx-sdma 20ec000.sdma: entry 2: count: 256 dma: 0x4a300200  =
intr
[  535.202023] imx-sdma 20ec000.sdma: entry 3: count: 256 dma: 0x4a300300  =
intr
[  535.202033] imx-sdma 20ec000.sdma: entry 4: count: 256 dma: 0x4a300400  =
intr
[  535.202042] imx-sdma 20ec000.sdma: entry 5: count: 256 dma: 0x4a300500  =
intr
[  535.202050] imx-sdma 20ec000.sdma: entry 6: count: 256 dma: 0x4a300600  =
intr
[  535.202059] imx-sdma 20ec000.sdma: entry 7: count: 256 dma: 0x4a300700  =
intr
[  535.202067] imx-sdma 20ec000.sdma: entry 8: count: 256 dma: 0x4a300800  =
intr
[  535.202077] imx-sdma 20ec000.sdma: entry 9: count: 256 dma: 0x4a300900  =
intr
[  535.202086] imx-sdma 20ec000.sdma: entry 10: count: 256 dma: 0x4a300a00 =
 intr
[  535.202094] imx-sdma 20ec000.sdma: entry 11: count: 256 dma: 0x4a300b00 =
 intr
[  535.202103] imx-sdma 20ec000.sdma: entry 12: count: 256 dma: 0x4a300c00 =
 intr
[  535.202111] imx-sdma 20ec000.sdma: entry 13: count: 256 dma: 0x4a300d00 =
 intr
[  535.202120] imx-sdma 20ec000.sdma: entry 14: count: 256 dma: 0x4a300e00 =
wrap intr
[  535.202135] imx-sdma 20ec000.sdma: vchan 8aa58994: txd 0a262722[8]: subm=
itted
[  535.202145] imx-sdma 20ec000.sdma: sdma_issue_pending channel: 2
[  535.202181] snd_pcm_capture_avail: hw_ptr: 0, appl_ptr: 0, avail: 0, bou=
ndary: 2013265920
[  535.202192] snd_pcm_capture_avail: hw_ptr: 0, appl_ptr: 0, avail: 0, bou=
ndary: 2013265920
[  535.202202] imx-sgtl5000 sound: wait_for_avail: avail=3D0, state=3D3, tw=
ake=3D64
[  535.203182] imx-sdma 20ec000.sdma: txd 19499aa8: freeing
[  535.203207] imx-sdma 20ec000.sdma: txd 0a262722: freeing
[  545.766059] imx-sgtl5000 sound: wait_for_avail: tout=3D0, state=3D3
[  545.766075] imx-sgtl5000 sound: capture write error (DMA or IRQ trouble?=
)

