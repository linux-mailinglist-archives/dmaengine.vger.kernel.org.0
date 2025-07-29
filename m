Return-Path: <dmaengine+bounces-5879-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 997BCB146B2
	for <lists+dmaengine@lfdr.de>; Tue, 29 Jul 2025 05:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDFBC1AA05F4
	for <lists+dmaengine@lfdr.de>; Tue, 29 Jul 2025 03:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6235E19E97A;
	Tue, 29 Jul 2025 03:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G6VxoChu"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FE52260C;
	Tue, 29 Jul 2025 03:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753758974; cv=fail; b=gyFmZHh155Jgn/Q/2HSiF3L3GEf8eVWgV9Ehr4BiXeXoXRSjJ2nC+CGnOejICqfboD6vFjVyxj2LHwC3FYZTO0WQxTtbp/yOGzWsG3hpcp5DJ9NhSXz7+T5pdHixR3nLg/zXV8f2b39a+BsP3xg1xnXsR6NKKAteYbVxS9EsfX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753758974; c=relaxed/simple;
	bh=jLm3i3bNpI5hyq72MXm+cu63hGNNzNA6MarWO/uf+qE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GhMnu65Fys8BgBJU3a+4dXp3MmXuf3JfH8JoXkBbPzb9vduWVe4bJPY9qq7958LFgaxtlOooWYWRdv/zGn+TNO/DTOmU7W4ehbdIp9SQ+P2wu27qoq7Al0FGJb5v6ZW+qEnJIPneyed6Nl8p/6IYTEnNt8Szt6Pt420taO3qVhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G6VxoChu; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753758971; x=1785294971;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=jLm3i3bNpI5hyq72MXm+cu63hGNNzNA6MarWO/uf+qE=;
  b=G6VxoChukk8Hw40qnl3Jbc0wwtVn7ME63hdCPOCi30RNfDbv7G5/BQLG
   XWyaD8o0RXIaEkNMcJlHjhNNgU9rMx3sR/lBLxRWJzl9Ktff2TirvNiHt
   FiNLHMihdKhdy+LpzRklyPfoJ0tbamQ+3gaqSfz02CljFWAZMIHGEmwHz
   wldcvrHhFSVBgG7xwY8Yee/syl4zo7YB6SLOsltlYxKGilRHR54DJwVi/
   ov3XnnMi+aOv0qlL+tWWGCFuRtc9u+1j5WOHBKf3TVrn2N2ufKNdL5IyQ
   Ax+U6rEA5EHFQC2SSK8z2Q2hWBW1Bw1gg5xiOL/dLgx7WTBFpRB1ErFGj
   A==;
X-CSE-ConnectionGUID: GlxNN1jPQ+eA9gBl6pe46Q==
X-CSE-MsgGUID: NKI7ibLnRoKXheONeLTTTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="55956446"
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; 
   d="scan'208";a="55956446"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 20:16:10 -0700
