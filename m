Return-Path: <dmaengine+bounces-7813-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 281CDCCD580
	for <lists+dmaengine@lfdr.de>; Thu, 18 Dec 2025 20:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1F8C30B62E7
	for <lists+dmaengine@lfdr.de>; Thu, 18 Dec 2025 19:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB9933B6FF;
	Thu, 18 Dec 2025 19:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AdJPgXsD"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012053.outbound.protection.outlook.com [40.107.200.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79BB30FC31;
	Thu, 18 Dec 2025 19:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766084812; cv=fail; b=C/YpyIHq58nst+ojRs0a2B7hXrMEq+gApX/5Y1pqTqLXuPTdjyOVpLwOYnllfSplHQshSPQUuskAehdk4mrfqYrq/sHtsH0NOeiV9FN31/IO2npXrRsvnVyMZgGpNf0NWOudBw5lhoorEOuRZWjwYazzsnY9mMkkI/NrN01YN0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766084812; c=relaxed/simple;
	bh=hjZxaTg2PDSamNPs8j9rvwEcNP8wPmPeaze1d3Ygor4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s6Sv/jx5tDc+sFtnw+QJ3UuLMmnledm9b2li4v3Q5W33c38koajwjvUFYJbAhdsHdQhGfudgYxGJ4lqCnVtLYRJr4rhHoYB2z0sdwI9UjFsR9uoORLxL0Hb95K3e9bKoe7bKq4RV3G1WTOnC+Or9OZ66i6Hv4iXMto6GqLuH0QA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AdJPgXsD; arc=fail smtp.client-ip=40.107.200.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXXflOesXxV/2aqzzrsDi7g2RfhMqDaFl5i3RuTknT7p+Q3+XwYShdw0207d15aEQYiozNW+IcW8oSi4ie/MLXiw2uqcxwlB2ht3Na0ngWDJ1O8No+XGNysJCVo3kd3uScjfxOck+Fyayf3WqUOKx9bOoJ3MgRtVb15B6vYKL2BDGDIK5mZl0LNe4eL2iaasFrmGVN+j9aX53rSRnamDd+O8TWYUbe7jlpJSUiZrHQZnosI9YSN9eIYkuM4PGg89ZCNqhKhh/FOd5qbXFBGaUicb/uyIBevYhPDIdLTlOapHJhFQ10KKnamZwMxKlelu1+o9glEgbc6wBmhWFgXB2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjZxaTg2PDSamNPs8j9rvwEcNP8wPmPeaze1d3Ygor4=;
 b=OMlPUGjB8EfzN7U1dr+Dx01vEVSipVmoGWYyFJvBpn3TlCVitBff+o2Ayt1gtwfv9LHot5yZ4/x6reIAC32IDPqcTZTE9VueQPuqSCYxMO249mIqIOp/EXcU/Z7cy+TgKfqb8y84cHCStxt8ptdaYgwDCJENTv7m3/wRkQngSqoXomHea4dZbu2cTwc+hzdRR+6IBMhzIIZrHJ6F/25RVQA/AhFv3HAJVxQNYniB0EdgULInPT3ZE6JUqJ2TzY7D5J1DE7SaJR59XRE2rX2l/2+GDJi5FxyyFg3vRfWlezidjVRLU8VC+MT9LHS2pNl2RScjnNaPNdv2N1ua3WN3vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjZxaTg2PDSamNPs8j9rvwEcNP8wPmPeaze1d3Ygor4=;
 b=AdJPgXsDuBWxRbyfWOd7DBz15eoQANK+cIJaGBfLDy41noTKyDOrx2jbAMfel3zD3sdyyD8GgpcL2mHR2eJp18gKVcjQwsPW005JZvqd6P222AscMXWnyAcguOSsvyUu30nomU4qtw7wYxGG+FBcorUihNeOJSyTqsA+nMH8OJU=
