Return-Path: <dmaengine+bounces-11774-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MQnIFeTuPGp3uggAu9opvQ
	(envelope-from <dmaengine+bounces-11774-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 11:03:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0826C40D6
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 11:03:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=yoseli.org header.s=gm1 header.b=KncRG5Kf;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11774-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11774-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=yoseli.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2464430A1873
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 08:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A62B38B146;
	Thu, 25 Jun 2026 08:59:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978EA384CEA;
	Thu, 25 Jun 2026 08:59:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782377984; cv=none; b=FacRYKP0mErcDZ9VQNjRsQdyNOv/1gQlsS2grB+L6gbSQQswxxLD8Yq2EQarNRm1y234uZPt5S/y04t3M72Q/+D9/f85xO2ZhSzvr/ny4/VWAiA8cfbGY58jUw8kN0RZH+DDIqXCMKQZs2BDZqMHsE1dXuL6URnbxdwb6mCWGyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782377984; c=relaxed/simple;
	bh=syIUdyu1xWcoWr0p4kpqxq+c6k9/6ho+XigYhdJfCPs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nxuhr5+bp6O9OShmwATC/8z0YeFmw7WFSBAhzpD++DPVnFt14t9atdznCdAU+YqU7Wya2bY/acMonkozTTQEj3zzPhijIlZpEXB6QrXUMOOpS7jgBv2zHHZLa3PMGmxCWsDaDGlglOgr7CfafMO1LeKeOqryYdEVrmKK6/RZkNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yoseli.org; spf=pass smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=KncRG5Kf; arc=none smtp.client-ip=217.70.183.197
Received: by mail.gandi.net (Postfix) with ESMTPSA id F3DF03EBC2;
	Thu, 25 Jun 2026 08:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1782377979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XCzXft9NlsCoIM092yOw5c0isnDLHn+QcrWCYc/COcU=;
	b=KncRG5KfwUQ4jMqbhzLkQLOl+wJ24IWHbBnyNhzocse/kjaLxhVvqkItRn2t7omBWRkqU7
	pqUR/KHXNUip10AP0dWjqwqH/rdCbax/Cs60SYXuSKYNdpp4j1eCNm4vxrj2MErfdexGKx
	D6DErm4wNnzK1Ajpc42K+HJjHKDG6lHUxDo75HZM32Ay/IFTFXtLJl1bad7s7SHfHcJXH1
	6eKbl1PUSvpT7d/KLEXrYZx6OtO4KTcKNNe0agBVP1PjTcl9otGN2jIXiqlcXuFchAJeLZ
	P8F0WvEYrkRZKCXxgnNsjV4nMc/y1c/Im3U/JL+Z890/JO4ED1YNjKvSuhkn7Q==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Subject: [PATCH v3 0/5] dmaengine: mcf-edma: fix 64-channel handling and
 modernize IRQ setup
Date: Thu, 25 Jun 2026 10:59:36 +0200
Message-Id: <20260625-b4-edma-dmaengine-v3-0-44be00ace37d@yoseli.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPjtPGoC/yWNQQ7CIBREr2JY+w0gUHXlPUwXLfy231QwUBubp
 ncX6mIWL5l5s7KEkTCx22FlEWdKFHyG8/HA7ND4HoFcZia5NNxIDa0CdK8GctD35BHkRdhKGKN
 cU7G8e0fs6Ls7H/Wf06d9op2KqDQGSlOIy346y9Irfi2ENMULNoyuo4gwS+CgW4FKK+UMv96Xk
 HCkU4g9q7dt+wGQplW0wAAAAA==
X-Change-ID: 20260625-b4-edma-dmaengine-281c71664da7
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
 Angelo Dureghello <angelo@sysam.it>
Cc: Frank Li <Frank.Li@kernel.org>, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782377978; l=2705;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=syIUdyu1xWcoWr0p4kpqxq+c6k9/6ho+XigYhdJfCPs=;
 b=lQdLUv1rlC5XNwxd3Yr3u8l1qOZP7cTW5Fr5peUYhmHUsl5v5i/36K43J3zxcXoRYpPoGHOgs
 3fgTbbKWL8VARKcnbhStheLeyrqjlD7AfSYpMMoCY7EXqKfBzLsUHaa
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=MsMTVmoV69wLIlSkHlFoACIMVNQFyvJzvsJSQsn/kq4=
X-GND-Sasl: jeanmichel.hautbois@yoseli.org
X-GND-Score: -100
X-GND-Cause: dmFkZTGiI+TjZcRXyPKYPtAGSjOk24JrOJJ3Wpg06hmACYTjlFfj4wkTxJPX6XapZsqD8kcxRRj3hkNHo1MKGvGHp2NrxiCHanobZBAHYY+Dbyux+59gP99JdqkpgPe+4xErjo4TwGYRMcjECQzR22Zbbo4opv9gmA6OHjTAGKG8lqrXmr1Hrorb+B7A0RNUy07S0QlIXIGURPO1v1qmCa0D/R4foDBWQ6axE75F+qzwNk0sOxyb6RSKqhnfSiWaxYq8vZSNxRa1E4hcbNLWru5PDh8jF2+rjOPF4WM28/XX+B99p3ZdDO2UJmCpJ0ZjoQ9b32eiC42FziKvTyFEHmHLCq2KGaA3vLQy7eHYXyvE+mrD74brPXmlQZ3LtaB4sa1jjp5uE3UV0fJaB8jj2TRFI0qJdKmZ8jvYSS/AUhmmQfPKZMVPCmX6vD1WefQvXD3OAvlrKjF+PgKbFZhD6adz8iN3iNze5UnX2bPcNALoBTNl+8/d0VTd0a5kjwRJcIcnkf3C23tgrAmD/4FBU03cBQVO3TX643RDqsq8UQ0zgymoIilBJT3MCqOpijiHr7r0yax4ZdrRR2EkHo3EERohb/D7IKoVbB5LnEQmEwRq0bFXKexpDArl15mPZU/R0v5PSPPNLi7nfgB1dCJ8YddHXmWwQZjt6tJdjAfYiqgjUYt1rw
X-GND-State: clean
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yoseli.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[yoseli.org:s=gm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11774-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jeanmichel.hautbois@yoseli.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@nxp.com,m:vkoul@kernel.org,m:angelo@sysam.it,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jeanmichel.hautbois@yoseli.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[yoseli.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeanmichel.hautbois@yoseli.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,yoseli.org:dkim,yoseli.org:email,yoseli.org:mid,yoseli.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F0826C40D6

The MCF54418 ColdFire SoC integrates an enhanced DMA controller (eDMA)
with 64 DMA channels. The current mcf-edma interrupt and error handlers
only deal correctly with the first 32 channels: they test the status
bits with BIT(ch) on an "unsigned long", which is 32-bit on ColdFire, so
any access to a channel >= 32 is undefined behaviour and the
corresponding completions/errors are mishandled.

This series fixes the 64-channel handling and tidies up the related
code:

 - move the shared eDMA error handler out of the header file so it can
   be reused by the mcf-edma glue;
 - add an FSL_EDMA_DRV_MCF driver flag to describe the ColdFire
   specifics;
 - fix the completion and error interrupt handlers to iterate over all
   64 channels using a proper bitmap;
 - register the per-channel interrupts with devm, which also fixes the
   IRQ leak on the probe error path and quiesces the controller on
   remove().

The two interrupt-handler fixes carry Fixes: tags and are candidates for
stable.

This work was previously posted as a single series together with the
ColdFire/m68k platform enablement.  As the driver changes and the
arch/m68k/ enablement are independent and target different trees, they
are now sent separately.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
---
Changes in v3:
- Rename the patch subject prefix dma: -> dmaengine: (Vinod Koul).
- Split the ColdFire/m68k enablement into its own series targeting the
  m68k tree; this series now contains only the drivers/dma/ changes.
- Add Fixes: tags to the two 64-channel interrupt-handler fixes.
- Replace the "Add per-channel IRQ naming" change with a devm-based
  per-channel IRQ registration that also fixes the probe-failure IRQ
  leak and quiesces the controller on remove().
- Link to v2: https://lore.kernel.org/dmaengine/20251126-dma-coldfire-v2-0-5b1e4544d609@yoseli.org

---
Jean-Michel Hautbois (5):
      dmaengine: fsl-edma: Move error handler out of header file
      dmaengine: fsl-edma: Add FSL_EDMA_DRV_MCF flag for ColdFire eDMA
      dmaengine: mcf-edma: Fix interrupt handler for 64 DMA channels
      dmaengine: mcf-edma: Fix error handler for all 64 DMA channels
      dmaengine: mcf-edma: Use devm for per-channel IRQ registration

 drivers/dma/fsl-edma-common.c |   5 ++
 drivers/dma/fsl-edma-common.h |  11 ++--
 drivers/dma/mcf-edma-main.c   | 133 ++++++++++++++++++++----------------------
 3 files changed, 72 insertions(+), 77 deletions(-)
---
base-commit: ab9de95c9cf952332ab79453b4b5d1bfca8e514f
change-id: 20260625-b4-edma-dmaengine-281c71664da7

Best regards,
--  
Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>


