Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B23C23A329
	for <lists+dmaengine@lfdr.de>; Mon,  3 Aug 2020 13:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgHCLOl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Aug 2020 07:14:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:51496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbgHCLOl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 3 Aug 2020 07:14:41 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12AA420719;
        Mon,  3 Aug 2020 11:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596453280;
        bh=5H3v1Du5rpRSWnXSCSiCk75bAcpRhnq+T5CXif4mD28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A3wQkcvAaAcrYqHs2CWdwYGBjxzh+8Bv3QZJ+6DfyRGG73tHlo8zhOhR+WHISnB7Z
         l0is1udwf6mDqCHk5KUWla+ZCRZC5IuCGwzTu3pQaogw4DVeBG4n/VvQz6nNKS/W9N
         FxApx86IozoVMOwtpMtKUA/hOwlW9sNSBnlbiBo4=
Date:   Mon, 3 Aug 2020 16:44:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, dan.j.williams@intel.com,
        linux-arm-kernel@lists.infradead.org, nm@ti.com,
        grygorii.strashko@ti.com, lokeshvutla@ti.com, nsekhar@ti.com,
        kishon@ti.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dmaengine: ti: k3-psil: Use soc_device_match to get
 the psil map
Message-ID: <20200803111436.GN12965@vkoul-mobl>
References: <20200803101128.20885-1-peter.ujfalusi@ti.com>
 <20200803101128.20885-2-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803101128.20885-2-peter.ujfalusi@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-08-20, 13:11, Peter Ujfalusi wrote:
> Instead of separate of_machine_is_compatible() it is better to use
> soc_device_match() and soc_device_attribute struct to get the PSI-L map
> for the booted device.
> 
> By using soc_device_match() it is easier to add support for new devices.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/dma/ti/k3-psil.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/ti/k3-psil.c b/drivers/dma/ti/k3-psil.c
> index fb7c8150b0d1..3ca29aabac93 100644
> --- a/drivers/dma/ti/k3-psil.c
> +++ b/drivers/dma/ti/k3-psil.c
> @@ -9,11 +9,18 @@
>  #include <linux/init.h>
>  #include <linux/mutex.h>
>  #include <linux/of.h>
> +#include <linux/sys_soc.h>
>  
>  #include "k3-psil-priv.h"
>  
>  static DEFINE_MUTEX(ep_map_mutex);
> -static struct psil_ep_map *soc_ep_map;
> +static const struct psil_ep_map *soc_ep_map;
> +
> +static const struct soc_device_attribute k3_soc_devices[] = {
> +	{ .family = "AM65X", .data = &am654_ep_map },
> +	{ .family = "J721E", .data = &j721e_ep_map },
> +	{ /* sentinel */ }
> +};
>  
>  struct psil_endpoint_config *psil_get_ep_config(u32 thread_id)
>  {
> @@ -21,15 +28,17 @@ struct psil_endpoint_config *psil_get_ep_config(u32 thread_id)
>  
>  	mutex_lock(&ep_map_mutex);
>  	if (!soc_ep_map) {
> -		if (of_machine_is_compatible("ti,am654")) {
> -			soc_ep_map = &am654_ep_map;
> -		} else if (of_machine_is_compatible("ti,j721e")) {
> -			soc_ep_map = &j721e_ep_map;
> +		const struct soc_device_attribute *soc;
> +
> +		soc = soc_device_match(k3_soc_devices);
> +		if (soc) {
> +			soc_ep_map = soc->data;
>  		} else {
>  			pr_err("PSIL: No compatible machine found for map\n");
>  			mutex_unlock(&ep_map_mutex);
>  			return ERR_PTR(-ENOTSUPP);
>  		}
> +

not related

>  		pr_debug("%s: Using map for %s\n", __func__, soc_ep_map->name);
>  	}
>  	mutex_unlock(&ep_map_mutex);
> -- 
> Peter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

-- 
~Vinod
