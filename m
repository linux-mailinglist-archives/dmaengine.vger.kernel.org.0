Return-Path: <dmaengine+bounces-5464-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DADAD9833
	for <lists+dmaengine@lfdr.de>; Sat, 14 Jun 2025 00:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD9091BC4702
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jun 2025 22:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E6228BAAF;
	Fri, 13 Jun 2025 22:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZHB/+YFe"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D96239E85;
	Fri, 13 Jun 2025 22:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749853591; cv=fail; b=hDDXOsQt21227PZyvSDRjz2DPYyDyls5ZNOUldXwsOT3nR/ycPQRGeL1UnphSFBko0TS8UV/b+OhfEGZ3MeR8pybhqGBb+RHfXeTlms7AB5/bQ+hrJu8qbRSD1L+WvwtufBTroAYVlMFpVG+QAe6k1J1sne6de/fChZCEPpH7U4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749853591; c=relaxed/simple;
	bh=3Zl/w/kr0wRdsyuZGgJEStz9SBwtfaAyfARs/+VobMo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SkTdfvG6YRxqMkfadv7MJvc3KvojLzYVoZnL2gIjcoyzG+ptWxEqM2wK4oxIo0Ybs/zkAuFGqkM1vfEARblhGCTYJ3Pc6OcRhKs54i2Wf0ZFUndm1GqCl4qjUjmcX0ZtIiIlZdhieBTOlSK9vI+0nwzLrIEu/2QdELvjuCXHFSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZHB/+YFe; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749853590; x=1781389590;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3Zl/w/kr0wRdsyuZGgJEStz9SBwtfaAyfARs/+VobMo=;
  b=ZHB/+YFeUhG8hg7SWcyTDb5xGJI8iinb1B5ZnEzyzqa2BO4RRjn1aV6Y
   Viqv35Y608+vdWViEFJv/o8ObB9w/8UglrWDAcbsmsK6ziW1mxXzyMt59
   CY5FtCPu0y6Rf3L1GIew0AjTEXBNP/28fIhjZU0hSblzTdx+aGZSZaqzO
   Oloct1wKjHZYb39ZfJUqP854cQFNM9tK/Mq8JZX0cFOCCp91Z53Gn1HBK
   XAMYPuFL2eqo51FswyNw+clKvtI3cFDEfnSunARQXw0cf3jfBynOYKj7F
   ZeQKc7Jz2DH5GwH7bMvLtqQ4/cmozc+KVjYGSmxclcUXu4QEfAPS1SRJ2
   w==;
