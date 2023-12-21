Return-Path: <dmaengine+bounces-595-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B554681B4E4
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 12:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E76E51C2215C
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 11:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972116BB3B;
	Thu, 21 Dec 2023 11:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzDgUtMI"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE34697A6;
	Thu, 21 Dec 2023 11:28:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D01C433C8;
	Thu, 21 Dec 2023 11:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703158138;
	bh=bn5TsZbZFAMzqugkbLLCAXDLCBCCddsOuTyKJNmW4j0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XzDgUtMIiyHvWufYrnuorriuX6ec0aKd75XvN4bvVRUU8h7RRq//v3hQxVZeIn26t
	 DUfgKuHgBaG/HJamZr9h39OxZ2rPlqxn7ZQqwV8EbzYwFCvU6c/vR6aRYx1pngrWtm
	 beBI35fawoXFmrakG6xJcSGxsszgy8mcmHJ2+25ZF+yJ7maIwhGu3MA2UGW3o0nQpm
	 aLdOCtkcZ/FwpFUOsjWQBplirFA+rE0UXR7Z3lfqSiubbMx7FCsZ+vgu9IiqlwgUST
	 YXW3Wg0+Xnf+lU3O0oRcaCI6LSrpv75aXN2tKalbPE6Aoxqmo9R9hGBBcGr+Wbymf7
	 sCwalRVuuimSg==
Date: Thu, 21 Dec 2023 11:28:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Sumit Semwal
 <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Vinod Koul <vkoul@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>, Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v5 1/8] iio: buffer-dma: Get rid of outgoing queue
Message-ID: <20231221112841.1de85482@jic23-huawei>
In-Reply-To: <20231219175009.65482-2-paul@crapouillou.net>
References: <20231219175009.65482-1-paul@crapouillou.net>
	<20231219175009.65482-2-paul@crapouillou.net>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Dec 2023 18:50:02 +0100
Paul Cercueil <paul@crapouillou.net> wrote:

> The buffer-dma code was using two queues, incoming and outgoing, to
> manage the state of the blocks in use.
> 
> While this totally works, it adds some complexity to the code,
> especially since the code only manages 2 blocks. It is much easier to
> just check each block's state manually, and keep a counter for the next
> block to dequeue.
> 
> Since the new DMABUF based API wouldn't use the outgoing queue anyway,
> getting rid of it now makes the upcoming changes simpler.
> 
> With this change, the IIO_BLOCK_STATE_DEQUEUED is now useless, and can
> be removed.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> 

I've applied this in interests in reducing the outstanding set of patches
and because it stands fine as on its own.

Applied to the togreg branch of iio.git and pushed out as testing.
Note this is now almost certainly 6.9 material given timing.

Jonathan

