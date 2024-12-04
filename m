Return-Path: <dmaengine+bounces-3885-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F779E3B87
	for <lists+dmaengine@lfdr.de>; Wed,  4 Dec 2024 14:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2E44B36B19
	for <lists+dmaengine@lfdr.de>; Wed,  4 Dec 2024 13:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A191D63EC;
	Wed,  4 Dec 2024 13:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sc3oSsbe"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C23D1CBEB9;
	Wed,  4 Dec 2024 13:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733318328; cv=none; b=DrNviNrUIiiT2S4SiY2BShyKOxIH0XR1rutVx28D7ARIHiJm+NfkBNzFMNt06nOFV/W5hfvE/nOVH3RwaP9DiAm5JXxTpufjUvIWW34Vg39YK18yr2jqzx1zNS/9Plk8aVXuqFZwSBURGWxLT/ZgCk3Ib2KcyfnmnFh80LKtnFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733318328; c=relaxed/simple;
	bh=lO9xIUaRtZeRCP63CoyPq0QUzfva2Z6kkfQeAKsC9ys=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZrL2eW2pV8FWjUlbcIwJWBk48XD+hEavMT+9Xf4KbYtV3QS8tAIusLNwxlkuopiTNfOHKAgwPZaWUUoGycJiRRH7h7ItiteGU8D8w5Y+vBfn1Ci5N3aW3vMCAUTqvJDN405a8xSAb6JhVCHBjnfXKdCVauBGAsKkTyZ7E+B5yFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sc3oSsbe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A593C4CED2;
	Wed,  4 Dec 2024 13:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733318327;
	bh=lO9xIUaRtZeRCP63CoyPq0QUzfva2Z6kkfQeAKsC9ys=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sc3oSsbeQpWy6aFS+k9IihECtgfiRvJ9MPOPTPdhKAOkVrnjxLvWmDV6pmKyFEyaH
	 pOJIo1H6B5PTdDC0iPQzRp2EXlwvdJQEv/uXX9ybIDHpc8+Ly8IwVSFAs4wpIZ5hFi
	 +GJ1PNVVzIuyznHzVVVAMzNCAaPIlSpUOJa/NZc3mp/yWaNyQBgHdOjP47mHa7bNtf
	 kPA6i14pjI+05VVbWGbvI9Hg5W/tfpWVL0qFiL1gaMpXoVaGzi5ZTOxWc9pu8wDOkr
	 OCyr1QWuHziS82GY3Qkk4Rux+bKrykLQ8aQPMNbbGXkU4SlwRbhO7w/KQVGNZ7lLfE
	 3IZjZersGkS1g==
From: Vinod Koul <vkoul@kernel.org>
To: vkol@kernel.org, hch@lst.de, Lizhi Hou <lizhi.hou@amd.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nishads@amd.com
In-Reply-To: <20240918181022.2155715-1-lizhi.hou@amd.com>
References: <20240918181022.2155715-1-lizhi.hou@amd.com>
Subject: Re: [PATCH V1 1/1] dmaengine: amd: qdma: Remove using the private
 get and set dma_ops APIs
Message-Id: <173331832573.673314.9904872288772199169.b4-ty@kernel.org>
Date: Wed, 04 Dec 2024 18:48:45 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 18 Sep 2024 11:10:22 -0700, Lizhi Hou wrote:
> The get_dma_ops and set_dma_ops APIs were never for driver to use. Remove
> these calls from QDMA driver. Instead, pass the DMA device pointer from the
> qdma_platdata structure.
> 
> 

Applied, thanks!

[1/1] dmaengine: amd: qdma: Remove using the private get and set dma_ops APIs
      commit: dcbef0798eb825cd584f7a93f62bed63f7fbbfc9

Best regards,
-- 
~Vinod



