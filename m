Return-Path: <dmaengine+bounces-2116-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F908CAA92
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2024 11:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B0F2826CB
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2024 09:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A4857C84;
	Tue, 21 May 2024 09:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PKHnP1N0"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5450A47A7C;
	Tue, 21 May 2024 09:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716283065; cv=none; b=Ekrgp1BiaoHmMjHuvMgemQCUc4Ve+W97NOIh6MIrxGUlc+INfjjNzqWTojdwjt/qsbv5HeZe05drP2mCPNpM4jDUvQfchdj1LsWC9FNLvLA784ecS+jXA7Xqxd1Z1qEled1DMMCTgQsXZjrvGLXABVUTa1349vtizU6Qkj/G77Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716283065; c=relaxed/simple;
	bh=IOfFdRjlnQNXbjs952mPqz0TKEhiPYLyL4JdcQuyDd4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TUzoOzmD4EgF8MxTWHPDaIH0+UWdzOYDKquOoCXdGsgomO9CxkiQ6BU1mVz7KuGnb4o7q1X51e9pVeUk66qsMZygwfn+e65VKIhE6hvk02QufIEhKaWqDMYiZb8NbOBzcInncz0IRLM6Y4mgoEjvN+X669UUDIy+wEnzKRYj9+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PKHnP1N0; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2CE276000A;
	Tue, 21 May 2024 09:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716283056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IOfFdRjlnQNXbjs952mPqz0TKEhiPYLyL4JdcQuyDd4=;
	b=PKHnP1N0ne4gLK/u0UUoxvvrwaceXoY/Y1wVqI1fY6d2DfGcSDDjScgD7mBCBcIJ85sJou
	3dRJPRpdUppW+rFUHrzvuU7AVaJgtWIdKtNvuMaAU8NgxdiklOUns6yRHzimfQ7HHBoGbG
	S62NB7srQB8oELp3Yt+Nq0IqRStDUZAucx4IFwefZxcWe6noZeXdNjFWc73NMpbBXlqrG+
	bywiv3Q9wvMBmnpAasdB38ZvCvEJdoJ48PFAA+EJRniqEneJoR+wFnhbgoXIesDm/3bCqQ
	f8NfYl5bvhSfp9XTXeE3GEYU7W7/C4Mzfr6R7NyfpWeqT2pPCoRXCtAzWr0Z+A==
Date: Tue, 21 May 2024 11:17:34 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Han Xu
 <han.xu@nxp.com>, Vinod Koul <vkoul@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@denx.de>, linux-mtd@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/6] mtd: rawnand: gpmi: add 'support_edo_timing' in
 gpmi_devdata
Message-ID: <20240521111734.6002db7a@xps-13>
In-Reply-To: <20240520-gpmi_nand-v2-3-e3017e4c9da5@nxp.com>
References: <20240520-gpmi_nand-v2-0-e3017e4c9da5@nxp.com>
	<20240520-gpmi_nand-v2-3-e3017e4c9da5@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Frank,

Frank.Li@nxp.com wrote on Mon, 20 May 2024 12:09:14 -0400:

> Introduce a boolean flag, 'support_edo_timing', within gpmi_devdata to
> simplify the logic check in gpmi_setup_interface(). This is made in
> preparation for adding support for imx8qxp gpmi.

Excellent idea. I really prefer it compared to the former
implementation.

Thanks,
Miqu=C3=A8l

