Return-Path: <dmaengine+bounces-10104-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kH3iLVAo62muJAAAu9opvQ
	(envelope-from <dmaengine+bounces-10104-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 10:22:40 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC3E45B606
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 10:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7FB413006084
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 08:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1E8320A14;
	Fri, 24 Apr 2026 08:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="GBy9+lMj"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D42431D757;
	Fri, 24 Apr 2026 08:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777018949; cv=none; b=FpJyb+tRGrRXurut22fHIm4Kldk6Z0lQHWqzRaKTFQFfrmcFHn4hhWseqZA2KyFgAUtP+q6e4Ja5Kv88R0YBWz/siZLBtH/ItmlrmcUzhpyD4u5rBAFpa0m2ihGFUdm8aJhjpdwfVTs8UNALcUpaiDw/ctTKJcRqBp6BacScS1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777018949; c=relaxed/simple;
	bh=uCUNP+lKsd/WyoTYB/YeSCQQ3CkT+PW7MTsRUSfaj3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cvqlZGTX+4UCyUgs9AmuU1KkUmALnmFqXbGu78GDxv2NgVWYX44y7v6IWhErIj63DQLrkkSnrrPary6amungXoY5LL8hA6cGzZloot54Zt7re53HSthlokuq8rE/6KuCb22LfmZ8uQGzQn1KkHsuYAY3cXOiAhYsefCzMDgYUCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=GBy9+lMj; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1777018896;
	bh=zQoYyY05/NN4DIdF/DF5E5EPkS4eUcGFX5Kh/T/X+gc=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=GBy9+lMjjqRJwGQLmjzyID9W9OubJxQyaT0ExNhqLGKnSxJ4vzlOJddRWd5Ii71qu
	 cGW7S5gP/npHtEHqMTaP4TWDDTxiNGpoKxvs8iARnaOkUTkzLb5SOYc+YWTkoxO/oq
	 EfXSpLSzlLD4/4zgVopsloUHimTB3MUvZIA2hYBQ=
X-QQ-mid: zesmtpsz2t1777018894t7fbc59af
X-QQ-Originating-IP: Zezn9LywKqxxsoLAOZMIyrvMc3zyPMp+d2tDMj7nmoc=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 24 Apr 2026 16:21:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16648141610303718672
EX-QQ-RecipientCnt: 20
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Fri, 24 Apr 2026 16:20:33 +0800
Subject: [PATCH v3 5/5] riscv: dts: spacemit: Add PDMA controller node for
 K3 SoC
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-k3-pdma-v3-5-efdf2e414a08@linux.spacemit.com>
References: <20260424-k3-pdma-v3-0-efdf2e414a08@linux.spacemit.com>
In-Reply-To: <20260424-k3-pdma-v3-0-efdf2e414a08@linux.spacemit.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777018865; l=1492;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=uCUNP+lKsd/WyoTYB/YeSCQQ3CkT+PW7MTsRUSfaj3s=;
 b=Yv61+gDpoL0yOj/qaJE39cneTaSwlm3hf9ez0iDOr6JobWqZliu4aid18u0G8OVW/8HdUnbTP
 afmvbZrzqBaBxhmkUcutIHCVwha0FRSn0CY1iUai6bXo6GTt2eRVSqX
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NoLc/2Jxb1KSXz3cBetQjuqTTflZojaC8lLCQ1X2Xt0mwvO8fOw9d6Kg
	nElxcL5sMhaMfUe8heeJRpZKUmyAcU0+n5TKUrqY0UsjlIa1jj+jQhz16nDmXgJ12ZGgLvV
	FeaFgFHNFsZw61ygbI8FXK8lOhqtexQzgd41PZPi4X+SVBHt7Ib0V42qlpZP/cu3bxpB8i/
	tNMrueeEXlqSiC3KYeuQFNYZjvRvhQTPdDB35PcXRqYF9e6lq8W6/uhcm/GjIiz+gufyMEM
	zzP1VaY1b4tI+eMxiV/6ph99mDK2OrCsLgUyUv3oT4nBpY0m6Jv4owFBuVdBtmvFYHuv1B9
	mjo7+uxx73dhkP6pt8yCjhGCChxhnDrimFI3fu1IyUCo66AMheTxZCeAjBKMdyEcF5ZBCM4
	3nkslYCf6txZ2+aKQrHDYYjN0oe2LQHeIvi/BQ90c9mjQqiW+ggdGlAZe+f0pmDvzQV+qLb
	xZhBFPR94wMJY6Bs6xCW/6h8uchzIG2IdORaNFqeHcjaSAo7CffgTz930eEk0P2ymnl3ejD
	lsk4pnu124MkZu/AebpBBCxgOmizNibo5NeACy3pBcCCOJ3q8IqNaix++R71/dUlB0Ga6Xg
	hHIvY31vgxhNyGOJ+q/kr10ssxRTLmkuUEDCMNucUBiDZZH/Rvg8u8qx3+qA//+CC6ouGvD
	uGzfjmx5iLucn9Gg7fv9YgVd1LUjFc6Y/8GqB6JxQjT8tkI768pimTdCy6ZDFKbvs3opj9C
	kctk8DTycXTNHQZq1s4M+UHWkBV+AVMJN3ZJ3DJO2IqQrvSCwGVQiMAeova+bzQtg5ydTRd
	NpS4TFkn/X1w9hYWQ3QVW36kI3LMCIRAh4NL7mRBUIYFHLE7NaTsL/B01ojh+1navLpP8F1
	Rwa61cihJazQbI6J//pSPWf8zYD9ui4T3hzsQrJEYcgj1g5J0xrdOPMxbYgQfR80nNj2rvd
	7nubyS4b0lhzWNlvdTN3bdIV9iNagSiFWXdv+QOqB5HT0FQYLM0/0W199ZlX5QpZqkDWIY+
	5U/+Sri4Ihm9++U64wqkzLjuqQSI73GE3if7JRn9sbFha5fy09k6r26bOwWdETyEkVvTkD3
	LZNW0Dk7U9ug9Yy2UpaxEf8xbdvr2K136cKa5XyI21e2kCnNY9YHv1igWfANVsb9w==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 5BC3E45B606
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux.spacemit.com:s=mxsw2412];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[spacemit.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10104-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,spacemit.com:email,linux.spacemit.com:dkim,linux.spacemit.com:mid,d4000000:email,d4015000:email]

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
2.53.0


