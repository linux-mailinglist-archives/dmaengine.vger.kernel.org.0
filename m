Return-Path: <dmaengine+bounces-9813-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qM8jBUxnzWnddAYAu9opvQ
	(envelope-from <dmaengine+bounces-9813-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Apr 2026 20:43:24 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5876837F603
	for <lists+dmaengine@lfdr.de>; Wed, 01 Apr 2026 20:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE8CA30151F5
	for <lists+dmaengine@lfdr.de>; Wed,  1 Apr 2026 18:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6170F3CE48F;
	Wed,  1 Apr 2026 18:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bmZL1n6s"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011004.outbound.protection.outlook.com [52.101.52.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8A2201113;
	Wed,  1 Apr 2026 18:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775068667; cv=fail; b=AXxOa5t7DqsPkbP1G/4O984e/dItlss2I6ljEEiCbHN23+vzqH3zCyn4mKK8jiSxsbfssnKStGe0uQmwpjOZnRCAr+3he9DLGHG1Ynv7lfIYcV9Xj8UbikjJbb569Gs/rmXgflRC1xBPnqrzov6t81bsm0PNuiDd+PC5gDcjS44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775068667; c=relaxed/simple;
	bh=Uy/O4RYjhiaR6BMElrHZNci69jQvjPgXiJySep1Tw/4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pg9hrXVG2DRrjyUAn6k3r3OPTY6vkzcHRxRYSCoKjaTxF2x3H3Ck9pqHxHdi9rmSSFph41FFTfYTZ+LfbclZFjz0+2gfZeHqsbJ7zPMIKN/rK1dONU4x7MwMKaeFM05YfDH4MUfbufr6c7shr5wfb0wFAkwHGblM2t74t1KWJCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bmZL1n6s; arc=fail smtp.client-ip=52.101.52.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ev42+KgAhrrnBpAVp9Kg6GEZCNjqI5HUL8Kn1wzMPZS4OHkciyJ2xZA2hZ9RmdczNN5dyzIe2GK91jFGU065mCKt+nv6fzhpmu9W/JQZkYQ03CjEo6Tv6+9Sib72kcNMiPG4mA/afHuSUO6q96OC1993wTyUTqJdFYprtfYyUrPpOagL40wv/DHCR3m6NBdAPBVOSxYCHBOi0fFPh1CBhz91I6IRe97l1Frci4kSOoczfhy5yZ5S6c6/b7OZ37EEKrrANvcqOroDfkoMPGukPSCJjhuJk9nhmdL61V94bE8Dk0Ad5cxZTGiYtl8ub35z51h9QHd3w+vBq65zzLwQ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uy/O4RYjhiaR6BMElrHZNci69jQvjPgXiJySep1Tw/4=;
 b=gTZbepV/QavArpxTPlTKwmcdavTBbk3O5lVmvbMOCpHGevSYVFRizA0KcZblHjOdvq5/2YS8UeG97gAfko57SWnmD3avQ0SSPTK0Z0QaT9xdQD9fI7znt/oh3BYsxv/42o+TZ4/+EVm8xmTaUhqSQwH5/GKisKckCldpxPMQafEqc3QfuZFfQaL8TdpO2HTX9QxQgLI36szCMy+XkUW95wEtTCACefBtveD/yqU2xuVYJeU16BG0giQVMd5mFjpPoKubrNb177YZ7dsZxCBsBhLx6iexnV44f1UWqNauF7PZeymieZhpomqkjTMV2CoBbIZmpcDj7FH5xgwgpkuX6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uy/O4RYjhiaR6BMElrHZNci69jQvjPgXiJySep1Tw/4=;
 b=bmZL1n6s6tzNn6wMOs2CbyVJsgmhl2QGE2YJFt0WVco+U3CPYpEl70+mmsqKIbFDpmt8LmNs2CReqfXXNkVMZe307+jxZBStOcYQOU45SViOkNAp6qDffc9MLyxdNJEC8y1DLs7a6clIsnYxibrtUL8/mdokyVwOxY/8snfnQ4c=
Received: from SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22)
 by PH7PR12MB8122.namprd12.prod.outlook.com (2603:10b6:510:2b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 18:37:42 +0000
Received: from SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54]) by SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54%4]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 18:37:41 +0000
From: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
To: Alex Bereza <alex@bereza.email>, Vinod Koul <vkoul@kernel.org>, Frank Li
	<Frank.Li@kernel.org>, "Simek, Michal" <michal.simek@amd.com>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Ulf Hansson <ulf.hansson@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, "Rao, Appana
 Durga Kedareswara" <appana.durga.kedareswara.rao@amd.com>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 0/2] Fix CPU stall in xilinx_dma_poll_timeout caused by
 passing delay_us=0
