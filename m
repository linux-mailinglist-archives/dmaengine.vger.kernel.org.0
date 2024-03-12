Return-Path: <dmaengine+bounces-1345-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA8E879867
	for <lists+dmaengine@lfdr.de>; Tue, 12 Mar 2024 16:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 279CA1F21B27
	for <lists+dmaengine@lfdr.de>; Tue, 12 Mar 2024 15:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE2D7C0AF;
	Tue, 12 Mar 2024 15:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qqn0s1fr"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8898956B92;
	Tue, 12 Mar 2024 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710259003; cv=fail; b=dCVgz8wG4R5C9FPQQ2xzk9oUl5E0nKjF/TJwhr0I++ulUYdaye5Iu0G//tYrrjYIRYz84tTiqIqkaPKZYaaUJNWY1cUCITFqZ5+ngpfMqeHOG4YLLKJHWlXnIFsXQ6lcUmgAYEPd0gbXmXqCdh2UK71F/5ar/GNLI3IskpMVePs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710259003; c=relaxed/simple;
	bh=UsJft2GAt6Jn+wVWP0Od3JiQkhmwuf8H8R6gRsbbB8c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jo+R04OxHr6z3FhmIaaXc5p4EiM1NCMKu1Z8C8/WyRzjS/0ov3Eb73nUgQdhdrsEMBpUYNupVZS7rl0okWtojtmvkPuyeU6RR5/PrsRxHnMx+n5y/8Jo4JXbvGzsps5yGPemqAx2zXM0njPOMM7oc158W/Y51IsxbI9nVPu+Zj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qqn0s1fr; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JuLir4T5Rjv6TqkxqkmHcPsbVwQfxhZmEX8ssdmh9TaGUaxqTVv7yaYDnZUkqePkuevUbt2C+JQ5fJlLKeL5cjoAh4hKvB1yTenHcJrQhJ9De8HPH47Tx96HDPgilfzeHLsl1pYLfGgfBHDCOnRy2tw7/O221taqNUG2fHq8dF+VaCOVRGnt0XNs3jequsUMKNSYoo82LALrxlvubd7s/TZkKLaiNQUzSthaWt+/h+/6Bxc23K7ZEK9+L95kW+QPUOjlQM0/OEB5JbXemVdyPDXjTRztLcPzTXrDrn/crUk19Ady/a0wq4k8DaqhYo/sv3T+hbdOJI3OzMuU5klY+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsJft2GAt6Jn+wVWP0Od3JiQkhmwuf8H8R6gRsbbB8c=;
 b=U0Xx1ONn2frjYMpgtCM8HMyluZg76Y2MSEPtvvLOcUOfWEMaf8TWEAdpUloN/IfQOs0EyuOpkRMPoAVciiL1eDDoLPYTplajT5Nm7Y7rNgt4SUfka7oYGSkOvzV0PgW1NmHQotnrx3h3oi2/KLZ/5DcqhdAf6r4lC+wsd5S6tLusA3N89rla2d9dUsDj5THPtkb7JL44f2OB/I5KE5LSORgARxOLE6V5XnjT3nHllN/gihvDWIQFRVS1GcC0uM3FEGdI4/njC3/1xioNHAXiIZWTZhrFj9DuAONtuK4OTPlgvnWnZzMGYWSC19eFx7MGnok1Oo2L+Wxz/VKqS+k8Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsJft2GAt6Jn+wVWP0Od3JiQkhmwuf8H8R6gRsbbB8c=;
 b=Qqn0s1frkzygN9fscOrGGSHMQc4yRxb+n1yvD+72Hu0BQCEEtO/wNe3grm/WL2Rg6BvRIUYkfmydI/9yOXk55hQIfKpKVSeFQZxHD1Dr81STmHWuqhQuK2iE1BIl0T3atnXM/yOVIVwmPiFV/hUgCuu7bk5yRj+ixd8P4SnUi7A=
