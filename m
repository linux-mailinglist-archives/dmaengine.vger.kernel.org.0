Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170652D7F46
	for <lists+dmaengine@lfdr.de>; Fri, 11 Dec 2020 20:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgLKTSC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Dec 2020 14:18:02 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35682 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392722AbgLKTRd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Dec 2020 14:17:33 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BBJFjTH049246;
        Fri, 11 Dec 2020 13:15:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607714145;
        bh=VoPG7rc/Kd2EXL9UY66g2TL//ET0Aft2NFdPswHgQtw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Vld0pl3wEDxvaqCAJ+U+33X4GWHMc/htWDJAVZljyVOQ6dMw5VZ6Zrq5c6ObtXPPk
         0/GcwEqyH4p/GwSRKohHoMSJigRWmocMeJdW+cHNRDx17rGS0UDrFzw0UUchDYxvIM
         IVWjB4v0K6+PPbL6fLYyr0QUGWTJ69CnKtx/+5r0=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BBJFjeW122640
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Dec 2020 13:15:45 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 11
 Dec 2020 13:15:45 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 11 Dec 2020 13:15:45 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BBJFg6W089717;
        Fri, 11 Dec 2020 13:15:43 -0600
Subject: Re: [PATCH v3 00/20] dmaengine/soc: k3-udma: Add support for BCDMA
 and PKTDMA
To:     Vinod Koul <vkoul@kernel.org>
CC:     <nm@ti.com>, <ssantosh@kernel.org>, <robh+dt@kernel.org>,
        <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <vigneshr@ti.com>,
        <grygorii.strashko@ti.com>
References: <20201208090440.31792-1-peter.ujfalusi@ti.com>
 <20201211162400.GZ8403@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <8df78a7a-abc8-e0e3-6b60-a0832be74aa5@ti.com>
Date:   Fri, 11 Dec 2020 21:16:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201211162400.GZ8403@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On 11/12/2020 18.24, Vinod Koul wrote:
> On 08-12-20, 11:04, Peter Ujfalusi wrote:
>> Hi,
>>
>> The series have build dependency on ti_sci/soc series (v2):
>> https://lore.kernel.org/lkml/20201008115224.1591-1-peter.ujfalusi@ti.com/
>>
>> Santosh kindly provided immutable branch and tag holding the series:
>> git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/drivers_soc_for_5.11 
> 
> I have picked this and then merged this and pushed to test branch. If
> everything is okay, it will be next on monday

Thank you!

this might cause a sparse warning:
https://lore.kernel.org/lkml/a1f83b16-c1ce-630e-3410-738b80a92741@ti.com/

I can send an incremental patch or resend the whole series with this
correction?

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
