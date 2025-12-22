Return-Path: <dmaengine+bounces-7861-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B91CD4ECE
	for <lists+dmaengine@lfdr.de>; Mon, 22 Dec 2025 09:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2D023003481
	for <lists+dmaengine@lfdr.de>; Mon, 22 Dec 2025 08:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9828330BB80;
	Mon, 22 Dec 2025 08:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vrBW9MOY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RgPQDdTe"
X-Original-To: dmaengine@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE9A24E4C3;
	Mon, 22 Dec 2025 08:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766390679; cv=none; b=U/+ZVwmb0JOp41CBiTNRcN4xfIaToIxBG8zc5TT6nCkoaj18pXs6xyAjcu/Ln6XzRsUG1Hl/xBbe3AjBP+avksNNSvcXe7vkVTXBNGbG7LS3Xn+btoquhLvra0f+Jzu/gBKyxWbYlQXAWc/RS+VFgzHDSXO4Fu4uLYa0JaEy73A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766390679; c=relaxed/simple;
	bh=x89KSPKJrplWxLOPS+kqKtScxkmyFNwjKV81VUvuZ5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=beHTxo05D/LlPifLf7bDlqzN2kjw4sEEJGOtypd8B1tUruOj9AVO5cEY1zBP+7DzLkxjRiWAlHw3y8BWg7X5uWtevhG/PrKdfyZBOIqIt0Pe86B4hZD3UHqwB81MScFKsCx7jJiILJWabrwaTCkESXH9rmJro77qRFJSzoQ2FRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vrBW9MOY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RgPQDdTe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766390676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2YLjS1hsgnkUVHk9gHTBrp934onhDP17aX3BXfgb1Js=;
	b=vrBW9MOYUkRLxmfA6886sKP9tE/tnVmHCPAacERNtWpaRiQq9vG6pwp+uLR2gMDepqt44s
	8oKF1VKWtC4vTVJd0DwoEg27PPTRpzqtGmliTCPybEIAviAs/M6RB8cdlBifQZ3UruE/PP
	M4fvuZLiXXkO0CdMntDlnH0E/ninUxJTPHIWu55D2WQSdd7/h/Mk/aNxxsp/a5WpC8uwwq
	f7nwqB63AZ72gCXe9U9cY0YDwA5cWozi5X6Vvptv2kzbspz/EdOxaz5cj5Vbg1tVhCbYu0
	QtFbfSpB7IIgHHiHbz3anLAV0NY6iFvdGG5k+L7UZfUlmg2lbjCKlpXRI5t18w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766390676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2YLjS1hsgnkUVHk9gHTBrp934onhDP17aX3BXfgb1Js=;
	b=RgPQDdTee2kb/X5vn5WMrgkqfibrzxbDZ1AeDHSSZAJ1Ieksxl9jJjj9n0Z25IDb62rGo+
	+E2dPjYVbbiDT8Ag==
Date: Mon, 22 Dec 2025 09:04:13 +0100
Subject: [PATCH] dmaengine: idxd: uapi: use UAPI types
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251222-uapi-idxd-v1-1-baa183adb20d@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAHz7SGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDIyMj3dLEgkygWEWKroWhhaWZsVmasYFRmhJQfUFRalpmBdis6NjaWgA
 ZibD9WwAAAA==
X-Change-ID: 20251222-uapi-idxd-8189636f302f
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 Dave Jiang <dave.jiang@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766390675; l=9746;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=x89KSPKJrplWxLOPS+kqKtScxkmyFNwjKV81VUvuZ5E=;
 b=3C0YvvwlFvclhfiytWAmkq3/nVw4hAfjZY2xAAWtGCMdgtQOT+oYhORNvRoJx21/afSzhX3t+
 E62rzXEJ/TiAigOzAhjJTPYlGB2H9WyVbJH7DzYGe3GrrlrqH1TU0bi
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Using libc types and headers from the UAPI headers is problematic as it
introduces a dependency on a full C toolchain.

Use the fixed-width integer types provided by the UAPI headers instead.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/uapi/linux/idxd.h | 270 +++++++++++++++++++++++-----------------------
 1 file changed, 133 insertions(+), 137 deletions(-)

