Return-Path: <dmaengine+bounces-597-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 834F481B514
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 12:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 226BD1F26131
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 11:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6693D6DCF9;
	Thu, 21 Dec 2023 11:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJjKfMIv"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4426D1A4;
	Thu, 21 Dec 2023 11:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7491AC433C7;
	Thu, 21 Dec 2023 11:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703158835;
	bh=0XVAbyt5Q2EdtCdnVgot+orUzg22qdyuWONYOCaOdvc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EJjKfMIv+lEiqo5m5vpW/rQ70EOUNXbX2Lyc3QilwQXwY+cjKMEek8oJD0ypJ9pzZ
	 0+YC8yJmimS0t+HDpBcAx65cpJ6QC2Y0GPWs+wRAYoPfWHPunk1hf+iQ+CvS1J5ey6
	 hiIz/ea1PaZcIIXaXsIxFMuamU2vuqUISJ8dVXqvlGkjnByx/ajgecqSeOUokKCt2E
	 TP2BmAsJIaIoW0Ld47zRAGl/pZ135pFhycy7N7bAS8AcruycCyRevpTOLA/1bTF0EF
	 y97Yz2wffZPtPoqvXe2MLE89FsxWzie35kqvUH/9SeNTYQnwt/giyfHkAz5vG23+mO
	 mzKPhMMX8Skig==
Date: Thu, 21 Dec 2023 11:40:20 +0000
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
Subject: Re: [PATCH v5 3/8] dmaengine: Add API function
 dmaengine_prep_slave_dma_vec()
Message-ID: <20231221114020.2d1e6364@jic23-huawei>
In-Reply-To: <20231219175009.65482-4-paul@crapouillou.net>
References: <20231219175009.65482-1-paul@crapouillou.net>
	<20231219175009.65482-4-paul@crapouillou.net>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Dec 2023 18:50:04 +0100
Paul Cercueil <paul@crapouillou.net> wrote:

> This function can be used to initiate a scatter-gather DMA transfer,
> where the address and size of each segment is located in one entry of
> the dma_vec array.
> 
> The major difference with dmaengine_prep_slave_sg() is that it supports
> specifying the lengths of each DMA transfer; as trying to override the
> length of the transfer with dmaengine_prep_slave_sg() is a very tedious
> process. The introduction of a new API function is also justified by the
> fact that scatterlists are on their way out.
> 
> Note that dmaengine_prep_interleaved_dma() is not helpful either in that
> case, as it assumes that the address of each segment will be higher than
> the one of the previous segment, which we just cannot guarantee in case
> of a scatter-gather transfer.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

This and the next patch look fine to me as clearly simplify things for
our usecases, but they are really something for the dmaengine maintainers
to comment on.

Jonathan

