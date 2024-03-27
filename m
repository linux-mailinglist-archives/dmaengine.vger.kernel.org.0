Return-Path: <dmaengine+bounces-1574-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E990088EC01
	for <lists+dmaengine@lfdr.de>; Wed, 27 Mar 2024 18:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 619FAB27FDD
	for <lists+dmaengine@lfdr.de>; Wed, 27 Mar 2024 16:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714A114C5AF;
	Wed, 27 Mar 2024 16:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDqzBkYR"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420B1131BA6;
	Wed, 27 Mar 2024 16:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711558457; cv=none; b=AMlEIVIgEKg12Ol/NPzgK0C+chJizDRoBH3ZB0fla76xlZjRl6py8YRnJhmmXhzZewj/TMtz+yGteN9FR1eGrG6FWOKslyxTlU+vHSOWTErU1PTvxqvutE6nCKLAZa3vTwxASliIKdQnZU/w+iu0n269r7swY9cAg9oN9jj160E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711558457; c=relaxed/simple;
	bh=YtctpCpdB+VYCu2a9Q5m8T9kdg5d6vQjlyKgCNcle3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McRPLP70MW05jgb/WJAYfiMHSc+1jvqUsA7218p8VTno2YIomghj3U8C2oznxFDNlTXMtNsBPtWur0AttXUZSCAiUQJW22tT60zYBof/Gk1GsD+wX6qbhem6EqdPel0N6hPt2YQVQzAWWyL4vwifkbydPt/7yAQDr0SnyhIOfSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDqzBkYR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1B8C433C7;
	Wed, 27 Mar 2024 16:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711558456;
	bh=YtctpCpdB+VYCu2a9Q5m8T9kdg5d6vQjlyKgCNcle3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qDqzBkYRpznyWCPMUh8t7LobBrg1hMyymR1es+/eqRzbuTVSpGlZ9heKdm7ri2z1F
	 vq77gRO9qd9QkpReW+xiXZ0fK8IeRdSbziH3w98yxjKeWwZOKGlgojuJhJuyO2E02T
	 DkM4sxgwOFE66OYjpxxeQ1nBrwetYVZVME993U4AZnCL9Hlk2KbVRiscw8SzDISDIO
	 vgrC/jWVjOQi6e7F1xNoV7i1JNAjXn3ko7qbqCPWM1fwiJAskfmRKphNpSGN2YE+5r
	 ncBJUPKduA3FCoyKNJwE95K6VHSB5tgvvDG50cvRJjGU5R/Lpz8+qS25PktdY0CicD
	 zKf/TW7TgdSzg==
Date: Wed, 27 Mar 2024 16:54:12 +0000
From: Conor Dooley <conor@kernel.org>
To: ChunHau Tan <chunhau.tan@starfivetech.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	JeeHeng Sia <jeeheng.sia@starfivetech.com>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: dma: snps,dw-axi-dmac: Add JH8100
 support
Message-ID: <20240327-skewed-unworn-d70215e3f07b@spud>
References: <20240327025126.229475-1-chunhau.tan@starfivetech.com>
 <20240327025126.229475-2-chunhau.tan@starfivetech.com>
 <6533503e-18e1-4957-96cc-db091e9c46c9@linaro.org>
 <BJSPR01MB0595D132CB5A072A9E61F9C09E34A@BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0K8lVn5NkQryrHMv"
Content-Disposition: inline
In-Reply-To: <BJSPR01MB0595D132CB5A072A9E61F9C09E34A@BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn>


--0K8lVn5NkQryrHMv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 08:24:01AM +0000, ChunHau Tan wrote:
>=20
>=20
> > -----Original Message-----
> > From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Sent: Wednesday, 27 March, 2024 3:50 PM
> > To: ChunHau Tan <chunhau.tan@starfivetech.com>; Eugeniy Paltsev
> > <Eugeniy.Paltsev@synopsys.com>; Vinod Koul <vkoul@kernel.org>; Rob Herr=
ing
> > <robh@kernel.org>; Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.o=
rg>;
> > Conor Dooley <conor+dt@kernel.org>
> > Cc: Leyfoon Tan <leyfoon.tan@starfivetech.com>; JeeHeng Sia
> > <jeeheng.sia@starfivetech.com>; dmaengine@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v2 1/2] dt-bindings: dma: snps,dw-axi-dmac: Add JH8=
100
> > support
> >=20
> > On 27/03/2024 03:51, Tan Chun Hau wrote:
> > > Add support for StarFive JH8100 SoC in Sysnopsys Designware AXI DMA
> > > controller.
> > >
> > > Both JH8100 and JH7110 require reset operation in device probe.
> > > However, JH8100 doesn't need to apply different configuration on
> > > CH_CFG registers.
> >=20
> > This is a friendly reminder during the review process.
> >=20
> > It looks like you received a tag and forgot to add it.
> >=20
> > If you do not know the process, here is a short explanation:
> > Please add Acked-by/Reviewed-by/Tested-by tags when posting new version=
s,
> > under or above your Signed-off-by tag. Tag is "received", when provided=
 in a
> > message replied to you on the mailing list. Tools like b4 can help here=
=2E However,
> > there's no need to repost patches *only* to add the tags. The upstream
> > maintainer will do that for tags received on the version they apply.
> >=20
> > https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/=
submitt
> > ing-patches.rst#L577
> >=20
> > If a tag was not added on purpose, please state why and what changed.
>=20
> Hi Krzysztof, thank you very much for the feedback,
> Sorry I overlooked it.
> Do you prefer I resend V2 patch or send a V3 patch to include the Acked-b=
y ?

I resent the tag, you do not need to do anything.

Thanks,
Conor.

--0K8lVn5NkQryrHMv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgRPNAAKCRB4tDGHoIJi
0nnSAP9BWE0+2dsBJL1vUxw62h2uDxlBC7J4MRQxeyx9dWWR1AD/c9QNihfyYiqb
gXrjgAjI/mlRlwoCYOSGJE3MYB78fAU=
=DJMF
-----END PGP SIGNATURE-----

--0K8lVn5NkQryrHMv--

