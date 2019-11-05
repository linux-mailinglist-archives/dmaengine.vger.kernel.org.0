Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA20EF702
	for <lists+dmaengine@lfdr.de>; Tue,  5 Nov 2019 09:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387484AbfKEIM5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Nov 2019 03:12:57 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:56448 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387442AbfKEIM5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 5 Nov 2019 03:12:57 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA58CkSf009351;
        Tue, 5 Nov 2019 02:12:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572941566;
        bh=rss6Mp4quh2S4WzB5MeQQKUNTQjYLZd5GvvycvppoCc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=EYMk7elOvlowniBg4gjffNRye3GSvxF/SC9gel8D9l0AeFj1HFwa4PHszW3/KlpJ7
         BK2E62xGnItiUg4dwH7mFZivTtHIjppPOYfDuLfEAGoZSt0inM8CeNxh1OvOqSS1e5
         fyfIX8E+UGzd6lVpdTLguU3DuMgNhf2uRGonae3I=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xA58CkMN053421
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Nov 2019 02:12:46 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 5 Nov
 2019 02:12:24 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 5 Nov 2019 02:12:24 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA58CaiX047486;
        Tue, 5 Nov 2019 02:12:36 -0600
Subject: Re: [PATCH v4 07/15] dmaengine: ti: k3 PSI-L remote endpoint
 configuration
To:     Tero Kristo <t-kristo@ti.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <tony@atomide.com>, <j-keerthy@ti.com>
References: <20191101084135.14811-1-peter.ujfalusi@ti.com>
 <20191101084135.14811-8-peter.ujfalusi@ti.com>
 <e23316e7-1913-d0a7-79c6-4af2084e5176@ti.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <c3f95799-e211-7740-8c20-d79416965dc2@ti.com>
Date:   Tue, 5 Nov 2019 10:13:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e23316e7-1913-d0a7-79c6-4af2084e5176@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 05/11/2019 9.49, Tero Kristo wrote:
> On 01/11/2019 10:41, Peter Ujfalusi wrote:
>> In K3 architecture the DMA operates within threads. One end of the thread
>> is UDMAP, the other is on the peripheral side.
>>
>> The UDMAP channel configuration depends on the needs of the remote
>> endpoint and it can be differ from peripheral to peripheral.
>>
>> This patch adds database for am654 and j721e and small API to fetch the
>> PSI-L endpoint configuration from the database which should only used by
>> the DMA driver(s).
>>
>> Another API is added for native peripherals to give possibility to
>> pass new
>> configuration for the threads they are using, which is needed to be
>> able to
>> handle changes caused by different firmware loaded for the peripheral for
>> example.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>   drivers/dma/ti/Kconfig         |   3 +
>>   drivers/dma/ti/Makefile        |   1 +
>>   drivers/dma/ti/k3-psil-am654.c | 172 ++++++++++++++++++++++++++
>>   drivers/dma/ti/k3-psil-j721e.c | 219 +++++++++++++++++++++++++++++++++
>>   drivers/dma/ti/k3-psil-priv.h  |  39 ++++++
>>   drivers/dma/ti/k3-psil.c       |  97 +++++++++++++++
>>   include/linux/dma/k3-psil.h    |  47 +++++++
>>   7 files changed, 578 insertions(+)
>>   create mode 100644 drivers/dma/ti/k3-psil-am654.c
>>   create mode 100644 drivers/dma/ti/k3-psil-j721e.c
>>   create mode 100644 drivers/dma/ti/k3-psil-priv.h
>>   create mode 100644 drivers/dma/ti/k3-psil.c
>>   create mode 100644 include/linux/dma/k3-psil.h

...

>> diff --git a/drivers/dma/ti/k3-psil.c b/drivers/dma/ti/k3-psil.c
>> new file mode 100644
>> index 000000000000..e610022f09f4
>> --- /dev/null
>> +++ b/drivers/dma/ti/k3-psil.c
>> @@ -0,0 +1,97 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + *  Copyright (C) 2019 Texas Instruments Incorporated -
>> http://www.ti.com
>> + *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/device.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/of.h>
>> +
>> +#include "k3-psil-priv.h"
>> +
>> +extern struct psil_ep_map am654_ep_map;
>> +extern struct psil_ep_map j721e_ep_map;
>> +
>> +static DEFINE_MUTEX(ep_map_mutex);
>> +static struct psil_ep_map *soc_ep_map;
> 
> So, you are only protecting the high level soc_ep_map pointer only. You
> don't need to protect the database itself via some usecounting or
> something, or are you doing it within the DMA driver?

That's correct, I protect only the soc_ep_map.
The DMA drivers can look up threads concurrently I just need to make
sure that the soc_ep_map is configured when the first
psil_get_ep_config() comes.
After this the DMA drivers are free to look up things.

The ep_config update will be coming from the DMA client driver(s) and
not from the DMA driver. The clinet driver knows how thier PSI-L
endpoint if configured so they could update the default configuration
_before_ they would request a DMA channel.

