Return-Path: <dmaengine+bounces-596-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C5981B4F1
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 12:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC87DB220E6
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 11:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F59A6BB57;
	Thu, 21 Dec 2023 11:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHdEaDtj"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2387E6A029;
	Thu, 21 Dec 2023 11:31:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39B1C433C7;
	Thu, 21 Dec 2023 11:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703158314;
	bh=Cpk+5UE2MMyOzEMOhTnWvY78nmuIRHA/4H9/WiQCvN8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NHdEaDtjTfH4nlGctu3s2hkp5HN7vvBI+QRZgUpTDFpK5xoz9BFpT54dbd51uIFnk
	 w+YWZ3v0BsMDcG1WyB1Jp5xQj3QPe0h0jY8nmkoqxlwJ1RZWbcb6PbxUAqpCPGPjDL
	 Kyh1cCCSSgbKjdIHj3n84ydRiW3QYsijTcoWOMd2dfkCetwRUFkGAFzawWpwWLaOLz
	 a0f8SJodbsS7kURzc1Qx0edRDgVsKYrMaNmI8bhEGXXgSLAGxziAOs1BtO8Tk9Cx6W
	 3NbqzVlbocmMvx+6KiJ3zPADUE+6TwlQ03bFKOq4K/hYnUh/Cr+AXZC5fB2hhKMwto
	 m9ZXscrXA3bRg==
Date: Thu, 21 Dec 2023 11:31:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Sumit Semwal
 <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Vinod Koul <vkoul@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>, Alexandru Ardelean
 <ardeleanalex@gmail.com>
Subject: Re: [PATCH v5 2/8] iio: buffer-dma: split
 iio_dma_buffer_fileio_free() function
Message-ID: <20231221113137.39911d64@jic23-huawei>
In-Reply-To: <20231219175009.65482-3-paul@crapouillou.net>
References: <20231219175009.65482-1-paul@crapouillou.net>
	<20231219175009.65482-3-paul@crapouillou.net>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Dec 2023 18:50:03 +0100
Paul Cercueil <paul@crapouillou.net> wrote:

> From: Alexandru Ardelean <alexandru.ardelean@analog.com>
> 
> This change splits the logic into a separate function, which will be
> re-used later.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> Cc: Alexandru Ardelean <ardeleanalex@gmail.com>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Harmless refactor so I'm fine taking this now to reduce noise on any
v6

Applied

Jonathan

