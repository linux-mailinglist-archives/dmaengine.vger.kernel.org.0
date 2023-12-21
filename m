Return-Path: <dmaengine+bounces-622-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6886A81BC14
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 17:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2269C286F18
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 16:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77AE58214;
	Thu, 21 Dec 2023 16:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omVtmNY1"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA2B55E73
	for <dmaengine@vger.kernel.org>; Thu, 21 Dec 2023 16:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9046C433C7;
	Thu, 21 Dec 2023 16:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703176223;
	bh=aWaGCmHb4Ao2Cp2e6PuUJGNCwIyfPmtaC909uBi+lgA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=omVtmNY15eX1+USzek0RgShC+9NDNisE0TvNBAl78v7scRWivfszazPf1phBtFDl2
	 B1F9nayMIZ9i6voZfq1VkF2fc626XidZnLZUK8st7yQi0CfxvhEyNaqb9TCfzvNlDc
	 xQHKBH3ElasYiPj1GVKv61vIKv4XTL9b/mLfjfR0GjJq01sxhA+vZYmx+VFpLMhBa+
	 qHO50E1nJNJEQJYHJ4E7xQVxQjFpZPt7bbQg2wv3EnhlYGBd9/zd1MNvwFEGoRCdU0
	 1UmBe8M3X/pezzjo4T9LSNnUcbIOPUTzNrciB5SZk90agq8BH5facItDBww5VWH/Rq
	 5x8iO4bOzEb/g==
From: Vinod Koul <vkoul@kernel.org>
To: Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>, 
 Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Michal Simek <monstr@monstr.eu>, dmaengine@vger.kernel.org
In-Reply-To: <20231130111315.729430-1-miquel.raynal@bootlin.com>
References: <20231130111315.729430-1-miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 0/4] dmaengine: xilinx: Misc (cyclic) transfers
 fixes
Message-Id: <170317622034.683420.139778767815093416.b4-ty@kernel.org>
Date: Thu, 21 Dec 2023 22:00:20 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Thu, 30 Nov 2023 12:13:11 +0100, Miquel Raynal wrote:
> So far all my testing was performed by looping the playback output to
> the recording input and comparing the files using FFTs. Unfortunately,
> when the DMA engine suffers from the same issue on both sides, some
> issues may appear un-noticed. I now have proper hardware to really
> listen to the actual sound, so here are a couple of fixes and
> improvements.
> 
> [...]

Applied, thanks!

[1/4] dmaengine: xilinx: xdma: Fix the count of elapsed periods in cyclic mode
      commit: 26ee018ff6d1c326ac9b9be36513e35870ed09db
[2/4] dmaengine: xilinx: xdma: Clarify the logic between cyclic/sg modes
      commit: 58b61fc75ba901b1fd63c911b31249f36d17e9c4
[3/4] dmaengine: xilinx: xdma: Better handling of the busy variable
      commit: b3072be7f955e56789a0508c18e9870f45cd9a11
[4/4] dmaengine: xilinx: xdma: Add terminate_all/synchronize callbacks
      commit: f5c392d106e7cc58c7705799ef4c36c3b2f60b31

Best regards,
-- 
~Vinod



