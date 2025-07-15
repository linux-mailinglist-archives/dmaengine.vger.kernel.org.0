Return-Path: <dmaengine+bounces-5824-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0433B05958
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jul 2025 13:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0E0562E0A
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jul 2025 11:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E23B2DAFBD;
	Tue, 15 Jul 2025 11:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0d2IDV/"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1045103F;
	Tue, 15 Jul 2025 11:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752580645; cv=none; b=TNeMlUgkBrY9sp4LJeVDLXc7uk1U1S6+VIjAh2sct9f3sooREJ+7Qo57ibhKuhrDlUgB40FJYXwtZP0v7BGez8s9+6mZ4ENFYemonETCW28PUICfrME+3fbEP1FUIymGjffrJsPqL3nQ3B0BAvA+/94vaz99nvxjjDWV7KU2aFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752580645; c=relaxed/simple;
	bh=dQpJV9t4WX6MPhN775PSWNhE4Y8XrFDxHw+0baMar30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=llQHunZW9zabW66iKOUjp3rj4Hfar2ByknhGCF+fDcyPiP8dJTrvUClZ2jKjhYW3BTkCu7NkIJNijb3jQhOjeVe1kmtlACPmJNgD0L1EtooUjPEP83VUBuptP1ZT6eeI+GNkvMq0PqoTw492F8KfC1klKBONgQw+e9TTk5mW/sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0d2IDV/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83826C4CEF6;
	Tue, 15 Jul 2025 11:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752580644;
	bh=dQpJV9t4WX6MPhN775PSWNhE4Y8XrFDxHw+0baMar30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N0d2IDV/1csdMXPNSESzqkWBceo9eaVAnc4jBjcAjEpg3Iup7r+euKYSnqkLVFT5i
	 Xh4LxeXEudgDyNk9RqEaGEZ10ZWe7EpWpNb88PrBc937o9F0XsI6jgiOYl41kWMlnK
	 imi0GiDM3Z/1SrKFbiwEGuerLx1oWJ5WWPSuSfUy5/JHNEyk8s5lwnO2elnciWGF0K
	 Ur+k/0WVICwvy4XKzOE5xEN3QKGeDXD1+1fmXBdvNnnFkFGXagcupKzXGFPZZHtBQe
	 A9Ue8BJc3WnegQNeb8tgkk851QJQ8Y8fHFxK9Fy3/6cfnhwwdoFE1//q/BUlJmlB7e
	 c2KPB6bCsmNww==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Vinod Koul <vkoul@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Robert Marko <robimarko@gmail.com>,
	Das Srinagesh <quic_gurus@quicinc.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Luca Weiss <luca.weiss@fairphone.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: Re: [PATCH v2 00/15] Various dt-bindings for Milos and The Fairphone (Gen. 6) addition
Date: Tue, 15 Jul 2025 12:57:09 +0100
Message-Id: <175257604342.2786246.10984360441321957187.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

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

Applied SMMU bindings change to iommu (arm/smmu/bindings), thanks!

[01/15] dt-bindings: arm-smmu: document the support on Milos
        https://git.kernel.org/iommu/c/2f0187392cba

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

