Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC66ED1062
	for <lists+dmaengine@lfdr.de>; Wed,  9 Oct 2019 15:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731378AbfJINlN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Oct 2019 09:41:13 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:48178 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731254AbfJINlN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Oct 2019 09:41:13 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x99Df5sN105925;
        Wed, 9 Oct 2019 08:41:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570628465;
        bh=SsWCaK0u568BJNLYQT3qNkhvXINTJ8zHD7fBBHIwLt4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=JTafH1Z3hknmtTUE2L6QNZjY+A5PGwZztPE6/rIM1fQf0BzitaE1wJ6FwU8Gwq9+p
         NA6GhortGRHuhA/FdFwjOovda8C5q7mUB5/qa73KoCo6QoSjNEhPcrYqdO3+A2Jk4V
         P3/mvLIuVgA6ctK8W1AaIxFrXDYhZ01xTczq7iUE=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x99Df4I7084862;
        Wed, 9 Oct 2019 08:41:05 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 9 Oct
 2019 08:41:03 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 9 Oct 2019 08:41:03 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x99Df0HJ075056;
        Wed, 9 Oct 2019 08:41:00 -0500
Subject: Re: [PATCH v3 08/14] dmaengine: ti: New driver for K3 UDMA - split#1:
 defines, structs, io func
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <tony@atomide.com>, <j-keerthy@ti.com>
References: <20191001061704.2399-1-peter.ujfalusi@ti.com>
 <20191001061704.2399-9-peter.ujfalusi@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <8bd7db20-811d-b7c7-38ec-75f1c9d94b8f@ti.com>
Date:   Wed, 9 Oct 2019 16:40:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191001061704.2399-9-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 01/10/2019 09:16, Peter Ujfalusi wrote:
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

Did review this to best of my ability but could not find anything 
obviously broken, thus:

Reviewed-by: Tero Kristo <t-kristo@ti.com>

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
