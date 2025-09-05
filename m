Return-Path: <dmaengine+bounces-6420-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA51B462AD
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 20:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B339C1CC1B73
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 18:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F8B284886;
	Fri,  5 Sep 2025 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8OBGPdV"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E0727FD52;
	Fri,  5 Sep 2025 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098131; cv=none; b=Dm+lvrHI/wCsGhO+87xpRKkVlSyFpigWQuw4ryJY4Y808INlOKqFPhr3bQ0w99pO7CPolsx0e8uNcFjdahP8zklYlfr3CXosMcnMQhWEuQznWOJ4nihYAMPNzAqJZW/oXBcLJRy7CmJIeKjm+aeDn8ksnu1oCQZCOyKBEllSn78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098131; c=relaxed/simple;
	bh=tqV2mVMBTfLNMFvpkSBPSeNnVNAfe/oi/nk13MKepyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rreRbCP5FtPZUYQ7j8GgeLrLWoXO5AJ9ZOLsLOgSAfC9zhyZTMrJ2FMt6zVYtRahmHUdS7jbTtHJs6QfwARtnig72EmeKWlQIUD2sJM35iCHGXscx0PXcSaW2VwdHdamp3pz6dCuHSpgaJf6ESk4dJziZzinv8hSGmiJ77QZUS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8OBGPdV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 145C7C4CEF7;
	Fri,  5 Sep 2025 18:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757098131;
	bh=tqV2mVMBTfLNMFvpkSBPSeNnVNAfe/oi/nk13MKepyo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=d8OBGPdVAiAG+m0Sxb0rkR8Yl/L4Xn7TaLOS5Ke/pUdxOfHTV2O57JSthSDxFkoi8
	 C0Uc421bf68efQXuhiTTv3qZr3T3VF0oORVszt+Lm/6Zo+SEHVHDWNos14Xb5mqDR9
	 n7uexv0i3Aikzllqg767vCfMVHyJOZLOD/P9hy0Fsw/YjaPI/8Ppup7VqAEsUaQ8Kt
	 H/FYrXIdNmqtH+LVIUTYv0dleMJgcC6sojErdKz4v2HaS8tUEfxpXCRt1UhT+9ehyM
	 yCEFRDf74IYAN0bo7x4NvCNZko6CPGAqXTebthH38cO7NqJvkTEBE3E6KTRaWwtKxE
	 7ZG32K9cist+w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0A9CA0FED;
	Fri,  5 Sep 2025 18:48:51 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 05 Sep 2025 13:48:36 -0500
Subject: [PATCH RFC 13/13] MAINTAINERS: Add entry for SDXI driver
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-sdxi-base-v1-13-d0341a1292ba@amd.com>
References: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
In-Reply-To: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Wei Huang <wei.huang2@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757098129; l=1013;
 i=nathan.lynch@amd.com; s=20241010; h=from:subject:message-id;
 bh=diiwvZ2HCcciUzDvmvbMM69P2dAF5ySeGY7sk+v6Rfw=;
 b=g9pjE89RBK+G+94dsfImJO3xLonKWVpKq/ow7JavJ4WfGw+Z+81XFuOanuP8PQeYHoz+RzLuN
 PDECOO8Y88YDR2o8fDQjDpiQ/OQtnuSyg/MUMU4+QC+s9ppZpxdUGoU
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=ZR637UTGg5YLDj56cxFeHdYoUjPMMFbcijfOkAmAnbc=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20241010 with
 auth_id=241
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com

From: Nathan Lynch <nathan.lynch@amd.com>

Add an entry for the SDXI driver to MAINTAINERS. Wei and I will
maintain the driver.

The SDXI specification and other materials may be found at:

  https://www.snia.org/sdxi

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index daf520a13bdf6a991c0160a96620f40308c29ee0..eb636ed1aa77aff30a871057efef81de8ff56cd7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22676,6 +22676,13 @@ L:	sdricohcs-devel@lists.sourceforge.net (subscribers-only)
 S:	Maintained
 F:	drivers/mmc/host/sdricoh_cs.c
 
+SDXI (Smart Data Accelerator Interface) DRIVER
+M:	Nathan Lynch <nathan.lynch@amd.com>
+M:	Wei Huang <wei.huang2@amd.com>
+L:	dmaengine@vger.kernel.org
+S:	Supported
+F:	drivers/dma/sdxi/
+
 SECO BOARDS CEC DRIVER
 M:	Ettore Chimenti <ek5.chimenti@gmail.com>
 S:	Maintained

-- 
2.39.5



