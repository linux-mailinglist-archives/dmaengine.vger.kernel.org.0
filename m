Return-Path: <dmaengine+bounces-9061-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOx8BbjSnmnwXQQAu9opvQ
	(envelope-from <dmaengine+bounces-9061-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 11:45:12 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A76C3195F60
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 11:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FC9930E2BA1
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 10:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB713939A6;
	Wed, 25 Feb 2026 10:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBbhkAfh"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9A433CE85
	for <dmaengine@vger.kernel.org>; Wed, 25 Feb 2026 10:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772016070; cv=none; b=KZkp7B/MF+dDlxHiEeja/vyRNAzPxQWsg8XEqyPQIMkp7xpP1qEKRS1P+9S02EDU81C8N5t0bIpPp2sSs0v564EUSaa096UOHI8vPxb6NjDL3+pQPTJBN0IteDPHiTYcTO1VLvP6Tz+inxbhj5188aUHa1Jv71Jz93uH7nY34nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772016070; c=relaxed/simple;
	bh=VzspfPtZQgOFnicfHJ8lFg9YZeEZbSTZRsbPCXjCtnI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kRUj/LICnEOnEE0V2AjggDG2A2Ogwldfv9k0Q04QZVDT7sIWDK2aPTeb+FUDPgVN68jSQn7ajRCDKokHtr/V5pHpStAfDV/Cv67GpwHuRZuhxtx2Kj8nKejPuf/QZUOyUKaD2VPTUP4zRgmJ0aHoCGNuqO1LwiwZZaRxjTFlrJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBbhkAfh; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-824b05d2786so5058850b3a.2
        for <dmaengine@vger.kernel.org>; Wed, 25 Feb 2026 02:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772016068; x=1772620868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XR42qk8rq04S2Z+KSvYDZFvfESR4/OwfS07dI/NcZUY=;
        b=FBbhkAfhbAj4m8qA/NSICBgrVHyVnPpshNFJ2mMUhJh2nyo2DKqt3V2lUg4Oata6KB
         syD/xw0huEDfaCc5sqw9I3Fqai4t8H+FIyRbM0jIPs8W21b30THIxfMYhB3TiziwoL+L
         vA1qCUom4EzPyDOVTp9wVQiu7SX8O/MCLuFyDjYiWfNzL12sk7xygOJAGhFjG3BJXa6/
         jZhS8w1VxVb0Opg7t+nUrPftDn4lgdH+BFZ7q8lFf0Nn1SZPCryPGxNBgKLRJVHify/h
         KxssDmWCFAL3aAh0Ni2T8fe9ch4hsWe2F1/+LR0zQVZo1+cg/er8DSWfUyOVDi3U2OgJ
         OhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772016068; x=1772620868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XR42qk8rq04S2Z+KSvYDZFvfESR4/OwfS07dI/NcZUY=;
        b=iq+VyGrarBbZuJbIKuyJX9v2e+fd3xgu5eO2ZOVJoySMnbET14ArkQ/pkxkqXE2KGW
         u+1LCn4mVcFGK/zrQ32gtQxnmotlaEyK4d2VWvwYDS/6tdWFamUXwCmotx3k5TIJeOeM
         ZSeeoYs7qt2adDyI0xGwlRvF6g+WoKviATInPgaBwM0XX0kxx54S+arAb27qGTh75Unc
         tIig0CiK6EVC5At2PbYTguUynLwJLWvFoi5DyGlMqGnj9mnN13ilxRYKn+5jGEYFGpNF
         iPkVzWjL8w2NLtmddnrkjVSFxzafXp6Wl+JFVKfjSg7l4Drxy/MKpk1IFM0RnwI7A/oJ
         iQnA==
X-Gm-Message-State: AOJu0Ywzl6k5mfWce+drWfEWJEBsskgF4X0MNE1MR5CTaSH9b9slWmg4
	dVVvmD9hAodStqGHchX5x4vdHrdNQ+aFKeqRbXPwpvFSWhTbKmCskRIG
X-Gm-Gg: ATEYQzx+4b6GCi3A3H1yLeEl4Gq0bLIXo79xnE6yyggqOCUqgOvhzfu0p0chmRgPO07
	3tVC5QiQ0wDpGqDs95lmv9VHy3bli5CtDBluCwXbfb5elfjBC9LZbk+vbGy2iQlrwZrDqI1ohAd
	D+cx+0iQF9bdg60t+GFhYIPFRl1ezIEDrJHhHGNun6cUY7OFzdq0pAUGTJNhBGddNelMhLiuncS
	P0iQUWEN2q3K+zs609YJZZYstzT4Hfnkmv6yVvDudvMFMvS6+w8EdZrDfF5AmrFQKkT/ll9dLRR
	xV7RjCPHm+Ko2pGoRL+SVyWFDUlnL2PDMNmqUlCbIKorRcMYJyhK+R/pTlU45U47WW1wP3gy/BM
	NUwZeRiBI6itbNGV3UbmzqXMuaoMOJkZcsLcizBhoSzxnY8prwVqXfNLpvc/OmRorDaXpgFrzQU
	T0XOgIH4DZtMMtwOrXs4E+3SslBcxG3vya
X-Received: by 2002:a05:6a00:a85:b0:824:374a:140d with SMTP id d2e1a72fcca58-826da8bd87cmr15266094b3a.4.1772016067626;
        Wed, 25 Feb 2026 02:41:07 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd8a1145sm12950172b3a.45.2026.02.25.02.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 02:41:07 -0800 (PST)
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
	Ze Huang <huangze@whut.edu.cn>,
	"Anton D. Stavinskii" <stavinsky@gmail.com>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>
Subject: [PATCH v4 0/3] riscv: sophgo: allow DMA multiplexer set channel number for DMA controller
Date: Wed, 25 Feb 2026 18:40:38 +0800
Message-ID: <20260225104042.1138901-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9061-lists,dmaengine=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_TO(0.00)[synopsys.com,kernel.org,outlook.com,gmail.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,whut.edu.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A76C3195F60
X-Rspamd-Action: no action

As the DMA controller on Sophgo CV1800 series SoC only has 8 channels,
the SoC provides a dma multiplexer to reuse the DMA channel. However,
the dma multiplexer also controlls the DMA interrupt multiplexer, which
means that the dma multiplexer needs to know the channel number.

Change the DMA phandle args parsing logic so it can use handshake
number as channel number if necessary.

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

Inochi Amaoto (3):
  dt-bindings: dma: snps,dw-axi-dmac: Add CV1800B compatible
  dmaengine: dw-axi-dmac: Add support for CV1800B DMA
  riscv: dts: sophgo: cv180x: Allow the DMA multiplexer to set channel
    number for DMA controller

 .../bindings/dma/snps,dw-axi-dmac.yaml        |  1 +
 arch/riscv/boot/dts/sophgo/cv180x.dtsi        |  2 +-
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 25 ++++++++++++++++---
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
 4 files changed, 24 insertions(+), 5 deletions(-)

--
2.53.0


