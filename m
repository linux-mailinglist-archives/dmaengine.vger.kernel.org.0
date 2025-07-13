Return-Path: <dmaengine+bounces-5771-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DCCB02F59
	for <lists+dmaengine@lfdr.de>; Sun, 13 Jul 2025 10:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74446189D7A6
	for <lists+dmaengine@lfdr.de>; Sun, 13 Jul 2025 08:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C051E2858;
	Sun, 13 Jul 2025 08:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="fGMtTo4X"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA301DED5F
	for <dmaengine@vger.kernel.org>; Sun, 13 Jul 2025 08:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752393963; cv=none; b=ptOHJbrvf5Li/0xHdsDB9hdYs6AvaMREJ2mE+YBHXq0p9pEkmRmSLEzhnZlV/Lhfdrfmdo66MgFtjg9QnfKw0Tydz43MS01jTzoIyFHZcSkfgCDjh+F3uw7XnVdwXy6lUL2yHNzhcEqCkfilCzRRnTqF5sURLidl0lgnRXLxRQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752393963; c=relaxed/simple;
	bh=sKo4y8QpCZfExvG8e5sr4tS96J9buiczaWtrwWfhuSM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rk76jRKvFhZCfx6xqstOI/RQc+k1Yao473A+w6/ocJhRbr08fuPod6IGD8mtNBUN+TdPfrz5WdvZuxpLzzeZDgPz18+AfOLQ1CMgUVhNFNvyojAM8NqqYTXJKM6D+68MDs5MDoYtIh2EAr8qD60o4W+bHMZhj3L2Ix9F3xRc0Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=fGMtTo4X; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4561607166aso1376355e9.2
        for <dmaengine@vger.kernel.org>; Sun, 13 Jul 2025 01:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752393958; x=1752998758; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z97mMSe/l3noDR//cRVhKxBrSPQEYiv3MttYExK1Ysw=;
        b=fGMtTo4XfNEM7gTQum6R1eHA8QF1DUfvIoOAF1XXuki5Edk//A0x05MP/3Mu7X+Uui
         NNS7ghoqy7CwLvtEPkj8iH0Psy1z9H7sD+JXd+uQKzYSLgSdBqkZW3GGEJK2gAzeKcSB
         LbPkzROi4+MX832S8qWtJdpfHSK3jnKuw9uh1Z85PdUyZe/2QhFjh631ReGBuaizZZ9f
         xt4tKBU0cFezxQvZe8Xzcn4QR6My0sXs9+eN/atiUSzQwtbkeb7wTyZLL3+vv4OQkaH2
         vOt9Xc1itvgHcx7D5KFTjoH/OSab14v58GGZJXSLVl0pAspm6zFeAcXBtOyMSFdEhZ1q
         Rd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752393958; x=1752998758;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z97mMSe/l3noDR//cRVhKxBrSPQEYiv3MttYExK1Ysw=;
        b=It8/niPwpYYvvg/w/sReQkxCqJ39Tdo8Cz9vpN+jnKI5ANJccu3XB2Wlaa+9ZgR1UY
         /ccvmxXgK6n/7ZbU0IPF+QaDhOyxJDaFhSQoUNkp/8CgdtdyISjgwx/AyWNAG1ILHJXG
         rWGNod9QN/xHJUSoUI6x4K2mpYcLURK9i5n6jJ+5dGM26xzKymg9ByP250R6DAYAKVBz
         FSGmKNytOqJ89jC3kzTXhcyBSAy3o76fX95aaj0IAYjaJ48UHtCbNPfpxwFF11nvTXjx
         TXCAF3yhTIPi9nl36hQqmJ0UM5lA1UbnG6oA3jvwLu3xhSmIuNwZj6qv+/6dAkoPT8Hg
         O4zQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1YzqO0Grk23UzlSI0aaP0dJSeXY53jG9ViGWa/N/+1yyCNAeyGKJVMZcMBTgeYzzcZ9+L/NTZ0SI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuP3YR/Ty77A6l6U/eHIOcw06l4mP/RwXRJhiLuyV596ezFdW5
	QH6a4cV12DTN8IyDan4gXKlZ4ovEzu9hWlF2TZgIH3Lb8UQrZ9eEMas0cgOvxcBbjLw=
