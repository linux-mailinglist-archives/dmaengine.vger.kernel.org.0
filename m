Return-Path: <dmaengine+bounces-7694-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C5BCC4850
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 18:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8402530CC57E
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 16:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB002D9EFC;
	Tue, 16 Dec 2025 16:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/+gXz3x"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D512D8796;
	Tue, 16 Dec 2025 16:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765904188; cv=none; b=AOM8NuCjougclU5jaL+NSnH0UGFh4XJJnsXYSrgxsbokyFfB0Z6Orj2fCdRPXWGXvFo+yPNJ83EEl6mBNrf1rOVeqwACTErE1hhgd/j/Aa6fcSYi5foP4SdHtXVbM8UsilNejK6uiFHPw4KqzQ0bKARLUyvJc8hUc0qGPegbXVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765904188; c=relaxed/simple;
	bh=4C+PIkTMFYRa2XqQ2KK0/ciIESaCrmvl0r0Ji4+puoE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hoQvwiHIQxkeYP1joyHFIOwGV2PxfZEfljIvuLiL5NqITmbl5nSlA1GZ6EQcqRf6jocJIguFkN1cNUu5Bg+haC6/iXJDYOrZMHnAdOdLGoi70cr7xRz6AE+UOCKSRGGC/kNVnwtlXFzDdck62eiI2z4f8oERuJUEGDYd7bC9ezo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/+gXz3x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80EC3C4CEF1;
	Tue, 16 Dec 2025 16:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765904188;
	bh=4C+PIkTMFYRa2XqQ2KK0/ciIESaCrmvl0r0Ji4+puoE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=h/+gXz3xsDpqQv5g+n31H6zOzx+Wyz3VdnU+pbrWnZ3fWgJm/x3HYRry2p9GIBcJZ
	 VojuUSWl9LW9xJXwuK+4oHLBT5iTxYUmKDfXk5pwVpo5cgz3PJ6sYwfPZGxKmseuSf
	 wezUceTeUxMPuM+xZ+t2A3PmOom0Eane64SI7OQ2wGu/55EOkaECv/Hk55TXwGyZWL
	 2Od5yb6qgS44g8kszwd6k4ucPEpXqBoF/UTOwvmF/zpzjydAGCIEJXnxmA+LCH9LOa
	 sDQzke3P/yBRvTZfnNPzV9/+xeptmD1PC4rQ6cAwrzMNL+tg/gYPY7T7tc/Snt1v2C
	 yy9zADTiB1BNQ==
From: Vinod Koul <vkoul@kernel.org>
To: radhey.shyam.pandey@amd.com, michal.simek@amd.com, 
 Suraj Gupta <suraj.gupta2@amd.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251021183006.3434495-1-suraj.gupta2@amd.com>
References: <20251021183006.3434495-1-suraj.gupta2@amd.com>
Subject: Re: [PATCH RESEND] dmaengine: xilinx_dma: Fix uninitialized
 addr_width when "xlnx,addrwidth" property is missing
Message-Id: <176590418615.422798.3456929870875820677.b4-ty@kernel.org>
Date: Tue, 16 Dec 2025 22:26:26 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 22 Oct 2025 00:00:06 +0530, Suraj Gupta wrote:
> When device tree lacks optional "xlnx,addrwidth" property, the addr_width
> variable remained uninitialized with garbage values, causing incorrect
> DMA mask configuration and subsequent probe failure. The fix ensures a
> fallback to the default 32-bit address width when this property is missing.
> 
> 

Applied, thanks!

[1/1] dmaengine: xilinx_dma: Fix uninitialized addr_width when "xlnx,addrwidth" property is missing
      commit: c0732fe78728718c853ef8e7af5bbb05262acbd1

Best regards,
-- 
~Vinod



