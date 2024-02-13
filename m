Return-Path: <dmaengine+bounces-1003-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 840DB852857
	for <lists+dmaengine@lfdr.de>; Tue, 13 Feb 2024 06:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E4D4B23F18
	for <lists+dmaengine@lfdr.de>; Tue, 13 Feb 2024 05:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C68A11CBC;
	Tue, 13 Feb 2024 05:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c4tAPbEt"
X-Original-To: dmaengine@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D61E11C8B;
	Tue, 13 Feb 2024 05:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707803071; cv=none; b=IcWJkSfzutZfUMEBrJDOkp6OijXy7qAvWrEIxv0IckneKa/ES1YFECD8uKPFD52kAYe3i2UOGisTUywc/fmKYY9DPcL5gSHQIQg3NF+OoTcbj9pWjn1/8cGk7mfDcVBE5S1pOwiGFrmoc+oQyok/T9fiRMK6FLUYff8XD1yJIOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707803071; c=relaxed/simple;
	bh=cl3wM9JQtOsfJgJiFykhtZhE4IN1J0k8y7c96/QMmUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcw19qsJLrtgBRNFZnqPL7BMzj3dj8y9M+HQes8mT+2igUa90JNujzy86ONes8JDKxwusB0P/+H9m/H99P/JcHIgt4RoKxnh5Cqz4F2rn9m+kyvs8+Ao0yDxb9nBIvNaj4THyoOZYv0TJrpgXQiEtcEeFt1Tr9IdsGFaqHODbes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c4tAPbEt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6zOF46KNE97lU9F+sBCtzMg//jibcItPS5IMSb0rFSs=; b=c4tAPbEtIAXOdVwYebn/kXl0O+
	ru630jepLoYTEtmCgL1hk7D08PPA7FKsFokN5+pHF4E/mZEACM8wzdSXzRwWclKjZBBL5+68mDFhv
	LffmoWapqxvmiNlvzrrFZOuvJp+p7AqdGVvc8YfS+shRSyOIpmgbiyip4bBV1XSaPsr7ae0NPY+zG
	Ci0sinqYtfYQR6KJU79DwGE8llTXMY+YmeRH5RrYUBdcDahhcNy9D34CAuKTrh2f3b0ZFWyuudOEK
	jRO1liDvXjVcvFWc2kBI2nRVBSY97gFJHPm/wGsvwmg5a+xivd6UKtkGhIyYW0T4DKsglYhykUVAz
	f0+6SVeA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZlak-000000081f6-0WCc;
	Tue, 13 Feb 2024 05:44:26 +0000
Date: Mon, 12 Feb 2024 21:44:26 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Kelvin Cao <kelvin.cao@microchip.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, logang@deltatee.com,
	George.Ge@microchip.com, christophe.jaillet@wanadoo.fr,
	hch@infradead.org
Subject: Re: [PATCH v7 0/1] Switchtec Switch DMA Engine Driver
Message-ID: <ZcsButDIoe0AjiuD@infradead.org>
References: <20231011220009.206201-1-kelvin.cao@microchip.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011220009.206201-1-kelvin.cao@microchip.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 11, 2023 at 03:00:08PM -0700, Kelvin Cao wrote:
> Hi,
>  
> This is v7 of the Switchtec Switch DMA Engine Driver, incorporating
> changes for the v2/v3/v4/v5/v6 review comments.

DMA engine maintainers: what is blocking the mege of this driver?


