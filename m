Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC858F89A3
	for <lists+dmaengine@lfdr.de>; Tue, 12 Nov 2019 08:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbfKLHY3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Nov 2019 02:24:29 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60552 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfKLHY3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Nov 2019 02:24:29 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAC7OLls037267;
        Tue, 12 Nov 2019 01:24:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573543461;
        bh=9ZjEggkK3tYtTfvVyv4LxqBOLJcpeT8JiS+RxzIUC7I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QcMaLS2gpVQKfVjYt3+Pr40c87QkE10hjw6CtAoXzDYohl5rT3zKu1DCZbHNbB9u6
         NUQDbUctWfRnd/2xcL2F/P5CAILp10Zh94rxHybOYz51g802mD9lsVjXqjBbsuRyiC
         B6H8Vzvg10kZWBVNETmTPG5mFxxCmhz8szpl1zD4=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAC7OLOM028549
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Nov 2019 01:24:21 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 12
 Nov 2019 01:24:03 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 12 Nov 2019 01:24:03 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAC7OHG7089194;
        Tue, 12 Nov 2019 01:24:17 -0600
Subject: Re: [PATCH v4 15/15] dmaengine: ti: k3-udma: Add glue layer for non
 DMAengine users
To:     Vinod Koul <vkoul@kernel.org>
CC:     <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>
References: <20191101084135.14811-1-peter.ujfalusi@ti.com>
 <20191101084135.14811-16-peter.ujfalusi@ti.com>
 <20191111061258.GS952516@vkoul-mobl>
 <6d4d2fcc-502b-4b41-cd71-8942741f4ad8@ti.com>
 <20191112053714.GX952516@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <b6b38b97-216f-c297-a414-e3c1f5703a68@ti.com>
Date:   Tue, 12 Nov 2019 09:25:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191112053714.GX952516@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 12/11/2019 7.37, Vinod Koul wrote:
> On 11-11-19, 12:31, Peter Ujfalusi wrote:
>>
>>
>> On 11/11/2019 8.12, Vinod Koul wrote:
>>> On 01-11-19, 10:41, Peter Ujfalusi wrote:
>>>> From: Grygorii Strashko <grygorii.strashko@ti.com>
>>>>
>>>> Certain users can not use right now the DMAengine API due to missing
>>>> features in the core. Prime example is Networking.
>>>>
>>>> These users can use the glue layer interface to avoid misuse of DMAengine
>>>> API and when the core gains the needed features they can be converted to
>>>> use generic API.
>>>
>>> Can you add some notes on what all features does this layer implement..
>>
>> In the commit message or in the code?
> 
> commit here so that we know what to expect.

Can you check the v5 commit message if it is sufficient? If not, I can
make it more verbose for v6.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
