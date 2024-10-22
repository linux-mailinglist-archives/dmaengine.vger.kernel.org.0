Return-Path: <dmaengine+bounces-3400-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EA89A9887
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2024 07:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 637541F24059
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2024 05:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0373B14A4F3;
	Tue, 22 Oct 2024 05:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6OfitfW"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF99C13664E;
	Tue, 22 Oct 2024 05:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729575164; cv=none; b=kz0vX91sF5EGNZPbMUr6Up+RL6/W9mrSxo2cq3iNzVOF7q//16XrpgGDPmju8N3BOj/sRr5rOp0yHfhsAhofztgeLNX8USwyavbGlK3483S0ctmlv2h4w2hhN9CBMOiaBdznEvYTF+OtqkQPxAMxo44IpThpjMU98hOT2q9XwEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729575164; c=relaxed/simple;
	bh=LQmRQVLyBjyaDESGZpvscgdg5HdPKWGlhEVGHcB4LkI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jiAykHHxzLKHDEppVIEX7H2pYaLJwNi1MwhmDgB+FcP2Ua7NZH4Wk0P+ku9iJPpVYPGpqAbxovKdyLtvegXslOPRPCCkf11T0sga+5sHz3AZKHrMId9mboK04w0w+ZlupkBFAvJL+rsqvV50X1y7AYh2jN33bprg9JBp1MLSJsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6OfitfW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C3CC4CEC3;
	Tue, 22 Oct 2024 05:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729575164;
	bh=LQmRQVLyBjyaDESGZpvscgdg5HdPKWGlhEVGHcB4LkI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=S6OfitfWTAZbLDu9ZZgCsfsmPBCC6s3faq018SpS9cKC0j11FEhF7GkcKz+tvv6ic
	 Hz/oCnEYijb7eKO2QDrHp5uZjnjU6VtblyjmEFF0PoBZNgs/xiQhtyoGDpmRRL9vX2
	 ZwRRdI69U7V+nE6CxidNFLw7+/ySvvcBju1AxCa65csdfyhDjBTo0HdMUZtDvwlh6i
	 aFKOlvVCSY+BniIZwV/AH1Q0L7nhN3zx9ufs319K08+SY9MLzvx/s/RZe24KeGxldS
	 lxcv6p1FP0UV3XsgjfYd+HWnNFGURWjYBPX4DeRLrs1ZDxF9MicBsv29XnWoiVNKsG
	 B1OBtKHSno43Q==
From: Vinod Koul <vkoul@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
 Mikhail Arkhipov <m.arhipov@rosa.ru>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 lvc-project@linuxtesting.org
In-Reply-To: <20240923193703.36645-1-m.arhipov@rosa.ru>
References: <20240923193703.36645-1-m.arhipov@rosa.ru>
Subject: Re: [PATCH] dmaengine: ti: edma: Check return value of
 of_dma_controller_register
Message-Id: <172957516287.489012.10792417455228330513.b4-ty@kernel.org>
Date: Tue, 22 Oct 2024 11:02:42 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 23 Sep 2024 22:37:03 +0300, Mikhail Arkhipov wrote:
> If of_dma_controller_register() fails within the edma_probe() function,
> the driver does not check the return value or log the failure. This
> oversight can cause other drivers that rely on this DMA controller to fail
> during their probe phase. Specifically, when other drivers call
> of_dma_request_slave_channel(), they may receive an error code
> -EPROBE_DEFER, causing their initialization to be delayed or fail without
> clear logging of the root cause.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: ti: edma: Check return value of of_dma_controller_register
      commit: 83158a3a712ad6ebdebd470d25af04c66c4e2223

Best regards,
-- 
~Vinod



