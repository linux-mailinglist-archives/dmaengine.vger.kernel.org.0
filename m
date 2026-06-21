Return-Path: <dmaengine+bounces-11686-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eEBWOOhaOGqqbQcAu9opvQ
	(envelope-from <dmaengine+bounces-11686-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 21 Jun 2026 23:43:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE576ABA11
	for <lists+dmaengine@lfdr.de>; Sun, 21 Jun 2026 23:43:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=HnC3Vhkp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11686-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11686-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 218BC3009152
	for <lists+dmaengine@lfdr.de>; Sun, 21 Jun 2026 21:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B020B371880;
	Sun, 21 Jun 2026 21:41:31 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F5C2D73B8
	for <dmaengine@vger.kernel.org>; Sun, 21 Jun 2026 21:41:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782078091; cv=none; b=IwseV7tJaI1wkxqSfkpKuxKRU2LGDXb6pCuNzbNVgMZqg8GO7gFP5jdt+JAlD+LcEDuhHi8SLWlSz5d3LJ3Z5cd+13Q8KBw1amPq88Z8NcsGpVSdMdUqmjNwpXCEXzIBjLf/hXdzOTAF7B43CUDe59L2szCxSKP04nhDBXrm1vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782078091; c=relaxed/simple;
	bh=AaVqPSi3j+R9XLCyLLFs+E/l+JBQxT8UcVIvlLB1NRI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=V9sAHtUfu/Nxh1rVclAcCHKAnKSiV87QrXMWE11SZ2n2xQeguqdPh5odKChGaJ50xd6v3PNi6j2U/Ltn41qDr5M7k6LGRfxuflEtsEyZfJY9PgXFOQuLwOeoOA/ET3fmUa7aL4yvl7MYnbfvrC/ROzPFYrxGRAJOQegLkVkAGc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnC3Vhkp; arc=none smtp.client-ip=209.85.219.49
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8df7a3a6fc3so27901526d6.0
        for <dmaengine@vger.kernel.org>; Sun, 21 Jun 2026 14:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782078089; x=1782682889; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/15cxm0Pr8gCTXCRGF6ew4X49c7fRxCykvCsRiSVCxw=;
        b=HnC3VhkpgPgaPK1PEVJZa39e3ETSbx3b1HIO4isI0deWEf/TAPiyP3pq5qJlyErn8X
         amBobWDMM7ZYqfb04ItfXbQSIjiTxpP+vBH7CXC7/h5h7Kq/vILfTo9smHJmS3kofPlP
         /h85AD+YlkD3xXMa3iX6Xzuzqjw0mjbiU7ZlJ8v9ldkhNpaBfWvqS5TdwsL4TzHp2+46
         hmQn7rB4j9ZoLbZrh5DBQwINGnPC+tH9pC9bFaiLQ56igkv4dNKo7tti3K/Pc/uI5c3J
         ybBdqQlx5W81GB9bFyFuMcN9T0DSrcVptAhvenK5PG73s+QDQXC46nhap8RS7Yr1UfK7
         p5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782078089; x=1782682889;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/15cxm0Pr8gCTXCRGF6ew4X49c7fRxCykvCsRiSVCxw=;
        b=Ha+Rj+Z0ifnU6HTSpfteXTOLs4HlW1zC2FMK8Pkak+DGxcisFjuXSJv8UKqIXp2/J5
         FKC5PBxbvZ+1dD+B0fdCT7a34E2L5Fiw+9T3IXqQNcxhg2sD1qj4hPlDYEJ3KS42PKpZ
         h5MQva+78w9I/BzFfS4vVZcpXiSSBW90e1csoBVIPnvDag+cVRpvgB1XCDfUc0CALoRV
         SJxlVtQGzMUJlGBNdAKYk6RJ4gfv5Tr/Waw+VB04j1BnoBD4/scOq57ldLngGVR8CUYX
         vldN8ZRIxYflpJQBjx4uPkZ22CgHa1wn9Cmc+uKAB1pRyGR95VmvzbdsKI0oySQbDoMo
         ijLg==
X-Forwarded-Encrypted: i=1; AHgh+RqarpsCDCZn3v7QPRrImMXQauPIIFaq0dKdOnPxnpApTVTwffB49y9I4lS4ZlIC2cgLSdulhz2k5OA=@vger.kernel.org
X-Gm-Message-State: AOJu0YytGw940Yrrir7ug2QhGgYEczdDDrpONKx99U0nGeynNzzpLiQL
	NSmbME+PaefiqBdtfxNLUkyU+mKsCWLypwugUy8Vf5BlgFXxyn3UwheF
X-Gm-Gg: AfdE7ckibkxR298rAjBNZ6F6ffyRZCoVQJ1HKKSm04J1YD9jEKGsbIq79P2P4jRzRnt
	IHhpwXpHDZ/FW1OlLdgU7oR8ATNX3K6BV4NmJgpsMiJKkHOQYxyOChmC9JfVhFNfp6hz2n/2Nk8
	eDmRAwK2fezhsk4XsJOI9lNGOLuvH5J2ZoelJxu7q4/GqufEx79RGiwyKovvBbGiihPvzgVyNfQ
	ee7cnrDFSp8LBHQuqBfxpZ6UuCJzEVeNR8zepgymAim/MEUBwbsselYQuQMdxOhmaj0LGNkG8MW
	x/pL+w3FwBbXRtbwUpknaVpqhW40pe0Oz4p/0nE9TJschY7bGfx+ugSeutoK0whlyvmnIK/CuyD
	3lqZhrDjRi01AwFXEUeu4j2p9Gud8pHM32cyZLOfAAcO2RDqEzUxF5C/O9nH+d5RNGLVorCOgmj
	9r+R+GD45XxceS2w==
X-Received: by 2002:a05:6214:5182:b0:8ce:e29b:6a91 with SMTP id 6a1803df08f44-8df927c4decmr137731436d6.42.1782078089211;
        Sun, 21 Jun 2026 14:41:29 -0700 (PDT)
Received: from [172.17.0.2] ([138.28.231.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df81cde9ecsm76274676d6.24.2026.06.21.14.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 14:41:28 -0700 (PDT)
From: Yuanshen Cao <alex.caoys@gmail.com>
Subject: [PATCH v2 0/5] dmaengine: sun6i-dma: Add support for Allwinner
 A733 DMA controller
Date: Sun, 21 Jun 2026 21:40:53 +0000
Message-Id: <20260621-sun60i-a733-dma-v2-0-340f205891cc@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw6DIBBFf8XMutMAAsau+h+NCwTUaeojoKaN8
 d8rdt3lSc49d4PoA/kIt2yD4FeKNA4HiEsGtjND65HcwSCY0EzzEuMyaEZoijxH1xu0QirFZcm
 1cnCspuAbep/FR/XjuNRPb+eUSUZHcR7D57xcefL+11eODJ2RtZZlYwth7m1v6HW1Yw/Vvu9fr
 Adhw8AAAAA=
X-Change-ID: 20260619-sun60i-a733-dma-c2455149165d
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>
Cc: Yuanshen Cao <alex.caoys@gmail.com>, dmaengine@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11686-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:mripard@kernel.org,m:alex.caoys@gmail.com,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:jernejskrabec@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,m:alexcaoys@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[alexcaoys@gmail.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,sholland.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexcaoys@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,linux.dev:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3BE576ABA11

Hi everyone,

This patch series introduces support for the Allwinner A733 DMA
controller in the `sun6i-dma` driver.

The A733 DMA controller differs from previous generations in several key
ways:
1. It supports higher address (up to 32G).
2. It uses a different interrupt register layout and mapping.
3. It has a different number of channels per interrupt register.

To support these differences without introducing complex conditional
logic throughout the driver, this series first refactors the
`sun6i_dma_config` structure. By moving interrupt handling, register
dumping, and address configuration into function pointers within the
configuration structure. This allows the driver to support the A733
and future hardware revisions. It also aligns with the DMA drivers in
Radxa BSP Package[1].

The series is organized as follows:
- Refactors the configuration structure to include function pointers for
  interrupt and register operations.
- Moves address setting logic into the configuration structure to handle
  varying address widths.
- Adds support for variable channels per interrupt register.
- Updates the device tree bindings documentation.
- Implements the A733-specific configuration and register mappings.

Tested on Radxa Cubie A7Z.

[1] https://github.com/radxa/allwinner-bsp/blob/cubie-aiot-v1.4.8/drivers/dma/sunxi-dma.c

Thanks!

Signed-off-by: Yuanshen Cao <alex.caoys@gmail.com>
---
Changes in v2:
- Implement SUN6I_DMA_IRQ_A31_COMMON_OPS macro to avoid duplicate.
- Move set_addr into helper function and revert back sun6i_dma_set_addr.
- Rename chan_num to irq_req to avoid misleading name as suggested by
  sashiko.
- Reorder and reword the dtbinding patch for more clarity.
- Link to v1: https://patch.msgid.link/20260619-sun60i-a733-dma-v1-0-da4b649fc72a@gmail.com

To: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Samuel Holland <samuel@sholland.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-sunxi@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org

---
Yuanshen Cao (5):
      dmaengine: sun6i-dma: Refactor to support A733 interrupt and register handling
      dmaengine: sun6i-dma: Add set_addr function pointer for variable address widths
      dmaengine: sun6i-dma: Add num_channels_per_reg for flexible interrupt mapping
      dt-bindings: dma: sun50i-a64-dma: Add allwinner,sun60i-a733-dma compatible string
      dmaengine: sun6i-dma: Implement support for Allwinner A733 DMA controller

 .../bindings/dma/allwinner,sun50i-a64-dma.yaml     |   2 +
 drivers/dma/sun6i-dma.c                            | 197 +++++++++++++++++++--
 2 files changed, 181 insertions(+), 18 deletions(-)
---
base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
change-id: 20260619-sun60i-a733-dma-c2455149165d

Best regards,
--  
Yuanshen Cao <alex.caoys@gmail.com>


