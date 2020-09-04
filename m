Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE6625D169
	for <lists+dmaengine@lfdr.de>; Fri,  4 Sep 2020 08:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbgIDG3f (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Sep 2020 02:29:35 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37166 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgIDG3e (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 4 Sep 2020 02:29:34 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0846TTwB124942;
        Fri, 4 Sep 2020 01:29:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599200969;
        bh=nSqNcWHQjbSwUvZrLc5Tni8ZU/Tm29cwM0u9RYIu/kg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=G4vy3bZShBoHOcnkWUCvUtGckrDw5XfDRtU+dTZklXgimA+jB5aU5gwbcQT/3IMJm
         GDzugfYYoCX6V5GdRwixZsgO2CwbOq7l1USjI9rbFjkJ+skEhaMEkzfwahzt8mHuT0
         73DQUCobZoGAqHcGRL9dJ4G8AkRt5tBdHujHF7OI=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0846TTlK098368
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Sep 2020 01:29:29 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 4 Sep
 2020 01:29:28 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 4 Sep 2020 01:29:28 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0846TPMf083114;
        Fri, 4 Sep 2020 01:29:26 -0500
Subject: Re: [PATCH v5 1/2] dt-bindings: dma: Add bindings for intel LGM SOC
To:     "Reddy, MallikarjunaX" <mallikarjunax.reddy@linux.intel.com>,
        Rob Herring <robh@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <vkoul@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andriy.shevchenko@intel.com>, <cheol.yong.kim@intel.com>,
        <qi-ming.wu@intel.com>, <chuanhua.lei@linux.intel.com>,
        <malliamireddy009@gmail.com>
References: <cover.1597381889.git.mallikarjunax.reddy@linux.intel.com>
 <68c77fd2ffb477aa4a52a58f8a26bfb191d3c5d1.1597381889.git.mallikarjunax.reddy@linux.intel.com>
 <20200814203222.GA2674896@bogus>
 <7cdc0587-8b4f-4360-a303-1541c9ad57b2@linux.intel.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <354cc7a4-de2f-1ed4-882d-3a285f565a26@ti.com>
Date:   Fri, 4 Sep 2020 09:31:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <7cdc0587-8b4f-4360-a303-1541c9ad57b2@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 18/08/2020 10.00, Reddy, MallikarjunaX wrote:
> Hi Rob,
> Thanks for your valuable comments. Please see my comments inline..
>=20
> On 8/15/2020 4:32 AM, Rob Herring wrote:
>> On Fri, Aug 14, 2020 at 01:26:09PM +0800, Amireddy Mallikarjuna reddy
>> wrote:
>>> Add DT bindings YAML schema for DMA controller driver
>>> of Lightning Mountain(LGM) SoC.
>>>
>>> Signed-off-by: Amireddy Mallikarjuna reddy
>>> <mallikarjunax.reddy@linux.intel.com>
>>> ---
>>> v1:
>>> - Initial version.
>>>
>>> v2:
>>> - Fix bot errors.
>>>
>>> v3:
>>> - No change.
>>>
>>> v4:
>>> - Address Thomas langer comments
>>> =C2=A0=C2=A0 - use node name pattern as dma-controller as in common b=
inding.
>>> =C2=A0=C2=A0 - Remove "_" (underscore) in instance name.
>>> =C2=A0=C2=A0 - Remove "port-" and "chan-" in attribute name for both
>>> 'dma-ports' & 'dma-channels' child nodes.
>>>
>>> v5:
>>> - Moved some of the attributes in 'dma-ports' & 'dma-channels' child
>>> nodes to dma client/consumer side as cells in 'dmas' properties.
>>> ---
>>> =C2=A0 .../devicetree/bindings/dma/intel,ldma.yaml=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 319
>>> +++++++++++++++++++++
>>> =C2=A0 1 file changed, 319 insertions(+)
>>> =C2=A0 create mode 100644
>>> Documentation/devicetree/bindings/dma/intel,ldma.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/dma/intel,ldma.yaml
>>> b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
>>> new file mode 100644
>>> index 000000000000..9beaf191a6de
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
>>> @@ -0,0 +1,319 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/dma/intel,ldma.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Lightning Mountain centralized low speed DMA and high speed
>>> DMA controllers.
>>> +
>>> +maintainers:
>>> +=C2=A0 - chuanhua.lei@intel.com
>>> +=C2=A0 - mallikarjunax.reddy@intel.com
>>> +
>>> +allOf:
>>> +=C2=A0 - $ref: "dma-controller.yaml#"
>>> +
>>> +properties:
>>> + $nodename:
>>> +=C2=A0=C2=A0 pattern: "^dma-controller(@.*)?$"
>>> +
>>> + "#dma-cells":
>>> +=C2=A0=C2=A0 const: 1
>> Example says 3.
> OK, i will fix it.

It would help if you would add description of what is the meaning of the
individual cell.

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

