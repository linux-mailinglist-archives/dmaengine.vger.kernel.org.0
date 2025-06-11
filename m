Return-Path: <dmaengine+bounces-5345-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AB0AD4E21
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 10:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DB6C169C1D
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 08:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02241239E91;
	Wed, 11 Jun 2025 08:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wue7G2fm"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7521239E63;
	Wed, 11 Jun 2025 08:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749629992; cv=none; b=olAc2sPANtEV7rBDl2ogACO+RX6GqKE+41jx4lf1iDOXB86dVq/WcgyRzey0lg5A15qLr9kMZK54qtzAlFxderYNJmmwOVqtJEz4DIBsDN2c32+nmG9mijglKu0WtPPHHUVj1wb4pmPxqZa0QgxL/41Grj7gT2zzdCfQoPMRbts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749629992; c=relaxed/simple;
	bh=LpOR7XcZXmzmGcfztdnzKluFpCfBqLJIBXVMouaN4m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8ecI3XGexZr6Z7s6PEP13zrRFPURF2YczZFFvLdlOG2xvLC5bJoMFGEidM5PdSwtVvXMp5jkJaAs0W5HHCa0VLCIFZzutqAcqG7+T4OFKpLcTFed5u9lFB4rse25lo5oV51Ezp9BNPTF0MrMZdDui1PXo4P7lL3j1K56SDiPVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wue7G2fm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFE7C4CEEE;
	Wed, 11 Jun 2025 08:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749629992;
	bh=LpOR7XcZXmzmGcfztdnzKluFpCfBqLJIBXVMouaN4m0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wue7G2fmsOdwpcBRX6+SWN21s+ZcCtwgSVV1Bgxb9qU0AaBwKNJIBfKyBnEkzmXcc
	 aGk4y/C0550irUJigcNd5MbdfRVJQPeWsYXlvPObTmR70E+rn1/dvCrqFUNx9b6CHD
	 d4SoNoyPtkNhMP+/pWk+SIfqrSNoyAtmNk7ta2JNzlINGSIhDb7dxdDPQtq5PREY4A
	 JxlnXKQCZuTigmoU87oXk6S7VS2Zfl5rIwJXN+0RyG/W9G1vlLCxEaocIyb7wDqF2y
	 cvTA/LTSeczdZ4GIwGxG4ufCvwjq5Z0JHEnKzsoqjwl2vTcbLOcZ5Rqr8fKlNBQ+9s
	 Z0BsJu0nq+Uug==
Date: Wed, 11 Jun 2025 10:19:49 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Vinod Koul <vkoul@kernel.org>, 
	Alexander Sverdlin <alexander.sverdlin@gmail.com>, Yu Yuan <yu.yuan@sjtu.edu.cn>, Ze Huang <huangze@whut.edu.cn>, 
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>, Junhui Liu <junhui.liu@pigmoral.tech>, 
	devicetree@vger.kernel.org, sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, dmaengine@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: reset: sophgo: Add CV1800B support
Message-ID: <20250611-brown-turtle-of-election-87c324@kuoka>
References: <20250611075321.1160973-1-inochiama@gmail.com>
 <20250611075321.1160973-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250611075321.1160973-2-inochiama@gmail.com>

On Wed, Jun 11, 2025 at 03:53:15PM GMT, Inochi Amaoto wrote:
> Add bindings for the reset generator on the SOPHGO CV1800B
> RISC-V SoC.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/reset/sophgo,sg2042-reset.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/reset/sophgo,sg2042-reset.yaml b/Documentation/devicetree/bindings/reset/sophgo,sg2042-reset.yaml
> index 1d1b84575960..bd8dfa998939 100644
> --- a/Documentation/devicetree/bindings/reset/sophgo,sg2042-reset.yaml
> +++ b/Documentation/devicetree/bindings/reset/sophgo,sg2042-reset.yaml
> @@ -17,6 +17,7 @@ properties:
>                - sophgo,sg2044-reset
>            - const: sophgo,sg2042-reset
>        - const: sophgo,sg2042-reset
> +      - const: sophgo,cv1800b-reset

Keep alphabetical order. That's enum with previous entry, btw.

Best regards,
Krzysztof


