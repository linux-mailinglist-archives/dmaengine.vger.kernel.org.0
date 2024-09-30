Return-Path: <dmaengine+bounces-3236-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EE198A802
	for <lists+dmaengine@lfdr.de>; Mon, 30 Sep 2024 17:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 140EA1F24B02
	for <lists+dmaengine@lfdr.de>; Mon, 30 Sep 2024 15:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA73F191F74;
	Mon, 30 Sep 2024 15:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="CW6XFPid"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF971CFA9
	for <dmaengine@vger.kernel.org>; Mon, 30 Sep 2024 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727708400; cv=none; b=Tdjp/ExVMgNx9xx4bu+fhRlJlXT9dDSZaKSVhCUJyimgbUEML5QdDo4xcdIVnY7+MsCXo5CEay/s0GV/+IxmWZ8oOHjNpkP72zzxqqR1QlmnufPA6zXlscSnxPwVQ9TtzRPqithWsoeLILDYAJBBM+2QH8rgQQwNmbwe9CofMjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727708400; c=relaxed/simple;
	bh=xinIHUprBI52PsIRaJ4JZcTeZPje0snSfpYXu/fggQk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jjvi492twErw7MLyMtCgUbBGWFlWEjTZtoYgIXYXtN9PVRYueX51fuDXzDTOa8IgSndlFayl+L46eMQiCOcE905TeithnTPa4WtzHBXVTTzXpqT3dMjbtkDL2s3fUpgoxfSKWGhlO65Tfvhn1zrxBy7PHxAeu+4BTnCZjv8rRDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=CW6XFPid; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=Zh1yObY8WHow/K
	ijC4LeeBHtkdQnh8DwECG6Q2RxrFk=; b=CW6XFPidi8bt7iDwyc7Fh+ufYrIZQ2
	CIBpMeW9F+jcanYCIGt7S7N4ViCgCNV6NvI5fP0DMl4B4+HgZtmF+2gGYFjcGEyI
	vhM0wL1fHEwxA+AHCePHVH9fI80za3GRwps9XVWlYBFft3B0jCd6aMMsKrntJq2E
	gJ1wK2vpl6sjXAeONadfQ+cv7x1vHjZ+w7L2WfVHPaHJNnW9/plFrvTUZT8lQXQe
	pBGtgCNGGk6FR80HGyDIbt269ssy7KhixqH7r9jtAqJpKXQZz3tQmRNGTAvP5TKX
	/us73NGEvAHrQJ94X2yLqu5fLj4HVzBpb74kTOCoVGJ9qHRNOldMDQmA==
Received: (qmail 2222573 invoked from network); 30 Sep 2024 16:59:56 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Sep 2024 16:59:56 +0200
X-UD-Smtp-Session: l3s3148p1@eSVCdVcj3uYujnsJ
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
Subject: [PATCH 0/3] dmaengine: sh: rz-dmac: add r7s72100 support
Date: Mon, 30 Sep 2024 16:59:51 +0200
Message-ID: <20240930145955.4248-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When activating good old Genmai board for regression testing, I found
out that not much is needed to activate the DMA controller for A1L.
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
  dt-bindings: dma: rz-dmac: Document RZ/A1L SoC
  dmaengine: sh: rz-dmac: add r7s72100 support

 .../bindings/dma/renesas,rz-dmac.yaml         | 27 +++++++++++++------
 drivers/dma/sh/Kconfig                        |  6 ++---
 drivers/dma/sh/rz-dmac.c                      | 27 ++++++++++---------
 3 files changed, 37 insertions(+), 23 deletions(-)

-- 
2.45.2


