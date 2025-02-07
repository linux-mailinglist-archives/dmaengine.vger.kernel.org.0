Return-Path: <dmaengine+bounces-4329-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B11A2C3D5
	for <lists+dmaengine@lfdr.de>; Fri,  7 Feb 2025 14:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98B4E167A0C
	for <lists+dmaengine@lfdr.de>; Fri,  7 Feb 2025 13:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4024E1F6694;
	Fri,  7 Feb 2025 13:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="WGLsSyhy"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7971FC7D8
	for <dmaengine@vger.kernel.org>; Fri,  7 Feb 2025 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738935441; cv=none; b=KC2gN0/MXzmcQbziX+dq1uBGpjOWSQEjgrfqAPU1rnIbt5uIl9DGC+JwWAaTNQDJxSoBF3+llbiIGeEjbawr9ph5I5sJ3u3Fgclg4NUn56gm0r4QIfzl/unQCedZNZxbd5kaq7InU2PYz7+2wzqfKQzC06qA3PJPblHoWeSVzM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738935441; c=relaxed/simple;
	bh=IdbOi6N0+bHgyQ08uTaIC9JomsdE+10WelxdSZmGp0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMIwnTwgDfbZXkEFzxdK60HNquetIEF6LmrWbG43bDu3G1bWe3K4FqKvDF+dBOlyXFy8aplKQUzWM72W8nTAKfq2mtxXwp85UX1O9JWvmR2v0ZSJNcvgFD7cd67AoiKI1STFmqz8KDLQktHf75p7dPtzKqca84lE9s8xL1LIi+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=WGLsSyhy; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id C3F8A240029
	for <dmaengine@vger.kernel.org>; Fri,  7 Feb 2025 14:37:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1738935431; bh=IdbOi6N0+bHgyQ08uTaIC9JomsdE+10WelxdSZmGp0A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=WGLsSyhyR1M+holYpFY2DE/LqX/M15jThbkxjOYqB/FmQAFFwC+GWz5a9IBwAww3F
	 mXlFcNxwX5ET/KIyhDzrzYAJY2KaepXF/mKP4+zXFWdqXcK2Rpm93qt97oV3bsN4U3
	 6OYk4IO4oNfu/VfOtLRiUArkbEZMHnUtEJuShNd8ptsnidw4lztDocLchG9SWz9COQ
	 GA8CeOLRgAiXRcPtFw1cPUr7OZALJdnNxBcwTv1PQp4jHg7fJVSTPfXh9ptk+RHx08
	 mrnvnVzNvI/Gm1FUwiVaDkEn8atEz/5JPR20I63GGSttcZALk/3j01UOWYKbg5sLQG
	 8/F+eljWn4kpQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4YqFPs4w9Pz9rxF;
	Fri,  7 Feb 2025 14:37:05 +0100 (CET)
Date: Fri,  7 Feb 2025 13:37:04 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Cc: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>,
	Frank Li <Frank.li@nxp.com>, devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Scott Wood <oss@buserror.net>,
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
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH 6/9] dt-bindings: pci: Add fsl,mpc83xx-pcie bindings
Message-ID: <Z6YMgETdCZGMJI4i@probook>
References: <20250126-ppcyaml-v1-0-50649f51c3dd@posteo.net>
 <20250126-ppcyaml-v1-6-50649f51c3dd@posteo.net>
 <Z5qx3jAFE81Ni2cJ@lizhi-Precision-Tower-5810>
 <Z6KkBEaGTkSyWiE_@probook>
 <689302c6-8fba-4fd1-a4b7-557cb2f8fa4d@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <689302c6-8fba-4fd1-a4b7-557cb2f8fa4d@quicinc.com>

On Thu, Feb 06, 2025 at 06:12:47PM +0530, Mukesh Kumar Savaliya wrote:
> neat: subject: since binding is already mentioned in the prefix of the
> subject, no need to add bindings word again.

Sounds reasonable, thanks
J. Neuschäfer

