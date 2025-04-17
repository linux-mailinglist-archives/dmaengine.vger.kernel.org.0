Return-Path: <dmaengine+bounces-4914-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07504A92131
	for <lists+dmaengine@lfdr.de>; Thu, 17 Apr 2025 17:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6119D19E5FD6
	for <lists+dmaengine@lfdr.de>; Thu, 17 Apr 2025 15:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F7625393D;
	Thu, 17 Apr 2025 15:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9x6243x"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D247253923;
	Thu, 17 Apr 2025 15:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744903130; cv=none; b=cubwhG6ekHzFsGhORT8SFH/t9Jsl+2Cex+bGP06IXnexFCdVJEjjXPVHqRhZ84WvumGOm1CLlnsgSM3uoREpmL2VeHVelR0uA5MuEsrlpvnf1tv0OofI/BzgrV3Ah/HpjEXhMe9a5OaMiCfjxObkIA5ff+IRYZyo930+Em36hcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744903130; c=relaxed/simple;
	bh=+bdDTh1okUrmA3pbK32EGiO3ShMado6K4TYHtvdpMdU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Tl9tKfiMqou5CzT8dTSQyPK5Bw9cCOJ/tdsRcq6zNvx+S1hdymEVvZI/dl7o4JNGgkYvb6S5Hjx0plSC4JQzEZC4lwkuSD8vLEXMPsWZa+837yasIZT66j+PSqhAjscRoSpBpejvfF7HNsqy9tK3r1saMh09WzW112rxoOee88A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9x6243x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66643C4CEE4;
	Thu, 17 Apr 2025 15:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744903129;
	bh=+bdDTh1okUrmA3pbK32EGiO3ShMado6K4TYHtvdpMdU=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=e9x6243xl3iyDkNO6y5fKod9983QH2ZwHhW4FCOBdUCAIJIZc4RjyU6ghRKTOHwFD
	 BhUvsPZ0HKs60B14dd7kV8i/fkZTaPyytm9d3tpTH0cw8U2nUe9iJ7yqlcG46ZpiIk
	 SQi7vHfXOlHblhzcAo/q5cKH20Ii0AS1Ev/kA+oIVsapHzRJO9+CN7WYDuHaqXJlL3
	 /8U2QjmSKjLrDqeyv1hhvTKeXkkosTenbwIRLHu21XXonG4+6YF7WqTMLONutH0gzk
	 QvAGA888jADymNiyWPW+Oxn3kCATFbrylgkjDQKiPAmFQz/Ab4NYSIiYhZxjtGPJ+8
	 7BYvRizdU+/Vw==
From: Vinod Koul <vkoul@kernel.org>
To: nathan.lynch@amd.com, Basavaraj.Natikar@amd.com, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Eder Zulian <ezulian@redhat.com>
In-Reply-To: <20250415121312.870124-1-ezulian@redhat.com>
References: <20250415121312.870124-1-ezulian@redhat.com>
Subject: Re: [PATCH v2] dmaengine: ptdma: Remove unused pointer
 dma_cmd_cache
Message-Id: <174490312803.238725.14116695966907460215.b4-ty@kernel.org>
Date: Thu, 17 Apr 2025 20:48:48 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 15 Apr 2025 14:13:12 +0200, Eder Zulian wrote:
> The pointer 'struct kmem_cache *dma_cmd_cache' was introduced in commit
> 'b0b4a6b10577 ("dmaengine: ptdma: register PTDMA controller as a DMA
> resource")' but it was never used.
> 
> Changes since v1:
> - Remove the 'err_cache' label and return -ENOMEM directly instead of
>   assigning -ENOMEM to 'ret' and jumping to the label, since there
>   are no unmanaged allocations to unwind. Based on suggestion from
>   Nathan Lynch.
> - Fix checkpatch.pl error: ERROR: Please use git commit description style
>   'commit <12+ chars of sha1> ("<title line>")'
> 
> [...]

Applied, thanks!

[1/1] dmaengine: ptdma: Remove unused pointer dma_cmd_cache
      commit: f087965ab4aaca653d19ea3909b42e7ef2b64ba0

Best regards,
-- 
~Vinod



