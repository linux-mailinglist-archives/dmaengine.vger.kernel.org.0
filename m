Return-Path: <dmaengine+bounces-7238-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B717BC67A5B
	for <lists+dmaengine@lfdr.de>; Tue, 18 Nov 2025 07:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EDDF4E2416
	for <lists+dmaengine@lfdr.de>; Tue, 18 Nov 2025 06:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6581271A7C;
	Tue, 18 Nov 2025 06:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gvGwr0Xu"
X-Original-To: dmaengine@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9012D97BF;
	Tue, 18 Nov 2025 06:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763445942; cv=none; b=nosaSzlVk+eCZ/trXSHY7cbpkvKMqo81yw5CpIJRf2ScAJMhVauk7gqMr5J9EPmMQQ8oHFZ1Xw+1F8L7oyoo4m2HRrIeOyul2iaRZ8G2neRvUhoGLay62gOmoNueZAXnBEIxHyfXuvV70T/CDH+MSVo+vkthijO0yfzTAYRjzxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763445942; c=relaxed/simple;
	bh=s9kIzY5NijM4WRIloZ9BzgsUpxjI8De4seMkSUZs1NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=soCcC23Cmy0zd2wu5jM933daymb1iCRlbXzqhPcNBd06E+kGMxJEDACHPdc13jneJrKgRsoGvV7vo8H7CLcev4a6kmU0OMoVnuFzp7yxzKLeF9ggUFZeBrgTJVTwfnk9BzkofEKJnjOIf7tkBEsQIHKEFhgHKRkiIIQ0yl815zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gvGwr0Xu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YvGDpZGJMbiNr7UqZQojlVS9eVMIi1Di1ToMoNoxO7Y=; b=gvGwr0XumFCX9Ha4A9MYWlG1wB
	STQFLS00xVL6qUWGyTZZl9HFv+0VxjAyc0J/EiFiR2ZOTqek+mYRJOpaPntp29CQTM0x6276anifY
	WQLDCzaInADLdBB8IqxKiG1eEugK4xT9CetBKnmE+mpOnSY+VbqMjZai6Y6M1hY6ntJtzxGIEbMDO
	LzKREqWvWGylJuv/3CElN+NKgnAatJZtRt4R/tf49VoNJ2qMQEwhxKKdz8CBXFtDYaYq7cGfwYF5Z
	XOun2RF2RHG1avU8kBZ21x3uWbhh1moqoQKJiHJaNdHxJcjpdrNpRbb44RRo0Yl34jzoJ7m5dmceh
	BsfMkTKw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLEqP-0000000HT95-1pHs;
	Tue, 18 Nov 2025 06:05:37 +0000
Date: Mon, 17 Nov 2025 22:05:37 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kelvin Cao <kelvin.cao@microchip.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	George.Ge@microchip.com, christophe.jaillet@wanadoo.fr,
	hch@infradead.org
Subject: Re: [PATCH v8 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Message-ID: <aRwMsf5Wk9K5jQxo@infradead.org>
References: <20240318163313.236948-1-kelvin.cao@microchip.com>
 <20240318163313.236948-2-kelvin.cao@microchip.com>
 <ZhKPsKFyaXFliJP4@matsya>
 <3baed5bf-8fa1-4ef9-8cb1-58145a6dd37c@deltatee.com>
 <aJopotHoEEbe6ll3@vaman>
 <e759d483-e303-421a-b674-72fd9121750d@deltatee.com>
 <0970f42e-503b-49e8-9450-cf83c476d580@deltatee.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0970f42e-503b-49e8-9450-cf83c476d580@deltatee.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Nov 14, 2025 at 03:28:29PM -0700, Logan Gunthorpe wrote:
> I've sent the patches for this discussion a couple times now over the
> last few months and have not received any response:
> 
> https://lore.kernel.org/dmaengine/20251014192239.4770-1-logang@deltatee.com/T/#t
> 
> Have the patches been getting through?

I see them..


