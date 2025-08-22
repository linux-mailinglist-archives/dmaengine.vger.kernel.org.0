Return-Path: <dmaengine+bounces-6126-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B455B30C37
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 05:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B621D7B1798
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 03:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4B8271447;
	Fri, 22 Aug 2025 03:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="kqxwAYqf"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46149265631
	for <dmaengine@vger.kernel.org>; Fri, 22 Aug 2025 03:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755832025; cv=none; b=Jw4Vp9dYfraUyeHH2cFRTsaghFZ+XF3M8qr+8wYkKjvky+MA19ajBa4GPuDIWqqZm+dLGtKAVN/V8xTCvALDo39VVhBkyjU5uARviLiwvCTCK8Vn8qqdM58RBlO6RjdIA94bZggFUNo5uK2zUlMpfiRfy+ooUEQmG6uAEMpU/Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755832025; c=relaxed/simple;
	bh=cFrWQEEvMc/7ZId6uak27PuJOXHlyYH9+xN4BakqZpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cdJnxJKywwB3DhVQ/uOXb/IqMBp54/0kcSEXEpK2Yv4uvJDZ2B7bo3ZHiPYv6U7YBDMOn6yiGNs6yGk+XXQs4X4eg9r+sQhSIllqIrLlCiwIj9qlVtN1+WqmKemKguIpL3sYOqFqwtyprz2eMV1pC3C4JNv5wWpLeEF/EWTEQw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=kqxwAYqf; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e2ea94c7dso1743620b3a.2
        for <dmaengine@vger.kernel.org>; Thu, 21 Aug 2025 20:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755832023; x=1756436823; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZudeS21S7Z9HKYl2WwDLHxu+6vkPHg6qhFAwHt0tdNs=;
        b=kqxwAYqfBHgQ+JJwAUosXmJYFt2MWianOW0QzPwGqRmtycDq8U1CkUom4Xlm8h92M1
         hVlE6rjaHeTpgjRjHiAf2CxZnAFQXkvnRibp6/vVG41wGGKLmB5SAXD+I0JMq1zXqrxF
         RJ/taYk/h2rV8qrhhA2LZdW25pv+jY4gx0s4ZHmmpkNVi5IcwszB3oxVouOuk717fOu/
         7EwpRSfyotgKGzqxW1W4KNNjtST7hie0v3/P86VCUelODnd42RKVQTvch+aDOLuQHdOs
         NoMm/X9mAL3HDMuMwjqKjb4SV2yoDrT2PQ/YJaAsEcPVJF5LarrGkRiy7cSmD2JqyVDm
         npvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755832023; x=1756436823;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZudeS21S7Z9HKYl2WwDLHxu+6vkPHg6qhFAwHt0tdNs=;
        b=w7kfTuOmMl4oqTq1xcoY/RvFPY28j/AC1PggRuw8mqts0L+85bNBmjNg0Z3vJOCaMw
         uDrnaDTj59IDz9Popz7ARLL8+BrJBGKYwEjH883VN4taei5AySmxUhIpMfMNF+21OX27
         oBgyz6bRa9BovObkt7v5mA8OtUXjNQ6JCG4NRjECEWYpmaO7acLhxtysVVXrG00vCU1K
         YnHn1q+xmYiC8on56rm5z+Xn1yFj136tDha5a2G1scR+WKoTW/m6IiFZaqLAnlbRKef5
         IOrcEhBbtK5i+T80mz7WRiHIgfA2h3qNOukp072h8pACwYWmxNdwH09c0uqsz+QrqDRm
         9Iow==
X-Forwarded-Encrypted: i=1; AJvYcCWFKkXGKdq74ulpKV3dWx1srTt5gVszGdt7GYpL8LL7WPSTEpqj9k3KvnOhnvBSRdeUz49AzHiNxFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW+oqroWLQ7mC1yxI+HPxh347iZhIFYLhzC6I5gnHWvoV2NZoW
	r52Eu9JaxvbiGDbo4qWi0fXEDfBtttQMS4aACWStEYYsE9yI1SKCSKqISrLNrGr8HmQ=
