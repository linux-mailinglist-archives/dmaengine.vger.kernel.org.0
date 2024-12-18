Return-Path: <dmaengine+bounces-4022-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A54DE9F6805
	for <lists+dmaengine@lfdr.de>; Wed, 18 Dec 2024 15:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59DAF188DB0A
	for <lists+dmaengine@lfdr.de>; Wed, 18 Dec 2024 14:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150691B043A;
	Wed, 18 Dec 2024 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jo7f0pVH"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52EF156879;
	Wed, 18 Dec 2024 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734531053; cv=none; b=c4k6fPBGIiSsdm/7XltxjoEvJfngZZGZgSAgPdaqpdh4PU3QiaH8vBudgFVMM0qwuciY+MlnUM45QWpfGLVLwV60r7hR7CmjvCec4FFutlMKzQxpWQhd8XxzzSRxSVF8G3ueX3KEcY7HJYLzLuIUc62sCIN14xrboNhkBkyD8b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734531053; c=relaxed/simple;
	bh=qKAVYOF7PF6g+oLbSwxNBACzcgf251bODnOeoXU6yj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LtFLpFVwH930U1UxZJuL1dT2RcCDqZJoiUtX+OLbn+2CSoBR9mbu9OTJ6iLN4G626RVAJyrsgkbzfJcQlkRJCj2pHwzMFuovKBFdflmrGhRvOzgeqlGpOnsVF5PzdGvxYmaDm1TdEy1YK+8crpFknA3NNL5drm4fzd4q2aEg3X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jo7f0pVH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FAABC4CECD;
	Wed, 18 Dec 2024 14:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734531052;
	bh=qKAVYOF7PF6g+oLbSwxNBACzcgf251bODnOeoXU6yj0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jo7f0pVHRYyhj8DFdATGWzzy1MvpZRjwOKPi7tGA0ZtuOu/psc9UEacjbyUC2ZZtx
	 JFMUK1YBOchWHtZDdrKrByFgqUYeEHBn3jasopdtcSD+rwKUk574JiCddA1qfemvUP
	 pMb4w35EXLvCeZXVwctkuH/Yq3VRu3Z+hfv0SeAlvDRUXywqgsvOGkBLQjQkf8QC+U
	 dygl1EI7rY2p/Dxk0b66m4Ufc4fJdnAbTY+OJywJSdcSvnNDeNioUIue/9kK/2ymau
	 uYTue0nAaU9yMMkQeh69Qnc7hKmPO5jt7KgMyVyuRhK7vRU/WK1Am0ROkWbVXpxtCl
	 VXS4J67lRcCTg==
Message-ID: <c465729e-3d16-4f9f-b592-06c6be92a482@kernel.org>
Date: Wed, 18 Dec 2024 15:10:47 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] dmaengine: fsl-edma: wait until no hardware request
 is in progress