Received: from SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22)
 by LV2PR12MB5822.namprd12.prod.outlook.com (2603:10b6:408:179::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.12; Thu, 18 Dec
 2025 19:06:45 +0000
Received: from SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::8ccf:715:fdc4:8a14]) by SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::8ccf:715:fdc4:8a14%3]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 19:06:45 +0000
From: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Vinod Koul
	<vkoul@kernel.org>, "Simek, Michal" <michal.simek@amd.com>, "Sagar, Vishal"
	<vishal.sagar@amd.com>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>
Subject: RE: [PATCH] dmaengine: xilinx_dma: Add support for residue on direct
 AXIDMA S2MM
Thread-Topic: [PATCH] dmaengine: xilinx_dma: Add support for residue on direct
 AXIDMA S2MM
Thread-Index: AQHcb/sG+HK+5LceuEezuw0Ada/i27UnwhkA
Date: Thu, 18 Dec 2025 19:06:44 +0000
Message-ID:
 <SA1PR12MB67987D5966B2D69688015A88C9A8A@SA1PR12MB6798.namprd12.prod.outlook.com>
References:
 <20251218-xilinx-dma-residue-fix-v1-1-7cd221d69d6b@ideasonboard.com>
In-Reply-To:
 <20251218-xilinx-dma-residue-fix-v1-1-7cd221d69d6b@ideasonboard.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-18T19:03:44.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB6798:EE_|LV2PR12MB5822:EE_
