Return-Path: <dmaengine+bounces-1780-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6A389B31B
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 18:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1234D1F22F26
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 16:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4712440840;
	Sun,  7 Apr 2024 16:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDKcT/JR"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2103FE2B;
	Sun,  7 Apr 2024 16:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712507966; cv=none; b=e1D9xOwtX1CRDb5KdNCmNLO79mGEtqsf6IIzD6MnuD7R5eFVEkCq39bsvBtx6PLSd1W1FfHoTTSdD+zDmaMOrU4F8V2IM2vyRRufGIDOhPK/6k5k5bIC3Ktei+OQ+n7qQ0E/Lr6Bl2yw31Qes9MgH0nEAQ771BHKzwWeMZmm84U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712507966; c=relaxed/simple;
	bh=++zImj/cC5IZlKqUtEq23pKi22/Nuz6nf5FucPhn8tU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BVu2SppQe3fPOtA7aQJcX18fyJDSn2FrfJ0UtxoZDE19ThURAhmXuV619jUO6C6EcOyLhG5rEOMyYhW1cy4wW8wqKEDMa+IT+T6NkSuyYZvlqeRxppkHa97v6JtI5hzpqa4oiQ+Ec/J6GVEWxvBjzfC+7ZDTeZxKdOxlDgLTUrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDKcT/JR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9A0C43601;
	Sun,  7 Apr 2024 16:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712507966;
	bh=++zImj/cC5IZlKqUtEq23pKi22/Nuz6nf5FucPhn8tU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qDKcT/JRAslHR1YAWcLwxkOZdV5hEld49tuZKnznMRfEBZfeYJ3O5GZb5kyFGjOlV
	 liQiCncdJ+tmQoS8jyfhGfKpK61pnaQpTRVchdtbR2N4YMq2n3bXPoH/cOc0qV56/Y
	 7pP1XEVt1UfgaRvvQPpjgVmDjl9JDqjJHTZ/cUSl/LONrTRHLfG1TufCJ1XH+T6t7K
	 O0dUihjBdCLhEUSW1rj8Yd25lPBxXVXHC8dQ5x9D4/9Gz7XtfLTAyUAenCAumCbprY
	 vbhmoeTN+t9cjL4PrrZqrejezFf5ywYvtgbcQyRw9KeiLINp/8H4Ipy8mbB86TAqmM
	 SzqoRNyNms3lg==
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev
In-Reply-To: <20240320-dpaa2-v1-0-eb56e47c94ec@nxp.com>
References: <20240320-dpaa2-v1-0-eb56e47c94ec@nxp.com>
Subject: Re: (subset) [PATCH 0/4] dmaengine: fsl-dpaa2-qdma: Update DPDMAI
 to support MC firmware 10.1x.x
Message-Id: <171250796406.435322.4332656364522147133.b4-ty@kernel.org>
Date: Sun, 07 Apr 2024 22:09:24 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Wed, 20 Mar 2024 15:39:18 -0400, Frank Li wrote:
> First do some clear up. Remove unused macro and function
> Then update DPMAI API to support MC firmware 10.1x.x
> 
> To: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: imx@lists.linux.dev
> 
> [...]

Applied, thanks!

[1/4] dmaengine: fsl-dpaa2-qdma: clean up unused macro
      commit: 06db9ee8b42ef833e3941ef3c7795c1bea37212c
[2/4] dmaengine: fsl-dpaa2-qdma: Remove unused function dpdmai_create()
      commit: 26a4d2aedac28640c1fbb3761d940d99eff44488
[3/4] dmaengine: fsl-dpaa2-qdma: Add dpdmai_cmd_open
      commit: ebf850697a9daa9f59b902ea1e547079d426618b

Best regards,
-- 
~Vinod



