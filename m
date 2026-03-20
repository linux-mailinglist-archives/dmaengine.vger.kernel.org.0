Return-Path: <dmaengine+bounces-9550-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qB5VDKf8vGkS5QIAu9opvQ
	(envelope-from <dmaengine+bounces-9550-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 08:52:07 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EBB2D6D16
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 08:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3204C3002919
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 07:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8282344D9D;
	Fri, 20 Mar 2026 07:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AligDqcK"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69109355F31
	for <dmaengine@vger.kernel.org>; Fri, 20 Mar 2026 07:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773993121; cv=fail; b=LUrITpVbZH3B5DEf7/awQKcNGXbp+rAdk/RXA9Vv+DbZTu/VvC6uuK8EsIvni1BQ4ZhOIPH9hjbYCRTkv83qY76mtoHPhZSWtcEtoQb5RjE8audC0ztvJ3H9+WrJ3WTYUVwbY7nS8/qZwMlc+6ank9OGmPbHQ1DFlWM1tFvU7tA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773993121; c=relaxed/simple;
	bh=65XKVqJ+ZflzK6pGNmWxuvdt9/DcDfflhj6jCEzSlr0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LXJWyoyiwpWWzgj+t22X7u3GqrV/lmjdmMfXW2B4X4C0VUhzHOyLFsxqUec7JXdd3XXLCfEYWxCt2Xvl6qS5kbNjJ2QqVbh7czdS28i2U/pwghltxbpufJYFhlq/VTNBuoqyZV2CU+NKODIUrQEPBcI6Cw6MHLje/5NGKV9fiQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AligDqcK; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773993119; x=1805529119;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=65XKVqJ+ZflzK6pGNmWxuvdt9/DcDfflhj6jCEzSlr0=;
  b=AligDqcKr0Suiyhdy9Rs2hV2xzS0iHwfKGEO3QjL3jTDB63qKRUss/cM
   Dv5C/kZWmkEQF7KM2P7jhwU4uhNolrnGHSlr4FetzxSvqxOypvmXzhX7I
   XH+PGYp2iwxA5vzMYEocEpbNx4WLOBY/08K7PL04RVMjpfWS9UA3ev80s
   U2TZPoVc21WG2cmEwbl4UruYrp8Ym5gOWwXgOsAzE8rd4XEnQHdoyax76
   GfU7CWKIGRsnBxYXEUpyecjFmCxINIIF7dsBUPRYoxaNPEDT+90SflQp+
   8pA7hZ9Lhi0jDRsNgRj+KPE1cCcyIx3F1vwXCVkuFXOW4EoYIvNfFWwxm
   A==;
X-CSE-ConnectionGUID: 5rRLifh+QUOoGkCHArkF7Q==
X-CSE-MsgGUID: jCZp/n7uQyyUoFDrrEaKJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="85390624"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="85390624"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 00:51:58 -0700
X-CSE-ConnectionGUID: 5idyVD+9QVW+Nv/jxHSwCw==
X-CSE-MsgGUID: r4yffJUpTbGhcyIuRB/vIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="246241886"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 00:51:58 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 00:51:58 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 00:51:58 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.39) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 00:51:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y1/QfGORIniHMQNcCDoIxdBjPXpSwLeszaxEzUe6qzRvu/fO8bK6jRxA6z6F1as6L0ifkX5ZTAetK10FNddOek9QrlQr72P5bq8uUoJhODx3jC/hAql8vxgD4WVTN3lhnvW+/sys7C3famFxcNAhVgNGrUUgSxnfa4yMVTNZ97SokIsr1bxS7KNW5ia4QfddvVl4XRWhRggxMBnd/8YXEvHc168LSwiFeLvohodBjJSJxBZj/ck5KgJRxyM04LjQ8fdW5LQlr4uL7P2ct+bin9mxWZ4eBiYFj+ZCdMJso+XCr56yPm2tk0ZS6bLeq6wzQuF48i0ElSqk+aCgF5aLQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6s+kT2LrTY5EyEWhMhKR9QzculBeDQIFUwY6n5mVQN0=;
 b=ms7Tlf6u0NhFnZCNpuCFZapSGMjrMPI+eToQg6CP7xLmYwv9WzUPYzffnra7yN4FsBcQpmZYU+Gfp2qzGb98+Wl/Vj8AysstCgjEOFdx7/C4vWjVwfltKlu1ASuZ5pk4txuqrsXGuy3t5NuR3uIdNCRETjw6BSEBK3XO6lPX0OFCKrbF1u8eB+d6sbjcXtR5vITLI8rVIAkpy77pjIeJNO8+C0zoy7w1HhiIFBDPJe6JjKjkkO/zkb0xS/c+z0OiRcC8Fo7Q3TLYBCRdVY2oNhQvdz6dPef/+/3t59Uqg0fNPAyabFH2CVGZpstsR3qOkr+dtlQ+msvKl0Kb7nicmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by PH7PR11MB6008.namprd11.prod.outlook.com (2603:10b6:510:1d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 07:51:50 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 07:51:50 +0000
Date: Fri, 20 Mar 2026 15:51:43 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Rosen Penev <rosenp@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <dmaengine@vger.kernel.org>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Kees Cook
	<kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] dmaengine: idma64: use kzalloc_flex
