Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB206E472B
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2019 11:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408437AbfJYJ3f (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 25 Oct 2019 05:29:35 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37016 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406381AbfJYJ3f (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 25 Oct 2019 05:29:35 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9P9TO13045068;
        Fri, 25 Oct 2019 04:29:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571995764;
        bh=HPgJGVv34kaCbmxMyK0unoXFnunk412hxWQRl6+VdGs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QIjqKvIafKs5pLDpGkeA2AbWniDt0/nKgA983Uct6RXVus3kYfPTP+pTO4u5SQiUb
         kAZmXEjJ+PFU3ZbNgzdLCD7G8CMRTJ+5IUy1Kx2LviA7CUiDTJoJI1zrvw2DQRiyH4
         +nHfXR1vjDkIFrKYzYw9Xjhv0u991lLBxYTcXdxg=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9P9TOlD053121
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Oct 2019 04:29:24 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 25
 Oct 2019 04:29:13 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 25 Oct 2019 04:29:23 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9P9TKLQ117235;
        Fri, 25 Oct 2019 04:29:20 -0500
Subject: Re: [PATCH v3 02/14] soc: ti: k3: add navss ringacc driver
To:     Lokesh Vutla <lokeshvutla@ti.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <t-kristo@ti.com>, <tony@atomide.com>,
        <j-keerthy@ti.com>
References: <20191001061704.2399-1-peter.ujfalusi@ti.com>
 <20191001061704.2399-3-peter.ujfalusi@ti.com>
 <86344789-e0f4-5b29-62da-3fb08025177b@ti.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <0a698278-19d8-bb20-34b9-9695d670b3a8@ti.com>
Date:   Fri, 25 Oct 2019 12:30:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <86344789-e0f4-5b29-62da-3fb08025177b@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 09/10/2019 16.27, Lokesh Vutla wrote:
>> +struct k3_ringacc {
>> +	struct device *dev;
>> +	struct k3_ringacc_proxy_gcfg_regs __iomem *proxy_gcfg;
>> +	void __iomem *proxy_target_base;
>> +	u32 num_rings; /* number of rings in Ringacc module */
>> +	unsigned long *rings_inuse;
>> +	struct ti_sci_resource *rm_gp_range;
>> +
>> +	bool dma_ring_reset_quirk;
>> +	u32 num_proxies;
>> +	unsigned long *proxy_inuse;
>> +
>> +	struct k3_ring *rings;
>> +	struct list_head list;
>> +	struct mutex req_lock; /* protect rings allocation */
>> +
>> +	const struct ti_sci_handle *tisci;
>> +	const struct ti_sci_rm_ringacc_ops *tisci_ring_ops;
>> +	u32  tisci_dev_id;
> 
> This can be dropped no? pdev->id has it already.

pdev->id might have it but it is simpler to keep it here than getting
the pdev when we need it

...

>> +struct k3_ring *k3_ringacc_request_ring(struct k3_ringacc *ringacc,
>> +					int id, u32 flags)
>> +{
>> +	int proxy_id = K3_RINGACC_PROXY_NOT_USED;
>> +
>> +	mutex_lock(&ringacc->req_lock);
>> +
>> +	if (id == K3_RINGACC_RING_ID_ANY) {
>> +		/* Request for any general purpose ring */
>> +		struct ti_sci_resource_desc *gp_rings =
>> +						&ringacc->rm_gp_range->desc[0];> +		unsigned long size;
>> +
>> +		size = gp_rings->start + gp_rings->num;
>> +		id = find_next_zero_bit(ringacc->rings_inuse, size,
>> +					gp_rings->start);
> 
> ti_sci_get_free resource can be used no? In case if id is passed, that bit alone
> can be set.

Hrm, kind of yes.
We have a bitfield for _all_ rings managed locally so I don't see much
benefit to manage another bitfiled usage, which is redundant.

>> +		if (id == size)
>> +			goto error;
>> +	} else if (id < 0) {
>> +		goto error;
>> +	}
>> +
>> +	if (test_bit(id, ringacc->rings_inuse) &&
>> +	    !(ringacc->rings[id].flags & K3_RING_FLAG_SHARED))
>> +		goto error;
>> +	else if (ringacc->rings[id].flags & K3_RING_FLAG_SHARED)
>> +		goto out;
>> +
>> +	if (flags & K3_RINGACC_RING_USE_PROXY) {
>> +		proxy_id = find_next_zero_bit(ringacc->proxy_inuse,
>> +					      ringacc->num_proxies, 0);
> 
> May be a dump question, but how do we make sure that these proxies are not used
> by another Hosts?

That's a good question. Grygorii?

> 
>> +		if (proxy_id == ringacc->num_proxies)
>> +			goto error;
>> +	}
>> +
>> +	if (!try_module_get(ringacc->dev->driver->owner))
>> +		goto error;
>> +
>> +	if (proxy_id != K3_RINGACC_PROXY_NOT_USED) {
>> +		set_bit(proxy_id, ringacc->proxy_inuse);
>> +		ringacc->rings[id].proxy_id = proxy_id;
>> +		dev_dbg(ringacc->dev, "Giving ring#%d proxy#%d\n", id,
>> +			proxy_id);
>> +	} else {
>> +		dev_dbg(ringacc->dev, "Giving ring#%d\n", id);
>> +	}
>> +
>> +	set_bit(id, ringacc->rings_inuse);
>> +out:
>> +	ringacc->rings[id].use_count++;
>> +	mutex_unlock(&ringacc->req_lock);
>> +	return &ringacc->rings[id];
>> +
>> +error:
>> +	mutex_unlock(&ringacc->req_lock);
>> +	return NULL;
>> +}
>> +EXPORT_SYMBOL_GPL(k3_ringacc_request_ring);
>> +

...
>> +	pm_runtime_enable(dev);
>> +	ret = pm_runtime_get_sync(dev);
>> +	if (ret < 0) {
>> +		pm_runtime_put_noidle(dev);
>> +		dev_err(dev, "Failed to enable pm %d\n", ret);
>> +		goto err;
>> +	}
> 
> Don't you need power-domains property in DT so that pm is actually working? If
> that is populated, dev-id can be derived from power-domains rather than a
> separate dt property.

Right, I never felt comfortable to fiddle with something outside of the
scope of the driver. What happens (unlikely) if the power-domains
binding got changed for some reason?

Another thing is that the whole NAVSS is always on, it can not power off
as it would loose all of it's configuration including event mappings,
DMA channel configurations, interrupt configs, ring configurations,
mailbox, timers, etc.

It is a catastrophic thing which can only be solved with a hard reboot
as there is no way to recover from it - system firmware would need to
rebooted as well.

In current SoCs NAVSS can not be off. Without power-domains in DT the
pm_runtime is NOP, but if this changes (NAVSS could turn off) we need to
prevent NAVSS power off and the code is ready for that, we just pop in
the power-domains to DT.

> 
> [...snip..]
> 
> 
>> diff --git a/include/linux/soc/ti/k3-ringacc.h b/include/linux/soc/ti/k3-ringacc.h
>> new file mode 100644
>> index 000000000000..526b2e38fcce
>> --- /dev/null
>> +++ b/include/linux/soc/ti/k3-ringacc.h
>> @@ -0,0 +1,245 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * K3 Ring Accelerator (RA) subsystem interface
>> + *
>> + * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
>> + */
>> +
>> +#ifndef __SOC_TI_K3_RINGACC_API_H_
>> +#define __SOC_TI_K3_RINGACC_API_H_
>> +
>> +#include <linux/types.h>
>> +
>> +struct device_node;
>> +
> 
> [...snip..]
> 
>> +
>> +/**
>> + * k3_ringacc_ring_reset - ring reset
>> + * @ring: pointer on Ring
>> + *
>> + * Resets ring internal state ((hw)occ, (hw)idx).
>> + * TODO_GS: ? Ring can be reused without reconfiguration
> 
> TODO_GS?
> 
> Thanks and regards,
> Lokesh
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
