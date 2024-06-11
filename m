Return-Path: <dmaengine+bounces-2344-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8B390438A
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2024 20:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C647D28225B
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2024 18:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4549823CC;
	Tue, 11 Jun 2024 18:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoO+hICi"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD37823B0;
	Tue, 11 Jun 2024 18:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130481; cv=none; b=KdYOLwKD1cd+rScMlC2LsFU6tn7cM36kJsFYGQVV5UH3Bdb2VdaJ1Knu1l7HAjKMU54ZbQR3fOUu8pEXOdpz6LGqycNBmjxiAdhfHLX0SobxEoDYiuF2aqqXdUdZaxLDMhb6f2dfRuq4ZVRZ43sfcleo2oVERzUNbVCAS7DUzuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130481; c=relaxed/simple;
	bh=CKsq3vSYkpUsDQyDUkiVJmQHYWw5DPCA3p6Kv9xSpbg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mUSiXiBxUbt1vqWID4e64DkvVPF6BdmZW07asgDji5Zvr1fzG1OQgcyfOl/j6Y7nUu5wVc3aZjGc2Wfg6iUXe8dRQH6k6P0teB9POpg75/ww2rKASq0/4SFLl4OCqMVYLCglKVz5dvCZqFHOxsBoLuxOe6PKQqDRTjeWSj0k04k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoO+hICi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24ABC4AF48;
	Tue, 11 Jun 2024 18:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718130481;
	bh=CKsq3vSYkpUsDQyDUkiVJmQHYWw5DPCA3p6Kv9xSpbg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MoO+hICi7WOT2OO4suXgeIfSgQs04jyx5JMhxp11qPRfHKILynSivG8N2IqhunCiQ
	 iNNseJaIx0FQNORyk9RIFUB23uCcDuzEo+aNCn3RBeIbqpzQnDS9N13g3PKiHVhAvr
	 7VDdGizIVbxoLCQbz4YSbgv/+oHzJMa9abjCnsjXMY+q2a2IW4o008HPZPenWFOGJZ
	 k3mMfXIDs/fOyCacmIG/eE2Wecc81/2KOyPxBMjScz2POCSZrC8lhUrFBrC77j+oBl
	 ihO3UiEhTsF/CRgKqTcnkPP8aGG/RiL7933z8AFuwxZ7PXZgJ0gs2diNETUJM+5+DV
	 n8ltYIXjIbx7g==
From: Vinod Koul <vkoul@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>, Nikita Shubin <n.shubin@yadro.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nikita Shubin <nikita.shubin@maquefel.me>
In-Reply-To: <20240514-ioatdma_fixes-v1-1-2776a0913254@yadro.com>
References: <20240514-ioatdma_fixes-v1-1-2776a0913254@yadro.com>
Subject: Re: [PATCH] dmaengine: ioatdma: Fix missing kmem_cache_destroy()
Message-Id: <171813047927.475489.15663025879772656295.b4-ty@kernel.org>
Date: Tue, 11 Jun 2024 23:57:59 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 14 May 2024 13:52:31 +0300, Nikita Shubin wrote:
> Fix missing kmem_cache_destroy() for ioat_sed_cache in
> ioat_exit_module().
> 
> Noticed via:
> 
> ```
> modprobe ioatdma
> rmmod ioatdma
> modprobe ioatdma
> debugfs: Directory 'ioat_sed_ent' with parent 'slab' already present!
> ```
> 
> [...]

Applied, thanks!

[1/1] dmaengine: ioatdma: Fix missing kmem_cache_destroy()
      commit: 5422145d0b749ad554ada772133b9b20f9fb0ec8

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


