Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45DB778694
	for <lists+dmaengine@lfdr.de>; Fri, 11 Aug 2023 06:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjHKEin (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Aug 2023 00:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjHKEim (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Aug 2023 00:38:42 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423F8271B;
        Thu, 10 Aug 2023 21:38:42 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37B4cKS3123986;
        Thu, 10 Aug 2023 23:38:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691728701;
        bh=QQm0EQ6zFCgMMob+YHHeBHIl+YEMa/25PBKmi4nAeDk=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=hu3dMsbXcXPtC6CNQtTWv9ym/Xpm5Imh4r55PpJRd4qLr9AJkdPXUU/NnySMzsZtu
         Kf6IdNrErgwYuMYw0u2L1yVnzXO8jPAQe6a8KF5yFyVdBDm6KyFjSlE9tjM5R/0GMc
         YvwiFErbTCvWw90Hwffngw7UZ1NtVIuYlqoZ2bbs=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37B4cKK2075718
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Aug 2023 23:38:20 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Aug 2023 23:38:20 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Aug 2023 23:38:20 -0500
Received: from [172.24.227.94] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37B4cHjr091629;
        Thu, 10 Aug 2023 23:38:18 -0500
Message-ID: <20f77050-dc12-5240-0105-f27c97e5ed0a@ti.com>
Date:   Fri, 11 Aug 2023 10:08:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] dt-bindings: dma: ti: k3-bcdma: Describe cfg register
 regions
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
CC:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230810174356.3322583-1-vigneshr@ti.com>
 <20230810174356.3322583-2-vigneshr@ti.com>
 <20230810-prelaw-payback-9388222dd6d3@spud>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20230810-prelaw-payback-9388222dd6d3@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 11/08/23 00:05, Conor Dooley wrote:
> On Thu, Aug 10, 2023 at 11:13:53PM +0530, Vignesh Raghavendra wrote:
>> Block copy DMA(BCDMA)module on K3 SoCs have ring cfg, TX and RX
>> channel cfg register regions which are usually configured by a Device
>> Management firmware. But certain entities such as bootloader (like
>> U-Boot) may have to access them directly. Describe this region in the
>> binding documentation for completeness of module description.
>>
>> Keep the binding compatible with existing DTS files by requiring first
>> five regions to be present at least.
>>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> ---
>>  .../devicetree/bindings/dma/ti/k3-bcdma.yaml  | 25 +++++++++++++------
>>  1 file changed, 17 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
>> index 4ca300a42a99..d166e284532b 100644
>> --- a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
>> +++ b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
>> @@ -37,11 +37,11 @@ properties:
>>  
>>    reg:
>>      minItems: 3
>> -    maxItems: 5
>> +    maxItems: 8
> 
> How come none of these reg entries have a description? What
> differentiates a "gcfg" from a "cfg" for example?
> 

Ok, I will a patch to describe the regions first before adding new ones.

>>  
>>    reg-names:
>>      minItems: 3
>> -    maxItems: 5
>> +    maxItems: 8
>>  
>>    "#dma-cells":
>>      const: 3
>> @@ -161,14 +161,19 @@ allOf:
>>        properties:
>>          reg:
>>            minItems: 5
>> +          maxItems: 8
>>  
>>          reg-names:
>> +          minItems: 5
>>            items:
>>              - const: gcfg
>>              - const: bchanrt
>>              - const: rchanrt
>>              - const: tchanrt
>>              - const: ringrt
>> +            - const: cfg
>> +            - const: tchan
>> +            - const: rchan
>>  
>>        required:
>>          - ti,sci-rm-range-bchan
>> @@ -216,12 +221,16 @@ examples:
>>              main_bcdma: dma-controller@485c0100 {
>>                  compatible = "ti,am64-dmss-bcdma";
>>  
>> -                reg = <0x0 0x485c0100 0x0 0x100>,
>> -                      <0x0 0x4c000000 0x0 0x20000>,
>> -                      <0x0 0x4a820000 0x0 0x20000>,
>> -                      <0x0 0x4aa40000 0x0 0x20000>,
>> -                      <0x0 0x4bc00000 0x0 0x100000>;
>> -                reg-names = "gcfg", "bchanrt", "rchanrt", "tchanrt", "ringrt";
>> +                reg = <0x00 0x485c0100 0x00 0x100>,
> 
> Why have you added extra zeros? (0x00)

Sorry, copy paste error, was trying to copy example from real DT that
use 0x00. Will fix. Thanks!

> 
> Thanks,
> Conor.
> 
>> +                      <0x00 0x4c000000 0x00 0x20000>,
>> +                      <0x00 0x4a820000 0x00 0x20000>,
>> +                      <0x00 0x4aa40000 0x00 0x20000>,
>> +                      <0x00 0x4bc00000 0x00 0x100000>,
>> +                      <0x00 0x48600000 0x00 0x8000>,
>> +                      <0x00 0x484a4000 0x00 0x2000>,
>> +                      <0x00 0x484c2000 0x00 0x2000>;
>> +                reg-names = "gcfg", "bchanrt", "rchanrt", "tchanrt", "ringrt",
>> +                            "cfg", "tchan", "rchan";
>>                  msi-parent = <&inta_main_dmss>;
>>                  #dma-cells = <3>;
>>  
>> -- 
>> 2.41.0
>>

-- 
Regards
Vignesh
