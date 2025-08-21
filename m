Return-Path: <dmaengine+bounces-6095-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2ADB2ED0B
	for <lists+dmaengine@lfdr.de>; Thu, 21 Aug 2025 06:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E863B9FC6
	for <lists+dmaengine@lfdr.de>; Thu, 21 Aug 2025 04:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7565F2505AF;
	Thu, 21 Aug 2025 04:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mdPCEd8T"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7918423AB9C;
	Thu, 21 Aug 2025 04:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755751019; cv=fail; b=e2CI15ToXHB9kcV7QlsxJpS2PMwnayaHpv2mRcz4Aq+HyLTQIiP9Rjk48/+H9jmDJYQQ41moFHqfTyjAlXVzuwtYs91tKaoMulmkqZM6MLK8QZmCg6WeTECPL2C3QiV9S0iLLyk2I2CT16qKNdpQRAnWv1lTxbucTq8t/KEt8d0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755751019; c=relaxed/simple;
	bh=bSdUCP3yB/T4uAYYqHRqBCK28fj2Y1hWywEK4BfWmhk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P0FnHjiyOt/5cu0jKZnKS1ZY98lJRd+42noE+HU0QjkEu8BH1PZ4dWr+TSBsMs+tTG0Aelrw2LOkk1cvcX5Cu2Gv14JdxkfVmH3SzoLGfx+/SSiOuuT5PvMOTIUfcom+3fS2Hpe4wiAkVE/JYIcer4w+C05NSbgwfSPJf0vsTZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mdPCEd8T; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755751017; x=1787287017;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bSdUCP3yB/T4uAYYqHRqBCK28fj2Y1hWywEK4BfWmhk=;
  b=mdPCEd8TnGsKEzS0mZ+8y/coFdtqFlT1POcucl/fzskswJWUNTkBoB4R
   U0mIUBU/T7zHvOtPsmPm4y46ga6DxPO0q7/h9oeNTj+m1gT3Fsj5TOj0g
   dqhJaCgaUxVxfENn/OF/926i2YstLWSCCwRCKZDoxRbGdRKPwVQc+daqF
   4KXTCrUCvX1qBjh/uMnRKPJfw93ARN3ZU9yOnM2vIxCKAnYQAX+BaKfri
   K6F6gCXp15ylbE3bunYXjT6FuJfQ9zM5YiA7HUmzxjXFkkIAoLjdTQG60
   rXpXZvEZa94tco9CVhS7BbMDCb2OQd9M1XrRJQ+V6hlpf/YIda7SVWAcv
   A==;
