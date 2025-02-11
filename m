Return-Path: <dmaengine+bounces-4418-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0897CA30DDC
	for <lists+dmaengine@lfdr.de>; Tue, 11 Feb 2025 15:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A49B11621FE
	for <lists+dmaengine@lfdr.de>; Tue, 11 Feb 2025 14:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D3E24CEE0;
	Tue, 11 Feb 2025 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWXtA3oT"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF7D1F1908;
	Tue, 11 Feb 2025 14:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739283216; cv=none; b=L+SbSjk/DcRbrRnKXCD1/5cDHTL8olBWE4OHJDwIUZ2cxLYpRb6+HCy/S26aSzDFDf1i6QiI6ogmAuJ6tIY1nhfZLYbu58YvXkg3ls0KmvGx4W40hINd9B/TopyUg/P969YMg9+LS8draQtB8qoc7ULA9vNVIo3av0aNKd2ZdMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739283216; c=relaxed/simple;
	bh=vDix81U6Ld3DReX03VSDWokaA9gTIex+ysGARHYBa4w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D31u2YMr3d/y1PDuWE/uNDCKa+RookZYgEH19eVLbla8/c4WZgE5EiVaahtZsyjBTv3ARGc2iWoGp4dWgV/yzjkWMk0zcsnb8vkMtv4e4vM9d4KmR2f8dQvaJypMKxO/8U0Y2qeANJXRp3YRVOVGP4BHc+QuG1kGy5DbYUCZe6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWXtA3oT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FA2C4CEDD;
	Tue, 11 Feb 2025 14:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739283215;
	bh=vDix81U6Ld3DReX03VSDWokaA9gTIex+ysGARHYBa4w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UWXtA3oTS+v0q5G+sC9wAGrQZjODEQAnaR0oVQTshDp+I9TwaC8dSIgVEox+pVhiv
	 WWcvOT3MmyWJ75dZACpkY8Ja3QESry9PBuQV9mlp1VMqI/238hvWLqFYRuZ9Jqm0oN
	 cwTz0p2oIVVzONSb4lDc9caK6gmpqGWLqfw/lwN56VuXEYaARH68C1tUya+W8JUVg9
	 3U5dEFvvQsZXw3u7N+8B3j4rIFzCmvZVl7xl2QxnqTdoxo6WV51ZbZRiK96/YKQpV9
	 1kOSZLQ8BBJBrMsbguCncwtdh8zf2Crfw5Wgh4QQqqYCFFWPSquZBXcWueQ4cHPvb6
	 srLbfkvAlWIXA==
From: Lee Jones <lee@kernel.org>
To: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Cc: Scott Wood <oss@buserror.net>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
 Niklas Cassel <cassel@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Lee Jones <lee@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Mark Brown <broonie@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, 
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org
In-Reply-To: <20250126-ppcyaml-v1-4-50649f51c3dd@posteo.net>
References: <20250126-ppcyaml-v1-0-50649f51c3dd@posteo.net>
 <20250126-ppcyaml-v1-4-50649f51c3dd@posteo.net>
Subject: Re: (subset) [PATCH 4/9] dt-bindings: mfd: Convert
 fsl,mcu-mpc8349emitx binding to YAML
Message-Id: <173928320921.2188572.3955959141357602902.b4-ty@kernel.org>
Date: Tue, 11 Feb 2025 14:13:29 +0000
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Sun, 26 Jan 2025 19:58:59 +0100, J. Neuschäfer wrote:
> Convert mcu-mpc8349emitx.txt to YAML and list the compatible strings
> currently in use.
> 
> 

Applied, thanks!

[4/9] dt-bindings: mfd: Convert fsl,mcu-mpc8349emitx binding to YAML
      commit: 252c95ec3802a5f447df58253575b52aa741c1a1

--
Lee Jones [李琼斯]


