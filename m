Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF119316553
	for <lists+dmaengine@lfdr.de>; Wed, 10 Feb 2021 12:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhBJLh2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 10 Feb 2021 06:37:28 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44928 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhBJLgI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 10 Feb 2021 06:36:08 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 11ABYhsG084287;
        Wed, 10 Feb 2021 05:34:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1612956883;
        bh=ZTT5yWAttLg1aAPI3ziGR5Ht0gucArUIncPh/zW+Slo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fLrc9Bga7XGx1ykAbm/5P1m4+6987rvctjneHqEbVsSS0IGPFeeyMtWRWjsgS3Ls6
         AxM85HnMtnEe6AiDd3muA4ZbuxiL8V2HLYJ7ZbGDxV4Vq2/hEpKSPsrQqphOtYEAru
         xcHHs76MZ4TP3c0PBNA+GbXKqkSTRW5Kf+LVx0Zo=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 11ABYhdl120259
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Feb 2021 05:34:43 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 10
 Feb 2021 05:34:43 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 10 Feb 2021 05:34:43 -0600
Received: from [10.250.232.207] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 11ABYdg2126128;
        Wed, 10 Feb 2021 05:34:40 -0600
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Fix NULL pointer dereference
 error
To:     =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210209120238.9476-1-kishon@ti.com>
 <8e9954cd-53fa-2c7e-2019-9821e5f9d45a@gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <30bfe6ef-de01-e019-d2d3-a999d6261fd8@ti.com>
Date:   Wed, 10 Feb 2021 17:04:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8e9954cd-53fa-2c7e-2019-9821e5f9d45a@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peter,

On 10/02/21 3:33 pm, Péter Ujfalusi wrote:
> Hi Kishon,
> 
> On 2/9/21 2:02 PM, Kishon Vijay Abraham I wrote:
>> bcdma_get_*() and udma_get_*() checks if bchan/rchan/tchan/rflow is
>> already allocated by checking if it has a NON NULL value. For the
>> error cases, bchan/rchan/tchan/rflow will have error value
>> and bcdma_get_*() and udma_get_*() considers this as already allocated
>> (PASS) since the error values are NON NULL. This results in
>> NULL pointer dereference error while de-referencing
>> bchan/rchan/tchan/rflow.
>>
>> Reset the value of bchan/rchan/tchan/rflow to NULL if the allocation
>> actually fails.
>>
>> Fixes: 017794739702 ("dmaengine: ti: k3-udma: Initial support for K3 BCDMA")
>> Fixes: 25dcb5dd7b7c ("dmaengine: ti: New driver for K3 UDMA")
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> Is this the same patch as the other with the similar subject?

Right, sorry for the duplicate patch (thought it didn't go out initially).

Regards
Kishon
