Return-Path: <dmaengine+bounces-11702-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bxzqFCGSOGqMdwcAu9opvQ
	(envelope-from <dmaengine+bounces-11702-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 03:38:41 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 969E06ABF32
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 03:38:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=QT0+fxEF;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11702-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11702-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EB26300BC92
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 01:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9800924EA90;
	Mon, 22 Jun 2026 01:38:38 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8F21519B4
	for <dmaengine@vger.kernel.org>; Mon, 22 Jun 2026 01:38:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782092318; cv=none; b=p7il7Ar1U5ktNF0R1I2pYzq66km/RuZt1C5zYOp5K3yz2CpcdaJALG/zfmhmR1CB3inlnvlwF6PasHTWxjF7Q9ISxeRHmkU7sGjdNyl0r0jYysG5DsmKPi7xGnT5wZ7NHQLQELyrDiMTfs8HKyV7h4AnunHzDlbCrK2oJ7HAxvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782092318; c=relaxed/simple;
	bh=uhIvo90yyNuSPEcJaD9VYXjhX72LdlUeeMyWYoo59cw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eAFRnrTejOPdcKqYPMhyr7SSHSmky4+g37gSSJTwrpLRdKLSFeHTlER+0CeXTervY12pj1Ew6gYDwdbU0oeBZIFAJSlk9T/MD9m6nDQHhCECRPrDlkaPUnQCGLR2xtLn3sx99sx0cQeaoi/W3qd4f+yqto+YhBEjCReHnCvCpDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QT0+fxEF; arc=none smtp.client-ip=209.85.160.182
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51a13ceb03bso19645121cf.2
        for <dmaengine@vger.kernel.org>; Sun, 21 Jun 2026 18:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782092316; x=1782697116; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+utPNMRVTmNzPHuEyrqqa9jsDCRNXUwMgRtH5CJYOFY=;
        b=QT0+fxEFJwhupn4qq4mQVL2B7uzaGa+eeKV1WrKCU5e08MatYTisC8yiDzf75eK8Zr
         DyF75reH5qiQG1sFpj0u+au11Ykm4enkPLPcDFAjHix1AXOHIpgPegFLw+AmACSHio0n
         lJ0+AbmsO9Xj4P2l1yEA3jFE420DbLqH0LK0hpjhf3kyCKU6k6+m6CNBt+qPmzXOqIi0
         EDq+qWqcVQvHmuF7p3Oe5rG3KOzpNP9C29SdB1fJbAANPfihXQggXxIckj/O0yiuRtyE
         Cnb1ajflpWNalbqgida42TaUwmlWVh5aYXRVLoPZAcsAqjHCCcZwAM5uPx4/Ytm/9vIN
         fKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782092316; x=1782697116;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+utPNMRVTmNzPHuEyrqqa9jsDCRNXUwMgRtH5CJYOFY=;
        b=sfX/B4eqEz+3u2aman0rN/cpryEKxdL69EsAEvy+hF/pRdhIbHfeVqQ2zK+uMz9mtV
         7M0av8BHkZ6y64llLtWUl8+8+7qPIx1yTdub5OVywIQj4LThctJBw3OsbWlNEHfXoieR
         +wnQ2F+GXKFEYYdZNBoOcw/oAbL5iGxFhiiHm4PjMFAa251E049Iyu21yNmwCKDdRU0/
         yIQzp3eQ8XSxfhgnzE+72rpRBlr3SMZd/tn2f6ruiRV+E3bh1Uml9rwZHdytNHN6htcr
         gSMZTFXRPtig5Wgfm4k/jqUzJgFV/5Q0fDBolrRjr4hqyjP+dnu1YdXbJ8t9e2MJq/or
         P56Q==
X-Forwarded-Encrypted: i=1; AFNElJ821wtpnrHqeBbh/fS15Da4jCqISHYffh6yTgjyaeJbEpc5xtFY+m+wR+f6A6dAkW/DL/J2+KjA0HY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKDJsQ7nbdppnpg7N/PoYONXR5Nmr2jqI5m7MuiK2paNZ5Ax4T
	seiQWw3C4J6s5VBq4Ew30mk0sJjsbi3kPdjdTrzIs4nDI59k7/ME5wDY
X-Gm-Gg: AfdE7ckvfkZfHwX5u7ZHZQBx8Tjtylqw23CUMDlYL0WZnARJkkzyOA2J2sRAyGyJGFV
	IP+8+qPyX+MmnCK6/Njxpgjv0sfjs+2egPtbVFaxmMBj2Hic8Tg5S2j68JF8ldnWwUlp+M15MWs
	/kgKfrV3u2y6Bnt/q+sczYRGnNi2JFU639peEOgdufl4WfP1QgtZIWfiOoGjGdTWyKf4tQMO+om
	qunddOxjUGr9KhpeQBbIBzpPrU++ku/AfchDF+VIbCk7YYFaAhQzDDDWb2chtKZhAIkUNnnrNRB
	B5xXt+DKYnj6rWsxbJvP3p/JTQPCsAsgepRmk9WJbGQfTsh0sZ1zI/3dzBp+z9WLUDSiDHq2klM
	R3/Esk5bsNdeOO4VjOeEk8B8CM+V40Gg0tWaTtsVUEpHI/QQbVhXm2RDmrtZKTx95XoUAQ2wRe8
	4vmr6PexEYnqNVOQ==
X-Received: by 2002:a05:622a:a04e:b0:519:f2bb:1036 with SMTP id d75a77b69052e-519f2bb1203mr115543741cf.36.1782092316301;
        Sun, 21 Jun 2026 18:38:36 -0700 (PDT)
Received: from [172.17.0.2] ([138.28.231.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a098e287csm55778831cf.29.2026.06.21.18.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 18:38:35 -0700 (PDT)
From: Yuanshen Cao <alex.caoys@gmail.com>
Subject: [PATCH v3 0/5] dmaengine: sun6i-dma: Add support for Allwinner
 A733 DMA controller
Date: Mon, 22 Jun 2026 01:36:22 +0000
Message-Id: <20260622-sun60i-a733-dma-v3-0-f697ef296cbc@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNTQ6CMBgFr0K6tqb9+oO48h7GRWkL1AiYFhoN4
 e62uCExLid5M29BwXpnAzoXC/I2uuDGIQE7FEh3amgtdiYxAgKSSFrhMA+SOKxKxrDpFdbAhaC
 8olIYlKynt417bcXr7cthru9WTzmTF50L0+jf22Wkefe/Hikm2CheS141ugR1aXvlHkc99ijXI
 +x8oL8+JJ9x0gARp4pqvffXdf0AaAIbAQABAAA=
X-Change-ID: 20260619-sun60i-a733-dma-c2455149165d
To: conor+dt@kernel.org, mripard@kernel.org, krzk+dt@kernel.org, 
 robh@kernel.org, samuel@sholland.org, wens@kernel.org, 
 jernej.skrabec@gmail.com, Frank.Li@kernel.org, vkoul@kernel.org
Cc: Yuanshen Cao <alex.caoys@gmail.com>, dmaengine@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11702-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:conor+dt@kernel.org,m:mripard@kernel.org,m:krzk+dt@kernel.org,m:robh@kernel.org,m:samuel@sholland.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:alex.caoys@gmail.com,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:Frank.Li@nxp.com,m:conor@kernel.org,m:krzk@kernel.org,m:jernejskrabec@gmail.com,m:alexcaoys@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[alexcaoys@gmail.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[kernel.org,sholland.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,nxp.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexcaoys@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 969E06ABF32

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
Changes in v3:
- Reword patches for clarity.
- Link to v2: https://patch.msgid.link/20260621-sun60i-a733-dma-v2-0-340f205891cc@gmail.com
---
Changes in v2:
- Implement SUN6I_DMA_IRQ_A31_COMMON_OPS macro to avoid duplicate.
- Move set_addr into helper function and revert back sun6i_dma_set_addr.
- Rename chan_num to irq_req to avoid misleading name as suggested by
  sashiko.
- Reorder and reword the dtbinding patch for more clarity.
- Link to v1: https://patch.msgid.link/20260619-sun60i-a733-dma-v1-0-da4b649fc72a@gmail.com

---
Yuanshen Cao (5):
      dmaengine: sun6i-dma: Refactor to support A733 interrupt and register handling
      dmaengine: sun6i-dma: Add set_addr function pointer for variable address widths
      dmaengine: sun6i-dma: Add num_channels_per_reg for flexible interrupt mapping
      dt-bindings: dmaengine: sun50i-a64-dma: Add allwinner,sun60i-a733-dma compatible string
      dmaengine: sun6i-dma: Add support for Allwinner A733 DMA controller

 .../bindings/dma/allwinner,sun50i-a64-dma.yaml     |   2 +
 drivers/dma/sun6i-dma.c                            | 197 +++++++++++++++++++--
 2 files changed, 181 insertions(+), 18 deletions(-)
---
base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
change-id: 20260619-sun60i-a733-dma-c2455149165d

Best regards,
--  
Yuanshen Cao <alex.caoys@gmail.com>


