Return-Path: <dmaengine+bounces-4193-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D67FA1CD9B
	for <lists+dmaengine@lfdr.de>; Sun, 26 Jan 2025 19:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80ADD18844BC
	for <lists+dmaengine@lfdr.de>; Sun, 26 Jan 2025 18:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C07181334;
	Sun, 26 Jan 2025 18:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyXFvuKm"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3377C8632B;
	Sun, 26 Jan 2025 18:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737917946; cv=none; b=Y0F4N2E1F1lsiu6Da0xXw8o2MO7z6pukvB2PHf0r/D4z28DNN5XTOCU9x5K3fGLkzo8/QlRV/AEcQUISgnQN+iLuq52a7M0iYt/YZvZu/hyXEBObSUiyxYncG6ECgn9fYnPAu0v/iT07rvq1t0KWS8JZDfAlQaYeZTmeCDg4P/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737917946; c=relaxed/simple;
	bh=t7MiR81B+Iee46VXjw3fUJ5IYqT5cIbBOLroU8KM1fQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TG0MY0JB3XjVa9jJFFiHMsJuv3olg35ya46/0AjeT/PBV/pM0qt+OOxGGb8h0f0a6GH71jTG6ohXUCwQsqGDIeqdTTk+InZAEz/zefywvbqej5lgVTS+KyxIWxhgmI+Fx909t8Ub+V1/Nc5bTJMI662SEA8pQkK9xXDfTm1ozHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyXFvuKm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B03EC4CED3;
	Sun, 26 Jan 2025 18:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737917945;
	bh=t7MiR81B+Iee46VXjw3fUJ5IYqT5cIbBOLroU8KM1fQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=EyXFvuKmOEPqCcAclYtRc2Nf6D64xrAfFFHSZA0oJ5gamkDnb6Lx9KPgGTaKh2ZKh
	 StvXwLWvB4AXxrvQfCNYMVQ+vpVzioxQMMB5QA+tePMantmyW6B9rN0BRQvG1/FvWU
	 prHsgS/oe5U6OOHHZh5ZPSdmN7eKPsdtUb1nfbVEq0vPIx4qdqoqUXf6uZemN0OnPz
	 K8suGTkXNhL0Xx0Ng2m6CJ3yVE19C8LvGkQWvvwWjtIzah0W0CKFmEx6/EnIToChCc
	 AWYum0Cs2J7hzfAr6sBPp1fVniQybgbyId3cy5jTPg+VlAkwKGNgQLNyYIHuje6NCa
	 rNybsHqvM8Eig==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66071C02181;
	Sun, 26 Jan 2025 18:59:05 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Subject: [PATCH 0/9] YAML conversion of several Freescale/PowerPC DT
 bindings
Date: Sun, 26 Jan 2025 19:58:55 +0100
Message-Id: <20250126-ppcyaml-v1-0-50649f51c3dd@posteo.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAO+FlmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDQyMz3YKC5MrE3BxdMwuD5OQUiyTjtGQjJaDqgqLUtMwKsEnRsbW1AIw
 prb9ZAAAA
X-Change-ID: 20250126-ppcyaml-680ccd8b3fc2
To: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Scott Wood <oss@buserror.net>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
 Niklas Cassel <cassel@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Lee Jones <lee@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Mark Brown <broonie@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, 
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737917943; l=2648;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=t7MiR81B+Iee46VXjw3fUJ5IYqT5cIbBOLroU8KM1fQ=;
 b=rX4cEDadyqjKuA8yYkLZevdyfcRaUdz4BHeJl10YNn4xTsKCjeCD6OKBl3O1tpdL5puknSF0r
 w3DGg25+T63CHz+RBokGYXZ8fMyOUHiLEo+aY9gwD/QBhE8TjlNwX8S
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

This is a spin-off of the series titled
"powerpc: MPC83xx cleanup and LANCOM NWAPP2 board".

During the development of that series, it became clear that many
devicetree bindings for Freescale MPC8xxx platforms are still in the old
plain-text format, or don't exist at all, and in any case don't mention
all valid compatible strings.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
J. Neuschäfer (9):
      dt-bindings: powerpc: Add binding for Freescale/NXP MPC83xx SoCs
      dt-bindings: ata: Convert fsl,pq-sata binding to YAML
      dt-bindings: crypto: Convert fsl,sec-2.0 binding to YAML
      dt-bindings: mfd: Convert fsl,mcu-mpc8349emitx binding to YAML
      dt-bindings: dma: Convert fsl,elo*-dma bindings to YAML
      dt-bindings: pci: Add fsl,mpc83xx-pcie bindings
      dt-bindings: watchdog: Convert mpc8xxx-wdt binding to YAML
      dt-bindings: spi: Convert Freescale SPI bindings to YAML
      [RFC] dt-bindings: nand: Convert fsl,elbc bindings to YAML

 .../devicetree/bindings/ata/fsl,pq-sata.yaml       |  59 ++++++
 Documentation/devicetree/bindings/ata/fsl-sata.txt |  28 ---
 .../devicetree/bindings/crypto/fsl,sec2.0.yaml     | 139 ++++++++++++++
 .../devicetree/bindings/crypto/fsl-sec2.txt        |  65 -------
 .../devicetree/bindings/dma/fsl,elo-dma.yaml       | 129 +++++++++++++
 .../devicetree/bindings/dma/fsl,elo3-dma.yaml      | 105 +++++++++++
 .../devicetree/bindings/dma/fsl,eloplus-dma.yaml   | 120 ++++++++++++
 .../bindings/mfd/fsl,mcu-mpc8349emitx.yaml         |  53 ++++++
 .../devicetree/bindings/mtd/fsl,elbc-fcm-nand.yaml |  61 ++++++
 .../devicetree/bindings/pci/fsl,mpc8xxx-pci.yaml   |  83 +++++++++
 .../devicetree/bindings/powerpc/fsl/dma.txt        | 204 ---------------------
 .../bindings/powerpc/fsl/fsl,elbc-gpcm-uio.yaml    |  55 ++++++
 .../devicetree/bindings/powerpc/fsl/fsl,elbc.yaml  | 150 +++++++++++++++
 .../bindings/powerpc/fsl/fsl,mpc83xx.yaml          |  67 +++++++
 .../devicetree/bindings/powerpc/fsl/lbc.txt        |  43 -----
 .../bindings/powerpc/fsl/mcu-mpc8349emitx.txt      |  17 --
 .../devicetree/bindings/spi/fsl,espi.yaml          |  56 ++++++
 Documentation/devicetree/bindings/spi/fsl,spi.yaml |  71 +++++++
 Documentation/devicetree/bindings/spi/fsl-spi.txt  |  62 -------
 .../devicetree/bindings/watchdog/mpc8xxx-wdt.txt   |  25 ---
 .../devicetree/bindings/watchdog/mpc8xxx-wdt.yaml  |  64 +++++++
 21 files changed, 1212 insertions(+), 444 deletions(-)
---
base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
change-id: 20250126-ppcyaml-680ccd8b3fc2

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>



