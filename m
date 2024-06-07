Return-Path: <dmaengine+bounces-2314-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E486900B87
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jun 2024 19:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 746681C22043
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jun 2024 17:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCBF19B3D2;
	Fri,  7 Jun 2024 17:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KoElxhXg"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4607819924F;
	Fri,  7 Jun 2024 17:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717782441; cv=none; b=C7rLAyzMWX5J60uG9NcyLZE32C/2TWUMMNel8FrzZ8eNheRDNOBoRGg0PmoMb7TkO6unS27iX7trlggohVmkFzFqqRHGKEkuIjoLt0/iblHeA73rOfw9fJSg+xwAWqVkuYdT30Zre51JgZhGhlwB/ziF6ZO8A+QaMkbBtgNFpvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717782441; c=relaxed/simple;
	bh=ByIEJK7RHrQ9tIuMX0t0w4IcM/VAF+vg+df90ADVd2s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GtQpyXMF852c2wY8n9AgJz7N5HNb4cIBc+yz+Wx5CeFMp/1K7kThvyDRWmVbLdisaRkOb/dXyJ8Ix2B6u6byAFQnjjw3zqj1lF51+I3/84h8BFl+qGFKNDLrC/sqZtcQ0kOEUA95cGEUHiZJRkW+wYgnmru0tss5btC5MP7mcOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KoElxhXg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F147EC32786;
	Fri,  7 Jun 2024 17:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717782440;
	bh=ByIEJK7RHrQ9tIuMX0t0w4IcM/VAF+vg+df90ADVd2s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KoElxhXgBNC8L8hyas0bPrJ7kcWuFc71AkdWIJk9uQMYjKAs9m8yoJnMT0RfYzTfc
	 Iy8tAIEHqZKDluStdOUY/hVZlMDMw/YOTSfjA+OfZ4WEsLs8jwykcaz2Stzc2fXeZw
	 PThGWz1rlXBRiRdprcmFm7yM5cGfM4wYe3DL8ltW9ySkivkGPytgXBxHhO0cDCA21d
	 oOH27bXjqMm6T5sl3RLxGX7Qjo3QY4N/As9EU0QsM6LtIIDwF8/iqWjNPWIak1D1eN
	 FODq3wQeKgHqvTquusGxw0NlHQDTeq08wEnTR/2BJ8i0ihSZ1F9LIuiM/pn5KPUbKP
	 BQPqnDDmDVk+g==
From: Vinod Koul <vkoul@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>, 
 Russ Weight <russ.weight@linux.dev>, Lucas Stach <l.stach@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J . Wysocki" <rafael@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Fabio Estevam <festevam@gmail.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, dmaengine@vger.kernel.org, 
 imx@lists.linux.dev, patchwork-lst@pengutronix.de
In-Reply-To: <20240516102532.213874-1-l.stach@pengutronix.de>
References: <20240516102532.213874-1-l.stach@pengutronix.de>
Subject: Re: [PATCH 1/2] firmware: add nowarn variant of
 request_firmware_nowait()
Message-Id: <171778243763.276050.8365914486302926439.b4-ty@kernel.org>
Date: Fri, 07 Jun 2024 23:17:17 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 16 May 2024 12:25:31 +0200, Lucas Stach wrote:
> Device drivers with optional firmware may still want to use the
> asynchronous firmware loading interface. To avoid printing a
> warning into the kernel log when the optional firmware is
> absent, add a nowarn variant of this interface.
> 
> 

Applied, thanks!

[1/2] firmware: add nowarn variant of request_firmware_nowait()
      commit: 11c63e57404e538c5df91f732e5d505860edb660
[2/2] dmaengine: imx-sdma: don't print warning when firmware is absent
      commit: ea00def538eceda618b940fef757f55c1190e327

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


