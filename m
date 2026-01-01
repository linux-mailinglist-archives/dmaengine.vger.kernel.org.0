Return-Path: <dmaengine+bounces-7996-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B6ACED3EE
	for <lists+dmaengine@lfdr.de>; Thu, 01 Jan 2026 18:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8A13302C239
	for <lists+dmaengine@lfdr.de>; Thu,  1 Jan 2026 17:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3213E2F1FC2;
	Thu,  1 Jan 2026 17:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caEpArpU"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0DC2F12DB
	for <dmaengine@vger.kernel.org>; Thu,  1 Jan 2026 17:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767289320; cv=none; b=sIRngK4K7SaRTH/aJNwUzqUEgiJ8ELAJAwgCEjlNt3NIssPB7EuqAaWhwre0p6jfTxyLN8tGIBDHyaeTJYV5x18fq/EfE/tu19rdZUPZ9vqnfikwf/qXuaFhdEGVA1020kdbDknY+iwWzLnVg+xxM7F4evKKs+oxbabfYwvqIfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767289320; c=relaxed/simple;
	bh=S12lTHmdO9RhGKGgjohWSG1bs+CqKFrlJvx0QrG7emQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TS6OjnEUIdriLIPr1C5kim8xle0XeCJXcy4POBMunCzQnnSuBH4Gwq+wuEwaM9UvbQpsW6ouJ5KQmKfTASGEdNlVHMgDQ88QIhbVASCTBMTIIzkdjlrcUbif7D0AoSzAICuZX0wB1scwTL5j4/knxXogb1zfSZcfv56TDknt2go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caEpArpU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FB8C19421;
	Thu,  1 Jan 2026 17:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767289319;
	bh=S12lTHmdO9RhGKGgjohWSG1bs+CqKFrlJvx0QrG7emQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=caEpArpURBVOfMZilsgHA+kQQ8zk3Ugl7QzEa5Xnda2dKtJxaEjjDZY3tQZyzl+OY
	 jFbvVZh4ufbbh9lO6haeYmmxljScGYqI3yTtwWj7WbMAGv5meuMoERYnmWD+isjtGI
	 LViby6Sxxnsryft7V5PQgBxX0DfSJ6xH4ksuP8+YkeAMZhXkWeiDX5wX1HPFbovs9t
	 pWd34lc6llLKpy6KT7lHsG181L+TuxDHXv6Ljjm88Iq/sCbogepksWQUtQbZwZBvrr
	 20FObVqqJTdz6ZLnBnaJBUhSOrSYtHsSwg1LWpvBNLTw9hqPKz/ZcyCQ/SRmiuvN9/
	 9BM3bmPsZwTKw==
From: Vinod Koul <vkoul@kernel.org>
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: dmaengine@vger.kernel.org
In-Reply-To: <20251225173847.1395928-1-vz@mleia.com>
References: <20251225173847.1395928-1-vz@mleia.com>
Subject: Re: [PATCH] dmaengine: pl08x: Fix comment stating the difference
 between PL080 and PL081
Message-Id: <176728931849.239406.6035613714292037346.b4-ty@kernel.org>
Date: Thu, 01 Jan 2026 23:11:58 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 25 Dec 2025 19:38:47 +0200, Vladimir Zapolskiy wrote:
> Fix a trivial typo in the comment, otherwise it takes an effort to
> understand what it actually means to say.
> 
> 

Applied, thanks!

[1/1] dmaengine: pl08x: Fix comment stating the difference between PL080 and PL081
      commit: 8049f77fd820f47a2727c805de629a7433538eab

Best regards,
-- 
~Vinod



