Return-Path: <dmaengine+bounces-10287-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKV1Nz16AWqMagEAu9opvQ
	(envelope-from <dmaengine+bounces-10287-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 08:42:05 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF7C508A6C
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 08:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5B2D304179A
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 06:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B00535E94E;
	Mon, 11 May 2026 06:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXwqWP0J"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95432324B06
	for <dmaengine@vger.kernel.org>; Mon, 11 May 2026 06:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778481530; cv=none; b=pnq28vUDZCaqsm2U9s9I5+nIMA5d4fTy+3bbeOi7ZQM93+dQihEcCRzjsczmlvsXAtyGi8cK7RVxB284+7lFcQkJKxa+p2+qj5TMK7Y4bYgpRoeX4rV+Tdzowgt/+Lmkhl8vrMZs5TQjYtzHNFVKPaJS8w9UXqqPfLPIYODNxDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778481530; c=relaxed/simple;
	bh=yXB7EIPk6XevVObOY5j0Sj39ejci5f5ONxRs5/PDOYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=taldVQ9unLaUboO57ytDCL3ktl9vgM8/stLvQDXXIkBG3tP/zbyE/uFJBf4OJdQt8LvIqWBagJFaDx8H92QywCJWceiIR8fDMcMHpHM7+8NBGhiJ87imbs71XCGJoqdqus897ZrFHypaRatLmJysfc6YxePKoS+rwC3cGsbLtyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXwqWP0J; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82fbf5d4dc2so2768882b3a.1
        for <dmaengine@vger.kernel.org>; Sun, 10 May 2026 23:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778481528; x=1779086328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfmcfX7gTqR/wtswsezRGGU6Mv16ceub/2XE21DxlUE=;
        b=WXwqWP0J+3Eei9CgSnmCdWgFVjg0n9/742RyA5RBp/NIFtLEmFQ6k0J9Gv9tOy5RFc
         mTtegPGK4ovkw1VcHO7S47rDgM+tNil0xXbB6DPwT4XcYvJFfnMHGs0tCdN8Esw0DMG4
         6rRkEsGlNJHNpFuKsaQzRur5QtfOIJkZaJkQHL7wuBLK3lrYxlHGb+RBcIBb3+5PQpo1
         5ju/THPTAldn8ZkotU2Rg2I2rt9ePhgsDcOaKOS2o3me/GBWS+2M5T09Bn0ydxXJGPZa
         9WnQJOtMg59CUECSw8ehPygHRn6G8PooM0BKUCoBAXYANC0QxEqthn0eGCk0q82nmUgR
         jzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778481528; x=1779086328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WfmcfX7gTqR/wtswsezRGGU6Mv16ceub/2XE21DxlUE=;
        b=QhwFQWegTSoxJPT1pLEIfIuJl54QPwfXyRR7iHZabLMvzUnUbW5X8GFEEl6uLsihF+
         mg+LNcpGVoMI1lApewAffHEC9EauMaet9m9bEt8tD8Tb4RF0Nm0/Lh2+NRp7o4lv6X3U
         9jRZ1OwmnDWDWVRq/qmfUhhqLO45razUCRW/VOKfEnW6oqQeDivC/TfQgzKKHuDY/d3E
         fMtWv2Izq18IDcKcgVqi3dn2XhSTESIlqddXCLxr+XEu4i8HJDY4L7owXSZw2Iam42LE
         epHFdCt0F/VStvWeRTZA6epxHVx8QE5+lRnOOt6nOpVHlxic45Kfnr3uTAG1reStA6Ih
         7w1A==
X-Gm-Message-State: AOJu0YzSof89KJoMxyoyYD6JJO/PgMC2jBrZnoRMIQTtg2l9GHFNlc2W
	QABNJROCpCqFLQEe38yTOzMLBbY4in4m4G6WsUvXQ/H+HUzileUPkJS8
X-Gm-Gg: Acq92OFnnbwGVdyHhef0s43zU46EwtsXbKJ5FcDLqptTeHliOHA/79imsFhJTkMQ6C+
	zuEmw6vcOgi+aF5OAkLODy1qZaQK2peZTE3XlXqHad70HFBpWQ08LcFsxx7OIXhv/iNqgUmTZbj
	RKwu/8dOPGoOlh5gJEQB09bp4ZR/prCzgSrktdxAoWyIEOxXH5tIgw4yYhaBu4YM5P1gxolkYHL
	gpvZtNvD+53/7oHLixmgH1pMjEQof85w6wWTYqM/3dKj8UtUD6bcI9BLXnZN22O6f83VOUHQiq4
	hpLa9Wkz4JUpeh3Y5ruG9p68dHTHRd2lcMYMVfEL3m9WmfsiXE0Fp6thhduj8c3aKut0EmbEObR
	bTcK19eI9pBRbFjDN4zIz8QC2HnPtXBvzByh3iRX9cqGzQqUDqv186vxBtuO6YHWRhy2+TxOwXF
	1T9/cIOvsIw9kilJe6B5M69bc=
X-Received: by 2002:aa7:9a51:0:b0:83d:446c:498f with SMTP id d2e1a72fcca58-83d446c4c89mr8198132b3a.32.1778481527848;
        Sun, 10 May 2026 23:38:47 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8396563f381sm23328475b3a.6.2026.05.10.23.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 23:38:47 -0700 (PDT)
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
Subject: [PATCH v6 2/2] riscv: dts: sophgo: cv180x: Allow the DMA multiplexer to set channel number for DMA controller
Date: Mon, 11 May 2026 14:38:17 +0800
Message-ID: <20260511063818.463877-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511063818.463877-1-inochiama@gmail.com>
References: <20260511063818.463877-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3DF7C508A6C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10287-lists,dmaengine=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.962];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.66.18.16:email,0.65.235.0:email]
X-Rspamd-Action: no action

Change the DMA controller compatible to the sophgo,cv1800b-axi-dma,
which supports setting DMA channel number in DMA phandle args.

This dts change does not break backward compatibility as a fallback
compatiable string is added.

Fixes: 514951a81a5e ("riscv: dts: sophgo: cv18xx: add DMA controller")
Reported-by: Anton D. Stavinskii <stavinsky@gmail.com>
Closes: https://github.com/sophgo/linux/issues/9
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Tested-by: Anton D. Stavinskii <stavinsky@gmail.com>
---
 arch/riscv/boot/dts/sophgo/cv180x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/sophgo/cv180x.dtsi b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
index 06b0ce5a2db7..ecafdee79ac8 100644
--- a/arch/riscv/boot/dts/sophgo/cv180x.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
@@ -417,7 +417,7 @@ sdhci1: mmc@4320000 {
 		};
 
 		dmac: dma-controller@4330000 {
-			compatible = "snps,axi-dma-1.01a";
+			compatible = "sophgo,cv1800b-axi-dma", "snps,axi-dma-1.01a";
 			reg = <0x04330000 0x1000>;
 			interrupts = <SOC_PERIPHERAL_IRQ(13) IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk CLK_SDMA_AXI>, <&clk CLK_SDMA_AXI>;
-- 
2.54.0


