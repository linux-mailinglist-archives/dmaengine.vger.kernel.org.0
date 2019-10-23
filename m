Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A796E215A
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2019 19:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfJWRE0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Oct 2019 13:04:26 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40244 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbfJWRE0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Oct 2019 13:04:26 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9NH3xeQ006228;
        Wed, 23 Oct 2019 12:03:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571850239;
        bh=UBTc3V+c2TiqjrYhKmFzYaRZfUW/MVg36Zg7zo1cHxA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=BD5siyVt4YjHNuoQZuBql3swzI7/DszTfYUWg59d+XVlMWT5f1gooVNzBOyQZ0h27
         X9CPgsGI1li7j7sP/ZoXH8pXrif+FD9ouTgiJExUZ5G90dMbhm2UHNLlMOccQ0FnaP
         MyfMX8yBRgYXiK8Op8WMuujYJdPdI+TqiYTRtPdE=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9NH3xfE059061
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Oct 2019 12:03:59 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 23
 Oct 2019 12:03:49 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 23 Oct 2019 12:03:49 -0500
Received: from [192.168.2.10] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9NH3ra1018604;
        Wed, 23 Oct 2019 12:03:54 -0500
Subject: Re: [PATCH] dmaengine: cppi41: Fix cppi41_dma_prep_slave_sg() when
 idle
To:     Tony Lindgren <tony@atomide.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vinod.koul@intel.com>
CC:     Alexandre Bailon <abailon@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bin Liu <b-liu@ti.com>, Daniel Mack <zonque@gmail.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Johan Hovold <johan@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        <dmaengine@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <giulio.benetti@benettiengineering.com>,
        Sebastian Reichel <sre@kernel.org>,
        Skvortsov <andrej.skvortzov@gmail.com>,
        Yegor Yefremov <yegorslists@googlemail.com>
References: <20191023153138.23442-1-tony@atomide.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <245e1e8f-7933-bae1-b779-239f33d4d449@ti.com>
Date:   Wed, 23 Oct 2019 20:04:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191023153138.23442-1-tony@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Tony,

On 10/23/19 6:31 PM, Tony Lindgren wrote:
> Yegor Yefremov <yegorslists@googlemail.com> reported that musb and ftdi
> uart can fail for the first open of the uart unless connected using
> a hub.
> 
> This is because the first dma call done by musb_ep_program() must wait
> if cppi41 is PM runtime suspended. Otherwise musb_ep_program() continues
> with other non-dma packets before the DMA transfer is started causing at
> least ftdi uarts to fail to receive data.
> 
> Let's fix the issue by waking up cppi41 with PM runtime calls added to
> cppi41_dma_prep_slave_sg() and return NULL if still idled. This way we
> have musb_ep_program() continue with PIO until cppi41 is awake.
> 
> Fixes: fdea2d09b997 ("dmaengine: cppi41: Add basic PM runtime support")
> Cc: Bin Liu <b-liu@ti.com>
> Cc: giulio.benetti@benettiengineering.com
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Skvortsov <andrej.skvortzov@gmail.com>
> Reported-by: Yegor Yefremov <yegorslists@googlemail.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> Please consider adding Cc stable v4.9+ tag when committing
> 
> ---
>  drivers/dma/ti/cppi41.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/ti/cppi41.c b/drivers/dma/ti/cppi41.c
> --- a/drivers/dma/ti/cppi41.c
> +++ b/drivers/dma/ti/cppi41.c
> @@ -586,9 +586,22 @@ static struct dma_async_tx_descriptor *cppi41_dma_prep_slave_sg(
>  	enum dma_transfer_direction dir, unsigned long tx_flags, void *context)
>  {
>  	struct cppi41_channel *c = to_cpp41_chan(chan);
> +	struct dma_async_tx_descriptor *txd = NULL;
> +	struct cppi41_dd *cdd = c->cdd;
>  	struct cppi41_desc *d;
>  	struct scatterlist *sg;
>  	unsigned int i;
> +	int error;
> +
> +	error = pm_runtime_get(cdd->ddev.dev);

If pm_runtime_get()
pm_runtime_mark_last_busy()+pm_runtime_put_autosuspend() around a code
which updates a descriptor in _memory_ helps then this best described as
works by luck ;)

I have a feeling that if you put enough delay between prepare_sg and
issue_pending in the usb driver then it will keep failing, no?

fwiw, in the cppi41_dma_issue_pending() the driver does:

	error = pm_runtime_get(cdd->ddev.dev);
...
	if (!cdd->is_suspended)
		cppi41_run_queue(cdd);
...
	pm_runtime_mark_last_busy(cdd->ddev.dev);
	pm_runtime_put_autosuspend(cdd->ddev.dev);

Without waiting for the transfer to complete?

If issue_pending is not starting the transfer right away then the whole
pm handling is broken in there. imho.

runtime_get in prep_slave_sg and runtime_put when the transfer is finished?

> +	if (error < 0) {
> +		pm_runtime_put_noidle(cdd->ddev.dev);
> +
> +		return NULL;
> +	}
> +
> +	if (cdd->is_suspended)
> +		goto err_out_not_ready;
>  
>  	d = c->desc;
>  	for_each_sg(sgl, sg, sg_len, i) {
> @@ -611,7 +624,13 @@ static struct dma_async_tx_descriptor *cppi41_dma_prep_slave_sg(
>  		d++;
>  	}
>  
> -	return &c->txd;
> +	txd = &c->txd;
> +
> +err_out_not_ready:
> +	pm_runtime_mark_last_busy(cdd->ddev.dev);
> +	pm_runtime_put_autosuspend(cdd->ddev.dev);
> +
> +	return txd;
>  }
>  
>  static void cppi41_compute_td_desc(struct cppi41_desc *d)
> 

- Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