X-Gm-Gg: ASbGncsJNL1tsCNysAR/EajHt6QPiAGeR49gZ+MSEXLth5BkipYS9V92kEth15EFFJi
	z5Wl4iVcB/cC6NYO0aqjK4dWHJoOfwzZpgqQz031hQxo/k+RFbo1IRWgptFXttXnxo7SWRPT8oX
	YFhPZCaMl2T24NLsPqyzivbEf3wGnD1w6efQODHO3Z07EZPn/ZDaOF1R7HIf+SyDWXvIooIRAap
	Uqjv9UCNRlOujew3HL5/iW7QCe097ip7PyTqoeP+eU7Mqnjwl7Ai/h3My35LSZSNfaep/MHSz2L
	dCrtZaPNyED8Xg4icCkQQtjyQvEz4kc2DEIRxcQsR+VjbVOFRlQbixmBT47pc4pqRmXremYgVwa
	kpxVkox7ueI6E4YAui/RuesBpYQE0SkcIuT7T
X-Google-Smtp-Source: AGHT+IGqYkTrUFA/6ZLhOe0a+pJDWzQ1SqMwIXFzJQ1LYFoy/jcIr+hNXdKcCXDJeGfCkYC/lPYjlA==
X-Received: by 2002:a05:600c:3595:b0:43b:c0fa:f9dd with SMTP id 5b1f17b1804b1-45565edcb2amr70388985e9.25.1752393958399;
        Sun, 13 Jul 2025 01:05:58 -0700 (PDT)
