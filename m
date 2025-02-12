Return-Path: <dmaengine+bounces-4448-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF34A32FFE
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 20:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 472593A7809
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 19:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D281FF7AA;
	Wed, 12 Feb 2025 19:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oj8s8rQe"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7575E1FF7A9;
	Wed, 12 Feb 2025 19:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739389488; cv=none; b=Lu/zuYRsdmLoKlMF4RtXQa1jXeMA5xwWoHXS8DcroCbCVn89KYiFjBc0EchrEvRNeIC0RXbTzKL+cZDPxyf5BJmvNfjUI5NmhWbNLC/rtAqLQq/25iK8sgFbt8wRXQ/4qAcL/8ofyrWcDZOfHbGdzEGA9hDBM7iJPkyBIpLVp6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739389488; c=relaxed/simple;
	bh=H2RGuJeh4p3PZLsKQKPNVcfG0Duy/0Y8WKyJ2Dp59WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3y5Pg+IiovjvfI8pkjqVIhVHahC8aF2VrSVdg8DGikz4jFeXp0qTngWE7LpoWl8vh7r5SSnuXFGVeSTIampRgW/EqC4RSM+UIdmBjzNLbne8gxWKQ4zHz78zPdP06ZrwWJDJptC0Qc+Y3ZFi1hKECJd015qm0WLzWJzixeG+wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oj8s8rQe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F4DC4CEDF;
	Wed, 12 Feb 2025 19:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739389488;
	bh=H2RGuJeh4p3PZLsKQKPNVcfG0Duy/0Y8WKyJ2Dp59WE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oj8s8rQeyXI3HiYI0OHJHEumwjJXAFZetGXjJbiY2MBZzopmcHcKUK4kieSry0099
	 qNx36t4mGK0OktWld9GOqZAbfj+DEYDz5hjoqokREJb1aTsdxd+D0cVUSAKj2jXwkb
	 3Ikh8NfPF3xHwGEocZ2HwUUIauob/u7P6UYBy23gs43d4HX61Yu4L6kDfSazoHUPX9
	 dknlKOu2PHYVpYSotcaWJoEHB3rHjT04kQpWWayQrdoJJH64ADn0YGdfCxkDeRfeU/
	 NPBkKJBcXimLXoqBff+yziV//iNuFWxTlue95EVOH+6rBchwDwEvGyXEivB6zAwq2j
	 5BkKP+eNC7jZg==
Date: Wed, 12 Feb 2025 13:44:46 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>
Cc: Guenter Roeck <linux@roeck-us.net>, linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	=?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.neuschaefer@gmx.net>,
	Mark Brown <broonie@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>,
	linux-watchdog@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-spi@vger.kernel.org, Naveen N Rao <naveen@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>, imx@lists.linux.dev,
	linux-ide@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
	Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-mtd@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	dmaengine@vger.kernel.org, Scott Wood <oss@buserror.net>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Niklas Cassel <cassel@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Richard Weinberger <richard@nod.at>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v2 10/12] dt-bindings: memory-controllers: Add
 fsl,elbc-gpcm-uio
Message-ID: <173938948613.128569.16012047906715128997.robh@kernel.org>
References: <20250207-ppcyaml-v2-0-8137b0c42526@posteo.net>
 <20250207-ppcyaml-v2-10-8137b0c42526@posteo.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250207-ppcyaml-v2-10-8137b0c42526@posteo.net>


On Fri, 07 Feb 2025 22:30:27 +0100, J. Neuschäfer wrote:
> Formalize the binding already supported by the uio_fsl_elbc_gpcm.c
> driver.
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
> 
> V2:
> - split out from fsl,elbc patch
> - add description
> - remove "device_type" property
> - move to bindings/memory-controllers
> ---
>  .../memory-controllers/fsl,elbc-gpcm-uio.yaml      | 59 ++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


