Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9654BD0816
	for <lists+dmaengine@lfdr.de>; Wed,  9 Oct 2019 09:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbfJIHOl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Oct 2019 03:14:41 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59340 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfJIHOl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Oct 2019 03:14:41 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x997EWLO009452;
        Wed, 9 Oct 2019 02:14:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570605272;
        bh=zf5X2BOp2+egdE7AI2QsP0CKdt0YNu7iahL8fNjOr/E=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=lOwZrDqhMyVBOcbkKs8knDjA7xQ1ijp3+TkwBRtJyqT97aocD4xDzWiUfRLoejDDI
         zwPuFkOXfo70N2tvODrW4AoDCsmmj6iTTfhoh9ksH1M5VCcVu7HQA3Ss0j1fTHjPTC
         O2kTMlxo00bgsMHVhOcBSmXPEJSUREQbZ7E1K3cM=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x997EWKu029687
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Oct 2019 02:14:32 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 9 Oct
 2019 02:14:26 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 9 Oct 2019 02:14:26 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x997EPXS021356;
        Wed, 9 Oct 2019 02:14:26 -0500
Subject: Re: [PATCH v3 02/14] soc: ti: k3: add navss ringacc driver
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <tony@atomide.com>, <j-keerthy@ti.com>
References: <20191001061704.2399-1-peter.ujfalusi@ti.com>
 <20191001061704.2399-3-peter.ujfalusi@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <cadf50c0-1bb9-1fa5-98e0-12bf8e2b5644@ti.com>
Date:   Wed, 9 Oct 2019 10:14:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191001061704.2399-3-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 01/10/2019 09:16, Peter Ujfalusi wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> The Ring Accelerator (RINGACC or RA) provides hardware acceleration to
> enable straightforward passing of work between a producer and a consumer.
> There is one RINGACC module per NAVSS on TI AM65x SoCs.
> 
> The RINGACC converts constant-address read and write accesses to equivalent
> read or write accesses to a circular data structure in memory. The RINGACC
> eliminates the need for each DMA controller which needs to access ring
> elements from having to know the current state of the ring (base address,
> current offset). The DMA controller performs a read or write access to a
> specific address range (which maps to the source interface on the RINGACC)
> and the RINGACC replaces the address for the transaction with a new address
> which corresponds to the head or tail element of the ring (head for reads,
> tail for writes). Since the RINGACC maintains the state, multiple DMA
> controllers or channels are allowed to coherently share the same rings as
> applicable. The RINGACC is able to place data which is destined towards
> software into cached memory directly.
> 
> Supported ring modes:
> - Ring Mode
> - Messaging Mode
> - Credentials Mode
> - Queue Manager Mode
> 
> TI-SCI integration:
> 
> Texas Instrument's System Control Interface (TI-SCI) Message Protocol now
> has control over Ringacc module resources management (RM) and Rings
> configuration.
> 
> The corresponding support of TI-SCI Ringacc module RM protocol
> introduced as option through DT parameters:
> - ti,sci: phandle on TI-SCI firmware controller DT node
> - ti,sci-dev-id: TI-SCI device identifier as per TI-SCI firmware spec
> 
> if both parameters present - Ringacc driver will configure/free/reset Rings
> using TI-SCI Message Ringacc RM Protocol.
> 
> The Ringacc driver manages Rings allocation by itself now and requests
> TI-SCI firmware to allocate and configure specific Rings only. It's done
> this way because, Linux driver implements two stage Rings allocation and
> configuration (allocate ring and configure ring) while I-SCI Message

You missed fixing the typo above: I-SCI to TI-SCI. However, it is just 
cosmetic so I don't mind.

Reviewed-by: Tero Kristo <t-kristo@ti.com>
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