Message-ID: <202603200800.38a86c8a-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260317003730.72379-1-rosenp@gmail.com>
X-ClientProxiedBy: TPYP295CA0042.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::20) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|PH7PR11MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: 4042c5b9-431b-4448-2a07-08de86558b9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /RCIKWQUbaxo8YGY+IKNELymoEmOMlRlJL+Q57egNwQoOXqUo5RrYFS1tmyZgyWL0Twi+pp4W/RJmpam8WZA8B234NLAmqKq/9pzTirGSuj7yOGbzGwjL0FqQ7W5QZbTC2A06pwBrMLx+jYe40FmWwZungdvMcKuswARhxliEQLIpE+l706YPucJhk2TCdgr10iRgFvQ0r6+VvOHcscEBBYGKfE+XuVKavO7iHwfY2d3GhQTe1gQ5EEbP/JjHgsydQVddht8+IRG57o6BTzHygiAKnb5XNsYeF3lJw9ij4simbge8AZIJPTK4BI+EhO++8boICsQLVv3FMEbDxqH4YM3i19UF2AXnjJcT42NllrhnCSJjuzSLKy80sO+PWa0CO3LcrEjiic1CIC+T2bzVYEPm4syrDAmnsNJ+g7MeLUvhSY0lB7DdAO68q6fmSLlM1YA1Y1UutcHXIydEE9Tn3wctGFiU2VjoT+2d2KZchOrXffYx+vJ7YD1ucPRPPqJK8i9aPl9qi74TKU2JC7H8Barn5h62XLo2fCbkppiwrNYCd9/wR+PvAynb7RJKwsSDoDl4rYXOcNKofoM7zFtBV7zIPcc7q20NoQJ8lh9iSJsc9nW2vFDsjaj0tPVHh+vwDJaWDFA2lJnL21Kp2FKAwq8vXlV7pw9A5vJDJqk7ihEt9OQbHv/PFtmvq5Uq75pF0+2f2kVMynr6TVkyHEF0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6rKk7vk1gHydTFIO/BZCbTCjV8UoVfzRumRJxMCQ2VIPpOgHFerKTJRcrpqN?=
 =?us-ascii?Q?qx/7OyF+HP+lRymxqrHAYK5e/s/icriSqr3E3/TTQYMy+RtplN8Bk/oh5C02?=
 =?us-ascii?Q?An/QXbKiu5h1jVir6D15h/2quWsy6wtkKyb34Xfk7/RQRLuKWg30b9j5mTxd?=
 =?us-ascii?Q?A/7WLIr7Uz6zYRwkIP7g3H/SGhWcnBGeqSEFI9eVgn6rXeVOi7XCHiMZKzw7?=
 =?us-ascii?Q?IyW6UTYqPi6/jFPHCOpFrpM62uA6kqjrDWFaRwlYZCEdJvzGlLsyPpekx527?=
 =?us-ascii?Q?azbyklvPR0um/JCoyx8qDSMtMRunpOAdyYcBrsKRNl4NQD2OC2Hf7UbX6KD9?=
 =?us-ascii?Q?EPwvn43JnSoe8HuHlBpdi3jhw6we32rkyNO2ClY4tXE5YGmzKdX8ucRdUPCd?=
 =?us-ascii?Q?lpgBR6TeiLSmebGLaE5MJWt+oSd17gnXADbms7xccZ9gVwaw0Cj6HUWtTYeA?=
 =?us-ascii?Q?N9bCqvzx0KERQETEMS4yrwBnqFiuW8UnleQAONPiP83FPpS6fzoRLEWdlAhf?=
 =?us-ascii?Q?dbBfPChNqKuHJ87emLDfEMVwx2GcM/5mCpWXhL4mihj0V2R2jTxNemf5AKEW?=
 =?us-ascii?Q?PgWJMwVUU4X7Yh/9XjzVz90EEFRliL7Jk6u4N849HXlUxuZ7xrhdbxgFGKH5?=
 =?us-ascii?Q?UwHgMGgI5QbQpKOXMjxSPL70hf4g9bU8SqED6G09kT6plnMBfwrxvIt6ksMw?=
 =?us-ascii?Q?hpgcHqNBuEFqnxcGPW+nQHyQTIXU1RYKkMhI/85uct85JqBFxE3QB4lboRQR?=
 =?us-ascii?Q?jFoJde8JZSboIgMu0+c9wHAuXoOVHvNv5zylH7z94uGGLW6lDvZXxXbPzIiu?=
 =?us-ascii?Q?mffrgntcNDs9sV6JSzxHdwGCoJBWPC3NDN9VqJsM0TW0dBUP8v/iiBj5XIZS?=
 =?us-ascii?Q?pv6BqFAtRXAwrauAkB1PuQp3kKmh2MoRgjTcxMnmTIPVm0Ks5mMox257H8rR?=
 =?us-ascii?Q?UMJfQZFXITKLERz2izVOKSp8n6Gan0IT9AQcow1GMEV0lRcEaM3ZcTahVJ5d?=
 =?us-ascii?Q?oMRF5KQWO13Dtp4NFWJ58MPhkL2ijMhyF3UzyxdiCqrJHjPxaC/IXoavtBT7?=
 =?us-ascii?Q?wRWhLxeulyiJVWaqABzmZtiy3ozXnx8wNeZtk3uqX7dBTAo2ETbNTsI5b7qR?=
 =?us-ascii?Q?mFh+5anYvOq8frnDEY2AjkKC0bRBIuirdL+UOXD61j+n45mSrWar59AoJTI7?=
 =?us-ascii?Q?EAoXxF1jNmkZOAJBrW6ydWqlz0wcAai/DJkwpOnlIwSxWif4LD/xqKgA10t4?=
 =?us-ascii?Q?ILL63bpsf4EXJySVsjPXKWsv+5n1NaIRmZiIdnttZYZd5tLsaNeTOsaWm+y/?=
 =?us-ascii?Q?sy7VDcyYqXu5SnjgVsOZYiHiHg31brDnKbWuwL4HvzoaQuRhHnYrbumZe1tL?=
 =?us-ascii?Q?uoOan6HryVXeE4NY3bArA2iQYPrNgu5AdixjluMST35tzWYuwYAGSmKfGAsP?=
 =?us-ascii?Q?rugCyjpGW96M5k3uW9iiMBF9xMH8gmslOTDcS1NnPXDD9QgiHPsLG0AmrGpx?=
 =?us-ascii?Q?QI/DEc77uiAY1mRJ4//6GaSLIzvFgF1llfdHFuiQMMjc/kl9WanWuot36UGe?=
 =?us-ascii?Q?fdJjm5SqCOxg49WaP4hhHrTVWh75WEi8fTJTVY4GyOSTV64s6/4apCHXauJt?=
 =?us-ascii?Q?/ClXL/oUPAHk2gbFMgwQLgWpvNaSNNBNbAoOJ/gWlPfSy7bYM4MFPBFuboV8?=
 =?us-ascii?Q?ZLF16wadhtPGUDax7B07DrYsp0KVR6INin6KAEh/M2Bqbrw9Uv7MVCmGnZ7D?=
 =?us-ascii?Q?sMXacRzyLA=3D=3D?=
