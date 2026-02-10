Return-Path: <dmaengine+bounces-8875-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMkyH+Q6i2neRgAAu9opvQ
	(envelope-from <dmaengine+bounces-8875-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 15:04:20 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D101111BAFC
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 15:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6F6B3007F49
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 14:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDA932938D;
	Tue, 10 Feb 2026 14:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EkxAQvN8"
X-Original-To: dmaengine@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010062.outbound.protection.outlook.com [52.101.56.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506C6327218;
	Tue, 10 Feb 2026 14:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770732209; cv=fail; b=pXId8aoouhZgYOpUAj+fActmHaxdSKPwN1NvMVx938Uap/GU6EKS/MdjTdyUtwzEyg0Adp4mxPZMKdbIxf1jbTB3yN+86bmGQ3DLP6AKR2tTtCKnZ/TXniNp8JnxZmC/DRIUWqU3H5ZYcTGEUVLDKZg9AWYNvSeUFGftebWOlgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770732209; c=relaxed/simple;
	bh=Zu7EgcvM+NNTRzrgZiP1pZ6yB/iFKdIdEfrYSef97DI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nENxQjjzIPln/ex189utLOe8BDlUAqrUX0Ien9AhGFuuAAynBu9Y2CqIZO39ie++KaVnfqGf1UYXvNR5Sh5wrpi11qK+fTvtZingxc6zThKrDv0ibpa8C3C0VJ0+xdVi6wV9UANs2ZXfoIzZSOOpTIp9IYjGpfdtXYbf0Z/hFJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EkxAQvN8; arc=fail smtp.client-ip=52.101.56.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EAFQ5jhzhGDoCZ9d8ZHVhMxR5mScmv/D1+i7gV7ZKueazAM9Ca8S2zwIdvfQVZPQ01C168mwo11d6O8TFn9WDVxxa0ZKCWV9SxhiFyDc/QNC9FYbuxycBV0z74IJlOTRh8KZjDGDlaOSVLsWyuaYLeVfdgbDC2JgMego3bmJEB0ezwWEi8ygjYZ8oUS64vMk7LwwRAJchh2hgo2mHe0RI/zcYbYZsLbNG3TbhpwpF7o6XJ/Bd6eQXMOWD2hzGhQap9GdgjwzBb7C0s7UuxcxUi0KITAv8XMWSUctZHHxlCbphAsIXJPmbXG/Db9vBLY82RgNXu/fTcAC+hvhKtwwtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zu7EgcvM+NNTRzrgZiP1pZ6yB/iFKdIdEfrYSef97DI=;
 b=BhuJjfChzgloNwb8BA+ei1Cu7CClR8fX0ix+zDmckWa4oOqrTIleWrMmiqmegcHd905KG0b7L/d8rnw6N0Nb4b/tHCabYoRS6Da6HgoaHqtRGLt6P/emVSmD1d/G8MjBTNCZbUuNpSXNrLOUPxvR3+qOZ8D+MOFIJBXdVIsXL9LgRLCp/JuBmY/XYpQM0voyRxkKuNAmtHWCifeNFIK9NPlTFCFIt4Vko+Fti37CB1ZztPjtqQpl9TeSHcRnw3cArRHzzSxtIpqLxUsuQQks633fB9bRoJu5nwrbWidfB0hj0qGeq9sB4N9C13KZud6jisiVuihbj0vTgEch40H37A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zu7EgcvM+NNTRzrgZiP1pZ6yB/iFKdIdEfrYSef97DI=;
 b=EkxAQvN8+kPdQ1PQMekm+EaslwwVuV5qil2HVjIPLeZEFktFwu/mqoD1BnpiiLNIhw7Xy473UAEftd9Q7DWJrp5CyRmYRYGtUClDes+bhbhufjF9xaFyoFn/ZXtL9eZyhEWM8mjUR3crS7pwsiStxzh7NrsVR6pxYdC3DSlADYo=
Received: from CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6)
 by DS0PR12MB7849.namprd12.prod.outlook.com (2603:10b6:8:141::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Tue, 10 Feb
 2026 14:03:23 +0000
Received: from CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d]) by CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 14:03:22 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: "Navale, Rahul" <Rahul.Navale@ifm.com>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dma@lists.freedesktop.org"
	<dma@lists.freedesktop.org>
