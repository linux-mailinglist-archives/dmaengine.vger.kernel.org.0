Return-Path: <dmaengine+bounces-2576-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D7891B68E
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2024 07:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D04621F246DB
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2024 05:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A554500C;
	Fri, 28 Jun 2024 05:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L+C4pNvN"
X-Original-To: dmaengine@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5180323775;
	Fri, 28 Jun 2024 05:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719553883; cv=none; b=gn4mEYG9Sg+ScjAHIOnkOYJb5j6Ogw24sv6uacLVYsejvuUXuSwl0wOIIjzvQwWz3ppm2DNLAz8rVL5NjD1EmKSkLS6UjWUgd89Stk6qgFQd3CRtrxGdRyok+EADrtIZnQpSUAEGg+3Dc/VVxPRINW7UzqxWOTLiJLGhJQXXYhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719553883; c=relaxed/simple;
	bh=UwG26qV1qLI4MCsZ+T917xmt7ZsZ35IoJK+u+Dm09BU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LY3h25IJfKwbC+lLz3jIFhfTpC77QYnN64Fi/LDa7JznlDAvHA08VVFGE3n09fhrpsybj0s5uuhrls5i8VkRAbqyXDGaFTeP6qc9eWXVgHVr0Jsp+f4jX7EiRbkM5eI1EbcIZa4M7nnrhMek0ruVioTx3e3d+w28nU3fGU7kOlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L+C4pNvN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UwG26qV1qLI4MCsZ+T917xmt7ZsZ35IoJK+u+Dm09BU=; b=L+C4pNvNdHxAlz2lKuzY4+1C7h
	qkOG6rgZze9D2Zjyn9ykZJEnBSvRGEyDAmMzx28fDfYPJ/5PS9si3qpOpCSN4hXDzKbbpu2Zwewnw
	TnmpWe3Kf/QsXiBActNfgIqxCWCoFRw4br2pHoLRdF+wro+1TlDldnT+kQDrnpJ5BfsD36yudxBVJ
	iuzooyRUYMupSzDeopYIGes+5GjnWSb+0O7cIzv7N/dQ9KzslOCB31KEki/JjS5eimVW9NZRxvxXv
	xBJwl/qceCQKVnaotYmL613iwDLJjUtDqdQECP0Weher/bbo1xUAZj/xKrDtDu7IpJ+qgXem/R0lV
	N4DheEqw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sN4Vz-0000000Cfad-3B4H;
	Fri, 28 Jun 2024 05:51:19 +0000
Date: Thu, 27 Jun 2024 22:51:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: vkoul@kernel.org, andriy.shevchenko@linux.intel.com,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: hsu: Add check for dma_set_max_seg_size in
 hsu_dma_probe()
Message-ID: <Zn5PV3z27uXQBcJ0@infradead.org>
References: <20240626082711.2826915-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626082711.2826915-1-make24@iscas.ac.cn>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 26, 2024 at 04:27:11PM +0800, Ma Ke wrote:
> As the possible failure of the dma_set_max_seg_size(), we should better
> check the return value of the dma_set_max_seg_size().

As I've told you before: no.

We'll remove the return value from dma_set_max_seg_size.

