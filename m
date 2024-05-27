Return-Path: <dmaengine+bounces-2182-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 792E08CFFD8
	for <lists+dmaengine@lfdr.de>; Mon, 27 May 2024 14:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12600B22D91
	for <lists+dmaengine@lfdr.de>; Mon, 27 May 2024 12:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A29A15ECC2;
	Mon, 27 May 2024 12:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RJ7SrfyP"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCE315DBB7;
	Mon, 27 May 2024 12:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716812327; cv=none; b=q9qZbifH9zbyBEB6aVbAfgT3rgZoZZgrLmOXDp8JCmGrfGCqwI1wu/NzVYvrbi2ghc0V45SXIP28a3SuruyvNCvoh0A/5cS1wVqqOs2ERRDsQkdb91ipf8LcK8wVAjZgKmRxgYWtACyY79YXNEK/XUZ0oj9jmIbH692ePHD6STk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716812327; c=relaxed/simple;
	bh=N3Pd8BDtG4WVjrpGE7/0kTpfr8WPMwenH+v6yM+bY88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hc1gza2oDJfhG1Ho0FITqDJZ1RkiadbZQaOjBysGdWw2aKo30mRRSeIqySpJOCuphi54m0imoWi7BzPvrUSp2uZ8J/1XbpWRpa+OI3dlXknPFN1omSfkwfBHwx0090j7DaDQ146E2JKKSe5u5K9AamiTh7Nc9RogczgwJPK7t3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RJ7SrfyP; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3A1B120004;
	Mon, 27 May 2024 12:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716812318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=94UOc6Wom93RXwChN429/bX0m+mqat4leaCPT/CzIhQ=;
	b=RJ7SrfyPwDv7LlLhgATY7ekp2eNuTnvkSO/t6KBDXdshAci07VITrFb/nfpdxBuIa+XBWE
	HgKo8EGDRgTHlyozBWsJai5fguj9P4tp6UTqkw18J2N+Wg/o+UIBd83MPUGzIluVE/tsfQ
	+aXXACwD6qK9jxMxI5YJc1lUIsehGBc111W3ggQejuwLJRg3tj54Istq7Ht8xNXsi3hqSU
	xW8tUbYMJ8Z8LE6wNrfMPxvsHvH3LBakAKc4t7y4MOFbTQAfTczauxTXYg0Lw61JNnUrzs
	aowpe9sGcJi8dUY6nt/LMWvk1J1nNU+1/zkNs9P0Ycce44JUskzIs++3bFgYHQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Han Xu <han.xu@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Marek Vasut <marex@denx.de>
Cc: linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/6] dt-bindings: dma: fsl-mxs-dma: Add compatible string "fsl,imx8qxp-dma-apbh"
Date: Mon, 27 May 2024 14:18:36 +0200
Message-Id: <20240527121836.178457-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240520-gpmi_nand-v2-2-e3017e4c9da5@nxp.com>
References: 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'ccb5d365ee53b3c79c96c89a0bb179354c37873c'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Mon, 2024-05-20 at 16:09:13 UTC, Frank Li wrote:
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
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