CC: "thomas.gessler@brueckmann-gmbh.de" <thomas.gessler@brueckmann-gmbh.de>,
	"Gupta, Suraj" <Suraj.Gupta2@amd.com>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"dev@folker-schwesinger.de" <dev@folker-schwesinger.de>, "sashal@kernel.org"
	<sashal@kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
	"marex@denx.de" <marex@denx.de>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Katakam, Harini"
	<harini.katakam@amd.com>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, Marek Vasut <marex@nabladev.com>
Subject: RE: [RFC] dmaengine: xilinx_dma: device-wide directions cause ASoC
 cyclic DMA regression
Thread-Topic: [RFC] dmaengine: xilinx_dma: device-wide directions cause ASoC
 cyclic DMA regression
Thread-Index: AQHcmnNDKyJ/sNlJBku/Wa4kYUlhsbV7670A
Date: Tue, 10 Feb 2026 14:03:22 +0000
Message-ID:
 <CY1PR12MB96978AEBD6072FC469DFEAF1B762A@CY1PR12MB9697.namprd12.prod.outlook.com>
References:
 <DU7PPF774CACD0EED60059A126F9FF158048A62A@DU7PPF774CACD0E.EURP189.PROD.OUTLOOK.COM>
In-Reply-To:
 <DU7PPF774CACD0EED60059A126F9FF158048A62A@DU7PPF774CACD0E.EURP189.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-10T13:22:35.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY1PR12MB9697:EE_|DS0PR12MB7849:EE_
