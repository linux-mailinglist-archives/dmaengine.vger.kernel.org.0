Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E6B2A8F9C
	for <lists+dmaengine@lfdr.de>; Fri,  6 Nov 2020 07:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgKFGon (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Nov 2020 01:44:43 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7720 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgKFGon (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 6 Nov 2020 01:44:43 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa4f0de0000>; Thu, 05 Nov 2020 22:44:46 -0800
Received: from [10.25.102.172] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov
 2020 06:44:37 +0000
Subject: Re: [PATCH 4/4] dt-bindings: bus: Convert ACONNECT doc to json-schema
To:     Rob Herring <robh@kernel.org>
CC:     <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <vkoul@kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <maz@kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
References: <1604571846-14037-1-git-send-email-spujar@nvidia.com>
 <1604571846-14037-5-git-send-email-spujar@nvidia.com>
 <20201105190508.GB1633758@bogus>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <8c8c7cc0-881f-5542-f23f-238e5d8608d3@nvidia.com>
Date:   Fri, 6 Nov 2020 12:14:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201105190508.GB1633758@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604645086; bh=CI65gxif5jEZW4MV9PdM5TeMKbiIlSvnLArX4Xc5ZqQ=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=ZqU+ReLfVjXqg0qIQuZuN8DIM7vlAVZwR4dnEt9OxJyqy43xkyDBi/94aN97BdfPi
         Ka3qWRhTq5bUPdo9FaKIFYyEvGmoeksKLuchPfopsLafuD6u6bi2ufaFZx4c9rgJRm
         bLTMcqFXgA0AUewb0VcCKUqWH0lNSZ5cHwqTWJ+llKQXYRYYdMYOPZl5Epp4Nz7PvH
         8FhqDCd13tqLLjl7xufxIsYBgr7DQ3ChWK/mwFyXvPpi2NCqO+VUzx2gw6sUfvgFuV
         UubOVO93aQfId03EX4Dv220zJol9c5SNlKAOex4YwaIKtHNPGQ3iwA+VkDaqH3BI6D
         D/ZM6K+RTDnJA==
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


>> Move ACONNECT documentation to YAML format.
>>
>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>> ---
>>   .../bindings/bus/nvidia,tegra210-aconnect.txt      | 44 -----------
>>   .../bindings/bus/nvidia,tegra210-aconnect.yaml     | 86 ++++++++++++++++++++++
>>   2 files changed, 86 insertions(+), 44 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/bus/nvidia,tegra210-aconnect.txt
>>   create mode 100644 Documentation/devicetree/bindings/bus/nvidia,tegra210-aconnect.yaml
>>

...

>> diff --git a/Documentation/devicetree/bindings/bus/nvidia,tegra210-aconnect.yaml b/Documentation/devicetree/bindings/bus/nvidia,tegra210-aconnect.yaml
>> new file mode 100644
>> index 0000000..f0161bc
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/bus/nvidia,tegra210-aconnect.yaml
>> @@ -0,0 +1,86 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/bus/nvidia,tegra210-aconnect.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: NVIDIA Tegra ACONNECT Bus
>> +
>> +description: |
>> +  The Tegra ACONNECT bus is an AXI switch which is used to connnect various
>> +  components inside the Audio Processing Engine (APE). All CPU accesses to
>> +  the APE subsystem go through the ACONNECT via an APB to AXI wrapper. All
>> +  devices accessed via the ACONNNECT are described by child-nodes.
>> +

...

>> +
>> +patternProperties:
>> +  "^dma-controller(@[0-9a-f]+)?$":
>> +    $ref: /schemas/dma/nvidia,tegra210-adma.yaml#
>> +  "^interrupt-controller(@[0-9a-f]+)?$":
>> +    $ref: /schemas/interrupt-controller/arm,gic.yaml#
>> +  "^ahub(@[0-9a-f]+)?$":
>> +    $ref: /schemas/sound/nvidia,tegra210-ahub.yaml#
> These all get applied already since they match on compatible strings. So
> having them here means the schema is applied twice. There's maybe some
> value to this if it's always going to be these 3 nodes.

1) May be this could be dropped with "additionalProperties = true", but 
that allows any arbitary property to be added for the device. Without 
this 'make dtbs_check' complains about not matching properties in DT files.

2) These may not be the final list of nodes this device can have. In 
future if any new device support gets added under this, above needs to 
be updated. But it will be limited number of devices.

So is [2] fine or you would suggest [1] would be good enough?

>
> Also, the unit-addresses shouldn't be optional.
>
> I'd just do:
>
> "@[0-9a-f]+$":
>    type: object
>
>> +
>> +required:
>> +  - compatible
>> +  - clocks
>> +  - clock-names
>> +  - power-domains
>> +  - "#address-cells"
>> +  - "#size-cells"
>> +  - ranges
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include<dt-bindings/clock/tegra210-car.h>
>> +
>> +    aconnect@702c0000 {
>> +        compatible = "nvidia,tegra210-aconnect";
>> +        clocks = <&tegra_car TEGRA210_CLK_APE>,
>> +                 <&tegra_car TEGRA210_CLK_APB2APE>;
>> +        clock-names = "ape", "apb2ape";
>> +        power-domains = <&pd_audio>;
>> +
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +        ranges = <0x702c0000 0x702c0000 0x00040000>;
>> +
>> +        // Child device nodes follow ...
>> +    };
>> +
>> +...
>> --
>> 2.7.4
>>

