Return-Path: <dmaengine+bounces-6771-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F962BBFE67
	for <lists+dmaengine@lfdr.de>; Tue, 07 Oct 2025 03:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 347293AC50E
	for <lists+dmaengine@lfdr.de>; Tue,  7 Oct 2025 01:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD5B1DFD96;
	Tue,  7 Oct 2025 01:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHtQ0YFC"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339FA2B9BA;
	Tue,  7 Oct 2025 01:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759799272; cv=none; b=WdDq8vPyFDYzP5ffdGMJ/65m+stT5yr556rAM9pc3j9msmbQzQ8sITTStipRcTGPyV9Vc+sZAMCBuUSlhCuTDD8Z8Llzg7Qn5jyfTH+mRWh9LpNJXrKZmSoSRsI53UfUQPECSg01XJs+aWgPOQtRbJ5reQhdIeoqVYUnwmkFX0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759799272; c=relaxed/simple;
	bh=nK6IsY8XXOXC3iEsNBKq4APCgI7iwBgaZHbbITUoa78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u1jbPqM0ITfKjH2WfVtCxXhDnDiigrhFVjcdiTCnch7GEXHG8faqI8l5KbMnZgeeTCO+OeGMSpGi6Yx+0U2rZ0EjnfMYyI959aM7tIRV1IRpU6kDMcrKCuAXzoCIF6fVY8BvdyPx1G39BZbUxR5VR/fWvISSHphqOWnCo5ZLZyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHtQ0YFC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B8EC4CEF5;
	Tue,  7 Oct 2025 01:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759799271;
	bh=nK6IsY8XXOXC3iEsNBKq4APCgI7iwBgaZHbbITUoa78=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gHtQ0YFCKBy1lf45EZWeJND8yeZrZBT7/7HNX2VpubpKWLuYidChVNlQy5SaMx8gt
	 S6FPOb5yOqT0M1x0WJWiugPGWpVY7daM2YTvUp+edMThQIhMXqDl2erHhUkBd3gI9M
	 GsSZywDM7qIq5Yz+5NapAO5ztQEVs6blHq7SlIW9qxk3Ef90x+YLiCVRhz5Co5aHk/
	 AQFSKi1d9rFglmGmsozt5KJIksAEXHCYwWCi6Xf7Ilf07l5GifaKKrh2Vu9dOT8BcJ
	 SRmRtsihag8qNibq0xZHDVaF32MeNC8x3pZS8UJSgKywkxwSmtMhG5ltlhtcBXZSeO
	 2m27pKypuPTCA==
Message-ID: <164411f7-7925-491c-a24f-30021cab3f99@kernel.org>
Date: Tue, 7 Oct 2025 10:07:40 +0900
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/4] Add tegra264 audio device tree support
To: "Sheetal ." <sheetal@nvidia.com>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Sameer Pujar <spujar@nvidia.com>,
 linux-sound@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jonathan Hunter
 <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>, Marc Zyngier <maz@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>
References: <20250929105930.1767294-1-sheetal@nvidia.com>
 <175915953199.54406.1457670691076635405.robh@kernel.org>
 <4cc27ab8-4e59-45b9-9383-183f78da47a6@nvidia.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <4cc27ab8-4e59-45b9-9383-183f78da47a6@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/09/2025 15:24, Sheetal . wrote:
> 
> 
> On 29-09-2025 20:58, Rob Herring (Arm) wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On Mon, 29 Sep 2025 16:29:26 +0530, Sheetal . wrote:
>>> From: sheetal <sheetal@nvidia.com>
>>>
>>> Add device tree support for tegra264 audio subsystem including:
>>> - Binding update for
>>>    - 64-channel ADMA controller
>>>    - 32 RX/TX ADMAIF channels
>>>    - tegra264-agic binding for arm,gic
>>> - Add device tree nodes for
>>>    - APE subsystem (ACONNECT, AGIC, ADMA, AHUB and children (ADMAIF, I2S,
>>>      DMIC, DSPK, MVC, SFC, ASRC, AMX, ADX, OPE and Mixer) nodes
>>>    - HDA controller
>>>    - sound
>>>
>>> Note:
>>>   The change is dependent on https://patchwork.ozlabs.org/project/linux-tegra/patch/20250818135241.3407180-1-thierry.reding@gmail.com/
>>>
>>> ...
>>> Changes in V2:
>>>   - Update the allOf condition in Patch 2/4.
>>>
>>> sheetal (4):
>>>    dt-bindings: dma: Update ADMA bindings for tegra264
>>>    dt-bindings: sound: Update ADMAIF bindings for tegra264
>>>    dt-bindings: interrupt-controller: arm,gic: Add tegra264-agic
>>>    arm64: tegra: Add tegra264 audio support
>>>
>>>   .../bindings/dma/nvidia,tegra210-adma.yaml    |   15 +-
>>>   .../interrupt-controller/arm,gic.yaml         |    1 +
>>>   .../sound/nvidia,tegra210-admaif.yaml         |  106 +-
>>>   .../arm64/boot/dts/nvidia/tegra264-p3971.dtsi |  106 +
>>>   arch/arm64/boot/dts/nvidia/tegra264.dtsi      | 3190 +++++++++++++++++
>>>   5 files changed, 3377 insertions(+), 41 deletions(-)
>>>
>>> --
>>> 2.34.1
>>>
>>>
>>>
>>
>>
>> My bot found new DTB warnings on the .dts files added or changed in this
>> series.
>>
>> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
>> are fixed by another series. Ultimately, it is up to the platform
>> maintainer whether these warnings are acceptable or not. No need to reply
>> unless the platform maintainer has comments.
>>
>> If you already ran DT checks and didn't see these error(s), then
>> make sure dt-schema is up to date:
>>
>>    pip3 install dtschema --upgrade
>>
>>
>> This patch series was applied (using b4) to base:
>>   Base: attempting to guess base-commit...
>>   Base: tags/v6.17-rc1-57-g635ae6f0a3ad (exact match)
>>
>> If this is not the correct base, please add 'base-commit' tag
>> (or use b4 which does this automatically)
>>
>> New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/nvidia/' for 20250929105930.1767294-1-sheetal@nvidia.com:
>>
>> In file included from arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi:3,
>>                   from arch/arm64/boot/dts/nvidia/tegra264-p3834-0008.dtsi:3,
>>                   from arch/arm64/boot/dts/nvidia/tegra264-p3971-0089+p3834-0008.dts:5:
>> arch/arm64/boot/dts/nvidia/tegra264.dtsi:8:10: fatal error: dt-bindings/power/nvidia,tegra264-powergate.h: No such file or directory
> 
> This error is expected.
> "dt-bindings/power/nvidia,tegra264-powergate.h" file is being added in 
> https://patchwork.ozlabs.org/project/linux-tegra/patch/20250818135241.3407180-1-thierry.reding@gmail.com/, 
> in the cover letter it is mentioned as dependent of that change in the 
> 'Note'.
> 
If you expect your patch not to be ignored after such feedback, explain
briefly missing dependency in the patch changelog. Not cover letter.

You will get this report every time and maintainers might ignore your
patch, due to unresolved reports from automation.

Best regards,
Krzysztof

