Return-Path: <dmaengine+bounces-10856-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MI9UFIEdFGoGJwcAu9opvQ
	(envelope-from <dmaengine+bounces-10856-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 11:59:29 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC945C8E25
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 11:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9853301303E
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 09:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0482B3E5EE3;
	Mon, 25 May 2026 09:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="DpF4UiRX"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012064.outbound.protection.outlook.com [52.101.53.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2E33E8335
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 09:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779703112; cv=fail; b=RE/xLe5BPpmraz2dnaI35++v5/EbO25ly11IO8IwZqM0Xj0EgRj3vazcbay8gwnzXopCfW308pG0qPCz5fSK5qMLH3OSJEf+sGHcYLExiSqvGUg8YefOrC50Nx6wgC7h7Pqh2iIDoumBH4abIVr8V3q8xXAXiCbVLcsTbJIDrQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779703112; c=relaxed/simple;
	bh=8vFxPfLax9L5AtTGFpLYmFfG2f2/Hv7ca1wSA0YDn9w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uZfdR51LYVYuqF8DWl+aSRl0Psstbu+2cSuKVxAxED0xz8Q0zDwsWpn7l6gmsqqwFf/yzjVVL+eRWTiQmohwAJUVE75FDPVF0I+b3KOtKUEmtfNp423+vTNXTap/S3UEb8q6rNnW0CbG0rCQEnP49dkJwh0xLbV4FZUTxhb3XBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=DpF4UiRX; arc=fail smtp.client-ip=52.101.53.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Obqkhjrvp4p1rBhmhLg2dst1McMp9Cb152ahDeD8LIakglBN9HLSGH2jDsdmzP3S5Phj5hL8HUKx6Y6RJPEopxmGuHQLUM0/HvdUkbNrzVuEi9gR4SZcFKoDWmjlRWs9D7gHg8znPMDvBHIFlNeFGElmcWzgPx5aNeYnifG4E+VYJ+z/y4rhQdDTq08WpLu04M4hYfTM8NckGnOJlYAwhPdC3qzMYDfBJfTWVPZg01ck//v7GAvEUCB2mEEMdEF2N46OgXMmTfCDmVa173kW61BDI4ICRzULFWaMpj1MIWq49eH8/f/Q0/hmP9bTFJVUzofsTNG2GxlK+PVcdP05bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vFxPfLax9L5AtTGFpLYmFfG2f2/Hv7ca1wSA0YDn9w=;
 b=FSP6PtfALGB99iFIeBYPHSqvm6uaFbRfGz9ztzKkRjiC/ZfVjvBYeZzbfRBx2XHNmkpm7uo9TJO2Dv4E1lj3EZXQeaWLZ5lHpoPHpabTCd+vFe7MXWnIJfpyWtun0Hf9QllOKiwuYfdxF9gJst9rXoCIr/Xc+38cvWtYVfCjCrjM0BU9jPvsEs7RpZO+RSuHU0ygrY7T7LV+1e+/QEDf1ozhmZ0icewr/pLN3OvkM294iiF/2jHInocyDE6q5SgqbjTSPkoKpesM6l0PPTuP8m9Ztkavq5ny3J3K08f0yJHdbtw02p5+7eBLf3HogHLeiw83JJm7HHSsAAO0Svel8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vFxPfLax9L5AtTGFpLYmFfG2f2/Hv7ca1wSA0YDn9w=;
 b=DpF4UiRXt+/bcpXDyZeDS0kJRiVY/54ZnNpnXbXqPgBEMdfHc7aH2dxLWJKm1OHBOHhxFfZQsJ/Wf9mfI5IqhCXV/S/Zwaeq4vjeWewNQ5fbKHCe0LeJr1+nA4dZPq+XQl2cg1g1BA0Bp09k1xabB6mvkqCczog9Fv2pIOaIW7W2SFTygKanmnSmUAtVJ1J3w4TPiIIxLUJ9/NOiaQJQfPOsAa1dbHROXa9U6++eBC3xPlomLqaHFaQQ2wubQEQws9XggEqlsoZSjTMqapCWGW+sKRh4n38yOcb1rZXUzo1NTkN6Z5wXXv70mVWQLgNXYnC09zSm9fqMo5UksY3Q8w==
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by SA1PR03MB6516.namprd03.prod.outlook.com (2603:10b6:806:1c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 09:58:27 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%4]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 09:58:27 +0000
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "Frank.Li@kernel.org" <Frank.Li@kernel.org>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>
Subject: Re: [PATCH v2] dma: altera-msgdma: Use memcpy_toio for descriptor
 FIFO writes
Thread-Topic: [PATCH v2] dma: altera-msgdma: Use memcpy_toio for descriptor
 FIFO writes
Thread-Index: AQHc7CG60nndVcDxp0WjWCcKmwC0WrYeb48AgAASO4A=
Date: Mon, 25 May 2026 09:58:27 +0000
Message-ID: <621a83f5-140e-4947-ba9a-5eeef8b4148a@altera.com>
References:
 <f6f3b4a2e2eb0eb1a51976de3f5d1ef5bab9bd76.1779697226.git.tze.yee.ng@altera.com>
 <20260525085311.1C2341F000E9@smtp.kernel.org>
In-Reply-To: <20260525085311.1C2341F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB5950:EE_|SA1PR03MB6516:EE_
x-ms-office365-filtering-correlation-id: 7bbf17ed-2325-46a3-d05a-08deba442b1d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003|38070700021|55112099003|11063799006|3023799007|4143699003|6133799003;
x-microsoft-antispam-message-info:
 kDW+ai8Z82cHvBp7Rb0Qz6+TMPwhTm8C9/VEMuyAeLoYQUlAE9SZPNISiLdmJC79q4+gElVftEILAziAADaFy8RgrytgBklrXjEoJHM683GTUev8GSQ35/DPuvYf4WZ7OaX+wyC6AVh8ppT7ohpQ0UfiyXeir3ZltzfWsYxnlv5xx9RKHbNAqCmLtPOYPtUbcsY+QSJs0nuFJTuIpCLvBfzZJpxDlWMVvooTtASE5tBJq/x3XCGAz1oK2uKIhHN+Vu1Yyn6iYU08Xc29sbrA8zaDcRYXBB6uWhOifF2L5J1jeBr5h6XYbPDy6Hh/UlgIaW5AvvA46fWWj1dIoKpr/7g3NGn8xpIGluG6NDAnzwKQL4sL3149yf3YmcmtYtoN3UL6/PCj4GOV5ciwwPgBYvPBlzFh+fOgyYpt1CyTHW4o8kfmtgI7WG02PHacm13a6sOsRXneGarXekPDs+uY/asT68pG3yng/PJFcNnktV2Aal9bcrVxtlCNHLDoLz6x8iGISuJQPrgTjlX79PbeOcAkIyBs7UtUHsuGWQntvp+GgwXF5YPnGYQ/diF/p6VVCXQ7jQm4ibzizyjVQJfSKrSpvOQ42D9JDGyZI5NhS+OxMtItMMvosxZpFeSTbjdcxD36nxJre9VzLCNIwFLIIxVyIO8tABdP47O0zE3tGaGZ5mvlkSGRmgvefmGwfOzVC7L3PcBW/8Cjp4fbI6h1ALLdpygKDYWYlxSu2USIYrS64gYw+VDE4TDj5xZa9gt7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003)(38070700021)(55112099003)(11063799006)(3023799007)(4143699003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T2JOS0FSd1JORnRKeUs2UDNRSWFnQjd6U2lFazR4ME1MbTkvcnVrYW5SaHFr?=
 =?utf-8?B?eGRqeXRERVhWU0YvWWo0bjk1eEpWVVYzWEJTeXcwTVUwUk1kNTlzQTRpeHZD?=
 =?utf-8?B?SUIrRUlram9iMXk3L3ZjcUIzNHByeEhVbUw4WXV6UWI3dUVuVEJCdzZmR0VB?=
 =?utf-8?B?cDB3Qm5SSE1NV0tMcFYxUEEwdllweUVOcTYwNlhCaXFPemNSSnluWnhOOE52?=
 =?utf-8?B?c1RkeWpIRnlRSS9kSU9SYVJSZzE5WVZVaWxzSXBaeUpHQlFQa1RKbjVWdnBK?=
 =?utf-8?B?R1l5ZDVBTzg0RitDc3NIZVFweUgrMVB5dWNDVmNvRSt6WkwxREg5eUhwaWp0?=
 =?utf-8?B?SFJGYlk3UU9Oek80ZjBDUFZtdTA5REZaQjVJNzU5TTJQT296aDFoV20xYWJR?=
 =?utf-8?B?UjlVNlViMXViZFg2SUZtckhwYTYwa2VudDBvT3VzdUpaaW1ZUzJwVUhVWk9l?=
 =?utf-8?B?OUwvaTVDUmdWMnFHQnJCTkxZYnZUTVhQU0R5MUxUR0h1SitNbXVGei9BaWFF?=
 =?utf-8?B?OXhtTTh1LzRKckt4S1NHMDFZSXB0cFZieEdIcGRSRUpZeUNKazdLSEN5bDBQ?=
 =?utf-8?B?QTQ0eDZyby9BamRndnJOWXhHWHdhcVRXRjdPT2RHR2JpVHJ6Y0FKV2ZjSHZN?=
 =?utf-8?B?Z0NWU0RtVFU2SUpGZ0ZmeE9iQlBVU1pkVHhpVVExU1pnelFySUhBNTB6d3RM?=
 =?utf-8?B?eDdiL21SZEY5a25jSUc5RldHcndvREVwdXcwU25sZkYzMjVPc0ljbVVaQ3o5?=
 =?utf-8?B?ZnVrWUM0NGdaZGZKWDlzMVlSdmNiOWd3bWFyQWJPYkxjdzBuTXczN24xZElF?=
 =?utf-8?B?cjVOUFMxc3RKWE1xMHowYWM4azd1WDAvT3gvSmNCWWdicXpWNG1NbksxQmQy?=
 =?utf-8?B?MTNiQTBNSFE2UXBuYTZxdzcrZDdENkFwUjBLaDNNOXpPZVk0M3NqNDk2SHRh?=
 =?utf-8?B?bktjYUlLVEdocjl5dy9ZbW1XdDBHMis1VjlvNWlheFlkdEgvMlNOV3JqVjEz?=
 =?utf-8?B?Rk5lbkZOUEZBbitzdCtzM2Z1dnVWR0FBbTNoNmNMYjNIcVZPdnF3RGcwUVha?=
 =?utf-8?B?NDM2czNnT0ZzMG1sZ2swaTEyZTVCQmFlU3RxaStrV3NIdW04Z2JTRUxqMHVY?=
 =?utf-8?B?UFhHUTVFUWd3MzBVZ0dBall5TURNbjRzNHBBMmhmNkNlWkhKUmhyL3lPdU1J?=
 =?utf-8?B?VnlCOG9vZVNtNlNxQWQvdWltbjV4RDUvbmFzZUlRZm5OS2xueStwNjBWTVVj?=
 =?utf-8?B?VHlYbUVEekZyc0VxM2tNUm9VVXowSDFUWmpmcU9sOEVNZ0NVQlN3cytYdGpL?=
 =?utf-8?B?L2R1eTNMaU9vUkVwZkg0SFJTYzNwT0d4VUxWcElaZ1ZIOGJOR0NYc0I1Njly?=
 =?utf-8?B?bkswd2RQc0RhYTlOckdPRVRtQ3lmSk9McUNma08zNXBNazc3bXA2RE1zMUZH?=
 =?utf-8?B?VFk5OU84NmEzQ0V2T1lHbms0UHhuY3grd0pEcDJPay82U1FxNHlXamVIRXNj?=
 =?utf-8?B?UjgyK1prSGpNL2l1azRPUm9tTm1UZEF3LzI1ZHBsNkZHczY2d0swVFU5V3ow?=
 =?utf-8?B?TE9EbG1sczZVY1hSWVF0cXpLMVRIT1FURzJzNGs4djF3NnBaNjV6eGdYcjlB?=
 =?utf-8?B?ZVVqc2k5S29hM2xxc2J4TzdXQW9wNFA0aGtMdXlVbDNhZ2FVNGJCL0tQMlly?=
 =?utf-8?B?Kzh3UTIzRm10Vk90aUV6SmNOUThkNDh0RmNmR2Q0NkRSVEdRenRyd01nZlF3?=
 =?utf-8?B?dzJ6MzA0SGRnRndnYWRZVy9BR0VFMERVcjZMTjVpd3NHTTkyRm1CcmJ5N0N4?=
 =?utf-8?B?eERkQXI0MStGMzNHNThSSk1BWjB3Z1hsdVJ4bEZWKzhwSVpWamZuZ1ZqeGNs?=
 =?utf-8?B?TmRRQ2txYkxPOE1WMEhUR2ttTkh4TmJaa21YWmdLVkdNNCtPWFdlaG0waVJH?=
 =?utf-8?B?T05BdnBheW9YdE1DN3A5dHFESXYyMVVmeGNGMGY2c3Z1bjJuZmRsb1V5NlJ1?=
 =?utf-8?B?S1ZGOFJTWWRTdGhpQ3JGQ2R1eUVZRmIzQlhQdCtERkM5SWM0Q1ZoYSswaktV?=
 =?utf-8?B?dW4xQys5TzkvK2pkTHB4ZkJYbWxJVk9FbVJRUkNtVmdiOWU4UG03Vy85YVlt?=
 =?utf-8?B?ZzIrSS91MWsreWUvTE5Ta2lwOVFuR3JvWU4xMnkwMVFGb2JRSUw3TzY4MlFx?=
 =?utf-8?B?WWU2WHdVUG84aUN1V1YzRTVPeFQ2RUIrZVZPRXFmR3FDYnozUDNpejVlSC91?=
 =?utf-8?B?Qko5Q0J0ZXI4cm00ZndKc29RQkZGRlh0aGt6aHEzejR1bEpuSnBUWGZldUVP?=
 =?utf-8?B?c0FQZUprOTNwbGxUaWFHby9yS2lRUEtkNlFWcEZaRWcyL2tpZFI0NWczTUEy?=
 =?utf-8?Q?y8qk0xXD/uL7JOCk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBF280E2BECBB549AD4FE0C32BCA6D60@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bbf17ed-2325-46a3-d05a-08deba442b1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 09:58:27.6909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oGUUJLFwoOf17DsPTpv0fe7SxyXYzLrY/ubWslAutZVjXmedpqnZ556zxr2YUN6K2mVyUBfXobOkNin/97bUog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6516
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[altera.com:+];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10856-lists,dmaengine=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tze.yee.ng@altera.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: DEC945C8E25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gMjUvNS8yMDI2IDQ6NTMgcG0sIHNhc2hpa28tYm90QGtlcm5lbC5vcmcgd3JvdGU6DQo+IFRo
YW5rIHlvdSBmb3IgeW91ciBjb250cmlidXRpb24hIFNhc2hpa28gQUkgcmV2aWV3IGZvdW5kIDQg
cG90ZW50aWFsIGlzc3VlKHMpIHRvIGNvbnNpZGVyOg0KPiANCj4gTmV3IGlzc3VlczoNCj4gLSBb
TG93XSBUaGUgcGF0Y2ggaW5hZHZlcnRlbnRseSBkdXBsaWNhdGVzIHRoZSBgc3RhdGljX2Fzc2Vy
dGAgYmxvY2sgZm9yIHRoZSBjb250cm9sIGZpZWxkIG9mZnNldC4NCj4gDQo+IFByZS1leGlzdGlu
ZyBpc3N1ZXM6DQo+IC0gW0hpZ2hdIE1peGVkIHVzYWdlIG9mIGBtZW1jcHlfdG9pbygpYCBhbmQg
YGlvd3JpdGUzMigpYCB3aGVuIHdyaXRpbmcgdG8gdGhlIGRlc2NyaXB0b3IgTU1JTyBGSUZPIHJl
c3VsdHMgaW4gaW5jb25zaXN0ZW50IGVuZGlhbm5lc3MgYmVoYXZpb3Igb24gYmlnLWVuZGlhbiBh
cmNoaXRlY3R1cmVzLg0KPiAtIFtIaWdoXSBgbWVtY3B5X3RvaW8oKWAgZG9lcyBub3QgZ3VhcmFu
dGVlIHRoZSBzdHJpY3RseSBzZXF1ZW50aWFsIDMyLWJpdCBhY2Nlc3NlcyByZXF1aXJlZCBieSB0
aGUgaGFyZHdhcmUgZGVzY3JpcHRvciBGSUZPLg0KPiAtIFtIaWdoXSBUaGUgZHJpdmVyIHBvbGxz
IHRoZSBkZXNjcmlwdG9yIGJ1ZmZlciBzdGF0dXMgaW5kZWZpbml0ZWx5IHVzaW5nIGBtZGVsYXko
KWAsIHdoaWNoIGNhbiBoYW5nIHRoZSBzeXN0ZW0gaWYgdGhlIGhhcmR3YXJlIHN0YWxscy4NCj4g
LS0NCj4gDQo+IGNvbW1pdCAwNzc0ODhmZTVjYmEwYTdmMGM4NDEwZDY5ZTVjYjBmNjg4ZTY1NDg1
DQo+IEF1dGhvcjogQWRyaWFuIE5nIEhvIFlpbiA8YWRyaWFuaG95aW4ubmdAYWx0ZXJhLmNvbT4N
Cj4gDQo+IGRtYTogYWx0ZXJhLW1zZ2RtYTogVXNlIG1lbWNweV90b2lvIGZvciBkZXNjcmlwdG9y
IEZJRk8gd3JpdGVzDQo+IA0KPiBUaGlzIGNvbW1pdCByZXBsYWNlcyB0aGUgZm9yY2VkIF9faW9t
ZW0gbWVtY3B5KCkgd2l0aCBtZW1jcHlfdG9pbygpIGZvcg0KPiBjb3B5aW5nIGRlc2NyaXB0b3Ig
Ym9kaWVzIHRvIHRoZSBkbWEgZW5naW5lIGZpZm8uIEl0IGFsc28gaW50cm9kdWNlcyBhDQo+IHN0
YXRpY19hc3NlcnQgdG8gZW5zdXJlIHRoZSBjb250cm9sIHdvcmQgaXMgdGhlIGxhc3QgZmllbGQg
aW4gdGhlIHN0cnVjdCwNCj4gYXMgd3JpdGluZyB0aGUgY29udHJvbCB3b3JkIGZsdXNoZXMgdGhl
IGZpZm8uDQo+IA0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL2FsdGVyYS1tc2dkbWEuYyBi
L2RyaXZlcnMvZG1hL2FsdGVyYS1tc2dkbWEuYw0KPj4gaW5kZXggYjQ2OTk5YzgxZGYwMC4uZTIz
ZTViNDQxYTI0ZSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZG1hL2FsdGVyYS1tc2dkbWEuYw0K
Pj4gKysrIGIvZHJpdmVycy9kbWEvYWx0ZXJhLW1zZ2RtYS5jDQo+PiBAQCAtNDk2LDYgKzQ5Niwx
MSBAQCBzdGF0aWMgdm9pZCBtc2dkbWFfY29weV9vbmUoc3RydWN0IG1zZ2RtYV9kZXZpY2UgKm1k
ZXYsDQo+PiAgIHsNCj4+ICAgCXZvaWQgX19pb21lbSAqaHdfZGVzYyA9IG1kZXYtPmRlc2M7DQo+
PiAgIA0KPj4gKwkvKiBFbnN1cmUgY29udHJvbCBpcyB0aGUgbGFzdCBmaWVsZCDigJQgcmVxdWly
ZWQgZm9yIGNvcnJlY3QgRklGTyBmbHVzaCBvcmRlcmluZyAqLw0KPj4gKwlzdGF0aWNfYXNzZXJ0
KG9mZnNldG9mKHN0cnVjdCBtc2dkbWFfZXh0ZW5kZWRfZGVzYywgY29udHJvbCkgPT0NCj4+ICsJ
CSAgICAgIHNpemVvZihzdHJ1Y3QgbXNnZG1hX2V4dGVuZGVkX2Rlc2MpIC0gc2l6ZW9mKHUzMiks
DQo+PiArCQkgICAgICAiY29udHJvbCBtdXN0IGJlIHRoZSBsYXN0IGZpZWxkIGluIG1zZ2RtYV9l
eHRlbmRlZF9kZXNjIik7DQo+PiArDQo+PiAgIAkvKg0KPj4gICAJICogQ2hlY2sgaWYgdGhlIERF
U0MgRklGTyBpdCBub3QgZnVsbC4gSWYgaXRzIGZ1bGwsIHdlIG5lZWQgdG8gd2FpdA0KPj4gICAJ
ICogZm9yIGF0IGxlYXN0IG9uZSBlbnRyeSB0byBiZWNvbWUgZnJlZSBhZ2Fpbg0KPj4gICAJICov
DQo+PiAgIAl3aGlsZSAoaW9yZWFkMzIobWRldi0+Y3NyICsgTVNHRE1BX0NTUl9TVEFUVVMpICYN
Cj4+ICAgCSAgICAgICBNU0dETUFfQ1NSX1NUQVRfREVTQ19CVUZfRlVMTCkNCj4+ICAgCQltZGVs
YXkoMSk7DQo+IA0KPiBbU2V2ZXJpdHk6IEhpZ2hdDQo+IFRoaXMgaXMgYSBwcmUtZXhpc3Rpbmcg
aXNzdWUsIGJ1dCBkb2VzIHRoaXMgbG9vcCByaXNrIGEgaGFyZCBrZXJuZWwgbG9ja3VwPw0KPiAN
Cj4gU2luY2UgdGhpcyBmdW5jdGlvbiBleGVjdXRlcyB3aGlsZSBob2xkaW5nIGEgc3BpbmxvY2sg
ZHVyaW5nIHRoZSBpcnEgaGFuZGxlcjoNCj4gDQo+IG1zZ2RtYV9pcnFfaGFuZGxlcigpLT5tc2dk
bWFfc3RhcnRfdHJhbnNmZXIoKS0+bXNnZG1hX2NvcHlfb25lKCkNCj4gDQo+IHBvbGxpbmcgaW5k
ZWZpbml0ZWx5IHdpdGggbWRlbGF5KCkgd2l0aG91dCBhIHRpbWVvdXQgY291bGQgd2VkZ2UgdGhl
IGNwdQ0KPiBpZiB0aGUgaGFyZHdhcmUgZmFpbHMgdG8gZHJhaW4gdGhlIGRlc2NyaXB0b3IgZmlm
by4gU2hvdWxkIHRoaXMgdXNlIGENCj4gcHJvcGVyIHRpbWVvdXQgbG9vcCBsaWtlIHJlYWRsX3Bv
bGxfdGltZW91dF9hdG9taWMoKSBpbnN0ZWFkPw0KPiANCj4+ICAgDQo+PiArCS8qIEVuc3VyZSBj
b250cm9sIGlzIHRoZSBsYXN0IGZpZWxkIOKAlCByZXF1aXJlZCBmb3IgY29ycmVjdCBGSUZPIGZs
dXNoIG9yZGVyaW5nICovDQo+PiArCXN0YXRpY19hc3NlcnQob2Zmc2V0b2Yoc3RydWN0IG1zZ2Rt
YV9leHRlbmRlZF9kZXNjLCBjb250cm9sKSA9PQ0KPj4gKwkJCXNpemVvZihzdHJ1Y3QgbXNnZG1h
X2V4dGVuZGVkX2Rlc2MpIC0gc2l6ZW9mKHUzMiksDQo+PiArCQkJImNvbnRyb2wgbXVzdCBiZSB0
aGUgbGFzdCBmaWVsZCBpbiBtc2dkbWFfZXh0ZW5kZWRfZGVzYyIpOw0KPj4gKw0KPiANCj4gW1Nl
dmVyaXR5OiBMb3ddDQo+IElzIHRoaXMgcmVncmVzc2lvbiBhIGNvcHktcGFzdGUgZXJyb3I/IFRo
ZSBleGFjdCBzYW1lIHN0YXRpY19hc3NlcnQgYW5kDQo+IGNvbW1lbnQgd2VyZSBhbHNvIGFkZGVk
IGp1c3QgYmVmb3JlIHRoZSB3aGlsZSBsb29wIGluIHRoaXMgcGF0Y2guDQo+IA0KPj4gICAJLyoN
Cj4+IC0JICogVGhlIGRlc2NyaXB0b3IgbmVlZHMgdG8gZ2V0IGNvcGllZCBpbnRvIHRoZSBkZXNj
cmlwdG9yIEZJRk8NCj4+IC0JICogb2YgdGhlIERNQSBjb250cm9sbGVyLiBUaGUgZGVzY3JpcHRv
ciB3aWxsIGdldCBmbHVzaGVkIHRvIHRoZQ0KPj4gLQkgKiBGSUZPLCBvbmNlIHRoZSBsYXN0IHdv
cmQgKGNvbnRyb2wgd29yZCkgaXMgd3JpdHRlbi4gU2luY2Ugd2UNCj4+IC0JICogYXJlIG5vdCAx
MDAlIHN1cmUgdGhhdCBtZW1jcHkoKSB3cml0ZXMgYWxsIHdvcmQgaW4gdGhlICJjb3JyZWN0Ig0K
Pj4gLQkgKiBvcmRlciAoYWRkcmVzcyBmcm9tIGxvdyB0byBoaWdoKSBvbiBhbGwgYXJjaGl0ZWN0
dXJlcywgd2UgbWFrZQ0KPj4gLQkgKiBzdXJlIHRoaXMgY29udHJvbCB3b3JkIGlzIHdyaXR0ZW4g
bGFzdCBieSBzaW5nbGUgY29kaW5nIGl0IGFuZA0KPj4gLQkgKiBhZGRpbmcgc29tZSB3cml0ZS1i
YXJyaWVycyBoZXJlLg0KPj4gKwkgKiBDb3B5IHRoZSBkZXNjcmlwdG9yIGludG8gdGhlIGRlc2Ny
aXB0b3IgRklGTyBvZiB0aGUgRE1BIGNvbnRyb2xsZXIsDQo+PiArCSAqIGV4Y2x1ZGluZyB0aGUg
Y29udHJvbCB3b3JkLiBUaGUgRklGTyBpcyBmbHVzaGVkIGFuZCB0aGUgZGVzY3JpcHRvcg0KPj4g
KwkgKiBiZWNvbWVzIHZhbGlkIG9uY2UgdGhlIGNvbnRyb2wgd29yZCBpcyB3cml0dGVuIGxhc3Qu
DQo+PiAgIAkgKi8NCj4+IC0JbWVtY3B5KCh2b2lkIF9fZm9yY2UgKilod19kZXNjLCAmZGVzYy0+
aHdfZGVzYywNCj4+IC0JICAgICAgIHNpemVvZihkZXNjLT5od19kZXNjKSAtIHNpemVvZih1MzIp
KTsNCj4+ICsJbWVtY3B5X3RvaW8oaHdfZGVzYywgJmRlc2MtPmh3X2Rlc2MsDQo+PiArCQkgICAg
b2Zmc2V0b2Yoc3RydWN0IG1zZ2RtYV9leHRlbmRlZF9kZXNjLCBjb250cm9sKSk7DQo+IA0KPiBb
U2V2ZXJpdHk6IEhpZ2hdDQo+IFRoaXMgaXMgYSBwcmUtZXhpc3RpbmcgaXNzdWUsIGJ1dCBkb2Vz
IG1lbWNweV90b2lvKCkgcHJvdmlkZSB0aGUgc3RyaWN0bHkNCj4gc2VxdWVudGlhbCAzMi1iaXQg
YWNjZXNzZXMgcmVxdWlyZWQgYnkgdGhlIGhhcmR3YXJlIGZpZm8/DQo+IA0KPiBTaW5jZSBtZW1j
cHlfdG9pbygpIGlzIGFyY2hpdGVjdHVyZS1kZXBlbmRlbnQgYW5kIG1heSBpbnRlcm5hbGx5IHVz
ZSBieXRlDQo+IHdyaXRlcywgNjQtYml0IHdyaXRlcywgb3IgY29weSBpbiBhIG5vbi1zZXF1ZW50
aWFsIG9yZGVyLCB3b3VsZCBhbiBleHBsaWNpdA0KPiBsb29wIHVzaW5nIGEgY29uc2lzdGVudCAz
Mi1iaXQgYWNjZXNzb3IgbGlrZSB3cml0ZXNsKCkgZ3VhcmFudGVlIHRoZQ0KPiByZXF1aXJlZCBh
Y2Nlc3MgcGF0dGVybiBpbnN0ZWFkPw0KPiANCj4gW1NldmVyaXR5OiBIaWdoXQ0KPiBUaGlzIGlz
IGEgcHJlLWV4aXN0aW5nIGlzc3VlLCBidXQgZG9lcyBtaXhpbmcgbWVtY3B5X3RvaW8oKSBhbmQg
aW93cml0ZTMyKCkNCj4gY2F1c2UgZGF0YSBjb3JydXB0aW9uIG9uIGJpZy1lbmRpYW4gYXJjaGl0
ZWN0dXJlcz8NCj4gDQo+IFNpbmNlIG1lbWNweV90b2lvKCkgcHJlc2VydmVzIGhvc3QgYnl0ZSBv
cmRlciB3aGlsZSBpb3dyaXRlMzIoKSAoY2FsbGVkDQo+IHN1YnNlcXVlbnRseSB0byB3cml0ZSB0
aGUgY29udHJvbCB3b3JkKSBwZXJmb3JtcyBjcHUtdG8tbGUgYnl0ZS1zd2FwcGluZyBvbg0KPiBi
aWctZW5kaWFuIHN5c3RlbXMsIHRoZSBkZXNjcmlwdG9yIGJvZHkgd2lsbCBiZSB3cml0dGVuIGlu
IGJpZy1lbmRpYW4gbWVtb3J5DQo+IG9yZGVyIHdoaWxlIHRoZSBjb250cm9sIHdvcmQgd2lsbCBi
ZSBzd2FwcGVkIHRvIGxpdHRsZS1lbmRpYW4uDQo+IA0KPiBEb2VzIHRoaXMgcmVxdWlyZSBhIGNv
bnNpc3RlbnQgc3RyZWFtLW9yaWVudGVkIGFjY2Vzc29yIGZhbWlseSBmb3IgYm90aCB0aGUNCj4g
YnVsayBjb3B5IGFuZCB0aGUgcmVtYWluZGVyPw0KPiANCj4+ICAgDQo+PiAgIAkvKiBXcml0ZSBj
b250cm9sIHdvcmQgbGFzdCB0byBmbHVzaCB0aGlzIGRlc2NyaXB0b3IgaW50byB0aGUgRklGTyAq
Lw0KPj4gICAJbWRldi0+aWRsZSA9IGZhbHNlOw0KPiANClRoYW5rcyBmb3IgdGhlIHJldmlldy4N
Cg0KRHVwbGljYXRlIHN0YXRpY19hc3NlcnQ6IEFncmVlZCDigJQgY29weS1wYXN0ZSBlcnJvciBp
biB2MjsgdjMga2VlcHMgYSANCnNpbmdsZSBzdGF0aWNfYXNzZXJ0IGJlZm9yZSBtZW1jcHlfdG9p
bygpLg0KDQpUaGUgRklGTy1mdWxsIG1kZWxheSgpIGxvb3AsIGFjY2Vzcy13aWR0aCBzZW1hbnRp
Y3MsIGFuZCBiaWctZW5kaWFuIA0KYmVoYXZpb3IgYXJlIHByZS1leGlzdGluZyBhbmQgdW5jaGFu
Z2VkIGJ5IHRoaXMgcGF0Y2guIFRoaXMgc2VyaWVzIG9ubHkgDQpzd2l0Y2hlcyB0aGUgZGVzY3Jp
cHRvciBib2R5IGNvcHkgdG8gbWVtY3B5X3RvaW8oKSBwZXIgRnJhbmvigJlzIGZlZWRiYWNrLCAN
CmtlZXBzIHRoZSBjb250cm9sIHdvcmQgd3JpdHRlbiBsYXN0IHdpdGggYmFycmllcnMsIGFuZCBh
ZGRzIGEgDQpzdGF0aWNfYXNzZXJ0IHNvIG9mZnNldG9mKGNvbnRyb2wpIHJlbWFpbnMgdmFsaWQu
IEkgY2FuIGFkZHJlc3MgdGhlIEZJRk8gDQpwb2xsaW5nIGFuZCBzdHJpY3RlciBNTUlPIGFjY2Vz
cyBpbiBhIHNlcGFyYXRlIHBhdGNoIGlmIG1haW50YWluZXJzIHdhbnQgDQp0aGF0Lg0KDQpUaGFu
a3MsDQpUemUgWWVlDQo=

