Return-Path: <dmaengine+bounces-7992-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8C5CED3CA
	for <lists+dmaengine@lfdr.de>; Thu, 01 Jan 2026 18:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F06D8300762E
	for <lists+dmaengine@lfdr.de>; Thu,  1 Jan 2026 17:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A12D24BBFD;
	Thu,  1 Jan 2026 17:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViNOvwCC"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CF61C84BC;
	Thu,  1 Jan 2026 17:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767289303; cv=none; b=VTWhG1GEkZQxHmjOhjQzlIU8vlRbdee7Fq0QqqZm5omYG56yMJZO3usq0YuDffme0k/hXbT0s1jWtMHGr/OPv7EsTob4UT0CpsrZJrcn+I0JR+QuF8nPIglFoBvYhy6IbvTGjiuZO3Ys1Zo3sASJWPKwB74S/Ul3zkHxQKVcxBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767289303; c=relaxed/simple;
	bh=nNgdKUG3FO3mHvi+GWQKOXSqipyIutSGayFpY5MUZXs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Zb8I7lXaHltOfOx3Qm/d4wN1nAyJTajPBrh45pPG8oumpJ60SaN5BIYyCQvfPP88j8KwBygdmWml9SeaiHIxUriHny1kRwVUldOdBq3m+3Q3VePCLKiN3u2iOpy8k9ULRdZd2PTMzAedBCWe4pVHD6CuNFGWFNax0PrPUdgZfc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViNOvwCC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BAFC4CEF7;
	Thu,  1 Jan 2026 17:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767289302;
	bh=nNgdKUG3FO3mHvi+GWQKOXSqipyIutSGayFpY5MUZXs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ViNOvwCCRJgl+JmPhouId9uegOvAQU2tq1ifx6TgrVeclKyaKv0+BTjkn7Ab4r1dX
	 62mk6HAP8C7N0u5Ae+hj4rrRKeUKjhXPeFE3C3Si/JD6hfa8GdVvOPFtiYp87/NVES
	 RXE8blbLSp5x7IGa3xuqAddgqCAqsBfGKwUP62Rp/fg8/6JXAgeoXvnc71qjcdAVx9
	 JVEQM2iY1vOsAxFZCk5eqExr2H94m03lvBFr1HY/OSwSE3/ggO5Ua8neuTJbcBVjcy
	 Ls9FVuwwDvD9vKv1J+AA0qYYlpjIZeZJDD99rSL+KPWde2Nk28RJyFyBEYrRcx6Ciu
	 OYkvzrzZyIaOA==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vladimir Zapolskiy <vz@mleia.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20251225181519.1401953-1-vz@mleia.com>
References: <20251225181519.1401953-1-vz@mleia.com>
Subject: Re: [PATCH] dt-bindings: dma: pl08x: Do not use plural form of a
 proper noun PrimeCell
Message-Id: <176728930063.239406.8039189937029694324.b4-ty@kernel.org>
Date: Thu, 01 Jan 2026 23:11:40 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 25 Dec 2025 20:15:19 +0200, Vladimir Zapolskiy wrote:
> As a proper noun PrimeCell is a single entity and it can not have a plural
> form, fix the typo.
> 
> 

Applied, thanks!

[1/1] dt-bindings: dma: pl08x: Do not use plural form of a proper noun PrimeCell
      commit: 99e0728b38da1ee343bd3b57bda72c404c693c45

Best regards,
-- 
~Vinod



