Return-Path: <dmaengine+bounces-4348-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A9DA2D15F
	for <lists+dmaengine@lfdr.de>; Sat,  8 Feb 2025 00:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEBDD188F538
	for <lists+dmaengine@lfdr.de>; Fri,  7 Feb 2025 23:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226F21B6CEC;
	Fri,  7 Feb 2025 23:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvPoqqau"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D114D194091;
	Fri,  7 Feb 2025 23:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738970263; cv=none; b=e5QwQAyOd5bBw4V70OLNi0vcuII+BAmzryuOD/qdTl2e8WUOIflrAlXGhmCAbKzB825tNlyTZlVKqh0r/Q/vud4EFSiw9UOGOxXc+fmAi/tD969G8l2GzZ+O5HiDnYn8HQc1MKc0jPVq39Dc4rArsaxm6rfMzGRxUIRtkTWE4SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738970263; c=relaxed/simple;
	bh=uBu6t4ty0hQZKKSCZBRKb4E9WpdD1GpGMPNfBVQXDVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BKfghTE94I+QN6B0lBCgPsiW92/aEQ1umLsQqSLBGlSr80CdZ4yOMq2TOT7f/7KpJr62f2zQoXLJGHrQpXkJTxLvjNu+3BMGUcV1SbzofLtNcpaX+Mo4Y7kaJghdhhaMhQi3I024PuPfGTx2iI1BLl2XiIcafm6fG9HHGY2O+jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvPoqqau; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0028C4CEE2;
	Fri,  7 Feb 2025 23:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738970260;
	bh=uBu6t4ty0hQZKKSCZBRKb4E9WpdD1GpGMPNfBVQXDVg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nvPoqqaucbZ+Zi7dcFcDf19MmSlaU676cQ27+TNgNPph5SnE0OcWAbUo6mtU6XA70
	 CRj64dcDZGAl20MNFWj5ElGlRslwwc5/82rTjSJ/eeDkPagVEXOvKsD37lz5OmauQ/
	 BljW5xyk6RVr97YBC4nN3jG9BDk7HPMnGeR5w/afedLrOmISQIhvJXZa2NMYrUgnwM
	 +ems6aj8tw36WCnlJU03Wieogvtqo9kWaQrsmW8KgpgFP0XAmUNUufDSjHc1B4z7ZF
	 HP5wB6OAf2XEnk0gkYoiiGTKTKW1VOfe52a2OyomRnFgIxjFCNSp7ViFtzhQ4/rN4C
	 MKlSVzR3S6BAg==
Message-ID: <8de72c76-6fea-4f8a-b818-72c8de07a78c@kernel.org>
Date: Sat, 8 Feb 2025 08:17:34 +0900
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] dt-bindings: ata: Convert fsl,pq-sata to YAML
To: j.ne@posteo.net, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Krzysztof Kozlowski <krzk@kernel.org>
Cc: imx@lists.linux.dev, Scott Wood <oss@buserror.net>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Lee Jones <lee@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?J=2E_Neusch=C3=A4fer?=
 <j.neuschaefer@gmx.net>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Mark Brown <broonie@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20250207-ppcyaml-v2-0-8137b0c42526@posteo.net>
 <20250207-ppcyaml-v2-2-8137b0c42526@posteo.net>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250207-ppcyaml-v2-2-8137b0c42526@posteo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/8/25 06:30, J. Neuschäfer via B4 Relay wrote:
> From: "J. Neuschäfer" <j.ne@posteo.net>
> 
> Convert the Freescale PowerQUICC SATA controller binding from text form
> to YAML. The list of compatible strings reflects current usage.
> 
> To clarify the description, I changed it to mention "each SATA
> controller" instead of each port.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>

Acked-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

