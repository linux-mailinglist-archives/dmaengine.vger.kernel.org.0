Return-Path: <dmaengine+bounces-5646-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7FBAEAA07
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 00:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22DDD3BB778
	for <lists+dmaengine@lfdr.de>; Thu, 26 Jun 2025 22:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E846623BCE2;
	Thu, 26 Jun 2025 22:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vENZzbPY"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87112356BE;
	Thu, 26 Jun 2025 22:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750978091; cv=none; b=PgwoVURBlDswAFWeJvsRT3IgK5GDiT7KAY23S0BQR1/5MmuQxdigu0DHCNTUqBo/IL9i/4Twlt6oKsNUSE0b9po/aoQxXnsPD1axKMLj3gSNbSI6+pt5Mt0eXvl6pY+Aih+yAgNfEpV6g2KOGTeOLZxlcABlt3e8oTqv5yNAIbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750978091; c=relaxed/simple;
	bh=3fBhKy1+utiVAQDLVFIyeUDSkV8JwRYwEjiojfvti6Q=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WQ6ew6v6zYnIu5fSgrb39J2CNngTTvRXTPxRbxGVLuApgsdNwttxEP0gOrAzn6n4f1hbocqNZHQI4L635yG4j0XTSuOUMpTMuQbUaMEvoE+MtW2aoenrAzEv9fcJHXfDVUSt9UcS9GVSSUnfO1j9btUqDbUQiteqcZJQV96fdrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vENZzbPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B905C4CEF0;
	Thu, 26 Jun 2025 22:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750978091;
	bh=3fBhKy1+utiVAQDLVFIyeUDSkV8JwRYwEjiojfvti6Q=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=vENZzbPYOzKpFGAiu3tEUky6wFCydYGu6rV4Cj+c6LEQUH73/Bbuu4osbwtk+8g22
	 6tBE+hgRV4R093Qdxf1gvfvRr8SHb4Wg2RzAivQiNnEwUdMW3tOEfa0JGf6SR0Yl7q
	 RzpZcsZ5qW6N4aTLipM/5wbsLCC/G78CywvsuW17ZQCmnRXDAxTFl79yXprOxzPPqI
	 Hi/DX5TcQuXm8YsqF1pPV0SKP/uuaYj3/xsUKdCYdHFnhfh9k8VAFQVDEOTb3jnA6X
	 i/gA1xiYqEj3iJXNjG4/oPjSHwuPbIa9o1LZ1RWT65o77ie5ZYts3LuTFol0VdJJ+s
	 oja1NoeidNCQA==
From: Vinod Koul <vkoul@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250404122114.359087-1-krzysztof.kozlowski@linaro.org>
References: <20250404122114.359087-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] dmaengine: sh: Do not enable SH_DMAE_BASE by
 default during compile testing
Message-Id: <175097809125.79884.17167867217631386949.b4-ty@kernel.org>
Date: Thu, 26 Jun 2025 15:48:11 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 04 Apr 2025 14:21:13 +0200, Krzysztof Kozlowski wrote:
> Enabling the compile test should not cause automatic enabling of all
> drivers.
> 
> 

Applied, thanks!

[1/2] dmaengine: sh: Do not enable SH_DMAE_BASE by default during compile testing
      commit: 587dd30449fb10121fc8a319bb825dc6152b8dd5
[2/2] dmaengine: ti: Do not enable by default during compile testing
      commit: ddf16e16346a36ec6616e5282f675f2e3cdc826f

Best regards,
-- 
~Vinod



