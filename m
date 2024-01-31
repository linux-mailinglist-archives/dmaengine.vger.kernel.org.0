Return-Path: <dmaengine+bounces-922-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DF88449F5
	for <lists+dmaengine@lfdr.de>; Wed, 31 Jan 2024 22:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B39471F22253
	for <lists+dmaengine@lfdr.de>; Wed, 31 Jan 2024 21:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A015239847;
	Wed, 31 Jan 2024 21:27:04 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE68381D5;
	Wed, 31 Jan 2024 21:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706736424; cv=none; b=ayUQ+WZZEYPmAyAgbsm7erFTTZspnf4gXoB1BioQ4mHXKrz2UC7aInhI39DUXMOL06g74IlSa2FG7VIfMcbk7lYGIN6tilYA3jZO7pcXPl9mooy+w0eRhKjuRwDjii67PGDgo7cYLReTvGjWsCJOu9d0ES0RRTO3FG9uzgvaKx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706736424; c=relaxed/simple;
	bh=C2xl6B8mdjbEM7LkG73vi5FpIpthCxvFmkdNbGVoIlc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SQyC9FTmryZI3GxnVA3/LU8H7yE0tKFIj5ESXF5QzDWOGfq8OD+/8jZ+h/maM/yAnzxF5bw6SLRm1C5E1Yn+C6nqIVKcEgIit8KMNKAMVDxyJXS05vYcaV3nb7a57oQN3UmJsRD1sj1MWH+nYPFeHz+6NumLToxQQD+4+OzyP7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 3169685431;
	Wed, 31 Jan 2024 22:26:59 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Subject: [PATCH v2 0/2] dt-bindings: mmp-dma: YAML conversion
Date: Wed, 31 Jan 2024 22:26:01 +0100
Message-Id: <20240131-pxa-dma-yaml-v2-0-9611d0af0edc@skole.hr>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOm6umUC/1XMQQ6DIBCF4auYWXcaoKCmq96jcYF1KKQqBhqiM
 dy91KSLLv+XvG+HSMFRhGu1Q6DkovNzCXGq4GH1/CR0Q2kQTEjGhcJl1ThMGjc9jcj6WhBnrZB
 GQrksgYxbD+7elbYuvn3YDj3x7/qDmn8oceSomkuvDbW1VPIWX36ksw3Q5Zw/5+1LdacAAAA=
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=971;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=C2xl6B8mdjbEM7LkG73vi5FpIpthCxvFmkdNbGVoIlc=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlurr2MhlWDhD09oCX/PC6H1E+khnjqapXfFbDx
 L4WqvslxCaJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZbq69gAKCRCaEZ6wQi2W
 4cU2D/4kM0DuhSjmc41eSbH1/jRvIChuFpt82fa1G71VMW03ZZPF99y3cyfANtRgo7ryLgirEGq
 Av2PYWez0AWHWua8YaMGRnDnoEgAUSkBXFYl10ctoi7YOJedfFk4C6JlZwarrt2KGyil1YmeoI2
 K7+dWPtlJkvKwM7FAm+RwYG3yR9sOtmCc8/qTu8OSvFCHZTiIDp/D+cptQvff+uDV8l+DRrF5EK
 dEeZWu832TrgTLj/u7ZyS6e2mmYM4HKoAFc21ijwgXxIjU3CE5qqBi8cEgWOmL+B1UqrJxm+LNM
 mlS8WemHNBcJsUNy6va4E1L22vW8+YuaG7l4ygPIWOZJQkz9TH26fNoQjAvu41NoeO7NFEur61Y
 S+YYc0vylfMUYlfwqf1eMccUTVMxhBqct5QwmG7x7bK0tAJLKjM9o8jMG32J+J3Yi9+5YtTYyIp
 xgBlPULgsljd4svrwhj5LrAT5qgPYhyAgfZ1HaxFhfrU8EIpTW980YIr+7EJa/Kdkx6Zhn87k14
 CWJeZU1dV3naauLTqpzMaN0pTODZKl6VWcYI+cmG3jo0uT/Y++YmX/wEaz61sWoIzleCRk4+AWM
 UsQL1i52Gh4QiZoKjAT8SU0Sm5FA8wB6t0CHvrGkp94sylTz9qmy9zzEX8ww7WiSt9U7vlL66Ig
 +YzdgR1Li4MiBxQ==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

Convert the mmp-dma binding to YAML and drop a useless property in
MMP2's ADMA node.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
Changes in v2:
- Add patch dropping iram in MMP2 dtsi
- Properly define asram property
- Fix asram constraint
- Drop pdma0 label
- Drop redundant second example
- Link to v1: https://lore.kernel.org/r/20240127-pxa-dma-yaml-v1-1-573bafe86454@skole.hr

---
Duje Mihanović (2):
      ARM: dts: mmp2: drop iram property
      dt-bindings: mmp-dma: convert to YAML

 .../devicetree/bindings/dma/marvell,mmp-dma.yaml   | 72 +++++++++++++++++++
 Documentation/devicetree/bindings/dma/mmp-dma.txt  | 81 ----------------------
 arch/arm/boot/dts/marvell/mmp2.dtsi                |  1 -
 3 files changed, 72 insertions(+), 82 deletions(-)
---
base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
change-id: 20240125-pxa-dma-yaml-0b62e10824f4

Best regards,
-- 
Duje Mihanović <duje.mihanovic@skole.hr>



