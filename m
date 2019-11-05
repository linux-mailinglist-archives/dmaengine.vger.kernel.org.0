Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 251ABEFA52
	for <lists+dmaengine@lfdr.de>; Tue,  5 Nov 2019 11:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387945AbfKEKBM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Nov 2019 05:01:12 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:44100 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387690AbfKEKBM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 5 Nov 2019 05:01:12 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA5A11fx040316;
        Tue, 5 Nov 2019 04:01:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572948061;
        bh=zbPTKFMP/VzQXIz/GVFKvy0Bu0kY7EmlTfBJtaGCMnY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=hsPSJ5PPRBoB3sBXG1LtBARKT2zN9fCaS9LhkOkrYQOM6HVtlkEYAyyjQYYcbL/XM
         q7JBa0WNoXYcB2azHcRf3Q0RRsax/sDEnAZGihLR+wRBuUhoBOebhTGnKhRhk3Isya
         9ZPn28nDm1syDYIbRJCvQ8ncDuI9x/uMElv4KebQ=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xA5A11PC107280
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Nov 2019 04:01:01 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 5 Nov
 2019 04:00:46 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 5 Nov 2019 04:01:00 -0600
Received: from [10.250.98.116] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA5A0vHX101993;
        Tue, 5 Nov 2019 04:00:58 -0600
Subject: Re: [PATCH v4 07/15] dmaengine: ti: k3 PSI-L remote endpoint
 configuration
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lokeshvutla@ti.com>, <t-kristo@ti.com>, <tony@atomide.com>,
        <j-keerthy@ti.com>
References: <20191101084135.14811-1-peter.ujfalusi@ti.com>
 <20191101084135.14811-8-peter.ujfalusi@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <bbe8e13f-b865-a352-7960-31b2865e5421@ti.com>
Date:   Tue, 5 Nov 2019 12:00:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191101084135.14811-8-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peter,

On 01/11/2019 10:41, Peter Ujfalusi wrote:
> In K3 architecture the DMA operates within threads. One end of the thread
> is UDMAP, the other is on the peripheral side.
> 
> The UDMAP channel configuration depends on the needs of the remote
> endpoint and it can be differ from peripheral to peripheral.
> 
> This patch adds database for am654 and j721e and small API to fetch the
> PSI-L endpoint configuration from the database which should only used by
> the DMA driver(s).
> 
> Another API is added for native peripherals to give possibility to pass new
> configuration for the threads they are using, which is needed to be able to
> handle changes caused by different firmware loaded for the peripheral for
> example.

I have no objection to this approach, but ...

> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>   drivers/dma/ti/Kconfig         |   3 +
>   drivers/dma/ti/Makefile        |   1 +
>   drivers/dma/ti/k3-psil-am654.c | 172 ++++++++++++++++++++++++++
>   drivers/dma/ti/k3-psil-j721e.c | 219 +++++++++++++++++++++++++++++++++
>   drivers/dma/ti/k3-psil-priv.h  |  39 ++++++
>   drivers/dma/ti/k3-psil.c       |  97 +++++++++++++++
>   include/linux/dma/k3-psil.h    |  47 +++++++
>   7 files changed, 578 insertions(+)
>   create mode 100644 drivers/dma/ti/k3-psil-am654.c
>   create mode 100644 drivers/dma/ti/k3-psil-j721e.c
>   create mode 100644 drivers/dma/ti/k3-psil-priv.h
>   create mode 100644 drivers/dma/ti/k3-psil.c
>   create mode 100644 include/linux/dma/k3-psil.h
> 

[...]

> diff --git a/include/linux/dma/k3-psil.h b/include/linux/dma/k3-psil.h
> new file mode 100644
> index 000000000000..16e9c8c6f839
> --- /dev/null
> +++ b/include/linux/dma/k3-psil.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + *  Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
> + */
> +
> +#ifndef K3_PSIL_H_
> +#define K3_PSIL_H_
> +
> +#include <linux/types.h>
> +
> +#define K3_PSIL_DST_THREAD_ID_OFFSET 0x8000
> +
> +struct device;
> +
> +/* Channel Throughput Levels */
> +enum udma_tp_level {
> +	UDMA_TP_NORMAL = 0,
> +	UDMA_TP_HIGH = 1,
> +	UDMA_TP_ULTRAHIGH = 2,
> +	UDMA_TP_LAST,
> +};
> +
> +enum psil_endpoint_type {
> +	PSIL_EP_NATIVE = 0,
> +	PSIL_EP_PDMA_XY,
> +	PSIL_EP_PDMA_MCAN,
> +	PSIL_EP_PDMA_AASRC,
> +};
> +
> +struct psil_endpoint_config {
> +	enum psil_endpoint_type ep_type;
> +
> +	unsigned pkt_mode:1;
> +	unsigned notdpkt:1;
> +	unsigned needs_epib:1;
> +	u32 psd_size;
> +	enum udma_tp_level channel_tpl;
> +
> +	/* PDMA properties, valid for PSIL_EP_PDMA_* */
> +	unsigned pdma_acc32:1;
> +	unsigned pdma_burst:1;
> +};
> +
> +int psil_set_new_ep_config(struct device *dev, const char *name,
> +			   struct psil_endpoint_config *ep_config);
> +
> +#endif /* K3_PSIL_H_ */
> 

I see no user now of this public interface, so I think it better to drop it until
there will be real user of it.

-- 
Best regards,
grygorii