To: Larisa Ileana Grigore <larisa.grigore@oss.nxp.com>, Frank.Li@nxp.com
Cc: dmaengine@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, s32@nxp.com,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>
References: <20241216075819.2066772-1-larisa.grigore@oss.nxp.com>
 <20241216075819.2066772-8-larisa.grigore@oss.nxp.com>
 <d4afb25d-5993-4f80-9f80-0a548b6532cd@kernel.org>
 <d5badfcf-58d7-49d4-8a5a-d31de498f015@oss.nxp.com>
 <2e0e1fe3-af5e-4416-8b34-3fecb923b481@kernel.org>
 <458f8940-4451-4dbd-bd50-75a43e4248d3@oss.nxp.com>
 <60b8eef7-e946-4e86-9116-46fadbafb53d@kernel.org>
 <d96a7dfc-af73-4296-bc26-4f1ccae8f7d7@oss.nxp.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJgPO8PBQkUX63hAAoJEBuTQ307
 QWKbBn8P+QFxwl7pDsAKR1InemMAmuykCHl+XgC0LDqrsWhAH5TYeTVXGSyDsuZjHvj+FRP+
 gZaEIYSw2Yf0e91U9HXo3RYhEwSmxUQ4Fjhc9qAwGKVPQf6YuQ5yy6pzI8brcKmHHOGrB3tP
 /MODPt81M1zpograAC2WTDzkICfHKj8LpXp45PylD99J9q0Y+gb04CG5/wXs+1hJy/dz0tYy
 iua4nCuSRbxnSHKBS5vvjosWWjWQXsRKd+zzXp6kfRHHpzJkhRwF6ArXi4XnQ+REnoTfM5Fk
 VmVmSQ3yFKKePEzoIriT1b2sXO0g5QXOAvFqB65LZjXG9jGJoVG6ZJrUV1MVK8vamKoVbUEe
 0NlLl/tX96HLowHHoKhxEsbFzGzKiFLh7hyboTpy2whdonkDxpnv/H8wE9M3VW/fPgnL2nPe
 xaBLqyHxy9hA9JrZvxg3IQ61x7rtBWBUQPmEaK0azW+l3ysiNpBhISkZrsW3ZUdknWu87nh6
 eTB7mR7xBcVxnomxWwJI4B0wuMwCPdgbV6YDUKCuSgRMUEiVry10xd9KLypR9Vfyn1AhROrq
 AubRPVeJBf9zR5UW1trJNfwVt3XmbHX50HCcHdEdCKiT9O+FiEcahIaWh9lihvO0ci0TtVGZ
 MCEtaCE80Q3Ma9RdHYB3uVF930jwquplFLNF+IBCn5JRzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmA872oFCRRflLYACgkQG5NDfTtBYpvScw/9GrqBrVLuJoJ52qBBKUBDo4E+5fU1bjt0
 Gv0nh/hNJuecuRY6aemU6HOPNc2t8QHMSvwbSF+Vp9ZkOvrM36yUOufctoqON+wXrliEY0J4
 ksR89ZILRRAold9Mh0YDqEJc1HmuxYLJ7lnbLYH1oui8bLbMBM8S2Uo9RKqV2GROLi44enVt
 vdrDvo+CxKj2K+d4cleCNiz5qbTxPUW/cgkwG0lJc4I4sso7l4XMDKn95c7JtNsuzqKvhEVS
 oic5by3fbUnuI0cemeizF4QdtX2uQxrP7RwHFBd+YUia7zCcz0//rv6FZmAxWZGy5arNl6Vm
 lQqNo7/Poh8WWfRS+xegBxc6hBXahpyUKphAKYkah+m+I0QToCfnGKnPqyYIMDEHCS/RfqA5
 t8F+O56+oyLBAeWX7XcmyM6TGeVfb+OZVMJnZzK0s2VYAuI0Rl87FBFYgULdgqKV7R7WHzwD
 uZwJCLykjad45hsWcOGk3OcaAGQS6NDlfhM6O9aYNwGL6tGt/6BkRikNOs7VDEa4/HlbaSJo
 7FgndGw1kWmkeL6oQh7wBvYll2buKod4qYntmNKEicoHGU+x91Gcan8mCoqhJkbqrL7+nXG2
 5Q/GS5M9RFWS+nYyJh+c3OcfKqVcZQNANItt7+ULzdNJuhvTRRdC3g9hmCEuNSr+CLMdnRBY fv0=
In-Reply-To: <d96a7dfc-af73-4296-bc26-4f1ccae8f7d7@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18/12/2024 14:38, Larisa Ileana Grigore wrote:
> On 12/18/2024 3:32 PM, Krzysztof Kozlowski wrote:
>> On 18/12/2024 14:24, Larisa Ileana Grigore wrote:
>>>>>
>>>>> Thank you for you review Krzysztof! Indeed, this commit should be moved
>>>>> right after "dmaengine: fsl-edma: add eDMAv3 registers to edma_regs"
>>>>
>>>> I don't understand this. Are you saying you introduce bug in one patch
>>>> and fix in other? Why this cannot be separate patchset?
>>>
>>> The bug was introduced by 72f5801a4e2b7 ("dmaengine: fsl-edma: integrate
>>> v3 support"), commit which is already upstream.
>>>
>>> In the proposed fix, a channel is disabled after checking the HRS
>>> register which is a eDMAv3 specific register.
>>>
>>> In the upstream implementation, "struct edma_regs" is created based on
>>> the eDMAv2 register layout [1] which is different compared to the eDMAv3
>>> register layout.
>>> The "hrs" field, which is used to access the HRS register, was
>>> introduced in one of the patches from this set [2].
>>> So, this fix depends on two other commits:
>>> "dmaengine: fsl-edma: add eDMAv3 registers to edma_regs"  [2]
>>> "dmaengine: fsl-edma: move eDMAv2 related registers to a new structure
>>> ’edma2_regs’" [3]
>>
>> OK, this explains the problem. Your fix cannot depend on other patches.
> 
> Should I remove the "Fixes" tag in this case?
No, you should rather rework the patches so the fix is independent and
can be submitted separately.

Best regards,
Krzysztof

