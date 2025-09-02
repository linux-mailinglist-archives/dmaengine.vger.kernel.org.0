Return-Path: <dmaengine+bounces-6323-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9749AB3FB23
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 11:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80C4E1899B4A
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 09:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503C22EDD67;
	Tue,  2 Sep 2025 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aO7XuKQV"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2290D2ECD33;
	Tue,  2 Sep 2025 09:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806596; cv=none; b=nBQDl3eWEMbWgqefV4R0j1UoJ3o73ZzYqMZCqhoYkwngJB4i1490xtrhrzHYfadHy8VUzcoAP5zylprNdgPuGDnNMiSxsKUloDM6p29fkrWVJzEs3oxCVWdIxmo1ZjP0FqcJAL96mmTga7czR/vDa99j0rBX5/m/5r6azZ4nJ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806596; c=relaxed/simple;
	bh=P72mig+lJzjyUzyIhJV0uWLLGHp1Vu+HmmPcTwazzOg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fk1FQiksgZR4Eo72w5Dp4ArTdWpOcppJtNWjW3aJAYw4P9gJRGUL30X26K+fWtVc5wIobIlcnt9KGDcwww/a/MuOT6Mwhh3gwUpMW2EEU1v7TdTcCkFN6E7hN+Ss96nAYor6L5f1D5IpAAbGZXgz4xNmLblqz+IVZQO7Nl1DY8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aO7XuKQV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5733C4CEF9;
	Tue,  2 Sep 2025 09:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756806595;
	bh=P72mig+lJzjyUzyIhJV0uWLLGHp1Vu+HmmPcTwazzOg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aO7XuKQV0KPATkqs4cmGD6f+lBgxjKDLXHc6JHu+rYp4uuq6QuKPdkuKZGRgEi1+f
	 2SGEAnMcZ80+1SbRBk2y2Tp2zc8pOfE/UiklQ8WXcpBU5yliosPxvDHyyKfmoMOgYu
	 v+95B9h+SOZmt3r4U5dWNILAB7Wx33iUbg2+A0whknX/CiySvzL8oc8WUlUuMkunHN
	 4y3Tfsp95hqegh4UMLq3bLsWrN3gm2yOlWAPlLOCExFkppPzgXprY/9lTbS42pLVdT
	 vEmjlEV9/bx/nyUDVkEiDJLCHvoYSQq0MWRygFIdoxaBNVZ2ep862Y2XSp4fvD0tA4
	 jbaeVlp8YQ1dA==
From: Vinod Koul <vkoul@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>, 
 Nathan Lynch <nathan.lynch@amd.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250826-dma_async_tx_desc-tx_submit-doc-fix-v1-1-18a4b51697db@amd.com>
References: <20250826-dma_async_tx_desc-tx_submit-doc-fix-v1-1-18a4b51697db@amd.com>
Subject: Re: [PATCH RESEND] dmaengine: Fix
 dma_async_tx_descriptor->tx_submit documentation
Message-Id: <175680659338.246694.12770116993030357573.b4-ty@kernel.org>
Date: Tue, 02 Sep 2025 15:19:53 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 26 Aug 2025 11:07:38 -0500, Nathan Lynch wrote:
> Commit 790fb9956eea ("linux/dmaengine.h: fix a few kernel-doc
> warnings") inserted new documentation for @desc_free in the middle of
> @tx_submit's description.
> 
> Put @tx_submit's description back together, matching the indentation
> style of the rest of the documentation for dma_async_tx_descriptor.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: Fix dma_async_tx_descriptor->tx_submit documentation
      commit: 7ea95d55e63176899eb96f7aaa34a5646f501b2c

Best regards,
-- 
~Vinod



