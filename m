Return-Path: <dmaengine+bounces-5613-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9E6AE7D1D
	for <lists+dmaengine@lfdr.de>; Wed, 25 Jun 2025 11:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3856188CB25
	for <lists+dmaengine@lfdr.de>; Wed, 25 Jun 2025 09:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB892DFA4B;
	Wed, 25 Jun 2025 09:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="VYivzD61"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C262DECD1
	for <dmaengine@vger.kernel.org>; Wed, 25 Jun 2025 09:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843393; cv=none; b=Qpbge+nxLbeigIhPfJzUkS9xhJuPDWenLqspM91MVrJxvCROpipKB8q/fDJVNfOSjQ7UTznfTS8K8HxFf/MsbNon3WYwFYcX87YgT2GEQlVhB9teD9ijTsWHcOqAHSDKPSSe77FLQRQbPRwdWVx87+JSWF4SXNhc1JkntPIl39Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843393; c=relaxed/simple;
	bh=X3UlS9d7TlY6Pd12RdYn75CPVuzcGSmzvT+aXKx0h9I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fhR2Bf6MG6+4ta8bDe3qcWXVEKM1xU+Yjmu6ryuf+FR+55NsVd8U95ba1bNvai5fi5yfyZkCrw08ooln8ghOmnvuitiLrQ0xLQbEB+7+PtvFehZ45B1syzJGAzzRCbhh7kx4NOecp11lfsNASehkFYlKhL3jTI3ZjfDMitybaRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=VYivzD61; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-606b58241c9so10045234a12.3
        for <dmaengine@vger.kernel.org>; Wed, 25 Jun 2025 02:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750843388; x=1751448188; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hV7WOWtVzsWUafxQtaP9Rv4gkIegzwV0WCsPbafI4b0=;
        b=VYivzD61f0Rr0FMLvDIF7n1SFPyZ+mQIOotBER9uqhTJi/ugKwTqFcH8fUTX7hmSFL
         epWoSVaO+thetchX2LtWM/Hu5LhPt2E0eGTzeGibEjLlScaoYUB/+S0NyALD+c+N7g1F
         kzAEQUA6rdJZfk6idAA09BphWvXoEl+uBds0MK50jeP0DGX/c5/QVihDezDIU6ci0h9J
         PLKHF9MWFf2qFvfPJOrve7z3hjG5UG2OUxATKAEheqt8yiWFR8V0Xu9qzxeEwkrWhhlQ
         ruumSzuYAAx7BMs5jnFpYfuxrRRLD/L6bTRS7fHD1e2s48zv/6JMnEcKzZuIZf/r59c3
         SLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750843388; x=1751448188;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hV7WOWtVzsWUafxQtaP9Rv4gkIegzwV0WCsPbafI4b0=;
        b=RHpgFSzN5DMEp6ci/IP6GcSx4xg7JXMY7JgKDqYta27DioKNmqnru0L+3mLCOf9CWK
         H6OpvI6cq+tW4D3PcU6qqlTRKqf6pyqyEL5XxGlMe5vJ5LmchuEBddchfM4JX7mmOxFG
         Vh2dKfxCKmBirRV00cSibHJEK2dz1vNFCDNGqbvO+kZkWx8k6QyofCK8qGRidxo6Eg8y
         UZ5uzrYljcdbraRWukTK566vMkkXDV+r8raUimVeVrSgrcESo0m52rBUxEctFJeF6gtx
         b+iGxiBFrebZ7mQ775aaor7mRkK0VJ5uxiHfjRhiE/pvoITzzfGPELrsuGMKmI8unJHy
         3XxA==
X-Forwarded-Encrypted: i=1; AJvYcCX3j03XDLwR+sSnDqoRo8NVIYaoKl0AM1iHvtlcNy5YrOfPnnTpQHBMA58RYIYxUPDzSu0f1YAHmDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhYptDEGHw9UNhqz3gvxR3sqxd5CbS4s4pvgEkqj0AYxpK7pCi
	qNauWcU2ssK23Qfs7qqGAi4TvD/7gRBzuWNP/9tGbw30Yy7uE2ZYRkKhGh49GegKzy0=
