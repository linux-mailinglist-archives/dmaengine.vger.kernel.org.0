Return-Path: <dmaengine+bounces-2341-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CD590437F
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2024 20:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 076451C23C08
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2024 18:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B237D08D;
	Tue, 11 Jun 2024 18:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qiSLN0yi"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC7C7CF34;
	Tue, 11 Jun 2024 18:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130473; cv=none; b=K28EhsuDIUTWNjHMrUveZS5lPdoDbop14YAeuzYl9J8Rg5zxUOwbvvvD3fw5UcdadlkSDIObRF7jPpSl9TptjOjQFeDLSRz+uf7QCqi7TKAN2W0nfttlHL4Dqi38AOpfBolXG+kMqhK31BPeNavEO2MwOowzpxSpGT//gYWrab8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130473; c=relaxed/simple;
	bh=fHhEfvWwtK4Eff3/jfxyCWlEtDu1mJZZ8Zh4eSjSY4I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ul49M/kgVRRV9sowdXpxA4Q0O4CshMcnXL1LzITmlsnhm/lLD4o43IaLU2YTd4cAqGiBTIT3T/cbCm726nCBlHJYaoynhd1AekR6gtyugnzokH79tdyvnSaKg5PHCNedgs3KeMyPd4vOpWwIR50n6syZ3oRTPpXYbi6T/q6O66Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qiSLN0yi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354CBC2BD10;
	Tue, 11 Jun 2024 18:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718130472;
	bh=fHhEfvWwtK4Eff3/jfxyCWlEtDu1mJZZ8Zh4eSjSY4I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qiSLN0yig0Kk9SOV1JSy2LZr0Qb1ltbpkrqFVZ9uobGkmDTylZAKyqghKRKMPjuL6
	 yQ5SnDS75wQWZ+Ds14pAoo8/1JNOM452z4DTdcmZEwz6+UcAfUFJEBFzXezzGyx4Qs
	 cWaGTYVYEiNTsnrVtL067+nCFa+Q2+ijfD5ZdkIcgntIMFEyFjbj38jDyZDeozL7ly
	 Pfb9rO19MYu5cA56esMVymwGZa3tUzkaYYdDtjH5VR81fz+Neo+uZG8Qj/f7x1kedZ
	 1s7F/ONtHbQ8496IeuZn5jHI8AKZMAe/AsxLJkt8eZ1YEcpdzNrB6ZZ5QpiJl4mIoa
	 Da3sReZ3DKI+w==
From: Vinod Koul <vkoul@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>, 
 Logan Gunthorpe <logang@deltatee.com>, Nikita Shubin <n.shubin@yadro.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux@yadro.com
In-Reply-To: <20240528-ioatdma-fixes-v2-0-a9f2fbe26ab1@yadro.com>
References: <20240528-ioatdma-fixes-v2-0-a9f2fbe26ab1@yadro.com>
Subject: Re: [PATCH v2 0/3] dmaengine: ioatdma: Fix mem leakage series
Message-Id: <171813046978.475489.11233301770503633665.b4-ty@kernel.org>
Date: Tue, 11 Jun 2024 23:57:49 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 28 May 2024 09:09:22 +0300, Nikita Shubin wrote:
> Started with observing leakage in patch 3, investigating revealed much
> more problems in probing error path.
> 
> Andy you are always welcome to review if you have a spare time.
> 
> Thank you Andy and Markus for your comments.
> 
> [...]

Applied, thanks!

[1/3] dmaengine: ioatdma: Fix leaking on version mismatch
      commit: 1b11b4ef6bd68591dcaf8423c7d05e794e6aec6f
[2/3] dmaengine: ioatdma: Fix error path in ioat3_dma_probe()
      commit: f0dc9fda2e0ee9e01496c2f5aca3a831131fad79
[3/3] dmaengine: ioatdma: Fix kmemleak in ioat_pci_probe()
      commit: 29b7cd255f3628e0d65be33a939d8b5bba10aa62

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


