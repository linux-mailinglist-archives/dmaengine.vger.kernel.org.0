Return-Path: <dmaengine+bounces-2181-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5CB8CFFD5
	for <lists+dmaengine@lfdr.de>; Mon, 27 May 2024 14:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C988F287195
	for <lists+dmaengine@lfdr.de>; Mon, 27 May 2024 12:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DA815E5A2;
	Mon, 27 May 2024 12:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZscDcFbs"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD6915DBCC;
	Mon, 27 May 2024 12:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716812325; cv=none; b=HGTqRMmh36NwqWaW88/eaF7fbBddJ/bHEPKT/puG6hQMV6+gP/ixl0s88TVmwKpWdWGtTNas9QZQsCN0HMozkid7pErt9C1bOm/HEok7jhYAltYbecuQ60cDRwHmBhohYie22bckq+Gk7waDbD87oekjWeMjCo9+3IioPSRfYJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716812325; c=relaxed/simple;
	bh=YSx9MjQ4veYq+NajQfgud5JiELKhT7CPGeCm6tpg7oY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=crU8t8GUQI05PTrsMS3HvLoslfuTrJDKXsrSFU7sRZ9kO0SggvMADUnUwVsqocJ3WiYW/hn3MIDo7HZmdO30MpDMPJcOfhOVS4CN9a/IghGFtxz0DxKFgTNQ55Jer8HRXrmRPrHeGr8FV7f+OX2QG65VFnvopJpMD5BUxlrRpgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZscDcFbs; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7CA5920007;
	Mon, 27 May 2024 12:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716812322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zUfiAG71aXn8LdRaUjhGkzb2gmamEauYl7siNmkQPII=;
	b=ZscDcFbsoCxIlzUzanGm50DEOu5JpbDdy9iNvKULFsmbZ/99wzJbP6FhaAYkJLO8gKnNaG
	IK19K3CEIvSx6XIeiwWMQsTI53hnkcJ3SPt8Peu1PJ0IOoAWgzmKY6EDwnYxB/1CIhoIAo
	E+PWT7Ql8mQerbCeoxS1HbuzBo7P8T1lFl8Bjws7IPqSXpRoJV9Q94HuSE+78YWcqTpRQC
	IwUkDsptHhcSgr1tFDIzKxYtA6f2SkYMLMY7xReggWFycsGErvMLZYNR86W9YuCvEdXiZ2
	jsljHJaKTlFhz5EDkzDPDZV46Or2dwJnRBgO2KA7WHFHMwNjx7b9LoICOv3c+g==
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
Subject: Re: [PATCH v2 1/6] dt-bindings: mtd: gpmi-nand: Add 'fsl,imx8qxp-gpmi-nand' compatible string
Date: Mon, 27 May 2024 14:18:41 +0200
Message-Id: <20240527121841.178486-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240520-gpmi_nand-v2-1-e3017e4c9da5@nxp.com>
References: 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'a25587a7c95063635ed4d92cb6d73c9e3d7babeb'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Mon, 2024-05-20 at 16:09:12 UTC, Frank Li wrote:
> Add 'fsl,imx8qxp-gpmi-nand' compatible string and clock-names restriction.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

