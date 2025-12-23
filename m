Return-Path: <dmaengine+bounces-7886-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B48CD91FD
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 12:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 144D7309C068
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 11:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8197D33345E;
	Tue, 23 Dec 2025 11:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiN9IjNa"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5B1333440;
	Tue, 23 Dec 2025 11:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766489321; cv=none; b=Tabk3f3enZ3eeFzHzgBDfXSg427PuuiIDGjWoxA9LDswJbpeeeqxFs0LRCe1xF3iMILcEeiFc72pwZGxaGBv12JQ93jld6UztgsrrN5Jo2u8QTXp/UZHJUswSauG23nCrwZo8eA3j9HvojctVjrlPiTanjIZZxW7rgaZ7a938H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766489321; c=relaxed/simple;
	bh=mWjLMrD7Qs7+TOUsvaOe048D73gNhSs+cvbFOlH02H8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ogATEyPOWATULWjwsvPMyy8EQM/PTdZi46QgB43iOc7Z1fn9CghwVO52mWprewsYYMkxLVB3xIhaxcN0V4Kg+nbaO/8hwHQ5vwPNKAIu5PJe7FVbCX1EYuR4oHn/IYTFnZvKhuteCEkTbDdUZHMslcdBhAfnxfZqTuMOJnEYGdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SiN9IjNa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275FEC19422;
	Tue, 23 Dec 2025 11:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766489320;
	bh=mWjLMrD7Qs7+TOUsvaOe048D73gNhSs+cvbFOlH02H8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SiN9IjNavCIG4A+BJHHiARzJEVZdYXLZDSYEAgCEz13NtSz1wpg9R1lDU9/jhSFxU
	 wg2TRBrjSDBjeQji66X2uYOqp50R4QxQ/kIXdcSUR9HFH2iDrkFdaynAdBPFv5ElDI
	 mKWZ7W96sqq/fsC8qObeunsGe06AbPl8oglpqodBYb78gI83WyyrQeljcHlXY1pF+h
	 rEG5GdH+GGr2c4jOp90Upf3Qjsu+DiRH7Dte8LTzioy40R97QB69HOflrcELaprNmj
	 2VfuOCcNnHAZYdSKeHHmFfdUNMtR6PXjyHkAObRIg8DhFvKpjL9JWG3kQL9uLYi8MK
	 uTd6cFppaS23A==
From: Vinod Koul <vkoul@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Paul Cercueil <paul@crapouillou.net>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251104-axi-dmac-fixes-and-improvs-v1-0-3e6fd9328f72@analog.com>
References: <20251104-axi-dmac-fixes-and-improvs-v1-0-3e6fd9328f72@analog.com>
Subject: Re: [PATCH RESEND 0/4] dma: dma-axi-dmac: fixes and improvements
Message-Id: <176648931879.697163.3228568925131734691.b4-ty@kernel.org>
Date: Tue, 23 Dec 2025 16:58:38 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0


On Tue, 04 Nov 2025 16:22:24 +0000, Nuno Sá wrote:
> This series adds some fixes to the DMA core with respect with cyclic
> transfer and HW scatter gather.
> 
> It also adds some improvements. Most notably for allowing bigger that
> 32bits DMA masks so we do not have to rely on bounce buffers from
> swiotlb.
> 
> [...]

Applied, thanks!

[1/4] dma: dma-axi-dmac: fix SW cyclic transfers
      commit: 9bd257181fd5c996d922e9991500ad27987cfbf4
[2/4] dma: dma-axi-dmac: fix HW scatter-gather not looking at the queue
      commit: bbcbafb99df41a1d81403eb4f5bb443b38228b57
[3/4] dma: dma-axi-dmac: support bigger than 32bits addresses
      commit: b2440442ccb68479fa6d307917419983f3c87e83
[4/4] dma: dma-axi-dmac: simplify axi_dmac_parse_dt()
      commit: c23918bedc74a7809e6fa2fd1d09b860625a90b8

Best regards,
-- 
~Vinod



