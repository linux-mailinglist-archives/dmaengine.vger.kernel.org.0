Return-Path: <dmaengine+bounces-10285-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGcXIXp5AWpGaQEAu9opvQ
	(envelope-from <dmaengine+bounces-10285-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 08:38:50 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 849235089CB
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 08:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2D6713001598
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 06:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF8E313551;
	Mon, 11 May 2026 06:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQvh9Mr1"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF562D7380
	for <dmaengine@vger.kernel.org>; Mon, 11 May 2026 06:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778481525; cv=none; b=UQufQbyaPhZRd40LsGgtghyZjAetpC7vRg8WVhejPRKjnVY/svb/BsuTUhetOU1uRiaDZS/f/vkk6viiT2Ccldq9sTpch+mXdfc4PQxkr+AADOkIJDEDu+6EINsnxVMmBHDpjxNrQkR/p+KkTgEpshI+dqMw9XLoRqeOH9iQEhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778481525; c=relaxed/simple;
	bh=yvzklUqCUgxletwdYULmVQM5JhvPwFFqwslMNk2qNBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y9HaCmzq2D/aMNwHl7KrEMcEBTi15SKGbYOOMOrl6khqgWbNSJZe6h6u30gy37GZm6rpv/s4zXbETSCV0zHGTGDdBkAbV+2M36zKHWE4kWoINZ6kv/dWCF59laUSSf38AvaJxuTcAyqNciTq7glCnAibM5EHf+WjgrbmQtLhSM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQvh9Mr1; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c7ffe8eeaf2so1535046a12.0
        for <dmaengine@vger.kernel.org>; Sun, 10 May 2026 23:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778481523; x=1779086323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VrHfqxO5zQWaRSbwjGtMUupsuspxAHrjR7FaYDhyfhQ=;
        b=DQvh9Mr11ioBD7Qh5Zv/GsK30h3KOBPLIjDm6eDBoFfBJHd8RoxHB0qF7JOX/aGl9n
         t+clAais7K91HagNelKRmt0Qmhn5U7YT8wJ4rpLAKzTZ+np4npTmyDjAgx2+lm4vSTRg
         YQen+ekmDeutAcXVzfGMMevESBIclHx4hKeHuzBWSa0rBEy65FmQ0d/XdiFXGyU33+w+
         mE3TEvw6+1DacUX5gq4Q0un4YAwXGTJMHh73E7OqZh1Po45MQXkf7GrhUMrO/FRPx11p
         R8j14n7yXvN2iBhNBI8+4/X7z85MdH4iS6ke9XXvYtrWT3c9qRQak+WHf2rDEu86qXKO
         4vlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778481523; x=1779086323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrHfqxO5zQWaRSbwjGtMUupsuspxAHrjR7FaYDhyfhQ=;
        b=a27sipBG4wnD9JYblX1K66J5aTXdmORsMrtYvKk2gKPns67Z21Lgh+XNw9Sk8ZKKrD
         RCLPcUxZGepPVSy2+wrMBey2CISDVD8ftqTXejy+nOXDEgV2FeZYvzUZBwX9gaOZSeQP
         k7zwOppE7gMJUHT03GUxdOM00+GhtHBT1e5ganQq+W/0gLPvTLcqiCMnKo2vXQm0CQzX
         2SOUeTfMG6F7AUJroM7OFpcshz/WDIfEChqJGA61y52iPhDSjeMMjfBBc37hQChMtZz5
         86cZaC+YohZndg+MELM3pMOMdFVDIOFJVizurbT9vWWPQnB7jugvjZenApWyO/2eH46w
         6IQg==
X-Gm-Message-State: AOJu0YzhUPvqeYkznIHPQaIfNsf1GKdYVXxQpa5gwl3IdZyEU8QrOhun
	8vkSKSRDHC/xZe3SWFjOJDq9lTx42wnInhIkkXfdrBgnbqgAQFGbwfBl
X-Gm-Gg: Acq92OEe17zJsuyTzYSpr7SSY4AL81wT9d2A1JGYjJYocpCRt6l6PDCoInqLnrjcjQe
	hVOr9nJq2FAJuZ4mdfMN60wjSJSDrTsHSw5UM2UQ0rgN8wJ6xz9U3rfH4E9KgfOzXnbwwTWe+hs
	e6eoHGHfbvMwewE872hKfQdsHAEV5GqeS2IOaLCoMy7lwV0JeHxIhNfOC9/au95rQ/QoetJiLb0
	b4hSR30Zdpv67M3LJZ8+MOkGQDeoWnV01cOePMcexT/hhKGJLhyhjvb4CxYdZAMXXfhzS42o8KT
	uAnXe/E0s9doCbKj2e3ykvKHmTPUZT3LTfNDhRNd+glQEe58BUpSXyGlh14ZWdPz4COgev+uqGm
	9pAY6iIbzbYShVwJCvXZFeX+Zw8R2U6qQz6dXNOi7f0HKpieqPPc7L6mF4KmZlfViCCPrAT5rqQ
	hSPnLmslzyKrNaz77/EPB1ZWs=
X-Received: by 2002:a05:6a21:9983:b0:3a2:7ef4:81df with SMTP id adf61e73a8af0-3aa5ab71a24mr24213272637.26.1778481523036;
        Sun, 10 May 2026 23:38:43 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c826767be0csm8409174a12.2.2026.05.10.23.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 23:38:42 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Longbin Li <looong.bin@gmail.com>,
	Yixun Lan <dlan@kernel.org>,
	"Anton D. Stavinskii" <stavinsky@gmail.com>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>
Subject: [PATCH v6 0/2] riscv: sophgo: allow DMA multiplexer set channel number for DMA controller
Date: Mon, 11 May 2026 14:38:15 +0800
Message-ID: <20260511063818.463877-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 849235089CB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10285-lists,dmaengine=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_TO(0.00)[synopsys.com,kernel.org,outlook.com,gmail.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-0.988];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

As the DMA controller on Sophgo CV1800 series SoC only has 8 channels,
the SoC provides a dma multiplexer to reuse the DMA channel. However,
the dma multiplexer also controlls the DMA interrupt multiplexer, which
means that the dma multiplexer needs to know the channel number.

Change the DMA phandle args parsing logic so it can use handshake
number as channel number if necessary.

This patch series add fallback compatiable according to the disscussion.

Link: https://lore.kernel.org/all/MA5PR01MB1250079A8884D4F6245B955B9FE51A@MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM

Change from v5:
- https://lore.kernel.org/all/20260426012921.673953-1-inochiama@gmail.com
1. Add dt-bindings patch for fallback compatiable
2. patch 2: Adapt the binding change.

Change from v4:
- https://lore.kernel.org/all/20260225104042.1138901-1-inochiama@gmail.com/
1. drop patch 1 and patch 2 as they are merged
2. Add ABI break statement and clarification for this patch.

Change from v3:
- https://lore.kernel.org/all/20260120013706.436742-1-inochiama@gmail.com/
1. rebase to v7.0-rc1
2. patch 1: Apply Conor's tag
3. patch 2: Apply Frank's tag

Change from v2:
- https://lore.kernel.org/all/20251214224601.598358-1-inochiama@gmail.com/
1. patch 2: rename "AXI_DMA_FLAG_HANDSHAKE_AS_CHAN" to "ARG0_AS_CHAN"

Change from v1:
- https://lore.kernel.org/all/20251212020504.915616-1-inochiama@gmail.com/
1. rebase to v6.19-rc1
2. patch 1: remove a comment placed in wrong place.
3. patch 2: fix typo in comments.
4. patch 2: initialize chan as NULL in dw_axi_dma_of_xlate.

Inochi Amaoto (2):
  dt-bindings: dma: snps,dw-axi-dmac: Add fallback compatible for
    CV1800B
  riscv: dts: sophgo: cv180x: Allow the DMA multiplexer to set channel
    number for DMA controller

 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml | 5 +++--
 arch/riscv/boot/dts/sophgo/cv180x.dtsi                      | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

--
2.54.0


