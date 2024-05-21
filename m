Return-Path: <dmaengine+bounces-2125-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFBD8CAFBD
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2024 15:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 518061C2271F
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2024 13:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3857CF39;
	Tue, 21 May 2024 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCW6osSl"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DF0770E3;
	Tue, 21 May 2024 13:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716299818; cv=none; b=eTG1kzT11UJ3H7QnOHmObgXKA0WA8bfCbTSKAUe68dMaDNvrrLb+ihXrZNefkFuMPg/wCaWaYnbHuyXhsRb/u2Rc9LN2rUe2DSmNubyjJ0Ih74RuFacRLDdRIZwRFdApmGLA3FSvRNM88j0KlueUBlsiJYdjVAdSGzaW42pj6NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716299818; c=relaxed/simple;
	bh=xVshbswY1e7znH1UPTx4SgJIxRng+OL6cql7RES1tjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzIOQQQ0B7e7MsWjI9qOp8diGHfm47WqZCicvi03qWYkZtYnvJtpDk0SeWaqoxpksaZNiNchwjQVbqPTwhlxfLeE8BQtydiSk8X9GyfWNVoHGK3zr+s6ENUHTtUCNLq7e9gxwfQaEPFl2pK6mXZIcOHRylw+d9yAZS3GLcgJcQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCW6osSl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67384C32786;
	Tue, 21 May 2024 13:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716299817;
	bh=xVshbswY1e7znH1UPTx4SgJIxRng+OL6cql7RES1tjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SCW6osSl45u0s6PY3hWxZwq3eDSVjS8M+xeO5IEc8im0M7hvlbh4pn1zbpIlZDD5p
	 fvdSUmLFW7rduHE+VqbXa7qgN75Fem4PRRmrmRg9ftJ/2jCTDCmO9wN1mWKaa1XdmK
	 IyjwZtBku40zbmMOgvItxlVl+tbLU5abhwFW+do2EmE2wvfhtEGgsjIuWtoeTQ2N4t
	 +vb4qnFF0Q3vfKUqFO4SGACfInaN38jdyCFAlwi21TfO5i+CYkxNxf6S/3XsmspJ68
	 OdB38zqqYnznWQuAUw7eHNUyy8b5A9e5qiRY9Rldvz0ixrkluWZ42su2UyFDBegTOa
	 F/9qZWLUVsmHQ==
Date: Tue, 21 May 2024 08:56:56 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Weinberger <richard@nod.at>, Marek Vasut <marex@denx.de>,
	dmaengine@vger.kernel.org, linux-mtd@lists.infradead.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org,
	Han Xu <han.xu@nxp.com>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v2 2/6] dt-bindings: dma: fsl-mxs-dma: Add compatible
 string "fsl,imx8qxp-dma-apbh"
Message-ID: <171629980867.3956813.9155367287615832279.robh@kernel.org>
References: <20240520-gpmi_nand-v2-0-e3017e4c9da5@nxp.com>
 <20240520-gpmi_nand-v2-2-e3017e4c9da5@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520-gpmi_nand-v2-2-e3017e4c9da5@nxp.com>


On Mon, 20 May 2024 12:09:13 -0400, Frank Li wrote:
> Add compatible string "fsl,imx8qxp-dma-apbh". It requires power-domains
> compared with "fsl,imx28-dma-apbh".
> 
> Allow 'power-domains' property because i.MX8DXL i.MX8QM and i.MX8QXP need
> it.
> 
> Keep the same restriction about 'power-domains' for other compatible
> strings.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


