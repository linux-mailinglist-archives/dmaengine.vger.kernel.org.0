Return-Path: <dmaengine+bounces-782-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78956836CFF
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 18:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10A5628CEB7
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 17:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5EB51C5F;
	Mon, 22 Jan 2024 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oaOU9HWz"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B020651C59;
	Mon, 22 Jan 2024 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705940705; cv=none; b=jCmrT6xm5oE4oYIqkdQYAhNmc3a1ScwUXTD63w7pTfg9gc0vo/ofLYXkpZ+yHkll+CYCbMJSy5l58LsCVDx0o3iYgDaTbcsxEGHPwV+Lxg+Kox5a+vOprySMOedsaBYCl1tnkmrR4n7voCA2pLyY4Fp9IQv0zbQwhIjZ/7eO8+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705940705; c=relaxed/simple;
	bh=pq2HbRb8pwsAXEdocoGWbwiWnNtqz7+Qzp0W5dDoWI8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IyMVC34pv4Q6LXIa0/Br2swRbuER7/DRHdSqslt/kwxbgQGpQrSZJVXkIavMZKucbqKHbVqOLRt5Yk0HxoIkyBoEje9Gzu0dgQ+ja9E+2bvZQamcqUcUepFyGI7P7SnIkV5nF2hS0rSqNRGj5dtDUqRzjRSVxFUrDo5gioHIW9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oaOU9HWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A7DC433F1;
	Mon, 22 Jan 2024 16:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705940705;
	bh=pq2HbRb8pwsAXEdocoGWbwiWnNtqz7+Qzp0W5dDoWI8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oaOU9HWzLPiDtd5MB9Zs6wCWRZuHGujEdyog9MrXHvtmPRw+Kluhgc9+3wuJA9dRH
	 ZgpezJlsIFmhtgzt/ja3alQsP4PcTR1i3AKjJ7LJjPYQRR4CoR8mu6EP4nE7hcMEcs
	 QoN6zMaODCu+6+QhNPinhpBbxEC1kUG1zuNj/t0fb0nQxjO7IHl/oO+ARe/kmpt7lg
	 kBXN5ntc6/nLFCfhbu04WgnemRLN8JxCrvH/bcq5+FifKW3AtwMDo+sOnWvspZRJj2
	 egnCLlDBXH+6d9p31bSGoPhu0zBpenMtitCLg8jXcWdk10yc7WmqsfvB11a96SD70Z
	 S+Fkrj1LH3+2A==
From: Vinod Koul <vkoul@kernel.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, 
 Guanhua Gao <guanhua.gao@nxp.com>, 
 Laurentiu Tudor <laurentiu.tudor@nxp.com>, 
 Ioana Ciornei <ioana.ciornei@nxp.com>, Li Zetao <lizetao1@huawei.com>, 
 Peng Ma <peng.ma@nxp.com>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev
In-Reply-To: <20240118162917.2951450-1-Frank.Li@nxp.com>
References: <20240118162917.2951450-1-Frank.Li@nxp.com>
Subject: Re: [PATCH 1/1] dmaengine: fsl-dpaa2-qdma: Fix the size of dma
 pools
Message-Id: <170594070183.297861.9047867462367435174.b4-ty@kernel.org>
Date: Mon, 22 Jan 2024 21:55:01 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Thu, 18 Jan 2024 11:29:16 -0500, Frank Li wrote:
> In case of long format of qDMA command descriptor, there are one frame
> descriptor, three entries in the frame list and two data entries. So the
> size of dma_pool_create for these three fields should be the same with
> the total size of entries respectively, or the contents may be overwritten
> by the next allocated descriptor.
> 
> 
> [...]

Applied, thanks!

[1/1] dmaengine: fsl-dpaa2-qdma: Fix the size of dma pools
      commit: b73e43dcd7a8be26880ef8ff336053b29e79dbc5

Best regards,
-- 
~Vinod



