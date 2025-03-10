Return-Path: <dmaengine+bounces-4688-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7946A5A5A7
	for <lists+dmaengine@lfdr.de>; Mon, 10 Mar 2025 22:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826B5189386A
	for <lists+dmaengine@lfdr.de>; Mon, 10 Mar 2025 21:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3291E6DC5;
	Mon, 10 Mar 2025 21:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olCWmCQn"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098F81E5B90;
	Mon, 10 Mar 2025 21:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640816; cv=none; b=pMDgLdQrGcIdMc610k5MPG3M6c4sMmMHUm+1n+mx0TYiMuTg1uhLqrD2JveSQEVsQooXvrGgODhOf5JKOEJzK+1tu9OetwKG/I2VOsc9HN5qbnYa+4fi9XHsAzvz9h48wVaGaI1XNWqGO5/3S2SzRUGqL1Azq9cJRvoyfI3tjrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640816; c=relaxed/simple;
	bh=aHodnL7sDcOW51ypAU/TDZpYSCaHkl1q89XnPQq3INM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=vBC+Vea203q1/J8H09XOHxDwTrgoQfXiS+vKiYFyEJssCU56A0vXP002Nh4w6wQtwj9CoFHtM7LwBIlgHhcbX37bCCw7gO4IlkK0ewTnh2W8GwYJ9Ir2UIuiXxMnxWeBQXUtuQg/eWwKacN/7RjOC5YzbTaD8QHKAw1w9RkwrUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olCWmCQn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A7DC4CEE5;
	Mon, 10 Mar 2025 21:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741640815;
	bh=aHodnL7sDcOW51ypAU/TDZpYSCaHkl1q89XnPQq3INM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=olCWmCQnrvLhmO01BgBvxL72HX4zWeHkRD6drrI8b+XQl04Fe8GAuAYCVGWxOPjLj
	 MkL1tGqlKGoJgJ7QcIIUi4C8oIY+eQ0TfiOQQY7Pwtvk14iRKMUufjh08OmyZPL58t
	 DxucAVXJoVh5iPMuSE0UDsXBqFCpM0+z7dslHvR4zknv0SgQUjXRFMXzE91SeubRC+
	 3TrYSQgHiLhpfwY2dULF09yKEAUbmBZFuJ7+bBBDah2ya24nUVzcQlaGEz69b3KTcd
	 F0+p+AYEpIbsehoM2SoREX8TlssNZJ5RdiDpACaskOlbDVd0m0W1L5BLNbOkR/vqhC
	 XokcvwmCZ1BBQ==
From: Vinod Koul <vkoul@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
 Matthew Majewski <mattwmajewski@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250216214741.207538-1-mattwmajewski@gmail.com>
References: <20250216214741.207538-1-mattwmajewski@gmail.com>
Subject: Re: [PATCH] dmaengine: ti: edma: support sw triggered chans in
 of_edma_xlate()
Message-Id: <174164081385.489187.12281170951493323877.b4-ty@kernel.org>
Date: Tue, 11 Mar 2025 02:36:53 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sun, 16 Feb 2025 16:47:41 -0500, Matthew Majewski wrote:
> The .of_edma_xlate() function always sets the hw_triggered flag to
> true. This causes sw triggered channels consumed via the device-tree
> to not function properly, as the driver incorrectly assumes they are
> hw triggered. Modify the xlate() function to correctly set the
> hw_triggered flag to false for channels reserved for memcpy
> operation (ie, sw triggered).
> 
> [...]

Applied, thanks!

[1/1] dmaengine: ti: edma: support sw triggered chans in of_edma_xlate()
      commit: e7240aba2053d437a661d946b3d413f310138a45

Best regards,
-- 
~Vinod



