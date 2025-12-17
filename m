Return-Path: <dmaengine+bounces-7740-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 500C8CC5E47
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 04:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8FC6F3010EF1
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 03:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EE52BE7B1;
	Wed, 17 Dec 2025 03:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmFt6DCp"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3212F28D82F;
	Wed, 17 Dec 2025 03:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765941732; cv=none; b=jVAGrQVQD3TaLoVsjJdKDeDSruXP+22S5v9B36xRJ8XHZA4ZZKYUPg3H3zlyOLpDXpOHvKZnDu88lcbqvPMXsgsWX9GHUJHYuWwbjQMo/UXHGNqIDetrZqZxnLhUEPHjA059UlOJzcw0lx1lDcXxxEEkCqpAil66f+Ne0cVzFjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765941732; c=relaxed/simple;
	bh=u5k6aFeluCnCcU6WlyD33Z3mf/SsHRJcNakxj8G8Kdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oTDBSGFd84sL0q3O6Ehxvv+RdQZ/Yi72VxfOG38S6+GBVrpDhS1uukQlCkvNhW4WSEYir2DWjJs93mB4TnrDjVlJUPwCKNBeFjJVkQfvhU/41nx5hxL16lWqV0DcaHcDXmKwwbGuYY1C3zO0TrnRwbc/18K/E33lT/yyBmTT3NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmFt6DCp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B192DC4CEF1;
	Wed, 17 Dec 2025 03:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765941731;
	bh=u5k6aFeluCnCcU6WlyD33Z3mf/SsHRJcNakxj8G8Kdo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KmFt6DCppcufCmXLZCYy1zpU0PfKyRVl4WvzV8Q59FDaaAkrolJhBqERIVfqhlLjL
	 HiYVpo9f9xVhQayfiWfgEZXpo58IAIcI2EMqGpg873P3oJGTfjtmKAUsxnluv5Hv8m
	 3kMTqIfzyr6oSIZpzMspNmpqXxIbxDY5+oX4/gshqulr+QD2RNKuXeQ07Teky9z+q4
	 QE15578lrO5ikyrCJR1/Tn8efLlQaEzBl1cz0Wgvrhl9rIhRj1XKSTHtOAB1+PMGCj
	 ITtVFwYpyE6bF/WCEUIRd5IxjvpxHYm9qfGDFMQloyXVsuOnZjfD4QKsBqJImX/D2F
	 P1UlYEFEWNTww==
Message-ID: <f1948d54-2e27-44ca-8509-ca16f9b792fd@kernel.org>
Date: Tue, 16 Dec 2025 21:22:09 -0600
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Add dma-coherent property
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul
 <vkoul@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <cover.1764717960.git.khairul.anuar.romli@altera.com>
 <e1aae851-4031-4b5c-a807-7a61ecfe6af1@kernel.org>
 <877bumsv3q.fsf@bootlin.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <877bumsv3q.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Miquel

On 12/16/25 02:12, Miquel Raynal wrote:
> 
>>> Khairul Anuar Romli (3):
>>>     dt-bindings: mtd: cdns,hp-nfc: Add dma-coherent property
>>>     dt-bindings: dma: snps,dw-axi-dmac: add dma-coherent property
>>>     arm64: dts: socfpga: agilex5: Add dma-coherent property
>>>    Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml | 2 ++
>>>    Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml      | 2 ++
>>>    arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi              | 3 +++
>>>    3 files changed, 7 insertions(+)
>>>
>>
>> Applied!
> 
> Have you applied all 3 patches? If yes, where? It happened during the
> merge window but I see nothing in v6.19-rc1. I was about to take the mtd
> binding patch, but if you took it already that's fine, I'll mark this
> series as already applied.
> 

Yes, I took all 3 and staging it in my tree for v6.20.

Thanks,
Dinh

