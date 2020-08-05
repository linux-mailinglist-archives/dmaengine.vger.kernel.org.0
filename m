Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC89A23CD19
	for <lists+dmaengine@lfdr.de>; Wed,  5 Aug 2020 19:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbgHERUD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 Aug 2020 13:20:03 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51030 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbgHERSk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 5 Aug 2020 13:18:40 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 075DHV9M072287;
        Wed, 5 Aug 2020 08:17:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596633451;
        bh=57yF68qyZ0azOmyzTIEwYs+6yRB7tuKz3qfi5lQTL2Y=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fb84QEizh1xqIZv4YwwWKBoNcIaWNZdLEhdp8PKXmcuSz5LdjdZudXZ+ZMNZfMHp+
         I3YuZE1CRruSM+2Cd9D/meA6KiIyju3KG+y7B2dEGuxf4+6NuubBU86ah5a8RLBs36
         MaqnS51DCQ7/TOyrO0POqJY3nYVUcAdxjSdLfkaA=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 075DHVG9004195
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Aug 2020 08:17:31 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 5 Aug
 2020 08:17:30 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 5 Aug 2020 08:17:30 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 075DHSMg035743;
        Wed, 5 Aug 2020 08:17:28 -0500
Subject: Re: [PATCH] dmaengine: ti: k3-udma-glue: Fix parameters for rx ring
 pair request
To:     Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
CC:     <ssantosh@kernel.org>, <santosh.shilimkar@oracle.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>
References: <20200805112746.15475-1-peter.ujfalusi@ti.com>
 <20200805113237.GX12965@vkoul-mobl>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <3eea63fe-88f5-d6b6-433a-bb15495a839d@ti.com>
Date:   Wed, 5 Aug 2020 16:17:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200805113237.GX12965@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 05/08/2020 14:32, Vinod Koul wrote:
> On 05-08-20, 14:27, Peter Ujfalusi wrote:
>> The original commit mixed up the forward and completion ring IDs for the
>> rx flow configuration.
> 
> Acked-By: Vinod Koul <vkoul@kernel.org>
> 
>>
>> Fixes: 4927b1ab2047 ("dmaengine: ti: k3-udma: Switch to k3_ringacc_request_rings_pair")
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>> Hi Santosh, Vinod,
>>
>> the offending patch was queued via ti SoC tree.
>> Santosh, can you pick up this fix also?

Thank you Peter for catching this - it's valid issue.
but I'd like to note that issue was discovered with private code and
nothing is broken in Master.

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
Best regards,
grygorii
