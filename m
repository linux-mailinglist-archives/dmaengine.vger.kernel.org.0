Return-Path: <dmaengine+bounces-2137-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADF38CC038
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2024 13:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EBC728255E
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2024 11:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACB0824BF;
	Wed, 22 May 2024 11:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkReHIBR"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2681B824AF;
	Wed, 22 May 2024 11:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716377375; cv=none; b=N0fNZhPXCEHnFglSUFc0rRD+u24tOpvAGwL6D6HJYfIfqD+NnEZKZrc45RU76HUaRjtl2pGRtDH/yZriAoaQrhwijDZgwWanAmVYnhuyrH7v6/yRxEjJpDIX4u2A9eL4Kv0hEi9Qjqd2yPgD8evRyrelEq32FlF2VBIoDNRw0R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716377375; c=relaxed/simple;
	bh=v9sTb1YPD0eyXpGV9zrS8qJaIGoTzfld+AFYcRslwoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IwcQNaO0GZovIW+J+WfWM/9dH654BNvb8AFEa+jmH9R6nG60/1g6Uf4+sg84wcanb/ZQrSFFmdSxTIOPcEMhyoUk6f2MuRlSsyJPgjmpoD2/ZlKs29+W0RDMJucq5Gn6YMUQ8yXOpAXQKRZFbh+YQtI3uWJOwC6xA599CnuuiOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkReHIBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22119C2BD11;
	Wed, 22 May 2024 11:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716377374;
	bh=v9sTb1YPD0eyXpGV9zrS8qJaIGoTzfld+AFYcRslwoU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mkReHIBRSYEtmd3hIYMzBO5Heb3KH5Qr+Im/mlh9DIJsrSLTykHd7qfQE/JHSBDm1
	 3wVerYYyHetfJdDZ0/YoJk5RPVzKaBTslonF+3clPkr+uQnX5hK622yBzUhvFOmqdz
	 hL0WOk99Gzp722x6k7n41/QiexaYr10Zcw5ngeobOuvZXl/yszGgPXaAErOcpbMKpe
	 6PacgvOkhZzeJbf04HbJfsLFj/7L0Py+ifxhU4rWk9Df+VRCyw2uLRNGyfMe2/JNV6
	 A7xCOwhoszGy48oMvhKJX6oRnHGe2PSdYw5A5/BGbEoRbYJMsqw9UTwbKfuynsPqOi
	 1iMkwHxx97KnQ==
Message-ID: <774df64c-56a1-461a-82fa-a0340732b779@kernel.org>
Date: Wed, 22 May 2024 13:29:30 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 1/2] dt-bindings: dma: Add reg-names to
 nvidia,tegra210-adma
To: Sameer Pujar <spujar@nvidia.com>, vkoul@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, thierry.reding@gmail.com,
 jonathanh@nvidia.com, dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 ldewangan@nvidia.com, mkumard@nvidia.com
References: <20240521110801.1692582-1-spujar@nvidia.com>
 <20240521110801.1692582-2-spujar@nvidia.com>
 <80b6e6e6-9805-4a85-97d5-38e1b2bf2dd0@kernel.org>
 <e6fab314-8d1e-4ed7-bb5a-025fd65e1494@nvidia.com>
 <56bf93ac-6c1e-48aa-89d0-7542ea707848@kernel.org>
 <f785f699-be50-4547-9411-d41a4e66a225@nvidia.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <f785f699-be50-4547-9411-d41a4e66a225@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/05/2024 09:43, Sameer Pujar wrote:
> 
> 
> On 22-05-2024 12:17, Krzysztof Kozlowski wrote:
>> On 22/05/2024 07:35, Sameer Pujar wrote:
>>> On 21-05-2024 17:23, Krzysztof Kozlowski wrote:
>>>> On 21/05/2024 13:08, Sameer Pujar wrote:
>>>>> From: Mohan Kumar <mkumard@nvidia.com>
>>>>>
>>>>> For Non-Hypervisor mode, Tegra ADMA driver requires the register
>>>>> resource range to include both global and channel page in the reg
>>>>> entry. For Hypervisor more, Tegra ADMA driver requires only the
>>>>> channel page and global page range is not allowed for access.
>>>>>
>>>>> Add reg-names DT binding for Hypervisor mode to help driver to
>>>>> differentiate the config between Hypervisor and Non-Hypervisor
>>>>> mode of execution.
>>>>>
>>>>> Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
>>>>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>>>>> ---
>>>>>    .../devicetree/bindings/dma/nvidia,tegra210-adma.yaml  | 10 ++++++++++
>>>>>    1 file changed, 10 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
>>>>> index 877147e95ecc..ede47f4a3eec 100644
>>>>> --- a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
>>>>> +++ b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
>>>>> @@ -29,8 +29,18 @@ properties:
>>>>>              - const: nvidia,tegra186-adma
>>>>>
>>>>>      reg:
>>>>> +    description: |
>>>>> +      For hypervisor mode, the address range should include a
>>>>> +      ADMA channel page address range, for non-hypervisor mode
>>>>> +      it starts with ADMA base address covering Global and Channel
>>>>> +      page address range.
>>>>>        maxItems: 1
>>>>>
>>>>> +  reg-names:
>>>>> +    description: only required for Hypervisor mode.
>>>> This does not work like that. I provide vm entry for non-hypervisor mode
>>>> and what? You claim it is virtualized?
>>>>
>>>> Drop property.
>>> With 'vm' entry added for hypervisor mode, the 'reg' address range needs
>>> to be updated to use channel specific region only. This is used to
>>> inform driver to skip global regions which is taken care by hypervisor.
>>> This is expected to be used in the scenario where Linux acts as a
>>> virtual machine (VM). May be the hypervisor mode gives a different
>>> impression here? Sorry, I did not understand what dropping the property
>>> exactly means here.
>> It was imperative. Drop it. Remove it. I provided explanation why.
> 
> The driver doesn't know if it is operated in a native config or in the 
> hypervisor config based on the 'reg' address range alone. So 'vm' entry 
> with restricted 'reg' range is used to differentiate here for the 
> hypervisor config. Just adding 'vm' entry won't be enough, the 'reg' 
> region must be updated as well to have expected behavior. Not sure how 
> this dependency can be enforced in the schema.

That's not a unusual problem, so please come with a solution for your
entire subarch. We've been discussing similar topic in terms of SCMI
controlled resources (see talk on Linaro Connect a week ago:
https://www.kitefor.events/events/linaro-connect-24/submissions/161 I
don't know where is recording or slides, see also discussions on mailing
lists about it), which is not that far away from the problem here. Other
platforms and maybe nvidia had as well changes in IO space for
virtualized configuration.

Come with unified approach FOR ALL your devices, not only this one
(that's kind of basic thing we keep repeating... don't solve only one
your problem), do not abuse the regular property, because as I said:
reg-names will be provided as well in non-vm case and then your entire
logic is wrong. The purpose of reg-names is not to tell whether you have
or have not virtualized environment.


Best regards,
Krzysztof


