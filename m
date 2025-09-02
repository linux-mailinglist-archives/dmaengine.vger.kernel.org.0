Return-Path: <dmaengine+bounces-6313-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 661AEB3F8BA
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 10:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9611B2017F
	for <lists+dmaengine@lfdr.de>; Tue,  2 Sep 2025 08:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C31F2ECD33;
	Tue,  2 Sep 2025 08:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UJ41hSEw"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C66B2ED151;
	Tue,  2 Sep 2025 08:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802062; cv=fail; b=g5do+zt4Ftdd2OjmTmowqJMN49CbSnRtzejrkK8v5olZdAx67hSNOzLjdS6ryGBFN9RPRsKlwSSxBqzM+3hF/cPI2TpBWmolItwOFnb4XQWCTDrxbhSWGyCrZsbX12kT097WWLKib52TCwF2L/Ta7jSqYokiECBuLou/zjWhfjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802062; c=relaxed/simple;
	bh=cLrQTHL1RI95dUSOiOIXW22G7Il0V1zwX+nuo7vOcXk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ixmDVUJSlQB8P5DlJbQNo9lkNb3T9hqpR5Cc02DrqNx9AzBn4Umf2+gtoZAYyE6nMnAl2SD/6oPnKatVeAJ/Psz9Tpz63gjYqJc61HeUze8yMFBpRURLEjKNqqdNpWOKmA1250bYtrz2L+wz5EdubVd147jkjpT1xp6UMFljIEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UJ41hSEw; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756802062; x=1788338062;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cLrQTHL1RI95dUSOiOIXW22G7Il0V1zwX+nuo7vOcXk=;
  b=UJ41hSEwtVJ5CMFMbs4RgkJ0V3tjLJMWnU98b6n8RGgYtiYmcKUeywf/
   ganxDreCallJkIR1ZfnfEsb0GrCsiaQnsRX0ZD3u4SC0SKJUL0mTEDXfI
   YaRYJtRBGEyQAGsTRk10fqlPKPuRGz+mtKryMgHLUl/Wm9MRgYpqDk3ts
   BMKCD37uRoSGpjcFLTBsYR4uNHyqjrjUR5RcetT+flH6+07w0Ezrqy2tE
   DENl5BFGM9OTmyUTVVSx5O37D3sUYQeTN1sCCva3tasUqMkOjvkrM8n16
   lNtNndD7UoWTAiXGaJTqghRb1cBfQ/GrQIZQV8oesUq4gytjKhuz7iOLn
   Q==;
