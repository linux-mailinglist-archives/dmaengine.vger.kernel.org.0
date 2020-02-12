Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54E2115AA10
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2020 14:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgBLNby (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Feb 2020 08:31:54 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60046 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbgBLNby (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Feb 2020 08:31:54 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01CDVoR4051083;
        Wed, 12 Feb 2020 07:31:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581514310;
        bh=J897UeGgDsfiByfaE1tdJb1BU8fjpD3Lxxq2FOTHk8M=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Z04WIp1vui/lE0J/BoP6J+sZ5BRmjeLbWqopsi21U3g8L40ZYww6vZMMOFVpyDdJp
         b//wCGuWk4k+pZOjAeiWbFPO9IEzKA4ndT+AjYXv1rJotIAaVjvx9TGqBgCfsguYdl
         2vbsii4L//+GWAF8xcJBub/ePkqemD0VNmx8Rs/E=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01CDVo9V104186
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Feb 2020 07:31:50 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 12
 Feb 2020 07:31:49 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 12 Feb 2020 07:31:49 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01CDVlA9002541;
        Wed, 12 Feb 2020 07:31:48 -0600
Subject: Re: [PATCH] dt-bindings: dma: ti-edma: fix example compatible
 property
To:     Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200212104840.20393-1-johan@kernel.org>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <5d7e8808-1def-695f-1b9f-e35953ace90f@ti.com>
Date:   Wed, 12 Feb 2020 15:31:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200212104840.20393-1-johan@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 12/02/2020 12.48, Johan Hovold wrote:
> Make sure that the compatible string in the edma1_tptc1 example node
> matches the binding by removing the space between the manufacturer and
> model.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  Documentation/devicetree/bindings/dma/ti-edma.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/ti-edma.txt b/Documentation/devicetree/bindings/dma/ti-edma.txt
> index 0e1398f93aa2..29fcd37082e8 100644
> --- a/Documentation/devicetree/bindings/dma/ti-edma.txt
> +++ b/Documentation/devicetree/bindings/dma/ti-edma.txt
> @@ -180,7 +180,7 @@ edma1_tptc0: tptc@27b0000 {
>  };
>  
>  edma1_tptc1: tptc@27b8000 {
> -	compatible = "ti, k2g-edma3-tptc", "ti,edma3-tptc";
> +	compatible = "ti,k2g-edma3-tptc", "ti,edma3-tptc";
>  	reg =	<0x027b8000 0x400>;
>  	power-domains = <&k2g_pds 0x4f>;
>  };
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
