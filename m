Return-Path: <dmaengine+bounces-11352-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 89xWCOVuKGr4EQMAu9opvQ
	(envelope-from <dmaengine+bounces-11352-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 09 Jun 2026 21:52:05 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 552E0663E7A
	for <lists+dmaengine@lfdr.de>; Tue, 09 Jun 2026 21:52:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=VxcxRmUY;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11352-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11352-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0802305789B
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2026 19:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87EF3B14B1;
	Tue,  9 Jun 2026 19:47:38 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E2241166B
	for <dmaengine@vger.kernel.org>; Tue,  9 Jun 2026 19:47:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781034458; cv=none; b=Mh4J/p9y58G+AocWAFUMjMtYo3yB67JDpAQNDWG6qff4bzsZKmtu9k5eLrOzOARWJPvhGr5brE6Wl2JUjZlEt6DUYl+0ftNNqgvk+QzOR13a/Yh5AzUVGcvwdoOKH+JrRiUhibk6YezZQ0y/iYWkeBxOyG1152MFRgo4VsF3Kus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781034458; c=relaxed/simple;
	bh=H/kR+2HYwlqkml7voLWdHY49vUjyuP/Tsib1MnxQLD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l0H/qtlXapOy8kHx6k7LicfjD8o1+T77Hg/4KkwvI1netzpbFPgrpNqUC0MSY5j+H5t9A7UCrBcZ79YkGI+QvGeujMk74r6OzyV1eqfsoGOw8YyjR53NzEURH8yNhAZOdyNEc4/kjp1ns7BZEIYL9JT9p6ksz9t126G6SK03KiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxcxRmUY; arc=none smtp.client-ip=209.85.215.175
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c85a2ca7bf7so2217817a12.3
        for <dmaengine@vger.kernel.org>; Tue, 09 Jun 2026 12:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781034452; x=1781639252; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MpR6igjuZL+55NUetVLOlJ7WyoEDc1JskAO0eU1M5r0=;
        b=VxcxRmUYcFUQ0tfMrxn479ooKQ2xqqs6/jfKkhP4eRIL2kNN/BrzarcsUJHXI9Vpdm
         I8Q6UnZu/RVa2vUHlHOhktKp3ueTInwbUWI6VHUBKe9ceOrkBqTjE8dggz9wZjvfxByG
         rrKCwWg5VTeOW9LbMs2N7Q49bdIhfUoKUBbk1fdyCth57IogSzObn4Nn1tMtkZmVgO1O
         QcazRUQo8DETHtWA/NGGo6KcPcfVqImZJT1p8Tbgi49oKnWNbCLlw5V8ut8EfaYxvYEI
         Q2Qj2DUTGJs5zvU6Z1It0XKmTYeCkziVgPAgT5YF8dmk1DYF3yNQvcD09Kr2WgugdcvA
         aikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781034452; x=1781639252;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MpR6igjuZL+55NUetVLOlJ7WyoEDc1JskAO0eU1M5r0=;
        b=Bq0sG9psH1+4wcMqiY6Cvq7KdsTwJcmwsyRJ3PEwgoBOFTWtHm2PVunHXlDJH1Sgio
         JcygFgm/nIv1I1aRuMU92iAOiLQyv2KhXYsktEdp721pKFva3pu8bheiJA7odADLDRzj
         PpZ6bSDoXNQQLwryMDBVfgsrz18Djg8han3DxxQSxySebUIUrs8/TwbQM+qEuZEy7VyA
         ++X9NPIJs7FH4rYgIDvpqdEexKcfiRVvQ6svnlOvlhkhdBBPkKdIHW04l7jqX7leLm1U
         JB5IuqP7rahnVrvIzZrQK2/IlamL2cHPlyAXiQKwqQWS4FGaY2aodVViW3GA16uAmKMt
         /qkg==
X-Forwarded-Encrypted: i=1; AFNElJ+SBUioxFnDeFFUidHVPqbxCiK9JjC/iwccyMBO/dkeF3rd0XZelKyUu69JjtGUaK9Na6CRLbqR6MU=@vger.kernel.org
X-Gm-Message-State: AOJu0YytCxXHD8trY/Uiy9tz8OQva2wksMOnKpRAVF+rXqoAwiWcvZgo
	nyexrT5r1STrwtHq8vOfZ2GvGIIt663+zjE9yF7ld8XTW0fWomSTRz9k
X-Gm-Gg: Acq92OHlGTqOJofD+vaZMbxLbl9jipbmYCW8KNHV0XQWQ/ORSP5TdYtjEHzFDpZgKHs
	dw5j1rxsLU5QyG0NIeuchd85a+BF5xwXGy9aPSfu4cXi5S0oZszAKNBbSqgHJMNguyznIydgxhM
	wEAsFK8L2/N33pdgUI6yI9IuYm/uM8cHkbuBEba9i8qHzlmynkQTgbHMlppXApT97Re8+b6603l
	uEwv5GSD+x1Obb3ydVAHxZ/8LUVedrsEq6c/IX55Aj0wRri9GSfA6nMPdLIlOJ8KBf0yj1gxLHC
	CYgV5r8H37dCdOZoIgc8PNNAeK+x7Qmu25PUqm3KVt8z3VQS+pLuWBVeC8UODj9JAd/rEK9eRto
	uu4cEgnhRAxFOS+uMMY467hVAFzsaAJ3wlSCXt469CK3tH1+sp6FnSs1Pf2NwJKRp/Y+SR0jiKl
	93eh79nQk+
X-Received: by 2002:a05:6300:2213:b0:3b4:6026:6c78 with SMTP id adf61e73a8af0-3b4ccd45617mr26253003637.11.1781034452412;
        Tue, 09 Jun 2026 12:47:32 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::3060])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04ff24sm19517121a12.14.2026.06.09.12.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 12:47:32 -0700 (PDT)
