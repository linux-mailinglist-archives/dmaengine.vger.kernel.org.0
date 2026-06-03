Return-Path: <dmaengine+bounces-11144-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2d71BLsjIGpywwAAu9opvQ
	(envelope-from <dmaengine+bounces-11144-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 14:53:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB917637B5C
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 14:53:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=UYPyULLN;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11144-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11144-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56C743037F68
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jun 2026 12:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E217A20FA81;
	Wed,  3 Jun 2026 12:41:39 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013004.outbound.protection.outlook.com [40.93.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC2D47ECCD
	for <dmaengine@vger.kernel.org>; Wed,  3 Jun 2026 12:41:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780490499; cv=fail; b=VThTQsKYbymPyEzzmrCa/0Z+noGYBJEmQFLlzs952gHO+4VpexNlD6STBT2X0cGeofLdEXzG81OpJWOazhnLUPdPlwW4n/T5mDS9ZCP5s3cf7wzN/93/QRxK/gmaRrmO6onbXCe7GO656lJ4WnyqkrDML+IpYJHJFGDo059qGOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780490499; c=relaxed/simple;
	bh=XCqOmAhzKsP264FpkqJA0o3uwcfrs0b0Vl/XfXok/0M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IKt4IcusW9pjidIVUTNnxUXAhXVu0ENaE0ztx8aE8nbihOVknt9S9xIxcgyKmyuXD/5KWPrFn+mPlsV08jpvg3ue82dZXHwVyHuk5Opwq+okMVBRpxgzX3POjpgCiZJcvvjM/GHaodk6+zTJsT4XKqXt7+OwooBz6eCqY47E2FQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UYPyULLN; arc=fail smtp.client-ip=40.93.201.4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tlt9f/RRPkpZrjlTYK9nHkRs76Cs2quoJ66xQKx9wnVLPolaocxMrYi64VPfZ9wyyNigqL1lHd1n+oXnudB5CMXX5BuvbxwhfDtDpgRK3IrfyIcNKYuIXyh1i9JT2x4WlsS7Xw61OFuT7k3SbPDMYU3v5obFOB3hBnaXFAQEsnyLwogzKs5nX5ZTLrXBGCZAT7qCTLJtFAz8/8YebSHyeNChFh66OsExb6ljqnsnVNBYcC7uQcZ9tA9sX6fiQDen6DAPCWAvn+uQgxehmX8OJEtbp7DqpgUuoWQpNUX/TL2FU5gPeQPnxgET5rDfElMYRgYXbtauXYmk96sMqBsXnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCqOmAhzKsP264FpkqJA0o3uwcfrs0b0Vl/XfXok/0M=;
 b=qYpuT+pi35pMfpZfNpoYrbNyzLxX3Vo9ZhcMP+srEDLmHx5+1eM7HqyW/5ccMHjv5SBHFqTP/UiYe1e9tjfG/i6VimE8LapFZH4CkgN/gVen96dR30u2j7K0BBL30TB/iwcaNGuedxnYyG5mrPVKjxaeokkv6ZGBHIbyAeGl3zE82xxGYsekT8Muw13IJSGWi7jOzX5kV8cssEHnHHzthA36+uRWTlW6YsCSHJkjQ0JRrj++XuuBp2uoTJ/3XMIAgE+ntB+UDQtWtd22RL1zqFLxIF0Oa8uAyb+MZV4WfDEBW+bkBhQ9sxWzSUC3WN5S8ff2neQSJVB58DM8lKXXCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCqOmAhzKsP264FpkqJA0o3uwcfrs0b0Vl/XfXok/0M=;
 b=UYPyULLN2ew2txHm7JfOjq12sq/8eAi3NZbYY5+mN/+0es4d6Cb8coancnk8XtSGCI8ktQFzjwQAgsDcOpMRpnw5ua6xTDnUeUVwHYf0uD8zwakgL7tpiFHxrlzXds2goN2bAF8LZn+wqInokFxiW3IcgMIphFcERjIofYQuNRI=
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by BY5PR12MB4275.namprd12.prod.outlook.com (2603:10b6:a03:20a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Wed, 3 Jun 2026
 12:41:24 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 12:41:24 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "Frank.Li@kernel.org" <Frank.Li@kernel.org>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>, "Verma,
 Devendra" <Devendra.Verma@amd.com>
Subject: RE: [PATCH v2] dmaengine: dw-edma: Enable HDMA 64R/W Channels
Thread-Topic: [PATCH v2] dmaengine: dw-edma: Enable HDMA 64R/W Channels
Thread-Index: AQHc80kMKUmiN7aw3EyPkjywklEm07YstXyAgAAPOwA=
Date: Wed, 3 Jun 2026 12:41:23 +0000
Message-ID:
 <BL4PR12MB94826D99C30DC8014277343595132@BL4PR12MB9482.namprd12.prod.outlook.com>
References: <20260603110628.2807317-1-devendra.verma@amd.com>
 <20260603114218.06C431F00893@smtp.kernel.org>
In-Reply-To: <20260603114218.06C431F00893@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-06-03T12:37:10.0000000Z;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public
 v26;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL4PR12MB9482:EE_|BY5PR12MB4275:EE_
x-ms-office365-filtering-correlation-id: 68101114-90d6-4e9b-d134-08dec16d6c04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|56012099006|4143699003|5023799004|6133799003|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 PnXk+eP3Fz8WMXe0nCeykGXq0S13A4NN2hB4rv2O9JpnoYyWqLdvaHZolv3+lpgHPswr0Wac4Ha6SLspYcTvTgQvVktrfFo6+BpU9nme2WeKrofK/BHuYGXgWJiuDmCTFtrFG1UQw85lRpzVk6P6pxV0D/y60mYHZt/eel3ny8IRZ/uqY7m7q1hfA3bh6K+jy0mGyZ4mPiHz3IDDAMgIjujR7wQNYTPxrse46ATi8EMBuKwYFETypSW7cUDb/WqufVJdTj6KoDAGEQzgvtJHgUz/nTb/x5Hspo1PCxlOm9VxTz0CqlDIYX9VWW8M3h7jD6kS+LJ1QZQv9qZY1OwEpWMnk92Q1nmXF6eKRF9M3aTrB2IamElHehBtFN9ekkCWemoHvPaEWuvo7NoyJbp5QoYFEVRpan2suop24E6xZRDQi3ZYbHil+jCYIfDqTkHJsSD7CMBlZ4XFp5JS4tR6atkJPHdFAt+S4bMhT2dY5GSp6+I8stWtuHw9KjcIqsgdAA7amxpUzp6nf7KPJhNfIkhjI0jOXHCltdVOSDj6DZtxwWbRhpfJjSXxOEBTMAxY5DqdlXjPPCaroCZV9+8YznkNyo/U7UPFu7o+9pb1ZPwfWgryJ7eupwj+dB7297DdxDbAzcszic6u2zEreW/qEylZA+gBLOkOSHDq20/wo/tc1/MAe2csxEa+/Mdd2Kd7VSsZyrFBROweB3ocCXFzMA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099006)(4143699003)(5023799004)(6133799003)(11063799006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MFdKVjZTeUZzZWZRMGxNOHRobDVjaDlwS0ZxNldPc2greWFSU3BEdzVjd211?=
 =?utf-8?B?OTlXaVJjNFBjNE1hUHV2U1VwQ1FUcnhMYVdFa3RRNGNuM1djNnIxTFNtY3Zq?=
 =?utf-8?B?T0toNFpIdjhhM0I0VjVCdFJrN0tOWCs3TlUyb24vZzdIUU9WKy9yMy9kVGtT?=
 =?utf-8?B?VGFpb1U0TURQOFEyMGt4N0VxSFNOcUZXbzYyT2treFdwQ21qTnBIdVBzSkFr?=
 =?utf-8?B?NTllK212OU1MYzJaUUNUS2JEV2hEbEtTRzFUL2MwVDV2NUtjZ0dDcUdrM3hn?=
 =?utf-8?B?WUhTMDNxWlhHVDlqV1h4QWxlUWc4blpvOTN1VkxxdjZGVGxLWXpKUlRsS3Fl?=
 =?utf-8?B?QWtZVnlXRlFSeDRDSW0xQzJxRlp4S08reXQrWmdZNWU4NTdqbW5qV25vU0RL?=
 =?utf-8?B?eVFQWjIxSWV2RGwxN1ErRExDYVNINkRrVFREZzg5OGZLM05jcDBNampEbm92?=
 =?utf-8?B?VTEzTkxXVW1OOTcyMFVhbzdaWXFvZ2VCeitxVHkxMnVvSmpYeXJrVGF0Z0RR?=
 =?utf-8?B?cXN2Z0VCMERzQk9oOVFRTE9XNEgwUWM1OVBscDgxaFRaVVIweW03cHVrZVda?=
 =?utf-8?B?OTkvMEhETG9MSXZFWWF6YmNNMzNWM3pCbDRzNDZkYlEraWFzdUFWSU11emlu?=
 =?utf-8?B?THR4S0NNakk1cU5ZTTJadnhxeXh1T2Q0QnlhejJ3YVJTZ0JncU5GNUptL004?=
 =?utf-8?B?ME9lWmtXTTZJc043TGdoK3lQL0NjM29LN2o3K01zYUErbUpnS2R2SXhrd2p5?=
 =?utf-8?B?aVNLRzgvOWd4YTdManpjbmZVT0RNZXFEUFJTQlNJZjUwdzVJVFlUNUloYTFC?=
 =?utf-8?B?U1ZBRXMzY2RCOUczYnhVdEVyK01oc09HOW9pU3F2VVNtS2tDbFlvQW9zWnBM?=
 =?utf-8?B?MEJtZzNLVnRPblNlNmdlMVFLVm50K0g5clUrNTcxb3Y4cFdFWkgzT1FERjIv?=
 =?utf-8?B?SEZoOWczSkJNQ1drd3l0V1JXSkJVVUhENnptaXBqSnc2clkwMVpuWXk2NEk5?=
 =?utf-8?B?R3Y1YUhmOXRsNUtNSzhDRWJWaU04NXpoN0hMaWJuRDdSZkFzUDZjMkJFMWd4?=
 =?utf-8?B?OVAyWHN4Y2lIRUhVWTJEeWY2Wm1PdXQ4bk9CMlI4WlVwYWV3NWUvVmdxOS9n?=
 =?utf-8?B?RFpNeks5VkJKUHJxTyt2MWlrRHRraXp2Kzk3WWtmeXprVDM1VDg0RllCKzI3?=
 =?utf-8?B?a0tIVjd5cE9RS3Y2dStkb3IxdWpzT0xiNUR0TUZDcnhad0F2anA4TTJ5RTQ4?=
 =?utf-8?B?S1BtUWlzM3BBcTBUOVRmb1dwakFtY1JPMWVPb2FldE5KSXE3SkZHaHVpYkpa?=
 =?utf-8?B?Q1B4K1VFb1M4QzJpNElsd3dZblFBVCs4dlB3Mm9sL2tJUXo2OVFsb0RGMzNQ?=
 =?utf-8?B?QUlNQlVpOUNKRUdvT3pFU1pPQ1VFdmFGNlBZV0ZOb28rK2pscXpkei9rem8w?=
 =?utf-8?B?bjQyZTVvNWRJWnU2Tmo0ZVJtSkE5cmo2bG5CMi9Rc0hOMnhzeXhSMFZSQXFV?=
 =?utf-8?B?QnUwZW42SUhkNklTclhKby8vY0F6ZWpTVGZickt2WmRLdElwUzVyU3VsMk12?=
 =?utf-8?B?aGdwVW9lbCt4QXNUaDMxUVdKeTFHeTBwaEQrVUpOVFpWcGdXdVVNeTFKMndV?=
 =?utf-8?B?M0VsVi95eTRRWG9ucllPTjRrL1JFVzhnQjgvMDlVYXBLcnc3c3kwM2tQaHk3?=
 =?utf-8?B?T2NtRmhTSjlPMkRneEN2eU5HbDE3aElhOEpOQWw2dXJUcnZ4dlh0aU9CZjl2?=
 =?utf-8?B?WHF3blZBZlNhY0hST0Vpc0Vxa1pEWnM3WnJZYXE1WlZCRElhRzdjTXFrVnlJ?=
 =?utf-8?B?NjhvbTk0bUxjc0NydnhNNy9mVUtMMm4zN1JxNko2eTdFRWhvTTQzZGhGTXJM?=
 =?utf-8?B?ZFd1RDh0TVNPWjJab0wwQ2ttc0c3YnoycHpyb3lSZllaeTVnajE5bnhiTndn?=
 =?utf-8?B?aXA3YmpRTFVhd0VIRnNXVm9rbWgrMEdTSkNMTURoSEtydlVwUnFOc0g0QUxH?=
 =?utf-8?B?MHdsTmRHeUlTamdzMFdsSGZJZ2Rra0E3emhQOTFhR0p2Ym1FanVKYUlsQVBO?=
 =?utf-8?B?c1hxOS9NcDdISDZuVTIydnkwdTFxYmFmdW9tNWdNWVVZT3RGRlVXWE1kNFlF?=
 =?utf-8?B?VjhXK1IrRndzaXZjZCszemVDNDM5YlFvZXdDV2YrQU5MYnJMY1hzWWJoY2U2?=
 =?utf-8?B?OFdoSjIwaVZ1MWpUUWtsUGc0TnJyc1M2ODdtdGx1eVRNYnVtWHNrdzBmc09u?=
 =?utf-8?B?Rk42Q3h5ektEOUM3SlJSMFVhYXk2MGk0UFlNZUF5K0l5bFRwYzU0M1pYS29l?=
 =?utf-8?Q?yebJnuDe5cBIQZiDAp?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 68101114-90d6-4e9b-d134-08dec16d6c04
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 12:41:24.0380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HYe8+JJatV2QnEW/EDhAivxYWZXTaaWJ2zuE8qgJpLxx80bvKNMmx8PqoQfszOaEdisgI2xeScl/7vHd8pNCYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4275
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11144-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Devendra.Verma@amd.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url,amd.com:dkim,amd.com:from_mime,amd.com:email,BL4PR12MB9482.namprd12.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB917637B5C

UHVibGljDQoNCkhpDQoNClBsZWFzZSByZWFjaCBjb21tZW50cyBpbmxpbmUuDQoNClJlZ2FyZHMs
DQpEZXZlbmRyYQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IHNhc2hp
a28tYm90QGtlcm5lbC5vcmcgPHNhc2hpa28tYm90QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFdlZG5l
c2RheSwgSnVuZSAzLCAyMDI2IDE3OjEyDQo+IFRvOiBWZXJtYSwgRGV2ZW5kcmEgPERldmVuZHJh
LlZlcm1hQGFtZC5jb20+DQo+IENjOiBGcmFuay5MaUBrZXJuZWwub3JnOyBkbWFlbmdpbmVAdmdl
ci5rZXJuZWwub3JnOyB2a291bEBrZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJd
IGRtYWVuZ2luZTogZHctZWRtYTogRW5hYmxlIEhETUEgNjRSL1cgQ2hhbm5lbHMNCj4NCj4gVGhh
bmsgeW91IGZvciB5b3VyIGNvbnRyaWJ1dGlvbiEgU2FzaGlrbyBBSSByZXZpZXcgZm91bmQgMyBw
b3RlbnRpYWwgaXNzdWUocykgdG8NCj4gY29uc2lkZXI6DQo+DQo+IE5ldyBpc3N1ZXM6DQo+IC0g
W0NyaXRpY2FsXSBTdGFjayBvdXQtb2YtYm91bmRzIHJlYWQgYW5kIGNoYW5uZWwgbWFzayB0cnVu
Y2F0aW9uIG9uIDMyLWJpdA0KPiBwbGF0Zm9ybXMgaW4gSERNQSBpbnRlcnJ1cHQgaGFuZGxlci4N
Cj4gLSBbTWVkaXVtXSBJbmNvbXBsZXRlIGVuYWJsZW1lbnQ6IERlc2lnbldhcmUgUENJZSBjb250
cm9sbGVyIHdyYXBwZXIgc3RpbGwNCj4gaGFyZGNvZGVzIGFuIDgtY2hhbm5lbCBsaW1pdC4NCj4N
Cj4gUHJlLWV4aXN0aW5nIGlzc3VlczoNCj4gLSBbSGlnaF0gQXJndW1lbnQgc3dhcCB3aGVuIHJl
YWRpbmcgY2hhbm5lbCBzdGF0dXMgY2F1c2VzIGl0IHRvIGFjY2VzcyB0aGUNCj4gd3JvbmcgaGFy
ZHdhcmUgcmVnaXN0ZXIuDQo+IC0tDQo+DQo+IGNvbW1pdCAwZjIzMDljNzhjNzI5MmFlMjlhZjE1
YjQzNmNlMGU0ZjE2ZjYyZDk2DQo+IEF1dGhvcjogRGV2ZW5kcmEgSyBWZXJtYSA8ZGV2ZW5kcmEu
dmVybWFAYW1kLmNvbT4NCj4NCj4gZG1hZW5naW5lOiBkdy1lZG1hOiBFbmFibGUgSERNQSA2NFIv
VyBDaGFubmVscw0KPg0KPiBUaGlzIHBhdGNoIGluY3JlYXNlcyB0aGUgbWF4aW11bSBzdXBwb3J0
ZWQgcmVhZCBhbmQgd3JpdGUgY2hhbm5lbHMgZnJvbSA4IHRvDQo+IDY0IGZvciB0aGUgSERNQSBJ
UC4gSXQgdXBkYXRlcyB0aGUgY2hhbm5lbCBzdHJ1Y3RzLCBtYXNrIHR5cGVzLCBhbmQgcHJvYmUN
Cj4gZnVuY3Rpb24gY29uZmlndXJhdGlvbiB0byBhY2NvbW1vZGF0ZSB0aGUgbGFyZ2VyIG51bWJl
ciBvZiBjaGFubmVscy4gSXQgYWxzbw0KPiBkZWZpbmVzIG5ldyBIRE1BLXNwZWNpZmljIG1hY3Jv
cyB0byByZWZsZWN0IHRoZSB1cGRhdGVkIGNoYW5uZWwgY291bnRzLg0KPg0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2RtYS9kdy1lZG1hL2R3LWVkbWEtY29yZS5oDQo+ID4gYi9kcml2ZXJzL2Rt
YS9kdy1lZG1hL2R3LWVkbWEtY29yZS5oDQo+ID4gaW5kZXggOTAyNTc0YjFiYTg2Ny4uZDEyZmVm
YmYzOTUyNCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2RtYS9kdy1lZG1hL2R3LWVkbWEtY29y
ZS5oDQo+ID4gKysrIGIvZHJpdmVycy9kbWEvZHctZWRtYS9kdy1lZG1hLWNvcmUuaA0KPiA+IEBA
IC05MSw4ICs5MSw4IEBAIHN0cnVjdCBkd19lZG1hX2NoYW4gew0KPiA+DQo+ID4gIHN0cnVjdCBk
d19lZG1hX2lycSB7DQo+ID4gICAgIHN0cnVjdCBtc2lfbXNnICAgICAgICAgICAgICAgICAgbXNp
Ow0KPiA+IC0gICB1MzIgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHdyX21hc2s7DQo+ID4g
LSAgIHUzMiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmRfbWFzazsNCj4gPiArICAgdTY0
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB3cl9tYXNrOw0KPiA+ICsgICB1NjQgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHJkX21hc2s7DQo+DQo+IFtTZXZlcml0eTogQ3JpdGljYWxd
DQo+IENhbiBjaGFuZ2luZyB0aGVzZSB0byB1NjQgY2F1c2UgYSBzdGFjayBvdXQtb2YtYm91bmRz
IHJlYWQgYW5kIG1hc2sgdHJ1bmNhdGlvbg0KPiBvbiAzMi1iaXQgcGxhdGZvcm1zPw0KPg0KPiBJ
biBkd19oZG1hX3YwX2NvcmVfaGFuZGxlX2ludCgpLCB0aGUgbG9jYWwgbWFzayB2YXJpYWJsZSBp
cyBzdGlsbCBkZWZpbmVkIGFzIGFuDQo+IHVuc2lnbmVkIGxvbmc6DQo+DQo+IGRyaXZlcnMvZG1h
L2R3LWVkbWEvZHctaGRtYS12MC1jb3JlLmM6ZHdfaGRtYV92MF9jb3JlX2hhbmRsZV9pbnQoKQ0K
PiAgICAgdW5zaWduZWQgbG9uZyBvZmYsIG1hc2s7DQo+DQo+ICAgICBpZiAoZGlyID09IEVETUFf
RElSX1dSSVRFKSB7DQo+ICAgICAgICAgdG90YWwgPSBkdy0+d3JfY2hfY250Ow0KPiAgICAgICAg
IG9mZiA9IDA7DQo+ICAgICAgICAgbWFzayA9IGR3X2lycS0+d3JfbWFzazsNCj4gICAgIH0NCj4g
ICAgIC4uLg0KPiAgICAgZm9yX2VhY2hfc2V0X2JpdChwb3MsICZtYXNrLCB0b3RhbCkgew0KPg0K
PiBBc3NpZ25pbmcgdGhlIDY0LWJpdCBkd19pcnEtPndyX21hc2sgdG8gdGhlIDMyLWJpdCBsb2Nh
bCBtYXNrIHZhcmlhYmxlIHdpbGwNCj4gc2lsZW50bHkgdHJ1bmNhdGUgdGhlIHVwcGVyIDMyIGJp
dHMgb24gMzItYml0IGFyY2hpdGVjdHVyZXMuIEZ1cnRoZXJtb3JlLCBpZiB0b3RhbCBpcw0KPiB1
cCB0byA2NCwgd29uJ3QgZm9yX2VhY2hfc2V0X2JpdCgpIHJlYWQgcGFzdCB0aGUgNC1ieXRlIG1h
c2sgdmFyaWFibGUgaW50bw0KPiBhZGphY2VudCBzdGFjayBtZW1vcnksIHBvdGVudGlhbGx5IHRy
aWdnZXJpbmcgc3B1cmlvdXMgaW50ZXJydXB0cyBvciBLQVNBTg0KPiBwYW5pY3M/DQo+DQo+IFsg
Li4uIF0NCj4NCg0KWWVzLCB0aGlzIGlzIHZhbGlkIGNvbmNlcm4sIHNoYWxsIGJlIGZpeGVkIGlu
IG5leHQgdmVyc2lvbi4NCg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9kdy1lZG1hL2R3
LWhkbWEtdjAtY29yZS5jDQo+ID4gYi9kcml2ZXJzL2RtYS9kdy1lZG1hL2R3LWhkbWEtdjAtY29y
ZS5jDQo+ID4gaW5kZXggNjMyYWJiOGI0ODFjZi4uZDdhM2M5YTczZTljNCAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL2RtYS9kdy1lZG1hL2R3LWhkbWEtdjAtY29yZS5jDQo+ID4gKysrIGIvZHJp
dmVycy9kbWEvZHctZWRtYS9kdy1oZG1hLXYwLWNvcmUuYw0KPiA+IEBAIC01MywxMyArNTMsMjQg
QEAgX19kd19jaF9yZWdzKHN0cnVjdCBkd19lZG1hICpkdywgZW51bQ0KPiBkd19lZG1hX2Rpcg0K
PiA+IGRpciwgdTE2IGNoKSAgc3RhdGljIHZvaWQgZHdfaGRtYV92MF9jb3JlX29mZihzdHJ1Y3Qg
ZHdfZWRtYSAqZHcpICB7DQo+ID4gICAgIGludCBpZDsNCj4gPiArICAgZW51bSBkd19lZG1hX2Rp
ciBkaXI7DQo+ID4gKw0KPiA+ICsgICBkaXIgPSBFRE1BX0RJUl9XUklURTsNCj4gPiArICAgZm9y
IChpZCA9IDA7IGlkIDwgZHctPndyX2NoX2NudDsgaWQrKykgew0KPiA+ICsgICAgICAgICAgIFNF
VF9DSF8zMihkdywgZGlyLCBpZCwgaW50X3NldHVwLA0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICBIRE1BX1YwX1NUT1BfSU5UX01BU0sgfA0KPiBIRE1BX1YwX0FCT1JUX0lOVF9NQVNLKTsNCj4g
PiArICAgICAgICAgICBTRVRfQ0hfMzIoZHcsIGRpciwgaWQsIGludF9jbGVhciwNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgSERNQV9WMF9TVE9QX0lOVF9NQVNLIHwNCj4gSERNQV9WMF9BQk9S
VF9JTlRfTUFTSyk7DQo+ID4gKyAgICAgICAgICAgU0VUX0NIXzMyKGR3LCBkaXIsIGlkLCBjaF9l
biwgMCk7DQo+ID4gKyAgIH0NCj4NCj4gW1NldmVyaXR5OiBIaWdoXQ0KPiBUaGlzIGlzbid0IGEg
YnVnIGludHJvZHVjZWQgYnkgdGhpcyBwYXRjaCwgYnV0IGRvZXMgZHdfaGRtYV92MF9jb3JlX2No
X3N0YXR1cygpDQo+IHBhc3MgYXJndW1lbnRzIHRvIEdFVF9DSF8zMigpIGluIHRoZSB3cm9uZyBv
cmRlcj8NCj4NCj4gVGhlIG1hY3JvIGV4cGVjdHMgdGhlIGRpcmVjdGlvbiBmaXJzdCBhbmQgdGhl
IGNoYW5uZWwgaW5kZXggc2Vjb25kLCBidXQgaXQgaXMNCj4gaW52b2tlZCBhczoNCj4NCj4gZHJp
dmVycy9kbWEvZHctZWRtYS9kdy1oZG1hLXYwLWNvcmUuYzpkd19oZG1hX3YwX2NvcmVfY2hfc3Rh
dHVzKCkNCj4gICAgIHRtcCA9IEZJRUxEX0dFVChIRE1BX1YwX0NIX1NUQVRVU19NQVNLLA0KPiAg
ICAgICAgICAgICAgICAgICAgIEdFVF9DSF8zMihkdywgY2hhbi0+aWQsIGNoYW4tPmRpciwgY2hf
c3RhdCkpOw0KPg0KPiBXaWxsIHRoaXMgY2F1c2UgdGhlIGNoYW5uZWwgSUQgKG5vdyB1cCB0byA2
MykgdG8gYmUgdXNlZCBhcyB0aGUgZGlyZWN0aW9uLCBhbmQgdGhlDQo+IGRpcmVjdGlvbiB0byBi
ZSB1c2VkIGFzIHRoZSBjaGFubmVsIElELCBjb25zaXN0ZW50bHkgcmVhZGluZyB0aGUgc3RhdHVz
IHJlZ2lzdGVyIG9mDQo+IHRoZSB3cm9uZyBjaGFubmVsPw0KPg0KPiBbIC4uLiBdDQo+DQoNClRo
aXMgaXMgcHJlLWV4aXN0aW5nIGJ1Zywgbm90IGNhdXNlZCBieSBteSBjb21taXQuIFRob3VnaCwg
SSB3aWxsIHRyeSB0byBmaXggdGhpcw0KYXMgd2VsbC4NCg0KPiA+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L2RtYS9lZG1hLmggYi9pbmNsdWRlL2xpbnV4L2RtYS9lZG1hLmggaW5kZXgNCj4g
PiAxZmFmZDViMGUzMTUzLi5kYTdhNWNjOTNhZDQzIDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUv
bGludXgvZG1hL2VkbWEuaA0KPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvZG1hL2VkbWEuaA0KPiA+
IEBAIC0xNCw2ICsxNCw4IEBADQo+ID4NCj4gPiAgI2RlZmluZSBFRE1BX01BWF9XUl9DSCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICA4DQo+ID4gICNkZWZpbmUgRURNQV9NQVhfUkRf
Q0ggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgOA0KPiA+ICsjZGVmaW5lIEhETUFf
TUFYX1dSX0NIICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDY0DQo+ID4gKyNkZWZp
bmUgSERNQV9NQVhfUkRfQ0ggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgNjQNCj4N
Cj4gW1NldmVyaXR5OiBNZWRpdW1dDQo+IERvZXMgdGhlIERlc2lnbldhcmUgUENJZSBjb250cm9s
bGVyIHdyYXBwZXIgYWxzbyBuZWVkIGFuIHVwZGF0ZSB0byBzdXBwb3J0IHRoZQ0KPiA2NCBjaGFu
bmVscz8NCj4NCj4gSW4gZHdfcGNpZV9lZG1hX2ZpbmRfY2hhbm5lbHMoKSwgdGhlIGluaXRpYWxp
emF0aW9uIHN0aWxsIGNoZWNrcyBhZ2FpbnN0IHRoZSA4LQ0KPiBjaGFubmVsIGxpbWl0Og0KPg0K
PiBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuYzpkd19wY2llX2Vk
bWFfZmluZF9jaGFubmVscygpDQo+ICAgICBpZiAoIXBjaS0+ZWRtYS5sbF93cl9jbnQgfHwgcGNp
LT5lZG1hLmxsX3dyX2NudCA+IEVETUFfTUFYX1dSX0NIIHx8DQo+ICAgICAgICAgIXBjaS0+ZWRt
YS5sbF9yZF9jbnQgfHwgcGNpLT5lZG1hLmxsX3JkX2NudCA+IEVETUFfTUFYX1JEX0NIKQ0KPiAg
ICAgICAgIHJldHVybiAtRUlOVkFMOw0KPg0KPiBJZiBhIGhvc3QgcGxhdGZvcm0ncyBIRE1BIElQ
IHN1cHBvcnRzIGFuZCByZXF1ZXN0cyBtb3JlIHRoYW4gOCBjaGFubmVscywgd29uJ3QNCj4gdGhp
cyBoYXJkY29kZWQgY2hlY2sgZmFpbCBhbmQgcmV0dXJuIC1FSU5WQUwsIHByZXZlbnRpbmcgdGhl
IG5ldyBjaGFubmVscyBmcm9tDQo+IGJlaW5nIHVzZWQ/DQo+DQoNCk5vLCB0aGUgYWJvdmUgc25p
cHBldCBzaGFyZWQgaXMgc3BlY2lmaWNhbGx5IG1lYW50IGZvciBub24tSERNQSBJUHMuIFRoZSBu
b24tSERNQQ0KYW5kIGxlc3NlciB2YXJpYW50cyBzdXBwb3J0IHVwdG8gOCBjaGFubmVscyBvbmx5
IHNvIHRoZSBjb25jZXJuZWQgcmFpc2VkIGlzIG5vdCBhcHBsaWNhYmxlLg0KVGhpcyB3aWxsIG5v
dCBjYXVzZSBhbnkgZnVuY3Rpb25hbGl0eSBicmVha2FnZS4gVGhlcmUgaXMgbm8gY2hhbmdlIHJl
cXVpcmVkIGhlcmUuDQoNCj4gLS0NCj4gU2FzaGlrbyBBSSByZXZpZXcgwrcgaHR0cHM6Ly9zYXNo
aWtvLmRldi8jL3BhdGNoc2V0LzIwMjYwNjAzMTEwNjI4LjI4MDczMTctMS0NCj4gZGV2ZW5kcmEu
dmVybWFAYW1kLmNvbT9wYXJ0PTENCg==

