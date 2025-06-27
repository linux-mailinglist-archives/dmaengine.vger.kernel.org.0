Return-Path: <dmaengine+bounces-5662-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35504AEBAA5
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 16:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E54856031A
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 14:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8183D2E92A7;
	Fri, 27 Jun 2025 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcF1qeMC"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1A52E7F08;
	Fri, 27 Jun 2025 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751036355; cv=none; b=pyO1n77ZoggHXXtRaOsoyFvQgsrEobNxooy8GnRlax+2mwv5oTuhXbOfbo6Ee/ab0Sef4z8/YVooA68G7Dj0kmWWVMTmP6FMvOd731nisUpkaESyASUjE/S56VrG+7lRVJcp+uzbZIkJtPw2GMNID0zAiM490LJ2U+J2VH22MvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751036355; c=relaxed/simple;
	bh=W24IHKj+SlDNVJOCYhxMLrPfL4h+fsCaf5OkbSZrYPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ugTHXq5Icu53N3kCYXpkX/lQyihRCPPx/kAKa9rURWwQiMBjQmeEUlziN+ZfYYiTigrJnnU3R8if2UkK+SsWy/VItwGCcUREuF4KxhnVqJcPysjEugUYwrRZga8jqAARrD8gmBajao4gZLUeLz246mFAR9nZ4psaevwpwoG0zZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcF1qeMC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6CF4C4CEF6;
	Fri, 27 Jun 2025 14:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751036354;
	bh=W24IHKj+SlDNVJOCYhxMLrPfL4h+fsCaf5OkbSZrYPE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OcF1qeMCEpW9J2B3pMBT8SG68FBj+P2FA5itLbE7NvVgVHv4QVH/JCO5vDN0mwV/A
	 xmtuS/jikwJCwriot43VnV49yU2vWL8HohEkwHbCv/yhEdp7Fqb9EPx3v6/lPsG2sB
	 ETKUgbZAPcZK0p1x6iUzrHII0MiFJ2TQSmN7yx+hxyOvN8ESArRhZ8fSEIXZ5ezuq3
	 1tC4LqlBLV5VdgvynD1DUVCY5EUv3hjM+BRsbKhI8FvXcNCgkzsJ6fctiBNLrMFwY9
	 X0nrYo9dRoi8T8mLPVrE/wg/IKSo/eo0UnZb2slup4Jt29jkdy7l60gnuwLVTZ1M9x
	 J7ZyGoY8t5UWA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB57AC7EE2A;
	Fri, 27 Jun 2025 14:59:14 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 27 Jun 2025 15:59:13 +0100
Subject: [PATCH RESEND v7 4/7] include: adi-axi-common: add new helper
 macros
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250627-dev-axi-clkgen-limits-v7-4-e4f3b1f76189@analog.com>
References: <20250627-dev-axi-clkgen-limits-v7-0-e4f3b1f76189@analog.com>
In-Reply-To: <20250627-dev-axi-clkgen-limits-v7-0-e4f3b1f76189@analog.com>
To: linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org, 
 dmaengine@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-spi@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, 
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
 Vinod Koul <vkoul@kernel.org>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Trevor Gamblin <tgamblin@baylibre.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, 
 Mike Turquette <mturquette@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751036364; l=1982;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=8E3tnJOQHd1DGzVU+4oHkcTaB0uu72Nu8VTU/0TEplU=;
 b=mSdoozCCGcvNaMbgrSeDkJLvEMcGNzJK8vR7AX00harXNacPlpk/TB6yGTnhMf+9chFssPy20
 LIp0/nzPiv7CaKyi0tfc5ZQh+SyiDpnRbhlR0wGK+oXtWq84TuxhZW3
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Add new helper macros and enums to help identifying the platform and some
characteristics of it at runtime.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 include/linux/adi-axi-common.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/include/linux/adi-axi-common.h b/include/linux/adi-axi-common.h
index 141ac3f251e6f256526812b9d55cd440a2a46e76..f64f4ad4bedae312ec450bd5fed09ceaedd5397e 100644
--- a/include/linux/adi-axi-common.h
+++ b/include/linux/adi-axi-common.h
@@ -12,6 +12,7 @@
 #define ADI_AXI_COMMON_H_
 
 #define ADI_AXI_REG_VERSION			0x0000
+#define ADI_AXI_REG_FPGA_INFO			0x001C
 
 #define ADI_AXI_PCORE_VER(major, minor, patch)	\
 	(((major) << 16) | ((minor) << 8) | (patch))
@@ -20,4 +21,36 @@
 #define ADI_AXI_PCORE_VER_MINOR(version)	(((version) >> 8) & 0xff)
 #define ADI_AXI_PCORE_VER_PATCH(version)	((version) & 0xff)
 
+#define ADI_AXI_INFO_FPGA_TECH(info)            (((info) >> 24) & 0xff)
+#define ADI_AXI_INFO_FPGA_FAMILY(info)          (((info) >> 16) & 0xff)
+#define ADI_AXI_INFO_FPGA_SPEED_GRADE(info)     (((info) >> 8) & 0xff)
+
+enum adi_axi_fpga_technology {
+	ADI_AXI_FPGA_TECH_UNKNOWN = 0,
+	ADI_AXI_FPGA_TECH_SERIES7,
+	ADI_AXI_FPGA_TECH_ULTRASCALE,
+	ADI_AXI_FPGA_TECH_ULTRASCALE_PLUS,
+};
+
+enum adi_axi_fpga_family {
+	ADI_AXI_FPGA_FAMILY_UNKNOWN = 0,
+	ADI_AXI_FPGA_FAMILY_ARTIX,
+	ADI_AXI_FPGA_FAMILY_KINTEX,
+	ADI_AXI_FPGA_FAMILY_VIRTEX,
+	ADI_AXI_FPGA_FAMILY_ZYNQ,
+};
+
+enum adi_axi_fpga_speed_grade {
+	ADI_AXI_FPGA_SPEED_UNKNOWN      = 0,
+	ADI_AXI_FPGA_SPEED_1    = 10,
+	ADI_AXI_FPGA_SPEED_1L   = 11,
+	ADI_AXI_FPGA_SPEED_1H   = 12,
+	ADI_AXI_FPGA_SPEED_1HV  = 13,
+	ADI_AXI_FPGA_SPEED_1LV  = 14,
+	ADI_AXI_FPGA_SPEED_2    = 20,
+	ADI_AXI_FPGA_SPEED_2L   = 21,
+	ADI_AXI_FPGA_SPEED_2LV  = 22,
+	ADI_AXI_FPGA_SPEED_3    = 30,
+};
+
 #endif /* ADI_AXI_COMMON_H_ */

-- 
2.49.0



