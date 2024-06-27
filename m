Return-Path: <dmaengine+bounces-2546-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5980F919F48
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2024 08:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8786F1C219FB
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2024 06:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8136728DC3;
	Thu, 27 Jun 2024 06:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="GYRR4Fqz"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F1620B33;
	Thu, 27 Jun 2024 06:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719469774; cv=none; b=DLCR4Qh5Sg8vIYEdZSmCZrEYy0uoB9e1WY6McorvJet8oZJO14nOKXmlFId2FFGV5y9BpoZRqI8rdJh/RBmXTyHSB5yLE3H0gydt/ASUEjrLKhC82H5sXEKxiSMOM60wEuA6nTZEHWYgmI4hXu64/3YtDuBAoJc0/ir7kbLjExs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719469774; c=relaxed/simple;
	bh=wHiwBzg0drLuXMvAPru+bat178YvBZzqVOLmGt0Zl6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GpZA3MfaWJVMYjPDRqyaBNxEWjMApXIaYYH0/eZ7J0fWVOLQApImOqBjQ+G/mn8hjR51w309veyDCe42y4kKfgyGyhkwnCoGICbTaUlPAuinohuWKu/ao4APH+Vv1p6sSkt0m3rtGGPAniYJ7L/4GSVJ3nxc5tqEtJ0Igin+2jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=GYRR4Fqz; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=4JVbwBMrJBsF2RiES/eofL7TJIZJsypozKg6acb8498=;
	b=GYRR4FqzDkNp1v7oDKqNrfn9aTuYTBcS9pYvjMeIJk0GfmCpOvdr9diNXmUFDF
	tJS8yBHis8oy2IxK4vyninFJi+/AAlhZ4jJvsiDlc9840Rlmwl9VrAr6IFENjVEE
	iM5l9zBkUZJ9GJ+RB1iq8DZjfvoWQQxAPZm+3JpxUx3gw=
Received: from dragon (unknown [114.218.218.47])
	by gzsmtp3 (Coremail) with SMTP id M88vCgD3vx6aBn1m1VYZAA--.51586S3;
	Thu, 27 Jun 2024 14:28:44 +0800 (CST)
Date: Thu, 27 Jun 2024 14:28:41 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Han Xu <han.xu@nxp.com>,
	Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>,
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 6/6] arm64: dts: imx8dxl-ss-conn: add gpmi nand
Message-ID: <Zn0GmUVgk1Plj5mA@dragon>
References: <20240520-gpmi_nand-v2-0-e3017e4c9da5@nxp.com>
 <20240520-gpmi_nand-v2-6-e3017e4c9da5@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520-gpmi_nand-v2-6-e3017e4c9da5@nxp.com>
X-CM-TRANSID:M88vCgD3vx6aBn1m1VYZAA--.51586S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVaZXUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCRwLZWZv-cwmbAAAsJ

On Mon, May 20, 2024 at 12:09:17PM -0400, Frank Li wrote:
> Update gpmi nand and dma_apbh interrupt number for imx8dxl.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!


