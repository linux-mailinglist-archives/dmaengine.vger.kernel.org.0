Return-Path: <dmaengine+bounces-5827-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F45B062D1
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jul 2025 17:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53E6D1AA2692
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jul 2025 15:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1DF245006;
	Tue, 15 Jul 2025 15:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsjUeGT2"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71361233148;
	Tue, 15 Jul 2025 15:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752592926; cv=none; b=aYzd606nsw6ohhUR2e9E0VCmyQIMmSbF6NxdTIOUq600wFuVAIPFwaz1J0UkL0rccEkDofjQ6BjXv7GBSK99pySrC3kEnOZMlQlDb4KXh6YYmc16KpqX15/gkpAhQaRUWQ8F5Ju51o5AXvm+LHYoynNY2ZYCZtp4xMb6dijM7s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752592926; c=relaxed/simple;
	bh=6fs8/NfuMxahoFjmKXHZsImMOsOUhDYSnfFLmEvRh+s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hXdy10G+0RdtqCqr3EA1RcSnFruuBelNa9CWe35eR5Az0D8ozmXjtsprZ8OfV4PWF0CsaOdQuqlpSzNl60rzcOVoag89UCdcDyZh5DXIBBiz2CC/1S9ESKyUtiasSHN5oD/IYe2sCdVLyUKLW52/+LUj3c1rc7e/OLjuPFZ3HCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsjUeGT2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902D4C4CEF7;
	Tue, 15 Jul 2025 15:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752592926;
	bh=6fs8/NfuMxahoFjmKXHZsImMOsOUhDYSnfFLmEvRh+s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HsjUeGT2YlZAlO1zIKd/qMl99dZbbW2JyTeAfNvDVEeH6DuOp8yW1zbd5nzZpQc5O
	 I4B2f6u6FdLXjKL1KWfQYyVoeDV/Etby1/umlnh0g/9rWAM/JMMfly92IepbHlU8fr
	 mgNRGQDyLvhICn1C6D6TB7n7Q1nhMD8bpGEyccXBu4wIBYRlYyVyMJmYLaEhmsPmaw
	 qqheYTEk4E3EhVbRcvP56xHLb5rnnKvPEabjCohNIpu1vy/QSzk909JB9axahlI9YR
	 RBAGwLJNFWv875lrwE2HrfqyL4E2tH0hlvaZf46hawCuW6fnAr38Fr4gjLs0MImglr
	 3idRs7yMdH4GQ==
From: Vinod Koul <vkoul@kernel.org>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <b13c5225-7eff-448c-badc-a2c98e9bcaca@sabinyo.mountain>
References: <b13c5225-7eff-448c-badc-a2c98e9bcaca@sabinyo.mountain>
Subject: Re: [PATCH] dmaengine: nbpfaxi: Fix memory corruption in probe()
Message-Id: <175259292421.543905.3175578919645729434.b4-ty@kernel.org>
Date: Tue, 15 Jul 2025 20:52:04 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 01 Jul 2025 17:31:40 -0500, Dan Carpenter wrote:
> The nbpf->chan[] array is allocated earlier in the nbpf_probe() function
> and it has "num_channels" elements.  These three loops iterate one
> element farther than they should and corrupt memory.
> 
> The changes to the second loop are more involved.  In this case, we're
> copying data from the irqbuf[] array into the nbpf->chan[] array.  If
> the data in irqbuf[i] is the error IRQ then we skip it, so the iterators
> are not in sync.  I added a check to ensure that we don't go beyond the
> end of the irqbuf[] array.  I'm pretty sure this can't happen, but it
> seemed harmless to add a check.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: nbpfaxi: Fix memory corruption in probe()
      commit: 188c6ba1dd925849c5d94885c8bbdeb0b3dcf510

Best regards,
-- 
~Vinod