Received: from BL1PR12MB5969.namprd12.prod.outlook.com (2603:10b6:208:398::7)
 by SA1PR12MB6823.namprd12.prod.outlook.com (2603:10b6:806:25e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Tue, 12 Mar
 2024 15:56:34 +0000
Received: from BL1PR12MB5969.namprd12.prod.outlook.com
 ([fe80::8bcc:8c11:788a:cab7]) by BL1PR12MB5969.namprd12.prod.outlook.com
 ([fe80::8bcc:8c11:788a:cab7%2]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 15:56:34 +0000
From: "Sagar, Vishal" <vishal.sagar@amd.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	"laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>,
	"vkoul@kernel.org" <vkoul@kernel.org>
CC: "Simek, Michal" <michal.simek@amd.com>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Allagadapa, Varunkumar"
	<varunkumar.allagadapa@amd.com>
Subject: RE: [PATCH v2 1/2] dmaengine: xilinx: dpdma: Fix race condition in
 vsync IRQ
Thread-Topic: [PATCH v2 1/2] dmaengine: xilinx: dpdma: Fix race condition in
 vsync IRQ
Thread-Index: AQHaaf22nCsgjQLFTE6eYqZBPR6lr7Ez2/MAgAB6KAA=
Date: Tue, 12 Mar 2024 15:56:34 +0000
Message-ID:
 <BL1PR12MB59698B0B4AC963EED60C3C479C2B2@BL1PR12MB5969.namprd12.prod.outlook.com>
References: <20240228042124.3074044-1-vishal.sagar@amd.com>
 <20240228042124.3074044-2-vishal.sagar@amd.com>
 <b08c99fe-c221-4eb8-9b1a-1420cb5c32f3@ideasonboard.com>
In-Reply-To: <b08c99fe-c221-4eb8-9b1a-1420cb5c32f3@ideasonboard.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0ae05992-43d6-4d8e-85da-d9dc5973c331;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-12T15:50:45Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5969:EE_|SA1PR12MB6823:EE_
x-ms-office365-filtering-correlation-id: 014cf883-3e5e-47d6-f101-08dc42acfe5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 MqtvVyhou5bW+Z+YO7/S5rUETtZDELMaP1maCo+31KAtFYDbnMXDrXqxEFQ4XvDopIXsVi9PCugwfsU2GkwdJgzwZ4s3hZchi/vT+STjgeXIcg7Jv+nmo7DDZbA9kTDvWkwC87DSy9AXuYJvgaegFQfycQrpOj+54LV3uhGIRoQYMcouzgkwBV5KMvQ1QOSqZ206VTetXPDt0HKqNJGVCuDKZGeSk/QLrsrmjMRE7kmx8PNp3Gy+Ob2paDUnf3RtkiEklTg6/QGc2Z7rDNQ/YD8XaqSnG/uMp3pcUqyuBNCQ4uEv9U9rXkI8Ml3+bLgC8QmjkKs8VzCv5qhh9wfYnKkETqILXrl517llFabD8c3mZsUsYC/PLPTlk/5xFMKQdWrMmo48aupO3Dvncuzj00gggA1Hmra7wvBCihzOazCOod8BvG4DXpyTicVBBurjdk161slnxmzf2s0MJ7UhBsNV6ZNUtpATaw3G1KoU9945TdhppW0AtGctNtGch2FcE0VkAfmQ23kiKll9SS5VxW/W2Lm2rQJxzmxwhAMOlocMcEZeUv8RTI1Pq0pUxqO8v1vvlIfsZhDZPYKKlbAPUMUF9jE/h+1n6bfeWlEk7cY4cJ4Sp/fMa1wOAd6TvxMyooKkt4oTLjpDkkgOzYM+spV/AZbXjMXkrsTXm4+KMAA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5969.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y3o2T3JuVklMN1hCTUNDbDc0T05MZ29PYnE0Z204NzVxeW9LQU1WbHVXN2lk?=
 =?utf-8?B?RTVGWGJJd0dtWHJPRlpsWVpTenVaZkRHUE5ydVdkaDdDdFk0bmxxWmhTNU1a?=
 =?utf-8?B?bVp1cGlSS3dpQ1ZlMzhqWE94L2JmTVB4TWxaREEzUzMxdG0wRm9EdU9oQXVs?=
 =?utf-8?B?cDJ2ZS9aRjdnazVlZDk4c2ZjVGE0UklacThqS1VtUmhMMDUrTXBmNzhCRjdo?=
 =?utf-8?B?bDBGNzBBcVowOFlqRjluOTUrUG1JNDA3V0JFaFFnSHp5a2lpRGpiZENGLzFE?=
 =?utf-8?B?ekhJQmRHb2tFZEJSN1NrWHRZQlNPODZTbXUxVk9PTlZRRHNmRm13YmZFS0RE?=
 =?utf-8?B?QnhLMU1MRzlzUDlFZ2tqd3hLZTJxdzRLZlArRTlMN2x3WmRrNEpXZEk1SWp4?=
 =?utf-8?B?UWxDQTZ4VVY2NTErcjF0bTJ6WjY5cEo1K1VidGMzTEtoZXFCeEhEYjVwVXhL?=
 =?utf-8?B?b0dpUGlPcm4xdFZ1SnZtd004VmZDZGdHR3hFRkp2ZnlFU0FCZksvS01qR2Fx?=
 =?utf-8?B?MHRuL2xhWlJaZitKa3JSYlpkWEpGcEtFYkh6dmUrT01kcVJ4TEMvYmw4VE01?=
 =?utf-8?B?YjJsUFNQN3puMGR1LytXVGhJS2ZNMWt0Y0pwelJodkltdXJERDJRbDdxTDU5?=
 =?utf-8?B?eU9YMCtNY2RxVWo3bERiUGdPQ3N0ZGFCYWVVYlVSWk5vSitWNWdhNERUcnYz?=
 =?utf-8?B?RVBSQmFPTEpBTlhrSG95TU9hV1phY1UvZ3RmTzc2ckk5S1VMd3o3K2Zjb1Fh?=
 =?utf-8?B?cm9aQ2szQlpCNVpseUowMk1FSzVVZkFDd1Y2RndWL0padGdzY3hnSW1QMS9G?=
 =?utf-8?B?bFlqV3dHaWxLWkpNaGVQc0Z2bUQwMml6eEc4VjNDaW90ZDA5R0ZTK3dIOVkz?=
 =?utf-8?B?WUhhUjd4REsrVGFRZVRZb3FjbHpzandmbFQyTmJYSCtlV0hVT0gza2tDa0F0?=
 =?utf-8?B?cWsyTkN0dVk2MjdSMWlVM3JSRDFrK1FoOFBINDczL0NLK1NpZG5wQ2hDNWFq?=
 =?utf-8?B?K3hGUml1dm50OFNXbUpadkVOV1Y3TlVrNHUvZlc5THFGRUFWQjgvSlFtSXQ4?=
 =?utf-8?B?cWZmVlFSTkFaeWhTTUJDK2JlUUFqbjFXb1duK3FZTHZ0K3I3eENJUVord1Jj?=
 =?utf-8?B?dkl0SWZJUURLUmdqbWQxWWc2TEJocWZ3bDV1bVp1T1ZGRFcyVEQvM2tJMzdK?=
 =?utf-8?B?S2RRSnVqYWE5SHVDNDR2Zm5lUzBuRExiWEd0Y0RVL0VBaHVkckJ4Sk5tc0V1?=
 =?utf-8?B?Y25FWCtlWS9tUi9CMWZ3Z1NFZS9TRmp2aEFsZTZVZHA3M3lYUHV5UVVzMGpN?=
 =?utf-8?B?VjMxci9KTjVKamd5KytyTjZqdXIzaG9QV3VpM0ZabmZxR0pFcDBmQmRqN2Qr?=
 =?utf-8?B?RGRxWFVxL2FFQ1BUazRNZDZEczRaYVN2YnVOVVhpNVkrRjNHWjVJeWFmL2U0?=
 =?utf-8?B?aXRhdUZtQnBEN2ZzL0U4SVJhejZZazNORk15bzRNSm01RWhKdEhYRDYwdURJ?=
 =?utf-8?B?SnBRdGpWbXZTbjZ3ZG5PQlVsNXVCanlUTzNCYzRWRFluWG1YMHU0UnR4aTBW?=
 =?utf-8?B?VE9wL3E2MGZseWpnVzdBdXhnb1RWS2xZbG9kT2ZqVFA5NVBGU1dpWXRqOXpR?=
 =?utf-8?B?NTJIZW9YWHk0d09BV3RTZ25rZjBHdk5PQm5LcWFGa2JOeE5XWjVCd2UzazdF?=
 =?utf-8?B?ME53cmJWM3NXUllsdkZxY1kwa1FTYnRtMEdnWVpXdVg4RXByNnlpNHJpTllr?=
 =?utf-8?B?RHFVdytYWHNVZjNYYzlHYXJydXFtZ3V4N2dnaGI5MmtEZFZlbysxaTRFQXdq?=
 =?utf-8?B?dEpRRUJ1S1ZTZ0F4bnlHK0ppWDIwc01uN1BkcU9JNW8zc2NsQjB2K0pqWFlL?=
 =?utf-8?B?NUQvaWs4U0w2d2plYXlBT1l4M3NBNXZ3ZkNBeTRHTXZjN3JZL3JJMm4yUkdq?=
 =?utf-8?B?WkJ1SU5JV0M3UWJxaExFL1lLSitFa1hKWThhZktDWkVoUFhteW5pT1dvOHNV?=
 =?utf-8?B?eEt4TEhKcDE3TE5JSVBCNTVZNzRwc2cyWDRhZThoalNXbGI5V3Yxdm1wbG90?=
 =?utf-8?B?eHhnQ3MrL0I1Y2djMnNrMVBnV1o0c3pvdFJPdGV5MmFNT3M2VGJXWnVNb0hy?=
 =?utf-8?Q?lx/M=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5969.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 014cf883-3e5e-47d6-f101-08dc42acfe5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 15:56:34.9034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QNWGMiLxL7vujw5uK0etJE76eYyX8iAlxsrLqElDyF0IKHKWG654M6P4X2OqjUcZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6823

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIFRvbWksDQoNCj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVG9taSBWYWxrZWluZW4gPHRvbWkudmFsa2Vp
bmVuQGlkZWFzb25ib2FyZC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDEyLCAyMDI0IDE6
MzQgQU0NCj4gVG86IFNhZ2FyLCBWaXNoYWwgPHZpc2hhbC5zYWdhckBhbWQuY29tPjsNCj4gbGF1
cmVudC5waW5jaGFydEBpZGVhc29uYm9hcmQuY29tOyB2a291bEBrZXJuZWwub3JnDQo+IENjOiBT
aW1laywgTWljaGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47IGRtYWVuZ2luZUB2Z2VyLmtlcm5l
bC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsNCj4gQWxsYWdhZGFwYSwgVmFydW5rdW1hciA8dmFydW5rdW1h
ci5hbGxhZ2FkYXBhQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMS8yXSBkbWFl
bmdpbmU6IHhpbGlueDogZHBkbWE6IEZpeCByYWNlIGNvbmRpdGlvbiBpbg0KPiB2c3luYyBJUlEN
Cj4NCj4gSGksDQo+DQo+IE9uIDI4LzAyLzIwMjQgMDY6MjEsIFZpc2hhbCBTYWdhciB3cm90ZToN
Cj4gPiBGcm9tOiBOZWVsIEdhbmRoaSA8bmVlbC5nYW5kaGlAeGlsaW54LmNvbT4NCj4gPg0KPiA+
IFRoZSB2Y2hhbl9uZXh0X2Rlc2MoKSBmdW5jdGlvbiwgY2FsbGVkIGZyb20NCj4gPiB4aWxpbnhf
ZHBkbWFfY2hhbl9xdWV1ZV90cmFuc2ZlcigpLCBtdXN0IGJlIGNhbGxlZCB3aXRoDQo+ID4gdmly
dF9kbWFfY2hhbi5sb2NrIGhlbGQuIFRoaXMgaXNuJ3QgY29ycmVjdGx5IGhhbmRsZWQgaW4gYWxs
IGNvZGUgcGF0aHMsDQo+ID4gcmVzdWx0aW5nIGluIGEgcmFjZSBjb25kaXRpb24gYmV0d2VlbiB0
aGUgLmRldmljZV9pc3N1ZV9wZW5kaW5nKCkNCj4gPiBoYW5kbGVyIGFuZCB0aGUgSVJRIGhhbmRs
ZXIgd2hpY2ggY2F1c2VzIERNQSB0byByYW5kb21seSBzdG9wLiBGaXggaXQgYnkNCj4gPiB0YWtp
bmcgdGhlIGxvY2sgYXJvdW5kIHhpbGlueF9kcGRtYV9jaGFuX3F1ZXVlX3RyYW5zZmVyKCkgY2Fs
bHMgdGhhdCBhcmUNCj4gPiBtaXNzaW5nIGl0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTmVl
bCBHYW5kaGkgPG5lZWwuZ2FuZGhpQGFtZC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmFkaGV5
IFNoeWFtIFBhbmRleSA8cmFkaGV5LnNoeWFtLnBhbmRleUBhbWQuY29tPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFRvbWkgVmFsa2VpbmVuIDx0b21pLnZhbGtlaW5lbkBpZGVhc29uYm9hcmQuY29tPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IFZpc2hhbCBTYWdhciA8dmlzaGFsLnNhZ2FyQGFtZC5jb20+DQo+
ID4NCj4gPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMjAxMjIxMjE0MDcu
MTE0NjctMS0NCj4gbmVlbC5nYW5kaGlAeGlsaW54LmNvbQ0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVy
cy9kbWEveGlsaW54L3hpbGlueF9kcGRtYS5jIHwgMTAgKysrKysrKystLQ0KPiA+ICAgMSBmaWxl
IGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4NCj4gVGhpcyBmaXhl
cyBhIGxvY2tkZXAgd2FybmluZzoNCj4NCj4gV0FSTklORzogQ1BVOiAxIFBJRDogNDY2IGF0IGRy
aXZlcnMvZG1hL3hpbGlueC94aWxpbnhfZHBkbWEuYzo4MzQNCj4NCj4gQWZhaWNzLCB0aGlzIGlz
c3VlIGhhcyBiZWVuIGFyb3VuZCBzaW5jZSB0aGUgaW5pdGlhbCBjb21taXQsIGluIHY1LjEwLA0K
PiBhbmQgdGhlIGZpeCBhcHBsaWVzIG9uIHRvcCBvZiB2NS4xMC4gSSBoYXZlIHRlc3RlZCB0aGlz
IG9uIHY2LjIsIHdoaWNoDQo+IGlzIHdoZXJlIHRoZSBEUCBzdXBwb3J0IHdhcyBhZGRlZCB0byB0
aGUgYm9hcmQgSSBoYXZlLg0KPg0KPiBTbyBJIHRoaW5rIHlvdSBjYW4gYWRkOg0KPg0KPiBGaXhl
czogN2NiYjBjNjNkZTNmICgiZG1hZW5naW5lOiB4aWxpbng6IGRwZG1hOiBBZGQgdGhlIFhpbGlu
eA0KPiBEaXNwbGF5UG9ydCBETUEgZW5naW5lIGRyaXZlciIpDQo+DQo+ICAgVG9taQ0KPg0KDQo8
c25pcD4NCg0KVGhhbmtzIGZvciBnb2luZyB0aHJvdWdoIHRoZSBwYXRjaC4NCkkgd2lsbCBhZGQg
dGhpcyB0byB0aGUgY29tbWl0IG1lc3NhZ2UgYW5kIHJlc2VuZCB2My4NCkkgYW0gc3RpbGwgd2Fp
dGluZyBmb3IgbW9yZSByZXZpZXdzIHRvIGhhcHBlbi4NCg0KUmVnYXJkcw0KVmlzaGFsIFNhZ2Fy
DQo=

