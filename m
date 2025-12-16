Return-Path: <dmaengine+bounces-7697-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA14CC48B3
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 18:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E1C6303F287
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 16:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9715E288502;
	Tue, 16 Dec 2025 16:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDMqD5Hz"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D955288D6;
	Tue, 16 Dec 2025 16:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765904365; cv=none; b=a+RMS8iqNquRk57FfCTXnROOXtGUhddWGADYIsfkiqh1QqKyrqJpVkFalFjfWPHfWDRArfruPvn+2iR7GPCj8aWOVWcPDETPdwUAzdVj9Z6OoIW1YI7MmDeuXzyN2Inch4lT/fdWC2wfi9DormU2AA1nBQpzvOx5FOrCpPDScbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765904365; c=relaxed/simple;
	bh=oWHf/x4iwvLDc6qD6bHU62nY/7OrThHYZ+ZvHeeAKwc=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XewP7n0PMmlMdzGYl7hH8wX9R0iqlMwgc+fN/GKmxsS5MnVh+b7QiKc6bdVI448lA/uJCDlcBJYw1m4dZCqXQnLhYpDInHCItN59nSYXBaPxRJO8CN1WVmJQU1XGuM5wF2n/Ocb+y+erqniH+Wz6ESMfU/B9kaqZKh4nxqJv4+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDMqD5Hz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64B3C4CEF1;
	Tue, 16 Dec 2025 16:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765904365;
	bh=oWHf/x4iwvLDc6qD6bHU62nY/7OrThHYZ+ZvHeeAKwc=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=MDMqD5HzCQpBIZ/73amGTRW6d01Y+d9eud/r2yCVYiv4nTjoEYNSxAwzqpBZ4L2zE
	 AU3Svshs4kGf3CmxOj6xf1UpeYqK8GtoC23gCsxZCgHihA/JE3OhJOufGBS4JbviYl
	 yTTY4H3P7zj1w155jD4SIvK0xV5kL2YnRnLLZpt1VS1DB3O0L4Rqk7a7UbVNdsLzZ8
	 616F8zVsUjLWCooZHMZmVlLblBCqKxlAgRj8wIM8Fm0BVaJrWc9VP4njigUkLHrfFq
	 mhP2VP4XY7ME1VAQkyeAMURjlbG8jiIeRYjXnhRaA+xaXVJG+nzqL+JCCbBNRYH9rw
	 FO5YzWUnWdUdw==
From: Vinod Koul <vkoul@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20251208020729.4654-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20251208020729.4654-2-krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH] dmaengine: dw-edma: Fix confusing cleanup.h syntax
Message-Id: <176590436343.430148.178908996367705335.b4-ty@kernel.org>
Date: Tue, 16 Dec 2025 22:29:23 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 08 Dec 2025 03:07:30 +0100, Krzysztof Kozlowski wrote:
> Initializing automatic __free variables to NULL without need (e.g.
> branches with different allocations), followed by actual allocation is
> in contrary to explicit coding rules guiding cleanup.h:
> 
> "Given that the "__free(...) = NULL" pattern for variables defined at
> the top of the function poses this potential interdependency problem the
> recommendation is to always define and assign variables in one statement
> and not group variable definitions at the top of the function when
> __free() is used."
> 
> [...]

Applied, thanks!

[1/1] dmaengine: dw-edma: Fix confusing cleanup.h syntax
      commit: f9ef8dedee34e2d7828d5a6a0643cd969aaa8437

Best regards,
-- 
~Vinod



