Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 784B1CF6C2
	for <lists+dmaengine@lfdr.de>; Tue,  8 Oct 2019 12:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbfJHKJU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Oct 2019 06:09:20 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55194 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728866AbfJHKJT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Oct 2019 06:09:19 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x98A937D068103;
        Tue, 8 Oct 2019 05:09:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570529344;
        bh=FkNiIod96/3T2zF68YAgCCg2oYEqg3sIPlPb6RVQtJU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=rqMjNPvD+0W8D0F/WVHwVLj73f3VdnSnzzhobu03+GT+LpwtlmnElkM6+UnCNa2sw
         8ybL4vocG5xUba642POMwE/IomSzf/qjbYfgZPXOQW3CKZ5Ig6SJZ4QNZP+PbL4K/R
         8RJvjvO1x23sLcJ8v/RAtTk5F+ZLBrlCfGxQOyDE=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x98A9373015293;
        Tue, 8 Oct 2019 05:09:03 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 8 Oct
 2019 05:09:00 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 8 Oct 2019 05:09:02 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x98A8xv6073491;
        Tue, 8 Oct 2019 05:08:59 -0500
Subject: Re: [PATCH v3 00/14] dmaengine/soc: Add Texas Instruments UDMA
 support
To:     <santosh.shilimkar@oracle.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>
References: <20191001061704.2399-1-peter.ujfalusi@ti.com>
 <c567c1a2-2e74-3809-8e0f-4c2049ba4747@oracle.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <7dd18208-1ca5-c902-dc11-edbd4ded51ed@ti.com>
Date:   Tue, 8 Oct 2019 13:09:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c567c1a2-2e74-3809-8e0f-4c2049ba4747@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Santosh,

On 04/10/2019 19.35, santosh.shilimkar@oracle.com wrote:
> On 9/30/19 11:16 PM, Peter Ujfalusi wrote:
>> Hi,
>>
>> Changes since v2
>> )https://patchwork.kernel.org/project/linux-dmaengine/list/?series=152609&state=*)
>>
>> - Based on 5.4-rc1
>> - Support for Flow only data transfer for the glue layer
>>
> 
>>
>> Grygorii Strashko (3):
>>    bindings: soc: ti: add documentation for k3 ringacc
>>    soc: ti: k3: add navss ringacc driver
>>    dmaengine: ti: k3-udma: Add glue layer for non DMAengine users
>>
>> Peter Ujfalusi (11):
>>    dmaengine: doc: Add sections for per descriptor metadata support
>>    dmaengine: Add metadata_ops for dma_async_tx_descriptor
>>    dmaengine: Add support for reporting DMA cached data amount
>>    dmaengine: ti: Add cppi5 header for UDMA
>>    dt-bindings: dma: ti: Add document for K3 UDMA
>>    dmaengine: ti: New driver for K3 UDMA - split#1: defines, structs, io
>>      func
>>    dmaengine: ti: New driver for K3 UDMA - split#2: probe/remove, xlate
>>      and filter_fn
>>    dmaengine: ti: New driver for K3 UDMA - split#3: alloc/free
>>      chan_resources
>>    dmaengine: ti: New driver for K3 UDMA - split#4: dma_device callbacks
>>      1
>>    dmaengine: ti: New driver for K3 UDMA - split#5: dma_device callbacks
>>      2
>>    dmaengine: ti: New driver for K3 UDMA - split#6: Kconfig and Makefile
>>
>>   .../devicetree/bindings/dma/ti/k3-udma.txt    |  185 +
>>   .../devicetree/bindings/soc/ti/k3-ringacc.txt |   59 +
>>   Documentation/driver-api/dmaengine/client.rst |   75 +
>>   .../driver-api/dmaengine/provider.rst         |   46 +
>>   drivers/dma/dmaengine.c                       |   73 +
>>   drivers/dma/dmaengine.h                       |    8 +
>>   drivers/dma/ti/Kconfig                        |   22 +
>>   drivers/dma/ti/Makefile                       |    2 +
>>   drivers/dma/ti/k3-udma-glue.c                 | 1225 ++++++
>>   drivers/dma/ti/k3-udma-private.c              |  141 +
>>   drivers/dma/ti/k3-udma.c                      | 3525 +++++++++++++++++
>>   drivers/dma/ti/k3-udma.h                      |  161 +
>>   drivers/soc/ti/Kconfig                        |   12 +
>>   drivers/soc/ti/Makefile                       |    1 +
>>   drivers/soc/ti/k3-ringacc.c                   | 1165 ++++++
>>   include/dt-bindings/dma/k3-udma.h             |   10 +
>>   include/linux/dma/k3-udma-glue.h              |  134 +
>>   include/linux/dma/ti-cppi5.h                  | 1049 +++++
>>   include/linux/dmaengine.h                     |  110 +
>>   include/linux/soc/ti/k3-ringacc.h             |  245 ++
>>   20 files changed, 8248 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/dma/ti/k3-udma.txt
>>   create mode 100644
>> Documentation/devicetree/bindings/soc/ti/k3-ringacc.txt
>>   create mode 100644 drivers/dma/ti/k3-udma-glue.c
>>   create mode 100644 drivers/dma/ti/k3-udma-private.c
>>   create mode 100644 drivers/dma/ti/k3-udma.c
>>   create mode 100644 drivers/dma/ti/k3-udma.h
>>   create mode 100644 drivers/soc/ti/k3-ringacc.c
>>   create mode 100644 include/dt-bindings/dma/k3-udma.h
>>   create mode 100644 include/linux/dma/k3-udma-glue.h
>>   create mode 100644 include/linux/dma/ti-cppi5.h
>>   create mode 100644 include/linux/soc/ti/k3-ringacc.h
>>
> Can you please split this series and post drivers/soc/* bits
> separately ?  If its ready, I can apply k3-ringacc.c changes.

I'll wait couple of days for guys to check the series, then I can send
the split out ringacc patches separately.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
