Return-Path: <dmaengine+bounces-5168-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C81AB6ECE
	for <lists+dmaengine@lfdr.de>; Wed, 14 May 2025 17:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 430FD1720F8
	for <lists+dmaengine@lfdr.de>; Wed, 14 May 2025 15:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E393127A11A;
	Wed, 14 May 2025 15:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJFdA2tm"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4B71C84AF;
	Wed, 14 May 2025 15:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747234988; cv=none; b=RLTt5wMMnCmJmzaAu0lrdFJX+80jq+GEEslQR2uwVHFgEovK3Bg8tbPuGbsc3GgU+CL6g+8duBJ51kgL5EHT6L/eP2Gq68wbFeP8wLfMHQoWv0/BgaQzAPosdvUzccoe/yyHmgK10HxhOA5PQDliDXB9+acG20cvIc2AwLhd/1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747234988; c=relaxed/simple;
	bh=THM7iq9nTJk9Q8gCDTAEMYHnO9fGV9dakzHktzYuPNM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ivVwFv/O7l+W7eh+sYTu3pzZvgRzS+hYlWM2IbZa2uk9srFKtYHUthYN2h17iHmVgd37v9xkktXlICVGFObOCu/1ue0KTbBneYC/mfEHB6HCkYj3NwHVYT634MBr+Shy7ok5xAhTcsKG6hkrNre5O3YTmRR5242pNCWCDWS2mx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJFdA2tm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59A0C4AF09;
	Wed, 14 May 2025 15:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747234988;
	bh=THM7iq9nTJk9Q8gCDTAEMYHnO9fGV9dakzHktzYuPNM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kJFdA2tmwz+CrNON+B4SKIXvoPpy0j2SdGnod5EGPK+il+bqaGo6Aggz2mY6GN+mA
	 SuWQzCyqDZ8EfCfJwhGgu/nhoCmj7/+pjSVFvXOSD62x6U0HNXabn879lLqX1KEBQa
	 Sp7TGpZjlfmxaI9L5yUhsNmPtSlro7MowYTzMxiF/wHBHXZKYK859QPnnHNpy/2lHq
	 EG8yJotWKKmxk/x5cxnvZA8Y46TwPbHSJiU8MP8A95YC1LqSwHY4VO9r0A1Jg2sJIT
	 z8Sx22FLsr4mrCNBLoEYxFYT8XWsVCQ0nzr2xk0T9aUynYk+3e0TNG5ntRmaETV7LA
	 vT+ErACEESmYw==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, Ben Collins <bcollins@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <2025050513-complex-crane-2babb6@boujee-and-buff>
References: <2025050513-complex-crane-2babb6@boujee-and-buff>
Subject: Re: [PATCH v2] fsldma: Set correct dma_mask based on hw capability
Message-Id: <174723498654.115803.14478173273687526068.b4-ty@kernel.org>
Date: Wed, 14 May 2025 16:03:06 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 05 May 2025 13:53:07 -0400, Ben Collins wrote:
> The driver currently hardcodes DMA_BIT_MASK to 36-bits, which is only
> correct on eloplus:
> 
> elo3		supports 40-bits
> eloplus		supports 36-bits
> elo		supports 32-bits
> 
> [...]

Applied, thanks!

[1/1] fsldma: Set correct dma_mask based on hw capability
      commit: 00ff4d68a9ae4c9315c166f1fafa47f4c0a65f6f

Best regards,
-- 
~Vinod



