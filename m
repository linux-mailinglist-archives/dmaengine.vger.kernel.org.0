Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933E5223B87
	for <lists+dmaengine@lfdr.de>; Fri, 17 Jul 2020 14:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgGQMlp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Jul 2020 08:41:45 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53994 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgGQMlp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Jul 2020 08:41:45 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06HCfcjF100377;
        Fri, 17 Jul 2020 07:41:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594989699;
        bh=vj22npkLr4ycyFgGKzlLVt7vMVT8zWr/amI8H6iFZQI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=NogMo+o2HUFESCsoW02P3oYMBGyiHhXx6KiFlXK35lo78CA6oTVTAgT3gtcK/GylT
         SNgoUt8ibP4N2ywHMwhnHKy5sIb0NU1vWM+xa18XnCNvHG+9IV+QRIZ+VRCkSMrvJX
         Wm4bi60O94NDgqc3oi35+yTTrXvdpS0tMqke2mA0=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06HCfcY1091351
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jul 2020 07:41:38 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 17
 Jul 2020 07:41:38 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 17 Jul 2020 07:41:38 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06HCfZup023969;
        Fri, 17 Jul 2020 07:41:36 -0500
Subject: Re: [PATCH next 6/6] dmaengine: ti: k3-udma: Switch to
 k3_ringacc_request_rings_pair
To:     Vinod Koul <vkoul@kernel.org>
CC:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <dmaengine@vger.kernel.org>
References: <20200701103030.29684-1-grygorii.strashko@ti.com>
 <20200701103030.29684-7-grygorii.strashko@ti.com>
 <20200702125705.GB273932@vkoul-mobl>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <43ea4163-e477-ba55-9da0-c438fd46833b@ti.com>
Date:   Fri, 17 Jul 2020 15:41:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200702125705.GB273932@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 02/07/2020 15:57, Vinod Koul wrote:
> On 01-07-20, 13:30, Grygorii Strashko wrote:
>> From: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>
>> We only request ring pairs via K3 DMA driver, switch to use the new
>> k3_ringacc_request_rings_pair() to simplify the code.
> 
> Acked-By: Vinod Koul <vkoul@kernel.org>
> 

There is build warn with this patch - sending v2.

-- 
Best regards,
grygorii
