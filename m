Return-Path: <dmaengine+bounces-6989-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59784C09303
	for <lists+dmaengine@lfdr.de>; Sat, 25 Oct 2025 18:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 617F53B6EFD
	for <lists+dmaengine@lfdr.de>; Sat, 25 Oct 2025 16:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6091D303A1C;
	Sat, 25 Oct 2025 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcywdgQb"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AF5205AB6;
	Sat, 25 Oct 2025 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761408575; cv=none; b=YjQro6N/EUICSSfv20s4WL/tCHIHfNvAqwoC0NU8U7XrmCyZm3KCHeAskoSOAxNFIh1yCRLlXOxoYboGaD0OiOknyuWZ7+CoUMq4r3GVqgZGCFPEh4dFTTiOczR89jzYo5HmiTJMgaPcNnkCQ/j/Vsu+qc3eYqDxkBPo/jhl7Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761408575; c=relaxed/simple;
	bh=hP89qQmKZjwi7eCg302zpn3HWNE+6yuy0IrCw0HhMNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=agoxdffmAt/V8UHSbaqSVquaxaktHQSQEvNYr0YEgBexECVj6ORv9r8yqODk9IvQZGc6meWuPu4p++Rx/fCYW5PUVLKlfXegKaTGOQdVM5B+67SL0j4fsYLUX6YR0Xj4GhfgeCI2rcLzSyYMhAJIud8G0/X79IXUc4CNn0OamY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcywdgQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321BBC4CEF5;
	Sat, 25 Oct 2025 16:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761408575;
	bh=hP89qQmKZjwi7eCg302zpn3HWNE+6yuy0IrCw0HhMNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IcywdgQb6wtAydOACSGZHT/caOCVouixacZ1CkQFfSo5IX76qtT6CZNor8beBLFVY
	 AW1fFNYSvSNK9tjSFXIYjco9oQ/Sr2hLZ6HkVnOjPjF9vrwSFlKYw2NIkun+Ow248z
	 FPmCjUQo+KsF/S2VVqWhU2Qkt2py4OWA/iHkrCIAfLQip5i04MJ2QHvCi4nvlWXm51
	 BmKyM+TUsFhGBe4EMCQZuhaKE7iCXNb9Jroq2hCdHsfPHpO/RHSpvBkcbZIpmU2DHa
	 wvy2MRsGjSeB0LOtOKf5Wp/6kc7NlYsUSe1uUZTbjp3r2QBft4pdi8+f/kcdKPnNp4
	 HzVcF3aZvHmFA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17] dmaengine: idxd: Add a new IAA device ID for Wildcat Lake family platforms
Date: Sat, 25 Oct 2025 11:54:02 -0400
Message-ID: <20251025160905.3857885-11-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>

[ Upstream commit c937969a503ebf45e0bebafee4122db22b0091bd ]

A new IAA device ID, 0xfd2d, is introduced across all Wildcat Lake
family platforms. Add the device ID to the IDXD driver.

Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Link: https://lore.kernel.org/r/20250801215936.188555-1-vinicius.gomes@intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

- User impact: This enables the IDXD (IAA/IAX) driver to bind to Wildcat
  Lake (WCL) IAA devices (PCI ID 0xfd2d). Without it, systems with this
  hardware won’t get driver support, which is a practical user-visible
  gap for those platforms.
- Change scope: Extremely small and contained. It only adds one PCI
  device ID constant and one table entry to match that ID to the
  existing IAA/IAX driver flow.
  - `drivers/dma/idxd/registers.h`: Adds `#define
    PCI_DEVICE_ID_INTEL_IAA_WCL 0xfd2d`, introducing the new PCI ID
    without altering any logic.
  - `drivers/dma/idxd/init.c`: Adds `{ PCI_DEVICE_DATA(INTEL, IAA_WCL,
    &idxd_driver_data[IDXD_TYPE_IAX]) },` to `idxd_pci_tbl[]`, mapping
    the new device ID to the already-existing IAA/IAX handling path
    (`IDXD_TYPE_IAX`).
- No architectural changes: The driver’s behavior, register handling,
  and completion record layouts are unchanged. The new entry reuses the
  same `idxd_driver_data[IDXD_TYPE_IAX]` path, which already sets
  `cr_status_off`, `cr_result_off`, and `.load_device_defaults =
  idxd_load_iaa_device_defaults` for IAA devices (see
  `drivers/dma/idxd/init.c` context around `idxd_driver_data[]`). This
  indicates the new device is expected to be compatible with the
  existing IAA v1.0 programming model.
- Minimal regression risk: The only effect is that the driver now binds
  to devices reporting PCI ID 0xfd2d. No code paths for existing
  supported devices change; IRQ/MSI-X setup and all other logic remain
  untouched (the surrounding `idxd_setup_interrupts()` code is unchanged
  in `drivers/dma/idxd/init.c`).
- No side effects beyond enablement: No new kernel APIs, no user-visible
  ABI changes, no feature additions beyond recognizing new hardware.
- Stable policy fit: Even though the commit message doesn’t explicitly
  Cc stable or carry a Fixes tag, adding a PCI ID to support a
  compatible device is a common, low-risk backport to stable trees and
  often accepted to support shipping hardware.
- Preconditions for backport: The target stable series must already
  include the IDXD IAA/IAX support path (e.g., existing `IDXD_TYPE_IAX`
  infrastructure, IAA default loader, and related completion record
  definitions). If those are present (as implied by existing entries
  like `IAA_DMR` and `IAA_PTL` in `drivers/dma/idxd/init.c`), this is a
  clean, standalone enablement.

Conclusion: This is a classic, low-risk enablement-only change; it
should be backported to stable so that WCL IAA hardware works out of the
box.

 drivers/dma/idxd/init.c      | 2 ++
 drivers/dma/idxd/registers.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 8c4725ad1f648..2acc34b3daff8 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -80,6 +80,8 @@ static struct pci_device_id idxd_pci_tbl[] = {
 	{ PCI_DEVICE_DATA(INTEL, IAA_DMR, &idxd_driver_data[IDXD_TYPE_IAX]) },
 	/* IAA PTL platforms */
 	{ PCI_DEVICE_DATA(INTEL, IAA_PTL, &idxd_driver_data[IDXD_TYPE_IAX]) },
+	/* IAA WCL platforms */
+	{ PCI_DEVICE_DATA(INTEL, IAA_WCL, &idxd_driver_data[IDXD_TYPE_IAX]) },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, idxd_pci_tbl);
diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index 9c1c546fe443e..0d84bd7a680b7 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -10,6 +10,7 @@
 #define PCI_DEVICE_ID_INTEL_DSA_DMR	0x1212
 #define PCI_DEVICE_ID_INTEL_IAA_DMR	0x1216
 #define PCI_DEVICE_ID_INTEL_IAA_PTL	0xb02d
+#define PCI_DEVICE_ID_INTEL_IAA_WCL	0xfd2d
 
 #define DEVICE_VERSION_1		0x100
 #define DEVICE_VERSION_2		0x200
-- 
2.51.0


