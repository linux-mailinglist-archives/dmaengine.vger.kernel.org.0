Return-Path: <dmaengine+bounces-9752-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHd6DgSHy2kuIwYAu9opvQ
	(envelope-from <dmaengine+bounces-9752-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 10:34:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D69E9366351
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 10:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94A31307B217
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 08:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D333E0227;
	Tue, 31 Mar 2026 08:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="B4kw9Yjo"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4703DDDBF;
	Tue, 31 Mar 2026 08:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774945697; cv=none; b=VDuo9R9EpThdZ5njG6GomaNmEVqGGUnODblwePgUt7RKU0Ypth0zwe7qfOm7u28tVmvwQDnEixuHQMDH9iNm0rbaVaWrAf0+bNDsyRgRC++oEyTC7Qo8Wui/BCyd5uadh+DcYLNZLGdT4LGmCyqv40JjuC1vTMOZPbohxqTlLEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774945697; c=relaxed/simple;
	bh=bvhFJ28R6sbzlzhNjl+T7MOTQjiaKVSFR/6+3k4Bv98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GMc1kXyyFNuvuCDFVqAPNneViW7qD7u8lRGOhPPhw/75s7ajOn04Cm/a0q+MPZtFiYkwSRzAOx8pARBAHLuFQGNjeWbATIc2x9IS47A3Eip4vuPjAGBYJhb6yn+HjfvM2PasSbb5ZkUiq8pi+34zAqMaTzKYES4+kLjvSraWjS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=B4kw9Yjo; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1774945640;
	bh=UiHAnf4OYg3/oYdCjt52uagpeeIukVRJ+frHypKWT0E=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=B4kw9YjohiJrvW/MJCkEMikWBNEsp2LLg4FSoxqC7hdpAQS3XXgqYZtdLVNGxPoC+
	 cJZzp3uuY+9lKC0gsg59wBqMxIT3iBRk2sjNWKOVIA8+AocXT/loRzuhk1a+IrsNLS
	 AO2BdZ6qnRizT71ZbjFnPtROLU5EkQpbudDDPdwU=
X-QQ-mid: zesmtpsz5t1774945639t91087181
X-QQ-Originating-IP: QpOMtURX8OiWRWpBxqHNjoi1gsXtukgueL/swAiALnY=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 31 Mar 2026 16:27:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9614585065529904914
EX-QQ-RecipientCnt: 20
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Tue, 31 Mar 2026 16:27:04 +0800
Subject: [PATCH v3 1/5] dt-bindings: dmaengine: Add SpacemiT K3 DMA
 compatible string
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-k3-pdma-v3-1-a4e60dd8b4b3@linux.spacemit.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774945629; l=1475;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=wAz+iuTkp6Y7j7BJVKR8rJfy/kUKqSuh/ixh/RA9oK0=;
 b=pA9zOgLfuTMbcQXvvqaArR1Z9RpRmlxSlti/ejKkLRYJ9G4D2+O6UihfwJv5shUxDpQFFitPf
 Ipf2nWr+vUxANqU8sDftLZ04xNmLKGodX48wXRGIEYdNSHoLLmxEDvQ
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NWEwCzsFJJ7KsgGNGHIC37RXS6hMakRO1ixiwp9Fu/tBKr7L45fBzpi9
	WV2cuDgzfe3z/CftaOPan78JlvSULU97vo9K4pZ60YXa4hMS1uS0iS0vMX6aPVHTQq6azRT
	3YDcqAqmwFcMj5KetUWfF6jroZi9MdGn5Ny76Ba0xQFTKtvJYPq4qYnugKXbtQ6rg8261LA
	qcjTLH8umMVaGUFKCQeQH7xhig8WqgREvTbkExwgx1fDPZ9E79e95suJyjIooduiXrtkjwe
	z4Tv8x52U2B1dGIKThuaLakvGi22oVzP+sSumMhHqmr/Quz/f4IwUzUzbHHMMQ6ez79CcNZ
	YZKr2WPOcuI5PqwWP+px3zo1PMFNHvHbUbd/5gCDLMrU0ecrboJ24IDp5jletEGeGxUa4gW
	58gD6+99zw5Tzvvr7FpwFKm+b/HD3fQ0+CSOY9j6ngUZ8n5DBB/iCB6s/2++UwRGg3Wvdt1
	zhQoCmSry48unx2szxKFN7LiU+KDabQPRsy4XMXI/rpUez7hP4L4F+IbSJhykeSkcgCKffk
	N6zJd4/+ul+kQiEyHkhhC+QSWpMnqBu/R9LYSBS3Jnk/NIQlOi9D6e43JIG2DGLZ0VXhgiO
	jUobcUYnOTHLuQZTdj1EMNlusjPMQWTfTZGwqQmm3YKcYIyDDJ4h2AF6WDrw7xBd1AryDxv
	Hp6wVumEnmkNLQA12gTjYVsUmO/D4Yz3V3WFYunAq69+ucyB9UUTdhc9JMGeCoGeGRjMM7i
	QIw7RAMpLKX5pc3B5Mb4tw0nK5g5JEkQrKLXSbJyrwJT1IH9Yx/Rs9HWDlPT5TK0k6ucaRr
	WNVYHsQOQSwX14uY/G8OUsn6P+Peswkyf2Zt8Cb6YSPETXe7RJ5F/UsJ4ebhwMxh/j0PYqp
	L3NLIT4PcuNwS1l80DtdUNhaJw7t36q/rf04i/bcNZ+J0eupjqMUotldan2UcGFKpWDR+2c
	BGrXHPeKk7j/hS9syHryQkWQks2qrfSSNZPvCvnmpYz5oprWVdXN3ZY3p0YKnQH7hm8K5f6
	JApi1V8TKcovbHIZavnaQgb6zA2/3mkS8CRKE1pD83XjrLZH/4qnpHEV2uN2AtwWq0gFYQd
	IOfh9dahJigDWji3B/7UfzEbCe92DxqmweNxm2oLNd8f+TCr+dikIYJanUJrLkjBRX0lIA4
	/4qJ
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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
	TAGGED_FROM(0.00)[bounces-9752-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.spacemit.com:dkim,linux.spacemit.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,spacemit.com:email,riscstar.com:email]
X-Rspamd-Queue-Id: D69E9366351
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Guodong Xu <guodong@riscstar.com>

Add the "spacemit,k3-pdma" compatible string for the SpacemiT K3 SoC.

While the K3 PDMA IP reuses most of the design found on the earlier K1 SoC,
a new compatible string is required due to the following hardware differences:

- Variable extended DRCMR base: The DRCMR (DMA Request/Command Register) base
  address for extended DMA request numbers (>= 64) differs from the K1
  implementation, requiring different driver ops.
- Memory addressing capabilities: Unlike the K1 SoC, which had memory addressing
  limitations (e.g., restricted to the 0-4GB space) and required a dedicated
  dma-bus with dma-ranges to restrict memory allocations, the K3 DMA masters
  possess full memory addressing capabilities.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
 Documentation/devicetree/bindings/dma/spacemit,k1-pdma.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/spacemit,k1-pdma.yaml b/Documentation/devicetree/bindings/dma/spacemit,k1-pdma.yaml
index ec06235baf5c..62ce6d81526b 100644
--- a/Documentation/devicetree/bindings/dma/spacemit,k1-pdma.yaml
+++ b/Documentation/devicetree/bindings/dma/spacemit,k1-pdma.yaml
@@ -14,7 +14,9 @@ allOf:
 
 properties:
   compatible:
-    const: spacemit,k1-pdma
+    enum:
+      - spacemit,k1-pdma
+      - spacemit,k3-pdma
 
   reg:
     maxItems: 1

-- 
2.53.0