From: Guodong Xu <docular.xu@gmail.com>
Date: Tue, 09 Jun 2026 15:46:39 -0400
Subject: [PATCH v2 2/2] riscv: dts: spacemit: Use symbolic PDMA request
 numbers on K1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-b4-k1-pdma-req-macros-v2-2-5d5d7b997b54@gmail.com>
References: <20260609-b4-k1-pdma-req-macros-v2-0-5d5d7b997b54@gmail.com>
In-Reply-To: <20260609-b4-k1-pdma-req-macros-v2-0-5d5d7b997b54@gmail.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Guodong Xu <docular.xu@gmail.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1153; i=docular.xu@gmail.com;
 h=from:subject:message-id; bh=H/kR+2HYwlqkml7voLWdHY49vUjyuP/Tsib1MnxQLD4=;
 b=owGbwMvMwCXWtEl1Z3CGpCDjabUkhiyN3GM9QkaZAY4pz7LmFC1dU6c9iz/tlMZKQ7fXVvMvK
 4nY+yd0lLIwiHExyIopshw+2pK99ZVPtO9zzh8wc1iZQIYwcHEKwER+HmdkOHPhNCfP+fsPPTcn
 1nqfuZncluzK03QtbIry7o75tWsLqxgZztYqCf0tjHyftnB9yeSb33LSxM8wrTAwv3V5m/txgWc
 5/AA=
X-Developer-Key: i=docular.xu@gmail.com; a=openpgp;
 fpr=90B1DC3DF0BD10FD1227BD6344F254AF42F143EE
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11352-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 552E0663E7A

The K1 SPI3 node's "dmas" property hard-codes its PDMA request numbers.
Include <dt-bindings/dma/spacemit,k1-pdma.h> and use the K1_PDMA_SPI3_RX/TX
macros instead, for better code readability and easy for future
maintenance.

No functional change.

Signed-off-by: Guodong Xu <docular.xu@gmail.com>
---
V2: No change.
---
 arch/riscv/boot/dts/spacemit/k1.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index 08a0f28d011fe..c413a64d5560c 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/clock/spacemit,k1-syscon.h>
+#include <dt-bindings/dma/spacemit,k1-pdma.h>
 #include <dt-bindings/phy/phy.h>
 
 /dts-v1/;
@@ -1094,7 +1095,7 @@ spi3: spi@d401c000 {
 				clock-names = "core", "bus";
 				resets = <&syscon_apbc RESET_SSP3>;
 				interrupts = <55>;
-				dmas = <&pdma 20>, <&pdma 19>;
+				dmas = <&pdma K1_PDMA_SPI3_RX>, <&pdma K1_PDMA_SPI3_TX>;
 				dma-names = "rx", "tx";
 				status = "disabled";
 			};

-- 
2.43.0


