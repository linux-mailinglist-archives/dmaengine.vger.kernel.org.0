Return-Path: <dmaengine+bounces-4504-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 103B4A37655
	for <lists+dmaengine@lfdr.de>; Sun, 16 Feb 2025 18:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EBA03B0D5F
	for <lists+dmaengine@lfdr.de>; Sun, 16 Feb 2025 17:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C0319E7F7;
	Sun, 16 Feb 2025 17:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="RUgSl7vy"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BDB19D083
	for <dmaengine@vger.kernel.org>; Sun, 16 Feb 2025 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739727566; cv=none; b=sCRBBT1L5nSFLiH3UDlP0KZhmY1Dve/1raqVu9P/zwIEIGD6+nVkfoa86LbJqtCZiLe5xukYzcXPQqSIiLfdoOiXLdK0o8V9LOSBccTg2btING3S1IqMdicne5l8t5gp2ApkldfizfXAY/ggf0qejYJ6da88ceTSViC53/7b6dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739727566; c=relaxed/simple;
	bh=9Ya3nZNb9MMk0kVeCzyrPJWutNb/VgKd2miIFEuE9e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLLhLszYuz8PCos4GzW9nUfISe6JAPiWJx5/kN4XEMBPQOiwUHi93127FI7VzQ0aWRSmLOg+x63WVQoqj9sURE+h5JK23V9d9isgB7CiqU2YyndkF4LdeTTdIeUsqViQEtQbhGhP5kq4kCGikpCu8H0pMKUh/o68EF8CAbXRn3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=RUgSl7vy; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 16DFF240031
	for <dmaengine@vger.kernel.org>; Sun, 16 Feb 2025 18:39:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1739727562; bh=9Ya3nZNb9MMk0kVeCzyrPJWutNb/VgKd2miIFEuE9e4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=RUgSl7vyuD2gu97FMTGIHdpD9+s2OvoQa9Nw1zQw37hMzYtynBGKY1TvPUgt3cQ+/
	 ovTyJ8wwDt+SrvDnejvkHeLCpib+vqnNQZHILfweuQDIh0y2B604KgecdoS7dUP4ae
	 yW6G+OO3uRqrbkwh36SO1nlmLxGT01Y2hkKBOcgNrIREea1UUQCZ0+BUG7+K1iKrN+
	 de+TmyWis9VfuniNIVfA5h4BY1q+/yjAf2NqMNQE6m/FDq7NZQk0KiWCKBSTTw21Sb
	 jf147xX42+o1IMYGbMU9rhLJk8l8+VAd1Ym4Khu0ShwMV3tgVIbmh050LCBKqjbAj4
	 /NluK9WXPq68g==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4YwtM83X13z6txn;
	Sun, 16 Feb 2025 18:39:16 +0100 (CET)
Date: Sun, 16 Feb 2025 17:39:16 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Rob Herring <robh@kernel.org>
Cc: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>,
	devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Krzysztof Kozlowski <krzk@kernel.org>, imx@lists.linux.dev,
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
	=?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Mark Brown <broonie@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 11/12] dt-bindings: nand: Add fsl,elbc-fcm-nand
Message-ID: <Z7IixGUskrWxxZIZ@probook>
References: <20250207-ppcyaml-v2-0-8137b0c42526@posteo.net>
 <20250207-ppcyaml-v2-11-8137b0c42526@posteo.net>
 <20250211000157.GA240011-robh@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250211000157.GA240011-robh@kernel.org>

On Mon, Feb 10, 2025 at 06:01:57PM -0600, Rob Herring wrote:
> On Fri, Feb 07, 2025 at 10:30:28PM +0100, J. Neuschäfer wrote:
> > Formalize the binding already supported by the fsl_elbc_nand.c driver
> > and used in several device trees in arch/powerpc/boot/dts/.
> > 
> > Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> > ---
> > 
> > V2:
> > - split out from fsl,elbc binding patch
> > - constrain #address-cells and #size-cells
> > - add a general description
> > - use unevaluatedProperties=false instead of additionalProperties=false
> > - fix property order to comply with dts coding style
> > - include raw-nand-chip.yaml instead of nand-chip.yaml
> 
> Why? Doesn't look like you use anything from it. I think the correct 
> thing to use here is just mtd.yaml to pick up partitions.

There is one example of properties from nand-chip.yaml being used
on an fsl,elbc-fcm-nand node: arch/powerpc/boot/dts/turris1x.dts
uses nand-ecc-mode and nand-ecc-algo.


Thanks,
J. Neuschäfer

