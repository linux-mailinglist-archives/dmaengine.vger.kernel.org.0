Return-Path: <dmaengine+bounces-7991-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 351ACCED3B5
	for <lists+dmaengine@lfdr.de>; Thu, 01 Jan 2026 18:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A934300796F
	for <lists+dmaengine@lfdr.de>; Thu,  1 Jan 2026 17:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C0C224B12;
	Thu,  1 Jan 2026 17:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cB82Mb4o"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF5B1C84BC;
	Thu,  1 Jan 2026 17:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767289294; cv=none; b=mrlbkKR2SHa3Xii/GABOjQx560SNn41dd6jB5AppUvpUp7HlQpeVK1Uvcsn2nfA4fwrqhCSH56DPxlUUXNjDR3qgpO4qLTJX+m0lurkTKKjQ19fv/cJkpdoH94ghJs5BU0qL4GLLj6aA9nWsUW7JuR/JmRtweRsY/8nj7XWnbbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767289294; c=relaxed/simple;
	bh=P1/z+ggHodxfiwF/y3Y8LXsHEgBGIcsN14k9+EHGsuw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dCUaIE3fysrQ3AQA5V2OmrFJ8IjG3IKePZUN06xv57U5rmZkCwDem83Dnt8ebZi3aqTCwBpv6NA8PJYh7EKt5NN6HIAaYZ4gH++0bNb/+5uLPNApLG9hF/pM0xn/ZJyGchz0oMrzw7yyp2g34MZ8cq2nrwba+Ll38LmMgiFi+wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cB82Mb4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7F8C4CEF7;
	Thu,  1 Jan 2026 17:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767289292;
	bh=P1/z+ggHodxfiwF/y3Y8LXsHEgBGIcsN14k9+EHGsuw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cB82Mb4oeBIwgoWN54pO7vcUzmGh5rWu6ImPZt2JIigS2vRQnRs3yZotaj4//An9U
	 r5gV/d6iz89C46iOTxtXC0/KU6eNwhE7nB0e+x1DR4dJlWYYYVtBDN2YaK/tkMR8jq
	 4gNeXUgCltNgtns/mt7Lw72bIZuPsRB1xq3/DW2BTzxyXGbRY2iAvUhT8pNB+I9V6n
	 9bnGY/Nxq3ocvm8734AC2fzP1MdJ29dsESQR1MIijMMC5Q76Xrc9cMNqt0iga6N57X
	 vt3LhPaRG3AcXxi2w1ka7H05/slUud6xIZYNi5Eye4VlfN1Kwd5VzBia4fvfrKNaZK
	 q0ipHcrVR72lQ==
From: Vinod Koul <vkoul@kernel.org>
To: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
 Janne Grunau <j@jannau.net>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20251231-apple-admac-t8103-base-compat-v1-1-ec24a3708f76@jannau.net>
References: <20251231-apple-admac-t8103-base-compat-v1-1-ec24a3708f76@jannau.net>
Subject: Re: [PATCH] dmaengine: apple-admac: Add "apple,t8103-admac"
 compatible
Message-Id: <176728928984.239319.10678694314115348401.b4-ty@kernel.org>
Date: Thu, 01 Jan 2026 23:11:29 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 31 Dec 2025 13:34:59 +0100, Janne Grunau wrote:
> After discussion with the devicetree maintainers we agreed to not extend
> lists with the generic compatible "apple,admac" anymore [1]. Use
> "apple,t8103-admac" as base compatible as it is the SoC the driver and
> bindings were written for.
> 
> [1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/
> 
> [...]

Applied, thanks!

[1/1] dmaengine: apple-admac: Add "apple,t8103-admac" compatible
      commit: ad9a3567d02a5b6e866b58fc756d0d79f43b7412

Best regards,
-- 
~Vinod



