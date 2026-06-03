Return-Path: <dmaengine+bounces-11141-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NtliDBwFIGqquAAAu9opvQ
	(envelope-from <dmaengine+bounces-11141-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 12:42:36 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AF5636AD3
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 12:42:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=obdQNkIO;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11141-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11141-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E7DD304E6BE
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jun 2026 10:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0994345729;
	Wed,  3 Jun 2026 10:30:28 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012044.outbound.protection.outlook.com [52.101.48.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE9436F8F7
	for <dmaengine@vger.kernel.org>; Wed,  3 Jun 2026 10:30:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780482628; cv=fail; b=l5lNSMhOg/yMmzi6DYtQoxAQ24l3Ar5Lcq7Rs29/1PTQVULiT+qN1u1Js9l0WEJS97EVrQUeBzEbKHzkv2hYzQt99gah0QnWxx28Ac/qQeJQLMTW9aAkBD/ATnfD4jb0mFMraPt08DoWCJnmTGJruiGYdNKM4RVJ1yqcvhS8exc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780482628; c=relaxed/simple;
	bh=vU/u+Hmu99/MD61ToseXSKJPViyiC7AQQM1gMS9kwFQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UqkoBuA3LR3q6+PvcwqMnNCxKhzJFhEg7/obGEUgLGkaltB9OI/WKX6XQOoHEKbyZ0TGWO+hQ2MZC9y0JyQHOQwmlEBjhi49qVjpkQmX/yqFxt2PfE1cT0I5EkKwvkqJsutyTZUPsbPz1KofOoi5GrNZK9uLyNeIF1b7sJ5ETWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=obdQNkIO; arc=fail smtp.client-ip=52.101.48.44
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T8f2R/XjPRNS0XEVU8ksXuQx8MJ7KnfAA1MOB/APX2lja0VQLMMqCGKIB8aPN55iWZPvtYYvxuMwGvlAh2xvUw/8Y7PjRsrHiFM9nalE2EpCrMf2H5PiWtK+fKymRG6AHhZNeIP2mDCLQjxq9d03Qc5ZrjoqBm8R/OBBEwgkU4ICAgliTRi4xHqJNrvQSCyk7IAY1Uu+fbds3JQU2yY7ghI9f7938KKx3tZ7vmtgaZBqH4Wya0tZUP789hMV54htz+LabmTofar4ZUjJu9T5/34XC2dYFlvz/e1Vw+UqXdTwOcfWQbWZpo0vpOEJ86BTKFkgiUE1n0E1Z4KLvotoeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vU/u+Hmu99/MD61ToseXSKJPViyiC7AQQM1gMS9kwFQ=;
 b=V1VaYs04lYUX0nCL7Uv9jrWovpBhjV831v1af313hTiKHAforEzwCObVuMvOrdvHSnPAiKPd9f8AJYYvdW0J3qSLzN0TnKGGx1hTqvbH280Uid8icy31Rj88VwCgQ0XopE3pxvWrUya2k/POvINcsQra/VbSA8CysaP4JsK29Lk1SLRA5NkN1+t7twiDdbJrHo0aLFjOBs+Uwnic8plA2BRmRI7YLfZknWPu6/ZhGg63oxb/LW5/GUxfsnj+jk8Fr2bShfztLFwNYsEfyeu6LDx6zu9xOIChLoow5b3bFyNQvRbdJucltpY/u2v/hbGJnEWhqpvGQelunBQuAxuVhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vU/u+Hmu99/MD61ToseXSKJPViyiC7AQQM1gMS9kwFQ=;
 b=obdQNkIOFyPTevQvHcnR16nMdhYqYMQGidsAEkYykibJGmpjjD3loHOPlugx6hv5Y0h2OxPt8gPGI5cCra20B+SGg7c/Xkh+XBXpGbpYEWRu958t4NujaRyl/WJ1vU6JzFvgJ/b/5e0OYclnVItdl66oygj2b9OCVa8u3Ik829s=
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by SN7PR12MB7250.namprd12.prod.outlook.com (2603:10b6:806:2aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 10:30:23 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 10:30:23 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"vkoul@kernel.org" <vkoul@kernel.org>, "Frank.Li@kernel.org"
	<Frank.Li@kernel.org>, "Verma, Devendra" <Devendra.Verma@amd.com>
Subject: RE: [PATCH v1] dmaengine: dw-edma: Enable HDMA 64R/W Channels
Thread-Topic: [PATCH v1] dmaengine: dw-edma: Enable HDMA 64R/W Channels
Thread-Index: AQHc72WjgpPjD6egBUaVAulnN+rm6bYk+gaAgAeQogA=
Date: Wed, 3 Jun 2026 10:30:23 +0000
Message-ID:
 <BL4PR12MB9482D2207C8207EDC669B82095132@BL4PR12MB9482.namprd12.prod.outlook.com>
References: <20260529122104.2533048-1-devendra.verma@amd.com>
 <20260529130941.A07AF1F00893@smtp.kernel.org>
In-Reply-To: <20260529130941.A07AF1F00893@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-06-03T08:41:59.0000000Z;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public
 v26;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL4PR12MB9482:EE_|SN7PR12MB7250:EE_
x-ms-office365-filtering-correlation-id: d8bbbaf3-4373-4fcc-73ea-08dec15b1ed9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|6133799003|18002099003|22082099003|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info:
 4UhseGRAiWp5mlP0hQsA1GV241+gIil4PMd9CoI7yvB0SRNmMBBvqbMZCpRAqH/pDGWJWoO1CN1ZFSVKwrTokvT8f9x6Sm827Zc+WnBsBbEBHbkMGitKUrfdGMv66Yx5YUJcb4dzockqFMYaHPx6oxn1tW6S00aElXdI7eT/qeV6eNq0sNvxelwszUGmh42OThE+x++QjoVqIQrm2ukYIKmunUbM+YhBdsoxrCKrDUKORKGhxiYh2TVUKaEvhOLfa9t2SIPOsXsto3Po9S56GTZkR7nuh4BawmHjkmWXVoBj8TuHp0PDmEUEAJOltDRh4FJLmpCrrYx7zd/3NWuVWzUpY9c3kJfc5Z8MyMmMnNk3kGc8a1icOwWMOBVit+shcBNfYkyVFr7pKyvuFT98IZYW73dsClKh+fvIJLd+TWHFRIJO+fsUSwjg5/s2JYaf54n045HlLeVwsnMDI9R/XwnZEQwT2Lp4JyR7gMgt5Zp6mMy86Rd30CVGJ1zpADZ17N2RsGRTS1/I6ORCTIgAAaWMyn4Bjk1BwJuRmgiyu4wi4v2q4js8UIUmlbi5uDgFiwW+wAnejRGBraIkL2/4tevIMrf6EjgAHBB7Vkmp2uiRH9JxIctAxdKfpVC6D9k1VBgdrTSZdeKrrl4XB+/5vVPEiPB/9rT/DdNDguTZUlT/M0+LLDbHXJ3D9M1Ri4NVInx1m+YUrn/xFxlabWXw/g==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MStlUVVVZWd3blFQbFZrNzBxQUFHbENTSXFMTUFLdTl1Ym1yVzI1c0VqeTNM?=
 =?utf-8?B?L1JnWUtIZFlzSm5KbHpETlRVU3BsUFlCWm1ML3hxOEJORDNjSVhnTzZiQzR2?=
 =?utf-8?B?WFRlZFBnUWhHUm02MXRKcEFVQzc1c3UxeGY2UDlLdEZ2cm5xbTR4U0JqcGZj?=
 =?utf-8?B?R1NPNXdWMmQ3Rm1DbVlkUUhHVVd0U01BSFIzaGhIK2NtYjZPZ3FnU21zSkVK?=
 =?utf-8?B?YlJyN2VEK3RmVlExTEN0anpjUEJpa29UaTJQUzFmbXFWOFg1SGYwL2xrRENw?=
 =?utf-8?B?d3VrejVDWmxKOUV6TENJUnp3eUEyeEJtWnZIajg4Y0NWRGUxM1h3Q0VGK0x0?=
 =?utf-8?B?bU83bE1xQVFmVjBWR0VnYjFNQnNmcHFXZnpGMjdWRURzMTBIbWVyRW5sS1JV?=
 =?utf-8?B?TDhyZGt0V3dvaDROT05vZmorQUtJTmFhOHhYSTY3VmErUzBCR3FCcGk3Q1ZS?=
 =?utf-8?B?SCtQYjZ1Ty96NjFxRmcxRStnMDN4K2xmSmxDc3FMMFRFU2ZsT3pFLzZuSTk2?=
 =?utf-8?B?YUxlOFhPajNlRGxKOThmcThZUjdsUml6MkE2RDhScERxSEFacW9PYjQ2M28y?=
 =?utf-8?B?T21IUCtQOGVRdlJoYXBVWHo5RFJtOEJQNjZpR1kzVWsrZWlZNVAyblVQNEMy?=
 =?utf-8?B?c2hvS2lyTW9qVFNKR0VCUjV0SWY5cWpaUE1IS3g4T0tWRWlzY01NdFV3ZFdS?=
 =?utf-8?B?UXVSa1NJVmNOb1pPZnlkdkREYW1NQUQ0KzU1T1JaYUhzaGFJMTJ4NURnM1ll?=
 =?utf-8?B?L0t3UVhlQndMVGdIaGdCY2tFQjIveEdJaTNKMHdWUUl3c08vOEJEN3dveW45?=
 =?utf-8?B?akQzQVVnRG0vNllkNlg1WmJHNlliN3lOTTc1OFJBVkpSNHdVaHE0Tm52c1VB?=
 =?utf-8?B?V0tGOVZPMnF5SGEzemlEM09mVHBqN2xiVE5HN1FtMXFDL2hOdGVTSnY3NFlt?=
 =?utf-8?B?RlZxSGpwRjA0WEkycVdTNkRGdVdnRjZDSlBRUnlUVHVDcy9KNTNuakk3ZFpp?=
 =?utf-8?B?djFUSytBWTFmR2xqbHhnNTEwTkNHT0U4bHNrMTFWWlN6V05Sa2RBcncySEYy?=
 =?utf-8?B?ZFRKOFdid2Q0VWtDbjVxK09ML0lWSWVtU09YY2NkMG1IcFpPQTFlSEc1TjBi?=
 =?utf-8?B?b3V6azVCSEJaKzdBSDNIMVpod2svY3lsdmE0Y3pERmJPeVh1UE94eXNvMStq?=
 =?utf-8?B?MlduN2EvL3BtajJHb2pkajgzS1UycHhRVEFoUHlFVm9vUUwvTThqTnF4RHNO?=
 =?utf-8?B?R1pZc0p0T0lKam1mQTY1UzEzdDdTVkdzTlNMN3FRcUg5UE1NL3FKTWRzNjUv?=
 =?utf-8?B?N1dNMk5wTXdSY1FQaW1xWFlKSWRYZXRZcHFLbnFkU05UM2RRTmFnR3BybE14?=
 =?utf-8?B?QmhIVmhuVTN4K0F3NFVBWmpqcW82NEM3RVk5UDZoTmJxZEhmZ2N4c3ZFQkVj?=
 =?utf-8?B?SkF4OTNlWU9LakxMT2FPbU95cm95SUI1UFp0Y3pHMDU4QUtUMFZwdm1KY2Qy?=
 =?utf-8?B?b24weTllazdvTnlXVDZ3bUM0NkFZNHlZNlhSK1hyamJvVytIc0lGSkRZYjJN?=
 =?utf-8?B?L3dQUEhnK1B0V05DZWhVc2VpVCtxTmhMYkZ6Zm5MVXhsaW5TVUU1MlhYeWFN?=
 =?utf-8?B?SE1CazRGTzY5RGNva1RjSlBKRTRBSHBEQkJDR2tYZ1V3L1prVHRnQ1l0aXVF?=
 =?utf-8?B?Q1c5Yjd0QWQ0RGw0ekV5MEFSZXNBaXVXalBLN1YvMnoxcGpORXcxSWpMello?=
 =?utf-8?B?R1d2eW1WRlV6UGI5VmpUMllSanpqQlBWVVAySFVpUUhqSWsvbmdnNDBqQ0h1?=
 =?utf-8?B?b09JR2NwMXRZc3RRd1lPcUNScE1MWlFFSkpuOEFxanFaWTROSWhBSHhQRUpQ?=
 =?utf-8?B?QWRjbmsraVdFVHEzdGFmUERMQ1c0cTFtWEhQSFNsR2wrTi94bEVBbFByMk5k?=
 =?utf-8?B?bEpld1U1V3UrWjJVY0VDVlVhYTVSR3p3WUlabHM4dXlHYUFJcWpzV0IxUS9h?=
 =?utf-8?B?eWQ1cGZnZkx4dDY1ZTBSSWtvdFFhWjl0UGJqREhOM3daa2dyd3ltZTJvcEdM?=
 =?utf-8?B?WDE0bmpnSzNmOTBKZXNDMHVUMHYvaUw2dlIvSjVudjg5TGlDcEpyOXN6U2lO?=
 =?utf-8?B?eWZoU1ZaaG9TSkMzSnhTWG1NZXdFUGhLMXM3dUEyaHNHakdmT3lpYnJzZHZU?=
 =?utf-8?B?R3RHVS93c09DRHl3Q2h6L2s1ZzhodFM5bHVrRlBkNFliVVZvY0hzSTUwN1Ju?=
 =?utf-8?B?WUwyK3Vwc3hJait1RkxmR0tnbXFTTVhJbk1IckF1RXBuZGYzRjdRQ1hJTEg1?=
 =?utf-8?Q?shKkgLa1xu9stwCGUu?=
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
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8bbbaf3-4373-4fcc-73ea-08dec15b1ed9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 10:30:23.6393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tl/GPXp0+Ftk/5o3O7SiB8afyGp7bjGKCKN97F8VDXLmikSHVTKfqTKPdH91nbjvRNsonHOK7HzXL1wecoPNNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7250
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11141-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:Devendra.Verma@amd.com,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[Devendra.Verma@amd.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Devendra.Verma@amd.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url,amd.com:dkim,amd.com:from_mime,amd.com:email,BL4PR12MB9482.namprd12.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 26AF5636AD3

UHVibGljDQoNCkhpDQoNClBsZWFzZSBjaGVjayBteSBjb21tZW50cyBpbmxpbmUuDQoNClJlZ2Fy
ZHMsDQpEZXZlbmRyYQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IHNh
c2hpa28tYm90QGtlcm5lbC5vcmcgPHNhc2hpa28tYm90QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IEZy
aWRheSwgTWF5IDI5LCAyMDI2IDE4OjQwDQo+IFRvOiBWZXJtYSwgRGV2ZW5kcmEgPERldmVuZHJh
LlZlcm1hQGFtZC5jb20+DQo+IENjOiBkbWFlbmdpbmVAdmdlci5rZXJuZWwub3JnOyB2a291bEBr
ZXJuZWwub3JnOyBGcmFuay5MaUBrZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjFd
IGRtYWVuZ2luZTogZHctZWRtYTogRW5hYmxlIEhETUEgNjRSL1cNCj4gQ2hhbm5lbHMNCj4NCj4g
VGhhbmsgeW91IGZvciB5b3VyIGNvbnRyaWJ1dGlvbiEgU2FzaGlrbyBBSSByZXZpZXcgZm91bmQg
MyBwb3RlbnRpYWwgaXNzdWUocykNCj4gdG8gY29uc2lkZXI6DQo+IC0gW0NyaXRpY2FsXSBVbmJv
dW5kZWQgaXRlcmF0aW9uIGluIGBkd19oZG1hX3YwX2NvcmVfb2ZmKClgIGNhdXNlcyBvdXQtb2Yt
DQo+IGJvdW5kcyBNTUlPIHdyaXRlcyB0byB1bm1hcHBlZCByZWdpc3RlciBzcGFjZS4NCj4gLSBb
SGlnaF0gRGVzaWduV2FyZSBQQ0llIGNvbnRyb2xsZXIgZ2x1ZSBkcml2ZXIgYm91bmRzIGNoZWNr
cyB3ZXJlIG5vdA0KPiB1cGRhdGVkIHRvIHN1cHBvcnQgdGhlIG5ldyA2NC1jaGFubmVsIGxpbWl0
cy4NCj4gLSBbTWVkaXVtXSBIYXJkY29kZWQgY2hhbm5lbCBsaW1pdHMgaW4gdGhlIFBDSWUgZW5k
cG9pbnQgZHJpdmVyIHByZXZlbnQNCj4gdXRpbGl6aW5nIG1vcmUgdGhhbiA4IGNoYW5uZWxzLg0K
PiAtLQ0KPg0KPiBjb21taXQgNWQyYmRhY2EyYzkyYzk1Mjg4Mjc1YTMyMTBmMTkyYjhlNzA5NGI5
ZQ0KPiBBdXRob3I6IERldmVuZHJhIEsgVmVybWEgPGRldmVuZHJhLnZlcm1hQGFtZC5jb20+DQo+
DQo+IGRtYWVuZ2luZTogZHctZWRtYTogRW5hYmxlIEhETUEgNjRSL1cgQ2hhbm5lbHMNCj4NCj4g
VGhpcyBjb21taXQgYWRkcyBzdXBwb3J0IGZvciB1cCB0byA2NCByZWFkIGFuZCB3cml0ZSBjaGFu
bmVscyBpbiB0aGUNCj4gRGVzaWdud2FyZSBIRE1BIGNvbnRyb2xsZXIgZHJpdmVyLCBhcyBwZXIg
dGhlIGhhcmR3YXJlIHNwZWNpZmljYXRpb24uIEl0DQo+IGludHJvZHVjZXMgSERNQS1zcGVjaWZp
YyBtYWNyb3MgYW5kIHVwZGF0ZXMgdGhlIGluaXRpYWxpemF0aW9uIGZsb3cgdG8gdXNlDQo+IHRo
ZSBhcHByb3ByaWF0ZSBjaGFubmVsIGxpbWl0cyBiYXNlZCBvbiB0aGUgSVAgdmVyc2lvbi4NCj4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvZHctZWRtYS9kdy1lZG1hLXBjaWUuYw0KPiA+
IGIvZHJpdmVycy9kbWEvZHctZWRtYS9kdy1lZG1hLXBjaWUuYw0KPiA+IGluZGV4IDBiMzBjZTEz
ODUwMzYuLjc5ZjY1M2RhOGUwZmQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9kbWEvZHctZWRt
YS9kdy1lZG1hLXBjaWUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZG1hL2R3LWVkbWEvZHctZWRtYS1w
Y2llLmMNCj4gWyAuLi4gXQ0KPiA+IEBAIC02MSwxMSArNjEsMTEgQEAgc3RydWN0IGR3X2VkbWFf
cGNpZV9kYXRhIHsNCj4gPiAgICAgLyogZURNQSByZWdpc3RlcnMgbG9jYXRpb24gKi8NCj4gPiAg
ICAgc3RydWN0IGR3X2VkbWFfYmxvY2sgICAgICAgICAgICByZzsNCj4gPiAgICAgLyogZURNQSBt
ZW1vcnkgbGlua2VkIGxpc3QgbG9jYXRpb24gKi8NCj4gPiAtICAgc3RydWN0IGR3X2VkbWFfYmxv
Y2sgICAgICAgICAgICBsbF93cltFRE1BX01BWF9XUl9DSF07DQo+ID4gLSAgIHN0cnVjdCBkd19l
ZG1hX2Jsb2NrICAgICAgICAgICAgbGxfcmRbRURNQV9NQVhfUkRfQ0hdOw0KPiA+ICsgICBzdHJ1
Y3QgZHdfZWRtYV9ibG9jayAgICAgICAgICAgIGxsX3dyW0hETUFfTUFYX1dSX0NIXTsNCj4gPiAr
ICAgc3RydWN0IGR3X2VkbWFfYmxvY2sgICAgICAgICAgICBsbF9yZFtIRE1BX01BWF9SRF9DSF07
DQo+ID4gICAgIC8qIGVETUEgbWVtb3J5IGRhdGEgbG9jYXRpb24gKi8NCj4gPiAtICAgc3RydWN0
IGR3X2VkbWFfYmxvY2sgICAgICAgICAgICBkdF93cltFRE1BX01BWF9XUl9DSF07DQo+ID4gLSAg
IHN0cnVjdCBkd19lZG1hX2Jsb2NrICAgICAgICAgICAgZHRfcmRbRURNQV9NQVhfUkRfQ0hdOw0K
PiA+ICsgICBzdHJ1Y3QgZHdfZWRtYV9ibG9jayAgICAgICAgICAgIGR0X3dyW0hETUFfTUFYX1dS
X0NIXTsNCj4gPiArICAgc3RydWN0IGR3X2VkbWFfYmxvY2sgICAgICAgICAgICBkdF9yZFtIRE1B
X01BWF9SRF9DSF07DQo+DQo+IFtTZXZlcml0eTogTWVkaXVtXQ0KPiBXaWxsIHRoaXMgdXBkYXRl
IGFjdHVhbGx5IGFsbG93IHV0aWxpemluZyBtb3JlIHRoYW4gOCBjaGFubmVscywgb3IgZG8gdGhl
IHN0YXRpYw0KPiBjb25maWd1cmF0aW9uIHN0cnVjdHVyZXMgc3RpbGwgcmVzdHJpY3QgaXQ/DQo+
DQo+IFdoaWxlIHRoZXNlIGRhdGEgc3RydWN0dXJlcyBhcmUgdXBkYXRlZCB0byBzdXBwb3J0IDY0
IGNoYW5uZWxzLCB0aGUgc3RhdGljDQo+IGNvbmZpZ3VyYXRpb24gc3RydWN0dXJlcyBsaWtlIHhp
bGlueF9tZGJfZGF0YSBhbmQgc25wc19lZGRhX2RhdGEgYXJlIGxlZnQNCj4gaGFyZGNvZGVkIHRv
IDggYW5kIDIgY2hhbm5lbHMsIHJlc3BlY3RpdmVseS4NCj4NCj4gRHVyaW5nIHByb2JlLCBkd19l
ZG1hX3BjaWVfZ2V0X3hpbGlueF9kbWFfZGF0YSgpIGNvbXB1dGVzIHRoZSBjaGFubmVsDQo+IGNv
dW50IHVzaW5nIG1pbihwZGF0YS0+d3JfY2hfY250LCBGSUVMRF9HRVQoLi4uKSkuIFNpbmNlIHRo
ZSBpbml0aWFsDQo+IHBkYXRhLT53cl9jaF9jbnQgaXMgY2FwcGVkIGF0IDgsIHRoZSBkcml2ZXIg
d2lsbCBzaWxlbnRseSByZXN0cmljdCB0aGUNCj4gcGRhdGEtPm51bWJlcg0KPiBvZiBjaGFubmVs
cyB0byBhIG1heGltdW0gb2YgOCwgZXZlbiBpZiB0aGUgdW5kZXJseWluZyBJUCByZXBvcnRzIHN1
cHBvcnQgZm9yDQo+IHVwIHRvIDY0IGNoYW5uZWxzLg0KPg0KDQpIRE1BIHN1cHBvcnRzIDY0IFJl
YWQgYW5kIDY0IFdyaXRlIGNoYW5uZWxzLiBUaGUgY29kZSBjaGFuZ2VzIGFyZSByZXF1aXJlZA0K
c28gdGhhdCBwcm9wb3J0aW9uYWwgbnVtYmVyIG9mIHN0cnVjdHMgYXJlIGF2YWlsYWJsZSBmb3Ig
dGhlIGNoYW5uZWxzLg0KRHVyaW5nIHRoZSBwcm9iZSwgZm9yIElQcyB0aGF0IGhhdmUgZmV3ZXIg
Y2hhbm5lbHMgZW5hYmxlZCBjYW4gc3RpbGwgYmUgYWJsZSB0bw0KdXNlIHRoZSBkcml2ZXIgYXMg
aXMsIHdpdGhvdXQgaGF2aW5nIHRvIG1vZGlmeSBhbnl0aGluZy4gVGhpcyBjaGFuZ2UgZW5hYmxl
cw0KdGhlIEhETUEgSVAgZXZlbiB3aGVuIHVzZXIgd2FudHMgdG8gdXNlIDIgb3IgOCBjaGFubmVs
cy4gU28sIGl0IGlzIE9LIGlmIG5vdA0KYWxsIDY0IGNoYW5uZWxzIFJlYWQvV3JpdGUgYXJlIGVu
YWJsZWQgYnkgdGhlIHVzZXIgdG8gdXRpbGl6ZS4NCg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2RtYS9kdy1lZG1hL2R3LWhkbWEtdjAtcmVncy5oDQo+ID4gYi9kcml2ZXJzL2RtYS9kdy1lZG1h
L2R3LWhkbWEtdjAtcmVncy5oDQo+ID4gaW5kZXggNzc1OWJhOWI0ODUwZi4uNDhlNDBlZmNlYjJl
YSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2RtYS9kdy1lZG1hL2R3LWhkbWEtdjAtcmVncy5o
DQo+ID4gKysrIGIvZHJpdmVycy9kbWEvZHctZWRtYS9kdy1oZG1hLXYwLXJlZ3MuaA0KPiA+IEBA
IC0xMSw3ICsxMSw3IEBADQo+ID4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2RtYWVuZ2luZS5oPg0K
PiA+DQo+ID4gLSNkZWZpbmUgSERNQV9WMF9NQVhfTlJfQ0ggICAgICAgICAgICAgICAgICA4DQo+
ID4gKyNkZWZpbmUgSERNQV9WMF9NQVhfTlJfQ0ggICAgICAgICAgICAgICAgICA2NA0KPg0KPiBb
U2V2ZXJpdHk6IENyaXRpY2FsXQ0KPiBEb2VzIGluY3JlYXNpbmcgdGhpcyBjb25zdGFudCBjYXVz
ZSBvdXQtb2YtYm91bmRzIE1NSU8gd3JpdGVzIGR1cmluZw0KPiB0ZWFyZG93bj8NCj4NCj4gTG9v
a2luZyBhdCBkd19oZG1hX3YwX2NvcmVfb2ZmKCksIHRoZSBjb2RlIHVuY29uZGl0aW9uYWxseSBp
dGVyYXRlcyB1cCB0bw0KPiBIRE1BX1YwX01BWF9OUl9DSCB0byBkaXNhYmxlIGNoYW5uZWxzLCBy
YXRoZXIgdGhhbiB1c2luZyB0aGUNCj4gZHluYW1pY2FsbHkgY29uZmlndXJlZCBkdy0+d3JfY2hf
Y250IGFuZCBkdy0+cmRfY2hfY250Lg0KPg0KPiBTaW5jZSBlYWNoIGNoYW5uZWwgb2NjdXBpZXMg
NTEyIGJ5dGVzLCBpdGVyYXRpbmcgNjQgdGltZXMgd3JpdGVzIHRvIDMyIEtCIG9mDQo+IHJlZ2lz
dGVyIHNwYWNlLiBFeGlzdGluZyBlbmRwb2ludCBkZXZpY2VzIGxpa2UgWGlsaW54IE1EQiBtYXAg
b25seSA4IEtCIG9mDQo+IHJlZ2lzdGVyIHNwYWNlLg0KPg0KPiBXcml0aW5nIHRvIE1NSU8gb2Zm
c2V0cyBvdXRzaWRlIHRoZSBtYXBwZWQgcmVnaW9uIGNhbiBjYXVzZSBhIHRyYW5zbGF0aW9uDQo+
IGZhdWx0IG9yIGFuIHVuaGFuZGxlZCBrZXJuZWwgcGFnaW5nIHJlcXVlc3QsIHJlc3VsdGluZyBp
biBhIHJlZ3Jlc3Npb24uDQo+DQoNClllcywgdGhpcyBpcyBhIHZhbGlkIGlzc3VlLiBUaGlzIHdp
bGwgYmUgZml4ZWQgaW4gdGhlIG5leHQgdmVyc2lvbiBvZiB0aGUgc2FtZSBwYXRjaA0Kc2VyaWVz
Lg0KDQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZG1hL2VkbWEuaCBiL2luY2x1ZGUv
bGludXgvZG1hL2VkbWEuaCBpbmRleA0KPiA+IDFmYWZkNWIwZTMxNTMuLmRhN2E1Y2M5M2FkNDMg
MTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9kbWEvZWRtYS5oDQo+ID4gKysrIGIvaW5j
bHVkZS9saW51eC9kbWEvZWRtYS5oDQo+ID4gQEAgLTE0LDYgKzE0LDggQEANCj4gPg0KPiA+ICAj
ZGVmaW5lIEVETUFfTUFYX1dSX0NIICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDgN
Cj4gPiAgI2RlZmluZSBFRE1BX01BWF9SRF9DSCAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICA4DQo+ID4gKyNkZWZpbmUgSERNQV9NQVhfV1JfQ0ggICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgNjQNCj4gPiArI2RlZmluZSBIRE1BX01BWF9SRF9DSCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICA2NA0KPg0KPiBbU2V2ZXJpdHk6IEhpZ2hdDQo+IEFyZSB0aGVy
ZSBtaXNzaW5nIHVwZGF0ZXMgaW4gdGhlIERlc2lnbldhcmUgUENJZSBjb250cm9sbGVyIGdsdWUg
ZHJpdmVyIHRvDQo+IHN1cHBvcnQgdGhlc2UgbmV3IGxpbWl0cz8NCj4NCj4gVGhlIGZ1bmN0aW9u
IGR3X3BjaWVfZWRtYV9maW5kX2NoYW5uZWxzKCkgaW4gcGNpZS1kZXNpZ253YXJlLmMgZW5mb3Jj
ZXMgYQ0KPiBoYXJkIGxpbWl0IG9mIEVETUFfTUFYX1dSX0NILiBJZiBhIGRldmljZSBpcyBjb25m
aWd1cmVkIGZvciBtb3JlIHRoYW4gOA0KPiBjaGFubmVscywgdGhlIGNoZWNrIHBjaS0+ZWRtYS5s
bF93cl9jbnQgPiBFRE1BX01BWF9XUl9DSCB3aWxsIHRyaWdnZXINCj4gYW5kIHJldHVybiAtRUlO
VkFMLCBjYXVzaW5nIGluaXRpYWxpemF0aW9uIHRvIGZhaWwuDQo+DQoNClRoaXMgbGltaXQgaXMg
Zm9yIHRoZSBub24tSERNQSBkZXZpY2VzLiBFdmVuIHRob3VnaCB0aGUgbnVtYmVyIG9mIGNoYW5u
ZWxzDQppbmNyZWFzZWQgZm9yIEhETUEgaXQgd291bGQgbm90IGFmZmVjdCB0aGUgZnVuY3Rpb25h
bGl0eSBvZiBvdGhlciBJUHMuDQoNCj4gQWRkaXRpb25hbGx5LCBkd19wY2llX2VkbWFfaXJxX3Zl
Y3RvcigpIHJldHVybnMgLUVJTlZBTCBpZiB0aGUgSVJRIGluZGV4IG5yDQo+IGlzIGdyZWF0ZXIg
dGhhbiBvciBlcXVhbCB0byBFRE1BX01BWF9XUl9DSCArIEVETUFfTUFYX1JEX0NILA0KPiBicmVh
a2luZyBpbnRlcnJ1cHRzIGZvciBoaWdoZXIgY2hhbm5lbHMuDQo+DQo+IFRoaXMgcHJldmVudHMg
dGhlIG5ld2x5IGFkZGVkIGZlYXR1cmUgZnJvbSBmdW5jdGlvbmluZyBvbiBuYXRpdmUgaG9zdA0K
PiBjb250cm9sbGVycy4NCj4NCg0KQSBnbHVlIGRyaXZlciBpcyByZXF1aXJlZCBpcyBuZWVkZWQg
dG8gZW5hYmxlIDY0IFJlYWQgJiBXcml0ZSBjaGFubmVscy4NClRoaXMgbGltaXQgd2lsbCBub3Qg
YWZmZWN0IHRoZSBmdW5jdGlvbmFsaXR5IG9mIHRoZSBJUHMgZm9yIHdoaWNoIHRoaXMgZnVuY3Rp
b24NCmlzIGltcGxlbWVudGVkLiBNb3Jlb3ZlciwgdGhpcyBpc3N1ZSBjYW4gYmUgdGFrZW4gdXAg
aW4gYSBzZXBhcmF0ZQ0KcGF0Y2ggc2VyaWVzIGlmIGNoYW5uZWxzIG51bWJlciBuZWVkIHRvIGJl
IGVuaGFuY2VkLg0KDQo+IC0tDQo+IFNhc2hpa28gQUkgcmV2aWV3IMK3IGh0dHBzOi8vc2FzaGlr
by5kZXYvIy9wYXRjaHNldC8yMDI2MDUyOTEyMjEwNC4yNTMzMDQ4LQ0KPiAxLWRldmVuZHJhLnZl
cm1hQGFtZC5jb20/cGFydD0xDQo=