diff --git a/include/uapi/linux/idxd.h b/include/uapi/linux/idxd.h
index 3d1987e1bb2d..fdcc8eefb925 100644
--- a/include/uapi/linux/idxd.h
+++ b/include/uapi/linux/idxd.h
@@ -3,11 +3,7 @@
 #ifndef _USR_IDXD_H_
 #define _USR_IDXD_H_
 
-#ifdef __KERNEL__
 #include <linux/types.h>
-#else
-#include <stdint.h>
-#endif
 
 /* Driver command error status */
 enum idxd_scmd_stat {
@@ -176,132 +172,132 @@ enum iax_completion_status {
 #define DSA_COMP_STATUS(status)		((status) & DSA_COMP_STATUS_MASK)
 
 struct dsa_hw_desc {
-	uint32_t	pasid:20;
-	uint32_t	rsvd:11;
-	uint32_t	priv:1;
-	uint32_t	flags:24;
-	uint32_t	opcode:8;
-	uint64_t	completion_addr;
+	__u32	pasid:20;
+	__u32	rsvd:11;
+	__u32	priv:1;
+	__u32	flags:24;
+	__u32	opcode:8;
+	__u64	completion_addr;
 	union {
-		uint64_t	src_addr;
-		uint64_t	rdback_addr;
-		uint64_t	pattern;
-		uint64_t	desc_list_addr;
-		uint64_t	pattern_lower;
-		uint64_t	transl_fetch_addr;
+		__u64	src_addr;
+		__u64	rdback_addr;
+		__u64	pattern;
+		__u64	desc_list_addr;
+		__u64	pattern_lower;
+		__u64	transl_fetch_addr;
 	};
 	union {
-		uint64_t	dst_addr;
-		uint64_t	rdback_addr2;
-		uint64_t	src2_addr;
-		uint64_t	comp_pattern;
+		__u64	dst_addr;
+		__u64	rdback_addr2;
+		__u64	src2_addr;
+		__u64	comp_pattern;
 	};
 	union {
-		uint32_t	xfer_size;
-		uint32_t	desc_count;
-		uint32_t	region_size;
+		__u32	xfer_size;
+		__u32	desc_count;
+		__u32	region_size;
 	};
-	uint16_t	int_handle;
-	uint16_t	rsvd1;
+	__u16	int_handle;
+	__u16	rsvd1;
 	union {
-		uint8_t		expected_res;
+		__u8		expected_res;
 		/* create delta record */
 		struct {
-			uint64_t	delta_addr;
-			uint32_t	max_delta_size;
-			uint32_t 	delt_rsvd;
-			uint8_t 	expected_res_mask;
+			__u64	delta_addr;
+			__u32	max_delta_size;
+			__u32	delt_rsvd;
+			__u8	expected_res_mask;
 		};
-		uint32_t	delta_rec_size;
-		uint64_t	dest2;
+		__u32	delta_rec_size;
+		__u64	dest2;
 		/* CRC */
 		struct {
-			uint32_t	crc_seed;
-			uint32_t	crc_rsvd;
-			uint64_t	seed_addr;
+			__u32	crc_seed;
+			__u32	crc_rsvd;
+			__u64	seed_addr;
 		};
 		/* DIF check or strip */
 		struct {
-			uint8_t		src_dif_flags;
-			uint8_t		dif_chk_res;
-			uint8_t		dif_chk_flags;
-			uint8_t		dif_chk_res2[5];
-			uint32_t	chk_ref_tag_seed;
-			uint16_t	chk_app_tag_mask;
-			uint16_t	chk_app_tag_seed;
+			__u8	src_dif_flags;
+			__u8	dif_chk_res;
+			__u8	dif_chk_flags;
+			__u8	dif_chk_res2[5];
+			__u32	chk_ref_tag_seed;
+			__u16	chk_app_tag_mask;
+			__u16	chk_app_tag_seed;
 		};
 		/* DIF insert */
 		struct {
-			uint8_t		dif_ins_res;
-			uint8_t		dest_dif_flag;
-			uint8_t		dif_ins_flags;
-			uint8_t		dif_ins_res2[13];
-			uint32_t	ins_ref_tag_seed;
-			uint16_t	ins_app_tag_mask;
-			uint16_t	ins_app_tag_seed;
+			__u8	dif_ins_res;
+			__u8	dest_dif_flag;
+			__u8	dif_ins_flags;
+			__u8	dif_ins_res2[13];
+			__u32	ins_ref_tag_seed;
+			__u16	ins_app_tag_mask;
+			__u16	ins_app_tag_seed;
 		};
 		/* DIF update */
 		struct {
-			uint8_t		src_upd_flags;
-			uint8_t		upd_dest_flags;
-			uint8_t		dif_upd_flags;
-			uint8_t		dif_upd_res[5];
-			uint32_t	src_ref_tag_seed;
-			uint16_t	src_app_tag_mask;
-			uint16_t	src_app_tag_seed;
-			uint32_t	dest_ref_tag_seed;
-			uint16_t	dest_app_tag_mask;
-			uint16_t	dest_app_tag_seed;
+			__u8	src_upd_flags;
+			__u8	upd_dest_flags;
+			__u8	dif_upd_flags;
+			__u8	dif_upd_res[5];
+			__u32	src_ref_tag_seed;
+			__u16	src_app_tag_mask;
+			__u16	src_app_tag_seed;
+			__u32	dest_ref_tag_seed;
+			__u16	dest_app_tag_mask;
+			__u16	dest_app_tag_seed;
 		};
 
 		/* Fill */
-		uint64_t	pattern_upper;
+		__u64	pattern_upper;
 
 		/* Translation fetch */
 		struct {
-			uint64_t	transl_fetch_res;
-			uint32_t	region_stride;
+			__u64	transl_fetch_res;
+			__u32	region_stride;
 		};
 
 		/* DIX generate */
 		struct {
-			uint8_t		dix_gen_res;
-			uint8_t		dest_dif_flags;
-			uint8_t		dif_flags;
-			uint8_t		dix_gen_res2[13];
-			uint32_t	ref_tag_seed;
-			uint16_t	app_tag_mask;
-			uint16_t	app_tag_seed;
+			__u8	dix_gen_res;
+			__u8	dest_dif_flags;
+			__u8	dif_flags;
+			__u8	dix_gen_res2[13];
+			__u32	ref_tag_seed;
+			__u16	app_tag_mask;
+			__u16	app_tag_seed;
 		};
 
-		uint8_t		op_specific[24];
+		__u8		op_specific[24];
 	};
 } __attribute__((packed));
 
 struct iax_hw_desc {
-	uint32_t        pasid:20;
-	uint32_t        rsvd:11;
-	uint32_t        priv:1;
-	uint32_t        flags:24;
-	uint32_t        opcode:8;
-	uint64_t        completion_addr;
-	uint64_t        src1_addr;
-	uint64_t        dst_addr;
-	uint32_t        src1_size;
-	uint16_t        int_handle;
+	__u32        pasid:20;
+	__u32        rsvd:11;
+	__u32        priv:1;
+	__u32        flags:24;
+	__u32        opcode:8;
+	__u64        completion_addr;
+	__u64        src1_addr;
+	__u64        dst_addr;
+	__u32        src1_size;
+	__u16        int_handle;
 	union {
-		uint16_t        compr_flags;
-		uint16_t        decompr_flags;
+		__u16        compr_flags;
+		__u16        decompr_flags;
 	};
-	uint64_t        src2_addr;
-	uint32_t        max_dst_size;
-	uint32_t        src2_size;
-	uint32_t	filter_flags;
-	uint32_t	num_inputs;
+	__u64	src2_addr;
+	__u32	max_dst_size;
+	__u32	src2_size;
+	__u32	filter_flags;
+	__u32	num_inputs;
 } __attribute__((packed));
 
 struct dsa_raw_desc {
-	uint64_t	field[8];
+	__u64	field[8];
 } __attribute__((packed));
 
 /*
@@ -309,91 +305,91 @@ struct dsa_raw_desc {
  * volatile and prevent the compiler from optimize the read.
  */
 struct dsa_completion_record {
-	volatile uint8_t	status;
+	volatile __u8	status;
 	union {
-		uint8_t		result;
-		uint8_t		dif_status;
+		__u8		result;
+		__u8		dif_status;
 	};
-	uint8_t			fault_info;
-	uint8_t			rsvd;
+	__u8			fault_info;
+	__u8			rsvd;
 	union {
-		uint32_t		bytes_completed;
-		uint32_t		descs_completed;
+		__u32		bytes_completed;
+		__u32		descs_completed;
 	};
-	uint64_t		fault_addr;
+	__u64		fault_addr;
 	union {
 		/* common record */
 		struct {
-			uint32_t	invalid_flags:24;
-			uint32_t	rsvd2:8;
+			__u32	invalid_flags:24;
+			__u32	rsvd2:8;
 		};
 
-		uint32_t	delta_rec_size;
-		uint64_t	crc_val;
+		__u32	delta_rec_size;
+		__u64	crc_val;
 
 		/* DIF check & strip */
 		struct {
-			uint32_t	dif_chk_ref_tag;
-			uint16_t	dif_chk_app_tag_mask;
-			uint16_t	dif_chk_app_tag;
+			__u32	dif_chk_ref_tag;
+			__u16	dif_chk_app_tag_mask;
+			__u16	dif_chk_app_tag;
 		};
 
 		/* DIF insert */
 		struct {
-			uint64_t	dif_ins_res;
-			uint32_t	dif_ins_ref_tag;
-			uint16_t	dif_ins_app_tag_mask;
-			uint16_t	dif_ins_app_tag;
+			__u64	dif_ins_res;
+			__u32	dif_ins_ref_tag;
+			__u16	dif_ins_app_tag_mask;
+			__u16	dif_ins_app_tag;
 		};
 
 		/* DIF update */
 		struct {
-			uint32_t	dif_upd_src_ref_tag;
-			uint16_t	dif_upd_src_app_tag_mask;
-			uint16_t	dif_upd_src_app_tag;
-			uint32_t	dif_upd_dest_ref_tag;
-			uint16_t	dif_upd_dest_app_tag_mask;
-			uint16_t	dif_upd_dest_app_tag;
+			__u32	dif_upd_src_ref_tag;
+			__u16	dif_upd_src_app_tag_mask;
+			__u16	dif_upd_src_app_tag;
+			__u32	dif_upd_dest_ref_tag;
+			__u16	dif_upd_dest_app_tag_mask;
+			__u16	dif_upd_dest_app_tag;
 		};
 
 		/* DIX generate */
 		struct {
-			uint64_t	dix_gen_res;
-			uint32_t	dix_ref_tag;
-			uint16_t	dix_app_tag_mask;
-			uint16_t	dix_app_tag;
+			__u64	dix_gen_res;
+			__u32	dix_ref_tag;
+			__u16	dix_app_tag_mask;
+			__u16	dix_app_tag;
 		};
 
-		uint8_t		op_specific[16];
+		__u8		op_specific[16];
 	};
 } __attribute__((packed));
 
 struct dsa_raw_completion_record {
-	uint64_t	field[4];
+	__u64	field[4];
 } __attribute__((packed));
 
 struct iax_completion_record {
-	volatile uint8_t        status;
-	uint8_t                 error_code;
-	uint8_t			fault_info;
-	uint8_t			rsvd;
-	uint32_t                bytes_completed;
-	uint64_t                fault_addr;
-	uint32_t                invalid_flags;
-	uint32_t                rsvd2;
-	uint32_t                output_size;
-	uint8_t                 output_bits;
-	uint8_t                 rsvd3;
-	uint16_t                xor_csum;
-	uint32_t                crc;
-	uint32_t                min;
-	uint32_t                max;
-	uint32_t                sum;
-	uint64_t                rsvd4[2];
+	volatile __u8        status;
+	__u8                 error_code;
+	__u8		     fault_info;
+	__u8		     rsvd;
+	__u32                bytes_completed;
+	__u64                fault_addr;
+	__u32                invalid_flags;
+	__u32                rsvd2;
+	__u32                output_size;
+	__u8                 output_bits;
+	__u8                 rsvd3;
+	__u16                xor_csum;
+	__u32                crc;
+	__u32                min;
+	__u32                max;
+	__u32                sum;
+	__u64                rsvd4[2];
 } __attribute__((packed));
 
 struct iax_raw_completion_record {
-	uint64_t	field[8];
+	__u64	field[8];
 } __attribute__((packed));
 
 #endif

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251222-uapi-idxd-8189636f302f

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


