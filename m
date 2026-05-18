Return-Path: <dmaengine+bounces-10496-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCN0O9WICmr62wQAu9opvQ
	(envelope-from <dmaengine+bounces-10496-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 05:34:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC5456574A
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 05:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78F813013247
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 03:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED373803D0;
	Mon, 18 May 2026 03:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="KgAKrE+O"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CD4349B16;
	Mon, 18 May 2026 03:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779075281; cv=none; b=j1Bh+h/SG8gBCIQ1mINYT/7yPCla8oxibiAq1xlJW6Ekk2qc9nh33xBeR4qHEuNIW7/OyI5g9xFYdmIfrKpsbN0odXWwiR0yc2sNMrSAYQZX4LpIFyYrJ8AgLoWF7lsJadxPsUICE6MGaGxMo5b/HGHLmwfwgZk/NOEx9TPaSGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779075281; c=relaxed/simple;
	bh=UcgnyaWra/zqeOQob/WjOC8W7jbkn7uDsfsNgx6yk+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WhrCSVkycFHqeeaTgX7wZIBrMaW9SiCgwD6B0kKOVPZ6pmCtzO7wc4o4WWZtbHIyUEAJtpx2YvcNwg+MQKE+QDqZXIHXlFc9BbDhyOQur/94kIoeZh4hwoHsvUsj974k0GMGOgaOb98sbo7mZNV8Cab+SxBii41Gb/+hWWQhyE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=KgAKrE+O; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1779075188;
	bh=q9cTs1Fc6HOosuoCIVUk0fjsfQdYZlWk0msB6oMaeBI=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=KgAKrE+OhCymuix1/hRI1S8yc8ga6RiqWlfK3jAHB+YC+dWRf7AtRaHoT1g1MWUUX
	 EnO4rx67YfvpuT5WNUIPGZxQPcjSFY/fgMkyoS0lfd/DfjVIOBqGMDsW8w4oAPuQcf
	 5MWtcg6NtJ2Iq9bUY1Mmhs92G+txtxhh9VI0Y3s8=
X-QQ-mid: esmtpgz11t1779075186t3848c393
X-QQ-Originating-IP: uPvjKO1t2KTQ8lO9f/xBXIPU/kPKelDT33PkQW+MWR8=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 18 May 2026 11:33:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16121621445768738612
EX-QQ-RecipientCnt: 20
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Mon, 18 May 2026 11:32:44 +0800
Subject: [PATCH v6 4/4] riscv: dts: spacemit: Add PDMA controller node for
 K3 SoC
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-k3-pdma-v6-4-67fdf319a8f8@linux.spacemit.com>
References: <20260518-k3-pdma-v6-0-67fdf319a8f8@linux.spacemit.com>
In-Reply-To: <20260518-k3-pdma-v6-0-67fdf319a8f8@linux.spacemit.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Guodong Xu <guodong@riscstar.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779075161; l=1492;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=UcgnyaWra/zqeOQob/WjOC8W7jbkn7uDsfsNgx6yk+o=;
 b=gXXQW9P/zgQmIjJbTvYrldNydgUQ0POX1snKO+9oVuYzksb/se1r6RLbcyExplsG0Fr3Rofn1
 cD1g2gSAK/iDRuFZEXW1s8lE3NZkpBrVZIA3u20NvOouy8aU1cHk1Tb
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: N61MakLYUF4qyv5S5dKmpzAi9Um4L+jP7FpVxJLaQU4MvtKI+OBYB4V8
	GlJll9vq2INCVBD9dfHZ1yW1ongAX9AUWiYGpkkDh6cjPhx7OHf5GI+65hIipNpG1dx9IQx
	VfjD08dqB+0k2TqHwjOUvuts8h7IHXlxrEdOnciJLm2N9k3IjXZJE/HPn43NXWwFQpFNf12
	eSvD2tvrf4+iaqUSXkBW8mZJRIHmt4MmMfPmlVfTrCrDNicOHKQsozIUSPNqhj0DpiKHP+j
	yhLx26JM4j1DtYSyA5bleRJfbFs5Vo1wazO/sbeIF4TNch5zCpIFYPpIXVgLMYT9oHQTGwC
	pWI3yjQHWvzAF2CGSRRn8bOVxQygOZsXkw4uEtusUwl+CZ3SSh4ZzADgXfX8cbYOrnRPDNM
	fGrIqkt0CDyOQb9BW8J/9iHFf9WqNvzRyzXRiEbZA8sg9fXH1lG9+HLrpGAcoRzd/UDMC78
	c5LaRkEcJpSY6/Duc0ACfFY2GUj5xMsJ9JPWAwFQVz/ZkhEsZ6x8y5ief+9OBVH8OzInBOu
	lZ4sk5sfhm8wOSxFDuRWSYHjWnGWi+Lzoa8PSap8U7Ob2e5RBZSRSqIE6SjeAsyuGrUaoEb
	y26+Kf4tna2yxp5jAj4kRSfOtUD8YqEjGmldQBMh9W01S0QCm+cB4FSMyNBY/8GR9kHObcn
	wBRQKf9fgXTgBL2RzMSkVDnlISR+++F3zVDOKHXRLWTdUA1TXl/8pme5ykbqbyGkWVBj7fR
	XJJU+BAeLNUFtLxyJwVomyp5NyprDwiECcxaSUR5++3TwDoh/2K0RqdKOukQBTRjphURQH7
	dOGYEtSpuyRZ+HFJ0z6xatWPwKqDgkaJlcvx/aMxsPbU0heKcVaPLnRg33hy6n8y/ttzHm4
	cTquZ8baumLdNMncwf6feKzTLFLKSlJJsMxNCSzyaqrx7BcasJnMPnVDQoaqSOzTNn06Ktz
	8HzZN0VpixbVpud+6rSCiz5xlt8Bc7sMJodPgYYwYYPbxFs+QYW85vbBvPHvS/5W0cL1ENa
	xn8+f8/s9sCc9F1OkIqMSD+EJ6gPdm/AyMJjD3AddxjO7YgWP8OXkEFK22zvG3eItXLybc7
	R5py1SdkPQiMtMBVpk0zo8iWe/BteVcdQTEygXOR+swFxQPUr29JIHiW4cphg/jpQ==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 5BC5456574A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux.spacemit.com:s=mxsw2412];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[spacemit.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10496-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[troy.mitchell@linux.spacemit.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.spacemit.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,d4015000:email,linux.spacemit.com:mid,linux.spacemit.com:dkim]
X-Rspamd-Action: no action

Add the Peripheral DMA (PDMA) controller node for the SpacemiT K3 SoC.
The PDMA controller provides general-purpose DMA capabilities for various
peripheral devices across the system to offload CPU data transfers.

Unlike the previous K1 SoC, where some DMA masters had memory addressing
limitations (e.g. restricted to the 0-4GB space) requiring a dedicated dma-bus
with dma-ranges to restrict memory allocations, the K3 DMA masters have
full memory addressing capabilities. Therefore, the PDMA node is now
instantiated directly under the main soc bus.

Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
 arch/riscv/boot/dts/spacemit/k3.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k3.dtsi b/arch/riscv/boot/dts/spacemit/k3.dtsi
index a3a8ceddabec..cd321975fc18 100644
--- a/arch/riscv/boot/dts/spacemit/k3.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k3.dtsi
@@ -438,6 +438,17 @@ soc: soc {
 		dma-noncoherent;
 		ranges;
 
+		pdma: dma-controller@d4000000 {
+			compatible = "spacemit,k3-pdma";
+			reg = <0x0 0xd4000000 0x0 0x4000>;
+			clocks = <&syscon_apmu CLK_APMU_DMA>;
+			resets = <&syscon_apmu RESET_APMU_DMA>;
+			interrupts = <72 IRQ_TYPE_LEVEL_HIGH>;
+			dma-channels = <16>;
+			#dma-cells = <1>;
+			status = "disabled";
+		};
+
 		syscon_apbc: system-controller@d4015000 {
 			compatible = "spacemit,k3-syscon-apbc";
 			reg = <0x0 0xd4015000 0x0 0x1000>;

-- 
2.54.0


