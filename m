Return-Path: <dmaengine+bounces-5471-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2408FAD9BBA
	for <lists+dmaengine@lfdr.de>; Sat, 14 Jun 2025 11:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EF047A59B2
	for <lists+dmaengine@lfdr.de>; Sat, 14 Jun 2025 09:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934C41E991B;
	Sat, 14 Jun 2025 09:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JAyS/LaK"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFA91C3F02;
	Sat, 14 Jun 2025 09:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749892850; cv=fail; b=aKB4oiF7MrMZdLKUoeb21wA5xNIjFAxmMeXiI/znAIsgOA5I9lv3TOjGqqAr9Pt5EDt4Rbw8Rufgr3gaoRIRETnOLNLjND/vkfgbcn35ljW6Ki2A7xA6WDyHiPqS6xPVKVuLHkD0YuJBcE1qB7MUxtjcyAZ5yNjgbMvGR0NX7JY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749892850; c=relaxed/simple;
	bh=zqahm3QprKE6K90nhKP5sgcnx1Nfd7m9UCaB4Q5YzAY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eCePrGjtBx70ZJJs2C3Rg6RM4ZTVzdiVtwsjuSGfhK578Rj3qLA1oyo6dQcUypJpkOXlAnDP5okc0UcBYtazr+pUhP24wveajlfgYmpRKDK5xXyNXUees+pINtUomGTpaKCRB+jC3q4/tu6q6D1LASwzw7geGZy2gYAjEBrYsLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JAyS/LaK; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749892848; x=1781428848;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zqahm3QprKE6K90nhKP5sgcnx1Nfd7m9UCaB4Q5YzAY=;
  b=JAyS/LaK9UDas3pHU0GAYLLyd50boQ399yblAmxyv3zQc6aXIIkLakDy
   w1zl9br62wTVewaLzJ4XH3rDFp6DxcKGFnFeJuYIyIVJRI/p7YrxhrXIG
   qj9/qd5VMoJH2SrDx/Y53U60DgQkQeuiQoQTzIuFVwxIFLxh8iQevLSGh
   u33ExbtIsBff+KMZlMj6DoC52MEw9Xwrj4zP4qQFQEJ1LfeKLpAiJQozX
   Zs0XtG94ijmh5LZQhCMmb3sYJ0I9HedMHS+1rgq5FUsJWZlq0IgV6Ta5x
   BF7Odud/PiNj+UoZoTvaxUQ6CZa44U8LXZOa6SxUNteEk6SNurnNavF1E
   Q==;
X-CSE-ConnectionGUID: VcyMlFlXTzK0lR2qQfXBKQ==
X-CSE-MsgGUID: Snd5qVRgTXKDL8MfoM6YjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="63455265"
X-IronPort-AV: E=Sophos;i="6.16,236,1744095600"; 
   d="scan'208";a="63455265"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2025 02:20:48 -0700
