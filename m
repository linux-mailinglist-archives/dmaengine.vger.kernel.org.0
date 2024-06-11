Return-Path: <dmaengine+bounces-2351-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C46FE9043A9
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2024 20:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5B2F1C23FA5
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2024 18:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F7E81742;
	Tue, 11 Jun 2024 18:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pwmc5/OJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F3E156643;
	Tue, 11 Jun 2024 18:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130511; cv=none; b=EGMdv4Qrg4myIVMNGKVcvbuLPpk3xCpmiuznfc0HnqZpbdeTxH1TU79E/2bFFPzeT/m1eFiNLcfTvwm1UMYZd0Gil6GE3G32gRz0qjNhER7Ve1nOvGatTvViVl0l3nW0lQSzRM69Gh8B28XWcCswmR2TOwhR0lLVfaua/KIPENk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130511; c=relaxed/simple;
	bh=0IpkudyHdYEF2XfuJ5ytUb4hg9SXIAZELPdA4I83a4M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eAiwRY3311HWZR0x0iImncT7Ho6Ht5Ds4Q/go3uYDHwz9/7FVFfWGyKz2t4gNmrxlY6oi7fvng2CegX2DRp1V4r5CbI8q6DJ+8wdnH69BZhtYzNNWFot+3NdXtQcQFFmTmmLVE96O+WKMpTajnsaPpwK9K/9hQhyyNeELE4jZc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pwmc5/OJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07107C2BD10;
	Tue, 11 Jun 2024 18:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718130511;
	bh=0IpkudyHdYEF2XfuJ5ytUb4hg9SXIAZELPdA4I83a4M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Pwmc5/OJX8zMSSbaDlxc75aIvszsYj3yB2w9PlpEw3rhPcNgOBd8gucc+h3kvUwWh
	 mJXWg8b+9Dp+3ku6Cq7gmi5ANLiqTwY09p/SNzuVqPSeqFASdY68jDUaMZcd4e4aIB
	 6YAyRO9bpcp/XnG2BwGKkGfFLTkge5OxHAGMlDBaURz6MUiRWAtNYtYW5taZwM77+X
	 6WoFSKHJhTYtihJWOh3S0N4RoYYivmvGKJ/VlhCxFB3EZv8lTkSIdioSekl/C7B5/b
	 1NxPX/y3qodoUwRa/RWHgtZqNyJQyHB52Gpr63cQCsKHHfCwQCJSylLjo4ZzFyV8uT
	 PWDcoA7y7MkyA==
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@nxp.com>, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joy Zou <joy.zou@nxp.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20240510030959.703663-1-joy.zou@nxp.com>
References: <20240510030959.703663-1-joy.zou@nxp.com>
Subject: Re: [PATCH] dmaengine: fsl-edma: change the memory access from
 local into remote mode in i.MX 8QM
Message-Id: <171813050965.475662.12830562542163135119.b4-ty@kernel.org>
Date: Tue, 11 Jun 2024 23:58:29 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 10 May 2024 11:09:34 +0800, Joy Zou wrote:
> Fix the issue where MEM_TO_MEM fail on i.MX8QM due to the requirement
> that both source and destination addresses need pass through the IOMMU.
> Typically, peripheral FIFO addresses bypass the IOMMU, necessitating
> only one of the source or destination to go through it.
> 
> Set "is_remote" to true to ensure both source and destination
> addresses pass through the IOMMU.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: fsl-edma: change the memory access from local into remote mode in i.MX 8QM
      commit: 8ddad558997002ce67980e30c9e8dfaa696e163b

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


