Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD5046BD76
	for <lists+dmaengine@lfdr.de>; Tue,  7 Dec 2021 15:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhLGOZE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Dec 2021 09:25:04 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34560 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbhLGOZD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Dec 2021 09:25:03 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B7ELNvt059102;
        Tue, 7 Dec 2021 08:21:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638886883;
        bh=JRRivwci+2KkzJfJu25xcZadjbt3THPVJSVSPpmwgME=;
        h=Subject:CC:References:To:From:Date:In-Reply-To;
        b=RpXmyWda077iTCUlMX1AEJ00FpE+lkp224fgT7ur/+ZvI/RI4dc9pEQY9kEMFxZRM
         m92T0nhkrAAHJkntF8kk5YzrhpCrNsoCoRVBeRTsJI+xStdRJLVWShTR5v+3vkVYBp
         A0HcHbV50iKUluAemBplot/4KqghYWBNiBrvigpc=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B7ELN80095359
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Dec 2021 08:21:23 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 7
 Dec 2021 08:21:23 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 7 Dec 2021 08:21:23 -0600
Received: from [10.250.232.185] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B7ELKVH100953;
        Tue, 7 Dec 2021 08:21:21 -0600
Subject: Re: [PATCH 0/2] J721S2: Add initial support
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>
References: <20211119132315.15901-1-a-govindraju@ti.com>
To:     Vinod Koul <vkoul@kernel.org>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <6c8673fe-cad9-3a44-03ff-159e47e1963c@ti.com>
Date:   Tue, 7 Dec 2021 19:51:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211119132315.15901-1-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On 19/11/21 6:53 pm, Aswath Govindraju wrote:
> The following series of patches add support for J721S2 SoC.
> 
> Currently, the PSIL source and destination thread IDs for only a few of the
> IPs have been added. The remaning ones will be added as and when they are
> tested.
> 
> The following series of patches are dependent on,
> - http://lists.infradead.org/pipermail/linux-arm-kernel/2021-November/697574.html
> 

May I know if this patch series can be applied to next? This series is a
dependency for [1].

[1] -
https://lore.kernel.org/linux-arm-kernel/20211207080904.14324-3-a-govindraju@ti.com/T/

Thanks,
Aswath

> Aswath Govindraju (2):
>   dmaengine: ti: k3-udma: Add SoC dependent data for J721S2 SoC
>   drivers: dma: ti: k3-psil: Add support for J721S2
> 
>  drivers/dma/ti/Makefile         |   3 +-
>  drivers/dma/ti/k3-psil-j721s2.c | 167 ++++++++++++++++++++++++++++++++
>  drivers/dma/ti/k3-psil-priv.h   |   1 +
>  drivers/dma/ti/k3-psil.c        |   1 +
>  drivers/dma/ti/k3-udma.c        |   1 +
>  5 files changed, 172 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/dma/ti/k3-psil-j721s2.c
> 