X-Exchange-RoutingPolicyChecked: nDAjv4ZAsfhTxGG5PsJRbR4l7l+jJrCwDneFrGG2rwuVBRkT8CPySe2b16iTi2Th7oOs2tYDR/kLE6+e1kndxM03GDe+IoqcVRWdNWUBkzYQ2aLurYTrNe2zDbOuElCgtLyJg4AWn98ROIyD31BwVxkF9tyRZI3uzndo4MLMVpQUtlsybW+HzPeDYQOBkMc2opU0QsCaAQAMZfIOEHnoMNmQxOvoABqVgNiVNLU9u2W89KSgqmeVzqogYVZ2bX/bR8DGdJ0383fJP70nV19xj7UZQPXZs0yi1fECTlgFROjuqQnscQaJq0zkjoiDJ4ZcY5D/Qc1IlSjU+jHfd4ukAQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4042c5b9-431b-4448-2a07-08de86558b9f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 07:51:50.8336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zI8R4JsIH8Ri1nJ8itdb3Tk0m0O8Bv7skggKYWFPYG0CQcP4AAqhCv/0nGbY/UDjfJ+QZn+GPSMIQF7dH25UtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6008
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9550-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid,80.160.32.0:email];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 22EBB2D6D16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



Hello,

kernel test robot noticed "WARNING:HARDIRQ-safe->HARDIRQ-unsafe_lock_order_detected" on:

