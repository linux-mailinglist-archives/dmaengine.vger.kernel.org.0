Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05444AE4A0
	for <lists+dmaengine@lfdr.de>; Tue, 10 Sep 2019 09:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfIJH1b (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Sep 2019 03:27:31 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34360 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfIJH1b (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Sep 2019 03:27:31 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8A7RMsQ110822;
        Tue, 10 Sep 2019 02:27:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568100442;
        bh=2FCd0oZbRrdPCe62KstnW9at/OLpq3YSA6a8smnF4tk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Q5pfHFxDCfgC6N02F5/G2haKPQ50rdZTL5YUbgXbo7+W399JruszDiz+L8SKbx8YE
         +dgQTtIpRXpjpvSkISqBImURt1DxtqbU+TiTFyyLVeL4c83VE4F2/fjXp6IEfbYhdp
         KZWUYDJYaxIhbw8O/4oQM5Yu8viW1Cw7ZK6y3bS4=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8A7RMXw082532
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Sep 2019 02:27:22 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 10
 Sep 2019 02:27:21 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 10 Sep 2019 02:27:21 -0500
Received: from [10.250.98.116] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8A7RH75031075;
        Tue, 10 Sep 2019 02:27:18 -0500
Subject: Re: [PATCH v2 08/14] dmaengine: ti: New driver for K3 UDMA - split#1:
 defines, structs, io func
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lokeshvutla@ti.com>, <t-kristo@ti.com>, <tony@atomide.com>,
        <j-keerthy@ti.com>
References: <20190730093450.12664-1-peter.ujfalusi@ti.com>
 <20190730093450.12664-9-peter.ujfalusi@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <2081d1fb-dfa5-d7ca-2dd3-bdf42b60e51c@ti.com>
Date:   Tue, 10 Sep 2019 10:27:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730093450.12664-9-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 30/07/2019 12:34, Peter Ujfalusi wrote:
> Split patch for review containing: defines, structs, io and low level
> functions and interrupt callbacks.
> 
> DMA driver for
> Texas Instruments K3 NAVSS Unified DMA – Peripheral Root Complex (UDMA-P)
> 
> The UDMA-P is intended to perform similar (but significantly upgraded) functions
> as the packet-oriented DMA used on previous SoC devices. The UDMA-P module
> supports the transmission and reception of various packet types. The UDMA-P is
> architected to facilitate the segmentation and reassembly of SoC DMA data
> structure compliant packets to/from smaller data blocks that are natively
> compatible with the specific requirements of each connected peripheral. Multiple
> Tx and Rx channels are provided within the DMA which allow multiple segmentation
> or reassembly operations to be ongoing. The DMA controller maintains state
> information for each of the channels which allows packet segmentation and
> reassembly operations to be time division multiplexed between channels in order
> to share the underlying DMA hardware. An external DMA scheduler is used to
> control the ordering and rate at which this multiplexing occurs for Transmit
> operations. The ordering and rate of Receive operations is indirectly controlled
> by the order in which blocks are pushed into the DMA on the Rx PSI-L interface.
> 
> The UDMA-P also supports acting as both a UTC and UDMA-C for its internal
> channels. Channels in the UDMA-P can be configured to be either Packet-Based or
> Third-Party channels on a channel by channel basis.
> 
> The initial driver supports:
> - MEM_TO_MEM (TR mode)
> - DEV_TO_MEM (Packet / TR mode)
> - MEM_TO_DEV (Packet / TR mode)
> - Cyclic (Packet / TR mode)
> - Metadata for descriptors
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---

[...]

> +
> +/* Generic register access functions */
> +static inline u32 udma_read(void __iomem *base, int reg)
> +{
> +	return __raw_readl(base + reg);
> +}
> +
> +static inline void udma_write(void __iomem *base, int reg, u32 val)
> +{
> +	__raw_writel(val, base + reg);
> +}
> +
> +static inline void udma_update_bits(void __iomem *base, int reg,
> +				    u32 mask, u32 val)
> +{
> +	u32 tmp, orig;
> +
> +	orig = __raw_readl(base + reg);
> +	tmp = orig & ~mask;
> +	tmp |= (val & mask);
> +
> +	if (tmp != orig)
> +		__raw_writel(tmp, base + reg);
> +}

Pls, do not use  _raw APIs in drivers.

[...]

-- 
Best regards,
grygorii
