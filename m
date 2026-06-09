Return-Path: <dmaengine+bounces-11350-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k7NMEf5uKGoGEgMAu9opvQ
	(envelope-from <dmaengine+bounces-11350-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 09 Jun 2026 21:52:30 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B245F663E87
	for <lists+dmaengine@lfdr.de>; Tue, 09 Jun 2026 21:52:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=beXv5qU4;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11350-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11350-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3621A302FA11
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2026 19:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31FB41166F;
	Tue,  9 Jun 2026 19:47:29 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADC0411661
	for <dmaengine@vger.kernel.org>; Tue,  9 Jun 2026 19:47:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781034449; cv=none; b=IvnooT06ecW60exgCxPuYFyZ11W0kZuNV4h7ynC3EadJXK4srWKxNj6T5kMjK5myaWlzpYAk9H75gwbQHZvto2HvbHDob9EJn0WOAk+NBR9qsXlo3M61p+xNrEQzEIXPfbU5Ftk8ad9kf7Itj26bYivKZ+nVBabZlU770AFkkUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781034449; c=relaxed/simple;
	bh=+Pdfi70LkinVFTovJkzCSbIOzEBbKyNKWMr5FgCeZf0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=B5PCYpRj4eCBzede8QH23CXyyYMMKioAiJJezxqvQwS2zR0k1plNRN7vMKWy22ZVDxxc6rF7FCzSapekBx8iB/xl+3xr9nIfaTsj2YV7XsgHwiR4NqgE15GbNwPEtbH2ha9kGTzrQqg/fRrwaxVJXxBN/9I0jEazwhzXeUNhYB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=beXv5qU4; arc=none smtp.client-ip=209.85.215.180
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c8588f8fef3so2256692a12.0
        for <dmaengine@vger.kernel.org>; Tue, 09 Jun 2026 12:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781034443; x=1781639243; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=epRH3P+p1WTs0Qf73mC3lJ/lEpqA5BdU7cFqo7ivRaM=;
        b=beXv5qU4LCe6B6rTdzOSgY1VfjzFSawZ7cGiLDnnxqI90T9Ctq1dxLA7BE7bhG9lBO
         arviP8iLneTa6aGeaZ6rWZpP81kpiVLTE5vKUnNfA4CeppSn3/0zZYVGooS9hyNGwpnt
         UZtClFZKPo1vQexn2W3rLB4TGLfkatlup79hnEyug7ZGQa+nOWPNYhpTKEoK0O7FORor
         sNpPD3FMb9Zw9uLUXJl59c0315T58Ezh9gX0O2JIAuTqq/CUYkI/gLgonu6uqwjFtzFD
         7cF7H8NJm1tvQGYXF4gpEou2REpnQddmWzmaCqem/k0t5YZ3wS+1ysOaWyb4IHzgnVH+
         53VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781034443; x=1781639243;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epRH3P+p1WTs0Qf73mC3lJ/lEpqA5BdU7cFqo7ivRaM=;
        b=fySWyLaeaVkcLy33PCttaI1wUx8P+/bykl23kOYze+x4YOzhgNxMQLDPZRT/pOuvMW
         uEdIy7TUo/5+A2BfRLCGcKA6gz2cxUXtzttOCNSxpgqZZfKr4GofutFXdxAFYUlokGT/
         ZmA+eVyMc4RAfHqu7PXDMIJVHzV9sAyx1Er+nJGPKqXdgdzjFS3IAJ1NfVQz/I9+f8pu
         tkcVRFyU259bhYPrIm+ti2vmwal/wq3fVlQh5NaE6Itc65M9NQwK3QGadcfLB9Q6FAJY
         5XLZrdb5mAl93SjzTGvxyV0QYR5S/tnVUsY3+rHRc5aoymUHL91mllvLVVUHN/ODceST
         O9mA==
X-Forwarded-Encrypted: i=1; AFNElJ9V93YfcmR7aYqzUaAEm57dgPERAuzdNK282blihnrzJ1/zAXDxSf3J2NAuMNS20lBkst1LhzGBmvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfaX+AtKBUNjq1U0v7TQZnXLtHRJjDIPNDK+UpdjwHJ2WulaHS
	DVYtohQMD5eRquX+6m+MhoAIECW/B/fzfC3gwaPtWm+MX7a3M3qTKDgaTMEZYNnbyZc=
X-Gm-Gg: Acq92OGjQDNq6dVqcIWWtnQHil2UTRhWkKeVAlnLO88dLqCR15AluZNKcVbi9KHphqd
	GQmvDrrWeWqEY0LkxY+1XN1PqCD8J+HvKGTFaRSTu3tBcvZyXcGozFrfR4Qq+HXlln3VswOggYA
	LXGEpM4z/4ch58lKyqd4iG+hZ520qtvP1pmCMBFSZjGKJRKll14UR/jbbZr81YUsAXt1GxQaR8B
	aLUdjXbPTRnu+Ul6AfbQ2RWLwjhHSf1NWRzTOWvMkIh0+uwxZstRgY69Q4QGxg9pv1s7zc2hlCV
	A/sY2NqVgz9rhdbdP2goZivrljbaUYInRDjPSjAF9H4T+YcQW2uj+zUNgvjRGlq65danjz3rRyo
	wSv22hL2tV8HsxbY/5+ToELtDW1arhzozyV+UMl0V1MSjzqQ1let6YB6OFcUIPykL47zFAFCT8o
	g5Od1EHx7U
X-Received: by 2002:a05:6a21:3949:b0:3b4:6026:6c5d with SMTP id adf61e73a8af0-3b4cccfde39mr26226941637.5.1781034442949;
        Tue, 09 Jun 2026 12:47:22 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::3060])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04ff24sm19517121a12.14.2026.06.09.12.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 12:47:22 -0700 (PDT)
