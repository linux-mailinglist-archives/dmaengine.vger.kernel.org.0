Return-Path: <dmaengine+bounces-9157-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0F7UOKeSo2nBHAUAu9opvQ
	(envelope-from <dmaengine+bounces-9157-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 01 Mar 2026 02:13:11 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEF41C9F58
	for <lists+dmaengine@lfdr.de>; Sun, 01 Mar 2026 02:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F176303828D
	for <lists+dmaengine@lfdr.de>; Sun,  1 Mar 2026 01:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2755E222565;
	Sun,  1 Mar 2026 01:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nIuYTkXU"
X-Original-To: dmaengine@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA4221B9F6;
	Sun,  1 Mar 2026 01:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772327537; cv=none; b=B78f94kOVZ2CX7LcpfsLLO+c9uGjPit8il5v9Xc7mu0h1UdtPLwYcNMp6ipZcDMo4YL6qGQhVN1b3DBlSTwa2QiRayqvCdXt+mEO3tI8cahHHqJWvAtByAL1FrCMZazQCtO6XAHD2mDchjMU5zXxeLjTvcgdES9nm03zSAPwaXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772327537; c=relaxed/simple;
	bh=Ug/ILt32CfRF20W9Sps4omJ146tewhJYsmx1lVngcUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y+L/KSRgCToMZGooUUJm0tp5chYJVBCOpQW4oRM6hTNgmjKyJJO1BAv2gqGY8RL3cad8etLx59HKabBhuTy4Qm245J6l6safbeJWe2lAW+fY55lnPJCL8dl8bFDLu3RvyasovAG29B0EflO5P86XCIxJPSw60jmv9mupg8mMKVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nIuYTkXU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=qHLFjO29SIljGIO7gb0cbMSuo+aXtIXzRfvGbT2aoTc=; b=nIuYTkXU4tYbNZQYQMd5i4NIO0
	eXT+BZbftJJpfaNIwcffrUxL5aR+DGj0gzLJ/JbfaT2o1YtjEW5QHOSLGl2ux8e/NzNggNNx+H4UT
	5ocBnhDGOTofMGpNrGbUC8xz0nWJRlLC8f8+avfoZhUq4Q3mkKqWk96rRRLGbKz6o2Sp+bWzW78RV
	VFWX1Sf1nt1WNOwbeVDCuAtjGSsKQw0xqoew+9ZsTQOXbtWHxnI37bC3v7gE2+9iam2DVfPVfVQja
	ToAHgstdWdiIUnx8YhH1ojgSNsQOJrzJU4CD3F3mSOM5gsphyIzgnCWQt7hkNRtx9GUWk3TwzvGRx
	rOZaCzLw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwVLx-0000000ARSP-3Wfi;
	Sun, 01 Mar 2026 01:12:13 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org
Subject: [PATCH] dmaengine: ti-cppi5: fix all kernel-doc warnings
Date: Sat, 28 Feb 2026 17:12:13 -0800
Message-ID: <20260301011213.3063688-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,gmail.com,kernel.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9157-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4AEF41C9F58
X-Rspamd-Action: no action

Add missing struct member, function parameter, and enum value descriptions.
Add missing function Returns: sections.
Use correct function name in kernel-doc to avoid mismatched prototypes.

These repair all kernel-doc warnings in ti-cppi5.h:

Warning: include/linux/dma/ti-cppi5.h:27 struct member 'pkt_info1' not
 described in 'cppi5_desc_hdr_t'
Warning: include/linux/dma/ti-cppi5.h:27 struct member 'pkt_info2' not
 described in 'cppi5_desc_hdr_t'
Warning: include/linux/dma/ti-cppi5.h:50 struct member 'epib' not
 described in 'cppi5_host_desc_t'
Warning: include/linux/dma/ti-cppi5.h:142 struct member 'epib' not
 described in 'cppi5_monolithic_desc_t'
Warning: include/linux/dma/ti-cppi5.h:413 function parameter 'pkt_len'
 not described in 'cppi5_hdesc_set_pktlen'
Warning: include/linux/dma/ti-cppi5.h:436 function parameter 'ps_flags'
 not described in 'cppi5_hdesc_set_psflags'
Warning: include/linux/dma/ti-cppi5.h:509 function parameter 'hbuf_desc'
 not described in 'cppi5_hdesc_link_hbdesc'
Warning: include/linux/dma/ti-cppi5.h:839 struct member 'dicnt3' not
 described in 'cppi5_tr_type15_t'
Warning: include/linux/dma/ti-cppi5.h:970 function parameter 'desc_hdr'
 not described in 'cppi5_trdesc_init'
Warning: include/linux/dma/ti-cppi5.h:184 No description found for
 return value of 'cppi5_desc_is_tdcm'
Warning: include/linux/dma/ti-cppi5.h:198 No description found for
 return value of 'cppi5_desc_get_type'
Warning: include/linux/dma/ti-cppi5.h:210 No description found for
 return value of 'cppi5_desc_get_errflags'
Warning: include/linux/dma/ti-cppi5.h:448 expecting prototype for
 cppi5_hdesc_get_errflags(). Prototype was for cppi5_hdesc_get_pkttype()
 instead
Warning: include/linux/dma/ti-cppi5.h:460 expecting prototype for
 cppi5_hdesc_get_errflags(). Prototype was for cppi5_hdesc_set_pkttype()
 instead
Warning: include/linux/dma/ti-cppi5.h:1053 expecting prototype for
 cppi5_tr_cflag_set(). Prototype was for cppi5_tr_csf_set() instead
Warning: include/linux/dma/ti-cppi5.h:651 Enum value 'CPPI5_TR_TYPE_MAX'
 not described in enum 'cppi5_tr_types'
Warning: include/linux/dma/ti-cppi5.h:676 Enum value
 'CPPI5_TR_EVENT_SIZE_MAX' not described in enum 'cppi5_tr_event_size'
Warning: include/linux/dma/ti-cppi5.h:693 Enum value 'CPPI5_TR_TRIGGER_MAX'
 not described in enum 'cppi5_tr_trigger'
Warning: include/linux/dma/ti-cppi5.h:714 Enum value
 'CPPI5_TR_TRIGGER_TYPE_MAX' not described in enum 'cppi5_tr_trigger_type'
Warning: include/linux/dma/ti-cppi5.h:890 Enum value
 'CPPI5_TR_RESPONSE_STATUS_MAX' not described in enum
 'cppi5_tr_resp_status_type'
Warning: include/linux/dma/ti-cppi5.h:906 Enum value
 'CPPI5_TR_RESPONSE_STATUS_SUBMISSION_MAX' not described in enum
 'cppi5_tr_resp_status_submission'
Warning: include/linux/dma/ti-cppi5.h:934 Enum value
 'CPPI5_TR_RESPONSE_STATUS_UNSUPPORTED_MAX' not described in enum
 'cppi5_tr_resp_status_unsupported'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>
Cc: dmaengine@vger.kernel.org

 include/linux/dma/ti-cppi5.h |   53 ++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 20 deletions(-)

--- linux-next-20260227.orig/include/linux/dma/ti-cppi5.h
+++ linux-next-20260227/include/linux/dma/ti-cppi5.h
@@ -16,8 +16,8 @@
  * struct cppi5_desc_hdr_t - Descriptor header, present in all types of
  *			     descriptors
  * @pkt_info0:		Packet info word 0 (n/a in Buffer desc)
- * @pkt_info0:		Packet info word 1 (n/a in Buffer desc)
- * @pkt_info0:		Packet info word 2 (n/a in Buffer desc)
+ * @pkt_info1:		Packet info word 1 (n/a in Buffer desc)
+ * @pkt_info2:		Packet info word 2 (n/a in Buffer desc)
  * @src_dst_tag:	Packet info word 3 (n/a in Buffer desc)
  */
 struct cppi5_desc_hdr_t {
@@ -35,7 +35,7 @@ struct cppi5_desc_hdr_t {
  * @buf_info1:		word 8: Buffer valid data length
  * @org_buf_len:	word 9: Original buffer length
  * @org_buf_ptr:	word 10/11: Original buffer pointer
- * @epib[0]:		Extended Packet Info Data (optional, 4 words), and/or
+ * @epib:		Extended Packet Info Data (optional, 4 words), and/or
  *			Protocol Specific Data (optional, 0-128 bytes in
  *			multiples of 4), and/or
  *			Other Software Data (0-N bytes, optional)
@@ -132,7 +132,7 @@ struct cppi5_desc_epib_t {
 /**
  * struct cppi5_monolithic_desc_t - Monolithic-mode packet descriptor
  * @hdr:		Descriptor header
- * @epib[0]:		Extended Packet Info Data (optional, 4 words), and/or
+ * @epib:		Extended Packet Info Data (optional, 4 words), and/or
  *			Protocol Specific Data (optional, 0-128 bytes in
  *			multiples of 4), and/or
  *			Other Software Data (0-N bytes, optional)
@@ -179,7 +179,7 @@ static inline void cppi5_desc_dump(void
  * cppi5_desc_is_tdcm - check if the paddr indicates Teardown Complete Message
  * @paddr: Physical address of the packet popped from the ring
  *
- * Returns true if the address indicates TDCM
+ * Returns: true if the address indicates TDCM
  */
 static inline bool cppi5_desc_is_tdcm(dma_addr_t paddr)
 {
@@ -190,7 +190,7 @@ static inline bool cppi5_desc_is_tdcm(dm
  * cppi5_desc_get_type - get descriptor type
  * @desc_hdr: packet descriptor/TR header
  *
- * Returns descriptor type:
+ * Returns: descriptor type:
  * CPPI5_INFO0_DESC_TYPE_VAL_HOST
  * CPPI5_INFO0_DESC_TYPE_VAL_MONO
  * CPPI5_INFO0_DESC_TYPE_VAL_TR
@@ -205,7 +205,7 @@ static inline u32 cppi5_desc_get_type(st
  * cppi5_desc_get_errflags - get Error Flags from Desc
  * @desc_hdr: packet/TR descriptor header
  *
- * Returns Error Flags from Packet/TR Descriptor
+ * Returns: Error Flags from Packet/TR Descriptor
  */
 static inline u32 cppi5_desc_get_errflags(struct cppi5_desc_hdr_t *desc_hdr)
 {
@@ -307,7 +307,7 @@ static inline void cppi5_desc_set_tags_i
  * @psdata_size: PSDATA size
  * @sw_data_size: SWDATA size
  *
- * Returns required Host Packet Descriptor size
+ * Returns: required Host Packet Descriptor size
  * 0 - if PSDATA > CPPI5_INFO0_HDESC_PSDATA_MAX_SIZE
  */
 static inline u32 cppi5_hdesc_calc_size(bool epib, u32 psdata_size,
@@ -381,6 +381,8 @@ cppi5_hdesc_update_psdata_size(struct cp
 /**
  * cppi5_hdesc_get_psdata_size - get PSdata size in bytes
  * @desc: Host packet descriptor
+ *
+ * Returns: PSdata size in bytes
  */
 static inline u32 cppi5_hdesc_get_psdata_size(struct cppi5_host_desc_t *desc)
 {
@@ -398,7 +400,7 @@ static inline u32 cppi5_hdesc_get_psdata
  * cppi5_hdesc_get_pktlen - get Packet Length from HDesc
  * @desc: Host packet descriptor
  *
- * Returns Packet Length from Host Packet Descriptor
+ * Returns: Packet Length from Host Packet Descriptor
  */
 static inline u32 cppi5_hdesc_get_pktlen(struct cppi5_host_desc_t *desc)
 {
@@ -408,6 +410,7 @@ static inline u32 cppi5_hdesc_get_pktlen
 /**
  * cppi5_hdesc_set_pktlen - set Packet Length in HDesc
  * @desc: Host packet descriptor
+ * @pkt_len: Packet length to set
  */
 static inline void cppi5_hdesc_set_pktlen(struct cppi5_host_desc_t *desc,
 					  u32 pkt_len)
@@ -420,7 +423,7 @@ static inline void cppi5_hdesc_set_pktle
  * cppi5_hdesc_get_psflags - get Protocol Specific Flags from HDesc
  * @desc: Host packet descriptor
  *
- * Returns Protocol Specific Flags from Host Packet Descriptor
+ * Returns: Protocol Specific Flags from Host Packet Descriptor
  */
 static inline u32 cppi5_hdesc_get_psflags(struct cppi5_host_desc_t *desc)
 {
@@ -431,6 +434,7 @@ static inline u32 cppi5_hdesc_get_psflag
 /**
  * cppi5_hdesc_set_psflags - set Protocol Specific Flags in HDesc
  * @desc: Host packet descriptor
+ * @ps_flags: Protocol Specific flags to set
  */
 static inline void cppi5_hdesc_set_psflags(struct cppi5_host_desc_t *desc,
 					   u32 ps_flags)
@@ -442,8 +446,10 @@ static inline void cppi5_hdesc_set_psfla
 }
 
 /**
- * cppi5_hdesc_get_errflags - get Packet Type from HDesc
+ * cppi5_hdesc_get_pkttype - get Packet Type from HDesc
  * @desc: Host packet descriptor
+ *
+ * Returns: Packet type
  */
 static inline u32 cppi5_hdesc_get_pkttype(struct cppi5_host_desc_t *desc)
 {
@@ -452,7 +458,7 @@ static inline u32 cppi5_hdesc_get_pkttyp
 }
 
 /**
- * cppi5_hdesc_get_errflags - set Packet Type in HDesc
+ * cppi5_hdesc_set_pkttype - set Packet Type in HDesc
  * @desc: Host packet descriptor
  * @pkt_type: Packet Type
  */
@@ -501,7 +507,7 @@ static inline void cppi5_hdesc_reset_to_
 /**
  * cppi5_hdesc_link_hbdesc - link Host Buffer Descriptor to HDesc
  * @desc: Host Packet Descriptor
- * @buf_desc: Host Buffer Descriptor physical address
+ * @hbuf_desc: Host Buffer Descriptor physical address
  *
  * add and link Host Buffer Descriptor to HDesc
  */
@@ -527,7 +533,7 @@ static inline void cppi5_hdesc_reset_hbd
  * cppi5_hdesc_epib_present -  check if EPIB present
  * @desc_hdr: packet descriptor/TR header
  *
- * Returns true if EPIB present in the packet
+ * Returns: true if EPIB present in the packet
  */
 static inline bool cppi5_hdesc_epib_present(struct cppi5_desc_hdr_t *desc_hdr)
 {
@@ -538,7 +544,7 @@ static inline bool cppi5_hdesc_epib_pres
  * cppi5_hdesc_get_psdata -  Get pointer on PSDATA
  * @desc: Host packet descriptor
  *
- * Returns pointer on PSDATA in HDesc.
+ * Returns: pointer on PSDATA in HDesc.
  * NULL - if ps_data placed at the start of data buffer.
  */
 static inline void *cppi5_hdesc_get_psdata(struct cppi5_host_desc_t *desc)
@@ -568,7 +574,7 @@ static inline void *cppi5_hdesc_get_psda
  * cppi5_hdesc_get_swdata -  Get pointer on swdata
  * @desc: Host packet descriptor
  *
- * Returns pointer on SWDATA in HDesc.
+ * Returns: pointer on SWDATA in HDesc.
  * NOTE. It's caller responsibility to be sure hdesc actually has swdata.
  */
 static inline void *cppi5_hdesc_get_swdata(struct cppi5_host_desc_t *desc)
@@ -648,6 +654,7 @@ enum cppi5_tr_types {
 	CPPI5_TR_TYPE11,
 	/* type12-14: Reserved */
 	CPPI5_TR_TYPE15 = 15,
+	/* private: */
 	CPPI5_TR_TYPE_MAX
 };
 
@@ -673,6 +680,7 @@ enum cppi5_tr_event_size {
 	CPPI5_TR_EVENT_SIZE_ICNT1_DEC,
 	CPPI5_TR_EVENT_SIZE_ICNT2_DEC,
 	CPPI5_TR_EVENT_SIZE_ICNT3_DEC,
+	/* private: */
 	CPPI5_TR_EVENT_SIZE_MAX
 };
 
@@ -690,6 +698,7 @@ enum cppi5_tr_trigger {
 	CPPI5_TR_TRIGGER_GLOBAL0,
 	CPPI5_TR_TRIGGER_GLOBAL1,
 	CPPI5_TR_TRIGGER_LOCAL_EVENT,
+	/* private: */
 	CPPI5_TR_TRIGGER_MAX
 };
 
@@ -711,6 +720,7 @@ enum cppi5_tr_trigger_type {
 	CPPI5_TR_TRIGGER_TYPE_ICNT2_DEC,
 	CPPI5_TR_TRIGGER_TYPE_ICNT3_DEC,
 	CPPI5_TR_TRIGGER_TYPE_ALL,
+	/* private: */
 	CPPI5_TR_TRIGGER_TYPE_MAX
 };
 
@@ -815,7 +825,7 @@ struct cppi5_tr_type3_t {
  *			destination
  * @dicnt1:		Total loop iteration count for level 1 for destination
  * @dicnt2:		Total loop iteration count for level 2 for destination
- * @sicnt3:		Total loop iteration count for level 3 (outermost) for
+ * @dicnt3:		Total loop iteration count for level 3 (outermost) for
  *			destination
  */
 struct cppi5_tr_type15_t {
@@ -887,6 +897,7 @@ enum cppi5_tr_resp_status_type {
 	CPPI5_TR_RESPONSE_STATUS_UNSUPPORTED_ERR,
 	CPPI5_TR_RESPONSE_STATUS_TRANSFER_EXCEPTION,
 	CPPI5_TR_RESPONSE_STATUS__TEARDOWN_FLUSH,
+	/* private: */
 	CPPI5_TR_RESPONSE_STATUS_MAX
 };
 
@@ -903,6 +914,7 @@ enum cppi5_tr_resp_status_submission {
 	CPPI5_TR_RESPONSE_STATUS_SUBMISSION_ICNT0,
 	CPPI5_TR_RESPONSE_STATUS_SUBMISSION_FIFO_FULL,
 	CPPI5_TR_RESPONSE_STATUS_SUBMISSION_OWN,
+	/* private: */
 	CPPI5_TR_RESPONSE_STATUS_SUBMISSION_MAX
 };
 
@@ -931,6 +943,7 @@ enum cppi5_tr_resp_status_unsupported {
 	CPPI5_TR_RESPONSE_STATUS_UNSUPPORTED_DFMT,
 	CPPI5_TR_RESPONSE_STATUS_UNSUPPORTED_SECTR,
 	CPPI5_TR_RESPONSE_STATUS_UNSUPPORTED_AMODE_SPECIFIC,
+	/* private: */
 	CPPI5_TR_RESPONSE_STATUS_UNSUPPORTED_MAX
 };
 
@@ -939,7 +952,7 @@ enum cppi5_tr_resp_status_unsupported {
  * @tr_count: number of TR records
  * @tr_size: Nominal size of TR record (max) [16, 32, 64, 128]
  *
- * Returns required TR Descriptor size
+ * Returns: required TR Descriptor size
  */
 static inline size_t cppi5_trdesc_calc_size(u32 tr_count, u32 tr_size)
 {
@@ -955,7 +968,7 @@ static inline size_t cppi5_trdesc_calc_s
 
 /**
  * cppi5_trdesc_init - Init TR Descriptor
- * @desc: TR Descriptor
+ * @desc_hdr: TR Descriptor
  * @tr_count: number of TR records
  * @tr_size: Nominal size of TR record (max) [16, 32, 64, 128]
  * @reload_idx: Absolute index to jump to on the 2nd and following passes
@@ -1044,7 +1057,7 @@ static inline void cppi5_tr_set_trigger(
 }
 
 /**
- * cppi5_tr_cflag_set - Update the Configuration specific flags
+ * cppi5_tr_csf_set - Update the Configuration specific flags
  * @flags: Pointer to the TR's flags
  * @csf: Configuration specific flags
  *

