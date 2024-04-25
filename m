Return-Path: <dmaengine+bounces-1959-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F678B1DA7
	for <lists+dmaengine@lfdr.de>; Thu, 25 Apr 2024 11:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE6822857C7
	for <lists+dmaengine@lfdr.de>; Thu, 25 Apr 2024 09:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74C8127B50;
	Thu, 25 Apr 2024 09:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7PFA0er"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE051272CB;
	Thu, 25 Apr 2024 09:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714036652; cv=none; b=aKJb+30xLZeSKqP+2ncbsHvoQ0kemltRkAdJo8cehH50VfZfOkXrIeyXzgppiZRajjr+5xwb+/v6flra43KvXV2ouSBJT0cCKkPEfbR2sJfekX11OaHJZMGwgqAUVV96znEtAzCkBU7LfGk3/Bc2zFo8wzNPMziW/b6XQ5U+IYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714036652; c=relaxed/simple;
	bh=X8lhwntGfW+O+YDqqBjlPaZLgcwwhtDsgXmAr/fKAIU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hZviNcdk3422nBVGOcGi1yefdu4HoCDTRQ0hMzHgc02Qkq42r2vgXdinvoMmPGug1meF7RmlFMlsyx14d6KrLTsosa7Bw/QaXblXp7NhMCsnVjuiiBdEBeI2Xsj+cUxpdxplt3E692znF2KzKw5e11IK/veSqHfegR3s1JCMNZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7PFA0er; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51C3C113CC;
	Thu, 25 Apr 2024 09:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714036652;
	bh=X8lhwntGfW+O+YDqqBjlPaZLgcwwhtDsgXmAr/fKAIU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=B7PFA0erizox5Y4/FJcp+jCrRRxq4bMFUOLKQYCuhHzC/Laj+VVYTLSLGaHOOQV7H
	 7yXq8vrtKaybCGlmWVoCY+0JLCBnkKqvtipZM562TBl+pWPQExd6zHn9Bv8oR0WnSo
	 BJ5RoFsOix6XB4HXQX43vWh8aOwf+fyoZUYOaQYolX6+7i6G3NihOOeZjnhA1mTqiL
	 e6aLIgsfSQQ2OTyExzd3YIhcSdx+7z3Y6djo6+75un96f7H1bY+Gomw/x8nH32jp7T
	 oIOXY2PXrDtJilcvk0rtCehgdR+tVUAGu0srHHf7cxlKILyG2WCqaEqH20vruiMLrG
	 eogW7NqDB1S0g==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev
In-Reply-To: <20240418185851.3221726-1-Frank.Li@nxp.com>
References: <20240418185851.3221726-1-Frank.Li@nxp.com>
Subject: Re: [PATCH 1/1] dmaengine: fsl-dpaa2-qdma: Fix kernel-doc check
 warning
Message-Id: <171403665042.79852.486189247427998901.b4-ty@kernel.org>
Date: Thu, 25 Apr 2024 14:47:30 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 18 Apr 2024 14:58:49 -0400, Frank Li wrote:
> Fix all kernel-doc warnings under drivers/dma/fsl-dpaa2-qdma.
> 
> ./scripts/kernel-doc -v -none drivers/dma/fsl-dpaa2-qdma/*
> drivers/dma/fsl-dpaa2-qdma/dpdmai.c:262: warning: Function parameter or struct member 'queue_idx' not described in 'dpdmai_set_rx_queue'
> drivers/dma/fsl-dpaa2-qdma/dpdmai.c:339: warning: Excess function parameter 'fqid' description in 'dpdmai_get_tx_queue'
> ...
> 
> [...]

Applied, thanks!

[1/1] dmaengine: fsl-dpaa2-qdma: Fix kernel-doc check warning
      commit: 39def87bc7cae8ddfd6703051fc59931f152a2cb

Best regards,
-- 
~Vinod



