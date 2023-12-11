Return-Path: <dmaengine+bounces-447-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C531280CEF9
	for <lists+dmaengine@lfdr.de>; Mon, 11 Dec 2023 16:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F094281BE3
	for <lists+dmaengine@lfdr.de>; Mon, 11 Dec 2023 15:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D95E4A991;
	Mon, 11 Dec 2023 15:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A209N3Rw"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283B54A986;
	Mon, 11 Dec 2023 15:04:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09FF7C433C7;
	Mon, 11 Dec 2023 15:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702307063;
	bh=6YPTpmneh2xOLLFp7HB+g9pk93OOl5wyKTQWmwlvyBY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=A209N3RwTmTf9qNW4JLthFdDYscWbS6svzgzXePytW9dVoVLfqXJFFd0vFj0uxY2N
	 PZCtAZY+22sFadCQ9SmUZRk2gUxX2wFKadbHKVHXN7W5fzIp5tZLIePv3vxSoJAlfJ
	 PluUY167kBTI4BJQsz9HtFXKNYUvTvJ+8Wu3sGgHVuQpaTP26YaCExvUT/Tl1WrF4J
	 lszBBwQIAu5V+YvMshL5CNu6jGbZZk19BEB4zt3x09aGb03GN9FMHBE0H5VwKQ97B4
	 wjXIh2M3DbaoKz5yh7Qw0D/R8v07d9wmiHz1jmXfl7ShlVaqtvMQVzPNbew8rUk2ks
	 6wFIAsBnpLe9w==
From: Vinod Koul <vkoul@kernel.org>
To: robh+dt@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com, 
 ldewangan@nvidia.com, krzysztof.kozlowski+dt@linaro.org, 
 Mohan Kumar <mkumard@nvidia.com>
Cc: dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org, 
 devicetree@vger.kernel.org
In-Reply-To: <20231009063509.2269-1-mkumard@nvidia.com>
References: <20231009063509.2269-1-mkumard@nvidia.com>
Subject: Re: [PATCH V1 0/2] Support dma channel mask
Message-Id: <170230706064.319997.12594760561127798160.b4-ty@kernel.org>
Date: Mon, 11 Dec 2023 20:34:20 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Mon, 09 Oct 2023 12:05:07 +0530, Mohan Kumar wrote:
> To reserve the dma channel using dma-channel-mask property
> for Tegra platforms.
> 
> Mohan Kumar (2):
>   dt-bindings: dma: Add dma-channel-mask to nvidia,tegra210-adma
>   dmaengine: tegra210-adma: Support dma-channel-mask property
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: dma: Add dma-channel-mask to nvidia,tegra210-adma
      commit: d95fcb78e7f263f909ce492c3882a704067dc534
[2/2] dmaengine: tegra210-adma: Support dma-channel-mask property
      commit: 25b636225a0816eac20b02fcb37daf6c722d0bed

Best regards,
-- 
~Vinod



