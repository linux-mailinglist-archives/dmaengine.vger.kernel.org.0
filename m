Return-Path: <dmaengine+bounces-7642-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D8CCC16EA
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 09:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E049D3064DC4
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 07:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F414B1FC0ED;
	Tue, 16 Dec 2025 07:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kQo0H+UM"
X-Original-To: dmaengine@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D634832D440
	for <dmaengine@vger.kernel.org>; Tue, 16 Dec 2025 07:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765871705; cv=none; b=dm/eEMPf09ZBK/bJJLE4oEbAvTfcSDKBi1GS8rctY37s8XddoPNv4ueQHDZGln+0jI0iP00rQ2ZGP207u52H1A+pN363wbRXHYGuRKxMm+A0jNsbR1z9VDSDzA7h9VRljzZruEpqeNL8V2tRfndDBmiNsZUE/BuTdhSv7eG59A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765871705; c=relaxed/simple;
	bh=WLSVqasYiJTVyin6HRxLxdxum8ueE9wAziy3TUoPrdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrBcoV/GoKbpVVze4NIyHPeHUSw7sqECDCn7Mxb0XiPdovckrmbyCiqPzcpEMVc+lP8+XmzzILcvv5ATbC38JJvRFc7Ct+vpRzMI+f3CjB9cKee7+Tbwpk7evonxOdjua49O5B63v3lkrs3DrLJYHYHdkE3gWgpL4N4RFTVbjyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kQo0H+UM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2BHX70gh7pB5E0m+whMnbHJ2VXB0+k9OykglcNKjY3Q=; b=kQo0H+UM6meA1Pi340i7wpz8h6
	TIpolmZkiqw+eQUHebyXxqt5KR5HaY1eq+fD4zKzq9FxLp786OsGY7ZTntYoKwrK86yFV4kG0+SPP
	fKCGzM2mar4WZtm2Ea5vmbgCXZe5drGHwxEQAEkivWGkkhudu32xE0uYPE+rKAD/rAhHnNTNHgCOz
	YHmkosKTrk1g8WURg/Y0KDqw18OxPgoXdwOVvZELz5PxZoVfq95ENHx2QSzTA9NHnB9Wb+XyAmQxW
	5QSZJ5l4hlHqzjW2uZXIZ5Wm9DlctIbezQCadKSBapCVzqpzAP3QArUiDEzgySetmYkPRD5fkze0Q
	08HJ3zuA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVPtd-00000004sja-00Hy;
	Tue, 16 Dec 2025 07:55:01 +0000
Date: Mon, 15 Dec 2025 23:55:00 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Kelvin Cao <kelvin.cao@microchip.com>,
	George Ge <George.Ge@microchip.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v11 0/3] Switchtec Switch DMA Engine Driver
Message-ID: <aUEQVKhY9U6Y4x4A@infradead.org>
References: <20251215181649.2605-1-logang@deltatee.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215181649.2605-1-logang@deltatee.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Dec 15, 2025 at 11:16:46AM -0700, Logan Gunthorpe wrote:
> This is v11 of the Switchtec Switch DMA Engine Driver. We sent v10 in the
> previous cycle with almost no feedback.
> 
> To reiterate the response to the feedback we keep getting: virt-dma in
> not appropriate for this driver because the hardware has a submission
> queue itself. There's no sense adding a software queue when entries can
> just be placed on the hardware queue. This is the same as similar dma
> engine drivers which came before it: ioat and plx.
> 
> The patchset has been rebased on v6.19-rc1.

This still looks good to me.


