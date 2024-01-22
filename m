Return-Path: <dmaengine+bounces-774-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 006C3835FDD
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 11:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6479288E38
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 10:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CA03A8E3;
	Mon, 22 Jan 2024 10:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RSnJL8jM"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0033A8C5;
	Mon, 22 Jan 2024 10:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705919904; cv=none; b=OLAjyrmYuVu9Et9x3VUjt74euOcOFE2Q+InQPYM34L3kR27l4Dwji08ZHf+cnUhGzhBpKSwyBIXbiTSEAHSW/XiGXNiQNHrXcynoqIKi1ah+ut+arnqk/u1TNJOHWa2/yOJIOxNEmRn1gXh2MvszS+qwoRTJp3sNQkgIoVPtFq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705919904; c=relaxed/simple;
	bh=4hOX0W11VM0UdC7tEUo4g7mVlLXsU6zP1I89BabWmZI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hrXmXvjDMZKnKzye4HOB5KVpMfMdTCilPPN+/u+CFD8r5hU4K9qWbW+9IV6TyATolV8zSMwdvSjtjyDUyURhS5Jz1Zan06daLBQQ8R1iynFmoyR38UNFJ3neAKOQ+7DK3CnW/VDXzyfj0eZK5o5NXGziYpW3lAJtt2cbJKd+A0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RSnJL8jM; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D39EE1C000A;
	Mon, 22 Jan 2024 10:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705919899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cwtvDDiZVvgrYF8ifmUgl+F8hUZUCOJHlbq4i0YknSQ=;
	b=RSnJL8jMrMlfPGqVzkOk4/kkTJUAHoGNRnFmUAXNApYP0/xoadajZ2CmLVIT+bwUi91TZq
	z0S5FZJD5kM6y8bPqevvM+g71nzBYDlT5S+Nq/W3WS8c0alvS5OyZW3k0X4A+w5aLZz+OY
	1jnRDl+3FI9RTLvlcM5gH/mbwtaKolNE36YkCSyOzYosZD4+/KWdjFP8b16BA9YkkZAxmR
	gps0M5GK0JEyf7S+f4nRCRW1t7DfWwSyeg32r2lYAKvZ9gkZV29FqQdflCWxoJVpuPA8jd
	3x+UtyMvAK3PDreCJ4hNfskxsyxOnI/PLlN4ycTx8JZhZfRA19kGAz/bVhOAxA==
Date: Mon, 22 Jan 2024 11:38:17 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>, Gustavo Pimentel
 <gustavo.pimentel@synopsys.com>, Vinod Koul <vkoul@kernel.org>, Cai Huoqing
 <cai.huoqing@linux.dev>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, Herve Codina
 <herve.codina@bootlin.com>
Subject: Re: [PATCH v6 0/6] Fix support of dw-edma HDMA NATIVE IP in remote
 setup
Message-ID: <20240122113817.7c620c8a@kmaincent-XPS-13-7390>
In-Reply-To: <20240120151340.GA6371@thinkpad>
References: <20231117-b4-feature_hdma_mainline-v6-0-ebf7aa0e40d7@bootlin.com>
	<20231121062629.GA3315@thinkpad>
	<js3qo4i67tdhbbcopvfaav4c7fzhz4tc2nai45rzfmbpq7l3xa@7ac2colelvnz>
	<20231121120828.GC3315@thinkpad>
	<bqtgnsxqmvndog4jtmyy6lnj2cp4kh7c2lcwmjjqbet53vrhhn@i6fc6vxsvbam>
	<20231122171242.GA266396@thinkpad>
	<20240112111637.01a5ea21@kmaincent-XPS-13-7390>
	<20240120151340.GA6371@thinkpad>
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

On Sat, 20 Jan 2024 20:43:40 +0530
Manivannan Sadhasivam <mani@kernel.org> wrote:

> On Fri, Jan 12, 2024 at 11:16:37AM +0100, K=C3=B6ry Maincent wrote:
> > On Wed, 22 Nov 2023 22:42:42 +0530
> > Manivannan Sadhasivam <mani@kernel.org> wrote:
> >  =20
> > > > For all of that you'll need to fix the
> > > > dw_pcie_edma_find_chip()/dw_pcie_edma_detect() method somehow.
> > > >=20
> > > > Alternatively, to keep things simple you can convert the
> > > > dw_pcie_edma_find_chip()/dw_pcie_edma_detect() methods to just rely=
ing
> > > > on the HDMA settings being fully specified by the low-level drivers.
> > > >    =20
> > >=20
> > > This looks like the best possible solution at the moment. Thanks for =
the
> > > insight!
> > >=20
> > > I will post the patches together with the HDMA enablement ones. =20
> >=20
> > Hello Manivannan,
> >=20
> > What is the status of this series?
> > Do you want to wait for designware-ep.c to be HDMA compatible before me=
rging
> > the fixes? Do you expect us to do something? We can't work on the
> > designware-ep.c driver as we do not have such hardware.
> > Shouldn't fixes be merged as soon as possible?
> >  =20
>=20
> I've reviewed all the patches, but I do not merge them. It is upto the
> dmaengine maintainer (Vinod) to merge the patches. Anyway, we are in v6.8
> merge window, so you can rebase on top of v6.8-rc1 once released and post=
 the
> patches.

Ok, thanks! I will do this then!

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