commit: 9aaf187d4b233d22a895a594836a02c32c413937 ("[PATCH] dmaengine: idma64: use kzalloc_flex")
url: https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/dmaengine-idma64-use-kzalloc_flex/20260317-084750
base: https://git.kernel.org/cgit/linux/kernel/git/vkoul/dmaengine.git next
patch link: https://lore.kernel.org/all/20260317003730.72379-1-rosenp@gmail.com/
patch subject: [PATCH] dmaengine: idma64: use kzalloc_flex

in testcase: perf-event-tests
version: perf-event-tests-x86_64-54251c2-1_20251210
with following parameters:

	paranoid: not_paranoid_at_all


config: x86_64-rhel-9.4-bpf
compiler: gcc-14
test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202603200800.38a86c8a-lkp@intel.com



kern  :warn  : [   92.812882] [    T125] WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
kern  :warn  : [   92.812886] [    T125] 7.0.0-rc1-00048-g9aaf187d4b23 #1 Tainted: G S
kern  :warn  : [   92.812888] [    T125] -----------------------------------------------------
kern  :warn  : [   92.812890] [    T125] kworker/u64:13/125 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
kern  :info  : [   92.820021] [    T301] scsi host1: ahci
kern  :warn  : [   92.824348] [    T125] ffffffff85238340 (fs_reclaim){+.+.}-{0:0}, at: __kmalloc_noprof (include/linux/sched/mm.h:318 mm/slub.c:4452 mm/slub.c:4807 mm/slub.c:5218 mm/slub.c:5231)
kern  :info  : [   92.832922] [    T301] ata1: SATA max UDMA/133 abar m2048@0x50a02000 port 0x50a02100 irq 157 lpm-pol 0
kern  :warn  : [   92.840680] [    T125]
and this task is already holding:
kern  :warn  : [   92.840681] [    T125] ffffffff87aa2698 (&port_lock_key){-.-.}-{3:3}, at: serial_port_runtime_resume (include/linux/serial_core.h:640 include/linux/serial_core.h:674 include/linux/serial_core.h:718 drivers/tty/serial/serial_port.c:42)
kern  :info  : [   92.847517] [    T301] ata2: SATA max UDMA/133 abar m2048@0x50a02000 port 0x50a02180 irq 157 lpm-pol 0
kern  :warn  : [   92.856658] [    T125] which would create a new lock dependency:
kern  :warn  : [   92.856660] [    T125]  (&port_lock_key){-.-.}-{3:3} -> (fs_reclaim){+.+.}-{0:0}
kern  :warn  : [   92.921503] [    T125]
but this new dependency connects a HARDIRQ-irq-safe lock:
kern  :warn  : [   92.921505] [    T125]  (&port_lock_key){-.-.}-{3:3}
kern  :warn  : [   92.921509] [    T125]
... which became HARDIRQ-irq-safe at:
kern  :warn  : [   92.921510] [    T125]   __lock_acquire (kernel/locking/lockdep.c:5191 (discriminator 1))
kern  :warn  : [   92.959014] [    T125]   lock_acquire (include/trace/events/lock.h:24 (discriminator 15) include/trace/events/lock.h:24 (discriminator 15) kernel/locking/lockdep.c:5831 (discriminator 15))
kern  :warn  : [   92.959019] [    T125]   _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:133 kernel/locking/spinlock.c:162)
kern  :warn  : [   92.970359] [    T125]   serial8250_handle_irq (include/linux/serial_core.h:640 include/linux/serial_core.h:674 include/linux/serial_core.h:718 drivers/tty/serial/8250/8250_port.c:1798)
kern  :warn  : [   92.976110] [    T125]   serial8250_default_handle_irq (drivers/tty/serial/8250/8250_port.c:1846)
kern  :warn  : [   92.982547] [    T125]   serial8250_interrupt (drivers/tty/serial/8250/8250_core.c:86 (discriminator 1))
kern  :warn  : [   92.988104] [    T125]   __handle_irq_event_percpu (kernel/irq/handle.c:209)
kern  :warn  : [   92.994068] [    T125]   handle_irq_event (kernel/irq/handle.c:248 kernel/irq/handle.c:263)
kern  :warn  : [   92.999068] [    T125]   handle_edge_irq (kernel/irq/chip.c:857)
kern  :warn  : [   93.004157] [    T125]   __common_interrupt (include/asm-generic/irq_regs.h:29 (discriminator 5) arch/x86/kernel/irq.c:336 (discriminator 5))
kern  :warn  : [   93.009323] [    T125]   common_interrupt (arch/x86/kernel/irq.c:326 (discriminator 35))
kern  :warn  : [   93.014316] [    T125]   asm_common_interrupt (arch/x86/include/asm/idtentry.h:569)
kern  :warn  : [   93.019650] [    T125]   finish_task_switch+0x10b/0x3b0
kern  :warn  : [   93.025596] [    T125]   __schedule (kernel/sched/core.c:5298)
kern  :warn  : [   93.030226] [    T125]   schedule (arch/x86/include/asm/preempt.h:27 kernel/sched/core.c:5780 kernel/sched/core.c:5800 kernel/sched/core.c:6990 kernel/sched/core.c:7004)
kern  :warn  : [   93.034596] [    T125]   worker_thread (kernel/workqueue.c:3392)
kern  :warn  : [   93.039471] [    T125]   kthread (kernel/kthread.c:467)
kern  :warn  : [   93.043818] [    T125]   ret_from_fork (arch/x86/kernel/process.c:164)
kern  :warn  : [   93.048676] [    T125]   ret_from_fork_asm (arch/x86/entry/entry_64.S:255)
kern  :warn  : [   93.053710] [    T125]
to a HARDIRQ-irq-unsafe lock:
kern  :warn  : [   93.061189] [    T125]  (fs_reclaim){+.+.}-{0:0}
kern  :warn  : [   93.061193] [    T125]
... which became HARDIRQ-irq-unsafe at:
kern  :warn  : [   93.074129] [    T125] ...
kern  :warn  : [   93.074131] [    T125]   __lock_acquire (kernel/locking/lockdep.c:5191 (discriminator 1))
kern  :warn  : [   93.081760] [    T125]   lock_acquire (include/trace/events/lock.h:24 (discriminator 15) include/trace/events/lock.h:24 (discriminator 15) kernel/locking/lockdep.c:5831 (discriminator 15))
kern  :warn  : [   93.086999] [    T125]   fs_reclaim_acquire (mm/page_alloc.c:4349 mm/page_alloc.c:4362)
kern  :warn  : [   93.092056] [    T125]   mem_cgroup_alloc (include/linux/sched/mm.h:318 include/linux/xarray.h:876 mm/memcontrol.c:3758)
kern  :warn  : [   93.097030] [    T125]   mem_cgroup_css_alloc (mm/memcontrol.c:3830)
kern  :warn  : [   93.102350] [    T125]   cgroup_init_subsys (kernel/cgroup/cgroup.c:6257)
kern  :warn  : [   93.107583] [    T125]   cgroup_init (include/linux/list.h:191 kernel/cgroup/cgroup.c:6387)
kern  :warn  : [   93.112204] [    T125]   start_kernel (init/main.c:1202)
kern  :warn  : [   93.116907] [    T125]   __pfx_clear_bss (arch/x86/kernel/head64.c:310)
kern  :warn  : [   93.121614] [    T125]   x86_64_start_kernel (??:?)
kern  :warn  : [   93.126754] [    T125]   common_startup_64 (arch/x86/kernel/head_64.S:419)
kern  :warn  : [   93.131895] [    T125]
other info that might help us debug this:

