Return-Path: <dmaengine+bounces-2547-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 738C1919F75
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2024 08:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E001C216C6
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2024 06:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD5036139;
	Thu, 27 Jun 2024 06:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="dfzvGqDh"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2232A7484;
	Thu, 27 Jun 2024 06:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719470449; cv=none; b=tmRhmnAtWycisQ3cSkUl2cbza1TOvspGMm51ugGz54cvWs/gtqMuFFeiG994mOKvuLnsEwHylCsN33Og7BPQXrCEswp8nUhAoXQfESilGrjJaUb57dLam8A849BJeJ6FYBlANp2K9AkPKT8lrGY09TYzEOBUqszXn/wydwp1WYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719470449; c=relaxed/simple;
	bh=bJJt0FeM0KbEJPLYk2tCjgBeMwoyVLEpB+8s2fa5LfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSqjiwDzwe8h4bYW6R7MrOt7wibS8j0X7vMa+xgTK7bXQ62V86I4CceQMjNRY82PLpFeFL0AS+6Zt10Z1K+SfjLCGcMF8Bxv6qCtt5HDBQYcQLzsow14AHQDCT17XOKLgc/9QTXTHMJCIBFC8aVVJGUjPIy6BErKVViT53rJyWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=dfzvGqDh; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=4E9CM/5/mBeIexGZwjxuNqelU9W/5r9P19OkUaKlST4=;
	b=dfzvGqDhDzW8CIUfGN8u6wD8w3rvXo2pAA6zlf+rQX4lPDA5QpbZ/I6YFCAH/R
	AtSNZnRznbzJIxQX9GYN1yCEM9d2DlnR33U0XRfkg1QxcmeuHPWSm5pAfp63ZeJY
	YZZj9WZvf9XhghQZl3e5rxftZCaCaIcC0bxl20ZTq6rCI=
Received: from dragon (unknown [114.218.218.47])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDXP5t6Bn1m600aAA--.26605S3;
	Thu, 27 Jun 2024 14:28:12 +0800 (CST)
Date: Thu, 27 Jun 2024 14:28:06 +0800
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
Subject: Re: [PATCH v2 5/6] arm64: dts: imx8-ss-conn: add gpmi nand node
Message-ID: <Zn0GdvvigLqcGXxn@dragon>
References: <20240520-gpmi_nand-v2-0-e3017e4c9da5@nxp.com>
 <20240520-gpmi_nand-v2-5-e3017e4c9da5@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520-gpmi_nand-v2-5-e3017e4c9da5@nxp.com>
X-CM-TRANSID:Ms8vCgDXP5t6Bn1m600aAA--.26605S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUaK0PUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBBILZWZqryB7ewABs6

On Mon, May 20, 2024 at 12:09:16PM -0400, Frank Li wrote:
> Add gpmi nand support.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!


