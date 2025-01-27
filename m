Return-Path: <dmaengine+bounces-4207-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB78A1D054
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jan 2025 05:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13C743A49D9
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jan 2025 04:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B62815ADB4;
	Mon, 27 Jan 2025 04:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrYmahB0"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B60E157A48;
	Mon, 27 Jan 2025 04:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737952923; cv=none; b=fOLWnbAYQLAA011ceNjdL818hSXeKgizox6piRDg3iUFBaSaGeWFFAHQRMIa2OHGYUxjvIvQiXGfGKR4jJ1jBHXF/6udK2CFyZQ8E7lemiSf/0mAGfWRe2fXWaJWEZlRvjokhaoZP4YVC06wvt9R6tvU0eZgGKM0wnKwhMYWvKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737952923; c=relaxed/simple;
	bh=7RQPPYx18JlZ50CfItwadjRZng2k8lf+GHrJCgW0IU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qo5RzbdbXqkZaL5rAkbAj+L+87MiZziTUiDBMj2QQ1SRwzPPW0Kbj71+YOMYaY5L2yW0ATuPI9UvWbpJ8BWxRA+4K25uwc/KCFB2r0ItNoJDXjI7tObmr7fl1DM+O0Jq4p+rIz+hx5LPYvrxOjVf04HCr75zMtUlCeiVYp2MjJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrYmahB0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1E1C4CED2;
	Mon, 27 Jan 2025 04:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737952922;
	bh=7RQPPYx18JlZ50CfItwadjRZng2k8lf+GHrJCgW0IU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qrYmahB0F636L75RgPUrLxwR7KwywZjht6ZMLJWlp1dFhE7Jihu77/xMPP9kRdhpS
	 KHPAsLOQg2T3D/73CbIvksNqop9rM8onqD6VbxwZMVTaXn68kJfRnvoVgVmgbL+sx+
	 K6PY84jZ9c/YVC7vVjOSKnrLa2veVumMr2wasfmvGEE65fgjd/9YZ/qLhQaWhrPJX8
	 PS83Z4BeE7D2PMoZuYswAuZkAJtnNkhhReImAuPUwU30XHAlbwLMU2hJyvPBUehjk7
	 XAHMtm0Sn36T4yaaksKIikH1W83WXXS05LgjjPEYkntwQ6QjEM2l9YFbrfWVXRZp6d
	 llzr4d/cYd1Jg==
Date: Sun, 26 Jan 2025 22:42:01 -0600
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
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
	=?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.neuschaefer@gmx.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Mark Brown <broonie@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH 4/9] dt-bindings: mfd: Convert fsl,mcu-mpc8349emitx
 binding to YAML
Message-ID: <20250127044201.GC3106458-robh@kernel.org>
References: <20250126-ppcyaml-v1-0-50649f51c3dd@posteo.net>
 <20250126-ppcyaml-v1-4-50649f51c3dd@posteo.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250126-ppcyaml-v1-4-50649f51c3dd@posteo.net>

On Sun, Jan 26, 2025 at 07:58:59PM +0100, J. Neuschäfer wrote:
> Convert mcu-mpc8349emitx.txt to YAML and list the compatible strings
> currently in use.
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
>  .../bindings/mfd/fsl,mcu-mpc8349emitx.yaml         | 53 ++++++++++++++++++++++
>  .../bindings/powerpc/fsl/mcu-mpc8349emitx.txt      | 17 -------
>  2 files changed, 53 insertions(+), 17 deletions(-)

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

