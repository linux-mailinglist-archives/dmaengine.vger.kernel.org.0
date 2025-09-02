Return-Path: <dmaengine+bounces-6326-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AE2B3FB35
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 11:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E043C7ABE94
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 09:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338092F39D4;
	Tue,  2 Sep 2025 09:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZB2gwyX"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6D42F3C00;
	Tue,  2 Sep 2025 09:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806610; cv=none; b=Tcx6xN3dUPcPpL3g761IaAKNVuI/9oGOq697+og0fm5Y3EzleNy3rjeVF6NCmtJ87IoOxvliGOF3Jto3P0klmYCEbcFY2Q3DgHBNelSMJF5cGmSW9Txn6NOJcPF0cq/aIR7lGIOIQ55TEbEJdw2vnvCBswpmAU4EJQ3O2OiFhVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806610; c=relaxed/simple;
	bh=C11UpNJGH7LeuWpZAPE8cZYb9XnAzzUJJddIiOPFG50=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=d0C6/fgdnmLwUM9h2c1lnpYChzQWqe6SHIZWTzhZf0W6YXBEaTzHjQzlMTNZ6DcM/1+DQTr+Rmv681XVCMz5TrVd0w1vfEoxef4wAy7Ecl+VM6E8efEQbfiMC0MoP3sIsGjNNVFCzyfvlPrNHDu46+5lM9CIjoWAt3OUzCCe2Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZB2gwyX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732D5C4CEF7;
	Tue,  2 Sep 2025 09:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756806609;
	bh=C11UpNJGH7LeuWpZAPE8cZYb9XnAzzUJJddIiOPFG50=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bZB2gwyXJ8O6HvlbfDF5MoDgn+8+aSnvP1w2cUetubv3urF10neqLbwkLJ4vleeAA
	 iG5Ww6Urnjdbf6dxy4VSuDClPJI9xNw8H7LbvJ59q1ODeI42Ma89BdIyi7u/rOS/xy
	 D7DFkMKOmyEKDW3MYbbMzFX0KrzvxT+AHC8mwMQBjFHhdtbmgbAe5aacbzVnn3YBXd
	 Yb0NZeai1F6EnQoYiCwIza2e8+tVxvTqE1DFWiqQ65dQDT31RhlXB8Et/Pdl3BDbTh
	 VSyat5YN41w26ePFFM0LFHLENkPkCgmSBkriskzrbJLnG7XwZsRXKHvMhYdMWERlsK
	 GUq7Rmomhd1QQ==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20250821220942.10578-1-rosenp@gmail.com>
References: <20250821220942.10578-1-rosenp@gmail.com>
Subject: Re: [PATCH] dmaengine: mv_xor: match alloc_wc and free_wc
Message-Id: <175680660798.246694.1939035723269622939.b4-ty@kernel.org>
Date: Tue, 02 Sep 2025 15:20:07 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 21 Aug 2025 15:09:42 -0700, Rosen Penev wrote:
> dma_alloc_wc is used but not dma_free_wc.
> 
> 

Applied, thanks!

[1/1] dmaengine: mv_xor: match alloc_wc and free_wc
      commit: a33e3b667d2f004fdfae6b442bd4676f6c510abb

Best regards,
-- 
~Vinod



