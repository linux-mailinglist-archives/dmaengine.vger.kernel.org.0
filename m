Return-Path: <dmaengine+bounces-1605-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FAF88F8ED
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 08:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5134296F84
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 07:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC780548F6;
	Thu, 28 Mar 2024 07:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXGQffug"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CF1548F3
	for <dmaengine@vger.kernel.org>; Thu, 28 Mar 2024 07:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611595; cv=none; b=EDUS8IYup4JJ41Ooa65D39Bt47/E9vJwkPaB9FhlvuoD+DTLiUzm12jIzikZMakoJCebyH2mE+q5dYTX2MRzelUMM7GaMJGymPhY+L1XNpJapD82XOqJAqHewm9o4vCYt34PaxM5XnbG2wLzg9cZIMCtL/0CzcfYhp4FV9Ki2jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611595; c=relaxed/simple;
	bh=ZzvvQ6YDsyvBgi8WcanQNPPP/sckfC2BHc9RNMuK7JM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=M5cZXptAXZam40Op2oT5X5kULS16kmOzdmYmUwFetLRD75qp3V65v1GcORWEdfU9M3gmsexqKXLX1xIsuPpODFbPx3Cjnu2qdIIapcdWbOzH/sCdtm1tkWYUeJBktVaBIUKD612ZB1z9HY+J3ON4rLHd99biGt34w1R5WvaK9wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXGQffug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EADC43390;
	Thu, 28 Mar 2024 07:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711611595;
	bh=ZzvvQ6YDsyvBgi8WcanQNPPP/sckfC2BHc9RNMuK7JM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jXGQffugSUbEvfxjWWsfje6nlRM3tGqf88R35JBgHDTSp1B3CeQ1t7ZNY5FUY7Bm3
	 kYWvxoStl53693cuDjKWKuz4nZXjyK6rxMt8O8N6mWoBpBmwkBDEcRK5rakaK47X/q
	 CFN/HPLjbkwE/x+dQ8q3ibI8SG3CIM7tgnH65snKfYUP6DbjIEH7Fe+mP8kMxKNGsG
	 kZDSmw2AklxRZ2kY18itUNW11SugWaQe1qeLO5hyT2GAIlVgDvWFT4IMO+L+a6FMOk
	 +wFu8nwQ/U/mQ0/Siv74Hz7v0mFt4nl3KJLeW7er6cwc7Z5PPdEzrEDBjPp8wreUzw
	 OeSU0rCOx8nbQ==
From: Vinod Koul <vkoul@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: fancer.lancer@gmail.com, dmaengine@vger.kernel.org
In-Reply-To: <20240326085256.12639-1-manivannan.sadhasivam@linaro.org>
References: <20240326085256.12639-1-manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: Drop Gustavo Pimentel as EDMA Reviewer
Message-Id: <171161159370.113475.14170948972163028712.b4-ty@kernel.org>
Date: Thu, 28 Mar 2024 13:09:53 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Tue, 26 Mar 2024 14:22:56 +0530, Manivannan Sadhasivam wrote:
> Gustavo Pimentel seems to have left Synopsys, so his email is bouncing.
> And there is no indication from him expressing willingless to
> continue contributing to the driver.
> 
> So let's drop him from the MAINTAINERS entry.
> 
> 
> [...]

Applied, thanks!

[1/1] MAINTAINERS: Drop Gustavo Pimentel as EDMA Reviewer
      commit: 8b7149803af174f3184d97c779faa1c7608da5af

Best regards,
-- 
~Vinod



