Return-Path: <dmaengine+bounces-1767-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EE989B2FF
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 18:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09EB428331C
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 16:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821E93BB47;
	Sun,  7 Apr 2024 16:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Po0rrBfr"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599CD3BB30;
	Sun,  7 Apr 2024 16:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712507910; cv=none; b=Vi31eZNx+AFYzc7wqHT8rgOig4u8IryAIUB9peZjw2E9/08FTP9Iw/hhLQbsswGxiiSSnHMgEKQkLL7RIk7FmFmArwcwGI5gbKRwDfPeMRux9LyN4GP1lTtGOn50phQCjRJ+Kfkwrf9NdM63hWo8Q9QB/6IyFO7Rig50otek1YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712507910; c=relaxed/simple;
	bh=FC2XeXJApJNOlpgRA5p4bBH1dZS1UFHQ8ugXnRwZz1Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AJlJxCWY+f05pVCDe4XISgww2ptVVviTc+W80CKMod92id84FR3d8MVmYrn7Zgxloh+btjwcvhjmZHBrJPI2ltN6oHo3doqmpwCOcRKTJ+GXJhfoGhBlt2XEcTxmVc0ARkjbFNJXGl9zXq1RfOF0D2DgoGCFiPIN6zzJG8sn+xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Po0rrBfr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C538C433F1;
	Sun,  7 Apr 2024 16:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712507909;
	bh=FC2XeXJApJNOlpgRA5p4bBH1dZS1UFHQ8ugXnRwZz1Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Po0rrBfrl5QR2a1FgxUrfT0fes96f5Ihd0SNm0H1wOxlxqsVlEXaLsEdDAOHdeOUL
	 0eNj0D82upR9tL4ba/AdD3XvQ8RTr6H3WCQScVgEHPkW0EBk+idKl7ZGGsPFimY6gW
	 3t8NW+XBLypHJ29+JErzHiFw0jGQXMZ9mQTXFV1J9n72E9SWj9La2ElqFypNAbX3Lz
	 V+T/67Ah3hZqcI+Sw/V3G2pmB44zupLerDiNkR4PYGTaA771rX/egLP6nvMwwA3MWD
	 BYpU/OnUfPUFTIT71leZROAEMXL/u/SFagd84Vq8RFp8eDzvDG1Li4cDC8ZRfWgQy8
	 MjF2xRLetO1FQ==
From: Vinod Koul <vkoul@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 dmaengine@vger.kernel.org, Sean Anderson <sean.anderson@linux.dev>
Cc: Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Hyun Kwon <hyun.kwon@xilinx.com>, 
 Tejas Upadhyay <tejasu@xilinx.com>
In-Reply-To: <20240308210034.3634938-1-sean.anderson@linux.dev>
References: <20240308210034.3634938-1-sean.anderson@linux.dev>
Subject: Re: [PATCH 0/3] dma: xilinx_dpdma: Fix locking
Message-Id: <171250790684.435162.17890681359398162028.b4-ty@kernel.org>
Date: Sun, 07 Apr 2024 22:08:26 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Fri, 08 Mar 2024 16:00:31 -0500, Sean Anderson wrote:
> This series fixes some locking problems with the xilinx dpdma driver. It
> also adds some additional lockdep asserts to make catching such errors
> easier.
> 
> 
> Sean Anderson (3):
>   dma: xilinx_dpdma: Fix locking
>   dma: xilinx_dpdma: Remove unnecessary use of irqsave/restore
>   dma: Add lockdep asserts to virt-dma
> 
> [...]

Applied, thanks!

[1/3] dma: xilinx_dpdma: Fix locking
      commit: 244296cc3a155199a8b080d19e645d7d49081a38
[2/3] dma: xilinx_dpdma: Remove unnecessary use of irqsave/restore
      (no commit info)
[3/3] dma: Add lockdep asserts to virt-dma
      (no commit info)

Best regards,
-- 
~Vinod



