Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2DB2D2A09
	for <lists+dmaengine@lfdr.de>; Tue,  8 Dec 2020 12:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgLHLyJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Dec 2020 06:54:09 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38862 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgLHLyI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Dec 2020 06:54:08 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0B8BqT4n055991;
        Tue, 8 Dec 2020 05:52:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607428349;
        bh=iv8zEB8GmkL1Ie8iD/aF0lFt3MMc4uENlhuM/JropiM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=tezWFPvrmjofJ/S2KYjmR/OowZJhp2+slBY0ZHb3lKhQbWQCCJjeXa1IMpLBqSGMH
         ZYBwGU9WbImuNwtrWrtnznTRG9byFpzBieI6yJQtt982tGGkRm2hwa+En73VL1a+HW
         repFqb7CqWZYNt+6efLAJGAqP1kIqz/19CxJR+60=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0B8BqTSn116810
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Dec 2020 05:52:29 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 8 Dec
 2020 05:52:28 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 8 Dec 2020 05:52:28 -0600
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0B8BqPb9090364;
        Tue, 8 Dec 2020 05:52:26 -0600
Subject: Re: [PATCH v3 05/20] dmaengine: ti: k3-udma-glue: Get the ringacc
 from udma_dev
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <vkoul@kernel.org>,
        <nm@ti.com>, <ssantosh@kernel.org>, <robh+dt@kernel.org>
CC:     <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <vigneshr@ti.com>
References: <20201208090440.31792-1-peter.ujfalusi@ti.com>
 <20201208090440.31792-6-peter.ujfalusi@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <f759177c-f060-30dd-a4a5-44781054b2d3@ti.com>
Date:   Tue, 8 Dec 2020 13:52:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201208090440.31792-6-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 08/12/2020 11:04, Peter Ujfalusi wrote:
> If of_xudma_dev_get() returns with the valid udma_dev then the driver
> already got the ringacc, there is no need to execute
> of_k3_ringacc_get_by_phandle() for each channel via the glue layer.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>   drivers/dma/ti/k3-udma-glue.c    | 6 +-----
>   drivers/dma/ti/k3-udma-private.c | 6 ++++++
>   drivers/dma/ti/k3-udma.h         | 1 +
>   3 files changed, 8 insertions(+), 5 deletions(-)
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
Best regards,
grygorii
