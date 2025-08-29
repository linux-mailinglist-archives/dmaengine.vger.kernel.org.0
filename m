Return-Path: <dmaengine+bounces-6291-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B2CB3B9D1
	for <lists+dmaengine@lfdr.de>; Fri, 29 Aug 2025 13:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5966203FF5
	for <lists+dmaengine@lfdr.de>; Fri, 29 Aug 2025 11:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FCA270EBC;
	Fri, 29 Aug 2025 11:16:49 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3851D19922D;
	Fri, 29 Aug 2025 11:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756466209; cv=none; b=EebMUQEz1xQ5bJA57nlyoGGSLDwq+J4fs2FxuqqcBPv2KxQkxEDw74MVy0gL9Wi81z4jTwO8BsZC9wBWV1ol60u9ZqVoZn8yOJvCmbhWJFlDIPEInxsZ+aIwcny56jvZhCTfDoi4a1xq/IUnRkpm6BBYov9YiDmG0nr9gXvkqg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756466209; c=relaxed/simple;
	bh=3b46XT04ioIl/x52R9M8U5LjC3ghTv9+9Ho4gn7JYi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VM9AupPbmv2xg3zT59cm8S5vb8r2RAJxgRLHM51l3GIxcIi58HS8Fi6Ye86NrOrvsHtA7O5l7tuMOAR7e2AYuU05YyGh7R8XTD+s5fw4pb8qZvv2owAbxO4cF1X5A+CjFrGlfNrjq/Z5SMfzM566KNqSykuiZri00UcxbMvCJDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5990519F0;
	Fri, 29 Aug 2025 04:16:39 -0700 (PDT)
Received: from [10.57.2.173] (unknown [10.57.2.173])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AE383F738;
	Fri, 29 Aug 2025 04:16:45 -0700 (PDT)
Message-ID: <c178a775-5953-4b20-b37d-87a8559c8062@arm.com>
Date: Fri, 29 Aug 2025 12:16:43 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] dt-bindings: dma: dma350: Support ARM DMA-250
To: Krzysztof Kozlowski <krzk@kernel.org>, Jisheng Zhang
 <jszhang@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250823154009.25992-1-jszhang@kernel.org>
 <20250823154009.25992-14-jszhang@kernel.org>
 <0aea52e1-4bfa-43ca-a527-f3ae198118dc@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <0aea52e1-4bfa-43ca-a527-f3ae198118dc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-08-23 5:11 pm, Krzysztof Kozlowski wrote:
> On 23/08/2025 17:40, Jisheng Zhang wrote:
>> Compared with ARM DMA-350, DMA-250 is a simplified version, they share
>> many common parts, but they do have difference. The difference will be
>> handled in next driver patch, while let's add DMA-250 compatible string
>> to dt-binding now.
>>
>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>> ---
>>   Documentation/devicetree/bindings/dma/arm,dma-350.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/arm,dma-350.yaml b/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
>> index 94752516e51a..d49736b7de5e 100644
>> --- a/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
>> +++ b/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
>> @@ -15,6 +15,7 @@ allOf:
>>   properties:
>>     compatible:
>>       const: arm,dma-350
>> +    const: arm,dma-250
> 
> This obviously cannot work and was NEVER tested. Please test your code
> before you send it to mailing lists.

Also, DMA-250 should be 100% "compatible" with DMA-350 in the DT sense, 
since it shares the same register layout and general functionality, and 
the detailed features and even exact model are discoverable from ID 
registers (hence why the current driver explicitly checks for 
PRODUCTID_DMA350 as that's the only one it knows it definitely understands).

Thanks,
Robin.

