Return-Path: <dmaengine+bounces-4334-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F39A8A2CF08
	for <lists+dmaengine@lfdr.de>; Fri,  7 Feb 2025 22:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED702188DAEC
	for <lists+dmaengine@lfdr.de>; Fri,  7 Feb 2025 21:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8CE18E02A;
	Fri,  7 Feb 2025 21:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfve54Sx"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C53323C8C3;
	Fri,  7 Feb 2025 21:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738963835; cv=none; b=Mjr7r8lQgCIYdsV0xkLiLNItAXN9K7LU9vY+HrMpTAl0OZJZ4tnCrxBEP4mWZKHuTipLIkicY9b2+zRgvsLn5/zWvQIsgD7YBsIpZbbPhEpl7hlkVDNScTmphvBnIGaVD3huCMJ7UFNhIXfPzE/2zlCAa2mWwI0++rkiigaHZkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738963835; c=relaxed/simple;
	bh=94ujvz3tk5ekjf2MZlbHHWzbwwWLaHAsa3ywPEveVtA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YkvhxOXaAU6j8g+5jLZPey9XhwD9OXuydAfiM70GFOQqxNpc5ahGvxlLi4KPS5m5b5W1lBCoejvHpjibSPPYc+XhikEaED6ZFJ36Tv3eIvKH1i5mxgM2iSBY+7cU2SFIxZpZMB0ma+eboT+ty+z2GPzwb66Hb0CytfkJLe3jsnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfve54Sx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0CBADC4CED1;
	Fri,  7 Feb 2025 21:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738963835;
	bh=94ujvz3tk5ekjf2MZlbHHWzbwwWLaHAsa3ywPEveVtA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=cfve54Sxfr9QBL7efbkka4gqbqtmLqDIX7fxuTzqbSgJRFcfeed3+Xr+9fKlcgoO0
	 7SkednyYe2a+mlwJXN/glHoULVuuNp1baglH2iIOGjL+wNZ+jRBjylOQx6u0p5+ZBl
	 dMyKW521/HplkdQ4imXzl6l6fSsYfVhNa5B42O6un/jk4TqpNh8LMY+JP6I5TeqJtI
	 D+hMbghbT5SMbxIjdMfsO1nwhUBYR53hrYmqyIhj7ciuV4+FQgVOboC0ytQwYr68hX
	 G4Sie13QcWfrJYErG7fN0GLjtfB3Vq/d//lMLHG1rsxBb8gSVPyyrXdt0fxq4WzU4A
	 L30mdjjFq+xFQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5C6C02194;
	Fri,  7 Feb 2025 21:30:34 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Subject: [PATCH v2 00/12] YAML conversion of several Freescale/PowerPC DT
 bindings
Date: Fri, 07 Feb 2025 22:30:17 +0100
Message-Id: <20250207-ppcyaml-v2-0-8137b0c42526@posteo.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGp7pmcC/2XMQQ7CIBCF4as0sxYDVEh11XuYLuowWBItBAixa
 bi72K3L/+Xl2yFRdJTg1u0Qqbjk/NpCnjrAZV6fxJxpDZJLxYXULATc5veL6YEjmuHRW5TQ3iG
 SdZ9Duk+tF5eyj9sBF/Fb/40iGGeK68vVKoG9MWPwKZM/r5RhqrV+AeTPTISfAAAA
X-Change-ID: 20250126-ppcyaml-680ccd8b3fc2
To: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: imx@lists.linux.dev, Scott Wood <oss@buserror.net>, 
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738963832; l=3147;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=94ujvz3tk5ekjf2MZlbHHWzbwwWLaHAsa3ywPEveVtA=;
 b=9ApSQvdR7H4b5oYJC3cFy1ErDfu4w+UKbTU0bUdy14D+XfqSBEdTRk2y9o2+fy4Ll7XwAb/Ap
 0ovzTOSCrwXC+++bUZmGcEPJeGRovxiY/IKS/grKdK9HL/fa7Yy7Bo+
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
Changes in v2:
- rebased on v6.14-rc1
- various style cleanups, both in YAML and in DTS examples
- minor improvements to the commit messages
- Link to v1: https://lore.kernel.org/r/20250126-ppcyaml-v1-0-50649f51c3dd@posteo.net

---
J. Neuschäfer (12):
      dt-bindings: powerpc: Add Freescale/NXP MPC83xx SoCs
      dt-bindings: ata: Convert fsl,pq-sata to YAML
      dt-bindings: crypto: Convert fsl,sec-2.0 to YAML
      dt-bindings: mfd: Convert fsl,mcu-mpc8349emitx to YAML
      dt-bindings: dma: Convert fsl,elo*-dma to YAML
      dt-bindings: pci: Convert fsl,mpc83xx-pcie to YAML
      dt-bindings: watchdog: Convert mpc8xxx-wdt to YAML
      dt-bindings: spi: Convert Freescale SPI bindings to YAML
      dt-bindings: memory-controllers: Convert fsl,elbc to YAML
      dt-bindings: memory-controllers: Add fsl,elbc-gpcm-uio
      dt-bindings: nand: Add fsl,elbc-fcm-nand
      dt-bindings: mtd: raw-nand-chip: Relax node name pattern

 .../devicetree/bindings/ata/fsl,pq-sata.yaml       |  59 ++++++
 Documentation/devicetree/bindings/ata/fsl-sata.txt |  28 ---
 .../devicetree/bindings/crypto/fsl,sec2.0.yaml     | 142 ++++++++++++++
 .../devicetree/bindings/crypto/fsl-sec2.txt        |  65 -------
 .../devicetree/bindings/dma/fsl,elo-dma.yaml       | 140 ++++++++++++++
 .../devicetree/bindings/dma/fsl,elo3-dma.yaml      | 123 +++++++++++++
 .../devicetree/bindings/dma/fsl,eloplus-dma.yaml   | 134 ++++++++++++++
 .../memory-controllers/fsl,elbc-gpcm-uio.yaml      |  59 ++++++
 .../bindings/memory-controllers/fsl,elbc.yaml      | 146 +++++++++++++++
 .../bindings/mfd/fsl,mcu-mpc8349emitx.yaml         |  53 ++++++
 .../devicetree/bindings/mtd/fsl,elbc-fcm-nand.yaml |  68 +++++++
 .../devicetree/bindings/mtd/raw-nand-chip.yaml     |   2 +-
 .../devicetree/bindings/pci/fsl,mpc8xxx-pci.yaml   | 115 ++++++++++++
 Documentation/devicetree/bindings/pci/fsl,pci.txt  |  27 ---
 .../devicetree/bindings/powerpc/fsl/dma.txt        | 204 ---------------------
 .../bindings/powerpc/fsl/fsl,mpc83xx.yaml          |  67 +++++++
 .../devicetree/bindings/powerpc/fsl/lbc.txt        |  43 -----
 .../bindings/powerpc/fsl/mcu-mpc8349emitx.txt      |  17 --
 .../devicetree/bindings/spi/fsl,espi.yaml          |  64 +++++++
 Documentation/devicetree/bindings/spi/fsl,spi.yaml |  73 ++++++++
 Documentation/devicetree/bindings/spi/fsl-spi.txt  |  62 -------
 .../devicetree/bindings/watchdog/mpc8xxx-wdt.txt   |  25 ---
 .../devicetree/bindings/watchdog/mpc8xxx-wdt.yaml  |  64 +++++++
 23 files changed, 1308 insertions(+), 472 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250126-ppcyaml-680ccd8b3fc2

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>



