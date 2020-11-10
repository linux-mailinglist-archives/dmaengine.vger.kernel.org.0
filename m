Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CADE2AD0B9
	for <lists+dmaengine@lfdr.de>; Tue, 10 Nov 2020 08:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgKJH6U (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Nov 2020 02:58:20 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53820 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbgKJH6U (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Nov 2020 02:58:20 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AA7wCj3049915;
        Tue, 10 Nov 2020 01:58:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604995092;
        bh=simLczeCwAE+HWLvGuciuciDXR2ji2w1iKWzoq3nUhY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=WGDa9c/DTGXoJ4J/yPqDpSkCXW31rKViCz4p3z8a3KSY/7z3cRYgibNka2bf8xHkM
         S6AXv0TT2J9UO3jAarFRleS6gk3c+Ds4NrcW3XEK+1S7LhRnW6b4dD660YRJfp6W6h
         H5VXBFT5jggY/UZpjac95Lakjt/qtWeQNMn1KOHY=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AA7wBNA125419
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Nov 2020 01:58:11 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 10
 Nov 2020 01:58:10 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 10 Nov 2020 01:58:10 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AA7w9L1066999;
        Tue, 10 Nov 2020 01:58:09 -0600
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Block PM if SDMA is busy to fix
 audio
To:     Tony Lindgren <tony@atomide.com>, <linux-omap@vger.kernel.org>
CC:     Vinod Koul <vinod.koul@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20201109154013.11950-1-tony@atomide.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <acf280b4-f34d-cfc6-874c-48843cd54365@ti.com>
Date:   Tue, 10 Nov 2020 09:58:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201109154013.11950-1-tony@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Tony,

On 09/11/2020 17.40, Tony Lindgren wrote:
> We now use cpu_pm for saving and restoring device context for deeper SoC
> idle states. But for omap3, we must also block idle if SDMA is busy.
> 
> If we don't block idle when SDMA is busy, we eventually end up saving and
> restoring SDMA register state on PER domain idle while SDMA is active and
> that causes at least audio playback to fail.

Thanks for the fix!

Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Vinod: Can you take this for 5.10 as a fix? The off mode got enabled by
default in 5.10-rc1 and audio got broken out of box.

Thanks,
- Péter

> Fixes: 4c74ecf79227 ("dmaengine: ti: omap-dma: Add device tree match data and use it for cpu_pm")
> Reported-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/dma/ti/omap-dma.c | 37 ++++++++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> --- a/drivers/dma/ti/omap-dma.c
> +++ b/drivers/dma/ti/omap-dma.c
> @@ -1522,29 +1522,38 @@ static void omap_dma_free(struct omap_dmadev *od)
>  	}
>  }
>  
> +/* Currently used by omap2 & 3 to block deeper SoC idle states */
> +static bool omap_dma_busy(struct omap_dmadev *od)
> +{
> +	struct omap_chan *c;
> +	int lch = -1;
> +
> +	while (1) {
> +		lch = find_next_bit(od->lch_bitmap, od->lch_count, lch + 1);
> +		if (lch >= od->lch_count)
> +			break;
> +		c = od->lch_map[lch];
> +		if (!c)
> +			continue;
> +		if (omap_dma_chan_read(c, CCR) & CCR_ENABLE)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  /* Currently only used for omap2. For omap1, also a check for lcd_dma is needed */
>  static int omap_dma_busy_notifier(struct notifier_block *nb,
>  				  unsigned long cmd, void *v)
>  {
>  	struct omap_dmadev *od;
> -	struct omap_chan *c;
> -	int lch = -1;
>  
>  	od = container_of(nb, struct omap_dmadev, nb);
>  
>  	switch (cmd) {
>  	case CPU_CLUSTER_PM_ENTER:
> -		while (1) {
> -			lch = find_next_bit(od->lch_bitmap, od->lch_count,
> -					    lch + 1);
> -			if (lch >= od->lch_count)
> -				break;
> -			c = od->lch_map[lch];
> -			if (!c)
> -				continue;
> -			if (omap_dma_chan_read(c, CCR) & CCR_ENABLE)
> -				return NOTIFY_BAD;
> -		}
> +		if (omap_dma_busy(od))
> +			return NOTIFY_BAD;
>  		break;
>  	case CPU_CLUSTER_PM_ENTER_FAILED:
>  	case CPU_CLUSTER_PM_EXIT:
> @@ -1595,6 +1604,8 @@ static int omap_dma_context_notifier(struct notifier_block *nb,
>  
>  	switch (cmd) {
>  	case CPU_CLUSTER_PM_ENTER:
> +		if (omap_dma_busy(od))
> +			return NOTIFY_BAD;
>  		omap_dma_context_save(od);
>  		break;
>  	case CPU_CLUSTER_PM_ENTER_FAILED:
> 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
