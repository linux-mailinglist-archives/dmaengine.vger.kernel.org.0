Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 498469FB98
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2019 09:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfH1HZK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Aug 2019 03:25:10 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:34204 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbfH1HZK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Aug 2019 03:25:10 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7S7OxBL128105;
        Wed, 28 Aug 2019 02:24:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1566977099;
        bh=pHyb5hhjOJ/59tZ3itIB2wCsNr0fqOVSdMsLMcMWCFg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=DprJg+7gYdCQZU3GT0E4RZqlgPotiqCwfk4/ZIrngU2ongYe4mokK686Rnj+8I0xr
         IGya1Edsw00RFX6LQeC+EFbZt4g4MhamBOOVxJkE/2gwtrOA0vU6Vf0F7CYkjqXP8Q
         PyfdZXK+wt2I6GRnyBmKO41um+l6u+dp49pldKhI=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7S7OxBR030983
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Aug 2019 02:24:59 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 28
 Aug 2019 02:24:58 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 28 Aug 2019 02:24:57 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7S7Oumq019424;
        Wed, 28 Aug 2019 02:24:56 -0500
Subject: Re: [PATCH] dt-bindings: dmaengine: dma-common: Revise the
 dma-channel-mask property
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        <vkoul@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1566974375-32482-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <eb823985-5cf6-0d83-8613-1baeeaf7d9c8@ti.com>
Date:   Wed, 28 Aug 2019 10:25:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1566974375-32482-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 28/08/2019 9.39, Yoshihiro Shimoda wrote:
> The commit b37e3534ac42 ("dt-bindings: dmaengine: Add YAML schemas
> for the generic DMA bindings") changed the property from
> dma-channel-mask to dma-channel-masks. So, this patch revises it.
> 
> Fixes: b37e3534ac42 ("dt-bindings: dmaengine: Add YAML schemas for the generic DMA bindings")
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  Documentation/devicetree/bindings/dma/dma-common.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/dma-common.yaml b/Documentation/devicetree/bindings/dma/dma-common.yaml
> index 0141af0..ed0a49a 100644
> --- a/Documentation/devicetree/bindings/dma/dma-common.yaml
> +++ b/Documentation/devicetree/bindings/dma/dma-common.yaml
> @@ -24,7 +24,7 @@ properties:
>      description:
>        Used to provide DMA controller specific information.
>  
> -  dma-channel-masks:
> +  dma-channel-mask:
>      $ref: /schemas/types.yaml#definitions/uint32

How this mask supposed to be used for controllers having more than 32
channels (64, 300+)?

>      description:
>        Bitmask of available DMA channels in ascending order that are
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
