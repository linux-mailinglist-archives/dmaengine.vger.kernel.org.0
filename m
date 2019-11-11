Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 600ACF7201
	for <lists+dmaengine@lfdr.de>; Mon, 11 Nov 2019 11:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfKKK3m (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Nov 2019 05:29:42 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:48718 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfKKK3m (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Nov 2019 05:29:42 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xABATOlD073873;
        Mon, 11 Nov 2019 04:29:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573468164;
        bh=YZpKaTqvmzh9hQ+PeGOHHrD58ep4jR3IJK9ti43dRBQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=iszyDxY564+967ulaJhpJdBOFhlO3JSftHYlHmoQaetS0FcvzfAhljN2dJsRV4NaG
         T+Lt4x2b6cLn120CIEf7ZuK/ew7C5PdCMxtV7muQ3c271Ibrp1cnhPl4LSDG0zALJJ
         HyDEKq0P4whdVswhWxSmFUzpE5vDgx2XUCrk+Zh4=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xABATOKd055099
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Nov 2019 04:29:24 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 11
 Nov 2019 04:29:06 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 11 Nov 2019 04:29:06 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xABATKrB106153;
        Mon, 11 Nov 2019 04:29:21 -0600
Subject: Re: [PATCH v4 14/15] dmaengine: ti: New driver for K3 UDMA - split#6:
 Kconfig and Makefile
To:     Vinod Koul <vkoul@kernel.org>
CC:     <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>
References: <20191101084135.14811-1-peter.ujfalusi@ti.com>
 <20191101084135.14811-15-peter.ujfalusi@ti.com>
 <20191111061159.GR952516@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <20ab927d-e869-d240-8871-005181279dc6@ti.com>
Date:   Mon, 11 Nov 2019 12:30:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191111061159.GR952516@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 11/11/2019 8.11, Vinod Koul wrote:
>> +config TI_K3_UDMA
>> +	tristate "Texas Instruments UDMA support"
>> +	depends on ARCH_K3 || COMPILE_TEST
>> +	depends on TI_SCI_PROTOCOL
>> +	depends on TI_SCI_INTA_IRQCHIP
>> +	select DMA_ENGINE
>> +	select DMA_VIRTUAL_CHANNELS
>> +	select TI_K3_RINGACC
>> +	select TI_K3_PSIL
>> +	default y
> 
> Again no default y!

Removed

> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
