Return-Path: <dmaengine+bounces-10260-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPvhIaxr/Gn0PgAAu9opvQ
	(envelope-from <dmaengine+bounces-10260-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 12:38:36 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E7F4E6E36
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 12:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 44B813009E2F
	for <lists+dmaengine@lfdr.de>; Thu,  7 May 2026 10:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E423EC2C4;
	Thu,  7 May 2026 10:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="e7qjP51o"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB3B3EB7FA;
	Thu,  7 May 2026 10:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778150254; cv=none; b=Nalxsdc/oemVDtvxl5Zcnod2L84kSUZPZm61G2qy4r/xvAo1C+3WCA+ipapF07aoc8DZux4gzZBePq5yuOFBfGM0IRGgiZJuOsFH1pvBWi++CauJj/CeADUGpsJsGS24G0xDUcOVtojdfF7O56BgeTp3MvpXhwpnJ8pqr6/O/oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778150254; c=relaxed/simple;
	bh=UcgnyaWra/zqeOQob/WjOC8W7jbkn7uDsfsNgx6yk+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a2woVOWPHMraeWMPyTNdIQ8VdjWbk5esn7WSOSIKKAqkQZ+eKj7nXjfUaJTUzMhDq3uDkDxzwJhtipdFF7tkNGVaxhCH75nxVeruMaW98ehIhBW+s4UmfaRuJGLokXXc+qz51p1c+z8whgntkN0+a8L28P01bkrhayegqjIMW7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=e7qjP51o; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1778150208;
	bh=q9cTs1Fc6HOosuoCIVUk0fjsfQdYZlWk0msB6oMaeBI=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=e7qjP51oHFqRhM0QkFGh+yVFuQXuHYS/MZTI7rNgDX7WzyXFfBXvP1FVjaOJGfS0b
	 8ZuHQGOub1EuFeNeSKPFcM95juzlpm//abi2r9IVvkFwVv552HhBgIG07S1yS6r8cv
	 /K4pFKcnr2LRqFQizTAQ3INypZ2Wdjlq1xOv26Vs=
X-QQ-mid: esmtpgz11t1778150206t5ab20be1
X-QQ-Originating-IP: psN/mL0pLniw6V4U8YI/jaEoUJmf9vKAuNcqWpa3BiI=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 07 May 2026 18:36:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11507075083800382789
EX-QQ-RecipientCnt: 20
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Thu, 07 May 2026 18:36:23 +0800
Subject: [PATCH v5 4/4] riscv: dts: spacemit: Add PDMA controller node for
 K3 SoC
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-k3-pdma-v5-4-6b9743038026@linux.spacemit.com>
References: <20260507-k3-pdma-v5-0-6b9743038026@linux.spacemit.com>
In-Reply-To: <20260507-k3-pdma-v5-0-6b9743038026@linux.spacemit.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778150183; l=1492;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=UcgnyaWra/zqeOQob/WjOC8W7jbkn7uDsfsNgx6yk+o=;
 b=XOc0zZRuiXiBiZoN2eVYgNvG3zHP41yewOpJ76kQpJJtDH8H28Wf+lkzyIPnXBRVNdV2Q9uMT
 epKrIm+hSloDkYlvvqetMTtp6dk8M/N/b+DYHGRXVv0cxMCmuaovu3m
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MIebQsVGgJ8BS+4hYmiMYCQMGhxTjaYjN9XeuWqmA9lLr8hvfycLy2zG
	zSYsrg6Yu2lejAIOD0BGXcsBDZ1zKwmNVqw1KodWzUEudn6J2tZhylzFy3JZrnP+8w2haTm
	Nan/P7xKVSI6OnSWQUthlsinQzYzWKlINUGqFkBFvQYD1Bm/7+OFWJffblUuOdk61ZcJcA0
	T1JzApaicm/DM0Wf+pol+BxCr8iQOj1aCBuQmDXHJnrS7VNU4vHx9C/Nwr/7QyFOydAxMQB
	q644KaG37WsqWK39aSzhsEj9BwUQlp77V8kPJebGfAAWY4OW1mwjCeCYOo1f5R1tfRz0IgV
	cPrtqMCchLMzAHSDrfzKYgpns8/aZAdRlCaA68NiE98s3Pz0ZO7YF0myzJ2tqNCHF0Rg66Z
	s+cb7vKNkm2Xqe/ZmSHj5IiINyK8QzO4UeW0u/7CLFcK6opUPSlClMFaWtb+X4KrL7zQZaN
	qtoVXAPGeCHF48ikq/PPT/vWA6VJ/1dXPM+9WSfRaMRWEKuw8gyfWhv1hErhkRcao1UUUcr
	UcaR7I+ZpTX9fluZ8pKarkDpq4mVwB51Ajj9cWfeyRk6X8N/4PQjN08T1LJXkAHXW3NwGbl
	9fXwn6a4/94xPWAFQzsgvv9MmuQXGxRgO9AsJPdILltZ+qU3v9yYWyQ7tBa15t+Bu1vzBua
	bIC7+4YwIWG2kzXLsJSH6j2tY+V4pu8O2Pcay8kL7rXMyGO3U6IqUiudWmjbPcSX03DXlMu
	JTj//pKuJOVU/uG9TVlMBEsxxEsygjgX+zQ/DD2Uxz1K/seCunmjh0JJ3+GwpcjAJErz5dn
	vXNN6LuFWvnhsf4420U8SFoVQpbAGdqNR0ihPaZ67cZymGNNYgPy/KEry+GChjCKy+xLQsg
	HASrImQX7iUH1J0gDS4dR9O9FcCVPLC5dimHC0aQbHuWSj8qh1ogB1OwDl/LKVSPI9zyJ6K
	GwyzZof/AYs1Jq6y3RhiLMZx2qbS6k5tyYeJPXJ9h10CMEIXbaCwxyCHJzkyc3uts3+XDMo
	izcvPDZuRzgDUbcMUA215mKoIE5ONFBdWKaatz6F+bQJCacYIX/QAdNq1CmBXSXIfam/lKl
	ND3Pm7Wu4/FCsoDP9JpaFPxGTIMzW+ZRppe4MMB82VS2Kb1p/hz0okKmAwn7RPkpnt5KhD9
	kBiF7bSygrlazL3roVKXLSOrKjfp1yCff76d
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: C6E7F4E6E36
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux.spacemit.com:s=mxsw2412];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[spacemit.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10260-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[spacemit.com:email,d4000000:email,linux.spacemit.com:mid,linux.spacemit.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
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


