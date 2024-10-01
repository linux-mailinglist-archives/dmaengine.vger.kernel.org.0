Return-Path: <dmaengine+bounces-3250-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CB198BC73
	for <lists+dmaengine@lfdr.de>; Tue,  1 Oct 2024 14:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1712B23D5A
	for <lists+dmaengine@lfdr.de>; Tue,  1 Oct 2024 12:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812CC1C2DBE;
	Tue,  1 Oct 2024 12:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="CedhyN8V"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563FC1C32E5
	for <dmaengine@vger.kernel.org>; Tue,  1 Oct 2024 12:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727786605; cv=none; b=jaJf1kQVIAKv2c6vuJR3NmxRCdhJuTQLlX41WGQ94VgP1jwjzdVbHG83x+fc02K+aZspcTDCmXhrW1JyZAnRGS944AIPs65RE3L9cqNPER0jQ1gRWhplXid7P8ZNsHFu0myZTApNfUm3mGmxn30I6m2TsQrR/2ksfEmAivBRFxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727786605; c=relaxed/simple;
	bh=LfwXj+ePIZcsa6TZc6LW4L9UZrnKQQ6fjAWmspSVDMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lIW8hs7sP5A6z/4lFG6AdqYgXiDcJ4jIUDaXIwgA+OeVkbEsilFxrCpNbh3ccgr8fk9VsqFsBlJtLpsHQseLpt6ghWDZF8v8AGFhmb3D3bnNxDx4p+VQUUK9JRTtQd4W/yJp+rcGpiqmDXUmmOGECSlM9+W6Njt4/8PY6XE3kZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=CedhyN8V; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=Q+t9pZ2P/32bWX
	lJU1h2ij34utM5w1KgvNN67kolRks=; b=CedhyN8V2+XGAdfvOqlKsxGI6TDHOH
	fLi01LekLLukk1MiiN4SXV7qvaRwy4GeUiLxcU68T0tgdbM65KAr61ONhFNRP22a
	9TkPhRAgcJPgbIvSmJkkFnhP0xG2Olh3c7wEP7u8UOskbu8Va2zUJ0v1XRTCkKr/
	sG82JucbXPTnu9iJfDImsoKqKQmFMWldnzmVjO3POLb6IOkjzDWWa9Yfg1yQb7Nw
	eXYjN/enJvscgNoZtBaKDmvPU35seLoSDvAMibwOv9CSE7XpqXd2bfcxs1cqCrEK
	+7+2mZBrHGmz9e19S5FCcZo7MjwlHxTTbq6ua+zBRl4r8bOfCERcc9tQ==
Received: (qmail 2523545 invoked from network); 1 Oct 2024 14:43:13 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Oct 2024 14:43:13 +0200
X-UD-Smtp-Session: l3s3148p1@hZkfqmkjpNoujnuV
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v2 0/3] dmaengine: sh: rz-dmac: add r7s72100 support
Date: Tue,  1 Oct 2024 14:43:06 +0200
Message-ID: <20241001124310.2336-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v1:
* added tags to patches 1 and 3 (Thanks Biju, Claudiu, and Philipp!)
* used A1H instead of A1L (Thanks, Geert!)
* reworded comments and descriptions to use a more generic "RZ DMA"
  term without mentioning all the SoCs in patches 2 and 3.

Old cover-letter:

When activating good old Genmai board for regression testing, I found
out that not much is needed to activate the DMA controller for A1H.
Which makes sense, because the driver was initially written for this
SoC. Let it come home ;)

Patch 1 is a generic fix. The other patches are the actual enablement.
A branch with DTS additions for MMCIF can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/genmai-upstreaming

These will be upstreamed once the driver parts are in next. Adding SDHI
is still WIP because RZ/A1L usage exposes a SDHI driver bug. So much for
the value of regression testing...

Wolfram Sang (3):
  dmaengine: sh: rz-dmac: handle configs where one address is zero
  dt-bindings: dma: rz-dmac: Document RZ/A1H SoC
  dmaengine: sh: rz-dmac: add r7s72100 support

 .../bindings/dma/renesas,rz-dmac.yaml         | 27 +++++++++++++------
 drivers/dma/sh/Kconfig                        |  8 +++---
 drivers/dma/sh/rz-dmac.c                      | 27 ++++++++++---------
 3 files changed, 38 insertions(+), 24 deletions(-)

-- 
2.45.2