X-CSE-ConnectionGUID: /KgjiYfOSliKLfpI23xoPw==
X-CSE-MsgGUID: /m74SuxwSRC+lilly9/E4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; 
   d="scan'208";a="162930765"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 20:16:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 20:16:09 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 28 Jul 2025 20:16:09 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.42) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 28 Jul 2025 20:16:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=txnsNbXFkBh9zB2kCVqgoV2u0F7Dofy1G/xD622Vfrtm2oPEFKPd2Fb8H8jGRbZH4C78AlsdK0UwrR6ExWsyfz7dM04+fyN+3XanXqB4AexiUNkd95zk7YGkub78QZJT1SlpR8h2HXf25iEw9GXM37F/PdnKK6NH1SaUUKZjblReJ78lcGT6oLktRUXRh+dL8otFEIPWOCZbXzb51xmHZZYe/72DEgo09xnIbLcfJJBGKsKLaOZksoxP5VWh5PlGl1cpcBMXvoDbDDLjR4pJNzkHLvmb5xFGvYPkltpUtuqcYtC3K78ffarOHJ6QgCR+oiRlEkO0UowapFszGQptew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBB4j9lXg1Ol5vrw1WOXaWfpWfKUuBIvvjpISf0F1Dc=;
 b=uIRxXvDxuWDnGRXjJzfj2Veu/o6hFiJocS2+Tp2YGIcyJ+99AD9qkYWYLg823+SC8Az1jgQNF7HTgYlYIcYnjZTZySpL5Ho7PcKubz5o85rP+Z6OOuqwA9jdEqZorV7+o/6dhbh9hjOsc6VNb1Dp8zv4Pq0gjRyg3+sGjDX0DWKLFaQ1BcM1P4cCl2CdyVrGFn9Y+Rez6mOfLzhleHaOZeupWi+hBUxoAIK2MRC4yNtGfkq+nxCoEFC8NsuGYKSNlq7S9OMqQo/TG7ik4LEsmHLh9t/Fe1+lR7WaS00trKisSAZEsoRRtlDrrrvoIQjmhoGm+/VKZMYv19G09OKyMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6363.namprd11.prod.outlook.com (2603:10b6:208:3b6::5)
 by SN7PR11MB7601.namprd11.prod.outlook.com (2603:10b6:806:34a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Tue, 29 Jul
 2025 03:16:06 +0000
Received: from BL3PR11MB6363.namprd11.prod.outlook.com
 ([fe80::6206:bcb:fd57:6467]) by BL3PR11MB6363.namprd11.prod.outlook.com
 ([fe80::6206:bcb:fd57:6467%6]) with mapi id 15.20.8964.026; Tue, 29 Jul 2025
 03:16:06 +0000
Date: Tue, 29 Jul 2025 11:15:57 +0800
From: Yi Sun <yi.sun@intel.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
CC: Fenghua Yu <fenghuay@nvidia.com>, <vinicius.gomes@intel.com>,
	<dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dave.jiang@intel.com>, <gordon.jin@intel.com>
Subject: Re: [PATCH v3 2/2] dmaengine: idxd: Fix refcount underflow on module
 unload
Message-ID: <aIg87RSWc8-KbQ4v@ysun46-mobl.ccr.corp.intel.com>
References: <20250617102712.727333-1-yi.sun@intel.com>
 <20250617102712.727333-3-yi.sun@intel.com>
 <39398407-009e-4afe-acb6-e3de931627d7@nvidia.com>
 <aIXuYVtGSV0OHHps@ysun46-mobl.ccr.corp.intel.com>
 <316cd6b2-3519-4353-8c53-06997096b216@linux.alibaba.com>
 <aIdiTlIU03stIdqe@ysun46-mobl.ccr.corp.intel.com>
 <2ee448d2-76b2-446c-9368-8b90ec087419@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ee448d2-76b2-446c-9368-8b90ec087419@linux.alibaba.com>
X-ClientProxiedBy: SGXP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::16)
 To BL3PR11MB6363.namprd11.prod.outlook.com (2603:10b6:208:3b6::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6363:EE_|SN7PR11MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: e33dbecf-dc35-4d6b-8c1a-08ddce4e41df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGVCMGNha29mNkhPTEdHd002dkYwVkFsRnhKUVJIZ1NLbGZ5cmFMbTIvRlRN?=
 =?utf-8?B?TnBWVGxrWXFzZ0JZeHBvMnNVRjNJSzhtdzJjM1ZCellmTTJXU3d0WlRYcm1v?=
 =?utf-8?B?VThwNWFOazRJbjhobkhhc3cwREs0N0N5U1NKRm42UTJtR29aZTRkblAzSCto?=
 =?utf-8?B?eDdBZ2trbGJZQXVDMERKcVAxTUlWV3hFczJ2UE1JZTNLMVUwTWVzN2xJc2Fo?=
 =?utf-8?B?T3pUM0ovT012OHpSdzVIQ3N4VGYzZWJwUm1SbW9BUGp4UnlzNXBBaCtQcS8x?=
 =?utf-8?B?Z2Fpb1BJc1NvRUdJcGxsbitPeklRNXE5R09RUzJOc0ZNU0RKSHQrV1U3b2du?=
 =?utf-8?B?aGFNYlFWQkp5NG1mRTI1cE8wVlE3ZzNERDhqb2lmczhBSG1wSk8wRTBXUFJB?=
 =?utf-8?B?SW1DV0JKUGRaUEE0Y0N5emtoc2pFVnJlV003QlR4SUdFTUNvZGlYWTFyTllD?=
 =?utf-8?B?RkU4b2dCRktnZjNHOCtwS3BBUkhpYStQaHdrZHY5c2I0VUw2N2taWEg5eTIr?=
 =?utf-8?B?YXkvZysyY3YyZWJ2SnNlcmF1NHA2YTZDWG9rNEFKV3FWR0JPanJhdysreDFB?=
 =?utf-8?B?RlNQL2lhN2Jvb3dpRVczd2t5VTltR3NJZ1I3ems5dWQrenZINDlQbW81R0FR?=
 =?utf-8?B?WURzVWtUa0xCNWJhRXQ5Z2pEb0czVmlUQy82MTFmSG5GUnV3d1dudWhqZFR5?=
 =?utf-8?B?Q1EwZlk2YlFTYmJWM0xsS1lXeXA1L0JacytpbDJQUnlZeCtlWW03eDRIK0Jn?=
 =?utf-8?B?aGd2c0ZpK3luNG55YlRac0ZBdkFmekRCV1BwQ1pKTnMzNGNKbmFJSFdZelZv?=
 =?utf-8?B?Rm96eWxDaUNLQlpQRDgwdnN6SFNMR0ZVdjVkdzU3YWo1bmxTVzRJcFdCL0V6?=
 =?utf-8?B?WitNQU56S0N4SW44ZU95ZG1wTFBtNTgvd3J1QWdrYVpXOFdVcDV4MUpwaTcw?=
 =?utf-8?B?ZUh0a201UWQzMDlHOXJKNHprVGNtK3JIbXU1VW5mOWtIOFRsazZNVDA2LzUx?=
 =?utf-8?B?NlY3dnJNbHdjc3QzK3JEQTZUSFh4aUxnOER3UXo4UlBHZDVjN0RZTkRmYng5?=
 =?utf-8?B?THp2bHc0Z0d3c1Y4SGRnZ2dGVFZlSTg2UnNOQjN1RFBSOTdtTDhjUUVJZEMr?=
 =?utf-8?B?YVNoL0RYYjZ4NUR2TU1KVlFvZy9Hb09uK1dCWDNZeXJBVUNWcmJ2czNrcVdW?=
 =?utf-8?B?WnM2NHAwbzFwbjloYTBCRXhpcFN3b2dseVk5NXV1eFgyZ2QxR0FCdVVESEEy?=
 =?utf-8?B?V0RlYnVvK0V1N3Y0WDJ4VllzYnhTQVA4a1Z5Q05CUTFRYUs3N0JSaXo1cHQ4?=
 =?utf-8?B?NUw2N0dKZWx5d2pja2QwaHFFbTQ5UU4yWlcrNzR5bmRlWFFIUFlGUHNtZTAr?=
 =?utf-8?B?bFlBMkJ2ZmNNT0Jydk5wamlrTlRJdWk4TXJ4VTIyRFMvVHZTK2trZFlVLzdp?=
 =?utf-8?B?S1E0SWJOWEx3N3U2WEUyek5Bc1NwUjZ4bWdad1ZXMmdMM1B5ZXlnenNkWHFQ?=
 =?utf-8?B?U2luVUJDQWtIWWt1UHl2ZFJPclZxYUxMb2xCaFlCd3hHcUNpVmdZTFB0MzRW?=
 =?utf-8?B?SWZHOVBYdEFINFBjZVdqOEtkb3NzNTFhQisvNzR4cDFFWDBSZENJRTdGSlhp?=
 =?utf-8?B?eGUwbE41ZTl1bWtRL3VDbXhKNDlxY3JnUU4yOVg0TWdmSUI2TmQ5Si95RSs1?=
 =?utf-8?B?UlUwYitGSm9zWTd3bFZMbjBYN3Z1YVgwOUJEeWE5VWVLeFhFODlwQjduWmRm?=
 =?utf-8?B?VVQrblV6MG1TcU5aalgyb1NVTnpkWXZsNUpJcXVCdWtSTUV2bEV6cGZSNnlV?=
 =?utf-8?B?Ky9CaHdWS1lxWXJpZkR3UUR4RmlrdnMrR0V2M3h2OXp6WitXby9qTWtTcFMv?=
 =?utf-8?B?d2tCOE5pblJRRVE1dGpjT1JialJOWEMxaWhhaGptWUFUY2FjbXZobVpnZkpC?=
 =?utf-8?Q?FOhu2+UuPWU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6363.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjgvc3BOQ3RSZkpteEJBVjRCZTQ3RDVTOW9LODdXY3l4eHFhajlscFBZOEVq?=
 =?utf-8?B?Q1FYQXMveEtVSVd1bWt0K1dmeVdIclZkbktDdXI2NnZBVWxoelkvRzk4RFpR?=
 =?utf-8?B?YStKTnlOeFNsUVUxejVHYTlLYkpmL3dxYmFEOWJJeVYrUHhmWnBtbGt5aEpj?=
 =?utf-8?B?QXArdEhFdURpVmpxSXdKcDNyR0RORjIrOWt4NjBtdU9IK3JxMys1djJpR0hl?=
 =?utf-8?B?ZnBvS2NEcGZkQTdVOENRSCt6VjhSam1QckJvNDBpSUJIdFJIa0VnZVhzWHo3?=
 =?utf-8?B?K25vQzJMYVcwRHppa1lqWkszaVdXL2Z5aHhyNVEyaEJhV1NPaVZNaDd2bFpZ?=
 =?utf-8?B?NDRVZ1FiTkJyaGptS2F6dVc1MVNpN1BqUDQvMG5xSStXeVBNVTVIV3VmN1pH?=
 =?utf-8?B?a1cvbGRtZ3VYaU1iN1FyQXlxd2NidERkNGREVDAwTzM1N3hieDIzeWY0ZEtx?=
 =?utf-8?B?bXVwRE9lN3NYNWxzUWZ0K3BGYnRtNWd2RnR6M3NXM1Rka0MvTUNmT0dpT012?=
 =?utf-8?B?eitEUmpwaGI3d2lScy9QY1h6VmRTQnF2bXVFdmlEZ3c5L0tJM1NMbHpSRkR5?=
 =?utf-8?B?V2l2a2M1bzVoZnJRczM2WFVuby9vSStrZjBKYzNqTVZmNmRSdkF0SSt2R2M3?=
 =?utf-8?B?SXBsYklQUHNHVDQ2dXZ1dGlyUTJuZDZWTFRaQlljL2JJcElnSml2TGh1amNk?=
 =?utf-8?B?bnV1a2dxWXMvczdYeEpNRkp6d2FRRU1wcEtpbkZMbXd3MFZ6Yyt1emNZMkJ4?=
 =?utf-8?B?b05maHMyOEtzLzZXRWptUHV3SWNaZzQzOW1YUGxpWUVnNUNUTGhTb1FWd1Bj?=
 =?utf-8?B?cnY3alBaeHhHTUNyZVQ3WitneFREbXozSGFRM3QraDM2QUlRVk1DNHhPbVQr?=
 =?utf-8?B?d2RPUG5Gamp5WXJFbGdaYmZmaVNWeWx0SlovZHFWTm1DbWMzVCtVb3ptTitQ?=
 =?utf-8?B?RU5UdTVqd0svNDIvWjIzZEpqS0g4a0MwVjlpSFJTMk9ReGlRTDM0aG5SclFD?=
 =?utf-8?B?SG0rRklnOGM4SmxwQlFsWlZiM2FDVUtFaGpsQjNaODYzSnpUcDNjMHRmYTZq?=
 =?utf-8?B?TEVPdU1vTkE0dm1ubEpmZjh0V1pVRWU3Uit6YWJjVlRnUGlKd3NidGd4ZFZQ?=
 =?utf-8?B?eUFlb3BTZE4vZVJGZHBNVGJjRUtzNnkrU3h1eXg2UkNjMm1yeHplYUhBRkZw?=
 =?utf-8?B?SDNoSmNtSjcrS0YyZnhFTGV3dCs3NnpuSWdna3VtZVZpUjNQMWZjTXhPNnMy?=
 =?utf-8?B?T09vQnhUVTd6MWlocHhETlNUejhFUUt3Z3I3SEFiM3ZFOWxYdjdoaTBPODJI?=
 =?utf-8?B?UzJTUnd4KzE4VTY2UE1nV25SUUdlMXY1dDBqejlmM3E1Vi9YSVhCaGF3dG5E?=
 =?utf-8?B?cGZXbzZVNUtyMWRPbkRMK2UwZXovbUJDOHJ3alNVR3J1WmhtbTJJNTgzUHBv?=
 =?utf-8?B?U0FMOEE1MmVjZ1BTcW11VnpJSFdVbUgyZUJUcHVBUnN6bjVudjB1WWtTN0NL?=
 =?utf-8?B?aWdiQ29QS1JvTXRsdmd4L083WDdOSGZuNnE4Z2hIaUUzckVRL2hYd2xUY1Mv?=
 =?utf-8?B?Q0M2KzFRdVc3anRjRXgwS1dxeWhoVjI3Qjd0Zks0Nmh3eXphU0hXM2lOS05V?=
 =?utf-8?B?aFZNYXhPbk5mb2tRSGZ0NDJPcG9LUlN5K1k5Ty8rUDQ5SkgrYWk3aWYvMDV2?=
 =?utf-8?B?V2pDZzlDRXowUkNXQkNRcGw0R2dJbEM3UUwzcXlQUklPR3pBYVpmSmlTeEVo?=
 =?utf-8?B?L1poS3ZSNmdyRGdVemo2WVp5SDE3b0hMY2FjSjZaRmRveWkzb2p6ZjZxTTNz?=
 =?utf-8?B?UytsYTdGMTRTc2R1bSsvSjdmaWZBbTUvOGF3TDJ3RjRuWStqd05jU3gxR1ZK?=
 =?utf-8?B?cWFHS3RBWFI1MnRwRUhVb2ZLTCtUZnZNcWQ3elRoazZoTzdPNTBaMjFkK0or?=
 =?utf-8?B?T3B2T1ViWUR2R2IzZ0xjek9MZU5PQWNmd0pSMVZ0V0x0Q0JCa3dyVDU2T2U2?=
 =?utf-8?B?Wkx5RE1pYWVpNExJOG5Qck9FVnVibFd3ZUI3YzB0N3ZucU5QYjU5K1hIQVhV?=
 =?utf-8?B?YUFoMk9xMEFhelMvU2ZvR0dRM1FmcGY3bUFzUGIwc3FxUW13eW92VUlZeWk3?=
 =?utf-8?Q?SK96nUimkTcgUfOlCyDXw6AOV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e33dbecf-dc35-4d6b-8c1a-08ddce4e41df
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6363.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 03:16:06.7905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 14uaaCvdjwf1wftbXEdAL975EMOXxs8rJKjwmTRN4MXIdtBTNjTHoqTpaB9ULQMTEW5wnWoOz7HXYSKK9FaMSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7601
X-OriginatorOrg: intel.com

On 29.07.2025 10:46, Shuai Xue wrote:
>
>
>在 2025/7/28 19:43, Yi Sun 写道:
>>On 28.07.2025 16:40, Shuai Xue wrote:
>>>Hi, Yi Sun, Fenghua Yu,
>>>
>>>在 2025/7/27 17:16, Yi Sun 写道:
>>>>On 17.06.2025 14:58, Fenghua Yu wrote:
>>>>>Hi, Yi,
>>>>>
>>>>>On 6/17/25 03:27, Yi Sun wrote:
>>>>>>A recent refactor introduced a misplaced put_device() call, leading to a
>>>>>>reference count underflow during module unload.
>>>>>>
>>>>>>There is no need to add additional put_device() calls for idxd groups,
>>>>>>engines, or workqueues. Although commit a409e919ca3 claims:"Note, this
>>>>>>also fixes the missing put_device() for idxd groups, engines, and wqs."
>>>>>>It appears no such omission existed. The required cleanup is already
>>>>>>handled by the call chain:
>>>>>>
>>>>>>
>>>>>>Extend idxd_cleanup() to perform the necessary cleanup, and remove
>>>>>>idxd_cleanup_internals() which was not originally part of the driver
>>>>>>unload path and introduced unintended reference count underflow.
>>>>>>
>>>>>>Fixes: a409e919ca32 ("dmaengine: idxd: Refactor remove call with idxd_cleanup() helper")
>>>>>>Signed-off-by: Yi Sun <yi.sun@intel.com>
>>>>>>
>>>>>>diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
>>>>>>index 40cc9c070081..40f4bf446763 100644
>>>>>>--- a/drivers/dma/idxd/init.c
>>>>>>+++ b/drivers/dma/idxd/init.c
>>>>>>@@ -1292,7 +1292,10 @@ static void idxd_remove(struct pci_dev *pdev)
>>>>>>    device_unregister(idxd_confdev(idxd));
>>>>>>    idxd_shutdown(pdev);
>>>>>>    idxd_device_remove_debugfs(idxd);
>>>>>>-    idxd_cleanup(idxd);
>>>>>>+    perfmon_pmu_remove(idxd);
>>>>>>+    idxd_cleanup_interrupts(idxd);
>>>>>>+    if (device_pasid_enabled(idxd))
>>>>>>+        idxd_disable_system_pasid(idxd);
>>>>>>
>>>>>This will hit memory leak issue.
>>>>>
>>>>>idxd_remove_internals() does not only put_device() but also free allocated memory for wqs, engines, groups. Without calling idxd_remove_internals(), the allocated memory is leaked.
>>>>>
>>>>>I think a right fix is to remove the put_device() in idxd_cleanup_wqs/engines/groups() because:
>>>>>
>>>>>1. idxd_setup_wqs/engines/groups() does not call get_device(). Their counterpart idxd_cleanup_wqs/engines/groups() shouldn't call put_device().
>>>>>
>>>>>2. Fix the issue mentioned in this patch while there is no memory leak issue.
>>>>>
>>>>>>    pci_iounmap(pdev, idxd->reg_base);
>>>>>>    put_device(idxd_confdev(idxd));
>>>>>>    pci_disable_device(pdev);
>>>>>
>>>>>Thanks.
>>>>>
>>>>>-Fenghua
>>>>>
>>>>
>>>>Hi Fenghua,
>>>>
>>>>As with the comments on the previous patch, the function
>>>>idxd_conf_device_release already covers part of what is done in
>>>>idxd_remove_internals, including:
>>>>    kfree(idxd->groups);
>>>>    kfree(idxd->wqs);
>>>>    kfree(idxd->engines);
>>>>    kfree(idxd);
>>>>
>>>>We need to redesign idxd_remove_internals to clearly identify what
>>>>truely result in memory leaks and should be handled there.
>>>>Then, we'll need another patch to fix the idxd_remove_internals and call
>>>>it here.
>>>>
>>>>Let's prioritize addressing the two critical issues we've encountered here,
>>>>and then revisit the memory leak discussion afterward.
>>>>
>>>>Thanks
>>>>  --Sun, Yi
>>>
>>>The root cause is simliar to Patch 1, the idxd_conf_device_release()
>>>function already handles part of the cleanup that
>>>idxd_cleanup_internals() attempts to do, e.g.
>>>
>>>   idxd->wqs
>>>   idxd->einges
>>>   idxd->groups
>>>
>>>As a result, it causes user-after-free issue.
>>>
>>>   ------------[ cut here ]------------
>>>   WARNING: CPU: 190 PID: 13854 at lib/refcount.c:28 refcount_warn_saturate+0xbe/0x110
>>>   refcount_t: underflow; use-after-free.
>>>   drm_client_lib(E) i2c_algo_bit(E) drm_shmem_helper(E) drm_kms_helper(E) nvme(E) mlx5_core(E) mlxfw(E) nvme_core(E) pci_hyperv_intf(E) psample(E) drm(E) wmi(E) pinctrl_emmitsburg(E) sd_mod(E) sg(E) ahci(E) libahci(E) libata(E) fuse(E)
>>>   Modules linked in: binfmt_misc(E) bonding(E) tls(E) intel_rapl_msr(E) intel_rapl_common(E) intel_uncore_frequency(E) intel_uncore_frequency_common(E) i10nm_edac(E) skx_edac_common(E) nfit(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) kvm_intel(E) snd_hda_intel(E) kvm(E) snd_intel_dspcfg(E) snd_hda_codec(E) mlx5_ib(E) irqbypass(E) qat_4xxx(E) snd_hda_core(E) dax_hmem(E) ghash_clmulni_intel(E) intel_qat(E) cxl_acpi(E) snd_hwdep(E) rapl(E) snd_pcm(E) cxl_port(E) iTCO_wdt(E) intel_cstate(E) iTCO_vendor_support(E) snd_timer(E) ib_uverbs(E) pmt_telemetry(E) cxl_core(E) rfkill(E) tun(E) dh_generic(E) pmt_class(E) intel_uncore(E) einj(E) pcspkr(E) isst_if_mbox_pci(E) joydev(E) isst_if_mmio(E) idxd(E-) crc8(E) ib_core(E) isst_if_common(E) authenc(E) intel_vsec(E) idxd_bus(E) snd(E) i2c_i801(E) mei_me(E) soundcore(E) i2c_smbus(E) i2c_ismt(E) mei(E) nf_tables(E) nfnetlink(E) ipmi_ssif(E) acpi_power_meter(E) ipmi_si(E) acpi_ipmi(E) ipmi_devintf(E) ipmi_msghandle
>>>   CPU: 190 UID: 0 PID: 13854 Comm: rmmod Kdump: loaded Tainted: G S          E       6.16.0-rc6+ #116 PREEMPT(none)
>>>   Tainted: [S]=CPU_OUT_OF_SPEC, [E]=UNSIGNED_MODULE
>>>   Hardware name: Inspur AliServer-Xuanwu2.0-02-1UCG42PF/AS2111TG5, BIOS 3.0.ES.AL.P.090.01 02/22/2024
>>>   RIP: 0010:refcount_warn_saturate+0xbe/0x110
>>>   RSP: 0018:ff7078d2df957db8 EFLAGS: 00010282
>>>   RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
>>>   RBP: ff2b10355b055000 R08: 0000000000000000 R09: ff7078d2df957c68
>>>   RDX: ff2b10b33fdaa3c0 RSI: 0000000000000001 RDI: ff2b10b33fd9c440
>>>   R10: ff7078d2df957c60 R11: ffffffffbe761d68 R12: ff2b1035a00db400
>>>   R13: ff2b10355670b148 R14: ff2b103555097c80 R15: ffffffffc0a88938
>>>   FS:  00007fb5f8f3b740(0000) GS:ff2b10b380bb9000(0000) knlGS:0000000000000000
>>>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>   CR2: 00005560a898c2d8 CR3: 00000080f9def005 CR4: 0000000000f73ef0
>>>   PKRU: 55555554
>>>   Code: 01 01 e8 35 9b 9a ff 0f 0b c3 cc cc cc cc 80 3d 05 4c f5 01 00 75 85 48 c7 c7 30 21 75 bd c6 05 f5 4b f5 01 01 e8 12 9b 9a ff <0f> 0b c3 cc cc cc cc 80 3d e0 4b f5 01 00 0f 85 5e ff ff ff 48 c7
>>>   Call Trace:
>>>   idxd_cleanup+0x6b/0x100 [idxd]
>>>   <TASK>
>>>   idxd_remove+0x46/0x70 [idxd]
>>>   pci_device_remove+0x3f/0xb0
>>>   driver_detach+0x48/0x90
>>>   device_release_driver_internal+0x197/0x200
>>>   bus_remove_driver+0x6d/0xf0
>>>   idxd_exit_module+0x34/0x6c0 [idxd]
>>>   __do_sys_delete_module.constprop.0+0x174/0x310
>>>   do_syscall_64+0x5f/0x2d0
>>>   pci_unregister_driver+0x2e/0xb0
>>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>   RIP: 0033:0x7fb5f8a620cb
>>>   Code: 73 01 c3 48 8b 0d a5 6d 19 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 75 6d 19 00 f7 d8 64 89 01 48
>>>   RSP: 002b:00007ffeed6101c8 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
>>>   RAX: ffffffffffffffda RBX: 00005560a8981790 RCX: 00007fb5f8a620cb
>>>   RDX: 000000000000000a RSI: 0000000000000800 RDI: 00005560a89817f8
>>>   R13: 00007ffeed612352 R14: 00005560a89812a0 R15: 00005560a8981790
>>>   R10: 00007fb5f8baaac0 R11: 0000000000000206 R12: 00007ffeed6103f0
>>>   </TASK>
>>>   ---[ end trace 0000000000000000 ]---
>>>
>>>With this patch applied, the user-after-free issue is fixed.
>>>
>>>But, there is still memory leaks in
>>>
>>>   idxd->wqs[i]
>>>   idxd->einges[i]
>>>   idxd->groups[i]
>>>
>>>I agree with Vinicius that we should cleanup in idxd_conf_device_release().
>>>
>>>Thanks.
>>>Shuai
>>
>>Appreciate Shuai's clarification. Yes, it would be better if fixing the memory
>>leak issue in idxd_conf_device_release() in a separate patch.
>>
>>@Shuai, please feel free to proceed if you'd like to cook a patch for it.
>>
>>Thanks
>>    --Sun, Yi
>
>Hi, Sun, Yi,
>
>I need to correct my previous analysis. After further investigation, I
>believe there is no memory leak in the current code. The device
>reference counting and memory management are properly handled through
>the Linux device model. Each component is freed at the conf_dev
>destruction time:
>
>
>    idxd->wqs[i] is freed by idxd_conf_wq_release()
>    idxd->einges[i] is freed by idxd_conf_engine_release()
>    idxd->groups[i] is freed by idxd_conf_group_release()
>
>
>Adding additional cleanup in idxd_conf_device_release() would actually
>cause double-free issues. I can reproduce this with KASAN:
>
>[kernel][err]BUG: KASAN: slab-use-after-free in idxd_clean_groups+0x137/0x250 [idxd]
>[kernel][err]==================================================================
>[kernel][err]Read of size 4 at addr ff1100822ff89038 by task rmmod/13956
>[kernel][err]
>[kernel][err]CPU: 185 UID: 0 PID: 13956 Comm: rmmod Kdump: loaded Tainted: G S          E       6.16.0-rc6+ #117 PREEMPT(none)
>[kernel][err]Tainted: [S]=CPU_OUT_OF_SPEC, [E]=UNSIGNED_MODULE
>[kernel][err]Hardware name: Inspur AliServer-Xuanwu2.0-02-1UCG42PF/AS2111TG5, BIOS 3.0.ES.AL.P.090.01 02/22/2024
>[kernel][err]Call Trace:
>[kernel][err]<TASK>
>[kernel][err]dump_stack_lvl+0x55/0x70
>[kernel][err]print_address_description.constprop.0+0x27/0x2e0
>[kernel][err]? idxd_clean_groups+0x137/0x250 [idxd]
>[kernel][err]print_report+0x3e/0x70
>[kernel][err]kasan_report+0xb8/0xf0
>[kernel][err]? idxd_clean_groups+0x137/0x250 [idxd]
>[kernel][err]kasan_check_range+0x39/0x1b0
>[kernel][err]idxd_clean_groups+0x137/0x250 [idxd]
>[kernel][err]idxd_cleanup_internals+0x1f/0x1b0 [idxd]
>[kernel][err]idxd_conf_device_release+0xe2/0x2b0 [idxd]
>[kernel][err]device_release+0x9c/0x210
>[kernel][err]kobject_cleanup+0x101/0x360
>[kernel][err]pci_device_remove+0xab/0x1e0
>[kernel][err]idxd_remove+0x93/0xb0 [idxd]
>[kernel][err]device_release_driver_internal+0x369/0x530
>[kernel][err]driver_detach+0xbf/0x180
>[kernel][err]bus_remove_driver+0x11b/0x2a0
>[kernel][err]pci_unregister_driver+0x2a/0x250
>[kernel][err]? kobject_put+0x55/0xe0
>[kernel][err]idxd_exit_module+0x34/0x40 [idxd]
>[kernel][err]__do_sys_delete_module.constprop.0+0x2ee/0x580
>[kernel][err]? fput_close_sync+0xdd/0x190
>[kernel][err]? __pfx___do_sys_delete_module.constprop.0+0x10/0x10
>[kernel][err]do_syscall_64+0x5d/0x2d0
>[kernel][err]? __pfx_fput_close_sync+0x10/0x10
>[kernel][err]entry_SYSCALL_64_after_hwframe+0x76/0x7e
>[kernel][err]RIP: 0033:0x7f2ac20620cb
>[kernel][err]Code: 73 01 c3 48 8b 0d a5 6d 19 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 75 6d 19 00 f7 d8 64 89 01 48
>[kernel][err]RSP: 002b:00007ffdfec0a598 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
>[kernel][err]RDX: 000000000000000a RSI: 0000000000000800 RDI: 0000560bd6bd77f8
>[kernel][err]RAX: ffffffffffffffda RBX: 0000560bd6bd7790 RCX: 00007f2ac20620cb
>[kernel][err]R10: 00007f2ac21aaac0 R11: 0000000000000206 R12: 00007ffdfec0a7c0
>[kernel][err]RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
>[kernel][err]</TASK>
>[kernel][err]R13: 00007ffdfec0b352 R14: 0000560bd6bd72a0 R15: 0000560bd6bd7790
>[kernel][err]Allocated by task 1445:
>[kernel][err]
>[kernel][warning]kasan_save_stack+0x24/0x50
>[kernel][warning]kasan_save_track+0x14/0x30
>[kernel][warning]__kasan_kmalloc+0xaa/0xb0
>[kernel][warning]idxd_setup_groups+0x2b5/0x7a0 [idxd]
>[kernel][warning]idxd_setup_internals+0xd1/0x6e0 [idxd]
>[kernel][warning]idxd_probe+0x93/0x310 [idxd]
>[kernel][warning]idxd_pci_probe_alloc+0x3f3/0x6e0 [idxd]
>[kernel][warning]local_pci_probe+0xe5/0x1a0
>[kernel][warning]work_for_cpu_fn+0x52/0xa0
>[kernel][warning]process_one_work+0x652/0x1080
>[kernel][warning]worker_thread+0x652/0xc70
>[kernel][warning]ret_from_fork+0x253/0x2e0
>[kernel][warning]kthread+0x34a/0x450
>[kernel][warning]ret_from_fork_asm+0x1a/0x30
>[kernel][err]
>[kernel][err]Freed by task 13956:
>[kernel][warning]kasan_save_stack+0x24/0x50
>[kernel][warning]kasan_save_track+0x14/0x30
>[kernel][warning]kasan_save_free_info+0x3a/0x60
>[kernel][warning]__kasan_slab_free+0x54/0x70
>[kernel][warning]kfree+0x12e/0x430
>[kernel][warning]device_release+0x9c/0x210
>[kernel][warning]kobject_cleanup+0x101/0x360
>[kernel][warning]idxd_unregister_devices+0x22d/0x320 [idxd]
>[kernel][warning]pci_device_remove+0xab/0x1e0
>[kernel][warning]idxd_remove+0x3c/0xb0 [idxd]
>[kernel][warning]driver_detach+0xbf/0x180
>[kernel][warning]device_release_driver_internal+0x369/0x530
>[kernel][warning]bus_remove_driver+0x11b/0x2a0
>[kernel][warning]pci_unregister_driver+0x2a/0x250
>[kernel][warning]idxd_exit_module+0x34/0x40 [idxd]
>[kernel][warning]do_syscall_64+0x5d/0x2d0
>[kernel][warning]__do_sys_delete_module.constprop.0+0x2ee/0x580
>[kernel][err]
>[kernel][err]The buggy address belongs to the object at ff1100822ff89000
>
>The issue shows memory being freed during device_release(), then
>accessed again in idxd_conf_device_release().
>
>Your original approach is correct - the kernel's device model handles
>the memory management properly, and we should not interfere with it.
>
>Feel free to add:
>
>Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>
>
>Sorry for the confusion in my earlier analysis.
>
>Best Regards,
>Shuai

I see. Thanks Shuai for the comments and testing efforts.
I'd like to resend this series with the Tested-by tag to make it easier
for further review.


Thanks
    --Sun, Yi


