Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377C02D2A14
	for <lists+dmaengine@lfdr.de>; Tue,  8 Dec 2020 12:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgLHL5T (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Dec 2020 06:57:19 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55802 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgLHL5T (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Dec 2020 06:57:19 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0B8BtcB1054200;
        Tue, 8 Dec 2020 05:55:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607428538;
        bh=JmO/iWLGv+Hj8NN2W5fGoHVbiV83OKtPwcdpXebyXiI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=CBsH5IybWm+TvT3rP8jTUNOK2mbp+nWKOM0OR9qybs2lOVXcJWJStcl2MgJn2vQVK
         NsKlNLHH+yZXiFGVqH2u1eEvAKJTWW8sIWR8/X0nDgjcn8cnPmLeCVde0233q0OSB6
         E/wl5hAgYjBP+GCA7Wy05DT+5/yTKetBuddtSqEs=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0B8BtcgZ121670
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Dec 2020 05:55:38 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 8 Dec
 2020 05:55:38 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 8 Dec 2020 05:55:38 -0600
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0B8BtXE0039872;
        Tue, 8 Dec 2020 05:55:35 -0600
Subject: Re: [PATCH v3 13/20] dmaengine: ti: k3-psil: Extend
 psil_endpoint_config for K3 PKTDMA
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <vkoul@kernel.org>,
        <nm@ti.com>, <ssantosh@kernel.org>, <robh+dt@kernel.org>
CC:     <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <vigneshr@ti.com>
References: <20201208090440.31792-1-peter.ujfalusi@ti.com>
 <20201208090440.31792-14-peter.ujfalusi@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <ce3f82c4-e4b3-b162-d7f6-8b6781a381a6@ti.com>
Date:   Tue, 8 Dec 2020 13:55:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201208090440.31792-14-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 08/12/2020 11:04, Peter Ujfalusi wrote:
> Additional fields needed for K3 PKTDMA to be able to handle the mapped
> channels (channels are locked to handle specific threads) and flow ranges
> for these mapped threads.
> PKTDMA also introduces tflow for tx channels which can not be found in
> K3 UDMA architecture.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>   include/linux/dma/k3-psil.h | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
Best regards,
grygorii
