Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA212D2A0A
	for <lists+dmaengine@lfdr.de>; Tue,  8 Dec 2020 12:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgLHLyy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Dec 2020 06:54:54 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38956 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgLHLyy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Dec 2020 06:54:54 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0B8BrFWg056263;
        Tue, 8 Dec 2020 05:53:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607428395;
        bh=O9mL6Dgrk2AVgo4JKOdHkqRTOXCD0cWjEPf/L5oZ/XQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=tynT1opcaAkOvu3fA0vs90dekOZWxBbZRl2UDu3MUHsDqRdOQ9JjcujKgYEuNApLz
         aQH4Ynj525P228wnTTzRjK5OvM8n9tpOjnF8uWiETzRlREC5rrRxLtmeMSWquyafIq
         stkLwDk51HIxEwiSUDIAF7uE3S8Tig/evuuhfh04=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0B8BrFGF056255
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Dec 2020 05:53:15 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 8 Dec
 2020 05:53:14 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 8 Dec 2020 05:53:14 -0600
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0B8BrAPU022853;
        Tue, 8 Dec 2020 05:53:11 -0600
Subject: Re: [PATCH v3 06/20] dmaengine: ti: k3-udma-glue: Configure the
 dma_dev for rings
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <vkoul@kernel.org>,
        <nm@ti.com>, <ssantosh@kernel.org>, <robh+dt@kernel.org>
CC:     <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <vigneshr@ti.com>
References: <20201208090440.31792-1-peter.ujfalusi@ti.com>
 <20201208090440.31792-7-peter.ujfalusi@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <25fdf6df-4872-45d4-ac88-567005893c31@ti.com>
Date:   Tue, 8 Dec 2020 13:53:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201208090440.31792-7-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 08/12/2020 11:04, Peter Ujfalusi wrote:
> Rings in RING mode should be using the DMA device for DMA API as in this
> mode the ringacc will not access the ring memory in any ways, but the DMA
> is.
> 
> Fix up the ring configuration and set the dma_dev unconditionally and let
> the ringacc driver to select the correct device to use for DMA API.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>   drivers/dma/ti/k3-udma-glue.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
Best regards,
grygorii
