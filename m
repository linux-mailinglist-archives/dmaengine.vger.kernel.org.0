Return-Path: <dmaengine+bounces-5284-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3F5AC8810
	for <lists+dmaengine@lfdr.de>; Fri, 30 May 2025 07:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7ED11BA623E
	for <lists+dmaengine@lfdr.de>; Fri, 30 May 2025 05:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E151EB195;
	Fri, 30 May 2025 05:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L1XcjlvL"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD8A63B9;
	Fri, 30 May 2025 05:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748584698; cv=fail; b=LYrxNLvmVw81uy1O2hJQYoSdQGy3ezU6JcHFImP9ZNjoIpQ+hxZJHH1OGM0Mv6QE/j0+iSZJj0VXSPieOxQan67jgUVQDRQEDIC/+nEMj7qEopmkYTpcTcUtVTMB0Sj7esBuKsN8GA5uX9VlJXkQOD5w2OYjwapygSqXWXBrcNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748584698; c=relaxed/simple;
	bh=S9FsslOHgFsccY3wIrQd9idZFfrOLo7EIceZnIQ1eKI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AJCmfH6TtEpWQ+vwSzoGn7o/SOX+N+MkVCsOLFmHrlTUW3VRuZHoOMhZDa5/X1m1HfPtmbVzDCsBM5lckq99wc7IY+AhgZVloNyrLoMdjF+UKVHwDqT75uB+DbF4JRXUP5XYtfX2UHqxJmpwige42C9lzFnZj2qAsAy1qIgr48I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L1XcjlvL; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748584696; x=1780120696;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=S9FsslOHgFsccY3wIrQd9idZFfrOLo7EIceZnIQ1eKI=;
  b=L1XcjlvLSv5VebW61GHQ2WjfEQK1JC/CowE0tQ9oi4kmHPDPb4XK+nok
   f9ALPumgD4CfyQKn+sGUqE2Pd3TLz9NaZCMVOEXUYdKzpMNL7jIUJiPp3
   3Ry8E/YmpWo7FHhjuwv+XMCXiJFSC/oClz47IkWlfYBPoV5IelIwtDnQy
   j8ONj8G1BR4/60D9rz035QMp/hkki+3uywnrTWlKKdhadMAAxxtMsI8kD
   KvicC3cJR66UbMq3BzmiheSVu+UC0511oO8sjkyV9B+b+xMQl3tWEIjPP
   QIqL1V2Lslf/A/LbawUHNYrFiZJLZjVCwJL1DHMybmOF8IU4sDHW2aBGX
   A==;
X-CSE-ConnectionGUID: YnDOBHnxSca2nJyK++I5dw==
X-CSE-MsgGUID: 8UfeJHJHQ2CiZhMRla68NA==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="50538699"
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; 
   d="scan'208";a="50538699"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 22:58:15 -0700
