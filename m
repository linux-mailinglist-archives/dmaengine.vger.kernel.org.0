Return-Path: <dmaengine+bounces-619-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3727281BC0C
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 17:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71DF11C23BCE
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 16:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFFA62809;
	Thu, 21 Dec 2023 16:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1HrzvHW"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4250B59917;
	Thu, 21 Dec 2023 16:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A3FC433CA;
	Thu, 21 Dec 2023 16:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703176214;
	bh=A57ukB5dDklEZ9q0kgCWQa6lMi3LSmaS7YQSckNb91Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=P1HrzvHWzb/+3jULyDf6W9QWJPsgKr5LDrGbm1XLEwRz9R0015HLoNtLisFIoKRT+
	 u753KdaTa2kMDgpHg6AoYVyShNVOVH5p4/+UySAFwdFBjH26xRMrhpbxM59i1E8/ZE
	 6ty2JTBNAxxjWl9m49KGmFtREZZ5hxgj4t2aymcYH5nE1tWSwJqU6IVEeOnBAhUNZR
	 jben7mscQwQWRFleCIIsDt5E7syQP9KIMeFJE2Tcuv/HIDTK+90x6kunvYqzR/+kdO
	 Kc9nssCHoC60gPXLhc+sKTjYmw6f5gXLwxbyKYjgz+GNg0/eUzV4ED7aJHpcOKZ3dN
	 3a7MM7miVPoSA==
From: Vinod Koul <vkoul@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>, 
 Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: linux-stm32@st-md-mailman.stormreply.com, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20231213160452.2598073-1-amelie.delaunay@foss.st.com>
References: <20231213160452.2598073-1-amelie.delaunay@foss.st.com>
Subject: Re: [PATCH] dmaengine: fix NULL pointer in channel unregistration
 function
Message-Id: <170317621281.683420.8268114839792721931.b4-ty@kernel.org>
Date: Thu, 21 Dec 2023 22:00:12 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Wed, 13 Dec 2023 17:04:52 +0100, Amelie Delaunay wrote:
> __dma_async_device_channel_register() can fail. In case of failure,
> chan->local is freed (with free_percpu()), and chan->local is nullified.
> When dma_async_device_unregister() is called (because of managed API or
> intentionally by DMA controller driver), channels are unconditionally
> unregistered, leading to this NULL pointer:
> [    1.318693] Unable to handle kernel NULL pointer dereference at virtual address 00000000000000d0
> [...]
> [    1.484499] Call trace:
> [    1.486930]  device_del+0x40/0x394
> [    1.490314]  device_unregister+0x20/0x7c
> [    1.494220]  __dma_async_device_channel_unregister+0x68/0xc0
> 
> [...]

Applied, thanks!

[1/1] dmaengine: fix NULL pointer in channel unregistration function
      commit: f5c24d94512f1b288262beda4d3dcb9629222fc7

Best regards,
-- 
~Vinod



