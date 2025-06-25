Return-Path: <dmaengine+bounces-5630-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E78AAE8F74
	for <lists+dmaengine@lfdr.de>; Wed, 25 Jun 2025 22:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABA564A8146
	for <lists+dmaengine@lfdr.de>; Wed, 25 Jun 2025 20:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A1A2E0B4C;
	Wed, 25 Jun 2025 20:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjxBPgte"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D384B2E06F0;
	Wed, 25 Jun 2025 20:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750883122; cv=none; b=dvZBGSt46ktuF9JEEUlg/qQw+2rYeUdZnCqqkOH1+l/sA6GH/cOmNTcid5Rq6m4en7hBNrKS49+sscUOWRSB1UlLzkBiDUcE+60ZO1litdwSVhsNk/el1igQ5yjDEd1t4C3py6gXr6QbfPnrdPX6SC6OjY8n3tvsL4z01i9ghRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750883122; c=relaxed/simple;
	bh=+8MjsYjLQk7iYhneiOxY/4HQxLTzxHHxYvlkRd4VxMk=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=pGq7cezB2ngIFgXPl3Zb7OxJvl9br99ZyD7DCNCSoxiBsz9mX8tpsZwz9VWfDhBg/pVATQ8voX/VN+Y6WUqbUH7rzWQqC45eJOI1PaozI2CXnWVMVlRbHk8SZYZnVjTren8xuAvVyG4Es4hk+RedV6gfgweu+gTaKWrEmNEQFos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjxBPgte; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727C8C4CEEE;
	Wed, 25 Jun 2025 20:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750883121;
	bh=+8MjsYjLQk7iYhneiOxY/4HQxLTzxHHxYvlkRd4VxMk=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=FjxBPgte/hnwBLDmdydTbzz14Df12s+TFdfoEWn3IbNwWD723PsvN/Ff274kI+Qpj
	 07e3gS1h7nctSPrsRXmwjLFRx/N9SIg4pBrDmQ0ApAa8cQpKG5D29nkH8/kjN3UZl5
	 /eGjbcOBS/qnXPABEdfxZwZ3B3eRc3bdfW2TomvA7fUE9fiXAHU1ILG+JJO3CCQGwk
	 FGFhN6FIKYW9tZlcgX56IC/UOd2PxKXVXKf61yCMCFnB78pLwlbpTQZ+cBmGmMXaic
	 fhBBox0NxFCyYcG0JO13aY9eDDh5F4IY9wndgL6PbKmo+rdsS3qSJEnsWAJYi6xiDl
	 GwG7E5TlGLZtg==
Date: Wed, 25 Jun 2025 15:25:20 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Will Deacon <will@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-mmc@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
 linux-crypto@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>, 
 Robert Marko <robimarko@gmail.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Zhang Rui <rui.zhang@intel.com>, ~postmarketos/upstreaming@lists.sr.ht, 
 dmaengine@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 linux-arm-kernel@lists.infradead.org, Joerg Roedel <joro@8bytes.org>, 
 phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Amit Kucheria <amitk@kernel.org>, iommu@lists.linux.dev, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Jassi Brar <jassisinghbrar@gmail.com>, 
 Das Srinagesh <quic_gurus@quicinc.com>
To: Luca Weiss <luca.weiss@fairphone.com>
In-Reply-To: <20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com>
References: <20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com>
Message-Id: <175088289588.2146782.8259458340560356523.robh@kernel.org>
Subject: Re: [PATCH 00/14] Various dt-bindings for SM7635 and The Fairphone
 (Gen. 6) addition