X-CSE-ConnectionGUID: VEdPq2hJTZOnmnbDTZtxsQ==
X-CSE-MsgGUID: Q3V9aMMTTICLjCn9C1EbnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,236,1744095600"; 
   d="scan'208";a="148406950"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2025 02:20:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sat, 14 Jun 2025 02:20:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sat, 14 Jun 2025 02:20:47 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.42)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sat, 14 Jun 2025 02:20:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EhLBx+QVpPcVY2/WKd5waARROZaTnZSTpUKtUHvac7VnFjWhNMndIgYj4WGhZ7BjeGgEFH8k2WtG3wmzkRvt24ye/9NAoXgdxLjXLzZ8tXR+Ym5zgIyLt6kPLTBAZdsg3xiiXoLMqwE/tiyGGYuybwwdqQWTJHDqFKdh4gZDh+7QMjNSkJ4YPWC9RqaFQDoXE4d3ZRw64hj8vJqtg1A2jrWoaiuxXR8w6+bFGI/bSmpuB4V3qL8DKVdrwIlbArjvqXpt7qTBOGpOGBWvl8ubv/FwL8PVGp1sDphMSB1jC7P2HPgEr5fKBQvXSC+O33Iaj+ZVYZxNKFOOXahlgQFiXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hF/ovId+ZHV5hyKeFHXDLdysx/Ts6BHCY4Xg8eUYk+Q=;
 b=jfnLjiGIwFsd89f1hwcDNiSW6Y4juJE+bRd5Z9ROebUVg5AYjH+i+z/eqybL5xlKJWeQuLz2D/1ZGou2sRbZ1TKPpl74uhT5PyLYq8ZKCLC9T9kGpKT6YMjZtVeS7rUGnfBp16O4pnlDnTHrHqHLrboQCrqiBLqmz+9pCfBI1SilI959l+6eiEyegUl+E3kgGDBL+SSPhTBpcsIM3obGqiVRWRjn49vD2Kb79COWPEbkrEXMSu/2eB8D2sgyu9UoxjwScLYYj7D46DnFLxgfzBeaCKyKCabDPDGNGk9OcI+YtZqAx/RrHInfZoHjvBno0dJqkoP7344ufeYR1Fu75A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6363.namprd11.prod.outlook.com (2603:10b6:208:3b6::5)
 by SA2PR11MB5130.namprd11.prod.outlook.com (2603:10b6:806:11d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Sat, 14 Jun
 2025 09:20:44 +0000
Received: from BL3PR11MB6363.namprd11.prod.outlook.com
 ([fe80::6206:bcb:fd57:6467]) by BL3PR11MB6363.namprd11.prod.outlook.com
 ([fe80::6206:bcb:fd57:6467%6]) with mapi id 15.20.8835.019; Sat, 14 Jun 2025
 09:20:44 +0000
Date: Sat, 14 Jun 2025 15:56:03 +0800
From: Yi Sun <yi.sun@intel.com>
To: Fenghua Yu <fenghuay@nvidia.com>
CC: <dave.jiang@intel.com>, <vinicius.gomes@intel.com>,
	<dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<gordon.jin@intel.com>, <anil.s.keshavamurthy@intel.com>,
	<philip.lantz@intel.com>
Subject: Re: [PATCH 2/2] dmaengine: idxd: Add Max SGL Size Support for DSA3.0
Message-ID: <aE0rE5hhMM1wNk8R@ysun46-mobl.ccr.corp.intel.com>
References: <20250613161834.2912353-1-yi.sun@intel.com>
 <20250613161834.2912353-3-yi.sun@intel.com>
 <a3caf088-3a47-4036-85b6-906141f6b17f@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <a3caf088-3a47-4036-85b6-906141f6b17f@nvidia.com>
X-ClientProxiedBy: KL1P15301CA0066.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::14) To BL3PR11MB6363.namprd11.prod.outlook.com
 (2603:10b6:208:3b6::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6363:EE_|SA2PR11MB5130:EE_
X-MS-Office365-Filtering-Correlation-Id: b56f2384-84d6-4858-0eee-08ddab24bd8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elp1L3pCZzhFd1JnL1FKSHQ1R2g2azhBTUkwMGE3UzV0NS9DTkk4S0U5VzZ4?=
 =?utf-8?B?cmxVTHQ5bXIyREo2bUV5eVgvTVMvVjVSQ2pJbEZYUHZqaWRLQ1lVakpMcmtG?=
 =?utf-8?B?VlNBZ2pURllmYldTeCtmN3Fodm9GVUxQUU05ZkxXT2hKcWlFbGxEcDlaa1F5?=
 =?utf-8?B?Z1RsV2FXcUhneGRQQTZWclh4eUZ1cUt6VXkwRDdHTGoremI5TExqWEppY0Z3?=
 =?utf-8?B?TFlTNVBTTU9oM1RnK2JDeU9wdkdhTU00K1k3YmVPMEliMXNiVVRMaWVyK2sx?=
 =?utf-8?B?SlFMTHgzekZ6SHVlcHpldDIrT2Y2WXhqcHVBVEZzeWlzT3F3WGs4NC80WE50?=
 =?utf-8?B?d2RibjNVZGhEYXNpenVQZjR5MUxsRUNMKzYwaHppNEZxSzRDTDdrOENCR1F5?=
 =?utf-8?B?dC96VklOanVHWVdmdlpPU3lwazMzOTRWU0pTa1NXdWxNZk9OWnQ5NVdYSVZD?=
 =?utf-8?B?VjN2clQ3WE0rdnFjRlNENUpVbU9pVm1pYnRycitjMXBNblVUQVBMeFgxVDJY?=
 =?utf-8?B?SlVtZUs3eUVDcW9MU1ZRTVlqODZnZGNxWGFUazZIMkhOa2dOc2JxRHhaUWJt?=
 =?utf-8?B?NnBYZDFtcFY0dldGcWY2VWJ2eHgrS0JSMTVDYkZnRUhRSE9CYVUzWWNnUXJ0?=
 =?utf-8?B?YWZHQUNIZ2hsWGI3eEdNZ1k0dmV5WlVjSkFFNjROUzVWQjBBUzl1d0xRQitK?=
 =?utf-8?B?a3o3OTBzbU83bEhBUktuTGxiT3dJYXFnRmZ5R0pPR3JRYmd1ejZwSXl1eis1?=
 =?utf-8?B?NC9yVWFsU1VScDlFYkQ5eEp1UkVPcWVROHhrbzlQUTUrZmpTeGZGZHgrMGFq?=
 =?utf-8?B?WXo2UEVMVnVPRnYzYmF1Z2NyMWtTRm5GNVEzL0VTZFpJY1FuM2JIQ1c2UGVJ?=
 =?utf-8?B?M25NUWQ4aEVrOUJZMk5sU3Q5S0dDRU5qS3h6clpYWHUzMjgvUVVYQTJkMjBh?=
 =?utf-8?B?bm9xRGdyTGVrZyt5cDB0dUIxMlVVdzM5RG9QNmYxZnVNbC9WNHltdUt5SVZE?=
 =?utf-8?B?T1JuNS95TWNFNTJZWUljczN3UlMyWW9pOXl6NTY2eDAzZHliQm1zRkZiWE9a?=
 =?utf-8?B?VFVhcG9MS3k5OU1wTG5YUWl2ekdqa1g0Tm1FeXFrTWtRbDNzWUVYNFN5bE5U?=
 =?utf-8?B?SVdJZDdGbWY3ajFRd01WSnZoSE9zUGlhMWxIbys1cGl2amp4RGRqMGN4QkVE?=
 =?utf-8?B?TmhBc053STZzNlZrb0Q1MFJlVER2bzRJMDh4VUt5OGFqaE4rZHdaSnlCRWFz?=
 =?utf-8?B?bVJOK3orLzgvblcvaEZ4Q2dFcjZPeWx4U0dhZ00ranQ4eTZYMkRkeGE3OU1z?=
 =?utf-8?B?WVRyYzBRelZxNWhFNVJmdWthVmUxdUUxTUFHYkhWTUJwVVRHR1dUMmZ4UkRR?=
 =?utf-8?B?Zk1FR2xoS0JnWWNyRFAzNm5xT3pFN3I1a3hmb2JOUnZZd0J6V0JCOG9ySVF1?=
 =?utf-8?B?Ym1aNkFSUmRvSDE3ZTM0bktBYUk5Ui9mNXpqWnRQR0pBcWdiMlo0ZWpVZnhr?=
 =?utf-8?B?U1VNS0Nvai9TQU02ZkM1K0h3RWViUlVEL0dYanBrcmdyVjJqc2FIMHAxNll3?=
 =?utf-8?B?RGlPNlB5U2NCVTZDVXVjSGpOczBqUFhhZ2t4Z1VQQU8vRS93Mm81aEM0Y0ds?=
 =?utf-8?B?NDAzS01uVk14OEhSOFJOb1I5aHphL25Vc2tYanBpWDhtSGpBMUh5U3RESFBi?=
 =?utf-8?B?T1M2TWxobGFPYyt6V3BNNzN4T0YzRUlpRVU4Rk4xVHkwSkphNUxTOXM4OHBW?=
 =?utf-8?B?b1B6cVcxbXRweFFUazQ5WWFSQ1lmNDY4UG5kUlNuaDNrZnd3eEo1MDhkSk95?=
 =?utf-8?B?cjRHYVJtRWU1cWNNb2RwY1phMEp0QjV2bGxRUTdQZzJSclMyRzJQazlsUHBt?=
 =?utf-8?B?Z3RXdzVlR1Z3Y3Y1VWgvVW5uQ3JjZmdkM01iZmJza0c3V2Z1YnB5QWZ3ZEJs?=
 =?utf-8?Q?O5LHnrK9YKQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6363.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlpsTDcrcVFqZ3ZjNDQ0MlRxSnN4SHpaRExIZFVNZGRFNXhaRUFvN1k0NVRO?=
 =?utf-8?B?bUdHbk5iR1AzSFpZSHhEYS90clRkMFpZTzVkK0kxa3FJQVRmL3BJSThYTDB6?=
 =?utf-8?B?cjNYNzk5Sm4xYVBDYXNvSnpsWjVVdzNzZGQyTkFzb1JkczZIR3NXQ3ZBWjJF?=
 =?utf-8?B?N2dyQU4wY21XenYxN2xrTGhSSy9ORlhIZEV1WS9TTjRKOExRbEZveHNodVo2?=
 =?utf-8?B?SVhlQ1NyNnFjVHpTNWVGV01uYXgraTVLQjJscFVDWXRZdnlEQXd2OFB6MEZH?=
 =?utf-8?B?WllZMjNXRWp2ZEw1ajY1RHA5SnFKUnhwKzNieGxwYkxKbkUxdmFMVk9yL09M?=
 =?utf-8?B?aFpGTVFsTTh6SUJpbytTeEdmK3dnNGFlZmExZGR6RVRpYkJSQk44VjFzVjFh?=
 =?utf-8?B?YmE0NGs5dmNpdVNzSWdVdTBLU1ZWdkViRnMveXY4UUc3Rjh2Vm5PaXBYY1Vr?=
 =?utf-8?B?c1NLc0FsT2FFOGhxdW9FSnFLT0duRHM2dXBieWxVYXVmQjNZNitlNDJYZ2p5?=
 =?utf-8?B?MmlJTDFCblhqRjVJSS9DY00zclBUcys2Q0UxeVVCQVk2cGdzelZ1c00xQ2Z6?=
 =?utf-8?B?NFhDWXJ5YVNvRFpuaHBKT2hvWDBuUHhqcDFIcnh5UitDdlpzcmVHYmVXcGVY?=
 =?utf-8?B?a1p4cWFiUVpXSExmdzFOdUcxYTErcDQwNUoxV3J0R3lSZzRINUsySk1NblVk?=
 =?utf-8?B?NlpqK29VZzB0SjR3RUtRVU5INGxnWUhkVW9wZFBrRENBNlBwUlZtanRjSTFl?=
 =?utf-8?B?MkNHQjV1ZS9DZ0F1MjNmK2hFQmFXSzlBNWlsQmlVVk1HUjFLMXF1TTkyQVc5?=
 =?utf-8?B?bGlWb3pWbDZkU3lTZ3Qva214KzNoVG9OcGJteitxcUZoaTUySm4yS2pWTWF5?=
 =?utf-8?B?WHROanRPN0phemxxV0o3aU1SNmlSOHVGSEdkT20vK3ZJNXF0VFprOGg0Qnkz?=
 =?utf-8?B?QisvcEtqeXhxRjRIZW5TczRic1UxKzJaN1Brdm9oQVhqTTdXY0ZVK0ZIQlFm?=
 =?utf-8?B?UWNxZ0Z1eTE5Z21XaHltTUpsc2pObk13SDlKR3dSWHVBNmduU3JRdGJ2K0pz?=
 =?utf-8?B?eHFkL0FIU2ZmM2w3eTBQdTd6eHJmT1pzVXhjRGN4ZjVHZ0d1bm5EWVYwYitm?=
 =?utf-8?B?d2xNTG93L2VYbHR6MkdmMVZ5emZ4ZHhLSUhJdjNvQlFDWkZMcHQ2UlovKy9h?=
 =?utf-8?B?S0tmRXRMN05ycnh2TVZPeWUrTEQ0eGc4UHUyWmJvcVB3SDVaamRac3ZVSG9t?=
 =?utf-8?B?YUtMNnRWbWVETUhmMFZubzZiZURKZGc3MnJ0WVdaOEhLcFVpbGkxYzh3bEVK?=
 =?utf-8?B?OWtrMHRrWDRTU3JEd2NHQXNtMTBENjRRc25NVXNQVkc5dGZpK1NBNGJvcjk0?=
 =?utf-8?B?NUExZFhkM2ZYTVRFN3N3a3lGTHdvWTFwR2Z4MG9PSlFUYWF3Z3BYaXpmU0Qw?=
 =?utf-8?B?ZW9Rc2syZzRES3pyT0NmLzJqdGR1VU01SGdhbW53ZExRUVM3aEoxeEMzN0Zh?=
 =?utf-8?B?SFN6TXpOZWtTdzZYL3Rheit5Y3hXSVh3bGVEVFpRQzJyQ1dhUk5mcTVhaEhi?=
 =?utf-8?B?WmNJZHJRSlRyNWE5bEY4MThiSC9kZW1LRkdMMytNc1hjbFJPQm9UNFB3OGNz?=
 =?utf-8?B?MjBTYkhnc3RycUdNZDlueDZlM29TSC96eUVFaERkN0VLR2pldVliRjlEV0dW?=
 =?utf-8?B?dHZzYlZ1V1p4a3c3dTJaUnFnYldYYkVqMHoxRGJlRkZrdXhsWTFOeEsvOFlT?=
 =?utf-8?B?aHJBSGtQdWJEeE8yR3VkTHNuRmh3M2ZYK0lHUVIvRDIvbWl4WjVRaFRYY1Z2?=
 =?utf-8?B?bytJNFhCZ0poUUJodXplNitCYlVZOEViTFkrUG0wRVpXbHZOL0ZKNWVjM1d6?=
 =?utf-8?B?NFJpS1ViUU1QaXpwL0p5Z0YvbnRMd1ZHekpicVJJUGZERmQxOHhDL2ZrODhF?=
 =?utf-8?B?OFRqM0xGL3MxSkxlQWh3a0xXMHQxR3lRd1NNcWtraUJ6U0wrQVBqdlRyRUlF?=
 =?utf-8?B?S28vS3pxTDZOeDRkdmhab3N4cmpQNEQ5U2w0aG81MW9tclFLdWk4Um5Oc3lq?=
 =?utf-8?B?OS84dGRhbEk0Z05KNjJFSjlUSExsbjdWRTZ1VnozUDAwNEgyYkh3MS9Ta0tJ?=
 =?utf-8?Q?wsy//ixxP2M9t8N8kY7t2JHiU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b56f2384-84d6-4858-0eee-08ddab24bd8a
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6363.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 09:20:44.5050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kEM0GFtZsq0f/iKe0LVXwaURi3F8Wuq/p93L1qmKRDBYUG83ibUpr1ezN1JvAllrMJ34/c1fyCnyHVwYI54Ucg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5130
X-OriginatorOrg: intel.com

On 13.06.2025 15:03, Fenghua Yu wrote:
>Hi, Yi,
>
>On 6/13/25 09:18, Yi Sun wrote:
>>Certain DSA 3.0 opcodes, such as Gather copy and Gather reduce requires max
>s/reduce requires/reduce, require/
>>SGL configured for workqueues prior to support these opcodes.
>s/prior to support/prior to supporting/
>>
Get it.

... ...
>>  #define IDXD_DSACAP0_OFFSET		0x180
>>  union dsacap0_reg {
>>+	struct {
>>+		u64 max_sgl_shift:4;
>>+		u64 max_gr_block_shift:4;
>>+		u64 ops_inter_domain:7;
>>+		u64 rsvd1:17;
>>+		u64 sgl_formats:16;
>>+		u64 max_sg_process:8;
>>+		u64 rsvd2:8;
>>+	};
>
>Ah. The fields are defined here. I would suggest the fields are 
>defined in patch 1 because:
>
>1. Reviewer (like me) may get confused when reviewing patch 1 where 
>dsacap0 doesn't have any field but is defined a union.
>
>2. There are fields that not max_sgl_shift. So those fields are 
>irrelevant to this patch and had better to be define in patch 1.
>
>>  	u64 bits;
>>  };
>
OK, I see. I'll move this definition to patch 1.

Thanks
   --Sun, Yi

