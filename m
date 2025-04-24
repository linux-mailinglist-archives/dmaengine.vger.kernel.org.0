Return-Path: <dmaengine+bounces-5018-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1FDA9A089
	for <lists+dmaengine@lfdr.de>; Thu, 24 Apr 2025 07:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBC9B920CA7
	for <lists+dmaengine@lfdr.de>; Thu, 24 Apr 2025 05:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D459F1CDFAC;
	Thu, 24 Apr 2025 05:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVplbl5v"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5CF1CBA18;
	Thu, 24 Apr 2025 05:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745473019; cv=none; b=Tsj05eKGKJbOyE2kMxR9Y52PpBeDeOYmEUHOSxAZpCb54FagnpFOz4Dwc7fxP2yKLaLaEkNn0EKWQVst5lm0tvnbMaxEYATVksGelDk40BL4esLcVL6hKmQKFLVp6leN1LerOp/qs+O/mbH8FwlpzMBDvS78HX3e/1hc0U1l4bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745473019; c=relaxed/simple;
	bh=16Tv7vNTdXwidd0uz+YZ0SsmgwWLIo9ELsC6Ft/58yE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hwI84KXvC5w7LUkWFi5jPPDe0zHymZ/japHe27ZOJQjE1pUL7Rbyiv9lHXX0nJ5w0WCBCcCfrReQ/qqEwsNVWdCbJkHF0cEAtRhmyQrB5Z8v1DchfsBGqzyMnwrCelcydKx+yjPN3nMDmgVBTvVykhI7igJyIP+F72yEbf7c5Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVplbl5v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7A5C4CEEA;
	Thu, 24 Apr 2025 05:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745473019;
	bh=16Tv7vNTdXwidd0uz+YZ0SsmgwWLIo9ELsC6Ft/58yE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lVplbl5vuIGMKKE0B/NwmZpSwfZ8WJB6kVcHXsCeHiRN6rfm/4g0DAdIeaieu8MGA
	 mfdA2W/0ZK8E/rnmbOhBWS8vg7rlMWLDN8F6EfcBBrremkw1mP5UfJFgg8Ib5foF7n
	 8MqhggV0Y6L+QJunuO9LTbyh5yHQWRdQIFhTK2WH2Drq/bR7y7Mq24q2LXNnKguBdW
	 91LSU+KOi/D5z95P/zfTN/aF5pWY9SpAqn/XXqT1Voe0syR8/wecy5Rh0uOxfikBBg
	 m76FP4RIDY23BtcmjNKGYbfUeZFOgNPhsnCiGEKA1UjB5wnDdYu6suZBqA8ed4zKUw
	 3J1wZRtnNiFxg==
From: Vinod Koul <vkoul@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <50dbaf4ce962fa7ed0208150ca987e3083da39ec.1745345400.git.geert+renesas@glider.be>
References: <50dbaf4ce962fa7ed0208150ca987e3083da39ec.1745345400.git.geert+renesas@glider.be>
Subject: Re: [PATCH] dmaengine: ARM_DMA350 should depend on ARM/ARM64
Message-Id: <174547301700.316124.6778478265087224914.b4-ty@kernel.org>
Date: Thu, 24 Apr 2025 11:06:57 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 22 Apr 2025 20:11:19 +0200, Geert Uytterhoeven wrote:
> The Arm DMA-350 controller is only present on Arm-based SoCs.  Hence add
> dependencies on ARM and ARM64, to prevent asking the user about this
> driver when configuring a kernel for a non-Arm architecture.
> 
> 

Applied, thanks!

[1/1] dmaengine: ARM_DMA350 should depend on ARM/ARM64
      commit: 86071b369dbdf0a8f7e4424c4e0b613ba7b8ab5e

Best regards,
-- 
~Vinod



