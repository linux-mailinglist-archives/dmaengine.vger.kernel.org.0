Return-Path: <dmaengine+bounces-5169-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5310AB6ED3
	for <lists+dmaengine@lfdr.de>; Wed, 14 May 2025 17:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB76717B4B5
	for <lists+dmaengine@lfdr.de>; Wed, 14 May 2025 15:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8502C27AC25;
	Wed, 14 May 2025 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qb9nmv3q"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE9527990E;
	Wed, 14 May 2025 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747234990; cv=none; b=j5jOvjmw0YUb6q1SxjW3Dqq1X/e/zrqf6usVwDidwA+OATuNINJwYYdIruRNtwtP7F2ImV9azTFfbkd/SIZBqTKFiYpKK2ZweScNj+ZpSg1+uFRv0lBVsVfg4Ti++MambREQ10QpZ3c5kWwjwjUjThdnYte1Eg/FVCz2MTu211g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747234990; c=relaxed/simple;
	bh=oApTaXa/YyifVYlPelKiDC9Sg1K5tnN0r0xjNEF5VGU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SDQTqKjeUT2f/1YmaqXtkC/PELCFqpISHtto4xIhdcdBKgLqvmznxWsu4FfRqVGPM3Bg4Q3GZeu9zckLjSsGFZxoNv5d4P2tkOE3Z/Bu2TKMIrjZdQcA6ENMEOIZ6AA+/DuKLHJduduOmI8YprtBYT9DLIJME9sgnYH7+BTeJmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qb9nmv3q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B392EC4CEED;
	Wed, 14 May 2025 15:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747234989;
	bh=oApTaXa/YyifVYlPelKiDC9Sg1K5tnN0r0xjNEF5VGU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Qb9nmv3q1m6+Nv13DKxnfj01iU8W9lT5ujuqubzBdiYEbChUShySfes+dRdeevE4P
	 c7CcRvW/7tBK36qyaHi8IhyVSSQ/Xz++b/8/NBuBHwcmrtFTdWDNuwXZ7iUnkgj5ex
	 mFCKpzmxmDXh7y9WftL75nv03hsEX97enE0Okd0bT630B5PIlfBypfQVA9rTkb3Njr
	 T5TVtTWYXfH4EnDf513JsBs0GFbS5Ajj62H4tEmsCjKxdI/piLd8AqgWJZ5E9PFshZ
	 qvb0OaXCm5CDMjhCxx9iTwdWMG99uhFETrePFsZSwvQi9NUomiGNdnZTlBdFNp2QQq
	 Gvq87d9eq+k7g==
From: Vinod Koul <vkoul@kernel.org>
To: peter.ujfalusi@gmail.com, Henry Martin <bsdhenrymartin@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250402023900.43440-1-bsdhenrymartin@gmail.com>
References: <20250402023900.43440-1-bsdhenrymartin@gmail.com>
Subject: Re: [PATCH v1] dmaengine: ti: Add NULL check in udma_probe()
Message-Id: <174723498843.115803.15165946695069765623.b4-ty@kernel.org>
Date: Wed, 14 May 2025 16:03:08 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 02 Apr 2025 10:39:00 +0800, Henry Martin wrote:
> devm_kasprintf() returns NULL when memory allocation fails. Currently,
> udma_probe() does not check for this case, which results in a NULL
> pointer dereference.
> 
> Add NULL check after devm_kasprintf() to prevent this issue.
> 
> 
> [...]

Applied, thanks!

[1/1] dmaengine: ti: Add NULL check in udma_probe()
      commit: fd447415e74bccd7362f760d4ea727f8e1ebfe91

Best regards,
-- 
~Vinod



