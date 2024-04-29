Return-Path: <dmaengine+bounces-1967-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FD38B5043
	for <lists+dmaengine@lfdr.de>; Mon, 29 Apr 2024 06:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 885221C213BF
	for <lists+dmaengine@lfdr.de>; Mon, 29 Apr 2024 04:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FECEC2;
	Mon, 29 Apr 2024 04:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PlVsHE2z"
X-Original-To: dmaengine@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B370C372;
	Mon, 29 Apr 2024 04:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714365438; cv=none; b=ngY+QUjJ2gvs5XpZqRSJ7Bj44gDGLuMpKmDwCkgV1JudZz2FxvHdeFFfuxK4axi6pbZPwP9+Z5ZODhse8jPDoJp1p/cD/EY3A6niT+ImANPAZjiePH7aHzpOEyxHR1UDlhoYgNJg38Il+osZkCliXOoPVYZxkivuSV18sjcCzxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714365438; c=relaxed/simple;
	bh=Iq5C93cZzgyimtadPEuQvmhAykbbSSQ1qGAE1Le7f1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8MOIlJ/+PrA/X6ddLJhBWL8qW/cOz3fiTVYrAV15uEL6Kldvh1ZeMMsgmIKNqq38jlte6211l1u61H1ydx68fW69Z1JSHUBiYnxal/wEM/Ykm/JhN/kirF1N1lYiKTYQRUL7pxP51wNFKjQk/03W4Ux18L+5FUOdMIuU8uy22I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PlVsHE2z; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Iq5C93cZzgyimtadPEuQvmhAykbbSSQ1qGAE1Le7f1Y=; b=PlVsHE2zXpsd6AWqoVnJSegShd
	Efmslyt9vrWsCnBkWbwj7lvCjkPpmzdg/8cx97iDhC6JasDcuc1NGlIMW15cstXybWcSVpMZohkGE
	/PPFPLJWRN96CJsri05X1X9Mw17npUi4Q4WRi5RmKVVRfhRhzRrsPVb8hTiCfykGZ05S1rYA878fy
	3vmgERgnxLNTnXZFTfdBFjUVmlsgmWef0Fbr375fEwQWRAzekBngd9uMJeVdZFnFSUzgxWfuLy/Y4
	4J4Gq5dPTBteBLea/PhpmKma3Cs8tT8Jd0fuo/OyZ42YuFSMPnlol74eWw1vrLhPZ8wt1GWUy58xf
	zdhm1iMg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1IlQ-00000001Qfn-0JWj;
	Mon, 29 Apr 2024 04:37:16 +0000
Date: Sun, 28 Apr 2024 21:37:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: vkoul@kernel.org, florian.fainelli@broadcom.com, rjui@broadcom.com,
	sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	dmaengine@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: bcm2835-dma: Add check for
 dma_set_max_seg_size
Message-ID: <Zi8j_KCUW5NYf20a@infradead.org>
References: <20240429041312.2150441-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429041312.2150441-1-nichen@iscas.ac.cn>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Apr 29, 2024 at 12:13:12PM +0800, Chen Ni wrote:
> Add check for the return value of dma_set_max_seg_size() and return
> the error if it fails in order to catch the error.

Ok. this looks like you're looking t all dma_set_max_seg_size callers?
If so mybe just work on removing the return value instead..


