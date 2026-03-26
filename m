Return-Path: <dmaengine+bounces-9660-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MD0hA83sxGnN5AQAu9opvQ
	(envelope-from <dmaengine+bounces-9660-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 09:22:37 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B5C33139B
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 09:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 72F91307161C
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 08:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99ED3BADA3;
	Thu, 26 Mar 2026 08:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="qwNLRID2"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8A83B7B7D;
	Thu, 26 Mar 2026 08:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774513181; cv=none; b=tnj2F8Z/qk3EwQF3ynuWPBjItMgYFVjFv5l8g10cc/c4zf9Mg5iqpXRGn75CkCSBy7iO4N5Wfm73rZJ7bhIgAV5OXmW6xLdYDCuv1P+2mPy9ZlXBpQ07kJOQL/dYX9FNRhM3zvxjaCupsBAnZEtOidxNAIhFyijKFT2PeTRUSsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774513181; c=relaxed/simple;
	bh=jTzW/BlP/85Q+ebUua4Muo2x9pnkZwv/64rxq15Xclc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R9koFIUd191PfeX4iXhKJjZr0+zdslmxqn/VD8Fct1dob/DCEioVqnl5t7++ucYwMnyNN167hAQRFBd4mngqS0iAseLpPWHGAclOF7Cay4rFem4OCoUy5g5I1XaiIpYy6kM+OhhuEBaaZ8y4bYyLuxKI7eGgHdf/6VZVKTVXVCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=qwNLRID2; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1774513112;
	bh=X24IhPieDgBLiSP7Jey6c5qmaVJh9ukNDBwY2l74LNs=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=qwNLRID2fc0egpXFft83BjirTHAuHGFE05gVtrugTHd46SAKhYDlLL4N5I06sgrGF
	 UPuSfO7nKWQ6wzwpukMMYJaMG4IkKnoMs011Eut3TAwLZt2q0cFcxnZECYScjb2S2P
	 o2tZoiIUcu5fB1ZKFZwN0mpI5ysfE2r8GccOq200=
X-QQ-mid: esmtpgz16t1774513110t2f9ee44e
X-QQ-Originating-IP: 3Fqy/k1KQqWRHqrcdX1d3p6XWIRDCKU/1f8HFVA9VCY=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 26 Mar 2026 16:18:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8687179103118838065
EX-QQ-RecipientCnt: 20
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Thu, 26 Mar 2026 16:17:22 +0800
Subject: [PATCH v2 7/7] riscv: dts: spacemit: Add PDMA controller node for
 K3 SoC
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-k3-pdma-v2-7-ca94ca7bb595@linux.spacemit.com>
References: <20260326-k3-pdma-v2-0-ca94ca7bb595@linux.spacemit.com>
In-Reply-To: <20260326-k3-pdma-v2-0-ca94ca7bb595@linux.spacemit.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Guodong Xu <guodong@riscstar.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 dmaengine@vger.kernel.org, linux-clk@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774513072; l=1666;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=jTzW/BlP/85Q+ebUua4Muo2x9pnkZwv/64rxq15Xclc=;
 b=3hDlNh1Dew8xF43uT+rE6/WcbKSSrb5z8mSOX+K1w3Dpf+T8T4eRNTDd0Pytzl7fXe/S6kqVV
 wurgTM+kij/C7xADjHYnMoqVJIcsrkYdnT4IF2+ooR1GQ3q4nNclWEh
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OKX6byuwCvg7TA9sWPj9M7slTa/EiaWh0Wir5nsC29eRWMkXMBP9mTJT
	rtIPe0fBX7F2s807zJNTwN7LvSqRMRLX5XffWCGaSUpN+eGT2LZyFagVHtHNJd9U+WHvKJ7
	6jaMcP1CskR4xWqqIBTosJgSnqyeO2C+HiPbIFTFyOcIPUzEaNArLUsdW23ZAzI2qgB5RPA
	B266BqVBRgtA1AZ2VzV4DuZblb7AbFzze/PK1PIrlaW1gaC4wQ6uw88uvXJvh8lppCNRH+Z
	7ik7A99cu9EapMtdaOlyGLQr+f04vIVa7oEicplPWx3WkCzjUIOuLU5CEh+aTvzxa1uRs+T
	Qh5K+hdKnxyKZnciEBhjIjCv6qscveOgCc6Gkx6rH06WKpGFf0Rt5VLGX1zRaqWs+6a+egd
	sUv6hULKczGZtV9eI8jLEUsdoTcxFGxc460n4MRIPQx4+4N9fk7wXI/Cd9g0+YniJZVhANI
	2k00lYD5fidfsEqVOyzTn/IVPTstjftEa6ksI4czTui51IS1Qn14YFuJN7Wdg77q8H+QSCl
	rb107IPS5RAmM3CMcJdFU91nsu4/j8hMymNB4udaEyYFlLLbrVoOutohLYD79OtoL+Kuumi
	GQEL1feSDhH//gX+LL9GTxnnVcuqi/c3BuaYV9Y7PraF7iqIgbPCZDVcryEhkzniE5DzYuU
	Z0AjSJUOJAVP/t3PvMds6vFWeqk1M7yy3fBZYRHOQZWp/nREqrekjkTr6ufaRehFKrVmfgT
	QFcJY9Zoy91yIZmn51NHJXlxdHiFM2g1aNwMeodmESN9vmefVsULmdyfCs43uJvHQ8axWS6
	hCyyMYJWXBGWrvohDw/9XX7R5RMqPli59V7NDLk0z4nbvvjrKO91jcvqiAcSIJm/fpn97LU
	EM6vvFENWxQktOCIrFXeb4huistr5y5zLCEzT6i3EM0X4ECQMoo+ZCkF07r+hVDkHuxNkWu
	yDrrwHwki1ZsLUAeD6nIckFyZ8Qb85RIb4PZswjfzQJPPpytWulpQPAWAl4kfYYxijwyZ6n
	VXomLjmjI9O67mvQhfTCeo95nR9VH1Q7IOZNrmRM2UyFDBZGqPcMnuhPZbVT3YGdlM5Mdnf
	5RuzFw3/ztaKva+Qeqtp+tVwwYJfW2hbtEgodKQAa3ixCel8xsd3+k971O/xWf3gOIa225M
	LUwfFkDE9BAuLeik2phu7toTvTxMS7zRDzK2
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux.spacemit.com:s=mxsw2412];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[spacemit.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9660-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.spacemit.com:dkim,linux.spacemit.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,spacemit.com:email]
X-Rspamd-Queue-Id: D9B5C33139B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Changes in v2:
- update commit message
- using k3 compatible string
- Link to v1: https://lore.kernel.org/all/20260317-k3-pdma-v1-1-f39d3e97b53a@linux.spacemit.com/
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


