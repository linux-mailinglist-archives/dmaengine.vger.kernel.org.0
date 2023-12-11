Return-Path: <dmaengine+bounces-448-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDF880CEFB
	for <lists+dmaengine@lfdr.de>; Mon, 11 Dec 2023 16:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 551091F21961
	for <lists+dmaengine@lfdr.de>; Mon, 11 Dec 2023 15:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4688F4A99D;
	Mon, 11 Dec 2023 15:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+oV1h6F"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262A24A986;
	Mon, 11 Dec 2023 15:04:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37496C433C8;
	Mon, 11 Dec 2023 15:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702307066;
	bh=KJD+xYzc6CAoRixh1BSpxyBDmJjGrrIXDFFv6pBnCcE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=K+oV1h6F1sMyVxX2kiAGh+v/5Ueibnk86Lcvc1uHhRlw48GQCvp8CpYxGu6iWYWKt
	 G52BDl3WcfSeHGxC9Fzi0jFONRaxQHjWg+4KtWLwoZkN02rLWSQMGvxiwWgby4GCep
	 l4ufZqjiNzxGQyfalytZ1M095enQyJPkJSQSYQ5NC9duS0U/q42q24cd5omoH6Zxfl
	 QOQjmiipeIsX7RX0KeiytIs/rUk5BkYwGBWJHmfrFZLd5I7wlWIpiwkk00OSTEtdWW
	 Pe2HRuPLf2t9BR9OeTmLL6yPTLERhALRJvKQVe1yUgLczjHxUXCHzRgNPRayyGuDgU
	 bSbFGVxSf85gg==
From: Vinod Koul <vkoul@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20231122235050.2966280-1-robh@kernel.org>
References: <20231122235050.2966280-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: dma: Drop undocumented examples
Message-Id: <170230706382.319997.13782235714250384432.b4-ty@kernel.org>
Date: Mon, 11 Dec 2023 20:34:23 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Wed, 22 Nov 2023 16:50:50 -0700, Rob Herring wrote:
> The compatibles "ti,omap-sdma" and "ti,dra7-dma-crossbar" aren't documented
> by a schema which causes warnings:
> 
> Documentation/devicetree/bindings/dma/dma-controller.example.dtb: /example-0/dma-controller@48000000: failed to match any schema with compatible: ['ti,omap-sdma']
> Documentation/devicetree/bindings/dma/dma-router.example.dtb: /example-0/dma-router@4a002b78: failed to match any schema with compatible: ['ti,dra7-dma-crossbar']
> 
> As no one has cared to fix them, just drop them.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: dma: Drop undocumented examples
      commit: 4a8ececbb50f0dd9395ffc4188ae780916df4a9c

Best regards,
-- 
~Vinod



