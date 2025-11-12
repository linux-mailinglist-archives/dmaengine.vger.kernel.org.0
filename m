Return-Path: <dmaengine+bounces-7138-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD68C52422
	for <lists+dmaengine@lfdr.de>; Wed, 12 Nov 2025 13:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA6B33A0FFB
	for <lists+dmaengine@lfdr.de>; Wed, 12 Nov 2025 12:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DCF3176F8;
	Wed, 12 Nov 2025 12:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XhGjGZKQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3653191A9;
	Wed, 12 Nov 2025 12:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762950184; cv=fail; b=VX9q1JnLSn8zWK3spdXPVnMLwbO+GMdAdjBFA6UcXD3tLp+o3jnRF2Gb6TBP70peeU3in9rASUpxcadqjl11EdwIM921bFbq3p/dC1uu8nwoPVuoMwHwr9p7jEVP8KCpFQTpRq0NnsFAC/8p/uLWsOTm8ZIAGUpkzxQEOzZG9ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762950184; c=relaxed/simple;
	bh=EW9oOw1tTYLtD0Ajp4MFS+zVvkXiXKF97MyfeaBj48Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CE6GBPsW2GfxuQX0pveEbLMXm4uAttgcybuNLJm5FdysyWV77TGoIhfmWU+mpNdCOy56eRFBJGqq4f9YpuLgn3IeKsNFsP2R3LZSILOHtuhgiyHisADlnkY/7L2AxIA1LO5OalENsZmW/hBmL3ZCpt97VDGUe43YwWbI4zuLDTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XhGjGZKQ; arc=fail smtp.client-ip=52.101.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+0oSEV59AJ7AAhuva4K6MW2QYMglRCvbjfIROrkxf4Wqip9d4DEssYAvwTFZCOEjZ2ye+ccuEIjwG1uMb1xidKk7U2/nAwFFKwaz4yafsvzw9OfsxI4i24MPouHYKcT4WpHody74EFe09jpGZssRosmJwiM55Viugwwy9zkc8bHZE7IXIsd0N04IG+KPFWTEykELCLT0QpOxbrqOlZzcxo51Z0VdXbgAo82aeLqXtWlcL9GEjlwbOsHrq28Hk3BC8w3AdQnJKvl3SHDRr/W9PmDkRAAZGk1fCMtRQcvEsk1iWv28E3JyjGDO9F/A1CRjgexpf0rkUMlwMqtwTIgOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EW9oOw1tTYLtD0Ajp4MFS+zVvkXiXKF97MyfeaBj48Y=;
 b=OytiFQt0Er9s5eIHlEV/84lRxSw4vY1BGKkcjnd+KErVUwi/otHs6WURW6DVWsB+ogrnzYcTF39J6L+WnAUuwqoPvWrOPF+Y47L/DKzKzQSN2ZireuFsZaqaJ4TNTeosYAmnl+6umji9Yx09nIHEtEzaGFTmQ8CXXdu4mBUWMay5pni8LCA+ECeJHc+x1KHuIsXO3FpNwqNkI1ugOaHVhZyEXA1SKIUtg9h9lqhEDvhZfRweZjoCtByUPZnJB9Mr/N6FJg8VgCaP6jRamOmZrlJLOonNnNzC+xxegkrV/xrIezP5rwcS4qmWHPlFFZQMDZGHkwb7d5/PdzMuR1KcFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EW9oOw1tTYLtD0Ajp4MFS+zVvkXiXKF97MyfeaBj48Y=;
 b=XhGjGZKQAyBYSXui21Vyk0VJ0KWt1CQLegTFkpPbC/idSrhE6t0quNNnV47dEb1bSpR01BxgFj51DrDsdDuXIhLRQmgq+VGouuoQi8aIKOmsw/eYD4N2x+5P6suBldZ4cXkHw5D7Ei7dCOkN/YMD+cQMoRgo2tVgg0Lb78yM4Yc=
Received: from SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22)
 by CY5PR12MB6225.namprd12.prod.outlook.com (2603:10b6:930:23::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 12:22:59 +0000
Received: from SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::8ccf:715:fdc4:8a14]) by SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::8ccf:715:fdc4:8a14%3]) with mapi id 15.20.9298.015; Wed, 12 Nov 2025
 12:22:59 +0000