From: Guodong Xu <docular.xu@gmail.com>
Subject: [PATCH v2 0/2] dt-bindings: Add SpacemiT K1 PDMA request-number
 header and use it in DT
Date: Tue, 09 Jun 2026 15:46:37 -0400
Message-Id: <20260609-b4-k1-pdma-req-macros-v2-0-5d5d7b997b54@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ1tKGoC/4WNQQ6CMBBFr2K6dsy0SlFX3sOwKO0Ao5Zii0RDu
 LuAB3D5kvffH0WiyJTEeTOKSAMnDu0MarsRtjFtTcBuZqFQadSYQ3mAu4TOeQORnuCNjSHB0al
 cO5RKu0rM2y5Sxe+1ey1+nF7ljWy/xBaj4dSH+FmPB7l4/z4GCQhZqcz+lGWIub3U3vBjZ4MXx
 TRNX5UPZW/MAAAA
X-Change-ID: 20260607-b4-k1-pdma-req-macros-8d276d0126df
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Guodong Xu <docular.xu@gmail.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1594; i=docular.xu@gmail.com;
 h=from:subject:message-id; bh=+Pdfi70LkinVFTovJkzCSbIOzEBbKyNKWMr5FgCeZf0=;
 b=owGbwMvMwCXWtEl1Z3CGpCDjabUkhiyN3J0ap2uYnpxhcd+dxnzdfc6yC21LvXott9jc57uh8
 GCWkHhiRykLgxgXg6yYIsvhoy3ZW1/5RPs+5/wBM4eVCWQIAxenAEzk30VGhrkzE6YfOzR7l5tW
 xJPnr3+V1+iWFc9dtzx9/et51/skT4oy/GT8+HZOVUWLybYvGa+5Tme+6Et9eufM0tpDvUn7xM1
 dG7kB
X-Developer-Key: i=docular.xu@gmail.com; a=openpgp;
 fpr=90B1DC3DF0BD10FD1227BD6344F254AF42F143EE
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11350-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:dlan@kernel.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:spacemit@lists.linux.dev,m:docular.xu@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,m:docularxu@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[docularxu@gmail.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[docularxu@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B245F663E87

Currently, K1 device trees specify PDMA peripheral requests as raw numbers.
Add a dt-bindings header naming those request lines and convert the current
user (the K1 SPI3 node) to the new K1_PDMA_* macros.

Patch 1 adds include/dt-bindings/dma/spacemit,k1-pdma.h with the
  K1_PDMA_* request-number macros.
Patch 2 updates the current pdma user (currently spi3) in k1.dtsi to
  use these request number macros.

This patchset is based on dt-for-next of spacemit linux tree. The
request number defined in Patch 1 comes from SpacemiT K1 User Manual
[1], Chapter 9.4.3 DMA Connectivity & Assignments.

[1]: https://www.spacemit.com/community/document/info?lang=en&nodepath=hardware/key_stone/k1/k1_docs/k1_usermanual/9.Top_System.md

Changes in v2:
- Drop the #dma-cells description change in spacemit,k1-pdma.yaml; the request
  numbers are hardware-fixed and unused by the driver (Conor)
- Link to v1: https://patch.msgid.link/20260607-b4-k1-pdma-req-macros-v1-0-5b2a3955007c@gmail.com

BR,
Guodong Xu

Signed-off-by: Guodong Xu <docular.xu@gmail.com>
---
Guodong Xu (2):
      dt-bindings: dmaengine: Add SpacemiT K1 PDMA request numbers
      riscv: dts: spacemit: Use symbolic PDMA request numbers on K1

 arch/riscv/boot/dts/spacemit/k1.dtsi       |  3 +-
 include/dt-bindings/dma/spacemit,k1-pdma.h | 56 ++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 1 deletion(-)
---
base-commit: 793cc54475b49b5b558902b5c13e4bfe66530a50
change-id: 20260607-b4-k1-pdma-req-macros-8d276d0126df

Best regards,
--  
Guodong Xu <docular.xu@gmail.com>


