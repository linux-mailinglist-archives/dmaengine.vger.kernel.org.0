Return-Path: <dmaengine+bounces-731-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D3E82BE72
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jan 2024 11:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DAE61C2394E
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jan 2024 10:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5992064CE5;
	Fri, 12 Jan 2024 10:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OTc6kLuE"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ACE60B89;
	Fri, 12 Jan 2024 10:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8CE61C000F;
	Fri, 12 Jan 2024 10:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705054607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0K0NkJXHATQCdt6Zs6v3+PLVIU0Q+wxMutthUOuyUe0=;
	b=OTc6kLuE8/j50AyxXkOpTdbycuBdRRsukDgen1EqqVONnMp0PamyOrRuoWRUIED/OYtTEw
	7lkETMD0ixKhcBqNAjH/q0aO8LEJ7usz/0T6/CqFl/jKKnibtxI88c0XjSB0knZL1yMsy4
	0pQ6aNrdW9EBzF87wkoZ7lNQK5KQWfh9qwzn26VoEfVeiE7OykI+AtQuPKiaEYpZgpl7Lp
	yg4MyEJLoXbjJyzj4G3h37iTqwWY7Y1qqfyxUn+Uy1OYxw8EgIGKuqGsoredvq/F2Z+seW
	r0v8UJV84XImt35JzOb6qjErjAXnp2jFnbJBQ7hiBgOWs1fa6EVlq6+Ya4qVCg==
Date: Fri, 12 Jan 2024 11:16:37 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>, Gustavo Pimentel
 <gustavo.pimentel@synopsys.com>, Vinod Koul <vkoul@kernel.org>, Cai Huoqing
 <cai.huoqing@linux.dev>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, Herve Codina
 <herve.codina@bootlin.com>
Subject: Re: [PATCH v6 0/6] Fix support of dw-edma HDMA NATIVE IP in remote
 setup
Message-ID: <20240112111637.01a5ea21@kmaincent-XPS-13-7390>
In-Reply-To: <20231122171242.GA266396@thinkpad>
References: <20231117-b4-feature_hdma_mainline-v6-0-ebf7aa0e40d7@bootlin.com>
	<20231121062629.GA3315@thinkpad>
	<js3qo4i67tdhbbcopvfaav4c7fzhz4tc2nai45rzfmbpq7l3xa@7ac2colelvnz>
	<20231121120828.GC3315@thinkpad>
	<bqtgnsxqmvndog4jtmyy6lnj2cp4kh7c2lcwmjjqbet53vrhhn@i6fc6vxsvbam>
	<20231122171242.GA266396@thinkpad>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Wed, 22 Nov 2023 22:42:42 +0530
Manivannan Sadhasivam <mani@kernel.org> wrote:

> > For all of that you'll need to fix the
> > dw_pcie_edma_find_chip()/dw_pcie_edma_detect() method somehow.
> >=20
> > Alternatively, to keep things simple you can convert the
> > dw_pcie_edma_find_chip()/dw_pcie_edma_detect() methods to just relying
> > on the HDMA settings being fully specified by the low-level drivers.
> >  =20
>=20
> This looks like the best possible solution at the moment. Thanks for the
> insight!
>=20
> I will post the patches together with the HDMA enablement ones.

Hello Manivannan,

What is the status of this series?
Do you want to wait for designware-ep.c to be HDMA compatible before merging
the fixes? Do you expect us to do something? We can't work on the
designware-ep.c driver as we do not have such hardware.
Shouldn't fixes be merged as soon as possible?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