From: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Vinod Koul
	<vkoul@kernel.org>, "Simek, Michal" <michal.simek@amd.com>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Sagar, Vishal" <vishal.sagar@amd.com>
Subject: RE: [PATCH] dmaengine: xilinx_dma: Enable IRQs for AXIDMA in
 start_transfer
Thread-Topic: [PATCH] dmaengine: xilinx_dma: Enable IRQs for AXIDMA in
 start_transfer
Thread-Index: AQHcUx3NYtIbZMT/pUu+NbfgAjmP07Tu85Yg
Date: Wed, 12 Nov 2025 12:22:59 +0000
Message-ID:
 <SA1PR12MB6798CC79FE8DA14ED2614771C9CCA@SA1PR12MB6798.namprd12.prod.outlook.com>
References: <20251111-xilinx-dma-fix-v1-1-066c158bc18e@ideasonboard.com>
In-Reply-To: <20251111-xilinx-dma-fix-v1-1-066c158bc18e@ideasonboard.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-11-12T12:07:39.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB6798:EE_|CY5PR12MB6225:EE_
x-ms-office365-filtering-correlation-id: cbe72183-376a-4706-733a-08de21e637ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TGUvSmZ6WWhPenlyQzdpQWdyYW03bjdkTEZXd1l5VkJXelVsZ3BoZEUwWHVE?=
 =?utf-8?B?YTFoVHZSbHFScjFNL3JSa3V5SWZubkZWVmZvNi9XS1dneUwzcUIycWhFR0dT?=
 =?utf-8?B?eFROSHFHUjFzZ0hCTEVFNkVocG14QzRJTzNDVjVmM0VLMkNKaHdTSVZHblNX?=
 =?utf-8?B?UC9HVjNXbGlncVdHZE14TDFJc1hHZ2EzbjRxalZTdXcrYkFZN0loVDdTK1Zs?=
 =?utf-8?B?RnI3RzRDVmJhNXl2T0xWOVNpTmtQYXpWVUdlV1ZuZ25zK2hjZi8zZ0VzRHM1?=
 =?utf-8?B?N2ZvQU5pUlBVQ1dxY3VKWVBVY2FuR2dGRGk4TkdIYitnbzZ3c0NSZ2htVDVH?=
 =?utf-8?B?V1pGTy80U2hQUVVXYlJpZ3U2RXFXc0IxL1h3eXBaUGFGbzNVSk9aSTJnTVpz?=
 =?utf-8?B?eDIxWm0vTDZYOUswS1RiUWd0UVUwejVIM05IejcrbmJBeFNtZlN2TXBKMmlr?=
 =?utf-8?B?UVNaQnBROHJYTXV1TnpiVThDazNNUVM2VWlsUDIwTnc1cWE4YmZnT1F0cThj?=
 =?utf-8?B?RDBkVmJlVmJXK0V0clEyakIrMlZuankyZzQrb3Y4dmlxUmV0bC84YnVNUm96?=
 =?utf-8?B?VTNqcFpMazEvUTNla29ST3lXWFA0SGxMTXZaSEoyUlYybUJ5VFMxelFxMnlK?=
 =?utf-8?B?LytyVjJQMHAxajRTREs4azVZOHJBUUxyRnhESXpCTFNUSTFSSzJNUExNZGxv?=
 =?utf-8?B?TW5temxCOXF2RUVEM0xXeE5TYVlPZ0JucWgyVTh4WGtxQzlHTk1kU1JpNkdC?=
 =?utf-8?B?YjVEOHlXalZ2cHFjRlhZamlpQXYzZEo1aEFKdHVTUkU2Z0Y4dEVxUUxrZUh0?=
 =?utf-8?B?K2lKV3VjcDk4NUE5Y1FFbHRSNGJ0MUNZRHpmSHFIVS9kNnE5dEtBSzBGNkRG?=
 =?utf-8?B?SGpKSkx3L0p6aGgyRzlTeDZ4akVCU1dkTUtIbjI5czVqMHNEUi9SMVFFSUwx?=
 =?utf-8?B?YzJGWHJ5M2g2dUhvdE9FOXBCS0EraFROT2JsRWRHa2RKcmRHOUx5WkNiVWFl?=
 =?utf-8?B?VHIzYnlPa0RKZjRoTGJnOHJJOFpoSUlwUUhYanZkdFN1b3VHVmZzbXpQVjAy?=
 =?utf-8?B?TEgrUVo2MktPU2NmckJmUDZHWldUaHg0bkF4ZzBJR2FLS1RldmYzakpOWHJ3?=
 =?utf-8?B?VTYyNlRqakpJTHJnTHQ2b1pMQVBkME1ub0hEeUdDNFB3WERLWEFvWEI4Y1V5?=
 =?utf-8?B?Und6NG9HMXFFNkU2Nzk1N1FMYkgzNVpPU0RtZWQrc2wxbG9WWnVCbmJPTHVK?=
 =?utf-8?B?c0tUVU54M2ZlcWpBNWRha1RGa3E0OUpwRHB4NzJQTURxbHZEem9RLytqYS9Y?=
 =?utf-8?B?ejB3bHVFL3hQMXQwSVhKWTgwNEF6WlMybXo5OC8yNUp2b0RDbXNiY2QrT1Na?=
 =?utf-8?B?bG5zdlIxYThTbHdsY1dQRU9mVlRmSHZYak16aXRMNGFmeURoa09LQms0bW5K?=
 =?utf-8?B?NHVsQUljcVZxK2NkU0E3T2c2cEFFcUczQ2ZRSnZXOVZHc0VVc1NnREFYZjF5?=
 =?utf-8?B?WDJnL2ttd3FSMTU4N2hNWTFiQUVoUDIzaTArNlNjQlMvWGt5empDM2V0T2hP?=
 =?utf-8?B?Z1UyVldCZ1FuSzhDQmhZcXR2aFA1eStxT0FXNzBEekUxZDIvOHNBdnFQNURa?=
 =?utf-8?B?a3l2aWV2L2tnTjNnK25acG52dERjaUZDSGJMNEJPVlB5eVJqVk9RYXhqbDU4?=
 =?utf-8?B?WGFTcHJKSjNESlR5Y3I1c3N2NEFCMzF0MzBQbGJWcUxTeGQzMkZCZ1B0TnZw?=
 =?utf-8?B?eDNaYnhkb2tVOSt1RnhjdktyMmQ3UTNoMUtHenBOS2dpampoYVZYbndUNXpU?=
 =?utf-8?B?djdFUEs1Wk9xeEpvS0V3ODFkaDh5K2pkQThaalBWSU1TZXlmbWZNVFJNdEww?=
 =?utf-8?B?RGZEbTF1RFBHVjlNRVVvMHFtUDBDQzc0cmNvRjI0dVB4Y1V4eFVKUkdOa3No?=
 =?utf-8?B?Ym9OQVBzTnRnWlRnRHYranFaakZONTAvUmtDb2lRSDB2WGpEOG5jOXFDaGxQ?=
 =?utf-8?B?V3BjNlFRMExFUkhQQ1VWaWFWdktiNk9pNUx4M01RTnhKZ1FwNDltcTFUTjJn?=
 =?utf-8?Q?3RiQ+z?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6798.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NFpjRmZjN2xVdkdCeXNlaURQdlVzcTVVYWxtR3NCQ3pyemh1ZlRBY25XSm9T?=
 =?utf-8?B?UWVadUN2amxnTS9leGZUMy93OE54YzRiWk03Nno2bTZUR2hoWFcrMnNubVdQ?=
 =?utf-8?B?TWVEQ09qa2NKcEVOSmxyTmdKcHhzZmVPaG9UZGZDTzZmMEtja201L0FzbnpB?=
 =?utf-8?B?Wmw0Q2czNXB4TmY5VGFOaG1wRC9MNTkwT3R6Vjl2eEhYMkZPOVQ3cjB5L24x?=
 =?utf-8?B?eFVrQ2hhTlc1UDUrbUlobnVXczhkQUdOVTh3N0h0MzFucU5vZ2d2dU40d2Uy?=
 =?utf-8?B?SUlxSDAxTkdjWFBBMFVwVXN5ZWdwZDVBdlZJS3VzVHBHRnlsUVEzaTk2WTNv?=
 =?utf-8?B?R3JxM0tQNWpPajhRK2kySGtzckl2S1R0U1dYTFplTXh2dGJlSFg3SVE3SndK?=
 =?utf-8?B?NUhCK3Z0NkYwVUdPVzUvRmJ4SC84NUNTdU5ERXlmN09wSWxHNGJpclNjS0Fp?=
 =?utf-8?B?Y3JrRTIwMTFUaFRpWEVHQXI5amNLUHh1Q2JpRDgrMCtrRHl5ZGRsT2hnYU8z?=
 =?utf-8?B?blk1S3lOYzZzcHQwcFFMVkQwQW1jbnQzaUVIYkhYNjFCVW1QU2ZSdlBscEVY?=
 =?utf-8?B?bTJnUml5ZDZ3V2NEc3hxM21HQWpDMkpKb2ZiNDFrNCtLVEluTnNwY0JWOWhy?=
 =?utf-8?B?Rk1JQzhqMGN2NndQeU45VVI4cmlFaGVhUnhvMGpTQ1dFdVgwam5RU3F2RDBN?=
 =?utf-8?B?SlpHV2JZa2NrY3NXamx2SG04UVlJd2RtWGZrUkoxNkVrNWUzSTNBNzNFR3ZO?=
 =?utf-8?B?emQ3QmdQb0l3dTV2VDNaWW1yc0c1NyszWGlMT1ZkczQ2K05qbjllb0FGaEJi?=
 =?utf-8?B?cjRnZFgvNWFVeDZKRS9sUndXNzh5THEvNmN2aTE4MlFRWUlXaGtLajh4MXBt?=
 =?utf-8?B?YmdGOHprdHRicFhOVlZjSCtRNGhRYkdpYkx6T01oVGd4QmxvN3NmSmVHNC96?=
 =?utf-8?B?RmhnQUF5Mnl4Y2o3NFE2a0hwZkNLbU5PanlSN21sdm9TZUdDTk1zWXZFYWRy?=
 =?utf-8?B?NUhGQ01GOVJHM3dKTndKQnhXVE9zanE3NVExMlN5OEpsNlAvRjdDM0tJajJj?=
 =?utf-8?B?eGx1emp6QVdLTDhITUFXZ0pqV05OcUZGblFhTzFXYWo1dEdiSWh3N3N4SUlW?=
 =?utf-8?B?TURTSW1lOFJlMjZJcERYaThTTldPRmpJLzh1Mm40dlZKVlp4TVFTdEJsT1Nj?=
 =?utf-8?B?R2hNTmhUZlAyeW1KVjVMRzNFUk9sVmZNbmhEdmNEWkpuY2NieEdteFF2aEp2?=
 =?utf-8?B?Z2thdUIwWk5FWHpZWmdSSjV4VTdxQjlLcTRQUlYwdzJrRVdaMG53bC9KYi8x?=
 =?utf-8?B?VzdpUlNvbUNkNEVyOWV5cnBVRVAzc29GdHpvY2o4VEVxcXVPbHZKS1E4SzIr?=
 =?utf-8?B?K2JtMWVibGxLbk1laERaQ0tBRUw0cnJ4RW55Ukp4aldoMHlBSWhBcDc0YVox?=
 =?utf-8?B?Sk91NGxWNGVEdnFiV1pTUGpXWGZOSFkvejFkcGFuQmQ2aUM0ZVoycy8rbVFZ?=
 =?utf-8?B?eGJtYkhFeUx0YVRkaWQ2SWN6cWpYTnZ5dXdyNmdJQ2EzOVNUTU9KOUpLbzl2?=
 =?utf-8?B?eTFZUGxUV21Yb2VMWkJQb1NCK2xMYlRscEtkOTVhSC95U2ltMEtEYUNVMUpp?=
 =?utf-8?B?aXUrN1hKR3hZYkdsakgxWjljU0FGTDVEOVkxOEJ0R2ovR2k2R0pyOCtLZUx4?=
 =?utf-8?B?eGxwLzJubEFHV1ZrNFJKaERQM3V2WWNxY2FBalpxYXNSTnRpc3VzTFdaZkpY?=
 =?utf-8?B?N1lQcjAxTzhJS2J6SUNYWGt2ZVh2Ty9oSzlJakRCYXBLc29sNnBITW53aUti?=
 =?utf-8?B?c0lEV05nVEs3Q1JMSG9LejJPR28wbGV0TWx4QktuVGRnb1BETWxGZ3E0RDBr?=
 =?utf-8?B?WVhyMTdoSGpxSzBieGlyTitONlcwaDVxMnVnVkFCK0d4R0cybTdoZ1BKalFT?=
 =?utf-8?B?YkFpUE16OHVYVzlQalRySWFWQlg4MThZQjBDdU5XZS93SVJDTGxqU0piYUZO?=
 =?utf-8?B?WnRYUWVnSDd0S2JmMjBoWGh3a2V3bDFZNnZvTzZsMTVjRHNSQXpLV2w1eWpx?=
 =?utf-8?B?VHFUamdRdVBGSm1yNndtREZTbjU0b04vMS8wZW5SMWxpcFJTZ0ljUmpnNFpF?=
 =?utf-8?Q?VCX4=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6798.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe72183-376a-4706-733a-08de21e637ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 12:22:59.3819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QYtgbI2cu6nx5zPpCM2x1vJMXUWD6h7ZnCvqoqcdUXkQhvrSh7YPd5m4oUBjRLB34dXZKwW79ISiFi/927fGZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6225

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUb21pIFZh
bGtlaW5lbiA8dG9taS52YWxrZWluZW5AaWRlYXNvbmJvYXJkLmNvbT4NCj4gU2VudDogVHVlc2Rh
eSwgTm92ZW1iZXIgMTEsIDIwMjUgODozNyBQTQ0KPiBUbzogVmlub2QgS291bCA8dmtvdWxAa2Vy
bmVsLm9yZz47IFNpbWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPg0KPiBDYzogZG1h
ZW5naW5lQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgU2FnYXIsIFZpc2hhbCA8dmlz
aGFsLnNhZ2FyQGFtZC5jb20+OyBUb21pDQo+IFZhbGtlaW5lbiA8dG9taS52YWxrZWluZW5AaWRl
YXNvbmJvYXJkLmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSBkbWFlbmdpbmU6IHhpbGlueF9kbWE6
IEVuYWJsZSBJUlFzIGZvciBBWElETUEgaW4NCj4gc3RhcnRfdHJhbnNmZXINCj4NCj4gQ2F1dGlv
bjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2UuIFVzZSBw
cm9wZXINCj4gY2F1dGlvbiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNraW5nIGxpbmtz
LCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiBBIHNpbmdsZSBBWElETUEgY29udHJvbGxlciBjYW4g
aGF2ZSBvbmUgb3IgdHdvIGNoYW5uZWxzLiBXaGVuIGl0IGhhcyB0d28NCj4gY2hhbm5lbHMsIHRo
ZSByZXNldCBmb3IgYm90aCBhcmUgdGllZCB0b2dldGhlcjogcmVzZXR0aW5nIG9uZSBjaGFubmVs
DQo+IHJlc2V0cyB0aGUgb3RoZXIgYXMgd2VsbC4gVGhpcyBjcmVhdGVzIGEgcHJvYmxlbSB3aGVy
ZSByZXNldHRpbmcgb25lDQo+IGNoYW5uZWwgd2lsbCByZXNldCB0aGUgcmVnaXN0ZXJzIGZvciBi
b3RoIGNoYW5uZWxzLCBpbmNsdWRpbmcgY2xlYXJpbmcNCj4gaW50ZXJydXB0IGVuYWJsZSBiaXRz
IGZvciB0aGUgb3RoZXIgY2hhbm5lbCwgd2hpY2ggY2FuIHRoZW4gbGVhZCAgdG8NCj4gdGltZW91
dHMgYXMgdGhlIGRyaXZlciBpcyB3YWl0aW5nIGZvciBhbiBpbnRlcnJ1cHQgd2hpY2ggbmV2ZXIg
Y29tZXMuDQo+DQo+IFRoZSBkcml2ZXIgY3VycmVudGx5IGhhcyBhIHByb2JlLXRpbWUgd29yayBh
cm91bmQgZm9yIHRoaXM6IHdoZW4gYQ0KPiBjaGFubmVsIGlzIGNyZWF0ZWQsIHRoZSBkcml2ZXIg
YWxzbyByZXNldHMgYW5kIGVuYWJsZXMgdGhlDQo+IGludGVycnVwdHMuIFdpdGggdHdvIGNoYW5u
ZWxzIHRoZSByZXNldCBmb3IgdGhlIHNlY29uZCBjaGFubmVsIHdpbGwNCj4gY2xlYXIgdGhlIGlu
dGVycnVwdCBlbmFibGVzIGZvciB0aGUgZmlyc3Qgb25lLiBUaGUgd29yayBhcm91bmQgaW4gdGhl
DQo+IGRyaXZlciBpcyBqdXN0IHRvIG1hbnVhbGx5IGVuYWJsZSB0aGUgaW50ZXJydXB0cyBhZ2Fp
biBpbg0KPiB4aWxpbnhfZG1hX2FsbG9jX2NoYW5fcmVzb3VyY2VzKCkuDQo+DQo+IFRoaXMgd29y
a2Fyb3VuZCBvbmx5IGFkZHJlc3NlcyB0aGUgcHJvYmUtdGltZSBpc3N1ZS4gV2hlbiBjaGFubmVs
cyBhcmUNCj4gcmVzZXQgYXQgcnVudGltZSAoZS5nLiwgaW4geGlsaW54X2RtYV90ZXJtaW5hdGVf
YWxsKCkgb3IgZHVyaW5nIGVycm9yDQo+IHJlY292ZXJ5KSwgdGhlcmUncyBubyBjb3JyZXNwb25k
aW5nIG1lY2hhbmlzbSB0byByZXN0b3JlIHRoZSBvdGhlcg0KPiBjaGFubmVsJ3MgaW50ZXJydXB0
IGVuYWJsZXMuIFRoaXMgbGVhZHMgdG8gb25lIGNoYW5uZWwgaGF2aW5nIGl0cw0KPiBpbnRlcnJ1
cHRzIGRpc2FibGVkIHdoaWxlIHRoZSBkcml2ZXIgZXhwZWN0cyB0aGVtIHRvIHdvcmssIGNhdXNp
bmcNCj4gdGltZW91dHMgYW5kIERNQSBmYWlsdXJlcy4NCj4NCj4gQSBwcm9wZXIgZml4IGlzIGEg
Y29tcGxpY2F0ZWQgbWF0dGVyLCBhcyB3ZSBzaG91bGQgbm90IHJlc2V0IHRoZSBvdGhlcg0KPiBj
aGFubmVsIHdoZW4gaXQncyBvcGVyYXRpbmcgbm9ybWFsbHkuIFNvLCBwZXJoYXBzLCB0aGVyZSBz
aG91bGQgYmUgc29tZQ0KPiBraW5kIG9mIHN5bmNocm9uaXphdGlvbiBmb3IgYSBjb21tb24gcmVz
ZXQsIHdoaWNoIGlzIG5vdCB0cml2aWFsIHRvDQo+IGltcGxlbWVudC4gVG8gYWRkIHRvIHRoZSBj
b21wbGV4aXR5LCB0aGUgZHJpdmVyIGFsc28gc3VwcG9ydHMgb3RoZXIgRE1BDQo+IHR5cGVzLCBs
aWtlIFZETUEsIENETUEgYW5kIE1DRE1BLCB3aGljaCBkb24ndCBoYXZlIGEgc2hhcmVkIHJlc2V0
Lg0KPg0KPiBIb3dldmVyLCB3aGVuIHRoZSB0d28tY2hhbm5lbCBBWElETUEgaXMgdXNlZCBpbiB0
aGUgKGFzc3VtYWJseSkgbm9ybWFsDQo+IHVzZSBjYXNlLCBwcm92aWRpbmcgRE1BIGZvciBhIHNp
bmdsZSBtZW1vcnktdG8tbWVtb3J5IGRldmljZSwgdGhlDQo+IGNvbW1vbg0KPiByZXNldCBpcyBh
IGJpdCBzbWFsbGVyIGlzc3VlOiB3aGVuIHNvbWV0aGluZyBiYWQgaGFwcGVucyBvbiBvbmUgY2hh
bm5lbCwNCj4gb3Igd2hlbiBvbmUgY2hhbm5lbCBpcyB0ZXJtaW5hdGVkLCB0aGUgYXNzdW1wdGlv
biBpcyB0aGF0IHdlIGFsc28gd2FudA0KPiB0byB0ZXJtaW5hdGUgdGhlIG90aGVyIGNoYW5uZWwu
IEFuZCB0aHVzIHJlc2V0dGluZyBib3RoIGF0IHRoZSBzYW1lIHRpbWUNCj4gaXMgIm9rIi4NCj4N
Cj4gV2l0aCB0aGF0IGxpbmUgb2YgdGhpbmtpbmcgd2UgY2FuIGltcGxlbWVudCBhIGJpdCBiZXR0
ZXIgd29yayBhcm91bmQNCj4gdGhhbiBqdXN0IHRoZSBjdXJyZW50IHByb2JlIHRpbWUgd29yayBh
cm91bmQ6IGxldCdzIGVuYWJsZSB0aGUNCj4gQVhJRE1BIGludGVycnVwdHMgYXQgeGlsaW54X2Rt
YV9zdGFydF90cmFuc2ZlcigpIGluc3RlYWQuDQo+IFRoaXMgZW5zdXJlcyBpbnRlcnJ1cHRzIGFy
ZSBlbmFibGVkIHdoZW5ldmVyIGEgdHJhbnNmZXIgc3RhcnRzLA0KPiByZWdhcmRsZXNzIG9mIGFu
eSBwcmlvciByZXNldHMgdGhhdCBtYXkgaGF2ZSBjbGVhcmVkIHRoZW0uDQo+DQo+IFRoaXMgYXBw
cm9hY2ggaXMgYWxzbyBtb3JlIGxvZ2ljYWw6IGVuYWJsZSBpbnRlcnJ1cHRzIG9ubHkgd2hlbiBu
ZWVkZWQNCj4gZm9yIGEgdHJhbnNmZXIsIHJhdGhlciB0aGFuIGF0IHJlc291cmNlIGFsbG9jYXRp
b24gdGltZSwgYW5kLCBJIHRoaW5rLA0KPiBhbGwgdGhlIG90aGVyIERNQSB0eXBlcyBzaG91bGQg
YWxzbyB1c2UgdGhpcyBtb2RlbCwgYnV0IEknbSByZWx1Y3RhbnQgdG8NCj4gZG8gc3VjaCBjaGFu
Z2VzIGFzIEkgY2Fubm90IHRlc3QgdGhlbS4NCj4NCj4gVGhlIHJlc2V0IGZ1bmN0aW9uIHN0aWxs
IGVuYWJsZXMgaW50ZXJydXB0cyBldmVuIHRob3VnaCBpdCdzIG5vdCBuZWVkZWQNCj4gZm9yIEFY
SURNQSBhbnltb3JlLCBidXQgaXQncyBjb21tb24gY29kZSBmb3IgYWxsIERNQSB0eXBlcyAoVkRN
QSwgQ0RNQSwNCj4gTUNETUEpLCBzbyBsZWF2ZSBpdCB1bmNoYW5nZWQgdG8gYXZvaWQgYWZmZWN0
aW5nIG90aGVyIHZhcmlhbnRzLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBUb21pIFZhbGtlaW5lbiA8
dG9taS52YWxrZWluZW5AaWRlYXNvbmJvYXJkLmNvbT4NCj4gLS0tDQoNCkEgd2FybmluZyBoYXMg
bG9uZyBiZWVuIGluY2x1ZGVkIGluIHRoZSBQRyBzdGF0aW5nIHRoYXQgbXVsdGljaGFubmVsIHN1
cHBvcnQgZm9yIEFYSSBETUEgd2lsbCBiZSBkaXNjb250aW51ZWQuIFBsZWFzZSByZWZlciAyMDIy
LjEgQVhJRE1BIFBHOg0KIGh0dHBzOi8vd3d3LmFtZC5jb20vY29udGVudC9kYW0veGlsaW54L3N1
cHBvcnQvZG9jdW1lbnRzL2lwX2RvY3VtZW50YXRpb24vYXhpX2RtYS92N18xL3BnMDIxX2F4aV9k
bWEucGRmIDogUHJvZHVjdCBTcGVjaWZpY2F0aW9uL011bHRpY2hhbm5lbCBETUEgc3VwcG9ydC4N
ClRoZXJlZm9yZSwgaXQncyB1bm5lY2Vzc2FyeSB0byBtYWtlIGNoYW5nZXMgZm9yIG11bHRpcGxl
IGNoYW5uZWwgc3VwcG9ydC4NCg0KPiAgZHJpdmVycy9kbWEveGlsaW54L3hpbGlueF9kbWEuYyB8
IDkgKy0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDggZGVsZXRp
b25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS94aWxpbngveGlsaW54X2RtYS5j
IGIvZHJpdmVycy9kbWEveGlsaW54L3hpbGlueF9kbWEuYw0KPiBpbmRleCBhMzRkOGYwY2VlZDgu
LjUwZGQ5M2NlNjc0MSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9kbWEveGlsaW54L3hpbGlueF9k
bWEuYw0KPiArKysgYi9kcml2ZXJzL2RtYS94aWxpbngveGlsaW54X2RtYS5jDQo+IEBAIC0xMjE2
LDE0ICsxMjE2LDYgQEAgc3RhdGljIGludCB4aWxpbnhfZG1hX2FsbG9jX2NoYW5fcmVzb3VyY2Vz
KHN0cnVjdA0KPiBkbWFfY2hhbiAqZGNoYW4pDQo+DQo+ICAgICAgICAgZG1hX2Nvb2tpZV9pbml0
KGRjaGFuKTsNCj4NCj4gLSAgICAgICBpZiAoY2hhbi0+eGRldi0+ZG1hX2NvbmZpZy0+ZG1hdHlw
ZSA9PSBYRE1BX1RZUEVfQVhJRE1BKSB7DQo+IC0gICAgICAgICAgICAgICAvKiBGb3IgQVhJIERN
QSByZXNldHRpbmcgb25jZSBjaGFubmVsIHdpbGwgcmVzZXQgdGhlDQo+IC0gICAgICAgICAgICAg
ICAgKiBvdGhlciBjaGFubmVsIGFzIHdlbGwgc28gZW5hYmxlIHRoZSBpbnRlcnJ1cHRzIGhlcmUu
DQo+IC0gICAgICAgICAgICAgICAgKi8NCj4gLSAgICAgICAgICAgICAgIGRtYV9jdHJsX3NldChj
aGFuLCBYSUxJTlhfRE1BX1JFR19ETUFDUiwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgWElMSU5YX0RNQV9ETUFYUl9BTExfSVJRX01BU0spOw0KPiAtICAgICAgIH0NCj4gLQ0KPiAg
ICAgICAgIGlmICgoY2hhbi0+eGRldi0+ZG1hX2NvbmZpZy0+ZG1hdHlwZSA9PSBYRE1BX1RZUEVf
Q0RNQSkgJiYNCj4gY2hhbi0+aGFzX3NnKQ0KPiAgICAgICAgICAgICAgICAgZG1hX2N0cmxfc2V0
KGNoYW4sIFhJTElOWF9ETUFfUkVHX0RNQUNSLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFhJTElOWF9DRE1BX0NSX1NHTU9ERSk7DQo+IEBAIC0xNTcyLDYgKzE1NjQsNyBAQCBzdGF0
aWMgdm9pZCB4aWxpbnhfZG1hX3N0YXJ0X3RyYW5zZmVyKHN0cnVjdA0KPiB4aWxpbnhfZG1hX2No
YW4gKmNoYW4pDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaGVhZF9kZXNjLT5hc3lu
Y190eC5waHlzKTsNCj4gICAgICAgICByZWcgICY9IH5YSUxJTlhfRE1BX0NSX0RFTEFZX01BWDsN
Cj4gICAgICAgICByZWcgIHw9IGNoYW4tPmlycV9kZWxheSA8PCBYSUxJTlhfRE1BX0NSX0RFTEFZ
X1NISUZUOw0KPiArICAgICAgIHJlZyB8PSBYSUxJTlhfRE1BX0RNQVhSX0FMTF9JUlFfTUFTSzsN
Cj4gICAgICAgICBkbWFfY3RybF93cml0ZShjaGFuLCBYSUxJTlhfRE1BX1JFR19ETUFDUiwgcmVn
KTsNCj4NCj4gICAgICAgICB4aWxpbnhfZG1hX3N0YXJ0KGNoYW4pOw0KPg0KPiAtLS0NCj4gYmFz
ZS1jb21taXQ6IGU1ZjBhNjk4YjM0ZWQ3NjAwMmRjNWNmZjM4MDRhNjFjODAyMzNhN2ENCj4gY2hh
bmdlLWlkOiAyMDI1MTExMS14aWxpbngtZG1hLWZpeC1iYzI2YTZlOWJlNWENCj4NCj4gQmVzdCBy
ZWdhcmRzLA0KPiAtLQ0KPiBUb21pIFZhbGtlaW5lbiA8dG9taS52YWxrZWluZW5AaWRlYXNvbmJv
YXJkLmNvbT4NCj4NCg0K