Received: from [192.168.224.50] ([213.208.155.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc22a8sm9386608f8f.34.2025.07.13.01.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 01:05:57 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v2 00/15] Various dt-bindings for Milos and The Fairphone
 (Gen. 6) addition
Date: Sun, 13 Jul 2025 10:05:22 +0200
Message-Id: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMdoc2gC/42TyW7cMBBEf2WgXNMGF5Eidcp/BD5QzaaHiBaa1
 Ag2jPn3UOPJcrAhn4QW9KpaXai3plCOVJr+9NZk2mKJy1wH8f3U4NnNTwTR17kRTCimhYQydVo
 qCElDnOMa3QhcUcsCBSXRNxVMmUJ8uYn+fHyfMz1fqvb6/vKfdHXahQU3sEVPCyKkcYTpMq4Rk
 odtWeP8BF7z1iNZzqjrN9X8v91dQnMNdCmDgEyJ3EoZ1su8w0FpKTnqgQfXb+JjuIMSpzQS+Dx
 BGCDWTYxtNUelrOXyM1CwPxcpC8Y5LGBQExlvBFrfb/z07bSktV7VjQcCKc645hFsIOmNtrLVw
 7Etjgv+KtBpa72UxqPsvgxNsSCwIJV13khG7pjMaTrXXDwOyiPTGkkcQ/sxqbWKGGnNme03eUD
 sSUI6v4KXgxt0a9AHfmx0w/7mz3xnglKdsCx84c9oWlZKecECvLXe6ZaZdjDHy6YpboyzFmTrd
 Get7PwevTjEXrIQkgGRUs5oZ1B8Hris33dKsfrInVTDLYm69FMBppnpSA3SWXvnB1cIcJmmuPa
 nTT/UcmTkzd7Gcyzrkl9vjd/4rY53C/VRuTcODLxFL4Ugh3z4EVzM6bzM9FANmsfr9fobWKPjR
 UYEAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752393945; l=12361;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=sKo4y8QpCZfExvG8e5sr4tS96J9buiczaWtrwWfhuSM=;
 b=Kn4UrhmiQBELXj5IXqj2g5g9r43zN0IArxY8to5C/jjK/fFirD3vzMpj9pWlbX1xfosQpWoAp
 Jr+kQOBlNhhDXfDvq3ApRZnBeWogJFNfArCihUMBWR59uH1mT1lW0XA
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document various bits of the Milos SoC in the dt-bindings, which don't
really need any other changes.

Then we can add the dtsi for the Milos SoC and finally add a dts for
the newly announced The Fairphone (Gen. 6) smartphone.

Dependencies:
* The dt-bindings should not have any dependencies on any other patches.
* The qcom dts bits depend on most other Milos patchsets I have sent in
  conjuction with this one. The exact ones are specified in the b4 deps.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v2:
- Rebrand SM7635 to Milos as requested: https://lore.kernel.org/linux-arm-msm/aGMI1Zv6D+K+vWZL@hu-bjorande-lv.qualcomm.com/
- Disable pm8550vs instances by default
- Enable gpi_dma by default, sort pinctrl, update gpio-reserved-ranges
  style, update USB2.0 comment, newlines before status, remove dummy
  panel for simpledrm
- Link to v1: https://lore.kernel.org/r/20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com

---
Luca Weiss (15):
      dt-bindings: arm-smmu: document the support on Milos
      dt-bindings: cpufreq: qcom-hw: document Milos CPUFREQ Hardware
      dt-bindings: crypto: qcom,prng: document Milos
      dt-bindings: firmware: qcom,scm: document Milos SCM Firmware Interface
      dt-bindings: qcom,pdc: document the Milos Power Domain Controller
      dt-bindings: mailbox: qcom-ipcc: document the Milos Inter-Processor Communication Controller
      dt-bindings: soc: qcom,aoss-qmp: document the Milos Always-On Subsystem side channel
      dt-bindings: thermal: qcom-tsens: document the Milos Temperature Sensor
      dt-bindings: dma: qcom,gpi: document the Milos GPI DMA Engine
      dt-bindings: mmc: sdhci-msm: document the Milos SDHCI Controller
      dt-bindings: soc: qcom: qcom,pmic-glink: document Milos compatible
      dt-bindings: arm: qcom: Add Milos and The Fairphone (Gen. 6)
      arm64: dts: qcom: pm8550vs: Disable different PMIC SIDs by default
      arm64: dts: qcom: Add initial Milos dtsi
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
 arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts   |  815 ++++++
 arch/arm64/boot/dts/qcom/milos.dtsi                | 2802 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/pm8550vs.dtsi             |    8 +
 arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi       |   16 +
 arch/arm64/boot/dts/qcom/sm8550-hdk.dts            |   16 +
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts            |   16 +
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts            |   16 +
 arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts    |   16 +
 .../dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts    |   16 +
 arch/arm64/boot/dts/qcom/sm8650-hdk.dts            |   16 +
 arch/arm64/boot/dts/qcom/sm8650-mtp.dts            |   16 +
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts            |   16 +
 25 files changed, 3791 insertions(+)
---
base-commit: d9946fe286439c2aeaa7953b8c316efe5b83d515
change-id: 20250623-sm7635-fp6-initial-15e40fef53cd
prerequisite-change-id: 20250218-videocc-pll-multi-pd-voting-d614dce910e7:v5
prerequisite-patch-id: 65d170393a409edd16388edaf8dee8cd6312c062
prerequisite-patch-id: 00d97b0b5842bd24c063bf7f3ae611acb8eacc34
prerequisite-patch-id: ae99f7dded35d31fc1162ca56f80d25ec284174b
prerequisite-patch-id: 1b5366f870373196c64fb70351f787e45c5b6cd4
prerequisite-patch-id: f4027959d4262d387c4d373bde32becfbcca18f4
prerequisite-patch-id: 932d0000fecaffe8872f5a457dceb6f1bbba6c5e
prerequisite-patch-id: fcc2e32ef92d284025097a73b7ba149e57216d6a
prerequisite-patch-id: 0d3a206967fa72e69d006f6769a09fcd097ac6d7
prerequisite-patch-id: e39d2a84153cdef28af6da7dcb0ea92f6ba3d848
prerequisite-patch-id: 7369e91c8a3297c97cc6e1b5ac250dadf54181a4
prerequisite-patch-id: 8ee0fcbab043cc34666bd112438138b32b894bbf
prerequisite-patch-id: efccf2dcdb3fbdfdff6355cdb656e2f56deca7ba
prerequisite-patch-id: f02fa97d2a57c174de8735001c605df64f6cd196
prerequisite-patch-id: 7877c0402990c1d5f3c39b5b42f654c718fa9001
prerequisite-patch-id: 741df345330dfdc4603b82c31708fd5260ef1e5f
prerequisite-patch-id: 58e7c98be9a08205073ff258558db8dd7d35e818
prerequisite-patch-id: e3e0409e24c5376aadb9dc74defa322def3d4498
prerequisite-patch-id: 4657f379804236e49b21d23ff7263db829a0d287
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
prerequisite-change-id: 20250620-sm7635-pinctrl-9fe3d869346b:v2
prerequisite-patch-id: 8b2cb6c8afadbfe0861c1dcfd13be090b006bf73
prerequisite-patch-id: 722295402ec0e0c5a6bbe167c1a97ddc315c0d18
prerequisite-change-id: 20250620-sm7635-clocks-7699d338dc37:v2
prerequisite-patch-id: 30b56c4075513c2b4a44b32a07f270b5cb08d098
prerequisite-patch-id: 37be728e2df777fedd469f7da865e5a256a54b06
prerequisite-patch-id: 32cc06fb5708d126263bc3ac132126e530f72d4a
prerequisite-patch-id: d200c8de06976d3cfa9f1db896301019ab8a68d9
prerequisite-patch-id: f13af5b3633a7969c35f3c1497c3968ff438aa7b
prerequisite-patch-id: 70cc297fa29e022d4ffa74b0aad59f1ed1671e09
prerequisite-patch-id: fb0950b5ebf9ebdbb4381762362f131544252bc7
prerequisite-patch-id: c6593a406bcb7d9cb35bfa54b6fd8fbcaa58ae99
prerequisite-patch-id: 6b126e92f96a5f2152d8ca296489aaf712bbaa17
prerequisite-patch-id: 728eae32feac9247a5a822343f777ca678cd666c
prerequisite-patch-id: 1c49368327e67c86e9e3523213c2d3f8469c226c
prerequisite-change-id: 20250620-sm7635-clocks-misc-0f359ad830ea:v2
prerequisite-patch-id: 6989bd0e4ad07de29b2c5d7f576596157bc6febd
prerequisite-patch-id: 85526f03d5d021476f73b80788082be4f0e577db
prerequisite-patch-id: a723402abcb006bf116a8dca9d6b813af882ec8a
prerequisite-patch-id: c03b241d2252eaa82460a76e8115177b01fbfa31
prerequisite-change-id: 20250620-sm7635-rpmhpd-dcb5dc066ce2:v2
prerequisite-patch-id: 4f366d477db5c0ab18c263b1be8c67fde8747455
prerequisite-patch-id: 5cc7814cf9a1e233d323ce8534cefb2ab24c4709
prerequisite-change-id: 20250620-sm7635-icc-e495e0e66109:v3
prerequisite-patch-id: cfef14406349a8de35f9a9f52a94c27b9760c98d
prerequisite-patch-id: 2a0f6625a75fc2672c5b5b8838daf4c1b84dae06
prerequisite-patch-id: c43395b7274c6c4866e293378c2784e1ede5796b
prerequisite-patch-id: dc669619c955d963b478e6c5bf691b09a9e87e5c
prerequisite-patch-id: ec455ecaae1134984fab4ee9b0ced416c8388733
prerequisite-patch-id: b610e2d9aab84dd752188235293267130a540363
prerequisite-patch-id: de89fdb08c0e9794ea1c758bb8429cd8648d16e9
prerequisite-patch-id: 5ab96a904a60a84a151a2e776942a86b1edff4a5
prerequisite-patch-id: 201c52a86199d5977dda00e4611811a57124c32b
prerequisite-patch-id: 1af362b4eb70298089b1f407119831ed47d0e53a
prerequisite-patch-id: 99fc9ac3f20c10960aeaf8f95fbab2299fc1299c
prerequisite-patch-id: 719eac9c833b38f49f788d1f347f580523464ba5
prerequisite-patch-id: e5897f2ff8c6a908cbf4424fe34782cdfd8e78f7
prerequisite-patch-id: da0770cbea0b965c9cc1593f4f70316c1f06db74
prerequisite-patch-id: 2db94237c903c9dc8adab9282375786f7646bdcf
prerequisite-patch-id: 99f36df03d920c8e0735c6ff49b6ce24c64e1c4e
prerequisite-patch-id: 666f687cbbd07cf9d2a18a8946d4b89f214919ee
prerequisite-patch-id: 2b6bed1ff4cbe83734e1b9e73b8787fba5da12a2
prerequisite-patch-id: d4ff7d798a7cf3260a91672dbabaca06e663651c
prerequisite-patch-id: 133f755855d4d8b13759edcf79ce034725960673
prerequisite-patch-id: 5e809c2603fb204d11a2bda4126df60ccbf46206
prerequisite-patch-id: a5f457c883c17a5ea0f7226b4eeabc1354c965b7
prerequisite-patch-id: fe9cbf613cf61082c75dfb358d0e362680849f17
prerequisite-patch-id: 022a649bf46677564390068752121c6acf91cd74
prerequisite-patch-id: 259e32af18576dbe8cff7f20633437a80f9a50f5
prerequisite-patch-id: f316b9420653e078b04e2de499e4032e7d6b64ab
prerequisite-patch-id: d39b4a58681c5e5699ba045d3a889d843d768262
prerequisite-patch-id: 8e648304c8a8b21db26f1ae991abeb52a11d6ee8
prerequisite-patch-id: 30b56c4075513c2b4a44b32a07f270b5cb08d098
prerequisite-patch-id: 37be728e2df777fedd469f7da865e5a256a54b06
prerequisite-patch-id: 32cc06fb5708d126263bc3ac132126e530f72d4a
prerequisite-patch-id: d200c8de06976d3cfa9f1db896301019ab8a68d9
prerequisite-patch-id: f13af5b3633a7969c35f3c1497c3968ff438aa7b
prerequisite-patch-id: 70cc297fa29e022d4ffa74b0aad59f1ed1671e09
prerequisite-patch-id: fb0950b5ebf9ebdbb4381762362f131544252bc7
prerequisite-patch-id: c6593a406bcb7d9cb35bfa54b6fd8fbcaa58ae99
prerequisite-patch-id: 6b126e92f96a5f2152d8ca296489aaf712bbaa17
prerequisite-patch-id: 728eae32feac9247a5a822343f777ca678cd666c
prerequisite-patch-id: 1c49368327e67c86e9e3523213c2d3f8469c226c
prerequisite-patch-id: 5e03ae1c7a2396e40a26e42aaecedb529d2d303c
prerequisite-patch-id: 7b1d5afc2b053faa03334e1ae15f604c5090f2e3
prerequisite-change-id: 20250620-sm7635-eusb-phy-d3bab648cdf1:v2
prerequisite-patch-id: 9572f752f2ec547c808d6e2be1cc508cd3749eee
prerequisite-patch-id: d71ac98dcf98628013473a2f376e97f25122e0b6
prerequisite-patch-id: cdbc469ab33002c6bf697c033755b598dd1a621e
prerequisite-patch-id: ba8946f6b1adb9616d4541765f3858bfc044ae7c
prerequisite-change-id: 20250620-sm7635-eusb-repeater-0d78f557290f:v2
prerequisite-patch-id: 5c504d171a4d1acd9ec376e01e0dd0fddbad92b8
prerequisite-patch-id: 0c97dcf5472fbed8ef4cffbd482f3169fe1e972d
prerequisite-patch-id: a618abb349c3de5b49f79b4b0f86d9ab502ad500
prerequisite-patch-id: 09f91ff3a25c16a0375bdfec80604a64eab0b4fb
prerequisite-patch-id: 8fca8b09d70409c5c78f9f1b77d0a4c75bce38cf
prerequisite-patch-id: f5c2c24d2baefcd7ff91718529ab2f2c264ab99f
prerequisite-change-id: 20250620-sm7635-remoteprocs-149da64084b8:v3
prerequisite-patch-id: 33c2e4cd2d8e7b9c253b86f6f3c42e4602d16b7d
prerequisite-patch-id: 0d64e5738385b1c3138f9e8f1a3061e7ca995203
prerequisite-change-id: 20250620-sm7635-pmiv0104-34a679937d9d:v2
prerequisite-patch-id: 8fca8b09d70409c5c78f9f1b77d0a4c75bce38cf
prerequisite-patch-id: f5c2c24d2baefcd7ff91718529ab2f2c264ab99f
prerequisite-patch-id: d7a06ece910e7844c60b910fe8eed30ad2458f34
prerequisite-patch-id: e91b741c9cfc80aa149bfd8e43cae90ca58e17f2
prerequisite-patch-id: 5ba4a49c3792cb208ee064a6ba13545e40cb70ac
prerequisite-patch-id: 9105660b1ac9a8cd5834cc82e42dc3aa4e64a029
prerequisite-change-id: 20250620-sm7635-pmxr2230-ee55a86a8c2b:v2
prerequisite-patch-id: 49135534a379bbbc76b5bc9db9de2d2ab9d387c5
prerequisite-patch-id: ec7c10dc254b52f55557f3000e563c7512a67d48
prerequisite-patch-id: a5ad0151f7c6d333457e1a0851428bd0667543f7
prerequisite-patch-id: 66d255a641f459a3326d193d983fc3e025aff021
prerequisite-patch-id: 4c1e65349589e4f90a0977e1cd9524275ffb4bca
prerequisite-change-id: 20250623-pm7550-pmr735b-rpmh-regs-06087e5b3a99:v2
prerequisite-patch-id: 7360606a06f8fba3ea9a8f84b4ecfb8209e91ab0
prerequisite-patch-id: 7a06a346abdb7f7386912b92f2b84af87e7439a9
prerequisite-patch-id: 1e1a6eb9c5421812c07421f9fa7e3f16b26a42da
prerequisite-patch-id: 60b99e8b1e94effb4a012ac205e9d570146afc2d

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


