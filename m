Return-Path: <dmaengine+bounces-2600-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDCA91D122
	for <lists+dmaengine@lfdr.de>; Sun, 30 Jun 2024 12:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29813281DD8
	for <lists+dmaengine@lfdr.de>; Sun, 30 Jun 2024 10:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CEF13213C;
	Sun, 30 Jun 2024 10:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mraqjYxf"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258AA1E878;
	Sun, 30 Jun 2024 10:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719743532; cv=none; b=RuoinZRg3KGE4wSX0SdoK3+RMBQUlP8cPeiPpQgZhZN81JyUrD9Mqj4mYeQ9X4GObYzGTUPnbd+R73A/tNOrB3OJh77Xd3A/ucZbwSw33nvc1EoCihSWVpEELgouj5s4VdfQKhN1x4N6Auavk7WZQt5aqoY4pFezsSWOoIuqOqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719743532; c=relaxed/simple;
	bh=gh1JxaEepJgrDqQlb2ujT5dF1NO1oXJ9/fTSjRKekGg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZwTktB6qfUFHngEkPwN8DOkfYiJmPxM2ynWgoBjkB4ZW7o3hqhOhEqOnufWbFJtOzmGp7XCTICBCfam8dTB4F1n4eT6W2Y5Enq1q9aKQBm8X8ePerHEGbW9IlMIrEt07FDU9Yws9qNv48biCvhoWmpq/7a4AmFC8hMxIWWIc8wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mraqjYxf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04529C2BD10;
	Sun, 30 Jun 2024 10:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719743531;
	bh=gh1JxaEepJgrDqQlb2ujT5dF1NO1oXJ9/fTSjRKekGg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mraqjYxfRo+Upk60m5tv7fcpDsMVvTc64ODcth8JmTSp4NYpX19uuUc5hWyqNOGMj
	 fkYy89YIFOvkD1cFbWaeIOEYHDVhhycmnDSIp6zXfAHBOQ+h6yE2/hHRalQJgcOS96
	 hFbu2D/uiP18YiuUB597J/1hjNtJwbbLU0pw4s8ZfsR4f629iVgrC1gh4jDuDsvw7N
	 H5sUsVzuFKPiqlHe4gbDnJZ8BULVaa1mRymkU0cZri2M/KMmio7Bj7iurnpOnPa9Q+
	 7orEYL8kLkhyhf6MfZZUoilaizxXae6FwjVHkESPZMVvkLldwuYYofe1YnN6ATV6Ff
	 lIi9PObMJJP7w==
Date: Sun, 30 Jun 2024 11:32:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Sumit Semwal
 <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Paul Cercueil <paul@crapouillou.net>, Jonathan
 Corbet <corbet@lwn.net>, Nuno Sa <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Subject: Re: (subset) [PATCH v12 0/7] iio: new DMABUF based API v12
Message-ID: <20240630113203.719d1daf@jic23-huawei>
In-Reply-To: <171896438479.273533.11227587889239181030.b4-ty@kernel.org>
References: <20240620122726.41232-1-paul@crapouillou.net>
	<171896438479.273533.11227587889239181030.b4-ty@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jun 2024 15:36:24 +0530
Vinod Koul <vkoul@kernel.org> wrote:

> On Thu, 20 Jun 2024 14:27:19 +0200, Paul Cercueil wrote:
> > Here's the v12 of my patchset that introduces DMABUF support to IIO.
> > 
> > Apart from a small documentation fix, it reverts to using
> > mutex_lock/mutex_unlock in one particular place, which used cleanup
> > GOTOs (which don't play well with scope-managed cleanups).
> > 
> > Changelog:
> > - [3/7]:
> >     - Revert to mutex_lock/mutex_unlock in iio_buffer_attach_dmabuf(),
> >       as it uses cleanup GOTOs
> > - [6/7]:
> >     - "obtained using..." -> "which can be obtained using..."
> > 
> > [...]  
> 
> Applied, thanks!
> 
> [1/7] dmaengine: Add API function dmaengine_prep_peripheral_dma_vec()
>       commit: 5878853fc9389e7d0988d4b465a415cf96fd14fa
> [2/7] dmaengine: dma-axi-dmac: Implement device_prep_peripheral_dma_vec
>       commit: 74609e5686701ed8e8adc3082d15f009e327286d
> [7/7] Documentation: dmaengine: Document new dma_vec API
>       commit: 380afccc2a55e8015adae4266e8beff96ab620be

Merged Vinod's topic branch and applied, 3,4,5,6 to the togreg
branch of iio.git.  Thanks all for the hard work on this one.
Great to finally get there!

Jonathan

p.s. Last few weeks were about some complexities in the IIO tree
unrelated to this set.

> 
> Best regards,