X-Gm-Gg: ASbGncvL3XHl0bxs3W7bQ+DCgIo6tZZeXnWEqk0lhO0Ocm+inSbFEbDkpgMbXRvJ/7V
	+hGSHZaxF0lCSK/mWeRwGxR/VSRYEkytavxVVMXabGjm1UzQ4nlsI6izZbvihi2Gzg9q4OcpvVc
	gpHDkhubyYck3qn8yQh7r3ZSPi8VLLG0orX9Mb39W/f1vxrOp82sp4fJHQNn3WhbCGKu/Wd+7yI
	KSHkwjEI05B8zI+vaHNb0Oo05bFqkepf5kMv6RoeVbSt0kuE0dDdFatLI/2X8Ru5B7GyQKXaIvO
	y0UZiTM6t1OpflDtfsjeyghBDUM4dV4n6mOsNl5ZlMAlPzsnvn/IoGaaHXGHEu9jgCnoCzGvoJM
	KbRsGtRw6HOPwQIh6ucHHxWHjet6omENy
X-Google-Smtp-Source: AGHT+IGBfPWLF14udRjA4rTQL7Xmj57jJQlVSw3nSt80zUa+Z8byzZivAhETKB7aMXe+Sl/ni3qeIw==
X-Received: by 2002:a17:907:3e0e:b0:ae0:c7b4:b797 with SMTP id a640c23a62f3a-ae0c7b4b8e3mr103550666b.45.1750843388241;
        Wed, 25 Jun 2025 02:23:08 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0aaa0a854sm270277766b.68.2025.06.25.02.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:23:07 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 00/14] Various dt-bindings for SM7635 and The Fairphone
 (Gen. 6) addition
Date: Wed, 25 Jun 2025 11:22:55 +0200
Message-Id: <20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPG/W2gC/42TzW7bMBCEX0VQr92CP+KfXqXIgVwubaKWxJKyk
 CLIu0exkaSXQD4RQ/Ab7M6AL32jmqn1Y/fSV9pyy8u8C/6z6/Hs5xNBjrvuBROKaSGhTUZLBal
 oyHNes78AVzSwRElJjP0OlkopP99Mfz/ddaW/1917vV9+WY/d3ZhroGsLAioV8itVWK9znk+Ql
 JaSow48+XET/f9zfcIGWp7KhSDWCVKAjAjWDZqjUs5x+R0o2Mc6bcE8pwUsaiIbrUAXx413P7q
 lrHsk/nJgUPKMa72ASySj1U4OOuwGBxReFvzTwGjnopQ2ojQPQ1NuCCxJ5Xy0kpE/JmuZziVCx
 KAiMq2RxDH0HiYNThEjrTlzx8R7k1DO/yDK4IMeLMbEH8Q++2fR2KSUEY6lBzajaVmp1AUb8MF
 Frwdmh2CPyTLljXE2gBy8Ns5JE2/VH2LPVQjJgEgpb7W3KL4vXO7vjVJsP6qRKtya2Ic+NWCaW
 UMqSO8+og2+EeAyTXkdu03/2j9HRd4/vb6+AXIeQHavAwAA
X-Change-ID: 20250623-sm7635-fp6-initial-15e40fef53cd
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Das Srinagesh <quic_gurus@quicinc.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-mmc@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750843387; l=7315;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=X3UlS9d7TlY6Pd12RdYn75CPVuzcGSmzvT+aXKx0h9I=;
 b=PhYFkq1F/db914X03xPoQB5gZpwOk1nGvWuuwEpN40VtD7TEu3y6t9uK9TA7paxOaRoimK4Gk
 /NuLWry4HChDv0DC0NE795vB+PtWL7GdDfNCJ4mvxYQEKrdHOXw/hQF
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document various bits of the SM7635 SoC in the dt-bindings, which don't
really need any other changes.

Then we can add the dtsi for the SM7635 SoC and finally add a dts for
the newly announced The Fairphone (Gen. 6) smartphone.