kern  :warn  : [   93.142675] [    T125]  Possible interrupt unsafe locking scenario:

kern  :warn  : [   93.151346] [    T125]        CPU0                    CPU1
kern  :warn  : [   93.156839] [    T125]        ----                    ----
kern  :warn  : [   93.162328] [    T125]   lock(fs_reclaim);
kern  :info  : [   93.166307] [    T391] ata1: SATA link down (SStatus 4 SControl 300)
kern  :warn  : [   93.166424] [    T125]                                local_irq_disable();
kern  :warn  : [   93.166425] [    T125]                                lock(&port_lock_key);
kern  :info  : [   93.177705] [    T393] ata2: SATA link down (SStatus 4 SControl 300)
kern  :warn  : [   93.179181] [    T125]                                lock(fs_reclaim);
kern  :warn  : [   93.179183] [    T125]   <Interrupt>
kern  :warn  : [   93.179184] [    T125]     lock(&port_lock_key);
kern  :warn  : [   93.179186] [    T125]
*** DEADLOCK ***

kern  :warn  : [   93.179186] [    T125] 3 locks held by kworker/u64:13/125:
kern  :warn  : [   93.222088] [    T125]  #0: ffff8881016d2948 ((wq_completion)pm){+.+.}-{0:0}, at: process_one_work (kernel/workqueue.c:3250)
kern  :warn  : [   93.232332] [    T125]  #1: ffff888101b3fd40 ((work_completion)(&dev->power.work)){+.+.}-{0:0}, at: process_one_work (kernel/workqueue.c:3251)
kern  :warn  : [   93.244208] [    T125]  #2: ffffffff87aa2698 (&port_lock_key){-.-.}-{3:3}, at: serial_port_runtime_resume (include/linux/serial_core.h:640 include/linux/serial_core.h:674 include/linux/serial_core.h:718 drivers/tty/serial/serial_port.c:42)
kern  :warn  : [   93.255081] [    T125]
the dependencies between HARDIRQ-irq-safe lock and the holding lock:
kern  :warn  : [   93.265967] [    T125] -> (&port_lock_key){-.-.}-{3:3} {
kern  :warn  : [   93.271368] [    T125]    IN-HARDIRQ-W at:
kern  :warn  : [   93.275551] [    T125]                     __lock_acquire (kernel/locking/lockdep.c:5191 (discriminator 1))
kern  :warn  : [   93.282082] [    T125]                     lock_acquire (include/trace/events/lock.h:24 (discriminator 15) include/trace/events/lock.h:24 (discriminator 15) kernel/locking/lockdep.c:5831 (discriminator 15))
kern  :warn  : [   93.288963] [    T125]                     _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:133 kernel/locking/spinlock.c:162)
kern  :warn  : [   93.296016] [    T125]                     serial8250_handle_irq (include/linux/serial_core.h:640 include/linux/serial_core.h:674 include/linux/serial_core.h:718 drivers/tty/serial/8250/8250_port.c:1798)
kern  :warn  : [   93.303060] [    T125]                     serial8250_default_handle_irq (drivers/tty/serial/8250/8250_port.c:1846)
kern  :warn  : [   93.310805] [    T125]                     serial8250_interrupt (drivers/tty/serial/8250/8250_core.c:86 (discriminator 1))
kern  :warn  : [   93.317680] [    T125]                     __handle_irq_event_percpu (kernel/irq/handle.c:209)
kern  :warn  : [   93.325157] [    T125]                     handle_irq_event (kernel/irq/handle.c:248 kernel/irq/handle.c:263)
kern  :warn  : [   93.331689] [    T125]                     handle_edge_irq (kernel/irq/chip.c:857)
kern  :warn  : [   93.338301] [    T125]                     __common_interrupt (include/asm-generic/irq_regs.h:29 (discriminator 5) arch/x86/kernel/irq.c:336 (discriminator 5))
kern  :warn  : [   93.345005] [    T125]                     common_interrupt (arch/x86/kernel/irq.c:326 (discriminator 35))
kern  :warn  : [   93.351528] [    T125]                     asm_common_interrupt (arch/x86/include/asm/idtentry.h:569)
kern  :warn  : [   93.358390] [    T125]                     finish_task_switch+0x10b/0x3b0
kern  :warn  : [   93.365862] [    T125]                     __schedule (kernel/sched/core.c:5298)
kern  :warn  : [   93.372039] [    T125]                     schedule (arch/x86/include/asm/preempt.h:27 kernel/sched/core.c:5780 kernel/sched/core.c:5800 kernel/sched/core.c:6990 kernel/sched/core.c:7004)
kern  :warn  : [   93.377948] [    T125]                     worker_thread (kernel/workqueue.c:3392)
kern  :warn  : [   93.384375] [    T125]                     kthread (kernel/kthread.c:467)
kern  :warn  : [   93.390278] [    T125]                     ret_from_fork (arch/x86/kernel/process.c:164)
kern  :warn  : [   93.396705] [    T125]                     ret_from_fork_asm (arch/x86/entry/entry_64.S:255)
kern  :warn  : [   93.403303] [    T125]    IN-SOFTIRQ-W at:
kern  :warn  : [   93.407480] [    T125]                     __lock_acquire (kernel/locking/lockdep.c:5191 (discriminator 1))
kern  :warn  : [   93.413998] [    T125]                     lock_acquire (include/trace/events/lock.h:24 (discriminator 15) include/trace/events/lock.h:24 (discriminator 15) kernel/locking/lockdep.c:5831 (discriminator 15))
kern  :warn  : [   93.420866] [    T125]                     _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:133 kernel/locking/spinlock.c:162)
kern  :warn  : [   93.427896] [    T125]                     serial8250_handle_irq (include/linux/serial_core.h:640 include/linux/serial_core.h:674 include/linux/serial_core.h:718 drivers/tty/serial/8250/8250_port.c:1798)
kern  :warn  : [   93.434913] [    T125]                     serial8250_default_handle_irq (drivers/tty/serial/8250/8250_port.c:1846)
kern  :warn  : [   93.442616] [    T125]                     serial8250_interrupt (drivers/tty/serial/8250/8250_core.c:86 (discriminator 1))
kern  :warn  : [   93.449446] [    T125]                     __handle_irq_event_percpu (kernel/irq/handle.c:209)
kern  :warn  : [   93.456868] [    T125]                     handle_irq_event (kernel/irq/handle.c:248 kernel/irq/handle.c:263)
kern  :warn  : [   93.463342] [    T125]                     handle_edge_irq (kernel/irq/chip.c:857)
kern  :warn  : [   93.469897] [    T125]                     __common_interrupt (include/asm-generic/irq_regs.h:29 (discriminator 5) arch/x86/kernel/irq.c:336 (discriminator 5))
kern  :warn  : [   93.476528] [    T125]                     common_interrupt (arch/x86/kernel/irq.c:326 (discriminator 2))
kern  :warn  : [   93.482981] [    T125]                     asm_common_interrupt (arch/x86/include/asm/idtentry.h:569)
kern  :warn  : [   93.489779] [    T125]                     sched_balance_update_blocked_averages (kernel/sched/fair.c:9949)
kern  :warn  : [   93.498233] [    T125]                     sched_balance_softirq (kernel/sched/fair.c:13021)
kern  :warn  : [   93.505116] [    T125]                     handle_softirqs (arch/x86/include/asm/jump_label.h:37 include/trace/events/irq.h:142 kernel/softirq.c:623)
kern  :warn  : [   93.511663] [    T125]                     __irq_exit_rcu (kernel/softirq.c:657 kernel/softirq.c:496 kernel/softirq.c:723)
kern  :warn  : [   93.518123] [    T125]                     irq_exit_rcu (kernel/softirq.c:741 (discriminator 38))
kern  :warn  : [   93.524134] [    T125]                     sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1056 (discriminator 35) arch/x86/kernel/apic/apic.c:1056 (discriminator 35))
kern  :warn  : [   93.531547] [    T125]                     asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:569)
kern  :warn  : [   93.539311] [    T125]                     cpuidle_enter_state (drivers/cpuidle/cpuidle.c:294)
kern  :warn  : [   93.546121] [    T125]                     cpuidle_enter (drivers/cpuidle/cpuidle.c:403 (discriminator 2))
kern  :warn  : [   93.552324] [    T125]                     cpuidle_idle_call (kernel/sched/idle.c:161 kernel/sched/idle.c:237)
kern  :warn  : [   93.559039] [    T125]                     do_idle (kernel/sched/idle.c:332)
kern  :warn  : [   93.564800] [    T125]                     cpu_startup_entry (kernel/sched/idle.c:429)
kern  :warn  : [   93.571342] [    T125]                     start_secondary (arch/x86/kernel/smpboot.c:200 (discriminator 10) arch/x86/kernel/smpboot.c:280 (discriminator 10))
kern  :warn  : [   93.577886] [    T125]                     common_startup_64 (arch/x86/kernel/head_64.S:419)
kern  :warn  : [   93.584604] [    T125]    INITIAL USE at:
kern  :warn  : [   93.588630] [    T125]                    __lock_acquire (kernel/locking/lockdep.c:5191 (discriminator 1))
kern  :warn  : [   93.595007] [    T125]                    lock_acquire (include/trace/events/lock.h:24 (discriminator 15) include/trace/events/lock.h:24 (discriminator 15) kernel/locking/lockdep.c:5831 (discriminator 15))
kern  :warn  : [   93.601736] [    T125]                    _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:133 kernel/locking/spinlock.c:162)
kern  :warn  : [   93.608635] [    T125]                    serial8250_do_set_termios (include/linux/serial_core.h:640 include/linux/serial_core.h:674 include/linux/serial_core.h:718 include/linux/serial_core.h:797 drivers/tty/serial/8250/8250_port.c:2760)
kern  :warn  : [   93.615969] [    T125]                    uart_set_options (drivers/tty/serial/serial_core.c:2239)
kern  :warn  : [   93.622513] [    T125]                    serial8250_console_setup (drivers/tty/serial/8250/8250_port.c:3405)
kern  :warn  : [   93.629758] [    T125]                    univ8250_console_setup (drivers/tty/serial/8250/8250_core.c:430)
kern  :warn  : [   93.636745] [    T125]                    try_enable_preferred_console (kernel/printk/printk.c:3882 kernel/printk/printk.c:3873 kernel/printk/printk.c:3926)
kern  :warn  : [   93.644337] [    T125]                    register_console (kernel/printk/printk.c:4120)
kern  :warn  : [   93.650898] [    T125]                    univ8250_console_init (drivers/tty/serial/8250/8250_core.c:516)
kern  :warn  : [   93.657715] [    T125]                    console_init (kernel/printk/printk.c:4407)
kern  :warn  : [   93.663915] [    T125]                    start_kernel (init/main.c:1148)
kern  :warn  : [   93.670115] [    T125]                    __pfx_clear_bss (arch/x86/kernel/head64.c:310)
kern  :warn  : [   93.676311] [    T125]                    x86_64_start_kernel (??:?)
kern  :warn  : [   93.682946] [    T125]                    common_startup_64 (arch/x86/kernel/head_64.S:419)
kern  :warn  : [   93.689577] [    T125]  }
kern  :warn  : [   93.692212] [    T125]  ... key      at: port_lock_key+0x0/0x40
kern  :warn  : [   93.699982] [    T125]
the dependencies between the lock to be acquired
kern  :warn  : [   93.699983] [    T125]  and HARDIRQ-irq-unsafe lock:
kern  :warn  : [   93.714039] [    T125] -> (fs_reclaim){+.+.}-{0:0} {
kern  :warn  : [   93.719030] [    T125]    HARDIRQ-ON-W at:
kern  :warn  : [   93.723151] [    T125]                     __lock_acquire (kernel/locking/lockdep.c:5191 (discriminator 1))
kern  :warn  : [   93.729625] [    T125]                     lock_acquire (include/trace/events/lock.h:24 (discriminator 15) include/trace/events/lock.h:24 (discriminator 15) kernel/locking/lockdep.c:5831 (discriminator 15))


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260320/202603200800.38a86c8a-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


