Return-Path: <dmaengine+bounces-2451-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89756910E00
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2024 19:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45E27286382
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2024 17:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02E71B3F05;
	Thu, 20 Jun 2024 17:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxwbJctm"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60B51B375A;
	Thu, 20 Jun 2024 17:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718903129; cv=none; b=h77ZpcYfn00VrSsGrHSu0OuF2KkNzfPjLMdXSrO7TbHOpLBWYht7ipDwsy3PyQWcpfw05uCoFeqtwKOFo1mzmxze0Ni2Vb2u/4mFn5lkO+igKsRexoiM7QZT+12S/THxW79zEP4I8/crWda5kguR6CnPMOAdS1oNvLjP+N0oEXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718903129; c=relaxed/simple;
	bh=dEOA48ijsQW6/PEVP2tDx2FHmbFwZ3VWxLbybt5q2Gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+r1YjwaihhvyxFUUXXC9oRjXBAOrhLvI0Gjv+9giV6opBHT8/fvfrjCvUola+PEbbtud+047/ZXX2vQuvEwCFSp8rIP1b6hBpACrCUfZT1Aj1JeGEcm/XLWaapR8KTAaz0XTsOuPquDvOt2/c4stBkRaIQh9cyTbCt5CsWs6x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxwbJctm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F37C32786;
	Thu, 20 Jun 2024 17:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718903129;
	bh=dEOA48ijsQW6/PEVP2tDx2FHmbFwZ3VWxLbybt5q2Gc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sxwbJctmVpQc2cHDrejJwmRLLgiN4/IqvoqHWnjbNTTcfGeWUf120kJOYRM0+b/D8
	 aYzVnvBpcjwsiNJV4vwKU9T8UzfZJ5xbjZkFWtqqapxNJUmbfPiX+lLvLBZWNM/XR4
	 snmtxbaocXFVtbJ+wNaqTSF5Sdyz3Md94Atsi2ClD2lTyWs9feke0eA4lFS2aI3HdU
	 mx7y84Itr0OR06oAcI9xOGeb4MvgRsYtuib57M/REcT0vztdoLGGSnXGUb2oXg7yXP
	 DhTbM1NgGaHRgGhJpo+O1EJWqrwL1HsY60AQWEPtbJk1br8M75OGeFegWRgan6dRgg
	 l+/18t4+nEiew==
Date: Thu, 20 Jun 2024 18:05:22 +0100
From: Lee Jones <lee@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Markus Elfring <Markus.Elfring@web.de>, lkp@intel.com,
	Paul Cercueil <paul@crapouillou.net>,
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
	Julia Lawall <julia.lawall@inria.fr>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [v11 3/7] iio: core: Add new DMABUF interface infrastructure
Message-ID: <20240620170522.GU3029315@google.com>
References: <202406191014.9JAzwRV6-lkp@intel.com>
 <c25aab0d-48f6-4754-b514-d6caf8d51fd1@web.de>
 <ZnRUSaHJhz7XLcKa@matsya>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZnRUSaHJhz7XLcKa@matsya>

On Thu, 20 Jun 2024, Vinod Koul wrote:

> On 20-06-24, 12:45, Markus Elfring wrote:
> > …
> > > All errors (new ones prefixed by >>):
> > >
> > >>> drivers/iio/industrialio-buffer.c:1715:3: error: cannot jump from this goto statement to its label
> > >     1715 |                 goto err_dmabuf_unmap_attachment;
> > …
> > 
> > Which software design options would you like to try out next
> > so that such a questionable compilation error message will be avoided finally?
> 
> The one where all emails from Markus go to dev/null

Play nice please.

  Documentation/process/code-of-conduct.rst

-- 
Lee Jones [李琼斯]

