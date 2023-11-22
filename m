Return-Path: <dmaengine+bounces-181-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9857F4DBD
	for <lists+dmaengine@lfdr.de>; Wed, 22 Nov 2023 18:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5EEE2811B3
	for <lists+dmaengine@lfdr.de>; Wed, 22 Nov 2023 17:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AB25102F;
	Wed, 22 Nov 2023 17:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HsqmTlLj"
X-Original-To: dmaengine@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF9E11F;
	Wed, 22 Nov 2023 09:04:53 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AMH4ZQL112193;
	Wed, 22 Nov 2023 11:04:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1700672675;
	bh=Aux+7eojx+Fb63WPK91qxLrk6ZvM6nCAXtH2OgSbbbA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=HsqmTlLjG9kom2HsRRQitcKY5oYlPJ1VUIycsyhPLYk9r5RcmKDCzasFmRlaNMVeL
	 uAx70YOtoSZKwfes4SYuZx/2+LPfaaORvMBK8yPo25f4pqX8YkAVZpi5v499BPImnd
	 ASP2xulKogf3wVHZb6H85w33L1OVcJHQdBGqzouM=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AMH4ZPF006683
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 Nov 2023 11:04:35 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 Nov 2023 11:04:35 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 Nov 2023 11:04:35 -0600
Received: from [172.24.227.94] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
	by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AMH4Vqc124276;
	Wed, 22 Nov 2023 11:04:32 -0600
Message-ID: <522e57a5-20bb-48c4-ac55-15e92ad1a6e2@ti.com>
Date: Wed, 22 Nov 2023 22:34:31 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dt-bindings: dma: ti: k3-*: Add descriptions for
 register regions
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Peter Ujfalusi
	<peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20231122154238.815781-1-vigneshr@ti.com>
 <20231122154238.815781-2-vigneshr@ti.com>
 <ac4011c6-980f-483b-97e9-da0e1fd4ca61@linaro.org>
Content-Language: en-US
From: Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <ac4011c6-980f-483b-97e9-da0e1fd4ca61@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 22/11/23 21:49, Krzysztof Kozlowski wrote:
> On 22/11/2023 16:42, Vignesh Raghavendra wrote:
>> In preparation for introducing more register regions, add description
>> for existing register regions so that its easier to map reg-names to
>> that of SoC Documentations/TRMs.
>>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> ---
>>  .../devicetree/bindings/dma/ti/k3-bcdma.yaml  | 26 +++++++++++--------
>>  .../devicetree/bindings/dma/ti/k3-pktdma.yaml |  6 ++++-
>>  .../devicetree/bindings/dma/ti/k3-udma.yaml   |  5 +++-
>>  3 files changed, 24 insertions(+), 13 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
>> index 4ca300a42a99..b5444800b036 100644
>> --- a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
>> +++ b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
>> @@ -35,14 +35,6 @@ properties:
>>        - ti,am64-dmss-bcdma
>>        - ti,j721s2-dmss-bcdma-csi
>>  
>> -  reg:
>> -    minItems: 3
>> -    maxItems: 5
>> -
>> -  reg-names:
>> -    minItems: 3
>> -    maxItems: 5
> 
> Why do you remove properties from top-level? You shouldn't. We expect
> there to have widest constrains. This is not explained in commit msg and
> really not justified looking at further diff hunks.
> 

Sorry, I didn't realize having top-level constraints is a requirement
and thought individual compatibles enforcing that actual constraints is
sufficient. Will add these back in v3.

> Best regards,
> Krzysztof
> 

-- 
Regards
Vignesh

