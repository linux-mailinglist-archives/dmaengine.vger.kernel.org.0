Return-Path: <dmaengine+bounces-1091-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DD2861116
	for <lists+dmaengine@lfdr.de>; Fri, 23 Feb 2024 13:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2A881C21BCD
	for <lists+dmaengine@lfdr.de>; Fri, 23 Feb 2024 12:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEED7C090;
	Fri, 23 Feb 2024 12:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYW/138L"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469E17BAF8;
	Fri, 23 Feb 2024 12:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708690125; cv=none; b=WqPASz2RZf70kb1ngoaihzhlby0VbtAGtRIVJMR2jgAEJyoUPgmfURZ1V4XSBFPN54RfzNZ9SyQnDnJIXTrybIOl/s/VGXMVKGObyTq45m9N6MuV7Jx7HWkGAAmEBC2qVFQEs7DDsgyzgjZn/ANbqusRwbV0xmVK8yWD/xjtgek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708690125; c=relaxed/simple;
	bh=FGK/wZzrbp28TbwrnGWoJmL3G1Uylty0KLXbIXJ9ZvE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kO76t+tCMEEv1pf7rvQvX4pm37YRBU7JaxT0n+yW4iLpSLgWcRUvTEMv1YxlM+AHnGIlgwoxpweZ2/UgQb13HuTQZdzkfVaSd7zO8FD8BCj3qmvuX2r04qlcbvDaxa3ttNPrWUVoAALnJ49+j9z7+iP7Ba7p1CLZwpa3+J8Ul28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYW/138L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12119C43390;
	Fri, 23 Feb 2024 12:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708690124;
	bh=FGK/wZzrbp28TbwrnGWoJmL3G1Uylty0KLXbIXJ9ZvE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RYW/138LYT8K9jj3sEDxKvD6NYDskq1onJQ77rrXctU45rVW3jAOCgVrfwWeBNGJT
	 IicppUO7TEzRZCWoR14m/9bQpevcpcEE8pVXki7WJq0mFUrn5lwM4JGkwE9MKRWKxm
	 r4+DwTwK1YziRnrBZcSC5lJYp8fdD38zzi8/NjzdRjdICEs75MQozEV4/erBwRLYSN
	 vUoGuRvqOq7mbeM05yrmZuKue/ewiEd0gFgfAY5g5QaUtFl7oqPkTG1XqAb3EQweNb
	 IZGVmrHCY9SpVe1FlUP0033d4q5jS8f9Z2Aera8KpeeI+1gWcpyPcvzcVZfkhnGc3g
	 MDNu4RKOWsaIw==
From: Vinod Koul <vkoul@kernel.org>
To: =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Conor Dooley <conor+dt@kernel.org>, dmaengine@vger.kernel.org, 
 Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240222135847.5160-1-lukas.bulwahn@gmail.com>
References: <20240222135847.5160-1-lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: adjust file entry in MEDIATEK DMA DRIVER
Message-Id: <170869012270.529520.7551546252747451054.b4-ty@kernel.org>
Date: Fri, 23 Feb 2024 17:38:42 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Thu, 22 Feb 2024 14:58:47 +0100, Lukas Bulwahn wrote:
> Commit fa3400504824 ("dt-bindings: dma: convert MediaTek High-Speed
> controller to the json-schema")  converts mtk-hsdma.txt to
> mediatek,mt7622-hsdma.yaml, but misses to adjust its reference in
> MAINTAINERS.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
> 
> [...]

Applied, thanks!

[1/1] MAINTAINERS: adjust file entry in MEDIATEK DMA DRIVER
      commit: e3027b0d0b9db35a382285cca99364aa4905e39f

Best regards,
-- 
~Vinod



