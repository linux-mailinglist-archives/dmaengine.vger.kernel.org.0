Return-Path: <dmaengine+bounces-2446-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1601E910B68
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2024 18:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 468721C2433C
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2024 16:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847DB1B143D;
	Thu, 20 Jun 2024 16:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/vqKjnk"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B021AF68A;
	Thu, 20 Jun 2024 16:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899790; cv=none; b=L0N3qWiHoNgnqv5l51xpjQJrPwcWDmUrZun7Kzp5xKWb0hQyy8ZoJ723xuvMwxooWktfAkKPSdENsl3+V/MORE6/Mf3Ub1gvjgPXhgR6Qx5x08KLtq9AY/4/QndZqPmfAudXoRxIAMiYqNtOwoflWBMzE0oXD43Zr1trstC3yO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899790; c=relaxed/simple;
	bh=XQWFgbT1rILISA7GfD948pyMzLIvF0B1LSVD5WWIYrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MoVPHZcNzYwHxFbhOTBA9kVK25ncNuO5rwrTP41gtJ/104eX9orIW/6T3HR86XYeTxx/5x8XasGrHgnYNc7W8IX1dANgpmoKmiaYtu3jM5EAxb7dWJ3vHI34qGoPBzT6REZQl+Uzl3R9JLGGVhUIb9mIqmsIcOYj4VmB+02v9CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/vqKjnk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5A4C2BD10;
	Thu, 20 Jun 2024 16:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718899789;
	bh=XQWFgbT1rILISA7GfD948pyMzLIvF0B1LSVD5WWIYrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b/vqKjnkHu+L1R4UdBumQWvGZcFgNTl2F9cMHXjtfeby5EBZ06pxIECyEeoI7HNlf
	 IOK34i3IorowljsYyoXsX/yB83rvD9RXoU0LOZ4C4TacZ1YdhNkCzOPP+v2Na6ON8n
	 RNJ7UDIgveeS1ta1aGV3qlfjC6MKsO3VptQGp0Nt1os6xti5YTw94JpNH4Ml57ESh1
	 Adi1p0o/PKimgZcHce23WfypOPqnkwnrFX/RNgBJ5oK0AIKTaIHUfWPrYSG1aly0RT
	 DhriWD6p6OnZn5VmGYVINgUg48uAgRIqk2cibDkEmQxTsySp+zAk3EUYu8e6/BtpN+
	 N08P0hApcNYtA==
Date: Thu, 20 Jun 2024 21:39:45 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: lkp@intel.com, Paul Cercueil <paul@crapouillou.net>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	oe-kbuild-all@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
	linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Julia Lawall <julia.lawall@inria.fr>, Lee Jones <lee@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [v11 3/7] iio: core: Add new DMABUF interface infrastructure
Message-ID: <ZnRUSaHJhz7XLcKa@matsya>
References: <202406191014.9JAzwRV6-lkp@intel.com>
 <c25aab0d-48f6-4754-b514-d6caf8d51fd1@web.de>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c25aab0d-48f6-4754-b514-d6caf8d51fd1@web.de>

On 20-06-24, 12:45, Markus Elfring wrote:
> …
> > All errors (new ones prefixed by >>):
> >
> >>> drivers/iio/industrialio-buffer.c:1715:3: error: cannot jump from this goto statement to its label
> >     1715 |                 goto err_dmabuf_unmap_attachment;
> …
> 
> Which software design options would you like to try out next
> so that such a questionable compilation error message will be avoided finally?

The one where all emails from Markus go to dev/null

-- 
~Vinod

