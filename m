Return-Path: <dmaengine+bounces-5252-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFD2AC14E8
	for <lists+dmaengine@lfdr.de>; Thu, 22 May 2025 21:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AF9C178311
	for <lists+dmaengine@lfdr.de>; Thu, 22 May 2025 19:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D662A2BE7A3;
	Thu, 22 May 2025 19:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BviKpAsn"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DA32BDC3C;
	Thu, 22 May 2025 19:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747942729; cv=none; b=Rsa3ijRzxcIoQUdCxdUqHxuPDYaGEb5Cr20NS9ZtdPBUWnDYfFBf8bPXdUJPagVRDdDTF8ARH47Is0+aT8ICwKLB6EOAw+/KD9/XuZjd+6gjpDhvBmmaoE50vBoynL/6EgPESiSMDjY9lTSo7+To7KXYtlguyGnMYZt9F5VNd7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747942729; c=relaxed/simple;
	bh=YSTV4nrR9BcWNLjnzTxQXJEJv40M/G97zCOIOpydIcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSpegQF8tv7gyvbs5Yf3HXSReA4nY9LJejsy+73WAppg1XITkoUibcHI/212V/XGZMV6r5oEWaHWwOyic6zvTEZVHLt/6CzAC0OQ6TKt3bTA362wsvkiK4jk3kjNWG8smscjS/Tkbd43tTM0+WsTGniy5o9j+kP3uswv/sS9SpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BviKpAsn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE94DC4CEE4;
	Thu, 22 May 2025 19:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747942729;
	bh=YSTV4nrR9BcWNLjnzTxQXJEJv40M/G97zCOIOpydIcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BviKpAsnwN8/wHsxbVtqMWs6NQegDJNvtPqegexaj6V0gEVc8fklKCohTCjDArvDy
	 vd0AbInp8fIIpGKgtNzaj2IztrPLKNlTqseo9nSnQr3iWSSp1vtHxih09JbvLf7/23
	 tqeBqMK0j85D5Wb67Ak3a4bmcGpm/uuW694JJuPefwvQ9WCJWHDMTOz3X8b3e38Bbn
	 9yiIH31hTt1aauy4ns9RjezhCd+zEWkUTB7I2q5lnbRj2dhCeBDjeOXbkpuOKGnyk5
	 OR0+e4+q8JKQ3N12DbWS5XsOZDMA/gpd/ld+slatp1XYMTezM+J0jiwZ0E0xrukcbW
	 7Gny4joijn39Q==
Date: Thu, 22 May 2025 12:38:47 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>, vkoul@kernel.org,
	chenxiang66@hisilicon.com, leon@kernel.org, jgg@nvidia.com,
	alex.williamson@redhat.com, joel.granados@kernel.org,
	iommu@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	Haavard.Skinnemoen@google.com,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/6] fake-dma: add fake dma engine driver
Message-ID: <aC99RzlvdX0rnTNW@bombadil.infradead.org>
References: <20250520223913.3407136-1-mcgrof@kernel.org>
 <20250520223913.3407136-2-mcgrof@kernel.org>
 <e3b98f16-2b9f-4cc1-8a54-29c6dfee918f@arm.com>
 <CGME20250521170724eucas1p28e65ef0ade407ce9e2cfe0b72da26d7a@eucas1p2.samsung.com>
 <aC4IRTo_HBxv9dVN@bombadil.infradead.org>
 <fe97e7ba-85d1-44c7-9de8-2082146f335d@samsung.com>
 <aC9X1VFrRJbH4bYm@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aC9X1VFrRJbH4bYm@bombadil.infradead.org>

On Thu, May 22, 2025 at 09:59:03AM -0700, Luis Chamberlain wrote:
> I'll try the few knobs suggested by Leon to see if that enables it.

That didn't help, but I'm more intruiged by giving the iommufd mocking a
shot, so I'll try that next as I think that will ultimately be cleaner
if possible.

  Luis

