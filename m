Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 460D020C9F
	for <lists+dmaengine@lfdr.de>; Thu, 16 May 2019 18:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfEPQL2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 May 2019 12:11:28 -0400
Received: from mga11.intel.com ([192.55.52.93]:53958 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbfEPQL2 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 16 May 2019 12:11:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 May 2019 09:11:28 -0700
X-ExtLoop1: 1
Received: from djiang5-desk3.ch.intel.com ([143.182.137.59])
  by fmsmga001.fm.intel.com with ESMTP; 16 May 2019 09:11:27 -0700
Subject: Re: [PATCH] dmaengine: ioatdma: fix unprotected timer deletion
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, dan.j.williams@intel.com,
        fan.du@intel.com
References: <155744504539.8006.16459393524018173816.stgit@djiang5-desk3.ch.intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.jiang@intel.com; prefer-encrypt=mutual; keydata=
 xsPuBE6TbysRDACKOBHZT4ez/3/idMBVQP+cMIJAWfTTLqbHVYLdHMHh4h6IXWLqWgc9AYTx
 /ajdOrBVGSK9kMuvqRi0iRO1QLOMUAIc2n/44vh/3Fe54QYfgbndeXhHZi7YEwjiTCbpQ336
 pS0rS2qQaA8GzFwu96OslLI05j9Ygaqy73qmuk3wxomIYiu9a97aN3oVv1RyTp6gJK1NWT3J
 On17P1yWUYPvY3KJtpVqnRLkLZeOIiOahgf9+qiYqPhKQI1Ycx4YhbqkNmDG1VqdMtEWREZO
 DpTti6oecydN37MW1Y+YSzWYDVLWfoLUr2tBveGCRLf/U2n+Tm2PlJR0IZq+BhtuIUVcRLQW
 vI+XenR8j3vHVNHs9UXW/FPB8Xb5fwY2bJniZ+B4G67nwelhMNWe7H9IcEaI7Eo32fZk+9fo
 x6GDAhdT0pEetwuhkmI0YYD7cQj1mEx1oEbzX2p/HRW9sHTSv0V2zKbkPvii3qgvCoDb1uLd
 4661UoSG0CYaAx8TwBxUqjsBAO9FXDhLHZJadyHmWp64xQGnNgBathuqoSsIWgQWBpfhDACA
 OYftX52Wp4qc3ZT06NPzGTV35xr4DVftxxUHiwzB/bzARfK8tdoW4A44gN3P03DAu+UqLoqm
 UP/e8gSLEjoaebjMu8c2iuOhk1ayHkDPc2gugTgLLBWPkhvIEV4rUV9C7TsgAAvNNDAe8X00
 Tu1m01A4ToLpYsNWEtM9ZRdKXSo6YS45DFRhel29ZRz24j4ZNIxN9Bee/fn7FrL4HgO01yH+
 QULDAtU87AkVoBdU5xBJVj7tGosuV+ia4UCWXjTzb+ERek2503OvNq4xqche3RMoZLsSHiOj
 5PjMNX4EA6pf5kRWdNutjmAsXrpZrnviWMPy+zHUzHIw/gaI00lHMjS0P99A7ay/9BjtsIBx
 lJZ09Kp6SE0EiZpFIxB5D0ji6rHu3Qblwq+WjM2+1pydVxqt2vt7+IZgEB4Qm6rml835UB89
 TTkMtiIXJ+hMC/hajIuFSah+CDkfagcrt1qiaVoEAs/1cCuAER+h5ClMnLZPPxNxphsqkXxn
 3MVJcMEL/iaMimP3oDXJoK3O+u3gC3p55A/LYZJ7hP9lHTT4MtgwmgBp9xPeVFWx3rwQOKix
 SPONHlkjfvn4dUHmaOmJyKgtt5htpox+XhBkuCZ5UWpQ40/GyVypWyBXtqNx/0IKByXy4QVm
 QjUL/U2DchYhW+2w8rghIhkuHX2YOdldyEvXkzN8ysGR31TDwshg600k4Q/UF/MouC2ZNeMa
 y8I0whHBFTwSjN5T1F9cvko4PsHNB3QH4M4tbArwn4RzSX6Hfxoq59ziyI4Et6sE5SyiVEZQ
 DhKZ8VU61uUaYHDdid8xKU4sV5IFCERIoIwieEAkITNvCdFtuXl9gugzld7IHbOTRaGy4M+M
 gOyAvSe5ysBrXhY+B0d+EYif1I8s4PbnkH2xehof++lQuy3+1TZcweSx1f/uF6d92ZDkvJzQ
 QbkicMLaPy0IS5XIMkkpD1zIO0jeaHcTm3uzB9k8N9y4tA2ELWVR/iFZigrtrwpIJtJLUieB
 89EOJLR6xbksSrFhQ80oRGF2ZSBKaWFuZyAoV29yaykgPGRhdmUuamlhbmdAaW50ZWwuY29t
 PsJ9BBMRCAAlAhsjBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAUCUZEwDwIZAQAKCRBkFcTx
 ZqO5Ps8HAP4kF/KAor80fNwT7osSHGG5rLFPR/Yc5V0QpqkU8DhZDgEAoStRa/a6Mtq3Ri1H
 B84kFIqSQ9ME5049k6k1K7wdXcvOwE0ETpNvKxAEANGHLx0q/R99wzbVdnRthIZttNQ6M4R8
 AAtEypE9JG3PLrEd9MUB5wf0fB/2Jypec3x935mRW3Zt1i+TrzjQDzMV5RyTtpWI7PwIh5IZ
 0h4OV2yQHFVViHi6lubCRypQYiMzTmEKua3LeBGvUR9vVmpPJZ/UP6VajKqywjPHYBwLAAMF
 A/9B/PdGc1sZHno0ezuwZO2J9BOsvASNUzamO9to5P9VHTA6UqRvyfXJpNxLF1HjT4ax7Xn4
 wGr6V1DCG3JYBmwIZjfinrLINKEK43L+sLbVVi8Mypc32HhNx/cPewROY2vPb4U7y3jhPBtt
 lt0ZMb75Lh7zY3TnGLOx1AEzmqwZSMJhBBgRCAAJBQJOk28rAhsMAAoJEGQVxPFmo7k+qiUB
 AKH0QWC+BBBn3pa9tzOz5hTrup+GIzf5TcuCsiAjISEqAPkBTGk5iiGrrHkxsz8VulDVpNxk
 o6nmKbYpUAltQObU2w==
Message-ID: <f80ae09d-82f3-e395-f797-afd79381ce36@intel.com>
Date:   Thu, 16 May 2019 09:11:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <155744504539.8006.16459393524018173816.stgit@djiang5-desk3.ch.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 5/9/19 4:37 PM, Dave Jiang wrote:
> When ioat_free_chan_resources() gets called, ioat_stop() is called without
> chan->cleanup_lock. ioat_stop modifies IOAT_RUN bit.  It needs to be
> protected by cleanup_lock. Also, in the __cleanup() path, if IOAT_RUN is
> cleared, we should not touch the timer again. We observed that the timer
> routine was run after timer was deleted.
> 
> Fixes: 3372de5813e ("dmaengine: ioatdma: removal of dma_v3.c and relevant ioat3
> references")
> 
> Reported-by: Fan Du <fan.du@intel.com>
> Tested-by: Fan Du <fan.du@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Vinod, can you hold off on this please? There may be more changes. Thanks.

> ---
>  drivers/dma/ioat/dma.c |   16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
> index f373a139e0c3..78598ba5c73b 100644
> --- a/drivers/dma/ioat/dma.c
> +++ b/drivers/dma/ioat/dma.c
> @@ -138,11 +138,14 @@ void ioat_stop(struct ioatdma_chan *ioat_chan)
>  	struct pci_dev *pdev = ioat_dma->pdev;
>  	int chan_id = chan_num(ioat_chan);
>  	struct msix_entry *msix;
> +	unsigned long flags;
>  
> -	/* 1/ stop irq from firing tasklets
> -	 * 2/ stop the tasklet from re-arming irqs
> -	 */
> +	spin_lock_irqsave(&ioat_chan->cleanup_lock, flags);
>  	clear_bit(IOAT_RUN, &ioat_chan->state);
> +	spin_unlock_irqrestore(&ioat_chan->cleanup_lock, flags);
> +
> +	/* flush inflight timers */
> +	del_timer_sync(&ioat_chan->timer);
>  
>  	/* flush inflight interrupts */
>  	switch (ioat_dma->irq_mode) {
> @@ -158,9 +161,6 @@ void ioat_stop(struct ioatdma_chan *ioat_chan)
>  		break;
>  	}
>  
> -	/* flush inflight timers */
> -	del_timer_sync(&ioat_chan->timer);
> -
>  	/* flush inflight tasklet runs */
>  	tasklet_kill(&ioat_chan->cleanup_task);
>  
> @@ -652,7 +652,9 @@ static void __cleanup(struct ioatdma_chan *ioat_chan, dma_addr_t phys_complete)
>  	if (active - i == 0) {
>  		dev_dbg(to_dev(ioat_chan), "%s: cancel completion timeout\n",
>  			__func__);
> -		mod_timer(&ioat_chan->timer, jiffies + IDLE_TIMEOUT);
> +
> +		if (test_bit(IOAT_RUN, &ioat_chan->state))
> +			mod_timer(&ioat_chan->timer, jiffies + IDLE_TIMEOUT);
>  	}
>  
>  	/* microsecond delay by sysfs variable  per pending descriptor */
> 
