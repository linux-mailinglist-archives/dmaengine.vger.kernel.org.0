Return-Path: <dmaengine+bounces-4404-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5A6A2F24D
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 16:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90F918828E9
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 15:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481C12441BB;
	Mon, 10 Feb 2025 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="XJ32rxft"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD0924418C
	for <dmaengine@vger.kernel.org>; Mon, 10 Feb 2025 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739203073; cv=none; b=nWAk7pZ0GA8wKd/+8MjS/1nRzQq9nN46k3JRkzIe3z666ngdOmIav50Wk8RDm3fz1bb1trukmWOgZ1qfiu7CpK0AWIadeLQSgxfKAjIaoQxjYyflGjHb2Ad3hmt4Zoh22TUdiCoc+AbNgBF8XlblvtDfd9oAFUSmS8MOb4cnYLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739203073; c=relaxed/simple;
	bh=lQ9xjXE4fQ5E3R9uQe1RdCFTA3rQo7TSFCMdjBUTzJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=scg2WBLWJ4/i6apE/2x/SpOqnn+NoJfNQBc7GpG+6EIGyCoiEIRoAuvHCmU8ltzxP6/5pptEx20gR0DYPCA5lrpAuELJDzcMj0HmXxl9r6a0+3Axybi9IwyTCVxVjpAcBWO560STHPfm7mSl2n6k3p2qiWtO3iBZiJPXC3IBiqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=XJ32rxft; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 6B056240029
	for <dmaengine@vger.kernel.org>; Mon, 10 Feb 2025 16:57:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1739203069; bh=lQ9xjXE4fQ5E3R9uQe1RdCFTA3rQo7TSFCMdjBUTzJk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=XJ32rxft95edBr+EDeVQZGHUeecj5jwxAYiaY0fmQiw2umt38i4PSHy9Xqg3hFJiG
	 /zwvz+V5oKOw72WAw2xrq8hAP8wB+Yc79C5RKXPI+nT84dGnO8FJJe6BgjV+2KCv1K
	 1a/Sv9v6+tUMPu1OxatgL5s/rO/RkvTTXucwVQkuLC0FQKgeXGmOlzDLtEJL/rvaCK
	 3aSKa8WrXTNh5x1YiXZFYpqIAEdpStyegfE2z3NDSW+zSkvotggBkO6XagnhOYe+Gy
	 f22mnkpYg4Jfa392j6ToQbc6mTrz2xOh4/2lLIwaI1sSOLm6xfkPKEKVOGeJI1JRD3
	 asuBpZK0jhXeA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Ys8Nl2HW4z9rxD;
	Mon, 10 Feb 2025 16:57:42 +0100 (CET)
Date: Mon, 10 Feb 2025 15:57:42 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Mark Brown <broonie@kernel.org>
Cc: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>,
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
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 00/12] YAML conversion of several Freescale/PowerPC DT
 bindings
Message-ID: <Z6oh9t2QQzz17Yt6@probook>
References: <20250207-ppcyaml-v2-0-8137b0c42526@posteo.net>
 <611e47da-ba87-4c21-a6b7-cf051dc88158@sirena.org.uk>
 <Z6a_f03Ct9aB7Bbn@probook>
 <0fe3416c-c3f3-44c4-a1c0-7e8262c54d4b@sirena.org.uk>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0fe3416c-c3f3-44c4-a1c0-7e8262c54d4b@sirena.org.uk>

On Mon, Feb 10, 2025 at 12:59:35PM +0000, Mark Brown wrote:
> On Sat, Feb 08, 2025 at 02:20:47AM +0000, J. Neusch=C3=A4fer wrote:
> > On Fri, Feb 07, 2025 at 09:38:05PM +0000, Mark Brown wrote:
>=20
> > > What's the story with dependencies here - why is all this stuff in one
> > > series?
>=20
> > The patches are independent of each other, except for the four elbc/nand
> > patches. They are in the same series because they came up during the
> > same project and achieve similar goals, but it isn't necessary.
>=20
> Please don't do this, it just makes it harder to merge things since it
> makes it look like there's cross tree merges needed when that's not the
> case, complicating merging, and puts the entire series in everyone's
> inbox which makes things more noisy.

How should I proceed with this series, in your opinion?
I see potential advantages (less of the issues you describe) and
disadvantages (somewhat harder to track patches) of splitting it up
before sending v3.

(Outside of this series, the conclusion is clear and simple)


J. Neusch=C3=A4fer

