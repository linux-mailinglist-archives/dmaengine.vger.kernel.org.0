Return-Path: <dmaengine+bounces-5375-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1ECAD5BC0
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 18:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28D8D17B7BA
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 16:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04FB21018F;
	Wed, 11 Jun 2025 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBC0U1cn"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD9920E713;
	Wed, 11 Jun 2025 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749658528; cv=none; b=pu7AsAFMV375cxyVdkvQln8WaLNpNs5RsazLqtIBStz5cwJD6bHxOHrfaQsxDX380rhZ8Z5aO+DjHOS38caU/knN8GwGSjNEwoOWkZnh8SJxW+2i58JrE4Ddeawwv1b1A7yylXVejxH+kwryWg7tz1Iq/nGY637c4bd0rp781rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749658528; c=relaxed/simple;
	bh=W24IHKj+SlDNVJOCYhxMLrPfL4h+fsCaf5OkbSZrYPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GzaMfSBznhB9138GzK5wf6OqHEqanZz/h79o7903x3dR8lguARKWYBbyVcoNg6xQ7MlJiNYexJK6fU8XMHHzaz9ialQag78t1vVbvyxSZtfyY2/N6C0D6IUuO6AJ13BKMRHy/tykM3vtCVCoCvEANPOJSrGJBKg2ORGrFH6qUa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBC0U1cn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F3DBC4CEF1;
	Wed, 11 Jun 2025 16:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749658528;
	bh=W24IHKj+SlDNVJOCYhxMLrPfL4h+fsCaf5OkbSZrYPE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=aBC0U1cnZSV/tUpnp8s4uZID5pZ17rISamioIZK1ZXkqmgoCPtAcL/QFMQ4/W4BPK
	 71mBHV4591Wl8JNx+bEEO89SgQ277u2qsJNHHV568mBBUtFjp6TXB+Ye14iAaTFkEe
	 DeRPIsRykXd1RUdmXiTPgpo/zlVKczM26GOGJVJ3SYO1kR8xkTf/kcqI0B98LSss0C
	 jX84njUMzhM3TFTFRXgWBD6pWabCQKORC6354Mv69eVjNgMGDO9XH9fHJhyeu/PqkD
	 s0mxvPLHsaDE7aIRYcUaIhbAnc31TnznjkP75Kx174wsC55eFTKFzgjRtmWgYNBPJf
	 1PTOBn4HqcdXA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30346C71136;
	Wed, 11 Jun 2025 16:15:28 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 11 Jun 2025 17:15:36 +0100
Subject: [PATCH v7 4/7] include: adi-axi-common: add new helper macros
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250611-dev-axi-clkgen-limits-v7-4-3e7ff89dc366@analog.com>
References: <20250611-dev-axi-clkgen-limits-v7-0-3e7ff89dc366@analog.com>
In-Reply-To: <20250611-dev-axi-clkgen-limits-v7-0-3e7ff89dc366@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749658534; l=1982;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=8E3tnJOQHd1DGzVU+4oHkcTaB0uu72Nu8VTU/0TEplU=;
 b=Md983xgf8ErNqhqVFV+MJfO9rlfkbsqcF4S5/wsBswB3x7fzLWdoK50y9F3701UdBFP0ou8xf
 k3pikImOm52Cg8OWoU6oonHFTvAgglzP2ojINKZdgC68N/eqJrvZ8lC
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