Dependencies:
* The dt-bindings should not have any dependencies on any other patches.
* The qcom dts bits depend on most other SM7635 patchsets I have sent in
  conjuction with this one. The exact ones are specified in the b4 deps.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (14):
      dt-bindings: arm-smmu: document the support on SM7635
      dt-bindings: cpufreq: qcom-hw: document SM7635 CPUFREQ Hardware
      dt-bindings: crypto: qcom,prng: document SM7635
      dt-bindings: firmware: qcom,scm: document SM7635 SCM Firmware Interface
      dt-bindings: qcom,pdc: document the SM7635 Power Domain Controller
      dt-bindings: mailbox: qcom-ipcc: document the SM7635 Inter-Processor Communication Controller
      dt-bindings: soc: qcom,aoss-qmp: document the SM7635 Always-On Subsystem side channel
      dt-bindings: thermal: qcom-tsens: document the SM7635 Temperature Sensor
      dt-bindings: dma: qcom,gpi: document the SM7635 GPI DMA Engine
      dt-bindings: mmc: sdhci-msm: document the SM7635 SDHCI Controller
      dt-bindings: soc: qcom: qcom,pmic-glink: document SM7635 compatible
      dt-bindings: arm: qcom: Add SM7635 and The Fairphone (Gen. 6)
      arm64: dts: qcom: Add initial SM7635 dtsi
      arm64: dts: qcom: Add The Fairphone (Gen. 6)

 Documentation/devicetree/bindings/arm/qcom.yaml    |    6 +
 .../bindings/cpufreq/cpufreq-qcom-hw.yaml          |    2 +
 .../devicetree/bindings/crypto/qcom,prng.yaml      |    1 +
 .../devicetree/bindings/dma/qcom,gpi.yaml          |    1 +
 .../devicetree/bindings/firmware/qcom,scm.yaml     |    2 +
 .../bindings/interrupt-controller/qcom,pdc.yaml    |    1 +
 .../devicetree/bindings/iommu/arm,smmu.yaml        |    3 +
 .../devicetree/bindings/mailbox/qcom-ipcc.yaml     |    1 +
 .../devicetree/bindings/mmc/sdhci-msm.yaml         |    1 +
 .../bindings/soc/qcom/qcom,aoss-qmp.yaml           |    1 +
 .../bindings/soc/qcom/qcom,pmic-glink.yaml         |    1 +
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |    1 +
 arch/arm64/boot/dts/qcom/Makefile                  |    1 +
 arch/arm64/boot/dts/qcom/sm7635-fairphone-fp6.dts  |  837 ++++++
 arch/arm64/boot/dts/qcom/sm7635.dtsi               | 2806 ++++++++++++++++++++
 15 files changed, 3665 insertions(+)
