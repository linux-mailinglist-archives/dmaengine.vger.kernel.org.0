Return-Path: <dmaengine+bounces-4365-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D15A2E089
	for <lists+dmaengine@lfdr.de>; Sun,  9 Feb 2025 21:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD4FA1885F45
	for <lists+dmaengine@lfdr.de>; Sun,  9 Feb 2025 20:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4FB1E008B;
	Sun,  9 Feb 2025 20:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=buserror.net header.i=@buserror.net header.b="JwerkDeF"
X-Original-To: dmaengine@vger.kernel.org
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689EB38DDB;
	Sun,  9 Feb 2025 20:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=165.227.176.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739134211; cv=none; b=pHtsp1/Onn2sPV/F8NjTtx7rQldj/4e0Y+x6xU6fZkOkxKbTlb9DLdbcAz4fEPd70g9rt7aIMw0Ttep6AriU9FfgRGLmsjAUOAaU7N8lPnWVkPcMVGNK+2D89ZqDWnsYcEpJUy/yMIHtXsUuSCops2X1jgMLXTrP2//ClV/12l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739134211; c=relaxed/simple;
	bh=QhRwFeKqWMeHZQA5gyZTCQJnuWVF8Yk6P25dHCpDbWU=;
	h=Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Subject; b=gqJb6KOBT2WFLCDw9DzSxj0fpPd4Prp4W8iYP+kRbH3PkMV9WG+UIdJITM8N+RBZfMv3jSrRljc1wx+KXwqnBBt3GhFHxiDLzUEnyOY0MKkXtN8tLd2IKJugqwETVKpS8lxPjSggy+IM1pWEvIn7NX9O0U3d+CtW313crM+HeiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=buserror.net; spf=pass smtp.mailfrom=buserror.net; dkim=pass (2048-bit key) header.d=buserror.net header.i=@buserror.net header.b=JwerkDeF; arc=none smtp.client-ip=165.227.176.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=buserror.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buserror.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=buserror.net; s=rsa_sel; h=Subject:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Cc:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MuELZahnfjB2zfNBXkn/7vS+YWEIHeJmEyTF3bHn8yY=; b=JwerkDeFpUYmUtvgiyfDWFRcyc
	M1SayaRB+qccNqxuZLeR/Bh0Zi4doXvs2AuwQ4bXULgliRwmuL+46mVeaEmUJnjt20xSeByKQCeF7
	pqQnatSRU4+zfcORETcgPqMoDuz9Ijk4jbJsPiKiaLEQcbpIHWc/P0F4c/jFvX5d56ebaA3NJGjAd
	XSH27+KqmV7Z5IMLaNqwxgX15BzUCAKWCpbNvQyD4qc8VY5U6w9qaUHRzKdRGVNRg0Fih8GzX5jbP
	YQTGOo2FWDlTffHnVVvamHnt6obLmm/skiwsWgFKjykOnhriFwqciL6UJ9O4Wfc6dQ7QoO2ga6o7N
	QoWK9LuQ==;
Received: from oss by baldur.buserror.net with local (Exim 4.96)
	(envelope-from <oss@buserror.net>)
	id 1thEFY-00C5fM-1y;
	Sun, 09 Feb 2025 14:49:57 -0600
Date: Sun, 9 Feb 2025 14:49:56 -0600
From: Crystal Wood <oss@buserror.net>
To: j.ne@posteo.net
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Krzysztof Kozlowski <krzk@kernel.org>, imx@lists.linux.dev,
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
	=?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.neuschaefer@gmx.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Mark Brown <broonie@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-mtd@lists.infradead.org, Li Yang <leoyang.li@nxp.com>,
	John Ogness <john.ogness@linutronix.de>
Message-ID: <Z6kU9G4u3BbBJn5p@buserror.net>
References: <20250207-ppcyaml-v2-0-8137b0c42526@posteo.net>
 <20250207-ppcyaml-v2-9-8137b0c42526@posteo.net>
 <Z6kQpuQf5m-bXTyt@buserror.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6kQpuQf5m-bXTyt@buserror.net>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: j.ne@posteo.net, devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, krzk@kernel.org, imx@lists.linux.dev, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, dlemoal@kernel.org, cassel@kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net, lee@kernel.org, vkoul@kernel.org, lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, bhelgaas@google.com, j.neuschaefer@gmx.net, wim@linux-watchdog.org, linux@roeck-us.net, broonie@kernel.org, miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, leoyang.li@nxp.com, john.ogness@linutronix.de
X-SA-Exim-Mail-From: oss@buserror.net
X-Spam-Level: 
X-Spam-Report: 
	*  -15 BAYES_00 BODY: Bayes spam probability is 0 to 1%
	*      [score: 0.0000]
	* -0.0 NO_RELAYS Informational: message was not relayed via SMTP
Subject: Re: [PATCH v2 09/12] dt-bindings: memory-controllers: Convert
 fsl,elbc to YAML
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)

On Sun, Feb 09, 2025 at 02:31:35PM -0600, Crystal Wood wrote:
> On Fri, Feb 07, 2025 at 10:30:26PM +0100, J. Neuschäfer via B4 Relay wrote:
> > +        simple-periph@2,0 {
> > +            compatible = "fsl,elbc-gpcm-uio";
> > +            reg = <0x2 0x0 0x10000>;
> > +            elbc-gpcm-br = <0xfd810800>;
> > +            elbc-gpcm-or = <0xffff09f7>;
> > +        };
> 
> I know this isn't new, but... since we're using this as an example,
> where is the documentation for this fsl,elbc-gpcm-uio and
> elbc-gpcm-br/or?  What exactly is a simple-periph?
> 
> There are no in-tree device trees that use this either.  The bcsr
> node was actually a much more normal example, despite that particular
> platform having been removed.  There are other bcsr nodes that still
> exist that could be used instead.

OK, I noticed patch 10 after I sent this :-P

Seems I didn't like it too much when it was new either:
https://lkml.org/lkml/2014/12/9/530

And it's still a bad example for how GPCM devices on this bus should
normally be represented.

-Crystal

