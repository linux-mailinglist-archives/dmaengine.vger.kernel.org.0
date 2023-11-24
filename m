Return-Path: <dmaengine+bounces-225-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 454A07F7534
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 14:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F31D2281873
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 13:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A8528DD4;
	Fri, 24 Nov 2023 13:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fg+blA2Y"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7927028DCC;
	Fri, 24 Nov 2023 13:33:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7878C433C8;
	Fri, 24 Nov 2023 13:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700832784;
	bh=x6EgV44Z6FrkG3KgbOyNataJpEq/Te/FIziLy6Xf0mc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Fg+blA2YXdffBOsaH0+xQ+JG3CIJqzwezMCXY3atR5ZNmrj/cV8acUH8wdadnuHt4
	 CjHQ6KhlwVRBRVEL6sblpll66f9sH4Ry6Qr9KR+YeOrsFqaaqyiiy9vkBopexkm6G1
	 ysZ+/phg3V0JKHM652e1AZx6pjBCdZiDm5emkO28oOSjK7AKUn/BPWNa2Q0r29UoD1
	 NTEV2m45c/QLTOWBuwuT4yqaFcB0RQDBuFrSGff1ivBXkqHutSlLdxoiD6PazX+yRu
	 PWaJm5Q8G5z9Wm/kA9Ig/Jz+rM0iCE/8OC3t1l0vKzJgDSX7wWbITIwTJBbfunOn5N
	 dwD5NUGEF0WnQ==
From: Vinod Koul <vkoul@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20231124045722.191817-1-vigneshr@ti.com>
References: <20231124045722.191817-1-vigneshr@ti.com>
Subject: Re: [PATCH v3 0/4] dt-bindings: dma: ti: k3*: Update optional reg
 regions
Message-Id: <170083278148.771517.1841889156174413563.b4-ty@kernel.org>
Date: Fri, 24 Nov 2023 19:03:01 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Fri, 24 Nov 2023 10:27:18 +0530, Vignesh Raghavendra wrote:
> DMAs on TI K3 SoCs have channel configuration registers region which are
> usually hidden from Linux and configured via Device Manager Firmware
> APIs. But certain early SWs like bootloader which run before Device
> Manager is fully up would need to directly configure these registers and
> thus require to be in DT description.
> 
> This add bindings for such configuration regions.  Backward
> compatibility is maintained to existing DT by only mandating existing
> regions to be present and this new region as optional.
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: dma: ti: k3-*: Add descriptions for register regions
      commit: aaf7b392347bc4b32ffcab11c414d983a782e651
[2/4] dt-bindings: dma: ti: k3-bcdma: Describe cfg register regions
      commit: f04470678132c2d044b92befab39a933ac4d106c
[3/4] dt-bindings: dma: ti: k3-pktdma: Describe cfg register regions
      commit: 8d75e0e5eed23e4f8ced5eacae3255e498a1c304
[4/4] dt-bindings: dma: ti: k3-udma: Describe cfg register regions
      commit: d7aaccd3beb1ec34b04b13fa236f50efb77c8d6c

Best regards,
-- 
~Vinod



