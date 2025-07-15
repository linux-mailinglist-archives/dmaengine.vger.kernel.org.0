Return-Path: <dmaengine+bounces-5828-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 099FCB062D4
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jul 2025 17:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D9451AA2950
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jul 2025 15:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F7724A069;
	Tue, 15 Jul 2025 15:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsK6yEdR"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A03D248F60;
	Tue, 15 Jul 2025 15:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752592928; cv=none; b=UzrI793YsITJafExI0uAaOgdqrun6v0GY9cJ16gm4HfSalc94Z1ssFORVt8fZ1cAnz9tCmDgdLucoDmwQk8/UUwTdxHCmEPnj+gvYCNip4LRTu8z8hFAMjW8I1ih9CVvrcYAMCCcpoO3KmThpl0T+P5acyTPwGUmqtTT0Cx8fwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752592928; c=relaxed/simple;
	bh=s8z2gEmAsy45+Fv9f8lyhExZXqM5JzSnUHVuX1ptM/w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IsshwUzBKgO+iz+YgcxqIr9NETzDLiqZfaoENJKvbQvB8Q/f78gDZNr/mTRdGNd/D7RlawTarKWxzVxacPOD4MQO3nZRHlTvBqHw4J0P3/lOqB5sE6J1sFp395ATDRZxY3hcOIZe6t4iOjTtzc38sc3XnMy+gcUP7WoV2UVOY3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsK6yEdR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C923C4CEE3;
	Tue, 15 Jul 2025 15:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752592928;
	bh=s8z2gEmAsy45+Fv9f8lyhExZXqM5JzSnUHVuX1ptM/w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DsK6yEdRRCYUtJpZtbuXBVKOQQ5nfSjviSXhRa7JmLQBhv/Lc48H/7r4XjowmRawI
	 zJKayHN0pK58+Fqitx3L61bYddkqDWTgPp1+17LMqB3sgGlklktN+bVN2NLy4EjqAo
	 WwayrWRf7/z8ztCbBKW/5+CuVouIIwcMAZ6OPU9RQFJ1I1jQf3X4c2Y5g4o28sZmiK
	 ynRQsQ1mAw/8u+U3SsmCuBLkAF7sZd7Jrm80cunxzQSbzDvTXh/Bk9RCE6HI1wu+Zj
	 nK3D/6shjhrLcq/0vi4n+La4EZ/pIFJdAdx0H3CpndmmqPlhO7UD7koNdfYtsn6Hhr
	 spI/GgHEUR6Kg==
From: Vinod Koul <vkoul@kernel.org>
To: mani@kernel.org, Abinash Singh <abinashlalotra@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abinash Singh <abinashsinghlalotra@gmail.com>
In-Reply-To: <20250705160055.808165-1-abinashsinghlalotra@gmail.com>
References: <20250705160055.808165-1-abinashsinghlalotra@gmail.com>
Subject: Re: [PATCH RFC] dma: dw-edma: Fix build warning in
 dw_edma_pcie_probe()
Message-Id: <175259292621.543905.5838200154800264729.b4-ty@kernel.org>
Date: Tue, 15 Jul 2025 20:52:06 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Sat, 05 Jul 2025 21:30:55 +0530, Abinash Singh wrote:
> The function dw_edma_pcie_probe() in dw-edma-pcie.c triggered a
> frame size warning:
> ld.lld:warning:
>   drivers/dma/dw-edma/dw-edma-pcie.c:162:0: stack frame size (1040) exceeds limit (1024) in function 'dw_edma_pcie_probe'
> 
> This patch reduces the stack usage by dynamically allocating the
> `vsec_data` structure using kmalloc(), rather than placing it on
> the stack. This eliminates the overflow warning and improves kernel
> robustness.
> 
> [...]

Applied, thanks!

[1/1] dma: dw-edma: Fix build warning in dw_edma_pcie_probe()
      commit: 3df63fa8f2afd051848e37ef1b8299dee28d4f87

Best regards,
-- 
~Vinod