X-CSE-ConnectionGUID: E4x+GQMVQjKNtdz4VFECkA==
X-CSE-MsgGUID: Os3HscuQTg+NWYB+Pgl42g==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59014698"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59014698"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 01:34:21 -0700
X-CSE-ConnectionGUID: 2WlzgV3yTdePbs772T0WQQ==
X-CSE-MsgGUID: E3G7rLQhSr2FmIGTh2M/6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="175340456"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 01:34:21 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 01:34:20 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 01:34:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.68)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 01:34:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDpd/VmXS8Vl/dggHIhdoykuB2f2/WtxOSm9qMt2ivyi2mpqqoUREngB012tOqIU6YkhhfR/jzHaWsNRC8tEW2B+zg3CDhdgWMkqhc/U+CzJ2w/etiK0dYm/R534fu7YTdbNMIPWFMAP1+vLlzb7XOxixsCm+H1FTrxZx0glqYBtR9Lt3UCQkh29Fge+8pHyq6ARQ2VlpdfLwr84P7pltvBDG8BljeJSUBzb7s2h4zu8Y7PAMeivEV4a8HS081fl7JSudlIvq5LExCF0R5yK95jTFbhWfPCAx+V1rPg0ORlwIGAqAJQB9cean2VQFNrWzRQKeWHzrP6CZS8I4YdeNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLrQTHL1RI95dUSOiOIXW22G7Il0V1zwX+nuo7vOcXk=;
 b=lWQASOhYKEdlHGQ8/lPBoWd7FmCI4t/nzDXJX8ruvuW1e0BNLcq9auAIkTPvPM8wRo/4J87hE59f8lExgNN7gOJRQ8lEbDRXqq4t7kzDUp2zhhOf+D3pm/yQxkgEGrCFlOfEDRxAT9HysuqkwSet97GQ1WQ4YEuvplRsvzcZUbSNGWzP7WPrjcIZHTeRZ9CDgxMtDV+vFvwAtuZqKhpcu19xSJhtkP+afGSPelW6XG1Sal1ULVc+Br5tB7MntB+ITZj2mA8CJ/PYw8KTmN0YCsGFxPvqJ44Yxy1sxJf+XzFmcimUeQlZL8+e2mwyKWRJfzabk67wy+UbZmA/Tno7OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6374.namprd11.prod.outlook.com (2603:10b6:8:ca::8) by
 CY5PR11MB6115.namprd11.prod.outlook.com (2603:10b6:930:2c::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Tue, 2 Sep 2025 08:34:17 +0000
Received: from DS0PR11MB6374.namprd11.prod.outlook.com
 ([fe80::15ef:b5be:851f:52b8]) by DS0PR11MB6374.namprd11.prod.outlook.com
 ([fe80::15ef:b5be:851f:52b8%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 08:34:17 +0000
From: "Sun, Yi" <yi.sun@intel.com>
To: Vinod Koul <vkoul@kernel.org>
CC: "Gomes, Vinicius" <vinicius.gomes@intel.com>, "Jiang, Dave"
	<dave.jiang@intel.com>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Jin, Gordon" <gordon.jin@intel.com>,
	"fenghuay@nvidia.com" <fenghuay@nvidia.com>, "Lai, Yi1" <yi1.lai@intel.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: RE: [PATCH v3 1/2] dmaengine: idxd: Expose DSA3.0 capabilities
 through sysfs
Thread-Topic: [PATCH v3 1/2] dmaengine: idxd: Expose DSA3.0 capabilities
 through sysfs
Thread-Index: AQHcEnjnYA7Y6WNtkEeN5U4z+C3NxrR/kJCAgAAFA9A=
Date: Tue, 2 Sep 2025 08:34:17 +0000
Message-ID: <DS0PR11MB637482C854F7C5FF32033D8F9906A@DS0PR11MB6374.namprd11.prod.outlook.com>
References: <20250821085111.1430076-1-yi.sun@intel.com>
 <20250821085111.1430076-2-yi.sun@intel.com> <aLab55JCvLcbOm0S@vaman>
In-Reply-To: <aLab55JCvLcbOm0S@vaman>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6374:EE_|CY5PR11MB6115:EE_
x-ms-office365-filtering-correlation-id: 921bcb6b-0999-4dda-ec45-08dde9fb8187
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QWM0K1FkS2ZHbEdSS1ZqWFBHWi8wSVpLU1dkbkExajZKbHF4alByVVBwTmln?=
 =?utf-8?B?MnFZMFU2dzhKOFJsR0pCb3lTcjhYcXEvREhMOVNFMGhZdkJIaXJiN2ZJVUJU?=
 =?utf-8?B?dktNZFhKK0VpOUVENmJtVWNuM3RRMUZBdXQ4VG5CbEJwMjJDU1NFWjhnN255?=
 =?utf-8?B?Tm5ramlrVGlNTjErQ3h6TFlCSmQycHN0Vk84RnBJblJLcHEzZnJQeXl2Qitp?=
 =?utf-8?B?RkZDVnR1RUkzZXgvRjRJd1hnRkRuWGczTXFXSnc2L1U0NnVEdFFHeTFZSjVm?=
 =?utf-8?B?UGVkNldBaVdtWVU2S21qdHRkSTRYQldINk1uRFd1bHFyVXlleWZsU1hISFA3?=
 =?utf-8?B?MGtFSkx0UkNWRkczbG94c2dYSXlmYnlSWEpxSU5jVnY2c1Z2L3Fpd1pjbkNK?=
 =?utf-8?B?aXZWY0p3QVhSbVRhZ0pJaVg5SXZCcTJrUGwvbGhSbHRwVnB5dkN2QTE0UWFv?=
 =?utf-8?B?VGNiQjJtMUZLZFc0Z0FwelFWb1V1WDNnMGdUOG11ejNmT0ZNQmt1TGNyOU0r?=
 =?utf-8?B?eVQrZCtWQk9kNGRZNjdoQjhqL0pmT24zZk1kcjBOK1FVdmE0R2tGM2o3bzFa?=
 =?utf-8?B?MWcrWktsNnEwbGU4b0ZETVhDa01xdzN4VmRyeFZKMythYXlHZEtRZ0wzL0Ez?=
 =?utf-8?B?NGJNK0RmSmRnQ1o4YUladktFU2Q2VjBSQXlUK25nV0E3UXhPamRwY0pBOTA0?=
 =?utf-8?B?bm9mcnBLQngxbExZcncyZjJsQTNZVFZ5NXQ5TTc0MTRKOUhTcm0rWEhEZnZH?=
 =?utf-8?B?U2hoUVpVekcwZmF0MndHaDBtaVoveWJyUmxGYUlUZ0hBVTViVjNLMTlvOTJq?=
 =?utf-8?B?S0Qvb2FvWUd3c09DUURnYTZ4bXVvKzRkT2dGMDB1ckJVb2c5d1dtcWJZS0xG?=
 =?utf-8?B?Y1JBeHl6ZnFkUVh6TXY1SXFFWTh4SEI0eURleVB0clhDVlNGcldlWkh3dHI4?=
 =?utf-8?B?cVdoNVEzUTYvb3dMNERNUThTMFd0a3hCd1Fkd2FtQmVWZDM3NmJ3S1FQckYx?=
 =?utf-8?B?Qm5SOGIrQUxac1BjWFBRekk5aFhTb0pVTTkwYWdxd2Z5bUlVaFBMZ0RqYzZU?=
 =?utf-8?B?OFRoWE5EQXExSmNsK0RWT1l2eWczdVF2TkNnTUtsdkpHUXBIM3BqaWFEOTh2?=
 =?utf-8?B?Y1llS2p6RkNpUnNzdk1RZ2pnQlgzTll0ZTR6THJzTjljeDdleUh6ZUI5b2NZ?=
 =?utf-8?B?R1ZjQXM5WXVZR2RieStuVVV1ZVVjVzE4OHF4a0t5VkE1OC9VSEZsbXBoRE42?=
 =?utf-8?B?a0xHbzV2V3dIU0loZUVoTmloNTg4MUdYSHc5L0lRVXQ0ZlJGVzJMYmFTWXVo?=
 =?utf-8?B?U2k3OWtKUUx4REM4QUt1L1N0aXIvK21MYWpUWDdHUjVaYkZqd3dPeXhGTnEz?=
 =?utf-8?B?V3E2TzVXaFdrZmdndnprTlA1ZkdzcVRHeDIydWNWV3QydENxdFRiT3Z6Nzkx?=
 =?utf-8?B?RU1WaTlBY3JXQkNxdFRoSE43bmVTK0NjOHRva2JxOXBDNS9Fb0hIODVlZkRS?=
 =?utf-8?B?eFk5eUZOdWFtTk5la3VYLzZUY1AzL1F5Q20xcFhJL1ViMWgyU3NVdjJkZ3Nq?=
 =?utf-8?B?QjZEUlBZUkllSlRmZm1lWWY4NTlHN3pKZjVUc0N5TUdYZlRuWk9ncENoQ1JC?=
 =?utf-8?B?SW5yVmpMeDhZRXJQM294VVIyenVsSmpURi84SHI1b05rMjFxd0h5YzFxOGFZ?=
 =?utf-8?B?dTgrdDFoamlCcGErZmdyb1V2VldtQVFLVXY5VDZaVTNCSk0vTFpxaFZsbW8w?=
 =?utf-8?B?bXEwU3RWSmsrTWVGTk0vUDB4dkNvdFdJRlRYU051NDVDRnNWc0RCRnhYT2tS?=
 =?utf-8?B?d2NTY2Nxbks0MDYyUGg1cXlJMzY4WEFMMm0zbklSTW82Vi8wYW55bTBvdXA3?=
 =?utf-8?B?QUhDMnJOVHRoeXhxNGdUeFFuQ2p6Lyt0V0FKSTRyMEdkM2xRSUsxb0Zsd2Fq?=
 =?utf-8?B?a3NEbHVtWW5jUm1FdFJ5TkJ6eVlocXV6dStSc2RrUEhReU5ZN0x0ZmFIc05o?=
 =?utf-8?B?a200cVJtL2ZBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6374.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUdNVmU1ay9zYVNqVjJCejUwZHNwK1lTMERITWdISHhPVmg5NVN3MlR3dDYr?=
 =?utf-8?B?cGI4MUwyWFBOVnFndFdBeENiKzE5dEVVUFByYjRGeFI4N2VGV0k1djNqRHNa?=
 =?utf-8?B?L1R5dWdXL0pscjVyYzZ6L25lRUZabFRCMjBSSWZCRVA2ZGUyd05oL1BEU0lX?=
 =?utf-8?B?d203anBUdnlwOFJjZis3VEgxOGp2UEovbHY1akwxdXc2M1lRZ3JqQUlWcnFB?=
 =?utf-8?B?SmZVU3RmSCtveWlMMU41TTNqUWVBcVB4RXVLbWVEM3R3VlNWT2dyMW1BZVpK?=
 =?utf-8?B?YTVYQmpLa1dmUG9hWURpV0xOYm0yV2xYbUNHeFRQVGJlRVFmb1RybkVKeXc5?=
 =?utf-8?B?aXhqTDVDckoyQWhNcUF4OVRBSGdLSVAwRm5QSGE5U2ZJUlBmZWxHYytQTVAv?=
 =?utf-8?B?VDdodEw3YkJuYWt4aE5GaGRXS3phbW1rVEh0Nnh3cUxvR0x0c2xMZTZwU0Vn?=
 =?utf-8?B?OEJmY0twWkRmK0FmQy84N0Z2UFNLSHNQNXQraVdza2pwVDBOMkJNSk1ORWNR?=
 =?utf-8?B?QXd1Z1d3Z1YvaG9haHh6Sno1WXZ4RjhPVkFmYkZBaWdDT29RTkxWbkdxYWl2?=
 =?utf-8?B?cUc4cUhSVmJyakdWUHBrZ1dJemNiR0lFNjMrVGMrZ1I1aHZBa1hVSUo1MGlQ?=
 =?utf-8?B?V09FWW53Sngwb2s1Wk12Tlk2YWpZTkpRdERxWkhzNVVkNHpCTXFNTm43djMw?=
 =?utf-8?B?LzJJeThjWFJ3a0xGVjlxSFBzWEhaaFk0TmdnVmtRekxEOE5WdkZkRk1iOU41?=
 =?utf-8?B?cnVJbjkrbjZWQkN2bVdRelBtQ01mczNQUzhtNFFRZFhFL3JVRUR4VlUxZmw4?=
 =?utf-8?B?SkloV2ZxdFlld2hqS0UxNUxUenpIRk1sWVJKR2gvenFURVQ2MW96Y2dqWGsv?=
 =?utf-8?B?VFhwTjlydHd2ZGQ2bWhYaVNnNzgxTXZDNGg1QytJaHFCbktmdlJvSmljMUpx?=
 =?utf-8?B?d1NWaTBRVEl2VlJlSEJZQ29zdkR1YWVldndMZzdCT3pjTFhQNU85bXFiVGdV?=
 =?utf-8?B?VXJtWGtrZUduSjhoSEhlM1AyZ1R4eHIybXdMR0hVdEkzNFFtdkQ3WndBV2xT?=
 =?utf-8?B?aG5lalcxSGQrVENOUE9tTFIvUnFrMHJSR2F3cmhCVDZvRUg5c2IwMGFwSHJz?=
 =?utf-8?B?VytVbkhGblBBQW9Ha1Y0L1M0bjVIWWNzbzJyWTNYMytuNko1azBtUWhQenFS?=
 =?utf-8?B?TXdiN1JiWllTRm5WNHRrRUJCckQzOGkzbGxtUXpOYTJJdVEvNUJNaTBwVVc4?=
 =?utf-8?B?blhhYVZHdXZYNC9WZkp4SjJrb1MxT1VEQlF6dHV6MUNwN0x1Vno3WGVRLzFy?=
 =?utf-8?B?eWcrRElUOGtFQkdNQVlTTndNaXNXMk9IY0VqVzhBU01NbW56bkk5aVlsY2Y5?=
 =?utf-8?B?em5RSUppbWVnRWluWEdyM1ZKcEIwZWZJM3hLUE5wVXVkZS9mNld4ZDMvOU1r?=
 =?utf-8?B?YmNZNkdmQkJhQUFGMWlRVTJkUEcrajNCSWJTalNuVndMV0RrdDBxN21sa3Nj?=
 =?utf-8?B?UWdIZm5wZFFjSExwVmtPcEsrOGVsM3VyR2Q0R3M1WEZIMWZ3L1ZsTWRiZmZX?=
 =?utf-8?B?R052ekNKZ0hqSU5IeDhVb2o2aHA0UGd1bVlyU0Q2a2J2OUh6MGJMcUFBcVVq?=
 =?utf-8?B?cXg2UUw5Y2lobklYL1B6NGFFWVpxRS9DajJKRDJhamtONnFZZzVZMzdWTUxT?=
 =?utf-8?B?ZTNlaHJDYjdSVGtnWnZqR3hObmlacFNqbTVJK1pIbXhJY1ZZU2NTU1FvR3B0?=
 =?utf-8?B?REowREZ3WDMzbHlNdDFJRlBhK2I1MHVBNVZCQ1llSC9tZnFqOWFuVkhsTVY4?=
 =?utf-8?B?V0phbzBqQy9LYitTNjFrdmN1Y0tMSThmbGlyazVZeHNlK3dNdlA5NFFxTCsv?=
 =?utf-8?B?ckxLTkMvdThCZDh3aEhRY2RzMWsrREpoU0hVR1FiaTBqTlEyM0ZhaitQOWxZ?=
 =?utf-8?B?TmVFUHhrZmw2VVJyWWpUZ0diRnJMT0lLc3hFR2pXbDNuamJWWGFHa210WTls?=
 =?utf-8?B?WVI4OXhWRjhvdm5BTXVxQTlXQ2t4L2dkeVNNby9kemZlYUxPV1pRN3ZRWGZk?=
 =?utf-8?B?WitjYVpoVi8ySGxqYVVrOFFRV05yR0Z3SEFRNDJDRWVrSWxVTDlUWXgwU2NZ?=
 =?utf-8?Q?D2Ao=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6374.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 921bcb6b-0999-4dda-ec45-08dde9fb8187
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 08:34:17.5607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qd1F79JiuTyUDi+mob6iTaOds+azt8J0cS4OOAyw/+er3d4j8OciInZQwfgViBfCyWo0KZqsrzlrxr3uHFpTnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6115
X-OriginatorOrg: intel.com

SGkgVmlub2QsDQoNClRoZSB0aHJlZSBjYXBhYmlsaXR5IHJlZ2lzdGVycyBhcmUgY29uc2VjdXRp
dmUgaW4gQkFSMCAoMHgxODAsIDB4MTg4LCAweDE5MCkgYW5kIHJlcHJlc2VudCBhIHNpbmdsZSBm
dW5jdGlvbmFsaXR5LiBFeHBvc2luZyB0aGVtIGFzIG9uZSBzeXNmcyBlbnRyeSBtYWtlcyB0aGVp
ciByZWxhdGlvbnNoaXAgY2xlYXJlciBhbmQgYXZvaWRzIGNsdXR0ZXIsIHNpbmNlIHRoZXJlIGFy
ZSBhbHJlYWR5IG1hbnkgZmlsZXMgdW5kZXIgZHNhPHg+Lg0KDQpJZiBtb3JlIGNhcGFiaWxpdHkg
cmVnaXN0ZXJzIGFyZSBhZGRlZCBhdCBzZXF1ZW50aWFsIG9mZnNldHMgYW5kIGZvciB0aGUgc2Ft
ZSBmdW5jdGlvbiBpbiB0aGUgZnV0dXJlLCB0aGV5IGNhbiBiZSBhcHBlbmRlZCBpbiBvcmRlciho
aWdoZXIgb2Zmc2V0cyBwbGFjZWQgbGVmdC10by1yaWdodCkgdG8gbWFpbnRhaW4gY29uc2lzdGVu
Y3kuDQoNCldlIGNvbnNpZGVyZWQgZXhwb3NpbmcgdGhlbSBhcyBzZXBhcmF0ZSBmaWxlcywgYnV0
IGFncmVlZCB0aGF0IGEgc2luZ2xlIGZpbGUgcHJvdmlkZXMgYmV0dGVyIGNsYXJpdHkgYW5kIHJl
ZHVjZXMgbm9pc2UuDQoNClRoYW5rcw0KICAgLS1TdW4sIFlpDQoNCi0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQpGcm9tOiBWaW5vZCBLb3VsIDx2a291bEBrZXJuZWwub3JnPiANClNlbnQ6IFR1
ZXNkYXksIFNlcHRlbWJlciAyLCAyMDI1IDE1OjI1DQpUbzogU3VuLCBZaSA8eWkuc3VuQGludGVs
LmNvbT4NCkNjOiBHb21lcywgVmluaWNpdXMgPHZpbmljaXVzLmdvbWVzQGludGVsLmNvbT47IEpp
YW5nLCBEYXZlIDxkYXZlLmppYW5nQGludGVsLmNvbT47IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEppbiwgR29yZG9uIDxnb3Jkb24uamlu
QGludGVsLmNvbT47IGZlbmdodWF5QG52aWRpYS5jb207IExhaSwgWWkxIDx5aTEubGFpQGludGVs
LmNvbT47IEFuaWwgUyBLZXNoYXZhbXVydGh5IDxhbmlsLnMua2VzaGF2YW11cnRoeUBpbnRlbC5j
b20+DQpTdWJqZWN0OiBSZTogW1BBVENIIHYzIDEvMl0gZG1hZW5naW5lOiBpZHhkOiBFeHBvc2Ug
RFNBMy4wIGNhcGFiaWxpdGllcyB0aHJvdWdoIHN5c2ZzDQoNCk9uIDIxLTA4LTI1LCAxNjo1MSwg
WWkgU3VuIHdyb3RlOg0KPiBJbnRyb2R1Y2Ugc3lzZnMgaW50ZXJmYWNlcyBmb3IgMyBuZXcgRGF0
YSBTdHJlYW1pbmcgQWNjZWxlcmF0b3IgKERTQSkNCj4gY2FwYWJpbGl0eSByZWdpc3RlcnMgKGRz
YWNhcDAtMikgdG8gZW5hYmxlIHVzZXJzcGFjZSBhd2FyZW5lc3Mgb2YgaGFyZHdhcmUNCj4gZmVh
dHVyZXMgaW4gRFNBIHZlcnNpb24gMyBhbmQgbGF0ZXIgZGV2aWNlcy4NCj4gDQo+IFVzZXJzcGFj
ZSBjb21wb25lbnRzIChlLmcuIGNvbmZpZ3VyZSBsaWJyYXJpZXMsIHdvcmtsb2FkIEFwcHMpIHJl
cXVpcmUgdGhpcw0KPiBpbmZvcm1hdGlvbiB0bzoNCj4gMS4gU2VsZWN0IG9wdGltYWwgZGF0YSB0
cmFuc2ZlciBzdHJhdGVnaWVzIGJhc2VkIG9uIFNHTCBjYXBhYmlsaXRpZXMNCj4gMi4gRW5hYmxl
IGhhcmR3YXJlLXNwZWNpZmljIG9wdGltaXphdGlvbnMgZm9yIGZsb2F0aW5nLXBvaW50IG9wZXJh
dGlvbnMNCj4gMy4gQ29uZmlndXJlIG1lbW9yeSBvcGVyYXRpb25zIHdpdGggcHJvcGVyIG51bWVy
aWNhbCBoYW5kbGluZw0KPiA0LiBWZXJpZnkgY29tcHV0ZSBvcGVyYXRpb24gY29tcGF0aWJpbGl0
eSBiZWZvcmUgc3VibWl0dGluZyBqb2JzDQo+IA0KPiBUaGUgb3V0cHV0IGZvcm1hdCBpcyA8ZHNh
Y2FwMj4sPGRzYWNhcDE+LDxkc2FjYXAwPiwgd2hlcmUgZWFjaCBEU0ENCj4gY2FwYWJpbGl0eSB2
YWx1ZSBpcyBhIDY0LWJpdCBoZXhhZGVjaW1hbCBudW1iZXIsIHNlcGFyYXRlZCBieSBjb21tYXMu
DQo+IFRoZSBvcmRlcmluZyBmb2xsb3dzIHRoZSBEU0EgMy4wIHNwZWNpZmljYXRpb24gbGF5b3V0
Og0KPiAgT2Zmc2V0OiAgICAweDE5MCAgICAweDE4OCAgICAweDE4MA0KPiAgUmVnOiAgICAgICBk
c2FjYXAyICBkc2FjYXAxICBkc2FjYXAwDQo+IA0KPiBFeGFtcGxlOg0KPiBjYXQgL3N5cy9idXMv
ZHNhL2RldmljZXMvZHNhMC9kc2FjYXBzDQo+ICAwMDAwMDAwMDAwMDBmMThkLDAwMTQwMDBlMDAw
MDA3YWEsMDBmYTAxZmYwMWZmMDNmZg0KDQpzeXNmcyBhcmUgc3VwcG9zZWQgdG8gYmUgc2luZ2xl
IHZhbHVlcyBvbmx5LCBzaG91bGQgd2UgcmF0aGVyIGRvIHBlcg0KY2FwYWJpbGl0eT8gQWxzbyBp
biBmdXR1cmUgaWYgeW91IGhhdmUgbW9yZSB0aGFuIHRocmVlLi4uPyB3aGF0IGhhcHBlbnMNCnRo
ZW4/DQoNCi0tIA0KflZpbm9kDQo=

