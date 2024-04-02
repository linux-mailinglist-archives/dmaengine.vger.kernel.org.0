Return-Path: <dmaengine+bounces-1708-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DB28957D2
	for <lists+dmaengine@lfdr.de>; Tue,  2 Apr 2024 17:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31C3A1C22AC4
	for <lists+dmaengine@lfdr.de>; Tue,  2 Apr 2024 15:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C2012BF35;
	Tue,  2 Apr 2024 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="y2HhODVm"
X-Original-To: dmaengine@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244E4126F16;
	Tue,  2 Apr 2024 15:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712070558; cv=none; b=saLD5NLwYDbvwSHOld3WH/GDus3scDMHLee8dm7Raz32Y1GgGqpPebFWuseqw8Npd7/dTS7hEsHlbyb0INUJySaT3YmidwUk/1NOKMgb4ECyAVM5xwPctrohj8q8oMC6gNY/Che7gRxXK/QrL/fKm26gC+P5gn+diZvQrfpLFK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712070558; c=relaxed/simple;
	bh=PJX0RXPmLrCAOscox1CDIjMLVnKjUKpETe0dvMyXr9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8qS4oPQD3rPBwrpkvA5Uh281jFjD2P28NtfNuiH3KdxyU9J96m0IDHiZSfSzLK4iPRVNvE/pp3L6dlHJn4jcgZt7ts+ggSiZFnF8gwbLPLoRnUHe3yZbhmbfvptF+OskzIHjohkMS26rG/wxPL1++IjMxr7lNWnFgzp4VGmyQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=y2HhODVm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PJX0RXPmLrCAOscox1CDIjMLVnKjUKpETe0dvMyXr9Y=; b=y2HhODVms292uNiaGByn2Kruci
	uZbo83JYTXSK4SLRt5yV0yZ9FXGpLu7VTihFruwfLzY3gJklPWyVgtwmp02CESnFlpXwZuJXpZixL
	JjTt3mb4+OI09sxlfEfDmQsDXTClzcOlLSFAmD6Ro6xmhfFneuMxeyrNzWydBzKvPWl/EquOjWW72
	oCAhHF7kJi9GzR0y5pQKCsVxUqVko1AchcKISCjtF81VryRb+9NEn8Sr0TyYOQwYOloBAizrcVm6A
	neQeViJZC1Rztn+wfCTekeZPebfeBjIligxO+EN0YzemxfLasrJSh2LeOHm8MBGm1H+0paFjsqWPC
	epZsGdiA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrflA-0000000BkXS-2K3W;
	Tue, 02 Apr 2024 15:09:12 +0000
Date: Tue, 2 Apr 2024 08:09:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: rdunlap@infradead.org, hch@infradead.org, corbet@lwn.net,
	dmaengine@vger.kernel.org, imx@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lizhijian@fujitsu.com, mst@redhat.com
Subject: Re: [PATCH v2 1/1] docs: dma: correct dma_set_mask() sample code
Message-ID: <ZgwfmERghiT-e_x-@infradead.org>
References: <20240401174159.642998-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401174159.642998-1-Frank.Li@nxp.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Jon, do you want to pick this up through the Documentation tree, or
should I take it through the dma-mapping tree?


