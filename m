Return-Path: <dmaengine+bounces-3346-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC6799D68A
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2024 20:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C1E11C246B5
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2024 18:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA5414F115;
	Mon, 14 Oct 2024 18:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tczVN0SF"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AEF231C95;
	Mon, 14 Oct 2024 18:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728930769; cv=none; b=NhkDvvW6vuIXHO1v6HfVrzHMaKtjL87AizQojG9l1Eq1fRgdH3AZOJn8scY7qHj9DmEi2rKglMogEV9B3B8fQdpzbnaPDK6UFXUGK5eMkq6gBfyhplQUq2kp3ruwYzBhcBUb/NxKGXD5qL1cO91VzCEqpkpA8U1+l+EFaVo1Mvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728930769; c=relaxed/simple;
	bh=n8ZMvS/2ok2yXjgPkVXG7Bv0NljpUEjTR3zlA+cgQpU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ucKS54Dj/+rUO11+fscmXGv5R5ARV59o3rkrzJ7S8zBguKTLogDfoT4aw3lOQ9vTqAbPB4siks2UagTkGD6qQiKpeFGiPFUHfAZOU5KK62NZrdxbwjbQA1NppVJEyyKjDaFMFB/PQ95AsL4gVXo2i/twFeoS0UWWJplkTdw3PZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tczVN0SF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754E5C4CEC3;
	Mon, 14 Oct 2024 18:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728930768;
	bh=n8ZMvS/2ok2yXjgPkVXG7Bv0NljpUEjTR3zlA+cgQpU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tczVN0SFQH3apRhdIisJsXKrMBAh+0wSv+5NyRh+WBUo2rc0sVcb3OQhwRG0bzSv4
	 KhzDE1vgXqGoKLL55AzyTM7dNGPG0LFU85YQYnBKmAwa/NV01ap+HUbOFUqkqZe54Y
	 AihB4Tj0ss+Sozz4zqIieg+RjEX3yetCMKJ6Bti7AZadHHWWU3tMSX+rmhwSRlFTvn
	 pxiAZBvP3uGmaNSV7hjeQkGxzi8ha67fN4vdgrZQfD67dMdbqpIdaH/SWeXHwRr0hZ
	 ccaN53SNI/lwyjkz+0rDCIamHGK9+z2IirUCfbndTw2QTdTvU3nhQT9DJhbtnNby4+
	 IJdHZp5vVtv+Q==
From: Vinod Koul <vkoul@kernel.org>
To: linux-renesas-soc@vger.kernel.org, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 dmaengine@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Magnus Damm <magnus.damm@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Rob Herring <robh@kernel.org>
In-Reply-To: <20241007110200.43166-5-wsa+renesas@sang-engineering.com>
References: <20241007110200.43166-5-wsa+renesas@sang-engineering.com>
Subject: Re: (subset) [PATCH v3 0/3] dmaengine: sh: rz-dmac: add r7s72100
 support
Message-Id: <172893076506.76035.11771160122611042922.b4-ty@kernel.org>
Date: Tue, 15 Oct 2024 00:02:45 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 07 Oct 2024 13:02:00 +0200, Wolfram Sang wrote:
> Changes since v2:
> * added tags to patches 1 and 3
> * reword commit message 2 to make clear 'clocks' are not needed
> * 'power-domains' is also not required for RZA1
> 
> Thanks to Geert for the tags and for the input!
> 
> [...]

Applied, thanks!

[2/3] dt-bindings: dma: rz-dmac: Document RZ/A1H SoC
      commit: 209efec19c4c0cea17ff01d67c8fbd75a90fb854
[3/3] dmaengine: sh: rz-dmac: add r7s72100 support
      commit: 32172b3e3265833a367e41842fa8b7eaa0acae96

Best regards,
-- 
~Vinod