X-CSE-ConnectionGUID: NMZNZORMQoy8ErrySn7kgA==
X-CSE-MsgGUID: oo0vHbYwT0i/1K7DUcBLNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="52175839"
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="52175839"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 15:26:29 -0700
X-CSE-ConnectionGUID: 4Ot1whGcTAa0YBWG6VFEUg==
X-CSE-MsgGUID: mglgZI2yTtGL4AZtAzoVbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="147788713"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 15:26:29 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 15:26:28 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 13 Jun 2025 15:26:28 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.42) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 15:26:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nvSq3HP8QX1QJSLeik21xeLk8mIS1jOJy3lgYqvFLlHaL/3fkrpQdbVaQEbpxlUXapMBna3azfsMhAeXQW9hvq2l5BBRQ9ke4s2BLSVvBweudt8RGlk2ZDjl4WmMu6wrfHHVsjSDlWMoPD8+ookDr4K49sxMRx+EsSpXKsVwjHHTUm52R46DugeOK4Yn53aixcOM0Urhdd6e1UZX68AprQbobwNPIERoKQOvJkWln2388ti4pqY6uMFvsZNYFEFc6016BNzPYZYL63vyPDgVeXV+Q3E2whYEvpuMw0/lZoCMd+m4alBy4RrDlxbJe5uk4hFuXbR50J/cru8z5HEflQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Zl/w/kr0wRdsyuZGgJEStz9SBwtfaAyfARs/+VobMo=;
 b=fUpU5A/yBwVsmEaOLblqNdnQl2JLUXFQgWw5BQ+8rQhemsVT8XpfK/7MthVtoPLDzTxGlEbXddopzvNdyMtx16Rh0N2CdOYTOhx4BQ7eMY3MxkWvylw8SqIuL6Iu9l4I4YZ7qpqGGIEJfx0oEBYOshvCeDejqP+5iGfGm9rpNgwegXSDOyS6LgUO19+OM1pDZDtBCh/KUH+NY4lAsItiumqA9CE544naidlVK6urbi+M0OwufjR+4w1FnH+FwAjYH+I4UjR0YuYyA/IxjLUWSLkfNdmVa+bta158LUSOdjxr05ClAJUhwYklsJJSwGufbVBQ/RfLDzOih+GVVrJ4Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1SPRMB0011.namprd11.prod.outlook.com (2603:10b6:208:39f::13)
 by PH3PPF7DB70F9CE.namprd11.prod.outlook.com (2603:10b6:518:1::d33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Fri, 13 Jun
 2025 22:26:23 +0000
Received: from BL1SPRMB0011.namprd11.prod.outlook.com
 ([fe80::4a32:1541:cb2f:5e9a]) by BL1SPRMB0011.namprd11.prod.outlook.com
 ([fe80::4a32:1541:cb2f:5e9a%6]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 22:26:23 +0000
From: "Lantz, Philip" <philip.lantz@intel.com>
To: Fenghua Yu <fenghuay@nvidia.com>, "Sun, Yi" <yi.sun@intel.com>
CC: "Jin, Gordon" <gordon.jin@intel.com>, "Keshavamurthy, Anil S"
	<anil.s.keshavamurthy@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
	"Gomes, Vinicius" <vinicius.gomes@intel.com>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] dmaengine: idxd: Expose DSA3.0 capabilities through
 sysfs
Thread-Topic: [PATCH 1/2] dmaengine: idxd: Expose DSA3.0 capabilities through
 sysfs
Thread-Index: AQHb3H7yZbsPUYkYvEWBUlA/wAOa+bQBpjEAgAAEPrA=
Date: Fri, 13 Jun 2025 22:26:23 +0000
Message-ID: <BL1SPRMB00111E4D037AA0922A61CA0C8877A@BL1SPRMB0011.namprd11.prod.outlook.com>
References: <20250613161834.2912353-1-yi.sun@intel.com>
 <20250613161834.2912353-2-yi.sun@intel.com>
 <c9dae480-b5bf-4028-a398-bafb9d206f50@nvidia.com>
In-Reply-To: <c9dae480-b5bf-4028-a398-bafb9d206f50@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1SPRMB0011:EE_|PH3PPF7DB70F9CE:EE_
x-ms-office365-filtering-correlation-id: 53fab8b3-874c-4753-56da-08ddaac9545f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?K051azR5MktveGIwY2l1cFVYTStUNk5vTjlhOXVxQmhOb2FuZlhaNGdZU3g0?=
 =?utf-8?B?cHRpVFB2VFBNdTJYNHRWZllHSmFTZ0xWS0dsWUdBSnJPQUJiRDJhbjdQVTNO?=
 =?utf-8?B?cUtEZ3luTHZyZkppcGE3bGR5dkJ6cEk5aE5BZVNCeHZXbFBiTTFlNVFnQWti?=
 =?utf-8?B?RlBhMzBJVUNXbUV4YmxpVFN3WGFmbStMc3NWTlkwam4vbUtUOFBkdXRXTy8z?=
 =?utf-8?B?aEJ4R3FESjViUkswZ3MzSm1zeXNKN0JSa3g1dXBSd0RudEx2dEVLeFoyR21i?=
 =?utf-8?B?RHdIK1pqRUVvRGpmVTFVSzlLU0Fjd21LT0xCS24zMmhWMXJXUXd3WTJzTWZ2?=
 =?utf-8?B?TU1TS2NjNldJRVFIZ2pCd0NnWDJFNFZDdVBJWng0OTgwMlJtdGtYSUtxMFBq?=
 =?utf-8?B?N2dGNFdwcU85cy9XeGdwbjM3WTFMdmFBa0JNR3VxQ3FFcTJDSjlaS01MV3J0?=
 =?utf-8?B?S0EwdGJraTRqZTMvK0UxYzNVMVl5ZFdFcW9xM1RTSjl6dGlnSVU0YkIyUXR5?=
 =?utf-8?B?SW5rT09GWUN0YXZTY1ZiQzRvTXJOTlhKSW9ScHVhaEtrdkxGMmpKWW5iOHJS?=
 =?utf-8?B?eTNtRmFFYmFJRDZ2MXovdnVlcjVEdkM2ZG5vS2ZqQWhpZ292V1I0YnRKT2RK?=
 =?utf-8?B?L0xVOVdGTHpsN0RCNGsrKzdIRzlCdVVUYmJCMVR0dHVlWjJJQVk0ODR1ZUFy?=
 =?utf-8?B?RXhzN1BGdERGRGZpR2lvdzViQkpHVjhVWkVVN0c1ZytwL292TDlWL1lSMFFv?=
 =?utf-8?B?UzF5dWp4MGNvd1NZT1M4MDFaRndjQ21mM0t2T29QK2poYkdiVmxUMHRuQlZq?=
 =?utf-8?B?L0wydWgvN200L2xZS0l5NzE0KzdPREN3UzY4TjF1R1pQLzFPbzNNcmxQajF4?=
 =?utf-8?B?QWl4b0VNV1lFQ3hxakZoU0hYL2VRaldHa1JRZ1lEYmNFMnpGSTNmOGZkWnZH?=
 =?utf-8?B?dElGVXVWTjZ0YmJnTG9FWUhnLzRxMUZSczdUVDkzV09xZHBsOWFnRFpjMTA5?=
 =?utf-8?B?Zjd3elAzZW9HaCs1RUs2QkI4M3B1T0lLM1hzY096N1BLUEFzNXVzdWM2Ly8x?=
 =?utf-8?B?dDR0dzFnb0kyWTlGd3dIb1FPK0U5VlZuWWJ3ckZOazBjTW9xMWNNa2NzSER4?=
 =?utf-8?B?UmoyM3o0alNnMm52TGFETUpnWVdmWE9FL3g4cm1MQTd6TzU0UkdraHdSM0Zs?=
 =?utf-8?B?cjRubFN1WHA2aEUxNzQyeXlybmJxaEV2eVQwNCtWWU9RL3Z4T1ZYYmlGNzhE?=
 =?utf-8?B?YXZiY0g1ejJFanZ2MlY1SlFDc2swc1QyQXJPNkNQTVFwTTU2VytJbFhtYWNm?=
 =?utf-8?B?Q0xqRFovQ2VOT05KdkFGcS8vbjk0azhyU2lLQmRCUStSeENzUXlRcEZ3ZDk1?=
 =?utf-8?B?ais1bXk2c21zTUtNaDQrbGg4SU1YV2JJaks3bWdwaGJQSGxxdHFzeDQ5L0Nt?=
 =?utf-8?B?V1RXZElQeFNwMzhBL1VaTm8vNFJCVy8vVXRrOHQ1V2RUWHFqRmc3ZVZRaHd1?=
 =?utf-8?B?b0JFWnZOWEcwY3BBMGk3aUtLQ05lUjhCRkNpQmZtUmFTaE5tZDB5d3ZSQ1lC?=
 =?utf-8?B?aHRyc3BkaGp0TXpYMi9QdjAwZWpFT3d6UVFxVG5aM2VqdGViMHhVZzMwak9S?=
 =?utf-8?B?U1AvTmFTM3pKKzRraWkwRHFvYkg2NjFSQjc5ZEs2MEloVVBoaGZDTi8vcFZ3?=
 =?utf-8?B?Q2hrTmliNHRlTTZFdTJuSktMQy9hRDNTRVRXMUZWRDlWYlQrUnkreVM5YTZO?=
 =?utf-8?B?aGhhS1BMV1NyTUg1K3RYQzcvSEtGdXhweE1vL2kxQmI5SGZuRDNXQzh3YjdG?=
 =?utf-8?B?QjIyNXd4WEZOT2xRV00xdXJIS2hSZUVWSXd6U21veDY5aG1JRVR3eXNzd0lv?=
 =?utf-8?B?R3JQc2FCY29jejZoVFBqenFuTXFGV2xjakJPMjZkT1VFS2sydU42cWhtTkhP?=
 =?utf-8?B?Q0l3aEdkalZibnJSZk93b0E3ZjNWMEZVTml0UGJnSEw1TkVwU05wbDFLczdO?=
 =?utf-8?Q?eFRhiey8HgrxyIoNgSwGklZE/ZVIhw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1SPRMB0011.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1JWbkFEYW9kNGlmSWtpb0RQaGtvckxWVGtycVlxZUJFRm5nZnBmamVEU2R5?=
 =?utf-8?B?aklxeGFPdVFpNWpLMmJ5WTc3TmF4QTBEdURqVjh6R1c5YTdINnI0VWJJSmor?=
 =?utf-8?B?Q245WEdsL0doT3VGR0JTZ3RWZ1REQVZvTGFMNDRNTzR4MXp1ZXhHVVoyekFM?=
 =?utf-8?B?amJkSGtwNUN1TWdoMWVBTWhxZFY1Z3A0ZkYxRUYwZHhNejVrR3JiTG5icllX?=
 =?utf-8?B?SzZNV0paRTJHL3hHd2hZV3JqekUyL2lyNmp5UWNzSU1ETVNJODA1MnM0MWYr?=
 =?utf-8?B?ek02UWIyc08xWURKUFp6UjhKb2lvTmtxT2VuZG51V2NQOXFQNnA3QXZrRkV6?=
 =?utf-8?B?Zzl1cjJ2Ykl4b1B5Vm44Tk1hMVZFYk92bEhLQXZrQ29DOHdwU3FkRTNYZHlZ?=
 =?utf-8?B?TW00R01CV0dZenYveGxkRTVudUZtcHJtR1ZLd3NJaTM5bDdNUFFiMXZoT29l?=
 =?utf-8?B?TnlnQjI2N1ZKR2svVUlKcWpYdnBIZXZXaWlSY25CZUtlcnU4cnkzbU1pbVo5?=
 =?utf-8?B?My9kcVduU3ovNTFuaVVIS1A3YjVHcERvQlo4TmxDQThCdVl0QVlYb1RjeFc0?=
 =?utf-8?B?eWxoMWNvSGt4SVdBaHpKQVNtdmNtZk9ZbkdGNGJPZGtsc3p2N2x1V2NXbWRk?=
 =?utf-8?B?ZVo5Qm9LcFBoeFJRcmVROGFhdEovQThmeGhJeS9PZzZWWmxqQlhaTXRZTHB4?=
 =?utf-8?B?RGlkSTRJKzB0Q01SRTFrelZKclMzdEJRU3hmZ1BXckNESnZVSmMzRGJEZE1u?=
 =?utf-8?B?K1VDc09udnU0NU5ZMEF5TmpKbmdoQ2dlalI5MFlwb2llNkIvQURHb2NNSlM1?=
 =?utf-8?B?WkF5bGZZU0sxclFSTnNLOCs1cGxkcllyUkVCWk9kT3VGQVdGdTVuVlkxRkl0?=
 =?utf-8?B?TEV3cjdEenRWYmxhVlNyUmtDNDlwVFhsZ0FoeUxFR2xJSkdUbW1PL2pmdkw3?=
 =?utf-8?B?M3ZhNGtEZDk2ZmJBT0dLaVVwYkxiTDIxREhhN3dlUTR2QWlKejFIbXFveGxB?=
 =?utf-8?B?Ny9hb1lzWjJHZEd5NXl4VzNNank5WElRTHZHVVpBclNnZllWM1RjemFiclR1?=
 =?utf-8?B?cUFuZGRqR2VkSkE3bDNkckRLZ3FUYXJqNURjZlVac2JQejMyaDYxV2V0VXMx?=
 =?utf-8?B?ajBNQWh0YkZqWnU1QXQ3N2lPVlhGdjZzVVJxNGp2cG4zWmwxa0FhcndrQTB1?=
 =?utf-8?B?V0pKZmhrRFlIdW5QSkpKT0R2bzBqbnd6WXJ1ODQ0T0tINVVyNlNvTkVIQWIw?=
 =?utf-8?B?eDJRblFWOWV4ZGk4aUVncmRRdUVzMTFEWE9maTFhbzJwckhkazVXem95MkJ1?=
 =?utf-8?B?UytLcDZzTnhuWHR2SnFhakpVSjJld2podUQ3SldqOFp1cE83c2FOT28vTjJ0?=
 =?utf-8?B?blZmejJGdnp0VHZqOEdQWVVONCsrNVVFeW56ZHZGRGQ4bjVtbHdGdzRPdjdI?=
 =?utf-8?B?M0tJQTN0S2NnMUdZLzJwRzRsSTE5dC82L0VaYStxQkJuNVRXU2h0bk12R2la?=
 =?utf-8?B?REMvYjdFZEdadVN5ajhtbXAxVldqaWRlaXNTZXhVR0JybWRFd0lTR3d6T3Fk?=
 =?utf-8?B?N2JIMXNlbEdYU3EwaVpRcDcvcVdZb0JuNUpaeDVYQ2haVG84VlRHYU95WVh1?=
 =?utf-8?B?VTlvYmxuRnRLWmxMQXJxNk12bGZFODdGalpvL09abWVGNTcwMWIxRTRIWWR3?=
 =?utf-8?B?aER6ODIyMTRoMmZ1VXJyYTNWWm5KRDFuUy9iazhKSUZ0em5XaWVXK3R5Y3lP?=
 =?utf-8?B?cVh3YVpDQmVLN054eHhXUHZzTWd6ekEzT01IM3FiUWxwellWNXRuQU1XRU9W?=
 =?utf-8?B?VUdGRnZ0ZjVDQmdqWkdSYW1hN0pNZjhYM2FlUCtWdTFSR3RXeEJXMFhVRnUv?=
 =?utf-8?B?d1FKVHQ2dmFBWnVLcm9vUHlYYnpmUDYrc0J1bWpqSENpM0lDaHROZ29Zcm5Q?=
 =?utf-8?B?Yy9YMkNrcmJVN2xYUnJTeklwK08rbHBxaGZ1bElzeFc1OWEyeUNuclIwTmJn?=
 =?utf-8?B?MHE1enJCOWNaYkhnVy8wQnRmWXg5M3kzRDA0SVd3aGwvTjF4eURNbHN5SXIr?=
 =?utf-8?B?OVpsZjdvMXdCcmVsQ3N0NWYzdnRwU3pzSkhxYVhEMTFYZ3RTNFFJMC94ZUxM?=
 =?utf-8?Q?5sSqQQJneK91FhFEcJnoxTlr/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1SPRMB0011.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53fab8b3-874c-4753-56da-08ddaac9545f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 22:26:23.6634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EPvEyBxaDUX4RJD51Ve/P40pLUhor4YVuP2eBq+WmEWeGNvxWxa+K1pYJ3//kpjZez4hP7r25WneIUt6wMZETg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF7DB70F9CE
X-OriginatorOrg: intel.com

DQoNCkZlbmdodWEgd3JvdGU6DQoNCj4gSGksIFlpLA0KPiANCj4gT24gNi8xMy8yNSAwOToxOCwg
WWkgU3VuIHdyb3RlOg0KPiA+IEludHJvZHVjZSBzeXNmcyBpbnRlcmZhY2VzIGZvciAzIG5ldyBE
YXRhIFN0cmVhbWluZyBBY2NlbGVyYXRvciAoRFNBKQ0KPiA+IGNhcGFiaWxpdHkgcmVnaXN0ZXJz
IChkc2FjYXAwLTIpIHRvIGVuYWJsZSB1c2Vyc3BhY2UgYXdhcmVuZXNzIG9mIGhhcmR3YXJlDQo+
ID4gZmVhdHVyZXMgaW4gRFNBIHZlcnNpb24gMyBhbmQgbGF0ZXIgZGV2aWNlcy4NCj4gPg0KPiA+
IFVzZXJzcGFjZSBjb21wb25lbnRzIChlLmcuIGNvbmZpZ3VyZSBsaWJyYXJpZXMsIHdvcmtsb2Fk
IEFwcHMpIHJlcXVpcmUgdGhpcw0KPiA+IGluZm9ybWF0aW9uIHRvOg0KPiA+IDEuIFNlbGVjdCBv
cHRpbWFsIGRhdGEgdHJhbnNmZXIgc3RyYXRlZ2llcyBiYXNlZCBvbiBTR0wgY2FwYWJpbGl0aWVz
DQo+ID4gMi4gRW5hYmxlIGhhcmR3YXJlLXNwZWNpZmljIG9wdGltaXphdGlvbnMgZm9yIGZsb2F0
aW5nLXBvaW50IG9wZXJhdGlvbnMNCj4gPiAzLiBDb25maWd1cmUgbWVtb3J5IG9wZXJhdGlvbnMg
d2l0aCBwcm9wZXIgbnVtZXJpY2FsIGhhbmRsaW5nDQo+ID4gNC4gVmVyaWZ5IGNvbXB1dGUgb3Bl
cmF0aW9uIGNvbXBhdGliaWxpdHkgYmVmb3JlIHN1Ym1pdHRpbmcgam9icw0KPiA+DQo+ID4gVGhl
IG91dHB1dCBjb25zaXN0cyBvZiB2YWx1ZXMgZnJvbSB0aGUgdGhyZWUgZHNhY2FwIHJlZ2lzdGVy
cywgY29uY2F0ZW5hdGVkDQo+ID4gaW4gb3JkZXIgYW5kIHNlcGFyYXRlZCBieSBjb21tYXMuDQo+
ID4NCj4gPiBFeGFtcGxlOg0KPiA+IGNhdCAvc3lzL2J1cy9kc2EvZGV2aWNlcy9kc2EwL2RzYWNh
cA0KPiA+ICAgMDAxNDAwMGUwMDAwMDdhYSwwMGZhMDFmZjAxZmYwM2ZmLDAwMDAwMDAwMDAwMGYx
OGQNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFlpIFN1biA8eWkuc3VuQGludGVsLmNvbT4NCj4g
PiBDby1kZXZlbG9wZWQtYnk6IEFuaWwgUyBLZXNoYXZhbXVydGh5IDxhbmlsLnMua2VzaGF2YW11
cnRoeUBpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5pbCBTIEtlc2hhdmFtdXJ0aHkg
PGFuaWwucy5rZXNoYXZhbXVydGh5QGludGVsLmNvbT4NCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9E
b2N1bWVudGF0aW9uL0FCSS9zdGFibGUvc3lzZnMtZHJpdmVyLWRtYS1pZHhkDQo+IGIvRG9jdW1l
bnRhdGlvbi9BQkkvc3RhYmxlL3N5c2ZzLWRyaXZlci1kbWEtaWR4ZA0KPiA+IGluZGV4IDRhMzU1
ZTY3NDdhZS4uZjk1NjhlYTUyYjJmIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vQUJJ
L3N0YWJsZS9zeXNmcy1kcml2ZXItZG1hLWlkeGQNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL0FC
SS9zdGFibGUvc3lzZnMtZHJpdmVyLWRtYS1pZHhkDQo+ID4gQEAgLTEzNiw2ICsxMzYsMjEgQEAg
RGVzY3JpcHRpb246CVRoZSBsYXN0IGV4ZWN1dGVkIGRldmljZSBhZG1pbmlzdHJhdGl2ZQ0KPiBj
b21tYW5kJ3Mgc3RhdHVzL2Vycm9yLg0KPiA+ICAgCQlBbHNvIGxhc3QgY29uZmlndXJhdGlvbiBl
cnJvciBvdmVybG9hZGVkLg0KPiA+ICAgCQlXcml0aW5nIHRvIGl0IHdpbGwgY2xlYXIgdGhlIHN0
YXR1cy4NCj4gPg0KPiA+ICtXaGF0OgkJL3N5cy9idXMvZHNhL2RldmljZXMvZHNhPG0+L2RzYWNh
cA0KPiA+ICtEYXRlOgkJSnVuZSAxLCAyMDI1DQo+ID4gK0tlcm5lbFZlcnNpb246CTYuMTcuMA0K
PiA+ICtDb250YWN0OglkbWFlbmdpbmVAdmdlci5rZXJuZWwub3JnDQo+ID4gK0Rlc2NyaXB0aW9u
OglUaGUgRFNBMyBzcGVjaWZpY2F0aW9uIGludHJvZHVjZXMgdGhyZWUgbmV3IGNhcGFiaWxpdHkN
Cj4gPiArCQlyZWdpc3RlcnM6IGRzYWNhcFswLTJdLiBVc2VyIGNvbXBvbmVudHMgKGUuZy4sIGNv
bmZpZ3VyYXRpb24NCj4gPiArCQlsaWJyYXJpZXMgYW5kIHdvcmtsb2FkIGFwcGxpY2F0aW9ucykg
cmVxdWlyZSB0aGlzIGluZm9ybWF0aW9uDQo+ID4gKwkJdG8gcHJvcGVybHkgdXRpbGl6ZSB0aGUg
RFNBMyBmZWF0dXJlcy4NCj4gPiArCQlUaGlzIGluY2x1ZGVzIFNHTCBjYXBhYmlsaXR5IHN1cHBv
cnQsIEVuYWJsaW5nIGhhcmR3YXJlLXNwZWNpZmljDQo+ID4gKwkJb3B0aW1pemF0aW9ucywgQ29u
ZmlndXJpbmcgbWVtb3J5LCBldGMuDQo+ID4gKwkJVGhlIG91dHB1dCBjb25zaXN0cyBvZiB2YWx1
ZXMgZnJvbSB0aGUgdGhyZWUgZHNhY2FwIHJlZ2lzdGVycywNCj4gPiArCQljb25jYXRlbmF0ZWQg
aW4gb3JkZXIgYW5kIHNlcGFyYXRlZCBieSBjb21tYXMuDQo+ID4gKwkJVGhpcyBhdHRyaWJ1dGUg
c2hvdWxkIG9ubHkgYmUgdmlzaWJsZSBvbiBEU0EgZGV2aWNlcyBvZiB2ZXJzaW9uDQo+ID4gKwkJ
MyBvciBsYXRlci4NCj4gPiArDQo+ID4gICBXaGF0OgkJL3N5cy9idXMvZHNhL2RldmljZXMvZHNh
PG0+L2lhYV9jYXANCj4gPiAgIERhdGU6CQlTZXB0IDE0LCAyMDIyDQo+ID4gICBLZXJuZWxWZXJz
aW9uOiA2LjAuMA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9pZHhkL2lkeGQuaCBiL2Ry
aXZlcnMvZG1hL2lkeGQvaWR4ZC5oDQo+ID4gaW5kZXggNzRlNjY5NTg4MWU2Li5jYzBhM2ZlMWM5
NTcgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9kbWEvaWR4ZC9pZHhkLmgNCj4gPiArKysgYi9k
cml2ZXJzL2RtYS9pZHhkL2lkeGQuaA0KPiA+IEBAIC0yNTIsNiArMjUyLDkgQEAgc3RydWN0IGlk
eGRfaHcgew0KPiA+ICAgCXN0cnVjdCBvcGNhcCBvcGNhcDsNCj4gPiAgIAl1MzIgY21kX2NhcDsN
Cj4gPiAgIAl1bmlvbiBpYWFfY2FwX3JlZyBpYWFfY2FwOw0KPiA+ICsJdW5pb24gZHNhY2FwMF9y
ZWcgZHNhY2FwMDsNCj4gPiArCXVuaW9uIGRzYWNhcDFfcmVnIGRzYWNhcDE7DQo+ID4gKwl1bmlv
biBkc2FjYXAyX3JlZyBkc2FjYXAyOw0KPiA+ICAgfTsNCj4gPg0KPiA+ICAgZW51bSBpZHhkX2Rl
dmljZV9zdGF0ZSB7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL2lkeGQvaW5pdC5jIGIv
ZHJpdmVycy9kbWEvaWR4ZC9pbml0LmMNCj4gPiBpbmRleCA4MDM1NWQwMzAwNGQuLmNjODIwMzMy
MGQ0MCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2RtYS9pZHhkL2luaXQuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvZG1hL2lkeGQvaW5pdC5jDQo+ID4gQEAgLTU4Miw2ICs1ODIsMTAgQEAgc3RhdGlj
IHZvaWQgaWR4ZF9yZWFkX2NhcHMoc3RydWN0IGlkeGRfZGV2aWNlICppZHhkKQ0KPiA+ICAgCX0N
Cj4gPiAgIAltdWx0aV91NjRfdG9fYm1hcChpZHhkLT5vcGNhcF9ibWFwLCAmaWR4ZC0+aHcub3Bj
YXAuYml0c1swXSwgNCk7DQo+ID4NCj4gPiArCWlkeGQtPmh3LmRzYWNhcDAuYml0cyA9IGlvcmVh
ZDY0KGlkeGQtPnJlZ19iYXNlICsNCj4gSURYRF9EU0FDQVAwX09GRlNFVCk7DQo+ID4gKwlpZHhk
LT5ody5kc2FjYXAxLmJpdHMgPSBpb3JlYWQ2NChpZHhkLT5yZWdfYmFzZSArDQo+IElEWERfRFNB
Q0FQMV9PRkZTRVQpOw0KPiA+ICsJaWR4ZC0+aHcuZHNhY2FwMi5iaXRzID0gaW9yZWFkNjQoaWR4
ZC0+cmVnX2Jhc2UgKw0KPiBJRFhEX0RTQUNBUDJfT0ZGU0VUKTsNCj4gPiArDQo+IA0KPiBUaGUg
ZHNhY2FwcyBhcmUgaW52YWxpZCBmb3IgRFNBIDEgYW5kIDIuIE5vdCBzYWZlIHRvIHJlYWQgYW5k
IGFzc2lnbiB0aGUNCj4gYml0cyBvbiBEU0EgMSBhbmQgMi4NCj4gDQo+IEJldHRlciB0byBhc3Np
Z24gdGhlIGRzYWNhcCBiaXRzIG9ubHkgd2hlbiBpZHhkLmh3LnZlcnNpb24gPj0gRFNBX1ZFUlNJ
T05fMy4NCg0KVGhlIHJlZ2lzdGVycyBhcmUgYXJjaGl0ZWN0dXJhbGx5IGd1YXJhbnRlZWQgdG8g
cmV0dXJuIDAgb24gcHJpb3IgdmVyc2lvbnMsIHNvIGl0IGlzDQpzYWZlIHRvIHJlYWQgdGhlbSBv
biBEU0EgMSBhbmQgMiBhbmQgdGhlcmUgaXMgbm8gbmVlZCBmb3IgYW4gYWRkaXRpb25hbCBjaGVj
ay4NCg0KPiBbU05JUF0NCg==

