Return-Path: <dmaengine+bounces-2124-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BAA8CAFB9
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2024 15:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D7541F2400C
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2024 13:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1CC77112;
	Tue, 21 May 2024 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvvTKk9+"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B617C55783;
	Tue, 21 May 2024 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716299806; cv=none; b=flmjaH/3xB+s93qKFO1N15pBJlzSfZVYfTy6YWAgI3qMSl2DgvtWjtsj0miU/peeYMrMcTCeP19OQ/ETCQuh11IjWkjSZJc+NPsuyf6QDbQB7MJxB1rnlx1yrvgkKrp9iKeUzpAnuUCJ8TLHnpNJn+3maKq+RO2VPiY60axlpHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716299806; c=relaxed/simple;
	bh=FFuwVn68atOvznkRM8++lCl3i72ug2UrS29cE+2NwmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0GVTKA3bIxjdhiGvIFyfuLPEGHxYfEeyNHQFNr89NKt6H9bzAJimZGp+CcihlDbsHQ3EgTUaJDh/IUNLI+Lp2q7QyEu3X+lTyvuv1E4DRCOt/pStxgQuZDeCBnTvg403q3d20vjBsMAysd8JBV+ihFIBE4lZcHqvckeONCbKeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvvTKk9+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6548EC32789;
	Tue, 21 May 2024 13:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716299805;
	bh=FFuwVn68atOvznkRM8++lCl3i72ug2UrS29cE+2NwmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hvvTKk9+EXJ6Xym4d/wioGZbveQE+jqiYi6+83BgzvRAjrOlEjy/8VTvg99BZzXcG
	 vLQWDrOA/TtYCKwFv+Xr/usXS4A0QVbTWd3YWmitKlk24PevlGNNfvrTWR+xuvDmfz
	 2foYtUKL5FTB6kEixCRk7dNSxfYOhK9R8pnWIPMSc3I3uBjDm6puCvAEmSyrPjlrup
	 Ik2jQ5jJ5BokirZLbo8tmDhggE+vD1H5QTT8Ymb0s7LMjLugOdekAvzvA20/YLOnkW
	 AG35d0weG/j63kX6zuARghq6AJPO5EkE+cjmvdX6VEFSVYnsz6iU58QkuO5VaSTtz4
	 yg4jYzjqV83Cw==
Date: Tue, 21 May 2024 08:56:44 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Han Xu <han.xu@nxp.com>,
	Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>,
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/6] dt-bindings: mtd: gpmi-nand: Add
 'fsl,imx8qxp-gpmi-nand' compatible string
Message-ID: <20240521135644.GA3953973-robh@kernel.org>
References: <20240520-gpmi_nand-v2-0-e3017e4c9da5@nxp.com>
 <20240520-gpmi_nand-v2-1-e3017e4c9da5@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520-gpmi_nand-v2-1-e3017e4c9da5@nxp.com>

On Mon, May 20, 2024 at 12:09:12PM -0400, Frank Li wrote:
> Add 'fsl,imx8qxp-gpmi-nand' compatible string and clock-names restriction.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/mtd/gpmi-nand.yaml         | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