---
base-commit: d9946fe286439c2aeaa7953b8c316efe5b83d515
change-id: 20250623-sm7635-fp6-initial-15e40fef53cd
prerequisite-change-id: 20250616-eusb2-repeater-tuning-f56331c6b1fa:v2
prerequisite-patch-id: 5c504d171a4d1acd9ec376e01e0dd0fddbad92b8
prerequisite-patch-id: 0c97dcf5472fbed8ef4cffbd482f3169fe1e972d
prerequisite-change-id: 20250617-simple-drm-fb-icc-89461c559913:v2
prerequisite-patch-id: 1ce32150adbe39ad43d9a702623b55937d92a17c
prerequisite-patch-id: 3562d9a85381bee745402619a7acba9b951f145c
prerequisite-patch-id: f8447266657b779a546ecbbbc2e38bd61c422f08
prerequisite-patch-id: cb9d07c82e73ab3691e0ace9604bfa69cdd6bb64
prerequisite-patch-id: 18ab6ca6a024e5b8ea8138111064db593d72da35
prerequisite-change-id: 20250620-sm7635-socinfo-8c6ee8d82c9d:v1 # optional
prerequisite-patch-id: f1b2e11df96c271c9e3d010084809f361ee4249c
prerequisite-patch-id: 1471abf17230db340c67a84b5a9009f1f2ea6e0e
prerequisite-patch-id: 57bff00c4fedce1b78615375f12517b955dd1d16
prerequisite-change-id: 20250620-sm7635-pinctrl-9fe3d869346b:v1
prerequisite-patch-id: 43b88c44c6fc5b72a490cd3acc5d2585206e81f2
prerequisite-patch-id: b3b6ebd4a288bd4abf227c939a1a92eafb2cf2c8
prerequisite-change-id: 20250620-sm7635-clocks-7699d338dc37:v1
prerequisite-patch-id: 48485e0e7e8a992695af1690f8cd2c09c227a4bf
prerequisite-patch-id: 4685ceba3f900ad6d1d2ae35116d37f64a171d5d
prerequisite-patch-id: 80f71dad0c0a77da98e5e66b592f38db6d81b4b1
prerequisite-patch-id: 49a2fa1a14931d9143da232969e7487061466930
prerequisite-patch-id: f5d1794f61488235644f78ffc28e3dacdab215d1
prerequisite-patch-id: ab257573067ff09c94270e1fa6ad4de1480c06b9
prerequisite-patch-id: 6608bd3f2e198a0780736aebcea3b47ee03df9ef
prerequisite-patch-id: c463d0d2d84c8786ed9a09016f43b4657cbc231e
prerequisite-patch-id: e113e76af37f01befaf4059ee3063cb45b27fd6b
prerequisite-patch-id: 40f8b8acd07a9ff7da8683b1be6a58872250e849
prerequisite-change-id: 20250620-sm7635-clocks-misc-0f359ad830ea:v1
prerequisite-patch-id: 127f332296fced39a2fd2f9a1f446ba30ec28ceb
prerequisite-patch-id: d21a0c8ceb06523c9f3f4ce569d28714878b3f84
prerequisite-patch-id: 87029a8844ef174ab3e0f953a1d16957fe6c13cc
prerequisite-patch-id: 095c767d7b7aa67d47026589c926636e57349ca6
prerequisite-change-id: 20250620-sm7635-rpmhpd-dcb5dc066ce2:v1
prerequisite-patch-id: d71fe15334032610c05cb55aeb28bfaa44e3530c
prerequisite-patch-id: 729544e856b8046f7a311b719d9495f8b33c1e1f
prerequisite-change-id: 20250620-sm7635-icc-e495e0e66109:v1
prerequisite-patch-id: b387217215d6f83cbd50c380171b159a2f1406d8
prerequisite-patch-id: bffd82274c35f6d520f524aa2a9c1c4bef7e047e
prerequisite-change-id: 20250620-sm7635-eusb-phy-d3bab648cdf1:v1
prerequisite-patch-id: c242c9b099d738214def29d2e464b64be5f14e62
prerequisite-patch-id: 8c1eb426c08bc1ec9462e77139b3b64d5e1453e9
prerequisite-patch-id: cdbc469ab33002c6bf697c033755b598dd1a621e
prerequisite-patch-id: 6bb2900bb530880091622ef47d141fe1f5756a52
prerequisite-change-id: 20250620-sm7635-eusb-repeater-0d78f557290f:v1
prerequisite-patch-id: 5c504d171a4d1acd9ec376e01e0dd0fddbad92b8
prerequisite-patch-id: 0c97dcf5472fbed8ef4cffbd482f3169fe1e972d
prerequisite-patch-id: a618abb349c3de5b49f79b4b0f86d9ab502ad500
prerequisite-patch-id: 09f91ff3a25c16a0375bdfec80604a64eab0b4fb
prerequisite-patch-id: 8fca8b09d70409c5c78f9f1b77d0a4c75bce38cf
prerequisite-patch-id: f5c2c24d2baefcd7ff91718529ab2f2c264ab99f
prerequisite-change-id: 20250620-sm7635-remoteprocs-149da64084b8:v1
prerequisite-patch-id: 3c95a20dd456dfee100f2833de4e9931a2073c7d
prerequisite-patch-id: 5292d77663ea9c44346b8da86bda36e0cce3fe56
prerequisite-patch-id: 015edcb2a69b5e837dc7edfbc7adc22145ba611b
prerequisite-change-id: 20250620-sm7635-pmiv0104-34a679937d9d:v1
prerequisite-patch-id: 8fca8b09d70409c5c78f9f1b77d0a4c75bce38cf
prerequisite-patch-id: f5c2c24d2baefcd7ff91718529ab2f2c264ab99f
prerequisite-patch-id: d7a06ece910e7844c60b910fe8eed30ad2458f34
prerequisite-patch-id: e91b741c9cfc80aa149bfd8e43cae90ca58e17f2
prerequisite-patch-id: 5ba4a49c3792cb208ee064a6ba13545e40cb70ac
prerequisite-patch-id: 5bdfcbdd226f7223c04a65c1a3cdcc3ecad38858
prerequisite-change-id: 20250620-sm7635-pmxr2230-ee55a86a8c2b:v1
prerequisite-patch-id: f0bd6e083324f954b988647bb42d4e2be179fbda
prerequisite-patch-id: 8fe1c0fc544e8bcb35522c5eba0b36e83bfd0c19
prerequisite-patch-id: 525c9eb0087025024bb0aaec1ed1d7d2c0bc8f03
prerequisite-change-id: 20250623-pm7550-pmr735b-rpmh-regs-06087e5b3a99:v1
prerequisite-patch-id: 7360606a06f8fba3ea9a8f84b4ecfb8209e91ab0
prerequisite-patch-id: 7a06a346abdb7f7386912b92f2b84af87e7439a9
prerequisite-patch-id: 1e1a6eb9c5421812c07421f9fa7e3f16b26a42da
prerequisite-patch-id: 224df3e4068bee3a17bde32e16cd9366c55b5faf

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


