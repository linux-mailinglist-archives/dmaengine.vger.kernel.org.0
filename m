Return-Path: <dmaengine+bounces-933-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF722847482
	for <lists+dmaengine@lfdr.de>; Fri,  2 Feb 2024 17:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BE0F1C25FF0
	for <lists+dmaengine@lfdr.de>; Fri,  2 Feb 2024 16:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D55D1474A7;
	Fri,  2 Feb 2024 16:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V67IT8PE"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E121474A4
	for <dmaengine@vger.kernel.org>; Fri,  2 Feb 2024 16:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706890656; cv=none; b=WBrMvdBRFVBi3vzulqguwWxKyuQ7l8XyQ9oFduHOyfZqKpkcrpAu3Lw9J4tlLAqtAEUIjR1pmxmLUsXOYfggsumWUGDq3lOLB+bd9PlnZDmiWcLF9O3tBmBe7lSwVsDB+xU45rwVQZ+VFrH30bgpzZCK0zIYayJYt8zeXH6uK8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706890656; c=relaxed/simple;
	bh=AjKuDRmNJjHc/eKYfpcvy7WbczP1kZUkU0URJMqh/aU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ImIUQ8t7wJ3+Ar/CLd+BhWEo/SI3tmHQydY5qCVMBntZTgDzSmjtoQnKYU7XO9+GEBz54mcQapfLQFvzV4VBtkxrwclRdm9LEOiS/UaMIJvl7Skq3CXVPWtkDye/5MpYqavq6ED+KEBnjoWMharxkGPNmnEHQGQVUj6Sjmmmq4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V67IT8PE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF5BC433C7;
	Fri,  2 Feb 2024 16:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706890655;
	bh=AjKuDRmNJjHc/eKYfpcvy7WbczP1kZUkU0URJMqh/aU=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=V67IT8PENOIKH/0vbECnigYw6g0KirMcTQvzqHTtC75Qqo2l9XTSOI0vRJer9y6mS
	 tTyVdli4OylBCxxcReGb+taQofg5SvQX6c1ZP1yPKhWfrK3L5XBiukAa7J+E+cfeFt
	 YWOiAZUmF+bScHGl2zP8O/IVqnIMpb0Dlut7mLaPm/CJd5RQL5PKktPUkuMUSRadE7
	 UU9btMCHf0h4LAH1elKQbk7yePcwcOxtoUU5IPtbrmTLUFvRSU8vkCeJbGXsAqKMG4
	 XP7EhewxIl5CBwbF+8NKYcU3o+8cMUh4708Y9Rm/6/PTUvdO75yAHuMgkbqAdXMKfm
	 4u9zDEih5Ft0Q==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, 
 Ludovic Desroches <ludovic.desroches@microchip.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Vinod Koul <vkoul@kernel.org>
In-Reply-To: <20240130163216.633034-1-vkoul@kernel.org>
References: <20240130163216.633034-1-vkoul@kernel.org>
Subject: Re: [PATCH] dmaengine: at_hdmac: add missing kernel-doc style
 description
Message-Id: <170689065415.10410.7766142838246880894.b4-ty@kernel.org>
Date: Fri, 02 Feb 2024 17:17:34 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Tue, 30 Jan 2024 22:02:16 +0530, Vinod Koul wrote:
> We get following warning with W=1:
> 
> drivers/dma/at_hdmac.c:243: warning: Function parameter or struct member 'boundary' not described in 'at_desc'
> drivers/dma/at_hdmac.c:243: warning: Function parameter or struct member 'dst_hole' not described in 'at_desc'
> drivers/dma/at_hdmac.c:243: warning: Function parameter or struct member 'src_hole' not described in 'at_desc'
> drivers/dma/at_hdmac.c:243: warning: Function parameter or struct member 'memset_buffer' not described in 'at_desc'
> drivers/dma/at_hdmac.c:243: warning: Function parameter or struct member 'memset_paddr' not described in 'at_desc'
> drivers/dma/at_hdmac.c:243: warning: Function parameter or struct member 'memset_vaddr' not described in 'at_desc'
> drivers/dma/at_hdmac.c:255: warning: Enum value 'ATC_IS_PAUSED' not described in enum 'atc_status'
> drivers/dma/at_hdmac.c:255: warning: Enum value 'ATC_IS_CYCLIC' not described in enum 'atc_status'
> drivers/dma/at_hdmac.c:287: warning: Function parameter or struct member 'cyclic' not described in 'at_dma_chan'
> drivers/dma/at_hdmac.c:350: warning: Function parameter or struct member 'memset_pool' not described in 'at_dma'
> 
> [...]

Applied, thanks!

[1/1] dmaengine: at_hdmac: add missing kernel-doc style description
      commit: bd6081be2251c3700eca8a7bbe071e1bb8cd2af4

Best regards,
-- 
~Vinod



