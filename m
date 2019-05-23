Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3A7927B2D
	for <lists+dmaengine@lfdr.de>; Thu, 23 May 2019 12:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbfEWK53 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 May 2019 06:57:29 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41460 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbfEWK53 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 May 2019 06:57:29 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4NAvMjw040457;
        Thu, 23 May 2019 05:57:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1558609042;
        bh=LSEJtFUDM6YDrSW3z0O5orc8crYEJg4pp8/IPEdND4A=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=qVLmnzLf8/5JMVPAdud7G3aasywLvRGgzeD59+FaCfKb8NbMWdDnt+pT35cu2besm
         +eOWb+aVHIzfww7MiPBMlwUydyxT9iPBIiLXT6OubbyVPFjItcn5NC7r6H60DZStP1
         DaWKs0SmZz7HTEBOL84qr9XDU15bGRZFDm/jCH88=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4NAvMsN119479
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 May 2019 05:57:22 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 23
 May 2019 05:57:22 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 23 May 2019 05:57:22 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4NAvKDO018622;
        Thu, 23 May 2019 05:57:21 -0500
Subject: Re: [PATCH v3 0/2] dmaengine: ti: edma: Polled completion support
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>
References: <20190521093646.21836-1-peter.ujfalusi@ti.com>
Message-ID: <19b0d346-5249-e832-8eea-685c8e7706e2@ti.com>
Date:   Thu, 23 May 2019 13:57:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190521093646.21836-1-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Vinod,

On 21/05/2019 12.36, Peter Ujfalusi wrote:
> Hi,
> 
> Changes since v2:
> - Fix typo in the comment for patch 0
> 
> Changes since v1:
> - Cleanup patch for the array register handling
> - typo fixed in patch2 commit message
> 
> The code around the array register access was pretty confusing for the first
> look, so clean them up first then use the cleaner way in the polled handling.
> 
> When a DMA client driver decides that it is not providing callback for
> completion of a transfer (and/or does not set the DMA_PREP_INTERRUPT) but
> it will poll the status of the transfer (in case of short memcpy for
> example) we will not get interrupt for the completion of the transfer and
> will not mark the transaction as done.
> 
> Check the event registers (ER and EER) and if the channel is inactive then
> return wioth DMA_COMPLETE to let the client know that the transfer is
> completed.

Please do not pick this up yet, I got report that it might cause side
effect which I need to debug to understand.

> 
> Regards,
> Peter
> ---
> Peter Ujfalusi (2):
>   dmaengine: ti: edma: Clean up the 2x32bit array register accesses
>   dmaengine: ti: edma: Enable support for polled (memcpy) completion
> 
>  drivers/dma/ti/edma.c | 129 ++++++++++++++++++++++++++----------------
>  1 file changed, 81 insertions(+), 48 deletions(-)
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
