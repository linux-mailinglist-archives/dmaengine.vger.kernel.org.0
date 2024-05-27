Return-Path: <dmaengine+bounces-2179-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7278CFFCE
	for <lists+dmaengine@lfdr.de>; Mon, 27 May 2024 14:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 631CB287333
	for <lists+dmaengine@lfdr.de>; Mon, 27 May 2024 12:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AC815D5DF;
	Mon, 27 May 2024 12:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NF4Fxnwd"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D5A3C463;
	Mon, 27 May 2024 12:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716812313; cv=none; b=Il0OjHKJ8v+VmIzWJL5ZZL/G8+Y+6pj/7VLCZHkqiEliyVNQPw27WVjTuPBrO6siyFJrEURAV9rhAiuKQzoxycADrAQ4mwu6N6frAi0fwvioeMTkuL5MQAdKyOoxWh95K7jt+e5chdp9D/1R6233TDsZZWOxlswRH7tMpbigIcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716812313; c=relaxed/simple;
	bh=kLOiR/0PJYqKC2emVJKLB6F7L5wjo6KOdESD/0Us3YQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hKifEKmZ10ewR6hMmECpVtlLRz971To1K5RuxhAK6IF0qAzbCiRIN+RwzLVJ89l8PwackfPCxuF64F7mmq22O74AfGWRxNXdFksjiFCZAi46YopTcGPzzguTcqxryEvAwwIq1UUrLC5wSnagERAJFS1HTgQy1qzFTO6tYKodaBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NF4Fxnwd; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 72458FF810;
	Mon, 27 May 2024 12:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716812310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p2Iu865HQOncwOUv89lXf8ydO1Mwrp2c6T2G2xw89jY=;
	b=NF4FxnwdqS2r+FF9nN6B0D7CokJjbAf5Whywftp3k88UuIGMS9CWuyFDwsksh1KzcxV420
	mYIyrp43cK2Hr2kIIIkmjYr4oPe759t2CsmVXuwZvAG2yXFuhjtHIHA9jCBLxh4vhUyAEY
	yDit73LJgpNWaSZozOPlut82blxvk9Q+THeDFQKTk/zA1uIIttWbLPJ3YNll+fmv8f5wYq
	Ya+EKFw9FdvuYBcnnY4UoAIrlmOTnUN0dejWYCltmIqnJ8sF4AkeUQ4GGHSd8GtAQ7BDhZ
	tdeRmZY0g4z+W4fMMpt/huKy5NLGyxtYihFsc3uHqSXJfg3FEpCtaO/1d8BLsA==
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
Subject: Re: [PATCH v2 4/6] mtd: rawnand: gpmi: add iMX8QXP support.
Date: Mon, 27 May 2024 14:18:28 +0200
Message-Id: <20240527121828.178398-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240520-gpmi_nand-v2-4-e3017e4c9da5@nxp.com>
References: 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'b9bf7737de329f7a05ac2f9c1bba664926eed3e8'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Mon, 2024-05-20 at 16:09:15 UTC, Frank Li wrote:
> From: Han Xu <han.xu@nxp.com>
> 
> Add "fsl,imx8qxp-gpmi-nand" compatible string. iMX8QXP gpmi nand is similar
> to iMX7D. But it is using 4 clocks: "gpmi_io", "gpmi_apb", "gpmi_bch" and
> "gpmi_bch_apb".
> 
> Signed-off-by: Han Xu <han.xu@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

