Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8829BF6FE4
	for <lists+dmaengine@lfdr.de>; Mon, 11 Nov 2019 09:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfKKIq1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Nov 2019 03:46:27 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56048 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKKIq1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Nov 2019 03:46:27 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAB8kFjp047825;
        Mon, 11 Nov 2019 02:46:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573461975;
        bh=bPsdV3D16S4/f/dE/JDv9mNF3nvxhJIfXWIaWmitlCY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=mXaHGQTW3V1k5l+az7PK9qrALszJvuc6fkBps1mPRoWCUC9eXPnedgV5DUDxYuHv6
         g9E7oN45MK9ILrYHZGMIN2+6dBw6BWc9/HGDwcZz+2CI4lvRLEdew9a8772mJj13A/
         X8xm14x3Ju/vIpOsQydYM+IDfjBI0Rd1gnU+XBlw=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAB8kE99038243
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Nov 2019 02:46:15 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 11
 Nov 2019 02:45:57 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 11 Nov 2019 02:45:57 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAB8kArs100093;
        Mon, 11 Nov 2019 02:46:11 -0600
Subject: Re: [PATCH v4 07/15] dmaengine: ti: k3 PSI-L remote endpoint
 configuration
To:     Vinod Koul <vkoul@kernel.org>
CC:     <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>
References: <20191101084135.14811-1-peter.ujfalusi@ti.com>
 <20191101084135.14811-8-peter.ujfalusi@ti.com>
 <20191111044716.GM952516@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <0a9d570a-0942-6e98-9e5a-798546c9c677@ti.com>
Date:   Mon, 11 Nov 2019 10:47:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191111044716.GM952516@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 11/11/2019 6.47, Vinod Koul wrote:
> On 01-11-19, 10:41, Peter Ujfalusi wrote:
> 
>> --- /dev/null
>> +++ b/drivers/dma/ti/k3-psil.c
>> @@ -0,0 +1,97 @@
>> +// SPDX-License-Identifier: GPL-2.0
> 
> ...
> 
>> +extern struct psil_ep_map am654_ep_map;
>> +extern struct psil_ep_map j721e_ep_map;
>> +
>> +static DEFINE_MUTEX(ep_map_mutex);
>> +static struct psil_ep_map *soc_ep_map;
>> +
>> +struct psil_endpoint_config *psil_get_ep_config(u32 thread_id)
>> +{
>> +	int i;
>> +
>> +	mutex_lock(&ep_map_mutex);
>> +	if (!soc_ep_map) {
>> +		if (of_machine_is_compatible("ti,am654")) {
>> +			soc_ep_map = &am654_ep_map;
>> +		} else if (of_machine_is_compatible("ti,j721e")) {
>> +			soc_ep_map = &j721e_ep_map;
>> +		} else {
>> +			pr_err("PSIL: No compatible machine found for map\n");
>> +			return ERR_PTR(-ENOTSUPP);
>> +		}
>> +		pr_debug("%s: Using map for %s\n", __func__, soc_ep_map->name);
>> +	}
>> +	mutex_unlock(&ep_map_mutex);
>> +
>> +	if (thread_id & K3_PSIL_DST_THREAD_ID_OFFSET && soc_ep_map->dst) {
>> +		/* check in destination thread map */
>> +		for (i = 0; i < soc_ep_map->dst_count; i++) {
>> +			if (soc_ep_map->dst[i].thread_id == thread_id)
>> +				return &soc_ep_map->dst[i].ep_config;
>> +		}
>> +	}
>> +
>> +	thread_id &= ~K3_PSIL_DST_THREAD_ID_OFFSET;
>> +	if (soc_ep_map->src) {
>> +		for (i = 0; i < soc_ep_map->src_count; i++) {
>> +			if (soc_ep_map->src[i].thread_id == thread_id)
>> +				return &soc_ep_map->src[i].ep_config;
>> +		}
>> +	}
>> +
>> +	return ERR_PTR(-ENOENT);
>> +}
>> +EXPORT_SYMBOL(psil_get_ep_config);
> 
> This doesn't match the license of this module, we need it to be
> EXPORT_SYMBOL_GPL

Oops, will fix it.


- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
