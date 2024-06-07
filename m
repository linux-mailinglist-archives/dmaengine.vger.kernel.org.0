Return-Path: <dmaengine+bounces-2311-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C317900B7F
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jun 2024 19:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F408F1F23197
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jun 2024 17:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2685019A299;
	Fri,  7 Jun 2024 17:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTpFoVBi"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFBC1C33;
	Fri,  7 Jun 2024 17:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717782432; cv=none; b=hQa0nIWBKwXCSWiVNvQKwKheW6H9Rf/ravWg9RJBhtpEmLE/ZrD7Wke4sgKrYG9/qHLdyV5pMAmJGsBX7zPkUSe1oBdnYkoFMD/uQioRIS6FCwMQ/QGhbUrYjgk0loJ/YtahY5wzzpS2Va+2GXgeX+NDfGHl0ynF3daIIBkxBs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717782432; c=relaxed/simple;
	bh=0TNFTo/s6/X/Qtq2EF0zVEMS48LUE1ttF4Hoam+lF1E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BcFmwSDnmtsprODtH2wAHW3MaXnjADf9JgSXOF2Se6pgFeSxtLG/5oiVCTJDS6bjrKUHUA171RPQMesgXEE0csCE6l5vDv45KqullAYXu+T1XR0H+mOQPhJ1XZVEByhGwbZ37U0u1b/CM81wQ8D+8dko2L5FlpOvvT9g3Udvlbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTpFoVBi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F188C2BBFC;
	Fri,  7 Jun 2024 17:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717782431;
	bh=0TNFTo/s6/X/Qtq2EF0zVEMS48LUE1ttF4Hoam+lF1E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pTpFoVBiU99w+UJuMKSOOROofI6vDSBs15yxr9i7YQRPAXNpbb7TckIRtBTZKmFiK
	 FPXIJd32i2/mtG6YlR5+QzdQobENKFL4vOn+QNJWNpdNce6lyKJJf2zTUPvDBDLY6j
	 o+jxy1FZoJAHwBD2Iu/hbgTIHGY4xuJhFyR63ChUTmghRB1jaIYGT0Z2MBnexn1c5A
	 Hz4Q07oAuiyuhORtKwgRda2xH7LX2NlpzM889qRk1v2i6FKv5p8yZXPLPx8cfK27AV
	 YC9Dq0bOJizCtJ6RGQ/t2V3k3schzzF5837MXGhWWbA7yay/5MbyOBvk8AW9bxmYZu
	 62/sGi50wXIyw==
From: Vinod Koul <vkoul@kernel.org>
To: Fenghua Yu <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
 Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
 Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <20240606-md-drivers-dma-v2-1-0770dfdf74dd@quicinc.com>
References: <20240606-md-drivers-dma-v2-1-0770dfdf74dd@quicinc.com>
Subject: Re: [PATCH v2] dmaengine: add missing MODULE_DESCRIPTION() macros
Message-Id: <171778242916.276050.11535562159320987467.b4-ty@kernel.org>
Date: Fri, 07 Jun 2024 23:17:09 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 06 Jun 2024 13:00:01 -0700, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/idxd/idxd.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/ti/omap-dma.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/dmatest.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/ioat/ioatdma.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: add missing MODULE_DESCRIPTION() macros
      commit: 6e2fb806e08d46cbeb96c1000ef531a92d3b2e9a

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


