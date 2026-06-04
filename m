Return-Path: <dmaengine+bounces-11164-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id chc9JVxtIWodGQEAu9opvQ
	(envelope-from <dmaengine+bounces-11164-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 14:19:40 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E67BE63FCE2
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 14:19:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=q4RCJyy5;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11164-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11164-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D8AB3005AC7
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jun 2026 12:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230DE425CF7;
	Thu,  4 Jun 2026 12:11:40 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013063.outbound.protection.outlook.com [40.93.201.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDBE42E000
	for <dmaengine@vger.kernel.org>; Thu,  4 Jun 2026 12:11:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780575100; cv=fail; b=iNrVzIKNgsr7MqGBuOGKoRBvVAkZx5hgCT+814aCRc5SDFfX5fKIKujlBAyXd9IVrAV6d11mDOhXP580Ww1MjyFBxGM+wrx5YSDscANaNS6iPoCdlCAtfUKNOyXVywdmeYbNt0YRQtIkDfPTY9r0os/RyrOleA/e1W9oU2i9gIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780575100; c=relaxed/simple;
	bh=WpxbTOcVIVVia40aFwntyE7fIdq2E/psdT/GL24I6kA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CEpDptwT59AnIjXf8omv4GJKoolH40nT2SfClRQ+zljS/FpXtIc5mhdxmhyQJIVEYsJznAALFBcwi/tjbFBoEwOwZ8EuSQhwewD/572KoldFJhP4BHUpx57WDbnm8nDtam3ZXHahg96uRrkJKLuVpbjg78VarPg++zlueJAooQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q4RCJyy5; arc=fail smtp.client-ip=40.93.201.63
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pnIg619S0XHgsZIIhxSj1GlsWrkFCRP9tc/8NFwlsYgO6hgVt5J/Ziefy9XdJ7fsgac4UWrA2stmaXxGAgZT6e/mln33/GJ/gycQvzeql05tqmo0uT6H1AN5/+tKkIg75iwm/S9S3IF9zTliBPOOtjx9wSZkvAWJ0WaR/+fGxVHfTjbobh3Qiv/rNibqWmyU21Jr6mUTkPLuE7+t7Of67/nh6ww3RgtK73XPAi0LePB/QOKzFmtuXvG9XhiINpAao3SWWLfzuC/DUe1vV1XgSFzwXvloiRd7P40fE9sHsst1tgqt7pPGM7YIg/L0e0eVflJfODKxokGRZ1eS4QKJgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpxbTOcVIVVia40aFwntyE7fIdq2E/psdT/GL24I6kA=;
 b=OsdGhlQWHwdysdx14RS/1UYKRMbvBuP2J4q1VC9MSW0ZQrz2mSp8EXShj5AyPJ8Ts62C378RyJejik4F7ONjrFoZQkan3ockiI5tp5k8nueUPyrzD1+b2NiR4Ne/K1FXli221d8g5BtSUHH8rJe8euwVNg90GlNJeRYx2XLPsW14tGQ4dCiJr9lgf7vRxxsLWWXr7/egZzYpgL9UVNyDkyAZorYRWaht76Qmrv6WmD6lvKKoI1qun8llkqtVD+QYRqn33ribaRAZ/8I4vAt76v7ombfamLSBf1bsJvXCq75GsPS7YT3CO7Vtc+FMxihxrf8O9q25aoHPScgzPSWI8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpxbTOcVIVVia40aFwntyE7fIdq2E/psdT/GL24I6kA=;
 b=q4RCJyy5QBpbYiVe465VJgb6YLCdQvGpIxcRcPXcoLZmXSIsTfR9mMdgjtlG1HnMurggl2vC6HpivjEvQWLcDZLzwG1XHTdaLSoLHIxeREpLDY1StzG8tlM8dKTMEAQC0sjJh4QSmrtL8Q1OijT5FmTpBG6Z/PbTaP0fpRkdUUg=
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by IA1PR12MB8494.namprd12.prod.outlook.com (2603:10b6:208:44c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 12:11:34 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 12:11:33 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "vkoul@kernel.org" <vkoul@kernel.org>, "Frank.Li@kernel.org"
	<Frank.Li@kernel.org>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "Verma, Devendra" <Devendra.Verma@amd.com>
Subject: RE: [PATCH v3] dmaengine: dw-edma: Enable HDMA 64R/W Channels
Thread-Topic: [PATCH v3] dmaengine: dw-edma: Enable HDMA 64R/W Channels
Thread-Index: AQHc82cfn7QgO5h/VU+JEJ5JddgQKbYs7AWAgAFjOXA=
Date: Thu, 4 Jun 2026 12:11:33 +0000
Message-ID:
 <BL4PR12MB948289018164E646376C572A95102@BL4PR12MB9482.namprd12.prod.outlook.com>
References: <20260603144147.3249691-1-devendra.verma@amd.com>
 <20260603145820.2E7E81F00893@smtp.kernel.org>
In-Reply-To: <20260603145820.2E7E81F00893@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-04T12:09:42.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL4PR12MB9482:EE_|IA1PR12MB8494:EE_
x-ms-office365-filtering-correlation-id: 3652dfc8-ba27-47c2-6b84-08dec2326b07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|11063799006|4143699003|56012099006|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info:
 kxnPfMlVPQntNxugIdW2R8kuGM4RynIO+vwIONhMBeA5T0l8Uz1ORnqCJitwtY7HAOUY7jXRB3TgsEaV/YM2kTy7R1WWxsBZLjzcHz98XYC39aMd8PiX+TxXc7AK5DSnAHlkRIS2+SgLP3MbOnsnU+iNty/GJeuOK+Pw52Zf0Jog3cZgnoozWDycgOtHLKT5GOpDQ53dPSDJ53NMlwNMMhdaYzHGsTeZAEPCGSFKn4hql+2OHaW04JMFBpZ7HWZhD7xEhZu5dCu+Vn+M/JbUbpFUUZq/yz0BrvpPIo/+krzQxq8JhqcmFLbTsGYAws3Ud0qV+Yq66ZV7ULFyxp6sUmtgkkf1ufAtxvqajW7C/zXPZ2JAIYqfKQlQcSll8rKeG61o8mV/ihVhTwKLKReaXjHxL2qGrJTEpyU+ya+YqITD02moosLBKzx6kNoWtbA+S9FabtWE/T5HFG/s2KwXCNXXtqk7M5cSsBGA1jel/kavmgVVNmbAqxiYwj3m6634rpOXoJf/tR2+OQyzBIPIfc0pHXTEDKP8anuHhpOCf58DokdO1irZQsPA6th2Ylgtws0gOAUgvXXs7G1lBtOQ7EE0LX36WBbpdRRicwcRlqZDdsvqw8fZweJ4eewKjC6w8CxlX6EMCAVyM7V4qQvi3BuyqrVdOHYdjq8raPmnwSWSFxEnioUjwvZ8eGyezk4AoWdFJWtpSMq9a6ZGgW6J2A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?djN0SG9uZVc5Y2xTQ1o2SzNkRzlnR2ZnZm1QZmxNTWlFQldZKzUycGRmd05a?=
 =?utf-8?B?T0ZNazU0ZmxmSS90WWN0c0svd2NHTDFzUUhKR25VME5BSEdXclJDT0xlNW9D?=
 =?utf-8?B?ZGdtV2pTTGZVTGYxWEZ2K1VlaEV6c1g4OUcrcTNIUWZYcXhlYVdhQzZTY0Y2?=
 =?utf-8?B?TjN1RHFmWjllY2RPR2dtcUYzT3AwZGNWQkN3SG5IVnI4MGY4eGp3RkF4OEtH?=
 =?utf-8?B?M1lXZldhUGVtWlVZSWFSUFUreWRBZlZFNVJOWi92L1kvTWtnaCtBTTkyc1N5?=
 =?utf-8?B?M2doRG1obzVVRGwzazNRNlBRS1hCNS90aUN3Zk8zaDlTZlVQMlJhWjVJQndS?=
 =?utf-8?B?OXc2QWxjS3YvSzRzSTNsOEM5VkpFVzVMT2JpL2UrckhTUnBxazIxVXBhMGJ4?=
 =?utf-8?B?d0hoTk1QVWhpWkhEelZQaEF0L2xJMHVIUTR2dUR4NEJjMlkyaFlyZk9CU2wz?=
 =?utf-8?B?cDZ4T2d4Um9YYVJDR2FqelNWaC9EUDdXUXBraDBYWTlLWmx5ZkJWYm5nUUxX?=
 =?utf-8?B?em9Ld1RZaDkxRVBRZGZRbHUxcFU2NTdzR3RNU3RNZ1pTblR2Q0IyNXg2OWhj?=
 =?utf-8?B?SU5XNVhpQ29kSWExaURZckpSdTNRbDgvVG9LbHRhR29GdThEYkZmNlpMbGpx?=
 =?utf-8?B?ZVFjeTVPMVFBMmRRd0g1NXV3T0lEK29VcXMzYmNNcHMvOCtwNnAxR29OOVNr?=
 =?utf-8?B?eHl4WWZySU00akpQVnJFaXA0cXpzd3hFQVFUbHQzUDhHRkhBaWVWVmpQVTFV?=
 =?utf-8?B?ZHJkY21iL0pKVGZuVXZvNURDY1gwb0hrZ1JqQkNvSG5WQ3o2RVZzU0U4OGc1?=
 =?utf-8?B?K29Eb3VBaWJSQUs3OE1mYmpVTHpLSTlyVWN0RmlpcjdyZ2t4NzlGdVpsUmtF?=
 =?utf-8?B?OGtoeWhJSlg2L0pVMWNYeWJHVlFVdlppRllOdUZkR0xQcHk4WFhLSzVpMzNt?=
 =?utf-8?B?VVJQSUpzTjlsYTF0KzhZTVowbWxad05KWFFJRkRGZk92THE2YUVpSDM2NUFH?=
 =?utf-8?B?SmVCQmpZUmlOYStYWkxJaFBHdWxzWkFpb0dhWXJMTVlvNjZFV0ZsM0hDR2lB?=
 =?utf-8?B?WGNyQkJMaExxSTJMWmJXa0hLNGVLaFhoV1Z0ajdQb3M3NnBncjM0OFBVbDln?=
 =?utf-8?B?VmN2dklLWGlKVnlXeWErSGpOK1gvaE1Yb2Fxc0FCT1hJMHlUMFk3V3NSL082?=
 =?utf-8?B?dEhrRDd4K3BaMGc5MnlLUVgvRHNHSm4rYmJQaUZLblpMc2NzSVdiY1crR2dx?=
 =?utf-8?B?OXhNYTl3cHU4aXdjdWtka3hKWTB3Q1g5dFdlNHBxVXpKcVhXZVBLK3VneVpC?=
 =?utf-8?B?VUFFRExoRkgrZHFTbFVZOTVTcCt5RlZNMW41RmRCS3M5UERMU0FwK2phb3cx?=
 =?utf-8?B?R2xqbUhNWS9HcjVWdklQVzMrdXZjVGcxdm5rclFzelozRmtHdzlSZ1F0cE5k?=
 =?utf-8?B?Q3hsR2pZWndKU2NoQUxMYmhpWHJxTGVaMkRuZ3c4emlhR1dibHNNa2lCc3hx?=
 =?utf-8?B?U3RpKzNVL1kwOTk0Wmg0ZXJoUjArSGtlVVpPSHUxWm16dFB0SmxHbUZ4Q2s3?=
 =?utf-8?B?Tll1SEl0TnNFakVRUW9CU0xNWVBwWUd1eDcwTnF4U0hNNjZ6S0FWRWRTWnRP?=
 =?utf-8?B?UWZkUjRka0psNzJVZXRkemRqV1F1THBFN291S2E1TXJhcnNFVHIxR1Uvc3NG?=
 =?utf-8?B?SlVMR3NqR3VmWGtSZFVVbHFITkE4NU83WW1icjRLNXhleGZPN3QvZFpuUWZX?=
 =?utf-8?B?aEpYMVEyQVR6ejRsQ3RSZXR6eTlaNEhHVllkczhvZ2RMczBQNHc1L2lIeHR2?=
 =?utf-8?B?cWoyRzU0VzVOU3BtQytMajRJeWlrOXp1dExHai9VOVJYQXh3TE0rMkdFZjB3?=
 =?utf-8?B?VkpJT1ZyVHExTDhLbTRhRE1LbU9OZnUzNENRQzVmaE9YekxhWUJ0eTBpYkpo?=
 =?utf-8?B?YkJoZ0VxanVlcVg5dUJ3RllRTUpxejVHNjljZXlFUWZndndRd0M1MUdPaDNw?=
 =?utf-8?B?VWNOdkJtOW9JMS9MalZKSnp6V3pnZ1dONUtIK2ZIVTM4L013cjRxM2x1eFdC?=
 =?utf-8?B?OFlrMU5lcUFQSmltck9ESTFWUHo5cGt0OC8yQUQwMnZYSHVlNjF4UDNvRThM?=
 =?utf-8?B?KzMyK29rbUN0cmpoV3NMY0svNHJWK0JjZjVPVkVxRlRON294NTBFazArSFlr?=
 =?utf-8?B?RlEyR2w2c3FxalFPM0RYZkx2QmhTalFldi9OV1dHamtYNGdObkNYM3dMRVFI?=
 =?utf-8?B?MGtISjl0Zjh0THA0YmR0YlcxTWZyMm42Y2Zhdlk1aDlTd0dCL21lQVM5WlE0?=
 =?utf-8?Q?poLyK7WZECiJRMOhp9?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3652dfc8-ba27-47c2-6b84-08dec2326b07
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 12:11:33.2588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oXcN2a9jXC9cTZSZlfXV7OOIcYZfD5XKkj2rrG9Vy4edIVakNXna2Fh1uba/kYMWdnb5h0vDINunLGX0xoD75g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8494
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11164-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:Devendra.Verma@amd.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,amd.com:dkim,amd.com:from_mime,amd.com:email,sashiko.dev:url,BL4PR12MB9482.namprd12.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E67BE63FCE2

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBzYXNo
aWtvLWJvdEBrZXJuZWwub3JnIDxzYXNoaWtvLWJvdEBrZXJuZWwub3JnPg0KPiBTZW50OiBXZWRu
ZXNkYXksIEp1bmUgMywgMjAyNiAyMDoyOA0KPiBUbzogVmVybWEsIERldmVuZHJhIDxEZXZlbmRy
YS5WZXJtYUBhbWQuY29tPg0KPiBDYzogdmtvdWxAa2VybmVsLm9yZzsgRnJhbmsuTGlAa2VybmVs
Lm9yZzsgZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYz
XSBkbWFlbmdpbmU6IGR3LWVkbWE6IEVuYWJsZSBIRE1BIDY0Ui9XDQo+IENoYW5uZWxzDQo+DQo+
IFRoYW5rIHlvdSBmb3IgeW91ciBjb250cmlidXRpb24hIFNhc2hpa28gQUkgcmV2aWV3IGZvdW5k
IDMgcG90ZW50aWFsIGlzc3VlKHMpDQo+IHRvIGNvbnNpZGVyOg0KPg0KPiBOZXcgaXNzdWVzOg0K
PiAtIFtIaWdoXSBUaGUgNjQtY2hhbm5lbCBIRE1BIGZlYXR1cmUgaXMgdW5yZWFjaGFibGUgYmVj
YXVzZSBwbGF0Zm9ybSBnbHVlDQo+IGRyaXZlcnMgc3RpbGwgZW5mb3JjZSBsZWdhY3kgOC1jaGFu
bmVsIGhhcmRjb2RlZCBsaW1pdHMuDQo+DQoNClRoaXMgY2FuIGJlIHRha2VuIHVwIGluIGEgc2Vw
YXJhdGUgcGF0Y2ggYnV0IHRoZXJlIGlzIG5vIGdsdWUgZHJpdmVyIGF0IHRoZQ0KbW9tZW50IHRo
YXQgdXNlcyA2NCBjaGFubmVscy4NCg0KPiBQcmUtZXhpc3RpbmcgaXNzdWVzOg0KPiAtIFtIaWdo
XSBUaGUgZURNQSBzdWJzeXN0ZW0gaXMgZGVyZWdpc3RlcmVkIEFGVEVSIHRoZSBoYXJkd2FyZSBj
b3JlIGlzDQo+IGRpc2FibGVkIGFuZCBJUlFzIGFyZSBmcmVlZCwgdmlvbGF0aW5nIHRlYXItZG93
biBzeW1tZXRyeS4NCj4gLSBbSGlnaF0gVGhlIHZpcnQtZG1hIGRlc2NyaXB0b3JzIGFyZSBuZXZl
ciBmcmVlZCB3aGVuIGEgY2hhbm5lbCBpcyByZWxlYXNlZCwNCj4gbGVhZGluZyB0byBhIHBlcm1h
bmVudCBtZW1vcnkgbGVhay4NCg0KVGhlc2UgaXNzdWVzIGFsc28gY2FuIGJlIHRha2VuIHVwIGlu
IGEgc2VwYXJhdGUgcGF0Y2ggc2VyaWVzLg0KDQo+IC0tDQo+DQo+IGNvbW1pdCAyMGJhMzk1YmVk
ZTcwMTRjMThiODE4MDRhNWY2YTk0MWYzYTk1ZWJkDQo+IEF1dGhvcjogRGV2ZW5kcmEgSyBWZXJt
YSA8ZGV2ZW5kcmEudmVybWFAYW1kLmNvbT4NCj4NCj4gZG1hZW5naW5lOiBkdy1lZG1hOiBFbmFi
bGUgSERNQSA2NFIvVyBDaGFubmVscw0KPg0KPiBBcyBwZXIgJ0Rlc2lnbndhcmUgQ29yZXMgUENJ
IEV4cHJlc3MgQ29udHJvbGxlciBEYXRhYm9vaycsIFNlY3Rpb24gNy4xIC0NCj4gT3ZlcnZpZXcs
IEhETUEgc3VwcG9ydHMgNjQgUmVhZCBhbmQgNjQgV3JpdGUgY2hhbm5lbHMuIEN1cnJlbnQgY29u
dHJvbGxlcg0KPiBkcml2ZXIgc3VwcG9ydHMgdXAgdG8gOCByZWFkIGFuZCB3cml0ZSBjaGFubmVs
cyBvbmx5LiBJbiBvcmRlciB0byB1dGlsaXplIGFsbCB0aGUNCj4gY2hhbm5lbHMgdGhlIGNvbnRy
b2xsZXIgZHJpdmVyIG5lZWQgdG8gaGF2ZSB0aGUgY2hhbm5lbCByZWxhdGVkIHN0cnVjdHMgYW5k
DQo+IHZhcmlhYmxlcyBhcyBwZXIgdGhlIG51bWJlciBvZiBjaGFubmVscyBzdXBwb3J0ZWQgYnkg
SVAuDQo+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL2R3LWVkbWEvZHctZWRtYS1jb3Jl
LmMNCj4gPiBiL2RyaXZlcnMvZG1hL2R3LWVkbWEvZHctZWRtYS1jb3JlLmMNCj4gPiBpbmRleCBj
MmZlYjNhZGM3OWZhLi5hZGYxYjM5MzlmOTZjIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZG1h
L2R3LWVkbWEvZHctZWRtYS1jb3JlLmMNCj4gPiArKysgYi9kcml2ZXJzL2RtYS9kdy1lZG1hL2R3
LWVkbWEtY29yZS5jDQo+DQo+IFsgLi4uIF0NCj4NCj4gPiBAQCAtMTA3OSw2ICsxMDc5LDggQEAg
aW50IGR3X2VkbWFfcHJvYmUoc3RydWN0IGR3X2VkbWFfY2hpcCAqY2hpcCkNCj4gPiAgICAgc3Ry
dWN0IGR3X2VkbWEgKmR3Ow0KPiA+ICAgICB1MzIgd3JfYWxsb2MgPSAwOw0KPiA+ICAgICB1MzIg
cmRfYWxsb2MgPSAwOw0KPiA+ICsgICB1MTYgbWF4X3dyX2NudDsNCj4gPiArICAgdTE2IG1heF9y
ZF9jbnQ7DQo+ID4gICAgIGludCBpLCBlcnI7DQo+ID4NCj4gPiAgICAgaWYgKCFjaGlwKQ0KPiA+
IEBAIC0xMDk0LDIwICsxMDk2LDI1IEBAIGludCBkd19lZG1hX3Byb2JlKHN0cnVjdCBkd19lZG1h
X2NoaXANCj4gKmNoaXApDQo+ID4NCj4gPiAgICAgZHctPmNoaXAgPSBjaGlwOw0KPiA+DQo+ID4g
LSAgIGlmIChkdy0+Y2hpcC0+bWYgPT0gRURNQV9NRl9IRE1BX05BVElWRSkNCj4gPiArICAgaWYg
KGR3LT5jaGlwLT5tZiA9PSBFRE1BX01GX0hETUFfTkFUSVZFKSB7DQo+ID4gICAgICAgICAgICAg
ZHdfaGRtYV92MF9jb3JlX3JlZ2lzdGVyKGR3KTsNCj4gPiAtICAgZWxzZQ0KPiA+ICsgICAgICAg
ICAgIG1heF93cl9jbnQgPSBIRE1BX01BWF9XUl9DSDsNCj4gPiArICAgICAgICAgICBtYXhfcmRf
Y250ID0gSERNQV9NQVhfUkRfQ0g7DQo+ID4gKyAgIH0gZWxzZSB7DQo+ID4gICAgICAgICAgICAg
ZHdfZWRtYV92MF9jb3JlX3JlZ2lzdGVyKGR3KTsNCj4gPiArICAgICAgICAgICBtYXhfd3JfY250
ID0gRURNQV9NQVhfV1JfQ0g7DQo+ID4gKyAgICAgICAgICAgbWF4X3JkX2NudCA9IEVETUFfTUFY
X1JEX0NIOw0KPiA+ICsgICB9DQo+ID4NCj4gPiAgICAgcmF3X3NwaW5fbG9ja19pbml0KCZkdy0+
bG9jayk7DQo+ID4NCj4gPiAgICAgZHctPndyX2NoX2NudCA9IG1pbl90KHUxNiwgY2hpcC0+bGxf
d3JfY250LA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgZHdfZWRtYV9jb3JlX2NoX2Nv
dW50KGR3LA0KPiBFRE1BX0RJUl9XUklURSkpOw0KPiA+IC0gICBkdy0+d3JfY2hfY250ID0gbWlu
X3QodTE2LCBkdy0+d3JfY2hfY250LCBFRE1BX01BWF9XUl9DSCk7DQo+ID4gKyAgIGR3LT53cl9j
aF9jbnQgPSBtaW5fdCh1MTYsIGR3LT53cl9jaF9jbnQsIG1heF93cl9jbnQpOw0KPiA+DQo+ID4g
ICAgIGR3LT5yZF9jaF9jbnQgPSBtaW5fdCh1MTYsIGNoaXAtPmxsX3JkX2NudCwNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGR3X2VkbWFfY29yZV9jaF9jb3VudChkdywgRURNQV9ESVJf
UkVBRCkpOw0KPiA+IC0gICBkdy0+cmRfY2hfY250ID0gbWluX3QodTE2LCBkdy0+cmRfY2hfY250
LCBFRE1BX01BWF9SRF9DSCk7DQo+ID4gKyAgIGR3LT5yZF9jaF9jbnQgPSBtaW5fdCh1MTYsIGR3
LT5yZF9jaF9jbnQsIG1heF9yZF9jbnQpOw0KPiA+DQo+ID4gICAgIGlmICghZHctPndyX2NoX2Nu
dCAmJiAhZHctPnJkX2NoX2NudCkNCj4gPiAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4N
Cj4gW1NldmVyaXR5OiBIaWdoXQ0KPiBUaGlzIHBhdGNoIGV4cGFuZHMgdGhlIGVETUEgY29yZSBz
dHJ1Y3R1cmVzIHRvIHN1cHBvcnQgdXAgdG8gNjQgSERNQQ0KPiBjaGFubmVscy4NCj4gSG93ZXZl
ciwgZG9lcyBpdCBtaXNzIHVwZGF0aW5nIHRoZSBQQ0llIGluc3RhbnRpYXRpb24gd3JhcHBlcnMs
IHJlbmRlcmluZyB0aGUNCj4gZmVhdHVyZSB1bnVzYWJsZT8NCj4NCj4gSW4gZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmMsDQo+IGR3X3BjaWVfZWRtYV9maW5kX2No
YW5uZWxzKCkgcGVyZm9ybXMgYSBzYW5pdHkgY2hlY2sgdGhhdCBleHBsaWNpdGx5IHJlamVjdHMN
Cj4gYW55IGNvbmZpZ3VyYXRpb24gZXhjZWVkaW5nIEVETUFfTUFYX1dSX0NIICg4KSwgcmV0dXJu
aW5nIC1FSU5WQUw6DQo+DQo+ICAgICAgIGlmICghcGNpLT5lZG1hLmxsX3dyX2NudCB8fCBwY2kt
PmVkbWEubGxfd3JfY250ID4NCj4gRURNQV9NQVhfV1JfQ0ggfHwNCj4gICAgICAgICAgICFwY2kt
PmVkbWEubGxfcmRfY250IHx8IHBjaS0+ZWRtYS5sbF9yZF9jbnQgPiBFRE1BX01BWF9SRF9DSCkN
Cj4gICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4NCj4gU2ltaWxhcmx5LCBkd19wY2ll
X2VkbWFfaXJxX3ZlY3RvcigpIGxpbWl0cyBJUlEgaW5kaWNlcyB0byAxNg0KPiAoRURNQV9NQVhf
V1JfQ0ggKyBFRE1BX01BWF9SRF9DSCkuDQo+DQo+IEZ1cnRoZXJtb3JlLCBpbiBkcml2ZXJzL2Rt
YS9kdy1lZG1hL2R3LWVkbWEtcGNpZS5jLCB0aGUgZnVuY3Rpb25zDQo+IGR3X2VkbWFfcGNpZV9n
ZXRfc3lub3BzeXNfZG1hX2RhdGEoKSBhbmQNCj4gZHdfZWRtYV9wY2llX2dldF94aWxpbnhfZG1h
X2RhdGEoKQ0KPiB1c2UgbWluX3QgdG8gYm91bmQgdGhlIGhhcmR3YXJlLXJlcG9ydGVkIGNoYW5u
ZWwgY291bnQgYWdhaW5zdA0KPiBwZGF0YS0+d3JfY2hfY250ICh3aGljaCBpcyBzdGF0aWNhbGx5
IGluaXRpYWxpemVkIHRvIDIgb3IgOCk6DQo+DQo+ICAgICAgIHBkYXRhLT53cl9jaF9jbnQgPSBt
aW5fdCh1MTYsIHBkYXRhLT53cl9jaF9jbnQsDQo+DQo+IEZJRUxEX0dFVChEV19QQ0lFX1NZTk9Q
U1lTX1ZTRUNfRE1BX1dSX0NILCB2YWwpKTsNCj4NCj4gV2lsbCBhbnkgYXR0ZW1wdCB0byBjb25m
aWd1cmUgYW4gSERNQSBkZXZpY2Ugd2l0aCA+OCBjaGFubmVscyBiZSBzaWxlbnRseQ0KPiB0cnVu
Y2F0ZWQgdG8gOCBvciBmYWlsIHRvIHByb2JlIGNvbXBsZXRlbHk/DQo+DQo+DQo+IFtTZXZlcml0
eTogSGlnaF0NCj4gVGhpcyBpcyBhIHByZS1leGlzdGluZyBpc3N1ZSwgYnV0IGxvb2tpbmcgYXQg
ZHdfZWRtYV9yZW1vdmUoKSwgdGhlIGVETUENCj4gc3Vic3lzdGVtIGlzIGRlcmVnaXN0ZXJlZCBh
ZnRlciB0aGUgaGFyZHdhcmUgY29yZSBpcyBkaXNhYmxlZCBhbmQgSVJRcyBhcmUNCj4gZnJlZWQu
IERvZXMgdGhpcyB2aW9sYXRlIHRlYXItZG93biBzeW1tZXRyeT8NCj4NCj4gSW4gZHdfZWRtYV9y
ZW1vdmUoKSwgdGhlIGRyaXZlciBmaXJzdCBjYWxscyBkd19lZG1hX2NvcmVfb2ZmKGR3KSB0bw0K
PiBkaXNhYmxlIHRoZSBoYXJkd2FyZSwgYW5kIHRoZW4gZnJlZXMgYWxsIElSUXMgdXNpbmcgZnJl
ZV9pcnEoKS4gT25seSBhZnRlciB0aGF0DQo+IGRvZXMgaXQgY2FsbCBkbWFfYXN5bmNfZGV2aWNl
X3VucmVnaXN0ZXIoJmR3LT5kbWEpIGFuZCBraWxsIHRoZSB2aXJ0LWRtYQ0KPiB0YXNrbGV0czoN
Cj4NCj4gICAgICAgLyogRGlzYWJsZSBlRE1BICovDQo+ICAgICAgIGR3X2VkbWFfY29yZV9vZmYo
ZHcpOw0KPg0KPiAgICAgICAvKiBGcmVlIGlycXMgKi8NCj4gICAgICAgZm9yIChpID0gKGR3LT5u
cl9pcnFzIC0gMSk7IGkgPj0gMDsgaS0tKQ0KPiAgICAgICAgICAgICAgIGZyZWVfaXJxKGNoaXAt
Pm9wcy0+aXJxX3ZlY3RvcihkZXYsIGkpLCAmZHctPmlycVtpXSk7DQo+ICAgICAgIGR3X2VkbWFf
ZW11bF9pcnFfZnJlZShkdyk7DQo+DQo+ICAgICAgIC8qIERlcmVnaXN0ZXIgZURNQSBkZXZpY2Ug
Ki8NCj4gICAgICAgZG1hX2FzeW5jX2RldmljZV91bnJlZ2lzdGVyKCZkdy0+ZG1hKTsNCj4NCj4g
SWYgYSBjbGllbnQgc3RpbGwgaG9sZHMgYSByZWZlcmVuY2UgYW5kIGhhcyBhbiBhY3RpdmUgRE1B
IHRyYW5zZmVyIG9yIHN1Ym1pdHMgYQ0KPiBuZXcgb25lIHdoaWxlIHRoZSBkZXZpY2UgaXMgYmVp
bmcgcmVtb3ZlZCwgdGhlIHRyYW5zZmVyIGNhbm5vdCBjb21wbGV0ZQ0KPiBiZWNhdXNlIHRoZSBo
YXJkd2FyZSBpcyBkaXNhYmxlZCBhbmQgaW50ZXJydXB0cyBhcmUgZnJlZWQuIENhbiB0aGlzIGxl
YWQgdG8gYQ0KPiBodW5nIHRhc2sgb3IgYSBETUEgdGltZW91dD8NCj4NCj4NCj4gW1NldmVyaXR5
OiBIaWdoXQ0KPiBUaGlzIGlzIGEgcHJlLWV4aXN0aW5nIGlzc3VlLCBidXQgZG9lcyB0aGUgZHJp
dmVyIGxlYWsgdmlydC1kbWEgZGVzY3JpcHRvcnMNCj4gcGVybWFuZW50bHkgd2hlbiBhIGNoYW5u
ZWwgaXMgcmVsZWFzZWQ/DQo+DQo+IFRoZSB2aXJ0LWRtYSBmcmFtZXdvcmsgcmVxdWlyZXMgZHJp
dmVycyB0byBjYWxsIHZjaGFuX2ZyZWVfY2hhbl9yZXNvdXJjZXMoKQ0KPiBmcm9tIHRoZWlyIC5k
ZXZpY2VfZnJlZV9jaGFuX3Jlc291cmNlcyBjYWxsYmFjayB0byBmcmVlIGFsbCBwZW5kaW5nLA0K
PiBzdWJtaXR0ZWQsIGFuZCBhbGxvY2F0ZWQgZGVzY3JpcHRvcnMuIFRoZSBkd19lZG1hX2ZyZWVf
Y2hhbl9yZXNvdXJjZXMoKQ0KPiBmdW5jdGlvbiB3YWl0cyBmb3IgdGhlIGNoYW5uZWwgdG8gc3Rv
cCBidXQgZmFpbHMgdG8gY2FsbA0KPiB2Y2hhbl9mcmVlX2NoYW5fcmVzb3VyY2VzKCZjaGFuLT52
YykNCj4gb3IgbWFudWFsbHkgZnJlZSB0aGUgZGVzY3JpcHRvcnM6DQo+DQo+IHN0YXRpYyB2b2lk
IGR3X2VkbWFfZnJlZV9jaGFuX3Jlc291cmNlcyhzdHJ1Y3QgZG1hX2NoYW4gKmRjaGFuKSB7DQo+
ICAgICAgIHVuc2lnbmVkIGxvbmcgdGltZW91dCA9IGppZmZpZXMgKyBtc2Vjc190b19qaWZmaWVz
KDUwMDApOw0KPiAgICAgICBpbnQgcmV0Ow0KPg0KPiAgICAgICB3aGlsZSAodGltZV9iZWZvcmUo
amlmZmllcywgdGltZW91dCkpIHsNCj4gICAgICAgICAgICAgICByZXQgPSBkd19lZG1hX2Rldmlj
ZV90ZXJtaW5hdGVfYWxsKGRjaGFuKTsNCj4gICAgICAgICAgICAgICAuLi4NCj4gICAgICAgfQ0K
PiB9DQo+DQo+IEFzIGEgcmVzdWx0LCBldmVyeSB0aW1lIGEgY2xpZW50IGFsbG9jYXRlcyBkZXNj
cmlwdG9ycyBhbmQgdGhlbiByZWxlYXNlcyB0aGUNCj4gY2hhbm5lbCwgYXJlIGFsbCB0aG9zZSBk
ZXNjcmlwdG9ycyBwZXJtYW5lbnRseSBsZWFrZWQ/DQo+DQo+IC0tDQo+IFNhc2hpa28gQUkgcmV2
aWV3IMK3IGh0dHBzOi8vc2FzaGlrby5kZXYvIy9wYXRjaHNldC8yMDI2MDYwMzE0NDE0Ny4zMjQ5
NjkxLQ0KPiAxLWRldmVuZHJhLnZlcm1hQGFtZC5jb20/cGFydD0xDQo=

