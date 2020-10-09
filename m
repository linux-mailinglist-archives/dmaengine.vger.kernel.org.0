Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1332885B2
	for <lists+dmaengine@lfdr.de>; Fri,  9 Oct 2020 11:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733000AbgJIJAM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Oct 2020 05:00:12 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36052 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732969AbgJIJAM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 9 Oct 2020 05:00:12 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 099909VX053162;
        Fri, 9 Oct 2020 04:00:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602234009;
        bh=atVNXqR8De4QltIjOct1Mc9+wmSGMbZbnMsOGmwFWco=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=SXna70VzLVA7qbO1Ne45HmLgYFNTDYNAzCVCRahGZsyD7vDW7EmA91jE378Eq0KA4
         DIgNCvEv1K1/dlAXsXtEOKkH/QzkhrIxKSFgdi7md/dxNanZOlz74MMqedE80X193A
         lrNKu2EoxTHcXwD+Xc8uA/lawKx+05kX46ZxpHwI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 099909A4051886
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Oct 2020 04:00:09 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 9 Oct
 2020 04:00:08 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 9 Oct 2020 04:00:08 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 099907jW100953;
        Fri, 9 Oct 2020 04:00:07 -0500
Subject: Re: [PATCH v4 3/3] dmaengine: qcom: Add GPI dma driver
To:     Vinod Koul <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20201008123151.764238-1-vkoul@kernel.org>
 <20201008123151.764238-4-vkoul@kernel.org>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <6d6b4bf8-5610-f1cb-8c9d-f4bb82c93bdb@ti.com>
Date:   Fri, 9 Oct 2020 12:00:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201008123151.764238-4-vkoul@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On 08/10/2020 15.31, Vinod Koul wrote:
> This controller provides DMAengine capabilities for a variety of peripheral
> buses such as I2C, UART, and SPI. By using GPI dmaengine driver, bus
> drivers can use a standardize interface that is protocol independent to
> transfer data between memory and peripheral.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/dma/qcom/Kconfig     |   12 +
>  drivers/dma/qcom/Makefile    |    1 +
>  drivers/dma/qcom/gpi.c       | 2303 ++++++++++++++++++++++++++++++++++
>  include/linux/qcom-gpi-dma.h |   83 ++

Would not be better to have the header under include/linux/dma/ ?

>  4 files changed, 2399 insertions(+)
>  create mode 100644 drivers/dma/qcom/gpi.c
>  create mode 100644 include/linux/qcom-gpi-dma.h

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
