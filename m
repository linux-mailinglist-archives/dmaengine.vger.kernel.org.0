Return-Path: <dmaengine+bounces-4364-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D52A2DF89
	for <lists+dmaengine@lfdr.de>; Sun,  9 Feb 2025 18:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB0F01884CDE
	for <lists+dmaengine@lfdr.de>; Sun,  9 Feb 2025 17:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84D41E0B7C;
	Sun,  9 Feb 2025 17:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="pFQz+Mcg"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC05D1F95E
	for <dmaengine@vger.kernel.org>; Sun,  9 Feb 2025 17:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739123136; cv=none; b=tyhGpK6ZRklk0WioBC2Be4R6zZT6CsThZEMDoeHztteIurqQ3HJmNZkwLhAjCJ0YJw0i9tv+SPHyzVtTCMaClYoPDsjK9VW2ADZz5sh4dsaPRoZ2AE9EqF1FOaDctswJJjH4xI3+cDxkxy4Ir1v7oytU3tvnkD3bDucCm/vTs+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739123136; c=relaxed/simple;
	bh=wwaN1MEN5EN7ialSuuoReLLWAW4uA92LExoXB3rQqdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeTkAM/jwJ2uaeQBpaf7GgSD3t3LckLHJ35PEBt7nQ7r5sDYwuX55+epdr3eiU8KcEA/mvgJedQ8BpdTmNrsceXtBcQPI0yTZPWzkuNHb9pYwZMdVXBMuhB9GLlOR+4+ZpDCjJ0aGbqbh/4Y/BIwz9BlOUE4Km0amg7RYvppN7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=pFQz+Mcg; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 3038F240029
	for <dmaengine@vger.kernel.org>; Sun,  9 Feb 2025 18:45:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1739123132; bh=wwaN1MEN5EN7ialSuuoReLLWAW4uA92LExoXB3rQqdE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=pFQz+McgXOD4SJpqS3t88fYmh0f5343D1MX9fCQZ5W5ZdV5d90NJnQIiHn4PjdCht
	 jpzs5EMtNx/SAOBHAvluntIEwLOprerzu70UzAecNitIGH8k0ZnZrhUFsPPYt30bPa
	 5W++llA90llvNmYGZGg6pjdtnttlirT0AnVYIO3h/V52Nxuo2QcmZfdHQ5yO7Q21SW
	 jvIRtzOr5XZUGt9zXBs5HlCATqYCjE2JIiSc7GPY4SJyuH2VUSeO6sOP/akjsfoNL7
	 NQWpd+m9PlYAgJGrD6+VmVwjqa+7KOvmx5tud7mokjtobj+GT1nLVBwQhE74lhhlhe
	 V93cWZaX8J0/A==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4YrZqX2D0Mz9rxK;
	Sun,  9 Feb 2025 18:45:28 +0100 (CET)
Date: Sun,  9 Feb 2025 17:45:27 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-ide@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
	linuxppc-dev@lists.ozlabs.org, linux-spi@vger.kernel.org,
	=?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Guenter Roeck <linux@roeck-us.net>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Naveen N Rao <naveen@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>, imx@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>, Scott Wood <oss@buserror.net>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Richard Weinberger <richard@nod.at>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Lee Jones <lee@kernel.org>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-mtd@lists.infradead.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 09/12] dt-bindings: memory-controllers: Convert
 fsl,elbc to YAML
Message-ID: <Z6jptzP7KLxmIJeL@probook>
References: <20250207-ppcyaml-v2-0-8137b0c42526@posteo.net>
 <20250207-ppcyaml-v2-9-8137b0c42526@posteo.net>
 <173897189669.2630636.11579554304003668196.robh@kernel.org>
 <Z6jlrU7EPeATjK8s@probook>
 <4c41a8e2-b097-4b95-ba0a-115dbbfc4e1a@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c41a8e2-b097-4b95-ba0a-115dbbfc4e1a@kernel.org>

On Sun, Feb 09, 2025 at 06:30:44PM +0100, Krzysztof Kozlowski wrote:
> On 09/02/2025 18:28, J. Neuschäfer wrote:
> > On Fri, Feb 07, 2025 at 05:44:59PM -0600, Rob Herring (Arm) wrote:
> >> On Fri, 07 Feb 2025 22:30:26 +0100, J. Neuschäfer wrote:
> > [...]
> >>>  .../bindings/memory-controllers/fsl,elbc.yaml      | 146 +++++++++++++++++++++
> >>>  .../devicetree/bindings/powerpc/fsl/lbc.txt        |  43 ------
> >>>  2 files changed, 146 insertions(+), 43 deletions(-)
> > [...]
> >> dtschema/dtc warnings/errors:
> >> Documentation/devicetree/bindings/memory-controllers/fsl,elbc.example.dtb: /example-0/localbus@f0010100/simple-periph@2,0: failed to match any schema with compatible: ['fsl,elbc-gpcm-uio']
> >> Documentation/devicetree/bindings/memory-controllers/fsl,elbc.example.dtb: /example-1/localbus@e0005000/nand@1,0: failed to match any schema with compatible: ['fsl,mpc8315-fcm-nand', 'fsl,elbc-fcm-nand']
> >> Documentation/devicetree/bindings/memory-controllers/fsl,elbc.example.dtb: /example-1/localbus@e0005000/nand@1,0: failed to match any schema with compatible: ['fsl,mpc8315-fcm-nand', 'fsl,elbc-fcm-nand']
> > 
> > I think this is due to how the patches are ordered in the series.
> 
> If that's possible, this should be fixed, e.g.  by re-ordering the patches.

Yes, I'll do that for the next iteration


Best regards,
J. Neuschäfer

