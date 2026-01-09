Return-Path: <dmaengine+bounces-8141-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F88D06F3C
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 04:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8128030380F2
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 03:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D81C3033C6;
	Fri,  9 Jan 2026 03:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQRerYa7"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACA11DE3B7;
	Fri,  9 Jan 2026 03:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767928468; cv=none; b=rAzzFu6akMUO/avVPNvnM0rsujXg4aHTmL2rs06SFiEbVkJ4mAiOAQUU9/xwHozV0xZeriMiPcNDeJlscGUMkDC4TVpjo8Rq+Hr8m9ore8CHF/+XE+v2CuqdGoegxKoTU6x+nHKwwgVI9XmbD+/HcGm7Uh8wq4wJoCxDoNjDm/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767928468; c=relaxed/simple;
	bh=Ik7o+gA8Cd6NLCEyJLRQnm43YMqOig7MN49EWUT2M+o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LFYc0t/AtvkiFeGE9d+3Ok/4KzqoFr7JBpmwnJSoxpBUaG/6FQTHE1hfReNYjkvimIR6AukKEEEILtKDiLz1Y/0eW7HcCJK2IoK0R28h1xfXPftpEzRtA2XeBYG82ZGQY1mWpCCZ2VbQs4Sw8yv3FWg35xIigVE/rMf+Nj+IFuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQRerYa7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6B0C19422;
	Fri,  9 Jan 2026 03:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767928467;
	bh=Ik7o+gA8Cd6NLCEyJLRQnm43YMqOig7MN49EWUT2M+o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rQRerYa7s5Y8CSoeSxCBDvdWyedC25ArrV1F0ge19Pho4f0lEHcbNIdA8XdAH/OHk
	 pbaUsGoMIcpOtrmJgvQ6OrAiYPjHAA+QhrYkU5DMneDFVF+u0Dy80v/ILsN051IGlT
	 SoBrE3o+TxWvdnxv7GOeQivQET6kPEMcZKn5Ld97mTp1AsZXh1nX0hzmQ8IiSAKI1L
	 i2OiB4rA9Z50C+myQmasAVo5izfGOZ/qcYcFPE3IMHH7LZey1cmS7CkVPl6r92IHuP
	 4vi3UGpIXl8YAfIZoUeKIvbF3cpe+GO95my2m4k48HNhAIZp2VlSVkWJtCn5wJZR4O
	 cjcujb0JkiekQ==
From: Vinod Koul <vkoul@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 Yi Sun <yi.sun@intel.com>, 
 Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, 
 Yi Lai <yi1.lai@intel.com>
In-Reply-To: <20260107-idxd-yi-sun-dsa3-sgl-size-v2-0-dbef8f559e48@intel.com>
References: <20260107-idxd-yi-sun-dsa3-sgl-size-v2-0-dbef8f559e48@intel.com>
Subject: Re: [PATCH RESEND v2 0/2] dmaengine: idxd: Add basic DSA 3.0
 capability and SGL support
Message-Id: <176792846549.658957.142893606733069605.b4-ty@kernel.org>
Date: Fri, 09 Jan 2026 08:44:25 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 07 Jan 2026 16:02:21 -0800, Vinicius Costa Gomes wrote:
> Note: Marking as "resend" because the only modifications are the
> "Date" and "KernelVersion" in the sysfs docs.
> 
> Original cover letter:
> 
> This patch series introduces foundational support for DSA 3.0 features,
> exposing hardware capability registers to userspace in the IDXD driver.
> 
> [...]

Applied, thanks!

[1/2] dmaengine: idxd: Expose DSA3.0 capabilities through sysfs
      commit: 8308510b93650dcd83a7c6b9753dec1f90ca3e0c
[2/2] dmaengine: idxd: Add Max SGL Size Support for DSA3.0
      commit: fe7b87d908da33326fbf6fe2b3830426432ec66c

Best regards,
-- 
~Vinod



