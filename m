Return-Path: <dmaengine+bounces-227-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE9D7F753A
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 14:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F038B211CE
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 13:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B66728DDF;
	Fri, 24 Nov 2023 13:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MP8Q35if"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162C116432;
	Fri, 24 Nov 2023 13:33:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3529C433C7;
	Fri, 24 Nov 2023 13:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700832793;
	bh=leOqL5cP18fpDrM9XuEjcsZ1EgYyutXl9SkvhNNicbg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MP8Q35ifrSXBaCqY8/B9mycqEaJUeDG3+yvaE644sfy0zvNA49QhgI4EGlsrzjSR1
	 777QvA5F/9cIIRFL2jIQzPTgCdlcZ9iKC4qeyJLePoDbf7bymRlBKdzyHZj1iaAV5/
	 H39lK5BxZUYlvk82lKxJnl4nj+w3ptqdld65hDufjr0PeS2Nl8UJ42v+GakB3a98rz
	 tIDIroDBmXWZ0QNQKxYM9f82h7Tgz5ADt7gplZ7JomaD+TjO4JvPO8SvCRnU8jM8B9
	 TlfFMAQvraMOcTmALV9ZAps5pHug411qJ9pWozrjwC38GIgunh9q69inUg626x2Ovi
	 jfHsyvS0QZgbg==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20231102203922.548353-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20231102203922.548353-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] dt-bindings: dma: rz-dmac: Document RZ/Five SoC
Message-Id: <170083279036.771517.5485533645571949188.b4-ty@kernel.org>
Date: Fri, 24 Nov 2023 19:03:10 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Thu, 02 Nov 2023 20:39:22 +0000, Prabhakar wrote:
> The DMAC block on the RZ/Five SoC is identical to one found on the RZ/G2UL
> SoC. "renesas,r9a07g043-dmac" compatible string will be used on the
> RZ/Five SoC so to make this clear, update the comment to include RZ/Five
> SoC.
> 
> No driver changes are required as generic compatible string
> "renesas,rz-dmac" will be used as a fallback on RZ/Five SoC.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: dma: rz-dmac: Document RZ/Five SoC
      commit: 56d02cfa3fbfca7466ccd68f4db78b0297f5c01f

Best regards,
-- 
~Vinod



