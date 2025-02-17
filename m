Return-Path: <dmaengine+bounces-4509-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AF1A37FF9
	for <lists+dmaengine@lfdr.de>; Mon, 17 Feb 2025 11:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD08D16425E
	for <lists+dmaengine@lfdr.de>; Mon, 17 Feb 2025 10:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D054B216E1E;
	Mon, 17 Feb 2025 10:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="VoOKg8Sc"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD6E216E28
	for <dmaengine@vger.kernel.org>; Mon, 17 Feb 2025 10:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739787727; cv=none; b=ccxX1QZ5QaC40wocvZjcLuk/6SuMpaup7/SaJlsOHFR/qF5yWKfzBqsg+lISfV10FxYg/RZl9ixzTfMJwKRGYTKhUouQHuF8QdoQYGQELaLRCTREB0tWj0QrM4H+J3B9/rZo02irNLMVZSaN4vMMfs9OHmsw+r3sksnC+oVZK2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739787727; c=relaxed/simple;
	bh=jMs/nQgZnmKABPkw9jqt7Jfzzk1OWmU8OV/13GG2QpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=digewljgtD/XFGH9WVvEy5dvTEWMedKL3Dj7nxACp/DEiqCbofXk2hthyy4oqCSeLbbXb5UykPaSavONJf9X/fgHI8iK9W8eA6VojF3ph7XjDJzR66m4fUvNnXERLRTL2CnKdI1eIIuNyQw5jnRDMyMAfGFsSV1prnkYaWo+0XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=VoOKg8Sc; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 76301240028
	for <dmaengine@vger.kernel.org>; Mon, 17 Feb 2025 11:21:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1739787718; bh=jMs/nQgZnmKABPkw9jqt7Jfzzk1OWmU8OV/13GG2QpU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=VoOKg8ScbUMn0vwJXXeE+NHJZ0a9mDWjY3CeKpA7rXlmzvqNpeipXr22cUOZkwj5W
	 hlHqEuxydHy2X+qdRqpAo/cZQ0lKjeeiHRkh9nxqXR5EWMuKhJuMZW1Fm26Xtg1VNw
	 tbdXTKy0CrqIUEbhY0LakzhEglbdyyiFYaoYghcIt8r4EyXEM2uxT+QJ6RRDWpBWm4
	 OAMMipY1+hxsNKuYe7M94yopTUKCsQDL/6zirsQuwS50oW7b0kPaaMuIW9tg7PQOzY
	 ahZGwYFab344VQG/hqYTXsssLZrxpk4bz1wWrxm03KZGWNYvnFT67CaAZfNIy7ddYs
	 JG3RfyGnXf56g==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4YxJc00sngz9rxD;
	Mon, 17 Feb 2025 11:21:51 +0100 (CET)
Date: Mon, 17 Feb 2025 10:21:51 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>,
	=?utf-8?Q?J=2E_Neusch=C3=A4fer?= via B4 Relay <devnull+j.ne.posteo.net@kernel.org>,
	devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Krzysztof Kozlowski <krzk@kernel.org>, imx@lists.linux.dev,
	Scott Wood <oss@buserror.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>, Rob Herring <robh@kernel.org>,
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
	=?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Mark Brown <broonie@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 12/12] dt-bindings: mtd: raw-nand-chip: Relax node
 name pattern
Message-ID: <Z7MNv4NX8dSztdsP@probook>
References: <20250207-ppcyaml-v2-0-8137b0c42526@posteo.net>
 <20250207-ppcyaml-v2-12-8137b0c42526@posteo.net>
 <87o6zaurv9.fsf@bootlin.com>
 <Z7Iqir-qaZDt6tsx@probook>
 <87tt8svrxf.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tt8svrxf.fsf@bootlin.com>

On Mon, Feb 17, 2025 at 10:31:08AM +0100, Miquel Raynal wrote:
> Hello,
> 
> >> > In some scenarios, such as under the Freescale eLBC bus, there are raw
> >> > NAND chips with a unit address that has a comma in it (cs,offset).
> >> > Relax the $nodename pattern in raw-nand-chip.yaml to allow such unit
> >> > addresses.
> >> 
> >> This is super specific to this controller, I'd rather avoid that in the
> >> main (shared) files. I believe you can force another node name in the
> >> controller's binding instead?
> >
> > It's a bit tricky. AFAICS, when I declare a node name pattern in my
> > specific binding in addition to the generic binding, the result is that
> > both of them apply, so I can't relax stricter requirements:
> >
> > # raw-nand-chip.yaml
> > properties:
> >   $nodename:
> >     pattern: "^nand@[a-f0-9]$"
> >
> > # fsl,elbc-fcm-nand.yaml
> > properties:
> >   $nodename:
> >     pattern: "^nand@[a-f0-9](,[0-9a-f]*)?$"
> 
> Well, I guess this is creating a second possible node name.
> 
> > # dtc
> > /.../fsl,elbc-fcm-nand.example.dtb:
> > nand@1,0: $nodename:0: 'nand@1,0' does not match '^nand@[a-f0-9]$'
> >         from schema $id:
> > 	http://devicetree.org/schemas/mtd/fsl,elbc-fcm-nand.yaml#
> 
> What about fixing the DT instead?

In this particular context under the Freescale eLBC ("enhanced Local Bus
Controller"), nand@1,0 makes complete sense, because it refers to chip
select 1, offset 0. The eLBC binding (which has existed without YAML
formalization for a long time) specifies that each device address
includes a chip select and a base address under that CS.

The alternative of spelling it as nand@100000000 makes readability
strictly worse (IMO).

Due to the conflicting requirements of keeping compatibility with
historic device trees and complying with modern DT conventions,
I'm already ignoring a validation warning from dtc, which suggests to
use nand@100000000 instead of nand@1,0 because the eLBC bus has
historically been specified with compatible = ..., "simple-bus",
so I guess the fsl,elbc-fcm-nand binding can't be perfect anyway.

In any case, I'll drop this patch during further development.


Thank you for your inputs,

J. Neuschäfer

