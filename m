Return-Path: <dmaengine+bounces-6410-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E5AB462A0
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 20:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AACAC1CC1B60
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 18:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE3227B4E1;
	Fri,  5 Sep 2025 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgYAYDcw"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8332701B1;
	Fri,  5 Sep 2025 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098130; cv=none; b=etLPSqsxOuMZrPqcTB4IZfyp9MOqzPPPiN+QkpRLog1hkIJCCQkB/LHZ6psTmU1a3IKFtFsTuqV869SwVqFO4yWetHuMc+ZT96IJVxCNoYRQTCsiqdAW1GJp30mXNc3mPoeWxH4ycxufv4qJ9qpwb+s13eRHJbdjLeXx0chASfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098130; c=relaxed/simple;
	bh=cNmbCY+t6TV7EQ7mnMPyCQFcbNB1z1uoW0jwR/JCPok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LiVcJU8funfeU8V3ZvjWb8gcW6BT7rmoSkCXQm42esivN2qIDY2EM0brxPYChUYLwdTKYSSXkxNdxhRyNrRoZu3UKf9mrgA8iu3gfoUhpJxcbzGXRzKP3BoK8kE4w37j/Kggx+hDArqnZsswlKPorDRRgLgGq5smu7qrKPAkUaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgYAYDcw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74AD3C4CEF8;
	Fri,  5 Sep 2025 18:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757098130;
	bh=cNmbCY+t6TV7EQ7mnMPyCQFcbNB1z1uoW0jwR/JCPok=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FgYAYDcwg+Tfk8Ex5OAOY+CUlAtyv3a2MItV3sKoUEWVofm0n6JKc7yxtM8RI+sFa
	 gfZrVGVviNm3V+7zrxvQh6WiLcCns+h72bYtchiwXAAOufk5fX/3e+YRhD57Si6AQR
	 LQWBKS1AdfWCiYETP/oN2qZLif6ZMrkt9v1qBEhE+9acEcq0eYVDn1Hba2brz5E7EZ
	 rLgo2H6VMIMrQpfqDmYqR0djAtQKr6Go8daBKTm88fH7wtB96EEyErTeqvGM/SCrZy
	 rJxY2J8QCM6y38KgMt74g3qSSNC0jAulBQKFFVfgk73vmN30B76+g3CU4/Oha0fziK
	 vbr0ceY7x7hrg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D325CA0FED;
	Fri,  5 Sep 2025 18:48:50 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 05 Sep 2025 13:48:24 -0500
Subject: [PATCH RFC 01/13] PCI: Add SNIA SDXI accelerator sub-class
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-sdxi-base-v1-1-d0341a1292ba@amd.com>
References: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
In-Reply-To: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Wei Huang <wei.huang2@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757098128; l=1221;
 i=nathan.lynch@amd.com; s=20241010; h=from:subject:message-id;
 bh=cLbH23/lVKsKayqAoeaUUitg+lat6CFljkhFBcYIeRM=;
 b=z9iadhwq4aD126u/pxl2+eSCYi+5s2XIYfBIZ0WB/TKWi1ktB0fifgdSB9s7gYkn25U3fmNN1
 QlPrDkwGK6PBcfvYKWduOxi3i5WNamHtWmlNveGYblcipp4gDeqSIL3
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=ZR637UTGg5YLDj56cxFeHdYoUjPMMFbcijfOkAmAnbc=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20241010 with
 auth_id=241
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com

From: Nathan Lynch <nathan.lynch@amd.com>

This was added to the PCI Code and ID Assignment Specification in
revision 1.14 (2021). Refer to 1.19. "Base Class 12h" of that document
as well as the "SDXI PCI-Express Device Architecture" chapter of the
SDXI specification:

"""
  SDXI functions are expected to be identified through the SDXI class
  code.
  * SNIA Smart Data Accelerator Interface (SDXI) controller:
    * Base Class = 0x12
    * Sub Class = 0x01
    * Programming Interface = 0x0
"""

Information about SDXI may be found at the SNIA website:

  https://www.snia.org/sdxi

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 include/linux/pci_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 92ffc4373f6de3dcf82226a50d0e36af366e888e..ac9bb3d64949919019d40d1f86cd3658bfb1c661 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -154,6 +154,7 @@
 
 #define PCI_BASE_CLASS_ACCELERATOR	0x12
 #define PCI_CLASS_ACCELERATOR_PROCESSING	0x1200
+#define PCI_CLASS_ACCELERATOR_SDXI		0x120100
 
 #define PCI_CLASS_OTHERS		0xff
 

-- 
2.39.5