x-ms-office365-filtering-correlation-id: a9b0bf0e-75a3-4004-ecaf-08de68ad2722
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ejFEUFlsdDRRemFXczF6bkZ6RTNmVmlLcFltUkdYdk5nS2lMb3NSM1Zlckdw?=
 =?utf-8?B?MDZiajRSYUluR0lJdGRXMTR2QWhVbnlpaDRCclJMUzB5M0tSSGpOSDdFUVJO?=
 =?utf-8?B?bnh3Ny9HV1NNSlZZSVFQQ0E1TDVZZHpFVUtqRks0dWFadTBTb2ZGczNzVHFi?=
 =?utf-8?B?S1JPSzlyRzZSZ2wvbU5SOWRKUXFNUW52NHYvSXdoTFdZdGtseU9DVW1NV2Fr?=
 =?utf-8?B?dlVxT3A1MVFHcm1jaWpOUjJPcEc1RHluVnJ0TkZZdG1UanpuTXJhbVlDWGtE?=
 =?utf-8?B?bnJwTjJseG9paTVEUzFkeWF0d2thSVp4MHhLUlFPc0dkK1l2Nit6cW9PTEZ4?=
 =?utf-8?B?SmdhUWJidGh4cFhjTUhCMjZvNEV0emp2MGxoTEpMMUhqYUxYV1M5NHRBUkNX?=
 =?utf-8?B?dTBpTWNYUnFlUFN3Tm5lMXZJZG44WGk1RVlTZ3gzWVo2K0hXRW14MUtQbktt?=
 =?utf-8?B?dFo5ZHFkSXpzMnNyb1RRSk1HNXpES0d3bGF4S2xqQWpTcVRKUDUrT2Q3bXpZ?=
 =?utf-8?B?c1ZVcmlmS01iUldkeW1BSWJqVGMrallBazcwcDJZVlR4d3ZHZVpxOVVDZE82?=
 =?utf-8?B?ZjJiVjcrVDBXQmxaekhTRDg0QUZjWlJtRStQdnhEWitQZ0tvby9FczhOOENT?=
 =?utf-8?B?SGtTeEF6OGZ3dkFrMXhTMldJQ3BnOWxrektKdUVObzhIRytaVVNvWHlQbzZF?=
 =?utf-8?B?QmdUNld5VU5LS0h3bUVMc2pzK3c3WVhhZWNrbUlVTjE0M0xpL1FwQTJ5SG1R?=
 =?utf-8?B?WDlWQWFMWHV3MUZuV0JwUWlSc3BPSmVLZkxPVWJScEMxN2lnRE1tT3k0U1o4?=
 =?utf-8?B?WG0wV2lWOHZ0SHBlaHA2YTF3cWM4bkZHWkYySGYyV2hOSkFMMjZOVll4RmxL?=
 =?utf-8?B?aU8xVWF1bUxmaFpxRVkvekt4RDlScm00WFEzN3h0eEFNd3Z2MEpVSk1BaXZL?=
 =?utf-8?B?U0FValRjWkV4bkdwRW1FSkNGRTlSZFN5RE9Pek8vM2R2RHFuZGpHejdvQTJG?=
 =?utf-8?B?UGhNVWZCRUwzaHBqeFpPelhxMGtYZFU2a0pnN0lUL2ZoMVFGY1UyV2dkL0Jx?=
 =?utf-8?B?eGM4ZzRURnJXdnBCMFNsSW03aUdMTkVvbUxJQThTZWhUdDNBQnVvaGtaVFZZ?=
 =?utf-8?B?MFA0TmhYQXFlZ2EzcHArUEcrbWNCcTZVYUZ5bExpMXpJVUhNK2pteC9HU2RF?=
 =?utf-8?B?dHpyVW1BZnVSN1ZpZ1FERGJud1NIL2dJS0IxS0N0L0NQSlVwYVFhNzU3dzBG?=
 =?utf-8?B?dzY5aHpvK3NEdjgwcjB0bUNZYXZBRlY4c091U1FxeCttSFdhaDNBWGRuUktH?=
 =?utf-8?B?V0YxU2NGL2k2OVUxWTNJU0NpTThVU081bEdIcVRiSWdxY1ZuL1habmxPcU1O?=
 =?utf-8?B?aWVIVkpHRkFpMnNHMzl2OWd1NjJBNmo3cjdjU3diNFVTUnhTcGsxQUx1QlQ0?=
 =?utf-8?B?N05SY1ExT1VuK1ozQ0xhVFE2MEVMVTk5UEwxSXMyNytXd0RrK3Q4ZlFUWkgr?=
 =?utf-8?B?dWVKdUY5alUyZUNTYXJvd2lVeWpiVHVJUlVZenpyZlhGQ3BrSGtIMmgyN3ZR?=
 =?utf-8?B?ejNwc3RYd1orWitGSy82NE41RlVsZHFhWS9VSldZUGRvN21KRko5RklDRU5j?=
 =?utf-8?B?amRmam55N2FkR3JNMXhSYTlnZkhsSTE2ME1IdThlM25LVzNWV2hHZ01YWkhX?=
 =?utf-8?B?d0llbmtJTkowNVRkaC8zNGJjNkhwbHRubXBNbDloM2ZMN3M5SEkwc0hCWjZs?=
 =?utf-8?B?NldmNEtvWWFYdDBrdUU3MUxIOE5VbHVwckd6TGVLZzNjTjNucll5MVorV3lq?=
 =?utf-8?B?M0J5Z1V0aDdES2M2U2dMZUxYWWdjZjlUM3ZMR0dScjZ2ZDFOTkJZZGpYdUZo?=
 =?utf-8?B?K0tJcVYvRFM1UGtWQ1BRS1VCc0JyZDJqNWJRMWtRc1VqanpZNHl4ZmQ0QmJO?=
 =?utf-8?B?cm42U3d5V3k5M0p6d1lrYmNrdG9nY09td2ZVUk1iV0JFb21xcWpBOElZY3Jw?=
 =?utf-8?B?M3hneGxYWjVLTlhCOXNpN0RKSC9scGwxcXZydlZWZTBMUDVvUzFzVVZDRFM0?=
 =?utf-8?B?WkVqaEQ1WTgyY09mOFE5RVZpOWZ4TStMWWl3MVZDZXlydXllQ0orSXFJWVl1?=
 =?utf-8?B?V000YlQvMHlONUJIZzdvQjVRTS9Kc3BObitocHJpVFdYdVYvTEJHTUtSQmpG?=
 =?utf-8?Q?Wd18Xgu+P96JQrqzkbLopOs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9697.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZnU2SXNaR2txTUF4QlRhSGZRbmxwODhnM3p5QU0xYkUzbHI0RlhveXVMWjJu?=
 =?utf-8?B?cW5Za0s1RUZJVTNPQmtHQWVKUDFkLzFWWmZ5UmNhcEZEa08zWU5yamgrVGEx?=
 =?utf-8?B?L2ZLT29DMXNTSnJFcU1rNXhSRGNWaXFSSzFoa0lFcTNuejJhMXQrWjNLQmdZ?=
 =?utf-8?B?ZWJ3bUNEREMydE4xdjdTZ1c1VEJxc01EcjNtUDhYc25EVCt4RzY0bXFDL0I2?=
 =?utf-8?B?RDhLNTNiRWNqbUVveG11cWg1ZWxuSklHck9kUHVnVlF4UytXT1pDeGsyM3Zt?=
 =?utf-8?B?Qzd0dTltMmxwM3cwVkg4OUt1NytOcWNBRmlRNkozaWVydGpzTzI0VkMwYVdT?=
 =?utf-8?B?QkZ1VVF0RHkwZFB4NUpDNElRNWttR3dLSG9HUEcyc2wvQ1FvY0l1Y2UvVkhC?=
 =?utf-8?B?MW9QdG5oK3NjUktUb2VId25CL3djUW5oaTZTYUp1Q3dtQjJ1eTFFWlNpMklW?=
 =?utf-8?B?US9hMHhRZC8rNjdjZndDZi9qeUY1aTEyR0ZkY3FGY2FyVm1RNGx6d3NRa1lk?=
 =?utf-8?B?bjdDbVh3RVBPbnlQNUl2a3oyZksrTjFBUW40M0I1QmhWTmVNWlNSME5Fa1ZI?=
 =?utf-8?B?aWxHZUlaTnNXQzNhRk00Wng1aWhVcG1STTlHcldFUi9iaGx4RXNpWEZYb1E4?=
 =?utf-8?B?RjN1WVR5L0tUSGRGTUhmRmNIS2dnN3QwUmZIRVJabGNWQzI3Zk52Y0pYVmR5?=
 =?utf-8?B?LzRSQXJocER3VlZXZkZTUlNxQlYzTUpSTmQvbG16Tno5bVE4MEUzREVheURK?=
 =?utf-8?B?cklBUUxrQm41RTZSMGhUWFV4b24wYzZXM1JQdVpwTHlEN0FodE1OVzMwSHpu?=
 =?utf-8?B?RVBmL0FHY3QwelZBVktCYkN5RDUyaElwUjhFb3YwODRHTTdFZHZxa1U5NTdq?=
 =?utf-8?B?R09NVDE1VmZSMzcwTXlCMjdpWXUzYndmS3A5OUZMendFU0RoYlFSOXdnM3Vl?=
 =?utf-8?B?N2lJTVNEUXZuaXcxR1hZY0VaUHNmZEpEZzYxci9jdnNMdzJpNnc2dnBjZVh5?=
 =?utf-8?B?eng2eWZNYm9SRkNTazVkeUhCMTlhb3N1MHQ3WUhDdjVUaW8yU1J6TFp5eWRR?=
 =?utf-8?B?N0J5VExnei9qSDVsUHBNcmJXSW5ndUNyVmlqU20xL1p1TzRRajVMc1ZHQ2hj?=
 =?utf-8?B?NlFCSWQ2S0dQZHd1NHNXZzc2V0I4dU12cm1tcHdMZGw0ZHc4VXBVTEZDRkFl?=
 =?utf-8?B?d1BUcXJCK08wRVMzd1BQUXc3SjZjZjA5YkdsU2hiQmxWdjFQQUlQbnZyYUJv?=
 =?utf-8?B?Z2dkUXJQTGtLOEUwQ1ltOFJBMnM1S2lpYTZXR0d0N1hYWlpzbnpFMVM1dTNF?=
 =?utf-8?B?dlJ4MzllV0d1c3lRZkVkdEk0OWFIY1Y3ZGsrNW0wc1AySlNCZkZPYmtEK2Rn?=
 =?utf-8?B?ckpYWGwxWVpIYW1SdjJXQmZEZGxFM1NnTWQwNHpvR2t3TnFnOXl2aXQ4OVpv?=
 =?utf-8?B?NktHdngyMW5OdFpFN2Z2djhOVTBGTG16T2lJQmdXZTJFcER6UzdKQWVMSTc4?=
 =?utf-8?B?LzVabjlkVDk1L0xmcDVmS1JtWjZXYVRHd1phZzZzOExndlBOOUZxUHRYOVNk?=
 =?utf-8?B?YllRRFhvd0xmVHRZZEhKVGdoNDlQMDJ2a0xtZGNZcGNVY0VaSm54WDJaQmt1?=
 =?utf-8?B?c1VHeXVIVTYwekduZnpaclFNTnRyNTF3ZnN1c1BHRkNBN1F4WFJiVHZhUFVM?=
 =?utf-8?B?UFBmbWdzUm0vL0diemdFYUtUR3cxdENzZlZXVE01bXBCS09hQ2h1N0dpa3hh?=
 =?utf-8?B?bHZxTU9mQ3RhcTBhNnZMRThiTHZ1TThOTmxzN3hHb2ZPQUlTZ0VyUjRJSnlX?=
 =?utf-8?B?eHJ4Um9LZXhONGUyYWhHeFdZK0duck1GWVZDYytTQUh2c2NzTmZCeG5jZlk2?=
 =?utf-8?B?RnNyRE8rT3Q0VmJVUmRHMksyNGZhNWpKM09NdzNRYjN3ZWpLWStkZTBQWEpV?=
 =?utf-8?B?Q1plZm95OWNoelJHWXlmN1REc1k4Nk9vUDMzOVNHbGlpUnd5clRRYmxIZFlu?=
 =?utf-8?B?OGFVY1JzSkM0OVhxT1JrUWtKM1ppUFFKbTVSTStRYnk3MitMNjRTSytlV2wy?=
 =?utf-8?B?UUxPeTlBS0ZtS2lTZVlKUlVkWit3WVNWVkoyMU9uVGplSnpuTFpyOHMwc3ht?=
 =?utf-8?B?b3UrN3ZKOTNmY25NUUptUkx3YkthSS9uYzF3UU9hdUlGemN1S0FUNUZkNTR1?=
 =?utf-8?B?eHdYb3ZKejM1b0dlR0RlUmpGazM2T0JNNHFnUmNEaWJOUkovVG5seHFGcVdu?=
 =?utf-8?B?dC9UT3ZiZ2wvS2ZoTkR4Z0JieHMxMG85Yyt4TlRyNDA4TllzZlZqc1d4MERZ?=
 =?utf-8?Q?vzXqsjv6eT3f3gagnW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b0bf0e-75a3-4004-ecaf-08de68ad2722
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 14:03:22.8071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eEafHvQyC3wUwmN+NLEUJVA9X5yPrV0MZA+5NTvYenZWKp3ZJdHaibA61DVXDOuZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7849
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8875-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[radhey.shyam.pandey@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,CY1PR12MB9697.namprd12.prod.outlook.com:mid,amd.com:dkim]
X-Rspamd-Queue-Id: D101111BAFC
X-Rspamd-Action: no action

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPkhlbGxvIGFsbCwNCj5XZSBoYXZlIG9ic2VydmVkIGEgcmVncmVzc2lvbiBvbiBhIFp5bnFN
UCBwbGF0Zm9ybSB1c2luZyBBWEkgRE1BIGZvciBBU29DIFBDTSBwbGF5YmFjayB3aXRoIExpbnV4
IDYuMTIueS4NCj5XZSB3b3VsZCBsaWtlIHRvIGRpc2N1c3MgYSByZWdyZXNzaW9uIGluIEFTb0Mg
YXVkaW8gb24gWnlucU1QIHBsYXRmb3JtcyBjYXVzZWQgYnkgdXBzdHJlYW0gY29tbWl0IDdlMDE1
MTE0NDNjMyAoZG1hZW5naW5lOiB4aWxpbnhfZG1hOiBTZXQgZG1hX2RldmljZSBkaXJlY3Rpb25z
KS4NCg0KUGxlYXNlIHVzZSBwbGFpbiB0ZXh0LiBJIGFtIG5vdCBjbGVhciBvbiB5b3VyIHByb2Js
ZW0gLiBTbyBkbyBzb21lDQppbml0aWFsIHRyaWFnZS4gTWF5IGJlIHByaW50IHRoZSBjb21tb24u
ZGlyZWN0aW9ucyBpbg0Kd29ya2luZyAvbm9uLXdvcmtpbmcgY2FzZS4NCg0KQmFzZWQgb24gZG9j
dW1lbnRhdGlvbiAtIGRpcmVjdGlvbnM6IHNob3VsZCBjb250YWluIGEgYml0bWFzayBvZiB0aGUN
CnN1cHBvcnRlZCBzbGF2ZSBkaXJlY3Rpb25zIChpLmUuIGV4Y2x1ZGluZyBtZW0ybWVtIHRyYW5z
ZmVycykuDQoNCkZZSSAtIGJlbG93IGRyaXZlcnMgc2V0IGRpcmVjdGlvbnMgZmllbGQuIEkgYmVs
aWV2ZSBmc2xkbWEgc2V0DQpwcm9wZXIgZGlyZWN0aW9uIGZpZWxkLiBEb2VzIGFsaWduaW5nIHRv
IGl0IGZpeGVzIHlvdXIgcmVncmVzc2lvbj8NCg0KZ3JlcCAtciAiY29tbW9uLmRpcmVjdGlvbnMi
IGRyaXZlcnMvZG1hLw0KZHJpdmVycy9kbWEvZnNsZG1hLmM6ICAgZmRldi0+Y29tbW9uLmRpcmVj
dGlvbnMgPQ0KQklUKERNQV9ERVZfVE9fTUVNKSB8IEJJVChETUFfTUVNX1RPX0RFVik7DQpkcml2
ZXJzL2RtYS9xY29tL2JhbV9kbWEuYzogICAgIGJkZXYtPmNvbW1vbi5kaXJlY3Rpb25zID0NCkJJ
VChETUFfREVWX1RPX01FTSkgfCBCSVQoRE1BX01FTV9UT19ERVYpOw0KZHJpdmVycy9kbWEvcWNv
bS9xY29tX2FkbS5jOiAgICBhZGV2LT5jb21tb24uZGlyZWN0aW9ucyA9DQpCSVQoRE1BX0RFVl9U
T19NRU0gfCBETUFfTUVNX1RPX0RFVik7DQpkcml2ZXJzL2RtYS94aWxpbngveGlsaW54X2RtYS5j
Og0KeGRldi0+Y29tbW9uLmRpcmVjdGlvbnMgfD0gY2hhbi0+ZGlyZWN0aW9uOw0KDQpUaGFua3Ms
DQpSYWRoZXkNCg0K