> 
> -Tero
> 
>> +
>> +struct psil_endpoint_config *psil_get_ep_config(u32 thread_id)
>> +{
>> +    int i;
>> +
>> +    mutex_lock(&ep_map_mutex);
>> +    if (!soc_ep_map) {
>> +        if (of_machine_is_compatible("ti,am654")) {
>> +            soc_ep_map = &am654_ep_map;
>> +        } else if (of_machine_is_compatible("ti,j721e")) {
>> +            soc_ep_map = &j721e_ep_map;
>> +        } else {
>> +            pr_err("PSIL: No compatible machine found for map\n");
>> +            return ERR_PTR(-ENOTSUPP);
>> +        }
>> +        pr_debug("%s: Using map for %s\n", __func__, soc_ep_map->name);
>> +    }
>> +    mutex_unlock(&ep_map_mutex);
>> +
>> +    if (thread_id & K3_PSIL_DST_THREAD_ID_OFFSET && soc_ep_map->dst) {
>> +        /* check in destination thread map */
>> +        for (i = 0; i < soc_ep_map->dst_count; i++) {
>> +            if (soc_ep_map->dst[i].thread_id == thread_id)
>> +                return &soc_ep_map->dst[i].ep_config;
>> +        }
>> +    }
>> +
>> +    thread_id &= ~K3_PSIL_DST_THREAD_ID_OFFSET;
>> +    if (soc_ep_map->src) {
>> +        for (i = 0; i < soc_ep_map->src_count; i++) {
>> +            if (soc_ep_map->src[i].thread_id == thread_id)
>> +                return &soc_ep_map->src[i].ep_config;
>> +        }
>> +    }
>> +
>> +    return ERR_PTR(-ENOENT);
>> +}
>> +EXPORT_SYMBOL(psil_get_ep_config);
>> +
>> +int psil_set_new_ep_config(struct device *dev, const char *name,
>> +               struct psil_endpoint_config *ep_config)
>> +{
>> +    struct psil_endpoint_config *dst_ep_config;
>> +    struct of_phandle_args dma_spec;
>> +    u32 thread_id;
>> +    int index;
>> +
>> +    if (!dev || !dev->of_node)
>> +        return -EINVAL;
>> +
>> +    index = of_property_match_string(dev->of_node, "dma-names", name);
>> +    if (index < 0)
>> +        return index;
>> +
>> +    if (of_parse_phandle_with_args(dev->of_node, "dmas", "#dma-cells",
>> +                       index, &dma_spec))
>> +        return -ENOENT;
>> +
>> +    thread_id = dma_spec.args[0];
>> +
>> +    dst_ep_config = psil_get_ep_config(thread_id);
>> +    if (IS_ERR(dst_ep_config)) {
>> +        pr_err("PSIL: thread ID 0x%04x not defined in map\n",
>> +               thread_id);
>> +        of_node_put(dma_spec.np);
>> +        return PTR_ERR(dst_ep_config);
>> +    }
>> +
>> +    memcpy(dst_ep_config, ep_config, sizeof(*dst_ep_config));
>> +
>> +    of_node_put(dma_spec.np);
>> +    return 0;
>> +}
>> +EXPORT_SYMBOL(psil_set_new_ep_config);
>> +
>> +MODULE_DESCRIPTION("TI K3 PSI-L endpoint database");
>> +MODULE_AUTHOR("Peter Ujfalusi <peter.ujfalusi@ti.com>");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/include/linux/dma/k3-psil.h b/include/linux/dma/k3-psil.h
>> new file mode 100644
>> index 000000000000..16e9c8c6f839
>> --- /dev/null
>> +++ b/include/linux/dma/k3-psil.h
>> @@ -0,0 +1,47 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + *  Copyright (C) 2019 Texas Instruments Incorporated -
>> http://www.ti.com
>> + */
>> +
>> +#ifndef K3_PSIL_H_
>> +#define K3_PSIL_H_
>> +
>> +#include <linux/types.h>
>> +
>> +#define K3_PSIL_DST_THREAD_ID_OFFSET 0x8000
>> +
>> +struct device;
>> +
>> +/* Channel Throughput Levels */
>> +enum udma_tp_level {
>> +    UDMA_TP_NORMAL = 0,
>> +    UDMA_TP_HIGH = 1,
>> +    UDMA_TP_ULTRAHIGH = 2,
>> +    UDMA_TP_LAST,
>> +};
>> +
>> +enum psil_endpoint_type {
>> +    PSIL_EP_NATIVE = 0,
>> +    PSIL_EP_PDMA_XY,
>> +    PSIL_EP_PDMA_MCAN,
>> +    PSIL_EP_PDMA_AASRC,
>> +};
>> +
>> +struct psil_endpoint_config {
>> +    enum psil_endpoint_type ep_type;
>> +
>> +    unsigned pkt_mode:1;
>> +    unsigned notdpkt:1;
>> +    unsigned needs_epib:1;
>> +    u32 psd_size;
>> +    enum udma_tp_level channel_tpl;
>> +
>> +    /* PDMA properties, valid for PSIL_EP_PDMA_* */
>> +    unsigned pdma_acc32:1;
>> +    unsigned pdma_burst:1;
>> +};
>> +
>> +int psil_set_new_ep_config(struct device *dev, const char *name,
>> +               struct psil_endpoint_config *ep_config);
>> +
>> +#endif /* K3_PSIL_H_ */
>>
> 
> -- 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
