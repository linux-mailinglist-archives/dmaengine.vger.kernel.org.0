Return-Path: <dmaengine+bounces-4760-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2194A6A9A8
	for <lists+dmaengine@lfdr.de>; Thu, 20 Mar 2025 16:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D9154841C4
	for <lists+dmaengine@lfdr.de>; Thu, 20 Mar 2025 15:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CE81DDC2B;
	Thu, 20 Mar 2025 15:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DMGOWAqY"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D28E14B08A;
	Thu, 20 Mar 2025 15:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742484164; cv=none; b=JimXHVzEmsDHYkejCkziTy1TWVlb6iln45G8ytFz1XT2nsaP4Xq+gXcuk3vaM9je+awR2kjE+CwIOVwn5UMZwHgkVo8RgbR6cBlrUbJ8jZztTxO8T5DVoOrWrcmHbAIzNawG87t8gYsaHbfMbTXi7fRN3Tg59JHX5u9V5X0PgqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742484164; c=relaxed/simple;
	bh=f25INGyCJY8UcVjC17OBdzMS7cvAdf0J4z2Qw+0j+UA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U3BXaLf87Dhge3o9aQmKD8ipZqyR66EzI95ufgtdVanhbJo1ZckHMmrjPLB6vM8vwpxPRnYrBtraNvsH867HnqKRvdEXrZgJdjh1hICUrmykItkPT6DhZEhMdpr4WNvQSmWNsywq6ijCdyYS97GC3BEC+oAsfavn0VxSAayLm+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DMGOWAqY; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742484162; x=1774020162;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f25INGyCJY8UcVjC17OBdzMS7cvAdf0J4z2Qw+0j+UA=;
  b=DMGOWAqYY9BxNd8sleLk/w6ri0INHzy6HfWZ2tm0bQzP6GtyTdom3Y0v
   RMS5zr0Tl5TOmQMKjt1ciadhhL+n+8DwHbFGxdOwDzv9RddxzqICAG04X
   GV3gySNMX0WwnG58jm7RsbyQcIEzzzM2ZIUIHdVrqQZgN8AaFPQSGzfOI
   FtGuZH0827FgPDE6agpgtZtv09rc3UpMcUvorXOUAMqYJRi+3Ev0AZsNd
   PmPog9RUtKq2UWyb6jlqK4zd8OJ0QfVz9CssgGtyRs5S76WHSvS8w2Hb0
   lGQX7b1GOzxEF7JzMhMU1jRbvpjJgGM8L2XTdu85KyAWYlc6MWIm89wH4
   g==;
X-CSE-ConnectionGUID: T/aS0PwqTh6v5Mmh1M9sHw==
X-CSE-MsgGUID: FA79GDeeQE+JwRv1tO3QXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="42970754"
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="42970754"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 08:22:40 -0700
X-CSE-ConnectionGUID: I6eL56F9Qk6L3GAx/LeXMg==
X-CSE-MsgGUID: 65mLGYXWSsq6P9hlHmr6sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="122852413"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO [10.125.110.123]) ([10.125.110.123])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 08:22:40 -0700
Message-ID: <1ca7b324-9de2-41b8-8c5a-a823c861c692@intel.com>
Date: Thu, 20 Mar 2025 08:22:39 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma/idxd: Remove __packed from structures
To: Yi Sun <yi.sun@intel.com>, anil.s.keshavamurthy@intel.com,
 vkoul@kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gordon.jin@intel.com, andriy.shevchenko@intel.com, yi.sun@linux.intel.com
References: <20250320081807.3688123-1-yi.sun@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250320081807.3688123-1-yi.sun@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/20/25 1:18 AM, Yi Sun wrote:
> The __packed attribute introduces potential unaligned memory accesses
> and endianness portability issues. Instead of relying on compiler-specific
> packing, it's much better to explicitly fill structure gaps using padding
> fields, ensuring natural alignment.
> 
> Since all previously __packed structures already enforce proper alignment
> through manual padding, the __packed qualifiers are unnecessary and can be
> safely removed.
> 
> Signed-off-by: Yi Sun <yi.sun@intel.com>