Thread-Topic: [PATCH v3 0/2] Fix CPU stall in xilinx_dma_poll_timeout caused
 by passing delay_us=0
Thread-Index: AQHcwciSIc8BFSD3pUi015Ucs2lixbXKiJLQ
Date: Wed, 1 Apr 2026 18:37:41 +0000
Message-ID:
 <SA1PR12MB67988A9CB5224DB398AF367EC950A@SA1PR12MB6798.namprd12.prod.outlook.com>
References:
 <20260401-fix-atomic-poll-timeout-regression-v3-0-85508f0aedde@bereza.email>
In-Reply-To:
 <20260401-fix-atomic-poll-timeout-regression-v3-0-85508f0aedde@bereza.email>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-01T18:33:43.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB6798:EE_|PH7PR12MB8122:EE_
x-ms-office365-filtering-correlation-id: d18443d3-28b6-4207-3f8f-08de901dc226
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 n0ufoPjsrKT+FFjQYNFeBcXn5sz76JyCtHvef7F4uu/VLaNZWoIuH9Clz/Oea3uZ6/6FD1xd7W9H5JB8lTq2xpNcehtA0rBQU66YCdjHYMtgqMHJ5rXAiHHuCMwsoQujqSnmVM9Sd4XSAEUsU1xUDgjjL7+fQVPY9uwpELb5r8bnI/ZicoAn+FXvLqBaCT5VKDHVlDMOnY3dss+jkRCkZO3/sZ4vHua950w5bjiViM6+iNyAlnzWg5qgfi6Azk+zFvuFDzGmydRtIQFrGI6uMYVgNh6TWgFKYBgqsVxUNMvqKv6ppzaBoK/vnI8sRn0GhqfM0rsKsibf6zC5tiorczYv6pTBGyr4+KCXlRyKufAzz5wAXDD2gaXezj7rDswkYgQV11WW5xT/9/UaHoGb6fXMxNvAx0bWSPixRuaRtXBqJZ+HPzM56CszcyTmTnHXElrtXAqWw3JTXvoavBG/zd6PsDIOESckFAwOqbfs2mW6G1JqYjEnb01LZVfJNQmOl2M8HGvUq+HlCE0Pap4w1NEwFX3cDzLxwaggGBt0pny/tltE3PojOY3GqohDj0clB9Qs4cIPlR3TTx8uWSbRR1qZRDaMIAzvHiOb4kbrieD2abjkx2qH+0WDFZT/TdYlsbQlsHm3FCLzfRRDOf0hRVl5qD5mbdhQlEM2v+pGgOy2HRT3ciucr4JT/kK7q+uvgOgYaVEp4ldMhuHmvDtNQZ/IfQuqQHTvPvRvEb9ABf5fXOzjYA3QxQh2FVqVToB9IX1vhHOy3wlKJlRxeVLI7w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6798.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RzNmcGk5V2JUOW1zbXJQc01jOGtWS3FLREt3UUxBWlFvSUJhNW8rNlNiSmY0?=
 =?utf-8?B?S2NnZ2lTeWd1alBhdXBja2V4d2hrU0xjQjdHVE9HMDcwSlNRR2Yrc0JnWk9R?=
 =?utf-8?B?cklDUU92ZFREaUdtZFNYMm1QaXlOdUJyb3c3UE5rbFNNeW5Dd0dkNi9wZ2F0?=
 =?utf-8?B?dlNJWFkxSTkvTENCek9jRnZYeWZBNDQxd3BKZmlSWS9aNk9EQkZrbFdkVEJ0?=
 =?utf-8?B?YXM0RGdjSTBSMVpPeVRPejhCcDJqQ3JZaVl6MHhMcVRKc1N0Y2FmeUpaQ0Vr?=
 =?utf-8?B?NDZ6TmZERlZsT1N2aTgxR1RJb0xFU3RoR0lra0lLaXFTU1A0dm8zeEtjT2d4?=
 =?utf-8?B?Qko2M25vVXZlY0pheHBOenp6MkhKYW5HODRxVE92ZENPbFVTM3VrbnFtZDJ1?=
 =?utf-8?B?dWd6RHc5Tnh3VUI5RW14eWNwM0c4NzRUVDRBTi9DcmJJRmp6K0xyZ3lUeDI4?=
 =?utf-8?B?SjB1MmV6L01sRnRqY2l3dWwyZmxGMU53ZFoveHYxSzFSNWkveWFwaG1hbnBI?=
 =?utf-8?B?REhDYTlnY1lWNTlCRG1XK1lIbHVXRk8yYjlFbVc5SHdKUmpxYW12Q3hrMm15?=
 =?utf-8?B?b1BNTm5mUzVMMjJZMTJkbjdLWDR2bDM0RzJNMGtRQ0V5a2owd2g0Uk13c29J?=
 =?utf-8?B?Rk1ua1ZsVTh0M29hVGtpQzkwcGJxM01wZG96LzNobUJaekE2b1haTEd3RlFN?=
 =?utf-8?B?bzdyUThUU0JOdDE2NXpnU0FBZDZYZlVzc2lhMDlUblc5ZlpBTHB0RlRnWStD?=
 =?utf-8?B?REEwN2xVUkg1a1dGZ3pPWHgvYk9lN0U0SE9nTEVIY2lTdjE5ak1ZL25DTFo0?=
 =?utf-8?B?WW9oMlBQMHlib3Y4NWpLblErQllyaCtiaXgzNjMyR1pnc3k2RnV0S3hnUUMw?=
 =?utf-8?B?ZEMzd1VxMkd1TXNPMG83MnNPMnJkYVRtSUsvSjZKSXB0RjBiQ3ZwMDhLQzM1?=
 =?utf-8?B?UXVWQ2xIeEgrU0UxUXhHUktXcDg0cWI1aVdsNU44cXdGWk10Yi9FZFVsQ0c3?=
 =?utf-8?B?c3BPZ2dwN3ZYSmtHTFlNNmFtTGZoZmtQanBZUU1oVW94SmVjM2ZaN1pvQzdJ?=
 =?utf-8?B?bGxkbkpWZWs0VU80U1ByM2ZBS1U0ejdpUXhEY3NGeGJ6NzExRHRxL3RYaERv?=
 =?utf-8?B?SjJRTjRaNGVZY3F1dStnNVVpdjcrYzBCZUdaTjN0MzlsZkladEdvSUtQMlp5?=
 =?utf-8?B?V21aTUxXdkFYaGVRaGVnTG51TEkyMVdTUDhLMGZ5SUZRdXFXVHJnYkJZd1Fm?=
 =?utf-8?B?NFJRMHI3dGxWMDFMM1ZmRWFSMXJpSjlMWDluTXVDTkpIalRpYS9oMkNJSXhE?=
 =?utf-8?B?UGZuVU1hYlJ3MTZDcEFKa1JoU3g3NUZod1lvYUVDYnVxMzlGUEhnamFrcmZR?=
 =?utf-8?B?b0JsL3lsYm1FTzN1MDNYVVp4VWwxOGU5cjhvOC9QMnoybDFpb08ybDZ1N2Q0?=
 =?utf-8?B?Q0JucTJkVVFnT0V0R2F6bDZveFNFdk5Qc1l6RWVsV3NsMkxmKzVpdml3dGJl?=
 =?utf-8?B?T1VGTHErWjAwVjhxUmJoZjc4TkdGbG4wV3Y2b2J6ZHlIL3kzbURYZXJqNFBz?=
 =?utf-8?B?UFRPTmtlN1NvU1hTQ0N6VDdQU0w2WC9LNVJlaER4L3kxT05oTDV3T3dGdHlM?=
 =?utf-8?B?ZlNwTVlOMGwwdzh4S3hkUUoxTzBZc3B2N2xnL2xnUVlUK2diWWhTeVdROFFQ?=
 =?utf-8?B?MDZKQ2YwZG9LN2ZQTDBIbW5FTlBDdlhUNGZUL3grVWVVaGZFcWtZbGdqcDk5?=
 =?utf-8?B?OEFWdExQaHczUzRPakc2WGpQRmV3MlQwcUpSdXZxSk5kNEFFQmR3YjNXNHpw?=
 =?utf-8?B?Y3pyd0lpemFjTkxRVDY5WTgxZmxjdDBNcTR6Q3hvSE1TQ2pNa3VBNXl1Z09W?=
 =?utf-8?B?dUh2OWhXR1RLdUxxSG1yeVZTK0Vmb2pOdFpFTlJXemZNUjZ3bUFzQlVVWEww?=
 =?utf-8?B?elhVNjJuN29TV0M4K2o3UjNlR3BGZVhMQkg3cXp6MDZraWxhUlljeEtJSi9F?=
 =?utf-8?B?Ym5hUUFoT085NzZPMXhYZ2E2ZmhNWG9jOXpkVFNSWXFsNmtDUGtxdTR5eGR0?=
 =?utf-8?B?L0ZKM0Rvb1ZZVEgvazRTNDMwaDQxZXozaGJXbUhsM2tmaVJEOEZ0WWp1ZHlM?=
 =?utf-8?B?VER6bm9UaXVTeGFNWEVRUVhSaEFONDBNc2V0ZWNTZmNBalZ0YlhJeWZEbGtk?=
 =?utf-8?B?ZXVyTVJkSVM5aGpMK0pmYkk3MzMxRFBjREFUMFYxYTJubWZ2a3hwYTVmZTB3?=
 =?utf-8?B?WGNQQWlEbEl1UDJ3dHRZN0hqcUFuaU8yeCtabmIyYmFJSUZaeVU4alVpM1pq?=
 =?utf-8?Q?c5EamGAY3MQlJDj8Zl?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d18443d3-28b6-4207-3f8f-08de901dc226
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 18:37:41.8837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7YPT7fIMw3AjkiFFNGFP2HzlJoYoAbm6YJa3ExT8WKfbyae0sj5Ddwq7gQ1TxgzB5ib9Oj+CKlyVrQaDvnhywg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8122
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9813-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[Suraj.Gupta2@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	REDIRECTOR_URL(0.00)[aka.ms];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5876837F603
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4IEJlcmV6YSA8YWxl
eEBiZXJlemEuZW1haWw+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXByaWwgMSwgMjAyNiA0OjI3IFBN
DQo+IFRvOiBWaW5vZCBLb3VsIDx2a291bEBrZXJuZWwub3JnPjsgRnJhbmsgTGkgPEZyYW5rLkxp
QGtlcm5lbC5vcmc+OyBTaW1laywNCj4gTWljaGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47IEdl
ZXJ0IFV5dHRlcmhvZXZlbg0KPiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+OyBVbGYgSGFuc3Nv
biA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz47IEFybmQNCj4gQmVyZ21hbm4gPGFybmRAYXJuZGIu
ZGU+OyBUb255IExpbmRncmVuIDx0b255QGF0b21pZGUuY29tPjsgUmFvLA0KPiBBcHBhbmEgRHVy
Z2EgS2VkYXJlc3dhcmEgPGFwcGFuYS5kdXJnYS5rZWRhcmVzd2FyYS5yYW9AYW1kLmNvbT4NCj4g
Q2M6IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEFsZXggQmVyZXph
IDxhbGV4QGJlcmV6YS5lbWFpbD4NCj4gU3ViamVjdDogW1BBVENIIHYzIDAvMl0gRml4IENQVSBz
dGFsbCBpbiB4aWxpbnhfZG1hX3BvbGxfdGltZW91dCBjYXVzZWQgYnkNCj4gcGFzc2luZyBkZWxh
eV91cz0wDQo+DQo+IFtZb3UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20gYWxleEBiZXJlemEu
ZW1haWwuIExlYXJuIHdoeSB0aGlzIGlzIGltcG9ydGFudA0KPiBhdCBodHRwczovL2FrYS5tcy9M
ZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0KPg0KPiBDYXV0aW9uOiBUaGlzIG1lc3Nh
Z2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3BlciBjYXV0aW9u
DQo+IHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRp
bmcuDQo+DQo+DQo+IFNpZ25lZC1vZmYtYnk6IEFsZXggQmVyZXphIDxhbGV4QGJlcmV6YS5lbWFp
bD4NCj4gLS0tDQoNCkZvciB0aGUgc2VyaWVzLCBSZXZpZXdlZC1ieTogU3VyYWogR3VwdGEgPHN1
cmFqLmd1cHRhMkBhbWQuY29tPg0KDQpUaGFua3MhDQpTdXJhag0KDQo+IENoYW5nZXMgaW4gdjM6
DQo+IC0gcGF0Y2ggMS8yOg0KPiAgIC0gRml4IGNvbW1pdCBtZXNzYWdlOiByZW1vdmUgYmxhbmsg
bGluZSBiZXR3ZWVuIHRhZ3MNCj4gLSBwYXRjaCAyLzI6IG5vdGhpbmcNCj4gLSBMaW5rIHRvIHYy
OiBodHRwczovL3BhdGNoLm1zZ2lkLmxpbmsvMjAyNjA0MDEtZml4LWF0b21pYy1wb2xsLXRpbWVv
dXQtDQo+IHJlZ3Jlc3Npb24tdjItMC02OGEyNjVlMzc3MGZAYmVyZXphLmVtYWlsDQo+DQo+IENo
YW5nZXMgaW4gdjI6DQo+IC0gRml4ZWQgdGhlIEZpeGVzOiB0YWdzIGFzIHN1Z2dlc3RlZCBieSBH
ZWVydCBVeXR0ZXJob2V2ZW4NCj4gICA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+IC0gdGhhbmtz
IQ0KPiAtIFNwbGl0IHRoZSByZW5hbWluZyBvZiBYSUxJTlhfRE1BX0xPT1BfQ09VTlQgaW50byBz
ZXBhcmF0ZSBjb21taXQNCj4gLSBMaW5rIHRvIHYxOiBodHRwczovL3BhdGNoLm1zZ2lkLmxpbmsv
MjAyNjAzMzEtZml4LWF0b21pYy1wb2xsLXRpbWVvdXQtDQo+IHJlZ3Jlc3Npb24tdjEtMS01Yjdi
ZDk2ZWFjYTBAYmVyZXphLmVtYWlsDQo+DQo+IC0tLQ0KPiBBbGV4IEJlcmV6YSAoMik6DQo+ICAg
ICAgIGRtYWVuZ2luZTogeGlsaW54X2RtYTogRml4IENQVSBzdGFsbCBpbiB4aWxpbnhfZG1hX3Bv
bGxfdGltZW91dA0KPiAgICAgICBkbWFlbmdpbmU6IHhpbGlueF9kbWE6IFJlbmFtZSBYSUxJTlhf
RE1BX0xPT1BfQ09VTlQNCj4NCj4gIGRyaXZlcnMvZG1hL3hpbGlueC94aWxpbnhfZG1hLmMgfCAy
NiArKysrKysrKysrKysrKysrLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2Vy
dGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IGI3NTYwNzk4
NDY2YTA3ZDljM2ZiMDExNjk4ZTkyYzMzNWFiMjhiYWYNCj4gY2hhbmdlLWlkOiAyMDI2MDMzMC1m
aXgtYXRvbWljLXBvbGwtdGltZW91dC1yZWdyZXNzaW9uLTRmNGUzYmFmM2ZkNw0KPg0KPiBCZXN0
IHJlZ2FyZHMsDQo+IC0tDQo+IEFsZXggQmVyZXphIDxhbGV4QGJlcmV6YS5lbWFpbD4NCj4NCg0K