X-CSE-ConnectionGUID: UdMIiPLYRU23k3unv1l29w==
X-CSE-MsgGUID: od9N6jNTSjaT+QRaeHS30g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; 
   d="scan'208";a="149052515"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 22:58:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 29 May 2025 22:58:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 29 May 2025 22:58:15 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.48)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 29 May 2025 22:58:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvd79iOPjFzMrlNCh9UnDEyNjscRbLMnu3vLrM660K2xMmGw2z9IIt4sZcGhFdUFxV2O5rf7NXqUBd3iC7+xnjBRpUuNbHJu7D7DdiemBi8LKv+8q656uShKCSG4WpJLa4pVPFSkGk+mP89H0nDeA483Fq5+IdJmFRzTg93OXBweryyTmauhf0Go/k1c5K0R4aA5jmWHrMHjx3JB/8v19JkolnpaI2eSVOh66zgMc0U6IFlRhEFlITM5feii/HW5fhcjxnZXnyaFykkslyiKUpQg9xyPH6WmSSDkn73VpHSksZ3GO5QCNcarZeXxwdM3tAr+iMcZuGkocZ+VVmbnaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ia6aZPa2zBQresuVQKjDJMIEKSiWMObSiVZ1C3Zjweg=;
 b=somVEPjJ+9l5R1wJy4TcrczcSKS3q/PV3PpVW+p0TO0vITjMy4TIts3pCJhwPXqNuWSWJYCZyXjm0ITvuamuBi9JXFYa66DBnOkepyDLMvr5pNriYYbwe6R+/UIlxznqU9bcaK6S1OV6a3uWRL+WMHs56uyvPM9+chWSEFOdAf8i96EbZC/JQl1yPPT15wt8MvpXBOXZI7wP0i5G3pzOzzzxr2G3JiM4J5668fb9rIw8aPJhPIjyuCzBrgCUqJFYxCJTkwC4itXnbbQjbx608cA2OZEByn1e4xLu/eZxNq/WaB/6b0U33gw9kWB/lX4plbNEYniVV/EkvXIewczXqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6363.namprd11.prod.outlook.com (2603:10b6:208:3b6::5)
 by SA2PR11MB5115.namprd11.prod.outlook.com (2603:10b6:806:118::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Fri, 30 May
 2025 05:58:12 +0000
Received: from BL3PR11MB6363.namprd11.prod.outlook.com
 ([fe80::6206:bcb:fd57:6467]) by BL3PR11MB6363.namprd11.prod.outlook.com
 ([fe80::6206:bcb:fd57:6467%4]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 05:58:12 +0000
Date: Fri, 30 May 2025 13:58:03 +0800
From: Yi Sun <yi.sun@intel.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
CC: Vinicius Costa Gomes <vinicius.gomes@intel.com>, <dave.jiang@intel.com>,
	<dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<gordon.jin@intel.com>
Subject: Re: [PATCH 2/2] dmaengine: idxd: Fix refcount underflow on module
 unload
Message-ID: <aDlI69HGnflsD-ss@ysun46-mobl.ccr.corp.intel.com>
References: <20250529153431.1160067-1-yi.sun@intel.com>
 <20250529153431.1160067-2-yi.sun@intel.com>
 <87msav9wm6.fsf@intel.com>
 <aDkgxCsCtsEugTdI@ysun46-mobl.ccr.corp.intel.com>
 <78dd14f8-8344-49a4-95eb-14ff005c5ba5@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78dd14f8-8344-49a4-95eb-14ff005c5ba5@linux.alibaba.com>
X-ClientProxiedBy: SGBP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::19)
 To BL3PR11MB6363.namprd11.prod.outlook.com (2603:10b6:208:3b6::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6363:EE_|SA2PR11MB5115:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ae04b55-6e9b-47f9-ba1c-08dd9f3ef605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDZsc01vTTE3cFVDeTgrc0Zwd1dod3dnTHd2N0w0RE1kT0srUEtKR1hLNkZk?=
 =?utf-8?B?QTh1VFlCSVRKYTJudXBCRW5UZEQ2cjVJclQ3WW4vdGtEbGZKalU3eTgxWmsz?=
 =?utf-8?B?TEljRENFMDFGa2psV2dVNStCT0pkU0RVMitHeWNaT25oN3pRWWpsZCtQaEs5?=
 =?utf-8?B?UTlHRFRaM0ZmdTdWbDErTFpXTHlSMFlSRVQzRGRsb2VjK0ViRGo5b3NGdmhV?=
 =?utf-8?B?dkZlVHFRaDBpSjM4OURjbE1jSUo2QmtNQkRDZkxFbnRxWFZKMklqSlFrWmxY?=
 =?utf-8?B?dVdLdHZKT041M3Z1NTY2OTFGVmJScXhrMDhyTi9aLzdyNGlvU3ZvRnNobE85?=
 =?utf-8?B?dXR3cG9tNGNKTDBkM09XKzVodEpaS0hMNUNFWXRNYkJxSFNtd0tHVW9KazBs?=
 =?utf-8?B?bXIwbjU1d3d3WnJlWVl6ZTdNZ0dISXpydnlRTkxzSDdWWXdEcTJvWVFmRjVR?=
 =?utf-8?B?WUpKZjAyU0JUeEw4YzdqVldGdDdmNnBhL0VDc1JjdFRwbEZSVGtTODNOSTJI?=
 =?utf-8?B?MWxxQkRqZk9XWVRmMk54QnlwSVVJc3RDdUFxcUJOTmkySGFlZG5wTm1lOFFN?=
 =?utf-8?B?ck5qSzBzNVNXaVl0cFc2dlNHbm9yMGJEQVpYd2t0NUdjY2tSZk4yNjFMOFJz?=
 =?utf-8?B?cGcxNFJLLzZneU1pYldNN1NYODdXeXBnWHNPc29EdEM0SE1GdjN2andrOHJn?=
 =?utf-8?B?L3I0RXhHbDFQTUcvMm9HNkJaNHJrL0F4Q0JxRTJGT25ULzFVdUg5RE5JVGti?=
 =?utf-8?B?NldiZVg1QVpiUkVKYzJZNjVXTmIrYzhyeFpHVExRR0pPajZ6TlM5UEt3c3Vu?=
 =?utf-8?B?SjR5WGJGSFFBZk5nb2RJeEs0RlE3Sjd3aWwzTU9OajJoS1d5dm9aVmFTc3NO?=
 =?utf-8?B?KzRrWEhWellRVXBseVc1U1BVZC96Vzl0MjZ6eE9BNzFnWEF6bGZaZ2JuUTRS?=
 =?utf-8?B?ZzdrUDh5RWxjVUpZcVZCWHNBRS9peUlXbE5uRmptY3RvWmd5WDNxMHNjODFK?=
 =?utf-8?B?c0NzRm93ZzZzVWkrQmFjMkNVWVFybzF3TnI0UnJjWDFPeXNyK24zcVo1VmZz?=
 =?utf-8?B?WXBJYkhLUjFkUktwaUV0UGJQbTdRd1pITHQrU1pWWUNmNVRGa1pMU1h5ZFcw?=
 =?utf-8?B?ajlTdGFKZ1NZVldMbFRWZ0RGS2xUdGthajhJaWlLOHUwd2Z6WGY1NW1PUm1M?=
 =?utf-8?B?T1c3dU5VakhHRGNEazZ1S093eHBjMUlCREJUNEdjV3NyRXJickJZdm9BZUdC?=
 =?utf-8?B?WTMreUxYL3dzUkt3b05mMUExbW4ycE1COU1sbzllZjU3dEd1N1ZneklQSkNX?=
 =?utf-8?B?Rkc4M3lIWkR0STJFb2NUQ290eVRXVWtKc3VZOUdiRFN3blFJaG1YY0tsbnlj?=
 =?utf-8?B?K1B2b3Ivc25yeWFCS05jM3FqTGtpemxuY3JuczJjZXhoY2JOY2QyNkluMzFH?=
 =?utf-8?B?ZTR5MGZlNjFQMUg4aFVvYlM5THdQL2lSZktVbkRVem85aS8yWnlZWEtSVkth?=
 =?utf-8?B?bkdTZithODlSWFh6ZVlqTkZQWnRNTEhMNnpMdUFCUjFkSHhSYU5ac2JCdFVo?=
 =?utf-8?B?c0p3dTJ6SUMrNVBNYyt3c2l4VXJxOVhIODVQalZERzMraUEzYkQrWVM3Z1VY?=
 =?utf-8?B?QTVIMmIxZ04yajFwdFd5Tjd5OXA5TUx4SDVvTDJMUEQzKzYvelJpRy9pODdl?=
 =?utf-8?B?Sjh6c1RQcTZtT244NmNyY3ExYnVBOE80a1Jhd1k3Tm9QWVBlcStaS2crY0o2?=
 =?utf-8?B?QlNEb0NtVGw2Y0NySHNWWE9ydjhnaFNsbnRzRngwNG9yanN3d0RTYUE1YkJ5?=
 =?utf-8?B?VVdPWUxUMjA0eDFwWFk2UWIrUzhjV3hzOWdycWZPZXdkemtPYW5kYWFHSGU3?=
 =?utf-8?B?Q1NOUUN3TWx0MHdzbFJVa1hKenVZakU0aVcvcXNXRWRKWUlJVlh4YktTVEJv?=
 =?utf-8?Q?A1QxLvu3mt8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6363.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aE1qaTBURytqbE5VRkpGZTIwallLZzJXb3VOTVFrQzk3UXVKdEIvTllHdkhS?=
 =?utf-8?B?VnhEZ1N1dGh0MTFtdk9OeUZMZ0IvWkoydWhRb1NTNWQwS2ZaL2hYa3BaT0ls?=
 =?utf-8?B?WGZHRFZRUXdtNUZzNmFYL2FwN3NORFdVUXJjMFRLZTRBN081dlNvSlNYZW1B?=
 =?utf-8?B?YStZUmdzRllra0FGSHpGNnEzTnNjRGNBeGwwSUQrWEtsdWV0SGJSSjd6YlFU?=
 =?utf-8?B?anVGd1RtK3N6NmVoL045c3M0ZzlKVmpuSk55eFcwejkxUDFMemlXVjEwbXdl?=
 =?utf-8?B?WWNER09YOE1FMG10aHJYeG0vM0cyazlydTVkL2h0emFFYThiM2UwUUJ4amVw?=
 =?utf-8?B?blFZRXhsSGVaY09PdzRYWElvdUxXcUlVZGU3anpSOHd4ZG5WanViWHA1NFRo?=
 =?utf-8?B?NlFPVklRN1kzcDlyMGJwaURFVmpNUVlVMnhCZUpFNWI0emR2M2pEZEk5SDkx?=
 =?utf-8?B?WE9PZlp1WlI3QUZkOXpYdFpDNlNnc2lGS00zbWJWSG5qcXByMTJXOWJmUnpJ?=
 =?utf-8?B?TXhlS0UwM3JvSWZHS2R0Y1VQaXBhOGdHQ0ErSHlSbFdZZzN6RDlsRWxBakp2?=
 =?utf-8?B?VkhRZzViQTh0TVhGYXBjc0Zmcks4YTlLMmUrZnVibDlmRU01elFKbVAxWVg0?=
 =?utf-8?B?RkZRdXBnRHZ4Rkx0dEQxa21OYkVVMFVKWGp6RXM2TEVqdlpiN2dFc1JqSTJl?=
 =?utf-8?B?eEt0N0JLWUpCZ0Zkd2dTUGpkQnFrc0FXV2ppQnBoWWZoY3VxT1loMG00UWVl?=
 =?utf-8?B?cEV4OUtmT1FlZ3dJYkF2Vm9FcmtQVGNMQkhvVm9hd3JONnZRTDhUMXRpbjZk?=
 =?utf-8?B?R2VXYUxrVi9PbHU5bHIvTXg2aDYrRFBITUVHRmtRS0VWMGRTRGlwTU5mYndZ?=
 =?utf-8?B?elZjRFBHVGpWOXlramQzQWhrdWIweWh1RDNnckFlU3JHMUo1NTI1QVBjSlIx?=
 =?utf-8?B?S3V6Wk50SU9TTVZnYjJXTVYyZnpPVW5PQ0tMcFBIQ0l1cktYVkY4L3E2dEpX?=
 =?utf-8?B?TE5sd1ExRFZZdlZkcVhYMXRtS0Y1bzRFMmE0N2xPUThobkQ1WEFuU2kxNFB1?=
 =?utf-8?B?V2taVCtmOGd3WmNEVFRUbHJ5ZUwvUWZmOHZIWUZhVDkzY20xUVQ3Mk05ZGZ4?=
 =?utf-8?B?cXFRRldET1N1c2FKdmkvMGtHMWpMUFJnbi82MGRpL0IxMGJMUlQwcFZ4UVJE?=
 =?utf-8?B?U0NLeFozYWhONWR2SFJUcmlWa0VwTzVNMkhjUXNUSXV1UkxJOWRDSXd0Vm1a?=
 =?utf-8?B?WGFzZ2ZXdVpNQWdvNEY3RXlTTUZsSXY4dFY4ZVlhUjc4eEJkSXNIbVdIenZj?=
 =?utf-8?B?SDYwdWZVbVFpWnVjNVBNa2xQV1o1T2txTGlRU2xFWDczV2dRTjJHOWx0L2pL?=
 =?utf-8?B?WWtLZC9wT25oZjBqYmRxRFRpZ25kWEYzNSsvV1E5K01oekRWNERrQVZmeTJK?=
 =?utf-8?B?cmpTenRWaXdmT2RycUZuMFpmSXU1UnFnbDh3OVVrdjV3OGZlOWd2OVNCNTNm?=
 =?utf-8?B?YkpwQlMyTUttbkplQTE2N1pUakNQVEs4Kzl3L2UvMFhYdmZMaUVIL2M0MzhB?=
 =?utf-8?B?SlFOSndaQlRxR0pray9OL1JpYnpvVUtGclJVK0NTV2l1MmFlTjNULzJHaE9k?=
 =?utf-8?B?cVlGdXN5dkwwN29MT2M0bS91SVNIK21PVDRHMCttb0tsUEFHVUl1S09hc3li?=
 =?utf-8?B?eHkrN1VxWkc4Vm5hRE5CL2l6c0Z4a3kxUlJ1T0NYVzkxNWFwcFlsV3pmZHNj?=
 =?utf-8?B?M2EzK1FnSTBkZGlhaDlYVFlIL0Jsa3ZySFNoak9BVnJTd05MUTU0bXRpZC92?=
 =?utf-8?B?OUpTSjJRSW9FY1RBWkxpaUp3NFR6dFJweGVEVFhuYmpsQ09FamhYK3JLd3gy?=
 =?utf-8?B?Z1RJTHU2ekdPeVBkVWpEbWRJTE9HWEI4S0tuVE5CTVhRZ2pSdFZSUTNKdEJ3?=
 =?utf-8?B?N2V3UmI4a3diSk5hdGlDVHhvSm8xczN1bVlXRlBRNW9nQ1pyZjI3RHNPL3cw?=
 =?utf-8?B?bFlESUJraU1QMDFBR0cxbEJvelBaN2o1QlVxZUZvdCtaWDRDdHBWUUszRG9p?=
 =?utf-8?B?YitvVVhIbVUxanBmN2JmeVl5b29Yc0I0aFpkeEZmdDc0MTdjNmVuRS9IdlJD?=
 =?utf-8?Q?GdgEgOi2AGHemYESMCH540Qem?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae04b55-6e9b-47f9-ba1c-08dd9f3ef605
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6363.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 05:58:12.4463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NdJ7Si1fG/VjGF4hjVGtekdLxFoICICIUP1Fk7+vp1/ADHzPdJ3ZFAzo6H9rDJObL0gtkAUTDdsFv+t7Ukic6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5115
X-OriginatorOrg: intel.com

On 30.05.2025 13:39, Shuai Xue wrote:
>
>
>在 2025/5/30 11:06, Yi Sun 写道:
>>On 29.05.2025 10:04, Vinicius Costa Gomes wrote:
>>>Yi Sun <yi.sun@intel.com> writes:
>>>
>>>>A recent refactor introduced a misplaced put_device() call, resulting in
>>>>reference count underflow when the module is unloaded.
>>>>
>>>>Expand the idxd_cleanup() function to handle proper cleanup, and remove
>>>>idxd_cleanup_internals() as it was not part of the driver unload path.
>>>>
>>>
>>>'idxd_cleanup_internals()' frees a bunch of stuff. I would expect an
>>>explanation of when those things are being free'd now that removed that
>>>call.
>>>
>>
>>I believe the call to idxd_unregister_devices(), which is invoked at the
>>very beginning of idxd_remove(), already takes care of the necessary
>>put_device() through the following call path:
>>idxd_unregister_devices() -> device_unregister() -> put_device()
>>
>>Therefore, there's no need to add additional put_device() calls for idxd
>>groups, engines, or workqueues. While the commit message for a409e919ca3
>>states: "Note, this also fixes the missing put_device() for idxd groups,
>>engines, and wqs."
>>it appears that no such omission actually existed, this part of the flow
>>was already correctly handled.
>>
>>Moreover, this refcount underflow issue appears to be a a clear
>>regression. Prior to this commit, idxd_cleanup_internals() was not part of
>>the driver unload path. The commit did not provide a strong justification
>>for calling idxd_cleanup_internals() within idxd_cleanup().
>>
>>For reference, the both two related bugs produce nearly identical call
>>traces, and I think both are blocking issues.
>>
>>Thanks
>>    --Sun, Yi
>
>Hi, Sun, Yi
>
>idxd_pci_probe_alloc() {
>	rc = idxd_probe(idxd);
>	rc = idxd_register_devices(idxd);
>	if (rc) {
>		dev_err(dev, "IDXD sysfs setup failed\n");
>		goto err_dev_register;
>	}
>// ...
> err_dev_register:			<-
>	idxd_cleanup(idxd);
>}
>
>We use idxd_cleanup() when register devices failed to undo the
>idxd_probe(). idxd_probe() sets up idxd groups, engine and wqs and
>get reference counts by device_initialize().
>
>what's the difference between idxd_cleanup_internals() and
>idxd_unregister_devices()?

Hi Shuai,

Prior to the commit, I meant the function idxd_remove() did not invoke
idxd_cleanup() or idxd_cleanup_internals(), and it was able to handle
reference counts correctly via idxd_unregister_devices().

However, the code refactor introduced the use of the idxd_cleanup()
helper, which internally calls idxd_cleanup_internals(). This results
in a duplicate put_device() call, leading to a reference count underflow
issue.

Thanks
    --Sun, Yi