On Wed, 25 Jun 2025 11:22:55 +0200, Luca Weiss wrote:
> Document various bits of the SM7635 SoC in the dt-bindings, which don't
> really need any other changes.
> 
> Then we can add the dtsi for the SM7635 SoC and finally add a dts for
> the newly announced The Fairphone (Gen. 6) smartphone.
> 
> Dependencies:
> * The dt-bindings should not have any dependencies on any other patches.
> * The qcom dts bits depend on most other SM7635 patchsets I have sent in
>   conjuction with this one. The exact ones are specified in the b4 deps.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> Luca Weiss (14):
>       dt-bindings: arm-smmu: document the support on SM7635
>       dt-bindings: cpufreq: qcom-hw: document SM7635 CPUFREQ Hardware
>       dt-bindings: crypto: qcom,prng: document SM7635
>       dt-bindings: firmware: qcom,scm: document SM7635 SCM Firmware Interface
>       dt-bindings: qcom,pdc: document the SM7635 Power Domain Controller
>       dt-bindings: mailbox: qcom-ipcc: document the SM7635 Inter-Processor Communication Controller
>       dt-bindings: soc: qcom,aoss-qmp: document the SM7635 Always-On Subsystem side channel
>       dt-bindings: thermal: qcom-tsens: document the SM7635 Temperature Sensor
>       dt-bindings: dma: qcom,gpi: document the SM7635 GPI DMA Engine
>       dt-bindings: mmc: sdhci-msm: document the SM7635 SDHCI Controller
>       dt-bindings: soc: qcom: qcom,pmic-glink: document SM7635 compatible
>       dt-bindings: arm: qcom: Add SM7635 and The Fairphone (Gen. 6)
>       arm64: dts: qcom: Add initial SM7635 dtsi
>       arm64: dts: qcom: Add The Fairphone (Gen. 6)
> 
>  Documentation/devicetree/bindings/arm/qcom.yaml    |    6 +
>  .../bindings/cpufreq/cpufreq-qcom-hw.yaml          |    2 +
>  .../devicetree/bindings/crypto/qcom,prng.yaml      |    1 +
>  .../devicetree/bindings/dma/qcom,gpi.yaml          |    1 +
>  .../devicetree/bindings/firmware/qcom,scm.yaml     |    2 +
>  .../bindings/interrupt-controller/qcom,pdc.yaml    |    1 +
>  .../devicetree/bindings/iommu/arm,smmu.yaml        |    3 +
>  .../devicetree/bindings/mailbox/qcom-ipcc.yaml     |    1 +
>  .../devicetree/bindings/mmc/sdhci-msm.yaml         |    1 +
>  .../bindings/soc/qcom/qcom,aoss-qmp.yaml           |    1 +
>  .../bindings/soc/qcom/qcom,pmic-glink.yaml         |    1 +
>  .../devicetree/bindings/thermal/qcom-tsens.yaml    |    1 +
>  arch/arm64/boot/dts/qcom/Makefile                  |    1 +
>  arch/arm64/boot/dts/qcom/sm7635-fairphone-fp6.dts  |  837 ++++++
>  arch/arm64/boot/dts/qcom/sm7635.dtsi               | 2806 ++++++++++++++++++++
>  15 files changed, 3665 insertions(+)
> ---
> base-commit: d9946fe286439c2aeaa7953b8c316efe5b83d515
> change-id: 20250623-sm7635-fp6-initial-15e40fef53cd
> prerequisite-change-id: 20250616-eusb2-repeater-tuning-f56331c6b1fa:v2
> prerequisite-patch-id: 5c504d171a4d1acd9ec376e01e0dd0fddbad92b8
> prerequisite-patch-id: 0c97dcf5472fbed8ef4cffbd482f3169fe1e972d
> prerequisite-change-id: 20250617-simple-drm-fb-icc-89461c559913:v2
> prerequisite-patch-id: 1ce32150adbe39ad43d9a702623b55937d92a17c
> prerequisite-patch-id: 3562d9a85381bee745402619a7acba9b951f145c
> prerequisite-patch-id: f8447266657b779a546ecbbbc2e38bd61c422f08
> prerequisite-patch-id: cb9d07c82e73ab3691e0ace9604bfa69cdd6bb64
> prerequisite-patch-id: 18ab6ca6a024e5b8ea8138111064db593d72da35
> prerequisite-change-id: 20250620-sm7635-socinfo-8c6ee8d82c9d:v1 # optional
> prerequisite-patch-id: f1b2e11df96c271c9e3d010084809f361ee4249c
> prerequisite-patch-id: 1471abf17230db340c67a84b5a9009f1f2ea6e0e
> prerequisite-patch-id: 57bff00c4fedce1b78615375f12517b955dd1d16
> prerequisite-change-id: 20250620-sm7635-pinctrl-9fe3d869346b:v1
> prerequisite-patch-id: 43b88c44c6fc5b72a490cd3acc5d2585206e81f2
> prerequisite-patch-id: b3b6ebd4a288bd4abf227c939a1a92eafb2cf2c8
> prerequisite-change-id: 20250620-sm7635-clocks-7699d338dc37:v1
> prerequisite-patch-id: 48485e0e7e8a992695af1690f8cd2c09c227a4bf
> prerequisite-patch-id: 4685ceba3f900ad6d1d2ae35116d37f64a171d5d
> prerequisite-patch-id: 80f71dad0c0a77da98e5e66b592f38db6d81b4b1
> prerequisite-patch-id: 49a2fa1a14931d9143da232969e7487061466930
> prerequisite-patch-id: f5d1794f61488235644f78ffc28e3dacdab215d1
> prerequisite-patch-id: ab257573067ff09c94270e1fa6ad4de1480c06b9
> prerequisite-patch-id: 6608bd3f2e198a0780736aebcea3b47ee03df9ef
> prerequisite-patch-id: c463d0d2d84c8786ed9a09016f43b4657cbc231e
> prerequisite-patch-id: e113e76af37f01befaf4059ee3063cb45b27fd6b
> prerequisite-patch-id: 40f8b8acd07a9ff7da8683b1be6a58872250e849
> prerequisite-change-id: 20250620-sm7635-clocks-misc-0f359ad830ea:v1
> prerequisite-patch-id: 127f332296fced39a2fd2f9a1f446ba30ec28ceb
> prerequisite-patch-id: d21a0c8ceb06523c9f3f4ce569d28714878b3f84
> prerequisite-patch-id: 87029a8844ef174ab3e0f953a1d16957fe6c13cc
> prerequisite-patch-id: 095c767d7b7aa67d47026589c926636e57349ca6
> prerequisite-change-id: 20250620-sm7635-rpmhpd-dcb5dc066ce2:v1
> prerequisite-patch-id: d71fe15334032610c05cb55aeb28bfaa44e3530c
> prerequisite-patch-id: 729544e856b8046f7a311b719d9495f8b33c1e1f
> prerequisite-change-id: 20250620-sm7635-icc-e495e0e66109:v1
> prerequisite-patch-id: b387217215d6f83cbd50c380171b159a2f1406d8
> prerequisite-patch-id: bffd82274c35f6d520f524aa2a9c1c4bef7e047e
> prerequisite-change-id: 20250620-sm7635-eusb-phy-d3bab648cdf1:v1
> prerequisite-patch-id: c242c9b099d738214def29d2e464b64be5f14e62
> prerequisite-patch-id: 8c1eb426c08bc1ec9462e77139b3b64d5e1453e9
> prerequisite-patch-id: cdbc469ab33002c6bf697c033755b598dd1a621e
> prerequisite-patch-id: 6bb2900bb530880091622ef47d141fe1f5756a52
> prerequisite-change-id: 20250620-sm7635-eusb-repeater-0d78f557290f:v1
> prerequisite-patch-id: 5c504d171a4d1acd9ec376e01e0dd0fddbad92b8
> prerequisite-patch-id: 0c97dcf5472fbed8ef4cffbd482f3169fe1e972d
> prerequisite-patch-id: a618abb349c3de5b49f79b4b0f86d9ab502ad500
> prerequisite-patch-id: 09f91ff3a25c16a0375bdfec80604a64eab0b4fb
> prerequisite-patch-id: 8fca8b09d70409c5c78f9f1b77d0a4c75bce38cf
> prerequisite-patch-id: f5c2c24d2baefcd7ff91718529ab2f2c264ab99f
> prerequisite-change-id: 20250620-sm7635-remoteprocs-149da64084b8:v1
> prerequisite-patch-id: 3c95a20dd456dfee100f2833de4e9931a2073c7d
> prerequisite-patch-id: 5292d77663ea9c44346b8da86bda36e0cce3fe56
> prerequisite-patch-id: 015edcb2a69b5e837dc7edfbc7adc22145ba611b
> prerequisite-change-id: 20250620-sm7635-pmiv0104-34a679937d9d:v1
> prerequisite-patch-id: 8fca8b09d70409c5c78f9f1b77d0a4c75bce38cf
> prerequisite-patch-id: f5c2c24d2baefcd7ff91718529ab2f2c264ab99f
> prerequisite-patch-id: d7a06ece910e7844c60b910fe8eed30ad2458f34
> prerequisite-patch-id: e91b741c9cfc80aa149bfd8e43cae90ca58e17f2
> prerequisite-patch-id: 5ba4a49c3792cb208ee064a6ba13545e40cb70ac
> prerequisite-patch-id: 5bdfcbdd226f7223c04a65c1a3cdcc3ecad38858
> prerequisite-change-id: 20250620-sm7635-pmxr2230-ee55a86a8c2b:v1
> prerequisite-patch-id: f0bd6e083324f954b988647bb42d4e2be179fbda
> prerequisite-patch-id: 8fe1c0fc544e8bcb35522c5eba0b36e83bfd0c19
> prerequisite-patch-id: 525c9eb0087025024bb0aaec1ed1d7d2c0bc8f03
> prerequisite-change-id: 20250623-pm7550-pmr735b-rpmh-regs-06087e5b3a99:v1
> prerequisite-patch-id: 7360606a06f8fba3ea9a8f84b4ecfb8209e91ab0
> prerequisite-patch-id: 7a06a346abdb7f7386912b92f2b84af87e7439a9
> prerequisite-patch-id: 1e1a6eb9c5421812c07421f9fa7e3f16b26a42da
> prerequisite-patch-id: 224df3e4068bee3a17bde32e16cd9366c55b5faf
> 
> Best regards,
> --
> Luca Weiss <luca.weiss@fairphone.com>
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: using specified base-commit d9946fe286439c2aeaa7953b8c316efe5b83d515
 Deps: looking for dependencies matching 56 patch-ids
 Deps: Applying prerequisite patch: [PATCH v2 1/2] dt-bindings: phy: qcom,snps-eusb2-repeater: Remove default tuning values
 Deps: Applying prerequisite patch: [PATCH v2 2/2] phy: qualcomm: phy-qcom-eusb2-repeater: Don't zero-out registers
 Deps: Applying prerequisite patch: [PATCH v2 1/5] dt-bindings: display: simple-framebuffer: Add interconnects property
 Deps: Applying prerequisite patch: [PATCH v2 2/5] drm/sysfb: simpledrm: Sort headers correctly
 Deps: Applying prerequisite patch: [PATCH v2 3/5] drm/sysfb: simpledrm: Add support for interconnect paths
 Deps: Applying prerequisite patch: [PATCH v2 4/5] fbdev/simplefb: Sort headers correctly
 Deps: Applying prerequisite patch: [PATCH v2 5/5] fbdev/simplefb: Add support for interconnect paths
 Deps: Applying prerequisite patch: [PATCH 1/3] dt-bindings: arm: qcom,ids: Add SoC IDs for SM7635 family
 Deps: Applying prerequisite patch: [PATCH 2/3] soc: qcom: socinfo: Add SoC IDs for SM7635 family
 Deps: Applying prerequisite patch: [PATCH 3/3] soc: qcom: socinfo: Add PM7550 & PMIV0108 PMICs
 Deps: Applying prerequisite patch: [PATCH 1/2] dt-bindings: pinctrl: document the SM7635 Top Level Mode Multiplexer
 Deps: Applying prerequisite patch: [PATCH 2/2] pinctrl: qcom: Add SM7635 pinctrl driver
 Deps: Applying prerequisite patch: [PATCH 01/10] dt-bindings: clock: qcom: document the SM7635 Global Clock Controller
 Deps: Applying prerequisite patch: [PATCH 02/10] clk: qcom: Add Global Clock controller (GCC) driver for SM7635
 Deps: Applying prerequisite patch: [PATCH 03/10] dt-bindings: clock: qcom: document the SM7635 Camera Clock Controller
 Deps: Applying prerequisite patch: [PATCH 04/10] clk: qcom: Add Camera Clock controller (CAMCC) driver for SM7635
 Deps: Applying prerequisite patch: [PATCH 05/10] dt-bindings: clock: qcom: document the SM7635 Display Clock Controller
 Deps: Applying prerequisite patch: [PATCH 06/10] clk: qcom: Add Display Clock controller (DISPCC) driver for SM7635
 Deps: Applying prerequisite patch: [PATCH 07/10] dt-bindings: clock: qcom: document the SM7635 GPU Clock Controller
 Deps: Applying prerequisite patch: [PATCH 08/10] clk: qcom: Add Graphics Clock controller (GPUCC) driver for SM7635
 Deps: Applying prerequisite patch: [PATCH 09/10] dt-bindings: clock: qcom: document the SM7635 Video Clock Controller
 Deps: Applying prerequisite patch: [PATCH 10/10] clk: qcom: Add Video Clock controller (VIDEOCC) driver for SM7635
 Deps: Applying prerequisite patch: [PATCH 1/4] dt-bindings: clock: qcom: Document the SM7635 RPMH Clock Controller
 Deps: Applying prerequisite patch: [PATCH 2/4] clk: qcom: rpmh: Add support for RPMH clocks on SM7635
 Deps: Applying prerequisite patch: [PATCH 3/4] dt-bindings: clock: qcom: document the SM7635 TCSR Clock Controller
 Deps: Applying prerequisite patch: [PATCH 4/4] clk: qcom: tcsrcc-sm8650: Add support for SM7635 SoC
 Deps: Applying prerequisite patch: [PATCH 1/2] dt-bindings: power: qcom,rpmpd: document the SM7635 RPMh Power Domains
 Deps: Applying prerequisite patch: [PATCH 2/2] pmdomain: qcom: rpmhpd: Add SM7635 power domains
 Deps: Applying prerequisite patch: [PATCH 1/2] dt-bindings: interconnect: document the RPMh Network-On-Chip Interconnect in Qualcomm SM7635 SoC
 Deps: Applying prerequisite patch: [PATCH 2/2] interconnect: qcom: Add SM7635 interconnect provider driver
 Deps: Applying prerequisite patch: [PATCH 1/4] dt-bindings: usb: qcom,snps-dwc3: Add SM7635 compatible
 Deps: Applying prerequisite patch: [PATCH 2/4] dt-bindings: phy: qcom,snps-eusb2: document the SM7635 Synopsys eUSB2 PHY
 Deps: Applying prerequisite patch: [PATCH 3/4] phy: qcom: phy-qcom-snps-eusb2: Add missing write from init sequence
 Deps: Applying prerequisite patch: [PATCH 4/4] phy: qcom: phy-qcom-snps-eusb2: Add extra register write for SM7635
 Deps: Applying prerequisite patch: [PATCH v2 1/2] dt-bindings: phy: qcom,snps-eusb2-repeater: Remove default tuning values
 Deps: Applying prerequisite patch: [PATCH v2 2/2] phy: qualcomm: phy-qcom-eusb2-repeater: Don't zero-out registers
 Deps: Applying prerequisite patch: [PATCH 1/4] dt-bindings: phy: qcom,snps-eusb2-repeater: Document qcom,tune-res-fsdif
 Deps: Applying prerequisite patch: [PATCH 2/4] phy: qualcomm: phy-qcom-eusb2-repeater: Support tune-res-fsdif prop
 Deps: Applying prerequisite patch: [PATCH 3/4] dt-bindings: phy: qcom,snps-eusb2-repeater: Add compatible for PMIV0104
 Deps: Applying prerequisite patch: [PATCH 4/4] phy: qualcomm: phy-qcom-eusb2-repeater: Add support for PMIV0104
 Deps: Applying prerequisite patch: [PATCH 1/3] dt-bindings: remoteproc: qcom,sm8350-pas: document SM7635 MPSS & WPSS
 Deps: Applying prerequisite patch: [PATCH 2/3] dt-bindings: remoteproc: qcom,sm8550-pas: document SM7635 ADSP & CDSP
 Deps: Applying prerequisite patch: [PATCH 3/3] remoteproc: qcom: pas: Add SM7635 remoteproc support
 Deps: Applying prerequisite patch: [PATCH 3/4] dt-bindings: phy: qcom,snps-eusb2-repeater: Add compatible for PMIV0104
 Deps: Applying prerequisite patch: [PATCH 4/4] phy: qualcomm: phy-qcom-eusb2-repeater: Add support for PMIV0104
 Deps: Applying prerequisite patch: [PATCH 1/4] dt-bindings: mfd: qcom,spmi-pmic: Document PMIV0104
 Deps: Applying prerequisite patch: [PATCH 2/4] dt-bindings: pinctrl: qcom,pmic-gpio: Add PMIV0104 support
 Deps: Applying prerequisite patch: [PATCH 3/4] pinctrl: qcom: spmi: Add PMIV0104
 Deps: Applying prerequisite patch: [PATCH 4/4] arm64: dts: qcom: Add PMIV0104 PMIC
 Deps: Applying prerequisite patch: [PATCH 1/3] dt-bindings: leds: qcom,spmi-flash-led: Add PMXR2230
 Deps: Applying prerequisite patch: [PATCH 2/3] dt-bindings: mfd: qcom-spmi-pmic: Document PMXR2230 PMIC
 Deps: Applying prerequisite patch: [PATCH 3/3] arm64: dts: qcom: Add PMXR2230 PMIC
 Deps: Applying prerequisite patch: [PATCH 1/4] regulator: dt-bindings: qcom,rpmh: Add PM7550 compatible
 Deps: Applying prerequisite patch: [PATCH 2/4] regulator: dt-bindings: qcom,rpmh: Add PMR735B compatible
 Deps: Applying prerequisite patch: [PATCH 3/4] regulator: qcom-rpmh: add support for pmr735b regulators
 Deps: Applying prerequisite patch: [PATCH 4/4] regulator: qcom-rpmh: add support for pm7550 regulators

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/qcom/' for 20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com:

arch/arm64/boot/dts/qcom/sm7635-fairphone-fp6.dtb: /panel: failed to match any schema with compatible: ['boe,bj631jhm-t71-d900']






