Return-Path: <dmaengine+bounces-1770-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B64C589B306
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 18:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E79A61C220CB
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 16:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A452E3D980;
	Sun,  7 Apr 2024 16:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmlXaClf"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDC53D965
	for <dmaengine@vger.kernel.org>; Sun,  7 Apr 2024 16:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712507933; cv=none; b=gWnh6TSv3+sNxaZaU+FMZcSVIKinNZbh6SQCjD7UUOQb9B9UcU0KuWoEUnHknBsMsM9z9PRqU9IUycwtvYg5t7dy2dl7rdUm0TG9pus+WvP+pJjHIS5a7CJGOZAryZZZf12hc1IMM081JeUHcKMm0G7cm2/pa2QeJiK2SaRqVno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712507933; c=relaxed/simple;
	bh=Tl+YWosBCkIR7Af/G1CogV2Q5H8bLKZQaPbF6B8AE64=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oohAEmKaqdfb/jcj2bUQRbAVhVQ0SQewaiiothOJPGdTeouqnzOcJ1NFPCb5WjwreOGRq2/pJ0FEmTkrB4tvroiM6W/ItL+0si+gBR3sNKJ5BayyLYEcDRfNQ79PdfnUOMoGruoK9NNonbTnIteq6kJmzxzZpa+ICVxumbELbT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmlXaClf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB4EC433C7;
	Sun,  7 Apr 2024 16:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712507933;
	bh=Tl+YWosBCkIR7Af/G1CogV2Q5H8bLKZQaPbF6B8AE64=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HmlXaClfKoC53qUaxyfXI7V+BOfHO7v/edehy/reLFgH8YStu/w0Jnp/PvBDqhKbe
	 r/J8CUHH1bM/i1o24quKkDYNbgrWutRci2t7soa+WIEsD3noWjtO91SVpZvGMxKPvk
	 3XiTLAjZQQD/X8ERLoPIok3Tzgd1GisDrTLJ1621EfVoLosw7BOMRoaVqI0qRt/evg
	 utidmR9MsT8go/ElvVllyMR3BsUCz1XdzDqKtjV7Kdn9svN6UAyDaiFZSMfnAIEcsZ
	 QoUeUsIHi8pufazQbyWEdWvmrdJ/AVSJkHVaiXA2JHFKJlcN80w1D+36pfb6dzNzd7
	 kbNev4btClgDw==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, stable@kernel.org
In-Reply-To: <20240222-axi-dmac-devm-probe-v3-0-16bdca9e64d6@analog.com>
References: <20240222-axi-dmac-devm-probe-v3-0-16bdca9e64d6@analog.com>
Subject: Re: (subset) [PATCH v3 0/2] dmaengine: axi-dmac: move to device
 managed probe
Message-Id: <171250793118.435322.18108162980865124084.b4-ty@kernel.org>
Date: Sun, 07 Apr 2024 22:08:51 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Thu, 22 Feb 2024 16:15:49 +0100, Nuno Sa wrote:
> Added a new patch so we can easily backport a possible race in the
> unbind path.
> 

Applied, thanks!

[2/2] dmaengine: axi-dmac: move to device managed probe
      commit: 779a44831a4f64616a2fb18256fc9c299e1c033a

Best regards,
-- 
~Vinod



