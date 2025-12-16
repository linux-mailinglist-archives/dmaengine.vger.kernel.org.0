Return-Path: <dmaengine+bounces-7705-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC70CC48E0
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 18:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51372309FB22
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 17:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B29532694E;
	Tue, 16 Dec 2025 16:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwSgG/6z"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FD52DAFA4;
	Tue, 16 Dec 2025 16:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765904389; cv=none; b=iiK6vOyZoia/9y/L6NGxP64nLFevs6gXsD4Z54j2Q2z0yDThqNDjEAPj2WxoO3OBeVY1qd/0Htie6sVaI32UaPGHC83vTIhSnqMwn0dH/At4qz4Ky3sf8mO0oSIb9cF7nh+G1NJzr7U4plucLkZ4zCus/2hEF39BP9R4qIXJJRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765904389; c=relaxed/simple;
	bh=IEUxEiubHfZryPxl7VoGp+qOf8EBAHnzqwRfMyWiBzs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CHu4MG18PwGmUZid669fWiovx6JHs4PMwmZBXuATPIyKBejlJA2Ayer9zV07+eIvT8YnKceji16CcxM2Xc3Egx/qAak61QPhspMFPk85qH9OSv9YqglR2DyNUxMjT/8Powo9F8AFdARdPAnP0oPHD78C8869B8tDoDX8NRW9z9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwSgG/6z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB8AC19422;
	Tue, 16 Dec 2025 16:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765904388;
	bh=IEUxEiubHfZryPxl7VoGp+qOf8EBAHnzqwRfMyWiBzs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hwSgG/6z6szArHuo7d16I1MZ6M5yJKvZMTL19/c2eUGUBl+pW/8+IQdvDY7LaQ+5L
	 1D7WQERB3Nqy37aYtZWrLOT9KL+RX2hZo5swx231VZYXFYlJ1qb8D7ln38AyOgskae
	 SeBjC4nQ8LKq/A2Z8ba+RrBNrdtouR6s/HIIECxOGJIqtsMIJ0L1/kHmqH5ykig2ss
	 pHmmFCfhMOgtCjHxYEA/2+xeQLyJ4kly2U2Sl48lQ6BV+QxjMHe69LRw2IKJkNhD9A
	 Fm4onOIplddXlK/7hAHBTPebXAodh+op7VQs0aKliC6CouPIUG2ZfwH6x5hoM1V74J
	 67PwaM5w+4EFQ==
From: Vinod Koul <vkoul@kernel.org>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, 
 Paul Mundt <lethal@linux-sh.org>, dmaengine@vger.kernel.org, 
 linux-sh@vger.kernel.org
In-Reply-To: <20251104002001.445297-1-rdunlap@infradead.org>
References: <20251104002001.445297-1-rdunlap@infradead.org>
Subject: Re: [PATCH] dmaengine: shdma: correct most kernel-doc issues in
 shdma-base.h
Message-Id: <176590438608.430148.16381479522388164901.b4-ty@kernel.org>
Date: Tue, 16 Dec 2025 22:29:46 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 03 Nov 2025 16:20:01 -0800, Randy Dunlap wrote:
> Fix kernel-doc comments in include/linux/shdma-base.h to avoid
> most warnings:
> 
> - prefix an enum name with "enum"
> - prefix enum values with '@'
> - prefix struct member names with '@'
> 
> [...]

Applied, thanks!

[1/1] dmaengine: shdma: correct most kernel-doc issues in shdma-base.h
      commit: de4761fb57f6a71eeb5a4c1167ae3606b08d8f59

Best regards,
-- 
~Vinod



