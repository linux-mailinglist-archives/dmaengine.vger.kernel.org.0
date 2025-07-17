Return-Path: <dmaengine+bounces-5829-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A6DB083F5
	for <lists+dmaengine@lfdr.de>; Thu, 17 Jul 2025 06:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30FD17A03D3
	for <lists+dmaengine@lfdr.de>; Thu, 17 Jul 2025 04:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B3A21D00A;
	Thu, 17 Jul 2025 04:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExYE3jCE"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BC221CC64;
	Thu, 17 Jul 2025 04:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752726692; cv=none; b=m1lKgrfFHKM21eNQ5IfHQwbJwb0ZoWPwSZFVUQGvctIY3s5FuipCHhNb4uz7nrgFYDF2cz/SYI3FuyyVnmiBoVt6hGsP92OIDFScj3iJYbS31w+QGjUImE4qshVlhCPPhDwuX9MiUnceKYZG2XoE1X0m94v5apH6Xcj8ckJZ8w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752726692; c=relaxed/simple;
	bh=FUphvS0A9PwEICMfXvjYOafxfusNQmr5yCGzqlIMojE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d0f1bz3SqOpykGx7EBGZ5/7EIHxwOUj8AwQe/hk0CI4W76xoRdFdJ4SskMrq0VMALX4p+KD1dJpXdEx5Vix0oFaR+LgtKkhKJ8iWLJuQCZzNb4t4EwjnJ6Vzb2pk3LKjMcn10my3A1BYEw+L6IlTkBm0pUCPFRjQ1UeQg9xyXNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExYE3jCE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3503CC4CEF6;
	Thu, 17 Jul 2025 04:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752726691;
	bh=FUphvS0A9PwEICMfXvjYOafxfusNQmr5yCGzqlIMojE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ExYE3jCEJ3wVAeaTVmKiM8j0TWjaFKo6Pp45jITxs6/g907yx6TC8C/Av02lS8SeN
	 xcANIhoJOvpIpzp7Dc3Fu0M7k4r6Ta/zvVm4Q7pKOXXn/PtNHqPBEYNtgXsRzvUJYF
	 7vK1KSPEa2RKUnBVsvid7HmjfTf8aTLbH9Rn+wFqf5tAOvgj0ZXgB7TRznJLhwLdSN
	 DJwUmySslz+68gszrxuBJh4LLi42iFprCGenbtYkOZshtWZoKxpklCXkutk6EzJd5n
	 W755o2u6KtIqQWuv1eQMMHfnHQD8NNhTFDcan11MonCbQgWsezhDdfUyVlstolhC3J
	 kSPbAJB6fGwrg==
From: Bjorn Andersson <andersson@kernel.org>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
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
Cc: ~postmarketos/upstreaming@lists.sr.ht,
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
Subject: Re: (subset) [PATCH v2 00/15] Various dt-bindings for Milos and The Fairphone (Gen. 6) addition
Date: Wed, 16 Jul 2025 23:31:04 -0500
Message-ID: <175272667138.130869.10008592038680168443.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
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

Applied, thanks!

[04/15] dt-bindings: firmware: qcom,scm: document Milos SCM Firmware Interface
        commit: 4405f3f7b44767c037270d8c40fe2fb3dc3454d0
[07/15] dt-bindings: soc: qcom,aoss-qmp: document the Milos Always-On Subsystem side channel
        commit: 6cd06adc39ac92ebca04d5c0df5acb7f0ec5ff2d
[11/15] dt-bindings: soc: qcom: qcom,pmic-glink: document Milos compatible
        commit: 4587d3910f805ac74348e6c320071a9b65be035e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

