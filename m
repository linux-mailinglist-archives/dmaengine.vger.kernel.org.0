Return-Path: <dmaengine+bounces-3890-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA64B9E3B27
	for <lists+dmaengine@lfdr.de>; Wed,  4 Dec 2024 14:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 880A5169083
	for <lists+dmaengine@lfdr.de>; Wed,  4 Dec 2024 13:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62ED1F7074;
	Wed,  4 Dec 2024 13:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAN1Rd3K"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748CF1F6690;
	Wed,  4 Dec 2024 13:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733318352; cv=none; b=IqU5i2/wZUPGBAXZuOdAEtl2bXBFreT0+gOsln+FWPWka/x9c3SK8JJYoUEvc/cBx2rniLaWRJc18+1eQkHTN1ZhnnuZEU8zRanSEWDXWn6DyHzwQ5OaYTRwSPAmWKmwwSppc4p4BrGLSV3cBEmwtcENAlkDURftozXxvpvukCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733318352; c=relaxed/simple;
	bh=oepm4y3T9LW27evMwKmgna3Vb+XqatWSImIwtMlTVT8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UoAH20xh4T01gr+RFSNlrJunCKHk/ZsM47oayRzVb1kElp2j9CteJKXXsI9KHv0AzuzVGldi7uACoW1dCWqif45iqp/p7pVF86rgdh+jD3HgFICjIJS39/jSNZexdVOuz6gdxw7Ki2E0ZQC/MaCQCTdut9wiNaTIxX25lJEkfhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAN1Rd3K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0CBC4CED1;
	Wed,  4 Dec 2024 13:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733318352;
	bh=oepm4y3T9LW27evMwKmgna3Vb+XqatWSImIwtMlTVT8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fAN1Rd3K4XIQaKBeUJ5V9SNq+ZUsH/SrDgu8/HFPYSzhUX9wNfzb0UdL7aqccvmRG
	 9ioj4CrjLetr75MexrcHp7tEUnKZinWyFcN8MS5NRRgFyuM9/+Se/WDjYj3RFq4ueG
	 0rGuvbmmV9At/tlBgigw3rx7zrbLgigSZMWBYfyISROc/KTVK4rbp9mkEn+a+qC/4g
	 RjRUjvovOotYsIZZdbKZK3yanUHT5/0ty0NcDnXVnsDKS6abHkJJqS7p6jXnLzD3Ew
	 4s1RlNm7bv/LHwWneO+y8XUj3ILuIRW705uqIHYr/7gwp8MAMm+dRFvo5CqpHSFC05
	 zEyB0xQu/MVUw==
From: Vinod Koul <vkoul@kernel.org>
To: Nishad Saraf <nishads@amd.com>, Lizhi Hou <lizhi.hou@amd.com>, 
 dmaengine@vger.kernel.org, Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240912131017.588141-1-colin.i.king@gmail.com>
References: <20240912131017.588141-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] dmaengine: amd: qdma: make read-only arrays
 h2c_types and c2h_types static const
Message-Id: <173331834993.673424.15609586273115690011.b4-ty@kernel.org>
Date: Wed, 04 Dec 2024 18:49:09 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 12 Sep 2024 14:10:17 +0100, Colin Ian King wrote:
> Don't populate the read-only arrays h2c_types and c2h_types on the
> stack at run time, instead make them static const.
> 
> 

Applied, thanks!

[1/1] dmaengine: amd: qdma: make read-only arrays h2c_types and c2h_types static const
      commit: 7a155fefec85af91b5b13909ab18090b2672aa8b

Best regards,
-- 
~Vinod



