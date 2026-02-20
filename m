Return-Path: <dmaengine+bounces-8994-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OryL6S5mGkdLgMAu9opvQ
	(envelope-from <dmaengine+bounces-8994-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 20:44:36 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B29116A6A8
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 20:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 883E3300B9F0
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 19:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B432366DCD;
	Fri, 20 Feb 2026 19:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="aFP0fx2f"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1752F36680D
	for <dmaengine@vger.kernel.org>; Fri, 20 Feb 2026 19:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771616674; cv=none; b=iIMNwjc8jUqR4/v660O+Os9N8ynP7BSoH8G8764/8JIT7s8UrJeUamsBdVpka+bN6TYwyJXqZyVLYsvyQ9TOH0VtwU7LzFyxsGXEqPqJutTkIYMIPCBb4ZDkxHcuH+C0Ipo0Fx20tquD7NoNCyt9Qs+UffrpH3FQzK0JUvZg0r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771616674; c=relaxed/simple;
	bh=lDR4hwKAnZx7jEioVJrSlzqGnc79ShiEsvnMpfk7hIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BEmaWUCPpF9vURg+DYsR63HvdqTtuTiZjq9XAsOlRA6ls8EC7Lgf3qfewg64d08HGsZM42yyFoTLSdRIggwXlOXYSvD8e1qz2vnABJN05lfLTJQE/75z1zp4MjXofVxrmw79TNPoV98BTEq2V/PtFHn1EwhcFycugm/kmeCL2a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=aFP0fx2f; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-483a2338616so13670145e9.0
        for <dmaengine@vger.kernel.org>; Fri, 20 Feb 2026 11:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1771616671; x=1772221471; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=idd3phAMZAFbXYRAtJBjuUopeP1FYK6fM2z0tYAIx5o=;
        b=aFP0fx2fhCcePNUmUhg/T/Tiv7HN2JjPHn8J/U469aZWT2n956umkmRY8a1ydQUUbr
         BCF3kVB7nnryZ7iv622oHnTiy1VwWnNQv+R0JPAHqV3vYOobxTVnWXeB8vJruEi/zV6k
         y8v9m0d+uSbWdWrFMy4nk9ff4g1txVTBIhuztjPOw0LglbN8JqyRXBosf8bhzktHBHKj
         zy2sOQW7QrMYWqQKZKRs+VrPJm4JmMmBOCB8TyMIkrpfKjG2SKbKRfN0441gOIWF6K8c
         Yc6MoC9fxURgMDBKojUBVPe1ZZIB+ItN54KdpDGRC+3kjGuO2YiLbDn7kgjf9cu+XEzv
         bysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771616671; x=1772221471;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=idd3phAMZAFbXYRAtJBjuUopeP1FYK6fM2z0tYAIx5o=;
        b=fm7XCaTRWpTsCBzZnH8tP7jJcpMB7uYGuUSAlxAPXVb6twxML6qDqPndvVzLSRhUl4
         h3pfSs+2qxY4CCdqakkGCOsD9uZxP0a4JR14UEv4iWTrabIxbu0HmmfzFROAnusS/4s+
         QFqZb1Dy7+rHrnq4djvTWK2yfxJVnZi325EPtaFgl57cM6jGhabeFzoLGIcEEYMvR2dS
         qdnbxkmr61Cu/aBMAaFihuysQKtzyjJwe78J1cIOtW7QlmKb56gfzoqBrP0WVW7LiJqs
         6zueqw1z5Sg/DU1HgSeHeft/d1t3UCY9L8yZqPlTxSamNhDifZsxbf9qm1SmPrSRA23n
         0tQw==
X-Forwarded-Encrypted: i=1; AJvYcCWcL1QIrH2NKViSjzv9SPEE5+Vdx5RIdu8A1Sic8fZoi8yDdzlbmbGM3ZVYe5NPa1XWJmlg8Yz4qds=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjq7poFS2bIV9Ni9um9sLNyxmMHs73rEK8ffXPWANz9EB01d3j
	yPFDUScZo1tnXddDWivFX3muSSUFV8tYhDgs7XY9HuCkbbo3mpdhmb7kVWAp7gh0CdE=
X-Gm-Gg: AZuq6aI0hH8ISK8eXBZY8BJGCHaQNtSYc8XeqUYm8pJSqHVVY49237LYIWR01AFcoIL
	dancXtobYmTgVRDwrCJENQX4GmN7wyRCv1+CQkQdaRNL4OBehXRaYPk8R77dWt/1LVSpLJ40cws
	QwhvkDeMIN72BP8vkcIb/0HlGWBvr7LkVctttZR3xFi/Ud4WGHoXb0OcygBXRSBChkJUC/0I7co
	YIqI+Nn+k+OtW0i7Pb8nZcuW8Ve3sc4b+V/SsLzd8NUkuJSSKNLJUu9CIJpD7QJWbAHz50afUay
	FweZeKuiSOdIYS17q159bU88CXInWqpS4mbRykFykhaqTT/6Z0Wz/FVdq9k10Ca/mqO4nSR7Rbn
	Duz7ndrRqeuQj3S8AWCxfrs/lmvSRhvnZuiPKDDgF9KoATq1zafvBQj6mgnTrP+NdLba0Hf+/cz
	mNUN5qtIQipDN2qPpUPjEw
X-Received: by 2002:a05:600c:6206:b0:465:a51d:d4 with SMTP id 5b1f17b1804b1-483a95b6debmr11062065e9.6.1771616671414;
        Fri, 20 Feb 2026 11:44:31 -0800 (PST)
Received: from [127.0.1.1] ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a3e1b7ccsm24460755e9.11.2026.02.20.11.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 11:44:30 -0800 (PST)
From: Max Hsu <max.hsu@sifive.com>
Date: Sat, 21 Feb 2026 03:43:57 +0800
Subject: [PATCH 5/5] riscv: dts: sifive: fu740: add PDMA device node
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260221-pdma-v1-5-838d929c2326@sifive.com>
References: <20260221-pdma-v1-0-838d929c2326@sifive.com>
In-Reply-To: <20260221-pdma-v1-0-838d929c2326@sifive.com>
To: Paul Walmsley <pjw@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>, Green Wan <green.wan@sifive.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Palmer Debbelt <palmer@sifive.com>, 
 Conor Dooley <conor@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
 devicetree@vger.kernel.org, Max Hsu <max.hsu@sifive.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057; i=max.hsu@sifive.com;
 h=from:subject:message-id; bh=lDR4hwKAnZx7jEioVJrSlzqGnc79ShiEsvnMpfk7hIc=;
 b=owEB7QES/pANAwAKAdID/Z0HeUC9AcsmYgBpmLl7WJN+KlGhaQDsDQuRh2UU1WfdgPf5OXwRa
 svTz8p0n+uJAbMEAAEKAB0WIQTqXmcbOhS2KZE9X2jSA/2dB3lAvQUCaZi5ewAKCRDSA/2dB3lA
 vbM0DAC+ZD2Mg/GWBwIyC/TlvwOiFOFQKy4esK8Dgt7GVcHUUoFwIEAyxbMsk2vMABjwkDseaQA
 JyDYZmK5sGPB3JK2U39FMzpY/+Zd3Dz7ZfHl2jnzKc++Dbw/1wXnU84mvIueSLfUNY1fKlqGUIX
 LUg7/2YfBSYRyYfE47D2MsCpLN8F6GHtPnj4GHJqH2uNkvl2dbM9b5eLkXeSYkG3DHnOQZzv3Ud
 vabdRYU8MyuvDpgrn14qt3NNxOSA2sb/DvXMJpVebiTyLQEi6N5jyW2NXk82YeqS2ORQMgtixxd
 ZRg/8RVFk1WRcE58fSEjd2fLoeiqVTQqCgPv3/5np+c5WPyZMn24rEC1xK2u2cITJsx7SzRGkRk
 YSrL1akXMVO1xgvz9D1JQVW4hiNMNfAL5T6ScMh42motZmukkGI9R7TnfsJmPe4mAkk7CuvOY+H
 ab2MadPqZA3xZ4njdWv4716jypgzPesD26uWEGpwrmw2DGXV47yWdPP+VA+bZ3PKQbw1Y=
X-Developer-Key: i=max.hsu@sifive.com; a=openpgp;
 fpr=EA5E671B3A14B629913D5F68D203FD9D077940BD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sifive.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[sifive.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8994-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[sifive.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[max.hsu@sifive.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_PROHIBIT(0.00)[0.153.128.224:email,0.45.198.192:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sifive.com:mid,sifive.com:dkim,sifive.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,e00000000:email]
X-Rspamd-Queue-Id: 4B29116A6A8
X-Rspamd-Action: no action

The FU740 SoC includes a 4-channel Platform DMA (PDMA) controller.
Add the device node to enable DMA support.

Signed-off-by: Max Hsu <max.hsu@sifive.com>
---
 arch/riscv/boot/dts/sifive/fu740-c000.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
index 6150f3397bff..30d0d6837c57 100644
--- a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
+++ b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
@@ -329,6 +329,15 @@ gpio: gpio@10060000 {
 			clocks = <&prci FU740_PRCI_CLK_PCLK>;
 			status = "disabled";
 		};
+		dma: dma-controller@3000000 {
+			compatible = "sifive,fu740-c000-pdma", "sifive,pdma0";
+			reg = <0x0 0x3000000 0x0 0x100000>;
+			interrupt-parent = <&plic0>;
+			interrupts = <11>, <12>, <13>, <14>, <15>, <16>, <17>, <18>;
+			dma-channels = <4>;
+			clocks = <&prci FU740_PRCI_CLK_PCLK>;
+			#dma-cells = <1>;
+		};
 		pcie@e00000000 {
 			compatible = "sifive,fu740-pcie";
 			#address-cells = <3>;

-- 
2.43.0


