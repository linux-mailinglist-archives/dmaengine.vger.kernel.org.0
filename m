Return-Path: <dmaengine+bounces-5160-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E3FAB6EB6
	for <lists+dmaengine@lfdr.de>; Wed, 14 May 2025 17:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A90F3B6418
	for <lists+dmaengine@lfdr.de>; Wed, 14 May 2025 15:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B451C6FEA;
	Wed, 14 May 2025 15:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOAx9mRu"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0E71C68A6
	for <dmaengine@vger.kernel.org>; Wed, 14 May 2025 15:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747234958; cv=none; b=QIGtHoOT1ty4uoxleEkn0HOcXnARUX8owWEsFb86PCSXu0KzTGki6VZo7j/UOV8BBo6q6auF8tb6ku8JOP78azlhFfBior5RHuLaLc2p3PAxxENVssTQfPEBjPi2oYofeQdaWmK1cl60YmxRE0ozbYhgijDtjckgTJ2ddtCHYNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747234958; c=relaxed/simple;
	bh=XNMDVmGKoaD0CCCLKXD9UTbJt7MUB5DFdnvWT9PPXTA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bZsKTOBndfvesUNJkIa+iYVBWpEsciQ0vU54DqNUtAv8LzS77r6E98/VvxQoXml+J3fmrVmPQyXm8GiBQwK7qOndfYuhwWOVqfr8WycgV9i2yYmxMGU1v4h61i2BRdK4fgW5+EbqHgk+2XkQ9WZYdqwWhU8Z+vg2eZZpW5SnbVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOAx9mRu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E51C4CEE9;
	Wed, 14 May 2025 15:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747234957;
	bh=XNMDVmGKoaD0CCCLKXD9UTbJt7MUB5DFdnvWT9PPXTA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FOAx9mRundJ7+FBssNCqiSsGCXonlqiexhBOzRlvk7/B1yU84/uD1yPQP1+WJ86JQ
	 wI2xqNtXDigI4ORWibeeZqExYyvwHpi1X+3wWcpnLAHf3+h+vJpsiLgK2JXhsstaf8
	 ie9Nb0GTU++L+wrn/ga2j7dy7B/CpJFBCbe6yIrOhO/SDofF6NQMNETCPXMzom2wci
	 Fq6e1UWr079sA9tlWGYVceu4z1M4TS/Jnr1gevM/CMlCc5TnOclPEtK8qQAdfkzqXW
	 HY90UNZdd0IVEdhQzQCAWDKreao/y7wLwSLRWKA5YNvYkbOep2N58jei9wm13HDqDm
	 ehbGo9UolZ2kA==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>
Cc: vinicius.gomes@intel.com, kernel test robot <lkp@intel.com>
In-Reply-To: <20250508170548.2747425-1-dave.jiang@intel.com>
References: <20250508170548.2747425-1-dave.jiang@intel.com>
Subject: Re: [PATCH] dmaengine: idxd: Fix ->poll() return value
Message-Id: <174723495665.115648.13734368610818117334.b4-ty@kernel.org>
Date: Wed, 14 May 2025 16:02:36 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 08 May 2025 10:05:48 -0700, Dave Jiang wrote:
> The fix to block access from different address space did not return a
> correct value for ->poll() change.  kernel test bot reported that a
> return value of type __poll_t is expected rather than int. Fix to return
> POLLNVAL to indicate invalid request.
> 
> 

Applied, thanks!

[1/1] dmaengine: idxd: Fix ->poll() return value
      commit: ae74cd15ade833adc289279b5c6f12e78f64d4d7

Best regards,
-- 
~Vinod