X-CSE-ConnectionGUID: vkyUqxlWSa+DaK2l8eMaug==
X-CSE-MsgGUID: kfZPTf7FQpqcAV2ZI87FYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="69130706"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="69130706"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 21:36:56 -0700
X-CSE-ConnectionGUID: JdJpNmxOQGmy6tbc3h3uYg==
X-CSE-MsgGUID: tqHuWL3YSV2CD/h5rMzIBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="199296342"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 21:36:56 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 21:36:56 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 20 Aug 2025 21:36:56 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.79)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 21:36:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFDdxzrf9OD3LVbfSQfKi/aVcsAM98fmJBV7OimDiuS3WFCA65WtCwzFaojMsGwmBfJpbhp9mflpZv4V/4qP485qN7WtU3iH8WUFiIRfqqaZLxTZmXvc9zS/+1dwUVRmcsusyGNdS4wPsp79o99LGwIRq+RxsVk8zJl3sRdAY5TsQuJPAT84YysvwjmAg+WiHvhPMTzW/D+BrsEeLt5HPMkBMnU74nOd/2qbvAqHnvVooqn9VUrihw5pQb1McWp4+ciRVunEOIbCryC3ZY3ySC6mAc7mBdhcQr6lCWi//aaHcAg6xiwiaYNxIR2KugKHDTiezplncLTxbPXIuvMbnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSdUCP3yB/T4uAYYqHRqBCK28fj2Y1hWywEK4BfWmhk=;
 b=w/baVBNCJwIp2E7VDML05mBZXWiXvVdwY3k1hI4VBkpsM36YzWJFWUGcWsd5PWCX/wXMcsU+Cg4Mbh7uEvyJNT0dqM+1QV5isZkFqH0C6i4AslWLixYsjBIT6dqaaNjOsD4TP8OCb8F4DRljGWz0SeM95QikxwFNzwDRWZeLIeM3IoMmtCqE4mWkHQdmgGTeJWkfySDByKTclz9EWSHSLlZJdsMV83zPYeWfpwggs+YXQEVz4bWKTGGLI1Bd6NnV97XO2VBAnmj07DhU9PjRAudNzpgSc61XiLLCSXAgs8s178jPbgvuJKntwO0RayXnGlk+nSKETUtyz8JHODgltw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL3PR11MB6363.namprd11.prod.outlook.com (2603:10b6:208:3b6::5)
 by CY8PR11MB7363.namprd11.prod.outlook.com (2603:10b6:930:86::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Thu, 21 Aug
 2025 04:36:52 +0000
Received: from BL3PR11MB6363.namprd11.prod.outlook.com
 ([fe80::6206:bcb:fd57:6467]) by BL3PR11MB6363.namprd11.prod.outlook.com
 ([fe80::6206:bcb:fd57:6467%5]) with mapi id 15.20.9031.024; Thu, 21 Aug 2025
 04:36:52 +0000
From: "Sun, Yi" <yi.sun@intel.com>
To: Vinod Koul <vkoul@kernel.org>
CC: "Gomes, Vinicius" <vinicius.gomes@intel.com>, "Jiang, Dave"
	<dave.jiang@intel.com>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "fenghuay@nvidia.com" <fenghuay@nvidia.com>,
	"Lantz, Philip" <philip.lantz@intel.com>, "Jin, Gordon"
	<gordon.jin@intel.com>, "anil.s.keshavamurthy@intel.com"
	<anil.s.keshavamurthy@intel.com>
Subject: RE: [PATCH v2 2/2] dmaengine: idxd: Add Max SGL Size Support for
 DSA3.0
Thread-Topic: [PATCH v2 2/2] dmaengine: idxd: Add Max SGL Size Support for
 DSA3.0
Thread-Index: AQHb4eS14U7wzvXHSU+Eit9gOmuoELQRfYeAgE0bfoCADZOCAIAApBIw
Date: Thu, 21 Aug 2025 04:36:51 +0000
Message-ID: <BL3PR11MB6363FFF13063DD82898476139932A@BL3PR11MB6363.namprd11.prod.outlook.com>
References: <20250620130953.1943703-1-yi.sun@intel.com>
 <20250620130953.1943703-3-yi.sun@intel.com> <87o6ue6kf6.fsf@intel.com>
 <aJqizVCcYSL-4LOm@ysun46-mobl.ccr.corp.intel.com> <aKYGRC2TzHpnhRyO@vaman>
In-Reply-To: <aKYGRC2TzHpnhRyO@vaman>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6363:EE_|CY8PR11MB7363:EE_
x-ms-office365-filtering-correlation-id: 49f5c50c-7bb1-463d-e375-08dde06c598c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cW1Xem05V09qSzV3N2VnRXBiMVJVdFllb2hzd0xIVnp3KzRGL0pJd0xOVHRr?=
 =?utf-8?B?d05NaVlPbWdJMlpvZ0o1YW4vZkJvT3BXRHZtZUdSaDlqNytqOEc2ZVJwV2gv?=
 =?utf-8?B?cjhGTDFTbTNPNWFGQ2Y1QnBWM2pwbGd6QlRJdlRiV0oweDF3WWZNWmhHVkx2?=
 =?utf-8?B?QTZoQUdOeXFNOXBkNHdCQjRUZENzaEFmbVp3K1JZRCt2cE1ZTzNzNzRqWmd0?=
 =?utf-8?B?Q1UrZUZ2c0dlQm1YYW9yaFd6V3Nzc1RBUFMrMzlwZ1lPVjM1aFQwSEQrbVEv?=
 =?utf-8?B?MVR4Um5UZ3FlcDkxczB4QTRNK3J0eHBzamxhemRnYi9QU0JVNVVoTDJhWkZB?=
 =?utf-8?B?alJ2YTFscHVWWndvN1NlR3MzaGhicG8yRjJVUlRyWW90Q0xOdXZsUXhGR1BG?=
 =?utf-8?B?UVo1MXdQRWJ1VHpyT0RuM1JEaGpYbDd4ZEQyQXZyNThiSndOUWJTU1ppMnNI?=
 =?utf-8?B?TFhscUg1VFFiV0xHMmhLdGVuQmJ4TllLdnNtbnIwMUtndEVrL3o1THViS0k1?=
 =?utf-8?B?aEFkSW5hdFFRN252YTBlZ2pLNXVRVytLandYWjJmNDJvUWdseGdDZm10Umo5?=
 =?utf-8?B?YlFjWjk1K2kzZ2RDUjlBOGZCdjcxQzZyZmtpSlNnSGoremxoY1Uvb1ZtQmtC?=
 =?utf-8?B?c3lQUndGRytydjdIUTFEVktOQXZLODY4RTc3c2NiSTd6eXM2WnlnRVl5emUw?=
 =?utf-8?B?Nmt6b2lEczI5Mk1yR3RGNVdvNnZIVmRnZjJwSXJYSFcwaFJPNGxDQjZ4LzZF?=
 =?utf-8?B?Z0VIajRnVVo1REcxd2FCbFVqdUFEbk9nemZYby9hTG12QlJCNTRydHR0blNY?=
 =?utf-8?B?OFBNNEprTXJrbUtoMmpzS1FSTGoxL2pHeThzMHFxanBuMzRJM2d0Q0ZhQ0Zi?=
 =?utf-8?B?Yit5SzYrK2wrVmUrSkRxODcyeTNjbGI4czJLRjVlVUEzNXZPajNhL2pFUEQx?=
 =?utf-8?B?OThYWUt3QWFJTlpLWk5DbXZRVmJERE9DMTJjUEhQRldLbFpERUJsc3IzSWg3?=
 =?utf-8?B?bkZlTFM5SDBURklCVE02QnhNVTVrYnMvOFd5ZmpyV1lnRDhLMng5UzhEbmMv?=
 =?utf-8?B?Q2ZtT1JUQ1dsdUVad0hxM1hrM290NDZqVUFFenpkeVZjNlRWNjMvRFBYcDVR?=
 =?utf-8?B?UVAvUGw5VEtoTyt1TjlncDRoaHc1V1laMDRQUGxPdmJwL0pnNndyWmNtSC85?=
 =?utf-8?B?TXFqRG45Q0F4ZUcvbUdpdlMrQ2tUSHBCRk1wVC9kY3ptamtFOHNLcThzNHdU?=
 =?utf-8?B?VDFmQmtidHBPdWZadElNQUlnK2RGR2h6VTc2WHgvbjFmeDBaN2h6Tm52NnJC?=
 =?utf-8?B?TSswK1Y2NEJtOHlwZ1FvSGtSaE9OMzBLUWZEKyt6K0pJc2s2a0k1RlVUMXA5?=
 =?utf-8?B?Vy9pOTl5TDlIRGQ5Z3lXNE1CM0txMlZPeVVRT1lVZEx3YmswdGhyZGpQQVQz?=
 =?utf-8?B?dkdLWWpMSzJ5VnBoUDJMMkh6eTRRbzJtMmMrRmZZRU1hUU92WUV5TmcvRGF1?=
 =?utf-8?B?ai81MFF6MXY3MEZRZzJDS0Y4aElNMVZNZGllY2sxTngxY1g5cUpJL1hmNTRn?=
 =?utf-8?B?TnBJLy84TlFsUjlRRHlETHU0aDUxR1orTytUdFUrbFpoMFkyRWNYMXhnNHhr?=
 =?utf-8?B?b1NmTWhJOFhvZk1WWEVHUW91d2NGZk9rQmd2YWs5U0NxRU5yMFR0a2J6eWd2?=
 =?utf-8?B?Y0VjK2VLUnhqeG9VM3V6YlRRVDhaQjlOeUpIc2t0MnhkZGMyQlMwZEdOSlcz?=
 =?utf-8?B?NExQZ0FRYUxzYllZQmI5aml3NmtmSWRVZHVGamdNUnc2cktuMjlMdFYyVEEz?=
 =?utf-8?B?aDlBQjhQcFNBYjU0cHUvWlljRjFEc1RPbDdJNkVPUkpLbmJDMnQyeFpaSGRT?=
 =?utf-8?B?YTBjdUUrNWMxbWtEd0VWU1FPYzdXNXFtaHNpdVpvVnJJWHBBNTE1UDlKQXJL?=
 =?utf-8?B?MlBRQ0pZWlZnV0swZ1VtRnFqZVJ2YnZnNXRPRVVqYmdDTEx4RnZsemVRd2ZH?=
 =?utf-8?Q?QMJUKdf7mp9trq0FU7BXeOcdpS8WTw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6363.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1JoajZNclNZalJoVFBKN2hiWndyZ1YrSXV3Q05wSW9PRVRsVFdiaTBXRkk5?=
 =?utf-8?B?MGZzZDFzb0oxWGhySEdrYzhmYWhaWUdBSVhYYVlQdHh1Q0kvTHcydkkrOGRp?=
 =?utf-8?B?WXk4dXlUTDRpbWVtRW9CU3hnczQ0bWRpVkFrcnpZblFIQVZvUnFqRTlsMHNZ?=
 =?utf-8?B?TkkwSGVRcWJlTnBDZ21wRSt6SXM2TEFoR1BSakcwSVFCODVEWnhPQUNDWDdH?=
 =?utf-8?B?dXViK2xabkVSV0dCRFRpZndxQlB0ZTcxZkgxamp1dy9Vb0ZzOXUvRzRUMDdj?=
 =?utf-8?B?NXVpV1ZEK3BYblVhSUdQOTRqVnl6OE5mK0dXeGhOc1prY1dnckoyZFJxTC9l?=
 =?utf-8?B?S3JaUjF1UkczNzRmelAxdUpZR1JLZDRNSjlsaWkzbDljYmdCZzM1MDFSUlBv?=
 =?utf-8?B?KzhOUVJiYUxkOHRQdW94S0h5MlJ3RHk5YWl2WHZWMUNNbVpibDgwM2Z3WjV1?=
 =?utf-8?B?dDFaL082YnZ2NzZrc2tqSkhZUXVnTVRmS2hDZnJaYUx1eFEzNDVNbTNUK3NI?=
 =?utf-8?B?QTNQbWE2TFRnbysvOGk0UFVOQjdBVlkxNlN0eDRta2hRZk9WNDNoOTJmN0NC?=
 =?utf-8?B?c3habGdFVDdxSm1oUWNNUWVHZFJ0WHpnL2piUzEyVUp4andQeThhcldBY3Bq?=
 =?utf-8?B?TVZSdlFFc0kzVklNTVhSemFHTkU0RFlNZEs1ankvZHhQVkpWMnNILzFIaVM5?=
 =?utf-8?B?OFMvVVZMMjI2R1lkb1RZTjV5U1oreWtwa2tWZHdsS0pqTjV2N0ViZXlGVExD?=
 =?utf-8?B?c0xvU3dGdExrV1NHb0dqT09TL3EvN3NIaHIvc3RUZkJYL01Fc2xncnUrNnZM?=
 =?utf-8?B?S0RrdHFnQW9KVHU5azcxQXJQdnBQc2xTUGNwbmdHWEpiREJPblpFRk1qREVs?=
 =?utf-8?B?THdGYjFxaTBJb0FjbVNIL1pyaXlnZUJHWE9jRDVZc3pQNGoyRFVvS1ZqYnFj?=
 =?utf-8?B?cE13MU5ieXNmelBrdzMrVEoydjZmMDhYN2c0aXRjOHJYb0Y3ZWZrZEV6a01P?=
 =?utf-8?B?cG94cm1nUzd3OGpEaDIrR1BuelB2TFZMNDdQc3BuaitUMlk3WFMyQUlvd2VQ?=
 =?utf-8?B?VXFvYWZWOG5oclByc1YzUUJQMUtrM0ZEc1JiS05xK3d0b0MxVVNwRDVTYmM2?=
 =?utf-8?B?ekxuc2lVMmhndTh4ZDA5WVB0ck9HWGJ1Ky9YSTh1dnRUNDBNbjlQS0V1dnBz?=
 =?utf-8?B?Ly9Mcjd2OGFKWENRekRXTGNrYnFVVHJEajkzNGY0bHhCNWZvdHpqZU1SampI?=
 =?utf-8?B?aC9ESXlodENtaEJ6M0lZaGJOTndLSzh2WlhaVGFHVzRveS80WE9jZFNFa2ZB?=
 =?utf-8?B?QStvUmw1djFsM2dDR1B2d1drODJsT0dMaENqUWNyVVBuZVdCeHJmTmVvdHVj?=
 =?utf-8?B?bnZ6UHBFTmlJa3RWbm9hZGpJVGlmRUFzdGR0ZGFLYU84bWo1UExjNTY1TXRH?=
 =?utf-8?B?aFpwQmxqTVo0MTlaMW5yTGh4Y3JOa0U2MEQvblVUK2JUN05xVE8vbzhIc3BT?=
 =?utf-8?B?bXRiTnJBbUw5anlZU0ZEamQzTmhRRFQwMHdsVTUwT0RVTGhtZFViTG5zUWxp?=
 =?utf-8?B?aWo1TUIvR1daamh3Zk9lbHVFSG01ZCtLdTBSSDdzWSs0YzRQaTR2MGt4TWdn?=
 =?utf-8?B?dXcxbzVCTHNoRXdyeUZTSUtUYlpJaU1YcFV3dzRYSkFLU0g0SDc1LzVvYml1?=
 =?utf-8?B?d3padFJjRGV4ZzY5ZHdjKzJUVzdKUmtYMGVoV05VQjZjNkxaNjBrY1BBd0tO?=
 =?utf-8?B?elVJZ29sdFBhR01DcUZUUWFwaWl0UFRlY2Z6S2JueTJtdW81TWN2emxoalgw?=
 =?utf-8?B?OEJTRFJ6OEFTK1NFN0h0VU1DZ0d6UlQyc05ua1JkeGZuWUxpQUZnTzFjd0Jj?=
 =?utf-8?B?VC92dzdpaE9vbkFERSt1NjVMTGo0bTFvL2lVZDNCWmJvaUlkKzVzN1RLN1o4?=
 =?utf-8?B?Mjk1MlRtMmJNR3pHR3k3ZUFvWUR2OStXaDV1a1RxcnU3NWJBOHpyYlRVeWto?=
 =?utf-8?B?cFZJUGtHVktULzQzVlZwSmczaEtjM2l3N01ybWxFdWJ4RHJTMDdpVWVKR01x?=
 =?utf-8?B?YnVqT3RNckpBZGE0YllvSUJ6cFF5T1Z2U2ZhM3RHNm9xeVJKMlNBcWZoc2NS?=
 =?utf-8?Q?k+58=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6363.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f5c50c-7bb1-463d-e375-08dde06c598c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 04:36:51.9582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lrz+roNL4IPzcJ3n5fhlF1BjhMFZkYCPa4oo1fZnki0EhAN/H5Xz8eUL9J5jq27HlrfYM7dN+TQpO1d81Ni3Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7363
X-OriginatorOrg: intel.com

U3VyZSwgeW91IGNhbiBleHBlY3QgaXQgd2l0aGluIGEgZGF5LiBTb21lIGJhc2ljIHRlc3Rpbmcg
aXMgc3RpbGwgcmVxdWlyZWQuDQoNClRoYW5rcw0KICAgLS1TdW4sIFlpDQoNCi0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBWaW5vZCBLb3VsIDx2a291bEBrZXJuZWwub3JnPiANClNl
bnQ6IFRodXJzZGF5LCBBdWd1c3QgMjEsIDIwMjUgMDE6MzENClRvOiBTdW4sIFlpIDx5aS5zdW5A
aW50ZWwuY29tPg0KQ2M6IEdvbWVzLCBWaW5pY2l1cyA8dmluaWNpdXMuZ29tZXNAaW50ZWwuY29t
PjsgSmlhbmcsIERhdmUgPGRhdmUuamlhbmdAaW50ZWwuY29tPjsgZG1hZW5naW5lQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZmVuZ2h1YXlAbnZpZGlhLmNv
bTsgTGFudHosIFBoaWxpcCA8cGhpbGlwLmxhbnR6QGludGVsLmNvbT47IEppbiwgR29yZG9uIDxn
b3Jkb24uamluQGludGVsLmNvbT47IGFuaWwucy5rZXNoYXZhbXVydGh5QGludGVsLmNvbQ0KU3Vi
amVjdDogUmU6IFtQQVRDSCB2MiAyLzJdIGRtYWVuZ2luZTogaWR4ZDogQWRkIE1heCBTR0wgU2l6
ZSBTdXBwb3J0IGZvciBEU0EzLjANCg0KT24gMTItMDgtMjUsIDEwOjExLCBZaSBTdW4gd3JvdGU6
DQo+IE9uIDIzLjA2LjIwMjUgMTc6NDEsIFZpbmljaXVzIENvc3RhIEdvbWVzIHdyb3RlOg0KPiA+
IFlpIFN1biA8eWkuc3VuQGludGVsLmNvbT4gd3JpdGVzOg0KPiA+IA0KPiA+ID4gQ2VydGFpbiBE
U0EgMy4wIG9wY29kZXMsIHN1Y2ggYXMgR2F0aGVyIGNvcHkgYW5kIEdhdGhlciByZWR1Y2UsIHJl
cXVpcmUgbWF4DQo+ID4gPiBTR0wgY29uZmlndXJlZCBmb3Igd29ya3F1ZXVlcyBwcmlvciB0byBz
dXBwb3J0aW5nIHRoZXNlIG9wY29kZXMuDQo+ID4gPiANCj4gPiA+IENvbmZpZ3VyZSB0aGUgbWF4
aW11bSBzY2F0dGVyLWdhdGhlciBsaXN0IChTR0wpIHNpemUgZm9yIHdvcmtxdWV1ZXMgZHVyaW5n
DQo+ID4gPiBzZXR1cCBvbiB0aGUgc3VwcG9ydGVkIEhXLiBBcHBsaWNhdGlvbiBjYW4gdGhlbiBw
cm9wZXJseSBoYW5kbGUgdGhlIFNHTA0KPiA+ID4gc2l6ZSB3aXRob3V0IGV4cGxpY2l0bHkgc2V0
dGluZyBpdC4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogWWkgU3VuIDx5aS5zdW5AaW50
ZWwuY29tPg0KPiA+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBBbmlsIFMgS2VzaGF2YW11cnRoeSA8YW5p
bC5zLmtlc2hhdmFtdXJ0aHlAaW50ZWwuY29tPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQW5pbCBT
IEtlc2hhdmFtdXJ0aHkgPGFuaWwucy5rZXNoYXZhbXVydGh5QGludGVsLmNvbT4NCj4gPiA+IFJl
dmlld2VkLWJ5OiBEYXZlIEppYW5nIDxkYXZlLmppYW5nQGludGVsLmNvbT4NCj4gPiA+IA0KPiA+
IA0KPiA+IEFja2VkLWJ5OiBWaW5pY2l1cyBDb3N0YSBHb21lcyA8dmluaWNpdXMuZ29tZXNAaW50
ZWwuY29tPg0KPiA+IA0KPiA+IA0KPiA+IENoZWVycywNCj4gPiAtLSANCj4gPiBWaW5pY2l1cw0K
PiANCj4gSGkgVmlub2QsDQo+IA0KPiBHZW50bGUgcGluZyBvbiB0aGUgZW50aXJlIHNlcmllcy4N
Cg0KQ2FuIHlvdSBwbGVhc2UgcmViYXNlIGFuZCByZXNlbmQgdGhpcw0KDQotLSANCn5WaW5vZA0K

