Return-Path: <dmaengine+bounces-1551-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAD888DACC
	for <lists+dmaengine@lfdr.de>; Wed, 27 Mar 2024 10:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93DE51F2A053
	for <lists+dmaengine@lfdr.de>; Wed, 27 Mar 2024 09:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5995A3A264;
	Wed, 27 Mar 2024 09:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MRW0GmJG"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597D22EB05;
	Wed, 27 Mar 2024 09:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711533554; cv=none; b=In44JU6iRCdu7VHilFt/X1ruy4QZHALGBAosl9vwFicjANPgKX/aFecS3zxtePe0Ay7qYx7pJHkfcVMzNxy0zvk59GZw92hD3W1jGvISEJOoXaZm/HWtvYZbAUZ4mt+6vj98tQ+wvLAwjrN0aAIDJI7OJfgYCmOeLdvNXXJF5yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711533554; c=relaxed/simple;
	bh=hH3nkol0D9n+79wP1SeGr0CEiZZZ6HOE9y+63tUTgbc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GY1ZjYz+F7kTyO7bumO8dT3xeZhvO9QKG9Aadmea89nMHRKIGetFiBu1u+ge++2LfRCIcptSkAdKkIdZAC/06HlzBYJhqVGQ8hkG9DTt+Lu6LS1DsTP844LypeX0Y3KyJvM4W3tu7EQUGn4uefN/fpWDlkR/DwoT2T/62gxwFo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MRW0GmJG; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D04492000A;
	Wed, 27 Mar 2024 09:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711533549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7AOXxENiOZu9Q6E3lamw5EvRntGLECkgd1135Gi9eBM=;
	b=MRW0GmJGmT5NXlfZgPDZ/CmlB9F26D3GSUxcAKua51sDU37KRtUxeHOF7IN0L0hCpRYVxe
	UREGGnXzExpEhaS24jSVfOogB7aYJMy2X/T7Ol99ClztzmgQcjJETRj6Opgp0aDKrdvy1y
	ZGucnqwmXtyGw4EXO17++BZ2WHvvR8cDtfqPLsSEEbfPnvdgd9KcKZdq9vucrNEd9GH1Ci
	EOXPQj8QTzcyrd+5YXzec3fN2/pJEQjf1pbCZGpnbQOQ3w0k8wD+WkLEtv2pNz3YVSvRh2
	0KuOMM3zLY5EtHzgDxUfotTfV7V1zvWWOBnAEmV0ebkKSR32RwW/EgCYAHXB0Q==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Subject: [PATCH 0/3] dmaengine: xilinx: xdma: Various fixes for xdma
Date: Wed, 27 Mar 2024 10:58:47 +0100
Message-Id: <20240327-digigram-xdma-fixes-v1-0-45f4a52c0283@bootlin.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANftA2YC/x3LTQqAIBBA4avIrBvInwi6SrSYcrJZZKEQgnT3p
 OXH41XInIQzTKpC4keyXLFBdwq2g2JgFN8Mpjeut8aglyAh0YnFn4S7FM5IpK0b9Dq60UE778R
 /aOO8vO8HCsbB0GUAAAA=
To: Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>, 
 Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>, 
 Vinod Koul <vkoul@kernel.org>, Michal Simek <michal.simek@amd.com>, 
 Jan Kuliga <jankul@alatek.krakow.pl>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=927;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=hH3nkol0D9n+79wP1SeGr0CEiZZZ6HOE9y+63tUTgbc=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmA+3rUgXjk92zRe2bs1JcSuniCJEA2pWJHuOXfeNo
 13hmjpuJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZgPt6wAKCRAgrS7GWxAs4hVxEA
 C77RZ5Smytho2eHluPFl/tNiMpTM13E2gnesZiJIllJO9w6RNQemRttPhvUtGurWFnmZhUS44Ax14y
 +Bqp7O98ut1vyIxDQSs81D7wzkpL2UkhSkzCpli2Th5U+6c6kxrq1NMCRGSSPCgIlbecwvZP5oTk0S
 rt8koWLl69W7lxnaH8yJmlH9WuW2E02Zt7li5SF6/N7J4t78D0BZCrYcYE04IN5gjzJDLu12BGaQly
 2iCXZ+MOFEiqaDNpaCNA5bEVArgYjqRvSYFWJcZBQyNu+QLE/qHUAgdOVeu7THzkgXxGONf8dMCYHi
 5KbryTkfRGC3DJZ6BKFy0DMduGoeTdMqujAKi0vm+Oh4rfJNSGoNu+o+hYhCeo1ftcQvCVNkvMwiVq
 GKERHylegaimhBMj1obVlXbn/TXQmDzVlm4Aql9ffsr02OGWIuUgWYPw/4WOjD/ZnPJt9q9kLFtxL0
 BTOon4x23OwZNzmTpnSylaX3BUTQjXvRrWAta5z+Ylg2mqj7vyFa6cUMl6+smItDlVbIq6XtKYbK24
 oOQvyZQWA6Q2TCK3MclWGXj/n/SgyYasjrJlKS3LRIVMQkp/cvrFK+vv/+6wQhmbdS08qiNjkeoFX4
 ACrf013c/F1QYS/sahrejJEI2o0I8PvxhSPDCGByZQwAHFlsDsNFN2iYr2yA==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

The current driver have some issues, this series fixes them.

PATCH 1 is fixing a wrong offset computation in the dma descriptor address
PATCH 2 is fixing the xdma_synchronize callback, which was not waiting 
   properly for the last transfer.
PATCH 3 is clarifing the documentation for xdma_fill_descs 

---
Louis Chauvet (1):
      dmaengine: xilinx: xdma: Fix synchronization issue

Miquel Raynal (2):
      dmaengine: xilinx: xdma: Fix wrong offsets in the buffers addresses in dma descriptor
      dmaengine: xilinx: xdma: Clarify kdoc in XDMA driver

 drivers/dma/xilinx/xdma-regs.h |  3 +++
 drivers/dma/xilinx/xdma.c      | 42 +++++++++++++++++++++++++++---------------
 2 files changed, 30 insertions(+), 15 deletions(-)
---
base-commit: 8e938e39866920ddc266898e6ae1fffc5c8f51aa
change-id: 20240322-digigram-xdma-fixes-aa13451b7474

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>


