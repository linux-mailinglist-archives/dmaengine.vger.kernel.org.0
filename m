Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5E75F6DA4
	for <lists+dmaengine@lfdr.de>; Mon, 11 Nov 2019 05:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfKKErW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 10 Nov 2019 23:47:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:34018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726764AbfKKErW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 10 Nov 2019 23:47:22 -0500
Received: from localhost (unknown [106.201.42.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58AA32084F;
        Mon, 11 Nov 2019 04:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573447641;
        bh=IP70vFTbjgfIhIAFcbrEA9JEDy+eeHt6RS3u5EPlgbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UF5RhSmvO9U730zE98iGXTV3w9TzQlTw4fyfIsIbdmSrgvouKSNdj5oXPc1G8tmMM
         lCNYbcymyff2/P7kCAXR8hoNHDMBf//iMQl8NWAhoy3NVFHJrANZDSJnKCxHndZhxw
         A030trLz3NnavZzYGFk5pdA2C3UQbizREcwrgr4I=
Date:   Mon, 11 Nov 2019 10:17:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     robh+dt@kernel.org, nm@ti.com, ssantosh@kernel.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, grygorii.strashko@ti.com,
        lokeshvutla@ti.com, t-kristo@ti.com, tony@atomide.com,
        j-keerthy@ti.com
Subject: Re: [PATCH v4 07/15] dmaengine: ti: k3 PSI-L remote endpoint
 configuration
Message-ID: <20191111044716.GM952516@vkoul-mobl>
References: <20191101084135.14811-1-peter.ujfalusi@ti.com>
 <20191101084135.14811-8-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101084135.14811-8-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 01-11-19, 10:41, Peter Ujfalusi wrote:

> --- /dev/null
> +++ b/drivers/dma/ti/k3-psil.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0

...

> +extern struct psil_ep_map am654_ep_map;
> +extern struct psil_ep_map j721e_ep_map;
> +
> +static DEFINE_MUTEX(ep_map_mutex);
> +static struct psil_ep_map *soc_ep_map;
> +
> +struct psil_endpoint_config *psil_get_ep_config(u32 thread_id)
> +{
> +	int i;
> +
> +	mutex_lock(&ep_map_mutex);
> +	if (!soc_ep_map) {
> +		if (of_machine_is_compatible("ti,am654")) {
> +			soc_ep_map = &am654_ep_map;
> +		} else if (of_machine_is_compatible("ti,j721e")) {
> +			soc_ep_map = &j721e_ep_map;
> +		} else {
> +			pr_err("PSIL: No compatible machine found for map\n");
> +			return ERR_PTR(-ENOTSUPP);
> +		}
> +		pr_debug("%s: Using map for %s\n", __func__, soc_ep_map->name);
> +	}
> +	mutex_unlock(&ep_map_mutex);
> +
> +	if (thread_id & K3_PSIL_DST_THREAD_ID_OFFSET && soc_ep_map->dst) {
> +		/* check in destination thread map */
> +		for (i = 0; i < soc_ep_map->dst_count; i++) {
> +			if (soc_ep_map->dst[i].thread_id == thread_id)
> +				return &soc_ep_map->dst[i].ep_config;
> +		}
> +	}
> +
> +	thread_id &= ~K3_PSIL_DST_THREAD_ID_OFFSET;
> +	if (soc_ep_map->src) {
> +		for (i = 0; i < soc_ep_map->src_count; i++) {
> +			if (soc_ep_map->src[i].thread_id == thread_id)
> +				return &soc_ep_map->src[i].ep_config;
> +		}
> +	}
> +
> +	return ERR_PTR(-ENOENT);
> +}
> +EXPORT_SYMBOL(psil_get_ep_config);

This doesn't match the license of this module, we need it to be
EXPORT_SYMBOL_GPL
-- 
~Vinod
