Return-Path: <dmaengine+bounces-5850-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE28B0F23A
	for <lists+dmaengine@lfdr.de>; Wed, 23 Jul 2025 14:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D79C37AF102
	for <lists+dmaengine@lfdr.de>; Wed, 23 Jul 2025 12:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460F22E49A5;
	Wed, 23 Jul 2025 12:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbxWN2ii"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3CF210F4A;
	Wed, 23 Jul 2025 12:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753273769; cv=none; b=g3rLZL+g0NX/Q0P1NWjW7D5Y+muSBe/ahbMGBo/oPmgxusliTtlu8v/0gCBM47O+xRvrKaXL2AnOiirf7NKqVNGEWFnQJY4Nzxk8uXUZ7oRz+dUaBH7Nty8kJl+NbTswXytL1shRUV54/mNeOWxOG+M5TB7rZNE8n+khpeilUZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753273769; c=relaxed/simple;
	bh=Z1m4e0F1hHnK+GgkCb3mXzRDsiQSoSWfTycNxdXFiQA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kvaP0YTXD7mJINlqJ/Z/9L1S3c6VxzZXCmY1gO7A+iqUoDuTGkT7KQ+yG+/uZGOiE2pT7zwQ0ywoK/tTAN/m7MbM0IrjRZFuLhDaNjRrkEMwdwkpvtLhQ3cokYe7iCyGc0b7uKXGPTvGv4ZBmflknm6wRFSMv9XY2kKTwSd2B+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbxWN2ii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A97C4CEE7;
	Wed, 23 Jul 2025 12:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753273768;
	bh=Z1m4e0F1hHnK+GgkCb3mXzRDsiQSoSWfTycNxdXFiQA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BbxWN2iia6X+T0YTzqCa0lzRsuHPvCJ5QX+LmE48P1hm5OC5R7jeFmX7hewOHccRB
	 bbeiGVmB04NkvEUFNZXOW6xBMNEvaHdLVmbdr2vHrUWwsIl0j+b42DUCOCsDqfwQpT
	 yW/iXcFL4g/1QmQASU0L2BzNXoKkURTHx5iW5CHzRnmtNuem9+YNuBrVnwrIOxN35p
	 wsTTqHhpRx+oBYR+jptDxSBYH6VAP1AydNWsa60XDSCaICvcPJUSX4Xg87bcsEM8R7
	 A9vO5yLmWDx41p7QuExKuEP6u1uaYC/7z4vBjxSCf+iOehR5vplf1xRUTfL9gbBTcg
	 sJNCFNnH/CZhw==
From: Vinod Koul <vkoul@kernel.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Das Srinagesh <quic_gurus@quicinc.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-mmc@vger.kernel.org
In-Reply-To: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
Subject: Re: (subset) [PATCH v2 00/15] Various dt-bindings for Milos and
 The Fairphone (Gen. 6) addition
Message-Id: <175327375916.189941.14207583854602372511.b4-ty@kernel.org>
Date: Wed, 23 Jul 2025 17:59:19 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Sun, 13 Jul 2025 10:05:22 +0200, Luca Weiss wrote:
> Document various bits of the Milos SoC in the dt-bindings, which don't
> really need any other changes.
> 
> Then we can add the dtsi for the Milos SoC and finally add a dts for
> the newly announced The Fairphone (Gen. 6) smartphone.
> 
> Dependencies:
> * The dt-bindings should not have any dependencies on any other patches.
> * The qcom dts bits depend on most other Milos patchsets I have sent in
>   conjuction with this one. The exact ones are specified in the b4 deps.
> 
> [...]

Applied, thanks!

[09/15] dt-bindings: dma: qcom,gpi: document the Milos GPI DMA Engine
        commit: b330d77c5da2cfece98a89cbb51b8ef948691e6f

Best regards,
-- 
~Vinod



