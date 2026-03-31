Return-Path: <dmaengine+bounces-9756-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GidM02Hy2kuIwYAu9opvQ
	(envelope-from <dmaengine+bounces-9756-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 10:35:25 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D763663AB
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 10:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EAF9310367D
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 08:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10DF3E0C48;
	Tue, 31 Mar 2026 08:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="AEbh4MeN"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706E03E0C69;
	Tue, 31 Mar 2026 08:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774945724; cv=none; b=YKhOqNF8uDM2SiwGgFDbicIR5SPHOfTYYHkGnuatLieM0q/NR5e8xJOeTBmiR54Q2iS954lrqhn4fFyiu4MgMFcjCiWQV/hKl9Ld4GDozKRuHyriq9iEFt2r8SUK8NryhoHg6tP6AWvN9qEGGN6b59lKuBrZ0Db4vEraLcTQ7zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774945724; c=relaxed/simple;
	bh=uCUNP+lKsd/WyoTYB/YeSCQQ3CkT+PW7MTsRUSfaj3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KevvV6HkABfeKYJ6ltuuA6mQt7PvlMeegfFaIUB8VmkGWPqYBRMlDYo/jJLCgDg7PCpL5pMvfM5iMfoRcZxOibWltdHN95+fm+PnLaLrBGY0CIITmuPQAbPxYjDTmrOIa5TomWecBGhcpjsWhAZlJefeNXOPMtNTBF2x4Mg3t2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=AEbh4MeN; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1774945662;
	bh=zQoYyY05/NN4DIdF/DF5E5EPkS4eUcGFX5Kh/T/X+gc=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=AEbh4MeNy+4C/6KCzb6+K+Epe3SLhZtReIYde2zXKWOa8+3aBpKNMDcISVnszlBRf
	 IZIQBhwua9/rrAsykgUaloWzUSXLKdF53fkfQll8qQ6UawlVao2sahPHYIvxZQNuSp
	 YfSGwjEbI/8ozPHXilO+uehd8u4pPiFQyKFMmkWQ=
X-QQ-mid: esmtpsz21t1774945660ta7daa60d
X-QQ-Originating-IP: GjHiuxIfRSsNOn5618I7qlZiklEPnClLa0+OptB6tYM=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 31 Mar 2026 16:27:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6010631218431936232
EX-QQ-RecipientCnt: 20
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Tue, 31 Mar 2026 16:27:08 +0800
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
Message-Id: <20260331-k3-pdma-v3-5-a4e60dd8b4b3@linux.spacemit.com>
References: <20260331-k3-pdma-v3-0-a4e60dd8b4b3@linux.spacemit.com>
In-Reply-To: <20260331-k3-pdma-v3-0-a4e60dd8b4b3@linux.spacemit.com>
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
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774945629; l=1492;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=uCUNP+lKsd/WyoTYB/YeSCQQ3CkT+PW7MTsRUSfaj3s=;
 b=vApl4HNXczu6nf5zq/M4HL8n5ctkadC1V4pDcxt8t7XYKnGayBPG25Fh+Lf5VqiBqH72q4dsI
 hi7jJWIqYhuDxxS8/+kon6GXX9zlRLPTzJbeKEfOOSAwvQoZ7qtSt7H
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NeScTrMyTZw6e0LsQMX4R5C3bWyhZLYNGaljWSn4yuKsoP7cHyr9vYgK
	dW/o21vWoop+8GO8zeyQugf/WbUzZp9TROLEb+GQWSH9tpUNDYDi544ITBwCvWG9YnAKaqU
	6Gt9Z74IYeLk50ux5aejL8GV7ouIyLvH35V5iMM2ND7GYRvFHKQ6NeyGxtZNnS4ktFCWIZK
	5kUe8CgUplykbsiOjncfCGFTwq/xSmTYFNlycpRGtWEkxZdzq4C5iZJv4ZnIPzPwT+zBFXm
	JPl5jXwpwSNs2seA5lWybrUPCpDNC6Fr/OLZeTGnKnPyTB4B0IdWT08tKcfKA9c4FmGvCix
	V78SQ3TkMq/tTPEwHYqodBui1poyYKQ25PmexHa/Q5cFolSpOzjRMLw8+YxUCfjiqr+9beN
	beJ5xDArStzBudsOE84LBiJP2vbEk9hTdhnBzomUl8DqEIZwFyOIpt4rY+mf6OChrx7bcxc
	/yfvtU/oeDErUOo7mSrw1XicHbhdXuCPmoQwe1yHCh6mwY9L+iYaXbKej49q6F7g16ViXX7
	QFrrsSXuMb5KRgrtwUAge8a427b7gi57Pc2+I9PVVd6MPN/XKJm4423oRIVw7kV0JKpEy1Q
	e3gstbrZQMZ8q9wGrvDnZOZYFXxFbZp/CJkNd3XKq6y9x6GdtLStdRLTouij0/i/oACObHQ
	WODL7UVDip5atnIXGkvt+/n3v08UGYvhaUDAphGdpTz+Qbe8BSJAaTtOSnENTNdJFdJSsQT
	6oSfiQDSDCkpEpQZbxJlSBAIfZifObr+IQt0l/5Y53cd/rWr/pLUD2lNxEG0ewaBpipcpbL
	JaAME5ip0LvK+pnKzJlkyziBWoGaiRbyDQB01fknoSb3yS3SKnDtGLB3pzee6oWayMuyQCw
	9MbxELxNPIqvSsyg0/AMZSAdcDdbbcBjM6MzWFHJ7AAg6tjtkhYELDYuWkowofuMatcXq/T
	A0AlfzzyOF1/hWiAqfrjuijumIuH59fH6h4+1+PYrpTaPklaKFGMW4B72qNjzuyOjSmEcom
	S3AMSwJpdyal1mhZTtmZcqUMjkFESoCn7Z4F1yRo4fu98Y2TqEbO2S63RE62mgICZzMbnLa
	a06Cvu92GlSAbvIqcgt6pQEXkWJc8OOCzUrZylRNec3Y0v/n2GTIObqM6gkUZo1VQ==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
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
	TAGGED_FROM(0.00)[bounces-9756-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[spacemit.com:email,linux.spacemit.com:dkim,linux.spacemit.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,d4000000:email,d4015000:email]
X-Rspamd-Queue-Id: 79D763663AB
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


