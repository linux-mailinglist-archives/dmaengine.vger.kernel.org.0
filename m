Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2E5F7211
	for <lists+dmaengine@lfdr.de>; Mon, 11 Nov 2019 11:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfKKKao (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Nov 2019 05:30:44 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54336 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfKKKao (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Nov 2019 05:30:44 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xABAUaL6024709;
        Mon, 11 Nov 2019 04:30:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573468236;
        bh=J49vO9a5Q6nbdkFfwrMnpwhRrLhy3uz8gGzESzCD4oo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=J0pC0vQNOwWzcvvyyQL76SmlVuEzN0Z+CjL83wyC4lp4rBJiQ2R1WTU+ky0182CGU
         FTXTm6Qn7grF70n77I6mtxC44f2VRRamde1Mg5BmLaZlzhLGa12VcCNxC08G61KIOA
         d5uzuQB+yddSy3ouqSKbKhg+hMh59KTqSgK/uEBU=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xABAUZfl057030
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Nov 2019 04:30:35 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 11
 Nov 2019 04:30:17 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 11 Nov 2019 04:30:17 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xABAUVBd048429;
        Mon, 11 Nov 2019 04:30:31 -0600
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
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <6d4d2fcc-502b-4b41-cd71-8942741f4ad8@ti.com>
Date:   Mon, 11 Nov 2019 12:31:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191111061258.GS952516@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 11/11/2019 8.12, Vinod Koul wrote:
> On 01-11-19, 10:41, Peter Ujfalusi wrote:
>> From: Grygorii Strashko <grygorii.strashko@ti.com>
>>
>> Certain users can not use right now the DMAengine API due to missing
>> features in the core. Prime example is Networking.
>>
>> These users can use the glue layer interface to avoid misuse of DMAengine
>> API and when the core gains the needed features they can be converted to
>> use generic API.
> 
> Can you add some notes on what all features does this layer implement..

In the commit message or in the code?

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
