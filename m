Return-Path: <dmaengine+bounces-2180-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A67CE8CFFD0
	for <lists+dmaengine@lfdr.de>; Mon, 27 May 2024 14:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E0641F226E7
	for <lists+dmaengine@lfdr.de>; Mon, 27 May 2024 12:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2B215E5BB;
	Mon, 27 May 2024 12:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="D/JZ7hcU"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F0415E5B2;
	Mon, 27 May 2024 12:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716812318; cv=none; b=P8Btx8zLR0mhIfZhJJSRP3F8zVl6P3v8ua/bLGk6+XzQECq7LomgVnOPmRk06KXdADiLdFVxdv5UME0NTGME9oCy1aCY0xiYvR6csJ+qk9dWVUkoqfezKzjv+YcpXrpZthCt6DIfeaysAEAZ6zVSfJ/LcUD0axTpWkMfoT2uPXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716812318; c=relaxed/simple;
	bh=+bSXoa7zKm+dP+bwmyOYx5PoNI5Xi9I6uCfiIjbRA/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gOdqs/nt3z0fxD5/rbnIa3t8WCWzerIHeoUDGigHjDvvCOKcA0oKiCBTj9rRi0l8jhDKVOsnEC1to8/gaTDNANcHaRUxc/XvnWICZ3E/vIVmgGKHIUFtw/1wNGCvKNd20rbc8OX2wCJWw3iBry2TPnDPWLnN6ALlkLrOnEWqzpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=D/JZ7hcU; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7F3F1FF809;
	Mon, 27 May 2024 12:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716812314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gJGCBGWt/YnEWyTAuowr4XOvldsHsCCiNE6m/L9+UDA=;
	b=D/JZ7hcUtunEHjGi6W7diX1NPrwkhQsjZ8sibKty0ZOrxXwRRlUIuDQJamLQhcuyaJhNI+
	zNEgkEr/3Owkhq++mI9a9tFiiYwkyHb1NoX9ABbKsMglYebZPqFtHa29d2uFEVD4G75TvJ
	CB30iHLUTZt8/o43W+rqBI4FP75WQkWTgpnOATCTAv74I7pvVoKnx9eLBMDIkvUOc6WWps
	guTLlHtwsEr6JeXO36p8Z/Vf3HduL+W4rTAQrzPKawvHkwb3gUPw3lUQhves5E4bo7iUbC
	6RCFM7zr1B524QVYWKrvfuW6+sswaX2zf0C3Q2pWGOtmIk+DYhunhANE6GndhA==
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
Subject: Re: [PATCH v2 3/6] mtd: rawnand: gpmi: add 'support_edo_timing' in gpmi_devdata
Date: Mon, 27 May 2024 14:18:33 +0200
Message-Id: <20240527121833.178429-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240520-gpmi_nand-v2-3-e3017e4c9da5@nxp.com>
References: 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'88861f37ce6e9e31991e248c7d9d04ae2287b377'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Mon, 2024-05-20 at 16:09:14 UTC, Frank Li wrote:
> Introduce a boolean flag, 'support_edo_timing', within gpmi_devdata to
> simplify the logic check in gpmi_setup_interface(). This is made in
> preparation for adding support for imx8qxp gpmi.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