X-Gm-Gg: ASbGncuNJ+PzF/SxgqzvR6AS7DJOyzhhS9VU4XqYt0v5R4sq2a+h2ju4EHRfdWJY8WN
	WzbLJjHho+wcpIZwJPLJ4NLQ+vEAxqhrrLPTVuVWo7JqEin5pCpyA/9Yo5wyctGlMjVIoIhJqYQ
	VeNie+a/dOp0ekTVPGH+zngdBv3q8HLgtH67LEmqgX2iKkoWLQcty3k12ok7E7n0jNbU0w1+IeO
	jL8NucJAP3wJuMFpvFwvA7aKl3YqimNae4kL+bBJXwSlnCYvPfaT4qrWmP6DNfM/b8bmw3DvWjs
	nsRTj1kJq5m/anMX5te7bxE8tTUbHdBmkdpXkiqWd98zjOdc8wRUPeB7mgJgkn3rtuDTW8nHybK
	7hLFNiEQvkui3OW9bKbPEhYWmzLBmmUQZJtiQp69T95H4
X-Google-Smtp-Source: AGHT+IGm4j2NRRY1FzjfoUSGytYiPyWd0cIxjX3x+KRIkqu4iEC4XXZhVq4VrVHDhxiZRilFQYwnKA==
X-Received: by 2002:a05:6a20:6a0b:b0:240:489:be9c with SMTP id adf61e73a8af0-24340cd3104mr2211058637.39.1755832023564;
        Thu, 21 Aug 2025 20:07:03 -0700 (PDT)
Received: from [127.0.1.1] ([222.71.237.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b47769afc1bsm2756777a12.19.2025.08.21.20.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 20:07:03 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Fri, 22 Aug 2025 11:06:32 +0800
Subject: [PATCH v5 6/8] riscv: dts: spacemit: Add PDMA node for K1 SoC
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-working_dma_0701_v2-v5-6-f5c0eda734cc@riscstar.com>
References: <20250822-working_dma_0701_v2-v5-0-f5c0eda734cc@riscstar.com>
In-Reply-To: <20250822-working_dma_0701_v2-v5-0-f5c0eda734cc@riscstar.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, duje@dujemihanovic.xyz
Cc: Alex Elder <elder@riscstar.com>, Vivian Wang <wangruikang@iscas.ac.cn>, 
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Guodong Xu <guodong@riscstar.com>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.14.2

Add PDMA dma-controller node under dma_bus for SpacemiT K1 SoC.

The PDMA node is marked as disabled by default, allowing board-specific
device trees to enable it as needed.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
v5:
- Add reviewed-by from Troy.
v4:
- Rename the node from pdma0 to pdma
- For consistnecy, put the "interrupts" after "clocks" and "resets"
v3:
- Adjust pdma0 position, ordering by device address
- Update properties according to the newly created schema binding
v2:
- Updated the compatible string.
- Rebased. Part of the changes in v1 is now in this patchset:
   - "riscv: dts: spacemit: Add DMA translation buses for K1"
   - Link: https://lore.kernel.org/all/20250623-k1-dma-buses-rfc-wip-v1-0-c0144082061f@iscas.ac.cn/
---
 arch/riscv/boot/dts/spacemit/k1.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index abde8bb07c95c5a745736a2dd6f0c0e0d7c696e4..861f0fe18083fa158da51bd3be2808609f6233f4 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -660,6 +660,17 @@ dma-bus {
 			dma-ranges = <0x0 0x00000000 0x0 0x00000000 0x0 0x80000000>,
 				     <0x1 0x00000000 0x1 0x80000000 0x3 0x00000000>;
 
+			pdma: dma-controller@d4000000 {
+				compatible = "spacemit,k1-pdma";
+				reg = <0x0 0xd4000000 0x0 0x4000>;
+				clocks = <&syscon_apmu CLK_DMA>;
+				resets = <&syscon_apmu RESET_DMA>;
+				interrupts = <72>;
+				dma-channels = <16>;
+				#dma-cells= <1>;
+				status = "disabled";
+			};
+
 			uart0: serial@d4017000 {
 				compatible = "spacemit,k1-uart",
 					     "intel,xscale-uart";

-- 
2.43.0


