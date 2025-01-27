Return-Path: <dmaengine+bounces-4210-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 357D8A1D089
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jan 2025 05:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97D2A3A6E91
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jan 2025 04:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01301FC0E6;
	Mon, 27 Jan 2025 04:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lew5dHJX"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA791FC3;
	Mon, 27 Jan 2025 04:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737953483; cv=none; b=VDOjSvEfdpZH2F2jEsZQ1kYuu2p5+nWWLZtJ4/9JD0MKBfWuFx7Ct3Mg/AeSF+qhzFREbZ0L+wZXORftvvOmSZgaB6PUcjbv02RUzg+dajl04GMFKhWN5qjG0hLC/7qdsvEP4oj56diwBhmDf34ST9tsLdvDHx62WK8DWF0E09M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737953483; c=relaxed/simple;
	bh=MP5quvHBDN7k35e6RGGtxX0t8y8u7jhKsU/FGhI5zdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5XjC0sD3ZitlLr9QDqheqSfgDhcAQCaRHrmQIgwzofXjJ4CZPfjMfl6rixn79aeKQ9sGLc9YIVMZezPji3W91hOEDg3igvDKMeBrvC3HoB5LZzXPalERzhLF4cHYyxbqunK/gDX7cCPf2YGAA+kXLMtQVSsl4yuLUZd4eJqWW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lew5dHJX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E852BC4CED2;
	Mon, 27 Jan 2025 04:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737953483;
	bh=MP5quvHBDN7k35e6RGGtxX0t8y8u7jhKsU/FGhI5zdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lew5dHJXknFjzOW36Rib15BHiM3vLvNHrw4+kpJxAGzdWQz5Wq6HPBohWme5nANCz
	 piXRw8aSDn7kVz6tulHNLkQpmPqa1Tn1vtMN1SOOFSAOFgh64D4rPUYtUkLT/zqiD7
	 2wgbPJIDprlCiTfrmpva/60u0FRYruucYIVbBsVj0cww4ClYUV86AvgSR4LOGsA6E0
	 4N10dQycFwXGFCk0nAbHFIldS80TvjVzflSoPBGNS3CQYVT5enq13GgmgfpZwMybHq
	 eKc/FPstif+ganbHJP2xQMSfBCYI/O3hXVhd08UdlbKZXcq7cz4Bnj3NvwDbQa80o4
	 yF3B4YlkIt9hw==
Date: Sun, 26 Jan 2025 22:51:22 -0600
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Scott Wood <oss@buserror.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, Lee Jones <lee@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.neuschaefer@gmx.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Mark Brown <broonie@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH 7/9] dt-bindings: watchdog: Convert mpc8xxx-wdt binding
 to YAML
Message-ID: <20250127045122.GA3127337-robh@kernel.org>
References: <20250126-ppcyaml-v1-0-50649f51c3dd@posteo.net>
 <20250126-ppcyaml-v1-7-50649f51c3dd@posteo.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250126-ppcyaml-v1-7-50649f51c3dd@posteo.net>

On Sun, Jan 26, 2025 at 07:59:02PM +0100, J. Neuschäfer wrote:
> Convert mpc83xx-wdt.txt to YAML to enable automatic schema validation.
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
>  .../devicetree/bindings/watchdog/mpc8xxx-wdt.txt   | 25 ---------
>  .../devicetree/bindings/watchdog/mpc8xxx-wdt.yaml  | 64 ++++++++++++++++++++++
>  2 files changed, 64 insertions(+), 25 deletions(-)

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

