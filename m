Return-Path: <dmaengine+bounces-924-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 994CE8449FE
	for <lists+dmaengine@lfdr.de>; Wed, 31 Jan 2024 22:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63FAF1C23A9F
	for <lists+dmaengine@lfdr.de>; Wed, 31 Jan 2024 21:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF89B39850;
	Wed, 31 Jan 2024 21:27:09 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120F739FF1;
	Wed, 31 Jan 2024 21:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706736429; cv=none; b=idYNsXTitdP0uno3+UIuVuVzRYkT1UxChWOZnARfgJT465Ec5AlFt8BPzTuQsXHl0sTttJdW2Ht5C3qsIJL0yUSNUjzRIUs+SULKWXokOBZVxOyRcUyOi+5azXlVcvYqEQ669Z0351zN+Rh8vp9kfByakyDROsWSTAqC7WqepqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706736429; c=relaxed/simple;
	bh=buBAlLs39uQNi21shfxdafiuOZnjkE6bEZ9Dhre1+VU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WFe3K3CzUn6AW5KPXBl9wAlhX/+5Rdaix/8xHMoPOLVX0S0dOk+6gjZHmaWXHJ/P6Ggq6Y9uJTXs+nQKzgvxeBULsKPPG3Nnt8sboXvzdHp1cmOqohmbrFOvncmWsdnUlTB1zQ1F0e39fHKI9uLdYzL8g6+ZgaYQql5NxW9n4UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 57FDC84012;
	Wed, 31 Jan 2024 22:26:59 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Wed, 31 Jan 2024 22:26:02 +0100
Subject: [PATCH v2 1/2] ARM: dts: mmp2: drop iram property
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240131-pxa-dma-yaml-v2-1-9611d0af0edc@skole.hr>
References: <20240131-pxa-dma-yaml-v2-0-9611d0af0edc@skole.hr>
In-Reply-To: <20240131-pxa-dma-yaml-v2-0-9611d0af0edc@skole.hr>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=728;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=buBAlLs39uQNi21shfxdafiuOZnjkE6bEZ9Dhre1+VU=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlurr2Wz3mWQu2FtJfvWIzRVHlqwYl45LQLZLEm
 7jcVpIGTjeJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZbq69gAKCRCaEZ6wQi2W
 4eu2EACs/rH2sFH3hlthYJ9ZiEI6DpdNhJfGSIeKGSOljLJvaao9WIThTjl0trs6iR9Et2pDdET
 d1YBDYtPHzf9WC7nHb9DRJy1cGiigFFdhn9Dov0EsdpEmAC099TG0XQVxxc5hPuLdzAKOiQyEmm
 C/fxNxr5/7qHJvgDl/bWUVh1h5Igri5W470LZ3HklxsOYzlDlBpj8QdUl0NXaSH4YcSxdso4NOp
 46p+CuBs+GI5HYKik4BFLsaMpKGDmOLPjNSPbozwosgG8VlsAmHzZ/v90m2VHKeQ3BBC7NYQPRI
 X1aXBQz4A1OUXJYP/JzHv/3/UxgB2ignDQxYaBgxAs8QM/eAMLMFcmqj4MGXIlay671sq6nw7ld
 raWY0U1TzjD3QThDMSRKZw1kijgVDYBixf+bgDvHLIu5SBB+VmXkb4NqDRlqKLxuzqn0WUUqpir
 QKnAjaWYSgrbvZgeIT6pEsKoBtIgjSQXY6KirH6RWaXyh2ZfV1o5jKM48BL+nBxv1Fho4O0bvit
 6KMNoq0bjC3AV0r4eLt/a5AoGnT8wHqCOn70w12Cu/u2q8gvamXT0nRHRTmakyaSip/trx8yOs5
 xRR3RUZ+7mSd8yVnwDRQCScEYgA2iA2tZF87TxRu4FYu4vbIu9ZbdT0VzfJACrZbuSemVmw7RgX
 913/NPw5IhmzQkA==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

The iram property appears to be a duplicate of the asram property, with
the difference that it's not used by the mmp-tdma driver anyway. Drop it
from the SoC dtsi.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 arch/arm/boot/dts/marvell/mmp2.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/marvell/mmp2.dtsi b/arch/arm/boot/dts/marvell/mmp2.dtsi
index 987d792f67ea..1c0a1b58373c 100644
--- a/arch/arm/boot/dts/marvell/mmp2.dtsi
+++ b/arch/arm/boot/dts/marvell/mmp2.dtsi
@@ -212,7 +212,6 @@ adma0: dma-controller@d42a0800 {
 				interrupts = <48>;
 				#dma-cells = <1>;
 				asram = <&asram>;
-				iram = <&asram>;
 				status = "disabled";
 			};
 

-- 
2.43.0



