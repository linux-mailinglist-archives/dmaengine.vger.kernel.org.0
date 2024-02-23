Return-Path: <dmaengine+bounces-1088-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B524861110
	for <lists+dmaengine@lfdr.de>; Fri, 23 Feb 2024 13:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B85D1F2513C
	for <lists+dmaengine@lfdr.de>; Fri, 23 Feb 2024 12:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4278D7CF21;
	Fri, 23 Feb 2024 12:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hn2G4CzO"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CA77B3E2;
	Fri, 23 Feb 2024 12:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708690109; cv=none; b=azPjzZDC327NBPdR+5tc8JINrWrmsLCeVFXqAnoWvFaW2OVAlkgL1WF4Gv+AyjLI8cFUi8XJvji0m+AIRSkFB+Ulr4M3Uir1zYzf7aYfZIxpY5hGGiW1gpgCEGNCJ6N8rIhgngVSUt3JgEFx+uA5+tRe0THOrFWDOaPvGfsqQlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708690109; c=relaxed/simple;
	bh=uoiiQeQo2YtOx4mz4CMGt+q1UJv5HBbeHyEhs6N2jNU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HchxaXM/V4hQ4EEBIgNE5eT4TRJF7+3tIAZKnQDh0r05us3w1VGprnpTNoqLv1rjIKNB/uSkO5GO2/P0KbslKObZfEOekUFMJqtqokSKHhp55lsrp8ICwAdFOHoDH125Zu/KZKUr/RjWPVjux4rzxb3pzARsv5MPfGM+6lu/As8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hn2G4CzO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C300C43399;
	Fri, 23 Feb 2024 12:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708690108;
	bh=uoiiQeQo2YtOx4mz4CMGt+q1UJv5HBbeHyEhs6N2jNU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Hn2G4CzOcRiSkCT2clLatUpTDnWiim/g1qjFGKGkDIKmxjCg5CmLgOVItBsmdIEVx
	 Y6sQoV/3kALRpK+qj3HUC01RhJh7SM8xUXAlb8V0YH14gD/E32jclpPGTRe9i4VEYP
	 egBCRcPs1kQarE08SvdBVBWQB5b4tzMb2b5G4HzWgUJLxBZwJA4I/PzvCliJMaoyZ3
	 q3Zg1vJOQriu4nK9qg94CycAd8jqc6N4AkFDChXnEjb2SFo4K5UGSNoaQoTL4zPTXu
	 ECT/gbD8vweIcmvIIP/a3PGPsfkbRw09GFjv4KM7QSzzFowCiUAWskGPUZdkQwGBcb
	 tbx42pljS286w==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev
In-Reply-To: <20240219155939.611237-1-Frank.Li@nxp.com>
References: <20240219155939.611237-1-Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/1] dmaengine: fsl-qdma: add __iomem and struct in
 union to fix sparse warning
Message-Id: <170869010682.529426.9943525377594193452.b4-ty@kernel.org>
Date: Fri, 23 Feb 2024 17:38:26 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Mon, 19 Feb 2024 10:59:39 -0500, Frank Li wrote:
> Fix below sparse warnings.
> 
> drivers/dma/fsl-qdma.c:645:50: sparse: warning: incorrect type in argument 2 (different address spaces)
> drivers/dma/fsl-qdma.c:645:50: sparse:    expected void [noderef] __iomem *addr
> drivers/dma/fsl-qdma.c:645:50: sparse:    got void
> 
> drivers/dma/fsl-qdma.c:387:15: sparse: sparse: restricted __le32 degrades to integer
> drivers/dma/fsl-qdma.c:390:19: sparse:     expected restricted __le64 [usertype] data
> drivers/dma/fsl-qdma.c:392:13: sparse:     expected unsigned int [assigned] [usertype] cmd
> 
> [...]

Applied, thanks!

[1/1] dmaengine: fsl-qdma: add __iomem and struct in union to fix sparse warning
      commit: 1878840a0328dac1c85d29fee31456ec26fcc01c

Best regards,
-- 
~Vinod



