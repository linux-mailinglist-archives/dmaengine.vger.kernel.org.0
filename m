Return-Path: <dmaengine+bounces-3677-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F619B9EC4
	for <lists+dmaengine@lfdr.de>; Sat,  2 Nov 2024 11:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00407280F58
	for <lists+dmaengine@lfdr.de>; Sat,  2 Nov 2024 10:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DA4171E4F;
	Sat,  2 Nov 2024 10:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="XgKiC9le"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C28B1714C9;
	Sat,  2 Nov 2024 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730542235; cv=none; b=rl0b3ratusmzWct3n7aFTL7bGlT3d6E97mX3ibgw4i2/XfAPRSTQqxhVBHckONDrIeepQ0aRw/SQmwmyTanqMaopoU6x1wlGixEb9cu6iRrmm6JIYjqVfKXEERFovfTouIDfb5hNxfrCxkdoL0Ro0yZzisiYh1ycVNXvzGozAVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730542235; c=relaxed/simple;
	bh=msZfN1vlHTTQkwq03Xyv0w1GgK6cVJfBoFs08qoycKU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U6iq2C2XloqEcuU/vPylnnK8VHrw5Q5OVrMp9V6/ibMA4S38Q8D/Yssy/A4j4EyImsgYu1pcKOXZgTmExjoPA2Llqr7vq0cIwt7cEfffMOgGV+tnd+lrEy7fkxm2yAeXxQ2NJX6P9VodoNGkgt3Ssmy6C9dIHiZpEPo9BaOUmCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=XgKiC9le; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id C8941A09BA;
	Sat,  2 Nov 2024 11:10:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=dC+s2x2zpsTUqYLdynlJ3f94YiheKXfponBNvdNMjDQ=; b=
	XgKiC9leoIhXmEAbZVWSBFsTDdg50PyWu8AvvLrkfT79/2cypQocCu0/JVzHzxCo
	FX9gFnIlOWM7C1GWp7tiaeNGmF3NMZUX9Na5G4NuHSzMB7LQRhxB+THIGQ3vHhrx
	EDKACzlA/6rvuklZxCoyXHRayFy5gtKxFQvFvCecArlhB4bTrvG1uWoCGt+7v0yW
	IN6j12Exu+LTCuYz6g1h6QzRnOot9Iq5oWJ4B/rq6Dx95iBoL8ZN0xSC+BDEUrii
	3XAlKVkg68RsnCofGSM5czpirf4EJKe0lrOCzUDtfnltBW1VCQ0aHQYoNzyqNUCE
	RLBlDY0vzTRfGg2fUbnHi6Ao5UDVxJG/mccJd3d2dyYNQJRLqfjVEVgPIFWA6Bk5
	JUfdtdfKQwDlGlrSSMut4vNjU+ZCTyGiUskcPWkhssQcFr5Idm4zplXOortqkU5n
	q4NZDHMmo9OTXMcF/5seugSlZGK2vnotl3Dp/hI/fWf3tDVYFCg6Z0zxeznl9H4c
	IJDj3EgwjUUzA33prma/x4WpFhx978xItF7aeikUun7jcU6NqAgNjdSjKY6aJzXn
	mMb0ahFyoYnOg42RteikoZt3TVuHlji2oB0ONDFc/TZpDk0xmHcy5aDeZL4KQ2mL
	SsfkKTyg/82fs7KZ2ZDnTkb6rBkuyoqQiLE7g0JaULE=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Mark
 Brown" <broonie@kernel.org>, Mesih Kilinc <mesihkilinc@gmail.com>, Vinod Koul
	<vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, "Chen-Yu
 Tsai" <wens@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Conor Dooley <conor.dooley@microchip.com>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Amit Singh Tomar <amitsinght@marvell.com>
Subject: [PATCH v5 0/5] Add support for DMA of F1C100s
Date: Sat, 2 Nov 2024 11:10:17 +0100
Message-ID: <20241102101017.2636558-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1730542228;VERSION=7979;MC=3166311018;ID=220060;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855667067

Support for Allwinner F1C100s/200s series audio was
submitted in 2018 as an RFC series, but was not merged,
despite having only minor errors. However, this is
essential for having audio on these SoCs.
This series was forward-ported/rebased to the best of
my abilities, on top of Linus' tree as of now:
commit c2ee9f594da8 ("KVM: selftests: Fix build on on non-x86 architectures")

Link: https://lore.kernel.org/all/cover.1543782328.git.mesihkilinc@gmail.com/

As requested by many, this series will now be split in 2, the DMA and the
ALSA/ASoC codec driver. This is the DMA part of the series.

Csókás, Bence (1):
  dt-bindings: dmaengine: Add Allwinner suniv F1C100s DMA

Mesih Kilinc (4):
  dma-engine: sun4i: Add a quirk to support different chips
  dma-engine: sun4i: Add has_reset option to quirk
  dma-engine: sun4i: Add support for Allwinner suniv F1C100s
  ARM: dts: suniv: f1c100s: Add support for DMA

 .../bindings/dma/allwinner,sun4i-a10-dma.yaml |   4 +-
 .../arm/boot/dts/allwinner/suniv-f1c100s.dtsi |  10 +
 drivers/dma/Kconfig                           |   4 +-
 drivers/dma/sun4i-dma.c                       | 217 +++++++++++++++---
 4 files changed, 200 insertions(+), 35 deletions(-)

-- 
2.34.1



