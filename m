Return-Path: <dmaengine+bounces-4352-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AD0A2D308
	for <lists+dmaengine@lfdr.de>; Sat,  8 Feb 2025 03:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF15216C344
	for <lists+dmaengine@lfdr.de>; Sat,  8 Feb 2025 02:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7092A15278E;
	Sat,  8 Feb 2025 02:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="RETv0pi8"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657A81465AB
	for <dmaengine@vger.kernel.org>; Sat,  8 Feb 2025 02:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738981257; cv=none; b=g2pwlHZNU4rM4VgHQ5v8DRIs8DGRlnMLBHo7PLTSw3qx0S9xFQ7g4Fdxx+4Hp4SAG3ImMG4ZrXuefRCV1JG7g3PHYYbm3mapecjTjOSKgSf3TH46conlZ88B0DzAGzvzpgjaE8nJdoJzCRlHXWTHnLDcvLnkHBb6qtzUN06jRTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738981257; c=relaxed/simple;
	bh=X/9UQWBS5m7Ib3mDDNhFlWLQ3zPrVaQFBwT1jLZLH3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhcHFxfTNqScIOEsHaA/STlKUt9tO3aDUQ/aW2yK7H9r6ngYj9mHZOKIoH+Z5XxPQBc9bHvysusH98OIWAAHYRMjzy/bGpKUyKdnLrNae83DItdQt5QoB7Xf9Be6TAV5ifRnyqhbhSz1YAGJcd6KRWrxE66NaTsB9QOK4Xa4DKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=RETv0pi8; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 8E0FD240101
	for <dmaengine@vger.kernel.org>; Sat,  8 Feb 2025 03:20:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1738981253; bh=X/9UQWBS5m7Ib3mDDNhFlWLQ3zPrVaQFBwT1jLZLH3k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=RETv0pi8P373DiegxSUvi4C2fJev+HyWTRyNykg7oIgWn47X65NNvVgCsCbdWDAQP
	 DMPA93xS+LXRfM/pNswr8q1Lv7jueqqTAaY6kl3zaQ3VQ6BVmyzau/3NjwVPv4x0pa
	 DyRmTi86qoq2bQLzc/9fvmo0N+Y1eqLuyep9+vlpbT8B2at6F1Vx/ZEQ8QKMzSjGww
	 1jnOpdg43i8qcuBMG9zpmrhFU1fjx68aD33m56Tv1/WyL22Pca//Bc0TkaL7owECs9
	 ymKH6bYxsVIiQqiGoOvl+CE/ynq28UQJdSo/80Iw0zp4Bue42SfjvS9yUGrJOzKE2z
	 WiW/Swc0Ab07w==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4YqZM431Sgz9rxL;
	Sat,  8 Feb 2025 03:20:48 +0100 (CET)
Date: Sat,  8 Feb 2025 02:20:47 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Mark Brown <broonie@kernel.org>
Cc: j.ne@posteo.net, devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
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
Message-ID: <Z6a_f03Ct9aB7Bbn@probook>
References: <20250207-ppcyaml-v2-0-8137b0c42526@posteo.net>
 <611e47da-ba87-4c21-a6b7-cf051dc88158@sirena.org.uk>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <611e47da-ba87-4c21-a6b7-cf051dc88158@sirena.org.uk>

On Fri, Feb 07, 2025 at 09:38:05PM +0000, Mark Brown wrote:
> On Fri, Feb 07, 2025 at 10:30:17PM +0100, J. Neuschäfer via B4 Relay wrote:
> 
> > This is a spin-off of the series titled
> > "powerpc: MPC83xx cleanup and LANCOM NWAPP2 board".
> 
> > During the development of that series, it became clear that many
> > devicetree bindings for Freescale MPC8xxx platforms are still in the old
> > plain-text format, or don't exist at all, and in any case don't mention
> > all valid compatible strings.
> 
> What's the story with dependencies here - why is all this stuff in one
> series?

The patches are independent of each other, except for the four elbc/nand
patches. They are in the same series because they came up during the
same project and achieve similar goals, but it isn't necessary.


> Normally I'd expect bindings conversions to be standalone.

Noted.


J. Neuschäfer

