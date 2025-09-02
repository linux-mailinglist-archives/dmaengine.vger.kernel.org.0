Return-Path: <dmaengine+bounces-6317-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1075B3FA9E
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 11:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F0F37A4D0D
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 09:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40582EB86E;
	Tue,  2 Sep 2025 09:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmkdsVe3"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78369261B9E;
	Tue,  2 Sep 2025 09:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756805739; cv=none; b=CDPGbZRAsCQz6dqmzAFTkuHc1LdtyBT0SrbbRvJw37UjmMEflNTqGJ7E6jgr/1MUVZufl7gOS+lhJJ7PAB/+murmRvKTbrFIT1TClX8IbezmCh9GD0bmTfXY6e7MpCjVklwkZlw0VBwWzApQRGC4Xy3Ud52uLJB6twMfA1TvC9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756805739; c=relaxed/simple;
	bh=ujlZdG/yM2wDrOV0esyv1Z6jFhcIE8BBWeFRBpgrSaw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J3j5gKRwGTJOK6ypQBswK4WpOPOXv49ecaV2mjQBmk8U4J3FM4r19anI9yauZbkdcTlN8+iHELTMHKPwC7nqVrHSKIX2CP20GFYTSqpBgkKZElILzA0M+ZPIHIBuBv63e592zNi69w1w8QT6GIXhZs9l68U92s0SD99Q7TJgX8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmkdsVe3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BCDC4CEF5;
	Tue,  2 Sep 2025 09:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756805739;
	bh=ujlZdG/yM2wDrOV0esyv1Z6jFhcIE8BBWeFRBpgrSaw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pmkdsVe3ld0uKCLwlrRvdDH1mvbdPhhG4kCLAf0r4Ux22p4fXhA02s3b8MhDCGLjM
	 QHRSATTjBrKjJCyufm2FsP2ZYjIJpJ8UmU0NCIgVdO1AMoViYlDdFYsudUkPflXTPq
	 plJil7ZUntlFVepgrTYxXrJO0bNn3soGygDrenvzxRPugDXWyzdH7QWfN5jJbOiuww
	 h7H/9RsI/twIaTsiptUJ3tSd7GKgogOMi0sHucAdWb4nOPddK4ny1pZrHWbAigP/Vi
	 wwWtJ56xtzJgmtzzaZ+2MPYKat2DkAjxWR2IiAtu9XEWvrHmpHgbLS45ricoiIPuj6
	 m2gixE1qN5g6A==
From: Vinod Koul <vkoul@kernel.org>
To: peter.ujfalusi@gmail.com, nathan@kernel.org, 
 Anders Roxell <anders.roxell@linaro.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, dan.carpenter@linaro.org, arnd@arndb.de, 
 benjamin.copeland@linaro.org
In-Reply-To: <20250830094953.3038012-1-anders.roxell@linaro.org>
References: <20250829232132.GA1983886@ax162>
 <20250830094953.3038012-1-anders.roxell@linaro.org>
Subject: Re: [PATCHv2] dmaengine: ti: edma: Fix memory allocation size for
 queue_priority_map
Message-Id: <175680573537.233989.3534240892584425378.b4-ty@kernel.org>
Date: Tue, 02 Sep 2025 15:05:35 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Sat, 30 Aug 2025 11:49:53 +0200, Anders Roxell wrote:
> Fix a critical memory allocation bug in edma_setup_from_hw() where
> queue_priority_map was allocated with insufficient memory. The code
> declared queue_priority_map as s8 (*)[2] (pointer to array of 2 s8),
> but allocated memory using sizeof(s8) instead of the correct size.
> 
> This caused out-of-bounds memory writes when accessing:
>   queue_priority_map[i][0] = i;
>   queue_priority_map[i][1] = i;
> 
> [...]

Applied, thanks!

[1/1] dmaengine: ti: edma: Fix memory allocation size for queue_priority_map
      commit: e63419dbf2ceb083c1651852209c7f048089ac0f

Best regards,
-- 
~Vinod



