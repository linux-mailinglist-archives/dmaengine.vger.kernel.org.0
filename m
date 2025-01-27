Return-Path: <dmaengine+bounces-4204-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3765FA1D00F
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jan 2025 05:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 924471638CB
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jan 2025 04:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475841DBB03;
	Mon, 27 Jan 2025 04:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EcrPn4L2"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0642E126BEE;
	Mon, 27 Jan 2025 04:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737951829; cv=none; b=Zv6i6wsHPb/BDiWi9MtFzi+QnoBcvECDOA5iM1bMGHjamErree03fazYx6FwdtyowXz1pZScwbAS5NoxRFsm1bQ21d5bo7mU53IWROimHOKgUiyubGUH0ImjS+F8ca79taKbxwg4matgl3HC3blYxvmYMwZmp0krVW5e1OfZedo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737951829; c=relaxed/simple;
	bh=miZrlNghDbxyTZzrKu3L8ab88Zt9rpvC1n4KYw977rU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtkqotZoDNHQbrrb8nDLJIeHQI95oXRB+q75YMpB8LYpWG90kZfUKpEs2RaXqdAO/S5tTuJtJVyE2f1U9lnkGa576QyVhf+7n8PTMSFsWurrwzvHEVtOCAyA+iB1eYMuNgjVl4EnLU+ez5Ymj95Ii0YO+WCecUI/OuWSxzi6mXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EcrPn4L2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B73C4CED2;
	Mon, 27 Jan 2025 04:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737951828;
	bh=miZrlNghDbxyTZzrKu3L8ab88Zt9rpvC1n4KYw977rU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EcrPn4L2165qqoi43IdQ1t9rM+v8XNG69QGvAvJ3iSoflVUZeAXt69KcSbRo686Be
	 ZkILmYE9nHp+zy6B4DbBnuZE5k39PftQDd4SkMfrhpXXVZM8z1mxUnSg8Uv3eHZ9Ep
	 FQmu6JtSGaKqI8JKmU99H8KpzLOMkxDnYJ5HsMCA2sfHQJdWcaN+8lG/KspJQIS+hP
	 Y5JxKllSRH0zn13yviPft9eA8GiVP/vlYDeI1PaK3ReKqgfyY2wRvfOJAaES98tuBK
	 lEgCNpGrS2XcJOskwkSyowom86AbjkrNxyoNb1AcXeRpPaKW+HFKFyq15Uo9Yl0+QE
	 I6vuL2F2uj0zA==
Date: Sun, 26 Jan 2025 22:23:47 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>
Cc: linux-spi@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	devicetree@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Scott Wood <oss@buserror.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Naveen N Rao <naveen@kernel.org>, linuxppc-dev@lists.ozlabs.org,
	Conor Dooley <conor+dt@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Michael Ellerman <mpe@ellerman.id.au>, linux-crypto@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	"David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.neuschaefer@gmx.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-mtd@lists.infradead.org, dmaengine@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mark Brown <broonie@kernel.org>, linux-pci@vger.kernel.org,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 1/9] dt-bindings: powerpc: Add binding for Freescale/NXP
 MPC83xx SoCs
Message-ID: <173795182667.3090530.5101657106637409770.robh@kernel.org>
References: <20250126-ppcyaml-v1-0-50649f51c3dd@posteo.net>
 <20250126-ppcyaml-v1-1-50649f51c3dd@posteo.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250126-ppcyaml-v1-1-50649f51c3dd@posteo.net>


On Sun, 26 Jan 2025 19:58:56 +0100, J. Neuschäfer wrote:
> Add a new binding for MPC83xx platforms, describing the board compatible
> strings used in currently existing device trees.
> 
> Note that the SoC bus is called immr@... in many existing devicetrees,
> but this contradicts the simple-bus binding.
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
>  .../bindings/powerpc/fsl/fsl,mpc83xx.yaml          | 67 ++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