x-ms-office365-filtering-correlation-id: 64d933e7-4982-4346-7c3a-08de3e689628
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?OElXR0daRXpZd2lnMzdQOTFvcFRXOXV4aEJPSWd3YkxPbkxqZkJvMytqcjk2?=
 =?utf-8?B?OFhWc1JNM2wzTXphZmxuY2hNNm5HUW9PZVZNUGRDUkZiU3Q3UFhyTFFYK2do?=
 =?utf-8?B?dmhqSWQvZ2RjL1M3bmhjdmxoZUxmVWRmdENuK0hlR0xlajlzOS9NOG5ORkhu?=
 =?utf-8?B?Y3VwZ0RYQ3NiamNYeW9iZk1RSVI5akd6d1AvaW8yWERSZkgvQVFINTl0S0Jh?=
 =?utf-8?B?ZVFzd2ZiejFCL0ZTNHI1cU5kQ2U4d0J6VHZCaGhDMGJHUUFPSmNrTXlnN1dS?=
 =?utf-8?B?QmlKV3ZZSEt5K29tcEtvR0lJU3JXcVJBWjdxUWp3Rk1EcGNqRi94ZHJOcC9Q?=
 =?utf-8?B?VzJQczFmbjY5WmFlT0d4Q3JCeEFhNDZVdkdBT1FmVlpVbEo2L1RMYUowakNs?=
 =?utf-8?B?SW44b2VPM2EyNmkzanVsa1o4VU8yYnUyL1A0ZDN3RXhuZE83andIWGhmVWs4?=
 =?utf-8?B?MUVJNHRaUkx3djBEVWo1RnU0aVMrZWJwVmQ0Uk9Zb3JDVTJKS1dpVXI0azk1?=
 =?utf-8?B?OVZsdTNuNEdlNjUyYXJySkwwejdmTExZbW1VVjFhR2xteWw1a1lRUTAzTGxU?=
 =?utf-8?B?TktFR3NlODh4QnkxbXRNdjdUNDlwNnhnSmVrcDltbVkzSUNLdk5DUDZrcC9M?=
 =?utf-8?B?UGQ3Y0FmbFNUeVBra2xsWXBCMEYrcW1ZSTBCeWVPVkl0eUxrcW9SditacEM1?=
 =?utf-8?B?aE1la3BOeTM1WjVPcEpFQ1hsUjBzK0dOMWRhY2tXUzJSUHRqak5reXBERXFv?=
 =?utf-8?B?MENod0R5Vkc1QzJWcjRuVW9vZ0FTMWtPcHFTdk5yNk15aE1FZE0yQ1pmbUN2?=
 =?utf-8?B?aVdZYzRTNlByMHE2cFpCUTJZbWNrVml0ejA4U0xZTWcyL3FyRncvRnVVYzFX?=
 =?utf-8?B?WW8raUZpcDR5RUpwUUtYdWtDUks3U0h6R1ZCdlBJRkdQK2JlZEhhZHA2ajE4?=
 =?utf-8?B?bDFlN0FTN0dGMExUVll3cXRLT0RFTHBObUhXRGlNSmF2MmlhWGhCRTdIMEJq?=
 =?utf-8?B?QlZuaVVjUzBwZytTdjIyeGRmV0xXSUpYWXZJMW11d3NONEIyVHZ1NXU4SUJa?=
 =?utf-8?B?cFZIelpyMGQyemxOUWJLN0IzRER0T2NxTnJCQlRzVWxHSDdyS3M2c2dVUkRQ?=
 =?utf-8?B?QTFpRnFXV2VDQjFPaXJXT0NkVCtxY3BSekxYRTdZTlpRSU9kbGlLZGhPY2FS?=
 =?utf-8?B?WW5yRzRjRUNRaTgrRHl2YnJvNEkzSmQ0QmJRR0NwWlA5bW02OXhhb2pJYUFM?=
 =?utf-8?B?bHAwTnVMQ0xBVFM4ak1LN29uVTdtdW1COXV0a1gzeHFwUmxaWVBCMW1yN0p0?=
 =?utf-8?B?Q3g2eXBBcVZnK1FJR3FBNC8xMlZ0NHdNUGFKRVdrc1VZZ2gyN2Z1RlNEZjVn?=
 =?utf-8?B?TFgxWTZqZ3NIdk5mVkFIU3c2bTRzQ1hVUDdPVVNCelBhQ2FZaHZRSE9Hdyt3?=
 =?utf-8?B?Uk9jYUttc3I2eHRmbVRKNWNtNVdaeFNqMys0Y2t3SFJ1Y08wQkpRSkpYbTRG?=
 =?utf-8?B?MDJJUERGZ2dJeXRRK3NpN1ZlK00vcmJ3cDRNUi9NaFVFcVdNOGxtSDdMem5M?=
 =?utf-8?B?T3RvYzRWSzgvOTRmbFg1eC9TbWJjcmFRUzBMdHF5b2Zxc21aMk9PcUQwK3Fo?=
 =?utf-8?B?V2doQUc1bk4vZFZ4NTd0YUNZYkhmOFFyejNreHc3RXN6NWo1Yy95TE1CUjYy?=
 =?utf-8?B?d2pqZm1NSkp1NU1iKzlnby93YmFFNCsxNGFmMU9CRWIrVThvbHc2YnUxVzd4?=
 =?utf-8?B?TkZFUlZHN2JydkZCUmhvRzYvanl0ZXhwNWVMWEVMQmRwQkFIZHlrNWRma2hk?=
 =?utf-8?B?dWoyMmo3ZzBlVjVlaFByRWFvd1FIaXhpTDBYeXRRNmpqdnpKcURRWWc0bDdw?=
 =?utf-8?B?ZnpHZElHWFBGRkhlTnc5VzFicGdwQ3h3azFFbllkZTZVRDlKV3FSREswTTF6?=
 =?utf-8?B?WjB4aVoxNFYyaEZLa1VGdGE3MDMwbnZyTUd1VmRza0hQK2grOEYrM2l1NTVx?=
 =?utf-8?B?R0lCTWJ3MUVMOG51N1dTejlvaGR0azFuRkRZOXhvOGcxUU5iYjBBTjNJUXJS?=
 =?utf-8?Q?BfbdUp?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6798.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cHp5cDZkY0FKTWQ5UjZnVkZaRUVSd3NZc2RteVlVK0JJT3ZYL1ZCRzVsd2x5?=
 =?utf-8?B?N2FqT2MxU3dEZ2RGdUkxWXZ0d0FlQVFrcWw5Yzg0RkdIejkwYU4xVDRHOG1z?=
 =?utf-8?B?NmUzQ2xuRy9uWjBzVTFRSENBTkdhbitSRW5xWTFlNzd2cmR4cGlNNVBpUHFa?=
 =?utf-8?B?VGZTVkVVVkwvQWJJcFJXZ1Z1SDduYk9yMjBSZjdBNmNZL1Z1cXZEKzVZbzFV?=
 =?utf-8?B?QU1KRjNwcTZCNUI5VUlnd253Smd1OHU0VFQ5Z2IrdGI3T2dSbEt1RHV3cVlL?=
 =?utf-8?B?QzlXcFNwanVOanR1MnRQY1VKVzhPaHR6OTBnaGJKbHV4b3FwUzZkU3liNmU0?=
 =?utf-8?B?VlBud2NTZ29WMVRWYlVwY0VlYXdoRzJ0dFFNcWtLNHdRZXRDRmtDV28yd25r?=
 =?utf-8?B?aEMxMlcxaUpDNE5rYVBQODRHR0NGRGlRSnNtNTM4dWhzZkk0ZHpOdnI2b1Zl?=
 =?utf-8?B?aWZMemhJVmJoM2FHY1VEOVk4ZnJPVkx4QVdFSzI3Wjh0VjEyRjdUK3QwajJl?=
 =?utf-8?B?WUt5VVhxRVpVQUxCNUFZK0xLSFV0WUE1cUppSEd4UWRRN2ZzTERhcGVsWHRS?=
 =?utf-8?B?S093bnFnTk1ZZEVlZ2NKSlE0eFJ0N2tVWWNVZkdCT29WenVsYzl0RlZ0Z1JD?=
 =?utf-8?B?Yi90bHhOMm1UaElCNldnWUkxbG1BREhXMEkrSkdmQzFnWGY3bEJmUW53cXYw?=
 =?utf-8?B?L0UwVk9scmFEY2Z4bEVKZmlrNWwzQWQ0Q01uL2lWOElpVnVPTUFseVhMb3p4?=
 =?utf-8?B?SFo0bnRlQ3lpdHV6dWE2NEZmWUxncGxBcVlPWm5EYlRBSEpGTUFoY3pSTFdZ?=
 =?utf-8?B?d0JveVN3SjlZMlVpVHk0L2JidlFtekZOSXoxQ3dZTnIvYi9KUDhsdExvbmxC?=
 =?utf-8?B?YzBocDgxSzRPMGlsdUgvL1Y4dkZkK3EwV2t1RmdmTlZUcHdZdnFIUjJBTDd3?=
 =?utf-8?B?bGFjbkRqTllWTkkxU05JbGxWMU1LdFVXdVZ5Tk9KOGhFdTZGZHhqVFlMZnJD?=
 =?utf-8?B?V1VYMHhOOWp6K0hjT0ZlWXVvUGUzRG9NYjhMUUZrWjhuZ0tKWG53Ri9WdWpD?=
 =?utf-8?B?VkcyQ1RSUEljcHNNb3lLRVRsR0J1b0Q5VEhGdXJLRFluT3JiM2dvWm0vT2Jn?=
 =?utf-8?B?VFh2aUxJRzh0MEhka2NQMUU3cHFQcmdiM0lNZCtaZENvd3BkUDFnRFdZM1NL?=
 =?utf-8?B?YU5mWDRicGw1MlVmY2FkNzk3Z1BoUG5tMzRTN1lPMGRJaEJpb3hTUE9tTkRm?=
 =?utf-8?B?RFdmdVphUHJxNTlxZVFvVVRqa1BZamZRdWJ3QTlOcUtFY2txbVN0NmpSeDJ1?=
 =?utf-8?B?czZHeW41eXBnNUlUZ2xLRlB4N0NWYUovRm92Wi9OaU1RUm9OMEtIalhuQTIy?=
 =?utf-8?B?RTlKSGVHUDFvcDlyRWp2ZGlBU3daU3Z3cUpoaURReExtT0VyWkw0RmNwMHVS?=
 =?utf-8?B?T1d6QW5JQ0Z6WkVJNm14M1ZwYTVUeHJ1WDlCaGVCRnB3T3JzYW1hYnFPWXV3?=
 =?utf-8?B?VDhvQjBFMDU0Rjd2UXo5YVg1VzZyUnBNVVRIOFAzcWZQWUR6VGt3dU9CNGxt?=
 =?utf-8?B?TXMvc092dytTZm90a0RraVFMMG1VMmFsbEtRMjdMWDFwWkFjdGNqVHl6Y3ZR?=
 =?utf-8?B?Zmh2Qm9MY1A0S0I5bXJHR0ZyQklPVUhrMHJMTUFLWUx1TGRPRTQvdStIYXEx?=
 =?utf-8?B?cE9NNE9obDVDWVJOYnZOSkhSUi9sL2p0VWt3SVNHdGZyWEJoenFibE9pam0y?=
 =?utf-8?B?NE1EMDNGRExhd1MzLyswbW9XUzFlT2ZuWGdMRW13N1BweE4wSkFybVAwRk00?=
 =?utf-8?B?RWhKN1RZSysyOTlkMDAwZlRVZ0wvSXpRRWFMREJuZW03S3gwQ29NMEJKWlZS?=
 =?utf-8?B?aVZjQjFrNGpLcmcrWXU3SlBCSEV3eldtUnNhSiszeGhOZ2dwWWdRUjVrQjIx?=
 =?utf-8?B?aXdoRkdjTEJJNTc5UmgrMFkrcHJ2NnlCSWlkNXpJREZLY2taNVhwR0I4Y3kv?=
 =?utf-8?B?ZWlRM2liT0FpeHhwc1ZKVTkyelpZWDdTU2UxVEdoUFhOcUlpM1RLdmZOTGJs?=
 =?utf-8?B?Ui9tMDNtTVc0L1AxYW11TitwWHV0d0x4UEdMMUNnTzYzdmZGRDdaQTE1bHQ1?=
 =?utf-8?Q?7cAc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d933e7-4982-4346-7c3a-08de3e689628
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2025 19:06:44.9838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kXaHv+sWttam2hkmVtZhw7VlTALuhz29Qm4VuXiFbZKukuGwMPm2VlRo3hnhXpQI7NUU2ZpYFwCYglHs/C6zMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5822

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUb21pIFZhbGtlaW5lbiA8
dG9taS52YWxrZWluZW5AaWRlYXNvbmJvYXJkLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIERlY2Vt
YmVyIDE4LCAyMDI1IDI6MTAgUE0NCj4gVG86IFZpbm9kIEtvdWwgPHZrb3VsQGtlcm5lbC5vcmc+
OyBTaW1laywgTWljaGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47DQo+IFNhZ2FyLCBWaXNoYWwg
PHZpc2hhbC5zYWdhckBhbWQuY29tPg0KPiBDYzogZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZzsg
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4ga2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgTGF1cmVudCBQaW5jaGFydA0KPiA8bGF1cmVudC5waW5jaGFydEBpZGVh
c29uYm9hcmQuY29tPjsgVG9taSBWYWxrZWluZW4NCj4gPHRvbWkudmFsa2VpbmVuQGlkZWFzb25i
b2FyZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSF0gZG1hZW5naW5lOiB4aWxpbnhfZG1hOiBBZGQg
c3VwcG9ydCBmb3IgcmVzaWR1ZSBvbiBkaXJlY3QNCj4gQVhJRE1BIFMyTU0NCj4NCj4gQ2F1dGlv
bjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2UuIFVzZSBw
cm9wZXIgY2F1dGlvbg0KPiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNraW5nIGxpbmtz
LCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiBBWElETUEgSVAgc3VwcG9ydHMgcmVwb3J0aW5nIHRo
ZSBhbW91bnQgb2YgYnl0ZXMgdHJhbnNmZXJyZWQgb24gdGhlIFMyTU0NCj4gY2hhbm5lbCBpbiBk
aXJlY3QgbW9kZSAoaS5lLiBub24tU0cpLCBidXQgdGhlIGRyaXZlciBkb2VzIG5vdC4gVGh1cyB0
aGUNCj4gZHJpdmVyIGFsd2F5cyByZXBvcnRzIHRoYXQgYWxsIG9mIHRoZSBidWZmZXIgd2FzIGZp
bGxlZC4NCj4NCj4gQWRkIHhpbGlueF9kbWFfZ2V0X3Jlc2lkdWVfYXhpZG1hX2RpcmVjdF9zMm1t
KCkgd2hpY2ggZ2V0cyB0aGUgcmVzaWR1ZQ0KPiBhbW91bnQgZm9yIGRpcmVjdCBBWElETUEgZm9y
IFMyTU0gZGlyZWN0aW9uLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBUb21pIFZhbGtlaW5lbiA8dG9t
aS52YWxrZWluZW5AaWRlYXNvbmJvYXJkLmNvbT4NCg0KDQpMb29rcyBmaW5lIHRvIG1lLg0KUmV2
aWV3ZWQtYnk6IFN1cmFqIEd1cHRhIDxzdXJhai5ndXB0YTJAYW1kLmNvbT4NCg0KPiAtLS0NCj4g
IGRyaXZlcnMvZG1hL3hpbGlueC94aWxpbnhfZG1hLmMgfCAyMSArKysrKysrKysrKysrKysrKysr
KysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2RtYS94aWxpbngveGlsaW54X2RtYS5jIGIvZHJpdmVycy9kbWEveGlsaW54L3hp
bGlueF9kbWEuYw0KPiBpbmRleCBmYWJmZjYwMjA2NWYuLjY0YjNmYmE0ZTQ0ZiAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9kbWEveGlsaW54L3hpbGlueF9kbWEuYw0KPiArKysgYi9kcml2ZXJzL2Rt
YS94aWxpbngveGlsaW54X2RtYS5jDQo+IEBAIC0xMDIxLDYgKzEwMjEsMjQgQEAgc3RhdGljIHUz
MiB4aWxpbnhfZG1hX2dldF9yZXNpZHVlKHN0cnVjdA0KPiB4aWxpbnhfZG1hX2NoYW4gKmNoYW4s
DQo+ICAgICAgICAgcmV0dXJuIHJlc2lkdWU7DQo+ICB9DQo+DQo+ICtzdGF0aWMgdTMyDQo+ICt4
aWxpbnhfZG1hX2dldF9yZXNpZHVlX2F4aWRtYV9kaXJlY3RfczJtbShzdHJ1Y3QgeGlsaW54X2Rt
YV9jaGFuICpjaGFuLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBzdHJ1Y3QgeGlsaW54X2RtYV90eF9kZXNjcmlwdG9yICpkZXNjKQ0KPiArew0KPiArICAgICAg
IHN0cnVjdCB4aWxpbnhfYXhpZG1hX3R4X3NlZ21lbnQgKnNlZzsNCj4gKyAgICAgICBzdHJ1Y3Qg
eGlsaW54X2F4aWRtYV9kZXNjX2h3ICpodzsNCj4gKyAgICAgICB1MzIgZmluaXNoZWRfbGVuOw0K
PiArDQo+ICsgICAgICAgZmluaXNoZWRfbGVuID0gZG1hX2N0cmxfcmVhZChjaGFuLCBYSUxJTlhf
RE1BX1JFR19CVFQpOw0KPiArDQo+ICsgICAgICAgc2VnID0gbGlzdF9maXJzdF9lbnRyeSgmZGVz
Yy0+c2VnbWVudHMsIHN0cnVjdCB4aWxpbnhfYXhpZG1hX3R4X3NlZ21lbnQsDQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBub2RlKTsNCj4gKw0KPiArICAgICAgIGh3ID0gJnNlZy0+
aHc7DQo+ICsNCj4gKyAgICAgICByZXR1cm4gaHctPmNvbnRyb2wgLSBmaW5pc2hlZF9sZW47DQo+
ICt9DQo+ICsNCj4gIC8qKg0KPiAgICogeGlsaW54X2RtYV9jaGFuX2hhbmRsZV9jeWNsaWMgLSBD
eWNsaWMgZG1hIGNhbGxiYWNrDQo+ICAgKiBAY2hhbjogRHJpdmVyIHNwZWNpZmljIGRtYSBjaGFu
bmVsDQo+IEBAIC0xNzMyLDYgKzE3NTAsOSBAQCBzdGF0aWMgdm9pZCB4aWxpbnhfZG1hX2NvbXBs
ZXRlX2Rlc2NyaXB0b3Ioc3RydWN0DQo+IHhpbGlueF9kbWFfY2hhbiAqY2hhbikNCj4gICAgICAg
ICAgICAgICAgIGlmIChjaGFuLT5oYXNfc2cgJiYgY2hhbi0+eGRldi0+ZG1hX2NvbmZpZy0+ZG1h
dHlwZSAhPQ0KPiAgICAgICAgICAgICAgICAgICAgIFhETUFfVFlQRV9WRE1BKQ0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICBkZXNjLT5yZXNpZHVlID0geGlsaW54X2RtYV9nZXRfcmVzaWR1ZShj
aGFuLCBkZXNjKTsNCj4gKyAgICAgICAgICAgICAgIGVsc2UgaWYgKGNoYW4tPnhkZXYtPmRtYV9j
b25maWctPmRtYXR5cGUgPT0gWERNQV9UWVBFX0FYSURNQQ0KPiAmJg0KPiArICAgICAgICAgICAg
ICAgICAgICAgICAgY2hhbi0+ZGlyZWN0aW9uID09IERNQV9ERVZfVE9fTUVNICYmICFjaGFuLT5o
YXNfc2cpDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGRlc2MtPnJlc2lkdWUgPQ0KPiB4aWxp
bnhfZG1hX2dldF9yZXNpZHVlX2F4aWRtYV9kaXJlY3RfczJtbShjaGFuLCBkZXNjKTsNCj4gICAg
ICAgICAgICAgICAgIGVsc2UNCj4gICAgICAgICAgICAgICAgICAgICAgICAgZGVzYy0+cmVzaWR1
ZSA9IDA7DQo+ICAgICAgICAgICAgICAgICBkZXNjLT5lcnIgPSBjaGFuLT5lcnI7DQo+DQo+IC0t
LQ0KPiBiYXNlLWNvbW1pdDogN2QwYTY2ZTRiYjkwODFkNzVjODJlYzQ5NTdjNTAwMzRjYjBlYTQ0
OQ0KPiBjaGFuZ2UtaWQ6IDIwMjUxMjE4LXhpbGlueC1kbWEtcmVzaWR1ZS1maXgtZjZlNGY5N2Zm
ZTYxDQo+DQo+IEJlc3QgcmVnYXJkcywNCj4gLS0NCj4gVG9taSBWYWxrZWluZW4gPHRvbWkudmFs
a2VpbmVuQGlkZWFzb25ib2FyZC5jb20+DQo+DQoNCg==