Although endian portability is probably not a concern given this driver is only for an Intel platform device.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
> index 006ba206ab1b..9c1c546fe443 100644
> --- a/drivers/dma/idxd/registers.h
> +++ b/drivers/dma/idxd/registers.h
> @@ -45,7 +45,7 @@ union gen_cap_reg {
>  		u64 rsvd3:32;
>  	};
>  	u64 bits;
> -} __packed;
> +};
>  #define IDXD_GENCAP_OFFSET		0x10
>  
>  union wq_cap_reg {
> @@ -65,7 +65,7 @@ union wq_cap_reg {
>  		u64 rsvd4:8;
>  	};
>  	u64 bits;
> -} __packed;
> +};
>  #define IDXD_WQCAP_OFFSET		0x20
>  #define IDXD_WQCFG_MIN			5
>  
> @@ -79,7 +79,7 @@ union group_cap_reg {
>  		u64 rsvd:45;
>  	};
>  	u64 bits;
> -} __packed;
> +};
>  #define IDXD_GRPCAP_OFFSET		0x30
>  
>  union engine_cap_reg {
> @@ -88,7 +88,7 @@ union engine_cap_reg {
>  		u64 rsvd:56;
>  	};
>  	u64 bits;
> -} __packed;
> +};
>  
>  #define IDXD_ENGCAP_OFFSET		0x38
>  
> @@ -114,7 +114,7 @@ union offsets_reg {
>  		u64 rsvd:48;
>  	};
>  	u64 bits[2];
> -} __packed;
> +};
>  
>  #define IDXD_TABLE_MULT			0x100
>  
> @@ -128,7 +128,7 @@ union gencfg_reg {
>  		u32 rsvd2:18;
>  	};
>  	u32 bits;
> -} __packed;
> +};
>  
>  #define IDXD_GENCTRL_OFFSET		0x88
>  union genctrl_reg {
> @@ -139,7 +139,7 @@ union genctrl_reg {
>  		u32 rsvd:29;
>  	};
>  	u32 bits;
> -} __packed;
> +};
>  
>  #define IDXD_GENSTATS_OFFSET		0x90
>  union gensts_reg {
> @@ -149,7 +149,7 @@ union gensts_reg {
>  		u32 rsvd:28;
>  	};
>  	u32 bits;
> -} __packed;
> +};
>  
>  enum idxd_device_status_state {
>  	IDXD_DEVICE_STATE_DISABLED = 0,
> @@ -183,7 +183,7 @@ union idxd_command_reg {
>  		u32 int_req:1;
>  	};
>  	u32 bits;
> -} __packed;
> +};
>  
>  enum idxd_cmd {
>  	IDXD_CMD_ENABLE_DEVICE = 1,
> @@ -213,7 +213,7 @@ union cmdsts_reg {
>  		u8 active:1;
>  	};
>  	u32 bits;
> -} __packed;
> +};
>  #define IDXD_CMDSTS_ACTIVE		0x80000000
>  #define IDXD_CMDSTS_ERR_MASK		0xff
>  #define IDXD_CMDSTS_RES_SHIFT		8
> @@ -284,7 +284,7 @@ union sw_err_reg {
>  		u64 rsvd5;
>  	};
>  	u64 bits[4];
> -} __packed;
> +};
>  
>  union iaa_cap_reg {
>  	struct {
> @@ -303,7 +303,7 @@ union iaa_cap_reg {
>  		u64 rsvd:52;
>  	};
>  	u64 bits;
> -} __packed;
> +};
>  
>  #define IDXD_IAACAP_OFFSET	0x180
>  
> @@ -320,7 +320,7 @@ union evlcfg_reg {
>  		u64 rsvd2:28;
>  	};
>  	u64 bits[2];
> -} __packed;
> +};
>  
>  #define IDXD_EVL_SIZE_MIN	0x0040
>  #define IDXD_EVL_SIZE_MAX	0xffff
> @@ -334,7 +334,7 @@ union msix_perm {
>  		u32 pasid:20;
>  	};
>  	u32 bits;
> -} __packed;
> +};
>  
>  union group_flags {
>  	struct {
> @@ -352,13 +352,13 @@ union group_flags {
>  		u64 rsvd5:26;
>  	};
>  	u64 bits;
> -} __packed;
> +};
>  
>  struct grpcfg {
>  	u64 wqs[4];
>  	u64 engines;
>  	union group_flags flags;
> -} __packed;
> +};
>  
>  union wqcfg {
>  	struct {
> @@ -410,7 +410,7 @@ union wqcfg {
>  		u64 op_config[4];
>  	};
>  	u32 bits[16];
> -} __packed;
> +};
>  
>  #define WQCFG_PASID_IDX                2
>  #define WQCFG_PRIVL_IDX		2
> @@ -474,7 +474,7 @@ union idxd_perfcap {
>  		u64 rsvd3:8;
>  	};
>  	u64 bits;
> -} __packed;
> +};
>  
>  #define IDXD_EVNTCAP_OFFSET		0x80
>  union idxd_evntcap {
> @@ -483,7 +483,7 @@ union idxd_evntcap {
>  		u64 rsvd:36;
>  	};
>  	u64 bits;
> -} __packed;
> +};
>  
>  struct idxd_event {
>  	union {
> @@ -493,7 +493,7 @@ struct idxd_event {
>  		};
>  		u32 val;
>  	};
> -} __packed;
> +};
>  
>  #define IDXD_CNTRCAP_OFFSET		0x800
>  struct idxd_cntrcap {
> @@ -506,7 +506,7 @@ struct idxd_cntrcap {
>  		u32 val;
>  	};
>  	struct idxd_event events[];
> -} __packed;
> +};
>  
>  #define IDXD_PERFRST_OFFSET		0x10
>  union idxd_perfrst {
> @@ -516,7 +516,7 @@ union idxd_perfrst {
>  		u32 rsvd:30;
>  	};
>  	u32 val;
> -} __packed;
> +};
>  
>  #define IDXD_OVFSTATUS_OFFSET		0x30
>  #define IDXD_PERFFRZ_OFFSET		0x20
> @@ -533,7 +533,7 @@ union idxd_cntrcfg {
>  		u64 rsvd3:4;
>  	};
>  	u64 val;
> -} __packed;
> +};
>  
>  #define IDXD_FLTCFG_OFFSET		0x300
>  
> @@ -543,7 +543,7 @@ union idxd_cntrdata {
>  		u64 event_count_value;
>  	};
>  	u64 val;
> -} __packed;
> +};
>  
>  union event_cfg {
>  	struct {
> @@ -551,7 +551,7 @@ union event_cfg {
>  		u64 event_enc:28;
>  	};
>  	u64 val;
> -} __packed;
> +};
>  
>  union filter_cfg {
>  	struct {
> @@ -562,7 +562,7 @@ union filter_cfg {
>  		u64 eng:8;
>  	};
>  	u64 val;
> -} __packed;
> +};
>  
>  #define IDXD_EVLSTATUS_OFFSET		0xf0
>  
> @@ -580,7 +580,7 @@ union evl_status_reg {
>  		u32 bits_upper32;
>  	};
>  	u64 bits;
> -} __packed;
> +};
>  
>  #define IDXD_MAX_BATCH_IDENT	256
>  
> @@ -620,17 +620,17 @@ struct __evl_entry {
>  	};
>  	u64 fault_addr;
>  	u64 rsvd5;
> -} __packed;
> +};
>  
>  struct dsa_evl_entry {
>  	struct __evl_entry e;
>  	struct dsa_completion_record cr;
> -} __packed;
> +};
>  
>  struct iax_evl_entry {
>  	struct __evl_entry e;
>  	u64 rsvd[4];
>  	struct iax_completion_record cr;
> -} __packed;
> +};
>  
>  #endif


