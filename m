Return-Path: <dmaengine+bounces-4583-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCDDA47CE2
	for <lists+dmaengine@lfdr.de>; Thu, 27 Feb 2025 13:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F7918929A0
	for <lists+dmaengine@lfdr.de>; Thu, 27 Feb 2025 12:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F9822A4C5;
	Thu, 27 Feb 2025 12:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dr5FnoNJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1DE22655E;
	Thu, 27 Feb 2025 12:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658048; cv=none; b=gcNVfkmTJ7kLSLVRDYpVAXwyT9+gr7+6zxpc8gXtll9+wjlDzGfh+9bcRMZ6qPDGvKVVTNecHeRMjAeJz7RgKYW2m/ccMEUMhUSDr2aIXj501HAE//P+7aiMHWOBca9NsPSWixXoDwM97Ubhw1NqQwRaTM//+RNBQJrnGlYtEhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658048; c=relaxed/simple;
	bh=Bz3utF3aP0323wmwhVGVsyigkVsa58YZDdZIVB6qyIs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=prmPsDT6dnkzlpz3BpQ1QkRgkg9vwMFBv+d0OIiumthk2AZ2iULloj0DzGKNE1xdbHCFvQTsn5ydr9cYROzLJFC29gHOt8CUbO/jmeG+sFdx8Sv0B256iaEVy9tFqjfga0IM3pTp29HmLUj18GeDG7vou9XG7LclQEOBnY5xod8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dr5FnoNJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC14C4CEDD;
	Thu, 27 Feb 2025 12:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740658048;
	bh=Bz3utF3aP0323wmwhVGVsyigkVsa58YZDdZIVB6qyIs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dr5FnoNJeFiRyFq2O0Wuij8+4j04cFcscbmXbE5BNH78XTaaIi1VF6vTSRKO7MkJR
	 rDy4kev2IWjNkZKV20kIUyzdhVwbcEqe7r39rjAA83w9mcoX10YlUnfxd5pM9gQGy3
	 70LShsLJJqoDD/W4ZvhuZDHz3TVzLtveSAeE5WQQhWqt2vU3G/cIxcWb36TiIrL3Sk
	 16JKlGkrDAAmBEZgmLW0s+9u8b98FyfVG3LZKIhNobILfFULW8jXWH0EBsGFQYYpZi
	 gyN4NI7g9+Wx9JIsccJ+iq0tDnlasj5sDzQ1r9zGt/fFmouANHo1rRi7ZvqCm87P12
	 SCVARjEit+N7w==
From: Vinod Koul <vkoul@kernel.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Amit Vadhavana <av2082000@gmail.com>, Dave Jiang <dave.jiang@intel.com>, 
 Fenghua Yu <fenghua.yu@intel.com>, Kees Cook <kees@kernel.org>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: David Heidelberg <david@ixit.cz>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, dmaengine@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org
In-Reply-To: <20250208223112.142567-1-caleb.connolly@linaro.org>
References: <20250208223112.142567-1-caleb.connolly@linaro.org>
Subject: Re: [PATCH] Revert "dmaengine: qcom: bam_dma: Avoid writing
 unavailable register"
Message-Id: <174065804355.367315.5192736172350019547.b4-ty@kernel.org>
Date: Thu, 27 Feb 2025 17:37:23 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 08 Feb 2025 22:30:54 +0000, Caleb Connolly wrote:
> This commit causes a hard crash on sdm845 and likely other platforms.
> Revert it until a proper fix is found.
> 
> This reverts commit 57a7138d0627309d469719f1845d2778c251f358.
> 
> 

Applied, thanks!

[1/1] Revert "dmaengine: qcom: bam_dma: Avoid writing unavailable register"
      commit: e521f516716de7895acd1b5b7fac788214a390b9

Best regards,
-- 
~Vinod



