Return-Path: <dmaengine+bounces-2470-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9D29111EE
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2024 21:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBF67281D36
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2024 19:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CB21BA06F;
	Thu, 20 Jun 2024 19:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYUPkiBR"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87671B47C1;
	Thu, 20 Jun 2024 19:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718910873; cv=none; b=q9/VaZ3zxJUjeAg4wdSkB6Y/kI6iQzgIqobOxnsQeppOK/hwmgj077GXBxgXOLMokF+/buCxbsQPj1MjS/hjy107UmZe31gSYJMgDVB9H2fIUatmh5rwzwU0CVbacNPC6wM0aGF5S1gbqPTgBE78PqKKoy5cxaUm/BOhw0MKj6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718910873; c=relaxed/simple;
	bh=bjhFvNWi5TsvQnfmtqUqpLdLlMq0YUpUWHuLtvckbn4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fJuQXp7a6CheLuWZ7EWo3nOkaWRfszfDOx7O3RFnL6Bzr8INsozQEXQn6lETpsJZHzW2kXIiwB7d9usz2H4640Lfdz/1VDyJ1RirnPQ92SEyiZS7XX7ScFj1oeFM0CgV9Vs8puVhxRD+tloSmyaQFvf+E9re5xDgm6pur+PRMTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYUPkiBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9539AC4AF10;
	Thu, 20 Jun 2024 19:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718910872;
	bh=bjhFvNWi5TsvQnfmtqUqpLdLlMq0YUpUWHuLtvckbn4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZYUPkiBRn0UHJaSaMjoznC1HWpr24AlPSJPIZygqUCrs1sksNt6azm8wGush54FXl
	 MmlS8JJP2e+UmdBUqrKYrQdaL05dTbjCcDloZ6h7gK08fEnVCVbLuzVabF8Nw5Zcyl
	 tWJGZde5J5KZkIEEPIHKOdpNkfvz2Vz4ncziWv4FfWDVrzfuwiSfd3MR3RprjWR7VI
	 iMhGn/vljPQvtF0zSl+s5aV+hXn1DMFKvP2PO+DyAL19sI0UUXMLq68be52bo8FKWI
	 ms0zxNnhUxdAhcyv8XD3lNzT8tgZzWG3R2RfF+EfzuyuYoUyW02Fj5XD0z2JHWuNeI
	 I2OEpzrkVVe7Q==
Date: Thu, 20 Jun 2024 20:14:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Paul Cercueil <paul@crapouillou.net>, Lars-Peter Clausen
 <lars@metafoo.de>, Sumit Semwal <sumit.semwal@linaro.org>, Christian
 =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Jonathan Corbet
 <corbet@lwn.net>, Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v12 0/7] iio: new DMABUF based API v12
Message-ID: <20240620201425.1cbcb5f1@jic23-huawei>
In-Reply-To: <20240620201150.72c11599@jic23-huawei>
References: <20240620122726.41232-1-paul@crapouillou.net>
	<ZnRW2axOg7gtKzz0@matsya>
	<20240620201150.72c11599@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jun 2024 20:11:50 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 20 Jun 2024 21:50:41 +0530
> Vinod Koul <vkoul@kernel.org> wrote:
> 
> > On 20-06-24, 14:27, Paul Cercueil wrote:  
> > > Hi Jonathan,    
> > 
> > Hey Jonathan,
> > 
> > Assuming we are fine with this series, how would you like to proceed.
> > Would you be fine with me picking the dmaengine bits and providing a
> > signed tag for you to pull?
> >   
> 
> Hi Vinod,
> 
> Yes. That will work nicely.
> From my side it all looks good.

Just to make sure we are on the same page, based on a clean rc1
so I just get the parts of this series (hopefully there aren't
an necessary precursors!) 

J
> 
> Thanks,
> 
> Jonathan
> 
> 


