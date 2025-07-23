Return-Path: <dmaengine+bounces-5856-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6572DB0F24F
	for <lists+dmaengine@lfdr.de>; Wed, 23 Jul 2025 14:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 799E6AA1DFF
	for <lists+dmaengine@lfdr.de>; Wed, 23 Jul 2025 12:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133E62E7BCA;
	Wed, 23 Jul 2025 12:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPii49I9"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1362E5B38;
	Wed, 23 Jul 2025 12:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753273790; cv=none; b=k2NeZlURsBWVZZKaty+3N1Fanqe9nN/lZB+QOmtPf1I0SwveuwwPbdhGV2xn6+ecEKJinlopbxHQgks00wnup8ToE8P4U/ckgK7fvKf7vRDTLwwlD5XES0BLe4h785o2cSP1JfdGYo7uucHv8FskWCBvCaysqXRui+eNHH7Gw6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753273790; c=relaxed/simple;
	bh=aVCHEe3ksbayGIHAF13OBQWF1Xw4AI3aSQvoUg81aKU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ni69hmeBn+ATG/CJW708WFbR5oNrAf5c2TwtUJKHn/l1AVwNSHvqjFD5CACGgqiF+wzIh0w2Lum4UQKiamxzT2uRDri0IkrJb0UKhwkybx/0RnkZkCoXvVCn5Ga0uZ/ittUqgM7/H9QLUil67MizEMuWQyc1cyJlyVUY3fJ2Yj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPii49I9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C641C4CEF5;
	Wed, 23 Jul 2025 12:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753273790;
	bh=aVCHEe3ksbayGIHAF13OBQWF1Xw4AI3aSQvoUg81aKU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hPii49I9qGK1H5XnCmYVy5yuSZLK9QxA8qdmNfWNZesCq1/JsNJ4bvuju+590V2Vt
	 v8/iNj177ACcxzp6yOJodxko5NcbtxjsC3VC6m1xxKw/u7y1rDv767nnh9DciT8nNf
	 lPYM8ADqGD67rAVWuxYbdBvyGcxcTH4RgMuSkZ/BjoN7RWSIyjotI10Za64Lck8uP/
	 vxx3F1V3VkCCNxckqZ4HlXfenKMaKeg4hWlmAmqZXZex8lkSY/p9gVx1s2XIRt8kgb
	 uHKj/igqUpdTYrILBcR/EBwsNaU1lKdEoOfSRk3M7Fa3VyRQgGG81Kq1k4gMe9vsqm
	 HqGrLF27QJjZQ==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>, 
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev
In-Reply-To: <20250523213252.582366-1-Frank.Li@nxp.com>
References: <20250523213252.582366-1-Frank.Li@nxp.com>
Subject: Re: [PATCH 1/1] dt-bindings: dma: fsl-mxs-dma: allow
 interrupt-names for fsl,imx23-dma-apbx
Message-Id: <175327378618.189941.16358340664801683783.b4-ty@kernel.org>
Date: Wed, 23 Jul 2025 17:59:46 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 23 May 2025 17:32:52 -0400, Frank Li wrote:
> Allow interrupt-names for fsl,imx23-dma-apbx and keep the same restriction
> for others.
> 
> 

Applied, thanks!

[1/1] dt-bindings: dma: fsl-mxs-dma: allow interrupt-names for fsl,imx23-dma-apbx
      commit: e3a9ccd21897a59d02cf2b7a95297086249306d6

Best regards,
-- 
~Vinod



